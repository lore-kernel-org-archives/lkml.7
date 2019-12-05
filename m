Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF79C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92EC2073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfu2s4eC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfLEE4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 23:56:24 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:34283 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfLEE4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 23:56:24 -0500
Received: by mail-pg1-f202.google.com with SMTP id w9so1134634pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 20:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UGw+elk+Q46fH6zXXZMT2OXr0euljB48U9bBxyx3aus=;
        b=gfu2s4eCN7BS3urrPU2aXVhzGbhqdTghf4zTXfanfnPJR6n1TBpXTu/d8HOu0BYh+i
         f1n9hgU5+hFzaHN4lQOl7PddlzKgGAN7pMxAfLkympEk8rJ4ONzktqOyhEINFvZgVxj9
         TR1WoRjnK//p9E0AHtVHnOroNAM6YX8LUWhk1ABeglXOxYYIReRlBOZQoZQFo9VdGuoq
         dfOM5qNBL4SefKjhCumg1qiePTNLmFjZ8295riHQZ+eNki75cmjatTexBNR/qk9DokOM
         a6fU9tE5H+xHG/XXvCaJLDaKoRimdGJbX0HDc8cvp8tsq5d2ibWBHYdKxfulCEVp+HKj
         gSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UGw+elk+Q46fH6zXXZMT2OXr0euljB48U9bBxyx3aus=;
        b=VKuzUESRJrcHGODcwUVVuTFRP6Hmfvop5fiFl+vy1WYXkt8PCqv34Wo/Vj9B9cvwG6
         3YWeDz7SHBYbyrYHThkeqQcx/NOA6lnqy/CxcGUaRgsd2ROT2Zb0DX+PcaqB5cR1adGi
         yn91jQEZ24Z4np8SA788s9cW1/jdIGh9jACMZECFdsvF2j++5nil/Q/PPe6hx6CUXdqQ
         4DgK34Z7xYU82EXh5xD7o85b9mVGaETiijHACg1yqm4RqzdF+mFkrChkJdzl4aOUAp1H
         XzRt7Cxs4dhMPFq0sQ5cmV42k7aIWPqDWqOMr976uvVTQEqI7fFtLEi+zkAppadD40K1
         nQCg==
X-Gm-Message-State: APjAAAWI3sTwRhSoJVIZ9+lZ2zPO2UI11+ng7HqSPv0Am7T3adiXDb3y
        VkG6dRwJ3TU4Q2/glJmSFyklqrtIah4crw==
X-Google-Smtp-Source: APXvYqwhWoUvaZceiyIVIAuL9tg0344t4RWmxDFsB2B2+mJyk2VZ1JxVbDzkbU6IEHBLlJOUs8nilMZy1JmSZA==
X-Received: by 2002:a63:f60:: with SMTP id 32mr2149198pgp.206.1575521782759;
 Wed, 04 Dec 2019 20:56:22 -0800 (PST)
Date:   Wed,  4 Dec 2019 20:56:19 -0800
Message-Id: <20191205045619.204946-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH] time: tick-sched: Annotate lockless access to last_jiffies_update
From:   Eric Dumazet <edumazet@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot (KCSAN) reported a data-race in tick_do_update_jiffies64() [1]

Use READ_ONCE() and WRITE_ONCE() to annotate this expected race.

[1]

BUG: KCSAN: data-race in tick_do_update_jiffies64 / tick_do_update_jiffies64

write to 0xffffffff8603d008 of 8 bytes by interrupt on cpu 1:
 tick_do_update_jiffies64+0x100/0x250 kernel/time/tick-sched.c:73
 tick_sched_do_timer+0xd4/0xe0 kernel/time/tick-sched.c:138
 tick_sched_timer+0x43/0xe0 kernel/time/tick-sched.c:1292
 __run_hrtimer kernel/time/hrtimer.c:1514 [inline]
 __hrtimer_run_queues+0x274/0x5f0 kernel/time/hrtimer.c:1576
 hrtimer_interrupt+0x22a/0x480 kernel/time/hrtimer.c:1638
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
 smp_apic_timer_interrupt+0xdc/0x280 arch/x86/kernel/apic/apic.c:1135
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
 arch_local_irq_restore arch/x86/include/asm/paravirt.h:756 [inline]
 kcsan_setup_watchpoint+0x1d4/0x460 kernel/kcsan/core.c:436
 check_access kernel/kcsan/core.c:466 [inline]
 __tsan_read1 kernel/kcsan/core.c:593 [inline]
 __tsan_read1+0xc2/0x100 kernel/kcsan/core.c:593
 kallsyms_expand_symbol.constprop.0+0x70/0x160 kernel/kallsyms.c:79
 kallsyms_lookup_name+0x7f/0x120 kernel/kallsyms.c:170
 insert_report_filterlist kernel/kcsan/debugfs.c:155 [inline]
 debugfs_write+0x14b/0x2d0 kernel/kcsan/debugfs.c:256
 full_proxy_write+0xbd/0x100 fs/debugfs/file.c:225
 __vfs_write+0x67/0xc0 fs/read_write.c:494
 vfs_write fs/read_write.c:558 [inline]
 vfs_write+0x18a/0x390 fs/read_write.c:542
 ksys_write+0xd5/0x1b0 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x4c/0x60 fs/read_write.c:620
 do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffffffff8603d008 of 8 bytes by task 0 on cpu 0:
 tick_do_update_jiffies64+0x2b/0x250 kernel/time/tick-sched.c:62
 tick_nohz_update_jiffies kernel/time/tick-sched.c:505 [inline]
 tick_nohz_irq_enter kernel/time/tick-sched.c:1257 [inline]
 tick_irq_enter+0x139/0x1c0 kernel/time/tick-sched.c:1274
 irq_enter+0x4f/0x60 kernel/softirq.c:354
 entering_irq arch/x86/include/asm/apic.h:517 [inline]
 entering_ack_irq arch/x86/include/asm/apic.h:523 [inline]
 smp_apic_timer_interrupt+0x55/0x280 arch/x86/kernel/apic/apic.c:1133
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
 native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:60
 arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:571
 default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
 cpuidle_idle_call kernel/sched/idle.c:154 [inline]
 do_idle+0x1af/0x280 kernel/sched/idle.c:263
 cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
 rest_init+0xec/0xf6 init/main.c:452
 arch_call_rest_init+0x17/0x37
 start_kernel+0x838/0x85e init/main.c:786
 x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:490
 x86_64_start_kernel+0x72/0x76 arch/x86/kernel/head64.c:471
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
---
 kernel/time/tick-sched.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8b192e67aabc9d16d8a7b08c0356641b5462c783..a792d21cac645c63468f605207c0c5fd7b356242 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -58,8 +58,9 @@ static void tick_do_update_jiffies64(ktime_t now)
 
 	/*
 	 * Do a quick check without holding jiffies_lock:
+	 * The READ_ONCE() pairs with two updates done later in this function.
 	 */
-	delta = ktime_sub(now, last_jiffies_update);
+	delta = ktime_sub(now, READ_ONCE(last_jiffies_update));
 	if (delta < tick_period)
 		return;
 
@@ -70,8 +71,9 @@ static void tick_do_update_jiffies64(ktime_t now)
 	if (delta >= tick_period) {
 
 		delta = ktime_sub(delta, tick_period);
-		last_jiffies_update = ktime_add(last_jiffies_update,
-						tick_period);
+		/* Pairs with the lockless read in this function. */
+		WRITE_ONCE(last_jiffies_update,
+			   ktime_add(last_jiffies_update, tick_period));
 
 		/* Slow path for long timeouts */
 		if (unlikely(delta >= tick_period)) {
@@ -79,8 +81,10 @@ static void tick_do_update_jiffies64(ktime_t now)
 
 			ticks = ktime_divns(delta, incr);
 
-			last_jiffies_update = ktime_add_ns(last_jiffies_update,
-							   incr * ticks);
+			/* Pairs with the lockless read in this function. */
+			WRITE_ONCE(last_jiffies_update,
+				   ktime_add_ns(last_jiffies_update,
+						incr * ticks));
 		}
 		do_timer(++ticks);
 
-- 
2.24.0.393.g34dc348eaf-goog

