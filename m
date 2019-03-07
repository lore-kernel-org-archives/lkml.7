Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E47AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2691B20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="H0t6WsJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCGDsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 22:48:40 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43551 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfCGDsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 22:48:40 -0500
Received: by mail-qk1-f195.google.com with SMTP id s26so132400qkm.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 19:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cfMkd7k5sfsoufvYvmOTamvmreEyC+E68UQtEbBo5qI=;
        b=H0t6WsJxPvqVTlR4Q3olCA72TjvAPUP+vKPl9pHZXpppxrE8Ns3we2BgNC0dTLc4os
         B9muEuGM7xEDfL7tanpS8Kwgcc9TmhwQ45G0ES/P0fjVNU7h1yf2Ae4vDOkvawcAIWH/
         wwzVnzUQFgOGqfLCG0GEGYgXEtzBx+SZYA9AXsviSIyhZ6/b5gFDWemapxo/KTDjuR2/
         bz6kxTpOJXYJW+0IzOjaI9zKDtlwNDjyODxSRpVsRdzVlmtmrSS0NnG4a8voiH6PQspM
         3SaMYjyZqGxQDLKsUO57bbF1pq8/MYOXk2aqNcRq0lBF8ReXyyq0yAinonZ6iIeSbyKu
         nc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cfMkd7k5sfsoufvYvmOTamvmreEyC+E68UQtEbBo5qI=;
        b=E5XoN7VruIpuLkv6AvlDbBV/0MUVHy2GPRCQ9tzr3csuUQJJzTWdHK6g4ZlBXXkmUM
         E5Eo/7RUbf5EOm7eebAX1gmTGcPCpsRxftIjkkqW3G3k+2nPLVq4vpACDkbIpwo7p77V
         21Zqv2Pe1z6sjOqrOKgYiVnPm4AzJH/6ZE5CAys3P5fLBNwdfz2TXBx5nnR3afmFuGqO
         PX8+ZetMr5ZQBPwo9E0TLDCpwgeyVyBURjQbjNyQ58IwWaNJ4kGlwD52Ve9ESa2UJr+z
         Q8leV/zSy8h0pXXrkrHLu+XBEWyPW4hEzLNgCXxj8r1PYXfsGd+kZkTHCgGSwA3ZFPqS
         NbJQ==
X-Gm-Message-State: APjAAAXojcIIB1m0JtzJ5faj48za2Z9sWraW2BxbVVTP8oDp9GBp5jPR
        /gPw5curOVEfh22iN73tHE9FdQ==
X-Google-Smtp-Source: APXvYqwBvaruU+dvEpOiKiLSyAr5JJG0Xdp9CifuxSx7Xxz/lqhTZ12AZRaEKlSPq47iFlbTRT9Uag==
X-Received: by 2002:a37:f507:: with SMTP id l7mr8630648qkk.302.1551930518976;
        Wed, 06 Mar 2019 19:48:38 -0800 (PST)
Received: from ovpn-121-103.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p127sm1726897qke.97.2019.03.06.19.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 19:48:38 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc: silence unused-but-set-variable warnings
Date:   Wed,  6 Mar 2019 22:48:21 -0500
Message-Id: <20190307034821.48769-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_unmap() compiles away on some powerpc platforms, so silence the
warnings below by using the argument to pte_unmap() as a nop. Also, fix
checkpatch.pl warnings "Single statement macros should not use a do {}
while (0) loop".

mm/memory.c: In function 'copy_pte_range':
mm/memory.c:820:24: warning: variable 'orig_dst_pte' set but not used
[-Wunused-but-set-variable]
mm/memory.c:820:9: warning: variable 'orig_src_pte' set but not used
[-Wunused-but-set-variable]
mm/madvise.c: In function 'madvise_free_pte_range':
mm/madvise.c:318:9: warning: variable 'orig_pte' set but not used
[-Wunused-but-set-variable]
mm/swap_state.c: In function 'swap_ra_info':
mm/swap_state.c:634:15: warning: variable 'orig_pte' set but not used
[-Wunused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 868fcaf56f6b..ec00ce6dd312 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1006,7 +1006,7 @@ extern struct page *pgd_page(pgd_t pgd);
 	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while(0)
+#define pte_unmap(pte)			(void)(pte)
 
 /* to find an entry in a kernel page-table-directory */
 /* This now only contains the vmalloc pages */
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index e77ed9761632..103071afab3d 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -205,7 +205,7 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
   (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while(0)
+#define pte_unmap(pte)			(void)(pte)
 
 /* to find an entry in a kernel page-table-directory */
 /* This now only contains the vmalloc pages */
-- 
2.17.2 (Apple Git-113)

