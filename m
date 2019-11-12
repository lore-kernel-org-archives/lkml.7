Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37865C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F00A222C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aTYt51GT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfKLO3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:29:49 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49920 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfKLO3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:29:11 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACET91p091993;
        Tue, 12 Nov 2019 08:29:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573568949;
        bh=3afVrSmjTL4CyEPRTamBo0N3qnu4sRsruT5eMjfEjYc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aTYt51GTCQEJDNubHxhIxGOLYkQtJpJPo2qCsUm+b5WuxNrCDDZO5hoOYUBZK8biC
         WfqmBu7R5PDooYQ5pbJFGVOYJK3AHqEKRoHfQ8BmgvWtT0mf4/PKwBOHd/8Z77CU31
         OHk/9eJwj6/PgromZlJDpG4gn+ivWMi33TtWWZXQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACET9VJ019483
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:29:09 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:28:51 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:28:51 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACESriP044422;
        Tue, 12 Nov 2019 08:29:08 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 13/20] media: ti-vpe: cal: Add DRA76x support
Date:   Tue, 12 Nov 2019 08:31:45 -0600
Message-ID: <20191112143152.23176-14-bparrot@ti.com>
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

Add the needed control module register bit layout to support
the DRA76x family of devices.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/cal.c | 34 +++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 8d9c1569c05a..0ed517b3c00d 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -287,6 +287,36 @@ static const struct cal_data dra72x_es1_cal_data = {
 	.flags = DRA72_CAL_PRE_ES2_LDO_DISABLE,
 };
 
+static struct reg_field dra76x_ctrl_core_csi0_reg_fields[F_MAX_FIELDS] = {
+	[F_CTRLCLKEN] = REG_FIELD(0, 8, 8),
+	[F_CAMMODE] = REG_FIELD(0, 9, 10),
+	[F_CSI_MODE] = REG_FIELD(0, 11, 11),
+	[F_LANEENABLE] = REG_FIELD(0, 27, 31),
+};
+
+static struct reg_field dra76x_ctrl_core_csi1_reg_fields[F_MAX_FIELDS] = {
+	[F_CTRLCLKEN] = REG_FIELD(0, 0, 0),
+	[F_CAMMODE] = REG_FIELD(0, 1, 2),
+	[F_CSI_MODE] = REG_FIELD(0, 3, 3),
+	[F_LANEENABLE] = REG_FIELD(0, 24, 26),
+};
+
+static struct cal_csi2_phy dra76x_cal_csi_phy[] = {
+	{
+		.base_fields = dra76x_ctrl_core_csi0_reg_fields,
+		.num_lanes = 5,
+	},
+	{
+		.base_fields = dra76x_ctrl_core_csi1_reg_fields,
+		.num_lanes = 3,
+	},
+};
+
+static const struct cal_data dra76x_cal_data = {
+	.csi2_phy_core = dra76x_cal_csi_phy,
+	.num_csi2_phy = ARRAY_SIZE(dra76x_cal_csi_phy),
+};
+
 /*
  * there is one cal_dev structure in the driver, it is shared by
  * all instances.
@@ -2287,6 +2317,10 @@ static const struct of_device_id cal_of_match[] = {
 		.compatible = "ti,dra72-pre-es2-cal",
 		.data = (void *)&dra72x_es1_cal_data,
 	},
+	{
+		.compatible = "ti,dra76-cal",
+		.data = (void *)&dra76x_cal_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, cal_of_match);
-- 
2.17.1

