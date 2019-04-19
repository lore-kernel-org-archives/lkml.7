Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42351C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0277120652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="B0BQlA/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfDSSZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:25:52 -0400
Received: from condef-07.nifty.com ([202.248.20.72]:40749 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfDSSZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:25:51 -0400
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-07.nifty.com with ESMTP id x3J9nRw7028234;
        Fri, 19 Apr 2019 18:49:27 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x3J9mDiV012304;
        Fri, 19 Apr 2019 18:48:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x3J9mDiV012304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555667309;
        bh=sNr4ub5sQxS+0LMMMb+j8VzxalFAFd/JYoE5EUyoP38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0BQlA/PTYdRhr/cnabblYMwAYhKD6J8OBAnfSjQcaEkjG6yjSsJYkeL42KRC579r
         PNg66kXGfTKg1PT7Mcezea0Le+TIG2L3R4/go1gHcEczBgXpsHfXnTklxKr73FcJpB
         pgKBhSPoXPMW7FmxAXFP1oXRnpOJMTmVFfi2T1b21yJJ50Dxj8uphUr9arAF2VZ5Gt
         iFyTtCd7tSUQLuAgFMsInuQd7Zi7f4y+HfXk6okijLRI07aBA/2tsWZxCbHUU5cMYd
         OpHcQiZWhdNji5KDIWUGz0avKi8LtEztXO2FBxeNaT2m5466QUP8yjbxpOEGypVmOj
         xzYLsSTkB+gRA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 10/11] powerpc/mm/radix: mark as __tlbie_pid() and friends as__always_inline
Date:   Fri, 19 Apr 2019 18:47:53 +0900
Message-Id: <20190419094754.24667-11-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190419094754.24667-1-yamada.masahiro@socionext.com>
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for powerpc, the following errors are reported:

arch/powerpc/mm/tlb-radix.c: In function '__tlbie_lpid':
arch/powerpc/mm/tlb-radix.c:148:2: warning: asm operand 3 probably doesn't match constraints
  asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
  ^~~
arch/powerpc/mm/tlb-radix.c:148:2: error: impossible constraint in 'asm'
arch/powerpc/mm/tlb-radix.c: In function '__tlbie_pid':
arch/powerpc/mm/tlb-radix.c:118:2: warning: asm operand 3 probably doesn't match constraints
  asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
  ^~~
arch/powerpc/mm/tlb-radix.c: In function '__tlbiel_pid':
arch/powerpc/mm/tlb-radix.c:104:2: warning: asm operand 3 probably doesn't match constraints
  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
  ^~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - new patch

 arch/powerpc/mm/tlb-radix.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index a2b2848f0ae3..14ff414d1545 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -90,8 +90,8 @@ void radix__tlbiel_all(unsigned int action)
 	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
 }
 
-static inline void __tlbiel_pid(unsigned long pid, int set,
-				unsigned long ric)
+static __always_inline void __tlbiel_pid(unsigned long pid, int set,
+					 unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -106,7 +106,7 @@ static inline void __tlbiel_pid(unsigned long pid, int set,
 	trace_tlbie(0, 1, rb, rs, ric, prs, r);
 }
 
-static inline void __tlbie_pid(unsigned long pid, unsigned long ric)
+static __always_inline void __tlbie_pid(unsigned long pid, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -136,7 +136,7 @@ static inline void __tlbiel_lpid(unsigned long lpid, int set,
 	trace_tlbie(lpid, 1, rb, rs, ric, prs, r);
 }
 
-static inline void __tlbie_lpid(unsigned long lpid, unsigned long ric)
+static __always_inline void __tlbie_lpid(unsigned long lpid, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -239,7 +239,7 @@ static inline void fixup_tlbie_lpid(unsigned long lpid)
 /*
  * We use 128 set in radix mode and 256 set in hpt mode.
  */
-static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
+static __always_inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 {
 	int set;
 
-- 
2.17.1

