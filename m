Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA08C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744DD217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599322;
	bh=W8jA6zfczwBK1o/YN05QDTIIpNcndbIRXQ3AmvC0I+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gb71VW4oI243oQyTKJ9jdQnvdSjdMTHWhFR4x6RmHCaQ1GPL5oe+ko3YEJMuhBV1z
	 8P+H7okcHdz3R6e48vBOk4Wm44Z1/ptwM+OBfRZ0STn63hS0o3/YOfv/JIT1AUqmwm
	 vWYNi3Uq9LMwHqy0DrHbDRNY45U1iZZiRHrUDfao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbfGHPWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387852AbfGHPV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:21:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3477F21707;
        Mon,  8 Jul 2019 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599318;
        bh=W8jA6zfczwBK1o/YN05QDTIIpNcndbIRXQ3AmvC0I+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmYy+XS91UgvF3119+rWaRCIuSaOoK9otNn4biIFEtWKTv9GK2yMdnhm7ic3mTDmh
         7FnsL5q3QB7wdE/pmt8FqiI2m4+KHhOGX1HIzeOXCGdEflu8dj8a8BNsbL/XZRXGuo
         dezhpD8r2S3A9zCFfsuAGQU/fE/zTp193naN3tqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 076/102] MIPS: math-emu: do not use bools for arithmetic
Date:   Mon,  8 Jul 2019 17:13:09 +0200
Message-Id: <20190708150530.393799947@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8535f2ba0a9b971df62a5890699b9dfe2e0d5580 ]

GCC-7 complains about a boolean value being used with an arithmetic
AND:

arch/mips/math-emu/cp1emu.c: In function 'cop1Emulate':
arch/mips/math-emu/cp1emu.c:838:14: warning: '~' on a boolean expression [-Wbool-operation]
  fpr = (x) & ~(cop1_64bit(xcp) == 0);    \
              ^
arch/mips/math-emu/cp1emu.c:1068:3: note: in expansion of macro 'DITOREG'
   DITOREG(dval, MIPSInst_RT(ir));
   ^~~~~~~
arch/mips/math-emu/cp1emu.c:838:14: note: did you mean to use logical not?
  fpr = (x) & ~(cop1_64bit(xcp) == 0);    \

Since cop1_64bit() returns and int, just flip the LSB.

Suggested-by: Maciej W. Rozycki <macro@imgtec.com>
Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17058/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/math-emu/cp1emu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 7f2519cfb5d2..15f788601b64 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -828,12 +828,12 @@ do {									\
 } while (0)
 
 #define DIFROMREG(di, x)						\
-	((di) = get_fpr64(&ctx->fpr[(x) & ~(cop1_64bit(xcp) == 0)], 0))
+	((di) = get_fpr64(&ctx->fpr[(x) & ~(cop1_64bit(xcp) ^ 1)], 0))
 
 #define DITOREG(di, x)							\
 do {									\
 	unsigned fpr, i;						\
-	fpr = (x) & ~(cop1_64bit(xcp) == 0);				\
+	fpr = (x) & ~(cop1_64bit(xcp) ^ 1);				\
 	set_fpr64(&ctx->fpr[fpr], 0, di);				\
 	for (i = 1; i < ARRAY_SIZE(ctx->fpr[x].val64); i++)		\
 		set_fpr64(&ctx->fpr[fpr], i, 0);			\
-- 
2.20.1



