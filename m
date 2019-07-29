Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27114C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8992054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429321;
	bh=mrPfb4yn5qmbsy+jrQ54Euyf0XfhyDXl+Ju9S5MQqmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aTLHL4KgGl8JM6sIAI2BFsSz1XyAyaZ125IKv5PwXwhdUv6tiMgg9WCv5mXBW5EXf
	 FZWdh9jQZOlbxPbaZpLsOkJF6Tvj+e+0lh9DiksJ+RPH7XwqTEVC4vfiwNuTkTthkQ
	 9P3gjKFZuyLouvqp5+Jf4S9fAojpssuWGw5GexuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbfG2Tl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388566AbfG2Tl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:41:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C83CB2054F;
        Mon, 29 Jul 2019 19:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429316;
        bh=mrPfb4yn5qmbsy+jrQ54Euyf0XfhyDXl+Ju9S5MQqmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSv+hbUitAT5C6QCp9fmUAWvjyHdCojAOL620B7LkIQBi5e3RN06dDa2iurm6xzeE
         8+OzcO9xpeT7DQjbgXi2gBQZJy8UoajqzlYI2RmblaRmME6jCnA4hCHA2/aDWBPlVI
         f32tG/FsCgJpq5ld7CaGQ0xhEOd6NbvaWk6uoMo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 059/113] powerpc/mm: Handle page table allocation failures
Date:   Mon, 29 Jul 2019 21:22:26 +0200
Message-Id: <20190729190709.585562359@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2230ebf6e6dd0b7751e2921b40f6cfe34f09bb16 ]

This fixes kernel crash that arises due to not handling page table allocation
failures while allocating hugetlb page table.

Fixes: e2b3d202d1db ("powerpc: Switch 16GB and 16MB explicit hugepages to a different page table format")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/hugetlbpage.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 7296a42eb62e..cef0b7ee1024 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -150,6 +150,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 	} else {
 		pdshift = PUD_SHIFT;
 		pu = pud_alloc(mm, pg, addr);
+		if (!pu)
+			return NULL;
 		if (pshift == PUD_SHIFT)
 			return (pte_t *)pu;
 		else if (pshift > PMD_SHIFT) {
@@ -158,6 +160,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 		} else {
 			pdshift = PMD_SHIFT;
 			pm = pmd_alloc(mm, pu, addr);
+			if (!pm)
+				return NULL;
 			if (pshift == PMD_SHIFT)
 				/* 16MB hugepage */
 				return (pte_t *)pm;
@@ -174,12 +178,16 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 	} else {
 		pdshift = PUD_SHIFT;
 		pu = pud_alloc(mm, pg, addr);
+		if (!pu)
+			return NULL;
 		if (pshift >= PUD_SHIFT) {
 			ptl = pud_lockptr(mm, pu);
 			hpdp = (hugepd_t *)pu;
 		} else {
 			pdshift = PMD_SHIFT;
 			pm = pmd_alloc(mm, pu, addr);
+			if (!pm)
+				return NULL;
 			ptl = pmd_lockptr(mm, pm);
 			hpdp = (hugepd_t *)pm;
 		}
-- 
2.20.1



