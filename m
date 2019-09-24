Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43E1C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB892054F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344353;
	bh=XZeHI9WNQBBsr5LX0AFe24TjADJgl7zLNaRbvmxddCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J2dONgFeIKB6a28ehg2MoEb2/7nMLvLqQFLoXKzIX26a8fS/GTj5qh//CMRLmRtZG
	 KkqfM3ezxSCs3dxgdy0rp0llwPqAcVLsicO8w2zUJpTZdaSspWQduPW2q0+U8eZfdF
	 NsylWXBrZ53QkjNbp9Sz5ZIRxiWgvdnAHPYwbS40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410358AbfIXQrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387659AbfIXQrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:47:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08BA821D6C;
        Tue, 24 Sep 2019 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343631;
        bh=XZeHI9WNQBBsr5LX0AFe24TjADJgl7zLNaRbvmxddCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sDZQdzLlYpPUfvxuswDFQ8Da1o+bldckB7/ZOeSRdZhwVUXLcS1Di5AzVDStXFxyZ
         CSWtwhdY4obLHoQbtza2gLGQIPTfFYmmFzzgMu6hMnX7Qs8QpegaWJj3+vaYhdNqaG
         qKoS/Cc30+s2O/G1sJ/7ewnGxZ3E9qmQcoOog/BI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.2 35/70] powerpc/64s/radix: Remove redundant pfn_pte bitop, add VM_BUG_ON
Date:   Tue, 24 Sep 2019 12:45:14 -0400
Message-Id: <20190924164549.27058-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164549.27058-1-sashal@kernel.org>
References: <20190924164549.27058-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 6bb25170d7a44ef0ed9677814600f0785e7421d1 ]

pfn_pte is never given a pte above the addressable physical memory
limit, so the masking is redundant. In case of a software bug, it
is not obviously better to silently truncate the pfn than to corrupt
the pte (either one will result in memory corruption or crashes),
so there is no reason to add this to the fast path.

Add VM_BUG_ON to catch cases where the pfn is invalid. These would
catch the create_section_mapping bug fixed by a previous commit.

  [16885.256466] ------------[ cut here ]------------
  [16885.256492] kernel BUG at arch/powerpc/include/asm/book3s/64/pgtable.h:612!
  cpu 0x0: Vector: 700 (Program Check) at [c0000000ee0a36d0]
      pc: c000000000080738: __map_kernel_page+0x248/0x6f0
      lr: c000000000080ac0: __map_kernel_page+0x5d0/0x6f0
      sp: c0000000ee0a3960
     msr: 9000000000029033
    current = 0xc0000000ec63b400
    paca    = 0xc0000000017f0000   irqmask: 0x03   irq_happened: 0x01
      pid   = 85, comm = sh
  kernel BUG at arch/powerpc/include/asm/book3s/64/pgtable.h:612!
  Linux version 5.3.0-rc1-00001-g0fe93e5f3394
  enter ? for help
  [c0000000ee0a3a00] c000000000d37378 create_physical_mapping+0x260/0x360
  [c0000000ee0a3b10] c000000000d370bc create_section_mapping+0x1c/0x3c
  [c0000000ee0a3b30] c000000000071f54 arch_add_memory+0x74/0x130

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190724084638.24982-5-npiggin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index ccf00a8b98c6a..c470f6370dccb 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -602,8 +602,10 @@ static inline bool pte_access_permitted(pte_t pte, bool write)
  */
 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
 {
-	return __pte((((pte_basic_t)(pfn) << PAGE_SHIFT) & PTE_RPN_MASK) |
-		     pgprot_val(pgprot));
+	VM_BUG_ON(pfn >> (64 - PAGE_SHIFT));
+	VM_BUG_ON((pfn << PAGE_SHIFT) & ~PTE_RPN_MASK);
+
+	return __pte(((pte_basic_t)pfn << PAGE_SHIFT) | pgprot_val(pgprot));
 }
 
 static inline unsigned long pte_pfn(pte_t pte)
-- 
2.20.1

