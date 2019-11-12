Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423FAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8E321925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="cILbNzKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKLNgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:36:45 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38376 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbfKLNgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:36:43 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xACDXcEN006948;
        Tue, 12 Nov 2019 08:36:22 -0500
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2058.outbound.protection.outlook.com [104.47.48.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w7prk8rv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 08:36:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCDYHrXOu4wmgETTCSL2NQD0DJmNkVhBR2LFXSMc0xt8TS8IL4xt0SX0ZjkN/E8HCQfJTtV1gLYg7yKUsBGTmE4Owu8yTlf1Sn7xJku5/SLwD8nCD4jsG0JNr+YkYIVGeidtJiHWAKG2cS6Pe0HdzgEHjqxBCexDBLwtbmUH+UeA83jHGqy0YSQq4MRiFdK962q6XB3h64mHS1sfyj6u6hZjTig8LpZk1bLrZa1Eskf4l1QIqeWmfO+aA/icGFU3NlPkwV6ZZP4YJoLvNen7T87/+l3Tm/5gD2JgjCVgDwTIrMH9tq+0JRWKb2rMkGTb3e3jOhYg6JkWQ0xgewKH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmLwiKHjVwAxJ99g5UZRw0G3u42VHrBU/uBc4cd1BB4=;
 b=gxKrqj36UMeYbfRKSeT3SMTI2/mgLQNJz89nl2+dIZ89OTeRfVpfO7iL0Kmc7tmAR0K4ACM5IGMrMKZpKGgBeOCo31EI7Y/XNalRBY5PxCg5/aoTsDGJYjffD5dCTvVC2eeAiLjpLFWr9nMZzq9EWc5oVz5CrQFeNUH322VNJ7Q1VMXb9fd3YySjbWnhZRphQzPdc9wf5YWhpD7yA+0MCKsbKTyFOsHmnmmFjG5gfJk364qXf41YvUFOKpXIeri4qbtSo0CBqDoLxvekB12aM61hIu/+qplWHlTRsxcS6Z94zoYPk012gqa99vw28UidmzGN+ktYxf0YmCzy+HikRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=baylibre.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmLwiKHjVwAxJ99g5UZRw0G3u42VHrBU/uBc4cd1BB4=;
 b=cILbNzKaEyvBpNUhu4X0NSqO9jNoBJ8tr72L1cGs3PmyVJN30CIWHSJ/QtZ7TFo3Nu9BM4fXmR0ust4nD1iRJbH+KuFQORKffTqZQlBatS/CFmHnJTwQ9gGsVNoGTu0hDWqH7NwWV41nwlQUHiy06X7H4Kx3M0erUMNRG6kbJy8=
Received: from DM6PR03CA0030.namprd03.prod.outlook.com (2603:10b6:5:40::43) by
 CY4PR03MB3048.namprd03.prod.outlook.com (2603:10b6:903:137::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 13:36:19 +0000
Received: from SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by DM6PR03CA0030.outlook.office365.com
 (2603:10b6:5:40::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22 via Frontend
 Transport; Tue, 12 Nov 2019 13:36:19 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT014.mail.protection.outlook.com (10.152.72.106) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 13:36:19 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xACDaH7X021888
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 12 Nov 2019 05:36:17 -0800
Received: from btogorean-pc.ad.analog.com (10.48.65.146) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 12 Nov 2019 08:36:16 -0500
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <narmstrong@baylibre.com>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>, <tglx@linutronix.de>,
        <alexios.zavras@intel.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [RESEND PATCH 1/2] drm: bridge: adv7511: Enable SPDIF DAI
Date:   Tue, 12 Nov 2019 15:34:51 +0200
Message-ID: <20191112133452.8493-1-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(189003)(199004)(4326008)(47776003)(356004)(6666004)(2351001)(2616005)(6916009)(51416003)(7696005)(478600001)(305945005)(7636002)(486006)(186003)(44832011)(476003)(126002)(336012)(7416002)(2870700001)(26005)(14444005)(36756003)(426003)(86362001)(70586007)(8676002)(106002)(54906003)(50226002)(2906002)(70206006)(316002)(8936002)(50466002)(5660300002)(1076003)(48376002)(246002)(107886003)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3048;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad0dca27-db26-49af-657b-08d767754cc0
X-MS-TrafficTypeDiagnostic: CY4PR03MB3048:
X-Microsoft-Antispam-PRVS: <CY4PR03MB3048A514435F35E98A1DF5159B770@CY4PR03MB3048.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gf6kTt2D327Ob9ae2eWtUtNLXZy+eIID6pDN6ljVM83hslLIvH6YwJREwI8YoWqdIauLAAlG7ZCL+cKV4HKQIy471JKeplDG530dH9VhzkEHKVjtjsDOudia88Kqa3bjPqWBC5M85hcsQjorE366Qp0aXbagz1B3Uj3Pyg1ZZdF+nr8iTf4jEajAZO51eGNcGCShBBFGdPZenkLMUbUOEUnO2qMR9v8OFBbNqkTwMSxC+hIobUqVC/S3XCF7xICnPusYRYanHpIDvFgpQzFJx9+Ch1tm5tL0+0iiorBgRPSQvUe4HGBhk3nuXZEfVA166N6s4wfjjkvc/I0JUavSw2b8P2rif3JUbxacSH17n3wnqQsnwzZKcTMWN1aqkNm7n3q9MjRQ71EdFHNBnfzAzMlayyas5Y8pjCoXjBduyMfWasR+DWeYjSCnHmQ8FylX
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 13:36:19.1515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0dca27-db26-49af-657b-08d767754cc0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3048
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_04:2019-11-11,2019-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=1 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911120122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADV7511 support I2S or SPDIF as audio input interfaces. This commit
enable support for SPDIF.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index a428185be2c1..1e9b128d229b 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -119,6 +119,9 @@ int adv7511_hdmi_hw_params(struct device *dev, void *data,
 		audio_source = ADV7511_AUDIO_SOURCE_I2S;
 		i2s_format = ADV7511_I2S_FORMAT_LEFT_J;
 		break;
+	case HDMI_SPDIF:
+		audio_source = ADV7511_AUDIO_SOURCE_SPDIF;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -175,11 +178,21 @@ static int audio_startup(struct device *dev, void *data)
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
@@ -213,6 +226,7 @@ static const struct hdmi_codec_pdata codec_data = {
 	.ops = &adv7511_codec_ops,
 	.max_i2s_channels = 2,
 	.i2s = 1,
+	.spdif = 1,
 };
 
 int adv7511_audio_init(struct device *dev, struct adv7511 *adv7511)
-- 
2.23.0

