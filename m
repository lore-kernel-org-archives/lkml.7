Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB723C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B6A2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfDKEsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 00:48:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48850 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfDKEsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 00:48:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hERco-0005NN-UV; Thu, 11 Apr 2019 04:47:47 +0000
Date:   Thu, 11 Apr 2019 05:47:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 14/15] dcache: Implement partial shrink via Slab
 Movable Objects
Message-ID: <20190411044746.GE2217@ZenIV.linux.org.uk>
References: <20190411013441.5415-1-tobin@kernel.org>
 <20190411013441.5415-15-tobin@kernel.org>
 <20190411023322.GD2217@ZenIV.linux.org.uk>
 <20190411024821.GB6941@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411024821.GB6941@eros.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 12:48:21PM +1000, Tobin C. Harding wrote:

> Oh, so putting entries on a shrink list is enough to pin them?

Not exactly pin, but __dentry_kill() has this:
        if (dentry->d_flags & DCACHE_SHRINK_LIST) {
                dentry->d_flags |= DCACHE_MAY_FREE;
                can_free = false;
        }
        spin_unlock(&dentry->d_lock);
        if (likely(can_free))
                dentry_free(dentry);
and shrink_dentry_list() - this:
                        if (dentry->d_lockref.count < 0)
                                can_free = dentry->d_flags & DCACHE_MAY_FREE;
                        spin_unlock(&dentry->d_lock);
                        if (can_free)
                                dentry_free(dentry);
			continue;
so if dentry destruction comes before we get around to
shrink_dentry_list(), it'll stop short of dentry_free() and mark it for
shrink_dentry_list() to do just dentry_free(); if it overlaps with
shrink_dentry_list(), but doesn't progress all the way to freeing,
we will
	* have dentry removed from shrink list
	* notice the negative ->d_count (i.e. that it has already reached
__dentry_kill())
	* see that __dentry_kill() is not through with tearing the sucker
apart (no DCACHE_MAY_FREE set)
... and just leave it alone, letting __dentry_kill() do the rest of its
thing - it's already off the shrink list, so __dentry_kill() will do
everything, including dentry_free().

The reason for that dance is the locking - shrink list belongs to whoever
has set it up and nobody else is modifying it.  So __dentry_kill() doesn't
even try to remove the victim from there; it does all the teardown
(detaches from inode, unhashes, etc.) and leaves removal from the shrink
list and actual freeing to the owner of shrink list.  That way we don't
have to protect all shrink lists a single lock (contention on it would
be painful) and we don't have to play with per-shrink-list locks and
all the attendant headaches (those lists usually live on stack frame
of some function, so just having the lock next to the list_head would
do us no good, etc.).  Much easier to have the shrink_dentry_list()
do all the manipulations...

The bottom line is, once it's on a shrink list, it'll stay there
until shrink_dentry_list().  It may get extra references after
being inserted there (e.g. be found by hash lookup), it may drop
those, whatever - it won't get freed until we run shrink_dentry_list().
If it ends up with extra references, no problem - shrink_dentry_list()
will just kick it off the shrink list and leave it alone.

Note, BTW, that umount coming between isolate and drop is not a problem;
it call shrink_dcache_parent() on the root.  And if shrink_dcache_parent()
finds something on (another) shrink list, it won't put it to the shrink
list of its own, but it will make note of that and repeat the scan in
such case.  So if we find something with zero refcount and not on
shrink list, we can move it to our shrink list and be sure that its
superblock won't go away under us...
