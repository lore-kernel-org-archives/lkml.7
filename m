Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498FCC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0706520862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="QCMzft6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbfJDLRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 07:17:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3724 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730061AbfJDLRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 07:17:34 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94B8XND021691;
        Fri, 4 Oct 2019 07:17:07 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2va4e88998-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 07:17:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEIF9/wv8aYJkiZxEkZLvVk7Do8q8lwNGowD8P3sly0Jyfv/isAQ2PIN0s11lITsGAuEIl+wuKNGt1pTv+H44M6Q5Qvzrd+fkStpToUwV4g1IUtawwqMAiJxalbgbz6GoIWtPe4CxFEORAemeGXcDWpjgJcuG6lLwkKzEkZIJjizCQL/gzqA6UQy9suhXbUaRfR/0yfSxMm8hiIgxM80wMMTxZ3yx7NmqiI0uJyRLcBlzuPoYoI5b/UpWuywIX1RH8laRyON4pXMkVcr22jM0IwE5biWyrdd5gc66GOYqSNWy8V6gQzImVYODszo9tn7eC7C1TeAbCk2QnKn392nRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+B3Ir2C9sUmEs5tCo88lm09Okak+DA902otRY59QvU=;
 b=l4u6ZxkT7ZQWZ63t3b0Qqji4ei78r3v8eb2E3aSUDmZddRIOSrza6J21U+O+UmqgNFNngcLEBT+w7KNsibCcZWmEINhLd9VBbAK2y5E7lamudXTxwB6IBer1SBncCDJajFimr0FN/jCjKK7VN38YBOCqPoYhd4nvC7SORRLcDdLERFcEKFOeHvI6Us86ZoZ6yg2qxOP94cz9pQiXd0T28qe5jDKy/TMl1Altsk2mpmvAE+pwVg+ulIb/taTTpohYighI6LLgRFnWVeUVy/CseiVXqNUYssv6Ds2+jbmpoaiVa4+StYNERxW22vqZf9OF6VyPDslcAeB1mrfMfZtE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=baylibre.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+B3Ir2C9sUmEs5tCo88lm09Okak+DA902otRY59QvU=;
 b=QCMzft6g6SJp3DkhlfiI6SD/oj5CM1nf2xYR3cpLmyWdnttqPMGBNEOjpeU1VGA7Zv/jSzTQnoI/7Tnrbq3bSLyxfqLNmjDf71IPJVpxsNWpM3j7LnPqr0An7u/6erbF80l6pqmFX2rCr3oAjzNY0oSCFYM0pzMjaYzc8eTsTdo=
Received: from BYAPR03CA0017.namprd03.prod.outlook.com (2603:10b6:a02:a8::30)
 by BN7PR03MB4403.namprd03.prod.outlook.com (2603:10b6:408:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23; Fri, 4 Oct
 2019 11:17:05 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BYAPR03CA0017.outlook.office365.com
 (2603:10b6:a02:a8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.17 via Frontend
 Transport; Fri, 4 Oct 2019 11:17:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2327.21
 via Frontend Transport; Fri, 4 Oct 2019 11:17:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x94BH2YP026934
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 4 Oct 2019 04:17:02 -0700
Received: from btogorean-pc.ad.analog.com (10.48.65.146) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 4 Oct 2019 07:17:02 -0400
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <narmstrong@baylibre.com>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>,
        <allison@lohutok.net>, <tglx@linutronix.de>, <rfontana@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [PATCH 1/2] drm: bridge: adv7511: Enable SPDIF DAI
Date:   Fri, 4 Oct 2019 14:16:15 +0300
Message-ID: <20191004111615.30293-1-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(50466002)(70206006)(70586007)(106002)(54906003)(36756003)(51416003)(6666004)(356004)(2351001)(478600001)(316002)(48376002)(2906002)(2870700001)(7696005)(47776003)(7416002)(14444005)(6916009)(50226002)(8936002)(305945005)(8676002)(1076003)(246002)(7636002)(44832011)(186003)(426003)(86362001)(26005)(5660300002)(2616005)(126002)(486006)(4326008)(476003)(107886003)(336012)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB4403;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9557b4d-ffed-4e14-422e-08d748bc6307
X-MS-TrafficTypeDiagnostic: BN7PR03MB4403:
X-Microsoft-Antispam-PRVS: <BN7PR03MB440310D53B1E8DF4BFC8F09A9B9E0@BN7PR03MB4403.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-Forefront-PRVS: 018093A9B5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4ORuIhiJ1uMjrkXN9VmYXlZWaAU7SP6js+HttAQx4rqM6pnIS3IcFmFbdfpYh2czh75Q6RvcH8HORlYh7G7+/anAxQgNEUdQGKzKsvTbWVXEOgysNVzc07Q1VUYv/dmZ1B5hmROrMTdQjijqOvh8dHUJbMIZ3Bd721wBGlal1VVSt4CtWJnNb0UxLmkhXxF0yj9pApyKcevFPfR07FnLTWtUPiL0n3TsgKYQM7Mr6dCv6KCwYjo95bF7XpNlayTzRqbE+/oM/VG943QhqJGINQXR7xW/7nXIcVTrx1z+lEy0EJDGU81Sn127BTuMdjpzD7i5hdZ82NE7vGDLfhz389dDrb96RnB+0EnpSl6mgygqJpi02u7UMaARWZ8Z90hsQZbBbJbqeBitFK0K5WOY2NBG+R2waBha7TYmanAJv0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2019 11:17:04.7014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9557b4d-ffed-4e14-422e-08d748bc6307
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4403
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_06:2019-10-03,2019-10-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=936 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 suspectscore=1 clxscore=1011 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910040105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADV7511 support I2S or SPDIF as audio input interfaces. This commit
enable support for SPDIF.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index a428185be2c1..96be7b005c50 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -119,6 +119,8 @@ int adv7511_hdmi_hw_params(struct device *dev, void *data,
 		audio_source = ADV7511_AUDIO_SOURCE_I2S;
 		i2s_format = ADV7511_I2S_FORMAT_LEFT_J;
 		break;
+	case HDMI_SPDIF:
+		audio_source = ADV7511_AUDIO_SOURCE_SPDIF;
 	default:
 		return -EINVAL;
 	}
@@ -175,11 +177,21 @@ static int audio_startup(struct device *dev, void *data)
 	/* use Audio infoframe updated info */
 	regmap_update_bits(adv7511->regmap, ADV7511_REG_GC(1),
 				BIT(5), 0);
+	/* enable SPDIF receiver */
+	if (adv7511->audio_source == ADV7511_AUDIO_SOURCE_SPDIF)
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG,
+				   BIT(7), BIT(7));
+
 	return 0;
 }
 
 static void audio_shutdown(struct device *dev, void *data)
 {
+	struct adv7511 *adv7511 = dev_get_drvdata(dev);
+
+	if (adv7511->audio_source == ADV7511_AUDIO_SOURCE_SPDIF)
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG,
+				   BIT(7), 0);
 }
 
 static int adv7511_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
@@ -213,6 +225,7 @@ static const struct hdmi_codec_pdata codec_data = {
 	.ops = &adv7511_codec_ops,
 	.max_i2s_channels = 2,
 	.i2s = 1,
+	.spdif = 1,
 };
 
 int adv7511_audio_init(struct device *dev, struct adv7511 *adv7511)
-- 
2.23.0

