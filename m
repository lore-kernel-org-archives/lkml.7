Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399BFC352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1401F2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfJGKpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:45:45 -0400
Received: from foss.arm.com ([217.140.110.172]:59606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfJGKpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:45:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38989142F;
        Mon,  7 Oct 2019 03:45:44 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 682263F706;
        Mon,  7 Oct 2019 03:45:43 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] stop_machine: avoid potential race behaviour
Date:   Mon,  7 Oct 2019 11:45:36 +0100
Message-Id: <20191007104536.27276-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both multi_cpu_stop() and set_state() access multi_stop_data::state
racily using plain accesses. These are subject to compiler
transformations which could break the intended behaviour of the code,
and this situation is detected by KCSAN on both arm64 and x86 (splats
below).

Let's improve matters by using READ_ONCE() and WRITE_ONCE() to ensure
that the compiler cannot elide, replay, or tear loads and stores. In
multi_cpu_stop() we expect the two loads of multi_stop_data::state to be
a consistent value, so we snapshot the value into a temporary variable
to ensure this.

The state transitions are serialized by atomic manipulation of
multi_stop_data::num_threads, and other fields in multi_stop_data are
not modified while subject to concurrent reads.

KCSAN splat on arm64:

| BUG: KCSAN: data-race in multi_cpu_stop+0xa8/0x198 and set_state+0x80/0xb0
|
| write to 0xffff00001003bd00 of 4 bytes by task 24 on cpu 3:
|  set_state+0x80/0xb0
|  multi_cpu_stop+0x16c/0x198
|  cpu_stopper_thread+0x170/0x298
|  smpboot_thread_fn+0x40c/0x560
|  kthread+0x1a8/0x1b0
|  ret_from_fork+0x10/0x18
|
| read to 0xffff00001003bd00 of 4 bytes by task 14 on cpu 1:
|  multi_cpu_stop+0xa8/0x198
|  cpu_stopper_thread+0x170/0x298
|  smpboot_thread_fn+0x40c/0x560
|  kthread+0x1a8/0x1b0
|  ret_from_fork+0x10/0x18
|
| Reported by Kernel Concurrency Sanitizer on:
| CPU: 1 PID: 14 Comm: migration/1 Not tainted 5.3.0-00007-g67ab35a199f4-dirty #3
| Hardware name: linux,dummy-virt (DT)

KCSAN splat on x86:

| write to 0xffffb0bac0013e18 of 4 bytes by task 19 on cpu 2:
|  set_state kernel/stop_machine.c:170 [inline]
|  ack_state kernel/stop_machine.c:177 [inline]
|  multi_cpu_stop+0x1a4/0x220 kernel/stop_machine.c:227
|  cpu_stopper_thread+0x19e/0x280 kernel/stop_machine.c:516
|  smpboot_thread_fn+0x1a8/0x300 kernel/smpboot.c:165
|  kthread+0x1b5/0x200 kernel/kthread.c:255
|  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:352
|
| read to 0xffffb0bac0013e18 of 4 bytes by task 44 on cpu 7:
|  multi_cpu_stop+0xb4/0x220 kernel/stop_machine.c:213
|  cpu_stopper_thread+0x19e/0x280 kernel/stop_machine.c:516
|  smpboot_thread_fn+0x1a8/0x300 kernel/smpboot.c:165
|  kthread+0x1b5/0x200 kernel/kthread.c:255
|  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:352
|
| Reported by Kernel Concurrency Sanitizer on:
| CPU: 7 PID: 44 Comm: migration/7 Not tainted 5.3.0+ #1
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/stop_machine.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index c7031a22aa7b..998d50ee2d9b 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2010		SUSE Linux Products GmbH
  * Copyright (C) 2010		Tejun Heo <tj@kernel.org>
  */
+#include <linux/compiler.h>
 #include <linux/completion.h>
 #include <linux/cpu.h>
 #include <linux/init.h>
@@ -167,7 +168,7 @@ static void set_state(struct multi_stop_data *msdata,
 	/* Reset ack counter. */
 	atomic_set(&msdata->thread_ack, msdata->num_threads);
 	smp_wmb();
-	msdata->state = newstate;
+	WRITE_ONCE(msdata->state, newstate);
 }
 
 /* Last one to ack a state moves to the next state. */
@@ -186,7 +187,7 @@ void __weak stop_machine_yield(const struct cpumask *cpumask)
 static int multi_cpu_stop(void *data)
 {
 	struct multi_stop_data *msdata = data;
-	enum multi_stop_state curstate = MULTI_STOP_NONE;
+	enum multi_stop_state newstate, curstate = MULTI_STOP_NONE;
 	int cpu = smp_processor_id(), err = 0;
 	const struct cpumask *cpumask;
 	unsigned long flags;
@@ -210,8 +211,9 @@ static int multi_cpu_stop(void *data)
 	do {
 		/* Chill out and ensure we re-read multi_stop_state. */
 		stop_machine_yield(cpumask);
-		if (msdata->state != curstate) {
-			curstate = msdata->state;
+		newstate = READ_ONCE(msdata->state);
+		if (newstate != curstate) {
+			curstate = newstate;
 			switch (curstate) {
 			case MULTI_STOP_DISABLE_IRQ:
 				local_irq_disable();
-- 
2.11.0

