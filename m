Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F92C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65292072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="HVMswcL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgAGNHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:07:40 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15662 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727834AbgAGNHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:07:39 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007D6pR0020335;
        Tue, 7 Jan 2020 08:07:06 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xarg96wym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 08:07:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFKSooTtokf9zKB9DrWy9urQUZvtXURHzKJARICgI8s1rmWRhv7/3oXL5jLLqcqXYRWy2NIa6HSSseRSK1oKEBsC9NV3YMkDjaivbgLgdWehnhpMSTdlqLVR3H3ySclQr9sxC+Ce8SeVr+Lo7EBr7UV7i+lmTc9SxmhzxAzlQ5/2J7VO6SL/fU4VDOL7wOC0bAqFzojTrnJByIkw8/P+1znmIGubqOCClQe8KWRMy+UuNJhF9qorKDqw0pGvkV6EgXSoz7F5bb7QLXjb4tCKHtGwwqJ9UdCH0WOkcrPqVa3Jvaq1ku0SJaPrjkWAE1jY5Or7FEXILxcVPeOp1UKyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXr1CS+Onv/bAP35WOni6UcuvOJhwmrcteAKlw4f6/8=;
 b=XNXHYbMOHHGPrnsgWRfhmtfg9a1TWJN+WS7KA25XA7PphBQFVncg/KgYnwYptlWbtjcTWu3dMsoov4A3LRT9R8HQvGMSLTDlaBU7KOWQe9pOHpXTBwyMRohGFo/w0r9/jSZMhi3eVcCCj2try0GxnCFWSmxGnDZ2dxhKmi0MsdxsF4ZDOT42Ij7elALkhTZm2FNbP8eOlWXQTMe/J/SaKLnYurK6zBtqkkFuz+tJ0jh9lu1eFkuRpCoBjCW4VkFbUVXo5emy9CFpjyur+adpFCcRwxyJ+Ldof8aIF0DQqyz3+IpgKy7V4r4zj5AoRjqwzqrD4xUCiAiW00YZ7yIHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=analog.com; dmarc=bestguesspass action=none
 header.from=analog.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXr1CS+Onv/bAP35WOni6UcuvOJhwmrcteAKlw4f6/8=;
 b=HVMswcL/VhYqrvheYs6GCAeoPC+ToOU6P3Cv3SxxGFjIxM7I13H6ZFokwdCMSEwhaPzQYiB+CD2+NBUta4We6AwjVi9uOGKhTTee/RryfPuiGlMlhrSSo9XCgnHGattVfKuhdKaBd89FAMRzth0VHauY1RqGBZoFu/uvqDY0dJY=
Received: from BN3PR03CA0055.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::15) by BYAPR03MB4661.namprd03.prod.outlook.com
 (2603:10b6:a03:131::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12; Tue, 7 Jan
 2020 13:07:04 +0000
Received: from CY1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BN3PR03CA0055.outlook.office365.com
 (2a01:111:e400:7a4d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend
 Transport; Tue, 7 Jan 2020 13:07:04 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT007.mail.protection.outlook.com (10.152.75.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Tue, 7 Jan 2020 13:07:03 +0000
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id 007D716w008945
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 7 Jan 2020 05:07:01 -0800
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 7 Jan 2020
 05:07:00 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 7 Jan 2020 08:07:00 -0500
Received: from btogorean-pc.ad.analog.com ([10.48.65.146])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 007D6nYZ000586;
        Tue, 7 Jan 2020 08:06:50 -0500
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <narmstrong@baylibre.com>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>, <tglx@linutronix.de>,
        <sam@ravnborg.org>, <wsa+renesas@sang-engineering.com>,
        <matt.redfearn@thinci.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [RESEND] drm: bridge: adv7511: Fix low refresh rate register for ADV7533/5
Date:   Tue, 7 Jan 2020 15:06:33 +0200
Message-ID: <20200107130632.26349-1-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(44832011)(336012)(186003)(6666004)(356004)(4326008)(26005)(478600001)(426003)(107886003)(86362001)(6916009)(2906002)(7416002)(36756003)(7696005)(70206006)(7636002)(246002)(316002)(8936002)(1076003)(54906003)(5660300002)(8676002)(70586007)(2616005)(16453002)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4661;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ace0f59-152d-46f8-7659-08d793727d78
X-MS-TrafficTypeDiagnostic: BYAPR03MB4661:
X-Microsoft-Antispam-PRVS: <BYAPR03MB46615356D66C301A210960FF9B3F0@BYAPR03MB4661.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-Forefront-PRVS: 027578BB13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvD8Uw0us5yiG6ZSRJKg+r5tPx4zC0Vuhw6Ls2Ez/YhfMCJMlHdAGSWbK3PUMyGb5bkjWaukqXO6xqZkZfkJiemwSixYApWigh5CzS56717UcXaWR4nCiD8Y0FZG6gnibDDNXDiHfDx6u/STdPOU8pafZptAyMIqWvaqFod0EkRYE8N9kD+XnsGOFCexu9+f1XDOg7wB/uhjkY9YRsRQtcVY6nXetC/94vWT5LVf+IE7g8ajmLQcxyzOSwwwyoTK8uGMI0WHZyi+K4TruevMp9oEXW4sUAs8+F/ymLshtdoz1DAP6JZUn6IHatTzf9UWxemD/k6FbhyLUNzaFqC0z+kGGirnZqW0tddlQfSUSPK73Am/2rJcuTBpqceiPifLWWGp2FzvSTPrMA2ZdkzAUFFM8DNSAl8kHROqWLhCU+fRxru5thj8h/H9AcSZ+0/7kXDlAHD0A3YCMQFUYvspk3/tJ5/c3/N6sBmq6IFmYvrIe7U91XimXZOCnvsR8tx7lfV6Vvc9Jp5oOGZIGUUbzg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 13:07:03.5364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ace0f59-152d-46f8-7659-08d793727d78
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4661
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_03:2020-01-06,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=1
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=744 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070109
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

