Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8C6C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BD922ADB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfGXQ0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:26:05 -0400
Received: from foss.arm.com ([217.140.110.172]:43412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbfGXQ0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:26:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3762B15A2;
        Wed, 24 Jul 2019 09:26:01 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D79053F71F;
        Wed, 24 Jul 2019 09:25:59 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, marc.zyngier@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v3 09/15] arm64/mm: Split the function check_and_switch_context in 3 parts
Date:   Wed, 24 Jul 2019 17:25:28 +0100
Message-Id: <20190724162534.7390-10-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190724162534.7390-1-julien.grall@arm.com>
References: <20190724162534.7390-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function check_and_switch_context is used to:
    1) Check whether the ASID is still valid
    2) Generate a new one if it is not valid
    3) Switch the context

While the latter is specific to the MM subsystem, the rest could be part
of the generic ASID allocator.

After this patch, the function is now split in 3 parts which corresponds
to the use of the functions:
    1) asid_check_context: Check if the ASID is still valid
    2) asid_new_context: Generate a new ASID for the context
    3) check_and_switch_context: Call 1) and 2) and switch the context

1) and 2) have not been merged in a single function because we want to
avoid to add a branch in when the ASID is still valid. This will matter
when the code will be moved in separate file later on as 1) will reside
in the header as a static inline function.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---

    Will wants to avoid to add a branch when the ASID is still valid. So
    1) and 2) are in separates function. The former will move to a new
    header and make static inline.
---
 arch/arm64/mm/context.c | 51 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 27e328fffdb1..5e8b381ab67f 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -193,16 +193,21 @@ static u64 new_context(struct asid_info *info, atomic64_t *pasid)
 	return idx2asid(info, asid) | generation;
 }
 
-void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
+static void asid_new_context(struct asid_info *info, atomic64_t *pasid,
+			     unsigned int cpu);
+
+/*
+ * Check the ASID is still valid for the context. If not generate a new ASID.
+ *
+ * @pasid: Pointer to the current ASID batch
+ * @cpu: current CPU ID. Must have been acquired throught get_cpu()
+ */
+static void asid_check_context(struct asid_info *info,
+			       atomic64_t *pasid, unsigned int cpu)
 {
-	unsigned long flags;
 	u64 asid, old_active_asid;
-	struct asid_info *info = &asid_info;
 
-	if (system_supports_cnp())
-		cpu_set_reserved_ttbr0();
-
-	asid = atomic64_read(&mm->context.id);
+	asid = atomic64_read(pasid);
 
 	/*
 	 * The memory ordering here is subtle.
@@ -223,14 +228,30 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	    !((asid ^ atomic64_read(&info->generation)) >> info->bits) &&
 	    atomic64_cmpxchg_relaxed(&active_asid(info, cpu),
 				     old_active_asid, asid))
-		goto switch_mm_fastpath;
+		return;
+
+	asid_new_context(info, pasid, cpu);
+}
+
+/*
+ * Generate a new ASID for the context.
+ *
+ * @pasid: Pointer to the current ASID batch allocated. It will be updated
+ * with the new ASID batch.
+ * @cpu: current CPU ID. Must have been acquired through get_cpu()
+ */
+static void asid_new_context(struct asid_info *info, atomic64_t *pasid,
+			     unsigned int cpu)
+{
+	unsigned long flags;
+	u64 asid;
 
 	raw_spin_lock_irqsave(&info->lock, flags);
 	/* Check that our ASID belongs to the current generation. */
-	asid = atomic64_read(&mm->context.id);
+	asid = atomic64_read(pasid);
 	if ((asid ^ atomic64_read(&info->generation)) >> info->bits) {
-		asid = new_context(info, &mm->context.id);
-		atomic64_set(&mm->context.id, asid);
+		asid = new_context(info, pasid);
+		atomic64_set(pasid, asid);
 	}
 
 	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
@@ -238,8 +259,14 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 
 	atomic64_set(&active_asid(info, cpu), asid);
 	raw_spin_unlock_irqrestore(&info->lock, flags);
+}
+
+void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
+{
+	if (system_supports_cnp())
+		cpu_set_reserved_ttbr0();
 
-switch_mm_fastpath:
+	asid_check_context(&asid_info, &mm->context.id, cpu);
 
 	arm64_apply_bp_hardening();
 
-- 
2.11.0

