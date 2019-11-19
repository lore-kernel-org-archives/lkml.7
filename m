Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D7FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30108222DC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKSGuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:50:50 -0500
Received: from inva021.nxp.com ([92.121.34.21]:46584 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfKSGuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:50:50 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F75720002C;
        Tue, 19 Nov 2019 07:50:48 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7020020000F;
        Tue, 19 Nov 2019 07:50:46 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BC27140286;
        Tue, 19 Nov 2019 14:50:43 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     Sandor Yu <Sandor.yu@nxp.com>, linux-kernel@vger.kernel.org
Cc:     Wen He <wen.he_1@nxp.com>
Subject: [linux-nxp/display/hdp] drm: imx: mhdp: Adjustment core rate of DP TX CTRL for LS1028A
Date:   Tue, 19 Nov 2019 14:50:49 +0800
Message-Id: <20191119065049.27594-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Display TX CTRL clock should be ACLK/4, update it to align with
the specification.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dp-core.c | 4 ++++
 drivers/gpu/drm/imx/cdn-mhdp-imx8qm.c         | 3 +++
 include/drm/bridge/cdns-mhdp-common.h         | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dp-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dp-core.c
index 54396f9042ed..0a7550785953 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dp-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dp-core.c
@@ -435,6 +435,7 @@ static int __cdns_dp_probe(struct platform_device *pdev,
 	}
 
 	mhdp->is_hpd = true;
+	mhdp->is_ls1028a = false;
 
 	mhdp->irq[IRQ_IN] = platform_get_irq_byname(pdev, "plug_in");
 	if (mhdp->irq[IRQ_IN] < 0) {
@@ -450,6 +451,9 @@ static int __cdns_dp_probe(struct platform_device *pdev,
 
 	cdns_dp_parse_dt(mhdp);
 
+	if (of_device_is_compatible(dev->of_node, "cdn,ls1028a-dp"))
+		mhdp->is_ls1028a = true;
+
 	cdns_mhdp_plat_call(mhdp, power_on);
 
 	cdns_mhdp_plat_call(mhdp, firmware_init);
diff --git a/drivers/gpu/drm/imx/cdn-mhdp-imx8qm.c b/drivers/gpu/drm/imx/cdn-mhdp-imx8qm.c
index b8a762ed2d90..76ecfefe3153 100644
--- a/drivers/gpu/drm/imx/cdn-mhdp-imx8qm.c
+++ b/drivers/gpu/drm/imx/cdn-mhdp-imx8qm.c
@@ -526,6 +526,9 @@ int cdns_mhdp_firmware_init_imx8qm(struct cdns_mhdp_device *mhdp)
 
 	/* configure HDMI/DP core clock */
 	rate = clk_get_rate(imx_mhdp->clks.clk_core);
+	if (mhdp->is_ls1028a)
+		rate = rate / 4;
+
 	cdns_mhdp_set_fw_clk(&imx_mhdp->mhdp, rate);
 
 	/* un-reset ucpu */
diff --git a/include/drm/bridge/cdns-mhdp-common.h b/include/drm/bridge/cdns-mhdp-common.h
index d11d048352ef..f416b57d29db 100755
--- a/include/drm/bridge/cdns-mhdp-common.h
+++ b/include/drm/bridge/cdns-mhdp-common.h
@@ -684,6 +684,7 @@ struct cdns_mhdp_device {
 	bool power_up;
 	bool plugged;
 	bool is_hpd;
+	bool is_ls1028a;
 	struct mutex lock;
 	struct mutex iolock;
 
-- 
2.17.1

