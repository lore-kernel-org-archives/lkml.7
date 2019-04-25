Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE68FC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565DB206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="P5hcG3MA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfDYKq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:46:59 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:43162 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728944AbfDYKq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:46:58 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 292182E0DDC;
        Thu, 25 Apr 2019 13:46:55 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 1ntPunexU0-kqUOQVSE;
        Thu, 25 Apr 2019 13:46:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1556189215; bh=lRYvD+k8oEBPJWX5OyPVnoY1l7XxL72FGY8nF6uwy8c=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=P5hcG3MAgHhPg6AHXFqnPrWuQRwHN0GoYFyAoqgd29N396lA2p+XWOiPDuvr0dmwy
         isosp+JdDFvvocX1csCdS7suJp8uUhoWKW+/CXzmSQXPo4Ii32EF9jsxKB6xoSBeee
         QacZxuWUFFZtwNikt2+OQCwszaMQ888beF6s2380=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:547a:aec1:8b2f:9dac])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Z4flB0q0Ey-kp5uOfKg;
        Thu, 25 Apr 2019 13:46:52 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH RFC] x86 / CPU: Add cpu isolation flag for avoiding
 disturbance from aperfmperf IPI
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date:   Thu, 25 Apr 2019 13:46:51 +0300
Message-ID: <155618921176.2006.3031084313219003524.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sensitive workloads like DPDK polling do not like any interrupts.

This patch adds flag 'freq' for boot option 'isolcpu': isolcpu=freq,<cpus>.

Users like show_cpuinfo() fallback to frequency from generic cpufreq
policy if arch-specific requesting method returns 0.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 Documentation/admin-guide/kernel-parameters.txt |    3 +++
 arch/x86/kernel/cpu/aperfmperf.c                |   12 +++++++++++-
 include/linux/sched/isolation.h                 |    1 +
 kernel/sched/isolation.c                        |    6 ++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..3797cd5c2b2e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1900,6 +1900,9 @@
 			  <cpu number> begins at 0 and the maximum value is
 			  "number of CPUs in system - 1".
 
+			freq
+			  Do not request current cpu frequency via IPI.
+
 			The format of <cpu-list> is described above.
 
 
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 804c49493938..e8fb917980a8 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -14,6 +14,7 @@
 #include <linux/percpu.h>
 #include <linux/cpufreq.h>
 #include <linux/smp.h>
+#include <linux/sched/isolation.h>
 
 #include "cpu.h"
 
@@ -86,6 +87,9 @@ unsigned int aperfmperf_get_khz(int cpu)
 	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
+	if (!housekeeping_cpu(cpu, HK_FLAG_FREQ))
+		return 0;
+
 	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
 	return per_cpu(samples.khz, cpu);
 }
@@ -102,9 +106,12 @@ void arch_freq_prepare_all(void)
 	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
 		return;
 
-	for_each_online_cpu(cpu)
+	for_each_online_cpu(cpu) {
+		if (!housekeeping_cpu(cpu, HK_FLAG_FREQ))
+			continue;
 		if (!aperfmperf_snapshot_cpu(cpu, now, false))
 			wait = true;
+	}
 
 	if (wait)
 		msleep(APERFMPERF_REFRESH_DELAY_MS);
@@ -118,6 +125,9 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
+	if (!housekeeping_cpu(cpu, HK_FLAG_FREQ))
+		return 0;
+
 	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
 		return per_cpu(samples.khz, cpu);
 
diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index b0fb1446fe04..88e6013ac8a9 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -13,6 +13,7 @@ enum hk_flags {
 	HK_FLAG_TICK		= (1 << 4),
 	HK_FLAG_DOMAIN		= (1 << 5),
 	HK_FLAG_WQ		= (1 << 6),
+	HK_FLAG_FREQ		= (1 << 7),
 };
 
 #ifdef CONFIG_CPU_ISOLATION
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index b02d148e7672..456b5f1dfa11 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -140,6 +140,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
+		if (!strncmp(str, "freq,", 5)) {
+			str += 5;
+			flags |= HK_FLAG_FREQ;
+			continue;
+		}
+
 		pr_warn("isolcpus: Error, unknown flag\n");
 		return 0;
 	}

