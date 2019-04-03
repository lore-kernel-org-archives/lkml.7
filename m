Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6423DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7042084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="e3XUR79k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDCUGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:06:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35242 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfDCUGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:06:14 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44ZHC939Pcz9v9xs;
        Wed,  3 Apr 2019 22:06:13 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=e3XUR79k; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id njmphAoaq_Ch; Wed,  3 Apr 2019 22:06:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44ZHC91Zyhz9v6Km;
        Wed,  3 Apr 2019 22:06:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554321973; bh=C2Z1JuB327icEvR5qtvCdFCYWUJoN96aYqgB9CFVtK0=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=e3XUR79kq0iUYBCGJt32XYUUHF9izsjKDP1wcu/5hPO8yI13QzEHmXH1ZrpMRihVM
         NalGDorK9DLFXLzjs9R/ZtZuL00Kka6GMYGKF149IG7FoWAmdQj8ucCPDT1TDK2UF3
         IrQKb+tILlYO+SFLKNxTAByNmPTtyOCt8Z+/bETE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 550758B905;
        Wed,  3 Apr 2019 22:06:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id P67zKlWfYnUm; Wed,  3 Apr 2019 22:06:13 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2BB8F8B902;
        Wed,  3 Apr 2019 22:06:13 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1C08C655EC; Wed,  3 Apr 2019 20:06:13 +0000 (UTC)
Message-Id: <0c8d706a693b0ca957be8ac1061a9b5ad10c03be.1554321743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 01/15] powerpc/mm: drop __bad_pte()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  3 Apr 2019 20:06:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has never been called (since Kernel has been in git at least),
drop it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 2 --
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 3633502e102c..645af86cd072 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -22,8 +22,6 @@
  */
 #define MAX_PGTABLE_INDEX_SIZE	0xf
 
-extern void __bad_pte(pmd_t *pmd);
-
 extern struct kmem_cache *pgtable_cache[];
 #define PGT_CACHE(shift) pgtable_cache[shift]
 
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index bd186e85b4f7..ea265a578eb0 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -22,8 +22,6 @@
  */
 #define MAX_PGTABLE_INDEX_SIZE	0xf
 
-extern void __bad_pte(pmd_t *pmd);
-
 extern struct kmem_cache *pgtable_cache[];
 #define PGT_CACHE(shift) pgtable_cache[shift]
 
-- 
2.13.3

