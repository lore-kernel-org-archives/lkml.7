Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C52C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70092075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="gTfQ67k1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbfILNtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:49:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51845 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731420AbfILNto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:49:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Tg9x2GMQz9tyn6;
        Thu, 12 Sep 2019 15:49:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=gTfQ67k1; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id S3aS4dXQEy-S; Thu, 12 Sep 2019 15:49:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Tg9x19tsz9tyn0;
        Thu, 12 Sep 2019 15:49:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568296181; bh=tIuj7A2g/wU/lfgUsNki9hmYUsxY/tQJgq5pQBOkNp4=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=gTfQ67k1tf2KkSnDykBo5FX6Li0ChIVjzDG+72kVlnhGaywvk70KYgV4g1zYVXtX3
         p5y7lqaPAYlQVhoo7fdOfj8B8MafL7Zci3rcugkwcvB0XL78Ln9v5bvs05MgRkhH/V
         JF1VBxY7YcG49WMAeglOIKpU434k0wKrIuii+s2g=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B11AE8B933;
        Thu, 12 Sep 2019 15:49:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xXQnglXC8Qh4; Thu, 12 Sep 2019 15:49:42 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D7228B93C;
        Thu, 12 Sep 2019 15:49:42 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4F0CC6B736; Thu, 12 Sep 2019 13:49:42 +0000 (UTC)
Message-Id: <f4984c615f90caa3277775a68849afeea846850d.1568295907.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1568295907.git.christophe.leroy@c-s.fr>
References: <cover.1568295907.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 2/4] powerpc/fixmap: Use __fix_to_virt() instead of
 fix_to_virt()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 12 Sep 2019 13:49:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify back __set_fixmap() to using __fix_to_virt() instead
of fix_to_virt() otherwise the following happens because it
seems GCC doesn't see idx as a builtin const.

  CC      mm/early_ioremap.o
In file included from ./include/linux/kernel.h:11:0,
                 from mm/early_ioremap.c:11:
In function ‘fix_to_virt’,
    inlined from ‘__set_fixmap’ at ./arch/powerpc/include/asm/fixmap.h:87:2,
    inlined from ‘__early_ioremap’ at mm/early_ioremap.c:156:4:
./include/linux/compiler.h:350:38: error: call to ‘__compiletime_assert_32’ declared with attribute error: BUILD_BUG_ON failed: idx >= __end_of_fixed_addresses
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
./include/linux/compiler.h:331:4: note: in definition of macro ‘__compiletime_assert’
    prefix ## suffix();    \
    ^
./include/linux/compiler.h:350:2: note: in expansion of macro ‘_compiletime_assert’
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^
./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^
./include/asm-generic/fixmap.h:32:2: note: in expansion of macro ‘BUILD_BUG_ON’
  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
  ^

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 4cfac2f9c7f1 ("powerpc/mm: Simplify __set_fixmap()")
---
 arch/powerpc/include/asm/fixmap.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 0cfc365d814b..722289a1d000 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -77,7 +77,12 @@ enum fixed_addresses {
 static inline void __set_fixmap(enum fixed_addresses idx,
 				phys_addr_t phys, pgprot_t flags)
 {
-	map_kernel_page(fix_to_virt(idx), phys, flags);
+	if (__builtin_constant_p(idx))
+		BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
+	else if (WARN_ON(idx >= __end_of_fixed_addresses))
+		return;
+
+	map_kernel_page(__fix_to_virt(idx), phys, flags);
 }
 
 #endif /* !__ASSEMBLY__ */
-- 
2.13.3

