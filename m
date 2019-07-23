Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDF4C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9B321BF6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FWn4FdN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbfGWHuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:50:18 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:26611 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfGWHuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:50:18 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x6N7nlBd002370;
        Tue, 23 Jul 2019 16:49:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x6N7nlBd002370
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563868187;
        bh=/ZG3CdOtI33rMeokPxToXGxnzYvk2W+J+Ed/VTmXJgQ=;
        h=From:To:Cc:Subject:Date:From;
        b=FWn4FdN8vgdvI+ITeXpzuYYA2oYpl78IRJ4p0xGrmx5Qs/sTQMfkrBwK+g1OjC2Sf
         HRxEAngWoNxEVkDDIsxSvSZC4g0017ceC3kVfjUmLKrAhsr5s1+OWPFfWoPZt8tGcD
         T7D+AQL0izjln7ltNs4GOyGKZv0z9aCpUemW6A6a0WjkvWXoW2eyzG5ibb+cTRJasv
         IQEv7j0VZEQCCfIWSFp41UkXu4PbMsDKgENy/+OM4Ciyta9aGddYVz0fweXDjQg1iZ
         unvnnhaSqRNLDISOPcKjSpsE/z6kLklewyyvPO/CqLsAbWJv4q1g0IBRxFaUJVQvUP
         Dl/sjG7prNuAQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sh: use __builtin_constant_p() directly instead of IS_IMMEDIATE()
Date:   Tue, 23 Jul 2019 16:49:43 +0900
Message-Id: <20190723074943.17093-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__builtin_constant_p(nr) is used everywhere now. It does not make
much sense to define IS_IMMEDIATE() as its alias.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sh/include/asm/bitops-op32.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/sh/include/asm/bitops-op32.h b/arch/sh/include/asm/bitops-op32.h
index 466880362ad1..cfe5465acce7 100644
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
-- 
2.17.1

