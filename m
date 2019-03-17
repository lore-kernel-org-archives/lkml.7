Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FDEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030EE2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lb3u8a6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfCQWGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 18:06:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46762 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfCQWGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 18:06:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id i5so8545212qkd.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 15:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IcWacMfHF/AVn0k21ppx7/coY7WOvCyg2dM8iR4NJXs=;
        b=lb3u8a6pPVm8uoNsiHm5xunrfvg339f1A6zuVExgsvlk9TxKL7iwpSWadBnhT4yEVc
         j03Y2HrKwWQgLmr6JuGYlkM6jOlHsfwb7UxkXT41uHcrUIoSvjzbZH5UqzS41htO+H50
         nLrNYFN4oZLh54fQp6k3C72Z4hnvjzKCL/mHmtoB3FvMdzGoC4HM5B/IgEeGRFiWOXR8
         K18GEfFWmPnQuqI68PhPfc8sCVbYSs43UP03OqdK2DDeeEEQZgKyYm2hH2ThtWOFVPsm
         XR/pKlUjmJ+bCEdzYSwj8OmNWsI7+2Z27SnG4fChJVR5fPkg3S2xLcS9vj7mK/iDDydj
         kiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IcWacMfHF/AVn0k21ppx7/coY7WOvCyg2dM8iR4NJXs=;
        b=o5vg9Q2HwMytIeGFLQRSQH5DB19W0PF4c9tp0lQTrnI7ayt5IDL1fI7z5ujUuF7KXy
         u1cbII6WLDgkssXd1U5LjSxUhUFxkjYFK56bG9T2DQnsZC2Kl/mpv+0rXOjQsIVEiuwq
         XaF3/WRhWy9GhDAEFwEbYe8xqKpwKJv2mWd6Y011hb3mfq2RK3v0SlNejYdj9djyA9HV
         ElJF9rmFE1GO0IhsFRZwNStMvJCjzMa2NTsVjsvGNIQeI8XEqjh3xVvkJPzMH7LHDuZi
         R4ShazZqjLeGbhIFq8gMvKUCqK460D4mkZOR1+042SDo9w2flREFsw1wCzwRthJrujM6
         4YYg==
X-Gm-Message-State: APjAAAXBGh07xs9ZEE/FXafIZUUVXGvBKwy5irip1sCSfdsDDXENnrtl
        +XBr/WTCq3J91GbrOclx21775g==
X-Google-Smtp-Source: APXvYqxfYLcIq0OWqTUdqZV1k4PcSOCNVkvQqMCLCRcSu2rH8enduAxIzpi0NgtRFm6Q0+zQWaDN3g==
X-Received: by 2002:a37:4b4e:: with SMTP id y75mr10734924qka.158.1552860366714;
        Sun, 17 Mar 2019 15:06:06 -0700 (PDT)
Received: from ovpn-116-105.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x29sm5339984qtm.74.2019.03.17.15.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 15:06:06 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH v2] powerpc: mute unused-but-set-variable warnings
Date:   Sun, 17 Mar 2019 18:05:16 -0400
Message-Id: <20190317220516.92654-1-cai@lca.pw>
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
Reviewed-by:: Christophe Leroy <christophe.leroy@c-s.fr>
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

