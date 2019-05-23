Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675A5C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3233B2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i5QmnkA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbfEWSf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:35:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19545 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbfEWSf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558636529; x=1590172529;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=moiNqi+OACGZ0OOxMAvL1/AkfKGXkoOtRfH0U9lXBns=;
  b=i5QmnkA8GRRGxyxaS9Ch6DTWo9DXWr+igIoE+SWkEfXQpTm/Zdg5IkqP
   qXFG1t6pUEGBsG52HoZvqf/vp8B6WK5rHnieKCurWoM73pjmlX6DYJja+
   OSqLwVeH4poh1xTZZH9/YHsEAl73zjnRYYTw2VEvqPibEK4laepg0TKHZ
   eRUHGwvJ9vC/ktWt1hWFvT6NYwS/mRf+T3W6di/Mbxq9vU727KPEMPZpr
   41ml3Pn6YOr2SIMUUsEOjK0n6TPlt6pH+jsmXVP80I9WZDgMhqGtcc39j
   XmHJnjIARnu7eT54eOdcSBZmVKZS0uOgr0RJR1ylwg+iV8QgD+8TmFf7/
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,504,1549900800"; 
   d="scan'208";a="113909785"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2019 02:35:28 +0800
IronPort-SDR: O+YzpOye5aoTpSUMkaI6ssTBRczxmIWY2MFWCgxCGU646n/m7ayt/hdoXV31IB75OuSDUoZ0+c
 U9eB3P8LdqXUFSiJTBNg7lYISDlK5lOVxwwQe+mvPsa/1j/+OmoUytfsh0eBX+cNTAhk1gkHKJ
 ZMT8RZtVQulIaNt+cUdyAhhSabcty4C7vbJSZlAqrId0CWAw61VfMRVtzhTxqutr6CQO7voNE5
 Pk/mFNp/aCO3V1q4J9denB9Q55GoNIqWBqS5xh2IO1qvr1Qm9i/2TpEcKfrjL41de3DeO/iidu
 0aageFR2Bl8mOGFDt+xzY8Cv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 23 May 2019 11:13:10 -0700
IronPort-SDR: WKVz19Ljj3GO3eDkce5qb+9PJTwGl3tUU1RRKQ+DtD7EqbxSZR6e+sYQJ/LpoNpi//artRi48Q
 s9UDxHFtE8fTOOXX3WVYitwgv+/pLmKEN8l8/erahBrYNCdQhSxRbtzoaoyLoKLjepoRBHbpM5
 dWEVKAoeTNtctBXsj28FB7paTRmqCspdSwQw9iIUy4OVcC9NCD+rW2kJkFHdHSPxzNjEAm8IiM
 9zCffme0rGEvMQsSeDaM7PB8AOi38XWfNhu10fbgVgxTTKluw0d1Pk5w/gDTCB+m+563pU+xda
 o14=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 May 2019 11:35:28 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        marek.vasut@gmail.com, catalin.marinas@arm.com,
        will.deacon@arm.com, trini@konsulko.com, paul.walmsley@sifive.com
Subject: [v3 PATCH] RISC-V: Add a PE/COFF compliant Image header.
Date:   Thu, 23 May 2019 11:35:16 -0700
Message-Id: <20190523183516.583-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, last stage boot loaders such as U-Boot can accept only
uImage which is an unnecessary additional step in automating boot flows.

Add a PE/COFF compliant image header that boot loaders can parse and
directly load kernel flat Image. The existing booting methods will continue
to work as it is.

Another goal of this header is to support EFI stub for RISC-V in future.
EFI specification needs PE/COFF image header in the beginning of the kernel
image in order to load it as an EFI application. In order to support
EFI stub, code0 should be replaced with "MZ" magic string and res5(at
offset 0x3c) should point to the rest of the PE/COFF header (which will
be added during EFI support).

This patch is based on ARM64 boot image header and provides an opprtunity
to combine both ARM64 & RISC-V image headers.

Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.

Signed-off-by: Atish Patra <atish.patra@wdc.com>

---
I have not sent out corresponding U-Boot patch as all the changes are
compatible with current u-boot support. Once, the kernel header format
is agreed upon, I will update the U-Boot patch.

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

