Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A491DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A80B2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHF2By8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfHMNLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:11:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35183 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbfHMNLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:11:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id n4so9512962pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yY7htr7WE/EKJBQ2M1n895AFliUWiENe940QX+rVURU=;
        b=RHF2By8VIi/Ecjrf42jExWj8vOSHVpErUG8CgQQxnPOnxZLJstRthf1olhl/ljc8bx
         K4wgqUsGl4bMsGZ7EweZ386NDTpAUtzmCz2Bk1Z1E+S6lo5wkzkgraHuA2XYxZFltO/6
         CFbFtDDPh4HasiFEeHiISCPXpcB9KSNygI+z6LY4/AtClm6FD1M2uYTpB25QrJFNixRV
         D8pPxVBmXstEAFp+odU8VS01rkwSdsqDluGZ7pvu5NptHQ4XFd8HrpfS1j77vuZ746og
         vpt81/bmfV8LScTo79fSeT/6lqKSXMBUnj9FYKp4t5Y0UvC/4oHVZQDw7jLKCPgixp75
         LSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yY7htr7WE/EKJBQ2M1n895AFliUWiENe940QX+rVURU=;
        b=RIfTLlblOGU7zrGc/ak0s91zPFTlukdVV8IJxW73qYbv+zql/WbUPs2QlsP4ZoQRHv
         eBIMaLDYX+J/I+JoZxIgOexLMPUBtcQUk9yuO0GWbH5sB7RWHWtuhqLLU7exxgvTurdl
         bInsxGcuArkqiHpVQX+Qxr2UC2Pp0HG+U1Hg+QchSUfC/zN6Wro1FVC6QUJyzZeTN+uK
         OU6bHdXOix2Peo1g2Q9C06WDOp52vPtJwT0ZiYLd62tObOiy3zaO58xQWAWmuS5mbTCk
         k+kua1OIsURy91Rz0U9AhoqafT8AsF5cT9Kdjmc6n5qmLNPG50R3mPiC1pcvwUSG+1J5
         34vg==
X-Gm-Message-State: APjAAAUSbUaCswdbausT3S412ibqHN25ix+t3+pbgxRjTp6Ur2YQX9ve
        n6yexVCtixkDjmhnh1/CJOqzdLDTVuteAC4ILRPg5Q==
X-Google-Smtp-Source: APXvYqzIUoQsP0J/BgEBMYUjNuJWFSVhIYrHnm20VdZDK2UbmN4z6gZVZhh65eDNMlZPYVymw14imtEU7Dp8vHBmrS4=
X-Received: by 2002:aa7:9e0a:: with SMTP id y10mr17057703pfq.93.1565701900046;
 Tue, 13 Aug 2019 06:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005463aa0589dcfb85@google.com> <000000000000773344058bbe0858@google.com>
In-Reply-To: <000000000000773344058bbe0858@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 13 Aug 2019 15:11:29 +0200
Message-ID: <CAAeHK+wbx6B=0j_RNcRkkJY-Qj-QTmjprJtF5Vx=AErn84zdSQ@mail.gmail.com>
Subject: Re: INFO: trying to register non-static key in usbtouch_reset_resume
To:     syzbot <syzbot+933daad9be4e67ba91a9@syzkaller.appspotmail.com>
Cc:     allison@lohutok.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, rfontana@redhat.com,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 11:33 AM syzbot
<syzbot+933daad9be4e67ba91a9@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    9939f56e usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=100c063aa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df134eda130bb43a
> dashboard link: https://syzkaller.appspot.com/bug?extid=933daad9be4e67ba91a9
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144fa5e6a00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d12de6a00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+933daad9be4e67ba91a9@syzkaller.appspotmail.com
>
> usb 1-1: reset low-speed USB device number 2 using dummy_hcd
> INFO: trying to register non-static key.
> the code is fine but needs lockdep annotation.
> turning off the locking correctness validator.
> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.2.0-rc5+ #11
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   assign_lock_key kernel/locking/lockdep.c:775 [inline]
>   register_lock_class+0x11ae/0x1240 kernel/locking/lockdep.c:1084
>   __lock_acquire+0x11d/0x5340 kernel/locking/lockdep.c:3674
>   lock_acquire+0x100/0x2b0 kernel/locking/lockdep.c:4303
>   __mutex_lock_common kernel/locking/mutex.c:926 [inline]
>   __mutex_lock+0xf9/0x12b0 kernel/locking/mutex.c:1073
>   usbtouch_reset_resume+0xb1/0x170
> drivers/input/touchscreen/usbtouchscreen.c:1611
>   usb_resume_interface drivers/usb/core/driver.c:1242 [inline]
>   usb_resume_interface.isra.0+0x184/0x390 drivers/usb/core/driver.c:1210
>   usb_resume_both+0x23d/0x780 drivers/usb/core/driver.c:1412
>   __rpm_callback+0x27e/0x3c0 drivers/base/power/runtime.c:355
>   rpm_callback+0x18f/0x230 drivers/base/power/runtime.c:485
>   rpm_resume+0x10c5/0x1840 drivers/base/power/runtime.c:849
>   __pm_runtime_resume+0x103/0x180 drivers/base/power/runtime.c:1076
>   pm_runtime_get_sync include/linux/pm_runtime.h:226 [inline]
>   usb_autoresume_device+0x1e/0x60 drivers/usb/core/driver.c:1599
>   usb_remote_wakeup+0x7b/0xb0 drivers/usb/core/hub.c:3601
>   hub_port_connect_change drivers/usb/core/hub.c:5190 [inline]
>   port_event drivers/usb/core/hub.c:5350 [inline]
>   hub_event+0x23d7/0x3590 drivers/usb/core/hub.c:5432
>   process_one_work+0x905/0x1570 kernel/workqueue.c:2269
>   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
>   kthread+0x30b/0x410 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> dummy_hcd dummy_hcd.0: port status 0x00010100 has changes
> dummy_hcd dummy_hcd.0: port status 0x00010101 has changes
> dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
> usb 1-1: reset low-speed USB device number 2 using dummy_hcd
> dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
> usb usb1: dummy_bus_suspend
> usb usb1: dummy_bus_resume
> dummy_hcd dummy_hcd.0: port status 0x00010100 has changes
> dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
> usb 1-1: reset low-speed USB device number 2 using dummy_hcd
> dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
> usb usb1: dummy_bus_suspend
> usb usb1: dummy_bus_resume
> dummy_hcd dummy_hcd.0: port status 0x00010100 has changes
> dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
> usb 1-1: reset low-speed USB device number 2 using dummy_hcd
> dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
> usb usb1: dummy_bus_suspend
> usb usb1: dummy_bus_resume
> dummy_hcd dummy_hcd.0: port status 0x00010100 has changes
> dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
> usb 1-1: reset low-speed USB device number 2 using dummy_hcd
> dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
> usb usb1: dummy_bus_suspend
> usb usb1: dummy_bus_resume
> dummy_hcd dummy_hcd.0: port status 0x00010100 has changes
> dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
> usb 1-1: reset low-speed USB device number 2 using dummy_hcd
> dummy_hcd dummy_hcd.0: port status 0x00100303 has changes
>

#syz dup: WARNING in usbtouch_open
