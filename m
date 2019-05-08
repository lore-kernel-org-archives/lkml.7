Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89E3C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A90E216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+JPaIb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfEHPYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:24:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32953 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfEHPYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:24:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so4292984pgv.0;
        Wed, 08 May 2019 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5ewii1e+MTEfWZGeRVIBVrPsob2PwcVcWoJvnrmTVY=;
        b=X+JPaIb25Dkien3Jj24PhWZ918Q3vjlie5c33WY24q6uV0zIx8hZXXuVJvKHncBj2C
         5+pR/Fj0d6F7kKrV3Tcd9LBOGZuCHdonXeeEk4Ius1gkTSBMdvcyviM/i86DMmFEa/p4
         NXeJFFD8FtqK44dBcCo17K82u/hOLoMcys5scW/YOw4YcXcegVBakDGig0LXmBwr6w1D
         ekndz+Lz7V/7ZMfzVnndf4wfQztCVkzb3t3LO+LDm1lTS+UaObK1z7KgE8e4yL8y2I7P
         C1NIkruHOGQiaFvu96GXUGm1Dh2DpASehcZdYCn55HcVGXzDxr7sL37GZb39MUL067xw
         JmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5ewii1e+MTEfWZGeRVIBVrPsob2PwcVcWoJvnrmTVY=;
        b=Dxw7nT9Ez9ghh5VstQsM40wgn2//GRL6MXPEIMtXcA1JvXhL3PmRpdVKRgnWbCRkaT
         ow+OzjM5ODgAOTLhHzAAmqgIJxAmZDcobYn/9NksrCS7sR6lRnGmPAKeJOyg62oym4PQ
         7KghiXtlDj+gpKQ8ogEuvCuzBiFnGT1FCqRFcGyIxm7U0JbaMxMtEyiHLpfwlLWFfo1A
         cX3uRX6vzU3tvna4zwjGv+4MlKWzkMjpL4tC8MSbphVg0+eKkL3bmanXJ27LrjaYofRi
         D8AdhjZIBd+paVaNKK9shwThIG0SXqlSN56FE62TkztpudYD5o9JKg6rnRxKhP3kLVEb
         o4LA==
X-Gm-Message-State: APjAAAVEru7M8B1csFMn4cacoe0ekhr6EJgD6KEYxrKQX8wNlPLkzVts
        R8CtiLcCAnmaOcmqerLx2mbVZopf
X-Google-Smtp-Source: APXvYqx1h0r/SofRhvifs0WW3xGwOTpNSK8Dy6WHzS8xKL1gErrpxZ9BihWXsCpUZKR4T9Al2IRgYA==
X-Received: by 2002:a63:2d87:: with SMTP id t129mr47615433pgt.451.1557329061308;
        Wed, 08 May 2019 08:24:21 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.24.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:24:20 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 22/27] Documentation: x86: convert x86_64/uefi.txt to reST
Date:   Wed,  8 May 2019 23:21:36 +0800
Message-Id: <20190508152141.8740-23-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508152141.8740-1-changbin.du@gmail.com>
References: <20190508152141.8740-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/x86/x86_64/index.rst            |  1 +
 .../x86/x86_64/{uefi.txt => uefi.rst}         | 30 ++++++++++++++-----
 2 files changed, 24 insertions(+), 7 deletions(-)
 rename Documentation/x86/x86_64/{uefi.txt => uefi.rst} (79%)

diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index a8cf7713cac9..ddfa1f9d4193 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -8,3 +8,4 @@ x86_64 Support
    :maxdepth: 2
 
    boot-options
+   uefi
diff --git a/Documentation/x86/x86_64/uefi.txt b/Documentation/x86/x86_64/uefi.rst
similarity index 79%
rename from Documentation/x86/x86_64/uefi.txt
rename to Documentation/x86/x86_64/uefi.rst
index a5e2b4fdb170..88c3ba32546f 100644
--- a/Documentation/x86/x86_64/uefi.txt
+++ b/Documentation/x86/x86_64/uefi.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
 General note on [U]EFI x86_64 support
--------------------------------------
+=====================================
 
 The nomenclature EFI and UEFI are used interchangeably in this document.
 
@@ -14,29 +17,42 @@ with EFI firmware and specifications are listed below.
 
 3. x86_64 platform with EFI/UEFI firmware.
 
-Mechanics:
+Mechanics
 ---------
-- Build the kernel with the following configuration.
+
+- Build the kernel with the following configuration::
+
 	CONFIG_FB_EFI=y
 	CONFIG_FRAMEBUFFER_CONSOLE=y
+
   If EFI runtime services are expected, the following configuration should
-  be selected.
+  be selected::
+
 	CONFIG_EFI=y
 	CONFIG_EFI_VARS=y or m		# optional
+
 - Create a VFAT partition on the disk
 - Copy the following to the VFAT partition:
+
 	elilo bootloader with x86_64 support, elilo configuration file,
 	kernel image built in first step and corresponding
 	initrd. Instructions on building elilo	and its dependencies
 	can be found in the elilo sourceforge project.
+
 - Boot to EFI shell and invoke elilo choosing the kernel image built
   in first step.
 - If some or all EFI runtime services don't work, you can try following
   kernel command line parameters to turn off some or all EFI runtime
   services.
-	noefi		turn off all EFI runtime services
-	reboot_type=k	turn off EFI reboot runtime service
+
+	noefi
+		turn off all EFI runtime services
+	reboot_type=k
+		turn off EFI reboot runtime service
+
 - If the EFI memory map has additional entries not in the E820 map,
   you can include those entries in the kernels memory map of available
   physical RAM by using the following kernel command line parameter.
-	add_efi_memmap	include EFI memory map of available physical RAM
+
+	add_efi_memmap
+		include EFI memory map of available physical RAM
-- 
2.20.1

