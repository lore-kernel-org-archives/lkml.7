Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9C3C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FD8222F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5OEA6kM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfKSNf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:35:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36721 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfKSNf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:35:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id k13so11387921pgh.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 05:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlL4JdbEktI9zkObkASn7TbhSwKiSPzPVUMi6U8vf2E=;
        b=H5OEA6kMS0jCMTcFH3iKYxZa78SKxenglMSWLMOp6yInuynmqeA2hc7M9GioyuCiWx
         3NbEHnsdTOrOqYDZd5GV3C3fkYTCVU+WsH5e57HL0mpAF/obR+xG1pE4SVLJZlPSPRIm
         mEPN+3ecGnBf6mpvjHUSaJ6Z/EWzfLoFXyyAarIbORfxAX8KFCpuOO8+nnZgH6X0+nOK
         u8uOow8qTm644lreNoTQMltmz+k9NFc3/GDhP3y7njQutN3kbJ7A9ThzBxWswOruBlur
         B6byDGSmsHhIZZgxeJo4DQQWewV0DJMjz9avWU+cmLSEiQ/nj9gWCb4/Qn4T9jQAdO3J
         CLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlL4JdbEktI9zkObkASn7TbhSwKiSPzPVUMi6U8vf2E=;
        b=sjxupfp+IM+e+edJCMl9gnJ13D6VOQhnmt4uga1qIOUpZUM3HtB3CUQBBbPeQbyOxk
         mNigyose62Ik8lP0OZgoLQCX5UkuThiqC8ZXPlW1fNrEnx2MPu96OlJ3S9qQaWUKWEUi
         dYJxzHMT8b7ECsrnDzBA624+xvC9zO4zOLcQ5TYazk4u7f6u7iTfjNH1C1aXMO19yGgJ
         98hO0nvab8Loh2oVV37rgEpa119QIISW3iuuSbwoGXUL8z4GybMSK/mpGNNN4fYG9JDN
         RoDhEImDA8ygrpJE7nMNWfep409P+Rb89yJuYvxYC1Ce1npNep5wyk3Z67b17WyctqV/
         ovOQ==
X-Gm-Message-State: APjAAAVj1U5dz5w9cygAOcI0GOfp1JP8OGSUEiox2Z6PKcY1iqaW28iT
        E2MAxvvu5juSmaecOXOX6GVPSFptv0hOFdIW0NyJjGn89SU=
X-Google-Smtp-Source: APXvYqwJPep0pkr6Pm8D9lD8AXtrHo+fVEFaCUUTFGdphUt+aPWWPkqpij8kFvDzlmTBMo17l+ODwzZ4xneNzmK3iA4=
X-Received: by 2002:a62:53c6:: with SMTP id h189mr5775991pfb.93.1574170525792;
 Tue, 19 Nov 2019 05:35:25 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c4157e0590123002@google.com>
In-Reply-To: <000000000000c4157e0590123002@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Nov 2019 14:35:13 +0100
Message-ID: <CAAeHK+x1gdMaVf8uXKATnsj1+qZ40AJVE7-ZXxFv0NVNi0OuTw@mail.gmail.com>
Subject: Re: divide error in usbtmc_generic_read
To:     syzbot <syzbot+55b0304b360654a7537b@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        guido.kiener@rohde-schwarz.com,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        steve_bayless@keysight.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 1:38 PM syzbot
<syzbot+55b0304b360654a7537b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d0847550 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=16295d4a600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc9c80cc095da19
> dashboard link: https://syzkaller.appspot.com/bug?extid=55b0304b360654a7537b
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1288a31c600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15282e86600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+55b0304b360654a7537b@syzkaller.appspotmail.com
>
> divide error: 0000 [#1] SMP KASAN
> CPU: 1 PID: 1761 Comm: syz-executor063 Not tainted 5.3.0-rc4+ #26
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:usbtmc_generic_read+0x135/0x1190 drivers/usb/class/usbtmc.c:816
> Code: 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2
> 0f 85 50 08 00 00 41 0f b7 6e 34 31 d2 31 ff 8b 44 24 28 <f7> f5 89 d6 41
> 89 d4 e8 2f 54 c9 fd 44 8b 6c 24 28 45 85 e4 44 89
> RSP: 0018:ffff8881d2b77a58 EFLAGS: 00010246
> RAX: 0000000000000002 RBX: 000000004f894bad RCX: ffffffff837487cd
> RDX: 0000000000000000 RSI: ffffffff837487da RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffff8881d20a0000 R09: ffffed103a56ef90
> R10: ffffed103a56ef8f R11: 0000000000000003 R12: ffff8881d08e7180
> R13: 0000000020000000 R14: ffff8881d0404c80 R15: ffff8881d08e7180
> FS:  0000555555b74880(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000006cc090 CR3: 00000001d615e000 CR4: 00000000001406e0
> Call Trace:
>   usbtmc_ioctl_generic_read drivers/usb/class/usbtmc.c:1029 [inline]
>   usbtmc_ioctl+0x27d/0x2ab0 drivers/usb/class/usbtmc.c:2089
>   vfs_ioctl fs/ioctl.c:46 [inline]
>   file_ioctl fs/ioctl.c:509 [inline]
>   do_vfs_ioctl+0xd2d/0x1330 fs/ioctl.c:696
>   ksys_ioctl+0x9b/0xc0 fs/ioctl.c:713
>   __do_sys_ioctl fs/ioctl.c:720 [inline]
>   __se_sys_ioctl fs/ioctl.c:718 [inline]
>   __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:718
>   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4419a9
> Code: e8 8c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffd0abd6738 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004419a9
> RDX: 0000000020000000 RSI: 00000000c0145b0e RDI: 0000000000000004
> RBP: 000000000000a984 R08: 000000000000000f R09: 00000000004002c8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402700
> R13: 0000000000402790 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace a91d281a4d83213c ]---
> RIP: 0010:usbtmc_generic_read+0x135/0x1190 drivers/usb/class/usbtmc.c:816
> Code: 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2
> 0f 85 50 08 00 00 41 0f b7 6e 34 31 d2 31 ff 8b 44 24 28 <f7> f5 89 d6 41
> 89 d4 e8 2f 54 c9 fd 44 8b 6c 24 28 45 85 e4 44 89
> RSP: 0018:ffff8881d2b77a58 EFLAGS: 00010246
> RAX: 0000000000000002 RBX: 000000004f894bad RCX: ffffffff837487cd
> RDX: 0000000000000000 RSI: ffffffff837487da RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffff8881d20a0000 R09: ffffed103a56ef90
> R10: ffffed103a56ef8f R11: 0000000000000003 R12: ffff8881d08e7180
> R13: 0000000020000000 R14: ffff8881d0404c80 R15: ffff8881d08e7180
> FS:  0000555555b74880(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000006cc090 CR3: 00000001d615e000 CR4: 00000000001406e0
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

#syz fix: usbtmc: more sanity checking for packet size
