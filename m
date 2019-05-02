Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E760C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E9C20873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuspEN7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfEBHLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:11:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40534 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfEBHLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:11:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so643547pgl.7;
        Thu, 02 May 2019 00:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5ewii1e+MTEfWZGeRVIBVrPsob2PwcVcWoJvnrmTVY=;
        b=WuspEN7/uK2jP84acxB/Ef808mAHUJ4WGQpKUiao33FnWzc1pD+LkJtRr6jh4Ie/Dh
         Vt7G62bmJMU1QgPb6Y1M5rUhVG7OXR0Glv1sFQDRhEZFpL0nTbDkHBBvRGcSI65i4lvu
         sKE00WYhd22/Z4nKTLMMika+PGalte0FW4mjTGs3PQvOnr5Jf+S1q/+DZcGADnP65bZZ
         7S7CZMQNcwicONPDeeVsfjLyTgegR3kffdNsa3GVnk0AITAOji1qmJaCFsvfljVuTwFL
         f15WVjwNgLqXnhLw5UQ6hVh9y5AT+7OLS+zWgohek0IMQPeCxeupd7GRKPXJEcsVA/kJ
         SXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5ewii1e+MTEfWZGeRVIBVrPsob2PwcVcWoJvnrmTVY=;
        b=emk7tDEr7MxMwBYrgymB2Id+e5sm/kkxcO3FBnwuOAMS/021eZTU+pKR3zwnyHPrX9
         W/gaIKHuKQZ50fUCHI83ZiAGMwWxig15KKEK1E7wA3mvoTlGTvd9lbstVo+nPcVEjDlH
         s+vgyNp/NH3DyoTy/FGHzsSqag8pyy773Mp/MbaNzu9OclB2cWkJGwS/ThmuA2bkIVOB
         k1alzXLuCuXO2fLa6+S7oiUKal1urvZkwuCk8i3VVCip2mBtuFkl0cj/nHw88/lOhQL0
         vCFzEbqPkDdFrfb/iz+MB1k1EJfg9truG3+ytMSJ1VOObcyo45BSwYajXShsCSl+tBIS
         mQig==
X-Gm-Message-State: APjAAAUZUG1JN5/ma9hKxQ0LxLXEnbCnFwEh0jpEudJTGYktetYLzqg6
        sS6Q+2yQuE74sGwdbxHMSy4=
X-Google-Smtp-Source: APXvYqwmjXjxSEaRe9RG+96kApF4FxIBDWbITMZ2aIHPK019dzSJkdYU4yT97j41XbzzYAXQbCn2Hg==
X-Received: by 2002:a63:2ace:: with SMTP id q197mr2335192pgq.371.1556781100875;
        Thu, 02 May 2019 00:11:40 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:11:39 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 22/27] Documentation: x86: convert x86_64/uefi.txt to reST
Date:   Thu,  2 May 2019 15:06:28 +0800
Message-Id: <20190502070633.9809-23-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502070633.9809-1-changbin.du@gmail.com>
References: <20190502070633.9809-1-changbin.du@gmail.com>
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

