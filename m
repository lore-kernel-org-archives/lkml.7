Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F341C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B892175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="oKgFQVNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfCTKIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:08:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8626 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbfCTKGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:06:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PQYq6rttz9vC04;
        Wed, 20 Mar 2019 11:06:39 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=oKgFQVNj; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8g_cGDYGbEbI; Wed, 20 Mar 2019 11:06:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PQYq5Wbrz9vByx;
        Wed, 20 Mar 2019 11:06:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553076399; bh=h7/rZIF3uGtCrZZS12jpO81CTlxOtTpT+Awl5ww0sac=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=oKgFQVNjUVGemogterTVlY+J/TJ+hoMWMYrQegHvDjKiBNF36F+oQxK/HCWLUB+Uu
         PyO2RPMX43b8901qisEozzZP4y+UVRQP/TEEKyoqcpKDtXLWUItzKZA3fcMDy1c78J
         8XqLh5/rFDN1BSn/9XhQ+npdq+OA6KdhcH1xXQOU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D9FCE8B918;
        Wed, 20 Mar 2019 11:06:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PMN5MDTOsgIx; Wed, 20 Mar 2019 11:06:40 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF06F8B911;
        Wed, 20 Mar 2019 11:06:40 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A44CE63AEF; Wed, 20 Mar 2019 10:06:40 +0000 (UTC)
Message-Id: <463eb6599ff3ed0a3238be5e01c7d4508042f7f8.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 05/27] powerpc/mm: drop slice_set_user_psize()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 10:06:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slice_set_user_psize() is not used anymore, drop it.

Fixes: 1753dd183036 ("powerpc/mm/slice: Simplify and optimise slice context initialisation")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/slice.h | 5 -----
 arch/powerpc/include/asm/nohash/64/slice.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
index db0dedab65ee..af498b0da21a 100644
--- a/arch/powerpc/include/asm/book3s/64/slice.h
+++ b/arch/powerpc/include/asm/book3s/64/slice.h
@@ -16,11 +16,6 @@
 #else /* CONFIG_PPC_MM_SLICES */
 
 #define get_slice_psize(mm, addr)	((mm)->context.user_psize)
-#define slice_set_user_psize(mm, psize)		\
-do {						\
-	(mm)->context.user_psize = (psize);	\
-	(mm)->context.sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
-} while (0)
 
 #endif /* CONFIG_PPC_MM_SLICES */
 
diff --git a/arch/powerpc/include/asm/nohash/64/slice.h b/arch/powerpc/include/asm/nohash/64/slice.h
index ad0d6e3cc1c5..1a32d1fae6af 100644
--- a/arch/powerpc/include/asm/nohash/64/slice.h
+++ b/arch/powerpc/include/asm/nohash/64/slice.h
@@ -7,6 +7,5 @@
 #else /* CONFIG_PPC_64K_PAGES */
 #define get_slice_psize(mm, addr)	MMU_PAGE_4K
 #endif /* !CONFIG_PPC_64K_PAGES */
-#define slice_set_user_psize(mm, psize)	do { BUG(); } while (0)
 
 #endif /* _ASM_POWERPC_NOHASH_64_SLICE_H */
-- 
2.13.3

