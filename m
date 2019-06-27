Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19A1C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BF82086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Cd0FwXYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfF0XwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:52:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58113 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF0XwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:52:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNpnqS503974
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:51:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNpnqS503974
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679510;
        bh=Hylc574+4tp9n34JpCpiTJNbeTo6BbE6M5kjHT2stZA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Cd0FwXYDelqV4xRmoYmljEhjMubm1K9Eu269VzOZOOdAVckgJ/9sR4wVlcElqL8o1
         TY+cVw3uPsOkVC4kKAXvt/bqmlVYJWtWV2vGgBE0OPid29UGbMS5EEkwir8nvaEYEw
         J/kHaKZKO9eHAq4EnurntXferklMCZptnDV/YCpSvd4+TLv6pJ2uuvLlLzKbvrAPTL
         J8R5feRcv38+amJ+CkAdaZJ5UXqHY4TdvZhsMZLxhtHGR3bmA4VX7Y4ImQ9UZ0o4Lu
         UEExlFQCRhWFMqV/3tFUnlQEID8Yjhf32gdBYoS8amWQvowDXImdB5ZNHVMUQtJP9N
         iL6gA/dqsyKKQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNpnSn503971;
        Thu, 27 Jun 2019 16:51:49 -0700
Date:   Thu, 27 Jun 2019 16:51:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-310b5b3eb6ba5d3a92d783b9fa1c5a3ffb5932e9@git.kernel.org>
Cc:     hpa@zytor.com, eranian@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, ravi.v.shankar@intel.com,
        ricardo.neri-calderon@linux.intel.com,
        Suravee.Suthikulpanit@amd.com, mingo@kernel.org,
        andi.kleen@intel.com, tglx@linutronix.de, ashok.raj@intel.com
Reply-To: eranian@google.com, mingo@kernel.org, andi.kleen@intel.com,
          tglx@linutronix.de, hpa@zytor.com, Suravee.Suthikulpanit@amd.com,
          ricardo.neri-calderon@linux.intel.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, ravi.v.shankar@intel.com,
          ashok.raj@intel.com
In-Reply-To: <20190623132436.461437795@linutronix.de>
References: <20190623132436.461437795@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Consolidate clockevent functions
Git-Commit-ID: 310b5b3eb6ba5d3a92d783b9fa1c5a3ffb5932e9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  310b5b3eb6ba5d3a92d783b9fa1c5a3ffb5932e9
Gitweb:     https://git.kernel.org/tip/310b5b3eb6ba5d3a92d783b9fa1c5a3ffb5932e9
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:24:06 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:26 +0200

x86/hpet: Consolidate clockevent functions

Now that the legacy clockevent is wrapped in a hpet_channel struct most
clockevent functions can be shared between the legacy and the MSI based
clockevents.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132436.461437795@linutronix.de

---
 arch/x86/kernel/hpet.c | 92 ++++++++++++++------------------------------------
 1 file changed, 25 insertions(+), 67 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 19e3ac81c3b9..47eb4d36864e 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -310,8 +310,9 @@ static void hpet_legacy_clockevent_register(struct hpet_channel *hc)
 	pr_debug("Clockevent registered\n");
 }
 
-static int hpet_set_periodic(struct clock_event_device *evt, int channel)
+static int hpet_clkevt_set_state_periodic(struct clock_event_device *evt)
 {
+	unsigned int channel = clockevent_to_channel(evt)->num;
 	unsigned int cfg, cmp, now;
 	uint64_t delta;
 
@@ -340,8 +341,9 @@ static int hpet_set_periodic(struct clock_event_device *evt, int channel)
 	return 0;
 }
 
-static int hpet_set_oneshot(struct clock_event_device *evt, int channel)
+static int hpet_clkevt_set_state_oneshot(struct clock_event_device *evt)
 {
+	unsigned int channel = clockevent_to_channel(evt)->num;
 	unsigned int cfg;
 
 	cfg = hpet_readl(HPET_Tn_CFG(channel));
@@ -352,8 +354,9 @@ static int hpet_set_oneshot(struct clock_event_device *evt, int channel)
 	return 0;
 }
 
-static int hpet_shutdown(struct clock_event_device *evt, int channel)
+static int hpet_clkevt_set_state_shutdown(struct clock_event_device *evt)
 {
+	unsigned int channel = clockevent_to_channel(evt)->num;
 	unsigned int cfg;
 
 	cfg = hpet_readl(HPET_Tn_CFG(channel));
@@ -363,15 +366,17 @@ static int hpet_shutdown(struct clock_event_device *evt, int channel)
 	return 0;
 }
 
-static int hpet_resume(struct clock_event_device *evt)
+static int hpet_clkevt_legacy_resume(struct clock_event_device *evt)
 {
 	hpet_enable_legacy_int();
 	hpet_print_config();
 	return 0;
 }
 
-static int hpet_next_event(unsigned long delta, int channel)
+static int
+hpet_clkevt_set_next_event(unsigned long delta, struct clock_event_device *evt)
 {
+	unsigned int channel = clockevent_to_channel(evt)->num;
 	u32 cnt;
 	s32 res;
 
@@ -406,32 +411,6 @@ static int hpet_next_event(unsigned long delta, int channel)
 	return res < HPET_MIN_CYCLES ? -ETIME : 0;
 }
 
-static int hpet_legacy_shutdown(struct clock_event_device *evt)
-{
-	return hpet_shutdown(evt, 0);
-}
-
-static int hpet_legacy_set_oneshot(struct clock_event_device *evt)
-{
-	return hpet_set_oneshot(evt, 0);
-}
-
-static int hpet_legacy_set_periodic(struct clock_event_device *evt)
-{
-	return hpet_set_periodic(evt, 0);
-}
-
-static int hpet_legacy_resume(struct clock_event_device *evt)
-{
-	return hpet_resume(evt);
-}
-
-static int hpet_legacy_next_event(unsigned long delta,
-				  struct clock_event_device *evt)
-{
-	return hpet_next_event(delta, 0);
-}
-
 /*
  * The HPET clock event device wrapped in a channel for conversion
  */
@@ -440,11 +419,11 @@ static struct hpet_channel hpet_channel0 = {
 		.name			= "hpet",
 		.features		= CLOCK_EVT_FEAT_PERIODIC |
 					  CLOCK_EVT_FEAT_ONESHOT,
-		.set_state_periodic	= hpet_legacy_set_periodic,
-		.set_state_oneshot	= hpet_legacy_set_oneshot,
-		.set_state_shutdown	= hpet_legacy_shutdown,
-		.tick_resume		= hpet_legacy_resume,
-		.set_next_event		= hpet_legacy_next_event,
+		.set_state_periodic	= hpet_clkevt_set_state_periodic,
+		.set_state_oneshot	= hpet_clkevt_set_state_oneshot,
+		.set_state_shutdown	= hpet_clkevt_set_state_shutdown,
+		.tick_resume		= hpet_clkevt_legacy_resume,
+		.set_next_event		= hpet_clkevt_set_next_event,
 		.irq			= 0,
 		.rating			= 50,
 	}
@@ -481,22 +460,7 @@ void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg)
 	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hc->num) + 4);
 }
 
-static int hpet_msi_shutdown(struct clock_event_device *evt)
-{
-	return hpet_shutdown(evt, clockevent_to_channel(evt)->num);
-}
-
-static int hpet_msi_set_oneshot(struct clock_event_device *evt)
-{
-	return hpet_set_oneshot(evt, clockevent_to_channel(evt)->num);
-}
-
-static int hpet_msi_set_periodic(struct clock_event_device *evt)
-{
-	return hpet_set_periodic(evt, clockevent_to_channel(evt)->num);
-}
-
-static int hpet_msi_resume(struct clock_event_device *evt)
+static int hpet_clkevt_msi_resume(struct clock_event_device *evt)
 {
 	struct hpet_channel *hc = clockevent_to_channel(evt);
 	struct irq_data *data = irq_get_irq_data(hc->irq);
@@ -509,13 +473,7 @@ static int hpet_msi_resume(struct clock_event_device *evt)
 	return 0;
 }
 
-static int hpet_msi_next_event(unsigned long delta,
-			       struct clock_event_device *evt)
-{
-	return hpet_next_event(delta, clockevent_to_channel(evt)->num);
-}
-
-static irqreturn_t hpet_interrupt_handler(int irq, void *data)
+static irqreturn_t hpet_msi_interrupt_handler(int irq, void *data)
 {
 	struct hpet_channel *hc = data;
 	struct clock_event_device *evt = &hc->evt;
@@ -529,9 +487,9 @@ static irqreturn_t hpet_interrupt_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int hpet_setup_irq(struct hpet_channel *hc)
+static int hpet_setup_msi_irq(struct hpet_channel *hc)
 {
-	if (request_irq(hc->irq, hpet_interrupt_handler,
+	if (request_irq(hc->irq, hpet_msi_interrupt_handler,
 			IRQF_TIMER | IRQF_NOBALANCING,
 			hc->name, hc))
 		return -1;
@@ -553,20 +511,20 @@ static void init_one_hpet_msi_clockevent(struct hpet_channel *hc, int cpu)
 	hc->cpu = cpu;
 	per_cpu(cpu_hpet_channel, cpu) = hc;
 	evt->name = hc->name;
-	hpet_setup_irq(hc);
+	hpet_setup_msi_irq(hc);
 	evt->irq = hc->irq;
 
 	evt->rating = 110;
 	evt->features = CLOCK_EVT_FEAT_ONESHOT;
 	if (hc->boot_cfg & HPET_TN_PERIODIC) {
 		evt->features |= CLOCK_EVT_FEAT_PERIODIC;
-		evt->set_state_periodic = hpet_msi_set_periodic;
+		evt->set_state_periodic = hpet_clkevt_set_state_periodic;
 	}
 
-	evt->set_state_shutdown = hpet_msi_shutdown;
-	evt->set_state_oneshot = hpet_msi_set_oneshot;
-	evt->tick_resume = hpet_msi_resume;
-	evt->set_next_event = hpet_msi_next_event;
+	evt->set_state_shutdown	= hpet_clkevt_set_state_shutdown;
+	evt->set_state_oneshot = hpet_clkevt_set_state_oneshot;
+	evt->set_next_event = hpet_clkevt_set_next_event;
+	evt->tick_resume = hpet_clkevt_msi_resume;
 	evt->cpumask = cpumask_of(hc->cpu);
 
 	clockevents_config_and_register(evt, hpet_freq, HPET_MIN_PROG_DELTA,
