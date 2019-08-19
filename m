Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03BEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73E722CE9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJYynHWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfHSRAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:00:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45928 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfHSQ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:59:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so1540751pgp.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUxgzN8UU65DwqW16EZRmKb5xDjSw2k2ZtFj5x9TEjo=;
        b=CJYynHWtlqIstUC4ROdZfXlBH+Oe5b2LQEHBlUXqS1fEfTzy7wdLZVSVdG+/IJ3MZ6
         U+BuaCZOjqihV4zQeTIrW2SJHmhqQSgx1AZTAnhu+teeQYoNilE4VPfszkLuhjFhgDGN
         T4yOahz+ZRnVX34bG19K5d594xz66BbvtKwymGtYm5y3v6Oacs69heEz8yfZJs3YZvhE
         lF4vyVpiwL/QOA8m0/hzicsimYxTgc3AjLDBEctktbaKK3cRz3FQyruxHPoR+cjQcm8x
         Uixeq0ULhfZFgZcNJrKwTm+xagKpiq3HIlQQM9cdnoAPtgBXFwpFBFmazyzUPpciJoqk
         P/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUxgzN8UU65DwqW16EZRmKb5xDjSw2k2ZtFj5x9TEjo=;
        b=B1MeDs+l1P6PdehOMr+UWaKMR3fXSANU4/YWIvET+ZkzwYIk+W2fasj4MTAJE/lNyK
         +PeYp34XvNaO4X2pXUajRLPeF4Wqv6Z66u/kdh5v0ceWPqIp8cRKhJTQw48eMzKda8QH
         lYiaaNB5ZvX6V+SpJ4vFrl9/vc15qxTldf6CuUh/8RM0fI0vS4Hy4aLyoBkNUQqK9S1y
         ZdaZaKC+hHQ7pRiWSrlsRfB/v65um1/aHJrHqHLkKyZjiN8Z+6i3zT6AuRK54C+LXtQU
         oJy/GaobRIxpX5kK+/QiL4Ep+yfCsesjr02TmpcULpUj+6nHv6bd149WmdNdp0luN52B
         cf4w==
X-Gm-Message-State: APjAAAWgqJiIxvyXuLIIxRkdXEscJboYM0Ik5MEPgF9fwPVOpRB63WHH
        ciZ9teuWGFYdp33UOCqN5+GmHmu7Weysbi6ZHOLBnA==
X-Google-Smtp-Source: APXvYqzCYnJdpEMlutnsSJtr8ra8DIo473qpMCyc2viI6vvHVXot/Jwd4SsTNIzUI4faNcKY/5cxsxb8MeE8nJM+dJA=
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr21413311pjt.123.1566233997275;
 Mon, 19 Aug 2019 09:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000621bc305907aaf02@google.com>
In-Reply-To: <000000000000621bc305907aaf02@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 19 Aug 2019 18:59:45 +0200
Message-ID: <CAAeHK+zOQLEcHesUzKHT2U59DpHtR3PnZXdTMv=1PNLD-evqtA@mail.gmail.com>
Subject: Re: WARNING in kmem_cache_alloc_trace
To:     syzbot <syzbot+0e7b6b6001ca8ed655f6@syzkaller.appspotmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, chunfeng.yun@mediatek.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 6:18 PM syzbot
<syzbot+0e7b6b6001ca8ed655f6@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d0847550 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=16947fce600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc9c80cc095da19
> dashboard link: https://syzkaller.appspot.com/bug?extid=0e7b6b6001ca8ed655f6
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1141c5ba600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ed91d2600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0e7b6b6001ca8ed655f6@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> do not call blocking ops when !TASK_RUNNING; state=1 set at
> [<000000000453b57c>] prepare_to_wait+0xb1/0x2b0 kernel/sched/wait.c:230
> WARNING: CPU: 0 PID: 1720 at kernel/sched/core.c:6551
> __might_sleep+0x135/0x190 kernel/sched/core.c:6551
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 1720 Comm: syz-executor552 Not tainted 5.3.0-rc4+ #26
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   panic+0x2a3/0x6da kernel/panic.c:219
>   __warn.cold+0x20/0x4a kernel/panic.c:576
>   report_bug+0x262/0x2a0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:179 [inline]
>   fixup_bug arch/x86/kernel/traps.c:174 [inline]
>   do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
>   do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
>   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
> RIP: 0010:__might_sleep+0x135/0x190 kernel/sched/core.c:6551
> Code: 65 48 8b 1c 25 00 ef 01 00 48 8d 7b 10 48 89 fe 48 c1 ee 03 80 3c 06
> 00 75 2b 48 8b 73 10 48 c7 c7 e0 55 c6 85 e8 30 21 f6 ff <0f> 0b e9 46 ff
> ff ff e8 ef ee 46 00 e9 29 ff ff ff e8 e5 ee 46 00
> RSP: 0018:ffff8881c7df7a30 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff8881d4a49800 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81288cfd RDI: ffffed1038fbef38
> RBP: ffffffff86a6a5d1 R08: ffff8881d4a49800 R09: fffffbfff11ad3a1
> R10: fffffbfff11ad3a0 R11: ffffffff88d69d07 R12: 00000000000001f5
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000cc0
>   slab_pre_alloc_hook mm/slab.h:501 [inline]
>   slab_alloc_node mm/slub.c:2690 [inline]
>   slab_alloc mm/slub.c:2778 [inline]
>   kmem_cache_alloc_trace+0x233/0x2f0 mm/slub.c:2795
>   kmalloc include/linux/slab.h:552 [inline]
>   dummy_urb_enqueue+0x7c/0x890 drivers/usb/gadget/udc/dummy_hcd.c:1249
>   usb_hcd_submit_urb+0x2aa/0x1ee0 drivers/usb/core/hcd.c:1555
>   usb_submit_urb+0x6e5/0x13b0 drivers/usb/core/urb.c:569
>   yurex_write+0x3b2/0x710 drivers/usb/misc/yurex.c:491
>   __vfs_write+0x76/0x100 fs/read_write.c:494
>   vfs_write+0x262/0x5c0 fs/read_write.c:558
>   ksys_write+0x127/0x250 fs/read_write.c:611
>   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440749
> Code: e8 bc af 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffccb32e308 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440749
> RDX: 000000000000008d RSI: 0000000020000040 RDI: 0000000000000004
> RBP: 00000000006cb018 R08: 000000000000000f R09: 00000000004002c8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401fd0
> R13: 0000000000402060 R14: 0000000000000000 R15: 0000000000000000
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
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

Looks like an issue in the yurex driver, despite a generic report title.
