Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8785CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 10:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EF82190F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 10:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfJTKO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 06:14:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60168 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfJTKO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 06:14:56 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iM8Eg-0007VD-AO; Sun, 20 Oct 2019 12:14:54 +0200
Date:   Sun, 20 Oct 2019 10:13:56 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/urgent for 5.4-rc4
Message-ID: <157156643658.8795.8700195163364281095.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

up to:  b1fc58333575: stop_machine: Avoid potential race behaviour

A single fix, amending stop machine with WRITE/READ_ONCE() to address the
fallout of KCSAN.

Thanks,

	tglx

------------------>
Mark Rutland (1):
      stop_machine: Avoid potential race behaviour


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


