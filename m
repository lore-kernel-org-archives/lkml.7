Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E61C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA7521A4A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfJBMYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:24:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:57254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726635AbfJBMYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:24:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91B0CACC3;
        Wed,  2 Oct 2019 12:24:17 +0000 (UTC)
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
Subject: [PATCH v2 2/2] cpufreq: intel_pstate: Conditional frequency invariant accounting
Date:   Wed,  2 Oct 2019 14:29:26 +0200
Message-Id: <20191002122926.385-3-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191002122926.385-1-ggherdovich@suse.cz>
References: <20191002122926.385-1-ggherdovich@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

intel_pstate has two operating modes: active and passive. In "active"
mode, the in-built scaling governor is used and in "passive" mode,
the driver can be used with any governor like "schedutil". In "active"
mode the utilization values from schedutil is not used and there is
a requirement from high performance computing use cases, not to read
any APERF/MPERF MSRs. In this case no need to use CPU cycles for
frequency invariant accounting by reading APERF/MPERF MSRs.
With this change frequency invariant account is only enabled in
"passive" mode.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 drivers/cpufreq/intel_pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 9f02de9a1b47..c7d9149e99ee 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2493,6 +2493,8 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 {
 	int ret;
 
+	x86_arch_scale_freq_tick_disable();
+
 	memset(&global, 0, sizeof(global));
 	global.max_perf_pct = 100;
 
@@ -2505,6 +2507,9 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 
 	global.min_perf_pct = min_perf_pct_min();
 
+	if (driver == &intel_cpufreq)
+		x86_arch_scale_freq_tick_enable();
+
 	return 0;
 }
 
-- 
2.16.4

