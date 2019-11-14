Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1F6C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87654206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="As+KnhAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKNRWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:22:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58806 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfKNRWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:22:09 -0500
Received: from zn.tnic (p200300EC2F15E200329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:e200:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D83961EC0CFE;
        Thu, 14 Nov 2019 18:22:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573752128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=PbGZIko68f80PGyBe+EPLI/nCbCe2I6Wk5PKlvFX2Eg=;
        b=As+KnhAm1LMxrNd+Wp+gSlW35ZMZVF2gp+dUFzThNkXe/ke8bx8a7jQvJNx6hnd/he61iz
        wUv0TlGRn0a3uTZrOX7s1o58HRt5UGKetNDa+4TKu936livR7h2aAuPzHfh/NJA2Vuk6bc
        0eFGQ/raLhQuBCLKuC4ZsxyPlZ28N4I=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [PATCH] x86/crash: Align function arguments on opening braces
Date:   Thu, 14 Nov 2019 18:22:00 +0100
Message-Id: <20191114172200.19563-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... or let function calls stick out and thus remain on a single line,
even if the 80 cols rule is violated by a couple of chars, for better
readability.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
---
 arch/x86/kernel/crash.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index a16ec92b70f5..00fc55ac7ffa 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -202,8 +202,7 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 	unsigned int nr_ranges = 0;
 	struct crash_mem *cmem;
 
-	walk_system_ram_res(0, -1, &nr_ranges,
-				get_nr_ram_ranges_callback);
+	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
 	if (!nr_ranges)
 		return NULL;
 
@@ -240,10 +239,9 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
 	if (ret)
 		return ret;
 
-	if (crashk_low_res.end) {
+	if (crashk_low_res.end)
 		ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
-							crashk_low_res.end);
-	}
+					      crashk_low_res.end);
 
 	return ret;
 }
@@ -270,8 +268,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (!cmem)
 		return -ENOMEM;
 
-	ret = walk_system_ram_res(0, -1, cmem,
-				prepare_elf64_ram_headers_callback);
+	ret = walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
 	if (ret)
 		goto out;
 
@@ -281,8 +278,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem,
-				IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
@@ -297,8 +293,7 @@ static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 	if (nr_e820_entries >= E820_MAX_ENTRIES_ZEROPAGE)
 		return 1;
 
-	memcpy(&params->e820_table[nr_e820_entries], entry,
-			sizeof(struct e820_entry));
+	memcpy(&params->e820_table[nr_e820_entries], entry, sizeof(struct e820_entry));
 	params->e820_entries++;
 	return 0;
 }
@@ -353,24 +348,24 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	cmd.type = E820_TYPE_RAM;
 	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 	walk_iomem_res_desc(IORES_DESC_NONE, flags, 0, (1<<20)-1, &cmd,
-			memmap_entry_callback);
+			    memmap_entry_callback);
 
 	/* Add ACPI tables */
 	cmd.type = E820_TYPE_ACPI;
 	flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 	walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1, &cmd,
-		       memmap_entry_callback);
+			    memmap_entry_callback);
 
 	/* Add ACPI Non-volatile Storage */
 	cmd.type = E820_TYPE_NVS;
 	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
-			memmap_entry_callback);
+			    memmap_entry_callback);
 
 	/* Add e820 reserved ranges */
 	cmd.type = E820_TYPE_RESERVED;
 	flags = IORESOURCE_MEM;
 	walk_iomem_res_desc(IORES_DESC_RESERVED, flags, 0, -1, &cmd,
-			   memmap_entry_callback);
+			    memmap_entry_callback);
 
 	/* Add crashk_low_res region */
 	if (crashk_low_res.end) {
@@ -381,8 +376,7 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	}
 
 	/* Exclude some ranges from crashk_res and add rest to memmap */
-	ret = memmap_exclude_ranges(image, cmem, crashk_res.start,
-						crashk_res.end);
+	ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
 	if (ret)
 		goto out;
 
-- 
2.21.0

