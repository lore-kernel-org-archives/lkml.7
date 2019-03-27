Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48BDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736102186A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709874;
	bh=MZB3QHZIQZ81aY5ro+0DEani9OJGE+4Jsl/jlOkcpLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z7oTZhyqh1pLxWCZ7uHFDgXl3NE5V5p4WehZk5fQYS0RFyVIFubICC/BebPvxukI1
	 uCUMn8zInKcmOoYy8uquds8zqMDXqFnvS6jWQ/PTnPSFohr0t+yTOQxD/sHsbwJu09
	 msBcGvZpKpmwZNWmsNvlvIlXHvmVvlhuNIc1RJC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbfC0SEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733266AbfC0SE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:04:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA87121734;
        Wed, 27 Mar 2019 18:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709868;
        bh=MZB3QHZIQZ81aY5ro+0DEani9OJGE+4Jsl/jlOkcpLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHmygAqsB3gQft2S2fbhvGiAoZ/wzrE0Ywc558rAjgDLt2aaHEZAcRTvPd21kmi6i
         00SFZk9WcRj9C5z4LFOYbgLfsHIh3cYG3up6cu+iTMKYEcC/MIpjFjrYGDzitn8rRa
         OKowAz17GqGro/WtGX8WbwdztReyxxIv8VfHju94=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.0 080/262] powerpc/xmon: Fix opcode being uninitialized in print_insn_powerpc
Date:   Wed, 27 Mar 2019 13:58:55 -0400
Message-Id: <20190327180158.10245-80-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
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

