Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A06C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE53A20869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfDMHVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:21:48 -0400
Received: from www.osadl.org ([62.245.132.105]:36455 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfDMHVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 03:21:47 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3D7JfAT003435;
        Sat, 13 Apr 2019 09:20:08 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/4 RFC] ARM: imx legacy: warn on failed allocation
Date:   Sat, 13 Apr 2019 09:14:17 +0200
Message-Id: <1555139666-948-6-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1555139666-948-1-git-send-email-hofrat@osadl.org>
References: <1555139666-948-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even in init the allocation can fail and thus should at least warn so
that the cause can be identified.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located with an experimental coccinelle script

Note sure if there is a better solution as this is early in the boot
process so not that could be done anyway but fuss - anyway unchecked
allocation is not a good thing.

Patch was compile-tested with: imx_v4_v5_defconfig (implies
CONFIG_MACH_MX27ADS=y)
(with some unrelated sparse warnings about unimplemented syscalls
 and a few checkpatch warnings - covered in the other patches)

Patch is against 5.1-rc4 (localversion-next is 20190412)

 arch/arm/mach-imx/mach-mx27ads.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 6dd7f57..528846f 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -247,6 +247,7 @@ static void __init mx27ads_regulator_init(void)
 	struct gpio_chip *vchip;
 
 	vchip = kzalloc(sizeof(*vchip), GFP_KERNEL);
+	WARN_ON(!vchip);
 	vchip->owner		= THIS_MODULE;
 	vchip->label		= "LCD";
 	vchip->base		= MX27ADS_LCD_GPIO;
-- 
2.1.4

