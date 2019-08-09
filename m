Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF69FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA172171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="VJVdzO7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406985AbfHIORh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:17:37 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:63920 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbfHIORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:17:36 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79ED7aT015334;
        Fri, 9 Aug 2019 10:17:10 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2052.outbound.protection.outlook.com [104.47.36.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u9a8wg13m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 09 Aug 2019 10:17:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2VG7UfCYex9W0eqmIl2Zh8WJo8iPW2mnWAziziEmVYulVbNn+XVcJMkM2kq5yXhT1ejbKL0GERPCWy4X9oPonEXpJGzoRmGYtwDh8jdUUilGc/PGJv+aTylbvbxnq+AU62OZO6bbnAHzkput2iEGJinkjaYFc2koQfk97vjKfsff537Hi/91haeqvIUg3NtcEaoTvCgSMSBhzhR1/N0C9v/pu/CSE5WGRPmzOhqW7ZrwE/uKzHbldqcvnjqnFZqfAdiEQ1KuJKyFO0lRUF9FQxE9oGW/0lGM3M3ddFY/KX+cVk+3Z+oZH6SSuQoPQAUb8rJIaYgWTZN1P0bPlcrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLZNujszGpwFXLMRJwnU+KjjddsZRuRfuPLmmIk0YBs=;
 b=LTj4F+2/deol9UH+Lx+hL/5TXlJemhBQCWF64C/vS4XKOsSl9BRXK8nSzt0F3wsg8ciulStPJgX+1PpGyaeydhCjCbYzmT74k4q0apPOM0yKZcCLqssQrPaYI+wBRoGDsdTNBu7NdELqoWKWTNP57CSGdq8Iagyka7u5H3XRafdPFNrbR3YPaab0zfDQD+nzTFvC9yRixzBIDmhI6+HFflrset7S5PS236BtVKTcWPQBPGRfW7NzyZDhCm+f6xtb70trGL3iWLAm+OrblVHnETJ16gvWDfKdD4SQQ46xclTMmic8+Uz1IY2JYzmWvIXvwHbqc+HNf3qKov1i2+JW6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLZNujszGpwFXLMRJwnU+KjjddsZRuRfuPLmmIk0YBs=;
 b=VJVdzO7QwBFa+e3lN08yuAcYciJTIaYtEY4ol9KoqoQdcfe1RnN4tUTdEZmy2jitLbFEBMWh8tDp2+rH57uCtKCPJ49NWt53q9RS1U1qtzr9+gPEBQJ51cYEC0lqvCHkpSQT4hC0UScCjz3htfvdsOEsZW1O7spwA9LRUwOU1SY=
Received: from DM3PR03CA0011.namprd03.prod.outlook.com (2603:10b6:0:50::21) by
 BN7PR03MB4354.namprd03.prod.outlook.com (2603:10b6:408:3c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Fri, 9 Aug 2019 14:17:08 +0000
Received: from BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by DM3PR03CA0011.outlook.office365.com
 (2603:10b6:0:50::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18 via Frontend
 Transport; Fri, 9 Aug 2019 14:17:08 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT006.mail.protection.outlook.com (10.152.76.239) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Fri, 9 Aug 2019 14:17:08 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x79EH7hS005163
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 9 Aug 2019 07:17:07 -0700
Received: from btogorean-pc.ad.analog.com (10.48.65.146) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 9 Aug 2019 10:17:07 -0400
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <sam@ravnborg.org>, <gregkh@linuxfoundation.org>,
        <allison@lohutok.net>, <tglx@linutronix.de>,
        <matt.redfearn@thinci.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [PATCH v2 2/2] drm: bridge: adv7511: Add support for ADV7535
Date:   Fri, 9 Aug 2019 17:16:11 +0300
Message-ID: <20190809141611.9927-3-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809141611.9927-1-bogdan.togorean@analog.com>
References: <20190809141611.9927-1-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(189003)(199004)(316002)(51416003)(4326008)(2351001)(7696005)(50226002)(7636002)(7416002)(8936002)(106002)(50466002)(478600001)(86362001)(48376002)(5660300002)(70586007)(70206006)(305945005)(2616005)(54906003)(126002)(246002)(476003)(47776003)(1076003)(8676002)(336012)(44832011)(2870700001)(6916009)(14444005)(36756003)(5024004)(2906002)(186003)(446003)(26005)(11346002)(486006)(426003)(356004)(107886003)(6666004)(76176011)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB4354;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 074315b7-17f7-430a-68d3-08d71cd44352
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN7PR03MB4354;
X-MS-TrafficTypeDiagnostic: BN7PR03MB4354:
X-Microsoft-Antispam-PRVS: <BN7PR03MB4354E4EA381D0748AFD0007D9BD60@BN7PR03MB4354.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 01244308DF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Lwzgkgc+4HXKDlCWzln0M+fMwF8IkKFurCfwggUuzu89LCusk/B5QdwdadirOaSUri8Q2G77s86u+RIzknXtIofMwuzA8mxxpD6LqHDh5x+hOGCFRctTWVDhgYK3B8+I/2fXX1y13v0h+bmoVC7EsfbU7GVgQKCFb61IAwKLboMwF2FXqYyZGhHhhMdLB2oqD3suICHx+1R2MwawoxZez0XkIUKaD9cpdFHTs6tjdOFdhom3BFcmFx/NBrEPVADEvLFY2U1TT9m8ZfDDdTCLFzdnU6Kg8ThCw7KN/UnGPIxKzA3FBV0rTi06eBxAWAHXpHA7LchBMD9VcFntFGbFaFwKDbgbRIK/0W8jo8Mr0KYXXokHLevVhd8zWzWIB4kpcwzSL1PoQqw+BZrYXvW9K/2uXugKNEQnX1Ci0Pyp5cw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2019 14:17:08.3362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 074315b7-17f7-430a-68d3-08d71cd44352
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4354
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADV7535 is a DSI to HDMI bridge chip like ADV7533 but it allows
1080p@60Hz. v1p2 is fixed to 1.8V on ADV7535 but on ADV7533 can be 1.2V
or 1.8V and is configurable in a register.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---
 drivers/gpu/drm/bridge/adv7511/Kconfig       |  8 ++---
 drivers/gpu/drm/bridge/adv7511/Makefile      |  2 +-
 drivers/gpu/drm/bridge/adv7511/adv7511.h     |  4 ++-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 34 ++++++++++++++------
 4 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/Kconfig b/drivers/gpu/drm/bridge/adv7511/Kconfig
index 8a56ff81f4fb..fa43acd46ab7 100644
--- a/drivers/gpu/drm/bridge/adv7511/Kconfig
+++ b/drivers/gpu/drm/bridge/adv7511/Kconfig
@@ -15,16 +15,16 @@ config DRM_I2C_ADV7511_AUDIO
 	  Support the ADV7511 HDMI Audio interface. This is used in
 	  conjunction with the AV7511  HDMI driver.
 
-config DRM_I2C_ADV7533
-	bool "ADV7533 encoder"
+config DRM_I2C_ADV753x
+	bool "ADV753x encoder"
 	depends on DRM_I2C_ADV7511
 	select DRM_MIPI_DSI
 	default y
 	help
-	  Support for the Analog Devices ADV7533 DSI to HDMI encoder.
+	  Support for the Analog Devices ADV7533/5 DSI to HDMI encoder.
 
 config DRM_I2C_ADV7511_CEC
-	bool "ADV7511/33 HDMI CEC driver"
+	bool "ADV7511/33/35 HDMI CEC driver"
 	depends on DRM_I2C_ADV7511
 	select CEC_CORE
 	default y
diff --git a/drivers/gpu/drm/bridge/adv7511/Makefile b/drivers/gpu/drm/bridge/adv7511/Makefile
index b46ebeb35fd4..319efddb268e 100644
--- a/drivers/gpu/drm/bridge/adv7511/Makefile
+++ b/drivers/gpu/drm/bridge/adv7511/Makefile
@@ -2,5 +2,5 @@
 adv7511-y := adv7511_drv.o
 adv7511-$(CONFIG_DRM_I2C_ADV7511_AUDIO) += adv7511_audio.o
 adv7511-$(CONFIG_DRM_I2C_ADV7511_CEC) += adv7511_cec.o
-adv7511-$(CONFIG_DRM_I2C_ADV7533) += adv7533.o
+adv7511-$(CONFIG_DRM_I2C_ADV753x) += adv7533.o
 obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511.o
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
index 52b2adfdc877..38288c3c3c53 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
@@ -91,6 +91,7 @@
 #define ADV7511_REG_ARC_CTRL			0xdf
 #define ADV7511_REG_CEC_I2C_ADDR		0xe1
 #define ADV7511_REG_CEC_CTRL			0xe2
+#define ADV7511_REG_SUPPLY_SELECT		0xe4
 #define ADV7511_REG_CHIP_ID_HIGH		0xf5
 #define ADV7511_REG_CHIP_ID_LOW			0xf6
 
@@ -320,6 +321,7 @@ struct adv7511_video_config {
 enum adv7511_type {
 	ADV7511,
 	ADV7533,
+	ADV7535,
 };
 
 #define ADV7511_MAX_ADDRS 3
@@ -393,7 +395,7 @@ static inline int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511)
 }
 #endif
 
-#ifdef CONFIG_DRM_I2C_ADV7533
+#ifdef CONFIG_DRM_I2C_ADV753x
 void adv7533_dsi_power_on(struct adv7511 *adv);
 void adv7533_dsi_power_off(struct adv7511 *adv);
 void adv7533_mode_set(struct adv7511 *adv, const struct drm_display_mode *mode);
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index f6d2681f6927..b1501344df3e 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -367,7 +367,7 @@ static void adv7511_power_on(struct adv7511 *adv7511)
 	 */
 	regcache_sync(adv7511->regmap);
 
-	if (adv7511->type == ADV7533)
+	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
 		adv7533_dsi_power_on(adv7511);
 	adv7511->powered = true;
 }
@@ -387,7 +387,7 @@ static void __adv7511_power_off(struct adv7511 *adv7511)
 static void adv7511_power_off(struct adv7511 *adv7511)
 {
 	__adv7511_power_off(adv7511);
-	if (adv7511->type == ADV7533)
+	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
 		adv7533_dsi_power_off(adv7511);
 	adv7511->powered = false;
 }
@@ -761,7 +761,7 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
 	regmap_update_bits(adv7511->regmap, 0x17,
 		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
 
-	if (adv7511->type == ADV7533)
+	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
 		adv7533_mode_set(adv7511, adj_mode);
 
 	drm_mode_copy(&adv7511->curr_mode, adj_mode);
@@ -874,7 +874,7 @@ static int adv7511_bridge_attach(struct drm_bridge *bridge)
 				 &adv7511_connector_helper_funcs);
 	drm_connector_attach_encoder(&adv->connector, bridge->encoder);
 
-	if (adv->type == ADV7533)
+	if (adv->type == ADV7533 || adv->type == ADV7535)
 		ret = adv7533_attach_dsi(adv);
 
 	if (adv->i2c_main->irq)
@@ -903,6 +903,7 @@ static const char * const adv7511_supply_names[] = {
 	"dvdd-3v",
 };
 
+/* The order of entries is important. If changed update hardcoded indices */
 static const char * const adv7533_supply_names[] = {
 	"avdd",
 	"dvdd",
@@ -952,7 +953,7 @@ static bool adv7511_cec_register_volatile(struct device *dev, unsigned int reg)
 	struct i2c_client *i2c = to_i2c_client(dev);
 	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
 
-	if (adv7511->type == ADV7533)
+	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
 		reg -= ADV7533_REG_CEC_OFFSET;
 
 	switch (reg) {
@@ -994,7 +995,7 @@ static int adv7511_init_cec_regmap(struct adv7511 *adv)
 		goto err;
 	}
 
-	if (adv->type == ADV7533) {
+	if (adv->type == ADV7533 || adv->type == ADV7535) {
 		ret = adv7533_patch_cec_registers(adv);
 		if (ret)
 			goto err;
@@ -1094,8 +1095,9 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	struct adv7511_link_config link_config;
 	struct adv7511 *adv7511;
 	struct device *dev = &i2c->dev;
+	struct regulator *reg_v1p2;
 	unsigned int val;
-	int ret;
+	int ret, reg_v1p2_uV;
 
 	if (!dev->of_node)
 		return -EINVAL;
@@ -1163,6 +1165,16 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	if (ret)
 		goto uninit_regulators;
 
+	if (adv7511->type == ADV7533) {
+		reg_v1p2 = adv7511->supplies[5].consumer;
+		reg_v1p2_uV = regulator_get_voltage(reg_v1p2);
+
+		if (reg_v1p2_uV == 1200000) {
+			regmap_update_bits(adv7511->regmap,
+				ADV7511_REG_SUPPLY_SELECT, 0x80, 0x80);
+		}
+	}
+
 	adv7511_packet_disable(adv7511, 0xffff);
 
 	adv7511->i2c_edid = i2c_new_secondary_device(i2c, "edid",
@@ -1242,7 +1254,7 @@ static int adv7511_remove(struct i2c_client *i2c)
 {
 	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
 
-	if (adv7511->type == ADV7533)
+	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
 		adv7533_detach_dsi(adv7511);
 	i2c_unregister_device(adv7511->i2c_cec);
 	if (adv7511->cec_clk)
@@ -1266,8 +1278,9 @@ static const struct i2c_device_id adv7511_i2c_ids[] = {
 	{ "adv7511", ADV7511 },
 	{ "adv7511w", ADV7511 },
 	{ "adv7513", ADV7511 },
-#ifdef CONFIG_DRM_I2C_ADV7533
+#ifdef CONFIG_DRM_I2C_ADV753x
 	{ "adv7533", ADV7533 },
+	{ "adv7535", ADV7535 },
 #endif
 	{ }
 };
@@ -1277,8 +1290,9 @@ static const struct of_device_id adv7511_of_ids[] = {
 	{ .compatible = "adi,adv7511", .data = (void *)ADV7511 },
 	{ .compatible = "adi,adv7511w", .data = (void *)ADV7511 },
 	{ .compatible = "adi,adv7513", .data = (void *)ADV7511 },
-#ifdef CONFIG_DRM_I2C_ADV7533
+#ifdef CONFIG_DRM_I2C_ADV753x
 	{ .compatible = "adi,adv7533", .data = (void *)ADV7533 },
+	{ .compatible = "adi,adv7535", .data = (void *)ADV7535 },
 #endif
 	{ }
 };
-- 
2.22.0

