Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224F7C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99D02075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="D1v+wKUv";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="D1v+wKUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfKZNQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:16 -0500
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:57412
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbfKZNQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdLraPscYl7N5ZnI1D+z6wvdTqf7jpr4JBWbRvcBLpA=;
 b=D1v+wKUvBEXmmvZ7h86PluO3iyk0BLQBh9rXYyQp7cvu0zpXVUvg7xQdsdwoMlKgwvNbmddDxbpfBItZqWfrMJxoom1uWz6q+8u6MuVbuw+xpggFOyKHjhQLX8RzfbUDHNy3GqnxQgQEarE3rTUCrFMm5w2LBPxTxSfXcniyNLU=
Received: from VI1PR08CA0169.eurprd08.prod.outlook.com (2603:10a6:800:d1::23)
 by VI1PR0801MB2125.eurprd08.prod.outlook.com (2603:10a6:800:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Tue, 26 Nov
 2019 13:16:09 +0000
Received: from VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR08CA0169.outlook.office365.com
 (2603:10a6:800:d1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:09 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT031.mail.protection.outlook.com (10.152.18.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:09 +0000
Received: ("Tessian outbound a8f166c1f585:v33"); Tue, 26 Nov 2019 13:16:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ae0827d16706ec77
X-CR-MTA-TID: 64aa7808
Received: from 687810ec6074.8 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5BCFF590-9839-44B7-81BC-84FF2EEDCFAF.1;
        Tue, 26 Nov 2019 13:16:03 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 687810ec6074.8
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOEiwG0rYLuSYKaauLV7oePvrJlQu7DrskAkwXOXyh1ppDnoYRzQ3e12lysKMDRjBit6n9XFDCEngYCct6Aoke9Y8mMoj2UXsFVmNpeg2zDN1wq3FOXNdeVJ/a7gWkefylANp+XeQSkEymkB+CPhU/wEPDtVOa/Kz4OLz57+NkIM3mqHDUb1dviRPwntG3l+0ff8fc8bj40kqV0NOfgzQEdDHCZHYVDGUwK2wJ9GLyGctYNEee+OCNDkgpaPg3QOHlzYy8MkXnJKt1cw9Kz557p8fntiH/JAuRKAf0vcvhD5pOP3dnwmzV36KhWenzcXk0Rp3bHhEleT+H6CsIeyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdLraPscYl7N5ZnI1D+z6wvdTqf7jpr4JBWbRvcBLpA=;
 b=i+X5n40YxhjsCGYiEpo9c8hEtPAMcJERLAWqJh0VSB19sPSG2UnBf0tjW+g+XxCW367PRVopBTv7q0XSJwBNIM6eCYCLb5Q6XyJVkGIPPxhx32iYuH9Wu/Tnqaenoy2bT+YWdLWmJPnz0CeoCuB5T1L6CBVRAGgU30HOcj8Ymk/HOZlPlR6AYL+DhS7/+JLph8+sGvwoZJInFF8ii1bytQfyi9IpvGHe20BuJSzo8aeDdIn+b1gZ6QrnwO0Fumw8FTlxHNOrS6jv6k0tJjRqfJNrANkTODmSzXWQCTn5HtPcGCM5A0c0nCdRvHk6r9muA+ntQsCjEhKerl+fSG2bvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdLraPscYl7N5ZnI1D+z6wvdTqf7jpr4JBWbRvcBLpA=;
 b=D1v+wKUvBEXmmvZ7h86PluO3iyk0BLQBh9rXYyQp7cvu0zpXVUvg7xQdsdwoMlKgwvNbmddDxbpfBItZqWfrMJxoom1uWz6q+8u6MuVbuw+xpggFOyKHjhQLX8RzfbUDHNy3GqnxQgQEarE3rTUCrFMm5w2LBPxTxSfXcniyNLU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:01 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:01 +0000
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
        Maxime Ripard <maxime@cerno.tech>, Torsten Duwe <duwe@lst.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/30] drm/bridge: anx6345: Use drm_bridge_init()
Thread-Topic: [PATCH 03/30] drm/bridge: anx6345: Use drm_bridge_init()
Thread-Index: AQHVpFumWN2LaRa5802T6cP9cvsh+w==
Date:   Tue, 26 Nov 2019 13:16:01 +0000
Message-ID: <20191126131541.47393-4-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5decec0b-b2f6-4bfa-53e6-08d77272cd61
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|VI1PR0801MB2125:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB21252897022F76B0DC99AAE88F450@VI1PR0801MB2125.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1443;OLM:1443;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(7416002)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(14444005)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0ONJWPJOth+Ob6G8gvodfCmi8+R02t70ub+3Ab8nu/DDw/CR4Ibie/oYV5Uxjg5GMWc91PViq4ky0jsK5Y8fCxf21KwOe2mm3Sk4WrJ/1l4PVERLdGgJqCkUtYoceJONU2/XLzdGhmsnpfK0rouNczDKe48+6yzh8eRMmq4K8Ps3joTUo0mhYTkQAALqzAUoxVL/Xu9bbj1V+5y/jl4P6BsA3I1qcIw+hcc3SN9ebcFGesF6tP/2oCVALlWLRilZJdKpDrm2dq2BB4L+xjQ22Xb2ViKMou1CMcXDgR0AV55XUtCGSnklCVcsn5fpHfxylxx3H7zToWjnjJ5JQguNbkP1cPZlCthjVwRxWt5/owP1qN9TAMlfGTIDkRq9S2GyRKd0kTemCu3J2w2vdeQVGyGV1pw+PwaPvVloDHEkPDWvjSxnMksqOt64701I+1t1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(189003)(199004)(5640700003)(305945005)(70586007)(70206006)(106002)(99286004)(316002)(8936002)(356004)(36756003)(50226002)(36906005)(8746002)(81156014)(54906003)(8676002)(14444005)(2501003)(7736002)(86362001)(6862004)(81166006)(23756003)(50466002)(4326008)(6486002)(478600001)(6116002)(3846002)(6512007)(14454004)(26826003)(47776003)(22756006)(25786009)(336012)(2351001)(66066001)(2906002)(102836004)(446003)(76130400001)(5660300002)(6506007)(186003)(26005)(386003)(2616005)(1076003)(11346002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB2125;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 742e748e-4191-45ce-d2dc-08d77272c866
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnet4UKwqdRY2ewLljMJoUgPA1kMmElPN/JHumJMNzJ/OIx8kPPYg6wbXp+uTIScnnJFXnJF3Q7i+g1J0kScptA/iebM0QAwJ4/r0ErRjKt642th5LB+6i5EAeFqvvO7XZypA3iwWkAVTWF/1/JuTTg/t0KMQm4zfE9WiMRoBel7NDCf15yPuvOKwDJiXSbaKUZOnT7ZE4jo6WODSDElI0JbwJLYGIzckfazTyCXd8tGKs5GrfHQOCEzGDG5I516lmKppoNDska+zyG9OXz7MBuiYEvnilvfccBhTAHnUOtYdwTJhPBEb2jTz1OJL0d/xWBwh7lMWnNwMenOdU4NJs+3BNgaWP/zRJBoztIbJCHY9/Udv+c3l2/qOGV77r28Ev6uN7/RLG4+qBYftAtnSluQxCc3RRedfJEiVPd4VztPs+PYyj8fduXxZQsWskhp
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:09.2469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5decec0b-b2f6-4bfa-53e6-08d77272cd61
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/g=
pu/drm/bridge/analogix/analogix-anx6345.c
index b4f3a923a52a..130d5c3a07ef 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -696,8 +696,6 @@ static int anx6345_i2c_probe(struct i2c_client *client,
=20
 	mutex_init(&anx6345->lock);
=20
-	anx6345->bridge.of_node =3D client->dev.of_node;
-
 	anx6345->client =3D client;
 	i2c_set_clientdata(client, anx6345);
=20
@@ -760,7 +758,8 @@ static int anx6345_i2c_probe(struct i2c_client *client,
 	/* Look for supported chip ID */
 	anx6345_poweron(anx6345);
 	if (anx6345_get_chip_id(anx6345)) {
-		anx6345->bridge.funcs =3D &anx6345_bridge_funcs;
+		drm_bridge_init(&anx6345->bridge, &client->dev,
+				&anx6345_bridge_funcs, NULL, NULL);
 		drm_bridge_add(&anx6345->bridge);
=20
 		return 0;
--=20
2.23.0

