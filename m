Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5908C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853CA2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfLMJ2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:28:10 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48022 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfLMJ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:27:34 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id ca8ad0f169ccbab0; Fri, 13 Dec 2019 10:27:32 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 05/10] intel_idle: Refactor intel_idle_cpuidle_driver_init()
Date:   Fri, 13 Dec 2019 10:16:04 +0100
Message-ID: <15175612.mLOhOsQDLf@kreacher>
In-Reply-To: <3950312.2WmFeOdZGY@kreacher>
References: <3950312.2WmFeOdZGY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Move the C-state verification and checks from
intel_idle_cpuidle_driver_init() to a separate function,
intel_idle_verify_cstate(), and make the former call it after
checking the CPUIDLE_FLAG_UNUSABLE state flag.

Also combine the drv->states[] updates with the incrementation of
drv->state_count.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

No changes from the RFC version.

---
 drivers/idle/intel_idle.c | 49 ++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 75fd2a7b0842..47255d3cf51f 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -944,6 +944,22 @@ static void intel_idle_s2idle(struct cpuidle_device *dev,
 	mwait_idle_with_hints(eax, ecx);
 }
 
+static bool intel_idle_verify_cstate(unsigned int mwait_hint)
+{
+	unsigned int mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint) + 1;
+	unsigned int num_substates = (mwait_substates >> mwait_cstate * 4) &
+					MWAIT_SUBSTATE_MASK;
+
+	/* Ignore the C-state if there are NO sub-states in CPUID for it. */
+	if (num_substates == 0)
+		return false;
+
+	if (mwait_cstate > 2 && !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+		mark_tsc_unstable("TSC halts in idle states deeper than C2");
+
+	return true;
+}
+
 static void __setup_broadcast_timer(bool on)
 {
 	if (on)
@@ -1332,10 +1348,10 @@ static void __init intel_idle_cpuidle_driver_init(void)
 	drv->state_count = 1;
 
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
-		int num_substates, mwait_hint, mwait_cstate;
+		unsigned int mwait_hint;
 
-		if ((cpuidle_state_table[cstate].enter == NULL) &&
-		    (cpuidle_state_table[cstate].enter_s2idle == NULL))
+		if (!cpuidle_state_table[cstate].enter &&
+		    !cpuidle_state_table[cstate].enter_s2idle)
 			break;
 
 		if (cstate + 1 > max_cstate) {
@@ -1343,34 +1359,19 @@ static void __init intel_idle_cpuidle_driver_init(void)
 			break;
 		}
 
-		mwait_hint = flg2MWAIT(cpuidle_state_table[cstate].flags);
-		mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint);
-
-		/* number of sub-states for this state in CPUID.MWAIT */
-		num_substates = (mwait_substates >> ((mwait_cstate + 1) * 4))
-					& MWAIT_SUBSTATE_MASK;
-
-		/* if NO sub-states for this state in CPUID, skip it */
-		if (num_substates == 0)
-			continue;
-
-		/* if state marked as disabled, skip it */
+		/* If marked as unusable, skip this state. */
 		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUSABLE) {
 			pr_debug("state %s is disabled\n",
 				 cpuidle_state_table[cstate].name);
 			continue;
 		}
 
+		mwait_hint = flg2MWAIT(cpuidle_state_table[cstate].flags);
+		if (!intel_idle_verify_cstate(mwait_hint))
+			continue;
 
-		if (((mwait_cstate + 1) > 2) &&
-			!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
-			mark_tsc_unstable("TSC halts in idle"
-					" states deeper than C2");
-
-		drv->states[drv->state_count] =	/* structure copy */
-			cpuidle_state_table[cstate];
-
-		drv->state_count += 1;
+		/* Structure copy. */
+		drv->states[drv->state_count++] = cpuidle_state_table[cstate];
 	}
 
 	if (icpu->byt_auto_demotion_disable_flag) {
-- 
2.16.4





