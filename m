Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B2EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DEC2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="utdjWpxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfECMiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 08:38:21 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:35957 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfECMiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:38:21 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x43CbuW9020722;
        Fri, 3 May 2019 21:37:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x43CbuW9020722
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556887077;
        bh=N7oCkXQfepu6l+UAHVtt5vfxPNB5K7tbRYmyelOMNYM=;
        h=From:To:Cc:Subject:Date:From;
        b=utdjWpxmGnVSZlPDbdmUSctuhbvdk/+xastR2qAA9SFYQC9pF8dDKTe07nQv3bnSK
         n1IsL8kt+BBPcpKV/aAJcexyRpu0CLMhflaktEF8LVR2EvMfCV5VwBPILgeeNlOpPB
         FoAtf3f1tLGfqy1tjdIohPQfR6JbVfEENM6gAUrmEBCwvP0dbte8eJGU+BfTIcCuzz
         397zHtom+oyAWBXgbje71WSOWgaEm9YDrt/wQU9eShTtElu32YlQ1BvkXDd+98ik0f
         gnBEede0sb/LLcyjg6eMdWYMh0IgHCv+GYNZjq/vS0LKZBRUG1mXHPeJ9bSxKA7mV6
         b6qQX/b1d8ERA==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     x86@kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] x86,sh: use __builtin_constant_p() directly instead of IS_IMMEDIATE()
Date:   Fri,  3 May 2019 21:37:44 +0900
Message-Id: <1556887064-12882-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__builtin_constant_p(nr) is used everywhere now. It does not make
much sense to define IS_IMMEDIATE() as its alias.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sh/include/asm/bitops-op32.h | 8 +++-----
 arch/x86/include/asm/bitops.h     | 7 +++----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/sh/include/asm/bitops-op32.h b/arch/sh/include/asm/bitops-op32.h
index 4668803..cfe5465 100644
--- a/arch/sh/include/asm/bitops-op32.h
+++ b/arch/sh/include/asm/bitops-op32.h
@@ -16,11 +16,9 @@
 #define BYTE_OFFSET(nr)		((nr) % BITS_PER_BYTE)
 #endif
 
-#define IS_IMMEDIATE(nr)	(__builtin_constant_p(nr))
-
 static inline void __set_bit(int nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr)) {
+	if (__builtin_constant_p(nr)) {
 		__asm__ __volatile__ (
 			"bset.b %1, @(%O2,%0)		! __set_bit\n\t"
 			: "+r" (addr)
@@ -37,7 +35,7 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
 
 static inline void __clear_bit(int nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr)) {
+	if (__builtin_constant_p(nr)) {
 		__asm__ __volatile__ (
 			"bclr.b %1, @(%O2,%0)		! __clear_bit\n\t"
 			: "+r" (addr)
@@ -64,7 +62,7 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
  */
 static inline void __change_bit(int nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr)) {
+	if (__builtin_constant_p(nr)) {
 		__asm__ __volatile__ (
 			"bxor.b %1, @(%O2,%0)		! __change_bit\n\t"
 			: "+r" (addr)
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 8e790ec..2621438 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -45,7 +45,6 @@
  * We do the locked ops that don't return the old value as
  * a mask operation on a byte.
  */
-#define IS_IMMEDIATE(nr)		(__builtin_constant_p(nr))
 #define CONST_MASK_ADDR(nr, addr)	WBYTE_ADDR((void *)(addr) + ((nr)>>3))
 #define CONST_MASK(nr)			(1 << ((nr) & 7))
 
@@ -67,7 +66,7 @@
 static __always_inline void
 set_bit(long nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr)) {
+	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "orb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" ((u8)CONST_MASK(nr))
@@ -105,7 +104,7 @@ static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
 static __always_inline void
 clear_bit(long nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr)) {
+	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "andb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" ((u8)~CONST_MASK(nr)));
@@ -186,7 +185,7 @@ static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
  */
 static __always_inline void change_bit(long nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr)) {
+	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "xorb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" ((u8)CONST_MASK(nr)));
-- 
2.7.4

