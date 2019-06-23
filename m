Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0EFC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8A321530
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfFWN30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:29:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33410 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFWN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2Wu-0001j0-HB; Sun, 23 Jun 2019 15:27:36 +0200
Message-Id: <20190623132434.047254075@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:41 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 01/29] x86/hpet: Simplify CPU online code
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The indirection via work scheduled on the upcoming CPU was necessary with the
old hotplug code because the online callback was invoked on the control CPU
not on the upcoming CPU. The rework of the CPU hotplug core guarantees that
the online callbacks are invoked on the upcoming CPU.

Remove the now pointless work redirection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -547,12 +547,10 @@ static int hpet_setup_irq(struct hpet_de
 	return 0;
 }
 
-/* This should be called in specific @cpu */
 static void init_one_hpet_msi_clockevent(struct hpet_dev *hdev, int cpu)
 {
 	struct clock_event_device *evt = &hdev->evt;
 
-	WARN_ON(cpu != smp_processor_id());
 	if (!(hdev->flags & HPET_DEV_VALID))
 		return;
 
@@ -684,36 +682,12 @@ static struct hpet_dev *hpet_get_unused_
 	return NULL;
 }
 
-struct hpet_work_struct {
-	struct delayed_work work;
-	struct completion complete;
-};
-
-static void hpet_work(struct work_struct *w)
+static int hpet_cpuhp_online(unsigned int cpu)
 {
-	struct hpet_dev *hdev;
-	int cpu = smp_processor_id();
-	struct hpet_work_struct *hpet_work;
+	struct hpet_dev *hdev = hpet_get_unused_timer();
 
-	hpet_work = container_of(w, struct hpet_work_struct, work.work);
-
-	hdev = hpet_get_unused_timer();
 	if (hdev)
 		init_one_hpet_msi_clockevent(hdev, cpu);
-
-	complete(&hpet_work->complete);
-}
-
-static int hpet_cpuhp_online(unsigned int cpu)
-{
-	struct hpet_work_struct work;
-
-	INIT_DELAYED_WORK_ONSTACK(&work.work, hpet_work);
-	init_completion(&work.complete);
-	/* FIXME: add schedule_work_on() */
-	schedule_delayed_work_on(cpu, &work.work, 0);
-	wait_for_completion(&work.complete);
-	destroy_delayed_work_on_stack(&work.work);
 	return 0;
 }
 
@@ -1045,7 +1019,6 @@ static __init int hpet_late_init(void)
 	if (boot_cpu_has(X86_FEATURE_ARAT))
 		return 0;
 
-	/* This notifier should be called after workqueue is ready */
 	ret = cpuhp_setup_state(CPUHP_AP_X86_HPET_ONLINE, "x86/hpet:online",
 				hpet_cpuhp_online, NULL);
 	if (ret)


