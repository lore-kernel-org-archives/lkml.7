Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1E4C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26522206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cj/deBlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDZF75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:59:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20319 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfDZF7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:59:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44r3L04hd1z9v1v9;
        Fri, 26 Apr 2019 07:59:52 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=cj/deBlo; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id veHtSfkS-UAy; Fri, 26 Apr 2019 07:59:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44r3L03bkGz9v1tj;
        Fri, 26 Apr 2019 07:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556258392; bh=CdZAWtK1Toi2PIHVI6vPbGzH/nxkdPNYtkmYkbl6Eek=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=cj/deBlou+TS35OShgq1bIZF7x5XvaA1D67umcaIq9Olpj0LmxhaH46DZc8feuyMh
         lIyKiKF5JipY5IrfzBBLjjWRMri+I+Qvdv3bPVpwuhYw8afS2aDvrfY8D80dkmN61b
         rNibzcAyyJCv4P0Zwz+NCkA19kQqQ+wJusuyvUNs=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B0DB8B807;
        Fri, 26 Apr 2019 07:59:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JTTYIuQUBg2Y; Fri, 26 Apr 2019 07:59:53 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 363868B74C;
        Fri, 26 Apr 2019 07:59:53 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 129A066276; Fri, 26 Apr 2019 05:59:53 +0000 (UTC)
Message-Id: <1a5d0621f9c6e842497050d42a5e279a2efa0efc.1556258135.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556258134.git.christophe.leroy@c-s.fr>
References: <cover.1556258134.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 17/17] powerpc/mm: flatten function __find_linux_pte() step
 3
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 26 Apr 2019 05:59:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__find_linux_pte() is full of if/else which is hard to
follow allthough the handling is pretty simple.

Previous patches left a { } block. This patch removes it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable.c | 98 +++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index c1c6d0b79baa..db4a6253df92 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -348,59 +348,59 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 		hpdp = (hugepd_t *)&pgd;
 		goto out_huge;
 	}
-	{
-		/*
-		 * Even if we end up with an unmap, the pgtable will not
-		 * be freed, because we do an rcu free and here we are
-		 * irq disabled
-		 */
-		pdshift = PUD_SHIFT;
-		pudp = pud_offset(&pgd, ea);
-		pud  = READ_ONCE(*pudp);
 
-		if (pud_none(pud))
-			return NULL;
+	/*
+	 * Even if we end up with an unmap, the pgtable will not
+	 * be freed, because we do an rcu free and here we are
+	 * irq disabled
+	 */
+	pdshift = PUD_SHIFT;
+	pudp = pud_offset(&pgd, ea);
+	pud  = READ_ONCE(*pudp);
 
-		if (pud_huge(pud)) {
-			ret_pte = (pte_t *) pudp;
-			goto out;
-		}
-		if (is_hugepd(__hugepd(pud_val(pud)))) {
-			hpdp = (hugepd_t *)&pud;
-			goto out_huge;
-		}
-		pdshift = PMD_SHIFT;
-		pmdp = pmd_offset(&pud, ea);
-		pmd  = READ_ONCE(*pmdp);
-		/*
-		 * A hugepage collapse is captured by pmd_none, because
-		 * it mark the pmd none and do a hpte invalidate.
-		 */
-		if (pmd_none(pmd))
-			return NULL;
-
-		if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
-			if (is_thp)
-				*is_thp = true;
-			ret_pte = (pte_t *)pmdp;
-			goto out;
-		}
-		/*
-		 * pmd_large check below will handle the swap pmd pte
-		 * we need to do both the check because they are config
-		 * dependent.
-		 */
-		if (pmd_huge(pmd) || pmd_large(pmd)) {
-			ret_pte = (pte_t *)pmdp;
-			goto out;
-		}
-		if (is_hugepd(__hugepd(pmd_val(pmd)))) {
-			hpdp = (hugepd_t *)&pmd;
-			goto out_huge;
-		}
+	if (pud_none(pud))
+		return NULL;
 
-		return pte_offset_kernel(&pmd, ea);
+	if (pud_huge(pud)) {
+		ret_pte = (pte_t *)pudp;
+		goto out;
 	}
+	if (is_hugepd(__hugepd(pud_val(pud)))) {
+		hpdp = (hugepd_t *)&pud;
+		goto out_huge;
+	}
+	pdshift = PMD_SHIFT;
+	pmdp = pmd_offset(&pud, ea);
+	pmd  = READ_ONCE(*pmdp);
+	/*
+	 * A hugepage collapse is captured by pmd_none, because
+	 * it mark the pmd none and do a hpte invalidate.
+	 */
+	if (pmd_none(pmd))
+		return NULL;
+
+	if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
+		if (is_thp)
+			*is_thp = true;
+		ret_pte = (pte_t *)pmdp;
+		goto out;
+	}
+	/*
+	 * pmd_large check below will handle the swap pmd pte
+	 * we need to do both the check because they are config
+	 * dependent.
+	 */
+	if (pmd_huge(pmd) || pmd_large(pmd)) {
+		ret_pte = (pte_t *)pmdp;
+		goto out;
+	}
+	if (is_hugepd(__hugepd(pmd_val(pmd)))) {
+		hpdp = (hugepd_t *)&pmd;
+		goto out_huge;
+	}
+
+	return pte_offset_kernel(&pmd, ea);
+
 out_huge:
 	if (!hpdp)
 		return NULL;
-- 
2.13.3

