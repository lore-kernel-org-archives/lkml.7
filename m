Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28E0C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A4B20803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1GSexDf8";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1GSexDf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfLDLsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:50 -0500
Received: from mail-eopbgr50055.outbound.protection.outlook.com ([40.107.5.55]:36935
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727797AbfLDLsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opfrCUQhstTmEWhDCMZ446EAzDQXpi+cbl+vvgZtrP0=;
 b=1GSexDf8+18j51n7+cQmgRoYULNXUuSLqkLLrNXgiCq9gde/QDWp82fbujopFdKGpWxxA+JSlhxWqX6BaL9vwpure/A5EG1ItX+QzOeFJelLk6sp1RcJAq6hN2KEOJ+FUeKmQ9etQCX4kt9jAVUpYgjTy9yYYwYvntvNWzXEdWs=
Received: from VI1PR08CA0178.eurprd08.prod.outlook.com (2603:10a6:800:d1::32)
 by VI1PR08MB5551.eurprd08.prod.outlook.com (2603:10a6:803:f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.21; Wed, 4 Dec
 2019 11:48:31 +0000
Received: from AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by VI1PR08CA0178.outlook.office365.com
 (2603:10a6:800:d1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:31 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT040.mail.protection.outlook.com (10.152.17.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:31 +0000
Received: ("Tessian outbound 224ffa173bf0:v37"); Wed, 04 Dec 2019 11:48:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 02deba9103022596
X-CR-MTA-TID: 64aa7808
Received: from b7ecf5d06a39.6
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D52A9F92-832A-4F10-818E-23049E88648E.1;
        Wed, 04 Dec 2019 11:48:20 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b7ecf5d06a39.6
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFjfM1vbceSWlZzQOS3czSKAaBQBuopoGn+xGg+MwBYL0iX+W8QqSHFUoM+lfLR/lSzr/OdDxjIuP2jJgZLuUe52X2+7UD551EV8t/fcGVJHPI9AUgUwiHRv2tN5f134g8WsYhLlTtPdcMMNs+l/4hGfE33zTlPuyNFq3i+S+eB5jYif+jDAmt3dZ2Y6g4Q3zhZEYKwQOle1aY/VKbOMwfG7p4E8nsSEnNjgvjTtzXpwA6bEzu4/nRyur+DvnWXgp8TUOL0P6fvJNJyTvJernmYhE+YyLhe8N4EZtEAXYVCVCZfK2uwmDtIfdZANtuFTOhtWN+8Raak3v5jhUKqecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opfrCUQhstTmEWhDCMZ446EAzDQXpi+cbl+vvgZtrP0=;
 b=L3Hg4mrVEBOa+7Eg0HxR1pK28D7Url9Ao7j+h2mFv5lApB6IIMAaZbDrQZW/HBrqoKFKMoWFGhBaznFn7G4lZiq1/bRpMlGgq2CpXr/aSU9bKUPPnS43Xm9utLhNiotxh5idOgChVatRkEI5h8Dnwvy7aoSNi7jqBlsaQfmKRSXbGdgQsdJJ/yTxqIlQiFFt/gg9XcEun46x1fM8FMqalb4sRx5ODIsPL1d4DshzbdtnmqrjUtmxM1WVQ7NrzzXoTgm2SttCNLbGmhoKSkGFN9Loyu4MHh1QjsvYCa5nxHXZqx1+rCmHxGF7+lH4UPGfvqEHm2Tbf+5OYWzalFvz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opfrCUQhstTmEWhDCMZ446EAzDQXpi+cbl+vvgZtrP0=;
 b=1GSexDf8+18j51n7+cQmgRoYULNXUuSLqkLLrNXgiCq9gde/QDWp82fbujopFdKGpWxxA+JSlhxWqX6BaL9vwpure/A5EG1ItX+QzOeFJelLk6sp1RcJAq6hN2KEOJ+FUeKmQ9etQCX4kt9jAVUpYgjTy9yYYwYvntvNWzXEdWs=
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
Subject: [PATCH v2 19/28] drm/bridge: ti-sn65dsi86: Use drm_bridge_init()
Thread-Topic: [PATCH v2 19/28] drm/bridge: ti-sn65dsi86: Use drm_bridge_init()
Thread-Index: AQHVqpi4n744fjqeC0eCTHPE/a2o9g==
Date:   Wed, 4 Dec 2019 11:48:18 +0000
Message-ID: <20191204114732.28514-20-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: b2c2fc97-74b0-4366-470f-08d778afe2db
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|VI1PR08MB5551:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB555183D4AEB57DE6CD2399F68F5D0@VI1PR08MB5551.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Ee8US9YYDLIamDHsVWNhK0wsPhjx0r2hLi/WzW6cH7KY2NCfcT1SdGVWBV/r/2Su1Qz9RqkprqD2MIttwwD9WOROL2vy6BaN2t+Exc1RFoL7l8bnDFHKhZ5JhbZaFbhR0TrVP/twY+ekr8JHd4XJp935yGF4Odv3NPLKx0nC3GWOTMIqis40gWZjMs9QgdG7+JhqvriWSFiMkVYcgKyexpdb5rjGLF4RUdNM1zLJVeIdjVJJVHAFT2N1259kg3t0fuZVoWGC3hstp7HBpWVrlrvA8S7PSInJg8qPmW9sdwSXdE4IxDRoy8ZqZ6dFM3X5EMnf8Xh4kkELBMOL+RQInh6deD6qGi2c7yWTCGpbZLb8lnoDQOdhElAgWUSHDc6TtfcKcLK84HnLOcQ/KOjwIU4/2dUFKWfQYCcvqNFbMKXrq+fT9xE1wF4RIxzzs08X
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(54906003)(36906005)(316002)(70586007)(99286004)(70206006)(102836004)(5640700003)(6486002)(26005)(76130400001)(4326008)(6506007)(11346002)(186003)(6862004)(6116002)(3846002)(336012)(2616005)(305945005)(7736002)(2351001)(76176011)(6512007)(36756003)(2501003)(50466002)(14454004)(23756003)(1076003)(5660300002)(2906002)(22756006)(478600001)(4744005)(86362001)(356004)(81166006)(8936002)(8746002)(81156014)(50226002)(25786009)(8676002)(26826003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5551;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5cd40efa-2662-4175-beb2-08d778afdb19
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AS2LNBMwUxVM3aKvPHo07xnw3QrPi8qrpXjvdy881RmfUxNVavdNg8yq5dukfEjHzguIb3v8+XeqzTO7SRqWZjysXHO7DZRAa0IjZK0uAhMq03DRFpKHYmcS+GP4q0CJj1npmrkubW+CEWip9nsW1TP1FkXQEIi8esQhWAxsrfrCtDPjy5AKYnSxrezVLe6AfUBQBzFj5qZo0LjqEd+HyTpD/UYhLtpRfjW2lOczpM/GZr7jCoMhjJ7OtCJf0GUNB06PTUWX4034gPk8FrclnxxDxZYWlmneU24tE7rjV0I3aIJc+6vrXU3vPArn6F0lKSzMBCn2lF9W4jaF+vkp5rZrmT6HwNsVC7ATIROQ9U+XAJ79G0sTequzfZN6gRnlQP2xen7+TtA+87gRfj1lj+qiFB9x53DWrOFoxszhXl/fIIE0bSBok1mc0aAmHu4l
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:31.6255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c2fc97-74b0-4366-470f-08d778afe2db
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge=
/ti-sn65dsi86.c
index 43abf01ebd4c..4e236b46f913 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -765,9 +765,8 @@ static int ti_sn_bridge_probe(struct i2c_client *client=
,
 	pdata->aux.transfer =3D ti_sn_aux_transfer;
 	drm_dp_aux_register(&pdata->aux);
=20
-	pdata->bridge.funcs =3D &ti_sn_bridge_funcs;
-	pdata->bridge.of_node =3D client->dev.of_node;
-
+	drm_bridge_init(&pdata->bridge, &client->dev, &ti_sn_bridge_funcs,
+			NULL, NULL);
 	drm_bridge_add(&pdata->bridge);
=20
 	ti_sn_debugfs_init(pdata);
--=20
2.23.0

