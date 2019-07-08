Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D546C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27EA216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405015AbfGHUbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:31:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44861 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbfGHUbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:31:08 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MOAJt-1i8aQU1YWP-00OYvi; Mon, 08 Jul 2019 22:30:59 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] ARM: mtd-xip: work around clang/llvm bug
Date:   Mon,  8 Jul 2019 22:30:31 +0200
Message-Id: <20190708203049.3484750-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V7NNcdZbV6mw7tfdYJiUJWjfhAMjQ4ZOz+c5SMkPzy2jzCIxgH/
 pt3z+EXXXxY3LSweF/O5LBo2UxCpnX3kg0YItAVqxX3M9B2A5HrqQ81VPjg6+j1qPFmB85f
 ImodRn9ATMXuOL36cdfA72rGbINvDJVBi1P9wvZ162xPRURHIwauaITV/6GYiZlrruAZgD3
 yPClGNspWQsjkOU9QoV/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v+XvPb26ioU=:TjLKe2p2Vyy1aD8C0Nufwj
 FrZeID3M43k7HjEvkInllCLnR/9x6gufxWP8ADpgN0auCuIIjPIP2tu0X3ASOv/QXifZ6fjb4
 fKlZu6xDaoZtt8x67I8YacbTs4bBwepXTeep7F354PTBA34UGC8lZ+V1nE8sRbnncu3ob8/LP
 JR0tuXEqyWPyKcDtlpOHMZAMaZDwcg/kfr6xkzsUVYV75zOGIx8sq6NyqGQF3c1arsqTwrNcN
 hJhsQ7lnpgflhynJ5Bc549TYzbbcpmDJv2EPESCR8ZfGYOQGAR64bD1MNNDqeNGf32tFXzLi0
 +CkgAvnFKTjFeL8w8Gps4Rw4jiiWmhItlP2H/zFPsYwEBMV/uyZolwmW2WffgtqMKYreIRpoD
 wxA5LNyE+X+NdLbrzC7F/w5oKECDdDNa+wEsQMZS8O/NKs4gGpJ9Wl0QpYQ1z5zga8wlaFtHd
 ypJVr3q8cXSs7REZxwEZeSbfMZ6LXVm9uUQQcImXbb2yyrvpOdcgw8YpBgSshFJe0dW3AwA+L
 xIRheBgbluwdF4sFdEOy+IqW/QuHkind6qLv3FGlEGcHh/n5ErPd5rSn67lwA9/dQ3sew4ELj
 0IJABvVcc/M72PPepyFP1dkhf9bcvHnoPaE8lUm7HhlCHX+5g2CTjshcvagx/93ZVV/VZ+DFN
 YdDjg4aD2IE+NkZFigDlAijfbNlhkhrMyh45aKVjofJ8rIJiGPbgcDt1eVJiz39O5rlLq6RGW
 BhGY84gtjs1+dnjKiPjpNUMaPmILlrDBvvo1Gg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

llvm gets confused by inline asm with .rep directives, which
can lead to miscalculating the number of instructions inside it,
and in turn lead to an overflow for relative address calculation:

/tmp/cfi_cmdset_0002-539a47.s: Assembler messages:
/tmp/cfi_cmdset_0002-539a47.s:11288: Error: bad immediate value for offset (4100)
/tmp/cfi_cmdset_0002-539a47.s:11289: Error: bad immediate value for offset (4100)

This might be fixed in future clang versions, but is not hard
to work around by just replacing the .rep with a series of
eight unrolled nop instructions.

Link: https://bugs.llvm.org/show_bug.cgi?id=42539
https://godbolt.org/z/DSM2Jy
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/mtd-xip.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/mtd-xip.h b/arch/arm/include/asm/mtd-xip.h
index dfcef0152e3d..5ad0325604e4 100644
--- a/arch/arm/include/asm/mtd-xip.h
+++ b/arch/arm/include/asm/mtd-xip.h
@@ -15,6 +15,8 @@
 #include <mach/mtd-xip.h>
 
 /* fill instruction prefetch */
-#define xip_iprefetch() 	do { asm volatile (".rep 8; nop; .endr"); } while (0)
+#define xip_iprefetch()	do {						\
+	 asm volatile ("nop; nop; nop; nop; nop; nop; nop; nop;");	\
+} while (0)								\
 
 #endif /* __ARM_MTD_XIP_H__ */
-- 
2.20.0

