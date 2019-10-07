Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E015C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3658621655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="3BphAZFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfJGKJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:09:48 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18202 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727376AbfJGKJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:09:48 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97A4J7H000557;
        Mon, 7 Oct 2019 06:09:17 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2057.outbound.protection.outlook.com [104.47.38.57])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vemxaqx36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 06:09:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZ03jOKJwSyD2rX4uv1Tz7SHxNGlNNanXBhhOTO2V0nDa+9CMz0EUrrw3PxPJVtmHVbznGb9n0/4KNdoVqzrPGgpSPUyg9GG6LXM2LyiwAQ2il4FLusgHUKQ6o4szP1IUFXTLO+f9qYZ1zPo4L89dqNFivLWbp4lUKF0maJxp/YL5dAnkhPaYdL+UBmr0LDC9PzZZ1PkmOQGQdgTgnSf7Un8tD4vKn4NHm1eQ6ktoQ20QsNyH9S2hLTzHIVMv/otcSHCkZq7RYgpZYMLVvyypRK8oOKJAwG1GNK3YgYs7qGAYSdUQMSdH55BL4JF0qOMpEXw0iMELhdNYRxMlT8aJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2ZzhhRlr4o+nfr6dEHg8w6bxHM+TS6FEBwsWV3YAaA=;
 b=C08HQBrw66Zd6Xrk/bDcvzeECKPLH7+A8+aO6SqR1v8pxGKkBNQsqUxJ218lJ86QZqdU93WYuBHJblCZXaNkTzhQE/sMeuHbysYjLX8tb7oAdv0+iM78KaL5zNJk+O3SI/Ww10qa9HtD/jAE9WkPy3nXlmGoe0S8gaAvN9Z4D/aaU5lV+ClDPjCd8VkZl8h6+guHiRpajGUQKryD63fUG09c+bP2hZnrTSNe006TksZULC0JvH3xwSbYUAwgSvhi2/LTOlGEliCSCYKP+KHh531czl18GNJUDSRtbx2DVRotQOjMuTVAgeCdZ4Z95qsQombJ3sxVqK1Nj3qe8l0YCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=baylibre.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2ZzhhRlr4o+nfr6dEHg8w6bxHM+TS6FEBwsWV3YAaA=;
 b=3BphAZFPS6YK9lXA/9NKolJdSTlrzuxTIu+xdEZL8RRCIzrF55HBLLq0by8mZWbtq2j8GlaW+IkDNg+tZzM09zs3P8JaFIXHh46i0In5aPrJNUW/MFoOu0HSsIR7D/CXBR9L5F6haL1RvOIqYLZBDPZRxTH3ioa3S2SwVSN9+hc=
Received: from BYAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:a02:a8::25)
 by BYAPR03MB3720.namprd03.prod.outlook.com (2603:10b6:a02:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Mon, 7 Oct
 2019 10:09:16 +0000
Received: from CY1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BYAPR03CA0012.outlook.office365.com
 (2603:10b6:a02:a8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.19 via Frontend
 Transport; Mon, 7 Oct 2019 10:09:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT054.mail.protection.outlook.com (10.152.74.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2327.21
 via Frontend Transport; Mon, 7 Oct 2019 10:09:15 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x97A9D00016239
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 7 Oct 2019 03:09:13 -0700
Received: from btogorean-pc.ad.analog.com (10.48.65.146) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 7 Oct 2019 06:09:13 -0400
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <narmstrong@baylibre.com>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>,
        <allison@lohutok.net>, <tglx@linutronix.de>, <rfontana@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [PATCH v2] drm: bridge: adv7511: Enable SPDIF DAI
Date:   Mon, 7 Oct 2019 13:06:41 +0300
Message-ID: <20191007100641.25599-1-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(54906003)(7416002)(51416003)(48376002)(70206006)(7696005)(4326008)(1076003)(5660300002)(26005)(70586007)(6916009)(106002)(44832011)(50466002)(2616005)(126002)(426003)(476003)(336012)(36756003)(186003)(486006)(8676002)(47776003)(2870700001)(107886003)(7636002)(8936002)(246002)(14444005)(316002)(478600001)(305945005)(86362001)(50226002)(2351001)(356004)(6666004)(2906002)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3720;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05927766-8a6c-4385-5c4e-08d74b0e68c4
X-MS-TrafficTypeDiagnostic: BYAPR03MB3720:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3720429D697520D1C3569CD99B9B0@BYAPR03MB3720.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-Forefront-PRVS: 01834E39B7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/7nceK/4na2zKyxahg+RPwkVvAefXSF1BlWez49IWC84jBN9iz64B0qA/VoxyZsE+maa0W9nj5eXuBj7cgZL9ll2+mdgDtNLCW5ZeZI517C9EanSV8/H+Dpz1WvSgoMGCzKQOl5kZcneVEUaFFzmvZu5+9I21UiCyO0rl1mfjvdqyjJ6dGOW00Qz0BWqBuvXCAVZHi3GpDvwCsmDUnGtkBv13vMnlkuPGnim4oo573QRWIOZBatQBfxPWnHwKKhEpxaQmlPXfc1OmxvHfr1GXa6fXRIAwRrzazGsgV4ZsTBAbLB4FExSSaPPvJDIBXIdc2cgAWv0SEd4/PLm+Nsr+7nwOANLfiTNUxcwTIGo7iBdbbBflwvfd+VPw8HbDV/0fGylUqawo/AiU895MuPd5jvwzrARIzA/IAmiILrI9U=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2019 10:09:15.4267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05927766-8a6c-4385-5c4e-08d74b0e68c4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3720
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_02:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=1
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=893 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADV7511 support I2S or SPDIF as audio input interfaces. This commit
enable support for SPDIF.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---

Changes in v2:
- add forgotten break statement

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

