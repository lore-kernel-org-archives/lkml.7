Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BB8C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046C420651
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eAwTx8oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfHNUzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:55:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46946 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHNUzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:55:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so174625pgt.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=pwlvkrg2tJ0Bro/GpRuA46erbIfp3xuzVQb1TgQ90jg=;
        b=eAwTx8ooH0jipghYvKyEFk5GMB64L0WzCZrF48NqNbnpF54V+WuuBJRjVMBELngO/6
         OvTT1H1pcfdbXnQcF+ieAMeQquT0g+ltYsN117sRmygfviCMP60y70h+V0WaYe1djZs+
         j+nXP204e4qBJDTTgR6/N0Ns0qs6+GjP/m0SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pwlvkrg2tJ0Bro/GpRuA46erbIfp3xuzVQb1TgQ90jg=;
        b=ol3H20M9QfSYVJpYb5tM7gclzJZoiVZl+/0IpKkhRrZ+DG9964S7/0oPE2dSjl1dvC
         fq5PcbI+uNtsV5DVGCpnvsrFVAb7gnWSnJFLij3ZsbOLAtgz57LB6PTW5ZnImg0ive0N
         6I3+cs/9I8mfmAblI7vNhGkzSrhvkP2grZuCTNF6XPINh+6wQ9mzcAOPbIJaJD3ge8Jz
         DnTkzJ40dn30j28jxRh103rxAlfdCcr/KEhkHynZEuL1FCs8+scLUHzEuUGvudP93li+
         qzVWDhgmxBneZyLIKGIqC39w8Y0HDA8tYaY+jCJVCegzxCxEtvPMe2/CYMbJzIVLE67q
         UDNg==
X-Gm-Message-State: APjAAAU87ti/n9pb3LA9QrVxmgIg3bUdxSWfLaMrncGpJz60pY/JU5LL
        yEYCg6QQnl5UTKNV+qLlEb0Ffg==
X-Google-Smtp-Source: APXvYqwXwlomESOpg3jhtRVFxa+UXC9e0pyZnP+bf5Qmew+EduUR6NiVJ7TSfy2DGQScbKXr7iJNCw==
X-Received: by 2002:a63:ee08:: with SMTP id e8mr931440pgi.70.1565816152853;
        Wed, 14 Aug 2019 13:55:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o129sm752307pfg.1.2019.08.14.13.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 13:55:52 -0700 (PDT)
Date:   Wed, 14 Aug 2019 13:55:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] efi/libstub/arm64: Report meaningful relocation errors
Message-ID: <201908141353.043EF60B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When UEFI booting, if allocate_pages() fails (either via KASLR or
regular boot), efi_low_alloc() is used for fall back. If it, too, fails,
it reports "Failed to relocate kernel". Then handle_kernel_image()
reports the failure to its caller, which unhelpfully reports exactly
the same string again:

EFI stub: ERROR: Failed to relocate kernel
EFI stub: ERROR: Failed to relocate kernel

While debugging linker errors in the UEFI code that created insane memory
sizes that all the allocation attempts would fail at, this was a cause
for confusion. Knowing each allocation had failed would have helped me
isolate the issue sooner. To that end, this improves the error messages
to detail which specific allocations have failed.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 1550d244e996..24022f956e01 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -111,6 +111,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 		status = efi_random_alloc(sys_table_arg, *reserve_size,
 					  MIN_KIMG_ALIGN, reserve_addr,
 					  (u32)phys_seed);
+		if (status != EFI_SUCCESS)
+			pr_efi_err(sys_table_arg, "KASLR allocate_pages() failed\n");
 
 		*image_addr = *reserve_addr + offset;
 	} else {
@@ -135,6 +137,8 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 					EFI_LOADER_DATA,
 					*reserve_size / EFI_PAGE_SIZE,
 					(efi_physical_addr_t *)reserve_addr);
+		if (status != EFI_SUCCESS)
+			pr_efi_err(sys_table_arg, "regular allocate_pages() failed\n");
 	}
 
 	if (status != EFI_SUCCESS) {
@@ -143,7 +147,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 				       MIN_KIMG_ALIGN, reserve_addr);
 
 		if (status != EFI_SUCCESS) {
-			pr_efi_err(sys_table_arg, "Failed to relocate kernel\n");
+			pr_efi_err(sys_table_arg, "efi_low_alloc() failed\n");
 			*reserve_size = 0;
 			return status;
 		}
-- 
2.17.1


-- 
Kees Cook
