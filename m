Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0993FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CD02175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PvdmPulf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfCTKIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:08:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64298 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfCTKGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:06:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PQYn5FKMz9vC01;
        Wed, 20 Mar 2019 11:06:37 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PvdmPulf; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5cGSIn7k_SbG; Wed, 20 Mar 2019 11:06:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PQYn4578z9vByx;
        Wed, 20 Mar 2019 11:06:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553076397; bh=XMnpdij0lJYntaQnJxTgXX8uHpknTcgE4njbUx620Ec=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=PvdmPulfodAoMdDiTkNtRzcBq9ESvZQ6gx4OJsCeDi4j+xeP0m94uhXO9FtPtFztI
         ArU8Yo7gt6R3SdmsN0lVhnr9fr0/6KyoOFTzNX1VnPVzQpvmLPxkve9g92eCayvgTr
         oCgB413oxBr5lNN8XhEicgftRnDasABApQkN/sKE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A90818B918;
        Wed, 20 Mar 2019 11:06:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 87GHPVL2yRWI; Wed, 20 Mar 2019 11:06:38 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E1588B911;
        Wed, 20 Mar 2019 11:06:38 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8231063AEF; Wed, 20 Mar 2019 10:06:38 +0000 (UTC)
Message-Id: <f67363798e1ffb7603cd6619cb867563e4126d9a.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 03/27] powerpc/mm: don't BUG() in slice_mask_for_size()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 10:06:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When no mask is found for the page size, WARN() and return NULL
instead of BUG()ing.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/slice.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index aec91dbcdc0b..011d470ea340 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -165,7 +165,8 @@ static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
 	if (psize == MMU_PAGE_16G)
 		return &mm->context.mask_16g;
 #endif
-	BUG();
+	WARN_ON(true);
+	return NULL;
 }
 #elif defined(CONFIG_PPC_8xx)
 static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
@@ -178,7 +179,8 @@ static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
 	if (psize == MMU_PAGE_8M)
 		return &mm->context.mask_8m;
 #endif
-	BUG();
+	WARN_ON(true);
+	return NULL;
 }
 #else
 #error "Must define the slice masks for page sizes supported by the platform"
-- 
2.13.3

