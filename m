Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF15C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A65208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PdI4qVcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfF0XmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:42:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41283 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfF0XmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:42:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNf8ko500462
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:41:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNf8ko500462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561678869;
        bh=dTCZ0RhpJ37DtuMuCJHn0EhkoVHA7MY7k1ZLzWcJ9yE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=PdI4qVcSV7bDN7J5Lfp1q0LnAbZLxrlnIHdWBCUvimTbqhGLUMtJtMQkwq2efo+Bx
         g0dtsBv54A4KCBndYSl/j63O3P9q6n6MvY4mWoaFC6iLFT5/YquGj/ka4uW/xurpdT
         gOA6FahpF3EYAX91iVXse4R6h+mmNz/cWCX4sGhc6gB+nc4XlW1QaxfYeBp1y6J8dq
         giuhhdN8KmtD4k+VfUtluz389zlAAgTzmHW2GLOkzFHLKR/Dnt0w7TQUq0SBq0scF8
         2E3vj1PZ93CWVm0Db9/erxlvhkPihplHi8vo5pSMWKq0+7nuhieDhC9NHGpz4734o1
         oK/sZAchjxqBg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNf7Xc500459;
        Thu, 27 Jun 2019 16:41:07 -0700
Date:   Thu, 27 Jun 2019 16:41:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-3222daf970f30133cc4c639cbecdc29c4ae91b2b@git.kernel.org>
Cc:     ricardo.neri-calderon@linux.intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Suravee.Suthikulpanit@amd.com,
        hpa@zytor.com, andi.kleen@intel.com, peterz@infradead.org,
        eranian@google.com, ravi.v.shankar@intel.com, mingo@kernel.org,
        ashok.raj@intel.com
Reply-To: andi.kleen@intel.com, eranian@google.com, peterz@infradead.org,
          ashok.raj@intel.com, ravi.v.shankar@intel.com, mingo@kernel.org,
          ricardo.neri-calderon@linux.intel.com, tglx@linutronix.de,
          Suravee.Suthikulpanit@amd.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190623132435.058540608@linutronix.de>
References: <20190623132435.058540608@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Separate counter check out of
 clocksource register code
Git-Commit-ID: 3222daf970f30133cc4c639cbecdc29c4ae91b2b
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

Commit-ID:  3222daf970f30133cc4c639cbecdc29c4ae91b2b
Gitweb:     https://git.kernel.org/tip/3222daf970f30133cc4c639cbecdc29c4ae91b2b
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:51 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:18 +0200

x86/hpet: Separate counter check out of clocksource register code

The init code checks whether the HPET counter works late in the init
function when the clocksource is registered. That should happen right with
the other sanity checks.

Split it into a separate validation function and move it to the other
sanity checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132435.058540608@linutronix.de

---
 arch/x86/kernel/hpet.c | 65 ++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 71533f53fa1d..8c57dbf15e3b 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -809,38 +809,6 @@ static struct clocksource clocksource_hpet = {
 	.resume		= hpet_resume_counter,
 };
 
-static int __init hpet_clocksource_register(void)
-{
-	u64 start, now;
-	u64 t1;
-
-	/* Start the counter */
-	hpet_restart_counter();
-
-	/* Verify whether hpet counter works */
-	t1 = hpet_readl(HPET_COUNTER);
-	start = rdtsc();
-
-	/*
-	 * We don't know the TSC frequency yet, but waiting for
-	 * 200000 TSC cycles is safe:
-	 * 4 GHz == 50us
-	 * 1 GHz == 200us
-	 */
-	do {
-		rep_nop();
-		now = rdtsc();
-	} while ((now - start) < 200000UL);
-
-	if (t1 == hpet_readl(HPET_COUNTER)) {
-		pr_warn("Counter not counting. HPET disabled\n");
-		return -ENODEV;
-	}
-
-	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
-	return 0;
-}
-
 /*
  * AMD SB700 based systems with spread spectrum enabled use a SMM based
  * HPET emulation to provide proper frequency setting.
@@ -869,6 +837,32 @@ static bool __init hpet_cfg_working(void)
 	return false;
 }
 
+static bool __init hpet_counting(void)
+{
+	u64 start, now, t1;
+
+	hpet_restart_counter();
+
+	t1 = hpet_readl(HPET_COUNTER);
+	start = rdtsc();
+
+	/*
+	 * We don't know the TSC frequency yet, but waiting for
+	 * 200000 TSC cycles is safe:
+	 * 4 GHz == 50us
+	 * 1 GHz == 200us
+	 */
+	do {
+		rep_nop();
+		now = rdtsc();
+	} while ((now - start) < 200000UL);
+
+	if (t1 == hpet_readl(HPET_COUNTER)) {
+		pr_warn("Counter not counting. HPET disabled\n");
+		return false;
+	}
+	return true;
+}
 
 /**
  * hpet_enable - Try to setup the HPET timer. Returns 1 on success.
@@ -890,6 +884,10 @@ int __init hpet_enable(void)
 	if (!hpet_cfg_working())
 		goto out_nohpet;
 
+	/* Validate that the counter is counting */
+	if (!hpet_counting())
+		goto out_nohpet;
+
 	/*
 	 * Read the period and check for a sane value:
 	 */
@@ -948,8 +946,7 @@ int __init hpet_enable(void)
 	}
 	hpet_print_config();
 
-	if (hpet_clocksource_register())
-		goto out_nohpet;
+	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
 
 	if (id & HPET_ID_LEGSUP) {
 		hpet_legacy_clockevent_register();
