Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFAECA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EE02067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cthiwFBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfKACUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:20:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37426 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKACUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:20:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id z24so900007pgu.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 19:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0++fdwXA964df6WT0EpmnfbVrkeavF5iL05D8ZDEb3Y=;
        b=cthiwFBTpa5nGQwVXdgxJZ6QEZZVp3bOmwgoC1+VyDtLbfMKg9jFI6ldO5fuux5o4M
         Tix+g9SKdKO5uoABiZJIG2nEEWrXVG5j487Hcq6VsL4iU3qHH1qI3U189YpFKEAV2iVg
         BZx5AkGD7B5QHS2h6WTbwY0zD8faN/6hC888YR1yjv5ujy0BXvH1oDKErPvtV6eHqeWv
         qbUrUWRSlFR5++r9lyFD2bXFaB3oX7qCC20opvVM9l3zXIrZNsKQJlthEgwewGtIBq76
         76G2qY6DIxMQvJ4DfgxhHbKVXBX72oN1GiHb0KbypHEbNK7xYuQU0ba4SLnHu87yXshz
         Yzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0++fdwXA964df6WT0EpmnfbVrkeavF5iL05D8ZDEb3Y=;
        b=RRUNMnqwXhR7zLEJOQH6ua76GFMuGHhbCjWgkJpOldX0eySUMjGKnXLZfRuhYyELKt
         JDuKnsrATgA++UU15wn6nkBDQMmROC5hQWTkd+TcyfKa0eFhIJod/0gpkPjUBy7lXj3G
         eoUNQYqE45a0r+Z85kO4aY2LKKQ78SCdC4/eJ2hblEVQU8ZcZ7MK7LIiq8+WoHZygYxF
         WAeFcfVNiZbxzfHQ9ad81yECpS2MDNpH14//jvD8k3iBL47VEQpwBgPeeN7/qwwTVjh7
         50uSjL2Yl2zDho0FmsHAU7+gpKvr7jHdzaBZJm9MT2m2M69wJqZ4T/vkcxbNVT9jh03I
         Y2Kg==
X-Gm-Message-State: APjAAAXPWgDAjNegF/K1EqQKZ3RGbdYLxJ9H34CnhiLRCSitZHXsjiT6
        GqutjMjTApq2TnJtszjgAImKlHvW4vJfTw==
X-Google-Smtp-Source: APXvYqw+t2rWbo+T8aG8q7S3AMYOKcWAgax2Z847XqeEbcW4ejHds4rgIOs5TYC1DFOPCiYZ/UJjIg==
X-Received: by 2002:a62:e70e:: with SMTP id s14mr10821293pfh.182.1572574833889;
        Thu, 31 Oct 2019 19:20:33 -0700 (PDT)
Received: from gamma07.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id l3sm3966392pgo.74.2019.10.31.19.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 19:20:33 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, palmer@sifive.com, Anup.Patel@wdc.com
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH] riscv: Use PMD_SIZE to repalce PTE_PARENT_SIZE
Date:   Thu, 31 Oct 2019 19:20:30 -0700
Message-Id: <1572574830-11181-1-git-send-email-zong.li@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMD_SIZE is equal to PGDIR_SIZE when __PAGETABLE_PMD_FOLDED is
defined.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/mm/init.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 573463d..9a9b01a 100644
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
 
@@ -317,9 +315,9 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 	uintptr_t map_size = PAGE_SIZE;
 
 	/* Upgrade to PMD/PGDIR mappings whenever possible */
-	if (!(base & (PTE_PARENT_SIZE - 1)) &&
-	    !(size & (PTE_PARENT_SIZE - 1)))
-		map_size = PTE_PARENT_SIZE;
+	if (!(base & (PMD_SIZE - 1)) &&
+	    !(size & (PMD_SIZE - 1)))
+		map_size = PMD_SIZE;
 
 	return map_size;
 }
-- 
2.7.4

