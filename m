Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4CBC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 08:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EF72082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 08:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuITCgG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfEEIdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 04:33:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40587 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfEEIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 04:33:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so5111179pfn.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 01:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kW9cFc3oY5uX+D8x24aFAh/eOz8mR3Xa9rRR63JZ7FE=;
        b=KuITCgG6/MhcfWssqPO3bh4jADeh50kro0pY96IQauUkNWsThVozk9ys5p+dcOYwyk
         xwkzNvUt/n1oYXOYf5pizL8KYVMREQoY+bGgOeUNNEAqigQ7Dx06y/PeHwLKw+5NT8VC
         l5TWteBtOGzDt2FhoaOGoOoV5oXtDb4Mqu8NIW5kvl1SuMBQ4UwmNTq17kVZxMgQEtCb
         17Mi8Uq/EgLF3bRG7ZRjUfyyGOHjXe9UKRi3N9YCYyfNG0+88V85skr71ZGuw95SPl3G
         NpfqgdSXps2WinCzVPZ7AHysSmMZok4/SErNO+49d+jCKzPobSxXF+Oy2FavG7nAbUNF
         o0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kW9cFc3oY5uX+D8x24aFAh/eOz8mR3Xa9rRR63JZ7FE=;
        b=QF4n1t/gdRfDkluI7hlECP7REEbvEh0Ux0cFrcCxiYAaZCN7a6xNsty4ORlPVYojqY
         YfWZ/894xzdh/AvRIWrFf6ce6ZEnKDcY4QvTn3rD+/CHyyjRPMGSiN3q/r4R1Imfceiq
         0VX0VEE+H1evilewBDbQhqQPa38XMwfVEn4Dmz/iJ69TD+/iwwzxw9pXWSwlylJtvccA
         kbqHM9PW1fKTTsxPlhSYfjrrlzljHR1JqFISKPFNAoHv7D+BNPm8drmQAIdHoi2qZksB
         oCctXG05RvmltLK+KPgAijFCzOEiPH5Pynm9EFIi0VKAEVFoxWUw0jqRMxKXO7Jwmsnw
         evZQ==
X-Gm-Message-State: APjAAAUIsb58dUT+e/3x/RuYA9as81eaGFikaPwNhv7TfUbO7I9jqVxq
        DkbM1hIavtU1HwnfqOd8mKU=
X-Google-Smtp-Source: APXvYqzQWdVsmMjhZY/tvLi3osuocNfeof5yskb0ufl3rA4pCMJgpak0r9V5hbbW1cvYD589up1mBQ==
X-Received: by 2002:a63:360e:: with SMTP id d14mr23610439pga.188.1557045234544;
        Sun, 05 May 2019 01:33:54 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a18sm9013664pff.6.2019.05.05.01.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 01:33:53 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH] x86/mm: Initialize pgd cache during mm initialization
Date:   Sat,  4 May 2019 18:11:24 -0700
Message-Id: <20190505011124.39692-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Poking-mm initialization might require to duplicate the PGD in early
stage. Initialize the PGD cache earlier to prevent boot failures.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 4fc19708b165 ("x86/alternatives: Initialize temporary mm for patching")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/pgtable.h |  1 +
 arch/x86/mm/pgtable.c          | 10 ++++++----
 init/main.c                    |  1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 6b6bfdfe83aa..9635662e1163 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1027,6 +1027,7 @@ static inline int pgd_none(pgd_t pgd)
 
 extern int direct_gbpages;
 void init_mem_mapping(void);
+void pgd_cache_init(void);
 void early_alloc_pgt_buf(void);
 extern void memblock_find_dma_reserve(void);
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3dbf440d4114..1f67b1e15bf6 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -373,14 +373,14 @@ static void pgd_prepopulate_user_pmd(struct mm_struct *mm,
 
 static struct kmem_cache *pgd_cache;
 
-static int __init pgd_cache_init(void)
+void __init pgd_cache_init(void)
 {
 	/*
 	 * When PAE kernel is running as a Xen domain, it does not use
 	 * shared kernel pmd. And this requires a whole page for pgd.
 	 */
 	if (!SHARED_KERNEL_PMD)
-		return 0;
+		return;
 
 	/*
 	 * when PAE kernel is not running as a Xen domain, it uses
@@ -390,9 +390,7 @@ static int __init pgd_cache_init(void)
 	 */
 	pgd_cache = kmem_cache_create("pgd_cache", PGD_SIZE, PGD_ALIGN,
 				      SLAB_PANIC, NULL);
-	return 0;
 }
-core_initcall(pgd_cache_init);
 
 static inline pgd_t *_pgd_alloc(void)
 {
@@ -420,6 +418,10 @@ static inline void _pgd_free(pgd_t *pgd)
 }
 #else
 
+void __init pgd_cache_init(void)
+{
+}
+
 static inline pgd_t *_pgd_alloc(void)
 {
 	return (pgd_t *)__get_free_pages(PGALLOC_GFP, PGD_ALLOCATION_ORDER);
diff --git a/init/main.c b/init/main.c
index 949eed8015ec..7fac4ac2fede 100644
--- a/init/main.c
+++ b/init/main.c
@@ -537,6 +537,7 @@ static void __init mm_init(void)
 	init_espfix_bsp();
 	/* Should be run after espfix64 is set up. */
 	pti_init();
+	pgd_cache_init();
 }
 
 void __init __weak arch_call_rest_init(void)
-- 
2.17.1

