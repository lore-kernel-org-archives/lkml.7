Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DCAC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E432087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552335017;
	bh=NXNsVPfFa+GGcaGTQ6bhEVdP05rASOCee/t6OYtGLeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WfZVGrIJ5M6fQEUuX1Z5rrwV4/4i2XYvvx3UCEnbMTXfuIlFRyIgSWYUrJVWVSMxP
	 KO7EUGOyWTVwNmuy0L+s4vdH9+nRlB3uiQjuwGCKLWoOVtpPxIipBUgj0zyeWVHr44
	 tkWJ74Z32MjaINnHknxfHcjKJQqN23/rrH1pMnjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfCKT4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbfCKT4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:56:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68129214D8;
        Mon, 11 Mar 2019 19:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334191;
        bh=NXNsVPfFa+GGcaGTQ6bhEVdP05rASOCee/t6OYtGLeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wA77/X+sgvcN8hyZ29Yh3h3wGSo51t7QZvbzuVHZWaElgmvDxzS10yZaopQntOaCM
         GzI1FZGJlnPcfsNukoywFlYntF/OZqAELhGGzxq6K/valLbkJvZAr0GnxWA4ERqMM2
         eMLucCVF8ojabquGR1PRMM0hasGbcfjGtBEet1W0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 39/52] csky: Fixup _PAGE_GLOBAL bit for 610 tlb entry
Date:   Mon, 11 Mar 2019 15:55:03 -0400
Message-Id: <20190311195516.137772-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

[ Upstream commit 62eebea655d4be5a20fd563abfd7656724cdcd00 ]

C-SKY CPU 8xx's _PAGE_GLOBAL is BIT(0), but 610's _PAGE_GLOBAL is
BIT(6). Use _PAGE_GLOBAL macro instead of bad magic number.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index edfcbb25fd9f..af7a7faa1010 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -45,8 +45,8 @@
 	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset_t(address))
 #define pmd_page(pmd)	(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #define pte_clear(mm, addr, ptep)	set_pte((ptep), \
-			(((unsigned int)addr&0x80000000)?__pte(1):__pte(0)))
-#define pte_none(pte)	(!(pte_val(pte)&0xfffffffe))
+	(((unsigned int) addr & PAGE_OFFSET) ? __pte(_PAGE_GLOBAL) : __pte(0)))
+#define pte_none(pte)		(!(pte_val(pte) & ~_PAGE_GLOBAL))
 #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
 #define pte_pfn(x)	((unsigned long)((x).pte_low >> PAGE_SHIFT))
 #define pfn_pte(pfn, prot) __pte(((unsigned long long)(pfn) << PAGE_SHIFT) \
-- 
2.19.1

