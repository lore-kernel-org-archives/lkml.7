Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D72C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07ACD2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qQAJot6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfDYO3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:29:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21463 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfDYO3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:29:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44qfhQ3tGsz9v06d;
        Thu, 25 Apr 2019 16:29:26 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qQAJot6F; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Av73lSOS5JGQ; Thu, 25 Apr 2019 16:29:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44qfhQ2sPdz9v06V;
        Thu, 25 Apr 2019 16:29:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556202566; bh=C0pI7OuqdqJjDJPx/G2jlQ36a7ecvUiD6ZnPKJKabpk=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=qQAJot6F4CzzctiGcaTN7hvkKV00uZMDDU7Kfz2yWpGsINLDN37xXzpWVzOzg4O1l
         h7o3DWjowY8THdA8Qh2nSAjRu5Q3nQe6oDvZ/hp8gzwNA9syj9qax4DNzeM0bLH5tK
         sWoPUflZRTHevOW3m/KBD0L+nxLxMiSfDV3Oori8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E80F88B931;
        Thu, 25 Apr 2019 16:29:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1NT2jBOjNS4x; Thu, 25 Apr 2019 16:29:27 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B94AB8B923;
        Thu, 25 Apr 2019 16:29:27 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 91DAD66276; Thu, 25 Apr 2019 14:29:27 +0000 (UTC)
Message-Id: <3814377306ac3acdd404e2f23ff05dcf7e6bee26.1556202029.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556202028.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 01/11] powerpc/mm: fix erroneous duplicate slb_addr_limit
 init
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Apr 2019 14:29:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 67fda38f0d68 ("powerpc/mm: Move slb_addr_linit to
early_init_mmu") moved slb_addr_limit init out of setup_arch().

Commit 701101865f5d ("powerpc/mm: Reduce memory usage for mm_context_t
for radix") brought it back into setup_arch() by error.

This patch reverts that erroneous regress.

Fixes: 701101865f5d ("powerpc/mm: Reduce memory usage for mm_context_t for radix")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/setup-common.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 1729bf409562..7af085b38cd1 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -950,12 +950,6 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = klimit;
 
-#ifdef CONFIG_PPC_MM_SLICES
-#if defined(CONFIG_PPC_8xx)
-	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
-#endif
-#endif
-
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	mm_iommu_init(&init_mm);
 #endif
-- 
2.13.3

