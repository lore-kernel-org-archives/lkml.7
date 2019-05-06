Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AEEC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6904621850
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXFaIgn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfEFRLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:11:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40946 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfEFRLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:11:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so6677862plr.7;
        Mon, 06 May 2019 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5ewii1e+MTEfWZGeRVIBVrPsob2PwcVcWoJvnrmTVY=;
        b=lXFaIgn3chhf6fnv9h9lXWIU270xIuGmq2Pjn5R9Ni7loOTyGsssv1aJmvC23/jTMK
         jSNLFt/FLfoHI25OgULxaB+Goz5Jzm01JCdl9zLZdc8WOF3frTfmDHyFF6u4J7OR0CF6
         pXf6cd+TgMRhFYySOA6SqtyBWEi3djbUrxE6OlrWAGXw5/gsTdoHc7HqYylsRkkKPYbb
         MfLAzDlXQ/JXNz/ieBsSTtVMMPvtiRHTEjEY7uMqFAbnYEydJoAP9Td9qJihPCcyGBbk
         lN+zdRK6nCges4gjWWQQZI4nVRg6/JKuDHV9Ca6OJ0LZ0WhKZQ2D+fWY8s18X+FZUy6D
         hI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5ewii1e+MTEfWZGeRVIBVrPsob2PwcVcWoJvnrmTVY=;
        b=M223KodYaiIjDuHKZz5X88p9eK7kNxJAPCqIT6+/lwjVndzvSdRPDnQ7ixWTYWn4qU
         EbxYe01i6nhOjjLJeg5StfAlzhTccYr9kawkdBmPbvR40ry9HZIVryYjMLGrPNz8Gf7x
         OxbnlVtvx0zmpXrZIXALHuLzrBkk+UhXzSqvNHRQ0pmXWrvmUKKu6fXb+QOVoJhTR4x9
         kCO1Pu+wYgoD/3/xSRAbmCebOxog3K/oCur0Yjnz2QmrnaE2Xe0NM6AR7e4aoZiUWyhS
         jqTTBy0h2riTcX/0YRHjFw1iureeBxtq6cw2AO2mHuafSFGarM2cZU5SqMJgm47+oWKZ
         6bYQ==
X-Gm-Message-State: APjAAAXB1RexdfQVN4N2F2aiRm/Po2wD4Mhp0yGzfMUE5pUrMP7iiS6w
        T3qbfA6UQ7urQrXf9Jwyv4g=
X-Google-Smtp-Source: APXvYqy4P7YSHyQ9EUlYaNI/2qZlNL8Qi6HnLkJXnK4mcJ0XWBDmAwyP7QDO5wB0L2p9kzGQ6g7kyQ==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr3484259plk.207.1557162706049;
        Mon, 06 May 2019 10:11:46 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.11.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:11:45 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 22/27] Documentation: x86: convert x86_64/uefi.txt to reST
Date:   Tue,  7 May 2019 01:09:18 +0800
Message-Id: <20190506170923.7117-23-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506170923.7117-1-changbin.du@gmail.com>
References: <20190506170923.7117-1-changbin.du@gmail.com>
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

