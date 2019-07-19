Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93840C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8A6218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508899;
	bh=3gyWvW9TWKvGDCP/N8AuBPzV+BDaoFgHHsIs/6XfNHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DZyRIeVMv2BWysePGlU4g6Kqvnu/v0IkD66KMiZAEDiRFWhCMla/nrLlwEOnSnGZx
	 4hrXjuDahmJTl+1dkKm0R8A7epyb4BJJ4m83ZWqWfh44iyKO+kSc+ap61Vcj/eRr39
	 GrnrUbkB1Ekxc9KjTdX0DCTr2+Rt72SB5P2Dr5a8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfGSEBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729473AbfGSEBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:01:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 436D021873;
        Fri, 19 Jul 2019 04:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508890;
        bh=3gyWvW9TWKvGDCP/N8AuBPzV+BDaoFgHHsIs/6XfNHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UNFa4S2FEI33fcqOBuNsniCnQW5VTRLPSEIFkQn6vTbi+fqK2rk7JOthsjhQFO0xT
         igw1c4lvc/P46ViG/ZWdxLy8NxEaa8IAwlpUpAj0DyMF3kbWDv7+BVV9T36km8srK/
         SMkMyiBnGotiveD36CObaDFylP03CnyqBYown0Kw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.2 140/171] powerpc/irq: Don't WARN continuously in arch_local_irq_restore()
Date:   Thu, 18 Jul 2019 23:56:11 -0400
Message-Id: <20190719035643.14300-140-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 0fc12c022ad25532b66bf6f6c818ee1c1d63e702 ]

When CONFIG_PPC_IRQ_SOFT_MASK_DEBUG is enabled (uncommon), we have a
series of WARN_ON's in arch_local_irq_restore().

These are "should never happen" conditions, but if they do happen they
can flood the console and render the system unusable. So switch them
to WARN_ON_ONCE().

Fixes: e2b36d591720 ("powerpc/64: Don't trace code that runs with the soft irq mask unreconciled")
Fixes: 9b81c0211c24 ("powerpc/64s: make PACA_IRQ_HARD_DIS track MSR[EE] closely")
Fixes: 7c0482e3d055 ("powerpc/irq: Fix another case of lazy IRQ state getting out of sync")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190708061046.7075-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index bc68c53af67c..5645bc9cbc09 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -255,7 +255,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	irq_happened = get_irq_happened();
 	if (!irq_happened) {
 #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
-		WARN_ON(!(mfmsr() & MSR_EE));
+		WARN_ON_ONCE(!(mfmsr() & MSR_EE));
 #endif
 		return;
 	}
@@ -268,7 +268,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	 */
 	if (!(irq_happened & PACA_IRQ_HARD_DIS)) {
 #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
-		WARN_ON(!(mfmsr() & MSR_EE));
+		WARN_ON_ONCE(!(mfmsr() & MSR_EE));
 #endif
 		__hard_irq_disable();
 #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
@@ -279,7 +279,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 		 * warn if we are wrong. Only do that when IRQ tracing
 		 * is enabled as mfmsr() can be costly.
 		 */
-		if (WARN_ON(mfmsr() & MSR_EE))
+		if (WARN_ON_ONCE(mfmsr() & MSR_EE))
 			__hard_irq_disable();
 #endif
 	}
-- 
2.20.1

