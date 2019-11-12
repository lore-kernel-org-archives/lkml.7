Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DA0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB828222CB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kSoegeX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfKLO3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:29:32 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39160 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfKLO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:29:27 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACETAcA099249;
        Tue, 12 Nov 2019 08:29:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573568950;
        bh=Zm1DAkD5kdVnx/YycC32mnNw5DowmAO+JNH1v0pEsp0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kSoegeX7JjqEpO/Jx5hhHYWy9wWoLAFrMpIgukoQDpW+ayqUtRNiLe3TlaYKNdjXB
         JFV8ZragzYTNn47czF28Ne1Qb2LQfsAk4B0atHwbJubWX1UdDcZe60b7YX5OloAFhY
         BCYAAvfG13lw00fHUDCJGNx6LkLfpjJxBv/fY9Ck=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACETAJl027244
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:29:10 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:28:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:28:53 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACESriR044422;
        Tue, 12 Nov 2019 08:29:10 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 15/20] media: ti-vpe: cal: Add AM654 support
Date:   Tue, 12 Nov 2019 08:31:47 -0600
Message-ID: <20191112143152.23176-16-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112143152.23176-1-bparrot@ti.com>
References: <20191112143152.23176-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the needed control module register bit layout to support the AM654
family of devices.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/Kconfig      |  2 +-
 drivers/media/platform/ti-vpe/cal.c | 26 +++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index e84f35d3a68e..995f4c67f764 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -151,7 +151,7 @@ source "drivers/media/platform/sunxi/Kconfig"
 config VIDEO_TI_CAL
 	tristate "TI CAL (Camera Adaptation Layer) driver"
 	depends on VIDEO_DEV && VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API
-	depends on SOC_DRA7XX || COMPILE_TEST
+	depends on SOC_DRA7XX || ARCH_K3 || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_FWNODE
 	help
diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 0ed517b3c00d..58d2edc087fb 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -317,6 +317,24 @@ static const struct cal_data dra76x_cal_data = {
 	.num_csi2_phy = ARRAY_SIZE(dra76x_cal_csi_phy),
 };
 
+static struct reg_field am654_ctrl_core_csi0_reg_fields[F_MAX_FIELDS] = {
+	[F_CTRLCLKEN] = REG_FIELD(0, 15, 15),
+	[F_CAMMODE] = REG_FIELD(0, 24, 25),
+	[F_LANEENABLE] = REG_FIELD(0, 0, 4),
+};
+
+static struct cal_csi2_phy am654_cal_csi_phy[] = {
+	{
+		.base_fields = am654_ctrl_core_csi0_reg_fields,
+		.num_lanes = 5,
+	},
+};
+
+static const struct cal_data am654_cal_data = {
+	.csi2_phy_core = am654_cal_csi_phy,
+	.num_csi2_phy = ARRAY_SIZE(am654_cal_csi_phy),
+};
+
 /*
  * there is one cal_dev structure in the driver, it is shared by
  * all instances.
@@ -543,7 +561,9 @@ static void camerarx_phy_enable(struct cal_ctx *ctx)
 	/* Always enable all lanes at the phy control level */
 	max_lanes = (1 << cal_data_get_phy_max_lanes(ctx)) - 1;
 	regmap_field_write(phy->fields[F_LANEENABLE], max_lanes);
-	regmap_field_write(phy->fields[F_CSI_MODE], 1);
+	/* F_CSI_MODE is not present on every architecture */
+	if (phy->fields[F_CSI_MODE])
+		regmap_field_write(phy->fields[F_CSI_MODE], 1);
 	regmap_field_write(phy->fields[F_CTRLCLKEN], 1);
 }
 
@@ -2321,6 +2341,10 @@ static const struct of_device_id cal_of_match[] = {
 		.compatible = "ti,dra76-cal",
 		.data = (void *)&dra76x_cal_data,
 	},
+	{
+		.compatible = "ti,am654-cal",
+		.data = (void *)&am654_cal_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, cal_of_match);
-- 
2.17.1

