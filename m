Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B451C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF2E2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JZnFu6fr";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JZnFu6fr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLXRgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:36:16 -0500
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:19427
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726984AbfLXRet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYlkeJ90WiZW8Cggtnrv/K+fKTcTQr56ghgZZwwHLbo=;
 b=JZnFu6frIx93pXcxsyo2Pb2jIu/iV0wHEj31Ara6SuGu9/LsjwVueu7NGSWusvDf/PMLRJEbSzGU1udmerY8j3rJaiQhSNzGdSuQu8tm1FiPPx7W+Wxjsj9fC9qOGu/yLeyFGpuvuh2czBY9ok0XdGIJ7gjxgBuEUkJx6goQv+s=
Received: from AM6PR08CA0015.eurprd08.prod.outlook.com (2603:10a6:20b:b2::27)
 by AM5PR0801MB1908.eurprd08.prod.outlook.com (2603:10a6:203:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.13; Tue, 24 Dec
 2019 17:34:42 +0000
Received: from AM5EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::209) by AM6PR08CA0015.outlook.office365.com
 (2603:10a6:20b:b2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:42 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT006.mail.protection.outlook.com (10.152.16.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:42 +0000
Received: ("Tessian outbound 1da651c29646:v40"); Tue, 24 Dec 2019 17:34:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8cffa408b5dfffe4
X-CR-MTA-TID: 64aa7808
Received: from a20093a6efd9.4
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E4898AC4-9CBA-4373-915A-5BC35E8B3BA9.1;
        Tue, 24 Dec 2019 17:34:36 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a20093a6efd9.4
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj4CtvK5aMiabpRYT4r5CerBHl+NyXPjUZ64IOfQOjVcC8weoPBrT7aYc0WQlfMtHsndvUsxozJnoGPlQQXWNhbBhmJSlixbmAs0p2FYk0PVxLSQ4A/Is6l/KDaddbAgkHWsHGHvCwe/JC+VdDC9aFQuVi34EAL9/fPqAfn7ORtGb3l4qE/H6YSTRDwKtl0w/5RYkt9aTuFXT5my1OrWEPTmymtajKyrJQ2LFnN+opyWtrDVxQZFaFmYKO4Sk/EVxWFFXfOXxryAhzFjt1/8hmByVB/zUPoWyYxezZALaYixdVkIElo8XQITaf8taVgnbUBYTg1j99Jw/6SQS1YZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYlkeJ90WiZW8Cggtnrv/K+fKTcTQr56ghgZZwwHLbo=;
 b=B4QlyjAf7XK3jXAAYBpuqXQK7agkWOyStVU8/W0cqf0Q1qr+KHNJK90dqLtaLD96Mv7S43vFcYO8x31yvxVZaP7TjUbEjiAdhxZCSFNiGsXElK+biHEJFhxr+myFXxvLC57YdZsYFJtdZI7ODNy077k1A1aDL7LSC/PI34M+9gxAgBNaWuL2QDCSeekWG2XHoJM1QubQv0WCBdvhaQEzTysi6FHLGK9bPg/FwCePefMomfMO9BoJtVWROCj15ZanvOdBicdmnxt+iqPej/a2ON2B/FhuwieqUKcaPwXBZSROH5Bl6Ul3eljmcAvHIRqgcsMsj0oD0m37jX/eytfr+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYlkeJ90WiZW8Cggtnrv/K+fKTcTQr56ghgZZwwHLbo=;
 b=JZnFu6frIx93pXcxsyo2Pb2jIu/iV0wHEj31Ara6SuGu9/LsjwVueu7NGSWusvDf/PMLRJEbSzGU1udmerY8j3rJaiQhSNzGdSuQu8tm1FiPPx7W+Wxjsj9fC9qOGu/yLeyFGpuvuh2czBY9ok0XdGIJ7gjxgBuEUkJx6goQv+s=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2702.eurprd08.prod.outlook.com (10.170.239.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 24 Dec 2019 17:34:35 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:35 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 14/35] drm/bridge: lvds-codec: Use drm_bridge_init()
Thread-Topic: [PATCH v3 14/35] drm/bridge: lvds-codec: Use drm_bridge_init()
Thread-Index: AQHVuoBovxfdmrLJtUmljZ+7k+j1zQ==
Date:   Tue, 24 Dec 2019 17:34:34 +0000
Message-ID: <20191224173408.25624-15-mihail.atanassov@arm.com>
References: <20191224173408.25624-1-mihail.atanassov@arm.com>
In-Reply-To: <20191224173408.25624-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.24.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 844083b8-b5b0-44ca-bb34-08d788978f56
X-MS-TrafficTypeDiagnostic: VI1PR08MB2702:|VI1PR08MB2702:|AM5PR0801MB1908:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1908216B22C4FF3BA114EFF68F290@AM5PR0801MB1908.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(81156014)(8676002)(478600001)(36756003)(4326008)(8936002)(66446008)(64756008)(66946007)(66476007)(66556008)(26005)(186003)(44832011)(6506007)(2616005)(81166006)(71200400001)(316002)(2906002)(1076003)(6512007)(4744005)(54906003)(6916009)(6486002)(86362001)(5660300002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2702;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xYyvdLTWwqX6ZAsJAbCP1Frd/om+vqcaapIVWJ/ky4br0QXobeS4y6lJr0bG6NexC4d3/xAQAJ/iov6tJiwaiCifQ8ujjUO8+/z89KrIbeA86GAUhkJIAoOATMuZ5uwyGUNT65LtiDynetw/gSdyfBgInUhDxrnu2DutR07lk2f2nubCdo99xMmxLo9n7SqupIreKp0Tbl9GtF/ZgFqc8VK3dSA7bJBg+GvVZFg67U4RNGvyObgQx1ZiadChRuglF2Hgq2xU0b5Ucf4wBdRHhAiK2CSonXKZIUVc0Dg2F6J0Di5OcWitt+i/FWR2aAG/E+Fr8SkGBd1WJOlM8/M2hiYjjYVDGTpmci6/BnzQvVBgMV9P6VlzU5awqSz6sT4iDb7H2zkB+rVqikG9W3jP3rxPz/qbnEVfYrkwG7VQGJEexu08f9NBu5GA/HOK1qWI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2702
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(189003)(199004)(6486002)(70206006)(70586007)(107886003)(6862004)(54906003)(36906005)(4326008)(356004)(1076003)(316002)(6512007)(36756003)(2616005)(5660300002)(76130400001)(2906002)(81166006)(86362001)(81156014)(8676002)(6506007)(478600001)(8936002)(26005)(186003)(26826003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1908;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: fe05137c-8a34-4a60-73fc-08d788978a48
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCaUrE5vOWiaD/U6cG6ZZ+y284knruhGiZQ6a0kXdWHpDj3v9Sf2g57SFOwo3L9032caZbc2P+7G1R3nLiXA+QjKdg6WLbNEMmcFvEiDmRAk8g+A2SOU/BNb0xS77tI6or2C3zYnO+tRA/aoXciCaFPBuUX8YSsVpo6Mf7q/Vbj5aBGr73WOIdxf4xY/hEW25c5DeFgTUjMe2++3ltYMoLHFCqUpdJtyKPhBQn2I4YnQ09x2GqrGnNYHHyBQhMQv4udkjb+YaIp/efJsvTO5hHZIl/KMcdPpe0DCtOhWO+nRXJ7LxtV9V8tL7V9D0Pkdgg8b1s/PoFel5FNxKKwBTO1X++TORFEP4UWYfaMSRqLpONnB+Jy4AGtLLGQ2gMzZI4N3m9k73z2y60GYSD00jyGae2KmlxRDaabJqd2jCV3yqfhPRnDNkODcg5lNqtch
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:42.1859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844083b8-b5b0-44ca-bb34-08d788978f56
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1908
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

v3:
 - drop driver_private argument (Laurent)

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/lvds-codec.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lvds-codec.c b/drivers/gpu/drm/bridge/l=
vds-codec.c
index 5f04cc11227e..3bdfa7cce6d9 100644
--- a/drivers/gpu/drm/bridge/lvds-codec.c
+++ b/drivers/gpu/drm/bridge/lvds-codec.c
@@ -98,12 +98,10 @@ static int lvds_codec_probe(struct platform_device *pde=
v)
=20
 	/*
 	 * The panel_bridge bridge is attached to the panel's of_node,
-	 * but we need a bridge attached to our of_node for our user
-	 * to look up.
+	 * but we need a bridge attached to our of_node (in dev->of_node) for
+	 * our user to look up.
 	 */
-	lvds_codec->bridge.of_node =3D dev->of_node;
-	lvds_codec->bridge.funcs =3D &funcs;
-	drm_bridge_add(&lvds_codec->bridge);
+	drm_bridge_init(&lvds_codec->bridge, dev, &funcs, NULL);
=20
 	platform_set_drvdata(pdev, lvds_codec);
=20
--=20
2.24.0

