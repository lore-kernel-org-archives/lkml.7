Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7129DC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3202A2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WbMCTshb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfECL3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:29:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35571 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfECL3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:29:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x43BT7eQ2724884
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 3 May 2019 04:29:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x43BT7eQ2724884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556882948;
        bh=gHwBQ/agh8xF1zS7e1u4AxQC/ZUTirOvxUDcYC8SCSE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WbMCTshbbn/Dppy1Nf3yGqOVirHVRb/wmKn7X7wDE3V5Uep+CnTH+lhnMg05sFOcY
         v0dsgh0B6d9ubA1f7jNCR/LwxVPBY/7tpi92pYj4/Lyb9E0PGefR4U14O+0Z7F4yTg
         g+UbU5SgSW+k3G4f4ET4j2f5G1yzwUET3QIEKgk3+gLR3WfyXmD3L/c3k+8oqeGBXA
         wBUQClnNQHum6MQzD4EoIB+lXncVuc/2qgpI5sEtebEl6lB4JKB3wHgYR2fVHBW4dE
         6MP3DsVFDumWalbTwGLAmTfzzRWxVj52JYDSWNNKsVbsTQ3N8prRVMi6KRHpRNwEJH
         QmuynXgSBdwzg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x43BT6DD2724881;
        Fri, 3 May 2019 04:29:06 -0700
Date:   Fri, 3 May 2019 04:29:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nicholas Piggin <tipbot@zytor.com>
Message-ID: <tip-c2cb30bfceceba8a2a0d5713230a250dd6140e22@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        fweisbec@gmail.com, mingo@kernel.org, rafael.j.wysocki@intel.com,
        peterz@infradead.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, npiggin@gmail.com,
          torvalds@linux-foundation.org, fweisbec@gmail.com,
          peterz@infradead.org, rafael.j.wysocki@intel.com,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190411033448.20842-3-npiggin@gmail.com>
References: <20190411033448.20842-3-npiggin@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] power/suspend: Add function to disable secondaries
 for suspend
Git-Commit-ID: c2cb30bfceceba8a2a0d5713230a250dd6140e22
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

Commit-ID:  c2cb30bfceceba8a2a0d5713230a250dd6140e22
Gitweb:     https://git.kernel.org/tip/c2cb30bfceceba8a2a0d5713230a250dd6140e22
Author:     Nicholas Piggin <npiggin@gmail.com>
AuthorDate: Thu, 11 Apr 2019 13:34:45 +1000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 3 May 2019 12:53:14 +0200

power/suspend: Add function to disable secondaries for suspend

This adds a function to disable secondary CPUs for suspend that are
not necessarily non-zero / non-boot CPUs. Platforms will be able to
use this to suspend using non-zero CPUs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lkml.kernel.org/r/20190411033448.20842-3-npiggin@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/cpu.h      | 10 ++++++++++
 kernel/kexec_core.c      |  4 ++--
 kernel/power/hibernate.c | 12 ++++++------
 kernel/power/suspend.c   |  4 ++--
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 5041357d0297..563e697e7779 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -137,6 +137,16 @@ static inline int disable_nonboot_cpus(void)
 	return freeze_secondary_cpus(0);
 }
 extern void enable_nonboot_cpus(void);
+
+static inline int suspend_disable_secondary_cpus(void)
+{
+	return freeze_secondary_cpus(0);
+}
+static inline void suspend_enable_secondary_cpus(void)
+{
+	return enable_nonboot_cpus();
+}
+
 #else /* !CONFIG_PM_SLEEP_SMP */
 static inline int disable_nonboot_cpus(void) { return 0; }
 static inline void enable_nonboot_cpus(void) {}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d7140447be75..fd5c95ff9251 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1150,7 +1150,7 @@ int kernel_kexec(void)
 		error = dpm_suspend_end(PMSG_FREEZE);
 		if (error)
 			goto Resume_devices;
-		error = disable_nonboot_cpus();
+		error = suspend_disable_secondary_cpus();
 		if (error)
 			goto Enable_cpus;
 		local_irq_disable();
@@ -1183,7 +1183,7 @@ int kernel_kexec(void)
  Enable_irqs:
 		local_irq_enable();
  Enable_cpus:
-		enable_nonboot_cpus();
+		suspend_enable_secondary_cpus();
 		dpm_resume_start(PMSG_RESTORE);
  Resume_devices:
 		dpm_resume_end(PMSG_RESTORE);
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..cfc7a57049e4 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -281,7 +281,7 @@ static int create_image(int platform_mode)
 	if (error || hibernation_test(TEST_PLATFORM))
 		goto Platform_finish;
 
-	error = disable_nonboot_cpus();
+	error = suspend_disable_secondary_cpus();
 	if (error || hibernation_test(TEST_CPUS))
 		goto Enable_cpus;
 
@@ -323,7 +323,7 @@ static int create_image(int platform_mode)
 	local_irq_enable();
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Platform_finish:
 	platform_finish(platform_mode);
@@ -417,7 +417,7 @@ int hibernation_snapshot(int platform_mode)
 
 int __weak hibernate_resume_nonboot_cpu_disable(void)
 {
-	return disable_nonboot_cpus();
+	return suspend_disable_secondary_cpus();
 }
 
 /**
@@ -486,7 +486,7 @@ static int resume_target_kernel(bool platform_mode)
 	local_irq_enable();
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Cleanup:
 	platform_restore_cleanup(platform_mode);
@@ -564,7 +564,7 @@ int hibernation_platform_enter(void)
 	if (error)
 		goto Platform_finish;
 
-	error = disable_nonboot_cpus();
+	error = suspend_disable_secondary_cpus();
 	if (error)
 		goto Enable_cpus;
 
@@ -586,7 +586,7 @@ int hibernation_platform_enter(void)
 	local_irq_enable();
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Platform_finish:
 	hibernation_ops->finish();
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..59b6def23046 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -428,7 +428,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	if (suspend_test(TEST_PLATFORM))
 		goto Platform_wake;
 
-	error = disable_nonboot_cpus();
+	error = suspend_disable_secondary_cpus();
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
 
@@ -458,7 +458,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	BUG_ON(irqs_disabled());
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Platform_wake:
 	platform_resume_noirq(state);
