Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C2CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D03121881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxGcdkyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfIQMLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:11:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44167 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIQMLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:11:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so2036676pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8TjCL1+7c4nptumYKjTLyXcnc06lqVokGDWWx4FuTc=;
        b=kxGcdkyfa9pJ6i00CWCbKfQ+iUoRTz9yl2uzAzw2yhMV+s8lRavPbgX7Ssx0+f3sXl
         tm0F1BXW5y/SV3l0LDC5X7w2ZNhlluNHsozFq/BZ2TKeFlRosFZoxOFQlUB1qvrvvGid
         B9+JQ7ZnIXq96VvWWJ6wW4yhq67XKVC6qMKMUM+Ca2QEGGrJfaSVk8DB31WJ80XS0Nqu
         5c8zm6A8a4vx+ujZ3pqjBzEHFvqqS5j4C6yaS/wOwwzPkxZTTqS7N2Ps0UGfeThE1Q1k
         BDseFhm6LwHBId7sdgQbyyX6eI3g4vGdQ2NXS+sFBCK+IW6dhhLdbZirP4k6mcyCkTZP
         TdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8TjCL1+7c4nptumYKjTLyXcnc06lqVokGDWWx4FuTc=;
        b=tZzOTCI5tVe4b/G5VB39H9voTpnqp1bu8KgVlxRh1NaLOfPJh5a2PpelirpOHmbvVB
         VQbTJPmEN37XnjNtGCkFpVD+S3toZFkMXRUrSpPYQtUc6V3j7ncGXWvTMgi2GtstuC/u
         dTv09HkHn45NBa1hXMsNlBOA1JHi1TmDCkf4HU2swijFOFhg/Y2AlXCGy4Fgif/rQ4Wf
         ITmSs6IOBw0iS8YrYShOzZNv5iFBqgNYYA6ub+iPWhJx0D6B8ySzbzedJV+XytClzoTF
         JlCka9kU4gan8hYG8jNjkxiJ/W3jjDeZNA7eYqPaTU6/mmd0pYvDCKTgQegHLUQ4cU5E
         pdVg==
X-Gm-Message-State: APjAAAXV3x6cPUJMzNK8wOMi7hNOoJ34FBsyccR+DB0/Ocqg/GLtjIfA
        A7HS1zdpG9cwOZ3gJktT3wFlAO704eCISCdsqGru5A==
X-Google-Smtp-Source: APXvYqxBtAxhijTOtmMwDsA8B+ivm542BhmhQIhD1aAFYaQEW5BEm7Hki9NcxBslwR+glp3lXh06vc7o3lJbavBAtwQ=
X-Received: by 2002:a62:1cd2:: with SMTP id c201mr3906410pfc.51.1568722296210;
 Tue, 17 Sep 2019 05:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b1f1050592ab96ee@google.com> <Pine.LNX.4.44L0.1909161236580.1489-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909161236580.1489-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 17 Sep 2019 14:11:25 +0200
Message-ID: <CAAeHK+zOtyFvbQRuaAf7EAsqm=cQP2NY8uSEczL_BEbw-xZvwg@mail.gmail.com>
Subject: Re: possible deadlock in open_rio (2)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+19cf612d23f66bc19f22@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Cesar Miquel <miquel@df.uba.ar>,
        rio500-users@lists.sourceforge.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 6:40 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 16 Sep 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11512cd1600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=19cf612d23f66bc19f22
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f92c6e600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b9b85e600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+19cf612d23f66bc19f22@syzkaller.appspotmail.com
> >
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.3.0-rc7+ #0 Not tainted
> > ------------------------------------------------------
> > syz-executor071/1724 is trying to acquire lock:
> > 00000000f749c934 (rio500_mutex){+.+.}, at: open_rio+0x16/0xe0
> > drivers/usb/misc/rio500.c:65
> >
> > but task is already holding lock:
> > 000000009c24ba51 (minor_rwsem){++++}, at: usb_open+0x23/0x270
> > drivers/usb/core/file.c:39
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #1 (minor_rwsem){++++}:
> >         down_write+0x92/0x150 kernel/locking/rwsem.c:1500
> >         usb_register_dev drivers/usb/core/file.c:187 [inline]
> >         usb_register_dev+0x131/0x670 drivers/usb/core/file.c:156
> >         probe_rio.cold+0x53/0x237 drivers/usb/misc/rio500.c:474
> >         usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
> >         really_probe+0x281/0x6d0 drivers/base/dd.c:548
> >         driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
> >         __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
> >         bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
> >         __device_attach+0x217/0x360 drivers/base/dd.c:894
> >         bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >         device_add+0xae6/0x16f0 drivers/base/core.c:2165
> >         usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
> >         generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
> >         usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
> >         really_probe+0x281/0x6d0 drivers/base/dd.c:548
> >         driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
> >         __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
> >         bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
> >         __device_attach+0x217/0x360 drivers/base/dd.c:894
> >         bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >         device_add+0xae6/0x16f0 drivers/base/core.c:2165
> >         usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
> >         hub_port_connect drivers/usb/core/hub.c:5098 [inline]
> >         hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >         port_event drivers/usb/core/hub.c:5359 [inline]
> >         hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
> >         process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
> >         worker_thread+0x96/0xe20 kernel/workqueue.c:2415
> >         kthread+0x318/0x420 kernel/kthread.c:255
> >         ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >
> > -> #0 (rio500_mutex){+.+.}:
> >         check_prev_add kernel/locking/lockdep.c:2405 [inline]
> >         check_prevs_add kernel/locking/lockdep.c:2507 [inline]
> >         validate_chain kernel/locking/lockdep.c:2897 [inline]
> >         __lock_acquire+0x1f7c/0x3b50 kernel/locking/lockdep.c:3880
> >         lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
> >         __mutex_lock_common kernel/locking/mutex.c:930 [inline]
> >         __mutex_lock+0x158/0x1360 kernel/locking/mutex.c:1077
> >         open_rio+0x16/0xe0 drivers/usb/misc/rio500.c:65
> >         usb_open+0x1df/0x270 drivers/usb/core/file.c:48
> >         chrdev_open+0x219/0x5c0 fs/char_dev.c:414
> >         do_dentry_open+0x494/0x1120 fs/open.c:797
> >         do_last fs/namei.c:3416 [inline]
> >         path_openat+0x1430/0x3f50 fs/namei.c:3533
> >         do_filp_open+0x1a1/0x280 fs/namei.c:3563
> >         do_sys_open+0x3c0/0x580 fs/open.c:1089
> >         do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
> >         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > other info that might help us debug this:
> >
> >   Possible unsafe locking scenario:
> >
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(minor_rwsem);
> >                                 lock(rio500_mutex);
> >                                 lock(minor_rwsem);
> >    lock(rio500_mutex);
> >
> >   *** DEADLOCK ***
> >
> > 1 lock held by syz-executor071/1724:
> >   #0: 000000009c24ba51 (minor_rwsem){++++}, at: usb_open+0x23/0x270
> > drivers/usb/core/file.c:39
> >
> > stack backtrace:
> > CPU: 0 PID: 1724 Comm: syz-executor071 Not tainted 5.3.0-rc7+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >   check_noncircular+0x345/0x3e0 kernel/locking/lockdep.c:1741
> >   check_prev_add kernel/locking/lockdep.c:2405 [inline]
> >   check_prevs_add kernel/locking/lockdep.c:2507 [inline]
> >   validate_chain kernel/locking/lockdep.c:2897 [inline]
> >   __lock_acquire+0x1f7c/0x3b50 kernel/locking/lockdep.c:3880
> >   lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
> >   __mutex_lock_common kernel/locking/mutex.c:930 [inline]
> >   __mutex_lock+0x158/0x1360 kernel/locking/mutex.c:1077
> >   open_rio+0x16/0xe0 drivers/usb/misc/rio500.c:65
> >   usb_open+0x1df/0x270 drivers/usb/core/file.c:48
> >   chrdev_open+0x219/0x5c0 fs/char_dev.c:414
> >   do_dentry_open+0x494/0x1120 fs/open.c:797
> >   do_last fs/namei.c:3416 [inline]
> >   path_openat+0x1430/0x3f50 fs/namei.c:3533
> >   do_filp_open+0x1a1/0x280 fs/namei.c:3563
> >   do_sys_open+0x3c0/0x580 fs/open.c:1089
> >   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x401130
> > Code: 01 f0 ff ff 0f 83 00 0b 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> > 44 00 00 83 3d 5d 0c 2d 00 00 75 14 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff
> > ff 0f 83 d4 0a 00 00 c3 48 83 ec 08 e8 3a 00 00 00
> > RSP: 002b:00007ffca0216788 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> > RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000401130
> > RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007ffca02167a0
> > RBP: 00000000006cb018 R08: 0000000000000000 R09: 000000000000000f
> > R10: 0000000000000064 R11: 0000000000000246 R12: 0000000000402090
> > R13: 0000000000402120 R14: 0000000000000000 R15: 00
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
>
> This is undoubted the same as the previous bug report.  It should be
> fixed by commit 9472aff16ca0 in Greg KH's usb-next branch, but the
> fix is not yet in Linus's tree.
>
> #syz dup: possible deadlock in open_rio

Yeah, this one is confusing. If we look at the dashboard [1] we see
that the fixing commit for the original bug is "Revert "USB: rio500:
simplify locking"", which is in the usb-testing tree (btw, I've
switched syzbot from usb-next to usb-testing, as it looked more
relevant). So syzbot saw the Reported-by tag on that commit, and
decided that the fix is applied, so if another bug with the same
manifestation happens, it must be a different bug and should be
reported. Syzbot has no way to know that commit 9472aff16ca0 (with the
same Reported-by tag as "Revert "USB: rio500: simplify locking") is
the proper fix for this issue.

Since you've marked this bug as a dup of a fixed bug with the fix
applied to syzbot's tree, syzbot reported another one named "possible
deadlock in open_rio (3)". I'm going to manually mark that one as
fixed by commit 9472aff16ca0.

https://syzkaller.appspot.com/bug?id=5b6785f7f0febf30e2133fa6e6dab81683ffa1b5
