Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5D1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB442084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="g/X/NnbD";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="g/X/NnbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfKZNRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:17:52 -0500
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:61435
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbfKZNQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd38oFLWy/vll1uYa5+Hk1oRG4a6AluP5w8w6ULnIGg=;
 b=g/X/NnbDW5lKwUPqbDN8I0DiX6mdGtaTQe+jRqPIp1nH2Xq8lnuL+VevTA3mrG0FQAIru1T36jmG4u+XBoCMw2Ql7wIwpH1BldNGUJfg4loqQ/Kfm9LEm6qVwC8AbBGoiLrm/kLA8yc81fPhuMN6hH2b7k800O1XwkmteoFTBdE=
Received: from HE1PR0802CA0012.eurprd08.prod.outlook.com (2603:10a6:3:bd::22)
 by AM5PR0801MB1795.eurprd08.prod.outlook.com (2603:10a6:203:2f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Tue, 26 Nov
 2019 13:16:19 +0000
Received: from VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by HE1PR0802CA0012.outlook.office365.com
 (2603:10a6:3:bd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:18 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT060.mail.protection.outlook.com (10.152.19.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:18 +0000
Received: ("Tessian outbound af6b7800e6cb:v33"); Tue, 26 Nov 2019 13:16:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fb4723f78734d0df
X-CR-MTA-TID: 64aa7808
Received: from 687810ec6074.10 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2F217A09-623C-49E8-B37E-CF4052EFEC4C.1;
        Tue, 26 Nov 2019 13:16:04 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 687810ec6074.10
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3cQlI4zvt/+OHU2pVh7hfwxsWrAp+SdV84i6igsmMBc21N2A2JhI5Oikn4FpAre6PLk6fDVYHPMJCEsSN475wBn5V2bq4ethfRHYxQFUQTxcEyuwvnJhZumvVvGZ/daiE8vxM2ThyPALlecGd8EzXuW9fARvruh8kV+5BPX/WEZgz0OguZFzK+4zRIUPxncgPDN4xg7nlkQ2LWqWZ+BGx0pqTJLPv9Vno8OurFINTOS13+N9IQT4N0r1Dc08piuKuO2xOnRvPJqMP+ULbu9dIWVpBEfz0IPdQ6Z1IXhjF30CncOPGY7+JwqA9HTnIS7/mqbGIsDBTp4oScyo6J9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd38oFLWy/vll1uYa5+Hk1oRG4a6AluP5w8w6ULnIGg=;
 b=fBkCVjFBPQRxFklSClWSnCHRYiwzyzrpJ14s1a59AV40jyqtDi4OyuvKEsZ5Vy4Z90PI3ZNTapxF89F1hsS1vxPLBbSi81AvR0AIXS9tz7cvOdCeKlm2hn+LS1XKm/xkIskDekn3ba9URqzV+pSZkQFd7gha1IJJFZV0fcTQQVOsmoQRafzVb9HTrRBjI/gt4me4lAbdxbYeJEFXA+/A73olDGd4MBV6cmeYrSyWer5NwNxSOWBsiKAJcWNKQ8e6pyePkVUHOb2CNSByo0/FuQkVcHwThDsswTNX0DtExCbNuvHp95joN+4HMf1XDlA4yGE8TJKLAGl9NHaPKDbv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd38oFLWy/vll1uYa5+Hk1oRG4a6AluP5w8w6ULnIGg=;
 b=g/X/NnbDW5lKwUPqbDN8I0DiX6mdGtaTQe+jRqPIp1nH2Xq8lnuL+VevTA3mrG0FQAIru1T36jmG4u+XBoCMw2Ql7wIwpH1BldNGUJfg4loqQ/Kfm9LEm6qVwC8AbBGoiLrm/kLA8yc81fPhuMN6hH2b7k800O1XwkmteoFTBdE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:02 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:02 +0000
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
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/30] drm/bridge: anx78xx: Use drm_bridge_init()
Thread-Topic: [PATCH 04/30] drm/bridge: anx78xx: Use drm_bridge_init()
Thread-Index: AQHVpFumHisFg0Uva0+DP6hJJNbsSA==
Date:   Tue, 26 Nov 2019 13:16:02 +0000
Message-ID: <20191126131541.47393-5-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0e58306f-cf3a-4dbd-ee13-08d77272d2c5
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|AM5PR0801MB1795:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1795CE4C9D3D90D7D4250D6E8F450@AM5PR0801MB1795.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:386;OLM:386;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(7416002)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(14444005)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: COB1H5tODTimTBTb62Oj7IlBN8//512Ypw9ICiugdIem+geE+UwM9smcvo4amELaMbOiRxxhyF9wMRjYQr367vQF9bOout7fvizAivxfBq4fTMMhOMd6tSmXjx5YPZ7m+PqeO3+Gxi33Rd4myDI4VsjPWUX7Ib6RixvZrFBozR61czgSReMS+o4WQJ3mFMBinaV4G8XqZ0J97udaPtvOo8l48lNYG904toH6hSfFxMAbcUegoakALTLfssWsdKa39r73ycd9dWE9NfzGARdVSdjoi0MSVOgnsmNrtQ+8J7IqOBbA3UyLCSl1axvxjVcQhupG6/8dllKRBFihX6AMyImtqysIuPwoGqAKETivYmOLFv/SVogRXpHL8nKDcnesrax5oX1lXIxqVCBtvpiWRkrWb5v9OunLjrlU2aXd4dwJNi36wY4Vym1WKEyh/Bt2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(478600001)(6116002)(47776003)(106002)(25786009)(66066001)(22756006)(14444005)(6512007)(76176011)(54906003)(446003)(50226002)(36756003)(336012)(2501003)(5660300002)(2351001)(6862004)(8746002)(99286004)(2906002)(70586007)(1076003)(26826003)(36906005)(81166006)(70206006)(81156014)(4326008)(8936002)(6506007)(7736002)(76130400001)(356004)(8676002)(316002)(305945005)(5640700003)(26005)(86362001)(6486002)(14454004)(102836004)(11346002)(23756003)(186003)(2616005)(3846002)(50466002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1795;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: adc0ef46-da66-43ce-c287-08d77272c913
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vttylvrliu9T9YIrOgivxQZ9oaxo8qX3TTjQ61U6a9tI7sImrpHPqt1zPtgsJZSVPAGS0x2+QQ1Z4z8wpNrwTYX4PKMtTS76RIGgYUTLvzi0DlV+0drPUmSQ7FADTDGiJ6xuosGBGEG4Os4eROVk6nwq/OBMEJCUBl6j1dtpqoprzZOkdJVRvL0zZin4W0fqNjLmCXhMQop+7l6FaXyEjDDCeOHau1WQaektEbbvB66MPBxM54qv58V6FhTVmEqtNDbe3t2MmYQMQXHHODq7ffwfBEQtSwYW1PntH4RLAtxl7qkOiHKY6WHVcPIVZTveOtrLtJpZ960jMJnbC+Am1LQ1Ob4mZyGh4VlNahr+JzwQts52yUyFeM4C33RklO9Dn4zsubCDeY/LCsG+8atWBDShKZD4454vA7qGNwS9N3FNdNyOJK1MLasjtxZ0E+G+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:18.3118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e58306f-cf3a-4dbd-ee13-08d77272d2c5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/g=
pu/drm/bridge/analogix/analogix-anx78xx.c
index 41867be03751..e37892cdc9cf 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -1214,10 +1214,6 @@ static int anx78xx_i2c_probe(struct i2c_client *clie=
nt,
=20
 	mutex_init(&anx78xx->lock);
=20
-#if IS_ENABLED(CONFIG_OF)
-	anx78xx->bridge.of_node =3D client->dev.of_node;
-#endif
-
 	anx78xx->client =3D client;
 	i2c_set_clientdata(client, anx78xx);
=20
@@ -1321,8 +1317,8 @@ static int anx78xx_i2c_probe(struct i2c_client *clien=
t,
 		goto err_poweroff;
 	}
=20
-	anx78xx->bridge.funcs =3D &anx78xx_bridge_funcs;
-
+	drm_bridge_init(&anx78xx->bridge, &client->dev, &anx78xx_bridge_funcs,
+			NULL, NULL);
 	drm_bridge_add(&anx78xx->bridge);
=20
 	/* If cable is pulled out, just poweroff and wait for HPD event */
--=20
2.23.0

