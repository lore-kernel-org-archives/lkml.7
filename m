Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510E3C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3371C21783
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfKMMlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:41:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:39278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727097AbfKMMlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:41:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CDD3B555;
        Wed, 13 Nov 2019 12:41:19 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH v4 4/6] x86,sched: Add support for frequency invariance on ATOM_GOLDMONT*
Date:   Wed, 13 Nov 2019 13:46:52 +0100
Message-Id: <20191113124654.18122-5-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191113124654.18122-1-ggherdovich@suse.cz>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler needs the ratio freq_curr/freq_max for frequency-invariant
accounting. On GOLDMONT (aka Apollo Lake), GOLDMONT_D (aka Denverton) and
GOLDMONT_PLUS CPUs (aka Gemini Lake) set freq_max to the highest frequency
reported by the CPU.

The encoding of turbo ratios for GOLDMONT* is identical to the one for
SKYLAKE_X, but we treat the Atom case apart because we want to set freq_max to
a higher value, thus the ratio freq_curr/freq_max to be lower, leading to more
conservative frequency selections (favoring power efficiency).

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 arch/x86/kernel/smpboot.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0e79dcc03ae4..4d192abf337d 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1795,6 +1795,10 @@ void native_play_dead(void)
  * which would ignore the entire turbo range (a conspicuous part, making
  * freq_curr/freq_max always maxed out).
  *
+ * An exception to the heuristic above is the Atom uarch, where we choose the
+ * highest turbo level for freq_max since Atom's are generally oriented towards
+ * power efficiency.
+ *
  * Setting freq_max to anything less than the 1C turbo ratio makes the ratio
  * freq_curr / freq_max to eventually grow >1, in which case we clip it to 1.
  */
@@ -1841,6 +1845,27 @@ static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
 	{}
 };
 
+static bool glm_set_cpu_max_freq(u64 *ratio, u64 *turbo_ratio)
+{
+	int err;
+
+	if (!x86_match_cpu(has_glm_turbo_ratio_limits))
+		return false;
+
+	err = rdmsrl_safe(MSR_PLATFORM_INFO, ratio);
+	if (err)
+		return false;
+
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, turbo_ratio);
+	if (err)
+		return false;
+
+	*ratio = (*ratio >> 8) & 0xFF;        /* max P state ratio */
+	*turbo_ratio = *turbo_ratio & 0xFF;   /* highest turbo ratio */
+
+	return true;
+}
+
 static int get_knl_turbo_ratio(u64 *turbo_ratio)
 {
 	u64 msr;
@@ -1962,7 +1987,6 @@ static void intel_set_cpu_max_freq(void)
 	/*
 	 * TODO: add support for:
 	 *
-	 * - Atom Goldmont
 	 * - Atom Silvermont
 	 *
 	 * which all now get by default arch_max_freq = SCHED_CAPACITY_SCALE
@@ -1970,10 +1994,12 @@ static void intel_set_cpu_max_freq(void)
 
 	u64 ratio = 1, turbo_ratio = 1;
 
-	if (turbo_disabled() ||
-		x86_match_cpu(has_glm_turbo_ratio_limits))
+	if (turbo_disabled())
 		return;
 
+	if (glm_set_cpu_max_freq(&ratio, &turbo_ratio))
+		goto set_value;
+
 	if (knl_set_cpu_max_freq(&ratio, &turbo_ratio))
 		goto set_value;
 
-- 
2.16.4

