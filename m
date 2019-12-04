Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21B1C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC82420659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cBkuJABf";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cBkuJABf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfLDLt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:49:29 -0500
Received: from mail-eopbgr20068.outbound.protection.outlook.com ([40.107.2.68]:27234
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727831AbfLDLsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Av9EoDIvHqCagseLb7iy4+qbCZH7UsR3146DKkdXRfQ=;
 b=cBkuJABfDC6y3k7unQB2WmrePPwJaSQnaXk9QOfXtAhTC3bpM2iY2SQlXSejigVs4Bmj8hTjxVbSbO83ZuF1jvJ9KaUiKFfvmpmAVhYg8tEeF0ib7aD2glaGnu2IXWvM6dPzlBfDWe+nHUkBHnM/AaIU1dzttwrrckbK1kYu+3A=
Received: from VI1PR08CA0157.eurprd08.prod.outlook.com (2603:10a6:800:d1::11)
 by AM5PR0801MB1811.eurprd08.prod.outlook.com (2603:10a6:203:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Wed, 4 Dec
 2019 11:48:30 +0000
Received: from AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by VI1PR08CA0157.outlook.office365.com
 (2603:10a6:800:d1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:29 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT061.mail.protection.outlook.com (10.152.16.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:29 +0000
Received: ("Tessian outbound a8ced1463995:v37"); Wed, 04 Dec 2019 11:48:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d4be94568fcd5ed9
X-CR-MTA-TID: 64aa7808
Received: from b7ecf5d06a39.8
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3882E90F-F739-4CA1-98E0-AA1FF754248B.1;
        Wed, 04 Dec 2019 11:48:21 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b7ecf5d06a39.8
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY6pP4AUljXBmcjMDmRzJ3fCEQXFp9KBx7gwG/agwUlVlSbjwPnGGWdGMEvIQgk+hm31i97h9PVjqa6IulWPBWvxHMSJU607lCiuVAL520NWHRVtMb2oWld27xnKySggKhvUbnRKVGZ5oIeWesLjG8ryjrvZDNuIzSghaKOS7xhPVYh/lYDO0GFlA5GE9pTkQJF8Ibh7wuMb35QvvOt0Yh90t10mnQwVteAWJcUVtjWnNwbzj8EgXZkC4axS3aVxHworsSO7szwdGfZ0co3IN8BJBphSO4HZ2Zcp1g/n8pZdtnsFBtocVGI+zL8LPhHGEr3Qh6qGCmta8uBZMPzCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Av9EoDIvHqCagseLb7iy4+qbCZH7UsR3146DKkdXRfQ=;
 b=lw4Gr+mfKUk0ra4MhtNoAftoaNB9M5KK5QJ3CuAWst/OJsC0yJcDSG8M0u3I6Jtfl/n63GRj3oRYaPts8Ro8sNjn8r9NlKs/y/jdVaT9bexyrqFgXEXCQHXqRQEUfH3/LhFuyTeEPDJawReaoOBfpjwkgY7swq1SrWV0A+jcNfPuEYAsPaYawix57RCgd7ZQjnzVkHsCpDO7zCUvtPt2vOEL8cHsxE/wlUP6gt/mHGEMKjOG3J324wApjDox1pO6NQQJL2ZrU6qvUwaOgtOMphywbwlss2QHnc9xjigRrWF7K+Le9DtBcyr8RGB7/DNX0R09kn88/GS1xnB8Klqs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Av9EoDIvHqCagseLb7iy4+qbCZH7UsR3146DKkdXRfQ=;
 b=cBkuJABfDC6y3k7unQB2WmrePPwJaSQnaXk9QOfXtAhTC3bpM2iY2SQlXSejigVs4Bmj8hTjxVbSbO83ZuF1jvJ9KaUiKFfvmpmAVhYg8tEeF0ib7aD2glaGnu2IXWvM6dPzlBfDWe+nHUkBHnM/AaIU1dzttwrrckbK1kYu+3A=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:19 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:19 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 20/28] drm/bridge: ti-tfp410: Use drm_bridge_init()
Thread-Topic: [PATCH v2 20/28] drm/bridge: ti-tfp410: Use drm_bridge_init()
Thread-Index: AQHVqpi5QCRUUSgUu02K2aKh0X5GZw==
Date:   Wed, 4 Dec 2019 11:48:19 +0000
Message-ID: <20191204114732.28514-21-mihail.atanassov@arm.com>
References: <20191204114732.28514-1-mihail.atanassov@arm.com>
In-Reply-To: <20191204114732.28514-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LNXP265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::19) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ad83c8f-abf8-44b6-cbc6-08d778afe1be
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|AM5PR0801MB1811:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB18113AC82C0BE0CE6DA3DEC88F5D0@AM5PR0801MB1811.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: v1BHkepoKwFa6M8j4fxBcq6zRWYTSo2QrnjcodgrAiy0BPSZpd3oaD/OhOiHnyLFDVdInHVzb8WIu1OQ03dPCwBsLomKVVoit+KZHOM/I1h3GJONTK1DUWZ9R8U5wZ5zZE3m1n+YOwC5XC6opfbYBpHMeecvEB44zr+CIpFfg/WecokW2t7DKU7Im0qJc01UpMkFwIBDus0lRuHSCwKQ7KU18rhgR9jaXNN2aTG1wZ0KlY7oEUOTDQR3ChlJdGbDJJUNtPyYdAniC6dP8EQYkzRjSGZtEPGzxhNIUW6rwxpGvp8Nnkk6Nu/jDFITOVW37jF67ljVhNFXrph3H0IAILHEXhzI4K7btdjsa1GqxesqEb7+/IRXE6otD+0CvzUl+7i2mxnQLgSY7/Y07UQ51S40+HIPLCHH2FYCWTFc2JFgkW5iILSKx+u3JpgI3Zdp
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(14454004)(6116002)(2501003)(50466002)(22756006)(478600001)(23756003)(36906005)(3846002)(81156014)(2351001)(81166006)(26826003)(8746002)(8936002)(336012)(4744005)(50226002)(76176011)(8676002)(1076003)(36756003)(5640700003)(11346002)(2616005)(6862004)(25786009)(4326008)(6506007)(186003)(26005)(102836004)(70206006)(86362001)(2906002)(76130400001)(54906003)(6486002)(70586007)(7736002)(356004)(305945005)(99286004)(5660300002)(316002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1811;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7cbc9697-e47d-4b37-d00e-08d778afdb94
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzI+TxeKlGiqHWvELzp5ZZCmFWh0Uv02hxuKG3xzC5IzdY7lUCIl2OXBZJQhC2M2czwVQPaXNMD4koBzVCs1C+yzPp7Yu+Umr8N6gxvaL14a5mpwuYJubQdy+S2bOyAJv4afNCDr6qfa2+E7fMDJHE50uB8/TpUN/ZO8WthJPD0rY1eEpTl4eED1gwtktGO3fxHbhGIN/p+/yCTlVJJCnhOdaN+JO12bJVhXvn4G/LTZ0lsGT4XLrapoqWklLeeHE0YIt3HQhAkbBl7lcKrqcJ2KjgW7GT4qUu46oK26m/GBUH+AbMEF0CivtxcsRKtgkLBL7IKeUhS1q1mZLAC3aB2Ut5eaFwVeH9Fqpnvu5oMb1jrudx1xpZcVzj9LHD05joGPmJevP/xSFit6NhNtLOfmLoDzTAAGJhPOBeEH/IJG72Xecp3Z2YJeZUQ5ux7o
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:29.7661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad83c8f-abf8-44b6-cbc6-08d778afe1be
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti=
-tfp410.c
index aa3198dc9903..377eca989ff3 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -328,9 +328,8 @@ static int tfp410_init(struct device *dev, bool i2c)
 		return -ENOMEM;
 	dev_set_drvdata(dev, dvi);
=20
-	dvi->bridge.funcs =3D &tfp410_bridge_funcs;
-	dvi->bridge.of_node =3D dev->of_node;
-	dvi->bridge.timings =3D &dvi->timings;
+	drm_bridge_init(&dvi->bridge, dev, &tfp410_bridge_funcs, &dvi->timings,
+			NULL);
 	dvi->dev =3D dev;
=20
 	ret =3D tfp410_parse_timings(dvi, i2c);
--=20
2.23.0

