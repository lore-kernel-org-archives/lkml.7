Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53882C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235612087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbfCZVvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:51:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49556 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731621AbfCZVvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:51:07 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8tyJ-00071D-5Y; Tue, 26 Mar 2019 22:51:03 +0100
Date:   Tue, 26 Mar 2019 22:51:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Don Zickus <dzickus@redhat.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH] watchdog: Respect watchdog cpumask on CPU hotplug
Message-ID: <alpine.DEB.2.21.1903262245490.1789@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rework of the watchdog core to use cpu_stop_work broke the watchdog
cpumask on CPU hotplug.

The watchdog_enable/disable() functions are now called unconditionally from
the hotplug callback, i.e. even on CPUs which are not in the watchdog
cpumask.

Only invoke them when the plugged CPU is in the watchdog cpumask.

Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 kernel/watchdog.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -547,13 +547,15 @@ static void softlockup_start_all(void)
 
 int lockup_detector_online_cpu(unsigned int cpu)
 {
-	watchdog_enable(cpu);
+	if (cpumask_test_cpu(cpu, &watchdog_allowed_mask))
+		watchdog_enable(cpu);
 	return 0;
 }
 
 int lockup_detector_offline_cpu(unsigned int cpu)
 {
-	watchdog_disable(cpu);
+	if (cpumask_test_cpu(cpu, &watchdog_allowed_mask))
+		watchdog_disable(cpu);
 	return 0;
 }
 
