Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA50C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF96208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="juTm4bMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfITUUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 16:20:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46994 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbfITUUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 16:20:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so5220190pfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jEdIuqou/FiebeNFZj3DkFRHq3sTw58SvYggZlIuaw=;
        b=juTm4bMacMm/1cN6Fh+4WSECDG9qHNe+MvrITHFK/JAs3cC41S9FUpGLPZ+5aN4CJu
         fyVF9uCiM36zIZmuLOJnI1uZITrpv+/GDoZZsPRJ5b3RnhXWPBO+xtB0uKKIfckGKkE2
         tXhpEwDyg1/gwJDmQayiHMRP7y8BXCkAaQOCT3LW8jfNgxgSTujhN3TqI2tYoZQ61VKr
         BiPyQgF2tCQI77E7peINv4XJfmMrfPCFX1EaIJPlcgAWsxmyTIByGQdvqPuGsJNV95Sw
         +3T8uqLIxI8B2c+kTTM+ZOfI1TE8v0x5w74wRYXN0v2XyebpjicR7z5uGbRR4tx88TAz
         NjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jEdIuqou/FiebeNFZj3DkFRHq3sTw58SvYggZlIuaw=;
        b=ZkjBwinnCAaFFcmTPPhSrR1uL6RmTCTSu959FNtVHslrCY4xZgDBH/ltL52HRH0sWl
         KPp/mXjjbpBW9lgNnLBTmHXnVZOLWPvQsjKDW0vdAUnCSpwRvX3zz5Y5uEIWVYpK3Hhv
         S/HqvRW7DCpMXdpzLm3LGc7wViwV5ro+Y4KsYdjjjqjaV6K31cuK2JApY/Gx4m+giq2b
         1XCogo8rbZML8F1xnQ2SAuKnYHse5v1q4M/JS7PADHIOCEruSOOQmA957RGkjyjJB9ah
         dxhSAEoZYULFxKSg/xlJ8v54IqYXFVm+MioizRq/MIPjVAEVEzsha/M5J7Bl7Crx+2pk
         iDmw==
X-Gm-Message-State: APjAAAVGRfE949DtF3qjBgW03QfFjEIwYfsK1r/7krHbRyr7Rb0zVjtC
        3ulPuEh6kJ03cxVjNx7cA0btMJsaqgDIkWNJAse3Hw==
X-Google-Smtp-Source: APXvYqyRc3UYLiS8vXXYMqoSjnlqBODnfNKd4EE2IuClfNzBg5BAuREBQ6pVyPKUw4f3ZvhKwNEl6R5M+W8GKL0lY6o=
X-Received: by 2002:a63:d1a:: with SMTP id c26mr13159937pgl.286.1569010841781;
 Fri, 20 Sep 2019 13:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002ed3ab059300aaf1@google.com>
In-Reply-To: <0000000000002ed3ab059300aaf1@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 20 Sep 2019 22:20:30 +0200
Message-ID: <CAAeHK+xFWz=6=sQoayHTuXn66dYX5xCYPh_LH=-0m3nMMW-2BQ@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in __pm_runtime_resume
To:     syzbot <syzbot+28ecdc146b8e7def92dd@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 8:59 PM syzbot
<syzbot+28ecdc146b8e7def92dd@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    e0bd8d79 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=1670fa55600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8847e5384a16f66a
> dashboard link: https://syzkaller.appspot.com/bug?extid=28ecdc146b8e7def92dd
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+28ecdc146b8e7def92dd@syzkaller.appspotmail.com
>
> BUG: unable to handle page fault for address: fffffbfff23530b1
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 21ffef067 P4D 21ffef067 PUD 21ffb2067 PMD 0
> Oops: 0000 [#1] SMP KASAN
> CPU: 1 PID: 17297 Comm: syz-executor.5 Not tainted 5.3.0+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:92 [inline]
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:109 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:135 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:166 [inline]
> RIP: 0010:check_memory_region_inline mm/kasan/generic.c:182 [inline]
> RIP: 0010:check_memory_region+0x117/0x190 mm/kasan/generic.c:192
> Code: 75 2f 49 89 e9 49 29 c1 e9 6c ff ff ff 5b b8 01 00 00 00 5d 41 5c c3
> 4d 85 c9 74 f1 49 01 d9 eb 09 48 83 c0 01 4c 39 c8 74 e3 <80> 38 00 74 f2
> eb 92 4d 39 c2 74 4b e8 f8 e7 ff ff 31 c0 5b 5d 41
> RSP: 0018:ffff8881c7427710 EFLAGS: 00010086
> RAX: fffffbfff23530b1 RBX: fffffbfff23530b1 RCX: ffffffff8125804b
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff91a98588
> RBP: fffffbfff23530b2 R08: 0000000000000001 R09: fffffbfff23530b2
> R10: fffffbfff23530b1 R11: ffffffff91a9858f R12: ba771047467ec365
> R13: 00000000467ec365 R14: 0000000000000003 R15: ffff8881cbca2078
> FS:  00007f1c25a58700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffbfff23530b1 CR3: 00000001d664d000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   test_bit include/asm-generic/bitops-instrumented.h:237 [inline]
>   __lock_acquire+0x133b/0x3eb0 kernel/locking/lockdep.c:3925
>   lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4487
>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>   _raw_spin_lock_irqsave+0x32/0x50 kernel/locking/spinlock.c:159
>   __pm_runtime_resume+0xf5/0x180 drivers/base/power/runtime.c:1077
>   pm_runtime_get_sync include/linux/pm_runtime.h:226 [inline]
>   usb_autopm_get_interface+0x1b/0x50 drivers/usb/core/driver.c:1709
>   usbhid_power+0x7c/0xe0 drivers/hid/usbhid/hid-core.c:1234
>   hid_hw_power include/linux/hid.h:1038 [inline]
>   hidraw_open+0x20d/0x740 drivers/hid/hidraw.c:282
>   chrdev_open+0x219/0x5c0 fs/char_dev.c:414
>   do_dentry_open+0x494/0x1120 fs/open.c:797
>   do_last fs/namei.c:3408 [inline]
>   path_openat+0x1430/0x3f50 fs/namei.c:3525
>   do_filp_open+0x1a1/0x280 fs/namei.c:3555
>   do_sys_open+0x3c0/0x580 fs/open.c:1089
>   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4138f1
> Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48
> 83 ec 08 e8 0a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48
> 89 c2 e8 53 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007f1c25a577a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00000000004138f1
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f1c25a57850
> RBP: 000000000075bf20 R08: 000000000000000f R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007f1c25a586d4
> R13: 00000000004c8df7 R14: 00000000004dff20 R15: 00000000ffffffff
> Modules linked in:
> CR2: fffffbfff23530b1
> ---[ end trace 839607b5f3b5bbdf ]---
> RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:92 [inline]
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:109 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:135 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:166 [inline]
> RIP: 0010:check_memory_region_inline mm/kasan/generic.c:182 [inline]
> RIP: 0010:check_memory_region+0x117/0x190 mm/kasan/generic.c:192
> Code: 75 2f 49 89 e9 49 29 c1 e9 6c ff ff ff 5b b8 01 00 00 00 5d 41 5c c3
> 4d 85 c9 74 f1 49 01 d9 eb 09 48 83 c0 01 4c 39 c8 74 e3 <80> 38 00 74 f2
> eb 92 4d 39 c2 74 4b e8 f8 e7 ff ff 31 c0 5b 5d 41
> RSP: 0018:ffff8881c7427710 EFLAGS: 00010086
> RAX: fffffbfff23530b1 RBX: fffffbfff23530b1 RCX: ffffffff8125804b
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff91a98588
> RBP: fffffbfff23530b2 R08: 0000000000000001 R09: fffffbfff23530b2
> R10: fffffbfff23530b1 R11: ffffffff91a9858f R12: ba771047467ec365
> R13: 00000000467ec365 R14: 0000000000000003 R15: ffff8881cbca2078
> FS:  00007f1c25a58700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffbfff23530b1 CR3: 00000001d664d000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

#syz dup: general protection fault in __pm_runtime_resume
