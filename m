Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EB6C10F11
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 00:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518BE2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 00:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfDNAQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 20:16:11 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:44557 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfDNAQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 20:16:10 -0400
Received: by mail-io1-f69.google.com with SMTP id c2so11067934ioh.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 17:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xXuzSWyv+sKnNZGQm/vy9xDa4HZxZ8HxM06OLjDe5dQ=;
        b=PtgDN/yxwoVR76efzyh0UzaiXTkid1k6GxgDTTgeXcgJwDjQ4j/6ZGL0nGBGqzLdRO
         MZdNS9728UaiQcn2iE5aN92WozfhPG4EMSvcvK1RkjjGxqrKcmsWnowZn5ZphkZOboa9
         cRfuWy98VCe/WjM2HoEyokxvEzdjosAxsusevqo8EdSnWIkRy0PAOpscf/9HSyYxdiGH
         ExgKfHYQ5bskF1HzXsRa1GAFpXbRf1Q1HOgHevbrbUoTu1nqJQbrZsnbFR73vrCuAR0m
         KrtzCMDhMep2RoY9L0oCyt8OdGGdRuxErm2/s2RitN5DThIS8mSA5yzyl+MLZRIO7XD3
         bRpQ==
X-Gm-Message-State: APjAAAX66m0qXSFr2/fP+f4UEkJxuToGp9bZ3B30Cq1In5WW0Uv8Ajgx
        d6hDM4vQI1q0IFtcxcFBV9g6Usb/spnm+7P2odqmFFhvYTPf
X-Google-Smtp-Source: APXvYqwUGnz4QR3rq23u0Tb5EQnl3SZDYcLL/lu5WB5Yds4ZRRkQnmGQ90dvx2ZX/4tZ5pAZL9g3c+Y5aZeNFf1MGCfm6GE8G6Wk
MIME-Version: 1.0
X-Received: by 2002:a6b:8f01:: with SMTP id r1mr3846361iod.27.1555200969779;
 Sat, 13 Apr 2019 17:16:09 -0700 (PDT)
Date:   Sat, 13 Apr 2019 17:16:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005bb0ae05867271c1@google.com>
Subject: KMSAN: uninit-value in hci_event_packet
From:   syzbot <syzbot+4918ee47ac82d51de00d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c10a026b kmsan: use __free_pages() in kmsan_iounmap_page_r..
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=11c903a3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5675814e8eae69e
dashboard link: https://syzkaller.appspot.com/bug?extid=4918ee47ac82d51de00d
compiler:       clang version 8.0.0 (trunk 350509)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b4634d200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150657ef200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4918ee47ac82d51de00d@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KMSAN: uninit-value in hci_conn_complete_evt  
net/bluetooth/hci_event.c:2440 [inline]
BUG: KMSAN: uninit-value in hci_event_packet+0x126e8/0x35290  
net/bluetooth/hci_event.c:5781
CPU: 1 PID: 10735 Comm: kworker/u5:1 Not tainted 5.0.0+ #16
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: hci0 hci_rx_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x173/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x131/0x2a0 mm/kmsan/kmsan.c:636
  __msan_warning+0x7a/0xf0 mm/kmsan/kmsan_instr.c:310
  hci_conn_complete_evt net/bluetooth/hci_event.c:2440 [inline]
  hci_event_packet+0x126e8/0x35290 net/bluetooth/hci_event.c:5781
  hci_rx_work+0x478/0xcc0 net/bluetooth/hci_core.c:4412
  process_one_work+0x1607/0x2010 kernel/workqueue.c:2173
  worker_thread+0x111c/0x2460 kernel/workqueue.c:2319
  kthread+0x4a1/0x4e0 kernel/kthread.c:247
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:205 [inline]
  kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:159
  kmsan_kmalloc+0xa6/0x130 mm/kmsan/kmsan_hooks.c:173
  kmsan_slab_alloc+0xe/0x10 mm/kmsan/kmsan_hooks.c:182
  slab_post_alloc_hook mm/slab.h:445 [inline]
  slab_alloc_node mm/slub.c:2773 [inline]
  __kmalloc_node_track_caller+0xe9e/0xff0 mm/slub.c:4398
  __kmalloc_reserve net/core/skbuff.c:140 [inline]
  __alloc_skb+0x309/0xa20 net/core/skbuff.c:208
  alloc_skb include/linux/skbuff.h:1012 [inline]
  bt_skb_alloc include/net/bluetooth/bluetooth.h:339 [inline]
  bcsp_recv+0x1437/0x2050 drivers/bluetooth/hci_bcsp.c:685
  hci_uart_tty_receive+0x35c/0x5d0 drivers/bluetooth/hci_ldisc.c:607
  tty_ldisc_receive_buf+0x2ea/0x350 drivers/tty/tty_buffer.c:465
  tty_port_default_receive_buf+0x14f/0x1e0 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:481 [inline]
  flush_to_ldisc+0x30c/0x7f0 drivers/tty/tty_buffer.c:533
  process_one_work+0x1607/0x2010 kernel/workqueue.c:2173
  worker_thread+0x111c/0x2460 kernel/workqueue.c:2319
  kthread+0x4a1/0x4e0 kernel/kthread.c:247
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
