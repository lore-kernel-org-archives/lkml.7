Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D068BC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932602071E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="uUGvG83f";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="uUGvG83f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfLXRfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:35:01 -0500
Received: from mail-eopbgr120075.outbound.protection.outlook.com ([40.107.12.75]:28252
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727072AbfLXRey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av4RbeCcIzFcw7SkwkihJbx+cKuz7Y5laN42tNG5wis=;
 b=uUGvG83fhFTrFGFphPyCiicaqtJcFh91ZKcl6pDC7abDk30ie7n7Uf077v50H1W1B9nQVnqqq6zyAtsi+f4yVlc8xXbe6fU4Ws3KvJkjmvWIvhDMYcnJ/WMBmP9qFrdiT1+HQ9wl1flVpvVrxfDEQhbxItIpDq4gkTDPi4QLKZ0=
Received: from VI1PR08CA0122.eurprd08.prod.outlook.com (2603:10a6:800:d4::24)
 by PR2PR08MB4665.eurprd08.prod.outlook.com (2603:10a6:101:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.16; Tue, 24 Dec
 2019 17:34:49 +0000
Received: from DB5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by VI1PR08CA0122.outlook.office365.com
 (2603:10a6:800:d4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:49 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT005.mail.protection.outlook.com (10.152.20.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:49 +0000
Received: ("Tessian outbound 121a58c8f9bf:v40"); Tue, 24 Dec 2019 17:34:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1f14b32a4112de92
X-CR-MTA-TID: 64aa7808
Received: from bdd2edd0996c.4
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 090D986A-5886-41E6-9684-1759EE94A263.1;
        Tue, 24 Dec 2019 17:34:42 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bdd2edd0996c.4
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mpu8dwem56N9YN5JmiJMpYqfdezW2ZBlZFv1bFG7DRc7MPpqgyTiS/BAONsno+JdrA4BXJUgpUMeLKlpPIoDjk7fk4CZf7ZBZS+yd1ZMTvMurEagyyXMUYUUwQJitIgLOZpHiOOJ1ClFrHjIMvKpuSKX2ArKA1qIhLydezoGUwAlzSq6u4vZvuC03UxP1yjG05sR2mt2pYGg3HuJORnlystvKtP4xwrM59mvi6irnF5GwHFtt/z5ewvnqlL7XmggusHf5f1MVCrOktJTHse2x1Fcw5n7/3f6dfZZE3s6SxeRNqNd71+T0rWI3cfR1m+ZOIZ+ht9yGQ2FL3ihWUi1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av4RbeCcIzFcw7SkwkihJbx+cKuz7Y5laN42tNG5wis=;
 b=nG+viiJ822pmzSc7tGli67gz1pHBKKcGMSPI4PVt7GyvmCka1IHQUT9sljXj0+n2OMJVLrZ+XENSSJtzG98crVslfoS/PHmmX0z2epVkBKOUPCKIo6ORQgr717rynbk0v7cbh68/Nd6W3njBQljE4Bi+UZZDI257vKsoH7eCldoWuFU62HyVbXQMr51HoBlYgdf1OHidvmFjowLnLwFZUH/DkyrXQnHF1zHYGeW53FjKfkZO9o29SydpGTZGbaqoAqYv1lYWAu5Kwu0gEzujlk0CethzyJfmUA+/mP+RmIm2Q+RCocNjb6yUuDgLfzkaCehBso3qRxU8ZaB0MaNDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av4RbeCcIzFcw7SkwkihJbx+cKuz7Y5laN42tNG5wis=;
 b=uUGvG83fhFTrFGFphPyCiicaqtJcFh91ZKcl6pDC7abDk30ie7n7Uf077v50H1W1B9nQVnqqq6zyAtsi+f4yVlc8xXbe6fU4Ws3KvJkjmvWIvhDMYcnJ/WMBmP9qFrdiT1+HQ9wl1flVpvVrxfDEQhbxItIpDq4gkTDPi4QLKZ0=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2672.eurprd08.prod.outlook.com (10.170.238.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 17:34:38 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:38 +0000
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
Subject: [PATCH v3 18/35] drm/bridge: ps8622: Use drm_bridge_init()
Thread-Topic: [PATCH v3 18/35] drm/bridge: ps8622: Use drm_bridge_init()
Thread-Index: AQHVuoBqBe6XtLdBuk6r4vxdiq10BQ==
Date:   Tue, 24 Dec 2019 17:34:38 +0000
Message-ID: <20191224173408.25624-19-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: d97b4d66-41e6-4469-87a9-08d788979377
X-MS-TrafficTypeDiagnostic: VI1PR08MB2672:|VI1PR08MB2672:|PR2PR08MB4665:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <PR2PR08MB4665B071EC1597D5FD6C20E78F290@PR2PR08MB4665.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(26005)(52116002)(6506007)(6486002)(81166006)(6512007)(81156014)(8676002)(8936002)(44832011)(54906003)(478600001)(316002)(6916009)(2906002)(4326008)(2616005)(36756003)(1076003)(66446008)(64756008)(66556008)(66476007)(66946007)(4744005)(5660300002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2672;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hatUIA2eTnc4ZDQShxaQs93+xUl0tVSkLAEQeb2DieMTXzLhF1ucFlI7VnxAkK4lEpqmfjVMuVwaCy0TBgB04g+hQjtER3hc46cQCMBi+WKXI9v5hUN1I+UIedO2Ns8jofy84KHj8kbuaGkqrc0W7WFiYZdLSuhTjoTQyQ8VYNVhe+31y42zB8BCASBJXWdS7bPuteaK1AGWRKCxX1L66O554h8pLXDcX5aVzxwO51hjyuQpQ7o4wSWt9kaYh9ttcnLBtZCHEh2v4848X5b9OfXNR9WKCsSTnA0RPcS+ECBMidFewfL7p/dT371O3c4UUZBVvLd1mo5FRP29am1/X28GADjzaXiOIapIudE0LygyJBDBrpX5wdzGjsd0XR8P6Wn43/HF7JlV6SJOfhQGggR1QYsi8oisBqyFaFwHAEj5JtS1ywV1Z7e/bp55KMjW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(199004)(189003)(26005)(70206006)(6512007)(2906002)(336012)(316002)(1076003)(2616005)(86362001)(6486002)(186003)(6506007)(70586007)(478600001)(8676002)(26826003)(81166006)(81156014)(6862004)(76130400001)(54906003)(4326008)(5660300002)(107886003)(4744005)(356004)(8936002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:PR2PR08MB4665;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 88a5d40c-ae1a-4634-4969-08d788978cb5
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RW5nZhQo6OxJg4HSfIFDev7V9DveaJ/Qp/TpZCRQ4RLLratSen1/donzDuSO7rXpKYg3GzXjZv4sATB/AYoU+jIu1oB7X/JKhKnpSkkMhdR7jdjtgdtw7Tgza0FxLqI8IDIFbnKel9SZyHT99zKUZgh/QG/LJNScl2PMdunwaWsKhvF+xoESzpjgLfIFOk0RjxIBgGr9SpiPcBc7FBfp4efWqOujVmZ/Wu9v2YjGjBqcfkrPUpg+aYNX2475zVgn3jxEgktfj3HS5YrmAZzm6e6yzqpZ4DAicXbiT8kAcJuWRyKY5k5xi9uzfwXw5q7EBGHwtDPdSx3J2QVvJ8tbVplmAPZmxz1uKFt7TooUmGSeHNo8IE+YZRNVp9tNUi1+R4UdTW5Elyp8gofwYGQoobHTSRauKlAGmcbj+sSxjxwQttU6xR0taYDw0Q6XG9g6
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:49.1207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d97b4d66-41e6-4469-87a9-08d788979377
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4665
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
 drivers/gpu/drm/bridge/parade-ps8622.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridg=
e/parade-ps8622.c
index c32af9c2bbcc..ce870f26e93d 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -588,8 +588,7 @@ static int ps8622_probe(struct i2c_client *client,
 		ps8622->bl->props.brightness =3D PS8622_MAX_BRIGHTNESS;
 	}
=20
-	ps8622->bridge.funcs =3D &ps8622_bridge_funcs;
-	ps8622->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&ps8622->bridge, dev, &ps8622_bridge_funcs, NULL);
 	drm_bridge_add(&ps8622->bridge);
=20
 	i2c_set_clientdata(client, ps8622);
--=20
2.24.0

