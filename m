Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA416C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762E520872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WoDriALp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfDPRKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:10:39 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:52424 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPRKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:10:36 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 3A5C010C0847;
        Tue, 16 Apr 2019 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555434636; bh=zV3bLuswEzbFq98ePW3iRGLKvVhtVlUfXfWKRFePagI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoDriALpYRdbe+xmipXoTM2v7OYNYXMBaYDFL2sCPmUrms3CJBc8cP9AnqTHqPhXw
         +iYepBFtu9UMRSFv90EAtNUF6VZnNHV31cbwwM6KHXmesd49Y25fY1NqFuav8eFAVR
         ZvFlJvALrgestXSNrEu4cr0qXdzQd2BNmNsgCuUQd5F7IdhF177bI+de+aSvtBrDz/
         PuR3znYo+7UOPoNY8uF2AJ2cwLLYVg+B17TaJ49CZAUdnK/WPP1B4hltoiOj6XbXNH
         lRiHn2RJiL3LkTwFXN9kyXwN780OLFnizlF1D/Gnixg3f8AEL4fj7d+A7b3uKe7zPm
         6151mfxaJI69A==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.106])
        by mailhost.synopsys.com (Postfix) with ESMTP id C80C9A023C;
        Tue, 16 Apr 2019 17:10:34 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH 3/3] ARC: cache: allow to autodetect L1 cache line size
Date:   Tue, 16 Apr 2019 20:10:21 +0300
Message-Id: <20190416171021.20049-4-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190416171021.20049-1-Eugeniy.Paltsev@synopsys.com>
References: <20190416171021.20049-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One step to "build once run anywhere"

Allow to autodetect L1 I/D caches line size in runtime instead of
relying on value provided via Kconfig.

This is controlled via CONFIG_ARC_CACHE_LINE_AUTODETECT Kconfig option
which is disabled by default.
 * In case of this option disabled there is no overhead in compare with
   current implementation.
 * In case of this option enabled there is some overhead in both speed
   and code size:
   - we use cache line size stored in the global variable instead of
     compile time available define, so compiler can't do some
     optimizations.
   - we align all cache related buffers by maximum possible cache line
     size. Nevertheless it isn't significant because we mostly use
     SMP_CACHE_BYTES or ARCH_DMA_MINALIGN to align stuff (they are
     equal to maximum possible cache line size)

Main change is the split L1_CACHE_BYTES for two separate defines:
 * L1_CACHE_BYTES      >= real L1 I$/D$ line size.
   Available at compile time. Used for alligning stuff.
 * CACHEOPS_L1_LINE_SZ == real L1 I$/D$ line size.
   Available at run time. Used in operations with cache lines/regions.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig             | 10 +++++
 arch/arc/include/asm/cache.h |  9 ++++-
 arch/arc/lib/memset-archs.S  |  8 +++-
 arch/arc/mm/cache.c          | 89 ++++++++++++++++++++++++++++++++++----------
 4 files changed, 94 insertions(+), 22 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index c781e45d1d99..e7eb5ff1485d 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -215,10 +215,20 @@ menuconfig ARC_CACHE
 
 if ARC_CACHE
 
+config ARC_CACHE_LINE_AUTODETECT
+	bool "Detect cache lines length automatically in runtime"
+	depends on ARC_HAS_ICACHE || ARC_HAS_DCACHE
+	help
+	  ARC has configurable cache line length. Enable this option to detect
+	  all cache lines length automatically in runtime to make kernel image
+	  runnable on HW with different cache lines configuration.
+	  If you don't know what the above means, leave this setting alone.
+
 config ARC_CACHE_LINE_SHIFT
 	int "Cache Line Length (as power of 2)"
 	range 5 7
 	default "6"
+	depends on !ARC_CACHE_LINE_AUTODETECT
 	help
 	  Starting with ARC700 4.9, Cache line length is configurable,
 	  This option specifies "N", with Line-len = 2 power N
diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
index f1642634aab0..0ff8e19008e4 100644
--- a/arch/arc/include/asm/cache.h
+++ b/arch/arc/include/asm/cache.h
@@ -15,15 +15,22 @@
 #define SMP_CACHE_BYTES		ARC_MAX_CACHE_BYTES
 #define ARCH_DMA_MINALIGN	ARC_MAX_CACHE_BYTES
 
+#if IS_ENABLED(CONFIG_ARC_CACHE_LINE_AUTODETECT)
+/*
+ * This must be used for aligning only. In case of cache line autodetect it is
+ * only safe to use maximum possible value here.
+ */
+#define L1_CACHE_SHIFT		ARC_MAX_CACHE_SHIFT
+#else
 /* In case $$ not config, setup a dummy number for rest of kernel */
 #ifndef CONFIG_ARC_CACHE_LINE_SHIFT
 #define L1_CACHE_SHIFT		6
 #else
 #define L1_CACHE_SHIFT		CONFIG_ARC_CACHE_LINE_SHIFT
 #endif
+#endif /* IS_ENABLED(CONFIG_ARC_CACHE_LINE_AUTODETECT) */
 
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
-#define CACHE_LINE_MASK		(~(L1_CACHE_BYTES - 1))
 
 /*
  * ARC700 doesn't cache any access in top 1G (0xc000_0000 to 0xFFFF_FFFF)
diff --git a/arch/arc/lib/memset-archs.S b/arch/arc/lib/memset-archs.S
index b3373f5c88e0..4baeeea29482 100644
--- a/arch/arc/lib/memset-archs.S
+++ b/arch/arc/lib/memset-archs.S
@@ -16,9 +16,15 @@
  * line lengths (32B and 128B) you should rewrite code carefully checking
  * we don't call any prefetchw/prealloc instruction for L1 cache lines which
  * don't belongs to memset area.
+ *
+ * TODO: FIXME: as for today we chose not optimized memset implementation if we
+ * enable ARC_CACHE_LINE_AUTODETECT option (as we don't know L1 cache line
+ * size in compile time).
+ * One possible way to fix this is to declare memset as a function pointer and
+ * update it when we discover actual cache line size.
  */
 
-#if L1_CACHE_SHIFT == 6
+#if (!IS_ENABLED(CONFIG_ARC_CACHE_LINE_AUTODETECT)) && (L1_CACHE_SHIFT == 6)
 
 .macro PREALLOC_INSTR	reg, off
 	prealloc	[\reg, \off]
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 1036bd56f518..8d006c1d12a1 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -25,6 +25,22 @@
 #define USE_RGN_FLSH	1
 #endif
 
+/*
+ * Cache line defines and real L1 I$/D$ line size relations:
+ *
+ * L1_CACHE_BYTES      >= real L1 I$/D$ line size. Available at compile time.
+ * CACHEOPS_L1_LINE_SZ == real L1 I$/D$ line size. Available at run time.
+ */
+#if IS_ENABLED(CONFIG_ARC_CACHE_LINE_AUTODETECT)
+#define CACHEOPS_L1_LINE_SZ		l1_line_sz
+#define CACHEOPS_L1_LINE_MASK		l1_line_mask
+#else
+#define CACHEOPS_L1_LINE_SZ		L1_CACHE_BYTES
+#define CACHEOPS_L1_LINE_MASK		(~((CACHEOPS_L1_LINE_SZ) - 1))
+#endif /* IS_ENABLED(CONFIG_ARC_CACHE_LINE_AUTODETECT) */
+
+static unsigned int l1_line_sz;
+static unsigned long l1_line_mask;
 static int l2_line_sz;
 static int ioc_exists;
 int slc_enable = 1, ioc_enable = 1;
@@ -256,19 +272,19 @@ void __cache_line_loop_v2(phys_addr_t paddr, unsigned long vaddr,
 	 *  -@sz will be integral multiple of line size (being page sized).
 	 */
 	if (!full_page) {
-		sz += paddr & ~CACHE_LINE_MASK;
-		paddr &= CACHE_LINE_MASK;
-		vaddr &= CACHE_LINE_MASK;
+		sz += paddr & ~CACHEOPS_L1_LINE_MASK;
+		paddr &= CACHEOPS_L1_LINE_MASK;
+		vaddr &= CACHEOPS_L1_LINE_MASK;
 	}
 
-	num_lines = DIV_ROUND_UP(sz, L1_CACHE_BYTES);
+	num_lines = DIV_ROUND_UP(sz, CACHEOPS_L1_LINE_SZ);
 
 	/* MMUv2 and before: paddr contains stuffed vaddrs bits */
 	paddr |= (vaddr >> PAGE_SHIFT) & 0x1F;
 
 	while (num_lines-- > 0) {
 		write_aux_reg(aux_cmd, paddr);
-		paddr += L1_CACHE_BYTES;
+		paddr += CACHEOPS_L1_LINE_SZ;
 	}
 }
 
@@ -302,11 +318,11 @@ void __cache_line_loop_v3(phys_addr_t paddr, unsigned long vaddr,
 	 *  -@sz will be integral multiple of line size (being page sized).
 	 */
 	if (!full_page) {
-		sz += paddr & ~CACHE_LINE_MASK;
-		paddr &= CACHE_LINE_MASK;
-		vaddr &= CACHE_LINE_MASK;
+		sz += paddr & ~CACHEOPS_L1_LINE_MASK;
+		paddr &= CACHEOPS_L1_LINE_MASK;
+		vaddr &= CACHEOPS_L1_LINE_MASK;
 	}
-	num_lines = DIV_ROUND_UP(sz, L1_CACHE_BYTES);
+	num_lines = DIV_ROUND_UP(sz, CACHEOPS_L1_LINE_SZ);
 
 	/*
 	 * MMUv3, cache ops require paddr in PTAG reg
@@ -328,11 +344,11 @@ void __cache_line_loop_v3(phys_addr_t paddr, unsigned long vaddr,
 	while (num_lines-- > 0) {
 		if (!full_page) {
 			write_aux_reg(aux_tag, paddr);
-			paddr += L1_CACHE_BYTES;
+			paddr += CACHEOPS_L1_LINE_SZ;
 		}
 
 		write_aux_reg(aux_cmd, vaddr);
-		vaddr += L1_CACHE_BYTES;
+		vaddr += CACHEOPS_L1_LINE_SZ;
 	}
 }
 
@@ -372,11 +388,11 @@ void __cache_line_loop_v4(phys_addr_t paddr, unsigned long vaddr,
 	 *  -@sz will be integral multiple of line size (being page sized).
 	 */
 	if (!full_page) {
-		sz += paddr & ~CACHE_LINE_MASK;
-		paddr &= CACHE_LINE_MASK;
+		sz += paddr & ~CACHEOPS_L1_LINE_MASK;
+		paddr &= CACHEOPS_L1_LINE_MASK;
 	}
 
-	num_lines = DIV_ROUND_UP(sz, L1_CACHE_BYTES);
+	num_lines = DIV_ROUND_UP(sz, CACHEOPS_L1_LINE_SZ);
 
 	/*
 	 * For HS38 PAE40 configuration
@@ -396,7 +412,7 @@ void __cache_line_loop_v4(phys_addr_t paddr, unsigned long vaddr,
 
 	while (num_lines-- > 0) {
 		write_aux_reg(aux_cmd, paddr);
-		paddr += L1_CACHE_BYTES;
+		paddr += CACHEOPS_L1_LINE_SZ;
 	}
 }
 
@@ -422,14 +438,14 @@ void __cache_line_loop_v4(phys_addr_t paddr, unsigned long vaddr,
 
 	if (!full_page) {
 		/* for any leading gap between @paddr and start of cache line */
-		sz += paddr & ~CACHE_LINE_MASK;
-		paddr &= CACHE_LINE_MASK;
+		sz += paddr & ~CACHEOPS_L1_LINE_MASK;
+		paddr &= CACHEOPS_L1_LINE_MASK;
 
 		/*
 		 *  account for any trailing gap to end of cache line
 		 *  this is equivalent to DIV_ROUND_UP() in line ops above
 		 */
-		sz += L1_CACHE_BYTES - 1;
+		sz += CACHEOPS_L1_LINE_SZ - 1;
 	}
 
 	if (is_pae40_enabled()) {
@@ -1215,14 +1231,21 @@ static void arc_l1_line_check(unsigned int line_len, const char *cache_name)
 		panic("%s support enabled but non-existent cache\n",
 		      cache_name);
 
-	if (line_len != L1_CACHE_BYTES)
+	/*
+	 * In case of CONFIG_ARC_CACHE_LINE_AUTODETECT disabled we check
+	 * that cache line size is equal to provided via Kconfig,
+	 * in case of CONFIG_ARC_CACHE_LINE_AUTODETECT enabled we check
+	 * that cache line size is equal for every L1 (I/D) cache on every cpu.
+	 */
+	if (line_len != CACHEOPS_L1_LINE_SZ)
 		panic("%s line size [%u] != expected [%u]",
-		      cache_name, line_len, L1_CACHE_BYTES);
+		      cache_name, line_len, CACHEOPS_L1_LINE_SZ);
 }
 #endif /* IS_ENABLED(CONFIG_ARC_HAS_ICACHE) || IS_ENABLED(CONFIG_ARC_HAS_DCACHE) */
 
 /*
  * Cache related boot time checks needed on every CPU.
+ * NOTE: This function expects 'l1_line_sz' to be set.
  */
 static void arc_l1_cache_check(unsigned int cpu)
 {
@@ -1239,12 +1262,28 @@ static void arc_l1_cache_check(unsigned int cpu)
  * configuration (we validate this in arc_cache_check()):
  *  - Geometry checks
  *  - L1 cache line loop callbacks
+ *  - l1_line_sz / l1_line_mask setup
  */
 void __init arc_l1_cache_init_master(unsigned int cpu)
 {
+	/*
+	 * 'l1_line_sz' programing model:
+	 * We simplify programing of 'l1_line_sz' as we assume that we don't
+	 * support case where CPU have different cache configuration.
+	 * 1. Assign to 'l1_line_sz' length of any (I/D) L1 cache line of
+	 *    master CPU.
+	 * 2. Validate 'l1_line_sz' length itself.
+	 * 3. Check that both L1 I$/D$ lines on each CPU are equal to
+	 *    'l1_line_sz' (or to value provided via Kconfig in case of
+	 *     CONFIG_ARC_CACHE_LINE_AUTODETECT is disabled). This is done in
+	 *     arc_cache_check() which is called for each CPU.
+	 */
+
 	if (IS_ENABLED(CONFIG_ARC_HAS_ICACHE)) {
 		struct cpuinfo_arc_cache *ic = &cpuinfo_arc700[cpu].icache;
 
+		l1_line_sz = ic->line_len;
+
 		/*
 		 * In MMU v4 (HS38x) the aliasing icache config uses IVIL/PTAG
 		 * pair to provide vaddr/paddr respectively, just as in MMU v3
@@ -1258,6 +1297,8 @@ void __init arc_l1_cache_init_master(unsigned int cpu)
 	if (IS_ENABLED(CONFIG_ARC_HAS_DCACHE)) {
 		struct cpuinfo_arc_cache *dc = &cpuinfo_arc700[cpu].dcache;
 
+		l1_line_sz = dc->line_len;
+
 		/* check for D-Cache aliasing on ARCompact: ARCv2 has PIPT */
 		if (is_isa_arcompact()) {
 			int handled = IS_ENABLED(CONFIG_ARC_CACHE_VIPT_ALIASING);
@@ -1274,6 +1315,14 @@ void __init arc_l1_cache_init_master(unsigned int cpu)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_ARC_HAS_ICACHE) ||
+	    IS_ENABLED(CONFIG_ARC_HAS_DCACHE)) {
+		if (l1_line_sz != 32 && l1_line_sz != 64 && l1_line_sz != 128)
+			panic("L1 cache line sz [%u] unsupported\n", l1_line_sz);
+
+		l1_line_mask = ~(l1_line_sz - 1);
+	}
+
 	/*
 	 * Check that SMP_CACHE_BYTES (and hence ARCH_DMA_MINALIGN) is larger
 	 * or equal to any cache line length.
-- 
2.14.5

