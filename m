Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75418C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B12220684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cIxr0QgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfCHILL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:11:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCHILK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4iTz1XotpjVy44GeO18qPJRH/7xSw2g4NpbWO60EeS8=; b=cIxr0QgTtXvHmjYPQbHD9hr0S
        6OuGpjtaevFVhJrLBnfnBB4k4+0LJXyq7Y9p8d9EYtO5+8MPpkRJvQTs9nsASs/i/8k7lX7d/rK/i
        nckNewSI8i5jADsSN3aZUvfqiEPR3EivPtLGseEny0Rd2dqvQIhrp51kRNQ0vnMrkn4LMPeg0vWJm
        MHwvRkiiPjV3HMqg9FBASE+/HlT+7cn7DJafss6sl1Mw++rRXO87AOnTn6WY7e6oe90HNW+VYSZrL
        jOpdWppefe+EUtuYwDCPUT5elRrFl3wiqwVwXOtXf6lnNh+5LODO4Cbcp6YAmR/ShqnMRpLsEXESU
        aoyndnOGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2Aax-0007Hz-MD; Fri, 08 Mar 2019 08:11:07 +0000
Date:   Fri, 8 Mar 2019 00:11:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     syzbot <syzbot+78923eea7cf44364f4fb@syzkaller.appspotmail.com>
Cc:     darrick.wong@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low!
Message-ID: <20190308081107.GD22834@infradead.org>
References: <000000000000299b190583172880@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000299b190583172880@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probably more a lockdep than XFS thing..

On Fri, Mar 01, 2019 at 11:06:04PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    c63e9e91a254 Add linux-next specific files for 20190301
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16a559b2c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5875f9dc6e009b2
> dashboard link: https://syzkaller.appspot.com/bug?extid=78923eea7cf44364f4fb
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+78923eea7cf44364f4fb@syzkaller.appspotmail.com
> 
> BUG: MAX_STACK_TRACE_ENTRIES too low!
> turning off the locking correctness validator.
> CPU: 0 PID: 19385 Comm: syz-executor.0 Not tainted 5.0.0-rc8-next-20190301
> #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>  save_trace kernel/locking/lockdep.c:467 [inline]
>  save_trace.cold+0x14/0x19 kernel/locking/lockdep.c:437
>  mark_lock+0x2fb/0x1380 kernel/locking/lockdep.c:3401
>  __lock_acquire+0x548/0x3fb0 kernel/locking/lockdep.c:3648
>  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4202
>  flush_workqueue+0x126/0x14c0 kernel/workqueue.c:2774
>  drain_workqueue+0x1b4/0x470 kernel/workqueue.c:2939
>  destroy_workqueue+0x21/0x700 kernel/workqueue.c:4315
>  xfs_destroy_mount_workqueues+0x11d/0x1c0 fs/xfs/xfs_super.c:906
>  xfs_fs_fill_super+0x8e9/0x1670 fs/xfs/xfs_super.c:1786
>  mount_bdev+0x307/0x3c0 fs/super.c:1346
>  xfs_fs_mount+0x35/0x40 fs/xfs/xfs_super.c:1834
>  legacy_get_tree+0xf2/0x200 fs/fs_context.c:584
>  vfs_get_tree+0x123/0x450 fs/super.c:1481
>  do_new_mount fs/namespace.c:2622 [inline]
>  do_mount+0x1436/0x2c40 fs/namespace.c:2942
>  ksys_mount+0xdb/0x150 fs/namespace.c:3151
>  __do_sys_mount fs/namespace.c:3165 [inline]
>  __se_sys_mount fs/namespace.c:3162 [inline]
>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3162
>  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x45a89a
> Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 2d 8e fb ff c3 66 2e 0f
> 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 0a 8e fb ff c3 66 0f 1f 84 00 00 00 00 00
> RSP: 002b:00007f6d038b0a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f6d038b0b30 RCX: 000000000045a89a
> RDX: 00007f6d038b0ad0 RSI: 0000000020000140 RDI: 00007f6d038b0af0
> RBP: 0000000020000140 R08: 00007f6d038b0b30 R09: 00007f6d038b0ad0
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000003
> R13: 0000000000000000 R14: 00000000004dbde0 R15: 00000000ffffffff
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
---end quoted text---
