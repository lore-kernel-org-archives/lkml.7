Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839A4C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AD021783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="26jD8eFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfJBKab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 06:30:31 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:22674 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJBKab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:30:31 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x92ASDI8018024;
        Wed, 2 Oct 2019 19:28:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x92ASDI8018024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570012094;
        bh=mVsEFaGyKR+ONE3aTVtqJGvbA8/KiDyvvo+GI9JBcGU=;
        h=From:To:Cc:Subject:Date:From;
        b=26jD8eFPEWohdp5e0ArWJ5UyL9t2+NssfYmsqRKM5SICqFL04xpXRhBoQK7F4PTLF
         pTYTaYrlo4ndLWXRAm+AoHkWnYfXE0gxZDC4+zhapqFXbBfQQB3A31s1qJ/gZa7BLD
         wVW5h27fvLa+x+0NatKW7p7OEm2XjEEWpcB2tFSSDFCyN8ECWoV9wPmlTuvkp2CCu7
         rsShxES/GON/v5L91naShlOHQ8NN7Ptxpt1CdDptTIlEfJQ/WYfPqe7b0j9OqcB1li
         sRAg3wreRPsvirRGD+iOR+bAQcaB6rsegwmRBFrYQMtbYF/5EPA7CHqr7u/rOafrA6
         O27F2o0bu/UpQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     patches@arm.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Enrico Weigelt <info@metux.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Agner <stefan@agner.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH] ARM: add __always_inline to functions called from __get_user_check()
Date:   Wed,  2 Oct 2019 19:28:02 +0900
Message-Id: <20191002102802.29691-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KernelCI reports that bcm2835_defconfig is no longer booting since
commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly") (https://lkml.org/lkml/2019/9/26/825).

I also received a regression report from Nicolas Saenz Julienne
(https://lkml.org/lkml/2019/9/27/263).

This problem has cropped up on bcm2835_defconfig because it enables
CONFIG_CC_OPTIMIZE_FOR_SIZE. The compiler tends to prefer not inlining
functions with -Os. I was able to reproduce it with other boards and
defconfig files by manually enabling CONFIG_CC_OPTIMIZE_FOR_SIZE.

The __get_user_check() specifically uses r0, r1, r2 registers.
So, uaccess_save_and_enable() and uaccess_restore() must be inlined.
Otherwise, those register assignments would be entirely dropped,
according to my analysis of the disassembly.

Prior to commit 9012d011660e ("compiler: allow all arches to enable
CONFIG_OPTIMIZE_INLINING"), the 'inline' marker was always enough for
inlining functions, except on x86.

Since that commit, all architectures can enable CONFIG_OPTIMIZE_INLINING.
So, __always_inline is now the only guaranteed way of forcible inlining.

I added __always_inline to 4 functions in the call-graph from the
__get_user_check() macro.

Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

KernelVersion: v5.4-rc1

 arch/arm/include/asm/domain.h  | 8 ++++----
 arch/arm/include/asm/uaccess.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 567dbede4785..f1d0a7807cd0 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -82,7 +82,7 @@
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_CPU_CP15_MMU
-static inline unsigned int get_domain(void)
+static __always_inline unsigned int get_domain(void)
 {
 	unsigned int domain;
 
@@ -94,7 +94,7 @@ static inline unsigned int get_domain(void)
 	return domain;
 }
 
-static inline void set_domain(unsigned val)
+static __always_inline void set_domain(unsigned int val)
 {
 	asm volatile(
 	"mcr	p15, 0, %0, c3, c0	@ set domain"
@@ -102,12 +102,12 @@ static inline void set_domain(unsigned val)
 	isb();
 }
 #else
-static inline unsigned int get_domain(void)
+static __always_inline unsigned int get_domain(void)
 {
 	return 0;
 }
 
-static inline void set_domain(unsigned val)
+static __always_inline void set_domain(unsigned int val)
 {
 }
 #endif
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 303248e5b990..98c6b91be4a8 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -22,7 +22,7 @@
  * perform such accesses (eg, via list poison values) which could then
  * be exploited for priviledge escalation.
  */
-static inline unsigned int uaccess_save_and_enable(void)
+static __always_inline unsigned int uaccess_save_and_enable(void)
 {
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	unsigned int old_domain = get_domain();
@@ -37,7 +37,7 @@ static inline unsigned int uaccess_save_and_enable(void)
 #endif
 }
 
-static inline void uaccess_restore(unsigned int flags)
+static __always_inline void uaccess_restore(unsigned int flags)
 {
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	/* Restore the user access mask */
-- 
2.17.1

