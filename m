Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BADC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CF021D7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696814;
	bh=rgUASk+qHXvrsXRxbaZLq2x3+KI4P2PsXhbri1vX0Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ecbW08SyqJXALX4ATmY6u6WVgPNOqZMq/uTbeHHGRxt+KIqSC+2zHnvCOS4pMSeq2
	 B37fdw4pIGLvTwQxF7KMKziPt3UhajlKR+dkhQx5kw+kZnKfs96RgaKeZ8XfVYgYF8
	 ty9lhWpVUmH3EfUAUoTzCCzFiKJUKphUM6MIPLQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388059AbfJJIkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387411AbfJJIkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:40:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F8AC218AC;
        Thu, 10 Oct 2019 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696811;
        bh=rgUASk+qHXvrsXRxbaZLq2x3+KI4P2PsXhbri1vX0Y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QsdXqHajKGLdOI9HT80Y1zYt4GIv/Egm99/TXpapE2ir5eYwYWgtRbPoWeP1DeRx1
         TT6snfE9kClbOnOtMmEqR8SRjPeHerDmfTt6zBLKxHgEt0z/+bV1b1uCNMvjKR1/w1
         NW7b1eArT6c5dIGuEur8K2s78+AaynOYpfjEwFqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.3 034/148] powerpc/mm: Add a helper to select PAGE_KERNEL_RO or PAGE_READONLY
Date:   Thu, 10 Oct 2019 10:34:55 +0200
Message-Id: <20191010083613.220293397@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 4c0f5d1eb4072871c34530358df45f05ab80edd6 upstream.

In a couple of places there is a need to select whether read-only
protection of shadow pages is performed with PAGE_KERNEL_RO or with
PAGE_READONLY.

Add a helper to avoid duplicating the choice.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/9f33f44b9cd741c4a02b3dce7b8ef9438fe2cd2a.1566382750.git.christophe.leroy@c-s.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/kasan/kasan_init_32.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -12,6 +12,14 @@
 #include <asm/code-patching.h>
 #include <mm/mmu_decl.h>
 
+static pgprot_t kasan_prot_ro(void)
+{
+	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
+		return PAGE_READONLY;
+
+	return PAGE_KERNEL_RO;
+}
+
 static void kasan_populate_pte(pte_t *ptep, pgprot_t prot)
 {
 	unsigned long va = (unsigned long)kasan_early_shadow_page;
@@ -26,6 +34,7 @@ static int __ref kasan_init_shadow_page_
 {
 	pmd_t *pmd;
 	unsigned long k_cur, k_next;
+	pgprot_t prot = kasan_prot_ro();
 
 	pmd = pmd_offset(pud_offset(pgd_offset_k(k_start), k_start), k_start);
 
@@ -43,10 +52,7 @@ static int __ref kasan_init_shadow_page_
 
 		if (!new)
 			return -ENOMEM;
-		if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
-			kasan_populate_pte(new, PAGE_READONLY);
-		else
-			kasan_populate_pte(new, PAGE_KERNEL_RO);
+		kasan_populate_pte(new, prot);
 
 		smp_wmb(); /* See comment in __pte_alloc */
 
@@ -103,10 +109,9 @@ static int __ref kasan_init_region(void
 
 static void __init kasan_remap_early_shadow_ro(void)
 {
-	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
-		kasan_populate_pte(kasan_early_shadow_pte, PAGE_READONLY);
-	else
-		kasan_populate_pte(kasan_early_shadow_pte, PAGE_KERNEL_RO);
+	pgprot_t prot = kasan_prot_ro();
+
+	kasan_populate_pte(kasan_early_shadow_pte, prot);
 
 	flush_tlb_kernel_range(KASAN_SHADOW_START, KASAN_SHADOW_END);
 }


