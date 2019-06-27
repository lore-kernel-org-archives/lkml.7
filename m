Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32850C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0142C2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ktAdQ9SF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfF0X4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:56:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0X4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:56:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNqVRZ504028
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:52:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNqVRZ504028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679551;
        bh=IoJULm3a/vW3dHXLoW/C9JQt9qoXF9dTAoa50hiV2RM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ktAdQ9SFfpiEoClKa+ShnDFP7UxsBid4qkJMBPpM9Rz2z1g45mBje7t9fEMWh0asq
         VoX665BppHbxbaJNQpAjo3TlIjfUagc3XNJhgKySZ/8r2Q7D/KWl74sn7jyU9OTv0E
         K9nI2/C+EwKWA5DAbqkOthT5d+jTuzsyILk/6LxtFPB7WiLtJsAsffqp+F/uKetqlM
         QawwKNnLq7rsDhGudJIpp2GTlhjflYHsbwBmAWAexFqsbdVISTFHkTnKOUIzc83feH
         6DuPRchT0IQKO5cLeRtW8nSvymm5dHzh6Ln1003MyeWnMcXLQLbh+zdShqAvv35GMR
         fijk7L19Xv9cA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNqU5j504025;
        Thu, 27 Jun 2019 16:52:30 -0700
Date:   Thu, 27 Jun 2019 16:52:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-ea99110dd024d2f31bde19dda049f3fbf3816a70@git.kernel.org>
Cc:     andi.kleen@intel.com, mingo@kernel.org, hpa@zytor.com,
        Suravee.Suthikulpanit@amd.com, linux-kernel@vger.kernel.org,
        ricardo.neri-calderon@linux.intel.com, tglx@linutronix.de,
        peterz@infradead.org, ashok.raj@intel.com,
        ravi.v.shankar@intel.com, eranian@google.com
Reply-To: Suravee.Suthikulpanit@amd.com, linux-kernel@vger.kernel.org,
          ricardo.neri-calderon@linux.intel.com, tglx@linutronix.de,
          peterz@infradead.org, ashok.raj@intel.com,
          ravi.v.shankar@intel.com, eranian@google.com, mingo@kernel.org,
          andi.kleen@intel.com, hpa@zytor.com
In-Reply-To: <20190623132436.552451082@linutronix.de>
References: <20190623132436.552451082@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Carve out shareable parts of
 init_one_hpet_msi_clockevent()
Git-Commit-ID: ea99110dd024d2f31bde19dda049f3fbf3816a70
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

Commit-ID:  ea99110dd024d2f31bde19dda049f3fbf3816a70
Gitweb:     https://git.kernel.org/tip/ea99110dd024d2f31bde19dda049f3fbf3816a70
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:24:07 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:26 +0200

x86/hpet: Carve out shareable parts of init_one_hpet_msi_clockevent()

To finally remove the static channel0/clockevent storage and to utilize the
channel 0 storage in hpet_base, it's required to run time initialize the
clockevent. The MSI clockevents already have a run time init function.

Carve out the parts which can be shared between the legacy and the MSI
implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132436.552451082@linutronix.de

---
 arch/x86/kernel/hpet.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 47eb4d36864e..80497fe5354c 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -411,6 +411,25 @@ hpet_clkevt_set_next_event(unsigned long delta, struct clock_event_device *evt)
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
+	evt->set_state_oneshot	= hpet_clkevt_set_state_oneshot;
+	evt->set_next_event	= hpet_clkevt_set_next_event;
+	evt->set_state_shutdown	= hpet_clkevt_set_state_shutdown;
+
+	evt->features = CLOCK_EVT_FEAT_ONESHOT;
+	if (hc->boot_cfg & HPET_TN_PERIODIC) {
+		evt->features		|= CLOCK_EVT_FEAT_PERIODIC;
+		evt->set_state_periodic	= hpet_clkevt_set_state_periodic;
+	}
+}
+
 /*
  * The HPET clock event device wrapped in a channel for conversion
  */
@@ -510,22 +529,10 @@ static void init_one_hpet_msi_clockevent(struct hpet_channel *hc, int cpu)
 
 	hc->cpu = cpu;
 	per_cpu(cpu_hpet_channel, cpu) = hc;
-	evt->name = hc->name;
 	hpet_setup_msi_irq(hc);
-	evt->irq = hc->irq;
 
-	evt->rating = 110;
-	evt->features = CLOCK_EVT_FEAT_ONESHOT;
-	if (hc->boot_cfg & HPET_TN_PERIODIC) {
-		evt->features |= CLOCK_EVT_FEAT_PERIODIC;
-		evt->set_state_periodic = hpet_clkevt_set_state_periodic;
-	}
-
-	evt->set_state_shutdown	= hpet_clkevt_set_state_shutdown;
-	evt->set_state_oneshot = hpet_clkevt_set_state_oneshot;
-	evt->set_next_event = hpet_clkevt_set_next_event;
+	hpet_init_clockevent(hc, 110);
 	evt->tick_resume = hpet_clkevt_msi_resume;
-	evt->cpumask = cpumask_of(hc->cpu);
 
 	clockevents_config_and_register(evt, hpet_freq, HPET_MIN_PROG_DELTA,
 					0x7FFFFFFF);
