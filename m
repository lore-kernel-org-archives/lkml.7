Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D738C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032BF208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577644592;
	bh=83Q0i6gy5JrAk6opf7Mtf88kk8US5YyE5EsfErHveAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qRD5rYm1SlG5k1JnfGwcV5GM3EVGLt4dzo3gKt7PVmTXyGwcN9oCl7WzBDU19JIE4
	 ifNj2MkvEa51b0cRApdIgKJAYjdCskNfUpP2/eSrbzcRyp+fTirhFQleu+PcMMuFNn
	 1JaKWogT3oAhsi6FAoI1g8CN86o4AhJdvXpnE4hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfL2Sgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfL2Sg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 13:36:27 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB4A207FF;
        Sun, 29 Dec 2019 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577644587;
        bh=83Q0i6gy5JrAk6opf7Mtf88kk8US5YyE5EsfErHveAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAKT8OWjASnDNvIY7bRBmo1mwYWpc07yflAfxBW0fnjcO1EimXQ1BDICRniXpJUvO
         p8hpIyRMWBbiMzFQrZgJ0k+SuWiHFXw0cYMLiJUqHxDTIPYFpXBjn7vNbAvh6gPCnQ
         hHXZygZBv5bvH8/M++r+3xNMRC97z5hn3u3xnYkM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] mtd: onenand: Enable compile testing of OMAP and Samsung drivers
Date:   Sun, 29 Dec 2019 19:36:12 +0100
Message-Id: <20191229183612.22133-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191229183612.22133-1-krzk@kernel.org>
References: <20191229183612.22133-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OMAP and Samsung OneNAND drivers can be compile tested.  The OMAP
drivers still depends on mach header so limit the compile testing to
ARMv7.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mtd/nand/onenand/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/onenand/Kconfig b/drivers/mtd/nand/onenand/Kconfig
index ae0b8fe5b990..3886644de094 100644
--- a/drivers/mtd/nand/onenand/Kconfig
+++ b/drivers/mtd/nand/onenand/Kconfig
@@ -25,7 +25,7 @@ config MTD_ONENAND_GENERIC
 
 config MTD_ONENAND_OMAP2
 	tristate "OneNAND on OMAP2/OMAP3 support"
-	depends on ARCH_OMAP2 || ARCH_OMAP3
+	depends on ARCH_OMAP2 || ARCH_OMAP3 || (COMPILE_TEST && ARM)
 	depends on OF || COMPILE_TEST
 	help
 	  Support for a OneNAND flash device connected to an OMAP2/OMAP3 SoC
@@ -34,7 +34,7 @@ config MTD_ONENAND_OMAP2
 
 config MTD_ONENAND_SAMSUNG
         tristate "OneNAND on Samsung SOC controller support"
-        depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS4
+        depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS4 || COMPILE_TEST
         help
           Support for a OneNAND flash device connected to an Samsung SOC.
           S3C64XX uses command mapping method.
-- 
2.17.1

