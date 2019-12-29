Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A200C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D6D207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641794;
	bh=jE9EknK2kzLDWp7zDOt2TGeJUJtnJDEOt96lz0ENDJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vtoqnODocjBhQ+jH60hglWJatIJluungHbvGKhhIZ5MOzpes49bK3FE9yWLsLlnHk
	 YYw851+e0MXa+1ERhFRSnEQ6EX+bdabcC5Zpl1cCUX4nBOTBi5VDggCapjuSiLJYAi
	 14F2a48CD7C0KkccmYMvRGjLDGwT62M5sVW3zWJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbfL2Rty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731706AbfL2Rts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:49:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 072E3206A4;
        Sun, 29 Dec 2019 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641787;
        bh=jE9EknK2kzLDWp7zDOt2TGeJUJtnJDEOt96lz0ENDJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGJsNyZDoFJnBcH++ZtLMmV0hyG+eNHDE1qoU/2eP++4iRZjU4/YDnQqXJpg0VdeN
         44b19/ZoKDKq67RSfx/fbPfKNG50SoQ4J9aW7iXwBYSrXO/N6fvCceRGW0qnAkyJz8
         JoUwINzrqbbkeKWwGaWA2uc5jzhbQ0NABm2AoDeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 211/434] s390/mm: add mm_pxd_folded() checks to pxd_free()
Date:   Sun, 29 Dec 2019 18:24:24 +0100
Message-Id: <20191229172715.845172247@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index bccb8f4a63e2..77606c4acd58 100644
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



