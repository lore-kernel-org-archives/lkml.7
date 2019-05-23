Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA657C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54672133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nAoUGcXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfEWJdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:33:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52621 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfEWJdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:33:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9VxKr4042757
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:31:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9VxKr4042757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603919;
        bh=bS40bLJjFN3lJTYArjnk/bD65ZP21iJ1K8s7UdZJiPE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nAoUGcXx3eoK5AqpDQBmZ0GFz0w+h249miJYONZrLfMpybvWPTXRC+WHW9/nfre87
         dlhrWSMJ/qH1XmJASAS6BdxolBYpa/LVrKuYSYjb19gzQQv2+8xnrN93vGogma1HJc
         8Fhhs3prdhR54SA3qtTYeE/lvKSSdnM6iBeUClz0zrKUQzIWLqgncyRQdO0MzHJG/g
         T6W9bhZzBNMiDQ+FZNXE/BKdsjr9NNujVxxKisRkoRjqO7GvAlZ6jHX4Iv3tomLHpM
         P2QIjG9r1IMXxbZdkScsUO4icET+N/p8BLHDcULaVvPrLxAhEYJi5uzk5xy5A5VVTN
         k1vvX3zOzTixw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9VwpA4042754;
        Thu, 23 May 2019 02:31:58 -0700
Date:   Thu, 23 May 2019 02:31:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-b10b3efb88e7bba12f09f71740bab9b7225631c9@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, hpa@zytor.com, len.brown@intel.com,
        peterz@infradead.org
Reply-To: peterz@infradead.org, len.brown@intel.com, hpa@zytor.com,
          kan.liang@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <851320c8c87ba7a54e58ee8579c1bf566ce23cbb.1557769318.git.len.brown@intel.com>
References: <851320c8c87ba7a54e58ee8579c1bf566ce23cbb.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] perf/x86/intel/rapl: Support multi-die/package
Git-Commit-ID: b10b3efb88e7bba12f09f71740bab9b7225631c9
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

Commit-ID:  b10b3efb88e7bba12f09f71740bab9b7225631c9
Gitweb:     https://git.kernel.org/tip/b10b3efb88e7bba12f09f71740bab9b7225631c9
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 13 May 2019 13:58:58 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:35 +0200

perf/x86/intel/rapl: Support multi-die/package

RAPL becomes die-scope on Xeon Cascade Lake-AP. Perf RAPL driver needs to
support die-scope RAPL domain.

Use topology_logical_die_id() to replace topology_logical_package_id().
For previous platforms which doesn't have multi-die,
topology_logical_die_id() is identical as topology_logical_package_id().

Use topology_die_cpumask() to replace topology_core_cpumask().  For
previous platforms which doesn't have multi-die, topology_die_cpumask() is
identical as topology_core_cpumask().

There is no functional change for previous platforms.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/851320c8c87ba7a54e58ee8579c1bf566ce23cbb.1557769318.git.len.brown@intel.com

---
 arch/x86/events/intel/rapl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 37ebf6fc5415..6f5331271563 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -161,7 +161,7 @@ static u64 rapl_timer_ms;
 
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int pkgid = topology_logical_package_id(cpu);
+	unsigned int pkgid = topology_logical_die_id(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
@@ -571,7 +571,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -598,14 +598,14 @@ static int rapl_cpu_online(unsigned int cpu)
 		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
 		rapl_hrtimer_init(pmu);
 
-		rapl_pmus->pmus[topology_logical_package_id(cpu)] = pmu;
+		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
 	}
 
 	/*
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(&rapl_cpu_mask, topology_core_cpumask(cpu));
+	target = cpumask_any_and(&rapl_cpu_mask, topology_die_cpumask(cpu));
 	if (target < nr_cpu_ids)
 		return 0;
 
@@ -675,7 +675,7 @@ static void cleanup_rapl_pmus(void)
 
 static int __init init_rapl_pmus(void)
 {
-	int maxpkg = topology_max_packages();
+	int maxpkg = topology_max_packages() * topology_max_die_per_package();
 	size_t size;
 
 	size = sizeof(*rapl_pmus) + maxpkg * sizeof(struct rapl_pmu *);
