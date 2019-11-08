Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EF4FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B387D214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239321;
	bh=j3r/n5l6RYREqpwfXTDzpr2BYB8iYzHItBpD0Po+7WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p06fnhy/W9I2XqaRnkAK8WOUrVq/7UDUqigzhc0tFTSZQbQ+ODpptvmlbNMn4qugG
	 62FFHVnIBd1E5e9p6Bn+4CozVfW2e4opxLiqwmsxaP8QGe1n9TbCSltiphZqiMNLLo
	 gTltwEUdq95w6+c2DqR0yfR9Lw8xq03aFNGoECCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfKHSzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733294AbfKHSzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:55:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C24A222C5;
        Fri,  8 Nov 2019 18:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239315;
        bh=j3r/n5l6RYREqpwfXTDzpr2BYB8iYzHItBpD0Po+7WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=InPUAoJ08lgozGcxxQI3jTFSpowOc15WHC1j8ieJWvftlq0IP+B/C2b96vULBzYPv
         P27iERlN7B50BJQXUcrrM2O/kDLUFPtJXOBTEpbVgOENKtT3wPJ8mr5a3jeBucBOxp
         6AFBSxQSgwbBopqMRbKl8BdJeidqkqAC70iyn49I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk, Ard Biesheuvel" 
        <ardb@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4.4 72/75] ARM: ensure that processor vtables is not lost after boot
Date:   Fri,  8 Nov 2019 19:50:29 +0100
Message-Id: <20191108174812.646613145@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
References: <20191108174708.135680837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 3a4d0c2172bcf15b7a3d9d498b2b355f9864286b upstream.

Marek Szyprowski reported problems with CPU hotplug in current kernels.
This was tracked down to the processor vtables being located in an
init section, and therefore discarded after kernel boot, despite being
required after boot to properly initialise the non-boot CPUs.

Arrange for these tables to end up in .rodata when required.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 383fb3ee8024 ("ARM: spectre-v2: per-CPU vtables to work around big.Little systems")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mm/proc-macros.S |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -259,6 +259,13 @@
 	.endm
 
 .macro define_processor_functions name:req, dabort:req, pabort:req, nommu=0, suspend=0, bugs=0
+/*
+ * If we are building for big.Little with branch predictor hardening,
+ * we need the processor function tables to remain available after boot.
+ */
+#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+	.section ".rodata"
+#endif
 	.type	\name\()_processor_functions, #object
 	.align 2
 ENTRY(\name\()_processor_functions)
@@ -294,6 +301,9 @@ ENTRY(\name\()_processor_functions)
 	.endif
 
 	.size	\name\()_processor_functions, . - \name\()_processor_functions
+#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+	.previous
+#endif
 .endm
 
 .macro define_cache_functions name:req


