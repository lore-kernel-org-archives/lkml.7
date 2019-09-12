Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92DBC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9070C2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qrUvIVrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbfILNto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:49:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55649 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731209AbfILNtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:49:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Tg9w1RXhz9tyn5;
        Thu, 12 Sep 2019 15:49:40 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qrUvIVrv; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hpAv2H5-e49M; Thu, 12 Sep 2019 15:49:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Tg9w0PGXz9tyn0;
        Thu, 12 Sep 2019 15:49:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568296180; bh=xYjdjMd3IzqCkqX7OFLoQ6OwTDjszHtjM+gPrZ7fiKs=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=qrUvIVrvUWkV/DGEmSsWceBFvK/c6pNvodtTxhG+OSUnqtRM2byxN7EGqRtqmFR4R
         t8uzBhKIQcqONramjupGlwEmGC3PWV6VH4DjU7lCb0iblNUrQFkSb3eDMorD9p2BrI
         Pb3mF1+1UNyNnSdqBaNQddbJmmfgpgEnVxRoWQro=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 90ADB8B93B;
        Thu, 12 Sep 2019 15:49:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KZIelHUJ8zoG; Thu, 12 Sep 2019 15:49:41 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5AEBF8B933;
        Thu, 12 Sep 2019 15:49:41 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3D6236B736; Thu, 12 Sep 2019 13:49:41 +0000 (UTC)
Message-Id: <41c99bc06394a6bc2888631cb98a3ed2ae281ddb.1568295907.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1568295907.git.christophe.leroy@c-s.fr>
References: <cover.1568295907.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 1/4] powerpc/fixmap: don't clear fixmap area in
 paging_init()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 12 Sep 2019 13:49:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixmap is intended to map things permanently like the IMMR region on
FSL SOC (8xx, 83xx, ...), so don't clear it when initialising paging()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/mem.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index be941d382c8d..278be4712e10 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -216,14 +216,6 @@ void __init paging_init(void)
 	unsigned long long total_ram = memblock_phys_mem_size();
 	phys_addr_t top_of_ram = memblock_end_of_DRAM();
 
-#ifdef CONFIG_PPC32
-	unsigned long v = __fix_to_virt(__end_of_fixed_addresses - 1);
-	unsigned long end = __fix_to_virt(FIX_HOLE);
-
-	for (; v < end; v += PAGE_SIZE)
-		map_kernel_page(v, 0, __pgprot(0)); /* XXX gross */
-#endif
-
 #ifdef CONFIG_HIGHMEM
 	map_kernel_page(PKMAP_BASE, 0, __pgprot(0));	/* XXX gross */
 	pkmap_page_table = virt_to_kpte(PKMAP_BASE);
-- 
2.13.3

