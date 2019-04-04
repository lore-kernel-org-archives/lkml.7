Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7D0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B16B20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369042;
	bh=bFvZanvO2bfkQJsJ0D/Ji8862I1CE0Dhwhlnha/OUaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iDdsEbwkTolLCKg/+ObAnHgrzhjwRlAsw423Fzfn/ptd6fbBGPRtjpUSV3/te8njq
	 w1P+n8aj8LnX7bnakakqBIc6+ZJuaxiXdvQ+N0LqOha4uIs7uhXJPXTTFsgmSW+ub4
	 yRF04DTZxFQhx3NyRk17fIYFSIFWM4ZGnhwQqv1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbfDDJKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732612AbfDDJKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E7020693;
        Thu,  4 Apr 2019 09:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369037;
        bh=bFvZanvO2bfkQJsJ0D/Ji8862I1CE0Dhwhlnha/OUaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPJ23sgDWrJtneFde2ErL0fpFM+woTG6+jC5xYKXENrHh3XIBweIdYt5Tk+gcCLBv
         D+QBIX3FHZmNRMm1wgF0E1o8T/UMPbKXxQXOwUN5SwUc1vKQbOTedD6gLAqyXFFvvB
         2EE5zDcescPRkJ+oYRsbq3JWdt6ixzo4Wc0J/v+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 074/246] powerpc/xmon: Fix opcode being uninitialized in print_insn_powerpc
Date:   Thu,  4 Apr 2019 10:46:14 +0200
Message-Id: <20190404084621.726938345@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



