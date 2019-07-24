Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFA7C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4258121855
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkHhn/+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388646AbfGXXPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:15:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46542 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfGXXPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:15:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so22557071plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRCsuOGDft9dhV5jK1PPDHOTZ8bJiWsCL4k+CBc4n4w=;
        b=OkHhn/+PLkTKgs4lithBDVvzUNR9asCItEvbeIglX5BzPtApvmClAjdRumC+U/gTw/
         0+8AQ3yt4O+XSdMpJvqxfdciEOQvoGCmit1EWmxy2gC25J5wRy3WasCI6eGQazQlvpaC
         HzLw3YLjQLDRCssFqOovCVOFf0cwFASA8uElCjuRgcCOwiQS1E43P3vsDWtL1eNiZ+nG
         Oh2TviGoFkQ5acM1CIMxM9Hx0y1z64/EAQzHzO7tUIgeubCw80HPm7oljPWUeynop7fP
         KmvkF/DqrjWBDml9AeemKsVZRo+UQN5eXu8Ky+F087bhPnUQzUZKfMP6qk+EiLXGmNjw
         cCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRCsuOGDft9dhV5jK1PPDHOTZ8bJiWsCL4k+CBc4n4w=;
        b=XKJIlHklSFAwtwkpDRdTZSS/eLBi99UfdTvs0wYS1BoYrx+Zieti0rhUEzWuH5xxsD
         og5q+uf+hJfZFilw0veu4qmXqIA2pwSTA1lIK8kXcZmLoiZj4FE+ebQ83q9hxgXkxwpf
         lUQnXYtj5hxTSgL6J+jrqD3fB/w0M55ae3fHgFNVXrJUyP35tkmnw92zdrYWMwmT756i
         f+yuuVHd5Baxt6j0atNGvVxwvIismLw1hJrmT4b2icGp61wu/8s4LhkmT2D7XcGuBp/R
         WSdZ6BC5VnZGOX+Ox46XcHyRDulxqUAKwSmC+UHsOaXMVmvR5BurwRr5MTbHf+4pOlL9
         MRyA==
X-Gm-Message-State: APjAAAWhVjEB/ne6KBTJF74d0mvS5mf8kaxprfyjW9wEaY1CSec1EYfc
        jGfJdIqnXmtxFL4C2n/Z6B4=
X-Google-Smtp-Source: APXvYqwdAIVmH4w4eW+ya7a04oZ+c83fmafLm51BoaeSAq/aAsv3KuNLsss2z0uK2WgQmhsaJArLPA==
X-Received: by 2002:a17:902:b688:: with SMTP id c8mr86887309pls.243.1564010132755;
        Wed, 24 Jul 2019 16:15:32 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id x67sm50275523pfb.21.2019.07.24.16.15.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:15:32 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     "H . Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/1] x86/boot: clear some fields explicitly
Date:   Wed, 24 Jul 2019 16:15:28 -0700
Message-Id: <20190724231528.32381-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724231528.32381-1-jhubbard@nvidia.com>
References: <20190724231528.32381-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Recent gcc compilers (gcc 9.1) generate warnings about an
out of bounds memset, if you trying memset across several fields
of a struct. This generated a couple of warnings on x86_64 builds.

Because struct boot_params is __packed__, normal variable
variable assignment will work just as well as a memset here.
Change three u32 fields to be cleared to zero that way, and
just memset the _pad4 field.

This clears up the build warnings for me.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 arch/x86/include/asm/bootparam_utils.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index 101eb944f13c..4df87d4a043b 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -37,12 +37,11 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 	if (boot_params->sentinel) {
 		/* fields in boot_params are left uninitialized, clear them */
 		boot_params->acpi_rsdp_addr = 0;
-		memset(&boot_params->ext_ramdisk_image, 0,
-		       (char *)&boot_params->efi_info -
-			(char *)&boot_params->ext_ramdisk_image);
-		memset(&boot_params->kbd_status, 0,
-		       (char *)&boot_params->hdr -
-		       (char *)&boot_params->kbd_status);
+		boot_params->ext_ramdisk_image = 0;
+		boot_params->ext_ramdisk_size = 0;
+		boot_params->ext_cmd_line_ptr = 0;
+
+		memset(&boot_params->_pad4, 0, sizeof(boot_params->_pad4));
 		memset(&boot_params->_pad7[0], 0,
 		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
 			(char *)&boot_params->_pad7[0]);
-- 
2.22.0

