Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535BFC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3245A20644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfFMVBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:01:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:57146 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729530AbfFMVBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:01:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 14:01:01 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2019 14:01:01 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Christopherson Sean J" <sean.j.christopherson@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 1/3] x86/resctrl: Get max rmid and occupancy scale directly from CPUID instead of cpuinfo_x86
Date:   Thu, 13 Jun 2019 13:51:02 -0700
Message-Id: <1560459064-195037-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
References: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although x86_cache_max_rmid and x86_cache_occ_scale are read only once
during resctrl initialization, they are always stored in cpuinfo_x86 on
each CPU during run time even if resctrl is not configured.

To save cpuinfo_x86 space and make CPU and resctrl initialization simpler,
remove the two fields from cpuinfo_x86 and get max rmid and occupancy
scale directly from CPUID during resctrl initialization. And since each
known platform that supports resctrl has same max rmid on all CPUs, no
need to scan all CPUs to find minimum of max rmid values, i.e. getting
max rmid from CPUID on the current CPU is fine.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/processor.h       |  3 ---
 arch/x86/kernel/cpu/common.c           | 28 --------------------------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 28 +++++++++++++++++++++++---
 4 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c34a35c78618..27e875d4ca7d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -99,9 +99,6 @@ struct cpuinfo_x86 {
 	/* in KB - valid for CPUS which support this call: */
 	unsigned int		x86_cache_size;
 	int			x86_cache_alignment;	/* In bytes */
-	/* Cache QoS architectural values: */
-	int			x86_cache_max_rmid;	/* max index */
-	int			x86_cache_occ_scale;	/* scale to bytes */
 	int			x86_power;
 	unsigned long		loops_per_jiffy;
 	/* cpuid returned max cores value: */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2c57fffebf9b..38e4b1a9005e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -840,22 +840,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_F_0_EDX] = edx;
 
 		if (cpu_has(c, X86_FEATURE_CQM_LLC)) {
-			/* will be overridden if occupancy monitoring exists */
-			c->x86_cache_max_rmid = ebx;
-
 			/* QoS sub-leaf, EAX=0Fh, ECX=1 */
 			cpuid_count(0x0000000F, 1, &eax, &ebx, &ecx, &edx);
 			c->x86_capability[CPUID_F_1_EDX] = edx;
-
-			if ((cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC)) ||
-			      ((cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL)) ||
-			       (cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)))) {
-				c->x86_cache_max_rmid = ecx;
-				c->x86_cache_occ_scale = ebx;
-			}
-		} else {
-			c->x86_cache_max_rmid = -1;
-			c->x86_cache_occ_scale = -1;
 		}
 	}
 
@@ -1269,20 +1256,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 #endif
 }
 
-static void x86_init_cache_qos(struct cpuinfo_x86 *c)
-{
-	/*
-	 * The heavy lifting of max_rmid and cache_occ_scale are handled
-	 * in get_cpu_cap().  Here we just set the max_rmid for the boot_cpu
-	 * in case CQM bits really aren't there in this CPU.
-	 */
-	if (c != &boot_cpu_data) {
-		boot_cpu_data.x86_cache_max_rmid =
-			min(boot_cpu_data.x86_cache_max_rmid,
-			    c->x86_cache_max_rmid);
-	}
-}
-
 /*
  * Validate that ACPI/mptables have the same information about the
  * effective APIC id and update the package map.
@@ -1391,7 +1364,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 #endif
 
 	x86_init_rdrand(c);
-	x86_init_cache_qos(c);
 	setup_pku(c);
 
 	/*
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e49b77283924..474a7090d2dd 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -579,7 +579,7 @@ int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
-int rdt_get_mon_l3_config(struct rdt_resource *r);
+int __init rdt_get_mon_l3_config(struct rdt_resource *r);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 1573a0a6b525..e9d876c25703 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -617,13 +617,35 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 		list_add_tail(&mbm_local_event.list, &r->evt_list);
 }
 
-int rdt_get_mon_l3_config(struct rdt_resource *r)
+static void __init get_cqm_info(struct rdt_resource *r)
+{
+	u32 eax, ebx, ecx, edx;
+
+	/*
+	 * At this point, CQM LLC and one of occupancy, MBM total, and
+	 * MBM local monitoring features must be supported.
+	 */
+	cpuid_count(0x0000000F, 0, &eax, &ebx, &ecx, &edx);
+	/* will be overridden if occupancy monitoring exists */
+	r->num_rmid = ebx + 1;
+
+	cpuid_count(0x0000000F, 1, &eax, &ebx, &ecx, &edx);
+
+	if (boot_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))
+		r->num_rmid = ecx + 1;
+
+	if (boot_cpu_has(X86_FEATURE_CQM_MBM_TOTAL) || boot_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))
+		r->mon_scale = ebx;
+	else
+		r->mon_scale = -1;
+}
+
+int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int cl_size = boot_cpu_data.x86_cache_size;
 	int ret;
 
-	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
-	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
+	get_cqm_info(r);
 
 	/*
 	 * A reasonable upper limit on the max threshold is the number
-- 
2.19.1

