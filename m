Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D55C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D2F21871
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfGXQ0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:26:46 -0400
Received: from foss.arm.com ([217.140.110.172]:43346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbfGXQZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:25:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C9DD15A1;
        Wed, 24 Jul 2019 09:25:50 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED53B3F71F;
        Wed, 24 Jul 2019 09:25:48 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, marc.zyngier@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v3 02/15] arm64/mm: Move active_asids and reserved_asids to asid_info
Date:   Wed, 24 Jul 2019 17:25:21 +0100
Message-Id: <20190724162534.7390-3-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190724162534.7390-1-julien.grall@arm.com>
References: <20190724162534.7390-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables active_asids and reserved_asids hold information for a
given ASID allocator. So move them to the structure asid_info.

At the same time, introduce wrappers to access the active and reserved
ASIDs to make the code clearer.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/mm/context.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index b0789f30d03b..3de028803284 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -23,10 +23,16 @@ static struct asid_info
 {
 	atomic64_t	generation;
 	unsigned long	*map;
+	atomic64_t __percpu	*active;
+	u64 __percpu		*reserved;
 } asid_info;
 
+#define active_asid(info, cpu)	*per_cpu_ptr((info)->active, cpu)
+#define reserved_asid(info, cpu) *per_cpu_ptr((info)->reserved, cpu)
+
 static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
+
 static cpumask_t tlb_flush_pending;
 
 #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
@@ -89,7 +95,7 @@ static void flush_context(struct asid_info *info)
 	bitmap_clear(info->map, 0, NUM_USER_ASIDS);
 
 	for_each_possible_cpu(i) {
-		asid = atomic64_xchg_relaxed(&per_cpu(active_asids, i), 0);
+		asid = atomic64_xchg_relaxed(&active_asid(info, i), 0);
 		/*
 		 * If this CPU has already been through a
 		 * rollover, but hasn't run another task in
@@ -98,9 +104,9 @@ static void flush_context(struct asid_info *info)
 		 * the process it is still running.
 		 */
 		if (asid == 0)
-			asid = per_cpu(reserved_asids, i);
+			asid = reserved_asid(info, i);
 		__set_bit(asid2idx(asid), info->map);
-		per_cpu(reserved_asids, i) = asid;
+		reserved_asid(info, i) = asid;
 	}
 
 	/*
@@ -110,7 +116,8 @@ static void flush_context(struct asid_info *info)
 	cpumask_setall(&tlb_flush_pending);
 }
 
-static bool check_update_reserved_asid(u64 asid, u64 newasid)
+static bool check_update_reserved_asid(struct asid_info *info, u64 asid,
+				       u64 newasid)
 {
 	int cpu;
 	bool hit = false;
@@ -125,9 +132,9 @@ static bool check_update_reserved_asid(u64 asid, u64 newasid)
 	 * generation.
 	 */
 	for_each_possible_cpu(cpu) {
-		if (per_cpu(reserved_asids, cpu) == asid) {
+		if (reserved_asid(info, cpu) == asid) {
 			hit = true;
-			per_cpu(reserved_asids, cpu) = newasid;
+			reserved_asid(info, cpu) = newasid;
 		}
 	}
 
@@ -147,7 +154,7 @@ static u64 new_context(struct asid_info *info, struct mm_struct *mm)
 		 * If our current ASID was active during a rollover, we
 		 * can continue to use it and this was just a false alarm.
 		 */
-		if (check_update_reserved_asid(asid, newasid))
+		if (check_update_reserved_asid(info, asid, newasid))
 			return newasid;
 
 		/*
@@ -196,8 +203,8 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 
 	/*
 	 * The memory ordering here is subtle.
-	 * If our active_asids is non-zero and the ASID matches the current
-	 * generation, then we update the active_asids entry with a relaxed
+	 * If our active_asid is non-zero and the ASID matches the current
+	 * generation, then we update the active_asid entry with a relaxed
 	 * cmpxchg. Racing with a concurrent rollover means that either:
 	 *
 	 * - We get a zero back from the cmpxchg and end up waiting on the
@@ -208,10 +215,10 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	 *   relaxed xchg in flush_context will treat us as reserved
 	 *   because atomic RmWs are totally ordered for a given location.
 	 */
-	old_active_asid = atomic64_read(&per_cpu(active_asids, cpu));
+	old_active_asid = atomic64_read(&active_asid(info, cpu));
 	if (old_active_asid &&
 	    !((asid ^ atomic64_read(&info->generation)) >> asid_bits) &&
-	    atomic64_cmpxchg_relaxed(&per_cpu(active_asids, cpu),
+	    atomic64_cmpxchg_relaxed(&active_asid(info, cpu),
 				     old_active_asid, asid))
 		goto switch_mm_fastpath;
 
@@ -226,7 +233,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
 		local_flush_tlb_all();
 
-	atomic64_set(&per_cpu(active_asids, cpu), asid);
+	atomic64_set(&active_asid(info, cpu), asid);
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
 
 switch_mm_fastpath:
@@ -267,6 +274,9 @@ static int asids_init(void)
 		panic("Failed to allocate bitmap for %lu ASIDs\n",
 		      NUM_USER_ASIDS);
 
+	info->active = &active_asids;
+	info->reserved = &reserved_asids;
+
 	pr_info("ASID allocator initialised with %lu entries\n", NUM_USER_ASIDS);
 	return 0;
 }
-- 
2.11.0

