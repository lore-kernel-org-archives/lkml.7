Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4813C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A402053B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p5mAh4P/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfHZXd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 19:33:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61044 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfHZXd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566862407; x=1598398407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HBuM9mRogJeuAhVBz/AwUtILAVrCxrWKJVjNr8ehU94=;
  b=p5mAh4P/buGD7i9TQE6jcxfPxCfH0+LGrGnQfdDVsj5jfdm88xTTf5l3
   xYWsu51cw6L+q37glTqhV8B0Ts3+tcSImG2lDyQ1lUJbKQ0lODoMbby9/
   XC5+R+yxPSTqaH16I8xyIBXN4FxzV3icyp/rCUbavjKWxN6YDA4BwGeH/
   PxcTks/T1FVQfl7Qt0LlwBPt9NxLgpPNdl31bDDczpWowgchujDdyxKKz
   Cnx0GQAWfQ2FZB+ADMVVhwjUHfSvDw4da41//SLA5FbBgEpzkRnxpkHxe
   I5v+1uaIB4pVfmK7LA4faTimgdZCHFr4+7f+WkUCg++k7t9LE08sXqWns
   Q==;
IronPort-SDR: 6uWVivdhIvW8lUwHp3zMpec/MJ9sUG5x4Oh2WbRDY0QZ9EbxUKcNxxhfz52pag6dM4nw2KUrn+
 8ytxgLGWlTGhhXdIRus785dQIF3EVO5XXsEA+L4zSXh4TlndfMJxNO48BIqFyLwn7bhWWe3KOH
 0BCtzpYcJBx8SAlvIus6KtqNqCsnmmV4iffu/SpprmhrasOuGTPgvhBijWZzjkC+ziiZ01iR5K
 8hhsmBGHREcAYj5qDUhnOJeioW2YS6l01xpSSwYFE2bu/5T5cDemJtQIOaToINrhzy3L1s6OVC
 faw=
X-IronPort-AV: E=Sophos;i="5.64,435,1559491200"; 
   d="scan'208";a="116718027"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2019 07:33:27 +0800
IronPort-SDR: Nl9HEV7GtDZlgODvuv//hisoFEOf+81niqPFRPLLYcXIB98LnP+zLDa+NLDrHlai2xU/HFHdRY
 2bK9maCeaXYLH5SgNzejc3t768TUy/lxcTah1VPzeYZyuPbpXmdvbxptORMGU4WXFM5ZedFjFl
 ZG6nzIniAYH2gXZvwywptlgW5qI5gU/8AowkTUiDCSg1O64lctDJvKBeS03RbzNx2GANGd+dOS
 5ydpOeZFxOh8DFbPYlRVrcp4GfaouYlZulAXjkywN11uX1E1wEpdWzL8CT7t0FtPI49s5uSHTJ
 xqPiaCsRvDIuHUBXGxdDYCWC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 16:30:39 -0700
IronPort-SDR: VOG8eo+i8O55DIxvjUlBT6lQ8Lp1YRR4ZqyqgWU1pw0NJguuGPUzQGtMOg7MeA+i62MfrhxX1/
 p5Bl9KsmHhQwCOMg/X3LkHor8uE/9fZWr+A7bCcSfbAt6EAc4s74/MOxNYvi7+zaVab7XZ55hn
 s83Hro7DAa/yqk/sIOuw76v9PU6t3TMO5ePGJgY/xysGURyiH5/vcO4LC0R1MNRclvj1EmzNjm
 xXWuszoJLx3/oOdsNK2uH3VMMYaJDS8WnG05VQgcfJF7zfKWKIa+NzEd//Y+W4j5tTevCZ5ulZ
 84s=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Aug 2019 16:33:27 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <anup@brainfault.org>, Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 1/2] RISC-V: Mark existing SBI as legacy SBI.
Date:   Mon, 26 Aug 2019 16:32:55 -0700
Message-Id: <20190826233256.32383-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190826233256.32383-1-atish.patra@wdc.com>
References: <20190826233256.32383-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the new SBI specification, current SBI implementation is
defined as legacy and will be removed/replaced in future.

Rename existing implementation to reflect that. This patch is just
a preparatory patch for SBI v0.2 and doesn't introduce any functional
changes.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sbi.h | 61 +++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 21134b3ef404..7f5ecaaaa0d7 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -8,17 +8,18 @@
 
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
-
-#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({		\
+
+#define SBI_EXT_LEGACY_SET_TIMER 0x0
+#define SBI_EXT_LEGACY_CONSOLE_PUTCHAR 0x1
+#define SBI_EXT_LEGACY_CONSOLE_GETCHAR 0x2
+#define SBI_EXT_LEGACY_CLEAR_IPI 0x3
+#define SBI_EXT_LEGACY_SEND_IPI 0x4
+#define SBI_EXT_LEGACY_REMOTE_FENCE_I 0x5
+#define SBI_EXT_LEGACY_REMOTE_SFENCE_VMA 0x6
+#define SBI_EXT_LEGACY_REMOTE_SFENCE_VMA_ASID 0x7
+#define SBI_EXT_LEGACY_SHUTDOWN 0x8
+
+#define SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3) ({             \
 	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
 	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);	\
 	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);	\
@@ -32,58 +33,61 @@
 })
 
 /* Lazy implementations until SBI is finalized */
-#define SBI_CALL_0(which) SBI_CALL(which, 0, 0, 0, 0)
-#define SBI_CALL_1(which, arg0) SBI_CALL(which, arg0, 0, 0, 0)
-#define SBI_CALL_2(which, arg0, arg1) SBI_CALL(which, arg0, arg1, 0, 0)
-#define SBI_CALL_3(which, arg0, arg1, arg2) \
-		SBI_CALL(which, arg0, arg1, arg2, 0)
-#define SBI_CALL_4(which, arg0, arg1, arg2, arg3) \
-		SBI_CALL(which, arg0, arg1, arg2, arg3)
+#define SBI_CALL_LEGACY_0(which) SBI_CALL_LEGACY(which, 0, 0, 0, 0)
+#define SBI_CALL_LEGACY_1(which, arg0) SBI_CALL_LEGACY(which, arg0, 0, 0, 0)
+#define SBI_CALL_LEGACY_2(which, arg0, arg1) \
+		SBI_CALL_LEGACY(which, arg0, arg1, 0, 0)
+#define SBI_CALL_LEGACY_3(which, arg0, arg1, arg2) \
+		SBI_CALL_LEGACY(which, arg0, arg1, arg2, 0)
+#define SBI_CALL_LEGACY_4(which, arg0, arg1, arg2, arg3) \
+		SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3)
 
 static inline void sbi_console_putchar(int ch)
 {
-	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
+	SBI_CALL_LEGACY_1(SBI_EXT_LEGACY_CONSOLE_PUTCHAR, ch);
 }
 
 static inline int sbi_console_getchar(void)
 {
-	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
+	return SBI_CALL_LEGACY_0(SBI_EXT_LEGACY_CONSOLE_GETCHAR);
 }
 
 static inline void sbi_set_timer(uint64_t stime_value)
 {
 #if __riscv_xlen == 32
-	SBI_CALL_2(SBI_SET_TIMER, stime_value, stime_value >> 32);
+	SBI_CALL_LEGACY_2(SBI_EXT_LEGACY_SET_TIMER, stime_value,
+			  stime_value >> 32);
 #else
-	SBI_CALL_1(SBI_SET_TIMER, stime_value);
+	SBI_CALL_LEGACY_1(SBI_EXT_LEGACY_SET_TIMER, stime_value);
 #endif
 }
 
 static inline void sbi_shutdown(void)
 {
-	SBI_CALL_0(SBI_SHUTDOWN);
+	SBI_CALL_LEGACY_0(SBI_EXT_LEGACY_SHUTDOWN);
 }
 
 static inline void sbi_clear_ipi(void)
 {
-	SBI_CALL_0(SBI_CLEAR_IPI);
+	SBI_CALL_LEGACY_0(SBI_EXT_LEGACY_CLEAR_IPI);
 }
 
 static inline void sbi_send_ipi(const unsigned long *hart_mask)
 {
-	SBI_CALL_1(SBI_SEND_IPI, hart_mask);
+	SBI_CALL_LEGACY_1(SBI_EXT_LEGACY_SEND_IPI, hart_mask);
 }
 
 static inline void sbi_remote_fence_i(const unsigned long *hart_mask)
 {
-	SBI_CALL_1(SBI_REMOTE_FENCE_I, hart_mask);
+	SBI_CALL_LEGACY_1(SBI_EXT_LEGACY_REMOTE_FENCE_I, hart_mask);
 }
 
 static inline void sbi_remote_sfence_vma(const unsigned long *hart_mask,
 					 unsigned long start,
 					 unsigned long size)
 {
-	SBI_CALL_3(SBI_REMOTE_SFENCE_VMA, hart_mask, start, size);
+	SBI_CALL_LEGACY_3(SBI_EXT_LEGACY_REMOTE_SFENCE_VMA, hart_mask,
+			  start, size);
 }
 
 static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
@@ -91,7 +95,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 					      unsigned long size,
 					      unsigned long asid)
 {
-	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
+	SBI_CALL_LEGACY_4(SBI_EXT_LEGACY_REMOTE_SFENCE_VMA_ASID, hart_mask,
+			  start, size, asid);
 }
 
 #endif
-- 
2.21.0

