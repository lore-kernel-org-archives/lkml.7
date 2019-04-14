Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2A0C282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 11:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61978218FC
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 11:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfDNL0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 07:26:06 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:53850 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfDNL0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 07:26:05 -0400
Received: by mail-it1-f199.google.com with SMTP id o197so13830324ito.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 04:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aPOp2DDXqx+q1FfELvWqJfWsx62tABlYE0/X0mJuUkQ=;
        b=NUGY/cZnZ7fyWzLgwPPcTxFBDKVEJQ7As3/n8OkBfd1mqan8gu+TQWkS74hcTIBkYI
         NPnL9b/3xJcdG5eJx1uDvHPzU8thxO/Jjphbrq+qP2DanzsAYXZUBOpYn4HtjyGNY5cP
         2VlTqpDHaYPAwPq0aqei/1x9tT3bE+Y58yAjMoKZjJfLGudckIC+NV/dmoJ7TSBoCjwB
         5JqNftWDOqWPu485GHeJjf98U86w0gz9FIJ53WPBDXhLVeN1Ym52AkG++3NMP6G+q6Uj
         4kXXmXTumsr7O30vebsveye++pTm1YAqrIMLzoPq9lLyUTWP2mRw9+uF5z3OrS+SlY8Q
         eFJQ==
X-Gm-Message-State: APjAAAUtdgqbx07HNmBCg7vI8jsISlpUcwF/H4YhDprS8LuhCt+DqsDg
        CVtw2fjbr3fUemMw5zgpP9APGVcFpOg3ZglpexmdJ6+YIBHU
X-Google-Smtp-Source: APXvYqxJr6oLRQ44PoiH01HiI+kODErrLoyUPFF6mb49URZ8lJrUWP5uA8KAsNyQuLkzw1yJdIOKEVnGhIUPpkUu9q/KWRIYLm2H
MIME-Version: 1.0
X-Received: by 2002:a6b:7115:: with SMTP id q21mr1838425iog.25.1555241164844;
 Sun, 14 Apr 2019 04:26:04 -0700 (PDT)
Date:   Sun, 14 Apr 2019 04:26:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bb2b105867bcd11@google.com>
Subject: BUG: sleeping function called from invalid context at crypto/skcipher.c:LINE
From:   syzbot <syzbot+6f72c20560060c98b566@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e0a092eb Merge branch 'smc-next'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=139878f3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94c460c3e4cd188a
dashboard link: https://syzkaller.appspot.com/bug?extid=6f72c20560060c98b566
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6f72c20560060c98b566@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at crypto/skcipher.c:477
in_atomic(): 1, irqs_disabled(): 0, pid: 12, name: kworker/0:1
2 locks held by kworker/0:1/12:
  #0: 000000000864d9ff ((wq_completion)crypto){+.+.}, at: __write_once_size  
include/linux/compiler.h:220 [inline]
  #0: 000000000864d9ff ((wq_completion)crypto){+.+.}, at: arch_atomic64_set  
arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 000000000864d9ff ((wq_completion)crypto){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: 000000000864d9ff ((wq_completion)crypto){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:40 [inline]
  #0: 000000000864d9ff ((wq_completion)crypto){+.+.}, at: set_work_data  
kernel/workqueue.c:619 [inline]
  #0: 000000000864d9ff ((wq_completion)crypto){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
  #0: 000000000864d9ff ((wq_completion)crypto){+.+.}, at:  
process_one_work+0x87e/0x1790 kernel/workqueue.c:2240
  #1: 000000008b3d6218 ((work_completion)(&cpu_queue->work)){+.+.}, at:  
process_one_work+0x8b4/0x1790 kernel/workqueue.c:2244
Preemption disabled at:
[<ffffffff830d4130>] local_bh_disable include/linux/bottom_half.h:19  
[inline]
[<ffffffff830d4130>] cryptd_skcipher_complete+0x90/0x170 crypto/cryptd.c:471
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4+ #135
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: crypto cryptd_queue_worker
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  ___might_sleep.cold+0x1bd/0x1f6 kernel/sched/core.c:6190
  __might_sleep+0x95/0x190 kernel/sched/core.c:6143
  skcipher_walk_virt+0x11e/0x150 crypto/skcipher.c:477
  xor_tweak+0x146/0x350 crypto/xts.c:105
  xor_tweak_post crypto/xts.c:133 [inline]
  crypt_done+0x87/0xa0 crypto/xts.c:141
  cryptd_skcipher_complete+0xbf/0x170 crypto/cryptd.c:472
  cryptd_skcipher_decrypt+0x2f7/0x420 crypto/cryptd.c:532
  cryptd_queue_worker+0x126/0x1f0 crypto/cryptd.c:193
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
