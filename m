Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1905CC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A4D20869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfDMHU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:20:29 -0400
Received: from www.osadl.org ([62.245.132.105]:36359 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfDMHU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 03:20:28 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3D7JfAQ003435;
        Sat, 13 Apr 2019 09:19:53 +0200
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
Subject: [PATCH] ARM: add missing of_node_put()
Date:   Sat, 13 Apr 2019 09:14:14 +0200
Message-Id: <1555139666-948-3-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1555139666-948-1-git-send-email-hofrat@osadl.org>
References: <1555139666-948-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The call to of_find_compatible_node() returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage. (see drivers/of/base.c:of_find_compatible_node())

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located with an experimental coccinelle script

Patch was compile tested with: axm55xx_defconfig
(with some sparse warnings - not related to the proposed change though)

Patch is against 4.17.0 (localversion-next is next-20180614)

 arch/arm/mach-axxia/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-axxia/platsmp.c b/arch/arm/mach-axxia/platsmp.c
index 502e3df..c706a11 100644
--- a/arch/arm/mach-axxia/platsmp.c
+++ b/arch/arm/mach-axxia/platsmp.c
@@ -40,10 +40,11 @@ static int axxia_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	syscon_np = of_find_compatible_node(NULL, NULL, "lsi,axxia-syscon");
 	if (!syscon_np)
 		return -ENOENT;
 
 	syscon = of_iomap(syscon_np, 0);
+	of_node_put(syscon_np);
 	if (!syscon)
 		return -ENOMEM;
 
 	tmp = readl(syscon + SC_RST_CPU_HOLD);
 	writel(0xab, syscon + SC_CRIT_WRITE_KEY);
-- 
2.1.4

