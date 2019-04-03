Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B091AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7275820882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="b6PeFngB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfDCUHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:07:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22434 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbfDCUGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:06:21 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44ZHCH50m5z9v3ps;
        Wed,  3 Apr 2019 22:06:19 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=b6PeFngB; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PyJaZf77O8Pz; Wed,  3 Apr 2019 22:06:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44ZHCH3pBSz9v3pp;
        Wed,  3 Apr 2019 22:06:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554321979; bh=ddxEc6/ggbi1ClZar/N2xXvdQNNbwCcpDvZswkBFQiI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=b6PeFngBxWz+i7UR0mydWlAFR16HmnlLc0zoLsu1WXhPSjqRUhCjInMQzY9KnM6Y2
         xHmqXTUMSlFsJ7/SLxAdzsbpubFuzs6CS2iuN11HtXJuQgk7RUKnlT0FdaPFrN5EtU
         fF/h+8yFybiQtvpbWQ26JmTdHEWJe/Mr9cHE8ogE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A46318B905;
        Wed,  3 Apr 2019 22:06:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 91skxBs7JNvC; Wed,  3 Apr 2019 22:06:19 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 797148B902;
        Wed,  3 Apr 2019 22:06:19 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 63EF0655EC; Wed,  3 Apr 2019 20:06:19 +0000 (UTC)
Message-Id: <85bd4f5d3d12a994507ad8f6fb8c5fcdc32d26c5.1554321743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 07/15] powerpc/book3e: move early_alloc_pgtable() to init
 section
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  3 Apr 2019 20:06:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

early_alloc_pgtable() is only used during init.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable-book3e.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-book3e.c b/arch/powerpc/mm/pgtable-book3e.c
index 1032ef7aaf62..f6fc709697ee 100644
--- a/arch/powerpc/mm/pgtable-book3e.c
+++ b/arch/powerpc/mm/pgtable-book3e.c
@@ -55,7 +55,7 @@ void vmemmap_remove_mapping(unsigned long start,
 #endif
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
-static __ref void *early_alloc_pgtable(unsigned long size)
+static void __init *early_alloc_pgtable(unsigned long size)
 {
 	void *ptr;
 
@@ -74,7 +74,7 @@ static __ref void *early_alloc_pgtable(unsigned long size)
  * map_kernel_page adds an entry to the ioremap page table
  * and adds an entry to the HPT, possibly bolting it
  */
-int map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
+int __ref map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
 {
 	pgd_t *pgdp;
 	pud_t *pudp;
-- 
2.13.3

