Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDC1C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A040621871
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfGXQZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:25:55 -0400
Received: from foss.arm.com ([217.140.110.172]:43366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbfGXQZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:25:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 691CE28;
        Wed, 24 Jul 2019 09:25:53 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 156643F71F;
        Wed, 24 Jul 2019 09:25:51 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, marc.zyngier@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v3 04/15] arm64/mm: Move the variable lock and tlb_flush_pending to asid_info
Date:   Wed, 24 Jul 2019 17:25:23 +0100
Message-Id: <20190724162534.7390-5-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190724162534.7390-1-julien.grall@arm.com>
References: <20190724162534.7390-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables lock and tlb_flush_pending holds information for a given
ASID allocator. So move them to the asid_info structure.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/mm/context.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 49fff350e12f..b50f52a09baf 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -16,8 +16,6 @@
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 
-static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
-
 static struct asid_info
 {
 	atomic64_t	generation;
@@ -25,6 +23,9 @@ static struct asid_info
 	atomic64_t __percpu	*active;
 	u64 __percpu		*reserved;
 	u32			bits;
+	raw_spinlock_t		lock;
+	/* Which CPU requires context flush on next call */
+	cpumask_t		flush_pending;
 } asid_info;
 
 #define active_asid(info, cpu)	*per_cpu_ptr((info)->active, cpu)
@@ -33,8 +34,6 @@ static struct asid_info
 static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
 
-static cpumask_t tlb_flush_pending;
-
 #define ASID_MASK(info)			(~GENMASK((info)->bits - 1, 0))
 #define ASID_FIRST_VERSION(info)	(1UL << ((info)->bits))
 
@@ -113,7 +112,7 @@ static void flush_context(struct asid_info *info)
 	 * Queue a TLB invalidation for each CPU to perform on next
 	 * context-switch
 	 */
-	cpumask_setall(&tlb_flush_pending);
+	cpumask_setall(&info->flush_pending);
 }
 
 static bool check_update_reserved_asid(struct asid_info *info, u64 asid,
@@ -222,7 +221,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 				     old_active_asid, asid))
 		goto switch_mm_fastpath;
 
-	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+	raw_spin_lock_irqsave(&info->lock, flags);
 	/* Check that our ASID belongs to the current generation. */
 	asid = atomic64_read(&mm->context.id);
 	if ((asid ^ atomic64_read(&info->generation)) >> info->bits) {
@@ -230,11 +229,11 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 		atomic64_set(&mm->context.id, asid);
 	}
 
-	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
+	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
 		local_flush_tlb_all();
 
 	atomic64_set(&active_asid(info, cpu), asid);
-	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+	raw_spin_unlock_irqrestore(&info->lock, flags);
 
 switch_mm_fastpath:
 
@@ -277,6 +276,8 @@ static int asids_init(void)
 	info->active = &active_asids;
 	info->reserved = &reserved_asids;
 
+	raw_spin_lock_init(&info->lock);
+
 	pr_info("ASID allocator initialised with %lu entries\n",
 		NUM_USER_ASIDS(info));
 	return 0;
-- 
2.11.0

