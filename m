Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D7BC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0256021738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pBNkqVv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfDWXZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:25:20 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62950 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWXZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556061920; x=1587597920;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l9kLduGgH2CEH7OEe9isFOfe6yfXUj5pwtaHUqeYFhE=;
  b=pBNkqVv6teBGJQR1oeAWOa9KTDymuZDGA/xfQVxgaaIxJ4Bux32DKXEh
   1l7EPjljry3RnYKtDyhlHXWvgxP0nR8TwWWu8N5+E4NxdURoVLT4YCMGy
   ufcpiVQq2UGfELdsFDSvqZAwPyvzZj6A1wQ603Hj3+/1lkciPg8N6Jcg9
   tQPoq8+2F2TdqoowO24zzOdexBbq1yolQMrwjsKl5vxqPKAuxyT1fA/4j
   l6OMgKioN0JcOvKQ9KdtrS9lGabmAzQ4NjoNZnPaeZceCSnBkssTxwV77
   LTUtEKjDyxfIVoudtZUhd0GG5MiI1nlaZ+1fLQGNSW+mZY7Qh1jo/Tqw9
   g==;
X-IronPort-AV: E=Sophos;i="5.60,387,1549900800"; 
   d="scan'208";a="107864434"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2019 07:25:20 +0800
IronPort-SDR: M298p7UfDHodE1qxxvvMyBaHtNpn6g6qCau/cjuo/fxij4M0U5/4rPD8Sln4WtqIdzYm3DiUIE
 6W/iNJS1CvQrlwo6hVXbLGnbqmx7Qfv40z8d7ELJAdqrY59x6rD7pcrOt1IxvL2BHVBbQBEPtK
 yihVNgzE2HX0u4CgleyCqc5zZiWLf5LdqTuayrAo1q9MBPspvH2MZ5pPkv4Fbs5bLZ7uZ9NYsN
 VeJsreAGsMm741B6mM9L0gSObgdqYphr9d+XJTnIja9E7UlT4SBHPP3cSubtycK6AsqCfAXtfD
 X+RS6obl9QmoHkAlXA+LvUEX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 23 Apr 2019 16:01:51 -0700
IronPort-SDR: Cz9usMlryfriG6lYXvNXQznDlYS1KUnhv6vwtE/cTtzKjynqmNIrmECRkprpZZ5KB8uV/Eyd8b
 2aauPy8BMAX0+k/0KosAhzqvvr2fJk84/zpaJoEq5Jlw4OrsD1JNZt8wu9YpMUXWrO6OAvFk2v
 MDchRTAUMBxaoRGoovjo+UyRmse8FCtgmN01TUqYYYG9N0WkkexVUbjaCuv46Og46T+Elr+Sap
 Ndm6k4dl7EvD8AHZdqZM863QTvbQ5lFHY/KAD3OjaYtC5WhwON8klgnTM5e17TxRzbTBxPqINz
 06o=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Apr 2019 16:25:20 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>
Subject: [PATCH] RISC-V: Add an Image header that boot loader can parse.
Date:   Tue, 23 Apr 2019 16:25:06 -0700
Message-Id: <20190423232506.857-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, last stage boot loaders such as U-Boot can accept only
uImage which is an unnecessary additional step in automating boot flows.

Add a simple image header that boot loaders can parse and directly
load kernel flat Image. The existing booting methods will continue to
work as it is.

Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/image.h | 32 ++++++++++++++++++++++++++++++++
 arch/riscv/kernel/head.S       | 28 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 arch/riscv/include/asm/image.h

diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
new file mode 100644
index 000000000000..76a7e0d4068a
--- /dev/null
+++ b/arch/riscv/include/asm/image.h
@@ -0,0 +1,32 @@
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
+ * @magic:		Magic number
+ * @reserved:		reserved
+ */
+
+struct riscv_image_header {
+	u32 code0;
+	u32 code1;
+	u64 text_offset;
+	u64 image_size;
+	u64 res1;
+	u64 magic;
+	u32 res2;
+	u32 res3;
+};
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_IMAGE_H */
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index fe884cd69abd..154647395601 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -19,9 +19,37 @@
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

