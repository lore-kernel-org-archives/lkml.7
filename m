Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3A2C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FDB2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KC5a03Bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfE0IfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:35:18 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:51186 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfE0IfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:35:18 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x4R8Yoq4030794;
        Mon, 27 May 2019 17:34:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x4R8Yoq4030794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558946092;
        bh=45A2T5W61qPsoviArJh2p+JJaGRj8IKGUEzep9QlvkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KC5a03BcFatHw2Ht8RdXo/6qQt02T3aH5CE8kRYJwu2x5MtspNHSoYPGqUSN3LfIM
         2o124MeKsXE0Yw8kRRuf9LdRDpYRoToFVQFcSpC8g+3PPMRCCTQW1fLvTp0ljFAuSC
         USO7/CDaX482PYpPuDEILX8MnBkTCG/dzGeufIpH14CwdL4Vr9YrRFpIJ/M6PXL0QJ
         K5kI+VoPmxIQ4gHSbvigY4d1HguDFSt2KDI7c1IKX0n2SqMPqZM/tea3VVEPiwoqsa
         jN6cJxu+RBrg++NBcP+/HBH+gWq1lnmAz0i0mORROwbCbBH9mRq7tnjo9uC0Bw0QEE
         Bcz8Lnlv0mv9Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] linux/bits.h: make BIT(), GENMASK(), and friends available in assembly
Date:   Mon, 27 May 2019 17:34:11 +0900
Message-Id: <20190527083412.26651-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527083412.26651-1-yamada.masahiro@socionext.com>
References: <20190527083412.26651-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIT(), GENMASK(), etc. are useful to define register bits of hardware.
However, low-level code is often written in assembly, where they are
not available due to the hard-coded 1UL, 0UL.

In fact, in-kernel headers such as arch/arm64/include/asm/sysreg.h
use _BITUL() instead of BIT() so that the register bit macros are
available in assembly.

Using macros in include/uapi/linux/const.h have two reasons:

[1] For use in uapi headers
  We should use underscore-prefixed variants for user-space.

[2] For use in assembly code
  Since _BITUL() does not use hard-coded 1UL, it can be used as an
  alternative of BIT().

For [2], it is pretty easy to change BIT() etc. for use in assembly.

This allows to replace _BUTUL() in kernel headers with BIT().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/bits.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 2b7b532c1d51..669d69441a62 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -1,13 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_BITS_H
 #define __LINUX_BITS_H
+
+#include <linux/const.h>
 #include <asm/bitsperlong.h>
 
-#define BIT(nr)			(1UL << (nr))
-#define BIT_ULL(nr)		(1ULL << (nr))
-#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
+#define BIT(nr)			(UL(1) << (nr))
+#define BIT_ULL(nr)		(ULL(1) << (nr))
+#define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
-#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
+#define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
 
@@ -17,10 +19,11 @@
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
 #define GENMASK(h, l) \
-	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+	(((~UL(0)) - (UL(1) << (l)) + 1) & \
+	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
 
 #define GENMASK_ULL(h, l) \
-	(((~0ULL) - (1ULL << (l)) + 1) & \
-	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
+	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
 
 #endif	/* __LINUX_BITS_H */
-- 
2.17.1

