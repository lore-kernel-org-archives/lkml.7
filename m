Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6633C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906432071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UkDE96Ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKZDUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 22:20:39 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55206 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfKZDUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574738439; x=1606274439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3msswi1L8Ks5wZg0/7wdqU8PmVWmbpisj9uZJ7Kr3ao=;
  b=UkDE96JuWvvjsnwkxKs4otA03GQpzzjyrEahSC6XaDOhU6lfUZKtNrgV
   hB+2GpMpi4oTmiEJ3AUf3lhOpMliQ+OuP4/LfzB3ig+7W3t0ddHBWTg2F
   PDKhaKKLucqVimZ6f/J8Yv/z4g29JJVQEGfWaGyZU3qqIX4TdWBHqYB7F
   36nD/pwCs7rEs4H6rjIgQjp2qr+4yXayMJ85T/uVIm2KXu9nYePjlyRDU
   i1tHSQtwZC1Hds0MWCQEI8tT25WCE61AgNJJwu08Hq16CtmHBC47Dp269
   OYdcKdmCcfRhpnBw0dZ+5tLLelaWrN0pwV0BGb824jPqlmSWGeQDVFiBc
   Q==;
IronPort-SDR: 5wf/h+qCDjwWGOqRIiV4TPx/akvxjE0ydZmkfY2JjpPv2SoVEfmIMBGktpKuRP+oMj7puxqKYB
 OhQpOjI+GmPw54XG6cbIIY3+RhsTTMvjUygZFHj9yl/P80R3lmnDAOQE02+9h+svqdn+8nEY/1
 G794UwDpuEN8e/6+ytomEIO9H3VCXKmHFkJ/AlZ5GzF6k2P11bbB4KEQsfA59uAswGYOtpF34z
 8TQB2mCaUnUwRYpbh0YtHgP+Vh6MxaCh0qv+Z/zWbkVxK9xFFee8pCVt/ZRv8orh8pPFklOCPx
 fV4=
X-IronPort-AV: E=Sophos;i="5.69,244,1571673600"; 
   d="scan'208";a="124761538"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2019 11:20:38 +0800
IronPort-SDR: wATwAj2vt0I5rt5KiU8OVDwRyrRflRMIV1ZkAEmZWb/JWbGZ1ZKB27qTEt2zIB9XZ9MI3xbHxl
 aCYPUhegIj16TFGr/K8N7oWR/bwo2LbGtdya7ph0NZflfYyAYpfBxkBphBoPcL39rjyRHBs5W2
 HvZYJg+pq6kmWmGrdvfcLe/DmmRdAarjYLffZ3yZKlUy8h/QGLYY3/CAeDf2OTnyjDPD4n745E
 UvVdoKtYyYLDIgQJMtH7DIN2i3fdvZYPHRryNxUGkFQWdSWJ/aNaskaiq2VfiTOMeMCgfdjTDw
 Shq1ATWot2PzMgex+RB8wJNz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 19:15:17 -0800
IronPort-SDR: w9itRxrTp7+z+XJ8tiL++ldN14+tqtCnpkhNSDO6JRW3tsE0Orhyj3GM81wwQFXtHbGkEJbDq3
 vhCQHOFThZQYvHdUpUe81+zhAcpPG63NhDSOnwNYEKZKjtm0GhvD8H+z/sJjY2Q3gu87oCoS45
 WWMv2GwTXWDylAQIocP5CWttmSRz/af7+ljlx3bpMyQEY6v1k0ijoTvm5/hm4gwG2lLX49+ZBO
 8b9gGJK3J7KfFZX8+XzqpO4vVcxEN6T8YRJNTIJC0gqCxJ3OmmbVEjPqCv0nigxd+6ORXhqt4J
 gmc=
WDCIronportException: Internal
Received: from usa003951.ad.shared (HELO yoda.hgst.com) ([10.86.50.226])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2019 19:20:37 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 1/4] RISC-V: Mark existing SBI as 0.1 SBI.
Date:   Mon, 25 Nov 2019 19:20:30 -0800
Message-Id: <20191126032033.14825-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126032033.14825-1-atish.patra@wdc.com>
References: <20191126032033.14825-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the new SBI specification, current SBI implementation version
is defined as 0.1 and will be removed/replaced in future. Each of the
function call in 0.1 is defined as a separate extension which makes
easier to replace them one at a time.

Rename existing implementation to reflect that. This patch is just
a preparatory patch for SBI v0.2 and doesn't introduce any functional
changes.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sbi.h | 43 +++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 2570c1e683d3..96aaee270ded 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -9,17 +9,17 @@
 #include <linux/types.h>
 
 #ifdef CONFIG_RISCV_SBI
-#define SBI_SET_TIMER 0
-#define SBI_CONSOLE_PUTCHAR 1
-#define SBI_CONSOLE_GETCHAR 2
-#define SBI_CLEAR_IPI 3
-#define SBI_SEND_IPI 4
-#define SBI_REMOTE_FENCE_I 5
-#define SBI_REMOTE_SFENCE_VMA 6
-#define SBI_REMOTE_SFENCE_VMA_ASID 7
-#define SBI_SHUTDOWN 8
+#define SBI_EXT_0_1_SET_TIMER 0x0
+#define SBI_EXT_0_1_CONSOLE_PUTCHAR 0x1
+#define SBI_EXT_0_1_CONSOLE_GETCHAR 0x2
+#define SBI_EXT_0_1_CLEAR_IPI 0x3
+#define SBI_EXT_0_1_SEND_IPI 0x4
+#define SBI_EXT_0_1_REMOTE_FENCE_I 0x5
+#define SBI_EXT_0_1_REMOTE_SFENCE_VMA 0x6
+#define SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID 0x7
+#define SBI_EXT_0_1_SHUTDOWN 0x8
 
-#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({		\
+#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({             \
 	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
 	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);	\
 	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);	\
@@ -43,48 +43,50 @@
 
 static inline void sbi_console_putchar(int ch)
 {
-	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
+	SBI_CALL_1(SBI_EXT_0_1_CONSOLE_PUTCHAR, ch);
 }
 
 static inline int sbi_console_getchar(void)
 {
-	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
+	return SBI_CALL_0(SBI_EXT_0_1_CONSOLE_GETCHAR);
 }
 
 static inline void sbi_set_timer(uint64_t stime_value)
 {
 #if __riscv_xlen == 32
-	SBI_CALL_2(SBI_SET_TIMER, stime_value, stime_value >> 32);
+	SBI_CALL_2(SBI_EXT_0_1_SET_TIMER, stime_value,
+			  stime_value >> 32);
 #else
-	SBI_CALL_1(SBI_SET_TIMER, stime_value);
+	SBI_CALL_1(SBI_EXT_0_1_SET_TIMER, stime_value);
 #endif
 }
 
 static inline void sbi_shutdown(void)
 {
-	SBI_CALL_0(SBI_SHUTDOWN);
+	SBI_CALL_0(SBI_EXT_0_1_SHUTDOWN);
 }
 
 static inline void sbi_clear_ipi(void)
 {
-	SBI_CALL_0(SBI_CLEAR_IPI);
+	SBI_CALL_0(SBI_EXT_0_1_CLEAR_IPI);
 }
 
 static inline void sbi_send_ipi(const unsigned long *hart_mask)
 {
-	SBI_CALL_1(SBI_SEND_IPI, hart_mask);
+	SBI_CALL_1(SBI_EXT_0_1_SEND_IPI, hart_mask);
 }
 
 static inline void sbi_remote_fence_i(const unsigned long *hart_mask)
 {
-	SBI_CALL_1(SBI_REMOTE_FENCE_I, hart_mask);
+	SBI_CALL_1(SBI_EXT_0_1_REMOTE_FENCE_I, hart_mask);
 }
 
 static inline void sbi_remote_sfence_vma(const unsigned long *hart_mask,
 					 unsigned long start,
 					 unsigned long size)
 {
-	SBI_CALL_3(SBI_REMOTE_SFENCE_VMA, hart_mask, start, size);
+	SBI_CALL_3(SBI_EXT_0_1_REMOTE_SFENCE_VMA, hart_mask,
+			  start, size);
 }
 
 static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
@@ -92,7 +94,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 					      unsigned long size,
 					      unsigned long asid)
 {
-	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
+	SBI_CALL_4(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, hart_mask,
+			  start, size, asid);
 }
 #else /* CONFIG_RISCV_SBI */
 /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
-- 
2.23.0

