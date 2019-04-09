Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471C7C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3072064B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="EM4PQodk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfDINff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:35:35 -0400
Received: from mail-eopbgr680046.outbound.protection.outlook.com ([40.107.68.46]:38149
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbfDINfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBOeMXQ3N1N4Ec9oDE3gTMh2CDZQaL+V/HHn9qljcm8=;
 b=EM4PQodk5xDHiXf4MuX1F2JLcLrcfWMP2W9t1sGieLDVFbaTPQVjXAVizlblTGC0ypAjBMyqfoyI0dNnApy6HVvujFts6SpjJs7BdQMZ5E3WpHMQrZiPnQkp3JgTHQgEwLb/CGuVTPMTp9ue798eh5wHn7ssRluUL9c4v4S8W1I=
Received: from DM6PR03CA0063.namprd03.prod.outlook.com (20.178.24.40) by
 SN2PR03MB2270.namprd03.prod.outlook.com (10.166.210.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Tue, 9 Apr 2019 13:35:31 +0000
Received: from CY1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by DM6PR03CA0063.outlook.office365.com
 (2603:10b6:5:100::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16 via Frontend
 Transport; Tue, 9 Apr 2019 13:35:31 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT032.mail.protection.outlook.com (10.152.75.184) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Tue, 9 Apr 2019 13:35:30 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x39DZTfl000796
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 9 Apr 2019 06:35:29 -0700
Received: from mircea-Latitude-E6540.analog.com (10.50.3.101) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 9 Apr 2019 09:35:29 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH] iio: dac: ad5758: Modifications for new revision
Date:   Tue, 9 Apr 2019 16:35:21 +0300
Message-ID: <20190409133521.24828-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(189003)(199004)(7636002)(106466001)(51416003)(7696005)(486006)(107886003)(47776003)(106002)(336012)(53416004)(305945005)(476003)(6916009)(16586007)(77096007)(2351001)(186003)(86362001)(4326008)(44832011)(54906003)(5660300002)(426003)(126002)(2616005)(316002)(1076003)(356004)(6666004)(72206003)(50466002)(478600001)(8676002)(8936002)(26005)(50226002)(2906002)(246002)(36756003)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2270;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5add367-fd43-482c-a6f6-08d6bcf03c42
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:SN2PR03MB2270;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2270:
X-Microsoft-Antispam-PRVS: <SN2PR03MB2270206256A5CAF519AEFD4D812D0@SN2PR03MB2270.namprd03.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ynRf381ABkMxvSWREjsCPfWLb9IpWgRrxwBB0WULQS5GgsSdesSeSVXdoi21rVf4+l6YHsjuURy4rHK4tyI7UusIpNWfzkBTkKwuMWoZmZ8blsTWD9hhzOtbNrHn2KumXskYAq1GYu91LlWZdWBgB5dXyKkEfLGy5IOmd6rMjpszWxUS7K0SG1K/zxAHPnocR0GdQYFlbOjHw9PEx/jdWY5DOt0tbGqcWT+B+XhlmZkIbqAGOHUdI3Dg9tDQe/gyAYBgJizYfu9/VmzzwGrPT/I92PnsLuG0fpoUh3e9/ehKax0+XDMZni+NiXFR97VkAaydruKqaOkKoqBRnhAQKLKc2icZyPRXrsYMR3Ntu1Fnxt6cAi4ymfwFEkyFLIUc/3+SoNlfTpaabGmD0h6dD6zOqAFiqB8s2oibpIuowF0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 13:35:30.4434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5add367-fd43-482c-a6f6-08d6bcf03c42
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2270
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will ensure compatibility with the new revision of the AD5758
dac converter. The modifications consist of removing the fault_prot_switch
function since this option is no longer available, and enabling the
ENABLE_PPC_BUFFERS bit in ADC_CONFIG register before setting the PPC
current mode.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/dac/ad5758.c | 55 +++++++++++++---------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 2bdf1b0aee06..a513c70faefa 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -72,8 +72,6 @@
 #define AD5758_DCDC_CONFIG1_DCDC_VPROG_MODE(x)	(((x) & 0x1F) << 0)
 #define AD5758_DCDC_CONFIG1_DCDC_MODE_MSK	GENMASK(6, 5)
 #define AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(x)	(((x) & 0x3) << 5)
-#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK	BIT(7)
-#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(x)	(((x) & 0x1) << 7)
 
 /* AD5758_DCDC_CONFIG2 */
 #define AD5758_DCDC_CONFIG2_ILIMIT_MSK		GENMASK(3, 1)
@@ -84,6 +82,10 @@
 /* AD5758_DIGITAL_DIAG_RESULTS */
 #define AD5758_CAL_MEM_UNREFRESHED_MSK		BIT(15)
 
+/* AD5758_ADC_CONFIG */
+#define AD5758_ADC_CONFIG_PPC_BUF_EN(x)		(((x) & 0x1) << 11)
+#define AD5758_ADC_CONFIG_PPC_BUF_MSK		BIT(11)
+
 #define AD5758_WR_FLAG_MSK(x)		(0x80 | ((x) & 0x1F))
 
 #define AD5758_FULL_SCALE_MICRO	65535000000ULL
@@ -315,6 +317,18 @@ static int ad5758_set_dc_dc_conv_mode(struct ad5758_state *st,
 {
 	int ret;
 
+	/*
+	 * The ENABLE_PPC_BUFFERS bit must be set prior to enabling PPC current
+	 * mode.
+	 */
+	if (mode == AD5758_DCDC_MODE_PPC_CURRENT) {
+		ret  = ad5758_spi_write_mask(st, AD5758_ADC_CONFIG,
+				    AD5758_ADC_CONFIG_PPC_BUF_MSK,
+				    AD5758_ADC_CONFIG_PPC_BUF_EN(1));
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
 				    AD5758_DCDC_CONFIG1_DCDC_MODE_MSK,
 				    AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(mode));
@@ -444,23 +458,6 @@ static int ad5758_set_out_range(struct ad5758_state *st, int range)
 					     AD5758_CAL_MEM_UNREFRESHED_MSK);
 }
 
-static int ad5758_fault_prot_switch_en(struct ad5758_state *st, bool enable)
-{
-	int ret;
-
-	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
-			AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK,
-			AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(enable));
-	if (ret < 0)
-		return ret;
-	/*
-	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
-	 * This allows the 3-wire interface communication to complete.
-	 */
-	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
-					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
-}
-
 static int ad5758_internal_buffers_en(struct ad5758_state *st, bool enable)
 {
 	int ret;
@@ -585,8 +582,8 @@ static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5758_state *st = iio_priv(indio_dev);
 	bool pwr_down;
-	unsigned int dcdc_config1_mode, dc_dc_mode, dac_config_mode, val;
-	unsigned long int dcdc_config1_msk, dac_config_msk;
+	unsigned int dc_dc_mode, dac_config_mode, val;
+	unsigned long int dac_config_msk;
 	int ret;
 
 	ret = kstrtobool(buf, &pwr_down);
@@ -602,17 +599,6 @@ static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
 		val = 1;
 	}
 
-	dcdc_config1_mode = AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(dc_dc_mode) |
-			    AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(val);
-	dcdc_config1_msk = AD5758_DCDC_CONFIG1_DCDC_MODE_MSK |
-			   AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK;
-
-	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
-				    dcdc_config1_msk,
-				    dcdc_config1_mode);
-	if (ret < 0)
-		goto err_unlock;
-
 	dac_config_mode = AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
 			  AD5758_DAC_CONFIG_INT_EN_MODE(val);
 	dac_config_msk = AD5758_DAC_CONFIG_OUT_EN_MSK |
@@ -841,11 +827,6 @@ static int ad5758_init(struct ad5758_state *st)
 			return ret;
 	}
 
-	/* Enable the VIOUT fault protection switch (FPS is closed) */
-	ret = ad5758_fault_prot_switch_en(st, 1);
-	if (ret < 0)
-		return ret;
-
 	/* Power up the DAC and internal (INT) amplifiers */
 	ret = ad5758_internal_buffers_en(st, 1);
 	if (ret < 0)
-- 
2.17.1

