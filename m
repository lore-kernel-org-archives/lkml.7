Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B93C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A29A218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354029;
	bh=Jz4CMJJAqqS8hXRcDOx/AmbcXYAgo3CVD8RX9M/PJkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KIgQOqhi+g6fk1dnhHWmnylo81yoZtwa4eCy/WrTR7ZwIKJH0GbmTACjZcc4EBYHa
	 WaoVStgXGqn4snJ3X7qjUla/D1AmQ6ke/E13qhvpeknEcePifddkajd/HteJoZ1CtA
	 AAYuE5i8hRoUyONf359R5FhBV8Z+t4E+w+HQc3Mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfDOSrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbfDOSrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4428D218DA;
        Mon, 15 Apr 2019 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354021;
        bh=Jz4CMJJAqqS8hXRcDOx/AmbcXYAgo3CVD8RX9M/PJkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQXLPeENoQAMZ96W/xdB6clWzpMYf4EOAxpsLipgGwgWm2az6jNuhKgWKDhkDYBSO
         sxZ7UdBijyBws7Z37c8NE5yNoZQiHbtKQwaUpwAQaKS4AJqBxWzWAzMj3U4cgypLSt
         Ln/EnHu4W14PHiqHyu12KKOsNKa0qHA73A57HPYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 43/76] powerpc/fsl: Fix the flush of branch predictor.
Date:   Mon, 15 Apr 2019 20:44:07 +0200
Message-Id: <20190415183718.829242692@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 27da80719ef132cf8c80eb406d5aeb37dddf78cc upstream.

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
index 79c6fee6368d..423b5257d3a1 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -348,6 +348,7 @@ ret_from_mc_except:
 #define GEN_BTB_FLUSH
 #define CRIT_BTB_FLUSH
 #define DBG_BTB_FLUSH
+#define MC_BTB_FLUSH
 #define GDBELL_BTB_FLUSH
 #endif
 
-- 
2.19.1



