Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15971C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D381320651
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WdX5uj0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfEAT4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:56:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62667 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEAT4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556740584; x=1588276584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HiC1BhVQDcUK5m3uXFgIx1Wx/ouIkY0QSuBsbL+0D6U=;
  b=WdX5uj0r5xv7crksoS68bQw0kbOs8j//bOkKEbkR2hQTZdvxBMpELa2S
   lMdUOO3PHEz9l9c/lT26+K93nRcex7X+sqFMqtU4w5xR0jiI4/b7WqeUg
   I1+/vcTm2UX0Tu4bZhhKK1u/HncjkvtOKaGKahRgiLZ1IaolM62AmUB6l
   93+0psj0DlNr7d7fiSi2Aia5YpgGe/Csu8xyVkM8A0323Tta5ZZagfiG8
   2Vkt9WkAImKQLRBDUWOmlIWEhRITBTL4KEhezsKQgFW76Nf0lpaIA+aTw
   uW0u2fBFAPF/00wFfaB4oDB6vYgJgfklGTXucJ+iZbqNbC/5WE2j52OHA
   g==;
X-IronPort-AV: E=Sophos;i="5.60,418,1549900800"; 
   d="scan'208";a="107289431"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2019 03:56:23 +0800
IronPort-SDR: QpppXnE1FEY0wGN/NLuqMb9J1bmKcLwMNXPd5dDjC2bjBrp09FASLMjXeS5oCRNHmO7syIDhWG
 6s9Xho2x107ArVKNsy5jcenTLkGVHz5yRYJpMTzxieAY5gccWVJHKGoM18okPBNP7fhxH7cmD9
 8k8kDWpI+BYcRi1F2SJpf2A4M00DYXcX7PjCQ5bFuQaAvp+T6Z/opKZscVLEJXdddv7v6nDpxd
 QX493hGezikLIuLX8YCOmQxPrEvJ3JrSHBsxSHNiEWlt1hHYxnQEBZVwBc4MeMhGoJ5fHFUwRx
 wmG0EcatmFe/6TFvGif4n2Pv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 01 May 2019 12:32:43 -0700
IronPort-SDR: 64bfk7lvm02jAvWULVkiHb/LDqgE0xh3Jfd2ZwMXj3wwvTcqloWgF4crIPBBElJ+uAqK8WOvXg
 GxUEGfa4SH4uti10/WBT/xLdSi+O3g7k68OGaRp6/gZz16Zw5xg40885TNsmzlC5qXp+ZiV49e
 lMH/GQPI5qAMQ+xEyuHJOS2M9AeVJJlUKySfll9O+eHlzODL7TigzC3JW08F/O0U3fNi+hp1Qu
 CqwSo4nIIJBDkyeFwWkfE09yEdXggZGLPEc+bU8yYi5IIqRBdL45HyLwewfTwdJdk03ERuADwU
 QdY=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 May 2019 12:56:22 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>, mark.rutland@arm.com,
        merker@debian.org
Subject: [v2 PATCH] RISC-V: Add a PE/COFF compliant Image header.
Date:   Wed,  1 May 2019 12:56:07 -0700
Message-Id: <20190501195607.32553-1-atish.patra@wdc.com>
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

Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
Changes from v1-v2:
1. Added additional reserved elements to make it fully PE compatible.
---
 arch/riscv/include/asm/image.h | 37 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/head.S       | 30 +++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 arch/riscv/include/asm/image.h

diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
new file mode 100644
index 000000000000..927333ededee
--- /dev/null
+++ b/arch/riscv/include/asm/image.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+
+#define RISCV_IMAGE_MAGIC	"RISCV"
+
+#ifndef __ASSEMBLY__
+/*
+ * struct riscv_image_header - riscv kernel image header
+ *
+ * @code0:		Executable code
+ * @code1:		Executable code
+ * @text_offset:	Image load offset
+ * @image_size:		Effective Image size
+ * @reserved:		reserved
+ * @reserved:		reserved
+ * @reserved:		reserved
+ * @magic:		Magic number
+ * @reserved:		reserved
+ * @reserved:		reserved (will be used for PE COFF offset)
+ */
+
+struct riscv_image_header {
+	u32 code0;
+	u32 code1;
+	u64 text_offset;
+	u64 image_size;
+	u64 res1;
+	u64 res2;
+	u64 res3;
+	u64 magic;
+	u32 res4;
+	u32 res5;
+};
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_IMAGE_H */
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index fe884cd69abd..12d660d929ba 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -19,9 +19,39 @@
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
+	.dword 0
+	.dword 0
+	.dword 0
+	.asciz RISCV_IMAGE_MAGIC
+	.word 0
+	.word 0
+
+.global _start_kernel
+_start_kernel:
 	/* Mask all interrupts */
 	csrw sie, zero
 
-- 
2.21.0

