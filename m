Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19520C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89722173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="g7xjUkmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbfGPNM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 09:12:56 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:9922 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726997AbfGPNM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 09:12:56 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6GD8WLh017090;
        Tue, 16 Jul 2019 09:12:06 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2050.outbound.protection.outlook.com [104.47.46.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2tseuc82pe-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Jul 2019 09:12:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d75yfUpMwk4xgyyn1Qx7beN3tzEXlmsuS+MhJkrMb/qPBFqhu3fgiJhaErDJeUZVFCVUL0nQn4AKVl5gLhw9sVbndvdFXp4+8Ys7Ye97nkCjWEQGRdvGMNjfzku1tBHRm9K4KK0W6EERQpFipJHY7vrJkDfjs3JAwkBX3DyV7670Tt9vOKmkdzsRapbSZN+JaGEEqEkfyzAC+nA6xsipVAQj/44XkfM5wPOMyfwTRVOWtVHhfBwTGVhJoRsaPDqlVkpZ8pgOlxo5SQwsZw1B9CNVdF64ZeWa/o+W5XzpL8zus6YOb2YFqOLRf7GN8KD6jUL8+aDDK47qQFykVEI5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqG5Oej3TqDoGoXxSl7qRk0xaLWwbsrfQLJovkF24cc=;
 b=fzGwYsF9ka51BwtjCO9kuHtK/qdQ7ffdLTMHFDmFwiI1/KZqpsqmHAAW66vY2oa25aotbHhYUXRGzCEL02wZxtSZEn4Qm5Ga40Q0FvSd29AVn6q3usT132clblEe/p3YPcqr2781TmY+k9fSoRmew7lsp56Uaqc6ZFgqCURFbNLCfwB8kZQT7fgdGQe0jFOJWQ52ZWAsrA0koGRhO8R2Pi6YftZpDzcSRneaUPkZp7bo4Zba7ITHv8jw7c+FEcBAS7Jj8A2LVMUNYZ8K+wsK0H2MKVSvzNsQoQEXrL7dB84EcYrT9oOklFioL8O32TCMhWCVzizxZuS4ZFcjG8UY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=ffwll.ch
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqG5Oej3TqDoGoXxSl7qRk0xaLWwbsrfQLJovkF24cc=;
 b=g7xjUkmBZwYaQfSOfHJQO7vhdu9pz4icnHA8y3m9y+3gHTLMmnJvDQ2NbEs6XYcMGQPSa56hWUpt2FcRJ/q4QnuBX0IUGICeTIssko55nSnmr8gCPqvBGf5rPnd6u3FYzAdhEMfi4AoxiV3EyUjH00qYr/YeYMGaMe07ElcwMfQ=
Received: from CY4PR03CA0104.namprd03.prod.outlook.com (2603:10b6:910:4d::45)
 by BYAPR03MB4711.namprd03.prod.outlook.com (2603:10b6:a03:131::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.11; Tue, 16 Jul
 2019 13:12:05 +0000
Received: from CY1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY4PR03CA0104.outlook.office365.com
 (2603:10b6:910:4d::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14 via Frontend
 Transport; Tue, 16 Jul 2019 13:12:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT012.mail.protection.outlook.com (10.152.75.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Tue, 16 Jul 2019 13:12:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6GDBxXw023907
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 16 Jul 2019 06:11:59 -0700
Received: from btogorean-pc.ad.analog.com (10.48.65.146) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 16 Jul 2019 09:12:00 -0400
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <a.hajda@samsung.com>
CC:     <Laurent.pinchart@ideasonboard.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <sam@ravnborg.org>, <swinslow@gmail.com>,
        <benjamin.gaignard@linaro.org>, <bogdan.togorean@analog.com>,
        <tglx@linutronix.de>, <matt.redfearn@thinci.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: adv7511: Fix low refresh rate register for ADV7533/5
Date:   Tue, 16 Jul 2019 16:10:05 +0300
Message-ID: <20190716131005.761-1-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(2980300002)(189003)(199004)(2870700001)(26005)(48376002)(47776003)(476003)(186003)(2906002)(36756003)(51416003)(7696005)(2616005)(486006)(86362001)(5660300002)(4326008)(126002)(6916009)(316002)(50466002)(54906003)(44832011)(70206006)(70586007)(7416002)(478600001)(426003)(2351001)(50226002)(8676002)(7636002)(8936002)(305945005)(106002)(356004)(14444005)(1076003)(336012)(246002)(16453002)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4711;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22474c59-33bf-4461-51f9-08d709ef32b8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BYAPR03MB4711;
X-MS-TrafficTypeDiagnostic: BYAPR03MB4711:
X-Microsoft-Antispam-PRVS: <BYAPR03MB47111638C116C314902859BC9BCE0@BYAPR03MB4711.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-Forefront-PRVS: 0100732B76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ey6wSF/X5nOcHU0ySxkqFd+COTL7woZUYTXJT+Wr9kbyIsMQGG46Eq6Tnl3OhkZt/N9M/umTAvNA6oE2dGcZ8Xtjn+gle2dbMO3y1JHlgKAj6FthWg8MqBKn2rbrRLnnbuIZx7hS6o32S0UyjzWSXejyt0qvV/0YerIpvDC+rVgWQuPHZ057X9nQGhGvJF73Pi5nLDdTCKY0aANF/AaYc/OUAlmvOJXbgZhgzYB1AAEMNpuMP3asMYzSPIfI/zzzJT+uzY7PID+JzHw3It6zoqvJXCElK4KDUCFtg1TxXOYIAnLM38apHtNcANnabdc+uucKo0rBcSlXNUomFYRaC8RZNfHXF0woZEBSDoqt7B2aTMaFCi+9X4pG2Ya9dMxb+XolkrzqUSJdB/1JmBuwX5SqgNO6/J3bjNP7JvkM200=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2019 13:12:04.1252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22474c59-33bf-4461-51f9-08d709ef32b8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4711
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=758 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160163
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
index f6d2681f6927..4508a304d23f 100644
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
2.22.0

