Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB9EC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366852084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLl9hNwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfDKDfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:35:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43956 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKDfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:35:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so2766334pgu.10;
        Wed, 10 Apr 2019 20:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNWp/JYAk75hC4HoWk0MvjkPFwZd8/2hFPRLSvOXOzA=;
        b=OLl9hNwtQd2tB2gY61TlRWKsYN1lJrQaRCJPgoKV/o/v19h1MGYYtfn3hqMDcMiDv7
         MlKokVZ7JhzBXCEOi7CCWEQOBLnCFiSgFc2gzOWEVuu0nS6wcvgMMSUUT11hgdzYTmpn
         vFH9Uj5fgfzYwWF619iOjKD/l3KdB0lD9yVxnhqkJNv2gpbUNk+wCj5AY4tjJxUc5itU
         25EsAujPh5U/3AFe0WWBbw+I8or9RlVbH8n3VQ+mk1hiRkZDoSX4zT9ApFaUv7js1JzW
         Go6Fnfvy7y1ArMpTZBHhCUZSesr/PenYyTJMdl4/8znL0E6RHDd8c5Dp3EsubPuUTqeV
         Df6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNWp/JYAk75hC4HoWk0MvjkPFwZd8/2hFPRLSvOXOzA=;
        b=iVAa47khjo0m71zUTMlmHfczXLFDcFMRDMEnpIVCi+i4Jn54SWivVglIjuLWg5tCVF
         +XGHlYtKtUN6aRDMZOEv/XAqehfAszuKokVTw+Yd2GTnuPsKU4kJNtqFCObO8K/vLPNd
         wOxs+M0t2QV32kTjr7wa74QwXuoIf6m4FZoqnMdXiW9xi2w7j+RCc09YzXhiRVJ54Ee5
         F9+wHGTXYF4Vjsf3DnnQ5hMIx7HvHn/8ykxsC45kUi1+HJqp/nOz7C7qNDxXY/SuH+T0
         p2JUYuF8lOcOmptJ1nmU0Ku0gNa6ejzXL8e3eMAV4xZfXlyxSpAiMvRTqeumfWRvHYir
         w9sA==
X-Gm-Message-State: APjAAAXSClelUe7v71WwBQ4lT0MOZRtHAqwnAzWCbSlaMZqFyjzx3qaM
        ik+fQnEfssjIZer1zh3PhfQ=
X-Google-Smtp-Source: APXvYqyDgWG4ci3RtiypzLC3Kgjv3A2jZhQBoW86sUX8p83WdFga8vK543Il4hpAUUzCUxz68qhcrQ==
X-Received: by 2002:a63:2b41:: with SMTP id r62mr42647693pgr.403.1554953716793;
        Wed, 10 Apr 2019 20:35:16 -0700 (PDT)
Received: from bobo.local0.net ([203.63.188.231])
        by smtp.gmail.com with ESMTPSA id b9sm37231416pfd.32.2019.04.10.20.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 20:35:16 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/5] kernel/cpu: Allow non-zero CPU to be primary for suspend / kexec freeze
Date:   Thu, 11 Apr 2019 13:34:46 +1000
Message-Id: <20190411033448.20842-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411033448.20842-1-npiggin@gmail.com>
References: <20190411033448.20842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 563e697e7779..dd3813959d62 100644
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
-- 
2.20.1

