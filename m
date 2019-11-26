Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EA0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AB92073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MoOxntQ9";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MoOxntQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfKZNQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:45 -0500
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:2125
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728118AbfKZNQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsj1ZwfMocxMmhXuaRq5ay7fcHZ5bq2hDSJxGG7/gpQ=;
 b=MoOxntQ9NBrdex9YXgZ/fvjvXPv3EvezXcm9Q1NG1a1f63nJAx7PrDeOPmlxausWAUT7zEW05BswiKzxhxnhOignJmRolEUPT/lbuhgvdF81e0uVOUsYptKzJ7OE8DHEe6VwFN+3S+vtHutm8UOIfVK1xUo5+1PMgPHt5q02j9w=
Received: from VI1PR08CA0173.eurprd08.prod.outlook.com (2603:10a6:800:d1::27)
 by VI1PR08MB3886.eurprd08.prod.outlook.com (2603:10a6:803:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Tue, 26 Nov
 2019 13:16:31 +0000
Received: from VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by VI1PR08CA0173.outlook.office365.com
 (2603:10a6:800:d1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:31 +0000
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
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:31 +0000
Received: ("Tessian outbound a8f166c1f585:v33"); Tue, 26 Nov 2019 13:16:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d50e3995147f7ce0
X-CR-MTA-TID: 64aa7808
Received: from 687810ec6074.14 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8B2EC3F5-2F8E-43AF-9D08-FBFB3D31EECF.1;
        Tue, 26 Nov 2019 13:16:05 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 687810ec6074.14
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsFnUarmYnR30lUpDJ2zKvZgTqf5Hp5g8HlZ3axlWoxWTZyzQsEXUswYerm7jHSTluOrUBpyUa89yR8/fgCNxJdWhtwn+aJBXE5vQSUX/IsWmpazXnermmlaEIVlFpaXpy8POtk4S4LJZdKhETMFJE5FytnOvjYk6hrkxyi4/PAU8ZZO+nDj0Emvdsp9ZST68wezjQGL6127iOx8z8F2WbR4q9qewydRLt5v2ABuHN+JypyaPGMQJsHFFUWoLW1aEYC9gnYwB0V+cWAu7HZ1KgJbTCWbknpvtIrpee7xAAMsW8E+1L4w3ymqdYR9FodftBCy5PnGKrFlk/zCfu/VCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsj1ZwfMocxMmhXuaRq5ay7fcHZ5bq2hDSJxGG7/gpQ=;
 b=LRodKbJI6dRvC8KiyYU2vtfexTtTuKYzEmsrMFEKEkaOBoEfGQVbxp96SN+aTzXwoelYFNahw175TEDsZdWYsQH4a0jMweVtlbP2QGGZ/Kp9Nbw02ppRo1pPbZOG/yh96kgtT+wSTHS02YxxmMXOo4D8KTZ61/Q/1jdg8xJ+KC1p4urZ7GGE8HVwGRLz6yrawk3KWMkDq/BYcyNOLtRYSwvSZZMtd7Om4fh8E/WJgPD91R+xUlWUnXXGwRQZyjjyPzVqA5zqvhlioEjhfOiSpvyjWL+6ExKWaQXFAy23zO8d5mucazvRcvqvAm+8QUgSW+v8YQ66lkaax04xHsViUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsj1ZwfMocxMmhXuaRq5ay7fcHZ5bq2hDSJxGG7/gpQ=;
 b=MoOxntQ9NBrdex9YXgZ/fvjvXPv3EvezXcm9Q1NG1a1f63nJAx7PrDeOPmlxausWAUT7zEW05BswiKzxhxnhOignJmRolEUPT/lbuhgvdF81e0uVOUsYptKzJ7OE8DHEe6VwFN+3S+vtHutm8UOIfVK1xUo5+1PMgPHt5q02j9w=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:04 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:04 +0000
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
Subject: [PATCH 06/30] drm/bridge: dumb-vga-dac: Use drm_bridge_init()
Thread-Topic: [PATCH 06/30] drm/bridge: dumb-vga-dac: Use drm_bridge_init()
Thread-Index: AQHVpFunvVd9IdaLvkq8Buf75d1N+A==
Date:   Tue, 26 Nov 2019 13:16:04 +0000
Message-ID: <20191126131541.47393-7-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 699acced-4bb0-4a52-3d05-08d77272da69
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|VI1PR08MB3886:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB38863DEE973AA1CAD55F0E6F8F450@VI1PR08MB3886.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:46;OLM:46;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: J9ToH+3qHLnxdOwX9CZA9rKmsXO6+evl51q4zjLdNcDKHrhIRYssK7ccZF8qIZ/A+ze6TJf07uJF1gEBwCALL85HlusXEv1OmJbqcvx2V4uUBdaw9J3m0HtXpW4Dg9oQNtCNUvabiZx/D34LYLqTHGgTr9IQjyuIeBE4GKIZsZTsWq30NqG1fsXNIBZ6fNYhq1tVmUX7/hSkLoWQ6fk21475Xjo/y2glB8bGZLBj9kth7yf66HiX3JtWe0FgBQ0qiihF/ahMouetuSIqeQkglP2NSYvDgdD1llvYqQVxfNcXtiu6CNxMu+lvIRVdQ8bR49iht7wW8Z44KtmVyoyTmUA2wFjVZFHiNIW9/DDDvBbtmk0R+krhscPdk6SYGWQURdD2pZddvqGpflGeSuA61vr0H4HCKennm/1Czt10njnCJJHGVagQ7LmWXT2BGLwe
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(47776003)(26826003)(14454004)(25786009)(22756006)(76176011)(6512007)(11346002)(2616005)(1076003)(3846002)(6116002)(2906002)(446003)(102836004)(5660300002)(76130400001)(6506007)(66066001)(2351001)(4744005)(186003)(386003)(70586007)(70206006)(50226002)(36906005)(8746002)(316002)(99286004)(356004)(8936002)(36756003)(305945005)(5640700003)(26005)(478600001)(336012)(6862004)(86362001)(50466002)(6486002)(4326008)(106002)(81156014)(23756003)(54906003)(81166006)(2501003)(8676002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3886;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: dde9866e-7058-470e-4971-08d77272ca46
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vegCSDD6cPL9XPMZb0kSTFMm/4CNLHIfkboT15lTvv03ASnpwTm6ia2BXbrrhdfgjGmzSgvtJJx/UMh3e9Xy3BsE1klHmQjAz65KR16k72zxTHJlP3k3HWu/BuovDSEgZSdHlPgkboL/oU0oErm0N6HpZ9Nk/x7C2Svp+6Q2Iy873PXLm+44TwE1Z/ZEatWDLRQolP1sndsHdNBr5dzTNrBI3nQY339y/NTaPRFh3w4ei05aKlFP9Did1uvgx5dTAy/fVnnhcQXWstOKVpMw/hgKB5lwPxcd9Ox2fvt/Jc0M195cyVfHyZ8F8Hr2sznGL0JaJ956wdkb+eFLaYoFR8z6+/GGy4/73+R2TfjImwCtcOTWl0KDCY7/frEdQfa8WQyJHpgStlHH1svWHsydvVp1wtf3Fq14gWMlDou2NEXHiDJuz86DcNs6WlTVSmYz
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:31.1101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 699acced-4bb0-4a52-3d05-08d77272da69
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3886
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge=
/dumb-vga-dac.c
index cc33dc411b9e..896f27272e38 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -205,10 +205,8 @@ static int dumb_vga_probe(struct platform_device *pdev=
)
 		}
 	}
=20
-	vga->bridge.funcs =3D &dumb_vga_bridge_funcs;
-	vga->bridge.of_node =3D pdev->dev.of_node;
-	vga->bridge.timings =3D of_device_get_match_data(&pdev->dev);
-
+	drm_bridge_init(&vga->bridge, &pdev->dev, &dumb_vga_bridge_funcs,
+			of_device_get_match_data(&pdev->dev), NULL);
 	drm_bridge_add(&vga->bridge);
=20
 	return 0;
--=20
2.23.0

