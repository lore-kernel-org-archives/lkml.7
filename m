Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF38C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6042087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011470;
	bh=Mul0E8HVTIwUIJumJMenw8NuqJ7QN5bugakid710Lpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iTmCQqrjO8Hb5NGkkHbMMCJDo3HbwNbi1jf3YULICv57lN+at0ve+GDZ7VPPcUJyy
	 JB5Bmol8O8ShD6UwKOSsAykGe01BEl1jLYXooBv+I1mTubkUb9dPxumqFQjmbkevoL
	 Gi0Emj/cEDfYZvOhvjBeEMika7MAbZcxZqNwl59k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfHENY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:32932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730182AbfHENYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:24:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D079A2067D;
        Mon,  5 Aug 2019 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011463;
        bh=Mul0E8HVTIwUIJumJMenw8NuqJ7QN5bugakid710Lpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOq9b7q0gzZB5STY7HSIPEjX2P5CR0Uj0wnoqeYkDutiJX/fifF+ltMIp3NDbieYv
         DQZFQi+j1xMiqf/tSD9WNWM02eKMOrZx/g2G4yoAS6cL53ORg5QNS5UqK5/Fk2LJ6K
         0t8eUOJjZb+sCQX1hs6hhA2S/67Gw2uAkrT8wjXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Erhard F." <erhard_f@mailbox.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.2 097/131] powerpc/kasan: fix early boot failure on PPC32
Date:   Mon,  5 Aug 2019 15:03:04 +0200
Message-Id: <20190805124958.459176172@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit d7e23b887f67178c4f840781be7a6aa6aeb52ab1 upstream.

Due to commit 4a6d8cf90017 ("powerpc/mm: don't use pte_alloc_kernel()
until slab is available on PPC32"), pte_alloc_kernel() cannot be used
during early KASAN init.

Fix it by using memblock_alloc() instead.

Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
Cc: stable@vger.kernel.org # v5.2+
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/da89670093651437f27d2975224712e0a130b055.1564552796.git.christophe.leroy@c-s.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/kasan/kasan_init_32.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -21,7 +21,7 @@ static void kasan_populate_pte(pte_t *pt
 		__set_pte_at(&init_mm, va, ptep, pfn_pte(PHYS_PFN(pa), prot), 0);
 }
 
-static int kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_end)
+static int __ref kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_end)
 {
 	pmd_t *pmd;
 	unsigned long k_cur, k_next;
@@ -35,7 +35,10 @@ static int kasan_init_shadow_page_tables
 		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
 			continue;
 
-		new = pte_alloc_one_kernel(&init_mm);
+		if (slab_is_available())
+			new = pte_alloc_one_kernel(&init_mm);
+		else
+			new = memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE);
 
 		if (!new)
 			return -ENOMEM;


