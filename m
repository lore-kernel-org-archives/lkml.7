Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5368FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2912E20645
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfC0RW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:22:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:57760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727234AbfC0RW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:22:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA5BBAD2F;
        Wed, 27 Mar 2019 17:22:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 39F671E1589; Wed, 27 Mar 2019 18:22:54 +0100 (CET)
Date:   Wed, 27 Mar 2019 18:22:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jan Kara <jack@suse.cz>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Joel Becker <jlbec@evilplan.org>, Mark Fasheh <mark@fasheh.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
Message-ID: <20190327172254.GC6742@quack2.suse.cz>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <20190325194332.GO2217@ZenIV.linux.org.uk>
 <20190325224823.GF26298@dastard>
 <20190325230211.GR2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325230211.GR2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25-03-19 23:02:11, Al Viro wrote:
> On Tue, Mar 26, 2019 at 09:48:23AM +1100, Dave Chinner wrote:
> 
> > And when it comes to VFS inode reclaim, XFS does not implement
> > ->evict_inode because there is nothing at the VFS level to do.
> > And ->destroy_inode ends up doing cleanup work (e.g. freeing on-disk
> > inodes) which is non-trivial, blocking work, but then still requires
> > the struct xfs_inode to be written back to disk before it can bei
> > freed. So it just gets marked "reclaimable" and background reclaim
> > then takes care of it from there so we avoid synchronous IO in inode
> > reclaim...
> > 
> > This works because don't track dirty inode metadata in the VFS
> > writeback code (it's tracked with much more precision in the XFS log
> > infrastructure) and we don't write back inodes from the VFS
> > infrastructure, either. It's all done based on internal state
> > outside the VFS.
> > 
> > And, because of this, the VFS cannot assume that it can free
> > the struct inode after calling ->destroy_inode or even use
> > call_rcu() to run a filesystem destructor because the filesystem
> > may need to do work that needs to block and that's not allowed in an
> > RCU callback...
> 
> In Linus' patch that's what you get with non-NULL ->destroy_inode
> + NULL ->destroy_inode_rcu, so XFS won't be screwed by that.
> Said that, yes, XFS adds another fun twist there (AFAICS, it's
> the only in-tree filesystem that pulls that off).
> 
> I would really like some comments from f2fs and ocfs2 folks, as well
> as Jan - he's had much more recent contact with writeback code than
> I have...  Could somebody explain what's going on in f2fs and ocfs2
> ->drop_inode()?  It _should_ be just a predicate; looks like both
> are playing very odd games to work around writeback problems and
> I wonder if there's a cleaner solution for that.  I can try and dig
> through maillist(s) archives, but I would really appreciate it
> if somebody could give a braindump on the issues dealt with in there...

OCFS2 is discussed elsewhere and should be relatively easy to deal with.
F2FS seems harder. The problem is that AFAICS they get inode references
from their garbage collection code which can get called during page
writeback. And then they need to drop these references and they can be the
last ones to hold the inode reference for an unlinked inode forcing flush
worker into inode cleanup. Which generally causes problems and was the
reason why writeback code does not take inode references but relies on
I_SYNC to protect it from inode reclaim instead (see commit 169ebd90131b
"writeback: Avoid iput() from flusher thread"). And they noticed the
problem as well and hacked around it... Now I don't know enough about F2FS
and its garbage collection to tell how they can avoid dropping inode
references from flush worker context. But that's the right solution for
avoiding deadlocks.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
