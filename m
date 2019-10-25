Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A765CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E807D21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="yepqcDDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394489AbfJYKsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:48:24 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18162 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394465AbfJYKsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:48:24 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9PAlRBw027852;
        Fri, 25 Oct 2019 06:47:38 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2057.outbound.protection.outlook.com [104.47.40.57])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vt9t2b0ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 06:47:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lbe7B3vAkdB2IfaLEf/iSH+w6UFyUsoZIeL8jqz4IIuJvmTnkP9AMW3mRJ2/CYlRsi8CJId0keKtekduQ+Fq1YvXjNKwZy9JPXf1l1Sfi3gbW1CBSrvzI2JLlak6CorahD0Or9nZOFji1hQQkPOu3tZSNvy6CssgNRt8PAj7rQgSt+CgwzYbbfvgh2nmTCIN6GgTmPwxhaqF/4ZHj7zlu9ptr/HXR8LgeTDnxLuE4auIYZ9Lz7/rLh//U/9hPO5i1j2PsfUD/+LNo1dCOtr/ySA3t61NpFZYENAGttQmHPcXNOsKLmeVzpvEyBCQtTmZmq5Wz943k4mXSQrDuoQtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXr1CS+Onv/bAP35WOni6UcuvOJhwmrcteAKlw4f6/8=;
 b=IVnFA+lL1RG+kC0FXt4Owm04B7HLqFfvfweFBq2s6/9A2MYiVb4n/GgBJUL5+8MaWnJ+uj4PboPyyHfqs3bJVPbESBTu1MCpc+sdxkUVWv7lk+81QEWcAczf7vEuPirN94i0EmKaOW8ZsrVivhRTB6XGwNG0psJP+WUiGDK4nKfEz+vZNVgnhuiiHi8iYPOSXpHxxkialMP3RKgQH/Y9FFKhEQo9r19VtLYAXDV7qm3/q1m3zZA3i9/u9WYkqunUQHzT1h5vCF4cV3Wx5iT9ssBzv3SJrUhBbs7toDizw2hce1Ye9eVFSCXAX4siGHbELjHi3E2Z2+yBgiTuxvX1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=samsung.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXr1CS+Onv/bAP35WOni6UcuvOJhwmrcteAKlw4f6/8=;
 b=yepqcDDjrq0hOqDQeM0xvQOR3JU+RvILCTtONKKbz2lycYH6PcJAKbL6glDbcSM5uoYBSsAEJjLrN0j+ubxzFI2PEJtpEVQA+8wxKLjA2GXodvDwR+AAfhh9dhLDSRIACH/P/Sk+Oo6Q/TzvRWnjcRYHTE+A4B/pWbW7XMWB/cI=
Received: from BY5PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:1e0::34)
 by DM6PR03MB4859.namprd03.prod.outlook.com (2603:10b6:5:188::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.21; Fri, 25 Oct
 2019 10:47:36 +0000
Received: from BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BY5PR03CA0024.outlook.office365.com
 (2603:10b6:a03:1e0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.25 via Frontend
 Transport; Fri, 25 Oct 2019 10:47:35 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT044.mail.protection.outlook.com (10.152.77.35) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 25 Oct 2019 10:47:35 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9PAlPYm027211
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 25 Oct 2019 03:47:25 -0700
Received: from btogorean-pc.ad.analog.com (10.48.65.146) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 25 Oct 2019 06:47:31 -0400
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <narmstrong@baylibre.com>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>, <tglx@linutronix.de>,
        <sam@ravnborg.org>, <wsa+renesas@sang-engineering.com>,
        <matt.redfearn@thinci.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [RESEND PATCH] drm: bridge: adv7511: Fix low refresh rate register for ADV7533/5
Date:   Fri, 25 Oct 2019 13:44:18 +0300
Message-ID: <20191025104417.28901-1-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(305945005)(47776003)(14444005)(54906003)(478600001)(70586007)(48376002)(476003)(86362001)(8936002)(70206006)(50226002)(2870700001)(8676002)(7416002)(106002)(36756003)(126002)(1076003)(2351001)(486006)(2906002)(44832011)(7636002)(336012)(246002)(2616005)(316002)(5660300002)(356004)(6666004)(426003)(186003)(107886003)(4326008)(26005)(7696005)(6916009)(51416003)(50466002)(16453002)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4859;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a3d6a52-b18b-47f3-7c9a-08d75938bf06
X-MS-TrafficTypeDiagnostic: DM6PR03MB4859:
X-Microsoft-Antispam-PRVS: <DM6PR03MB485976D0E3D09057EB5CBF4B9B650@DM6PR03MB4859.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-Forefront-PRVS: 02015246A9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /OQI62jjY9M0nINvHuCfFTgAmJ5h7W83uzauoj3Ra3tiQ/HYF3/xeSMryi4Dr3Paq5lW1UionmPDpbNfRRe3hAiKduxb0Iay0TjyAT7JxQq5U9XUz4hmv88b1j6z53jHLQt39t0zdmXdd4tOnA8FgWWrok+DFVY9b5Doms2WKhVqTsPLirkHc54JNFgLZD4e13Fr9Ld/KNqUwT5lbUGiDDlo1cTj5G4pRGQU0b1V/wTLxWq9I0CGD7Uy1ZzAKjXd/dOrwOTpMuiGhBRAXk5Km5BTdNJzfRa5+ntGfyAV0WbXBe+GIDu2x/sVzc/jJtzNrVL/viAiW4v/JNBcjSlp+Egv8SwtvuF0q2j4FkD2S8jdgZEjd6+5OqgWRjqY9i/z72opb/nuXXbW2NdSFKrJljobxYQUiFnPd47oJAFriuOKq4cG/C8rwGiN6o3aAcC5
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2019 10:47:35.3614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3d6a52-b18b-47f3-7c9a-08d75938bf06
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4859
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-25_06:2019-10-25,2019-10-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=1 mlxlogscore=830 phishscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910250102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 
-- 
2.23.0

