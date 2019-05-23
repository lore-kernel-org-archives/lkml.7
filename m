Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067BAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF4221019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yFmVfNdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfEWJeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:34:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54223 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfEWJeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:34:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9WfJP4042791
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:32:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9WfJP4042791
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603962;
        bh=6lC41jvdgeVTxcqYxxQ2U2sulpTHDaCnCykV3UQCT+4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=yFmVfNdh6ewCTJ9Ppo+XZnhb8KOD0cnl8k5yYnB3LfZQPhhFhr3kefGWC7z06KfIw
         T0apKE2ksIuMJQfmZ8AP79grCQidabn68xwehYN86fkjus5bGNa1aa6xZ5O1HnCy0j
         f5Bbo+Blg2JAByFzvJ4fBy17GKaLHUs8ElXn4TtpRFZL+inWYsqZjhjcgH+jBNXwYE
         QTGs0dw/epMpmCXBvHRhajnWSV2caiJC5ZB93PSbeYUsj8PJtS1ClDSFon0kRDRW7S
         CZYhqsRTYvqeKI01awcLx/V4AxSJtK0rVAZcAKcWhuD5Yp97R8sOelGyqNJCLwe2jb
         fFKd6dW3Hg4Bw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9WfL44042788;
        Thu, 23 May 2019 02:32:41 -0700
Date:   Thu, 23 May 2019 02:32:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-cb63ba0f670df1f0ddf21c6cc4bbe74db398742c@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        kan.liang@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, len.brown@intel.com
Reply-To: kan.liang@linux.intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          len.brown@intel.com, tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <acb5e483287280eeb2b6daabe04a600b85e72a78.1557769318.git.len.brown@intel.com>
References: <acb5e483287280eeb2b6daabe04a600b85e72a78.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] perf/x86/intel/cstate: Support multi-die/package
Git-Commit-ID: cb63ba0f670df1f0ddf21c6cc4bbe74db398742c
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

Commit-ID:  cb63ba0f670df1f0ddf21c6cc4bbe74db398742c
Gitweb:     https://git.kernel.org/tip/cb63ba0f670df1f0ddf21c6cc4bbe74db398742c
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 13 May 2019 13:58:59 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:35 +0200

perf/x86/intel/cstate: Support multi-die/package

Some cstate counters become die-scoped on Xeon Cascade Lake-AP. Perf cstate
driver needs to support die-scope cstate counters.

Use topology_die_cpumask() to replace topology_core_cpumask().  For
previous platforms which doesn't have multi-die, topology_die_cpumask() is
identical as topology_core_cpumask().  There is no functional change for
previous platforms.

Name the die-scope PMU "cstate_die".

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/acb5e483287280eeb2b6daabe04a600b85e72a78.1557769318.git.len.brown@intel.com

---
 arch/x86/events/intel/cstate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 6072f92cb8ea..267d7f8e12ab 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -302,7 +302,7 @@ static int cstate_pmu_event_init(struct perf_event *event)
 			return -EINVAL;
 		event->hw.event_base = pkg_msr[cfg].msr;
 		cpu = cpumask_any_and(&cstate_pkg_cpu_mask,
-				      topology_core_cpumask(event->cpu));
+				      topology_die_cpumask(event->cpu));
 	} else {
 		return -ENOENT;
 	}
@@ -385,7 +385,7 @@ static int cstate_cpu_exit(unsigned int cpu)
 	if (has_cstate_pkg &&
 	    cpumask_test_and_clear_cpu(cpu, &cstate_pkg_cpu_mask)) {
 
-		target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+		target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
 		/* Migrate events if there is a valid target */
 		if (target < nr_cpu_ids) {
 			cpumask_set_cpu(target, &cstate_pkg_cpu_mask);
@@ -414,7 +414,7 @@ static int cstate_cpu_init(unsigned int cpu)
 	 * in the package cpu mask as the designated reader.
 	 */
 	target = cpumask_any_and(&cstate_pkg_cpu_mask,
-				 topology_core_cpumask(cpu));
+				 topology_die_cpumask(cpu));
 	if (has_cstate_pkg && target >= nr_cpu_ids)
 		cpumask_set_cpu(cpu, &cstate_pkg_cpu_mask);
 
@@ -663,7 +663,13 @@ static int __init cstate_init(void)
 	}
 
 	if (has_cstate_pkg) {
-		err = perf_pmu_register(&cstate_pkg_pmu, cstate_pkg_pmu.name, -1);
+		if (topology_max_die_per_package() > 1) {
+			err = perf_pmu_register(&cstate_pkg_pmu,
+						"cstate_die", -1);
+		} else {
+			err = perf_pmu_register(&cstate_pkg_pmu,
+						cstate_pkg_pmu.name, -1);
+		}
 		if (err) {
 			has_cstate_pkg = false;
 			pr_info("Failed to register cstate pkg pmu\n");
