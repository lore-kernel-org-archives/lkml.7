Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E63C10F06
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE99217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2SSklts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfCLA6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:58:11 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:33424 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfCLA6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:58:06 -0400
Received: by mail-io1-f73.google.com with SMTP id n15so610226ioc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 17:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0N1MhcRbdixhLcojGjz1JbD9gYvKsU3sALAMDz5L+zQ=;
        b=m2SSklts5axBtBFT99k5kWRqt2k7AZ/UFLe5QDWp2m4MrS9nPTzvu+lW6Cw1GTX91x
         q7m9lX4AdtHIlQvrmJR+9nAGmjI1Sxwo9tCXJq3a4TfLEoryCkDdcW+2PmNyW2gIWRBs
         wTPKiJ0yJ7eAQJXABh3sNDsdXtcGTVXBZd0z6nTiMfX/ZIfTqQq83M55OBXw3KfljcNy
         jwcNX81PR159z9bI7I9PlNagdpSG7F8sKSGKprXJJKepemxzBfeWNYASGdTYUFTIqFFc
         lrAn/W9ub2uGjX9hl5ahbzfE78V49Svncz9HAlXjfo8dyifGlJnK9/F5LsE8kRnM/321
         lOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0N1MhcRbdixhLcojGjz1JbD9gYvKsU3sALAMDz5L+zQ=;
        b=DHKTfLqVZNgpTxlYmkKEMfIq9Nh+6s68j1lpTQe/d+vzU8RM5ohlnT2N8lRqM66ckk
         XmfZLCXJg/g7etNT1B2Vg7WxlxV6z9sm5Ul74O0Tzy9ixACf5KvNsKeUWdywghbY36Ai
         i0f3I+0GEb8xw5gmLzhYJ3tQXyPmuBlA0t7Nph3h6S/ltmqAhjtQoVvyAHhD/UW2WETQ
         nR8bhTtxA9vFp2lCRiVc0iZ/ehRo5B9x/DfAiE77UCSl60nB/WRm5PXFP+pVJeBZ244x
         CZ3F1RsExTfx4TRpTlxRgoYgGvVJ/AavSV3wHYpfbI2leYRQBsJ/99Zua54IQfaEykD5
         FqVw==
X-Gm-Message-State: APjAAAW+Y6TNPFitwzwa8cepJLn1Lqi6A+LhwdjdK5qckzpBiARW+euf
        PEmFWR3xIQLOTQnHAILHCaZOn2cPZPs=
X-Google-Smtp-Source: APXvYqw5KDZ39HU8Icwu4S6RpSSs7BszMpNyZQ5WJg5vOVgn5k90ODytif1OzlfBC2AtFGb/6BjcJbfFcJE=
X-Received: by 2002:a24:5a04:: with SMTP id v4mr546460ita.37.1552352285759;
 Mon, 11 Mar 2019 17:58:05 -0700 (PDT)
Date:   Mon, 11 Mar 2019 18:57:47 -0600
In-Reply-To: <20190312005749.30166-1-yuzhao@google.com>
Message-Id: <20190312005749.30166-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20190310011906.254635-1-yuzhao@google.com> <20190312005749.30166-1-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v4 2/4] arm64: mm: don't call page table ctors for init_mm
From:   Yu Zhao <yuzhao@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_mm doesn't require page table lock to be initialized at
any level. Add a separate page table allocator for it, and the
new one skips page table ctors.

The ctors allocate memory when ALLOC_SPLIT_PTLOCKS is set. Not
calling them avoids memory leak in case we call pte_free_kernel()
on init_mm.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/mm/mmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f704b291f2c5..d1dc2a2777aa 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -370,6 +370,16 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	} while (pgdp++, addr = next, addr != end);
 }
 
+static phys_addr_t pgd_kernel_pgtable_alloc(int shift)
+{
+	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
+	BUG_ON(!ptr);
+
+	/* Ensure the zeroed page is visible to the page table walker */
+	dsb(ishst);
+	return __pa(ptr);
+}
+
 static phys_addr_t pgd_pgtable_alloc(int shift)
 {
 	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
@@ -594,7 +604,7 @@ static int __init map_entry_trampoline(void)
 	/* Map only the text into the trampoline page table */
 	memset(tramp_pg_dir, 0, PGD_SIZE);
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
-			     prot, pgd_pgtable_alloc, 0);
+			     prot, pgd_kernel_pgtable_alloc, 0);
 
 	/* Map both the text and data into the kernel page table */
 	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
@@ -1070,7 +1080,8 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
-			     size, PAGE_KERNEL, pgd_pgtable_alloc, flags);
+			     size, PAGE_KERNEL, pgd_kernel_pgtable_alloc,
+			     flags);
 
 	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
 			   altmap, want_memblock);
-- 
2.21.0.360.g471c308f928-goog

