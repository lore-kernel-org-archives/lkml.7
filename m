Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CCEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C540C21734
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="M6SAS/b8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfE0IfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:35:20 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:51185 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfE0IfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:35:19 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x4R8Yoq5030794;
        Mon, 27 May 2019 17:34:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x4R8Yoq5030794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558946092;
        bh=dq9Xozr64FzGVJ+aw2LL+eX9eu8zuBNETqzyhb/EVhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6SAS/b8mE3OxMR28tPr3uw2XKcJx7epVWglKLCGQV0VSwDlgDRSUIDMBkIrwzoMY
         feRhow4SiPG8eA4DViP6qEZ/GpGOYaz8Lm8XbP6e0kALHqzW1WMC5eXpVREMXwTtCs
         5fv65DAg3t5ETuJTxLT6bKLwbbZQHbSiS8YuK39fFXL2Jkwl8Rc+R7Igp/82ByyGzz
         ijp1qJqLfQbFePMjlB9Z2vwKcbSe2DjGxpUku1HEvr61MLCU9ZA847Pz9ufRM01/il
         JBrTprEN8hnLGRo8/cUTLWTsjN9r7JY9GYqkBPch7+VuOwP/8OVYiYnWnIF8F3pZN3
         xXFOHyaiEE+EA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] arm64: replace _BITUL() with BIT()
Date:   Mon, 27 May 2019 17:34:12 +0900
Message-Id: <20190527083412.26651-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527083412.26651-1-yamada.masahiro@socionext.com>
References: <20190527083412.26651-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that BIT() can be used from assembly code, replace _BITUL() with
equivalent BIT().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/include/asm/sysreg.h | 82 ++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 902d75b60914..3bcd8294acc0 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -20,7 +20,7 @@
 #ifndef __ASM_SYSREG_H
 #define __ASM_SYSREG_H
 
-#include <linux/const.h>
+#include <linux/bits.h>
 #include <linux/stringify.h>
 
 /*
@@ -458,31 +458,31 @@
 #define SYS_ZCR_EL12			sys_reg(3, 5, 1, 2, 0)
 
 /* Common SCTLR_ELx flags. */
-#define SCTLR_ELx_DSSBS	(_BITUL(44))
-#define SCTLR_ELx_ENIA	(_BITUL(31))
-#define SCTLR_ELx_ENIB	(_BITUL(30))
-#define SCTLR_ELx_ENDA	(_BITUL(27))
-#define SCTLR_ELx_EE    (_BITUL(25))
-#define SCTLR_ELx_IESB	(_BITUL(21))
-#define SCTLR_ELx_WXN	(_BITUL(19))
-#define SCTLR_ELx_ENDB	(_BITUL(13))
-#define SCTLR_ELx_I	(_BITUL(12))
-#define SCTLR_ELx_SA	(_BITUL(3))
-#define SCTLR_ELx_C	(_BITUL(2))
-#define SCTLR_ELx_A	(_BITUL(1))
-#define SCTLR_ELx_M	(_BITUL(0))
+#define SCTLR_ELx_DSSBS	(BIT(44))
+#define SCTLR_ELx_ENIA	(BIT(31))
+#define SCTLR_ELx_ENIB	(BIT(30))
+#define SCTLR_ELx_ENDA	(BIT(27))
+#define SCTLR_ELx_EE    (BIT(25))
+#define SCTLR_ELx_IESB	(BIT(21))
+#define SCTLR_ELx_WXN	(BIT(19))
+#define SCTLR_ELx_ENDB	(BIT(13))
+#define SCTLR_ELx_I	(BIT(12))
+#define SCTLR_ELx_SA	(BIT(3))
+#define SCTLR_ELx_C	(BIT(2))
+#define SCTLR_ELx_A	(BIT(1))
+#define SCTLR_ELx_M	(BIT(0))
 
 #define SCTLR_ELx_FLAGS	(SCTLR_ELx_M  | SCTLR_ELx_A | SCTLR_ELx_C | \
 			 SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB)
 
 /* SCTLR_EL2 specific flags. */
-#define SCTLR_EL2_RES1	((_BITUL(4))  | (_BITUL(5))  | (_BITUL(11)) | (_BITUL(16)) | \
-			 (_BITUL(18)) | (_BITUL(22)) | (_BITUL(23)) | (_BITUL(28)) | \
-			 (_BITUL(29)))
-#define SCTLR_EL2_RES0	((_BITUL(6))  | (_BITUL(7))  | (_BITUL(8))  | (_BITUL(9))  | \
-			 (_BITUL(10)) | (_BITUL(13)) | (_BITUL(14)) | (_BITUL(15)) | \
-			 (_BITUL(17)) | (_BITUL(20)) | (_BITUL(24)) | (_BITUL(26)) | \
-			 (_BITUL(27)) | (_BITUL(30)) | (_BITUL(31)) | \
+#define SCTLR_EL2_RES1	((BIT(4))  | (BIT(5))  | (BIT(11)) | (BIT(16)) | \
+			 (BIT(18)) | (BIT(22)) | (BIT(23)) | (BIT(28)) | \
+			 (BIT(29)))
+#define SCTLR_EL2_RES0	((BIT(6))  | (BIT(7))  | (BIT(8))  | (BIT(9))  | \
+			 (BIT(10)) | (BIT(13)) | (BIT(14)) | (BIT(15)) | \
+			 (BIT(17)) | (BIT(20)) | (BIT(24)) | (BIT(26)) | \
+			 (BIT(27)) | (BIT(30)) | (BIT(31)) | \
 			 (0xffffefffUL << 32))
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
@@ -504,23 +504,23 @@
 #endif
 
 /* SCTLR_EL1 specific flags. */
-#define SCTLR_EL1_UCI		(_BITUL(26))
-#define SCTLR_EL1_E0E		(_BITUL(24))
-#define SCTLR_EL1_SPAN		(_BITUL(23))
-#define SCTLR_EL1_NTWE		(_BITUL(18))
-#define SCTLR_EL1_NTWI		(_BITUL(16))
-#define SCTLR_EL1_UCT		(_BITUL(15))
-#define SCTLR_EL1_DZE		(_BITUL(14))
-#define SCTLR_EL1_UMA		(_BITUL(9))
-#define SCTLR_EL1_SED		(_BITUL(8))
-#define SCTLR_EL1_ITD		(_BITUL(7))
-#define SCTLR_EL1_CP15BEN	(_BITUL(5))
-#define SCTLR_EL1_SA0		(_BITUL(4))
-
-#define SCTLR_EL1_RES1	((_BITUL(11)) | (_BITUL(20)) | (_BITUL(22)) | (_BITUL(28)) | \
-			 (_BITUL(29)))
-#define SCTLR_EL1_RES0  ((_BITUL(6))  | (_BITUL(10)) | (_BITUL(13)) | (_BITUL(17)) | \
-			 (_BITUL(27)) | (_BITUL(30)) | (_BITUL(31)) | \
+#define SCTLR_EL1_UCI		(BIT(26))
+#define SCTLR_EL1_E0E		(BIT(24))
+#define SCTLR_EL1_SPAN		(BIT(23))
+#define SCTLR_EL1_NTWE		(BIT(18))
+#define SCTLR_EL1_NTWI		(BIT(16))
+#define SCTLR_EL1_UCT		(BIT(15))
+#define SCTLR_EL1_DZE		(BIT(14))
+#define SCTLR_EL1_UMA		(BIT(9))
+#define SCTLR_EL1_SED		(BIT(8))
+#define SCTLR_EL1_ITD		(BIT(7))
+#define SCTLR_EL1_CP15BEN	(BIT(5))
+#define SCTLR_EL1_SA0		(BIT(4))
+
+#define SCTLR_EL1_RES1	((BIT(11)) | (BIT(20)) | (BIT(22)) | (BIT(28)) | \
+			 (BIT(29)))
+#define SCTLR_EL1_RES0  ((BIT(6))  | (BIT(10)) | (BIT(13)) | (BIT(17)) | \
+			 (BIT(27)) | (BIT(30)) | (BIT(31)) | \
 			 (0xffffefffUL << 32))
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
@@ -735,13 +735,13 @@
 #define ZCR_ELx_LEN_SIZE	9
 #define ZCR_ELx_LEN_MASK	0x1ff
 
-#define CPACR_EL1_ZEN_EL1EN	(_BITUL(16)) /* enable EL1 access */
-#define CPACR_EL1_ZEN_EL0EN	(_BITUL(17)) /* enable EL0 access, if EL1EN set */
+#define CPACR_EL1_ZEN_EL1EN	(BIT(16)) /* enable EL1 access */
+#define CPACR_EL1_ZEN_EL0EN	(BIT(17)) /* enable EL0 access, if EL1EN set */
 #define CPACR_EL1_ZEN		(CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN)
 
 
 /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
-#define SYS_MPIDR_SAFE_VAL	(_BITUL(31))
+#define SYS_MPIDR_SAFE_VAL	(BIT(31))
 
 #ifdef __ASSEMBLY__
 
-- 
2.17.1

