Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC48FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB3521835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578051627;
	bh=2ZDafcrOFKSF2ybRq49KajpWushIOtD+aMmrNSMAiQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wEjsJBom7aPJH0qRHhHzO31Vr/ShLLuFKRYf5S5Wo+T2kBTIzuT7Z0DX3ZXxcIzQg
	 8sWfCReH5l+RJGz71mG6Ayq7UznjLLIjTNBL3ND8enF2WNkuX4tmua+qA9s0jPXuu9
	 1nO20ITvS/Du0qgCiAuzoB/4QrLmMY//Z3fiusxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgACLk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbgACLkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:24 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E3E524649;
        Fri,  3 Jan 2020 11:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051624;
        bh=2ZDafcrOFKSF2ybRq49KajpWushIOtD+aMmrNSMAiQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z3XU3CX/9PcO9vjlhAP54CO0W7KCHeRLDWxVe7EmYZDGNEZYy0VzFjoF4p/HgVqZ0
         EceYb2XWR0TSCUpTK++cE4gQny6i+NcoNcGpW/CzYeDxZjbi08BTKv4U+nIuLvZ3Pw
         EnI7TEFmrSWeEw3vnneMEdOmph9URiSeDtNq/Zg0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 04/20] efi/x86: map the entire EFI vendor string before copying it
Date:   Fri,  3 Jan 2020 12:39:37 +0100
Message-Id: <20200103113953.9571-5-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a couple of issues with the way we map and copy the vendor string:
- we map only 2 bytes, which usually works since you get at least a
  page, but if the vendor string happens to cross a page boundary,
  a crash will result
- only call early_memunmap() if early_memremap() succeeded, or we will
  call it with a NULL address which it doesn't like,
- while at it, switch to early_memremap_ro(), and array indexing rather
  than pointer dereferencing to read the CHAR16 characters.

Fixes: 5b83683f32b1 ("x86: EFI runtime service support")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index d96953d9d4e7..3ce32c31bb61 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -541,7 +541,6 @@ void __init efi_init(void)
 	efi_char16_t *c16;
 	char vendor[100] = "unknown";
 	int i = 0;
-	void *tmp;
 
 #ifdef CONFIG_X86_32
 	if (boot_params.efi_info.efi_systab_hi ||
@@ -566,14 +565,16 @@ void __init efi_init(void)
 	/*
 	 * Show what we know for posterity
 	 */
-	c16 = tmp = early_memremap(efi.systab->fw_vendor, 2);
+	c16 = early_memremap_ro(efi.systab->fw_vendor,
+				sizeof(vendor) * sizeof(efi_char16_t));
 	if (c16) {
-		for (i = 0; i < sizeof(vendor) - 1 && *c16; ++i)
-			vendor[i] = *c16++;
+		for (i = 0; i < sizeof(vendor) - 1 && c16[i]; ++i)
+			vendor[i] = c16[i];
 		vendor[i] = '\0';
-	} else
+		early_memunmap(c16, sizeof(vendor) * sizeof(efi_char16_t));
+	} else {
 		pr_err("Could not map the firmware vendor!\n");
-	early_memunmap(tmp, 2);
+	}
 
 	pr_info("EFI v%u.%.02u by %s\n",
 		efi.systab->hdr.revision >> 16,
-- 
2.20.1

