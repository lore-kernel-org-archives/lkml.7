Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4545EC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA0A206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfKHREQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:04:16 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:34902 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfKHREN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:04:13 -0500
Received: by mail-il1-f199.google.com with SMTP id w69so7552042ilk.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 09:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Qf6/971redFg5+hNvL72Agdhn9HP6mUxpqJ1caev7c4=;
        b=Zli6K4OryqPrKMJZEcJGjJvtZ0DA9RjtwbHx+64ZY3D/ZokeykvmchmSNmrlTAeDaZ
         2hMDJ3819RmOOQpoB0Iuuz/gZJ1JTj71oQyWCNpOHIuZExvt17m3PsIGRHlt9M+F6kir
         y28YeajBk4ABdAJ6zm820D/mX7pWEL8QOlClBKwfgwxx19pIcztuFudYtk9XhCmB+B9Y
         x1g3YllpaGqO1KC+A48kPJYe+frNMViMhmOQWbEbqVinuVZZNg8DP0xvqNcRkV1wm4pO
         m/ZpAuRtsjrGhc9BThjBnLnLRfd/CyGNCFgsyBdea1/spOm4m2mLwif1PZrcMgkQD9Jt
         Vx2g==
X-Gm-Message-State: APjAAAU98qd1tk6tue9InDjipfTeewNgD6GjtuH0hRQ3FjlJ1dMHinEx
        fOCRZAuEBWYokNY7Reck7jFeqPbr7m5fBlddMxcofhttt2Jj
X-Google-Smtp-Source: APXvYqyQmUieY6KPbHUN5J96vU2WE/TqY+EHvMAdv6Rn77xwW31IsVLTeBCAUL6lDnbae9trKVf56uhf2kJ3gOe5Gj5kN6pHTyGF
MIME-Version: 1.0
X-Received: by 2002:a6b:6512:: with SMTP id z18mr10894907iob.282.1573232651747;
 Fri, 08 Nov 2019 09:04:11 -0800 (PST)
Date:   Fri, 08 Nov 2019 09:04:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b4a6c0596d8c5a8@google.com>
Subject: KMSAN: use-after-free in rxrpc_send_keepalive
From:   syzbot <syzbot+2e7168a4d3c4ec071fdc@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, glider@google.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c38191cb kmsan: fixed unaligned origin handling in kmsan_m..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10c518e3600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49548798e87d32d7
dashboard link: https://syzkaller.appspot.com/bug?extid=2e7168a4d3c4ec071fdc
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c4fec7600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e7168a4d3c4ec071fdc@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: use-after-free in rxrpc_peer_keepalive_dispatch  
net/rxrpc/peer_event.c:369 [inline]
BUG: KMSAN: use-after-free in rxrpc_peer_keepalive_worker+0xb82/0x1510  
net/rxrpc/peer_event.c:430
CPU: 1 PID: 3995 Comm: kworker/1:2 Not tainted 5.4.0-rc2+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: krxrpcd rxrpc_peer_keepalive_worker
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x153/0x2c0 mm/kmsan/kmsan_report.c:113
  __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:250
  rxrpc_send_keepalive+0x53c/0x830 net/rxrpc/output.c:634
  rxrpc_peer_keepalive_dispatch net/rxrpc/peer_event.c:369 [inline]
  rxrpc_peer_keepalive_worker+0xb82/0x1510 net/rxrpc/peer_event.c:430
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:154 [inline]
  kmsan_internal_poison_shadow+0x60/0x120 mm/kmsan/kmsan.c:137
  kmsan_slab_free+0x8d/0x100 mm/kmsan/kmsan_hooks.c:123
  slab_free_freelist_hook mm/slub.c:1473 [inline]
  slab_free mm/slub.c:3040 [inline]
  kfree+0x4c1/0x2db0 mm/slub.c:3982
  rxrpc_local_rcu+0x7a/0xe0 net/rxrpc/local_object.c:499
  __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
  rcu_do_batch kernel/rcu/tree.c:2157 [inline]
  rcu_core+0xc99/0x1b10 kernel/rcu/tree.c:2377
  rcu_core_si+0xe/0x10 kernel/rcu/tree.c:2386
  __do_softirq+0x4a1/0x83a kernel/softirq.c:293
  invoke_softirq kernel/softirq.c:375 [inline]
  irq_exit+0x230/0x280 kernel/softirq.c:416
  exiting_irq+0xe/0x10 arch/x86/include/asm/apic.h:536
  smp_apic_timer_interrupt+0x48/0x70 arch/x86/kernel/apic/apic.c:1139
  apic_timer_interrupt+0x2e/0x40 arch/x86/entry/entry_64.S:837
  native_restore_fl arch/x86/include/asm/irqflags.h:41 [inline]
  arch_local_irq_restore arch/x86/include/asm/irqflags.h:84 [inline]
  kmsan_slab_free+0xac/0x100 mm/kmsan/kmsan_hooks.c:127
  slab_free_freelist_hook mm/slub.c:1473 [inline]
  slab_free mm/slub.c:3040 [inline]
  kmem_cache_free+0x2d1/0x2b70 mm/slub.c:3056
  anon_vma_chain_free mm/rmap.c:134 [inline]
  unlink_anon_vmas+0x3c1/0xb70 mm/rmap.c:401
  free_pgtables+0x2e2/0x6a0 mm/memory.c:396
  exit_mmap+0x53f/0xa00 mm/mmap.c:3162
  __mmput+0x148/0x590 kernel/fork.c:1081
  mmput+0x83/0x90 kernel/fork.c:1102
  exec_mmap fs/exec.c:1048 [inline]
  flush_old_exec+0xfaf/0x2180 fs/exec.c:1281
  load_elf_binary+0x1121/0x5f10 fs/binfmt_elf.c:847
  search_binary_handler+0x2f4/0xac0 fs/exec.c:1659
  exec_binprm fs/exec.c:1702 [inline]
  __do_execve_file+0x2218/0x2e90 fs/exec.c:1822
  do_execveat_common fs/exec.c:1868 [inline]
  do_execve fs/exec.c:1885 [inline]
  __do_sys_execve fs/exec.c:1961 [inline]
  __se_sys_execve+0xec/0x110 fs/exec.c:1956
  __x64_sys_execve+0x4a/0x70 fs/exec.c:1956
  do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
