Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6730EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C9F2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710330;
	bh=MZB3QHZIQZ81aY5ro+0DEani9OJGE+4Jsl/jlOkcpLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CmBC8ngj5HK1UJPY8VUPXzJ/Tn3g2jGVpdi0gU1y0ZuUNuJ3NA6zEHHF0Xgr2Bt4+
	 KICT7vxdxeBvg0W37y1zKG9ycrujYlTOU1rAgnUhprzlw+VmvGO/T/7PY2FzaErVt/
	 nvjukcDRfhxf42XQaG7YMvzioMed27SrTV1Ik7r4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbfC0SMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389132AbfC0SME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:12:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1707A2177E;
        Wed, 27 Mar 2019 18:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710323;
        bh=MZB3QHZIQZ81aY5ro+0DEani9OJGE+4Jsl/jlOkcpLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DeciHy5i2uqzgryqTprHvZdD4jgJVb/wIsyCQeAiAswBpIw7Bk33E6PFIZdIpUJI3
         dCWSnFk+RdDT1wQVDoCHqVCXw8z+t1hlOGnJrwZfgyEJ+6uaadxtuL+tgsUgoW3wUq
         TMcn0Jaupdi5vGhJ/pneCS4RM25sqsxs+Zp8Qt1M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 055/192] powerpc/xmon: Fix opcode being uninitialized in print_insn_powerpc
Date:   Wed, 27 Mar 2019 14:08:07 -0400
Message-Id: <20190327181025.13507-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit e7140639b1de65bba435a6bd772d134901141f86 ]

When building with -Wsometimes-uninitialized, Clang warns:

  arch/powerpc/xmon/ppc-dis.c:157:7: warning: variable 'opcode' is used
  uninitialized whenever 'if' condition is false
  [-Wsometimes-uninitialized]
    if (cpu_has_feature(CPU_FTRS_POWER9))
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/powerpc/xmon/ppc-dis.c:167:7: note: uninitialized use occurs here
    if (opcode == NULL)
        ^~~~~~
  arch/powerpc/xmon/ppc-dis.c:157:3: note: remove the 'if' if its
  condition is always true
    if (cpu_has_feature(CPU_FTRS_POWER9))
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/powerpc/xmon/ppc-dis.c:132:38: note: initialize the variable
  'opcode' to silence this warning
    const struct powerpc_opcode *opcode;
                                       ^
                                        = NULL
  1 warning generated.

This warning seems to make no sense on the surface because opcode is set
to NULL right below this statement. However, there is a comma instead of
semicolon to end the dialect assignment, meaning that the opcode
assignment only happens in the if statement. Properly terminate that
line so that Clang no longer warns.

Fixes: 5b102782c7f4 ("powerpc/xmon: Enable disassembly files (compilation changes)")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/xmon/ppc-dis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index 9deea5ee13f6..27f1e6415036 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -158,7 +158,7 @@ int print_insn_powerpc (unsigned long insn, unsigned long memaddr)
     dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
 		| PPC_OPCODE_POWER8 | PPC_OPCODE_POWER9 | PPC_OPCODE_HTM
 		| PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2
-		| PPC_OPCODE_VSX | PPC_OPCODE_VSX3),
+		| PPC_OPCODE_VSX | PPC_OPCODE_VSX3);
 
   /* Get the major opcode of the insn.  */
   opcode = NULL;
-- 
2.19.1

