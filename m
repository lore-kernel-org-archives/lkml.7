Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93333C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E07420869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouq1lm0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbfKFRsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:48:09 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:34155 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbfKFRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:48:08 -0500
Received: by mail-pg1-f202.google.com with SMTP id w9so18149972pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mbj5h+bjhbwX/N8Nt9chPn1ER1hCvPlyszokky0NZws=;
        b=ouq1lm0Bhb+qOg4mvoKyC0vnMOCwv8f0oW3X4wmKnGFosLPB3hFAmuU3BpyX9KYB0Q
         jQeH70LCiZLkorSvkrgah8NDW7PiqWrIjpnrjKX15N9a7qRGQMMcL295JUyDT4FYlNwx
         mJ2AqHXiYcsbHsBXntHDAmcv+ktm/5xNHULSfX4/kQL6LgueevlEilH9k1l41vtF4QMm
         I7VJ6Iz4nr44WEAlVMCU0Tjnp/2ULHDZbIxDW9tm/25DiwTdInmJKxPVmJzFFfklfKtc
         QEKNIX3JlgJ8RvQqxMEprdA7lwd9d2gj/pfBNQKQg57semsYKicbkPydPeNsy1NScCVd
         DVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mbj5h+bjhbwX/N8Nt9chPn1ER1hCvPlyszokky0NZws=;
        b=Wu2gqlM7MMEwwFirDf+S29K8r7nBs7jRjRCm6HIA3DOSbkKHyXicJ7Qt7w2kn92Gp+
         iyRNeIPbH1q+AqA+H53iik9tsKOjh69x0uJu6IHIwpm2072xYUtPG0zcPdcs35qkP2pW
         SsUcFVyd4QooFqAWovOS9m2sRkoiQTQbpqgdSd498m9GYVuJMOFqt4hQTj9ASyhwZY1K
         SnDrMpieThQBocG+qUZnkZWc1rDU+N1LqS/V7RoF32Wi6B4UGpurcg+jzNdFSk6PpcR8
         f6LHTLCRaQ/IwD4AKFhY+mDsl024FzJeJlm0tLR5+HxSyVmKkh3InvLCtY0yRl5Vp76T
         87HA==
X-Gm-Message-State: APjAAAVAy0XUsePEkR95Mk0xMWqNzwek/OXZNm9O/vtOvVAEhWFGA4XY
        WRSR897I2XYMbvPkT/6xifr2pEyX8hEmSw==
X-Google-Smtp-Source: APXvYqznlPpHM+eV25sT9XU6eEjgtR+9bHQKg7gujPpXDw06IcWvKUBiCFVn1KBzkSsyhHvJT0YA1RXbXHYgaA==
X-Received: by 2002:a63:e255:: with SMTP id y21mr4219775pgj.353.1573062487628;
 Wed, 06 Nov 2019 09:48:07 -0800 (PST)
Date:   Wed,  6 Nov 2019 09:48:04 -0800
Message-Id: <20191106174804.74723-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH] hrtimer: Annotate lockless access to timer->state
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

syzbot reported various data-race caused by hrtimer_is_queued()
reading timer->state. We need a READ_ONCE() there to silence
the warning.

Also add the corresponding WRITE_ONCE() when timer->state is set.

I chose to not use hrtimer_is_queued() helper in remove_hrtimer()
to avoid loading timer->state twice.

KCSAN reported these cases :

BUG: KCSAN: data-race in __remove_hrtimer / tcp_pacing_check

write to 0xffff8880b2a7d388 of 1 bytes by interrupt on cpu 0:
 __remove_hrtimer+0x52/0x130 kernel/time/hrtimer.c:991
 __run_hrtimer kernel/time/hrtimer.c:1496 [inline]
 __hrtimer_run_queues+0x250/0x600 kernel/time/hrtimer.c:1576
 hrtimer_run_softirq+0x10e/0x150 kernel/time/hrtimer.c:1593
 __do_softirq+0x115/0x33f kernel/softirq.c:292
 run_ksoftirqd+0x46/0x60 kernel/softirq.c:603
 smpboot_thread_fn+0x37d/0x4a0 kernel/smpboot.c:165
 kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352

read to 0xffff8880b2a7d388 of 1 bytes by task 24652 on cpu 1:
 tcp_pacing_check net/ipv4/tcp_output.c:2235 [inline]
 tcp_pacing_check+0xba/0x130 net/ipv4/tcp_output.c:2225
 tcp_xmit_retransmit_queue+0x32c/0x5a0 net/ipv4/tcp_output.c:3044
 tcp_xmit_recovery+0x7c/0x120 net/ipv4/tcp_input.c:3558
 tcp_ack+0x17b6/0x3170 net/ipv4/tcp_input.c:3717
 tcp_rcv_established+0x37e/0xf50 net/ipv4/tcp_input.c:5696
 tcp_v4_do_rcv+0x381/0x4e0 net/ipv4/tcp_ipv4.c:1561
 sk_backlog_rcv include/net/sock.h:945 [inline]
 __release_sock+0x135/0x1e0 net/core/sock.c:2435
 release_sock+0x61/0x160 net/core/sock.c:2951
 sk_stream_wait_memory+0x3d7/0x7c0 net/core/stream.c:145
 tcp_sendmsg_locked+0xb47/0x1f30 net/ipv4/tcp.c:1393
 tcp_sendmsg+0x39/0x60 net/ipv4/tcp.c:1434
 inet_sendmsg+0x6d/0x90 net/ipv4/af_inet.c:807
 sock_sendmsg_nosec net/socket.c:637 [inline]
 sock_sendmsg+0x9f/0xc0 net/socket.c:657

BUG: KCSAN: data-race in __remove_hrtimer / __tcp_ack_snd_check

write to 0xffff8880a3a65588 of 1 bytes by interrupt on cpu 0:
 __remove_hrtimer+0x52/0x130 kernel/time/hrtimer.c:991
 __run_hrtimer kernel/time/hrtimer.c:1496 [inline]
 __hrtimer_run_queues+0x250/0x600 kernel/time/hrtimer.c:1576
 hrtimer_run_softirq+0x10e/0x150 kernel/time/hrtimer.c:1593
 __do_softirq+0x115/0x33f kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0xbb/0xe0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:536 [inline]
 smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830

read to 0xffff8880a3a65588 of 1 bytes by task 22891 on cpu 1:
 __tcp_ack_snd_check+0x415/0x4f0 net/ipv4/tcp_input.c:5265
 tcp_ack_snd_check net/ipv4/tcp_input.c:5287 [inline]
 tcp_rcv_established+0x750/0xf50 net/ipv4/tcp_input.c:5708
 tcp_v4_do_rcv+0x381/0x4e0 net/ipv4/tcp_ipv4.c:1561
 sk_backlog_rcv include/net/sock.h:945 [inline]
 __release_sock+0x135/0x1e0 net/core/sock.c:2435
 release_sock+0x61/0x160 net/core/sock.c:2951
 sk_stream_wait_memory+0x3d7/0x7c0 net/core/stream.c:145
 tcp_sendmsg_locked+0xb47/0x1f30 net/ipv4/tcp.c:1393
 tcp_sendmsg+0x39/0x60 net/ipv4/tcp.c:1434
 inet_sendmsg+0x6d/0x90 net/ipv4/af_inet.c:807
 sock_sendmsg_nosec net/socket.c:637 [inline]
 sock_sendmsg+0x9f/0xc0 net/socket.c:657
 __sys_sendto+0x21f/0x320 net/socket.c:1952
 __do_sys_sendto net/socket.c:1964 [inline]
 __se_sys_sendto net/socket.c:1960 [inline]
 __x64_sys_sendto+0x89/0xb0 net/socket.c:1960
 do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 24652 Comm: syz-executor.3 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: syzbot <syzkaller@googlegroups.com>
---
 include/linux/hrtimer.h | 2 +-
 kernel/time/hrtimer.c   | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 1b9a51a1bccb78d4ef2a4019cfd547d0d1652b79..d55ec621221d2cbf48823445cc9cf2d7f6988f0c 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -461,7 +461,7 @@ extern bool hrtimer_active(const struct hrtimer *timer);
  */
 static inline int hrtimer_is_queued(struct hrtimer *timer)
 {
-	return timer->state & HRTIMER_STATE_ENQUEUED;
+	return READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED;
 }
 
 /*
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 65605530ee349c9682690c4fccb43aa9284d4287..a1cb0a959be32068025b625240cc1499b6416b63 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -966,7 +966,7 @@ static int enqueue_hrtimer(struct hrtimer *timer,
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
-	timer->state = HRTIMER_STATE_ENQUEUED;
+	WRITE_ONCE(timer->state, HRTIMER_STATE_ENQUEUED);
 
 	return timerqueue_add(&base->active, &timer->node);
 }
@@ -988,7 +988,7 @@ static void __remove_hrtimer(struct hrtimer *timer,
 	struct hrtimer_cpu_base *cpu_base = base->cpu_base;
 	u8 state = timer->state;
 
-	timer->state = newstate;
+	WRITE_ONCE(timer->state, newstate);
 	if (!(state & HRTIMER_STATE_ENQUEUED))
 		return;
 
@@ -1013,8 +1013,9 @@ static void __remove_hrtimer(struct hrtimer *timer,
 static inline int
 remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base, bool restart)
 {
-	if (hrtimer_is_queued(timer)) {
-		u8 state = timer->state;
+	u8 state = timer->state;
+
+	if (state & HRTIMER_STATE_ENQUEUED) {
 		int reprogram;
 
 		/*
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

