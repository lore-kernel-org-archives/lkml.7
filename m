Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468C4C48BE8
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6D1208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 16:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561305891;
	bh=m3PXllBlpDL+ihlJ9/avHamsAhmCEasRuxU2xZbo2YU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BA6Qfwu7e6dgIPwEqC5OHawAuuDZ95n5gfB0dNYHVCJv6LCPz6lBwVN6eWnQhNVGN
	 5uSvqitPar1IGVAxApPblPDD/GihctkKhGMKib0eIAJ1zLq0mWTBPOAsSZEFrNEFRK
	 pVpnzZDv75mBqTNWSS7PA6+sQR6qt9z6TSeHr1ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFWQEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 12:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfFWQEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 12:04:49 -0400
Received: from guoren-Inspiron-7460.lan (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7697208C3;
        Sun, 23 Jun 2019 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561305888;
        bh=m3PXllBlpDL+ihlJ9/avHamsAhmCEasRuxU2xZbo2YU=;
        h=From:To:Cc:Subject:Date:From;
        b=R0cK7REIoa8qRyqgt9GaVPCPHEFgZHn6ATO0n0TugMlVT5WcRpfWQSIbtK+FO55wP
         HD9E9t21JS/tDOosuFo/+3/rnlt+yPb8z9m+4dK2wbfCw19/+NEg5MyxG2NY6OupYs
         qGVn6hGOM4ZRabeGejpmNritCd+nMrAjdSqSdOOg=
From:   guoren@kernel.org
To:     julien.grall@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc:     linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] arm64: asid: Optimize cache_flush for SMT
Date:   Mon, 24 Jun 2019 00:04:29 +0800
Message-Id: <1561305869-18872-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The hardware threads of one core could share the same TLB for SMT+SMP
system. Assume hardware threads number sequence like this:

| 0 1 2 3 | 4 5 6 7 | 8 9 a b | c d e f |
   core1     core2     core3     core4

Current algorithm seems is correct for SMT+SMP, but it'll give some
duplicate local_tlb_flush. Because one hardware threads local_tlb_flush
will also flush other hardware threads' TLB entry in one core TLB.

So we can use bitmap to reduce local_tlb_flush for SMT.

C-SKY cores don't support SMT and the patch is no benefit for C-SKY.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Julien Grall <julien.grall@arm.com>
---
 arch/csky/include/asm/asid.h |  4 ++++
 arch/csky/mm/asid.c          | 11 ++++++++++-
 arch/csky/mm/context.c       |  2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/asid.h b/arch/csky/include/asm/asid.h
index ac08b0f..f654492 100644
--- a/arch/csky/include/asm/asid.h
+++ b/arch/csky/include/asm/asid.h
@@ -23,6 +23,9 @@ struct asid_info
 	unsigned int		ctxt_shift;
 	/* Callback to locally flush the context. */
 	void			(*flush_cpu_ctxt_cb)(void);
+	/* To reduce duplicate tlb_flush for SMT */
+	unsigned int		harts_per_core;
+	unsigned int		harts_per_core_mask;
 };
 
 #define NUM_ASIDS(info)			(1UL << ((info)->bits))
@@ -73,6 +76,7 @@ static inline void asid_check_context(struct asid_info *info,
 
 int asid_allocator_init(struct asid_info *info,
 			u32 bits, unsigned int asid_per_ctxt,
+			unsigned int harts_per_core,
 			void (*flush_cpu_ctxt_cb)(void));
 
 #endif
diff --git a/arch/csky/mm/asid.c b/arch/csky/mm/asid.c
index b2e9147..50a983e 100644
--- a/arch/csky/mm/asid.c
+++ b/arch/csky/mm/asid.c
@@ -148,8 +148,13 @@ void asid_new_context(struct asid_info *info, atomic64_t *pasid,
 		atomic64_set(pasid, asid);
 	}
 
-	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
+	if (cpumask_test_cpu(cpu, &info->flush_pending)) {
+		unsigned int i;
+		unsigned int harts_base = cpu & info->harts_per_core_mask;
 		info->flush_cpu_ctxt_cb();
+		for (i = 0; i < info->harts_per_core; i++)
+			cpumask_clear_cpu(harts_base + i, &info->flush_pending);
+	}
 
 	atomic64_set(&active_asid(info, cpu), asid);
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
@@ -162,15 +167,19 @@ void asid_new_context(struct asid_info *info, atomic64_t *pasid,
  * @info: Pointer to the asid allocator structure
  * @bits: Number of ASIDs available
  * @asid_per_ctxt: Number of ASIDs to allocate per-context. ASIDs are
+ * @harts_per_core: Number hardware threads per core, must be 1, 2, 4, 8, 16 ...
  * allocated contiguously for a given context. This value should be a power of
  * 2.
  */
 int asid_allocator_init(struct asid_info *info,
 			u32 bits, unsigned int asid_per_ctxt,
+			unsigned int harts_per_core,
 			void (*flush_cpu_ctxt_cb)(void))
 {
 	info->bits = bits;
 	info->ctxt_shift = ilog2(asid_per_ctxt);
+	info->harts_per_core = harts_per_core;
+	info->harts_per_core_mask = ~((1 << ilog2(harts_per_core)) - 1);
 	info->flush_cpu_ctxt_cb = flush_cpu_ctxt_cb;
 	/*
 	 * Expect allocation after rollover to fail if we don't have at least
diff --git a/arch/csky/mm/context.c b/arch/csky/mm/context.c
index 0d95bdd..b58523b 100644
--- a/arch/csky/mm/context.c
+++ b/arch/csky/mm/context.c
@@ -30,7 +30,7 @@ static int asids_init(void)
 {
 	BUG_ON(((1 << CONFIG_CPU_ASID_BITS) - 1) <= num_possible_cpus());
 
-	if (asid_allocator_init(&asid_info, CONFIG_CPU_ASID_BITS, 1,
+	if (asid_allocator_init(&asid_info, CONFIG_CPU_ASID_BITS, 1, 1,
 				asid_flush_cpu_ctxt))
 		panic("Unable to initialize ASID allocator for %lu ASIDs\n",
 		      NUM_ASIDS(&asid_info));
-- 
2.7.4

