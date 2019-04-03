Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4376C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986842084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDCRtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:49:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34218 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCRtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:49:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hBk0N-0004qz-VD; Wed, 03 Apr 2019 17:48:56 +0000
Date:   Wed, 3 Apr 2019 18:48:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH v2 14/14] dcache: Implement object migration
Message-ID: <20190403174855.GT2217@ZenIV.linux.org.uk>
References: <20190403042127.18755-1-tobin@kernel.org>
 <20190403042127.18755-15-tobin@kernel.org>
 <20190403170811.GR2217@ZenIV.linux.org.uk>
 <20190403171920.GS2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403171920.GS2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 06:19:21PM +0100, Al Viro wrote:
> On Wed, Apr 03, 2019 at 06:08:11PM +0100, Al Viro wrote:
> 
> > Oh, *brilliant*
> > 
> > Let's do d_invalidate() on random dentries and hope they go away.
> > With convoluted and brittle logics for deciding which ones to
> > spare, which is actually wrong.  This will pick mountpoints
> > and tear them out, to start with.
> > 
> > NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > And this is a NAK for the entire approach; if it has a positive refcount,
> > LEAVE IT ALONE.  Period.  Don't play this kind of games, they are wrong.
> > d_invalidate() is not something that can be done to an arbitrary dentry.
> 
> PS: "try to evict what can be evicted out of this set" can be done, but
> you want something like
> 	start with empty list
> 	go through your array of references
> 		grab dentry->d_lock
> 		if dentry->d_lockref.count is not zero
> 			unlock and continue
> 		if dentry->d_flags & DCACHE_SHRINK_LIST
> 			ditto, it's not for us to play with
>                 if (dentry->d_flags & DCACHE_LRU_LIST)
>                         d_lru_del(dentry);
> 		d_shrink_add(dentry, &list);
> 		unlock
> 
> on the collection phase and
> 	if the list is not empty by the end of that loop
> 		shrink_dentry_list(&list);
> on the disposal.

Note, BTW, that your constructor is wrong - all it really needs to do
is spin_lock_init() and setting ->d_lockref.count same as lockref_mark_dead()
does, to match the state of dentries being torn down.

__d_alloc() is not holding ->d_lock, since the object is not visible to
anybody else yet; with your changes it *is* visible.  However, if the
assignment to ->d_lockref.count in __d_alloc() is guaranteed to be
non-zero to non-zero, the above should be safe.
