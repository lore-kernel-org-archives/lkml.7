Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09091C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF40520675
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554051;
	bh=T2YsRAXz43N5eAKg1oT7Gz5GK/bJR/vt3ekmIKDORzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tKzLwnwvBY9MZ4NQa//bbLsnBOjep4ggQXYfHRzp7B6x6jW76A4TxmC1aDpLWTZI/
	 Ug+np3UByCjlq/IKD+pl4ahdmgBO0nalMQ59wYaVMNrbCKxBwhoeSn82ejz92Ud/ng
	 L1XHBiFjn0xekCcJ/5NG1BfPj4/4O1gADv1aYV8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbfEVT3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729466AbfEVT3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:29:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 696CE204FD;
        Wed, 22 May 2019 19:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553358;
        bh=T2YsRAXz43N5eAKg1oT7Gz5GK/bJR/vt3ekmIKDORzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PuAYzAgPCqTt4o1K0KvzArv5cNpnB44P8Vu7K+OR5zAB8p6DP17RoQ3uxgeM0S7Bo
         VOA+XeplfyPAz5QOhkuXm9zkM183bwLmL2FccXMymqZywD7yfvE2RQaBsgwY/Dacsc
         TQ5/Fp9MpiTh6mR/56HlPM2nqzlKqFo2204yX7PA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 021/167] arm64: Fix compiler warning from pte_unmap() with -Wunused-but-set-variable
Date:   Wed, 22 May 2019 15:26:16 -0400
Message-Id: <20190522192842.25858-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192842.25858-1-sashal@kernel.org>
References: <20190522192842.25858-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

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
index aafea648a30ff..ee77556b01243 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -420,6 +420,8 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 	return pmd_val(pmd) & PHYS_MASK & (s32)PAGE_MASK;
 }
 
+static inline void pte_unmap(pte_t *pte) { }
+
 /* Find an entry in the third-level page table. */
 #define pte_index(addr)		(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 
@@ -428,7 +430,6 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
 #define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while (0)
 #define pte_unmap_nested(pte)		do { } while (0)
 
 #define pte_set_fixmap(addr)		((pte_t *)set_fixmap_offset(FIX_PTE, addr))
-- 
2.20.1

