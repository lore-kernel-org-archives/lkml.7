Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495F2C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA5021835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cOHD7RAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgABDMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 22:12:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44620 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABDMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 22:12:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id 195so20547551pfw.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 19:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQKAhTZx2LAPekmwAIUP7L2Rg4T+0IV7GvZHk95ykAk=;
        b=cOHD7RACaeaOX0hsye4o3rGqzUSve7EvWLh3MWGM+1urW3KM8d0Pfe+gfNQYRwNyez
         jil62YaYg/AaVGM+T8nfiQOcad0wrhbFpwfUNzbC9iopylvat7eIyQfH1LGWhAjQYX53
         mRHFcD0xl8wtXxNeqkm+5A7ekaZQQ0akQcdIep10l/xi0Kl4gyYKF/4cRY8dpdcC9DgL
         uWy8QSn0aMLGjQ/qutNxNDxFs+qNWsKLvSTpKQcVNaVN552Id8EfyIQh7XOE6kO3Vv6z
         4RKyxoblfhX2pYvpY5qQk3RV1ZlAs/uoOFFYDic11ZIF0UInCMEev7CfmerflyZclCYR
         q41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQKAhTZx2LAPekmwAIUP7L2Rg4T+0IV7GvZHk95ykAk=;
        b=WElnTCDR+venZ+Jrhsaxipw9YuM21h9BGD7NTwA0aC+Ap1twXWZKUEvIm+3g8/agIe
         zqHhGIqhRFhYSUr7tA496EAOrS7sx81cnXBdi448HxuAHV1QQNp6+lffPn8ohaaCiMwh
         ioPpGhCvKnI0E2Wi8+XJxOzDb4yfvk3wp/4bgx/1/7wXHnuWC+qU+MGIKtq68tFTP38M
         CQsgIOemIUoGN+vPgU888tNLdYaC0EY/AH6NA6nQw7wRaRyLjkMUwS0pSeIM8EUEUA80
         GBffO/dqSmituqjRp8MHOu0a1pE/1hx5YXv2edRfKYv1OjzBLN7bGD0BRgt5tsRKfkpp
         Vuxw==
X-Gm-Message-State: APjAAAUMrO8bnJN3iuKip1SES2a6ZbxSxR5mn6WTaUw3g44u7hA04+Eb
        JhTjsg/zOUOsxmRruG9pQus7nQ==
X-Google-Smtp-Source: APXvYqy1ru5B4HwKEsGa9BAOmRSmjlAdXBl37aF70+DKeEXQRUXEpTA8BjyEUO+luv5dIZ6Cdld4kw==
X-Received: by 2002:a65:680f:: with SMTP id l15mr90126170pgt.307.1577934772029;
        Wed, 01 Jan 2020 19:12:52 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id l127sm57943938pgl.48.2020.01.01.19.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 19:12:51 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/2] riscv: mm: use __pa_symbol for kernel symbols
Date:   Thu,  2 Jan 2020 11:12:40 +0800
Message-Id: <20200102031240.44484-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102031240.44484-1-zong.li@sifive.com>
References: <20200102031240.44484-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__pa_symbol is the marcro that should be used for kernel symbols. It is
also a pre-requisite for DEBUG_VIRTUAL which will do bounds checking.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/mm/init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 69f6678db7f3..965a8cf4829c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -99,13 +99,13 @@ static void __init setup_initrd(void)
 		pr_info("initrd not found or empty");
 		goto disable;
 	}
-	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
+	if (__pa_symbol(initrd_end) > PFN_PHYS(max_low_pfn)) {
 		pr_err("initrd extends beyond end of memory");
 		goto disable;
 	}
 
 	size = initrd_end - initrd_start;
-	memblock_reserve(__pa(initrd_start), size);
+	memblock_reserve(__pa_symbol(initrd_start), size);
 	initrd_below_start_ok = 1;
 
 	pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
@@ -124,8 +124,8 @@ void __init setup_bootmem(void)
 {
 	struct memblock_region *reg;
 	phys_addr_t mem_size = 0;
-	phys_addr_t vmlinux_end = __pa(&_end);
-	phys_addr_t vmlinux_start = __pa(&_start);
+	phys_addr_t vmlinux_end = __pa_symbol(&_end);
+	phys_addr_t vmlinux_start = __pa_symbol(&_start);
 
 	/* Find the memory region containing the kernel */
 	for_each_memblock(memory, reg) {
@@ -445,7 +445,7 @@ static void __init setup_vm_final(void)
 
 	/* Setup swapper PGD for fixmap */
 	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
-			   __pa(fixmap_pgd_next),
+			   __pa_symbol(fixmap_pgd_next),
 			   PGDIR_SIZE, PAGE_TABLE);
 
 	/* Map all memory banks */
@@ -474,7 +474,7 @@ static void __init setup_vm_final(void)
 	clear_fixmap(FIX_PMD);
 
 	/* Move to swapper page table */
-	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | SATP_MODE);
+	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
 	local_flush_tlb_all();
 }
 #else
-- 
2.24.1

