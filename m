Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64D3C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4F72089C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rc6IiNmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfGCAys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:54:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53186 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGCAym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562115282; x=1593651282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wy7yC5O2tmsY73xSrxj13jbMBblMeVDokHmeqGBlXTw=;
  b=rc6IiNmvFTTZgqISSh+6pMluu6hlokptQpg8ZvEDhDuZk1eb7c0ZCxa+
   /tXrJeh1eGliN1MRbdG5/RchB0/eX7IWPUf6I+09pWBRcot8LWO9o2/61
   gicuZBhI5LDjGvnnS9rqY2j3u8eV1+1OHBCAE3bjvL4wY2V3q6pDnD5iO
   /kc3ARuzck7lsy2YfVVg1D9KmSLPUGvBqhQk0BzTnmk6J8EHxng00gXkK
   v1PV2sPZmp8BU6tz3D5Zg1CZ0QMxoIg47E3rX9wJPEOLl4tSRYzXiy0hG
   pWJPInvo53XONoa8Y3ldhz/bwOshe42+Ll0uLu/VvpFwllvzCeGKRsDIb
   A==;
IronPort-SDR: wh5FT19IPbpqFeWdKG1RDdU3c8hVyZQM2ilddF7AepHOYwAGxFSJ5qNMNNGYKNdpJo19LeGa0Q
 hqzGV0XFtIWWQvx9rCGe9NECZ1ifiJUqaObmft4shnT6MjeYsgftqmXjUuuIvNBHcTGmQaK3JT
 jn9UUBQT91bJbYDp5W0oIILekgtlKT104DSgmwEyeNIrLYhn9coBDG93SrqCilLXmYqpjC5sKm
 OROKSt1VfoyOqwypPIPOQF36cc3dPfeHoRLkS2p6lxNdu09fWAapqIvsIgxcv+kMwjjt1CgtRg
 j5o=
X-IronPort-AV: E=Sophos;i="5.63,445,1557158400"; 
   d="scan'208";a="113716745"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2019 08:54:41 +0800
IronPort-SDR: R96qTjlI+HZzO4zp4OmDPPi6AmCvV0yhj+RhLlx3ufv7WFaVae3WZ3xG8TWcS3MA0PxW0yyN5f
 RwJ7Evd6FkqSJU9mImBEIDAA0gh5mLWcpqxH/dxqbX97n2Sq9HmqEq/bLzrb43KxRtldd+8l/n
 CIYD5TCbBiMwrNkgKCy7K0T9uw4Py6KXMRqEJLqydUQGJ5bJ3qu4ReVziijFkitq3c0GLat8WT
 b7ZQU0uayRWb9H3XsTyjiLGd26YU2hMS4TZ0btLI7/y05TGQujJcMIhjzQeYcSJmK064xdW5Hh
 5Jng+PQlw1smOLdGH6Al2qIF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 02 Jul 2019 17:53:42 -0700
IronPort-SDR: Vas0ZmY2WTLD4D32wsiC0idNWk2cEvWjiEvuKcoTH7iaPOOiiIfGMUfQGFBsTdaEhdnmTm6L9M
 XbHVpKx2ryuFhZ6ghamcNSTUIizdK/F4l4gDpsY8JI79LPmpikqxk9qq/7SmADCrfP4KjCIfuJ
 OTK60S9lo+MUCN++J+E+OgrPCawor07uRnS+OwkPCSb9c1Vxt9gVwOFMyiqCnZx5Z2gE4JDR7H
 dJSz3XOjIAaAMjEGAsPD1cO5dSzzHIcQp8zoMMJAHnGpddrxWh/IkSvrQwS92uc6wkCxq26qjK
 9M4=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO risc6-mainframe.int.fusionio.com) ([10.196.157.140])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2019 17:54:41 -0700
From:   Alistair Francis <alistair.francis@wdc.com>
To:     linux-riscv@lists.infradead.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH RESEND 2/2] riscv/include/uapi: Define a custom __SIGINFO struct for RV32
Date:   Tue,  2 Jul 2019 17:52:02 -0700
Message-Id: <20190703005202.7578-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190703005202.7578-1-alistair.francis@wdc.com>
References: <20190703005202.7578-1-alistair.francis@wdc.com>
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

