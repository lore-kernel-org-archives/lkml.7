Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE72C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8633E2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="aPG+Kt1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKLNgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:36:44 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38280 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbfKLNgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:36:43 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xACDXokA018542;
        Tue, 12 Nov 2019 08:36:24 -0500
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2053.outbound.protection.outlook.com [104.47.32.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w7prjrr33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 08:36:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMDqq09DkKbAqyNhCGZqkvIva9oqTZ/37CPDKEI8TW24ugusFYwNtu8OFF7ZQxclzunLMqrr2NGn/TcLqFzQy9hPR59SH3XFQIiCCjViiW/G0N2oZIKMtvqvxFWFgcZxED/26smCtmQ0feQmwAzjGn5WGCanby5Dls/uOTedna/N6Cju/hlC5Y4DcbjtYH4FSD5qISwCIlso9yOiOwpd0Uq6KXBTINm4uBf/45xExi8ZN/myRUljaU76y3xXUa3k9SUG1RPWhe1sk/7uM5Gx03OqM3BvsRlM00YBGwa70wybHYOib2blQylxo/ajWmYgGDEmnb6sZyqRKnKITBNVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KfcrFk7OTTlCjcHxawy7ZNrJKYnlZc0/Og+Zy+TVOc=;
 b=k0ZAdVmjniCUT2gdoOIHTsETYC5Ku3oooTuloNjSP/FlOmSk5LXBe4K5Z9unXCUfL4UYZAtKyohxgS0JNk2k32YfPvfoqppqb5VwdVH7EQJwFvM/II2RgqshmdfbwTbTfDIFjCmmfBZlAqm9nb2JDzDg9mt+VSoQzZELmX21BcBBEaDzueyH7Sd9S+DUUfZuCZCVIuuS+8H8q6ohSFF4ueMXs+p2FYBTJJryzZWVmxUqFQXrGw3X6aWa1ep3mqXgMNYO7OU1aTWM/UfgFrnecBvSX+cR8Rf3h8TUbkEhqzck5Uj16Q/m1MQhdYLUOzsIzaUGaNOr27YN5tD/7vi+Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=baylibre.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KfcrFk7OTTlCjcHxawy7ZNrJKYnlZc0/Og+Zy+TVOc=;
 b=aPG+Kt1msYCtiOjqfL5DoLbebr46GQw+Lo/y56VH+e3WhKuAIS40UWShTiZvqmZhwtCjzAflzFUMEVPhqaCmjmPprItL67i9BXsaBjHLDP8+jtAOLk8/DRcieoiHaXuIG1dAb+WpsvjUHA34dm/ehcw3FXrjVKhXXsfs/18YKXU=
Received: from BN3PR03CA0072.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::32) by DM5PR03MB2490.namprd03.prod.outlook.com
 (2603:10b6:3:72::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.25; Tue, 12 Nov
 2019 13:36:22 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BN3PR03CA0072.outlook.office365.com
 (2a01:111:e400:7a4d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Tue, 12 Nov 2019 13:36:22 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 13:36:21 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xACDaL0X021911
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 12 Nov 2019 05:36:21 -0800
Received: from btogorean-pc.ad.analog.com (10.48.65.146) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 12 Nov 2019 08:36:20 -0500
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <narmstrong@baylibre.com>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>, <tglx@linutronix.de>,
        <alexios.zavras@intel.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [RESEND PATCH 2/2] drm: bridge: adv7511: Extend list of audio sample rates
Date:   Tue, 12 Nov 2019 15:34:52 +0200
Message-ID: <20191112133452.8493-2-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191112133452.8493-1-bogdan.togorean@analog.com>
References: <20191112133452.8493-1-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(199004)(189003)(4744005)(186003)(476003)(336012)(44832011)(2351001)(86362001)(11346002)(8936002)(6666004)(8676002)(478600001)(486006)(50226002)(7416002)(48376002)(426003)(446003)(356004)(51416003)(7696005)(2616005)(54906003)(5660300002)(106002)(26005)(316002)(76176011)(6916009)(2906002)(2870700001)(305945005)(7636002)(246002)(107886003)(47776003)(126002)(1076003)(70206006)(70586007)(50466002)(4326008)(36756003)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2490;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6977f447-0a97-4a9e-ee16-08d767754e57
X-MS-TrafficTypeDiagnostic: DM5PR03MB2490:
X-Microsoft-Antispam-PRVS: <DM5PR03MB249027D9C0F77E9C3AD140D89B770@DM5PR03MB2490.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IoTjGH0gSgv3DjlrKA0YklzQY/LGENvndB8hg0/xHk4IQMeh4k11eOyLrdiuao0MdhSK5KGDh5RBSebAvDOCsMrBVH2xreuA6pzp62j/9yv7VsYUWrTrLJemEbIgWGQLQlkHNGqPQ3kRnbJHHvxtqlUeg02YTFEU1t8zXtYmHFy9YScCI1IRtAONrPojlGwNLA1TYuphjSt670sUwSWrQsU+dy+aeEdLZHNNBkBWO5N5eBXur8qL5K+U2BxarZ0Sc74k9Xu8jhckZSgtGeIC1bjxvdPczVFzcVBUYOiSVSGPO0I0brk2nBBnlrKHFNDK73dREL6bwnjGnxFGBjCqo70DPiibl+GDzTJiJrYRsCJp2dWzYQde0TSDwKy7jSKIHTyez/Q/gR2fYvvfxuZ/rRRbMlJ3/UVnXQAlDKv7NzTur/9kld6oExlNyBf8L2cX
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 13:36:21.7633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6977f447-0a97-4a9e-ee16-08d767754e57
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2490
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_04:2019-11-11,2019-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=1 clxscore=1015 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911120122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADV7511 support sample rates up to 192kHz. CTS and N parameters should
be computed accordingly so this commit extend the list up to maximum
supported sample rate.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index 1e9b128d229b..13e8cee6e827 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -27,6 +27,18 @@ static void adv7511_calc_cts_n(unsigned int f_tmds, unsigned int fs,
 	case 48000:
 		*n = 6144;
 		break;
+	case 88200:
+		*n = 12544;
+		break;
+	case 96000:
+		*n = 12288;
+		break;
+	case 176400:
+		*n = 25088;
+		break;
+	case 192000:
+		*n = 24576;
+		break;
 	}
 
 	*cts = ((f_tmds * *n) / (128 * fs)) * 1000;
-- 
2.23.0

