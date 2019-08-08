Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16141C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD3E2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HHpzoMia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390190AbfHHRjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:39:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33911 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfHHRjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:39:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so38204848pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PivmghTlXg+yY8gg+X2M9V5T2UndrrUwzo+s775Y6U8=;
        b=HHpzoMiaF5QhupFhProjPvOBj9oGQnHALREOCxFfhLfSn+pfoPk9RX+KzsevNoKNls
         6xyK8/xouf8+f+jy8WNgV5bNkGQ6T2Ew2CmKtP8Bu0RADOs72TZarnXgyRsbY+VBI0Vg
         0Snt2FqpxPHvF/Rngt8F418W/xqxPh61YbvG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PivmghTlXg+yY8gg+X2M9V5T2UndrrUwzo+s775Y6U8=;
        b=MWy1hNNwEFefueeqDwncXHKI7RViZ/5cfGVmq0AtFI7IKci3k6aTsXa5XAIljp8iD3
         0RYENfm8FHQ2MLqD2FtKllskv7f14YUNR4rYDFYx5nS1SVm4ngHRO23XoTtUEJfTlzL3
         GT/wAli1hpM4JPtnzA+0L7FUmy82P5H6puD92oFBxXPc7C3TOYlP8F/5A0Xh3eAwHm+c
         sx5mCJxKeGF9nOkD7jcRwZkxoaMaHdyMTy77q+mRszfFgXunor+xvTOvAooyYqX6Huag
         E9zMx/I+JyD/b8Pr6hkWd8VPn11dXboILSRW2RCgiEBYp7DHpcgl2qlcNcYIuwvvi00F
         5h8w==
X-Gm-Message-State: APjAAAWLWpCLNr7+on/lGgNDmPW1Cg1NphpcjcA6P4S8oFWqZvqN07hj
        W29NmqaX68NWSwEP8rkzPFMczw==
X-Google-Smtp-Source: APXvYqzDwoJ1bfGRRVX4ijyV+Kjvr5aUWXV9BpWjc8owrLnexJYXDJnKMtB1tnb9rgb6Dvm8QMrETQ==
X-Received: by 2002:a62:1444:: with SMTP id 65mr16498905pfu.145.1565285951080;
        Thu, 08 Aug 2019 10:39:11 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id y12sm105824412pfn.187.2019.08.08.10.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 10:39:10 -0700 (PDT)
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
Subject: [PATCH RESEND v7 1/3] arm64: map FDT as RW for early_init_dt_scan()
Date:   Fri,  9 Aug 2019 01:38:03 +0800
Message-Id: <20190808173803.1146-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808173803.1146-1-hsinyi@chromium.org>
References: <20190808173803.1146-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in arm64, FDT is mapped to RO before it's passed to
early_init_dt_scan(). However, there might be some codes
(eg. commit "fdt: add support for rng-seed") that need to modify FDT
during init. Map FDT to RO after early fixups are done.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/mmu.h |  2 +-
 arch/arm64/kernel/kaslr.c    |  5 +----
 arch/arm64/kernel/setup.c    |  9 ++++++++-
 arch/arm64/mm/mmu.c          | 15 +--------------
 4 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index fd6161336653..f217e3292919 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -126,7 +126,7 @@ extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot, bool page_mappings_only);
-extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
+extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
 
 #define INIT_MM_CONTEXT(name)	\
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 708051655ad9..d94a3e41cef9 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -62,9 +62,6 @@ static __init const u8 *kaslr_get_cmdline(void *fdt)
 	return default_cmdline;
 }
 
-extern void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size,
-				       pgprot_t prot);
-
 /*
  * This routine will be executed with the kernel mapped at its default virtual
  * address, and if it returns successfully, the kernel will be remapped, and
@@ -93,7 +90,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	 * attempt at mapping the FDT in setup_machine()
 	 */
 	early_fixmap_init();
-	fdt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
+	fdt = fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
 	if (!fdt)
 		return 0;
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 9c4bad7d7131..25f5127210f8 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -170,9 +170,13 @@ static void __init smp_build_mpidr_hash(void)
 
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
-	void *dt_virt = fixmap_remap_fdt(dt_phys);
+	int size;
+	void *dt_virt = fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
 	const char *name;
 
+	if (dt_virt)
+		memblock_reserve(dt_phys, size);
+
 	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
 		pr_crit("\n"
 			"Error: invalid device tree blob at physical address %pa (virtual address 0x%p)\n"
@@ -184,6 +188,9 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 			cpu_relax();
 	}
 
+	/* Early fixups are done, map the FDT as read-only now */
+	fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
+
 	name = of_flat_dt_get_machine_name();
 	if (!name)
 		return;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 63d730c5b7a9..bed9db92be24 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -876,7 +876,7 @@ void __set_fixmap(enum fixed_addresses idx,
 	}
 }
 
-void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
+void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 {
 	const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
 	int offset;
@@ -929,19 +929,6 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	return dt_virt;
 }
 
-void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
-{
-	void *dt_virt;
-	int size;
-
-	dt_virt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
-	if (!dt_virt)
-		return NULL;
-
-	memblock_reserve(dt_phys, size);
-	return dt_virt;
-}
-
 int __init arch_ioremap_p4d_supported(void)
 {
 	return 0;
-- 
2.20.1

