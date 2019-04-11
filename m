Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105B4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43F920850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfDKVC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:02:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60466 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKVC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:02:28 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hEgpc-0002tG-Ba; Thu, 11 Apr 2019 21:02:00 +0000
Date:   Thu, 11 Apr 2019 22:02:00 +0100
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
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH v3 14/15] dcache: Implement partial shrink via Slab
 Movable Objects
Message-ID: <20190411210200.GH2217@ZenIV.linux.org.uk>
References: <20190411013441.5415-1-tobin@kernel.org>
 <20190411013441.5415-15-tobin@kernel.org>
 <20190411023322.GD2217@ZenIV.linux.org.uk>
 <20190411024821.GB6941@eros.localdomain>
 <20190411044746.GE2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411044746.GE2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 05:47:46AM +0100, Al Viro wrote:

> Note, BTW, that umount coming between isolate and drop is not a problem;
> it call shrink_dcache_parent() on the root.  And if shrink_dcache_parent()
> finds something on (another) shrink list, it won't put it to the shrink
> list of its own, but it will make note of that and repeat the scan in
> such case.  So if we find something with zero refcount and not on
> shrink list, we can move it to our shrink list and be sure that its
> superblock won't go away under us...

Aaaarrgghhh...  No, we can't.  Look: we get one candidate dentry in isolate
phase.  We put it into shrink list.  umount(2) comes and calls
shrink_dcache_for_umount(), which calls shrink_dcache_parent(root).
In the meanwhile, shrink_dentry_list() is run and does __dentry_kill() on
that one dentry.  Fine, it's gone - before shrink_dcache_parent() even
sees it.  Now shrink_dentry_list() holds a reference to its parent and
is about to drop it in
                dentry = parent;
                while (dentry && !lockref_put_or_lock(&dentry->d_lockref))
                        dentry = dentry_kill(dentry);
And dropped it will be, but... shrink_dcache_parent() has finished the
scan, without finding *anything* with zero refcount - the thing that used
to be on the shrink list was already gone before shrink_dcache_parent()
has gotten there and the reference to parent was not dropped yet.  So
shrink_dcache_for_umount() plows past shrink_dcache_parent(), walks the
tree and complains loudly about "busy" dentries (that parent we hadn't
finished dropping), and then we proceed with filesystem shutdown.
In the meanwhile, dentry_kill() finally gets to killing dentry and
triggers an unexpected late call of ->d_iput() on a filesystem that
has already been far enough into shutdown - far enough to destroy the
data structures needed for that sucker.

The reason we don't hit that problem with regular memory shrinker is
this:
                unregister_shrinker(&s->s_shrink);
                fs->kill_sb(s);
in deactivate_locked_super().  IOW, shrinker for this fs is gone
before we get around to shutdown.  And so are all normal sources
of dentry eviction for that fs.

Your earlier variants all suffer the same problem - picking a page
shared by dentries from several superblocks can run into trouble
if it overlaps with umount of one of those.

Fuck...  One variant of solution would be to have per-superblock
struct kmem_cache to be used for dentries of that superblock.
However,
	* we'd need to prevent them getting merged
	* it would add per-superblock memory costs (for struct
kmem_cache and associated structures)
	* it might mean more pages eaten by the dentries -
on average half a page per superblock (more if there are very
few dentries on that superblock)

OTOH, it might actually improve the memory footprint - all
dentries sharing a page would be from the same superblock,
so the use patterns might be more similar, which might
lower the fragmentation...

Hell knows...  I'd like to hear an opinion from VM folks on
that one.  Comments?
