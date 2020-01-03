Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCC9C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F005B222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TMVO19DT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgACISY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:18:24 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17279 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgACISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:18:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0ef8a20000>; Fri, 03 Jan 2020 00:17:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 00:18:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 00:18:22 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 08:18:21 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 08:18:21 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.118]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0ef8cb0000>; Fri, 03 Jan 2020 00:18:20 -0800
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v5 1/5] phy: tegra: xusb: Protect Tegra186 soc with config
Date:   Fri, 3 Jan 2020 16:18:10 +0800
Message-ID: <20200103081814.9848-2-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103081814.9848-1-jckuo@nvidia.com>
References: <20200103081814.9848-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578039458; bh=jtzhgmOSyLlj7voWgVZkhzmevHlkmril+TYqeYqIUAw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=TMVO19DT564EdqdoqBGJfRsE12O2RpJgoAXKOYjwWpjLSM56xjVFXPo6mzcowRGif
         UoHGSvWygjFgGmKugqYSzPlEUOXwNlrgkKOFehk1GCzquqVXbQnC/+AUCNBaInqDid
         ukwONRHGhD+Y49e/WYD9oV0f1YnEz5/ftBHnVoNgnfc2GeHapohr54nLZ/yvDW/z71
         Vvw4gjXAysMUuUNn807fnDEnsfo/fdS3rZH+wNb+A1gr3PJZWHKpSzpSS0PP4eYXOW
         wTP6vCplSLSe2sgLfwEPEUpa/ORstOJ6hO72Pj2g7DGAXGYRmX/ia8dVJcv/qTPv9G
         xH9xwe9vnaqKw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As xusb-tegra186.c will be reused for Tegra194, it would be good to
protect Tegra186 soc data with CONFIG_ARCH_TEGRA_186_SOC. This commit
also reshuffles Tegra186 soc data single CONFIG_ARCH_TEGRA_186_SOC
will be sufficient.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
Changes in v5: none
Changes in v4: none
Changes in v3: none
Changes in v2:
- new patch to protect Tegra186 soc data with config

 drivers/phy/tegra/xusb-tegra186.c | 70 ++++++++++++++++---------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 84c27394c181..01f7d979c9a8 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -503,19 +503,6 @@ static const char * const tegra186_usb2_functions[] = {
 	"xusb",
 };
 
-static const struct tegra_xusb_lane_soc tegra186_usb2_lanes[] = {
-	TEGRA186_LANE("usb2-0", 0,  0, 0, usb2),
-	TEGRA186_LANE("usb2-1", 0,  0, 0, usb2),
-	TEGRA186_LANE("usb2-2", 0,  0, 0, usb2),
-};
-
-static const struct tegra_xusb_pad_soc tegra186_usb2_pad = {
-	.name = "usb2",
-	.num_lanes = ARRAY_SIZE(tegra186_usb2_lanes),
-	.lanes = tegra186_usb2_lanes,
-	.ops = &tegra186_usb2_pad_ops,
-};
-
 static int tegra186_usb2_port_enable(struct tegra_xusb_port *port)
 {
 	return 0;
@@ -765,27 +752,6 @@ static const char * const tegra186_usb3_functions[] = {
 	"xusb",
 };
 
-static const struct tegra_xusb_lane_soc tegra186_usb3_lanes[] = {
-	TEGRA186_LANE("usb3-0", 0,  0, 0, usb3),
-	TEGRA186_LANE("usb3-1", 0,  0, 0, usb3),
-	TEGRA186_LANE("usb3-2", 0,  0, 0, usb3),
-};
-
-static const struct tegra_xusb_pad_soc tegra186_usb3_pad = {
-	.name = "usb3",
-	.num_lanes = ARRAY_SIZE(tegra186_usb3_lanes),
-	.lanes = tegra186_usb3_lanes,
-	.ops = &tegra186_usb3_pad_ops,
-};
-
-static const struct tegra_xusb_pad_soc * const tegra186_pads[] = {
-	&tegra186_usb2_pad,
-	&tegra186_usb3_pad,
-#if 0 /* TODO implement */
-	&tegra186_hsic_pad,
-#endif
-};
-
 static int
 tegra186_xusb_read_fuse_calibration(struct tegra186_xusb_padctl *padctl)
 {
@@ -885,6 +851,7 @@ static const struct tegra_xusb_padctl_ops tegra186_xusb_padctl_ops = {
 	.vbus_override = tegra186_xusb_padctl_vbus_override,
 };
 
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
 static const char * const tegra186_xusb_padctl_supply_names[] = {
 	"avdd-pll-erefeut",
 	"avdd-usb",
@@ -892,6 +859,40 @@ static const char * const tegra186_xusb_padctl_supply_names[] = {
 	"vddio-hsic",
 };
 
+static const struct tegra_xusb_lane_soc tegra186_usb2_lanes[] = {
+	TEGRA186_LANE("usb2-0", 0,  0, 0, usb2),
+	TEGRA186_LANE("usb2-1", 0,  0, 0, usb2),
+	TEGRA186_LANE("usb2-2", 0,  0, 0, usb2),
+};
+
+static const struct tegra_xusb_pad_soc tegra186_usb2_pad = {
+	.name = "usb2",
+	.num_lanes = ARRAY_SIZE(tegra186_usb2_lanes),
+	.lanes = tegra186_usb2_lanes,
+	.ops = &tegra186_usb2_pad_ops,
+};
+
+static const struct tegra_xusb_lane_soc tegra186_usb3_lanes[] = {
+	TEGRA186_LANE("usb3-0", 0,  0, 0, usb3),
+	TEGRA186_LANE("usb3-1", 0,  0, 0, usb3),
+	TEGRA186_LANE("usb3-2", 0,  0, 0, usb3),
+};
+
+static const struct tegra_xusb_pad_soc tegra186_usb3_pad = {
+	.name = "usb3",
+	.num_lanes = ARRAY_SIZE(tegra186_usb3_lanes),
+	.lanes = tegra186_usb3_lanes,
+	.ops = &tegra186_usb3_pad_ops,
+};
+
+static const struct tegra_xusb_pad_soc * const tegra186_pads[] = {
+	&tegra186_usb2_pad,
+	&tegra186_usb3_pad,
+#if 0 /* TODO implement */
+	&tegra186_hsic_pad,
+#endif
+};
+
 const struct tegra_xusb_padctl_soc tegra186_xusb_padctl_soc = {
 	.num_pads = ARRAY_SIZE(tegra186_pads),
 	.pads = tegra186_pads,
@@ -916,6 +917,7 @@ const struct tegra_xusb_padctl_soc tegra186_xusb_padctl_soc = {
 	.num_supplies = ARRAY_SIZE(tegra186_xusb_padctl_supply_names),
 };
 EXPORT_SYMBOL_GPL(tegra186_xusb_padctl_soc);
+#endif
 
 MODULE_AUTHOR("JC Kuo <jckuo@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra186 XUSB Pad Controller driver");
-- 
2.17.1

