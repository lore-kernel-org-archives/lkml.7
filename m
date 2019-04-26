Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0DFC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B3E2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmTxzb9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfDZPea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:34:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40436 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDZPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:34:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id s4so1902676pfh.7;
        Fri, 26 Apr 2019 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EltilnvvP1BvvyVI1MTgDNOjtPuzRRDurGYU5XZhXEs=;
        b=VmTxzb9G8xWP/elTNrrhgNHbowJ5YBP4fcPS1hoea+YJ71+DrQEXFSKVBEJSpPh6b4
         7ZtA+Rymu2xiB092b9kaWmT+bTS/UdQn4hfaf9VSWkOH5d5YBmw8Qo587//n/JUCweaq
         dMQowEQc/mPXXghk2+Rq5Xss23ne/z1dZM+quvHPqKFHbht1N0AVZkIMax9GQDBXe0sw
         4yR5xUTZS5OSUTX0FdJiyfqz1U4QRjbzoSkYSRroYSSyIg0tEubtI0Bv1BHS32IC1Jg2
         MVdXGRUByLVMLXPiNWIWpI97fJr2HRRcgXic5WTc3ZiFAh0+KMg3i6cL9GMLlX4dcmj8
         FtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EltilnvvP1BvvyVI1MTgDNOjtPuzRRDurGYU5XZhXEs=;
        b=f08jwmkhnDBAddpjx+bSCcfK6aUxbp69EL33FZXAQAS50wUVVZ44qPdq5EzjICqpFf
         BLmw52xnp83dLs0hgOac9cXei4+SfOTuNRadRpWfNpeidiky7WCZYRIjxOnNfqBEerzn
         AZuJXci7bnsRKum4V2nGalfj9+BdmueLJNiF4Ps/Vxuvq0Zls723t71L8tyIoHkZGEd0
         VDnfcoE9dhvotK7tOV3862KXG723PJ+BP0nsEh06PVCdV0t7Q60mTmnynBul268Yb3OF
         03gkZcnrIu0H0EkzngFXzGDUi91tHiqwqJFNKBqbYOP07ql/XIAEKCyG+Iy7/OdWpbVi
         +PMw==
X-Gm-Message-State: APjAAAU7t3q/QKk9f1S7sAuikk6dPsSv2zir0XluBm9yNrtWqwbjAU2s
        J4Prx8V5ryruMotwwcTMMrU=
X-Google-Smtp-Source: APXvYqxJHd4kGLCipwQ3mhyQA1QZVhAOZmzc7WkeL0EImdhr28PNtmUxWZUOJTNzwYE0F/kdDSc7zQ==
X-Received: by 2002:a63:fb58:: with SMTP id w24mr8518858pgj.444.1556292865988;
        Fri, 26 Apr 2019 08:34:25 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:34:25 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 22/27] Documentation: x86: convert x86_64/uefi.txt to reST
Date:   Fri, 26 Apr 2019 23:31:45 +0800
Message-Id: <20190426153150.21228-23-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426153150.21228-1-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
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

