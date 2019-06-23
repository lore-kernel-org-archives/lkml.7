Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3E5C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00B820679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfFWN2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:28:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33605 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfFWN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:55 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2XC-0001nW-H6; Sun, 23 Jun 2019 15:27:54 +0200
Message-Id: <20190623132436.737689919@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:24:09 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 29/29] x86/hpet: Use channel for legacy clockevent storage
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All preparations are done. Use the channel storage for the legacy
clockevent and remove the static variable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -66,11 +66,6 @@ bool					boot_hpet_disable;
 bool					hpet_force_user;
 static bool				hpet_verbose;
 
-/*
- * The HPET clock event device wrapped in a channel for conversion
- */
-static struct hpet_channel		hpet_channel0;
-
 static inline
 struct hpet_channel *clockevent_to_channel(struct clock_event_device *evt)
 {
@@ -903,7 +898,7 @@ int __init hpet_enable(void)
 	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
 
 	if (id & HPET_ID_LEGSUP) {
-		hpet_legacy_clockevent_register(&hpet_channel0);
+		hpet_legacy_clockevent_register(&hpet_base.channels[0]);
 		hpet_base.channels[0].mode = HPET_MODE_LEGACY;
 		if (IS_ENABLED(CONFIG_HPET_EMULATE_RTC))
 			hpet_base.channels[1].mode = HPET_MODE_LEGACY;
@@ -1088,7 +1083,7 @@ int hpet_rtc_timer_init(void)
 		return 0;
 
 	if (!hpet_default_delta) {
-		struct clock_event_device *evt = &hpet_channel0.evt;
+		struct clock_event_device *evt = &hpet_base.channels[0].evt;
 		uint64_t clc;
 
 		clc = (uint64_t) evt->mult * NSEC_PER_SEC;
@@ -1186,7 +1181,7 @@ int hpet_set_periodic_freq(unsigned long
 	if (freq <= DEFAULT_RTC_INT_FREQ) {
 		hpet_pie_limit = DEFAULT_RTC_INT_FREQ / freq;
 	} else {
-		struct clock_event_device *evt = &hpet_channel0.evt;
+		struct clock_event_device *evt = &hpet_base.channels[0].evt;
 
 		clc = (uint64_t) evt->mult * NSEC_PER_SEC;
 		do_div(clc, freq);


