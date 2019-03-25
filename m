Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC23C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1C020828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfCYXCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:02:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56772 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCYXCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:02:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h8Ybb-0000ti-QB; Mon, 25 Mar 2019 23:02:11 +0000
Date:   Mon, 25 Mar 2019 23:02:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jan Kara <jack@suse.cz>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Joel Becker <jlbec@evilplan.org>, Mark Fasheh <mark@fasheh.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
Message-ID: <20190325230211.GR2217@ZenIV.linux.org.uk>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <20190325194332.GO2217@ZenIV.linux.org.uk>
 <20190325224823.GF26298@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325224823.GF26298@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:48:23AM +1100, Dave Chinner wrote:

> And when it comes to VFS inode reclaim, XFS does not implement
> ->evict_inode because there is nothing at the VFS level to do.
> And ->destroy_inode ends up doing cleanup work (e.g. freeing on-disk
> inodes) which is non-trivial, blocking work, but then still requires
> the struct xfs_inode to be written back to disk before it can bei
> freed. So it just gets marked "reclaimable" and background reclaim
> then takes care of it from there so we avoid synchronous IO in inode
> reclaim...
> 
> This works because don't track dirty inode metadata in the VFS
> writeback code (it's tracked with much more precision in the XFS log
> infrastructure) and we don't write back inodes from the VFS
> infrastructure, either. It's all done based on internal state
> outside the VFS.
> 
> And, because of this, the VFS cannot assume that it can free
> the struct inode after calling ->destroy_inode or even use
> call_rcu() to run a filesystem destructor because the filesystem
> may need to do work that needs to block and that's not allowed in an
> RCU callback...

In Linus' patch that's what you get with non-NULL ->destroy_inode
+ NULL ->destroy_inode_rcu, so XFS won't be screwed by that.
Said that, yes, XFS adds another fun twist there (AFAICS, it's
the only in-tree filesystem that pulls that off).

I would really like some comments from f2fs and ocfs2 folks, as well
as Jan - he's had much more recent contact with writeback code than
I have...  Could somebody explain what's going on in f2fs and ocfs2
->drop_inode()?  It _should_ be just a predicate; looks like both
are playing very odd games to work around writeback problems and
I wonder if there's a cleaner solution for that.  I can try and dig
through maillist(s) archives, but I would really appreciate it
if somebody could give a braindump on the issues dealt with in there...
