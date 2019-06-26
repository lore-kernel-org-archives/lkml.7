Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BF9C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554DC217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfFZRvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:51:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:49814 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfFZRvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:51:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="337288582"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2019 10:51:08 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 01/10] x86/CPU: Expose if cache is inclusive of lower level caches
Date:   Wed, 26 Jun 2019 10:48:40 -0700
Message-Id: <34b9abb5e655a2781bae871814abeae726e4d129.1561569068.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1561569068.git.reinette.chatre@intel.com>
References: <cover.1561569068.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1561569068.git.reinette.chatre@intel.com>
References: <cover.1561569068.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deterministic cache parameters can be learned from CPUID leaf 04H.
Executing CPUID with a particular index in EAX would return the cache
parameters associated with that index in the EAX, EBX, ECX, and EDX
registers.

At this time, when discovering cache parameters for a particular cache
index, only the parameters returned in EAX, EBX, and ECX are parsed.
Parameters returned in EDX are ignored. One of the parameters in EDX,
whether the cache is inclusive of lower level caches, is valuable to
know when determining if a system can support L3 cache pseudo-locking.
If the L3 cache is not inclusive then pseudo-locked data within the L3
cache would be evicted when migrated to L2.

Add support for parsing the cache parameters obtained from EDX and make
the inclusive cache parameter available via the cacheinfo that can be
queried from the cache pseudo-locking code.

Do not expose this information to user space at this time. At this time
this information is required within the kernel only. Also, it is
not obvious what the best formatting of this information should be in
support of the variety of ways users may use this information.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/cacheinfo.c | 42 +++++++++++++++++++++++++++++----
 include/linux/cacheinfo.h       |  4 ++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 395d46f78582..f99104673329 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -154,10 +154,33 @@ union _cpuid4_leaf_ecx {
 	u32 full;
 };
 
+/*
+ * According to details about CPUID instruction documented in Intel SDM
+ * the third bit of the EDX register is used to indicate if complex
+ * cache indexing is in use.
+ * According to AMD specification (Open Source Register Reference For AMD
+ * Family 17h processors Models 00h-2Fh 56255 Rev 3.03 - July, 2018), only
+ * the first two bits are in use. Since HYGON is based on AMD the
+ * assumption is that it supports the same.
+ *
+ * There is no consumer for the complex indexing information so this bit is
+ * not added to the declaration of what processor can provide in EDX
+ * register. The declaration thus only considers bits supported by all
+ * architectures.
+ */
+union _cpuid4_leaf_edx {
+	struct {
+		unsigned int		wbinvd_no_guarantee:1;
+		unsigned int		inclusive:1;
+	} split;
+	u32 full;
+};
+
 struct _cpuid4_info_regs {
 	union _cpuid4_leaf_eax eax;
 	union _cpuid4_leaf_ebx ebx;
 	union _cpuid4_leaf_ecx ecx;
+	union _cpuid4_leaf_edx edx;
 	unsigned int id;
 	unsigned long size;
 	struct amd_northbridge *nb;
@@ -595,21 +618,24 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
 	union _cpuid4_leaf_eax	eax;
 	union _cpuid4_leaf_ebx	ebx;
 	union _cpuid4_leaf_ecx	ecx;
-	unsigned		edx;
+	union _cpuid4_leaf_edx	edx;
+
+	edx.full = 0;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
 		if (boot_cpu_has(X86_FEATURE_TOPOEXT))
 			cpuid_count(0x8000001d, index, &eax.full,
-				    &ebx.full, &ecx.full, &edx);
+				    &ebx.full, &ecx.full, &edx.full);
 		else
 			amd_cpuid4(index, &eax, &ebx, &ecx);
 		amd_init_l3_cache(this_leaf, index);
 	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		cpuid_count(0x8000001d, index, &eax.full,
-			    &ebx.full, &ecx.full, &edx);
+			    &ebx.full, &ecx.full, &edx.full);
 		amd_init_l3_cache(this_leaf, index);
 	} else {
-		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &edx);
+		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full,
+			    &edx.full);
 	}
 
 	if (eax.split.type == CTYPE_NULL)
@@ -618,6 +644,7 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
 	this_leaf->eax = eax;
 	this_leaf->ebx = ebx;
 	this_leaf->ecx = ecx;
+	this_leaf->edx = edx;
 	this_leaf->size = (ecx.split.number_of_sets          + 1) *
 			  (ebx.split.coherency_line_size     + 1) *
 			  (ebx.split.physical_line_partition + 1) *
@@ -983,6 +1010,13 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->number_of_sets = base->ecx.split.number_of_sets + 1;
 	this_leaf->physical_line_partition =
 				base->ebx.split.physical_line_partition + 1;
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	     boot_cpu_has(X86_FEATURE_TOPOEXT)) ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
+		this_leaf->attributes |= CACHE_INCLUSIVE_SET;
+		this_leaf->inclusive = base->edx.split.inclusive;
+	}
 	this_leaf->priv = base->nb;
 }
 
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 70e19bc6cc9f..2550b5ce7fea 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -31,6 +31,8 @@ enum cache_type {
  * @physical_line_partition: number of physical cache lines sharing the
  *	same cachetag
  * @size: Total size of the cache
+ * @inclusive: Cache is inclusive of lower level caches. Only valid if
+ *	CACHE_INCLUSIVE_SET attribute is set.
  * @shared_cpu_map: logical cpumask representing all the cpus sharing
  *	this cache node
  * @attributes: bitfield representing various cache attributes
@@ -53,6 +55,7 @@ struct cacheinfo {
 	unsigned int ways_of_associativity;
 	unsigned int physical_line_partition;
 	unsigned int size;
+	unsigned int inclusive;
 	cpumask_t shared_cpu_map;
 	unsigned int attributes;
 #define CACHE_WRITE_THROUGH	BIT(0)
@@ -64,6 +67,7 @@ struct cacheinfo {
 #define CACHE_ALLOCATE_POLICY_MASK	\
 	(CACHE_READ_ALLOCATE | CACHE_WRITE_ALLOCATE)
 #define CACHE_ID		BIT(4)
+#define CACHE_INCLUSIVE_SET	BIT(5)
 	void *fw_token;
 	bool disable_sysfs;
 	void *priv;
-- 
2.17.2

