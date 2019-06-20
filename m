Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A3FC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D812082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbfFTNGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:06:41 -0400
Received: from foss.arm.com ([217.140.110.172]:36808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732029AbfFTNGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:06:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B5CB360;
        Thu, 20 Jun 2019 06:06:38 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3704F3F718;
        Thu, 20 Jun 2019 06:06:37 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, marc.zyngier@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [RFC v2 10/14] arm64/mm: Introduce a callback to flush the local context
Date:   Thu, 20 Jun 2019 14:06:04 +0100
Message-Id: <20190620130608.17230-11-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190620130608.17230-1-julien.grall@arm.com>
References: <20190620130608.17230-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flushing the local context will vary depending on the actual user of the ASID
allocator. Introduce a new callback to flush the local context and move
the call to flush local TLB in it.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/mm/context.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index fbef5a5c5624..3df63a28856c 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -39,6 +39,8 @@ static struct asid_info
 	cpumask_t		flush_pending;
 	/* Number of ASID allocated by context (shift value) */
 	unsigned int		ctxt_shift;
+	/* Callback to locally flush the context. */
+	void			(*flush_cpu_ctxt_cb)(void);
 } asid_info;
 
 #define active_asid(info, cpu)	*per_cpu_ptr((info)->active, cpu)
@@ -266,7 +268,7 @@ static void asid_new_context(struct asid_info *info, atomic64_t *pasid,
 	}
 
 	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
-		local_flush_tlb_all();
+		info->flush_cpu_ctxt_cb();
 
 	atomic64_set(&active_asid(info, cpu), asid);
 	raw_spin_unlock_irqrestore(&info->lock, flags);
@@ -298,6 +300,11 @@ asmlinkage void post_ttbr_update_workaround(void)
 			CONFIG_CAVIUM_ERRATUM_27456));
 }
 
+static void asid_flush_cpu_ctxt(void)
+{
+	local_flush_tlb_all();
+}
+
 /*
  * Initialize the ASID allocator
  *
@@ -308,10 +315,12 @@ asmlinkage void post_ttbr_update_workaround(void)
  * 2.
  */
 static int asid_allocator_init(struct asid_info *info,
-			       u32 bits, unsigned int asid_per_ctxt)
+			       u32 bits, unsigned int asid_per_ctxt,
+			       void (*flush_cpu_ctxt_cb)(void))
 {
 	info->bits = bits;
 	info->ctxt_shift = ilog2(asid_per_ctxt);
+	info->flush_cpu_ctxt_cb = flush_cpu_ctxt_cb;
 	/*
 	 * Expect allocation after rollover to fail if we don't have at least
 	 * one more ASID than CPUs. ASID #0 is always reserved.
@@ -332,7 +341,8 @@ static int asids_init(void)
 {
 	u32 bits = get_cpu_asid_bits();
 
-	if (!asid_allocator_init(&asid_info, bits, ASID_PER_CONTEXT))
+	if (!asid_allocator_init(&asid_info, bits, ASID_PER_CONTEXT,
+				 asid_flush_cpu_ctxt))
 		panic("Unable to initialize ASID allocator for %lu ASIDs\n",
 		      1UL << bits);
 
-- 
2.11.0

