Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D362FC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A060820665
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 15:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XPmKEJA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfFIPkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 11:40:18 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:44112 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbfFIPkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 11:40:18 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x59Fdj4j004189;
        Mon, 10 Jun 2019 00:39:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x59Fdj4j004189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560094785;
        bh=QRU//lhSODxOzUbblXINj/fJfjp7ttS/yZ3jFWUK/iQ=;
        h=From:To:Cc:Subject:Date:From;
        b=XPmKEJA4Vyq6WiDIX2dHX9hWuMnEmtDqiunkVloZ+UIhC8Y3VaaP0nJsqIIMka6aW
         OSL7iPqdWuQFF3tJE19uhKveM6qqduw52LpfOATgeXOiexTc2ErOtZRAJeDVbvun+1
         uGMvaR0Hqx2i9hzpuX3gv5EWEVhAIZZGoGsrQAl2Ra0lmlwpjLCHFw2PBfBCccwMyF
         iLOtASe0tKYrxgPVVOLan7JfBoD+RMTs6QaZ/umSRifGwJ+HTBDEz9uMSeKogOyZRV
         xdhEKwsLpco1/aKr9nFTjHEwlgBuIqKC32Y67KDtcbH8JYdixSqPYhhF3JrlfHgEII
         fTnLa7PA+1vPA==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] linux/bits.h: make BIT(), GENMASK(), and friends available in assembly
Date:   Mon, 10 Jun 2019 00:39:40 +0900
Message-Id: <20190609153941.17249-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
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
  Since _BITUL() uses UL(1) instead of 1UL, it can be used as an
  alternative of BIT().

For [2], it is pretty easy to change BIT() etc. for use in assembly.

This allows to replace _BUTUL() in kernel-space headers with BIT().

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

