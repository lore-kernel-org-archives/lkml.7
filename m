Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81678C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5899E2465C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077240;
	bh=onphT6hWMhVqKOAGzifvr2680zpCjO97OmfasZTzAAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ME4JA1x8Ptcgy7G0TzNX+AAbBWKnKsAt/LO14cyaEFennafzXbTA8+Ur1asUbQODC
	 3k3plQtyqSIE184TRCSSY/N9H4+WHkwi1WiI3eOdfiZCrr8/AcxkRerfcPljaSyeu5
	 Flhy5PDGdmVlZKNGRPH9X+rgscP7sWA2dugQ1Vjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfLKPN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:13:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730946AbfLKPN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:13:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70C2A24654;
        Wed, 11 Dec 2019 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077206;
        bh=onphT6hWMhVqKOAGzifvr2680zpCjO97OmfasZTzAAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZpLrs4WPYFTgNcdc+bcUBnPmyYsUSH4KYWuOmuLkSxFkwJeC0ekqvIjqUEjx4Ak9u
         W6jxLWUOGvJn6UI3NH9zLiogXGBZ9llq58R3/EvrAiIdaR0nzvh8Oupot4jvF0C+Gf
         wNk1m7V/vtBSa0gs+Y8bPH61L5WJn5hBNyBE4hcE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 088/134] powerpc/fixmap: Use __fix_to_virt() instead of fix_to_virt()
Date:   Wed, 11 Dec 2019 10:11:04 -0500
Message-Id: <20191211151150.19073-88-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 77693a5fb57be4606a6024ec8e3076f9499b906b ]

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
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/f4984c615f90caa3277775a68849afeea846850d.1568295907.git.christophe.leroy@c-s.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/fixmap.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 0cfc365d814ba..722289a1d000e 100644
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
2.20.1

