Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80046C28CC1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BC2244AB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185849;
	bh=KKm8tQobGgirNLVNYlyF73ua17hZpMFCc1GhanWrZdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Knr4+tJrcBq1x60hRQ8agWZfL+FL2a7IaYuuZfHnkzZDZ268SVQyR0M1MLmqAUrC
	 +PPS0A08r2lgexYgDNwWoBsvkMrkkzGTr9rymo0vp5W0Z4JHwZ3/SXV19aK9JSxQGb
	 /et6i6e+Fd3COFOyk5FOBImBXXbeGIs5bnP0Jcfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfE3DKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbfE3DKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:06 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B4B724492;
        Thu, 30 May 2019 03:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185805;
        bh=KKm8tQobGgirNLVNYlyF73ua17hZpMFCc1GhanWrZdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpmOXfHnUquKemzLTHyuybKiKbanqFSotNM+hD3FhshUCujNOPZ2pP7WFLpHCZreP
         0BHvEpyl/zrJm19FyogzTxLj6hLLyqGANdi+COEfio2xn2owt0CpkFo7H1fw3bWRSc
         buVcWGv/VNlOOY8s59SQaSTqpF7NgegGhtSfrMLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 086/405] arm64: Fix compiler warning from pte_unmap() with -Wunused-but-set-variable
Date:   Wed, 29 May 2019 20:01:24 -0700
Message-Id: <20190530030545.384841195@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 74dd022f9e6260c3b5b8d15901d27ebcc5f21eda ]

When building with -Wunused-but-set-variable, the compiler shouts about
a number of pte_unmap() users, since this expands to an empty macro on
arm64:

  | mm/gup.c: In function 'gup_pte_range':
  | mm/gup.c:1727:16: warning: variable 'ptem' set but not used
  | [-Wunused-but-set-variable]
  | mm/gup.c: At top level:
  | mm/memory.c: In function 'copy_pte_range':
  | mm/memory.c:821:24: warning: variable 'orig_dst_pte' set but not used
  | [-Wunused-but-set-variable]
  | mm/memory.c:821:9: warning: variable 'orig_src_pte' set but not used
  | [-Wunused-but-set-variable]
  | mm/swap_state.c: In function 'swap_ra_info':
  | mm/swap_state.c:641:15: warning: variable 'orig_pte' set but not used
  | [-Wunused-but-set-variable]
  | mm/madvise.c: In function 'madvise_free_pte_range':
  | mm/madvise.c:318:9: warning: variable 'orig_pte' set but not used
  | [-Wunused-but-set-variable]

Rewrite pte_unmap() as a static inline function, which silences the
warnings.

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index de70c1eabf336..74ebe96937141 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -478,6 +478,8 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 	return __pmd_to_phys(pmd);
 }
 
+static inline void pte_unmap(pte_t *pte) { }
+
 /* Find an entry in the third-level page table. */
 #define pte_index(addr)		(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 
@@ -486,7 +488,6 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
 #define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while (0)
 #define pte_unmap_nested(pte)		do { } while (0)
 
 #define pte_set_fixmap(addr)		((pte_t *)set_fixmap_offset(FIX_PTE, addr))
-- 
2.20.1



