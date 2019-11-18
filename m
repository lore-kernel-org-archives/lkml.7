Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7F1C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F9A2230C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A9P4UAZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKRW5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:57:07 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53672 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfKRW5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574117826; x=1605653826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/+BAvaHz+N+7XuCnyGB3EMvAUV1znsWOwLjOz3dJZA4=;
  b=A9P4UAZqan1+VPzeVcfWt/rsn5TDwsaSS8DFYo9wfhT8RGyRQMbimJws
   RWPTOas77iu0C8Emvao2LwI/VxRgT7INMYUfgmNtA1tB37TJiqtaDSEMX
   83Ob7lAgU5k5Z8K5FDPtUl7487TaYbpNVLllx7jEaJlRVn4s6t/+pLJWH
   0oALYB+Jtdi839v4WSpysjmBdMJU6TWqp1GwJbtDfN16ryzb+rCJKPVU5
   49W11xBwOsiZLy58N0/W0lu+H5MndPsgGVo/qLY+nXmIIQx8HHbzKx/e7
   c2pZCAjSsPx2er13zN9A1b0RuuQcAb4ORTc3JTY1n1I7NwrgeLhMUJItz
   w==;
IronPort-SDR: sn1BJntDCq1/mTQV1WMVckmxU7m2LUuqDkTl/T+n3cD7Ec4AcQ/XkQ5sA71UlKSgzqiuTNUA6a
 1LqvtKpB44/A3XM/Zd/IAkoyCIANre55PfQB3vXCWGOzMKMcBsL4Vqts+BaAGY3JArvt6AQpYd
 7+6xW4BEYXPF1RcgoP0qabC1Onnc+bwo6cr0YXtsHdSF2q+bHgQNZ55OMBqo/BOHHImJXvAhkM
 ucFsxP88j5EiQGavFAOtQ9cug6watHVOQ1ZvIM0KOxoKqcCJ9rBPT8U9YhXrN1Mw7LSsUcbNb7
 0Fg=
X-IronPort-AV: E=Sophos;i="5.68,321,1569254400"; 
   d="scan'208";a="230735381"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2019 06:57:05 +0800
IronPort-SDR: kQwceTjN83ScpkGh/YaGTfi4d89A5PVAWEq+MxGZOUzmn/aajEtkp4TrmNjx47SQbSCIuV0FK7
 iQz2kWgg/gK49cbBdsIpG75D1nV0sPHdYO/WcKnJcbvnC2vK16AWu9OgTC12lT2plTt2zwzVNf
 2y7CV8j7LYE9f04JSTm1dSC+bnn9+/uCNMTozxVUK2ojjjrhvlg5QAphZphwnKRotvgNYqxnhl
 xq5V2mV87hdX7TMikJbDO+W0/V5Oln6iRv+j3PpYsx3Kkl0W84u1EBMooE1f6rXbQMPYBaP9b8
 HWIvGSfJ6vMqHfwYOZ5wPjtn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 14:52:19 -0800
IronPort-SDR: mA89hvIC1dzzDvS1rNIdy/3mESYjMmS8+jqWnX1hc8WhQwMZVePBEiHQlbPOWt1FQ0h03D879t
 ARCLJyxvCIIRFjxxAF/6vkWClzrHf6psvRVvtm0bJpXyiyhAlZxrXAhTZAPOGZLxbC6QmYfU/o
 zsKhzTRFS/INGrVLclYmUzQvw0yxQ07dcJlkxU30rMKsraw1tWb3hGQ2YFiI2UcH10RDx35L8I
 d2ZNOxCUpEDG1rbrfffzFlr1bkbZK7MG8GCyVoL+21G57YSNqqRuwxJeII1aPkbjwcjs7AUQ7Y
 62I=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.237])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2019 14:57:06 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>, Gary Guo <gary@garyguo.net>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Behrens <behrensj@mit.edu>
Subject: [PATCH v3 1/4] RISC-V: Mark existing SBI as 0.1 SBI.
Date:   Mon, 18 Nov 2019 14:45:36 -0800
Message-Id: <20191118224539.2171-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118224539.2171-1-atish.patra@wdc.com>
References: <20191118224539.2171-1-atish.patra@wdc.com>
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
index 21134b3ef404..2147f384fad0 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -8,17 +8,17 @@
 
 #include <linux/types.h>
 
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
@@ -42,48 +42,50 @@
 
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
@@ -91,7 +93,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 					      unsigned long size,
 					      unsigned long asid)
 {
-	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
+	SBI_CALL_4(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, hart_mask,
+			  start, size, asid);
 }
 
 #endif
-- 
2.23.0

