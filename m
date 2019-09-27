Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DC7C352A9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 00:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4553207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 00:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RxfmoXcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfI0AJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 20:09:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38047 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfI0AJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 20:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569542988; x=1601078988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bDArMe9M2L91Z/CR0UnsmHQJUCaE4qjpImR1YxVjjj4=;
  b=RxfmoXcVp5X59seu8/+gzlhry+yCeTh9tLfLTUpuZvZgUgWk6oATZttU
   dtW/YvDj/GNYrlxWfBvchSOdOhORtsBeMfBtqJoxoZY3hNK9yFPwwcLLu
   cVFthIYQql1QzCJwJFGho7CcITlFAIY+j2XBzdiH+tyDTYEiYeNAyoUSU
   4U4N+LWdYS7wA3YTq+kh96+CEh7D1eSBunU9QGIwo/kf3SvsDQo6LfWEl
   HC2LcoLYoYowJbywwouMxhfEYP8u09v3QY1se+KeURKPjrvdo9UQJIpjw
   ri7XSmMEA7YkMEBTZIZzcYCxsy996UL0dgCKEL43PalXI6Hl5tMWFFHA8
   w==;
IronPort-SDR: oZdufVvqyR0WHwkTjv/vKcEmZMMnS1vhH14ThAuG3oPHcY1yTfIDwvkFiU9UnTwLu6RKYJk1+5
 E2AfXxDVrDkx95u0npMSPXFMsSKXNKpZkrkPMcrByW1Lia4DZ3If8WxcMB8Wxye94WO55d9vGR
 zIfEUA4OiQsREuqbF71FsWyuqIRXkuGfo20XX1vxSYVfx20gGJQcpLvPzttrh3hvffNRwivH5+
 5cSN6IQG4KbFz8sSviQZcPtzxA9jJXGlkbpZ2558hYLUI2dKHuJNQGtJ14RyKP8YazbWc5OGMZ
 SQo=
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; 
   d="scan'208";a="220096745"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 08:09:46 +0800
IronPort-SDR: f+n4acBEkBoHo1LCgHYsXt9sbBCMmGwpQcCz0cBJOR4F6JPSzmvFfuBvKgYf9kko1H3jnxJocJ
 OkzAZ7IWKI+3GTc6KZr6DfvsSrxxYL9fAFtyu3T0w4Os3W4QTFOA8sUcc53Iv3v0YFd9Oy6Rtj
 YVoklQrHPzkURiIyS7OxHNlsay4LlpHfGbVjJSaRvtE44+upRFHru9G1LNiLWhou8ptF2B7fta
 iusbn0EklYg/5BBb9Pu0HQGujG8D1bXpbBvTOSFlann2tYkgSGDzlRql9Sfb4J43CNJbSOHhNp
 dpjcKNuuPe+MX2CXDBBUhSp/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 17:05:45 -0700
IronPort-SDR: 5iiWTZJZcFIZLgZ/ptOBpHjaDkMGM/HJC4HUB7QiJCVOBj24JiCl63mi+A1hxuRHQRcx+bMRQQ
 p14dA785reRfFMxu8TZcc+xegP3+vhPgoECX0jWMVV0WJPpbwu5PdGQ6dGl0Z1EE0DbCKGr3L6
 tkBOE6j73OupEAxlVGMmtiwTOq7QMEWjue+yy2K2CQmXW10u4xtolQAZHZVceak+vb0xQ4nOdT
 wxISFKSoh9JSA+91eQGSybK3Ktqblh1HKv/WqpLSMmOm2IdYZ+AWmLeDYGwdEscdoQ25TcR6qx
 wSo=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Sep 2019 17:09:25 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>, Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 3/3] RISC-V: Move SBI related macros under uapi.
Date:   Thu, 26 Sep 2019 17:09:15 -0700
Message-Id: <20190927000915.31781-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927000915.31781-1-atish.patra@wdc.com>
References: <20190927000915.31781-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All SBI related macros can be reused by KVM RISC-V and userspace tools
such as kvmtool, qemu-kvm. SBI calls can also be emulated by userspace
if required. Any future vendor extensions can leverage this to emulate
the specific extension in userspace instead of kernel.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sbi.h      | 37 +-----------------------
 arch/riscv/include/uapi/asm/sbi.h | 48 +++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 36 deletions(-)
 create mode 100644 arch/riscv/include/uapi/asm/sbi.h

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 279b7f10b3c2..902b83041111 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -7,42 +7,7 @@
 #define _ASM_RISCV_SBI_H
 
 #include <linux/types.h>
-
-enum sbi_ext_id {
-	SBI_EXT_0_1_SET_TIMER = 0x0,
-	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
-	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
-	SBI_EXT_0_1_CLEAR_IPI = 0x3,
-	SBI_EXT_0_1_SEND_IPI = 0x4,
-	SBI_EXT_0_1_REMOTE_FENCE_I = 0x5,
-	SBI_EXT_0_1_REMOTE_SFENCE_VMA = 0x6,
-	SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
-	SBI_EXT_0_1_SHUTDOWN = 0x8,
-	SBI_EXT_BASE = 0x10,
-};
-
-enum sbi_ext_base_fid {
-	SBI_BASE_GET_SPEC_VERSION = 0,
-	SBI_BASE_GET_IMP_ID,
-	SBI_BASE_GET_IMP_VERSION,
-	SBI_BASE_PROBE_EXT,
-	SBI_BASE_GET_MVENDORID,
-	SBI_BASE_GET_MARCHID,
-	SBI_BASE_GET_MIMPID,
-};
-
-#define SBI_SPEC_VERSION_DEFAULT	0x1
-#define SBI_SPEC_VERSION_MAJOR_OFFSET	24
-#define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
-#define SBI_SPEC_VERSION_MINOR_MASK	0xffffff
-
-/* SBI return error codes */
-#define SBI_SUCCESS		0
-#define SBI_ERR_FAILURE		-1
-#define SBI_ERR_NOT_SUPPORTED	-2
-#define SBI_ERR_INVALID_PARAM   -3
-#define SBI_ERR_DENIED		-4
-#define SBI_ERR_INVALID_ADDRESS -5
+#include <uapi/asm/sbi.h>
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
diff --git a/arch/riscv/include/uapi/asm/sbi.h b/arch/riscv/include/uapi/asm/sbi.h
new file mode 100644
index 000000000000..2e09ee52c346
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/sbi.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Common SBI related defines and macros to be used by RISC-V kernel,
+ * RISC-V KVM and userspace.
+ *
+ * Copyright (c) 2019 Western Digital Corporation or its affiliates.
+ */
+
+#ifndef _UAPI_ASM_RISCV_SBI_H
+#define _UAPI_ASM_RISCV_SBI_H
+
+enum sbi_ext_id {
+	SBI_EXT_0_1_SET_TIMER = 0x0,
+	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
+	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
+	SBI_EXT_0_1_CLEAR_IPI = 0x3,
+	SBI_EXT_0_1_SEND_IPI = 0x4,
+	SBI_EXT_0_1_REMOTE_FENCE_I = 0x5,
+	SBI_EXT_0_1_REMOTE_SFENCE_VMA = 0x6,
+	SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
+	SBI_EXT_0_1_SHUTDOWN = 0x8,
+	SBI_EXT_BASE = 0x10,
+};
+
+enum sbi_ext_base_fid {
+	SBI_BASE_GET_SPEC_VERSION = 0,
+	SBI_BASE_GET_IMP_ID,
+	SBI_BASE_GET_IMP_VERSION,
+	SBI_BASE_PROBE_EXT,
+	SBI_BASE_GET_MVENDORID,
+	SBI_BASE_GET_MARCHID,
+	SBI_BASE_GET_MIMPID,
+};
+
+#define SBI_SPEC_VERSION_DEFAULT	0x1
+#define SBI_SPEC_VERSION_MAJOR_OFFSET	24
+#define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
+#define SBI_SPEC_VERSION_MINOR_MASK	0xffffff
+
+/* SBI return error codes */
+#define SBI_SUCCESS		0
+#define SBI_ERR_FAILURE		-1
+#define SBI_ERR_NOT_SUPPORTED	-2
+#define SBI_ERR_INVALID_PARAM   -3
+#define SBI_ERR_DENIED		-4
+#define SBI_ERR_INVALID_ADDRESS -5
+
+#endif
-- 
2.21.0

