Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D5EC5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD1420989
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfGFKDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:03:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:41874 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfGFKDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:03:02 -0400
Received: by mail-io1-f70.google.com with SMTP id x17so12514974iog.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 03:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Qm137e0H+OzKUvg8fQKGJb+KR6rd7KtPVRsyDyBLEVg=;
        b=pjojP7pDiNrYZuLbLyG/mXxA7e4/7vAArwDxFPQKjwOSHPbHC3GsuC1GEamAkWIjiU
         9ZkvTg+seufmvCmelKYgsmQ0V6ahU/xaxRHwT9NWbTZRxgkaxw/vmmXBDkXROfTdcrhK
         KbjJ0zBBF7NyJEBgiJ0E0WzkvCR2Py5F0qcBmFmctUObS6BUKQIUOA2jTf7aiFSyyh92
         mzfC3B2yhXAGW6QHidvfAGJ2vmOVMmpBdd2xwHXIpTSILH3TENXEbH2LruLqVcK4FWKM
         LRLjAKpS3jued0uSVm+C4j+865yhESvQYzlGsIANjJWpQzGNJDN9o2tFAOBr2CJt1HM8
         1hzA==
X-Gm-Message-State: APjAAAUimFqk06t6u2/1Ir6dbfz5lcs1xMGxBoqaDQ3aw3bLqE9TsVpU
        oYEhab3unKkFsUmB3vJVECtuzIFkhEFR9FKDE0ynPvi1VQr6
X-Google-Smtp-Source: APXvYqzL5e3ypX1jJXHpvuBVMxjbJV7Cu3ztlSK8YF2btdIvJK6HCHRsq6Z2osYCguuMf47C29F0oW3CnewvquZyzPhbzIbUZ0W9
MIME-Version: 1.0
X-Received: by 2002:a6b:8f93:: with SMTP id r141mr8804929iod.145.1562407380981;
 Sat, 06 Jul 2019 03:03:00 -0700 (PDT)
Date:   Sat, 06 Jul 2019 03:03:00 -0700
In-Reply-To: <CACT4Y+YjdV8CqX5=PzKsHnLsJOzsydqiq3igYDm_=nSdmFo2YQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f02455058d00503e@google.com>
Subject: Re: kernel BUG at net/rxrpc/local_object.c:LINE!
From:   syzbot <syzbot+1e0edc4b8b7494c28450@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, dvyukov@google.com,
        ebiggers@kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
kernel BUG at net/rxrpc/local_object.c:LINE!

rxrpc: Assertion failed
------------[ cut here ]------------
kernel BUG at net/rxrpc/local_object.c:468!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 10548 Comm: udevd Not tainted 5.2.0-rc7+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rxrpc_local_rcu net/rxrpc/local_object.c:468 [inline]
RIP: 0010:rxrpc_local_rcu.cold+0x11/0x13 net/rxrpc/local_object.c:462
Code: 83 eb 20 e9 74 ff ff ff e8 68 a9 2d fb eb cc 4c 89 ef e8 7e a9 2d fb  
eb e2 e8 97 f2 f4 fa 48 c7 c7 e0 8c 15 88 e8 2f f8 de fa <0f> 0b e8 84 f2  
f4 fa 48 c7 c7 e0 8c 15 88 e8 1c f8 de fa 0f 0b e8
RSP: 0018:ffff8880ae909de8 EFLAGS: 00010282
RAX: 0000000000000017 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815ad9e6 RDI: ffffed1015d213af
RBP: ffff8880ae909df8 R08: 0000000000000017 R09: ffffed1015d260a1
R10: ffffed1015d260a0 R11: ffff8880ae930507 R12: ffff888095d10940
R13: ffff888095d10940 R14: ffffffff867b9b10 R15: ffff8880ae909e78
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000000a11ba000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
  rcu_do_batch kernel/rcu/tree.c:2092 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2310 [inline]
  rcu_core+0xba5/0x1500 kernel/rcu/tree.c:2291
  __do_softirq+0x25c/0x94c kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x13b/0x550 arch/x86/kernel/apic/apic.c:1068
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:767  
[inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160  
[inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x95/0xe0  
kernel/locking/spinlock.c:191
Code: 48 c7 c0 30 76 b2 88 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c  
10 00 75 39 48 83 3d 82 18 95 01 00 74 24 48 89 df 57 9d <0f> 1f 44 00 00  
bf 01 00 00 00 e8 dc 2e 30 fa 65 8b 05 bd 9f e4 78
RSP: 0018:ffff8880a78bf728 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff1164ec6 RBX: 0000000000000286 RCX: 1ffff11011248d84
RDX: dffffc0000000000 RSI: ffff888089246c00 RDI: 0000000000000286
RBP: ffff8880a78bf738 R08: ffff888089246380 R09: ffff888089246c20
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8a758108
R13: 0000000000000286 R14: ffffffff8a758108 R15: 0000000000000000
  __debug_check_no_obj_freed lib/debugobjects.c:798 [inline]
  debug_check_no_obj_freed+0x200/0x464 lib/debugobjects.c:817
  free_pages_prepare mm/page_alloc.c:1140 [inline]
  free_pcp_prepare mm/page_alloc.c:1156 [inline]
  free_unref_page_prepare mm/page_alloc.c:2947 [inline]
  free_unref_page_list+0x1f9/0xc30 mm/page_alloc.c:3016
  release_pages+0x5df/0x1930 mm/swap.c:795
  free_pages_and_swap_cache+0x2a0/0x3d0 mm/swap_state.c:295
  tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
  tlb_flush_mmu_free mm/mmu_gather.c:184 [inline]
  tlb_flush_mmu+0x89/0x630 mm/mmu_gather.c:191
  tlb_finish_mmu+0x98/0x3b0 mm/mmu_gather.c:272
  exit_mmap+0x2cd/0x510 mm/mmap.c:3147
  __mmput kernel/fork.c:1063 [inline]
  mmput+0x15f/0x4c0 kernel/fork.c:1084
  exec_mmap fs/exec.c:1047 [inline]
  flush_old_exec+0x8c8/0x1c00 fs/exec.c:1280
  load_elf_binary+0xa53/0x56c0 fs/binfmt_elf.c:867
  search_binary_handler fs/exec.c:1658 [inline]
  search_binary_handler+0x16d/0x570 fs/exec.c:1635
  exec_binprm fs/exec.c:1701 [inline]
  __do_execve_file.isra.0+0x1310/0x22f0 fs/exec.c:1821
  do_execveat_common fs/exec.c:1868 [inline]
  do_execve fs/exec.c:1885 [inline]
  __do_sys_execve fs/exec.c:1961 [inline]
  __se_sys_execve fs/exec.c:1956 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1956
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f67dfd66207
Code: Bad RIP value.
RSP: 002b:00007fff900c3538 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f67dfd66207
RDX: 0000000000695c20 RSI: 00007fff900c3630 RDI: 00007fff900c4640
RBP: 0000000000625500 R08: 00000000000020d5 R09: 00000000000020d5
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000695c20
R13: 0000000000000007 R14: 0000000000691250 R15: 0000000000000005
Modules linked in:
---[ end trace 5b4a4001a18479d0 ]---
RIP: 0010:rxrpc_local_rcu net/rxrpc/local_object.c:468 [inline]
RIP: 0010:rxrpc_local_rcu.cold+0x11/0x13 net/rxrpc/local_object.c:462
Code: 83 eb 20 e9 74 ff ff ff e8 68 a9 2d fb eb cc 4c 89 ef e8 7e a9 2d fb  
eb e2 e8 97 f2 f4 fa 48 c7 c7 e0 8c 15 88 e8 2f f8 de fa <0f> 0b e8 84 f2  
f4 fa 48 c7 c7 e0 8c 15 88 e8 1c f8 de fa 0f 0b e8
RSP: 0018:ffff8880ae909de8 EFLAGS: 00010282
RAX: 0000000000000017 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815ad9e6 RDI: ffffed1015d213af
RBP: ffff8880ae909df8 R08: 0000000000000017 R09: ffffed1015d260a1
R10: ffffed1015d260a0 R11: ffff8880ae930507 R12: ffff888095d10940
R13: ffff888095d10940 R14: ffffffff867b9b10 R15: ffff8880ae909e78
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f67dfd661dd CR3: 00000000a11ba000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         69bf4b6b Revert "mm: page cache: store only head pages in ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146e5673a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6451f0da3d42d53
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

