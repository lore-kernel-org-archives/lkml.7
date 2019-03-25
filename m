Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1798FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D616A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfCYWsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:48:30 -0400
Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:37310 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729204AbfCYWs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:48:29 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail01.adl6.internode.on.net with ESMTP; 26 Mar 2019 09:18:24 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1h8YOF-0003iO-JF; Tue, 26 Mar 2019 09:48:23 +1100
Date:   Tue, 26 Mar 2019 09:48:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
Message-ID: <20190325224823.GF26298@dastard>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <20190325194332.GO2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325194332.GO2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 07:43:32PM +0000, Al Viro wrote:
> On Mon, Mar 25, 2019 at 11:36:01AM -0700, Linus Torvalds wrote:
> > Right. Not just move the existing destroy_inode() - because as you
> > say, people may not be able to to do that in RCU contect, but split it
> > up, and add a "final_free_inode()" callback or something for the RCU
> > phase.
> > 
> > In fact, I suspect that *every* user of destroy_inode() already has to
> > have its own RCU callback to another final freeing function anyway.
> 
> Nope - pipes do not, and for a good reason.
> 
> > Because they really shouldn't free the inode itself early. Maybe we
> > can just make that be a generic thing?
> 
> Maybe...  OTOH, we already have more methods on the destruction end
> than I'm comfortable trying to document.  Because we clearly *do*
> need a clear set of rules along the lines of "this kind of thing belongs
> in this method, this - in that one".
> 
> As it is, on the way to inode destruction we have
> 
> 1) [kinda] ->drop_inode() - decide whether this inode is not worth
> keeping around in icache once the refcount reaches zero.  Predicate,
> shouldn't change inode state at all.    Common instances:
> 	* default (encoded as NULL, available as generic_drop_inode()) -
> "keep it around if it's still hashed and link count is non-zero".
> 	* generic_delete_inode(): "don't retain that sucker"
> 
> However, 3 instances are more or less weird - f2fs, gfs and ocfs2.
> gfs2 one is the least odd of those, but the other two...
> What the hell is forced writeback doing in ocfs2_drop_inode()?
> If they don't want to retain anything, fine, but then why do
> the
>         inode->i_state |= I_WILL_FREE;
>         spin_unlock(&inode->i_lock);
>         write_inode_now(inode, 1);
>         spin_lock(&inode->i_lock);
>         WARN_ON(inode->i_state & I_NEW);
>         inode->i_state &= ~I_WILL_FREE;
> dance in ->drop_inode()?  It will be immediately followed by
> ->evict_inode(), and it feels like the damn thing would be
> a lot more natural there...  And what, for pity sake, f2fs is
> doing with truncation in that predicate, of all places?  The
> comment in there is
>         /*
>          * This is to avoid a deadlock condition like below.
>          * writeback_single_inode(inode)
>          *  - f2fs_write_data_page
>          *    - f2fs_gc -> iput -> evict
>          *       - inode_wait_for_writeback(inode)
>          */
> which looks... uninspiring, to put it mildly.
> 
> 2) ->evict_inode() - called when we kick the inode out.  Freeing
> on-disk inodes, etc. belongs there. inode is still in icache
> hash chain at that point, so any icache lookups for it will block
> until that thing is done.  If we have something non-trivial done
> by iget... test() callbacks, we must keep the data structures needed
> by those.
> 
> 3) ->destroy_inode() - destructor.  By that point all remaining
> references to inode are (stale) RCU ones.

At the VFS layer, perhaps, but the filesystem itself can still have
valid references to the struct inode the VFS knows nothing about.
i.e. filesystems typically wrap the struct inode in their own
extended inode structure and hence have more information in them
and a life cycle that the VFS knows nothing about. i.e. the VFS _does
not own_ the struct inode that the filesystem allocated for it's
use.

XFS has an inode cache layer below the VFS that provides an inode
life cycle that wraps around the outside of the VFS inode life
cycle. We do not use the VFS inode cache at all, and
fake the fact the inode is in the "icache hash chain" so that the
VFS behaves exactly as it should.

Further, we use lockless, RCU protected lookups on the XFS inode
cache, so we need to control XFS inode allocation and freeing
compeltely internally to XFS because it has RCU requirements the VFS
struct inode doesn't have.

And when it comes to VFS inode reclaim, XFS does not implement
->evict_inode because there is nothing at the VFS level to do.
And ->destroy_inode ends up doing cleanup work (e.g. freeing on-disk
inodes) which is non-trivial, blocking work, but then still requires
the struct xfs_inode to be written back to disk before it can bei
freed. So it just gets marked "reclaimable" and background reclaim
then takes care of it from there so we avoid synchronous IO in inode
reclaim...

This works because don't track dirty inode metadata in the VFS
writeback code (it's tracked with much more precision in the XFS log
infrastructure) and we don't write back inodes from the VFS
infrastructure, either. It's all done based on internal state
outside the VFS.

And, because of this, the VFS cannot assume that it can free
the struct inode after calling ->destroy_inode or even use
call_rcu() to run a filesystem destructor because the filesystem
may need to do work that needs to block and that's not allowed in an
RCU callback...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
