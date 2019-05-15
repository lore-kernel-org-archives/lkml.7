Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE1EC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24282084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="bvsQ4eTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfEOG7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:59:07 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:38554 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbfEOG7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:59:07 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id D1EED2E0290;
        Wed, 15 May 2019 09:59:02 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id I9rO96rdhK-x0wKCxql;
        Wed, 15 May 2019 09:59:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1557903542; bh=J6Gqte5fWOQxHzdibxGA6GXb8sU6FsUmN6IkmjfqrwQ=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=bvsQ4eTrbbQurt9NCOPvV0RB6u/q3GBd9qPPjrA9m/M5jCHDOk+5xf2eKHFYSJg+w
         oyK+mVgW2svw8meMLeHa9HRGna3+1XcQlyw1uHe+bMKaXSZhYYlL7rFwPcUhUh6j96
         xhDLgXEDC7Hb1qjHoR5wu80fsBm3zJNcbHMyTA00=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ed19:3833:7ce1:2324])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id jUOPFec0Xi-x0dGWP7K;
        Wed, 15 May 2019 09:59:00 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] x86/cpu: disable frequency requests via aperfmperf IPI for
 nohz_full CPUs
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>, x86@kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date:   Wed, 15 May 2019 09:59:00 +0300
Message-ID: <155790354043.1104.15333317408370209.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7d5905dc14a8 ("x86 / CPU: Always show current CPU frequency
in /proc/cpuinfo") open and read of /proc/cpuinfo sends IPI to all CPUs.
Many applications read /proc/cpuinfo at the start for trivial reasons like
counting cores or detecting cpu features. While sensitive workloads like
DPDK network polling don't like any interrupts.

This patch integrates this feature with cpu isolation and does not send
IPI to cpus without housekeeping flag HK_FLAG_MISC (set by nohz_full).

Code that requests cpu frequency like show_cpuinfo() falls back to last
frequency set by cpufreq driver if direct method returns 0.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: http://lkml.kernel.org/r/155618921176.2006.3031084313219003524.stgit@buzz
---
 arch/x86/kernel/cpu/aperfmperf.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 64d5aec24203..0be5ef97fd8f 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -14,6 +14,7 @@
 #include <linux/percpu.h>
 #include <linux/cpufreq.h>
 #include <linux/smp.h>
+#include <linux/sched/isolation.h>
 
 #include "cpu.h"
 
@@ -86,6 +87,9 @@ unsigned int aperfmperf_get_khz(int cpu)
 	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
+	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+		return 0;
+
 	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
 	return per_cpu(samples.khz, cpu);
 }
@@ -102,9 +106,12 @@ void arch_freq_prepare_all(void)
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
@@ -118,6 +125,9 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
+	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+		return 0;
+
 	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
 		return per_cpu(samples.khz, cpu);
 

