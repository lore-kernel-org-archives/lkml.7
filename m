Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4AEC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379A3214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i12ByIe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441318AbfIXOUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:20:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45279 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436753AbfIXOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:20:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id 4so1394870pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 07:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSLdeQv+YjEpGSVK/FgtNrsrxkCP1jxSzbN5KR9bzLo=;
        b=i12ByIe1FOnjphXX5RDI8FRL6u108hINLevjDyNb6iqFKXSnH5HKuxkhuuPnEHQqZz
         ZghLTmt8chWt7Xfdc5qhpjyempneKhvlTWH8evzpmz8VzfB2oZHKFwiHDr09IaFmX1el
         9d6Dte2IXGYjNOiNTg/NsvQtJmaTB283Rtz3Tq3TEIQB5BKeasLeifrsu/OQ2B9Gli1J
         thFgyyHJJCtWwryv0Cbh+FlZ9q5rUtOTisOrrVD4vm7zuddZdPDwpwlkaTXIsqYm0vJa
         1yk/fqMQFkR994kPnjMPRhJ0dLDz9jb+d5b1ps9yfSPAjy/q1/U5Y4yOVkebDOimd6tW
         MtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSLdeQv+YjEpGSVK/FgtNrsrxkCP1jxSzbN5KR9bzLo=;
        b=ipeaFnZk5ceE1ZnLmUApPihcXJKptWV8Bu3W5WIGTZGgIEgccY5Eu5WzPo7xVNxgKX
         ZyP/ZmFdbjtiDg27kRHoT22y28cdp2aQzh+dZIwhGLKZK3cUa5IAfsqpXXop/wyYOKBX
         CcfFG/o/IO1oYokg0qpQR475i+bqUKJcvimH4bd0Hing+wIXz2y9bQGCBZnfySAu3914
         lpr5vY/bnn7/53eQbI2vADe5F/YHvPvOhtr3WLOFrXadWWLN3WXxHxq8BQaiQrCnOoRO
         9ETkUMRm/kBPtCJcfjhvERxyYdLfUJq63sSjy6Kqh0pTsGsYdhoyhon69EJkAFMUmer0
         QhzQ==
X-Gm-Message-State: APjAAAWmEep/kK7D24Rmz6HsGrGh7yjiLhMDSsfTv2Q6iCN2nqUK6ZtA
        4sEkFqkxnviz9LxldE75sWKTyMdYpfF7O17TGztajA==
X-Google-Smtp-Source: APXvYqx99VFFwuojxbgj5GQsb20TuZ0F41JFIiy5+PSU26X2Gwv9RF6L8DrFTF6znTTeXS4ywCxduz5yfugPwFgUEK0=
X-Received: by 2002:a17:90a:ff18:: with SMTP id ce24mr235583pjb.123.1569334819782;
 Tue, 24 Sep 2019 07:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000030f35305934d3804@google.com>
In-Reply-To: <00000000000030f35305934d3804@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 24 Sep 2019 16:20:08 +0200
Message-ID: <CAAeHK+wE8ngx2Pa9=vD6Fw6MCbHpxfX6ss97deQUsmGD_Bw_Bw@mail.gmail.com>
Subject: Re: general protection fault in open_rio
To:     syzbot <syzbot+dbd38fbb686a9681143a@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 4:19 PM syzbot
<syzbot+dbd38fbb686a9681143a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d9e63adc usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=1602b303600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f4fa60e981ee8e6a
> dashboard link: https://syzkaller.appspot.com/bug?extid=dbd38fbb686a9681143a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+dbd38fbb686a9681143a@syzkaller.appspotmail.com
>
> usb 4-1: Rio opened.
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 1 PID: 6898 Comm: syz-executor.1 Not tainted 5.3.0+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:dev_name include/linux/device.h:1342 [inline]
> RIP: 0010:__dev_printk+0x3a/0x203 drivers/base/core.c:3335
> Code: 89 f5 53 e8 0f 01 d0 fe 48 85 ed 0f 84 bc 01 00 00 e8 01 01 d0 fe 48
> 8d 7d 50 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 <80> 3c 02 00 74
> 05 e8 32 e7 f6 fe 4c 8b 7d 50 4d 85 ff 75 27 e8 d4
> RSP: 0018:ffff8881cf697830 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: ffffed1039ed2f0d RCX: ffffc900012d0000
> RDX: 000000000000001e RSI: ffffffff826e3b9f RDI: 00000000000000f0
> RBP: 00000000000000a0 R08: ffff8881cf37c800 R09: fffffbfff0e98bf9
> R10: ffff8881cf697960 R11: ffffffff874c5fc7 R12: ffffffff85f2e160
> R13: ffff8881cf697888 R14: ffff8881ca024528 R15: ffff8881ca024528
> FS:  00007f175b8c8700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b30627000 CR3: 00000001cbb1f000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   _dev_info+0xd7/0x109 drivers/base/core.c:3381
>   open_rio drivers/usb/misc/rio500.c:75 [inline]
>   open_rio+0xaa/0xc0 drivers/usb/misc/rio500.c:59
>   usb_open+0x1df/0x270 drivers/usb/core/file.c:48
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
> RSP: 002b:00007f175b8c77a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004138f1
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007f175b8c77d0
> RBP: 000000000075bf20 R08: 0000000000000000 R09: 000000000000000f
> R10: 0000000000000064 R11: 0000000000000293 R12: 00007f175b8c86d4
> R13: 00000000004c8d40 R14: 00000000004dfe48 R15: 00000000ffffffff
> Modules linked in:
> ---[ end trace 2b1b73a1ede24824 ]---
> RIP: 0010:dev_name include/linux/device.h:1342 [inline]
> RIP: 0010:__dev_printk+0x3a/0x203 drivers/base/core.c:3335
> Code: 89 f5 53 e8 0f 01 d0 fe 48 85 ed 0f 84 bc 01 00 00 e8 01 01 d0 fe 48
> 8d 7d 50 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 <80> 3c 02 00 74
> 05 e8 32 e7 f6 fe 4c 8b 7d 50 4d 85 ff 75 27 e8 d4
> RSP: 0018:ffff8881cf697830 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: ffffed1039ed2f0d RCX: ffffc900012d0000
> RDX: 000000000000001e RSI: ffffffff826e3b9f RDI: 00000000000000f0
> RBP: 00000000000000a0 R08: ffff8881cf37c800 R09: fffffbfff0e98bf9
> R10: ffff8881cf697960 R11: ffffffff874c5fc7 R12: ffffffff85f2e160
> R13: ffff8881cf697888 R14: ffff8881ca024528 R15: ffff8881ca024528
> FS:  00007f175b8c8700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b30627000 CR3: 00000001cbb1f000 CR4: 00000000001406e0
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

Most probably the same bug:

https://syzkaller.appspot.com/bug?extid=745b0dff8028f9488eba

#syz dup: KASAN: invalid-free in disconnect_rio (2)
