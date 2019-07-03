Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D876C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FBC21993
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PnPo4QIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfGCAae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:30:34 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44681 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfGCAaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562113830; x=1593649830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wy7yC5O2tmsY73xSrxj13jbMBblMeVDokHmeqGBlXTw=;
  b=PnPo4QIFCl4xycyFwVj/2AcvUw6ex0XLigKL1lNsn4WfqKtLLUNpOgsg
   K1kkcH3CG30NLdOKTtiKMeNK7ZbWSr+Cn5jyb8lcI7VumHIfItUGtbfeM
   ZJ62wx9jw8CZb7kI41GIsYKx/6rmaqw0zufPl0JclLn2nR7SnwEiWQ4rj
   nuvSS3kG+vO9C0wsE3GujuLtmgFTH4LI8YJTuVGfspchYN9+tN1P/vwQ6
   D0t86jqtpVAKNL/aZ62FS14SEbYVHfDnNqKSIfsfaNwKhy6vkmekUKrje
   igbi+UqB57D9rBC/3C0tzrbYltfXpLmkdfXIM6BUvU0pRFvDwo0YtjRMX
   A==;
IronPort-SDR: 1P891hBb6x9O1/3WGDYYtPtTpOfbMaVNTAJhLU5rIOJBVcn/vZDm2dj6I1QL+LobYT87HpKV0i
 Aoz/YlCBjNoEWIpTw7uNbAIHGz9mk4rSGD1gusgSrewaDyO6dcSrpslrYgBZR6Iz5uRO3BPdEg
 LU93Y37riV1NqvzMLVrjgE53qabx5gB/z7FOoUB8SzjSMROiAe9c5IXA/hu7nZ5OOesXWRQrk+
 JMbbyxQjSqdGpSywmYyQrpO8maJTKle7ORABpKj3XE8i+x5ejaMuEB4gOQRcnfkO09ihlQwwWC
 gHE=
X-IronPort-AV: E=Sophos;i="5.63,444,1557158400"; 
   d="scan'208";a="112096603"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2019 08:21:25 +0800
IronPort-SDR: oRlID7VbmY+mxcrY+wVzzQ/KZDSEytidsRl6/1s+u7pC0OIZAqp7VZDYjaEukeCaLrWuvw/aoe
 WZapSjss7sojXQhhI37rfKBjIHKmFtiD6nhKvxDYEXkjHhlp1xjSk48pHO8fljb1skZ++esrPL
 LaSbZq7lWU5gmlO2c6upJtwj6uT5UGo76bWSv5NczKfu+CJflbZF6YfWNT9JmwOJB21K7NgdPs
 YgoTmHG429jE592pZO6s4+W0A9ClMnvTKODHtU/0w+y4M+ggKYjgJ0OCmnTheG+5Y5eIibUrjz
 vRPwJ0qq4CUHQkR0+nbjah2N
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 02 Jul 2019 17:20:26 -0700
IronPort-SDR: UZDjthIev6GusnpHicyRKLOOvWLP2fQvqt3HwRFRUC0oadg5DnlWcaGsFdEfndiB8WVfKl9IZw
 tGKxdSKGiYNLoHy1gcLpTIjhr/Iq1AKVZHnDKiTzTZkbNxXuR6xecPm8frDbDknAYt2Utzr5bk
 YOd//7/wlsnatwxsEy86yOCSjRIkiqo6UDtAvAq+HffqHSwZtcm1YO+iFrV9rFBhasi0uGV/c8
 YDiVVjL4/RyHDL8xh6/+Ya55tadiIOh9olwty8MwoYWQ0mvpUQvKXDyV5urEID58BpsvXeej24
 P/I=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO risc6-mainframe.int.fusionio.com) ([10.196.157.140])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2019 17:21:24 -0700
From:   Alistair Francis <alistair.francis@wdc.com>
To:     linux-riscv-bounces@lists.infradead.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/2] riscv/include/uapi: Define a custom __SIGINFO struct for RV32
Date:   Tue,  2 Jul 2019 17:18:42 -0700
Message-Id: <20190703001842.12238-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190703001842.12238-1-alistair.francis@wdc.com>
References: <20190703001842.12238-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The glibc implementation of siginfo_t results in an allignment of 8 bytes
for the union _sifields on RV32. The kernel has an allignment of 4 bytes
for the _sifields union. This results in information being lost when
glibc parses the siginfo_t struct.

To fix the issue add a pad variable to the struct to avoid allignment
mismatches.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 arch/riscv/include/uapi/asm/siginfo.h | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 arch/riscv/include/uapi/asm/siginfo.h

diff --git a/arch/riscv/include/uapi/asm/siginfo.h b/arch/riscv/include/uapi/asm/siginfo.h
new file mode 100644
index 000000000000..0854ad97bf44
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/siginfo.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_RISCV_SIGINFO_H
+#define _ASM_RISCV_SIGINFO_H
+
+/* Add a pad element for RISC-V 32-bit. We need this as the
+ * _sifields union is 8 byte allgined in usperace.
+ */
+#if __riscv_xlen == 32
+#ifndef __ARCH_HAS_SWAPPED_SIGINFO
+#define __SIGINFO 			\
+struct {				\
+	int si_signo;			\
+	int si_errno;			\
+	int si_code;			\
+	int pad;			\
+	union __sifields _sifields;	\
+}
+#else
+#define __SIGINFO 			\
+struct {				\
+	int si_signo;			\
+	int si_code;			\
+	int si_errno;			\
+	int pad;			\
+	union __sifields _sifields;	\
+}
+#endif /* __ARCH_HAS_SWAPPED_SIGINFO */
+#endif
+
+#include <asm-generic/siginfo.h>
+
+#endif /* _ASM_RISCV_SIGINFO_H */
-- 
2.22.0

