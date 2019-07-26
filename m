Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BFFC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938E6229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfGZJiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:38:21 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:52170 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfGZJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:38:07 -0400
Received: by mail-io1-f69.google.com with SMTP id c5so57709028iom.18
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 02:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=39Iz35mRNdj8tP+TDSA6C43v5ggwJ6FzRe1kzAV801U=;
        b=O1d9yky6CPT9oLw96OBanCxOM+zDAQwNlVw5JS6FbfVJXdANsVhyLce9vt+gR4mKD4
         3Tq8kfEhcFGM0zp44GU0wd7qZ6pLV8CyKl+bdyrUrCP0MUUQCYLm1bKoaLzawnY3szWQ
         w74uVlTH7mWVpAUT0wlM1XPRRCcTD538wzWw4ZLuG31bx3OqmCW5q/Z4hrd9Pf0LlmCU
         tktwrvLrhX655MlX/GzfdOK4V1snjhQfjnyfwtG46MtNWSt0HEeAm2ZUSaCJOAIK4MSK
         NK3i/r8PDty9gHYWUoWfUmYfDlNoPzqsGc642JtmivYUtOzE3tNcupbgG7cADAdJ5eHi
         oTSg==
X-Gm-Message-State: APjAAAUMFlvAou/qY9oAi0KNW5XLlkoLkrItObTyMLjet2/SJ/Hx7btw
        6OVGfyXZTfVa4CUMT0AkZKCjb3V/bqBySWVf23rK9AHG6gyZ
X-Google-Smtp-Source: APXvYqzQJnx5eS2Vg9aK9+kDrfFLZyTj0vfiOhdx/mgX5Rjd5uWJ1AfEt+x3TtstMmR5dFEfceDNOjAwrN6Rxc/S7t6s5gGZIklH
MIME-Version: 1.0
X-Received: by 2002:a5d:9b1a:: with SMTP id y26mr21679500ion.238.1564133887025;
 Fri, 26 Jul 2019 02:38:07 -0700 (PDT)
Date:   Fri, 26 Jul 2019 02:38:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7abcc058e924c12@google.com>
Subject: possible deadlock in rxrpc_put_peer
From:   syzbot <syzbot+72af434e4b3417318f84@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6d21a41b Add linux-next specific files for 20190718
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=174e3af0600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
dashboard link: https://syzkaller.appspot.com/bug?extid=72af434e4b3417318f84
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+72af434e4b3417318f84@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.2.0-next-20190718 #41 Not tainted
--------------------------------------------
kworker/0:3/21678 is trying to acquire lock:
00000000aa5eecdf (&(&rxnet->peer_hash_lock)->rlock){+.-.}, at: spin_lock_bh  
/./include/linux/spinlock.h:343 [inline]
00000000aa5eecdf (&(&rxnet->peer_hash_lock)->rlock){+.-.}, at:  
__rxrpc_put_peer /net/rxrpc/peer_object.c:415 [inline]
00000000aa5eecdf (&(&rxnet->peer_hash_lock)->rlock){+.-.}, at:  
rxrpc_put_peer+0x2d3/0x6a0 /net/rxrpc/peer_object.c:435

but task is already holding lock:
00000000aa5eecdf (&(&rxnet->peer_hash_lock)->rlock){+.-.}, at: spin_lock_bh  
/./include/linux/spinlock.h:343 [inline]
00000000aa5eecdf (&(&rxnet->peer_hash_lock)->rlock){+.-.}, at:  
rxrpc_peer_keepalive_dispatch /net/rxrpc/peer_event.c:378 [inline]
00000000aa5eecdf (&(&rxnet->peer_hash_lock)->rlock){+.-.}, at:  
rxrpc_peer_keepalive_worker+0x6b3/0xd02 /net/rxrpc/peer_event.c:430

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&(&rxnet->peer_hash_lock)->rlock);
   lock(&(&rxnet->peer_hash_lock)->rlock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

3 locks held by kworker/0:3/21678:
  #0: 000000007c4c2bc3 ((wq_completion)krxrpcd){+.+.}, at: __write_once_size  
/./include/linux/compiler.h:226 [inline]
  #0: 000000007c4c2bc3 ((wq_completion)krxrpcd){+.+.}, at: arch_atomic64_set  
/./arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 000000007c4c2bc3 ((wq_completion)krxrpcd){+.+.}, at: atomic64_set  
/./include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 000000007c4c2bc3 ((wq_completion)krxrpcd){+.+.}, at: atomic_long_set  
/./include/asm-generic/atomic-long.h:40 [inline]
  #0: 000000007c4c2bc3 ((wq_completion)krxrpcd){+.+.}, at: set_work_data  
/kernel/workqueue.c:620 [inline]
  #0: 000000007c4c2bc3 ((wq_completion)krxrpcd){+.+.}, at:  
set_work_pool_and_clear_pending /kernel/workqueue.c:647 [inline]
  #0: 000000007c4c2bc3 ((wq_completion)krxrpcd){+.+.}, at:  
process_one_work+0x88b/0x1740 /kernel/workqueue.c:2240
  #1: 000000006782bc7f  
((work_completion)(&rxnet->peer_keepalive_work)){+.+.}, at:  
process_one_work+0x8c1/0x1740 /kernel/workqueue.c:2244
  #2: 00000000aa5eecdf (&(&rxnet->peer_hash_lock)->rlock){+.-.}, at:  
spin_lock_bh /./include/linux/spinlock.h:343 [inline]
  #2: 00000000aa5eecdf (&(&rxnet->peer_hash_lock)->rlock){+.-.}, at:  
rxrpc_peer_keepalive_dispatch /net/rxrpc/peer_event.c:378 [inline]
  #2: 00000000aa5eecdf (&(&rxnet->peer_hash_lock)->rlock){+.-.}, at:  
rxrpc_peer_keepalive_worker+0x6b3/0xd02 /net/rxrpc/peer_event.c:430

stack backtrace:
CPU: 0 PID: 21678 Comm: kworker/0:3 Not tainted 5.2.0-next-20190718 #41
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: krxrpcd rxrpc_peer_keepalive_worker
Call Trace:
  __dump_stack /lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 /lib/dump_stack.c:113
  print_deadlock_bug /kernel/locking/lockdep.c:2301 [inline]
  check_deadlock /kernel/locking/lockdep.c:2342 [inline]
  validate_chain /kernel/locking/lockdep.c:2881 [inline]
  __lock_acquire.cold+0x194/0x398 /kernel/locking/lockdep.c:3880
  lock_acquire+0x190/0x410 /kernel/locking/lockdep.c:4413
  __raw_spin_lock_bh /./include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x33/0x50 /kernel/locking/spinlock.c:175
  spin_lock_bh /./include/linux/spinlock.h:343 [inline]
  __rxrpc_put_peer /net/rxrpc/peer_object.c:415 [inline]
  rxrpc_put_peer+0x2d3/0x6a0 /net/rxrpc/peer_object.c:435
  rxrpc_peer_keepalive_dispatch /net/rxrpc/peer_event.c:381 [inline]
  rxrpc_peer_keepalive_worker+0x7a6/0xd02 /net/rxrpc/peer_event.c:430
  process_one_work+0x9af/0x1740 /kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 /kernel/workqueue.c:2415
  kthread+0x361/0x430 /kernel/kthread.c:255
  ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
