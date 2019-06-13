Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59C1C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0B22183E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP0W8yRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfFMPdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:33:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36876 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbfFMKp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:45:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh12so7981453plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uCwWLrWN30s9tONuGry7ZPwH/e/7xLPMQjqyo7O5eBk=;
        b=OP0W8yRlUthFREqCxHMZcGfrR7ObjX7GSg3sDYQOctNsRHbm2Lqcb/opmbujosV95J
         Kh99aG4N5q3cD8Qe5BzWR9WJEMlx27hM+S6fiT/SGbKF6lFXXfH5hU2LKUg7g4jKajV7
         i+CpumuA89UHiI+0KEwM0sEc8xCFxvGVPnOo/wSJ+eHrjcMmDLkXIKzRiOrMhUlW3xX2
         0j2845eItLsOowqgOEDPMtCStDCTisuEjva0X94eD9UD6KLLzhjtMkuZ7kqhppDiaS4C
         nwXrzRFqbHigTy4SOi86TzPaELfID3cNgUHIFdnNBPTaW8jZPP1i+VQqes+JkhBDgzO0
         JNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uCwWLrWN30s9tONuGry7ZPwH/e/7xLPMQjqyo7O5eBk=;
        b=txuhHFlXMOL7Wyj+JgexdUvajS8CoU/nBr842TiNLMnWVOYzh5qXof8RgR4ze2SuBU
         6ib9yeYRlxs0/EUpdlnLvIFPwBWvMPoE7CDSKIPoWHBwyQgtjHpVYA1lb/21j/9BgkaY
         oFSU+QWZLVxJOloIlXZD4sOfeHwkJz/NwkGuSl+s86ctcjSFxPM1z/SdjHR1IVKHdh6I
         qzLrk0IVng5+pQsLExfuSj6scFxyexk6/JcAvSuup0aE8KzZGuPVbSQyXpeBjztiqQ7J
         SPABW9ZS8fV9izCkGuuyaVuxznkkDbDDpZc3p1DoRC5qVyz8VUcwxkt5+5VM44Ec46xd
         UVvg==
X-Gm-Message-State: APjAAAUsvPHGaIDCYTLvZiqQSidLYf6FjoFfCrTnhfbVvpKtcoYDrNaK
        JhdAYW33I1HobhhQPNvZaA==
X-Google-Smtp-Source: APXvYqz9LfQKa/wrOUIWnFUFZ/wGYmdDsdGq/Xe0dgLwb9nKtqXnSonygBcQvBArP0L1tEzTp904NA==
X-Received: by 2002:a17:902:a506:: with SMTP id s6mr12547789plq.87.1560422758789;
        Thu, 13 Jun 2019 03:45:58 -0700 (PDT)
Received: from mylaptop.redhat.com ([2408:8207:7825:dd90:9051:d949:55f9:678b])
        by smtp.gmail.com with ESMTPSA id a13sm2813285pgh.6.2019.06.13.03.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 03:45:58 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCHv4 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in gup fast path
Date:   Thu, 13 Jun 2019 18:45:01 +0800
Message-Id: <1560422702-11403-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1560422702-11403-1-git-send-email-kernelfans@gmail.com>
References: <1560422702-11403-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FOLL_LONGTERM suggests a pin which is going to be given to hardware and
can't move. It would truncate CMA permanently and should be excluded.

FOLL_LONGTERM has already been checked in the slow path, but not checked in
the fast path, which means a possible leak of CMA page to longterm pinned
requirement through this crack.

Place a check in gup_pte_range() in the fast path.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 mm/gup.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 766ae54..de1b03f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1757,6 +1757,14 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
+		/*
+		 * FOLL_LONGTERM suggests a pin given to hardware. Prevent it
+		 * from truncating CMA area
+		 */
+		if (unlikely(flags & FOLL_LONGTERM) &&
+			is_migrate_cma_page(page))
+			goto pte_unmap;
+
 		head = try_get_compound_head(page, 1);
 		if (!head)
 			goto pte_unmap;
@@ -1900,6 +1908,12 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
+	if (unlikely(flags & FOLL_LONGTERM) &&
+		is_migrate_cma_page(page)) {
+		*nr -= refs;
+		return 0;
+	}
+
 	head = try_get_compound_head(pmd_page(orig), refs);
 	if (!head) {
 		*nr -= refs;
@@ -1941,6 +1955,12 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
+	if (unlikely(flags & FOLL_LONGTERM) &&
+		is_migrate_cma_page(page)) {
+		*nr -= refs;
+		return 0;
+	}
+
 	head = try_get_compound_head(pud_page(orig), refs);
 	if (!head) {
 		*nr -= refs;
@@ -1978,6 +1998,12 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
+	if (unlikely(flags & FOLL_LONGTERM) &&
+		is_migrate_cma_page(page)) {
+		*nr -= refs;
+		return 0;
+	}
+
 	head = try_get_compound_head(pgd_page(orig), refs);
 	if (!head) {
 		*nr -= refs;
-- 
2.7.5

