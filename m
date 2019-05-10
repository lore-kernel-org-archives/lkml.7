Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417D8C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E8B21479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVjQHtg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfEJN61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:58:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41020 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfEJN60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:58:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id l132so3279539pfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oM8/oNwYrxAzNgRNt3GQ+pcVnxNe9smVxY/SlimUNN4=;
        b=wVjQHtg+qIugF9NaA5lCbGpiKvgLRbmt2/ByjuvTL6qa6UyyLpPXkR1RLOGKxhiqxU
         08Yo61YJtb10oBiPQ7XaFwwAyuH50WshPPBSauuhA/NHjRp8oWYn+nLiOQmnK9vrWq8q
         bOK/mR267drq7y82apMX3xw9s+eKN5WpV2ytXBA2b/4vqb971r5SvcN5NFDIOAIStlwJ
         VXQ1Z1PX2OZq8P3vHm7EMQtKN+ga18zuCCkFwGV+lbLxEVD3EaXnDPBnvBjY29A27tej
         iW1uhcpCDsSo2hqhb1IDpTE5ImYbqo60eBZd8jBaEnO1GDAwqiMEkR6WIwB6nLTNONJF
         3ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oM8/oNwYrxAzNgRNt3GQ+pcVnxNe9smVxY/SlimUNN4=;
        b=ftx+VUCZBIO9ynlldviHOX+NGmJqbOHkgRh9KCwJNlBDfiXTvsE9jXwL9/gnxddbFn
         JtNMCGGfI8KIu7bxatZpdut0MyQxmnTbWxchbcIf9fEF4llEnTJHRP7/KJiqGVcY/7U+
         N/m+VFt/nTX7LFAw0vGytaYmOXvFVFF6HXqCk5SpJNO/4hYddZ/BUASTTkt1YSyPwv95
         TEzRCn9g53/Uw8kzFDv5XriYLCzjbdJhH7j4nT1PBNcZxm/n7IvsZxqCnfiAn42df9zK
         A6gfSqtdW39wXftqhhF2Vmn4FPnt9dBXJKh8akXfpkcZ49AVu1/SWTPpnTi25VD3YWLg
         yYMw==
X-Gm-Message-State: APjAAAWk0Nb5hvRkJ9Jh69ARtl3tuPk2gTZVWdpdlaJXhkJS5xd/4KsQ
        8jQXsjTqRWd4UO/mpXmOTPQVD84S9wBnoHbuXzDLjg==
X-Google-Smtp-Source: APXvYqyyQzPpNgytYZZiMJQNJdM8NNIs4KpbS0RiaQdQe8DVnAxbIlv7nFA+gaEfubBfr2BlDg1xHP9/vSlTfygXNdg=
X-Received: by 2002:a63:2a89:: with SMTP id q131mr13372332pgq.359.1557496704207;
 Fri, 10 May 2019 06:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001cc652058888f117@google.com>
In-Reply-To: <0000000000001cc652058888f117@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 10 May 2019 15:58:13 +0200
Message-ID: <CAAeHK+xirVvazQoqgaDy3fDaZ1JuYDyb5sQp1Kh_spGdWrCOTw@mail.gmail.com>
Subject: Re: general protection fault in yurex_interrupt
To:     syzbot <syzbot+3f516a14255f95fc5599@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, rafael@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: syzbot <syzbot+3f516a14255f95fc5599@syzkaller.appspotmail.com>
Date: Fri, May 10, 2019 at 3:57 PM
To: <andreyknvl@google.com>, <gregkh@linuxfoundation.org>,
<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
<rafael@kernel.org>, <syzkaller-bugs@googlegroups.com>

> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    43151d6c usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=12864eaca00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4183eeef650d1234
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f516a14255f95fc5599
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161327b4a00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3f516a14255f95fc5599@syzkaller.appspotmail.com
>
> yurex 1-1:0.150: yurex_interrupt - unknown status received: -71
> yurex 1-1:0.150: yurex_interrupt - unknown status received: -71
> yurex 1-1:0.150: yurex_interrupt - unknown status received: -71
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN PTI
> CPU: 1 PID: 5323 Comm: syz-executor.0 Not tainted 5.1.0-rc3-319004-g43151d6
> #6
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:dev_name include/linux/device.h:1087 [inline]
> RIP: 0010:__dev_printk+0x3f/0x215 drivers/base/core.c:3208
> Code: 89 f5 53 e8 8e 53 1c fc 48 85 ed 0f 84 c9 01 00 00 e8 80 53 1c fc 48
> 8d 7d 50 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 <80> 3c 02 00 74
> 05 e8 41 68 53 fc 4c 8b 7d 50 4d 85 ff 75 28 e8 53
> RSP: 0018:ffff8880ad107930 EFLAGS: 00010002
> RAX: dffffc0000000000 RBX: ffffed1015a20f2d RCX: 00000000ffffffed
> RDX: 0000000000000010 RSI: ffffffff855576f0 RDI: 0000000000000080
> RBP: 0000000000000030 R08: ffff88809b7b1880 R09: ffffed1015a24fc9
> R10: ffffed1015a24fc8 R11: ffff8880ad127e47 R12: ffffffff8f031080
> R13: ffff8880ad107988 R14: 0000000000000000 R15: ffff8880a5a48d00
> FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff6c1085000 CR3: 000000001167a000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <IRQ>
>   _dev_err+0xdc/0x10e drivers/base/core.c:3251
>   yurex_interrupt.cold+0x12e/0x13d drivers/usb/misc/yurex.c:183
>   __usb_hcd_giveback_urb+0x1f4/0x470 drivers/usb/core/hcd.c:1758
>   usb_hcd_giveback_urb+0x346/0x400 drivers/usb/core/hcd.c:1823
>   __skb_queue_head_init include/linux/skbuff.h:1790 [inline]
>   skbpoolfree drivers/block/aoe/aoedev.c:428 [inline]
>   freedev drivers/block/aoe/aoedev.c:290 [inline]
>   dummy_timer+0x1225/0x328d drivers/block/aoe/aoedev.c:359
>   call_timer_fn+0x161/0x5f0 kernel/time/timer.c:1325
>   expire_timers kernel/time/timer.c:1362 [inline]
>   __run_timers kernel/time/timer.c:1681 [inline]
>   __run_timers kernel/time/timer.c:1649 [inline]
>   run_timer_softirq+0x58b/0x1400 kernel/time/timer.c:1694
>   __do_softirq+0x22a/0x8cd kernel/softirq.c:293
>   invoke_softirq kernel/softirq.c:374 [inline]
>   irq_exit+0x187/0x1b0 kernel/softirq.c:414
>   exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>   smp_apic_timer_interrupt+0xfe/0x4a0 arch/x86/kernel/apic/apic.c:1062
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
>   </IRQ>
> RIP: 0010:__read_once_size include/linux/compiler.h:193 [inline]
> RIP: 0010:csd_lock_wait kernel/smp.c:108 [inline]
> RIP: 0010:smp_call_function_single+0x284/0x330 kernel/smp.c:302
> Code: c3 e8 c0 a0 0a 00 48 8b 4c 24 08 48 8b 54 24 10 48 8d 74 24 40 8b 7c
> 24 1c e8 28 fa ff ff 41 89 c4 eb 07 e8 9e a0 0a 00 f3 90 <8b> 5c 24 58 31
> ff 83 e3 01 89 de e8 fc a1 0a 00 85 db 75 e5 e8 83
> RSP: 0018:ffff88809b037500 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
> RAX: ffff88809b7b1880 RBX: 0000000000000001 RCX: ffffffff816729e4
> RDX: 0000000000000000 RSI: ffffffff816729d2 RDI: 0000000000000005
> RBP: ffff88809b0375e0 R08: ffff88809b7b1880 R09: ffffed1015a05c49
> R10: ffffed1015a05c48 R11: ffff8880ad02e247 R12: 0000000000000000
> R13: 0000000000000200 R14: 1ffff11013606ea4 R15: ffff880000001000
>   smp_call_function_many+0x66c/0x7a0 kernel/smp.c:434
>   flush_tlb_others arch/x86/include/asm/paravirt.h:68 [inline]
>   flush_tlb_mm_range+0x1a4/0x260 arch/x86/mm/tlb.c:760
>   tlb_flush arch/x86/include/asm/tlb.h:23 [inline]
>   tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:173 [inline]
>   tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:168 [inline]
>   tlb_flush_mmu+0x1b6/0x510 mm/mmu_gather.c:82
>   arch_tlb_finish_mmu+0x41/0x380 mm/mmu_gather.c:100
>   tlb_finish_mmu+0x9c/0x100 mm/mmu_gather.c:259
>   free_ldt_pgtables.part.0+0xd3/0x110 arch/x86/kernel/ldt.c:319
>   arch_exit_mmap arch/x86/include/asm/mmu_context.h:258 [inline]
>   exit_mmap+0x21c/0x4d0 mm/mmap.c:3127
>   __mmput kernel/fork.c:1046 [inline]
>   mmput+0x158/0x4a0 kernel/fork.c:1067
>   exit_mm kernel/exit.c:546 [inline]
>   do_exit+0x7f0/0x2e10 kernel/exit.c:863
>   do_group_exit+0x12a/0x350 kernel/exit.c:980
>   get_signal+0x3a3/0x1cb0 kernel/signal.c:2577
>   do_signal+0x86/0x1750 arch/x86/kernel/signal.c:816
>   exit_to_usermode_loop+0x1fc/0x270 arch/x86/entry/common.c:162
>   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>   do_syscall_64+0x40c/0x4f0 arch/x86/entry/common.c:293
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x458da9
> Code: Bad RIP value.
> RSP: 002b:00007f2ca8685cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 000000000073bf08 RCX: 0000000000458da9
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000073bf08
> RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000073bf0c
> R13: 00007ffc924b246f R14: 00007f2ca86869c0 R15: 000000000073bf0c
> Modules linked in:
> ---[ end trace d1dc12b2d1082091 ]---
> RIP: 0010:dev_name include/linux/device.h:1087 [inline]
> RIP: 0010:__dev_printk+0x3f/0x215 drivers/base/core.c:3208
> Code: 89 f5 53 e8 8e 53 1c fc 48 85 ed 0f 84 c9 01 00 00 e8 80 53 1c fc 48
> 8d 7d 50 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 <80> 3c 02 00 74
> 05 e8 41 68 53 fc 4c 8b 7d 50 4d 85 ff 75 28 e8 53
> RSP: 0018:ffff8880ad107930 EFLAGS: 00010002
> RAX: dffffc0000000000 RBX: ffffed1015a20f2d RCX: 00000000ffffffed
> RDX: 0000000000000010 RSI: ffffffff855576f0 RDI: 0000000000000080
> RBP: 0000000000000030 R08: ffff88809b7b1880 R09: ffffed1015a24fc9
> R10: ffffed1015a24fc8 R11: ffff8880ad127e47 R12: ffffffff8f031080
> R13: ffff8880ad107988 R14: 0000000000000000 R15: ffff8880a5a48d00
> FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000458d7f CR3: 000000001167a000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

#syz dup: general protection fault in __dev_printk

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
