Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A2BC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF242077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PpwmZjpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfD0B26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:28:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43761 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfD0B25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:28:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id p19so2994941qkm.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 18:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oHeHzzA1NET7RP13gd+P20tu4K3AiVm8gbpCJItFTxQ=;
        b=PpwmZjpqiy7eZyc1O3V0XR2dEP6lpKzTHKB3B2rxoSWupwh8l/oYytCQu+S2iNsJN4
         2saDt0WgVllLtHQ72JFbfhl3ROUJ+UhHMyGuco/0hP6nshU8e/yP84WrDZzvd6+ZRf4P
         QyuMdgujPkQef+nxsmkbuGmrGCip1XA62j/I6AtkZBA8e06KmZRElG/rYFOw1ZNTJpjf
         uPxZkyUhyudoFXqYb5gib/hqD94nGJnPU7oaPruyrod6TNR8pLUvdicA97olrg+ng59O
         erfwBKu9Fb+P7ycClozdeNKF+n5ozaslTcpt8yM9lH2jqZ3msPkQUJPen4clJiBWwK6O
         cJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oHeHzzA1NET7RP13gd+P20tu4K3AiVm8gbpCJItFTxQ=;
        b=o4iu+zuKEE1wtQhuPmT9YF5BPbba9348X/WiYNm32XNuG9V+E3xHYa/Kho+OZfRZaY
         pgnXtXsZL7RZzKOcgLuJulPphEeNIJmBPfrOm+GWvqdyVdtcf8+n6OKrxYqsYKs2WIfL
         +hJXromK7IJEe03ICScF7hVorCxR3+WNFywOW2VE5qzXBjDk/g7bArK+K3hM1QVrPNCt
         zkIYDylb3FB7CyKJX/XmIxbtfh7FAR8Hw8e+ErgxtgPm8XUw3lJ4qOLzFoZrcCAFT2ZT
         sdlm3xoNWpj44j/RCHLCHim3qu1Fk8CJ7vo3hV8H/77cYlIYXrWo5kJjC7uZyt5RLQd5
         NwKA==
X-Gm-Message-State: APjAAAXhsDb3bIWfbSq5ompN8PIG5Bs1PHJJTXIveu/3nJcsVLdBgGUO
        yBA+bHtYRlmUA/f0NvgfARasZw==
X-Google-Smtp-Source: APXvYqxnybOblYjuohhgwpoBuKlkjQnRfY3zET98yQwp3XRoPFFMiE8uV3r1H69pDpQl9LbPARlaig==
X-Received: by 2002:a37:49ce:: with SMTP id w197mr28382910qka.330.1556328536765;
        Fri, 26 Apr 2019 18:28:56 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z8sm17641150qth.62.2019.04.26.18.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 18:28:56 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64: fix pte_unmap() -Wunused-but-set-variable
Date:   Fri, 26 Apr 2019 21:28:42 -0400
Message-Id: <20190427012842.93737-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many compilation warnings due to pte_unmap() compiles away. Fixed it by
making it an static inline function.

mm/gup.c: In function 'gup_pte_range':
mm/gup.c:1727:16: warning: variable 'ptem' set but not used
[-Wunused-but-set-variable]
mm/gup.c: At top level:
mm/memory.c: In function 'copy_pte_range':
mm/memory.c:821:24: warning: variable 'orig_dst_pte' set but not used
[-Wunused-but-set-variable]
mm/memory.c:821:9: warning: variable 'orig_src_pte' set but not used
[-Wunused-but-set-variable]
mm/swap_state.c: In function 'swap_ra_info':
mm/swap_state.c:641:15: warning: variable 'orig_pte' set but not used
[-Wunused-but-set-variable]
mm/madvise.c: In function 'madvise_free_pte_range':
mm/madvise.c:318:9: warning: variable 'orig_pte' set but not used
[-Wunused-but-set-variable]

Also, remove pte_unmap_nested() as nobody uses it anymore since the
commit ece0e2b6406a ("mm: remove pte_*map_nested()").

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index de70c1eabf33..7543e345e078 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -478,6 +478,8 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 	return __pmd_to_phys(pmd);
 }
 
+static inline void pte_unmap(pte_t *pte) { }
+
 /* Find an entry in the third-level page table. */
 #define pte_index(addr)		(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 
@@ -486,8 +488,6 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
 #define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while (0)
-#define pte_unmap_nested(pte)		do { } while (0)
 
 #define pte_set_fixmap(addr)		((pte_t *)set_fixmap_offset(FIX_PTE, addr))
 #define pte_set_fixmap_offset(pmd, addr)	pte_set_fixmap(pte_offset_phys(pmd, addr))
-- 
2.20.1 (Apple Git-117)

