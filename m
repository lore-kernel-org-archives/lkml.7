Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD74FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9F52133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050007;
	bh=EreNsZxfCtGj1UwHD657sGNgtuFQhti5dnsDHyGoZvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SXGY9io1LCY6CMyKmbIeUW7imhX0mTJwMavN3s5AimaZGivD4FfwQR9AwMJYl/srb
	 XvN5WA7OMYaSiUEG+IsxNAN3qxnE8duzLe8oEW7RcJYk2nJKZPWEttA/UiWOKKjdYA
	 +ua6OEfGMqfTJ8QKq5zqKhcOq5TEEYCqn77rG1hQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfCHNAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfCHNAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:00:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F117820661;
        Fri,  8 Mar 2019 13:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050003;
        bh=EreNsZxfCtGj1UwHD657sGNgtuFQhti5dnsDHyGoZvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5RNhJJjY0wvvkUH0ZjZ8MtTauaASu5qrc96G3A6HJkIBZ8fDVSkuzubSljjBSOtY
         fbSF6ph23OwsXEC6hbTPcmx84pW5pK5uB54TyzZVGQ9SV1LPrUfCKdLsgv7GgMtme+
         /gNhXJn93SJ6/qn4R30ePPKVU41gPB3QnuOnBRkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pitam Mitra <pitamm@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bockjoo Kim <bockjoo@phys.ufl.edu>, bp@alien8.de, hpa@zytor.com
Subject: [PATCH 4.19 54/68] x86/boot/compressed/64: Do not read legacy ROM on EFI system
Date:   Fri,  8 Mar 2019 13:50:24 +0100
Message-Id: <20190308124913.293894540@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

commit 6f913de3231e1d70a871135b38219da7810df218 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/boot/compressed/pgtable_64.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,5 +1,7 @@
+#include <linux/efi.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
+#include <asm/efi.h>
 #include "pgtable.h"
 #include "../string.h"
 
@@ -37,9 +39,10 @@ int cmdline_find_option_bool(const char
 
 static unsigned long find_trampoline_placement(void)
 {
-	unsigned long bios_start, ebda_start;
+	unsigned long bios_start = 0, ebda_start = 0;
 	unsigned long trampoline_start;
 	struct boot_e820_entry *entry;
+	char *signature;
 	int i;
 
 	/*
@@ -47,8 +50,18 @@ static unsigned long find_trampoline_pla
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


