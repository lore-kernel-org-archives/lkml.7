Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF90C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F32020803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KqEffK2S";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KqEffK2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfLDLty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:49:54 -0500
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:37102
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727701AbfLDLsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w9IwS9h8Xe+mRvYuwjPJLzvhx/Jnmzx3UokA4i7RFI=;
 b=KqEffK2SJj3rTIjudwFyYTMxvDX/UiNB/sbU8YtNfAS9++1qEzHD6L/dMYLR4NupzvyM9hzQknfXD31CSOk4Ubl0RH9AfrHJXYhepp9EnUosX5A6qw6z+w8KJ0OHHG04LnpXaViAqaT5X4wCGdVL6IzEmg0iSPtmvt/fzkZFbn4=
Received: from VI1PR0801CA0087.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::31) by DB7PR08MB3465.eurprd08.prod.outlook.com
 (2603:10a6:10:50::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.21; Wed, 4 Dec
 2019 11:48:16 +0000
Received: from VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by VI1PR0801CA0087.outlook.office365.com
 (2603:10a6:800:7d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:16 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT030.mail.protection.outlook.com (10.152.18.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:16 +0000
Received: ("Tessian outbound 691822eda51f:v37"); Wed, 04 Dec 2019 11:48:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 717e2d4d0e7512b2
X-CR-MTA-TID: 64aa7808
Received: from b2b246179d1c.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F9F0B099-DFB4-4AE9-A4A0-2337A0979941.1;
        Wed, 04 Dec 2019 11:48:06 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b2b246179d1c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em103aLbp1u9HQhHMFpAwSoGvesKDRirkEW5nG3Be1TydbEKoCWdd4zIu6oQqo/BnrEifXtKuGiNxUJw/jiKoSSqN4XWSKsumyuS3p8gGQ8KsZZwtZUWrQP/6zJX5onVtQBsyYYkAP50xLYApU4DtkQUCuo0JAZF4XlHQcJQhj3PyZSIJnr/pPneNPz6N8oMWGYIBiUKnJ+z6e2ngLKfRYPsUYZY1D2mQHjqJK2wWOghfmDxSY8crgg/jTTQVUmtW26g/Cw2qVWnM4dV2ZilFSguINcQhRnfTZcXESN9jVkdhuzgPWBRs91PKjxMjoAuWMAhb9iDmDYYrH+WHj6J1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w9IwS9h8Xe+mRvYuwjPJLzvhx/Jnmzx3UokA4i7RFI=;
 b=AquXxAbKrykiwCBPKNCkVErB5IursPKASVkIRqtHO4npnZSCjQF7q285UD0tf1HjlORzUgAkHX2SwTpcSuGN8/x8H526U3ZaphB2NXml+MfoWs4/Erf9iarw6dODLdwBqg0cfLpvSWR9SgguZ+BeoDBfYJ2c2odrDcbnWkHIxRlbejOgK2CQzjdboxZYN4Dh69WxY7CMCeC1n7jzQL2UpGIBH9BniCp6Naj2fyDblbqMFpcEmR+yvkOzPGxPtdDmU6uuFi0siIcoeZdbEhX+7ueIvftjnm1LurMqyuBQkyeRImFKN8rIVC4ZVS/MvriZb12y1KAOMD6giVnW+/v+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w9IwS9h8Xe+mRvYuwjPJLzvhx/Jnmzx3UokA4i7RFI=;
 b=KqEffK2SJj3rTIjudwFyYTMxvDX/UiNB/sbU8YtNfAS9++1qEzHD6L/dMYLR4NupzvyM9hzQknfXD31CSOk4Ubl0RH9AfrHJXYhepp9EnUosX5A6qw6z+w8KJ0OHHG04LnpXaViAqaT5X4wCGdVL6IzEmg0iSPtmvt/fzkZFbn4=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:04 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:04 +0000
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
        Sam Ravnborg <sam@ravnborg.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Matt Redfearn <matt.redfearn@thinci.com>,
        Rob Clark <robdclark@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/28] drm/bridge: adv7511: Use drm_bridge_init()
Thread-Topic: [PATCH v2 02/28] drm/bridge: adv7511: Use drm_bridge_init()
Thread-Index: AQHVqpivL9XMRFOhwE2O6FoRhLb0GA==
Date:   Wed, 4 Dec 2019 11:48:03 +0000
Message-ID: <20191204114732.28514-3-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4f4ceb62-05a1-49a0-f087-08d778afd9d5
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|DB7PR08MB3465:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB34654AE6B2FE26C79FA280288F5D0@DB7PR08MB3465.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(7416002)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: RgCd+RHzocEtpskmBLtyY7/wW8DEc9zhm0qPOzrB3PQA5V4j54pkkq7Rwah9uS7uJVS8DKZl6YfR0FqeZaQFwBvzHf/PDaQsC2Bp4+8wzE7cMzv4JV1UMc5CaXkdEpv8FwjSUuRnm4inC8R2Puqu+0Sfkt8h9MBt4K5lytwUKdFeUF7SJpvJkge8tzxVI9s3pZ633bDYxkdQck8LD06dd4akSZiYISPTypTn64B7Cs7X26kmpXdAqQ5IMyGAe5loZxaOc/GsM9klYb6qJFFmHu1xIqGlY7R6TZMzioefaCQ5wzm4NStfwZgnM4ud9x0cBRbyX1/66VFkTDHVdUcm3+mvR60df9vbbvAwXRua380tM1p3KXuSnSlZ5n2TlOdR321zULR2MMsFYroOr9jQNqpU5YBspgcAkGUNVEwpFfmmSjPHP5RuAGFHw1zE2EB5
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(199004)(189003)(2906002)(6486002)(356004)(5640700003)(50226002)(25786009)(478600001)(36756003)(23756003)(76176011)(8746002)(26826003)(50466002)(6116002)(3846002)(2351001)(81166006)(4326008)(14454004)(6862004)(26005)(99286004)(36906005)(5660300002)(316002)(11346002)(81156014)(70206006)(8936002)(76130400001)(70586007)(8676002)(6512007)(102836004)(86362001)(6506007)(4744005)(54906003)(1076003)(305945005)(336012)(22756006)(186003)(2616005)(2501003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3465;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a8e4b175-9ff7-4e92-0eb5-08d778afd1df
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVdgGq+k6IV2KYVxmiTrqNexJqgZrpa/CT1eIfjs/I1EXKWn9Oliv8AcCJgnA2EmvJrtPKoxE4VL4CDXUwwbdFxIKaHP94Q3NakQSnPSrfeCKHlhKtGFRPaLr2Ji8nPKmb3DcemVOUnGQPp+Z6W4OC83fquJ7ZgFaH0T/bjvZyJJxIN3KrUZOF0pDSU1FrV7d1qz/utYPB5/2ZV1uQr4ehVh+tUQXGDRbBhBm5C/hEOdbKD3vZrQatvbbPaBkfUMZHDoXRh0c40IIzdz7zN8M1Kpic9sBZC+PK2zZ1th6NGPdhRnrKzhaH71fnMpRvUsNRibANK6QDFFSXeDQ3wOot2AWiHrmpSPvGaVsV4y5nfo6penydfS/RU2elcDODrKVPqIY6Tt9TXVaQNEZbH/adAOk0n7HQzN466Q4T5+raA8dblRI7LZBj0RPbpeqh1u
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:16.4460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4ceb62-05a1-49a0-f087-08d778afd9d5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm=
/bridge/adv7511/adv7511_drv.c
index 9e13e466e72c..73600d8766f8 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1216,9 +1216,8 @@ static int adv7511_probe(struct i2c_client *i2c, cons=
t struct i2c_device_id *id)
 	if (ret)
 		goto err_unregister_cec;
=20
-	adv7511->bridge.funcs =3D &adv7511_bridge_funcs;
-	adv7511->bridge.of_node =3D dev->of_node;
-
+	drm_bridge_init(&adv7511->bridge, dev, &adv7511_bridge_funcs,
+			NULL, NULL);
 	drm_bridge_add(&adv7511->bridge);
=20
 	adv7511_audio_init(dev, adv7511);
--=20
2.23.0

