Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB50C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6AF2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbfCAI5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:57:07 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:9558 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733008AbfCAI5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:57:06 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id BC2BAED9311404AC15A7;
        Fri,  1 Mar 2019 16:57:03 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x218utNL086492;
        Fri, 1 Mar 2019 16:56:55 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019030116573424-2498920 ;
          Fri, 1 Mar 2019 16:57:34 +0800 
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
Subject: [PATCH 03/15] ARM: exynos: fix a leaked reference by addingmissing of_node_put
Date:   Fri, 1 Mar 2019 16:56:44 +0800
Message-Id: <1551430616-42014-3-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-01 16:57:34,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-01 16:56:40,
        Serialize complete at 2019-03-01 16:56:40
X-MAIL: mse01.zte.com.cn x218utNL086492
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./arch/arm/mach-exynos/firmware.c:201:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 193, but without a corresponding object release within this function.
./arch/arm/mach-exynos/firmware.c:204:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 193, but without a corresponding object release within this function.
./arch/arm/mach-exynos/suspend.c:642:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 634, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/mach-exynos/firmware.c | 1 +
 arch/arm/mach-exynos/suspend.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index d602e3b..2eaf2db 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -196,6 +196,7 @@ bool __init exynos_secure_firmware_available(void)
 		return false;
 
 	addr = of_get_address(nd, 0, NULL, NULL);
+	of_node_put(nd);
 	if (!addr) {
 		pr_err("%s: No address specified.\n", __func__);
 		return false;
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 0850505..9afb0c6 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -639,8 +639,10 @@ void __init exynos_pm_init(void)
 
 	if (WARN_ON(!of_find_property(np, "interrupt-controller", NULL))) {
 		pr_warn("Outdated DT detected, suspend/resume will NOT work\n");
+		of_node_put(np);
 		return;
 	}
+	of_node_put(np);
 
 	pm_data = (const struct exynos_pm_data *) match->data;
 
-- 
2.9.5

