Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4771FC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B21F20700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDCSZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:25:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34884 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCSZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:25:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hBkZC-0005dH-Oh; Wed, 03 Apr 2019 18:24:54 +0000
Date:   Wed, 3 Apr 2019 19:24:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christopher Lameter <cl@linux.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
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
Message-ID: <20190403182454.GU2217@ZenIV.linux.org.uk>
References: <20190403042127.18755-1-tobin@kernel.org>
 <20190403042127.18755-15-tobin@kernel.org>
 <20190403170811.GR2217@ZenIV.linux.org.uk>
 <01000169e458534a-3c6a5d6f-3054-4c64-b5f9-7f46c811eeac-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000169e458534a-3c6a5d6f-3054-4c64-b5f9-7f46c811eeac-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 05:56:27PM +0000, Christopher Lameter wrote:
> On Wed, 3 Apr 2019, Al Viro wrote:
> 
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
> Well could you help us figure out how to do it the right way? We (the MM
> guys) are having a hard time not being familiar with the filesystem stuff.
> 
> This is an RFC and we want to know how to do this right.

If by "how to do it right" you mean "expedit kicking out something with
non-zero refcount" - there's no way to do that.  Nothing even remotely
sane.

If you mean "kick out everything in this page with zero refcount" - that
can be done (see further in the thread).

Look, dentries and inodes are really, really not relocatable.  If they
can be evicted by memory pressure - sure, we can do that for a given
set (e.g. "everything in that page").  But that's it - if memory
pressure would _not_ get rid of that one, there's nothing to be done.
Again, all VM can do is to simulate shrinker hitting hard on given
bunch (rather than buggering the entire cache).  If filesystem (or
something in VFS) says "it's busy", it bloody well _is_ busy and
won't be going away until it ceases to be such.
