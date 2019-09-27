Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697BDC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 00:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC4B207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 00:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IbE53V5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfI0AJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 20:09:27 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38047 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfI0AJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 20:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569542987; x=1601078987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KPhrBII3Q/D9Muze6sav8ec9R3+Qxjj5Wect3Thw/gs=;
  b=IbE53V5BAKcrHfYwcWY6uuXxEQuB+dlK5NFHuz/+u3J4CTBT3jowaLiP
   WSlRgluU3B6+Hxk5/W7hME8ZQ+V3AWIo4NLs7ln5te9J0GJx3YSDpjCuo
   zTK6QwV44aqtjBDUoPQfi6Zda+w8YRG2LkDHWxYHmqaKvWxSoeLhYnDOu
   7D9gkFpNzbu1WpianK+V9A6A2FrTDzOMZRvMgfRRRHSUSEMK26lL1PZfA
   vnZGgPs88eAoYnmDKjCTM4NOJKYlPqri1JPPUnWJrIhQ/S+CjHjqYkeXF
   LoEti2E4ptIDxgD6shhCFa2e21gTo2cMgneNrBXjTEfWm6qX/2Q2F7Tic
   w==;
IronPort-SDR: uYjcvG+m+59jtqspMevgNtJg3+icfkI9IpNALB4f1vW4YNfOX2NUZG9AFKvH8nqeARMW3oqI+J
 C8j0fxmI81W79jQ8Vs4nyrBAdkdopFcaDXDHDwNKkg4X4dXQV/Ymbinb3wCke36Y3szMYIhj/E
 JvFVbtOiiMbnit60TYfU6LxMiDZA7atXbHGmMqKejMDhSewIfFpWXnOP7a8/lXwPh7C5VM9Plw
 5G4ICBQ0uyMmRNKd1SY0zZ52ViinfTiosvz+PtdLWGcVAsGXyiV8VEQSAAB+7w63UnBDEkLmXp
 DZo=
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; 
   d="scan'208";a="220096737"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 08:09:45 +0800
IronPort-SDR: +0zFzyi3miI62q5vzcFEVmf3rFbKE3JHbyTO2xUx357N4pRYmtpFbTtEFtyKoR8J2jzacwD6GW
 iHuAMEEQf0csQzkFtfUhdJnKKbm3EjW9OiDCogUe+D9N3kEodN+Gq4PSVfVqC0+/QN9Ygtbxhm
 O9JPaV8x3mM6+3zvR/Gx5eKC4wknSu75No+JbfDUXHizwP5ewXuNFrWGgrE3ACiqjscP5MAutz
 2m9SSyor3KmGfSNhBHp+TD4JP47jL3/5eXZnQXFjHuZPTjTxIW2XWrIT9tzvsVhZ9qoe5FJP8X
 YtHI9HgD4xRRNfZ0ou0rS97+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 17:05:45 -0700
IronPort-SDR: GrXZHkzBbltDD1EMwWoWItN2OyPtRJK5UyeJYyhwfoENa/jdZXAYn3YtZzk/liUs9zkdZSIfEs
 esIOr9ibIBp97JW+oecH8cgn9ejEl7AS5VlJvFcZ3OUWlF2368/sW2tu82IgOiKFsQd2P5cWlM
 iB0KTuG0S9Y9qSVisJJp/KUIga+MdK+gAq2YQ4dVJu8rIPKklyE0dlOGLLvKwP/bT25wrekYyo
 jKqpBR7EEsYX6o/v+MSy98p314KGkj4tEMl0BiXdPMdj2WIYAba8lcV6zdOwdLKjm4kjFFPoy9
 MCQ=
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
Subject: [PATCH v2 1/3] RISC-V: Mark existing SBI as 0.1 SBI.
Date:   Thu, 26 Sep 2019 17:09:13 -0700
Message-Id: <20190927000915.31781-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927000915.31781-1-atish.patra@wdc.com>
References: <20190927000915.31781-1-atish.patra@wdc.com>
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
2.21.0

