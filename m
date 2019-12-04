Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695ACC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2774520661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AWoRiu4v";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AWoRiu4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfLDLsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:36 -0500
Received: from mail-eopbgr20061.outbound.protection.outlook.com ([40.107.2.61]:64133
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727809AbfLDLsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG65isiFDLr+qbpV61uGylAb5rk13yS4rBT9XdjMRJo=;
 b=AWoRiu4vUlnxXR/XRpkfe/S7rlznzgt0NZttkwwk5xYoM5MLEHNUU1YFXFa7mOt+joGLFd60MKD9VWsTSc7WSHDpSfYi8YTXEKDf9qkbYBGmIUlds+22HBXMnNhTCzotWaQdupdYix/DiRcmvTcmWVO2Eh3aY/cR/GwjfPE3syU=
Received: from VI1PR0801CA0075.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::19) by AM0PR08MB3428.eurprd08.prod.outlook.com
 (2603:10a6:208:de::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Wed, 4 Dec
 2019 11:48:25 +0000
Received: from AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by VI1PR0801CA0075.outlook.office365.com
 (2603:10a6:800:7d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:25 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT025.mail.protection.outlook.com (10.152.16.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:24 +0000
Received: ("Tessian outbound 691822eda51f:v37"); Wed, 04 Dec 2019 11:48:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: afd437b83f5afa12
X-CR-MTA-TID: 64aa7808
Received: from c7e01adb9f43.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0047982A-6A09-424F-ABFC-C8B126E00B8E.1;
        Wed, 04 Dec 2019 11:48:13 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c7e01adb9f43.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FenAjWvI3+20XAuOXg9Ocgh+8owCdvy8p3SBl8mXF1RFDyDrdN+G/qOq7KEsQPD0z8aGWJ/EGGlvL2NcxwI4imcrroc4tY5Y33E0UWzCMVlQyIdX24QRGPpRAWhbcdzU6/gKX3Sm52P1770d94iae5V3cnZu6dv1k7+bXo8/GKnRT5cgrGdBVL4jcO0dms6msw8aXCcW82SrVS0Vco0VGeTGkUrcm3150yF8ljnOwsT02DqZG+x64MkrlqW3ULEQsKwM8VwNJ9JjwK+jxFYUQV5Hbp8NxGyvcxW6kuhENUmRQltO6BOB8tzJE6g3tGzrryWqSgFzI7/wIZAbgbCzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG65isiFDLr+qbpV61uGylAb5rk13yS4rBT9XdjMRJo=;
 b=hZGFo038AmeKK2hvQawHhmT63HmFhuLvzDnCXdw64NK1apFF6zAHkg7fjWlw+0lLcSUeuSvV+d+m8HOe2+6PHOo1ScR8GRlQLsAB7z15h5cl6gjPpRflJH1UnrPWXux0e23+x9Daj61lz/UVvwJ8SheE6UhSx1oAbLNch/chqxbqKV5ZBG6Z80l6dpi801LRay8tL7vsLvu3cURRcx71pCm5eQV6haSSwqAh98mIDtz3km2CX8L2kz/0TG4Swy/OfuWSfm3qi+vZmiE/gZ2V/ZqMnWOKJ86fap8H6RtI5ImKqZoFvZlMyge5AheLPj9zuinytwUHhh+woN7V2MKdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG65isiFDLr+qbpV61uGylAb5rk13yS4rBT9XdjMRJo=;
 b=AWoRiu4vUlnxXR/XRpkfe/S7rlznzgt0NZttkwwk5xYoM5MLEHNUU1YFXFa7mOt+joGLFd60MKD9VWsTSc7WSHDpSfYi8YTXEKDf9qkbYBGmIUlds+22HBXMnNhTCzotWaQdupdYix/DiRcmvTcmWVO2Eh3aY/cR/GwjfPE3syU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:11 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:11 +0000
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
Subject: [PATCH v2 11/28] drm/bridge: sii902x: Use drm_bridge_init()
Thread-Topic: [PATCH v2 11/28] drm/bridge: sii902x: Use drm_bridge_init()
Thread-Index: AQHVqpi060ZTiZ8Q+E27VJLEZbFhxQ==
Date:   Wed, 4 Dec 2019 11:48:11 +0000
Message-ID: <20191204114732.28514-12-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: d2872b36-ed57-4a22-b0d7-08d778afdecd
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|AM0PR08MB3428:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB342803F180BC4B4C6865299D8F5D0@AM0PR08MB3428.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NF75NZAigPFc2OTrlEMXxMLnu+dG52roI9bkFzD4OFE5KAqWCe6+94RkSaJvCVaXcaSZp72mqyUTf1j/1KU83KT66yxHO5F0064n4osTUVfKxby/OsriyRJYudk1TQeDGlikDONTGIUgthjb7y1UM9hRsJPp9er+/jqDfN86LCwV+gmlbAIMpIDEZ1WFIownXD2k+Le6iTxT6YYBFOM27dkwqMSnkx/Y+tV89U2CEJlcAkwZLhNjGWU/VqIjVVX0xPhf7qz6VLU20wDMAIf52WLQcR81IfSEk0kTvOw4rcR2db9PJ7WoYQhlFMqmB0VQxaWFf7LWxooV91rGMlEhp2wcPipe9MDP5BHw76R5W15izLXJCIBbkjQFubUoSfkSPKh6lju/XjAvuRiSe32MHudO+W8kVut/5Rw1w9epOuhOZMhHFMRSU+T/3PkCuaaL
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(478600001)(6486002)(8676002)(8936002)(8746002)(50226002)(6116002)(14454004)(70586007)(305945005)(3846002)(7736002)(6512007)(2906002)(50466002)(5660300002)(6506007)(26826003)(36906005)(2351001)(316002)(76176011)(54906003)(186003)(4744005)(336012)(70206006)(81156014)(81166006)(6862004)(4326008)(23756003)(76130400001)(2501003)(25786009)(102836004)(26005)(36756003)(11346002)(22756006)(99286004)(2616005)(356004)(86362001)(5640700003)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3428;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d3ed424d-5a77-47f3-2f5a-08d778afd6c9
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joRY5c0CJZOEePlFtoxrHtLcsLUcuA9SzroTnNvnjtIe0bjbFio/7R1Rmw57AgOo6ZBBJBbasi4Ht34OdkHg0g7g7MFbGc6T58V8/TDKZ3ot1Rb17wrBtnCClz37oKdo7YYDQj1bkk6Tfh1EYTIs7fceGSaPfMfBTNlm0MkEuHMk/yPDQG6ZDPbes007DyLh9LSP5gX7POo5Np6mcaWC6SmrtSfUcZekG/X7SP/OfWD61NFNK7Wqu+RKa5J/gzkODyj5zyyvqMLKycZfatP8h3DErZTRG9+llBm1TB6bsCSQkHrSe8SCbuf4LL7X8Vp5vx3hWfqpm6lXm7WUjfsLlkzST0hNB+butMhkZocemVnCkFGM/07KHelqR9EmAvKE9Gh38qOQzfyOhRJPz+fi3q5F2Pw1fPsN4WM6Krnsbr02rgZcG1UkoqzQzPhnO2hD
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:24.8256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2872b36-ed57-4a22-b0d7-08d778afdecd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3428
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii9=
02x.c
index b70e8c5cf2e1..2a9db621484d 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -1017,9 +1017,8 @@ static int sii902x_probe(struct i2c_client *client,
 			return ret;
 	}
=20
-	sii902x->bridge.funcs =3D &sii902x_bridge_funcs;
-	sii902x->bridge.of_node =3D dev->of_node;
-	sii902x->bridge.timings =3D &default_sii902x_timings;
+	drm_bridge_init(&sii902x->bridge, dev, &sii902x_bridge_funcs,
+			&default_sii902x_timings, NULL);
 	drm_bridge_add(&sii902x->bridge);
=20
 	sii902x_audio_codec_init(sii902x, dev);
--=20
2.23.0

