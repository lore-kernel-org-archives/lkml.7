Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B6EC4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1172075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="aXEScg1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbfILNtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:49:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:27554 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731209AbfILNtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:49:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Tg9z2Nmwz9tyn3;
        Thu, 12 Sep 2019 15:49:43 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=aXEScg1F; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Yf2tTHIzP6K1; Thu, 12 Sep 2019 15:49:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Tg9z1L1Nz9tyn0;
        Thu, 12 Sep 2019 15:49:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568296183; bh=KU6AEUzEcWurX6mbJ0LIIhHMpx0GSfPDvF/i/o76nqg=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=aXEScg1FLqxUKEbEWgWFiv2fc6vmxCKLtKSWvFvLtZc6rlWIeDCgRoqlBGxdpUj/N
         BkDCF1SFxM/9MF9jHAt9XE4dnHhb8fQ9CFE1USfDeHsODwhCPdr8KMAiJ3ayV37M7C
         UoBjoktMUeLie6kOllNR4bIr3THcqvu11L55P7LQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AF1BF8B93B;
        Thu, 12 Sep 2019 15:49:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eyoByRudMvqj; Thu, 12 Sep 2019 15:49:44 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C59E8B933;
        Thu, 12 Sep 2019 15:49:44 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5EE826B736; Thu, 12 Sep 2019 13:49:44 +0000 (UTC)
Message-Id: <b4f03a68ee8e68773c8973d74ec35f9c82c72871.1568295907.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1568295907.git.christophe.leroy@c-s.fr>
References: <cover.1568295907.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 4/4] powerpc/ioremap: warn on early use of ioremap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 12 Sep 2019 13:49:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Powerpc now has EARLY_IOREMAP.

Next step is to convert all early users of ioremap() to
early_ioremap().

Add a warning to help locate those users.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/ioremap_32.c | 1 +
 arch/powerpc/mm/ioremap_64.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/ioremap_32.c b/arch/powerpc/mm/ioremap_32.c
index f36121f25243..743e11384dea 100644
--- a/arch/powerpc/mm/ioremap_32.c
+++ b/arch/powerpc/mm/ioremap_32.c
@@ -68,6 +68,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *call
 	/*
 	 * Should check if it is a candidate for a BAT mapping
 	 */
+	pr_warn("ioremap() called early from %pS. Use early_ioremap() instead\n", caller);
 
 	err = early_ioremap_range(ioremap_bot - size, p, size, prot);
 	if (err)
diff --git a/arch/powerpc/mm/ioremap_64.c b/arch/powerpc/mm/ioremap_64.c
index fd29e51700cd..50a99d9684f7 100644
--- a/arch/powerpc/mm/ioremap_64.c
+++ b/arch/powerpc/mm/ioremap_64.c
@@ -81,6 +81,8 @@ void __iomem *__ioremap_caller(phys_addr_t addr, unsigned long size,
 	if (slab_is_available())
 		return do_ioremap(paligned, offset, size, prot, caller);
 
+	pr_warn("ioremap() called early from %pS. Use early_ioremap() instead\n", caller);
+
 	err = early_ioremap_range(ioremap_bot, paligned, size, prot);
 	if (err)
 		return NULL;
-- 
2.13.3

