Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6564C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C99F20872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BdNq0pIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfDPRKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:10:45 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:52418 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbfDPRKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:10:34 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 74F3D10C130D;
        Tue, 16 Apr 2019 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555434634; bh=r/ZPkalgTfT4ORTmItFJrcwFrTVw4C497BKL2kqKcLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BdNq0pImhh0HZM5CiqH+b6smCHVZ3F/375HBiq1q2pXPPfKVpViOjGAUDIVyx8chG
         VWGhTKWDSakln8bIcjbyg6a1Ax3QJkcp0imX53PIzHVWaZb8bWm5lHm7jbWBonw8D+
         2N7pRtQxD2CV1fWwd+2hFWCTurRgf+lg3lJ5Bl2MeY9svCLHwayJ/SWDIa7K0f8LLe
         so1NrPF2qLUQeCnvUUzv5L+OUQT0Sl7YO9Dv798dK83iYDw0DQx6Yfd6jOQsthB5QM
         KZgfb5HWYDm9VPuq6DZs5ZZuKP6FAzzfDTr39NDBNwGhaNLhPG32+hcJVDODuPzLYD
         ijgyWua72isgg==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.106])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3C964A023C;
        Tue, 16 Apr 2019 17:10:33 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH 2/3] ARC: cache: check cache configuration on each CPU
Date:   Tue, 16 Apr 2019 20:10:20 +0300
Message-Id: <20190416171021.20049-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190416171021.20049-1-Eugeniy.Paltsev@synopsys.com>
References: <20190416171021.20049-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARC kernel code assumes that all cores have same cache config
but as of today we check cache configuration only on master CPU.
Fix that and check cache configuration on each CPU.

Also while I'm at it, split cache_init_master() for two parts:
 * checks/setups related to master L1 caches
 * the rest of cache checks/setups which need to be done once
   (like IOC / SLC / dma callbacks setup)

Both of these changes are prerequisites for autodetecting cache
line size in runtime.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/mm/cache.c | 66 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 4135abec3fb0..1036bd56f518 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -1208,27 +1208,43 @@ noinline void __init arc_ioc_setup(void)
 	__dc_enable();
 }
 
+#if IS_ENABLED(CONFIG_ARC_HAS_ICACHE) || IS_ENABLED(CONFIG_ARC_HAS_DCACHE)
+static void arc_l1_line_check(unsigned int line_len, const char *cache_name)
+{
+	if (!line_len)
+		panic("%s support enabled but non-existent cache\n",
+		      cache_name);
+
+	if (line_len != L1_CACHE_BYTES)
+		panic("%s line size [%u] != expected [%u]",
+		      cache_name, line_len, L1_CACHE_BYTES);
+}
+#endif /* IS_ENABLED(CONFIG_ARC_HAS_ICACHE) || IS_ENABLED(CONFIG_ARC_HAS_DCACHE) */
+
 /*
- * Cache related boot time checks/setups only needed on master CPU:
- *  - Geometry checks (kernel build and hardware agree: e.g. L1_CACHE_BYTES)
- *    Assume SMP only, so all cores will have same cache config. A check on
- *    one core suffices for all
- *  - IOC setup / dma callbacks only need to be done once
+ * Cache related boot time checks needed on every CPU.
  */
-void __init arc_cache_init_master(void)
+static void arc_l1_cache_check(unsigned int cpu)
 {
-	unsigned int __maybe_unused cpu = smp_processor_id();
+	if (IS_ENABLED(CONFIG_ARC_HAS_ICACHE))
+		arc_l1_line_check(cpuinfo_arc700[cpu].icache.line_len, "ICache");
+
+	if (IS_ENABLED(CONFIG_ARC_HAS_DCACHE))
+		arc_l1_line_check(cpuinfo_arc700[cpu].dcache.line_len, "DCache");
+}
 
+/*
+ * L1 Cache related boot time checks/setups needed on master CPU:
+ * This checks/setups are done in assumption that all CPU have same cache
+ * configuration (we validate this in arc_cache_check()):
+ *  - Geometry checks
+ *  - L1 cache line loop callbacks
+ */
+void __init arc_l1_cache_init_master(unsigned int cpu)
+{
 	if (IS_ENABLED(CONFIG_ARC_HAS_ICACHE)) {
 		struct cpuinfo_arc_cache *ic = &cpuinfo_arc700[cpu].icache;
 
-		if (!ic->line_len)
-			panic("cache support enabled but non-existent cache\n");
-
-		if (ic->line_len != L1_CACHE_BYTES)
-			panic("ICache line [%d] != kernel Config [%d]",
-			      ic->line_len, L1_CACHE_BYTES);
-
 		/*
 		 * In MMU v4 (HS38x) the aliasing icache config uses IVIL/PTAG
 		 * pair to provide vaddr/paddr respectively, just as in MMU v3
@@ -1242,13 +1258,6 @@ void __init arc_cache_init_master(void)
 	if (IS_ENABLED(CONFIG_ARC_HAS_DCACHE)) {
 		struct cpuinfo_arc_cache *dc = &cpuinfo_arc700[cpu].dcache;
 
-		if (!dc->line_len)
-			panic("cache support enabled but non-existent cache\n");
-
-		if (dc->line_len != L1_CACHE_BYTES)
-			panic("DCache line [%d] != kernel Config [%d]",
-			      dc->line_len, L1_CACHE_BYTES);
-
 		/* check for D-Cache aliasing on ARCompact: ARCv2 has PIPT */
 		if (is_isa_arcompact()) {
 			int handled = IS_ENABLED(CONFIG_ARC_CACHE_VIPT_ALIASING);
@@ -1271,6 +1280,14 @@ void __init arc_cache_init_master(void)
 	 */
 	BUILD_BUG_ON_MSG(L1_CACHE_BYTES > SMP_CACHE_BYTES,
 			 "SMP_CACHE_BYTES must be >= any cache line length");
+}
+
+/*
+ * Cache related boot time checks/setups needed on master CPU:
+ *  - IOC setup / SLC setup / dma callbacks only need to be done once
+ */
+void __init arc_cache_init_master(void)
+{
 	if (is_isa_arcv2() && (l2_line_sz > SMP_CACHE_BYTES))
 		panic("L2 Cache line [%d] > kernel Config [%d]\n",
 		      l2_line_sz, SMP_CACHE_BYTES);
@@ -1301,11 +1318,16 @@ void __init arc_cache_init_master(void)
 
 void __ref arc_cache_init(void)
 {
-	unsigned int __maybe_unused cpu = smp_processor_id();
+	unsigned int cpu = smp_processor_id();
 	char str[256];
 
 	pr_info("%s", arc_cache_mumbojumbo(0, str, sizeof(str)));
 
+	if (!cpu)
+		arc_l1_cache_init_master(cpu);
+
+	arc_l1_cache_check(cpu);
+
 	if (!cpu)
 		arc_cache_init_master();
 
-- 
2.14.5

