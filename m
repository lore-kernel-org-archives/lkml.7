Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1102FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7331F21D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CSeBGviP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbfKHJAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:00:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36659 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbfKHJAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:00:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id k13so3585040pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 01:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4mA/9w+p4ZyPfP618OGaLYeasHgkEFTburLhkdeh8Lw=;
        b=CSeBGviPRt2/P3HOhMFEdRZs+ILwW5TPxv/TB+YeJDUPzK2T3ptP3mKQO5BjNoUIvE
         ag5ENFE/uMiUHfofqja/O4qkx1fgWpSbjKf7E9qJ6jKNvrstn30J7dQ0JwWJh6vMRd/2
         pC22Lqp60LieCWtmhZIsFDpR+qEFDRR+nzuxvB7XUI3q9oVhtRg6MImhtUHYmT+NELIM
         6ZidCcZ+Q68re198a/5oL6XCXgfHsCAxu/Z5KPqRFJJXvAutuG4fQ7ZYBTSRoyry19NU
         teIGjhsIzppsebkiow26ahkc5wwA6ZGjrFAje4GyImyHoUdMPJCyCcWfV0lRARAdkJUi
         lsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4mA/9w+p4ZyPfP618OGaLYeasHgkEFTburLhkdeh8Lw=;
        b=eSrIKPYu0RfP6Mpq3rHNWvz/0enRC2AotfP5ABc3NlAX5zTrDkIXhYaNRfKLvbEL7y
         P+U4Qs8TY+ErtEK1LML5DcMiFD2nlaW/TFUpGNre9qOTJWiPVgW/LtOJv8Ddhr2Sabd/
         9Mcwz4ClVyr3YcskwbS8bzHbcPCc0DdTA3lcYQME8NYrAAJ45MI1iTTFChdZ1FCg/kgu
         7urbb6Hyt6DY41TvPgv0tnWMum45L8G9Z0yDFiJmdHmyFjel43rG9Vp1KCLJHVpv289E
         KMwflCwJxx1vaOMYJ/tQQ513GK0T/1aPqK7YdQMFls0tGp/p02eZ45WdZazYiYiSwYdr
         15Cw==
X-Gm-Message-State: APjAAAXd9GMYBkW9kCDVYUNJ18xhV7fosU2MZKV8qKbZg+H7ND/u9NBQ
        KN+hJXInvs3SxSVocWuZB4kFI/6Nbzg=
X-Google-Smtp-Source: APXvYqx4IphqT43H1gJB2tzKQeJV2eonVGQE6tl6qIW3cvRDXBGlE55PSNn/1/Xn54s0jPojQmXuWg==
X-Received: by 2002:aa7:8d04:: with SMTP id j4mr2048566pfe.49.1573203645268;
        Fri, 08 Nov 2019 01:00:45 -0800 (PST)
Received: from gamma07.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id m65sm8636707pje.3.2019.11.08.01.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Nov 2019 01:00:44 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, anup@brainfault.org,
        hch@infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3] riscv: Use PMD_SIZE to repalce PTE_PARENT_SIZE
Date:   Fri,  8 Nov 2019 01:00:40 -0800
Message-Id: <1573203640-6173-1-git-send-email-zong.li@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMD_SIZE is equal to PGDIR_SIZE when __PAGETABLE_PMD_FOLDED is
defined.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>

---
 arch/riscv/mm/init.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 573463d..e83df7a 100644
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
 
@@ -314,14 +312,11 @@ static void __init create_pgd_mapping(pgd_t *pgdp,
 
 static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 {
-	uintptr_t map_size = PAGE_SIZE;
+	/* Upgrade to PMD_SIZE mappings whenever possible */
+	if ((base & (PMD_SIZE - 1)) || (size & (PMD_SIZE - 1)))
+		return PAGE_SIZE;
 
-	/* Upgrade to PMD/PGDIR mappings whenever possible */
-	if (!(base & (PTE_PARENT_SIZE - 1)) &&
-	    !(size & (PTE_PARENT_SIZE - 1)))
-		map_size = PTE_PARENT_SIZE;
-
-	return map_size;
+	return PMD_SIZE;
 }
 
 /*
-- 
2.7.4

