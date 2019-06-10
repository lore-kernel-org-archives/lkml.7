Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D73C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC27820859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389972AbfFJOyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:54:08 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:52107 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389379AbfFJOyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:54:07 -0400
Received: by mail-it1-f200.google.com with SMTP id w80so9031374itc.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 07:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pR/lX6upYTN7oLpDXNAj1RULtz2NNsKYuEMTxGjiiNs=;
        b=UcoSXorPO4Y03ihZbwwovIRXja7uwKliWMKbHnmlTC6cgB+GVREzJrpnAr5jOS95wd
         8wJVSUiSdHPg6sgjXDykV/zgC0Tj/HBXmhh4SRTlsAJF/Sb1OZw1YRm/4FINw99SsQ0D
         MJtGNuuf2dlgTXxDmnNfOeWFJxGl8hWQEng4D1aAhls1GIJrMWBd8o4IoPEV03N1gJmv
         bGCHW38rKjFfN1dRQLc7KwW4QyrDMdWUWzu34wNkRz9BUvj4z2FbXZED4jIalfJpn0aF
         ihv5ISlwgdk3lqfkg/7xIO33VIVuQg35OunbaZ3cBh9mRl4S+tDpooWbcYlNdTrHNduX
         8CaQ==
X-Gm-Message-State: APjAAAXrJhDXWwFRUue21Babl1D3Sn7K8cD/ZUlpBlTiWIjbGRCM1q+h
        bjxceUCC5wwqUIJ4vPNbrIZt8KO3vQ+tdh5PeRmq6iF61EnO
X-Google-Smtp-Source: APXvYqytFAYUICLEM4+lMx4UH7184LYVFDGiDmcQiFqyD8xDKekWsiRUitH2pZ25t5OESdonAF3MGXeYMB4TYKbch2CFqoKC8XUR
MIME-Version: 1.0
X-Received: by 2002:a02:938f:: with SMTP id z15mr45355127jah.108.1560178446420;
 Mon, 10 Jun 2019 07:54:06 -0700 (PDT)
Date:   Mon, 10 Jun 2019 07:54:06 -0700
In-Reply-To: <0000000000002f9ef4058848f26d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015d213058af95a5f@google.com>
Subject: Re: KASAN: use-after-free Read in kfree_skb (3)
From:   syzbot <syzbot+dcb1305dd05699c40640@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    d1fdb6d8 Linux 5.2-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138bdc01a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
dashboard link: https://syzkaller.appspot.com/bug?extid=dcb1305dd05699c40640
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c787f2a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e32801a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dcb1305dd05699c40640@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: use-after-free in refcount_read include/linux/refcount.h:43  
[inline]
BUG: KASAN: use-after-free in skb_unref include/linux/skbuff.h:1016 [inline]
BUG: KASAN: use-after-free in kfree_skb+0x38/0x390 net/core/skbuff.c:690
Read of size 4 at addr ffff88808d7fb2d4 by task kworker/u4:3/189

CPU: 0 PID: 189 Comm: kworker/u4:3 Not tainted 5.2.0-rc4 #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:188
  __kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  kasan_report+0x12/0x20 mm/kasan/common.c:614
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_read+0x11/0x20 mm/kasan/common.c:94
  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
  refcount_read include/linux/refcount.h:43 [inline]
  skb_unref include/linux/skbuff.h:1016 [inline]
  kfree_skb+0x38/0x390 net/core/skbuff.c:690
  bcsp_recv+0x2d8/0x13a0 drivers/bluetooth/hci_bcsp.c:608
  hci_uart_tty_receive+0x225/0x530 drivers/bluetooth/hci_ldisc.c:592
  tty_ldisc_receive_buf+0x15f/0x1c0 drivers/tty/tty_buffer.c:465
  tty_port_default_receive_buf+0x7d/0xb0 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:481 [inline]
  flush_to_ldisc+0x222/0x390 drivers/tty/tty_buffer.c:533
  process_one_work+0x989/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x354/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 189:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:489 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:462
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:497
  slab_post_alloc_hook mm/slab.h:437 [inline]
  slab_alloc_node mm/slab.c:3269 [inline]
  kmem_cache_alloc_node+0x131/0x710 mm/slab.c:3579
  __alloc_skb+0xd5/0x5e0 net/core/skbuff.c:194
  alloc_skb include/linux/skbuff.h:1054 [inline]
  bt_skb_alloc include/net/bluetooth/bluetooth.h:339 [inline]
  bcsp_recv+0x8c1/0x13a0 drivers/bluetooth/hci_bcsp.c:670
  hci_uart_tty_receive+0x225/0x530 drivers/bluetooth/hci_ldisc.c:592
  tty_ldisc_receive_buf+0x15f/0x1c0 drivers/tty/tty_buffer.c:465
  tty_port_default_receive_buf+0x7d/0xb0 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:481 [inline]
  flush_to_ldisc+0x222/0x390 drivers/tty/tty_buffer.c:533
  process_one_work+0x989/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x354/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 8808:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:451
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:459
  __cache_free mm/slab.c:3432 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3698
  kfree_skbmem net/core/skbuff.c:620 [inline]
  kfree_skbmem+0xc5/0x150 net/core/skbuff.c:614
  __kfree_skb net/core/skbuff.c:677 [inline]
  kfree_skb net/core/skbuff.c:694 [inline]
  kfree_skb+0xf0/0x390 net/core/skbuff.c:688
  bcsp_recv+0x2d8/0x13a0 drivers/bluetooth/hci_bcsp.c:608
  hci_uart_tty_receive+0x225/0x530 drivers/bluetooth/hci_ldisc.c:592
  tiocsti drivers/tty/tty_io.c:2195 [inline]
  tty_ioctl+0x921/0x14a0 drivers/tty/tty_io.c:2571
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd5f/0x1380 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88808d7fb200
  which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 212 bytes inside of
  224-byte region [ffff88808d7fb200, ffff88808d7fb2e0)
The buggy address belongs to the page:
page:ffffea000235fec0 refcount:1 mapcount:0 mapping:ffff88821b6f6540  
index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea000256f0c8 ffffea0002a49888 ffff88821b6f6540
raw: 0000000000000000 ffff88808d7fb0c0 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808d7fb180: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88808d7fb200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88808d7fb280: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                                  ^
  ffff88808d7fb300: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
  ffff88808d7fb380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

