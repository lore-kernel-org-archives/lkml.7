Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25562C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E725420B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RQl+05KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfDWDWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:22:50 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:57703 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfDWDWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:22:46 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x3N3L8LD031384;
        Tue, 23 Apr 2019 12:21:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x3N3L8LD031384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555989671;
        bh=Uo1hU/pOzqv1Q6UwWPC8xpA1XS41uzJeh8wwHc0qw10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQl+05KOKoPFyxSI2FuyZ89MGQq0gLVxtR0GWFgEWNRsXcCy0ywyMCoApyQXmEl2n
         io077/9bKRr3TeYS3JcPQpAgG+CgbDwSbEuJjT7Lmm7Jw6tR92Yz0nQViiui/FvOYz
         OHEdmjKD4ngKPNZFO6+CjberrgaPoe16v9aVfe5TB6AkQWrH8BAv1i7oqy5w8xLaj2
         RzbqB8+k+ccjgH7NZYljMP+UkT7M08F+jN4dlBRwqq5ZGhZlN6W78e7n79Ti0CPVAz
         o9Klq/jAOFriEnk7sGfoNu3h+Jeytk82FTnBT3j7jCa2JpKnKNKSS7Hd5r/0KKb6Z/
         rdh6GlVxkt4pA==
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
        Mathieu Malaterre <malat@debian.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 02/10] MIPS: mark mult_sh_align_mod() as __always_inline
Date:   Tue, 23 Apr 2019 12:20:58 +0900
Message-Id: <20190423032106.11960-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423032106.11960-1-yamada.masahiro@socionext.com>
References: <20190423032106.11960-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for mips, the following error is reported:

arch/mips/kernel/cpu-bugs64.c: In function 'mult_sh_align_mod.constprop':
arch/mips/kernel/cpu-bugs64.c:33:2: error: asm operand 1 probably doesn't match constraints [-Werror]
  asm volatile(
  ^~~
arch/mips/kernel/cpu-bugs64.c:33:2: error: asm operand 1 probably doesn't match constraints [-Werror]
  asm volatile(
  ^~~
arch/mips/kernel/cpu-bugs64.c:33:2: error: impossible constraint in 'asm'
  asm volatile(
  ^~~
arch/mips/kernel/cpu-bugs64.c:33:2: error: impossible constraint in 'asm'
  asm volatile(
  ^~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - split into a separate patch

 arch/mips/kernel/cpu-bugs64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cpu-bugs64.c b/arch/mips/kernel/cpu-bugs64.c
index bada74af7641..c04b97aace4a 100644
--- a/arch/mips/kernel/cpu-bugs64.c
+++ b/arch/mips/kernel/cpu-bugs64.c
@@ -42,8 +42,8 @@ static inline void align_mod(const int align, const int mod)
 		: "n"(align), "n"(mod));
 }
 
-static inline void mult_sh_align_mod(long *v1, long *v2, long *w,
-				     const int align, const int mod)
+static __always_inline void mult_sh_align_mod(long *v1, long *v2, long *w,
+					      const int align, const int mod)
 {
 	unsigned long flags;
 	int m1, m2;
-- 
2.17.1

