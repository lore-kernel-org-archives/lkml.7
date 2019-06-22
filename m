Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F039C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0C020679
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X5ykuasc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFVP0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 11:26:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44743 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVP0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 11:26:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MFPOjO2217871
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 08:25:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MFPOjO2217871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561217125;
        bh=2ISqZgRgJWnyeqUUJGNgQHPEq3Uk846/xeG+w3hucwc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=X5ykuascB+kGw0AVuvSudX0KnmEgsMFc3RpukG2Yyls35JDHZfzodmyyCn8PghNAi
         I4PhE+nMizK2xKf3cfZSMb4MXgrxUBw8OfWYRQRk2Y9Q+V+DRA1qHCviizWqA7EzvA
         mhc3gUdPemJLT7kO59qCVn1gEOT6kEnKu9BxOpHGmE7fcMVRUPV45cNAnDxPQPS1oB
         f3kNDyvoP5F7hv13gcfGg2FrsDJn8WW5ZyU/qcqM3O0Mnj5HHFnyZTYDh+TZYzYsF3
         IhSYoVRSaoCf0aDf+9ENxXkKZsSDzzhwL/Q6mH4kK1/ugG3Nnc8TlDb8OGxFh12Ad0
         jbsnoNT0A+Gtg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MFPNfl2217867;
        Sat, 22 Jun 2019 08:25:23 -0700
Date:   Sat, 22 Jun 2019 08:25:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Konstantin Khlebnikov <tipbot@zytor.com>
Message-ID: <tip-cc9e303c91f5c25c49a4312552841f4c23fa2b69@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, len.brown@intel.com,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        khlebnikov@yandex-team.ru, frederic@kernel.org,
        peterz@infradead.org
Reply-To: paulmck@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
          tglx@linutronix.de, khlebnikov@yandex-team.ru,
          peterz@infradead.org, frederic@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, len.brown@intel.com,
          mingo@kernel.org
In-Reply-To: <155790354043.1104.15333317408370209.stgit@buzz>
References: <155790354043.1104.15333317408370209.stgit@buzz>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpu: Disable frequency requests via aperfmperf
 IPI for nohz_full CPUs
Git-Commit-ID: cc9e303c91f5c25c49a4312552841f4c23fa2b69
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

Commit-ID:  cc9e303c91f5c25c49a4312552841f4c23fa2b69
Gitweb:     https://git.kernel.org/tip/cc9e303c91f5c25c49a4312552841f4c23fa2b69
Author:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
AuthorDate: Wed, 15 May 2019 09:59:00 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 17:23:48 +0200

x86/cpu: Disable frequency requests via aperfmperf IPI for nohz_full CPUs

Since commit 7d5905dc14a8 ("x86 / CPU: Always show current CPU frequency
in /proc/cpuinfo") open and read of /proc/cpuinfo sends IPI to all CPUs.
Many applications read /proc/cpuinfo at the start for trivial reasons like
counting cores or detecting cpu features. While sensitive workloads like
DPDK network polling don't like any interrupts.

Integrates this feature with cpu isolation and do not send IPIs to CPUs
without housekeeping flag HK_FLAG_MISC (set by nohz_full).

Code that requests cpu frequency like show_cpuinfo() falls back to the last
frequency set by the cpufreq driver if this method returns 0.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/r/155790354043.1104.15333317408370209.stgit@buzz

---
 arch/x86/kernel/cpu/aperfmperf.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index e71a6ff8a67e..e2f319dc992d 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -13,6 +13,7 @@
 #include <linux/percpu.h>
 #include <linux/cpufreq.h>
 #include <linux/smp.h>
+#include <linux/sched/isolation.h>
 
 #include "cpu.h"
 
@@ -85,6 +86,9 @@ unsigned int aperfmperf_get_khz(int cpu)
 	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
+	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+		return 0;
+
 	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
 	return per_cpu(samples.khz, cpu);
 }
@@ -101,9 +105,12 @@ void arch_freq_prepare_all(void)
 	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return;
 
-	for_each_online_cpu(cpu)
+	for_each_online_cpu(cpu) {
+		if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+			continue;
 		if (!aperfmperf_snapshot_cpu(cpu, now, false))
 			wait = true;
+	}
 
 	if (wait)
 		msleep(APERFMPERF_REFRESH_DELAY_MS);
@@ -117,6 +124,9 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
+	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+		return 0;
+
 	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
 		return per_cpu(samples.khz, cpu);
 
