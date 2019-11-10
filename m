Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F83C17440
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2990C21019
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354653;
	bh=kTWHcQgmOh92E8ZW7W0vJ+QVMthQ0RSoHstpcaD/z3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UT9qqcF5vXYwH31E3zJjmaxKy5k65KiCgPIqCViPGjY0H0YlyBzugKGsAIsSiyjjz
	 Fr7ID5A9txmZTmTeoAJJg6eXF768y/+J6jpVCYCjTxJHgexrxyVhchoaRo+ZyxTn6b
	 0UymEsuKrndz4Rc5S2Hx80HTzEqwdkt272YEM32Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfKJC4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbfKJC4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:56:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A22222085B;
        Sun, 10 Nov 2019 02:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354046;
        bh=kTWHcQgmOh92E8ZW7W0vJ+QVMthQ0RSoHstpcaD/z3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jKNe0NPTUrTBnn3MaVEVmGsAxC7dKAu+wD3VkwR1+tNfdRDW2AQ6aIFcoS0IdqVz0
         tMl3v12mo+OKlfNY+ftWNiRb/LnG1us/m7XihRxBYcc2tGRYZYytZ+H1jde0jVOucL
         Gd/QpOgJg88CFuD7kWwAhRKDa6kv9XALX7az5W2c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 057/109] phy: brcm-sata: allow PHY_BRCM_SATA driver to be built for DSL SoCs
Date:   Sat,  9 Nov 2019 21:44:49 -0500
Message-Id: <20191110024541.31567-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

