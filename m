Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A196DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B33020675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YSsQM/f0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfEWJXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:23:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51459 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfEWJXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:23:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9MXQa4039565
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:22:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9MXQa4039565
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603354;
        bh=JZC5p45HHrPfD4p50v1MbpkTyCQrDSGeIRlb9LsnWEs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YSsQM/f0VFTBeLXP8QJafg8gSwbbXZAf87dUpPQX1grJpqX9i4EAuqGxc7r8xT0w0
         jfOxs89Eybdjdm0Hz46WwQ+uMoQKks4AuhORmxTMB39JGlaI98uI7rLBOi0j9z8EtG
         zkifEgZ3DCy3yqoa1MKzNVwi6MoyM8YXuEN+f2RdE93VNJswZlpYAqrBkr7EBJt8cR
         MCScLP2icoHQx8o/lW/JRBOTxfN8exU1H4/Lz2zOdJeoFFE7/jA4Bb5Xf0BRcGNw7t
         izZ4bp/MpcQkAvB8pGwGpEHBMjbYz5AQjRlFUP8CEWE0TH7yglTy9cnJ9b8ual+PYf
         DeyeShX0AnxGg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9MW2L4039562;
        Thu, 23 May 2019 02:22:32 -0700
Date:   Thu, 23 May 2019 02:22:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Len Brown <tipbot@zytor.com>
Message-ID: <tip-7745f03eb39587dd15a1fb26e6223678b8e906d2@git.kernel.org>
Cc:     len.brown@intel.com, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, len.brown@intel.com, peterz@infradead.org
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] x86/topology: Add CPUID.1F multi-die/package
 support
Git-Commit-ID: 7745f03eb39587dd15a1fb26e6223678b8e906d2
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

Commit-ID:  7745f03eb39587dd15a1fb26e6223678b8e906d2
Gitweb:     https://git.kernel.org/tip/7745f03eb39587dd15a1fb26e6223678b8e906d2
Author:     Len Brown <len.brown@intel.com>
AuthorDate: Mon, 13 May 2019 13:58:45 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:30 +0200

x86/topology: Add CPUID.1F multi-die/package support

Some new systems have multiple software-visible die within each package.

Update Linux parsing of the Intel CPUID "Extended Topology Leaf" to handle
either CPUID.B, or the new CPUID.1F.

Add cpuinfo_x86.die_id and cpuinfo_x86.max_dies to store the result.

die_id will be non-zero only for multi-die/package systems.

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-doc@vger.kernel.org
Link: https://lkml.kernel.org/r/7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com

---
 Documentation/x86/topology.rst   |  4 ++
 arch/x86/include/asm/processor.h |  4 +-
 arch/x86/kernel/cpu/topology.c   | 85 +++++++++++++++++++++++++++++++---------
 arch/x86/kernel/smpboot.c        |  2 +
 4 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
index 6e28dbe818ab..8e9704f61017 100644
--- a/Documentation/x86/topology.rst
+++ b/Documentation/x86/topology.rst
@@ -49,6 +49,10 @@ Package-related topology information in the kernel:
 
     The number of cores in a package. This information is retrieved via CPUID.
 
+  - cpuinfo_x86.x86_max_dies:
+
+    The number of dies in a package. This information is retrieved via CPUID.
+
   - cpuinfo_x86.phys_proc_id:
 
     The physical ID of the package. This information is retrieved via CPUID
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c34a35c78618..ef0a44fccaec 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -105,7 +105,8 @@ struct cpuinfo_x86 {
 	int			x86_power;
 	unsigned long		loops_per_jiffy;
 	/* cpuid returned max cores value: */
-	u16			 x86_max_cores;
+	u16			x86_max_cores;
+	u16			x86_max_dies;
 	u16			apicid;
 	u16			initial_apicid;
 	u16			x86_clflush_size;
@@ -117,6 +118,7 @@ struct cpuinfo_x86 {
 	u16			logical_proc_id;
 	/* Core id: */
 	u16			cpu_core_id;
+	u16			cpu_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
 	u32			microcode;
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 8f6c784141d1..4d17e699657d 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -15,33 +15,63 @@
 /* leaf 0xb SMT level */
 #define SMT_LEVEL	0
 
-/* leaf 0xb sub-leaf types */
+/* extended topology sub-leaf types */
 #define INVALID_TYPE	0
 #define SMT_TYPE	1
 #define CORE_TYPE	2
+#define DIE_TYPE	5
 
 #define LEAFB_SUBTYPE(ecx)		(((ecx) >> 8) & 0xff)
 #define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
 #define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
 
-int detect_extended_topology_early(struct cpuinfo_x86 *c)
-{
 #ifdef CONFIG_SMP
+/*
+ * Check if given CPUID extended toplogy "leaf" is implemented
+ */
+static int check_extended_topology_leaf(int leaf)
+{
 	unsigned int eax, ebx, ecx, edx;
 
-	if (c->cpuid_level < 0xb)
+	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
+
+	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
 		return -1;
 
-	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
+	return 0;
+}
+/*
+ * Return best CPUID Extended Toplogy Leaf supported
+ */
+static int detect_extended_topology_leaf(struct cpuinfo_x86 *c)
+{
+	if (c->cpuid_level >= 0x1f) {
+		if (check_extended_topology_leaf(0x1f) == 0)
+			return 0x1f;
+	}
 
-	/*
-	 * check if the cpuid leaf 0xb is actually implemented.
-	 */
-	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
+	if (c->cpuid_level >= 0xb) {
+		if (check_extended_topology_leaf(0xb) == 0)
+			return 0xb;
+	}
+
+	return -1;
+}
+#endif
+
+int detect_extended_topology_early(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_SMP
+	unsigned int eax, ebx, ecx, edx;
+	int leaf;
+
+	leaf = detect_extended_topology_leaf(c);
+	if (leaf < 0)
 		return -1;
 
 	set_cpu_cap(c, X86_FEATURE_XTOPOLOGY);
 
+	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 	/*
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
@@ -52,7 +82,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
 }
 
 /*
- * Check for extended topology enumeration cpuid leaf 0xb and if it
+ * Check for extended topology enumeration cpuid leaf, and if it
  * exists, use it for populating initial_apicid and cpu topology
  * detection.
  */
@@ -60,22 +90,28 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
 	unsigned int eax, ebx, ecx, edx, sub_index;
-	unsigned int ht_mask_width, core_plus_mask_width;
+	unsigned int ht_mask_width, core_plus_mask_width, die_plus_mask_width;
 	unsigned int core_select_mask, core_level_siblings;
+	unsigned int die_select_mask, die_level_siblings;
+	int leaf;
 
-	if (detect_extended_topology_early(c) < 0)
+	leaf = detect_extended_topology_leaf(c);
+	if (leaf < 0)
 		return -1;
 
 	/*
 	 * Populate HT related information from sub-leaf level 0.
 	 */
-	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
+	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
+	c->initial_apicid = edx;
 	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
+	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 
 	sub_index = 1;
 	do {
-		cpuid_count(0xb, sub_index, &eax, &ebx, &ecx, &edx);
+		cpuid_count(leaf, sub_index, &eax, &ebx, &ecx, &edx);
 
 		/*
 		 * Check for the Core type in the implemented sub leaves.
@@ -83,23 +119,34 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 		if (LEAFB_SUBTYPE(ecx) == CORE_TYPE) {
 			core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
 			core_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-			break;
+			die_level_siblings = core_level_siblings;
+			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
+		}
+		if (LEAFB_SUBTYPE(ecx) == DIE_TYPE) {
+			die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
+			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 		}
 
 		sub_index++;
 	} while (LEAFB_SUBTYPE(ecx) != INVALID_TYPE);
 
 	core_select_mask = (~(-1 << core_plus_mask_width)) >> ht_mask_width;
-
-	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid, ht_mask_width)
-						 & core_select_mask;
-	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid, core_plus_mask_width);
+	die_select_mask = (~(-1 << die_plus_mask_width)) >>
+				core_plus_mask_width;
+
+	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid,
+				ht_mask_width) & core_select_mask;
+	c->cpu_die_id = apic->phys_pkg_id(c->initial_apicid,
+				core_plus_mask_width) & die_select_mask;
+	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid,
+				die_plus_mask_width);
 	/*
 	 * Reinit the apicid, now that we have extended initial_apicid.
 	 */
 	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
 
 	c->x86_max_cores = (core_level_siblings / smp_num_siblings);
+	c->x86_max_dies = (die_level_siblings / core_level_siblings);
 #endif
 	return 0;
 }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 73e69aaaa117..40ffe23249c0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -389,6 +389,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 		int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
 
 		if (c->phys_proc_id == o->phys_proc_id &&
+		    c->cpu_die_id == o->cpu_die_id &&
 		    per_cpu(cpu_llc_id, cpu1) == per_cpu(cpu_llc_id, cpu2)) {
 			if (c->cpu_core_id == o->cpu_core_id)
 				return topology_sane(c, o, "smt");
@@ -400,6 +401,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 		}
 
 	} else if (c->phys_proc_id == o->phys_proc_id &&
+		   c->cpu_die_id == o->cpu_die_id &&
 		   c->cpu_core_id == o->cpu_core_id) {
 		return topology_sane(c, o, "smt");
 	}
