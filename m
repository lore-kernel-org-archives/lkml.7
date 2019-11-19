Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47657C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DF5218BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142750;
	bh=kTWHcQgmOh92E8ZW7W0vJ+QVMthQ0RSoHstpcaD/z3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=raoA0NmJvP9kGrDtNiObO8sy82TRGLKTD3OP2Zq42QuE4FOzB2kD4CCijyJYdJFyY
	 WebwFDHRIg/OdMZpwbkz//XDHr3GJGYWuus4GBzn0fvqebwbKjKddWnnumKQDH6Xvm
	 bO/qF5uqF2mPMsQv4o6C9xX+u55XLgYdTdevPtmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbfKSFw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:52:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731297AbfKSFwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:52:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E6A2208C3;
        Tue, 19 Nov 2019 05:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142744;
        bh=kTWHcQgmOh92E8ZW7W0vJ+QVMthQ0RSoHstpcaD/z3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gosw+WNPB7+nMafji7JJDhZUxc5pHQa3vVXyDk9ZvFwmx6utqWTELuxjAm7YSFq7c
         BR+RETDvDXYI8Pn6HQXIauHpGPErczGUd1TRSLQRPb9R4jKqA7cOH2mL0n7yzFQ1pW
         1VedtDFuuADynRbvMGzJfZ9iEEUJugUcX4qyHD5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 186/239] phy: brcm-sata: allow PHY_BRCM_SATA driver to be built for DSL SoCs
Date:   Tue, 19 Nov 2019 06:19:46 +0100
Message-Id: <20191119051335.200929962@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 26728df4b254ae06247726a9a6e64823e39ac504 ]

Broadcom ARM-based DSL SoCs (BCM63xx product line) have the same
Broadcom SATA PHY that other SoCs are using, make it possible to select
that driver on these platforms.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/broadcom/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index 64fc59c3ae6d9..181b8fde2bfe6 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -60,7 +60,8 @@ config PHY_NS2_USB_DRD
 
 config PHY_BRCM_SATA
 	tristate "Broadcom SATA PHY driver"
-	depends on ARCH_BRCMSTB || ARCH_BCM_IPROC || BMIPS_GENERIC || COMPILE_TEST
+	depends on ARCH_BRCMSTB || ARCH_BCM_IPROC || BMIPS_GENERIC || \
+		   ARCH_BCM_63XX || COMPILE_TEST
 	depends on OF
 	select GENERIC_PHY
 	default ARCH_BCM_IPROC
-- 
2.20.1



