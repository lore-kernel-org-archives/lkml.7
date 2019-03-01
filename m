Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1F0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FC52186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbfCAI6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:58:02 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:32914 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387703AbfCAI56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:57:58 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id D47FC45984B79C16E70C;
        Fri,  1 Mar 2019 16:57:28 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x218vHe7087152;
        Fri, 1 Mar 2019 16:57:17 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019030116575609-2499040 ;
          Fri, 1 Mar 2019 16:57:56 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     liviu.dudau@arm.com
Cc:     sudeep.holla@arm.com, lorenzo.pieralisi@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kgene@kernel.org, krzk@kernel.org,
        linux-samsung-soc@vger.kernel.org, michal.simek@xilinx.com,
        afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        dinguyen@kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linus.walleij@linaro.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        openbmc@lists.ozlabs.org, xuwei5@hisilicon.com,
        maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, horms@verge.net.au, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, wang.yi59@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 10/15] ARM: sunxi: fix a leaked reference by addingmissing of_node_put
Date:   Fri, 1 Mar 2019 16:56:51 +0800
Message-Id: <1551430616-42014-10-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-01 16:57:56,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-01 16:57:01,
        Serialize complete at 2019-03-01 16:57:01
X-MAIL: mse01.zte.com.cn x218vHe7087152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./arch/arm/mach-sunxi/platsmp.c:55:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 46, but without a corresponding object release within this function.
./arch/arm/mach-sunxi/platsmp.c:138:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 129, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/mach-sunxi/platsmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
index 8fb5088..c842209 100644
--- a/arch/arm/mach-sunxi/platsmp.c
+++ b/arch/arm/mach-sunxi/platsmp.c
@@ -50,6 +50,7 @@ static void __init sun6i_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	prcm_membase = of_iomap(node, 0);
+	of_node_put(node);
 	if (!prcm_membase) {
 		pr_err("Couldn't map A31 PRCM registers\n");
 		return;
@@ -63,6 +64,7 @@ static void __init sun6i_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	cpucfg_membase = of_iomap(node, 0);
+	of_node_put(node);
 	if (!cpucfg_membase)
 		pr_err("Couldn't map A31 CPU config registers\n");
 
-- 
2.9.5

