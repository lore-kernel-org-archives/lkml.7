Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C620C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFCB2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="sqVVTiQI";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="sqVVTiQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfKZNQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:23 -0500
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:27971
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727667AbfKZNQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4D/5bCj6TvVVRDvDiedXMOypvZfwR1Fa0QcscRNJGw=;
 b=sqVVTiQIqqcaEvn1va8KsqQk/m12iCkPETnYuxNhHWWdeWBxxu+42NvaOzeQn7hszs0AQaFF7Cb1Hcp19K0jgg5CMVPLJFCVUeQioCAJQy2a97SyW5tOpBPoMPwCoHx1jvBb8vC/yjJyd7JjzglgUf7tET2n7erOOs38aC8X9oY=
Received: from AM6PR08CA0022.eurprd08.prod.outlook.com (2603:10a6:20b:b2::34)
 by VI1PR0802MB2208.eurprd08.prod.outlook.com (2603:10a6:800:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Tue, 26 Nov
 2019 13:16:16 +0000
Received: from AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by AM6PR08CA0022.outlook.office365.com
 (2603:10a6:20b:b2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:16 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT038.mail.protection.outlook.com (10.152.17.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:16 +0000
Received: ("Tessian outbound 512f710540da:v33"); Tue, 26 Nov 2019 13:16:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4942229eebfaa73c
X-CR-MTA-TID: 64aa7808
Received: from eb4165d38a59.4 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1DAE1596-2200-417D-A62D-830D93F26AF2.1;
        Tue, 26 Nov 2019 13:16:08 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id eb4165d38a59.4
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRQZ/GzVZm4JljAeFh8AuwTyTW00rDhlzi3DFhW85S3V/zRbPxzJfFyMnioegmWfdkyReVtGuzL80+HNOb7XrMsNKZ3qPzDnlTBhKwcfJn1NUg++uAOFyjhDE858D2MBMo3pOXYNcx+uzSn+pZTFk5KnYueKjBA7B9EgCuOhKBpqtffsEyCwR9+d/D/ndqm9wPe/rfO4zAbncO6NPXd1gWaSzpGy0B21y8l3cdTEJodKKYeZMHI4MJV2cXUdMTVPxfJlEb9jHORrzZeQ551t+TUR57TIYyhOjn6Za9sP9dbsJr+PEpYiUcwKBKoJ1XLykMvvBVwJkJ5en2pL7CqmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4D/5bCj6TvVVRDvDiedXMOypvZfwR1Fa0QcscRNJGw=;
 b=JU/c04osgz9ZPI9ERwihRNfyV9/KMRbPxXMuDB5rkGzaWxu2bC0u2AiyVbTNJ7GnNuUlR1rXv1WloI3EihABx1tnu6VSo8PFZ9Sjl3U3kegs+1SqqnCkMF/tLqeF/Fa/PV3xH6nb58ClDo3Ez5bbpHNHY6AOgNwThVhH3+gWi0kE9WIbCkcbcOtjlQqP+D9ZAsGUiKtchz/rxbpqqzf4xVZLsctNpM+wGY+H5FxAqpC7zk8WXH+XUhofpeMyAXKRDng/jOy/FpGde5Y977Or1gFXwYIPCse18SPIrDuRSECCI+NrA4XKIqK1AGyN6sonimczJ6jGD5q34AEwCjhAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4D/5bCj6TvVVRDvDiedXMOypvZfwR1Fa0QcscRNJGw=;
 b=sqVVTiQIqqcaEvn1va8KsqQk/m12iCkPETnYuxNhHWWdeWBxxu+42NvaOzeQn7hszs0AQaFF7Cb1Hcp19K0jgg5CMVPLJFCVUeQioCAJQy2a97SyW5tOpBPoMPwCoHx1jvBb8vC/yjJyd7JjzglgUf7tET2n7erOOs38aC8X9oY=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:07 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:07 +0000
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
Subject: [PATCH 09/30] drm/bridge: nxp-ptn3460: Use drm_bridge_init()
Thread-Topic: [PATCH 09/30] drm/bridge: nxp-ptn3460: Use drm_bridge_init()
Thread-Index: AQHVpFupslWOenScmkW8ORjTGjHPqQ==
Date:   Tue, 26 Nov 2019 13:16:07 +0000
Message-ID: <20191126131541.47393-10-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6e857dc-4899-4574-5e84-08d77272d16d
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|VI1PR0802MB2208:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2208D65829764DFF7BFFE06B8F450@VI1PR0802MB2208.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: kh/C7PCVsvfDVv3zTNKSmefSypczC4D8M7sHoEktOhaSzLiG2usy39fE7J+tU0Atv9D/vk+u8eVw7wD/PKmZjI6v+u8T9J1Kbl26ALFFupVS8iG9jnF/M6gE95STzVOArfX6I4QlrKWQSxxgQQyZlJcatiwyNwov421hCCzYCdMwOkzAi3ogfU+5gdW07bDLRb9cw4a7+umDWpnkmDlYvczs3357AS/EsndN1V1d1xF4yEeGxTH4IG5TyJvHY51CQ52gsjdMANewTP7YzBiXo3IZ/YdrTGZ84SnWR6aV8NPReegtwqdpA+CxGxBmRKYogPfdAl3m9zPeFtNSwQbwAjmxX/jct6SWKx5Eyv5K2EjVwFoEJDFQAuv/ZI0gKdD26tNvRxdOhvVVkt95ntT7jZ/RQfPOgLp1egB0WklLFW31Kc0e0F7jnlzFGwM4Hgx/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(11346002)(386003)(6506007)(8936002)(50466002)(6116002)(99286004)(8676002)(3846002)(14454004)(5660300002)(47776003)(76176011)(5640700003)(1076003)(81156014)(478600001)(6486002)(66066001)(25786009)(50226002)(4326008)(81166006)(26826003)(8746002)(2351001)(4744005)(316002)(7736002)(70206006)(36906005)(23756003)(22756006)(54906003)(106002)(70586007)(186003)(305945005)(2616005)(76130400001)(26005)(2501003)(6512007)(6862004)(102836004)(86362001)(446003)(336012)(2906002)(36756003)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2208;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c551a330-582c-4e98-9ad9-08d77272cc0a
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dVTpt9e4HGz4VM3moHQiG2bK8qrQhdYAgHR3yDwDQzWBRB6rJafYRM+BgI8AJVKxOWzLtgFcWjektw2yFlj6f9UWwTQERNnYlZ+tS4VN+jcwx1zcpf01K4A+i3gReBj/mdWO2+3Ck09qNOGeA26O2LHHe1EJd9r/7ZpXrV+e87tP5bG0h1kuDSlXnAPBOtJSs+xLA8snhIKtipFA/nKv765XUIujD2KvrKs5nXNTPKxEuqnOyzpZosv0lasHwSmSxEqli8eQYxbzyJESI77mEokmsH8FPDI2d5aOZ2kj1YxFlp2iMpMIIjtJ2XtX5qTLHuuD+jnyJrDNMjY3RHFN14BnSNOL+MKOls02iEGVLl5X/cuIIFfB5G7pMi5PyNA6uR9SJm3pnVLRRYvdu4fHt1uggSb2qkhmYrehbMCvs4hJP1ZjiajtmyZo+C9X+hRf
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:16.1048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e857dc-4899-4574-5e84-08d77272d16d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/nxp-ptn3460.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/=
nxp-ptn3460.c
index 57ff01339559..2656a188b434 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -320,8 +320,8 @@ static int ptn3460_probe(struct i2c_client *client,
 		return ret;
 	}
=20
-	ptn_bridge->bridge.funcs =3D &ptn3460_bridge_funcs;
-	ptn_bridge->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&ptn_bridge->bridge, dev, &ptn3460_bridge_funcs,
+			NULL, NULL);
 	drm_bridge_add(&ptn_bridge->bridge);
=20
 	i2c_set_clientdata(client, ptn_bridge);
--=20
2.23.0

