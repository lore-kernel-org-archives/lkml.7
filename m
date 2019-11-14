Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03B0C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8003D2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfKNRaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:30:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfKNRaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:30:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVIwQ-0007W6-LM; Thu, 14 Nov 2019 18:29:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2F08D1C0090;
        Thu, 14 Nov 2019 18:29:58 +0100 (CET)
Date:   Thu, 14 Nov 2019 17:29:57 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kdump] x86/crash: Align function arguments on opening braces
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191114172200.19563-1-bp@alien8.de>
References: <20191114172200.19563-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <157375259774.29376.17108399184829392884.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kdump branch of tip:

Commit-ID:     9eff303725da6530b615e9258f696149baa51df6
Gitweb:        https://git.kernel.org/tip/9eff303725da6530b615e9258f696149baa51df6
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 14 Nov 2019 16:11:50 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Nov 2019 18:24:55 +01:00

x86/crash: Align function arguments on opening braces

... or let function calls stick out and thus remain on a single line,
even if the 80 cols rule is violated by a couple of chars, for better
readability.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20191114172200.19563-1-bp@alien8.de
---
 arch/x86/kernel/crash.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index a16ec92..00fc55a 100644
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
 
