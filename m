Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F2DC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F1420730
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EA++qB1t";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EA++qB1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfLXRfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:35:03 -0500
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:14054
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbfLXRez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EVvXSzX8SkIMS+Anlo3xRslnuu0TmdGIPM6m5znj/8=;
 b=EA++qB1tkVig23Uigp387/0FfvVVJ4h9e7p7IP+dp9Rn35FMpCnyzMJK8vyYDtXzbcCTHj5WEQNsnV94UUspQV6pk38G2ioasKzUsNFJnIiZGcVVYpplo7ahFt1Qtn3UXxkITZzPM8ZJVuVecje9RmLVh2V1KI6K5cwZ4fFYGG4=
Received: from VI1PR08CA0088.eurprd08.prod.outlook.com (2603:10a6:800:d3::14)
 by DB8PR08MB5082.eurprd08.prod.outlook.com (2603:10a6:10:ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.15; Tue, 24 Dec
 2019 17:34:51 +0000
Received: from AM5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by VI1PR08CA0088.outlook.office365.com
 (2603:10a6:800:d3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.15 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:51 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT031.mail.protection.outlook.com (10.152.16.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:50 +0000
Received: ("Tessian outbound ba41a0333779:v40"); Tue, 24 Dec 2019 17:34:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 35f8ef058319cd54
X-CR-MTA-TID: 64aa7808
Received: from bdd2edd0996c.8
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C8A0404D-14E9-45DE-9173-78065C85E900.1;
        Tue, 24 Dec 2019 17:34:45 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bdd2edd0996c.8
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPXIIMWd3ItmIxkZTXJqEMKaaiV4xBlRxYq5LQS8q26Kjxk0U0YAEAexSWUQPQ6odvZU9KC2fmXW9NSUBf16p+OAyz7PkULoTRn7HvXoCfArqiD2X9aMfyKWWfsXaCxBJeu8lQT3xAzmvTmWIuN9lLqVE48HrprOyRGz7yIyH+tCLrKPLEXtTFRYFmBwiaMr571ZL1hiHlhfoPiooxNmdjXyx++T0KqEuew02EREgR4ViadykJs5GhqM116YaNPNlnOUQwB+z827d/TENI64tqeeuT5RxjejrgQRWIrkWk0yxqHrb7eCWL2ZPRazoPfBi5oqk88UOGMZuseQmE5zVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EVvXSzX8SkIMS+Anlo3xRslnuu0TmdGIPM6m5znj/8=;
 b=Vp6QTLThOaMFY/b5gCh8lYaE3hBNsVA0vSdfHnZbCky4ScpOiGk70u18mFv+85fVyyhqcZfSdlKvY1nSA4xzL2HWGx9zIQPSYbjXZeen8rcV3IXzTAeMVYk3yhYxLaG9X8yzlVwEyAk15e0VvJAfOKzKvCRkUbbLqkuEtpREXALigvoLYeRtgYlf6xhOfy4m7vZlgcoph0qlMPd6+vxvq6G5FlqwQ7mpnNB2D9DoX3jpUj86+eC30EVuLvyODqXeWJ7IXJt48TWdR2xTP3iUA+spUu0iBZtWrooBpaInLkj/XGhPQOilDTzHzUiiSIr6Y4ojy3bjqOnzBWmTsTPx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EVvXSzX8SkIMS+Anlo3xRslnuu0TmdGIPM6m5znj/8=;
 b=EA++qB1tkVig23Uigp387/0FfvVVJ4h9e7p7IP+dp9Rn35FMpCnyzMJK8vyYDtXzbcCTHj5WEQNsnV94UUspQV6pk38G2ioasKzUsNFJnIiZGcVVYpplo7ahFt1Qtn3UXxkITZzPM8ZJVuVecje9RmLVh2V1KI6K5cwZ4fFYGG4=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2672.eurprd08.prod.outlook.com (10.170.238.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 17:34:39 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:39 +0000
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
Subject: [PATCH v3 20/35] drm/bridge: sii9234: Use drm_bridge_init()
Thread-Topic: [PATCH v3 20/35] drm/bridge: sii9234: Use drm_bridge_init()
Thread-Index: AQHVuoBrbjmmu9/dQUmnvg8+r41VAQ==
Date:   Tue, 24 Dec 2019 17:34:39 +0000
Message-ID: <20191224173408.25624-21-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7ef7aad-cee9-48dc-8a6e-08d788979491
X-MS-TrafficTypeDiagnostic: VI1PR08MB2672:|VI1PR08MB2672:|DB8PR08MB5082:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5082EE14913ED96DE5ADFB668F290@DB8PR08MB5082.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:131;OLM:131;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(26005)(52116002)(6506007)(6486002)(81166006)(6512007)(81156014)(8676002)(8936002)(44832011)(54906003)(478600001)(316002)(6916009)(2906002)(4326008)(2616005)(36756003)(1076003)(66446008)(64756008)(66556008)(66476007)(66946007)(4744005)(5660300002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2672;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0i2JEJ/6Ev3EbLun6cxcSCZd21PL3SQZeKDGljoTdLkQAHuAozdwjDWcC6dku62tsbNSkFS4u6GkFpJb3z251bZp/DVG4g/BqC75Nm4s2XnpLbLNa4QhemIWev53h780AdmdySPm03FgdhkamAchAajFHH3xgwDVS2xvAzt9eqXvXfh1lInmL5FnUvpuluFH1GMc6HMe5/7+r25jVPn53apk+Bjv31CeInlzOTXm6UiZ0xk69+nhrc/zxnxQxRvJAMjLnIDaZLry2l6ieBbNWj9zQNo58JTrR1XqTF8PVCMCMfU1/pqhyLz98ZUwXXwcUzUs/9AOUODuhbcQ6zV4Zjjju66aphqPetYnoMw0KweacfEvSFsMmKC+LYKH6wfpJ9RJTEh51QyoMsCkhmcE+i8XVbTqvT7mz5+hmRKxCWYi+jKIxuS1KnxAag0JJb7K
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(76130400001)(26826003)(478600001)(6862004)(70206006)(70586007)(336012)(26005)(4326008)(5660300002)(2616005)(36906005)(8676002)(186003)(316002)(8936002)(81156014)(54906003)(81166006)(1076003)(4744005)(6486002)(36756003)(356004)(6512007)(6506007)(86362001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5082;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: aa1150a3-f9aa-433d-162d-08d788978da6
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95pBrWYkhuxBH+O/hMoTqnvREXwTTuwFOKeF7Y4Ysmi4cFAGCn/RhuYphL4m5Igf7WyR2r26xMBpePJ7JcUVnzKQV6sUEYo6njMMlgqK9i9Ub6kqlzQl/IoeDxvo9G/ufZEfAXKCGWTIVVpGKaD1wEYqp3GaAKAIrgLv6Da3mDht1hZ0DPH5Kv/K/i9xHyXSmtQrsYJE/2q9sSAardH3nxEIsfChjUkOiV94TkXpvMqvM3jGHQmLWdJesK2VQm06l4WGmD1x876LS6iwiyKNSrVQqYrshx9Ep8zvZuUdz1nKyrXnyjij0JYzZzD4wuAzJlMP2wwmQY+BxCy7j+Lr4uN7Ilr628EaD0aH6Wrg6BPyVJRFWrX2KDpnlk/Yru/ju6Kqmyb33L6p2EumVqYoEoaJ3bgnL1UyTf0tdv2vL4ZgIYC/ZaKY4KlecPsKmv8y
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:50.9579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ef7aad-cee9-48dc-8a6e-08d788979491
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

v3:
 - drop driver_private argument (Laurent)
 - update commit title prefix (Neil)

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/sii9234.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9=
234.c
index f81f81b7051f..108cff6c87b7 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -925,8 +925,7 @@ static int sii9234_probe(struct i2c_client *client,
=20
 	i2c_set_clientdata(client, ctx);
=20
-	ctx->bridge.funcs =3D &sii9234_bridge_funcs;
-	ctx->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&ctx->bridge, dev, &sii9234_bridge_funcs, NULL);
 	drm_bridge_add(&ctx->bridge);
=20
 	sii9234_cable_in(ctx);
--=20
2.24.0

