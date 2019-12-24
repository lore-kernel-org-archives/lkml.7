Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB6EC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4C22071E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="baahbcBL";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="baahbcBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLXRev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:34:51 -0500
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:47537
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbfLXReo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9ls/aoOTQc/7MCW/HA8um4kag8X2AYI+VRD6FJMDQ8=;
 b=baahbcBL2cPpPIwD5vfa3GKry+0ufILeUK9hbzwobGsB5V5wJRU6heGlc+Nj+o5EbDK7A3PgT8juv5TgjwdP7vDeCjXlxlbzb8UUvC3AQCHOVbTV9s4HPNefTSVmBdsiNXgN6rP/Q2EqPEElnHRt5K8+07gfbk2XVyAOW5Mjf24=
Received: from VI1PR08CA0159.eurprd08.prod.outlook.com (2603:10a6:800:d1::13)
 by DB7PR08MB3146.eurprd08.prod.outlook.com (2603:10a6:5:25::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Tue, 24 Dec
 2019 17:34:37 +0000
Received: from VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by VI1PR08CA0159.outlook.office365.com
 (2603:10a6:800:d1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:37 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT012.mail.protection.outlook.com (10.152.18.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:37 +0000
Received: ("Tessian outbound 4f3bc9719026:v40"); Tue, 24 Dec 2019 17:34:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4f94b2c4191e1048
X-CR-MTA-TID: 64aa7808
Received: from bce15b33d58b.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 14734123-E42D-43C8-AB4F-C8604D2EFADA.1;
        Tue, 24 Dec 2019 17:34:31 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bce15b33d58b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYGgJjnaThC5x1e4xrs50VzaKO92aAWI/+FLaARuK23V68Kkc5Upl5oeSlItpqA5/CGUojJ984ieb4DoIooJJWJzuYVhN/N3VkBpN/SQR+gEB7FqQLi04gZDyi71VmBVs4s7FzYvFXqMiqFSF2LQWPyGKaD8b3GxxyjwTU+G+T6hV/ETM7oktVFTWRiuhS1uLwVpdI+rsj8yzrZAE2/ZHU+T9B1ByA0k+j78E1DzEVxSGoszuwz3/nH5zCRraHKikr6YiaI9plvsb1RwFtY7Hktt5hmL3synxWrELYmGq7ZCEy8HR478njo0Y0Fu/wpJ+mAh3WxZjAIy3fS42NZHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9ls/aoOTQc/7MCW/HA8um4kag8X2AYI+VRD6FJMDQ8=;
 b=bsRaNTDUofCQR2azxiRq0PJwUtVy2ciexmxo0dnlnSBQfX8P0hKUQxz1i9NTlCsmXkeLxDYqmjqx5NLwRJKoKmlUwQ0rnxeTYluy/ymluMdsahyqH5sxAz8WlnxwaL7UWM6CFvjQYU/a9NGQs1x08i4l5OL2QlEme1GMgpn08M9BwP+FUHp3xZ2aEwiA+ZEc+dz0m5QxiflvJDrDs/1Hwzt7GIv6sZv8VvdjsQeo0XLDBF7lDhgcrHjK9T3mxNFlzuSRJZEXu36eL5uXI/U74lKfh5E1TVZzokvpMcQgsjmBMHmEMTIG/GIFy/TXfeMXi81Tk1ksqMg5TrGGHr4dKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9ls/aoOTQc/7MCW/HA8um4kag8X2AYI+VRD6FJMDQ8=;
 b=baahbcBL2cPpPIwD5vfa3GKry+0ufILeUK9hbzwobGsB5V5wJRU6heGlc+Nj+o5EbDK7A3PgT8juv5TgjwdP7vDeCjXlxlbzb8UUvC3AQCHOVbTV9s4HPNefTSVmBdsiNXgN6rP/Q2EqPEElnHRt5K8+07gfbk2XVyAOW5Mjf24=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2702.eurprd08.prod.outlook.com (10.170.239.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 24 Dec 2019 17:34:30 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:30 +0000
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
Subject: [PATCH v3 10/35] drm/bridge: adv7511: Use drm_bridge_init()
Thread-Topic: [PATCH v3 10/35] drm/bridge: adv7511: Use drm_bridge_init()
Thread-Index: AQHVuoBkMIOFtQciZEaSiVpU4Xi4LA==
Date:   Tue, 24 Dec 2019 17:34:29 +0000
Message-ID: <20191224173408.25624-11-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 302d46f7-34d1-4e20-4b3a-08d788978c69
X-MS-TrafficTypeDiagnostic: VI1PR08MB2702:|VI1PR08MB2702:|DB7PR08MB3146:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3146723A0638191B4B867A478F290@DB7PR08MB3146.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(81156014)(8676002)(478600001)(36756003)(4326008)(8936002)(66446008)(64756008)(66946007)(66476007)(66556008)(26005)(186003)(44832011)(6506007)(2616005)(81166006)(71200400001)(316002)(2906002)(1076003)(6512007)(4744005)(54906003)(6916009)(6486002)(86362001)(5660300002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2702;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lJxQfiB6NUo0WJi8UFdhO7CwcIiqYthGwzeutXZa7MBo7fQDC8UuG6A9apT4GLLqzBtmeDhm+jXwfJPevTaltYJtHC8dqxQRcKoiuAWInJDriLG9mlcgUtw//zUIENLx9GQ5W+vGeuRx8Cq9Ylml0T6TviqyE/TmGGzKqfrqrS4D+ysajkbOXJknWuIiRqFbDLFrhzhghZLvaGfHHCtE8kMjRHtkW32pIxdn8UYyGEUmxp7qCTGWEIkpSKcXEWzozH42hW5grXo9GE0t2iAsdeRVxfX4KrEk5PzUtluU0yQIy/fuEIM/dSfYKkIOBiW+MhGUEE1+4GZSZHz5TxuKtDVwVzo0cPT7IQC2Tnv8hEZiP3++wm1IqoRDLSvclfJ8TB7T6/0b9yvOMmn5rixDoEsqAZNYOT+ZmrJYGrQeqN7IDzSLwy+U+VFz37XyD6vu
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2702
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(54906003)(6512007)(2906002)(1076003)(4744005)(316002)(76130400001)(36906005)(6486002)(70586007)(86362001)(5660300002)(70206006)(26005)(186003)(81156014)(107886003)(8676002)(8936002)(356004)(81166006)(6506007)(478600001)(26826003)(6862004)(336012)(2616005)(36756003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3146;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e20c03c1-2f25-48d0-920f-08d788978755
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTBgbql7+lGu8s49YJe7tvcluHUV6W/oWvGdOg5yvnqhc01nJALmeeNaSY3Di4ZAFHjHjFA7JouOhsCHnXdKHxN540BDtEHQftNOJpGV4dvp3JTV2hRangsJ6A76Xdqxm1RXEeTpVDT4bGrdlOkTw0bpEo9GVPM6MKat5CMdbS6Xt0gYnuZbX03depHPlXSXtyyDKen9iNjsvbrQi8qQHqqnqWcqVeSBb+C5+MnWKOjCUFEVQBdfw7WV15rmqXx4OP0qS/5G0gLQ4dxZyzAgUuYYcusuPWlM2Uen3E/QKztg4WizojhFfAhA4GW7U+wvE1vjVTtpkguTsDibn/HKPlwin1KAc2dXqZJTxhtVAe88E8ljXFsyFNXYikNFfTUJyTNYp3EJIhdmBdcErtqcbraJOXZUraS3fyKcUlUd8h76YjWm1OnY0j3/mWIh54uS
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:37.2343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302d46f7-34d1-4e20-4b3a-08d788978c69
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3146
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
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm=
/bridge/adv7511/adv7511_drv.c
index 009cf1fef8d4..14a393f1c957 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1216,9 +1216,7 @@ static int adv7511_probe(struct i2c_client *i2c, cons=
t struct i2c_device_id *id)
 	if (ret)
 		goto err_unregister_cec;
=20
-	adv7511->bridge.funcs =3D &adv7511_bridge_funcs;
-	adv7511->bridge.of_node =3D dev->of_node;
-
+	drm_bridge_init(&adv7511->bridge, dev, &adv7511_bridge_funcs, NULL);
 	drm_bridge_add(&adv7511->bridge);
=20
 	adv7511_audio_init(dev, adv7511);
--=20
2.24.0

