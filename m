Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A104DC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC5A22C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564174922;
	bh=oM8gDSSZWuHow7Ix0i/JcBcUs6SZlbgsBk+Fkmaml+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HXXGfYInFqV1uxsFxIazaIYQbv3roH382X2P57ccZZulzDZa/bEb5Svhxe2w4YTdP
	 eZ9r12VbzjTCZiutFY188FJLPgrGC59n+4SlRkw1CbLU5453+5dzwKklDKPsP4lT6a
	 LzLcI1Rfj+0uC7Q6uIx8inDUvRVIi0BRYf3itGFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfGZVCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:02:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfGZVCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9RGZnoVUUhhYLZmtBoqppl1lanCMuAL11YxezwOxYZU=; b=jSYVtRLgD0dieSbh31vFsgqw3t
        2kxXaUgV09NCYDwEpfUDxmxbM1iWJss/l966f5X0It5cWRXkmanEtr1WzpulWPsai8h31AkQeAYMI
        IFgne6vCuMJsE0usFQ2rJM+wfJdHAiHPJmVF4EKaKAFjprC161qd7g7Tip3g9hVRe1Igi2ICNfiZB
        qH0e5sCMDJfnYqMUff9CEc88UyKXhaz0/CpZulNaScphzewog42CRj7iXVMPbbnSIKxYAqk7y9m2P
        XjPLGCDbUZtxAEN52OGjQuNswv5P9hVesxvNktkeNd2LCXzej+3SemxWCkv842LyNkT0ONKRm0l8X
        kTuTXZlQ==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr7Lj-0006ID-PJ; Fri, 26 Jul 2019 21:01:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hr7Lh-0005HC-06; Fri, 26 Jul 2019 18:01:57 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Karsten Merker <merker@debian.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] docs: riscv: convert boot-image-header.txt to ReST
Date:   Fri, 26 Jul 2019 18:01:55 -0300
Message-Id: <1eaeb3fbb74de55af0b3f6d93ab40776dcbbb5c8.1564174903.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <57eaa99a-d644-7b79-7177-a45d3ef1e71a@wdc.com>
References: <57eaa99a-d644-7b79-7177-a45d3ef1e71a@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert this small file to ReST format by:
   - Using a proper markup for the document title;
   - marking a code block as such;
   - use tags for Author and date;
   - use tables for bit map fields.

While here, fix a broken reference for a document with is
planned but is not here yet.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 ...image-header.txt => boot-image-header.rst} | 39 ++++++++++++-------
 Documentation/riscv/index.rst                 |  1 +
 2 files changed, 26 insertions(+), 14 deletions(-)
 rename Documentation/riscv/{boot-image-header.txt => boot-image-header.rst} (72%)

diff --git a/Documentation/riscv/boot-image-header.txt b/Documentation/riscv/boot-image-header.rst
similarity index 72%
rename from Documentation/riscv/boot-image-header.txt
rename to Documentation/riscv/boot-image-header.rst
index 1b73fea23b39..43e9bd0731d5 100644
--- a/Documentation/riscv/boot-image-header.txt
+++ b/Documentation/riscv/boot-image-header.rst
@@ -1,22 +1,25 @@
-				Boot image header in RISC-V Linux
-			=============================================
+=================================
+Boot image header in RISC-V Linux
+=================================
 
-Author: Atish Patra <atish.patra@wdc.com>
-Date  : 20 May 2019
+:Author: Atish Patra <atish.patra@wdc.com>
+:Date:   20 May 2019
 
 This document only describes the boot image header details for RISC-V Linux.
-The complete booting guide will be available at Documentation/riscv/booting.txt.
 
-The following 64-byte header is present in decompressed Linux kernel image.
+TODO:
+  Write a complete booting guide.
+
+The following 64-byte header is present in decompressed Linux kernel image::
 
 	u32 code0;		  /* Executable code */
-	u32 code1; 		  /* Executable code */
+	u32 code1;		  /* Executable code */
 	u64 text_offset;	  /* Image load offset, little endian */
 	u64 image_size;		  /* Effective Image size, little endian */
 	u64 flags;		  /* kernel flags, little endian */
 	u32 version;		  /* Version of this header */
-	u32 res1  = 0;		  /* Reserved */
-	u64 res2  = 0;    	  /* Reserved */
+	u32 res1 = 0;		  /* Reserved */
+	u64 res2 = 0;		  /* Reserved */
 	u64 magic = 0x5643534952; /* Magic number, little endian, "RISCV" */
 	u32 res3;		  /* Reserved for additional RISC-V specific header */
 	u32 res4;		  /* Reserved for PE COFF offset */
@@ -25,16 +28,21 @@ This header format is compliant with PE/COFF header and largely inspired from
 ARM64 header. Thus, both ARM64 & RISC-V header can be combined into one common
 header in future.
 
-Notes:
+Notes
+=====
+
 - This header can also be reused to support EFI stub for RISC-V in future. EFI
   specification needs PE/COFF image header in the beginning of the kernel image
   in order to load it as an EFI application. In order to support EFI stub,
   code0 should be replaced with "MZ" magic string and res5(at offset 0x3c) should
   point to the rest of the PE/COFF header.
 
-- version field indicate header version number.
-	Bits 0:15  - Minor version
-	Bits 16:31 - Major version
+- version field indicate header version number
+
+	==========  =============
+	Bits 0:15   Minor version
+	Bits 16:31  Major version
+	==========  =============
 
   This preserves compatibility across newer and older version of the header.
   The current version is defined as 0.1.
@@ -44,7 +52,10 @@ Notes:
   extension for RISC-V in future. For current version, it is set to be zero.
 
 - In current header, the flag field has only one field.
-	Bit 0: Kernel endianness. 1 if BE, 0 if LE.
+
+	=====  ====================================
+	Bit 0  Kernel endianness. 1 if BE, 0 if LE.
+	=====  ====================================
 
 - Image size is mandatory for boot loader to load kernel image. Booting will
   fail otherwise.
diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
index e3ca0922a8c2..215fd3c1f2d5 100644
--- a/Documentation/riscv/index.rst
+++ b/Documentation/riscv/index.rst
@@ -5,6 +5,7 @@ RISC-V architecture
 .. toctree::
     :maxdepth: 1
 
+    boot-image-header
     pmu
 
 .. only::  subproject and html
-- 
2.21.0

