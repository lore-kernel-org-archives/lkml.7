Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297E4C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB03F206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="xd8n5QE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfG3NTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:19:42 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:53756 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730717AbfG3NTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:19:40 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UDHcxG009738;
        Tue, 30 Jul 2019 09:18:23 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2058.outbound.protection.outlook.com [104.47.50.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u2hg2s45b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 09:18:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvKNBcuv7aw9xU4GSjWmARVTzqfmMEB7B0gjEL7DhBi41TF7Czf5nc7tzg5+F1MHy3fdAuGgD3jls83uX3hV+eVWr4Bn+2nNVz8882ikgz4vQIOEWH78+E7IVfcfiS72m7jDinfwTcgBow/mCkjFQM7e4V/3b+nYBriYCLGD8P6X8IX8lyUpjGNW5D7Fay49n8v68OluukCX+ziOa/f9gyzmNaE96EscS09Mls4atYG+dLVJuJdTwugjqmlFLk1SzRNmPVYWgoE2kxhAcpvzBZiHJj/LIsdLb/djLQn8qGbUZXQJslbveVOc4qfQ5KdFGA+K6N9cthwmui+ymtpaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2SrJ4wk4uUCutofdOpios8mTyEHFTls/g28JLA1fqo=;
 b=D6I4uJZKxdbeY/rvRRDZeyw7iHbnADV4kD9CyNT9HI9DbWRgA2rw+1OcnPHj+bpbwOUt8kwd1XEV+x89fO/kOVL5igHv/A/V3PsjBOflzN6IjZCaaeMXcQgoyu0TBgk/7B+T1vJuzLrZTp0rZ5kZPcLXVgWrHbAAdDL7QamdOw0PEabc96n5HHJgOXyQeNX+igp+Z7TEuk4GfDRUj/5OJDBQirvwG+RNYIpABJLJbI+7lT/gJ0y4m0dJLCxLfnefASvrMCH0FMUZlvaoR2bo37hi4jjj3/xmQ6GCvk2KXTA0cfI7kmjTPHE8GfOH3NbyORYYSwfPVg04pj+j637gqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2SrJ4wk4uUCutofdOpios8mTyEHFTls/g28JLA1fqo=;
 b=xd8n5QE6C6Wg9ES+nkSwUsgjQ4qL8oq2LUDfxo8kjTxjd79RMusb1n1AicX3lIb0t2ch7FKVcOIiCirY0/cOi1RLCwtyR2DKp33+L1OTDskN45EsJe2unva3qQZJiQvvYaHIffuf4LHtlYIl7afk7otd9olpFrBTjIJcIMC7apo=
Received: from CY4PR03CA0086.namprd03.prod.outlook.com (2603:10b6:910:4d::27)
 by MWHPR03MB3054.namprd03.prod.outlook.com (2603:10b6:300:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.15; Tue, 30 Jul
 2019 13:18:21 +0000
Received: from BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by CY4PR03CA0086.outlook.office365.com
 (2603:10b6:910:4d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.13 via Frontend
 Transport; Tue, 30 Jul 2019 13:18:20 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT041.mail.protection.outlook.com (10.152.77.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2115.10
 via Frontend Transport; Tue, 30 Jul 2019 13:18:20 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6UDIK1H025912
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 30 Jul 2019 06:18:20 -0700
Received: from btogorean-pc.ad.analog.com (10.48.65.146) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 30 Jul 2019 09:18:19 -0400
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <sam@ravnborg.org>, <gregkh@linuxfoundation.org>,
        <allison@lohutok.net>, <tglx@linutronix.de>,
        <matt.redfearn@thinci.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [PATCH 2/2] drm: bridge: adv7511: Add support for ADV7535
Date:   Tue, 30 Jul 2019 16:17:36 +0300
Message-ID: <20190730131736.30187-3-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730131736.30187-1-bogdan.togorean@analog.com>
References: <20190730131736.30187-1-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(199004)(189003)(6666004)(6916009)(76176011)(486006)(7416002)(356004)(7696005)(14444005)(5024004)(107886003)(36756003)(51416003)(446003)(336012)(426003)(5660300002)(126002)(50226002)(2616005)(305945005)(476003)(4326008)(316002)(11346002)(70586007)(2906002)(54906003)(478600001)(50466002)(48376002)(86362001)(70206006)(1076003)(2351001)(186003)(246002)(8676002)(44832011)(26005)(7636002)(8936002)(47776003)(106002)(2870700001)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3054;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fd81e4d-547d-4fe1-c777-08d714f0647b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MWHPR03MB3054;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3054:
X-Microsoft-Antispam-PRVS: <MWHPR03MB30547B19431DBA8913CD69489BDC0@MWHPR03MB3054.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0114FF88F6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: y8ZPrH9yWA20OHpiwJEbVcWj4zSaNR3VEvpM4adrFNNKGCKA91WbFRlwASqNjq2owUGw0nGmJ2edww4AoQhKOXXIdrCIAugexoabbreAurGFpenlJpm/Fir+qt/KwgktRu507fbfwfReqjVv5rCa5AabbAaG20JjNTBBFqQTa6lzJLbgU50wgJ8/v41zK08JY7DtE+yTIYRhhrgHKkNkuVZ4gRhSVarNeG04WaOiNc5xzjQwAnMFQK/ing5oZJPzTwDSfFsCinJmqdH+QEMsW3AA2FgNfCN8KvoTUTbyk2CrwyQKrPB6PWA/R4oBM8ktOl9OXK4jLWK4ejfPf5tfaU2Q/MeKqHsOD5m2TxawCYho/H3lXnIwvKiBmThDsp3/Af3AuzC4+ZYuQtKqmOLeI+qK+8qCc8KFSedcNozxB48=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2019 13:18:20.5663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd81e4d-547d-4fe1-c777-08d714f0647b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3054
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADV7535 is a DSI to HDMI bridge chip like ADV7533 but it allows
1080p@60Hz. v1p2 is fixed to 1.8V on ADV7535 but on ADV7533 can be 1.2V
or 1.8V and is configurable in a register.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511.h     |  2 ++
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 31 +++++++++++++++-----
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
index 52b2adfdc877..702432615ec8 100644
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
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index f6d2681f6927..941072decb73 100644
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
@@ -952,7 +952,7 @@ static bool adv7511_cec_register_volatile(struct device *dev, unsigned int reg)
 	struct i2c_client *i2c = to_i2c_client(dev);
 	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
 
-	if (adv7511->type == ADV7533)
+	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
 		reg -= ADV7533_REG_CEC_OFFSET;
 
 	switch (reg) {
@@ -994,7 +994,7 @@ static int adv7511_init_cec_regmap(struct adv7511 *adv)
 		goto err;
 	}
 
-	if (adv->type == ADV7533) {
+	if (adv->type == ADV7533 || adv->type == ADV7535) {
 		ret = adv7533_patch_cec_registers(adv);
 		if (ret)
 			goto err;
@@ -1094,8 +1094,9 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	struct adv7511_link_config link_config;
 	struct adv7511 *adv7511;
 	struct device *dev = &i2c->dev;
+	struct regulator *reg_v1p2;
 	unsigned int val;
-	int ret;
+	int ret, reg_v1p2_uV;
 
 	if (!dev->of_node)
 		return -EINVAL;
@@ -1163,6 +1164,18 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	if (ret)
 		goto uninit_regulators;
 
+	if (adv7511->type == ADV7533) {
+		ret = match_string(adv7533_supply_names, adv7511->num_supplies,
+									"v1p2");
+		reg_v1p2 = adv7511->supplies[ret].consumer;
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
@@ -1242,7 +1255,7 @@ static int adv7511_remove(struct i2c_client *i2c)
 {
 	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
 
-	if (adv7511->type == ADV7533)
+	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
 		adv7533_detach_dsi(adv7511);
 	i2c_unregister_device(adv7511->i2c_cec);
 	if (adv7511->cec_clk)
@@ -1268,6 +1281,7 @@ static const struct i2c_device_id adv7511_i2c_ids[] = {
 	{ "adv7513", ADV7511 },
 #ifdef CONFIG_DRM_I2C_ADV7533
 	{ "adv7533", ADV7533 },
+	{ "adv7535", ADV7535 },
 #endif
 	{ }
 };
@@ -1279,6 +1293,7 @@ static const struct of_device_id adv7511_of_ids[] = {
 	{ .compatible = "adi,adv7513", .data = (void *)ADV7511 },
 #ifdef CONFIG_DRM_I2C_ADV7533
 	{ .compatible = "adi,adv7533", .data = (void *)ADV7533 },
+	{ .compatible = "adi,adv7535", .data = (void *)ADV7535 },
 #endif
 	{ }
 };
-- 
2.22.0

