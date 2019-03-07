Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2048BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7AB2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="X73Hfy+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfCGOkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:40:49 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41723 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfCGOkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:40:49 -0500
Received: by mail-qt1-f196.google.com with SMTP id v10so17290860qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 06:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=o+Bdw4J7jteKQc6pumb4pNEyFr19MhGJj322ozeVKAE=;
        b=X73Hfy+jKgTjuqzFVd28M5ioPkJ9mXwmLTOSTZrYdEQUA5TVop/Ot2ZfW00VcWXpMZ
         r3TbYV2DQ9hrPMiaouaaEBvRLuaWPu/vcpWnNk8xR65mN49cyMKCE+NNplfwy/vrgmjB
         XyE1y2kl6/PfRWfHlTEfqVoTXzJAEBW59Rjwgz/BHgW5jy3bZUK24SDws7Bl1ATmcfZy
         MoP1gzHmdEZJoeYcUiLsyh0ES3MUjdUggeggXz/JXLCKvF9AwVmSNBltlc+1XwjaUsbD
         znSBf7BpnWwadIF5jX4RSE2S56VimVV3oYP5PKzEs01d71I85Dtloq7fSGNazwVY8eFN
         QUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o+Bdw4J7jteKQc6pumb4pNEyFr19MhGJj322ozeVKAE=;
        b=uQmpS6wRBAtbuUctM0I+Y6DsSxT1slbiF7iAKyq798NDcrRDitkKsjvxSk8ssnF5Uv
         ifFIf79oq/ihk/jsvIepv1NYDcoiMizRTeNJ6QHMbPP9aUehLin8MtlK4rKPDPJjY3N2
         UcWJWSaJNJdPMqU4ncnft+B7eQf1/O3D/cFY/VaCwiZPKHmi25JSQJkbQV4NHocm+w6J
         20xsIbS3aBVD2PE98CRh+dD3yTPyz7Jpj3OupZPftGqtF8XmnBXbI+N3zhswXYfk29xM
         BzVrZ3vGPoI6o/x6K8SNWJhmO9YfrQIP2hyktmJ80k9+XfGMiEAoVG98KvXwDtr6ks4Q
         n81A==
X-Gm-Message-State: APjAAAXTFfWPy4s+hOkb7ZMCUaS4wpHxy6O0WFjIwDDXJDT+R6BMUZC3
        T5F7jSxGvV7pHVwVfP0Iv2rRJHsMXl8=
X-Google-Smtp-Source: APXvYqwu4MSml3H1uDeihUyFRS/RjLs9Ov7p9x56I0MUlRQpOvBPZS/PJGIOvIAQHBOQG4cl4Ij1kw==
X-Received: by 2002:a0c:bd15:: with SMTP id m21mr10857078qvg.246.1551969647614;
        Thu, 07 Mar 2019 06:40:47 -0800 (PST)
Received: from ovpn-121-103.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b83sm2642067qkg.12.2019.03.07.06.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 06:40:46 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] powerpc: silence unused-but-set-variable warnings
Date:   Thu,  7 Mar 2019 09:40:31 -0500
Message-Id: <20190307144031.52494-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_unmap() compiles away on some powerpc platforms, so silence the
warnings below by making it a static inline function.

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

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: make it a static inline function.

 arch/powerpc/include/asm/book3s/64/pgtable.h | 3 ++-
 arch/powerpc/include/asm/nohash/64/pgtable.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 868fcaf56f6b..d798e33a0c86 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1006,7 +1006,8 @@ extern struct page *pgd_page(pgd_t pgd);
 	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while(0)
+
+static inline void pte_unmap(pte_t *pte) { }
 
 /* to find an entry in a kernel page-table-directory */
 /* This now only contains the vmalloc pages */
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index e77ed9761632..0384a3302fb6 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -205,7 +205,8 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
   (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while(0)
+
+static inline void pte_unmap(pte_t *pte) { }
 
 /* to find an entry in a kernel page-table-directory */
 /* This now only contains the vmalloc pages */
-- 
2.17.2 (Apple Git-113)

