Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF324C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8500D20854
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbfB1L23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:28:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfB1L23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:28:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1SBS4Qi3019793
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 03:28:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1SBS32a3019789;
        Thu, 28 Feb 2019 03:28:03 -0800
Date:   Thu, 28 Feb 2019 03:28:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-6f913de3231e1d70a871135b38219da7810df218@git.kernel.org>
Cc:     pitamm@gmail.com, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        bockjoo@phys.ufl.edu, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: pitamm@gmail.com, hpa@zytor.com, kirill.shutemov@linux.intel.com,
          bockjoo@phys.ufl.edu, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190219075224.35058-1-kirill.shutemov@linux.intel.com>
References: <20190219075224.35058-1-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot/compressed/64: Do not read legacy ROM on
 EFI system
Git-Commit-ID: 6f913de3231e1d70a871135b38219da7810df218
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6f913de3231e1d70a871135b38219da7810df218
Gitweb:     https://git.kernel.org/tip/6f913de3231e1d70a871135b38219da7810df218
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Tue, 19 Feb 2019 10:52:24 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 28 Feb 2019 12:25:05 +0100

x86/boot/compressed/64: Do not read legacy ROM on EFI system

EFI systems do not necessarily provide a legacy ROM. If the ROM is missing
the memory is not mapped at all.

Trying to dereference values in the legacy ROM area leads to a crash on
Macbook Pro.

Only look for values in the legacy ROM area for non-EFI system.

Fixes: 3548e131ec6a ("x86/boot/compressed/64: Find a place for 32-bit trampoline")
Reported-by: Pitam Mitra <pitamm@gmail.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Bockjoo Kim <bockjoo@phys.ufl.edu>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190219075224.35058-1-kirill.shutemov@linux.intel.com
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202351

---
 arch/x86/boot/compressed/pgtable_64.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 9e2157371491..f8debf7aeb4c 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,5 +1,7 @@
+#include <linux/efi.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
+#include <asm/efi.h>
 #include "pgtable.h"
 #include "../string.h"
 
@@ -37,9 +39,10 @@ int cmdline_find_option_bool(const char *option);
 
 static unsigned long find_trampoline_placement(void)
 {
-	unsigned long bios_start, ebda_start;
+	unsigned long bios_start = 0, ebda_start = 0;
 	unsigned long trampoline_start;
 	struct boot_e820_entry *entry;
+	char *signature;
 	int i;
 
 	/*
@@ -47,8 +50,18 @@ static unsigned long find_trampoline_placement(void)
 	 * This code is based on reserve_bios_regions().
 	 */
 
-	ebda_start = *(unsigned short *)0x40e << 4;
-	bios_start = *(unsigned short *)0x413 << 10;
+	/*
+	 * EFI systems may not provide legacy ROM. The memory may not be mapped
+	 * at all.
+	 *
+	 * Only look for values in the legacy ROM for non-EFI system.
+	 */
+	signature = (char *)&boot_params->efi_info.efi_loader_signature;
+	if (strncmp(signature, EFI32_LOADER_SIGNATURE, 4) &&
+	    strncmp(signature, EFI64_LOADER_SIGNATURE, 4)) {
+		ebda_start = *(unsigned short *)0x40e << 4;
+		bios_start = *(unsigned short *)0x413 << 10;
+	}
 
 	if (bios_start < BIOS_START_MIN || bios_start > BIOS_START_MAX)
 		bios_start = BIOS_START_MAX;
