Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69EAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD4521783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="uoG9lWSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfKLNlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:41:04 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29550 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbfKLNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:41:04 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xACDcJUC021618;
        Tue, 12 Nov 2019 08:40:31 -0500
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2057.outbound.protection.outlook.com [104.47.41.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w7prjrr9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 08:40:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltkonDPsDxpO2IxVUhmQ+saHLVIidSWjzks55EkiJJIsh2UgLb1NTG5VEOf8qgydlR/imepQ4avuYbGEoRkZLbPAIIdTHfiyPtTcKsS3OZXMLIYFfsosijaqAVqb9xq9wSt9ja3TB2nvoFJXmGlEC6VvIdjvaEt8qDCcodp6Y7T/31Zwh9kTKlsm9SSfeCDvVBgBwo2s3lhIznwD5j2euvHWGjnz1ZgpHFPuqD1nQ8PiFi1P6ofyKot+HOJxDDtniyyWOz8vtAC2e+4MU7zQ7UhAgIAwOZuQRS+O3Eb0Z2PUeqa3TkwOUdoOTPoX9fOIb/JiiI5wmnW2BSmG7euhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcwmqdzegI2pbeYFa74q27gB6X0fBkzb1+9MaBN1Coc=;
 b=iQuzaEITEpcbj4v27CmKgV8AZYF+ZdWsN1cCFxrFjn7M/MMo9yF6Cyulr+j+qVuiFQT8cO5oTnYztBW3jxbfxSGLxINirnWPX+37Mwn1dZhmSJ7+zlf0SDQba95nrkcSKvQWkEsayRucIVyzMWZ4VQ2q4kf5LmIQXKQVaqR7npzYjn0LbC08EXBqWHqg576RrKdzZQHFObNpOHp5XVrfIcFkNLjhk68QULLtUe6W9l8j8t+ZWBTZYdFB3wJGzkGurGw/tt94GoR7v/BdPxnnekYKWsrkfaaWoBgiyip4Jx2Unoe3tmLTdVUN5ivuSF8oXGeLYbI+2t6hAFFHiX/rhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=samsung.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcwmqdzegI2pbeYFa74q27gB6X0fBkzb1+9MaBN1Coc=;
 b=uoG9lWSkE73UXJpAeWaKy9hF/TGxJ/yojuEf5DOavPaC5yAt+Vy2WAvzNzzI4P2+ilOEoc7NDmQKlKgoe2+Q5S3im4IycJJvLN4DNo5DbHcm6BJYKc94X8pGARci4CaWPtSCYmME6cMydfhJvVsqmBnmyA0ojFLADcVonIxTaWM=
Received: from BN8PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:94::36)
 by BN7PR03MB3857.namprd03.prod.outlook.com (2603:10b6:408:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Tue, 12 Nov
 2019 13:40:29 +0000
Received: from SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BN8PR03CA0023.outlook.office365.com
 (2603:10b6:408:94::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Tue, 12 Nov 2019 13:40:29 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT047.mail.protection.outlook.com (10.152.72.201) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 13:40:28 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xACDeRrQ022964
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 12 Nov 2019 05:40:28 -0800
Received: from btogorean-pc.ad.analog.com (10.48.65.146) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 12 Nov 2019 08:40:27 -0500
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <narmstrong@baylibre.com>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>, <tglx@linutronix.de>,
        <sam@ravnborg.org>, <wsa+renesas@sang-engineering.com>,
        <matt.redfearn@thinci.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [RESEND] drm: bridge: adv7511: Fix low refresh rate register for ADV7533/5
Date:   Tue, 12 Nov 2019 15:39:00 +0200
Message-ID: <20191025104417.28901-1-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025104417.28901-1-bogdan.togorean@analog.com>
References: <20191025104417.28901-1-bogdan.togorean@analog.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Patchwork-Id: 337838
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(476003)(8676002)(305945005)(50466002)(2616005)(23676004)(7636002)(2486003)(8936002)(426003)(2906002)(5660300002)(186003)(76176011)(26005)(11346002)(50226002)(336012)(7696005)(356004)(6666004)(446003)(1076003)(36756003)(2870700001)(47776003)(4326008)(107886003)(486006)(54906003)(478600001)(44832011)(14444005)(70206006)(70586007)(86362001)(7416002)(316002)(126002)(106002)(246002)(2351001)(6916009)(16453002)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3857;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c215886-c225-47c5-2838-08d76775e1a6
X-MS-TrafficTypeDiagnostic: BN7PR03MB3857:
X-Microsoft-Antispam-PRVS: <BN7PR03MB3857C6748B83EE71D92169209B770@BN7PR03MB3857.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LN8WarTux0in0cpcR7EeUBiqKByJgNxYyRS+BbMRl7dKAO1qrUwt4X68xK+aWaRw1WNGNbRXtya75uuylaObfMBV4a/sqC7UULl2RjOX5i/CnHAuoMdo5mev+L67XzTpRB/Hi67P8fgwQBmBWBUy1YZ8TXDyBK7Wn27XX3c6VcA1Hj09Ubu2E0M0q7jkM3+gXRxT6F4cxPfoGiz9cv0pmJAEo7jFFI+AabkXXL648j9wXqqDhML0PZpFC7JOaJgapiLVYmnXCmzSe+J76Ee/VaEMQkStgN22LHle7IOchfyW5EqimGh5ZUPqUpoiDL8cCe7qknv3wgxxCWQ7bT1Epgai4lNkbvKtmg9rfPW/3mEUGaCDQsT6JuDUG8/yJP8ziVdjJFkfCA1UTcwr2EPOf11yA3Tsqt+iayF3PjCEspsOJD/NM2coGy9/MUHn1S1m
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 13:40:28.9500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c215886-c225-47c5-2838-08d76775e1a6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3857
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_04:2019-11-11,2019-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=235 suspectscore=1 clxscore=1015 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911120123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20191112133900.jpy_svPBK0cpfNhQQ1t8J2zsswGKQZDDTHAkH_eYD2o@z>

For ADV7533 and ADV7535 low refresh rate is selected using
bits [3:2] of 0x4a main register.
So depending on ADV model write 0xfb or 0x4a register.

Fixes: 9c8af882bf12: ("drm: Add adv7511 encoder driver")
Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 9e13e466e72c..2f8f7510f07e 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -756,8 +756,13 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
 	else
 		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
 
-	regmap_update_bits(adv7511->regmap, 0xfb,
-		0x6, low_refresh_rate << 1);
+	if (adv7511->type == ADV7511)
+		regmap_update_bits(adv7511->regmap, 0xfb,
+			0x6, low_refresh_rate << 1);
+	else
+		regmap_update_bits(adv7511->regmap, 0x4a,
+			0xc, low_refresh_rate << 2);
+
 	regmap_update_bits(adv7511->regmap, 0x17,
 		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
 
