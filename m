Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A79FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7719B20869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405639AbfJQKuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:50:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52640 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409023AbfJQKuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:50:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iL3Ls-0006Qf-0U; Thu, 17 Oct 2019 12:49:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 855321C009F;
        Thu, 17 Oct 2019 12:49:51 +0200 (CEST)
Date:   Thu, 17 Oct 2019 10:49:51 -0000
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] stop_machine: Avoid potential race behaviour
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191007104536.27276-1-mark.rutland@arm.com>
References: <20191007104536.27276-1-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <157130939131.29376.13614810360711743863.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     b1fc5833357524d5d342737913dbe32ff3557bc5
Gitweb:        https://git.kernel.org/tip/b1fc5833357524d5d342737913dbe32ff3557bc5
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 07 Oct 2019 11:45:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Oct 2019 12:47:12 +02:00

stop_machine: Avoid potential race behaviour

Both multi_cpu_stop() and set_state() access multi_stop_data::state
racily using plain accesses. These are subject to compiler
transformations which could break the intended behaviour of the code,
and this situation is detected by KCSAN on both arm64 and x86 (splats
below).

Improve matters by using READ_ONCE() and WRITE_ONCE() to ensure that the
compiler cannot elide, replay, or tear loads and stores.

In multi_cpu_stop() the two loads of multi_stop_data::state are expected to
be a consistent value, so snapshot the value into a temporary variable to
ensure this.

The state transitions are serialized by atomic manipulation of
multi_stop_data::num_threads, and other fields in multi_stop_data are not
modified while subject to concurrent reads.

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20191007104536.27276-1-mark.rutland@arm.com

---
 kernel/stop_machine.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index c7031a2..998d50e 100644
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
