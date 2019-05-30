Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEA8C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B16024921
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187473;
	bh=aQJcM1cVq7gWa9y+IphsuHHAkoXxn9PEzhVxGMJBiBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EIwygaMvjfcgaO0ZQAjweK0Odm+vX5BQJtSHgYkeIs/l/SeHlhApMT5pjE64CObHZ
	 vt1NxYF1GeDvRMRvClNZWkzdffZnYTz8kHjZNQ7vSVyiJP2RAybj++vTwp+6mToPgs
	 YO9jDrBeMXDa//ATLqFITit9eyQWFf+8rMzYm0nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbfE3DXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbfE3DRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:33 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17A3E24664;
        Thu, 30 May 2019 03:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186253;
        bh=aQJcM1cVq7gWa9y+IphsuHHAkoXxn9PEzhVxGMJBiBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTf1jHAW3ZyWKRPJ3q5gae0i1X6g5Ps3e7ZikhTvuC3BUV0QLlGZ4a2zvwghlHHtt
         +JKqgieJywMSb2kZ6/H2EeaDPGjITAnlujY7hunk1RgJczj6qPUyd02FsLNjZQGQT6
         RjTJ2KDJZPK3Qiy611l/4eU3I1nNzuyEuPaWTN7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 132/276] powerpc/64: Fix booting large kernels with STRICT_KERNEL_RWX
Date:   Wed, 29 May 2019 20:04:50 -0700
Message-Id: <20190530030534.020918776@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
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



