Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BEBC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BC620679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfFWN2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:28:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33588 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfFWN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:55 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2XB-0001nC-Dw; Sun, 23 Jun 2019 15:27:53 +0200
Message-Id: <20190623132436.552451082@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:24:07 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 27/29] x86/hpet: Carve out shareable parts of
 init_one_hpet_msi_clockevent()
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To finally remove the static channel0/clockevent storage and to utilize the
channel 0 storage in hpet_base, it's required to run time initialize the
clockevent. The MSI clockevents already have a run time init function.

Carve out the parts which can be shared between the legacy and the MSI
implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -411,6 +411,25 @@ hpet_clkevt_set_next_event(unsigned long
 	return res < HPET_MIN_CYCLES ? -ETIME : 0;
 }
 
+static void hpet_init_clockevent(struct hpet_channel *hc, unsigned int rating)
+{
+	struct clock_event_device *evt = &hc->evt;
+
+	evt->rating		= rating;
+	evt->irq		= hc->irq;
+	evt->name		= hc->name;
+	evt->cpumask		= cpumask_of(hc->cpu);
+	evt->set_state_oneshot	= hpet_clkevt_set_oneshot;
+	evt->set_next_event	= hpet_clkevt_set_next_event;
+	evt->set_state_shutdown	= hpet_clkevt_shutdown;
+
+	evt->features = CLOCK_EVT_FEAT_ONESHOT;
+	if (hc->boot_cfg & HPET_TN_PERIODIC) {
+		evt->features		|= CLOCK_EVT_FEAT_PERIODIC;
+		evt->set_state_periodic	= hpet_clkevt_set_periodic;
+	}
+}
+
 /*
  * The HPET clock event device wrapped in a channel for conversion
  */
@@ -510,23 +529,10 @@ static void init_one_hpet_msi_clockevent
 
 	hc->cpu = cpu;
 	per_cpu(cpu_hpet_channel, cpu) = hc;
-	evt->name = hc->name;
 	hpet_setup_msi_irq(hc);
-	evt->irq = hc->irq;
 
-	evt->rating = 110;
-	evt->features = CLOCK_EVT_FEAT_ONESHOT;
-	if (hc->boot_cfg & HPET_TN_PERIODIC) {
-		evt->features |= CLOCK_EVT_FEAT_PERIODIC;
-		evt->set_state_periodic = hpet_clkevt_set_periodic;
-	}
-
-	evt->set_state_shutdown = hpet_clkevt_shutdown;
-	evt->set_state_oneshot = hpet_clkevt_set_oneshot;
-	evt->set_next_event = hpet_clkevt_set_next_event;
+	hpet_init_clockevent(hc, 110);
 	evt->tick_resume = hpet_clkevt_msi_resume;
-	evt->cpumask = cpumask_of(hc->cpu);
-
 	clockevents_config_and_register(evt, hpet_freq, HPET_MIN_PROG_DELTA,
 					0x7FFFFFFF);
 }


