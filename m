Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F43AC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2922082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbfFTNGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:06:39 -0400
Received: from foss.arm.com ([217.140.110.172]:36790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731831AbfFTNGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:06:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D65F360;
        Thu, 20 Jun 2019 06:06:35 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18A843F73F;
        Thu, 20 Jun 2019 06:06:33 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, marc.zyngier@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [RFC v2 08/14] arm64/mm: Split asid_inits in 2 parts
Date:   Thu, 20 Jun 2019 14:06:02 +0100
Message-Id: <20190620130608.17230-9-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190620130608.17230-1-julien.grall@arm.com>
References: <20190620130608.17230-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move out the common initialization of the ASID allocator in a separate
function.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/mm/context.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index beba8e5b4100..81bc3d365436 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -271,31 +271,50 @@ asmlinkage void post_ttbr_update_workaround(void)
 			CONFIG_CAVIUM_ERRATUM_27456));
 }
 
-static int asids_init(void)
+/*
+ * Initialize the ASID allocator
+ *
+ * @info: Pointer to the asid allocator structure
+ * @bits: Number of ASIDs available
+ * @asid_per_ctxt: Number of ASIDs to allocate per-context. ASIDs are
+ * allocated contiguously for a given context. This value should be a power of
+ * 2.
+ */
+static int asid_allocator_init(struct asid_info *info,
+			       u32 bits, unsigned int asid_per_ctxt)
 {
-	struct asid_info *info = &asid_info;
-
-	info->bits = get_cpu_asid_bits();
-	info->ctxt_shift = ilog2(ASID_PER_CONTEXT);
+	info->bits = bits;
+	info->ctxt_shift = ilog2(asid_per_ctxt);
 	/*
 	 * Expect allocation after rollover to fail if we don't have at least
-	 * one more ASID than CPUs. ASID #0 is reserved for init_mm.
+	 * one more ASID than CPUs. ASID #0 is always reserved.
 	 */
 	WARN_ON(NUM_CTXT_ASIDS(info) - 1 <= num_possible_cpus());
 	atomic64_set(&info->generation, ASID_FIRST_VERSION(info));
 	info->map = kcalloc(BITS_TO_LONGS(NUM_CTXT_ASIDS(info)),
 			    sizeof(*info->map), GFP_KERNEL);
 	if (!info->map)
-		panic("Failed to allocate bitmap for %lu ASIDs\n",
-		      NUM_CTXT_ASIDS(info));
-
-	info->active = &active_asids;
-	info->reserved = &reserved_asids;
+		return -ENOMEM;
 
 	raw_spin_lock_init(&info->lock);
 
+	return 0;
+}
+
+static int asids_init(void)
+{
+	u32 bits = get_cpu_asid_bits();
+
+	if (!asid_allocator_init(&asid_info, bits, ASID_PER_CONTEXT))
+		panic("Unable to initialize ASID allocator for %lu ASIDs\n",
+		      1UL << bits);
+
+	asid_info.active = &active_asids;
+	asid_info.reserved = &reserved_asids;
+
 	pr_info("ASID allocator initialised with %lu entries\n",
-		NUM_CTXT_ASIDS(info));
+		NUM_CTXT_ASIDS(&asid_info));
+
 	return 0;
 }
 early_initcall(asids_init);
-- 
2.11.0

