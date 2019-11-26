Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E14BC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D082073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xih1U9gI";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xih1U9gI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfKZNQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:21 -0500
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:28046
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbfKZNQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+gIcXwMEpaWbNQmu/uXel91VQjEKWqcp2Xv7hI8VDc=;
 b=xih1U9gI8sNryTEKsTyCueacJPhIOw/hONsM1qZz6so24onz6etOjL7teYZuMiy0lzPrmfKBv21NA0ot8YCBXdWqkal2LVY77u1EEE4RBwyDzSnqItNXBaXgP6/rXWAGKpOGTVWDfxTqlBsRBV8MWWYFqVx4VbYj0FZF7aKmlA4=
Received: from DB6PR0802CA0030.eurprd08.prod.outlook.com (2603:10a6:4:a3::16)
 by HE1PR0802MB2172.eurprd08.prod.outlook.com (2603:10a6:3:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21; Tue, 26 Nov
 2019 13:16:15 +0000
Received: from AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by DB6PR0802CA0030.outlook.office365.com
 (2603:10a6:4:a3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.18 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:14 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT061.mail.protection.outlook.com (10.152.16.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:14 +0000
Received: ("Tessian outbound 37db47aaea47:v33"); Tue, 26 Nov 2019 13:16:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fb2c35bb90e50a6d
X-CR-MTA-TID: 64aa7808
Received: from c7042a58f532.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AF1CAC6A-F64B-481F-A03C-4766F511FEA1.1;
        Tue, 26 Nov 2019 13:16:06 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c7042a58f532.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FimEEE1tbvB66/ZOYLl5BWXl3HPDaRfQK2Qa+X7Ua2KktSlaONXKwsTuPgNJcXpfqQ+XVWrpCTO8hyR9R/80HhqjRj57sKhOr9JuYFPCvUCze8JTCqu8utnUJFxyB+Kt51gBzbyP0BZlXZ7wSCZcJEBJRq2pcQlczcRLSS7zwyc9d4NOc35YStwUsN5bhhUQ8BYzpZuQs+raypFxoXbo9/kLOlqg8e0jasuqE8yeHb3bYLGeI6VkgTrB71bPuaRR2FSEDZKMM09UsQj8LNo5siQw2JBss1tNTlg78jH/csNB8OD+SmrwMEe0jI/EnCHGGEft9FEmBkPpEqHRSJtacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+gIcXwMEpaWbNQmu/uXel91VQjEKWqcp2Xv7hI8VDc=;
 b=mr+qrzyA4hGy/Zwn+QwxOBZEiNqGk951PBEkAcpZ4NP0z3DRWq67MZtv75AlR7r7GRqOv8/ib8cfPgpeTusNs2qF/6J9QnCvL9P+ApyYw6Op4Bk/qhu8G0KJ1ywHpU2HDJxDdfCkCGTC02pho+5qgDThAEKz1tSUjlmCqYnlHUwpH3BU3kzZ9Jwj8fBeLxmVzhnuEzNAu9ee9FeSjPaWB9sRsXdVIktaCufzK2Wl3yqScGMXEJfWncl3/vjVg16D0cdjQKJBYmVPXyADWqZdnNicX9wHPESG+Z294kTMdDcOROm5VHZmj/JpoC5/oDEyt+xojVvhXv8gulpfFL+NVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+gIcXwMEpaWbNQmu/uXel91VQjEKWqcp2Xv7hI8VDc=;
 b=xih1U9gI8sNryTEKsTyCueacJPhIOw/hONsM1qZz6so24onz6etOjL7teYZuMiy0lzPrmfKBv21NA0ot8YCBXdWqkal2LVY77u1EEE4RBwyDzSnqItNXBaXgP6/rXWAGKpOGTVWDfxTqlBsRBV8MWWYFqVx4VbYj0FZF7aKmlA4=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:05 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:05 +0000
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
Subject: [PATCH 07/30] drm/bridge: lvds-encoder: Use drm_bridge_init()
Thread-Topic: [PATCH 07/30] drm/bridge: lvds-encoder: Use drm_bridge_init()
Thread-Index: AQHVpFuoYtFUOEB7u0KcxEc0nk9UCg==
Date:   Tue, 26 Nov 2019 13:16:05 +0000
Message-ID: <20191126131541.47393-8-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: f196c812-c122-49c0-e45b-08d77272d07e
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|HE1PR0802MB2172:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2172AEF89631EE3C8C3C46788F450@HE1PR0802MB2172.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(5024004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: eD2mrTiLuGPjRqn5B4LlmZzN/gDFoYOWa65eBY4sekXK5BeFwci8RRQM0L4HWXAyx3NpJGtR9Aa0lxiAZyMiRbKKy3CNYXKJ9YKY6BIP4Lz01Xvpfri/lOq5uC9LCsRE7dveF1I9vPKnegc/4zA3etYhlZi/kXPUIjJ+yMwyTJDy2lFBmpTTWSwDDKot/T6FkuWEJcFKMEMBPesYoKtVMsXhv3FGDtVntZ6/vsbyeFdUJQVX1mXcMM2P7wkxL2SF7eZiKQsU09gaSk7Ell7DFvKT0GPyDkYaKnYQvMFMViXHasuKiVOhL8ZO+mCXyOBarINpFCkFDaLpswkrQYHuzjBu0qNS7PZRjuaN1h2tLN9iseou2Ovx+qd4yFhthIEazdM/VJ6wI8UiQsbnsWXs++oGM/DjH2hnmM2h1E8kQ5IMpuGraifa6NVaAjsjP5qt
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(478600001)(356004)(2351001)(50226002)(26826003)(4326008)(2501003)(186003)(6506007)(54906003)(316002)(36756003)(5024004)(446003)(106002)(76176011)(14454004)(26005)(36906005)(2616005)(102836004)(386003)(76130400001)(11346002)(336012)(66066001)(86362001)(23756003)(47776003)(50466002)(6116002)(2906002)(22756006)(70586007)(3846002)(99286004)(5660300002)(8936002)(81156014)(81166006)(8746002)(70206006)(6486002)(1076003)(25786009)(305945005)(6862004)(7736002)(6512007)(5640700003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2172;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 35d4a9cc-2d83-438a-2535-08d77272cad9
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fq0fLvmV5VPnCUkIaVZxxpdOdr0s39hq6rW1WibY8BoBVxCoSKphJOHAFlRbOhJyaMkiTSnfJVD2oUcJHrgl7VFZ2jFblc7jyU701KaF3tE/EDqhvKzWeUx53wCn6Xghup61Y3r2ABwrok+4kWzA3oHUYyljGbNtZuSHdJCiZ1gfci+cUCagQLpQDhKm7B6zxjZvJpyDVFuwUoGfh+NOUhbzSWhGTCfAHB1vqXps/nmtHxMpGk+Q+YNt6PCwD0npYYyrKDs0ZGjiPyWMlOfxnp03GBEAsaXMOwwSoaYK7r2ouM8di+shrjIxNPE7LCg7obQyqpAtimc4AZDwFJfmITpuHqYQOdKUm89TGCgO1Wkcv+pxECd9cM8mRF3207bCSmg5KG8WCHyfF4QaJuynlgwJ6TvRnnPBxB/EzriaNX7dJtsSKPiXOGley9xzP16B
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:14.5399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f196c812-c122-49c0-e45b-08d77272d07e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/lvds-encoder.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge=
/lvds-encoder.c
index e2132a8d5106..155406510416 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -112,11 +112,10 @@ static int lvds_encoder_probe(struct platform_device =
*pdev)
 		return PTR_ERR(lvds_encoder->panel_bridge);
=20
 	/* The panel_bridge bridge is attached to the panel's of_node,
-	 * but we need a bridge attached to our of_node for our user
-	 * to look up.
+	 * but we need a bridge attached to our of_node (in dev->of_node)
+	 * for our user to look up.
 	 */
-	lvds_encoder->bridge.of_node =3D dev->of_node;
-	lvds_encoder->bridge.funcs =3D &funcs;
+	drm_bridge_init(&lvds_encoder->bridge, dev, &funcs, NULL, NULL);
 	drm_bridge_add(&lvds_encoder->bridge);
=20
 	platform_set_drvdata(pdev, lvds_encoder);
--=20
2.23.0

