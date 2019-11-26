Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF19CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E772071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VhKEMutK";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VhKEMutK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfKZNQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:28 -0500
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:31859
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727860AbfKZNQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br0IlITciAKMvoJF61FmiO4/HJaoP04jFIkFIztPEYA=;
 b=VhKEMutKzCHNWDbnslmhKSh2qKB+9LLi44FACy6k/QU/mNPy2xSye7+hFyOewP3hIPO3MyBOEH2+N1bmF0G9O8rFks3xfb8dhQC3ndoH3yl9LCdTf6xPka9y0tApgilZVStc6b+KNZBbbtXmKrhKoWFIWF+YwQ7dXQkk01/eQzI=
Received: from VI1PR08CA0091.eurprd08.prod.outlook.com (2603:10a6:800:d3::17)
 by VE1PR08MB5023.eurprd08.prod.outlook.com (2603:10a6:803:107::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Tue, 26 Nov
 2019 13:16:19 +0000
Received: from VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR08CA0091.outlook.office365.com
 (2603:10a6:800:d3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:19 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT024.mail.protection.outlook.com (10.152.18.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:19 +0000
Received: ("Tessian outbound 512f710540da:v33"); Tue, 26 Nov 2019 13:16:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fffb61ce6bbc02b2
X-CR-MTA-TID: 64aa7808
Received: from 0334c95094c9.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9D6D01C9-52D0-4AC9-BFD7-3E0C84E4FAC9.1;
        Tue, 26 Nov 2019 13:16:11 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0334c95094c9.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0wCYST6tErq5F47pDNzbOqQfMhb9NkEfGrEm9n30BBpRVTrglxvdAvm9J0yOb5j6r8PmTkl23sk0YyFB7Sv/0jHliD+Fee93TSk2HMQZRLSAHKWhP9wnQxQh7yDM79NovXP45JW6k70RebEnUipNZTCXkeDoTZomyjHbQAhPAOPk7pgrHVhe3ZAAWaK0rUEk2nd7sdaIocznWWMKwrInENKqt2jeq0PU06OQHof3pcP7oCQ2SS8LFovrT3dUBQvvGd4U099o3YVOQL/fEJM81GH1FbVtYKuhvOgK0H9Q7OgzJYl10dp3EfrCvU67b5PBR/o0UjmjBm6KCZA3rTrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br0IlITciAKMvoJF61FmiO4/HJaoP04jFIkFIztPEYA=;
 b=Uk87qBZ8z7gUaOlCqOcH9Vu4EwdVbPWd8/2WTzrXwCW1oMGE2pt9OTdzRf5tOijBf1NhfxGkv293rH9XCxtRT6TbQXbv1TIfN5Y6rONr+U+6YY0Qt/cGIcPO3Sd4e88Fr4W/1HSletMn3zl0pKlP9CpsIRS8vjSy9rVJJTvEI6TUzgIT7EQ31oN/175AjaIx60aBXxqhCyaLPHPQnkr3GoPxjKPmjR1DhhNzNoxTcmHXWrb+EVElR2Oz8uOIzahJvk5JCK2NwzXclFKWsPqeScivrZgKIb3KU4GFcMfQyH662f8wzpS53y/50ErV+wmhun3QwIPcxtfXhzoU0IwyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br0IlITciAKMvoJF61FmiO4/HJaoP04jFIkFIztPEYA=;
 b=VhKEMutKzCHNWDbnslmhKSh2qKB+9LLi44FACy6k/QU/mNPy2xSye7+hFyOewP3hIPO3MyBOEH2+N1bmF0G9O8rFks3xfb8dhQC3ndoH3yl9LCdTf6xPka9y0tApgilZVStc6b+KNZBbbtXmKrhKoWFIWF+YwQ7dXQkk01/eQzI=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:09 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:09 +0000
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
Subject: [PATCH 11/30] drm/bridge: ps8622: Use drm_bridge_init()
Thread-Topic: [PATCH 11/30] drm/bridge: ps8622: Use drm_bridge_init()
Thread-Index: AQHVpFurg5txLQ+NAkCgI2Ac0kEZ+Q==
Date:   Tue, 26 Nov 2019 13:16:09 +0000
Message-ID: <20191126131541.47393-12-mihail.atanassov@arm.com>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
In-Reply-To: <20191126131541.47393-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0453.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::33) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46223dd6-b269-4b92-cd13-08d77272d3a2
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|VE1PR08MB5023:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB502330723E9D47D5D85BBACB8F450@VE1PR08MB5023.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pTxPhTopEbIKcwrYDQLgGUtBKDndqB41AqImQqeneDxjNqe3pirM3MWVk1UWnY/JL+ywhpTjzlJY8hjkvmmNU5yvvneG/AbMDaQDUH2DGAtrlV5ndNEemZU6wnOuGPycV7cNUL3u5iDjRqXh7728dHQvX0xnLZ1Mpxo7QslW9mLR3ynZ36hBixdY5b7ic2w/e1orl0sEHkPV6oL0dd3MqOnBxDi+ey3wuKuWJG6XEq7K5e1PIG4oAMTWmOrgPFD6Gy0D76eAg2Oh4lPV2H1taXFirFrkdSpfj/65+THi7x/vShxwAw33l4cvJkN71hUIbSjiKYoRlRpBuLArjt7RPviYiohHWLOGzsuJulr0uYEBkHu3ZzVkpC0P7k+5vP8m9lZ0R1ZFF+ji2reYGUeI8CQc7j0YaN/Dui+/Kq/hOqLGFB1y1yTSkWWUwkjaSTyv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(478600001)(8936002)(14454004)(66066001)(26826003)(47776003)(2351001)(36756003)(8746002)(2906002)(36906005)(4326008)(50466002)(356004)(316002)(22756006)(23756003)(99286004)(54906003)(106002)(26005)(86362001)(186003)(76130400001)(5660300002)(70206006)(70586007)(6506007)(6486002)(5640700003)(6512007)(76176011)(102836004)(6862004)(386003)(6116002)(50226002)(305945005)(3846002)(25786009)(81166006)(7736002)(4744005)(446003)(11346002)(2616005)(336012)(1076003)(81156014)(2501003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5023;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 451d2042-b35a-4780-882e-08d77272cd55
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PuZo4c9KxsJmxzvSL+hJaihPgbeLsVqxJLsQHC0Bn/4CBvWA6AMZ8rg7X2si4f9nhEeA1ROISztqq2WGHJs7hX/fbE7K7zS0ZpTs9J2ZUF0RiufUeAXZxfN2wtGREtVu8wfg/tq66cxxEH+ukk5gbPbuQklQ7+kyyz1u35YiudKi4C4SkStgTuvJZERAZq/ogMuRrioBA0QpIIAL86X6eSY5snIsUdA6cNX92AY/WrM0evLFo9OoQWh8lYqRxcHo7Aon+9ip0VBF060On4y2Yku0e2x7doXcdtfoyqoz+tuiBD7kxjnofUAlQ6Xtoe1oupvJPQeyRsCIRBl8eMZEXphwMtICXXlgpxWP54SpFS14/+q6sgwjAqV+DfL+tQxBjY4Ue54xCPKoqYVTh7cTSOMtr/VILw4cxkeIy8E+aNVe2stXi8c61rqgj0mGpb8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:19.7643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46223dd6-b269-4b92-cd13-08d77272d3a2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/parade-ps8622.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridg=
e/parade-ps8622.c
index b7a72dfdcac3..8454dbb238bb 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -588,8 +588,7 @@ static int ps8622_probe(struct i2c_client *client,
 		ps8622->bl->props.brightness =3D PS8622_MAX_BRIGHTNESS;
 	}
=20
-	ps8622->bridge.funcs =3D &ps8622_bridge_funcs;
-	ps8622->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&ps8622->bridge, dev, &ps8622_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&ps8622->bridge);
=20
 	i2c_set_clientdata(client, ps8622);
--=20
2.23.0

