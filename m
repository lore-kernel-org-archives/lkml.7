Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E072C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3991220828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014105;
	bh=UT9oi/s9v/GTp5k7n/TwaiWPDk+vLR2tpyrAaDnfO6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oEDTgFcWucT33IOuQQQKJVPlvymgHY4QV1iRgBXZGT0YFxcOQGlyh2p42IrIRX2eY
	 ncq+ccjDByipIcTwCBDELOPucGJrzAq9HXeNgiSuKVJ/38nXBs13WVAsgJzMwTc6nA
	 +W/6mXpb5YtUIqjf7l5Nr7bDp2YC2dC/YPMCWNXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfLJVlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:41:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbfLJVeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:34:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FEC42073B;
        Tue, 10 Dec 2019 21:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013650;
        bh=UT9oi/s9v/GTp5k7n/TwaiWPDk+vLR2tpyrAaDnfO6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RGIsMtpEDk0xtLjq18q2I+X5Nx8KJK9iO8z81Z5eJy/xQ6qvb7VHCcE0hQH75NlWx
         SVNjndHvYFD/X9ZuuAB3WnGvstbHcBNQld7TA1Fl7UsUA2ATtXp7ECKrYNbYH7tcZr
         SvMseRb6i5X/sHFuxi6WEWYdzwd+5CwGNIz+vdt8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 089/177] s390/mm: add mm_pxd_folded() checks to pxd_free()
Date:   Tue, 10 Dec 2019 16:30:53 -0500
Message-Id: <20191210213221.11921-89-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

[ Upstream commit 2416cefc504ba8ae9b17e3e6b40afc72708f96be ]

Unlike pxd_free_tlb(), the pxd_free() functions do not check for folded
page tables. This is not an issue so far, as those functions will actually
never be called, since no code will reach them when page tables are folded.

In order to avoid future issues, and to make the s390 code more similar to
other architectures, add mm_pxd_folded() checks, similar to how it is done
in pxd_free_tlb().

This was found by testing a patch from from Anshuman Khandual, which is
currently discussed on LKML ("mm/debug: Add tests validating architecture
page table helpers").

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/pgalloc.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 5ee733720a571..67838df3f3f92 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -56,7 +56,12 @@ static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long address)
 		crst_table_init(table, _REGION2_ENTRY_EMPTY);
 	return (p4d_t *) table;
 }
-#define p4d_free(mm, p4d) crst_table_free(mm, (unsigned long *) p4d)
+
+static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
+{
+	if (!mm_p4d_folded(mm))
+		crst_table_free(mm, (unsigned long *) p4d);
+}
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
@@ -65,7 +70,12 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 		crst_table_init(table, _REGION3_ENTRY_EMPTY);
 	return (pud_t *) table;
 }
-#define pud_free(mm, pud) crst_table_free(mm, (unsigned long *) pud)
+
+static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+{
+	if (!mm_pud_folded(mm))
+		crst_table_free(mm, (unsigned long *) pud);
+}
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
 {
@@ -83,6 +93,8 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
+	if (mm_pmd_folded(mm))
+		return;
 	pgtable_pmd_page_dtor(virt_to_page(pmd));
 	crst_table_free(mm, (unsigned long *) pmd);
 }
-- 
2.20.1

