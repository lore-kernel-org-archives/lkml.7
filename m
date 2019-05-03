Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B24C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CEB20675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GPCqNfcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfECRrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 13:47:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35789 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfECRrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 13:47:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x43HkvXS2844948
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 3 May 2019 10:46:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x43HkvXS2844948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556905618;
        bh=gKf+2owCpWj0eTCYpgJAlMuwj6LW9QCuh/w2l7EapU4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=GPCqNfcWWix03t2frmUAqDiHm+Bol57YC02n+33s7RzXs0SlXhBhGIPlVVfgjHO8g
         b7pdlipQzKvhB8zmkzOyr/WLBp6jtCQwPjRAGNoy1BpwfKpg5+WxFO9Cf1AEn8HGae
         pfER7U6HuqmzYpHUeHy/RSyiIT2Z4UuBJYhHhTHEKH4D3C6w85UVazoJWssVBUxcc+
         53mPohaJkXwGSSKdK0jdf9UuNCi8rnL8rT0qogdbMdglhlJLFy8v7XVnPG5Rtk85fD
         yWRR/qx1641Xa7wbdUdVCwXTSRRDTu/+VzWLin96oloCHtbvo813d1ADC/3X+jIFuc
         oi+E8ATeYzWMA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x43Hkvt42844945;
        Fri, 3 May 2019 10:46:57 -0700
Date:   Fri, 3 May 2019 10:46:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nicholas Piggin <tipbot@zytor.com>
Message-ID: <tip-9ca12ac04bb7d7cfb28aa549dcd3d15761f15543@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com, npiggin@gmail.com,
        rafael.j.wysocki@intel.com, fweisbec@gmail.com,
        peterz@infradead.org
Reply-To: peterz@infradead.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, fweisbec@gmail.com,
          npiggin@gmail.com, rafael.j.wysocki@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190411033448.20842-4-npiggin@gmail.com>
References: <20190411033448.20842-4-npiggin@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] kernel/cpu: Allow non-zero CPU to be primary for
 suspend / kexec freeze
Git-Commit-ID: 9ca12ac04bb7d7cfb28aa549dcd3d15761f15543
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

Commit-ID:  9ca12ac04bb7d7cfb28aa549dcd3d15761f15543
Gitweb:     https://git.kernel.org/tip/9ca12ac04bb7d7cfb28aa549dcd3d15761f15543
Author:     Nicholas Piggin <npiggin@gmail.com>
AuthorDate: Thu, 11 Apr 2019 13:34:46 +1000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 3 May 2019 19:42:58 +0200

kernel/cpu: Allow non-zero CPU to be primary for suspend / kexec freeze

This patch provides an arch option, ARCH_SUSPEND_NONZERO_CPU, to
opt-in to allowing suspend to occur on one of the housekeeping CPUs
rather than hardcoded CPU0.

This will allow CPU0 to be a nohz_full CPU with a later change.

It may be possible for platforms with hardware/firmware restrictions
on suspend/wake effectively support this by handing off the final
stage to CPU0 when kernel housekeeping is no longer required. Another
option is to make housekeeping / nohz_full mask dynamic at runtime,
but the complexity could not be justified at this time.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lkml.kernel.org/r/20190411033448.20842-4-npiggin@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/powerpc/Kconfig |  4 ++++
 include/linux/cpu.h  |  7 ++++++-
 kernel/cpu.c         | 10 +++++++++-
 kernel/power/Kconfig |  9 +++++++++
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2d0be82c3061..bc98b0e37a10 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -318,6 +318,10 @@ config ARCH_SUSPEND_POSSIBLE
 		   (PPC_85xx && !PPC_E500MC) || PPC_86xx || PPC_PSERIES \
 		   || 44x || 40x
 
+config ARCH_SUSPEND_NONZERO_CPU
+	def_bool y
+	depends on PPC_POWERNV || PPC_PSERIES
+
 config PPC_DCR_NATIVE
 	bool
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 7ab2f09c0a14..73baab8535c1 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -140,7 +140,12 @@ extern void enable_nonboot_cpus(void);
 
 static inline int suspend_disable_secondary_cpus(void)
 {
-	return freeze_secondary_cpus(0);
+	int cpu = 0;
+
+	if (IS_ENABLED(CONFIG_PM_SLEEP_SMP_NONZERO_CPU))
+		cpu = -1;
+
+	return freeze_secondary_cpus(cpu);
 }
 static inline void suspend_enable_secondary_cpus(void)
 {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6754f3ecfd94..d1bf6e2b4752 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -9,6 +9,7 @@
 #include <linux/notifier.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/hotplug.h>
+#include <linux/sched/isolation.h>
 #include <linux/sched/task.h>
 #include <linux/sched/smt.h>
 #include <linux/unistd.h>
@@ -1199,8 +1200,15 @@ int freeze_secondary_cpus(int primary)
 	int cpu, error = 0;
 
 	cpu_maps_update_begin();
-	if (!cpu_online(primary))
+	if (primary == -1) {
 		primary = cpumask_first(cpu_online_mask);
+		if (!housekeeping_cpu(primary, HK_FLAG_TIMER))
+			primary = housekeeping_any_cpu(HK_FLAG_TIMER);
+	} else {
+		if (!cpu_online(primary))
+			primary = cpumask_first(cpu_online_mask);
+	}
+
 	/*
 	 * We take down all of the non-boot CPUs in one shot to avoid races
 	 * with the userspace trying to use the CPU hotplug at the same time
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index f8fe57d1022e..9bbaaab14b36 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -114,6 +114,15 @@ config PM_SLEEP_SMP
 	depends on PM_SLEEP
 	select HOTPLUG_CPU
 
+config PM_SLEEP_SMP_NONZERO_CPU
+	def_bool y
+	depends on PM_SLEEP_SMP
+	depends on ARCH_SUSPEND_NONZERO_CPU
+	---help---
+	If an arch can suspend (for suspend, hibernate, kexec, etc) on a
+	non-zero numbered CPU, it may define ARCH_SUSPEND_NONZERO_CPU. This
+	will allow nohz_full mask to include CPU0.
+
 config PM_AUTOSLEEP
 	bool "Opportunistic sleep"
 	depends on PM_SLEEP
