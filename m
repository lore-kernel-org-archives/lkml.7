Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9B8C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ACD214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n62M2MeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfIQL4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 07:56:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38474 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfIQL4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 07:56:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id x10so1906201pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 04:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gnc4EkK4Jf6FbkTfjutH19VLmTVDS6VgWlsRc28YFG0=;
        b=n62M2MeRC/OdoqBW31kTYIEr4VMdYisifCsk8WYZSr0G0b/YzHk5oTfc+JsCSReWnp
         bEFnGkkzR0wv3Grfs47F5f7RFB9TlMFn4h3sedhDCmvaJ8oCznOo3HWwMwiKE7NbZqfr
         yIaIDCJGf9pHJyO7zw0kVucIKthzykpVqp2EtEcGev6mZRnt1RpriqejLibFr7bM9Qnm
         VJ/f8xaw7wPs1pmgLmc4Kpp7eNCxcZ1cPox8FQjuD/+BzRJ6yJLV8SP2unNX606BrrMm
         kyGUQWGcv19XOfQzd4JlQODTmv4JZ8T8J2vkrOjH83f/u7TDlcQYVt9pi6c1zkuHSyxW
         9prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gnc4EkK4Jf6FbkTfjutH19VLmTVDS6VgWlsRc28YFG0=;
        b=nS0aMPTfkJ/lHE5LAvotVzmRCEA1ll6Qb8kF4WXceoUBiybYE/XtilTi0kUixQDRcy
         tLBCvZD6celH1ZWZZJ1he3RsAK1nPOdYz5CfktrIp+nL4z71yvDHuCziXdwVyoXcRVIc
         EXEdpBe+ONXdZOOiZmRYtn6xVmrYglAE8komUDRd0OJCLUynRB/VQCf3//OMJD1K0l4z
         W0AVxSe2Y87TGOz61bK+hXZpPtno6z9rThTMskgFmxbMzSOuaYAckxUV3tNSL4pxX7xv
         7vFN5RNjzHjG5SHL/0SGeyGz2P8glC6welzngSm8HOCPjcs/jLO4KOsJtcTGa5qo45/h
         GwHw==
X-Gm-Message-State: APjAAAV1nPz39938ZbSAwnDRq24Y+aHOeKq2vfllNfn1zIUxz8DY5BSa
        lQV/PnkLY7SgYMn+nOw+LYy2LsmmIB3cVryfs+F6jQ==
X-Google-Smtp-Source: APXvYqznsFN71Bmjdu1+4qis030qwr0akLQYdUImpS9ezEA0HaaDVBJ7b9dxjyGqDTRRVvxOeiacBZrV97Yz8+O8nho=
X-Received: by 2002:a63:5c26:: with SMTP id q38mr2922170pgb.130.1568721374847;
 Tue, 17 Sep 2019 04:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000031432d0592b00f44@google.com> <Pine.LNX.4.44L0.1909161628090.1489-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909161628090.1489-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 17 Sep 2019 13:56:03 +0200
Message-ID: <CAAeHK+wGtNkf6vZ8SEtP2K=g8sjFs-YUXv2HWBLDb=fsJ91_sA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in usb_autopm_put_interface
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+e1d1a6e595adbd2458f1@syzkaller.appspotmail.com>,
        Alexander Potapenko <glider@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:31 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 16 Sep 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    014077b5 DO-NOT-SUBMIT: usb-fuzzer: main usb gadget fuzzer..
> > git tree:       https://github.com/google/kmsan.git master
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16a7dde1600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e1d1a6e595adbd2458f1
> > compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176303e1600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e8f23e600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+e1d1a6e595adbd2458f1@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KMSAN: uninit-value in __write_once_size include/linux/compiler.h:235
> > [inline]
> > BUG: KMSAN: uninit-value in pm_runtime_mark_last_busy
> > include/linux/pm_runtime.h:107 [inline]
> > BUG: KMSAN: uninit-value in usb_mark_last_busy include/linux/usb.h:774
> > [inline]
> > BUG: KMSAN: uninit-value in usb_autopm_put_interface+0xf2/0x120
> > drivers/usb/core/driver.c:1630
> > CPU: 0 PID: 11318 Comm: syz-executor549 Not tainted 5.3.0-rc7+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x191/0x1f0 lib/dump_stack.c:113
> >   kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
> >   __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
> >   __write_once_size include/linux/compiler.h:235 [inline]
> >   pm_runtime_mark_last_busy include/linux/pm_runtime.h:107 [inline]
> >   usb_mark_last_busy include/linux/usb.h:774 [inline]
> >   usb_autopm_put_interface+0xf2/0x120 drivers/usb/core/driver.c:1630
> >   usbhid_power+0x12a/0x170 drivers/hid/usbhid/hid-core.c:1238
> >   hid_hw_power include/linux/hid.h:1038 [inline]
> >   drop_ref drivers/hid/hidraw.c:338 [inline]
> >   hidraw_release+0x4a9/0x6b0 drivers/hid/hidraw.c:356
> >   __fput+0x4c9/0xba0 fs/file_table.c:280
> >   ____fput+0x37/0x40 fs/file_table.c:313
> >   task_work_run+0x22e/0x2a0 kernel/task_work.c:113
> >   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
> >   exit_to_usermode_loop arch/x86/entry/common.c:163 [inline]
> >   prepare_exit_to_usermode+0x39d/0x4d0 arch/x86/entry/common.c:194
> >   syscall_return_slowpath+0x90/0x610 arch/x86/entry/common.c:274
> >   do_syscall_64+0xe2/0xf0 arch/x86/entry/common.c:300
> >   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> > RIP: 0033:0x401b20
> > Code: 01 f0 ff ff 0f 83 c0 0b 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> > 44 00 00 83 3d ad 5b 2d 00 00 75 14 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff
> > ff 0f 83 94 0b 00 00 c3 48 83 ec 08 e8 fa 00 00 00
> > RSP: 002b:00007ffc46217cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> > RAX: ffffffffffffffea RBX: 0000000000000000 RCX: 0000000000401b20
> > RDX: 0000000000000000 RSI: 000000000010503d RDI: 00007ffc46217cc0
> > RBP: 6666666666666667 R08: 000000000000000f R09: 000000000000000b
> > R10: 0000000000000075 R11: 0000000000000246 R12: 0000000000402b40
> > R13: 0000000000402bd0 R14: 0000000000000000 R15: 0000000000000000
> >
> > Uninit was created at:
> >   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:189 [inline]
> >   kmsan_internal_poison_shadow+0x58/0xb0 mm/kmsan/kmsan.c:148
> >   kmsan_slab_free+0x8d/0x100 mm/kmsan/kmsan_hooks.c:195
> >   slab_free_freelist_hook mm/slub.c:1472 [inline]
> >   slab_free mm/slub.c:3038 [inline]
> >   kfree+0x4c1/0x2db0 mm/slub.c:3980
> >   usb_release_interface+0x105/0x120 drivers/usb/core/message.c:1633
> >   device_release+0xe2/0x380 drivers/base/core.c:1060
> >   kobject_cleanup lib/kobject.c:693 [inline]
> >   kobject_release lib/kobject.c:722 [inline]
> >   kref_put include/linux/kref.h:65 [inline]
> >   kobject_put+0x38d/0x480 lib/kobject.c:739
> >   put_device+0x51/0x70 drivers/base/core.c:2264
> >   usb_disable_device+0x69a/0x1150 drivers/usb/core/message.c:1248
> >   usb_disconnect+0x51e/0xd60 drivers/usb/core/hub.c:2199
> >   hub_port_connect drivers/usb/core/hub.c:4949 [inline]
> >   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >   port_event drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x3fd0/0x72f0 drivers/usb/core/hub.c:5441
> >   process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
> >   worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
> >   kthread+0x4b5/0x4f0 kernel/kthread.c:256
> >   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
> > ==================================================================
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
> This is probably the same problem that was fixed in the Logitech driver
> earlier.  The fix still appears to be in linux-next (commit
> 5f9242775bb6).

Yes, this looks like a different manifestation of the same issue, let's dup it:

#syz dup: general protection fault in __pm_runtime_resume

> Shouldn't syzbot wait until after the merge window before running tests
> like this?

Syzbot just keeps on fuzzing and reports any new issues that it finds.
The reason this one got reported separately is because syzbot has no
way to know whether this report is caused by the same issue as some
other one that got marked as fixed. I'll keep looking out for more and
keep duping them until the fix is in the USB tree.

Thanks!
