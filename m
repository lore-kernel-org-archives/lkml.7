Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3996DC04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ED620866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556684683;
	bh=MFqRd9no9f4bQIPIfU9XYPtBqxr/HsAb9daQ9y2wNJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=Qvf/EbW3VkvH0UgxPt2qX6JnsNNYbpZtBsA0k12pv/OFj41FK3loCJfczqr6mu75G
	 4OKwpQNZDrbuttewaGf0IaX55+aVNs5csAaczBVKEw73NqqbQcDLUiCrcqLI+aWA4Z
	 4iBCr4iXJpp4/eYTnoXVrUmxhvhBOPcclGG2oQkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfEAEYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:24:41 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:56250 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfEAEYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:39 -0400
Received: by mail-it1-f196.google.com with SMTP id w130so8318020itc.5;
        Tue, 30 Apr 2019 21:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=isOyLkQGIr28y954+xXmnr2KCoPmXbiRFpy/WFUCd6k=;
        b=qIvFbygzhhkX34dCerxJLtL9Ok+IYl2hARsOkud/SaiN2XCSb3O6T0pXPFRIm8kykW
         nS2dGeiupT4z4cqgQoNzX4TGnbs8Qzkwad6CWx+t5/CkVw5G6QmhH9XXlvSr2eRND02O
         2N3zqSIRdQLkkId/SlpadAbRco5eJ2hdycli+Ek4bZ33/2EIJugMmxyb/IvOjWdQBUaV
         QFJXn7jXaG3cgM6VDDDpXQEPWV6gaR0pNJHBK69eS4nfXN52BwcH0T37CMFLrY+/ZClu
         IxhiTIfjBBCnghIoKzW6xbh6aDnopY5JlWRL3wj0hufpDQv07mkTY8DrptWKydXrDshx
         rmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=isOyLkQGIr28y954+xXmnr2KCoPmXbiRFpy/WFUCd6k=;
        b=PpzfQ3Tq8xvWtLAH8CEfb5atlLIfUGBAcyT+NQnWTwXWUMRREIQq/hdZHupx3slEi/
         9wbdPUPhSNQry+DUozYP9uGkSBRMn6JxPhe2NM5FqjpYZ6iTvQVmqHHWYZ695eUbYg6+
         S85YjJH/eb5w4LkmVU/1TQyaG0KI49c2uv6G9LLN7iFaln8UcUhIXGxydBU+8jp1+1Y2
         jm63SsQWPAYX3IEE4Y5UpScjSsi8f03UpjfFiY0l0FU93yglViXDxDw9/rVZfOJk4gLY
         q5UI8Ip4AtQVvtuEJM8JpREnTn4lzRRO2Oyn9vD0PDf4alZkw3TM9NkAParzm+DU8R45
         hLdg==
X-Gm-Message-State: APjAAAXpzxCaVxaLGvKbeTnk7m5wMKDluzNxC2tZMORt0bgXbAhvQzB0
        Ci+h4Ob3E8q60gakNioou+0=
X-Google-Smtp-Source: APXvYqw/Zfg51QY3Xssm1fg/rZBSPWdIwT5uadnm0wwTyQhfZkxvnCeUdSMgMYS9K1jFEE8OeWX/iA==
X-Received: by 2002:a24:1f50:: with SMTP id d77mr6392514itd.25.1556684679088;
        Tue, 30 Apr 2019 21:24:39 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:38 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 04/18] x86 topology: Add CPUID.1F multi-die/package support
Date:   Wed,  1 May 2019 00:24:13 -0400
Message-Id: <0b3e54cf35965be35725730b7a50d00068518f75.1556657368.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Some new systems have multiple software-visible die within each package.

Update Linux parsing of the Intel CPUID "Extended Topology Leaf"
to handle either CPUID.B, or the new CPUID.1F.

Add cpuinfo_x86.die_id and cpuinfo_x86.max_dies to store the result.

die_id will be non-zero only for multi-die/package systems.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/x86/topology.txt   |  4 ++
 arch/x86/include/asm/processor.h |  4 +-
 arch/x86/kernel/cpu/topology.c   | 85 +++++++++++++++++++++++++-------
 arch/x86/kernel/smpboot.c        |  2 +
 4 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/Documentation/x86/topology.txt b/Documentation/x86/topology.txt
index 06b3cdbc4048..8107b6cfc9ea 100644
--- a/Documentation/x86/topology.txt
+++ b/Documentation/x86/topology.txt
@@ -46,6 +46,10 @@ The topology of a system is described in the units of:
 
     The number of cores in a package. This information is retrieved via CPUID.
 
+  - cpuinfo_x86.x86_max_dies:
+
+    The number of dies in a package. This information is retrieved via CPUID.
+
   - cpuinfo_x86.phys_proc_id:
 
     The physical ID of the package. This information is retrieved via CPUID
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2bb3a648fc12..2507edc30cc2 100644
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
index 3f8bbfb26c18..05f9cfdddffd 100644
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
-- 
2.18.0-rc0

