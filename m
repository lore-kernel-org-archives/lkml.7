Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40281C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130A4205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F1SPpDoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfESRJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:09:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33025 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfESRJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:09:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so6065477pfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjgKgNWvkrWu2AB4Hfm3UsbNqpkTfiMRDxIt6YpDrD8=;
        b=F1SPpDoL5/a/tOtnEuMPcZHUmxrlYpCW55VLRABVi8Ktcj+pFOspwPpb/QdIdtJBsz
         41Nz2EnmkcnqlqMJ4FH9DYTW9qOWF3B9mwhUR4kc12EXddRoh1xcNY+hvWUgG0kVZaSO
         nmtAnQFNNwpNY2cb4wM/TTE7HA6icohq7g9rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjgKgNWvkrWu2AB4Hfm3UsbNqpkTfiMRDxIt6YpDrD8=;
        b=b0E10A+yaAAja9t6iDX5/7rI4ZgJTW9zb7YvojtEjXH5nZVl+P3jF21UOAP6z3VXE7
         WK7DYLEIfOUrjIWUZLoW5ljAX0eF3JYWKEYAcr7vOpuxM8gpARoXGYS8olxfsBW5vYiH
         IImr3w/z7qHT7uR9d2sKd62yb/O98pVYlN5x3clIsKAllYZj77EZm/B8kBZXfi3EznAq
         n46bPH2xPF1YiS03M54I2h+1v/D6XUEvUx/YWFG9wcDOBrrIbfWLR7lnbOjktarLQrow
         rt2oUzo3ZvGArRI6DRnh52tNlCKPfYIgereu+DU58lmARZKcLSKJFuhkbMVQYpU9OQyt
         BYbA==
X-Gm-Message-State: APjAAAVP01C6Rr8nM37DRusHrF1HssUNzE5c2kDd7jBuwDAyPw+T5CSG
        M2MWVvQfU6VGRVjOcMjHECQ8ew==
X-Google-Smtp-Source: APXvYqzq2wiw9TB3Jsn9Sm+quwS8aysurwuin7NtHbnbO84Ogl+zCj5bZND02CjmQyW98Mvom1I2XQ==
X-Received: by 2002:a62:e10f:: with SMTP id q15mr74698143pfh.56.1558281904958;
        Sun, 19 May 2019 09:05:04 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id b23sm17547007pfi.6.2019.05.19.09.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 09:05:04 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v4 1/3] amr64: map FDT as RW for early_init_dt_scan()
Date:   Mon, 20 May 2019 00:04:44 +0800
Message-Id: <20190519160446.320-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in arm64, FDT is mapped to RO before it's passed to
early_init_dt_scan(). However, there might be some code that needs
to modify FDT during init. Map FDT to RW until unflatten DT.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
change log v2->v4:
* v3 abandoned
* add an arg pgprot_t to fixmap_remap_fdt()
---
 arch/arm64/include/asm/mmu.h | 2 +-
 arch/arm64/kernel/setup.c    | 5 ++++-
 arch/arm64/mm/mmu.c          | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 67ef25d037ea..4499cb00ece7 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -137,7 +137,7 @@ extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot, bool page_mappings_only);
-extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
+extern void *fixmap_remap_fdt(phys_addr_t dt_phys, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
 
 #define INIT_MM_CONTEXT(name)	\
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 413d566405d1..064df3de1d14 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -181,7 +181,7 @@ static void __init smp_build_mpidr_hash(void)
 
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
-	void *dt_virt = fixmap_remap_fdt(dt_phys);
+	void *dt_virt = fixmap_remap_fdt(dt_phys, PAGE_KERNEL);
 	const char *name;
 
 	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
@@ -320,6 +320,9 @@ void __init setup_arch(char **cmdline_p)
 	/* Parse the ACPI tables for possible boot-time configuration */
 	acpi_boot_table_init();
 
+	/* remap fdt to RO */
+	fixmap_remap_fdt(__fdt_pointer, PAGE_KERNEL_RO);
+
 	if (acpi_disabled)
 		unflatten_device_tree();
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a170c6369a68..29648e86f7e5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -940,12 +940,12 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	return dt_virt;
 }
 
-void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
+void *__init fixmap_remap_fdt(phys_addr_t dt_phys, pgprot_t prot)
 {
 	void *dt_virt;
 	int size;
 
-	dt_virt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
+	dt_virt = __fixmap_remap_fdt(dt_phys, &size, prot);
 	if (!dt_virt)
 		return NULL;
 
-- 
2.20.1

