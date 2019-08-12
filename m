Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63001C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3254720842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="b5j3AeW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfHLMzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:55:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38649 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfHLMzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:55:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7CCt2FV912556
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 05:55:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7CCt2FV912556
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565614503;
        bh=e0XeqREdmjtlsxYNmoBWWlkE7ITelU6OmSaYjy9hmkA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=b5j3AeW4Pw2v1YtAP92c+RvJkMLsCSB9BxqcQ41A+0t62AIeknnHucvsxuTyj3Vt8
         kPnT5hjYkl532a8x4f+SKBWcYw34Ti69DQjeXEQVt9o4tl0blJkbtdNhWbSpt648pp
         f+/bXqcjTIaAbglGqipkl0T2zTVQn/oQMUhrNq7mCKC9Le2LTLr/zpRYQeCa0jlCez
         2DHt//gGvJG6I3KIhnfJa71sChCKQqpJ/Gpygp7mAAhIbP2inNjiYYrs0n5gJ5sHiN
         GDRjfOC/pXeBNa4On/spX44wG0cQGAn+dInBA1vL3SXIlsfz+sTXaklNjQCoVtKeaB
         wJVAh+3gGxtWw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7CCt2kw912553;
        Mon, 12 Aug 2019 05:55:02 -0700
Date:   Mon, 12 Aug 2019 05:55:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Fenghua Yu <tipbot@zytor.com>
Message-ID: <tip-e7409258845a0f64967f8377e99294d438137537@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        valdis.kletnieks@vt.edu, hpa@zytor.com, fenghua.yu@intel.com
Reply-To: hpa@zytor.com, mingo@kernel.org, fenghua.yu@intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          valdis.kletnieks@vt.edu
In-Reply-To: <1565401237-60936-1-git-send-email-fenghua.yu@intel.com>
References: <1565401237-60936-1-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/umwait: Fix error handling in umwait_init()
Git-Commit-ID: e7409258845a0f64967f8377e99294d438137537
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

Commit-ID:  e7409258845a0f64967f8377e99294d438137537
Gitweb:     https://git.kernel.org/tip/e7409258845a0f64967f8377e99294d438137537
Author:     Fenghua Yu <fenghua.yu@intel.com>
AuthorDate: Fri, 9 Aug 2019 18:40:37 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 12 Aug 2019 14:51:13 +0200

x86/umwait: Fix error handling in umwait_init()

Currently, failure of cpuhp_setup_state() is ignored and the syscore ops
and the control interfaces can still be added even after the failure. But,
this error handling will cause a few issues:

1. The CPUs may have different values in the IA32_UMWAIT_CONTROL
   MSR because there is no way to roll back the control MSR on
   the CPUs which already set the MSR before the failure.

2. If the sysfs interface is added successfully, there will be a mismatch
   between the global control value and the control MSR:
   - The interface shows the default global control value. But,
     the control MSR is not set to the value because the CPU online
     function, which is supposed to set the MSR to the value,
     is not installed.
   - If the sysadmin changes the global control value through
     the interface, the control MSR on all current online CPUs is
     set to the new value. But, the control MSR on newly onlined CPUs
     after the value change will not be set to the new value due to
     lack of the CPU online function.

3. On resume from suspend/hibernation, the boot CPU restores the control
   MSR to the global control value through the syscore ops. But, the
   control MSR on all APs is not set due to lake of the CPU online
   function.

To solve the issues and enforce consistent behavior on the failure
of the CPU hotplug setup, make the following changes:

1. Cache the original control MSR value which is configured by
   hardware or BIOS before kernel boot. This value is likely to
   be 0. But it could be a different number as well. Cache the
   control MSR only once before the MSR is changed.
2. Add the CPU offline function so that the MSR is restored to the
   original control value on all CPUs on the failure.
3. On the failure, exit from cpumait_init() so that the syscore ops
   and the control interfaces are not added.

Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1565401237-60936-1-git-send-email-fenghua.yu@intel.com

---
 arch/x86/kernel/cpu/umwait.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index 6a204e7336c1..32b4dc9030aa 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -17,6 +17,12 @@
  */
 static u32 umwait_control_cached = UMWAIT_CTRL_VAL(100000, UMWAIT_C02_ENABLE);
 
+/*
+ * Cache the original IA32_UMWAIT_CONTROL MSR value which is configured by
+ * hardware or BIOS before kernel boot.
+ */
+static u32 orig_umwait_control_cached __ro_after_init;
+
 /*
  * Serialize access to umwait_control_cached and IA32_UMWAIT_CONTROL MSR in
  * the sysfs write functions.
@@ -52,6 +58,23 @@ static int umwait_cpu_online(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * The CPU hotplug callback sets the control MSR to the original control
+ * value.
+ */
+static int umwait_cpu_offline(unsigned int cpu)
+{
+	/*
+	 * This code is protected by the CPU hotplug already and
+	 * orig_umwait_control_cached is never changed after it caches
+	 * the original control MSR value in umwait_init(). So there
+	 * is no race condition here.
+	 */
+	wrmsr(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached, 0);
+
+	return 0;
+}
+
 /*
  * On resume, restore IA32_UMWAIT_CONTROL MSR on the boot processor which
  * is the only active CPU at this time. The MSR is set up on the APs via the
@@ -185,8 +208,22 @@ static int __init umwait_init(void)
 	if (!boot_cpu_has(X86_FEATURE_WAITPKG))
 		return -ENODEV;
 
+	/*
+	 * Cache the original control MSR value before the control MSR is
+	 * changed. This is the only place where orig_umwait_control_cached
+	 * is modified.
+	 */
+	rdmsrl(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached);
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait:online",
-				umwait_cpu_online, NULL);
+				umwait_cpu_online, umwait_cpu_offline);
+	if (ret < 0) {
+		/*
+		 * On failure, the control MSR on all CPUs has the
+		 * original control value.
+		 */
+		return ret;
+	}
 
 	register_syscore_ops(&umwait_syscore_ops);
 
