Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AD9C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CBE222D1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2ebHG/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfKSOur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:50:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35136 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfKSOur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:50:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so11897063plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 06:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGAfLj5TtKeWTqlleATwO2oiUx1b36nfdxgPZrZOTeQ=;
        b=o2ebHG/R+RUdTGAhdjdUgqodS272s1PhIWJL0I/VbWcR/algVywzT4T9Bz6Gy/iCbR
         MJXo2hHAb3Va+aE5/srvI585sJvi5/5wcDqhFj0KZjBW9oFynbOzdMyFg+HA7KYgEg+M
         Tr9EZk0FBtGMRqE5gZaGs4V29ZGYxm5uWm97WQaPpsBko4mq0MqgfAcbiH3o2eOyq2N4
         GlhSV+o5kV7e+C0p1XTUzLPWCHMNKoXnhXKBTexnagmCNfvJoLKsd8CrwEOCXscy7vNn
         W/C18cI0hbrwEjjODNolCd6La4i08SKWxfw0Rsgy27KNv1mSZvDHITG1JL8yTaVTezEz
         TxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGAfLj5TtKeWTqlleATwO2oiUx1b36nfdxgPZrZOTeQ=;
        b=LcrLPkjItu3PQCxLIFyUpaskVEQ6muX1s57KotU9rEDKSYyORV/20EZqQXnE3sZtt2
         8jXtQpnZTywSZJaML+PF8xVx0F0JdlG+GqvgTKuD1qBRYiM1aJDxzV/pLLjOW/axchfn
         aebXVp/ORtvPlGNKJoKx9jbmYFk2B8Yhxv4pNvyCRQ7/3NTxmhmwA4UQXZEyYTDNpo67
         Mtz+RcU8k9ln8xLs9eRYC5q8Lt7yze2mbAc/5E0JTlLG/SZuOt9xZ2gwt/j27dwAt45V
         RL1wxBhC/l9rWca4nYH6I9lPxm8CVhSWqFWFS6emcUDn0fV9YKSYSym1oJZwJHjJ4RkK
         Ehlg==
X-Gm-Message-State: APjAAAUhlAr1bXBqWjoyOsVnLmYhmMxXxWQ2Iuf+49xND4yG2QayK3wl
        Vg5dOR/Msof84utSg2niwuotmIOg4OF7F4DvL8mkgvKfDjs=
X-Google-Smtp-Source: APXvYqycOZYYWgAO4IGrO1FMpIxz6KbV/AWJdBzdMoLHCy9f5E7q50FhnM28PHLxTDN2nvBX8olDoovHnzW6cE96dM0=
X-Received: by 2002:a17:902:ac90:: with SMTP id h16mr36199489plr.147.1574175045692;
 Tue, 19 Nov 2019 06:50:45 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b5ec8b0594070456@google.com>
In-Reply-To: <000000000000b5ec8b0594070456@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Nov 2019 15:50:34 +0100
Message-ID: <CAAeHK+yo6tEqp06A284cr07BJGtL1UZWObxiZ3k9yLMKfUeSAw@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in iowarrior_disconnect
To:     syzbot <syzbot+0761012cebf7bdb38137@syzkaller.appspotmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 9:59 PM syzbot
<syzbot+0761012cebf7bdb38137@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    014077b5 DO-NOT-SUBMIT: usb-fuzzer: main usb gadget fuzzer..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=108eae5e600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
> dashboard link: https://syzkaller.appspot.com/bug?extid=0761012cebf7bdb38137
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15161d99600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13632e3a600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0761012cebf7bdb38137@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KMSAN: uninit-value in iowarrior_disconnect+0x27a/0x3e0
> drivers/usb/misc/iowarrior.c:884
> CPU: 0 PID: 11102 Comm: kworker/0:5 Not tainted 5.3.0-rc7+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x191/0x1f0 lib/dump_stack.c:113
>   kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
>   __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
>   iowarrior_disconnect+0x27a/0x3e0 drivers/usb/misc/iowarrior.c:884
>   usb_unbind_interface+0x3a2/0xdd0 drivers/usb/core/driver.c:423
>   __device_release_driver drivers/base/dd.c:1120 [inline]
>   device_release_driver_internal+0x911/0xd20 drivers/base/dd.c:1151
>   device_release_driver+0x4b/0x60 drivers/base/dd.c:1174
>   bus_remove_device+0x4bf/0x670 drivers/base/bus.c:556
>   device_del+0xcd5/0x1d10 drivers/base/core.c:2339
>   usb_disable_device+0x567/0x1150 drivers/usb/core/message.c:1241
>   usb_disconnect+0x51e/0xd60 drivers/usb/core/hub.c:2199
>   hub_port_connect drivers/usb/core/hub.c:4949 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x3fd0/0x72f0 drivers/usb/core/hub.c:5441
>   process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
>   worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
>   kthread+0x4b5/0x4f0 kernel/kthread.c:256
>   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
>
> Uninit was created at:
>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:189 [inline]
>   kmsan_internal_poison_shadow+0x58/0xb0 mm/kmsan/kmsan.c:148
>   kmsan_slab_free+0x8d/0x100 mm/kmsan/kmsan_hooks.c:195
>   slab_free_freelist_hook mm/slub.c:1472 [inline]
>   slab_free mm/slub.c:3038 [inline]
>   kfree+0x4c1/0x2db0 mm/slub.c:3980
>   iowarrior_delete drivers/usb/misc/iowarrior.c:246 [inline]
>   iowarrior_release+0x334/0x3a0 drivers/usb/misc/iowarrior.c:670
>   __fput+0x4c9/0xba0 fs/file_table.c:280
>   ____fput+0x37/0x40 fs/file_table.c:313
>   task_work_run+0x22e/0x2a0 kernel/task_work.c:113
>   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>   exit_to_usermode_loop arch/x86/entry/common.c:163 [inline]
>   prepare_exit_to_usermode+0x39d/0x4d0 arch/x86/entry/common.c:194
>   syscall_return_slowpath+0x90/0x610 arch/x86/entry/common.c:274
>   do_syscall_64+0xe2/0xf0 arch/x86/entry/common.c:300
>   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000b5ec8b0594070456%40google.com.

#syz dup: KASAN: use-after-free Read in iowarrior_disconnect
