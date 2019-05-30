Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82BFC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945082554A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190519;
	bh=aQJcM1cVq7gWa9y+IphsuHHAkoXxn9PEzhVxGMJBiBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X+e6VarQY7deNJ5gsncYzf/kRAmcdGG+t2910wkvv5SkcITFOcjg6XMBkQE3xbmWJ
	 yvNxxAKSTbWSQt7wL/rY/VynbN9iFI5Rm8m9+LDA41gdpvXin8JF0y99VM2cu7zFfc
	 0wpXCSsno8FThnzjpO8oxsLhLbDxPxi0eegQyg3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfE3E2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbfE3DON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:14:13 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC83D24547;
        Thu, 30 May 2019 03:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186052;
        bh=aQJcM1cVq7gWa9y+IphsuHHAkoXxn9PEzhVxGMJBiBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjHIaF3siB6ZcjBX0G3gj9L5Cs3OymV3/1r1BHJEK30jx/9eXUtXN6Z5IfA9iAene
         5Dgc1oAb3PnNOV7tcWdyaMy7O4OqV+yyGSWaAiwd2rb7Shh/57QepuLWaTCAbL3pZb
         sBP7SuphmvKhzmRgOAtdn8Gu5sDQ4t05L95nx/qo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 149/346] powerpc/64: Fix booting large kernels with STRICT_KERNEL_RWX
Date:   Wed, 29 May 2019 20:03:42 -0700
Message-Id: <20190530030548.730027230@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 56c46bba9bbfe229b4472a5be313c44c5b714a39 ]

With STRICT_KERNEL_RWX enabled anything marked __init is placed at a 16M
boundary.  This is necessary so that it can be repurposed later with
different permissions.  However, in kernels with text larger than 16M,
this pushes early_setup past 32M, incapable of being reached by the
branch instruction.

Fix this by setting the CTR and branching there instead.

Fixes: 1e0fc9d1eb2b ("powerpc/Kconfig: Enable STRICT_KERNEL_RWX for some configs")
Signed-off-by: Russell Currey <ruscur@russell.cc>
[mpe: Fix it to work on BE by using DOTSYM()]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/head_64.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4898e9491a1cd..9168a247e24ff 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -970,7 +970,9 @@ start_here_multiplatform:
 
 	/* Restore parameters passed from prom_init/kexec */
 	mr	r3,r31
-	bl	early_setup		/* also sets r13 and SPRG_PACA */
+	LOAD_REG_ADDR(r12, DOTSYM(early_setup))
+	mtctr	r12
+	bctrl		/* also sets r13 and SPRG_PACA */
 
 	LOAD_REG_ADDR(r3, start_here_common)
 	ld	r4,PACAKMSR(r13)
-- 
2.20.1



