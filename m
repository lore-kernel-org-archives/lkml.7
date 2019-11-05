Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1EFCA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06A6214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TPTDOXVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfKECUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 21:20:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42862 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbfKECUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 21:20:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id s5so5729692pfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 18:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7b2y3zgo8qKKjwrv6gUDcqxB+dAh/ssjQVAiaSKyz7Q=;
        b=TPTDOXVlU4Ws9mRO9LEwkd5W6sg+gRV8f6gRKqE655V1UndxFs8t5BPpP8StgUXNoG
         46ihj7sC20mR7XvKUo4Xj6mhrUgxm9j6i7M+Z/mpBg3AL/IkW8pQ4nOwYyGeZqcYMu0j
         0rCbCzaBYgooSEH2EB+VJgT9jKBxxDJww9tcWwJImuCYZb8//6quyO8BRJYok01ITSjp
         GILCJ1yAAieQ1baq+COTX+5ihc2umosJWZgPNJT8WTf1/ll/996vgXHupAvHbUDNKiFs
         qtQklXVxCbMul9siP++iinLe2XUl0RyjXoYNE9zeR/tuJmBFbmu9ZYbYErP7hkQ1rtrA
         FUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7b2y3zgo8qKKjwrv6gUDcqxB+dAh/ssjQVAiaSKyz7Q=;
        b=hvBy5VI6B9+fKAtFv8piFdCMHsDR6iBzNoHfRIutLkLi6qN9CRr2QEOqaWNgRZlJoV
         1feR2TiRJgTk1QC6Ah2xitGry/YPK2mgQ/lPIT/6HY6xwjnIdVdCvXT4F57XV9clD1fY
         nW4rklqiDinkgOsFRBVhi6vQG7clXp7MfQvlXmwT/0GCpjie9kqFgdGpfsZXfQuf643j
         o7AbJpWSdQNhosiwINergo5EylsrTKfhB5BPiWwoxNl2Nh9VEPeomNmnRXTB37G4A7zv
         QyCUg02TvaUonagXfDI6EHm20EthG2yipdfWhVDijZwTIY2ppjumkUuIYW29btjgEzS9
         zPJA==
X-Gm-Message-State: APjAAAUFYMFkWK+awXbS4JjbN6UFShNRZg4xXgAm+WgeiuddncIwuHcI
        Ijl7zW2vpARvGnIQQdKCIiScuNbZwFI=
X-Google-Smtp-Source: APXvYqxhgOLlKkh3nf5acik48nMMfKxZywcjeW4trXTCKPfHOjiCvY+zpJGEw9VefSRc7EiasIIn7Q==
X-Received: by 2002:a17:90a:c082:: with SMTP id o2mr3132965pjs.94.1572920416635;
        Mon, 04 Nov 2019 18:20:16 -0800 (PST)
Received: from gamma07.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id i32sm10313443pgl.73.2019.11.04.18.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Nov 2019 18:20:16 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, palmer@sifive.com, Anup.Patel@wdc.com
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2] riscv: Use PMD_SIZE to repalce PTE_PARENT_SIZE
Date:   Mon,  4 Nov 2019 18:20:12 -0800
Message-Id: <1572920412-15661-1-git-send-email-zong.li@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMD_SIZE is equal to PGDIR_SIZE when __PAGETABLE_PMD_FOLDED is
defined.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/mm/init.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 573463d..642b330 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -273,7 +273,6 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
 #define get_pgd_next_virt(__pa)	get_pmd_virt(__pa)
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
 	create_pmd_mapping(__nextp, __va, __pa, __sz, __prot)
-#define PTE_PARENT_SIZE		PMD_SIZE
 #define fixmap_pgd_next		fixmap_pmd
 #else
 #define pgd_next_t		pte_t
@@ -281,7 +280,6 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
 #define get_pgd_next_virt(__pa)	get_pte_virt(__pa)
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
 	create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
-#define PTE_PARENT_SIZE		PGDIR_SIZE
 #define fixmap_pgd_next		fixmap_pte
 #endif
 
@@ -316,10 +314,10 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 {
 	uintptr_t map_size = PAGE_SIZE;
 
-	/* Upgrade to PMD/PGDIR mappings whenever possible */
-	if (!(base & (PTE_PARENT_SIZE - 1)) &&
-	    !(size & (PTE_PARENT_SIZE - 1)))
-		map_size = PTE_PARENT_SIZE;
+	/* Upgrade to PMD_SIZE mappings whenever possible */
+	if (!(base & (PMD_SIZE - 1)) &&
+	    !(size & (PMD_SIZE - 1)))
+		map_size = PMD_SIZE;
 
 	return map_size;
 }
-- 
2.7.4

