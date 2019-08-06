Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CBEC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B5F2173C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbfHFQal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:30:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730265AbfHFQal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:30:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B366A3098575;
        Tue,  6 Aug 2019 16:30:37 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-117-61.ams2.redhat.com [10.36.117.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2D3960C83;
        Tue,  6 Aug 2019 16:30:36 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ed Kellett <e@kellett.im>
Subject: [RFC PATCH] gcc-9: workaround array bounds warning on boot_params cleaning
Date:   Tue,  6 Aug 2019 19:30:34 +0300
Message-Id: <20190806163034.6105-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 06 Aug 2019 16:30:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code is supposed to clear several fields in the structure with
memset() and it produces the warning:

In file included from arch/x86/kernel/head64.c:17:
In function ‘memset’,
    inlined from ‘sanitize_boot_params’ at ./arch/x86/include/asm/bootparam_utils.h:40:3,
    inlined from ‘copy_bootdata’ at arch/x86/kernel/head64.c:391:2:
./include/linux/string.h:344:9: warning: ‘__builtin_memset’ offset [197, 448] from the object at ‘boot_params’ is out of the bounds of referenced subobject ‘ext_ramdisk_image’ with type ‘unsigned int’ at offset 192 [-Warray-bounds]
  344 |  return __builtin_memset(p, c, size);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

since gcc is aware of the field sizes of the structure.

Blind gcc treating the structure as a byte array and calculate
positions with offsetof().

Suggested-by: Ed Kellett <e@kellett.im>
Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 arch/x86/include/asm/bootparam_utils.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index 101eb944f13c..16e567a08b54 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -37,12 +37,14 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 	if (boot_params->sentinel) {
 		/* fields in boot_params are left uninitialized, clear them */
 		boot_params->acpi_rsdp_addr = 0;
-		memset(&boot_params->ext_ramdisk_image, 0,
-		       (char *)&boot_params->efi_info -
-			(char *)&boot_params->ext_ramdisk_image);
-		memset(&boot_params->kbd_status, 0,
-		       (char *)&boot_params->hdr -
-		       (char *)&boot_params->kbd_status);
+		memset((u8 *)boot_params + offsetof(struct boot_params, ext_ramdisk_image),
+		       0,
+		       offsetof(struct boot_params,  efi_info) -
+			offsetof(struct boot_params, ext_ramdisk_image));
+		memset((u8 *)boot_params + offsetof(struct boot_params, _pad7[0]),
+		       0,
+		       offsetof(struct boot_params, edd_mbr_sig_buffer[0]) -
+			offsetof(struct boot_params, _pad7[0]));
 		memset(&boot_params->_pad7[0], 0,
 		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
 			(char *)&boot_params->_pad7[0]);
-- 
2.22.0

