Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFECBC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BF02067D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oHltirZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfF0XyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:54:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53521 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfF0XyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:54:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNrsiE504144
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:53:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNrsiE504144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679635;
        bh=vRn26elBWa1X3UcNtcg5obuHPGs3EzBusaXblIOPBjg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=oHltirZkbXSneXfNfO1cv0xX5YPe3BjKlE8zISVqHHFH7hIO9rsctOy79y3H8cUET
         iQcFoCQds0qaGgTEubUPvRp+IUWClo7T1b4B/g/Z9s/beJHjntXs5H3dznKQvyfQG2
         3FEsi8gdOtTzqYa2P2PDM1B272hgPizBs3cC0eiSv3Fc9u+QfRopLG753uYW+pVDAC
         6feguaE7eKprojk7VCwgF1OoCdKS/KQ22B6Gz/Xl1kh/8XD/25WOns2vy+JwM47dKP
         hZ/j2FlTynAAxsrVehO8emsFM/lD2UvcsMfQLmpgePGuRs9VVrPYiSk7X+HJ7atlPS
         GKgNl5WIG2g+g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNrr61504141;
        Thu, 27 Jun 2019 16:53:53 -0700
Date:   Thu, 27 Jun 2019 16:53:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-e44252f4fe79dd9ca93bcf4e8f74389a5b8452f5@git.kernel.org>
Cc:     hpa@zytor.com, andi.kleen@intel.com, Suravee.Suthikulpanit@amd.com,
        ricardo.neri-calderon@linux.intel.com, peterz@infradead.org,
        eranian@google.com, ashok.raj@intel.com, ravi.v.shankar@intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: ashok.raj@intel.com, ravi.v.shankar@intel.com,
          tglx@linutronix.de, Suravee.Suthikulpanit@amd.com,
          andi.kleen@intel.com, hpa@zytor.com, mingo@kernel.org,
          eranian@google.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, ricardo.neri-calderon@linux.intel.com
In-Reply-To: <20190623132436.737689919@linutronix.de>
References: <20190623132436.737689919@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Use channel for legacy clockevent
 storage
Git-Commit-ID: e44252f4fe79dd9ca93bcf4e8f74389a5b8452f5
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

Commit-ID:  e44252f4fe79dd9ca93bcf4e8f74389a5b8452f5
Gitweb:     https://git.kernel.org/tip/e44252f4fe79dd9ca93bcf4e8f74389a5b8452f5
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:24:09 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:27 +0200

x86/hpet: Use channel for legacy clockevent storage

All preparations are done. Use the channel storage for the legacy
clockevent and remove the static variable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132436.737689919@linutronix.de

---
 arch/x86/kernel/hpet.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 35633e577d21..c43e96a938d0 100644
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
@@ -904,7 +899,7 @@ int __init hpet_enable(void)
 	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
 
 	if (id & HPET_ID_LEGSUP) {
-		hpet_legacy_clockevent_register(&hpet_channel0);
+		hpet_legacy_clockevent_register(&hpet_base.channels[0]);
 		hpet_base.channels[0].mode = HPET_MODE_LEGACY;
 		if (IS_ENABLED(CONFIG_HPET_EMULATE_RTC))
 			hpet_base.channels[1].mode = HPET_MODE_LEGACY;
@@ -1089,7 +1084,7 @@ int hpet_rtc_timer_init(void)
 		return 0;
 
 	if (!hpet_default_delta) {
-		struct clock_event_device *evt = &hpet_channel0.evt;
+		struct clock_event_device *evt = &hpet_base.channels[0].evt;
 		uint64_t clc;
 
 		clc = (uint64_t) evt->mult * NSEC_PER_SEC;
@@ -1187,7 +1182,7 @@ int hpet_set_periodic_freq(unsigned long freq)
 	if (freq <= DEFAULT_RTC_INT_FREQ) {
 		hpet_pie_limit = DEFAULT_RTC_INT_FREQ / freq;
 	} else {
-		struct clock_event_device *evt = &hpet_channel0.evt;
+		struct clock_event_device *evt = &hpet_base.channels[0].evt;
 
 		clc = (uint64_t) evt->mult * NSEC_PER_SEC;
 		do_div(clc, freq);
