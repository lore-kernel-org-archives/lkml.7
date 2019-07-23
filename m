Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04B4C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A23621911
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVD3kf8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbfGWH3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:29:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36148 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388344AbfGWH3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:29:36 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so79814491iom.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 00:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8k424NyrneZm8uYnqNL+NvCg5Ao/qU37IRKKlkguJs=;
        b=gVD3kf8g3YfT1qidprM/VLJGPdEQPy1Hnw16DDFu13W6WbaGz1OXLg1escxepEY54T
         77fQVy0lRaIQUOENQv8EKWb6GRiluTTF48lL6xnGviCbVEuKBqVR9FnZ62o7l+d14ZJL
         tqVAG5qBjAeDhlky5+h0Dn0JsrxD996FLQY343NZ2x2IPJ0fu7mJsTjHKu3S0/Pm/2Rg
         kNQX1qp4GkLrEM3KP0FvfA8qrWetPXhUIWcNNcHlrhhmOkfKzgOQN4XNO/e6DMT9g4Ka
         Rw82TLAn06p54KCMslSn4DISydKWvQOsxe/liJ5uJGHxIkmy3wxUaWlCBHpqDYD3gtzO
         FPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8k424NyrneZm8uYnqNL+NvCg5Ao/qU37IRKKlkguJs=;
        b=quBIHtqOehBhdsP4HJvldnSgYprAw9NDke/adEe9JxBex+ImM0k3ZsNX60YgvkQOd0
         3Zr48/X4CSQmt3IYgYYrOWL4jQ6TyF9xxqsxJ6iwiwV8eNcIV53o2vcskE0taFFAeLsR
         qYxfOAX/iYfFDQY9GHBASrCM6MfzLIz9DjRXF+baqIV6YyRH261/HBkRQhYoBrSSmHMM
         /m2mxSF5foqx5BkHmyDtTUNBKvpznx5rNS9A4gNZz4+vDE93ATsO58zVDpHaIyv9JuAT
         178B+v6gARPxVQhxZQsJb2L2og4+UkwkW+0pgEcEEUdiTzQLHbUUek2w23vCcSprleqr
         4MHw==
X-Gm-Message-State: APjAAAVqR4ZgIp8bCtCuC+LB4puJLOZhhbGyvRjHzLOcdauknrM5q8pS
        toalWH2WLYBsapgB5aBzV+QVXunknzLCfK57t7qC6w==
X-Google-Smtp-Source: APXvYqxrzGaWpbAdT7VSuME5l8UlNpP6Yvd6/8U85eUm7iqJjLmC8f2GYueYIB5AnXjkoDtWaBaGbQblTGi77c+Lsps=
X-Received: by 2002:a6b:4101:: with SMTP id n1mr42187939ioa.138.1563866974368;
 Tue, 23 Jul 2019 00:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003fd4ab058e46951f@google.com>
In-Reply-To: <0000000000003fd4ab058e46951f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Jul 2019 09:29:23 +0200
Message-ID: <CACT4Y+YLqSt34ka5kQQNBeo+GvGZ0dzNFL3Rb8_1Cid_C75_2w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in h5_rx_3wire_hdr
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+0abbda0523882250a97a@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 5:18 PM syzbot
<syzbot+0abbda0523882250a97a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    6d21a41b Add linux-next specific files for 20190718
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1377958fa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
> dashboard link: https://syzkaller.appspot.com/bug?extid=0abbda0523882250a97a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113e2bb7a00000

+drivers/bluetooth/hci_h5.c maintainers

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0abbda0523882250a97a@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in h5_rx_3wire_hdr+0x35d/0x3c0
> /drivers/bluetooth/hci_h5.c:438
> Read of size 1 at addr ffff8880a161d1c8 by task syz-executor.4/12040
>
> CPU: 1 PID: 12040 Comm: syz-executor.4 Not tainted 5.2.0-next-20190718 #41
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack /lib/dump_stack.c:77 [inline]
>   dump_stack+0x172/0x1f0 /lib/dump_stack.c:113
>   print_address_description.cold+0xd4/0x306 /mm/kasan/report.c:351
>   __kasan_report.cold+0x1b/0x36 /mm/kasan/report.c:482
>   kasan_report+0x12/0x17 /mm/kasan/common.c:612
>   __asan_report_load1_noabort+0x14/0x20 /mm/kasan/generic_report.c:129
>   h5_rx_3wire_hdr+0x35d/0x3c0 /drivers/bluetooth/hci_h5.c:438
>   h5_recv+0x32f/0x500 /drivers/bluetooth/hci_h5.c:563
>   hci_uart_tty_receive+0x279/0x790 /drivers/bluetooth/hci_ldisc.c:600
>   tiocsti /drivers/tty/tty_io.c:2197 [inline]
>   tty_ioctl+0x949/0x14f0 /drivers/tty/tty_io.c:2573
>   vfs_ioctl /fs/ioctl.c:46 [inline]
>   file_ioctl /fs/ioctl.c:509 [inline]
>   do_vfs_ioctl+0xdb6/0x13e0 /fs/ioctl.c:696
>   ksys_ioctl+0xab/0xd0 /fs/ioctl.c:713
>   __do_sys_ioctl /fs/ioctl.c:720 [inline]
>   __se_sys_ioctl /fs/ioctl.c:718 [inline]
>   __x64_sys_ioctl+0x73/0xb0 /fs/ioctl.c:718
>   do_syscall_64+0xfd/0x6a0 /arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459819
> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f7a3b459c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459819
> RDX: 0000000020000080 RSI: 0000000000005412 RDI: 0000000000000003
> RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7a3b45a6d4
> R13: 00000000004c408a R14: 00000000004d7ff0 R15: 00000000ffffffff
>
> Allocated by task 9200:
>   save_stack+0x23/0x90 /mm/kasan/common.c:69
>   set_track /mm/kasan/common.c:77 [inline]
>   __kasan_kmalloc /mm/kasan/common.c:487 [inline]
>   __kasan_kmalloc.constprop.0+0xcf/0xe0 /mm/kasan/common.c:460
>   kasan_kmalloc+0x9/0x10 /mm/kasan/common.c:501
>   __do_kmalloc_node /mm/slab.c:3615 [inline]
>   __kmalloc_node_track_caller+0x4e/0x70 /mm/slab.c:3629
>   __kmalloc_reserve.isra.0+0x40/0xf0 /net/core/skbuff.c:141
>   __alloc_skb+0x10b/0x5e0 /net/core/skbuff.c:209
>   alloc_skb /./include/linux/skbuff.h:1055 [inline]
>   bt_skb_alloc /./include/net/bluetooth/bluetooth.h:339 [inline]
>   h5_rx_pkt_start+0xce/0x270 /drivers/bluetooth/hci_h5.c:474
>   h5_recv+0x32f/0x500 /drivers/bluetooth/hci_h5.c:563
>   hci_uart_tty_receive+0x279/0x790 /drivers/bluetooth/hci_ldisc.c:600
>   tty_ldisc_receive_buf+0x15f/0x1c0 /drivers/tty/tty_buffer.c:465
>   tty_port_default_receive_buf+0x7d/0xb0 /drivers/tty/tty_port.c:38
>   receive_buf /drivers/tty/tty_buffer.c:481 [inline]
>   flush_to_ldisc+0x222/0x390 /drivers/tty/tty_buffer.c:533
>   process_one_work+0x9af/0x1740 /kernel/workqueue.c:2269
>   worker_thread+0x98/0xe40 /kernel/workqueue.c:2415
>   kthread+0x361/0x430 /kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352
>
> Freed by task 9200:
>   save_stack+0x23/0x90 /mm/kasan/common.c:69
>   set_track /mm/kasan/common.c:77 [inline]
>   __kasan_slab_free+0x102/0x150 /mm/kasan/common.c:449
>   kasan_slab_free+0xe/0x10 /mm/kasan/common.c:457
>   __cache_free /mm/slab.c:3425 [inline]
>   kfree+0x10a/0x2c0 /mm/slab.c:3756
>   skb_free_head+0x93/0xb0 /net/core/skbuff.c:591
>   skb_release_data+0x42d/0x7c0 /net/core/skbuff.c:611
>   skb_release_all+0x4d/0x60 /net/core/skbuff.c:665
>   __kfree_skb /net/core/skbuff.c:679 [inline]
>   kfree_skb /net/core/skbuff.c:697 [inline]
>   kfree_skb+0x101/0x3c0 /net/core/skbuff.c:691
>   h5_reset_rx+0x4c/0x120 /drivers/bluetooth/hci_h5.c:530
>   h5_rx_3wire_hdr+0x2f5/0x3c0 /drivers/bluetooth/hci_h5.c:440
>   h5_recv+0x32f/0x500 /drivers/bluetooth/hci_h5.c:563
>   hci_uart_tty_receive+0x279/0x790 /drivers/bluetooth/hci_ldisc.c:600
>   tty_ldisc_receive_buf+0x15f/0x1c0 /drivers/tty/tty_buffer.c:465
>   tty_port_default_receive_buf+0x7d/0xb0 /drivers/tty/tty_port.c:38
>   receive_buf /drivers/tty/tty_buffer.c:481 [inline]
>   flush_to_ldisc+0x222/0x390 /drivers/tty/tty_buffer.c:533
>   process_one_work+0x9af/0x1740 /kernel/workqueue.c:2269
>   worker_thread+0x98/0xe40 /kernel/workqueue.c:2415
>   kthread+0x361/0x430 /kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352
>
> The buggy address belongs to the object at ffff8880a161d1c0
>   which belongs to the cache kmalloc-8k of size 8192
> The buggy address is located 8 bytes inside of
>   8192-byte region [ffff8880a161d1c0, ffff8880a161f1c0)
> The buggy address belongs to the page:
> page:ffffea0002858700 refcount:1 mapcount:0 mapping:ffff8880aa4021c0
> index:0x0 compound_mapcount: 0
> flags: 0x1fffc0000010200(slab|head)
> raw: 01fffc0000010200 ffffea0002850508 ffffea000262ed08 ffff8880aa4021c0
> raw: 0000000000000000 ffff8880a161d1c0 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8880a161d080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff8880a161d100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff8880a161d180: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>                                                ^
>   ffff8880a161d200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8880a161d280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000003fd4ab058e46951f%40google.com.
