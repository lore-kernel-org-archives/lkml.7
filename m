Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B18C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D7221871
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfGXQ0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:26:33 -0400
Received: from foss.arm.com ([217.140.110.172]:43396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbfGXQ0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:26:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2BBB28;
        Wed, 24 Jul 2019 09:25:59 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DC6E3F71F;
        Wed, 24 Jul 2019 09:25:58 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, marc.zyngier@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v3 08/15] arm64/mm: Split asid_inits in 2 parts
Date:   Wed, 24 Jul 2019 17:25:27 +0100
Message-Id: <20190724162534.7390-9-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190724162534.7390-1-julien.grall@arm.com>
References: <20190724162534.7390-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move out the common initialization of the ASID allocator in a separate
function.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v3:
        - Allow bisection (asid_allocator_init() return 0 on success not
          error!).
---
 arch/arm64/mm/context.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 3b40ac4a2541..27e328fffdb1 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -260,31 +260,50 @@ asmlinkage void post_ttbr_update_workaround(void)
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
+	if (asid_allocator_init(&asid_info, bits, ASID_PER_CONTEXT))
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

