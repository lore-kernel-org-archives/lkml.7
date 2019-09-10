Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C93C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916F821019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393172AbfIJL5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:57:10 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48971 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732932AbfIJL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:57:08 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M2xjg-1i8k9h33wC-003NW5; Tue, 10 Sep 2019 13:56:45 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] [v2] arm64: fix unreachable code issue with cmpxchg
Date:   Tue, 10 Sep 2019 13:56:22 +0200
Message-Id: <20190910115643.391995-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EHTSpuLoMolBSz8CcDfb/qHKuFLM8p+7X9tC8Slqv2t0NwgBE8C
 CEK+aT1cF8p9GCYOMXQ9HwXnX5NR3vF73638cRLoJsKIRu4XOBbcOp7sn4PNSRR5Jbt0Sry
 d6um31l43yl6egOIpt1DYB9KLWb+JQkE3FcXmpjvrBxGY9yI6dKjHFJ35D2Ao3CsqwFFPRU
 kW57LeoduR53gqRvt9G4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tZ2pxyEDoFE=:FjiMNmyAJhF+Kct/9J4gj6
 WlnXVAVAC8Cxf0IYDscFNtsWlONzdMJXCr0JwZPzKZe6H2kyJ+9zA6HZFLjNI6X8TGtTkx1ZU
 YeaJHl2QR/C+yOjV5mni9COAFLkrzR9B7FOn2i+MEUH3TSPUt1pRfhhr/JI6u/vxjpCCIXE56
 lNNhX2f3/fJAYKLEbZEVxiRggi9Ae3gY4942USVK6PBNwClhC4wz7fiy4rmgHW5cFUcxop+oW
 bhsTxXPMd3ZNAjh+m6UWJBBZlkWFR9iScOGuXMPlP9jiMWveayxKFHQzPHzdwVD0hBYv3H0Uy
 FAV/roihgc1V0OUDl0qwBKuk9y4inwLCLHCYShGOiiJQ/BzEHzoR8Uzn76IZ4vaBXyvsguiAQ
 GKMMqeoH7+xtXsCDhFTxAewinskUBlX1II/D54y5mi4S1S7Cb+s49Vy3pPwPZaCQ0FGUxBcLL
 bm8u22xwBXQZMAHtIBrJGBOKZEBIeoKBzNZo7YLv8DI6q+Uh2qNAWIcZF60YxOoYrkSQ2SlsX
 EjN3vfJjiwr+RAvsJGgW0Updu1M0NHsFManaC9mkCRbY0k36V7Bi7YkrQEzUEPjkBMVXH7l4D
 eaUUPAu6qsGCrrVdU9IB/Autez1PeKBWm66DURBJl+gtrTiw9RrEbLT0xkiXlBXlOs05c1YsI
 uxOL6R7TgViEhaboreZmuwhnng1zszG6BEXPJNLZ/bynHBAJHtf8NvDNWlzmHJC9IeTSTpQtG
 QLsB2fv3oQcctBcfg0wLRYs1XNLJoirOb5z3fOldnxwVHphjv344tb3G7pOKU9SH+f/JD0ZkR
 H1QVp8iXmykxUFgO3di1hBiinYpWgQvVDHWXAEBGF9wZY5SgfU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 build with clang, sometimes the __cmpxchg_mb is not inlined
when CONFIG_OPTIMIZE_INLINING is set.
Clang then fails a compile-time assertion, because it cannot tell at
compile time what the size of the argument is:

mm/memcontrol.o: In function `__cmpxchg_mb':
memcontrol.c:(.text+0x1a4c): undefined reference to `__compiletime_assert_175'
memcontrol.c:(.text+0x1a4c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__compiletime_assert_175'

Mark all of the cmpxchg() style functions as __always_inline to
ensure that the compiler can see the result.

Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/648
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Tested-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: skip unneeded changes, as suggested by Andrew Murray
---
 arch/arm64/include/asm/cmpxchg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index a1398f2f9994..f9bef42c1411 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -62,7 +62,7 @@ __XCHG_CASE( ,  ,  mb_, 64, dmb ish, nop,  , a, l, "memory")
 #undef __XCHG_CASE
 
 #define __XCHG_GEN(sfx)							\
-static inline unsigned long __xchg##sfx(unsigned long x,		\
+static __always_inline  unsigned long __xchg##sfx(unsigned long x,	\
 					volatile void *ptr,		\
 					int size)			\
 {									\
@@ -148,7 +148,7 @@ __CMPXCHG_DBL(_mb)
 #undef __CMPXCHG_DBL
 
 #define __CMPXCHG_GEN(sfx)						\
-static inline unsigned long __cmpxchg##sfx(volatile void *ptr,		\
+static __always_inline unsigned long __cmpxchg##sfx(volatile void *ptr,	\
 					   unsigned long old,		\
 					   unsigned long new,		\
 					   int size)			\
@@ -255,7 +255,7 @@ __CMPWAIT_CASE( ,  , 64);
 #undef __CMPWAIT_CASE
 
 #define __CMPWAIT_GEN(sfx)						\
-static inline void __cmpwait##sfx(volatile void *ptr,			\
+static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
 				  unsigned long val,			\
 				  int size)				\
 {									\
-- 
2.20.0

