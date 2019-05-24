Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F744C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B903A217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XL2jDF0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfEXESw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 00:18:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:41249 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfEXESv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 00:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558671531; x=1590207531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kpAUTdu+s3Bqv6wA/9SKsl84MGlY7n2l9hP/DaqKAWE=;
  b=XL2jDF0sg3JK/6Y4NnIMIPc7R9+bAMeQKjdiECLbM6Ffc7uGDtiq6gey
   2qATvPbf0e0OvnMtgrVLutWt7xFC/Y8LSBKQO61Pz/RGyK6/hbaxs3+bt
   ZXd2Pl8q5PHD0qPwxURu133Hxva2HbH9iAUpjoZGaMTbG2o6qnluWpeYk
   ubSPf1EhQgoV3u5t7hjiwxCVXm2+rc0iWmOGSg46drcIpVHdU955uuGVV
   sh3gKVssXVE1UZ+RyaeTkaIJz2Lwpq6yVXs4XrHctE+phriiCElaP84SI
   jbrXShTyNUQ3g7GRGvvZbTHK49msJFVuwuRcnWcOgHztza3KuC4Qz8OHo
   w==;
X-IronPort-AV: E=Sophos;i="5.60,505,1549900800"; 
   d="scan'208";a="110246320"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2019 12:18:49 +0800
IronPort-SDR: wTmW9FAMmVl5aK3cmQXtO3vKzumVnjiH+aOXS14yMLr6IvzU2ATDl2fHYFtIPNQPFY00uBc4yu
 qk+hQdbBnyo4Gpnzhl/4nwY6s9z7hCQq2G0teEWfgMr3TDgH3VkIqSfXrTkSvvD1ifeK1bTeIH
 i1O/Oy9QsGo/iqAyMnZlhOVi/7QwxI676ZjdB4VdUOty8uKvX5MdPV79ChNsE89dfCNHxHWSXw
 42dOoVgstBDtnpe+fLrI+Nu5+NculAzRTlvaQlsyiVUpiyN/P9TkoM7X1UFGumYbQNgyno3Yuu
 zSSyOcjp1QftTtTZyw9UtpGR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 23 May 2019 20:56:30 -0700
IronPort-SDR: 5shGaPH1nVHyaJqsvy2c080RP96se6h3f4gy7NlCzqk7lf5ILFLe5hC8lI54N9w8qEeZvN694p
 +BYEQyQs91V3Gxpykzq9dCMEW4r3kbJB8ABZZR4n13ydC/M1BvHcgclxzHppZlffS3SBoykiec
 eatAvf4PUmRDAblSxEQh6MQm3db3C3ORCZHSh3Bg2ttxX63Wl+cO4FFspmclJFPmarQ+N7MZef
 BApccEiYzu/Idw1gfomMv8kaga3Z8gXBBWKKXXx54MJXzyoXBCRSiFEWsKLz9h28BnzdYDks5x
 9us=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 May 2019 21:18:49 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Karsten Merker <merker@debian.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org
Subject: [v4 PATCH] RISC-V: Add an Image header that boot loader can parse.
Date:   Thu, 23 May 2019 21:18:14 -0700
Message-Id: <20190524041814.7497-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the last stage boot loaders such as U-Boot can accept only
uImage which is an unnecessary additional step in automating boot
process.

Add an image header that boot loader understands and boot Linux from
flat Image directly.

This header is based on ARM64 boot image header and provides an
opportunity to combine both ARM64 & RISC-V image headers in future.

Also make sure that PE/COFF header can co-exist in the same image so
that EFI stub can be supported for RISC-V in future. EFI specification
needs PE/COFF image header in the beginning of the kernel image in order
to load it as an EFI application. In order to support EFI stub, code0
should be replaced with "MZ" magic string and res4(at offset 0x3c)
should point to the rest of the PE/COFF header (which will be added
during EFI support).

Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Karsten Merker <merker@debian.org>
Tested-by: Karsten Merker <merker@debian.org> (QEMU+OpenSBI+U-Boot)

---
I have not sent out corresponding U-Boot patch as all the changes are
compatible with current u-boot support. Once, the kernel header format
is agreed upon, I will update the U-Boot patch.

Changes from v3->v4
1. Update the commit text to clarify about PE/COFF header.

Changes from v2->v3
1. Modified reserved fields to define a header version.
2. Added header documentation.

Changes from v1-v2:
1. Added additional reserved elements to make it fully PE compatible.
---
 Documentation/riscv/boot-image-header.txt | 50 ++++++++++++++++++
 arch/riscv/include/asm/image.h            | 64 +++++++++++++++++++++++
 arch/riscv/kernel/head.S                  | 32 ++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 Documentation/riscv/boot-image-header.txt
 create mode 100644 arch/riscv/include/asm/image.h

diff --git a/Documentation/riscv/boot-image-header.txt b/Documentation/riscv/boot-image-header.txt
new file mode 100644
index 000000000000..68abc2353cec
--- /dev/null
+++ b/Documentation/riscv/boot-image-header.txt
@@ -0,0 +1,50 @@
+				Boot image header in RISC-V Linux
+			=============================================
+
+Author: Atish Patra <atish.patra@wdc.com>
+Date  : 20 May 2019
+
+This document only describes the boot image header details for RISC-V Linux.
+The complete booting guide will be available at Documentation/riscv/booting.txt.
+
+The following 64-byte header is present in decompressed Linux kernel image.
+
+	u32 code0;		  /* Executable code */
+	u32 code1; 		  /* Executable code */
+	u64 text_offset;	  /* Image load offset, little endian */
+	u64 image_size;		  /* Effective Image size, little endian */
+	u64 flags;		  /* kernel flags, little endian */
+	u32 version;		  /* Version of this header */
+	u32 res1  = 0;		  /* Reserved */
+	u64 res2  = 0;    	  /* Reserved */
+	u64 magic = 0x5643534952; /* Magic number, little endian, "RISCV" */
+	u32 res3;		  /* Reserved for additional RISC-V specific header */
+	u32 res4;		  /* Reserved for PE COFF offset */
+
+This header format is compliant with PE/COFF header and largely inspired from
+ARM64 header. Thus, both ARM64 & RISC-V header can be combined into one common
+header in future.
+
+Notes:
+- This header can also be reused to support EFI stub for RISC-V in future. EFI
+  specification needs PE/COFF image header in the beginning of the kernel image
+  in order to load it as an EFI application. In order to support EFI stub,
+  code0 should be replaced with "MZ" magic string and res5(at offset 0x3c) should
+  point to the rest of the PE/COFF header.
+
+- version field indicate header version number.
+  	Bits 0:15  - Minor version
+	Bits 16:31 - Major version
+
+  This preserves compatibility across newer and older version of the header.
+  The current version is defined as 0.1.
+
+- res3 is reserved for offset to any other additional fields. This makes the
+  header extendible in future. One example would be to accommodate ISA
+  extension for RISC-V in future. For current version, it is set to be zero.
+
+- In current header, the flag field has only one field.
+	Bit 0: Kernel endianness. 1 if BE, 0 if LE.
+
+- Image size is mandatory for boot loader to load kernel image. Booting will
+  fail otherwise.
diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
new file mode 100644
index 000000000000..61c9f20d2f19
--- /dev/null
+++ b/arch/riscv/include/asm/image.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+
+#define RISCV_IMAGE_MAGIC	"RISCV"
+
+
+#define RISCV_IMAGE_FLAG_BE_SHIFT	0
+#define RISCV_IMAGE_FLAG_BE_MASK	0x1
+
+#define RISCV_IMAGE_FLAG_LE		0
+#define RISCV_IMAGE_FLAG_BE		1
+
+
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define __HEAD_FLAG_BE		RISCV_IMAGE_FLAG_BE
+#else
+#define __HEAD_FLAG_BE		RISCV_IMAGE_FLAG_LE
+#endif
+
+#define __HEAD_FLAG(field)	(__HEAD_FLAG_##field << \
+				RISCV_IMAGE_FLAG_##field##_SHIFT)
+
+#define __HEAD_FLAGS		(__HEAD_FLAG(BE))
+
+#define RISCV_HEADER_VERSION_MAJOR 0
+#define RISCV_HEADER_VERSION_MINOR 1
+
+#define RISCV_HEADER_VERSION (RISCV_HEADER_VERSION_MAJOR << 16 | \
+			      RISCV_HEADER_VERSION_MINOR)
+
+#ifndef __ASSEMBLY__
+/*
+ * struct riscv_image_header - riscv kernel image header
+ *
+ * @code0:		Executable code
+ * @code1:		Executable code
+ * @text_offset:	Image load offset
+ * @image_size:		Effective Image size
+ * @flags:		kernel flags
+ * @version:		version
+ * @reserved:		reserved
+ * @reserved:		reserved
+ * @magic:		Magic number
+ * @reserved:		reserved (will be used for additional RISC-V specific header)
+ * @reserved:		reserved (will be used for PE COFF offset)
+ */
+
+struct riscv_image_header {
+	u32 code0;
+	u32 code1;
+	u64 text_offset;
+	u64 image_size;
+	u64 flags;
+	u32 version;
+	u32 res1;
+	u64 res2;
+	u64 magic;
+	u32 res3;
+	u32 res4;
+};
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_IMAGE_H */
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 370c66ce187a..577893bb150d 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -19,9 +19,41 @@
 #include <asm/thread_info.h>
 #include <asm/page.h>
 #include <asm/csr.h>
+#include <asm/image.h>
 
 __INIT
 ENTRY(_start)
+	/*
+	 * Image header expected by Linux boot-loaders. The image header data
+	 * structure is described in asm/image.h.
+	 * Do not modify it without modifying the structure and all bootloaders
+	 * that expects this header format!!
+	 */
+	/* jump to start kernel */
+	j _start_kernel
+	/* reserved */
+	.word 0
+	.balign 8
+#if __riscv_xlen == 64
+	/* Image load offset(2MB) from start of RAM */
+	.dword 0x200000
+#else
+	/* Image load offset(4MB) from start of RAM */
+	.dword 0x400000
+#endif
+	/* Effective size of kernel image */
+	.dword _end - _start
+	.dword __HEAD_FLAGS
+	.word RISCV_HEADER_VERSION
+	.word 0
+	.dword 0
+	.asciz RISCV_IMAGE_MAGIC
+	.word 0
+	.balign 4
+	.word 0
+
+.global _start_kernel
+_start_kernel:
 	/* Mask all interrupts */
 	csrw CSR_SIE, zero
 	csrw CSR_SIP, zero
-- 
2.21.0

