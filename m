Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3157C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD252084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbfCANku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:40:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:54082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728395AbfCANkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:40:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DF3AAFF5;
        Fri,  1 Mar 2019 13:40:48 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] efi: Downgrade "EFI_MEMMAP is not enabled" message
Date:   Fri,  1 Mar 2019 14:40:33 +0100
Message-Id: <20190301134033.2100-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes
when mapping the FB"), efifb_probe() checks its memory range via
efi_mem_desc_lookup(), and this leads to a spurious error message
"EFI_MEMMAP is not enabled" at every boot on KVM.  This is quite
annoying since the error message appears even if you set "quiet" boot
option.

Actually there are only a few places that call efi_mem_desc_lookup()
function, and the other callers do give the explicit error messages
when the function returns an error in anyway.  That is, the error
message in the function is more or less moot.

So let's downgrade the error message for stop annoying users.

Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1127339
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 55b77c576c42..50ac33097458 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -409,7 +409,7 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 	efi_memory_desc_t *md;
 
 	if (!efi_enabled(EFI_MEMMAP)) {
-		pr_err_once("EFI_MEMMAP is not enabled.\n");
+		pr_debug("EFI_MEMMAP is not enabled.\n");
 		return -EINVAL;
 	}
 
-- 
2.16.4

