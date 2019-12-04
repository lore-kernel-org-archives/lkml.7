Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CC4C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC03F2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DpmkmlsQ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DpmkmlsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfLDLsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:33 -0500
Received: from mail-eopbgr00057.outbound.protection.outlook.com ([40.107.0.57]:6976
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727797AbfLDLs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MgqguEy0jasCHbpHxT7B0woU2qwbfZInWMJIuCHW7o=;
 b=DpmkmlsQdZVsCELyQGF0SUG7KPT6pP8FwwrKx0677crtdJRZxbQbpImEBcDUoDZ6rL50PYuBOTKDbWKulk3yorYWUKaFoiL8wkI2bOi+FnJsBvzgya2q0o1eaEZCHX6Zm/i28A8Tx8BkhJA1JihBEErbFZoq2CLFWO1sEwewFoc=
Received: from VI1PR0802CA0045.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::31) by AM0PR08MB5505.eurprd08.prod.outlook.com
 (2603:10a6:208:18e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Wed, 4 Dec
 2019 11:48:24 +0000
Received: from DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VI1PR0802CA0045.outlook.office365.com
 (2603:10a6:800:a9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:24 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT004.mail.protection.outlook.com (10.152.20.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:24 +0000
Received: ("Tessian outbound 224ffa173bf0:v37"); Wed, 04 Dec 2019 11:48:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 271b2d51b2fa0437
X-CR-MTA-TID: 64aa7808
Received: from c7e01adb9f43.6
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5A9BA7B3-DECE-4238-B458-7485675675F5.1;
        Wed, 04 Dec 2019 11:48:15 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c7e01adb9f43.6
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3KBmBFry88ycHcbZ292v/lLUDldNlRZg2mDqaIlPeYfRNmeyfVJpN1bAfqf3Jqwb5FU+q7KZD+CRcCAcbOh7QxJ5W5WZY9uDzyoZkRal+vSzcbpBzvvOjFTguOsxoDZeJvvr0LWdbp4nQVDlKjV0VNtKOT843SKTUK+bHijxTLJa9VmoxLKcHuygFkC/6Xsa38Puz4zoVn6dZrfsnHGy30vfrSmNVI8ykyDUsXgJEqLlaLvVip+gBRFE0uKO3bDJhBRYZrkjZYsnEavaQ0iN4Q2CPkkfseGDGrsiyUpBjbra39lX5otOzuvP4U7FJcOrGZ5aMNNzZmfSMdETyEGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MgqguEy0jasCHbpHxT7B0woU2qwbfZInWMJIuCHW7o=;
 b=XrL5cmx9TiSu4ia0u/d9zhvtT6G2hMLHXvPlYyaOQB5PoWWH49QqSon2ctVbj2M200LMKr9pg+kqooUljt0Dv9Rvz8gNISMphQG57i0We/0Rc1+E8JKcpSDQNm0tlpHQ2IGcLl/J35NzBW1YUGIx6zyLqV3GMbGqQi/V41/XOUVUPzwtKvTtz+7csPBZK/tcP+dIVi65a/O+fEVniNj8tcHxcHIop8POoAlyMKLg3bc3l6x2m5ZLNOaBg8SvXMYh2nvXYR3bJdygmGmD/0D+w6Xh/tkNoDbRj69paMYDDQ/6LiFEk5qRaXb6M8NyGsOWNSARALnAjWdOJkf6qhWUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MgqguEy0jasCHbpHxT7B0woU2qwbfZInWMJIuCHW7o=;
 b=DpmkmlsQdZVsCELyQGF0SUG7KPT6pP8FwwrKx0677crtdJRZxbQbpImEBcDUoDZ6rL50PYuBOTKDbWKulk3yorYWUKaFoiL8wkI2bOi+FnJsBvzgya2q0o1eaEZCHX6Zm/i28A8Tx8BkhJA1JihBEErbFZoq2CLFWO1sEwewFoc=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:13 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:13 +0000
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
Subject: [PATCH v2 13/28] drm/bridge: sil_sii8620: Use drm_bridge_init()
Thread-Topic: [PATCH v2 13/28] drm/bridge: sil_sii8620: Use drm_bridge_init()
Thread-Index: AQHVqpi1+HN3O85Grk+0mnN0hyAIBA==
Date:   Wed, 4 Dec 2019 11:48:13 +0000
Message-ID: <20191204114732.28514-14-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: da92676d-3487-464f-f851-08d778afde53
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|AM0PR08MB5505:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB550528B902228AA82A71C72B8F5D0@AM0PR08MB5505.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: GR/AcZmwU0lSluJBhjpLTa+vSxoxIXHqHOqVeL6WVoBhIles8DCZsbU4TixcHWWXp4q1FSTwfXvgijuhaB6VAHY8EMFn0EecXtqbHfaIW6Q59gg/du+wUYie2AVz43Sfj+uULrEw5Hb4qHGJbQDPkNMQBMfiIhqmoU1hdVKHPYqOyhbL6m6i100BM5BRdzDQI5k4bWB3st6nzuIoV05G9vbMOM3GuK77GFw9f5/vPbSnLHUEdyXqeIAvSevZqJbEGh0U0cgTuvxuk28UAybk1H3nUMAd0dLoAFhQLDy6GqXBEVBiCy5mWQW5AqbDGiFQhp79uPgrtLVcPL6jkEVMLxvpwfRdhnVxz8W0YAn69RMJpnsuaWfXPxwXtd2TbcmptW3oF6yXv4VDwCfMP8UJkos1pgdKHw7NAzXg0hYf9nGmK/7SAzXKtfi4GKGJDM5W
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(86362001)(316002)(36756003)(99286004)(81156014)(50466002)(6512007)(81166006)(50226002)(8746002)(8936002)(8676002)(4326008)(2351001)(2616005)(11346002)(5640700003)(6862004)(186003)(102836004)(6506007)(6116002)(336012)(54906003)(3846002)(26005)(5660300002)(25786009)(7736002)(478600001)(26826003)(70586007)(70206006)(14454004)(4744005)(305945005)(76176011)(356004)(22756006)(6486002)(23756003)(2501003)(76130400001)(2906002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5505;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6c1ba5c7-6387-4d94-249c-08d778afd7dc
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vF8tZcxsRHWiYBhBzHVa7zBydNiyhTr2cI392Zx/Gmcxlc6nAEBmoPjZXKkXd+qiLuR9IvPmHnQBTzDOuBD7eSOidxgNpwmBzxF/zhw6Z2fW6LQYsiup0/C3B/K+GRDVF11NwdEl9Abc3/PQqFef2Fcdvi15ippFjwSyq6erIdB6RrAVSP6/PTI9tA1ABismU5pdz4a2s2WJsBWL3LLzkI+bOvpMSj0hrl7qtmB5MDCvSkgHF2EfPS8jZzEHkukGfzYYQ3ahOmVcSkwsX7tgykmdRkOzCOuJv5iYDM/NIADC8pI0SKy2lT9aIhwx4mesINZQqqWKn2QONc3OvfiSwZ/dd31kFmNSWDjOLiBi7STr/1tcn1nzHi35wChHGgOq4cDV+zEM/bKQh3OYJd38L4AT5z6F6MPLt5e4OB2miH0a83sKSNKjxSArOb9opE6
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:24.0359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da92676d-3487-464f-f851-08d778afde53
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/=
sil-sii8620.c
index 4c0eef406eb1..482dc2291350 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2337,8 +2337,7 @@ static int sii8620_probe(struct i2c_client *client,
=20
 	i2c_set_clientdata(client, ctx);
=20
-	ctx->bridge.funcs =3D &sii8620_bridge_funcs;
-	ctx->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&ctx->bridge, dev, &sii8620_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&ctx->bridge);
=20
 	if (!ctx->extcon)
--=20
2.23.0

