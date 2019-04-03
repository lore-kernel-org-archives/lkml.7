Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B85C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE09B20700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDCTFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:05:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35422 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCTFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:05:41 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hBlCK-0006a6-NT; Wed, 03 Apr 2019 19:05:20 +0000
Date:   Wed, 3 Apr 2019 20:05:20 +0100
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
Message-ID: <20190403190520.GW2217@ZenIV.linux.org.uk>
References: <20190403042127.18755-1-tobin@kernel.org>
 <20190403042127.18755-15-tobin@kernel.org>
 <20190403170811.GR2217@ZenIV.linux.org.uk>
 <01000169e458534a-3c6a5d6f-3054-4c64-b5f9-7f46c811eeac-000000@email.amazonses.com>
 <20190403182454.GU2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403182454.GU2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 07:24:54PM +0100, Al Viro wrote:

> If by "how to do it right" you mean "expedit kicking out something with
> non-zero refcount" - there's no way to do that.  Nothing even remotely
> sane.
> 
> If you mean "kick out everything in this page with zero refcount" - that
> can be done (see further in the thread).
> 
> Look, dentries and inodes are really, really not relocatable.  If they
> can be evicted by memory pressure - sure, we can do that for a given
> set (e.g. "everything in that page").  But that's it - if memory
> pressure would _not_ get rid of that one, there's nothing to be done.
> Again, all VM can do is to simulate shrinker hitting hard on given
> bunch (rather than buggering the entire cache).  If filesystem (or
> something in VFS) says "it's busy", it bloody well _is_ busy and
> won't be going away until it ceases to be such.

FWIW, some theory: the only kind of long-term reference that can
be killed off by memory pressure is that from child to parent.
Anything else (e.g. an opened file, current directory, mountpoint,
etc.) is out of limits - it either won't be going away until
the thing is not pinned anymore (close, chdir, etc.) *or*
it really shouldn't be ("VM wants this mountpoint dentry freed,
so just dissolve the mount" is a bloody bad idea for obvious
reasons).

Stuff in somebody's shrink list is none of our business - somebody
else is going to try and evict it anyway; if it can be evicted,
it will be.

Anything with zero refcount that isn't in somebody else's
shrink list is fair game.

Directories with children could, in principle, be helped along -
we could try shrink_dcache_parent() on them, which might end
up leaving them with zero refcount.  However, it's not cheap
and if you pick the root dentry of a filesystem, it'll try to
evict everything on it that can be evicted, be it in this page
or not.  And there's no promise that it will end up evictable
after that.

So from the correctness POV
	* you can kick out everything with zero refcount not
on shrink lists.
	* you _might_ try shrink_dcache_parent() on directory
dentries, in hope to drive their refcount to zero.  However,
that's almost certainly going to hit too hard and be too costly.
	* d_invalidate() is no-go; if anything, you want something
weaker than shrink_dcache_parent(), not stronger.

For anything beyond "just kick out everything in that page that
happens to have zero refcount" I would really like to see the
stats - how much does it help, how costly it is _and_ how much
of the cache does it throw away (see above re running into a root
dentry of some filesystem and essentially trimming dcache for
that fs down to the unevictable stuff).
