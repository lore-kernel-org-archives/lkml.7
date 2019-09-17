Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33FEC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1A521881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emONvmBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfIQMPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:15:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46699 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIQMPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:15:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so2041096pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmnYpZA3iC+BrJljyl/v54ahbIxfU/8bU9G1qNx5CK8=;
        b=emONvmBI3xBscuMfk9SV5vH9yD19sCNYwM98+d4Pf5o+1UHPBLdPPx7Fl0lp9S9Rw8
         9i5WnvRqyOctEtbe3ZgDgnGoQ4aMeMjl068g15qAaXV8Wx7UIpEofycyESs23/iP17si
         hmxGce71yE8p0VDmBR4tT3fRZz6urkda3ogHRt69Z7oekT5u04Y0wOP2/lEQkzbxSybq
         nfEZsR96vK0cqvkE1dezz1ShYd6kbG+XuA2UrJ3VN8HSYSoZcsCT719F+yeXCH7WMFlE
         86Fslf1XiClHLpPWiynJz2T70ClaY86jPiTlmNNedivsJSfsuKlks5UcXpVpgnlXcZUD
         4rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmnYpZA3iC+BrJljyl/v54ahbIxfU/8bU9G1qNx5CK8=;
        b=XFpNWpw/XSt2JeKlNQt6P41h9HWkUms1BOQKA+AYzqtdyEFlVddBKlhi7NPGm2bfKT
         PbPhgIQ0DoWhzoCaTbD2KVpTe9uHplIbOhpEJiBVw7KSMwznvzCZUHh4R9Uama8uxkNl
         cUaeDkqmPwY9ydShTz2oT0jIEXl4RQa1hVkYX3lHK0twVX51tI0dncspwiV1xvftDZT6
         0tkpc6iCGkYiXVlqVvRFzFyG0oiq896zvngZ5IFt1AjWW8kWBUUe1EBrUf4GxyIZUMkw
         19Qug4CQUabKm3WY5mnxgrh08e4krF6uSyhz118BvH6E/HnuDXlCFq01DBz7YRroXNKm
         72tA==
X-Gm-Message-State: APjAAAUNPHbd18jryOkTNYNOOB5aLJLU1mhmYaL7xA6/zoOtp3LYUAJS
        q+E3bIGZajJQGE/2uOun1yMy0ZAt0/h2iAdJ4cyXtg==
X-Google-Smtp-Source: APXvYqxU5dmfEBc538s2o8X7Fn6bVPsZE+YcnKXR0FmuLOhuPzosOeFhzvLiVNn/nqwy998ZSQAzYNz3B/N9wNxiBgw=
X-Received: by 2002:a63:c442:: with SMTP id m2mr3003491pgg.286.1568722501250;
 Tue, 17 Sep 2019 05:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000044408c0592b00ff5@google.com>
In-Reply-To: <00000000000044408c0592b00ff5@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 17 Sep 2019 14:14:50 +0200
Message-ID: <CAAeHK+yssfbaP2UH3EnkRKsYf25j6XnR21kkFjjK61gSB3drJg@mail.gmail.com>
Subject: Re: KASAN: global-out-of-bounds Read in __pm_runtime_resume
To:     syzbot <syzbot+cd157359d82e8d98c17b@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        pavel@ucw.cz, rjw@rjwysocki.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 8:49 PM syzbot
<syzbot+cd157359d82e8d98c17b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=10efb5fa600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> dashboard link: https://syzkaller.appspot.com/bug?extid=cd157359d82e8d98c17b
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+cd157359d82e8d98c17b@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: global-out-of-bounds in __pm_runtime_resume+0x162/0x180
> drivers/base/power/runtime.c:1069
> Read of size 1 at addr ffffffff863d87b1 by task syz-executor.2/13622
>
> CPU: 0 PID: 13622 Comm: syz-executor.2 Not tainted 5.3.0-rc7+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x6a/0x32c mm/kasan/report.c:351
>   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
>   kasan_report+0xe/0x12 mm/kasan/common.c:618
>   __pm_runtime_resume+0x162/0x180 drivers/base/power/runtime.c:1069
>   pm_runtime_get_sync include/linux/pm_runtime.h:226 [inline]
>   usb_autopm_get_interface+0x1b/0x50 drivers/usb/core/driver.c:1709
>   usbhid_power+0x7c/0xe0 drivers/hid/usbhid/hid-core.c:1234
>   hid_hw_power include/linux/hid.h:1038 [inline]
>   hidraw_open+0x20d/0x740 drivers/hid/hidraw.c:282
>   chrdev_open+0x219/0x5c0 fs/char_dev.c:414
>   do_dentry_open+0x494/0x1120 fs/open.c:797
>   do_last fs/namei.c:3416 [inline]
>   path_openat+0x1430/0x3f50 fs/namei.c:3533
>   do_filp_open+0x1a1/0x280 fs/namei.c:3563
>   do_sys_open+0x3c0/0x580 fs/open.c:1089
>   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4137d1
> Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48
> 83 ec 08 e8 0a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48
> 89 c2 e8 53 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007faea59927a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00000000004137d1
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007faea5992850
> RBP: 000000000075bf20 R08: 000000000000000f R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007faea59936d4
> R13: 00000000004c8cbf R14: 00000000004dfc90 R15: 00000000ffffffff
>
> The buggy address belongs to the variable:
>   __param_str_xfer_debug+0x91/0x4a0
>
> Memory state around the buggy address:
>   ffffffff863d8680: fa fa fa fa 00 00 00 02 fa fa fa fa 00 00 00 00
>   ffffffff863d8700: fa fa fa fa 00 00 00 02 fa fa fa fa 00 07 fa fa
> > ffffffff863d8780: fa fa fa fa 00 00 fa fa fa fa fa fa 00 00 07 fa
>                                       ^
>   ffffffff863d8800: fa fa fa fa 00 00 00 00 00 00 fa fa fa fa fa fa
>   ffffffff863d8880: 00 07 fa fa fa fa fa fa 00 00 06 fa fa fa fa fa
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

#syz dup: general protection fault in __pm_runtime_resume
