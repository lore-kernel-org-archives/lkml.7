Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF57C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FB221670
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbfIIUWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 16:22:07 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:54997 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbfIIUWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 16:22:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MtwIW-1iQ3WI0jXQ-00uGVx; Mon, 09 Sep 2019 22:21:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] arm64: fix unreachable code issue with cmpxchg
Date:   Mon,  9 Sep 2019 22:21:35 +0200
Message-Id: <20190909202153.144970-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6HbGcOwcgeWZk7saAnF44EQwGRc5qar4XnbwhsGQ9AeeGtgVJQ0
 jJnqy2N1qSE1vkSfHW+ITZ7JxZVOzcynaRgSnRdUR27uZBdiqKyQncb1oAb8ZmA2gUv7jjt
 9E5l4E7yQRz5TcvxGRo3Byc/2TanVmuFGegAxsPoUXDoqNQZvQci40d1brApPysfW7fOesk
 VdklBj8+v4Gsa+toV+uVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C1d7SlUsv+A=:Lj2/wQb1QrZDoyfBBvZrvm
 370fWlMX2geahYOibVfa+G1FGva5/fqlJYl7pkjy5dnYfjEbNUm/+ebrQMN41Q3qJwKd1dR6z
 T5nAheJ+Bemia9f4GTp5E9bIF9eAa1l/DZ0/hiSWcmpl/qlS8usEHW+fll9VTLZiqHz+K5rsH
 CVzTI1MUnIsseeoRFpmrkVxOY4Dg/I0T4gB2D7T55wdtiAZK5dZiiCFTT617FfryJyGsccUeJ
 galX2PFrtBenOyO9SHS0SFas5EM01nQKILKNxUuN1poDQ1DMjPrFTUZMu8u53UiYfJCDlpbqV
 Lt1K1uItp4HOfBi1N2GQeu0BwevjsxeMdl7/PJvSTy/ScRvhqeZlxl+g+ngoLtv4joHKsprp6
 L4ncVos7HATxanCI4uLoC/0AM0c/TL20KycRzkr+RV5/HJAVk7DIKmEBhsSnSQI07pLbvTm4i
 uxGCxUvLIsC/yU5IoULbklys2QD31uxuYBoehErQlLpIA/bKB49f42U4sTGrdcPUwf51X2VxS
 6Q4aiW2htlXlrNx3mmyQklCtGo1VX7ri28iXwcVmnIha0JUy/8FRU1mUTbLd2TQgmv1nPV5ad
 fqE8m3GuJeVauXjoIGNJ/+L4kMPqgaYvq/TImckjqaEaWkijR2TOPMPMC9rTBjZs3LBtis8TV
 obr9Oy1Ade2++k7MJKQUK3B90LC2/EZaiidkjrsicmaYQBmiCzsLKzJuDqcDONc3xy7+fMe4O
 5oSIifTYUg0VTTDWzObdc/TaeMd91zbiSNRFyfXCnCBXz/vQozBvvaPpcmC82YeojyaSB0AUF
 lGjKB9e0veJsRu1LPHIYcnlGukAoNUw4q5Eo7jmuJQ1f9oU2g0=
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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/cmpxchg.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index a1398f2f9994..fd64dc8a235f 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -19,7 +19,7 @@
  * acquire+release for the latter.
  */
 #define __XCHG_CASE(w, sfx, name, sz, mb, nop_lse, acq, acq_lse, rel, cl)	\
-static inline u##sz __xchg_case_##name##sz(u##sz x, volatile void *ptr)		\
+static __always_inline u##sz __xchg_case_##name##sz(u##sz x, volatile void *ptr)\
 {										\
 	u##sz ret;								\
 	unsigned long tmp;							\
@@ -62,7 +62,7 @@ __XCHG_CASE( ,  ,  mb_, 64, dmb ish, nop,  , a, l, "memory")
 #undef __XCHG_CASE
 
 #define __XCHG_GEN(sfx)							\
-static inline unsigned long __xchg##sfx(unsigned long x,		\
+static __always_inline  unsigned long __xchg##sfx(unsigned long x,	\
 					volatile void *ptr,		\
 					int size)			\
 {									\
@@ -103,8 +103,9 @@ __XCHG_GEN(_mb)
 #define arch_xchg_release(...)	__xchg_wrapper(_rel, __VA_ARGS__)
 #define arch_xchg(...)		__xchg_wrapper( _mb, __VA_ARGS__)
 
-#define __CMPXCHG_CASE(name, sz)			\
-static inline u##sz __cmpxchg_case_##name##sz(volatile void *ptr,	\
+#define __CMPXCHG_CASE(name, sz)					\
+static __always_inline u##sz 						\
+__cmpxchg_case_##name##sz(volatile void *ptr,				\
 					      u##sz old,		\
 					      u##sz new)		\
 {									\
@@ -148,7 +149,7 @@ __CMPXCHG_DBL(_mb)
 #undef __CMPXCHG_DBL
 
 #define __CMPXCHG_GEN(sfx)						\
-static inline unsigned long __cmpxchg##sfx(volatile void *ptr,		\
+static __always_inline unsigned long __cmpxchg##sfx(volatile void *ptr,	\
 					   unsigned long old,		\
 					   unsigned long new,		\
 					   int size)			\
@@ -230,7 +231,7 @@ __CMPXCHG_GEN(_mb)
 })
 
 #define __CMPWAIT_CASE(w, sfx, sz)					\
-static inline void __cmpwait_case_##sz(volatile void *ptr,		\
+static __always_inline void __cmpwait_case_##sz(volatile void *ptr,	\
 				       unsigned long val)		\
 {									\
 	unsigned long tmp;						\
@@ -255,7 +256,7 @@ __CMPWAIT_CASE( ,  , 64);
 #undef __CMPWAIT_CASE
 
 #define __CMPWAIT_GEN(sfx)						\
-static inline void __cmpwait##sfx(volatile void *ptr,			\
+static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
 				  unsigned long val,			\
 				  int size)				\
 {									\
-- 
2.20.0

