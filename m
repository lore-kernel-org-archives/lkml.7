Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0115C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666F22075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714913;
	bh=RqPXrsMjM7S0nSetsJDiXM3heWfRxYPfkh6HyA8QHi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AHACxeKtlRNYIJCRUN3ObZIecFDl0kH9RM6riT+H4/gLiqk1/kVfu2sBuJAUhWknV
	 TJRdwwphZpNbk1c8TzuSsYyfnlZMTDKcLNNkmC+e/cxhy3xaoUKHs0sum9I1/H10g2
	 QwkpbWBJqkjHPoBXLDhIsBGjhmRl664E6fUSF5Y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbfC0T2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733223AbfC0SES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:04:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 191FF21871;
        Wed, 27 Mar 2019 18:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709857;
        bh=RqPXrsMjM7S0nSetsJDiXM3heWfRxYPfkh6HyA8QHi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PKufl1zVHX8w4L10bWlXhl4CQDwWJ3hM349ZdX7l8Wjt9F3IFk8qBsx5wire2x91G
         S5kIoXzaMQqUnZGdhei953HI75JRWm9HNod1W291rQOGA581KFUuKfxu3F5hR7nIFT
         8BrsHHq7ZhYhn/4ZnHTDRcrFBoGkfzmk8sw0Mvlg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.0 076/262] powerpc/fsl: Fix the flush of branch predictor.
Date:   Wed, 27 Mar 2019 13:58:51 -0400
Message-Id: <20190327180158.10245-76-sashal@kernel.org>
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

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 27da80719ef132cf8c80eb406d5aeb37dddf78cc ]

The commit identified below adds MC_BTB_FLUSH macro only when
CONFIG_PPC_FSL_BOOK3E is defined. This results in the following error
on some configs (seen several times with kisskb randconfig_defconfig)

arch/powerpc/kernel/exceptions-64e.S:576: Error: Unrecognized opcode: `mc_btb_flush'
make[3]: *** [scripts/Makefile.build:367: arch/powerpc/kernel/exceptions-64e.o] Error 1
make[2]: *** [scripts/Makefile.build:492: arch/powerpc/kernel] Error 2
make[1]: *** [Makefile:1043: arch/powerpc] Error 2
make: *** [Makefile:152: sub-make] Error 2

This patch adds a blank definition of MC_BTB_FLUSH for other cases.

Fixes: 10c5e83afd4a ("powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)")
Cc: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Daniel Axtens <dja@axtens.net>
Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/exceptions-64e.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index afb638778f44..447defdd4503 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -349,6 +349,7 @@ ret_from_mc_except:
 #define GEN_BTB_FLUSH
 #define CRIT_BTB_FLUSH
 #define DBG_BTB_FLUSH
+#define MC_BTB_FLUSH
 #define GDBELL_BTB_FLUSH
 #endif
 
-- 
2.19.1

