Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE73C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81722084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfDNQsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:48:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:41336 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfDNQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:48:06 -0400
Received: by mail-io1-f70.google.com with SMTP id e126so12202064ioa.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 09:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gp7DxYFgEXvtYebLYvfri0HqBz4so8qAizsohbVZgwg=;
        b=YJ9UhXAOdKdYkuY7xt28n4E2ruYO7bUb3VoCLBZPNYn4QlGA2L5uMWC4TLRsge2OKr
         ISwo9mS4Yntxvzq9cF+0D60JkQiRrw5JotpsJk8z1UF7+ON0fxhnj/hEy9HBxlwWkmRp
         li1AZiorYjpB6Hl1QXHyfSs21K+73uyRPXx0ck7zmy7FflCr/RLyJEmEDzJb0ZWVVWhZ
         StK+USvYT/1W2jkEPTBWqVedW52m1RnAiofhhVAQsDlxPeYr6cyS05gS7cRVXroIwlo5
         TXP14Ys67wLgocFr1ZkbaX9KUaT7FBfz5qid6mtkUzeZ63xmdDe5gAzKfZJ6IPfFmlaB
         UVtw==
X-Gm-Message-State: APjAAAUArakmIoqCLqXdm5d7dy+M2qoQ4qJrkLgo8I1BZzzkSYv6KyNy
        1gpxrVTCUKBxIlBUD7J4GcPizbn2ax6O/4Mm5J4GxuDxcRjn
X-Google-Smtp-Source: APXvYqxkYbDR0IEYusgdi0OvnOasMZZvTZfiC29P2wKCT6/pJv6ZEJ6cFsNlaIIGb4O31CG/2mUwrx1e9M/3Ll5/KvGKwaf5rPiR
MIME-Version: 1.0
X-Received: by 2002:a24:5c12:: with SMTP id q18mr5564898itb.13.1555260485816;
 Sun, 14 Apr 2019 09:48:05 -0700 (PDT)
Date:   Sun, 14 Apr 2019 09:48:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca5ede0586804c42@google.com>
Subject: BUG: corrupted list in hsr_prune_nodes
From:   syzbot <syzbot+99ad9e40137a83c70ee3@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c342dc10 bpf: refactor "check_reg_arg" to eliminate code r..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10a8a2f3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94c460c3e4cd188a
dashboard link: https://syzkaller.appspot.com/bug?extid=99ad9e40137a83c70ee3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+99ad9e40137a83c70ee3@syzkaller.appspotmail.com

list_del corruption. next->prev should be ffff88809b45c240, but was  
ffff8880a0202900
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:54!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 13874 Comm: syz-executor.0 Not tainted 5.1.0-rc4+ #85
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_del_entry_valid.cold+0x48/0x4f lib/list_debug.c:54
Code: e8 00 cf 28 fe 0f 0b 4c 89 e2 4c 89 f6 48 c7 c7 00 a1 a1 87 e8 ec ce  
28 fe 0f 0b 4c 89 f6 48 c7 c7 c0 a1 a1 87 e8 db ce 28 fe <0f> 0b 90 90 90  
90 90 55 48 89 e5 41 54 53 48 89 fb 48 c7 c7 60 98
RSP: 0018:ffff8880ae807c80 EFLAGS: 00010286
RAX: 0000000000000054 RBX: ffffffffffffffd0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815affc6 RDI: ffffed1015d00f82
RBP: ffff8880ae807c98 R08: 0000000000000054 R09: ffffed1015d05011
R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffff88806f59b260
R13: ffff88806f59b260 R14: ffff88809b45c240 R15: 0000000000000000
FS:  00007fa430e01700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30724000 CR3: 0000000060d3e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  <IRQ>
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_rcu include/linux/rculist.h:130 [inline]
  hsr_prune_nodes+0x399/0x9d0 net/hsr/hsr_framereg.c:402
  call_timer_fn+0x190/0x720 kernel/time/timer.c:1325
  expire_timers kernel/time/timer.c:1362 [inline]
  __run_timers kernel/time/timer.c:1681 [inline]
  __run_timers kernel/time/timer.c:1649 [inline]
  run_timer_softirq+0x652/0x1700 kernel/time/timer.c:1694
  __do_softirq+0x266/0x95a kernel/softirq.c:293
  invoke_softirq kernel/softirq.c:374 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:414
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x14a/0x570 arch/x86/kernel/apic/apic.c:1062
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:list_lru_count_one+0x2e/0x380 mm/list_lru.c:189
Code: 41 56 41 55 49 89 fd 41 54 49 89 d4 53 48 63 de e8 d7 97 d6 ff 4c 89  
ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 <0f> 85 27 03 00  
00 48 c1 e3 07 49 03 5d 00 e8 1f 44 c4 ff e8 aa 97
RSP: 0018:ffff888097d178c0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90005df3000
RDX: 1ffff1101316ba41 RSI: ffffffff8199f729 RDI: ffff888098b5d208
RBP: ffff888097d178e0 R08: ffff8880a9366480 R09: 0000000000000002
R10: ffffed1015d05bbf R11: ffff8880ae82ddfb R12: ffff88806fc38380
R13: ffff888098b5d208 R14: ffff888097d17a20 R15: ffff888097d17a24
  list_lru_shrink_count include/linux/list_lru.h:122 [inline]
  super_cache_count+0x1a8/0x2e0 fs/super.c:147
  do_shrink_slab+0x10e/0xa80 mm/vmscan.c:469
  shrink_slab_memcg mm/vmscan.c:616 [inline]
  shrink_slab+0x36a/0x5e0 mm/vmscan.c:688
  shrink_node+0x552/0x1570 mm/vmscan.c:2724
  shrink_zones mm/vmscan.c:2953 [inline]
  do_try_to_free_pages+0x3cb/0x11e0 mm/vmscan.c:3015
  try_to_free_mem_cgroup_pages+0x2dd/0xa30 mm/vmscan.c:3319
  reclaim_high.constprop.0+0xb3/0x100 mm/memcontrol.c:2152
  mem_cgroup_handle_over_high+0x8e/0x130 mm/memcontrol.c:2177
  tracehook_notify_resume include/linux/tracehook.h:190 [inline]
  exit_to_usermode_loop+0x1ee/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa430e00c78 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: 0000000000000003 RBX: 0000000000000005 RCX: 0000000000458c29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 00007fa430e016d4
R13: 00000000004c54b5 R14: 00000000004d9698 R15: 00000000ffffffff
Modules linked in:
---[ end trace e4b315486d1a6405 ]---
RIP: 0010:__list_del_entry_valid.cold+0x48/0x4f lib/list_debug.c:54
Code: e8 00 cf 28 fe 0f 0b 4c 89 e2 4c 89 f6 48 c7 c7 00 a1 a1 87 e8 ec ce  
28 fe 0f 0b 4c 89 f6 48 c7 c7 c0 a1 a1 87 e8 db ce 28 fe <0f> 0b 90 90 90  
90 90 55 48 89 e5 41 54 53 48 89 fb 48 c7 c7 60 98
RSP: 0018:ffff8880ae807c80 EFLAGS: 00010286
RAX: 0000000000000054 RBX: ffffffffffffffd0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815affc6 RDI: ffffed1015d00f82
RBP: ffff8880ae807c98 R08: 0000000000000054 R09: ffffed1015d05011
R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffff88806f59b260
R13: ffff88806f59b260 R14: ffff88809b45c240 R15: 0000000000000000
FS:  00007fa430e01700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30724000 CR3: 0000000060d3e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
