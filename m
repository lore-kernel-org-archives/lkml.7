Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C1BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9DF208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FC0fNf03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfICMNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:13:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34937 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfICMNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:13:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so8211775pfw.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 05:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aciZLK4eHf2hi5CLyys3bwv1SZObhD4X2AM1NactPFs=;
        b=FC0fNf03T8of5RPMxHUv9Yg92YKEFmswhiyMfatSIkD8a392Kh/qXDsXxDCenIbu1Q
         eLTkb2CBu3qAvIP3PAKAWPk7IkKQGA4tXvbafs0OFUzEnt8dOZfxDPE3QO2GEyimqVPg
         KSfXyitZWOIdaktqLESxcsxBIDkrx0ZGRCT+0bSHcjA+4XNCpWP+vHjuXj79rxMINcEZ
         J3B99m1m4kJor3RNVOgTSE/ZI32faSwl7AA7PV3J3H4/Ty7hPkESADiD77SYWHxAR2aV
         WqTujB7WiXmqcxB8900DQfQncjeWc6gWD4hk4GNZTTXKOGmQfKi933jpaekwfO1UGRmo
         YYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aciZLK4eHf2hi5CLyys3bwv1SZObhD4X2AM1NactPFs=;
        b=gHsH+s+ja8JQybZa/3MmdG9uxXZsV03PGFGwNMIiFmduJT6r9c1fWV5YcOFxomUZv+
         essVCRP1a6T41a1Bx5FKsFV6prBxEcoVBuPOkGMdLbbxudaaXwzT/JET5FNQB4NdBYJW
         6ypZbF/uYAph9SkgiULhqQYa9YpUk9RJ4brczmvXaBewiRUbyC5TXXkbj70NDkGan09X
         m0+N5DCj0fKKc31hdi4gI9MAQSuZBIfsLeJbtRzXvcTrqdqT2FZM13aQTE+KIMkdp0eV
         eB5O+V5+X6Zb+Rbbz/de/7vZ3678Cllxy1lN2N/3Xc2R8EUBe2jTFvii0aL2THrY62rt
         0Y7g==
X-Gm-Message-State: APjAAAVFGQQcatjEebEL8ybzpOW1B6k8zuZOZbAad30LEhYv6pS/MvB4
        C2WK8h11rPaZLvYL/HVXF8+QVh77L/bEzhVvAAEqaw==
X-Google-Smtp-Source: APXvYqy7SPW3b+w0c6uj6yKM7FtVAbLfbdKXEzs6Lf0QeaBLM8Tpt/fY4DMZVbIkAFmN55lFmx9f7M8ge1hnfyZsPMk=
X-Received: by 2002:a17:90a:ff08:: with SMTP id ce8mr8045016pjb.123.1567512787737;
 Tue, 03 Sep 2019 05:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000043c9390591a4f14b@google.com>
In-Reply-To: <00000000000043c9390591a4f14b@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 3 Sep 2019 14:12:56 +0200
Message-ID: <CAAeHK+xdsA1wSBsrCJZsrB8FAvXtzt9JkDaeMK52v6FQe7Lbbw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in usbhid_open
To:     syzbot <syzbot+058e326a87dbb54f2426@syzkaller.appspotmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 2:08 PM syzbot
<syzbot+058e326a87dbb54f2426@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    eea39f24 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=16ab9982600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
> dashboard link: https://syzkaller.appspot.com/bug?extid=058e326a87dbb54f2426
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+058e326a87dbb54f2426@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in clear_bit
> include/asm-generic/bitops-instrumented.h:56 [inline]
> BUG: KASAN: use-after-free in usbhid_open+0x263/0x390
> drivers/hid/usbhid/hid-core.c:727
> Write of size 8 at addr ffff8881c89228c0 by task syz-executor.1/10380
>
> CPU: 0 PID: 10380 Comm: syz-executor.1 Not tainted 5.3.0-rc5+ #28
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x6a/0x32c mm/kasan/report.c:351
>   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
>   kasan_report+0xe/0x12 mm/kasan/common.c:612
>   check_memory_region_inline mm/kasan/generic.c:185 [inline]
>   check_memory_region+0x128/0x190 mm/kasan/generic.c:192
>   clear_bit include/asm-generic/bitops-instrumented.h:56 [inline]
>   usbhid_open+0x263/0x390 drivers/hid/usbhid/hid-core.c:727
>   hid_hw_open+0xd2/0x160 drivers/hid/hid-core.c:2023
>   hidraw_open+0x256/0x740 drivers/hid/hidraw.c:288
>   chrdev_open+0x219/0x5c0 fs/char_dev.c:414
>   do_dentry_open+0x494/0x1120 fs/open.c:797
>   do_last fs/namei.c:3416 [inline]
>   path_openat+0x1430/0x3f50 fs/namei.c:3533
>   do_filp_open+0x1a1/0x280 fs/namei.c:3563
>   do_sys_open+0x3c0/0x580 fs/open.c:1089
>   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x413761
> Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48
> 83 ec 08 e8 0a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48
> 89 c2 e8 53 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007f50d4f077a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 0000000000413761
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f50d4f07850
> RBP: 000000000075bf20 R08: 000000000000000f R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007f50d4f086d4
> R13: 00000000004c8c86 R14: 00000000004dfc10 R15: 00000000ffffffff
>
> The buggy address belongs to the page:
> page:ffffea0007224880 refcount:0 mapcount:0 mapping:0000000000000000
> index:0x0
> flags: 0x200000000000000()
> raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8881c8922780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>   ffff8881c8922800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > ffff8881c8922880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                                             ^
>   ffff8881c8922900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>   ffff8881c8922980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
