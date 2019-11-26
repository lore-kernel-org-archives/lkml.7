Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24A0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8937320727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="u/dgm9ly";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="u/dgm9ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfKZNR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:17:56 -0500
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:38326
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727718AbfKZNQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=528OVsPgmledT3KzwsU137Xb39xXYhXTngkZrmxaBXM=;
 b=u/dgm9lyzcBsToTjvghYaxq4lZMMS3j5Sj+5lyhOdLGlxxLh/Fuybw1oR0pVUKwCz6WXBpAtm7MnEDOmdw6M0VzmcjaSPCmsApaGE0QEMox/WegEraquHCNQkL2gPGUdqOdq2ClN2f0ZtgKNXt6dC4b6xqVL0HdIckDuCOrwpks=
Received: from AM4PR08CA0058.eurprd08.prod.outlook.com (2603:10a6:205:2::29)
 by AM6PR08MB4916.eurprd08.prod.outlook.com (2603:10a6:20b:ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Tue, 26 Nov
 2019 13:16:16 +0000
Received: from AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::209) by AM4PR08CA0058.outlook.office365.com
 (2603:10a6:205:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:16 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT062.mail.protection.outlook.com (10.152.17.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:16 +0000
Received: ("Tessian outbound 712c40e503a7:v33"); Tue, 26 Nov 2019 13:16:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b69359a9aa1b7bd6
X-CR-MTA-TID: 64aa7808
Received: from eb4165d38a59.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8F49B243-D0E0-4A24-A9E0-E1DA024E1BED.1;
        Tue, 26 Nov 2019 13:16:08 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id eb4165d38a59.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6718M6WIG7cznXs21aajtfzYW649KgFYmnuuofdSy4g/DvXdwMCpmhMp//d9RdlD9ur8/LgPgeqfzeyafteeACEK01JrB7dvHabsIb0EgGdPMn9pLyNEpauWpA0ZUgVg1P3CmtkvnjJk6kmGAcLu0c0mvTcAYp3MUnQ6HsFaZYSzCXJd4DEvFOhRg1Yyli8vaQGYPlE08h3HEz9dqBZDgzDs7Se1WWmwfoYYJ437Qt9Y+SXmq7ajkVVOR8dYqUwoFUdJEUfyXZlwo16IjRimcGOJHIkovKanpQT6HrUAjGVYiGKjwfVZRBwr6w/LNUWs5KA4SrTIcCHnRK018dpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=528OVsPgmledT3KzwsU137Xb39xXYhXTngkZrmxaBXM=;
 b=UVRHQI5NSR5z9Z2tmeofrDay4MVQ0KobLR9uetxScQiMbU3atw1g2CgHZftlx/ZUR5EQ3H1E1ZmoSx3t5e5MVUuuRf5vljRw/mtelBFTXcT68x42bMkgn97vkmJ37YSbZs9LIUvq9jsCq/9ezwiOhuh1Dxf2iHT0YfhrhUziq/aGYHMltTzoCrdZBhzj4qKAV00ORwReB/1TyVvIZom/H1sm4FT67LcTbxKLgZLEAxVJWWKIiithlx+AtfR3DW6YJUUrh/w9hJlSWS+3zDlcJCn1mVhdFHzD4i/QZgrgLvAOqV9wvnFHKPPuYp5HTVc2wb+b65KeXgpqOJ06pPpq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=528OVsPgmledT3KzwsU137Xb39xXYhXTngkZrmxaBXM=;
 b=u/dgm9lyzcBsToTjvghYaxq4lZMMS3j5Sj+5lyhOdLGlxxLh/Fuybw1oR0pVUKwCz6WXBpAtm7MnEDOmdw6M0VzmcjaSPCmsApaGE0QEMox/WegEraquHCNQkL2gPGUdqOdq2ClN2f0ZtgKNXt6dC4b6xqVL0HdIckDuCOrwpks=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:06 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:06 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/30] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Use
 drm_bridge_init()
Thread-Topic: [PATCH 08/30] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Use
 drm_bridge_init()
Thread-Index: AQHVpFupoTyMiBGaqE2PqP/t3pS+oQ==
Date:   Tue, 26 Nov 2019 13:16:06 +0000
Message-ID: <20191126131541.47393-9-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: d0329b3a-add5-4b75-2057-08d77272d18e
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|AM6PR08MB4916:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB49160EE68CC019625F6F56708F450@AM6PR08MB4916.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(7416002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(14444005)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4VUgw8KHe+8hT3ET9hAb5BZeNLc32X1H66UjnzLNyB57x+IkhAd5bSvIvThkYG8QarEGl7Pb9kTyW6sGXNOjut3etc2aumEj32RAMqFku/1BUYlV9LKgCXMWejLoALeMa0FGds4RmJQVjOiV4qjqDISCLMUnqB5RyOroepAnLvFchKMBk03K7g2NFDuaKi6bHez/Js5Y5yiFf9N5xoqXbNpf9pM++7sawQ+n86urLPQApz+WWFzJnIU/qcNSrDNUEOBYe0JeW5PkAXNpBEIVvT2nnkFJla9/d4bisZkq5EJbhA1yaw69kbfoTn/okynj2HopKs8XENNsnoh24k76YVF6NJgEfpxr7pghCJpDySXjj3z50qruadB53BM+pa+twA9XU26aHd+xgrV5VtFlduI0fkCWnc9fUEMhZqFOQRUVyp89h+7E6F93C6s6Jnmz
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(81166006)(54906003)(81156014)(106002)(2501003)(2906002)(50466002)(2351001)(6862004)(36906005)(316002)(22756006)(99286004)(386003)(186003)(6512007)(336012)(102836004)(26005)(6506007)(305945005)(14454004)(23756003)(7736002)(86362001)(76176011)(6116002)(3846002)(4744005)(356004)(70206006)(70586007)(446003)(36756003)(11346002)(1076003)(5660300002)(76130400001)(8676002)(2616005)(25786009)(8936002)(8746002)(47776003)(4326008)(50226002)(6486002)(14444005)(5640700003)(26826003)(478600001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4916;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: cc23e328-4222-4a2f-1e6d-08d77272cb79
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FclfGfM00JWtcsOPRN3bmf3Bp+swZ4tghpjkK5GhH4jDNyjlrz5Qj/+tgkH6Xt0Wq2F+fbT+gzYYqnlbvKt79rQ/uydlaTvWRWVXwVvAiyDd+gz7cCWUJKxPFxdjwOgWjZFqjLsqX8EkHQHameZKLS21OhYhzGM9yEXOTOguusx2iLg0ZWRq3kDtQOapRZ36B3pL5WRJZpvvD7kdItF/hdPz9gA32gTLZ0yz4bTaLtlkN6QyS/jo1YZJpaaJgH0FxhE4ak4Qz5jUzRyg/6oyiduUH5b5mperHjCxnlDX6g0XxK5LAvO/6j1uJ29XlPBahMJnYx0D6SrLruvYx1Wx35jQsoB+mjg24kPtY2osV6SwJu5r9JuIZjI/ZTsyX6e215Cozuyw/HAax0EydDbCMHm1T+DL3MWCfNqCi1Oig0uyfT7od7A0kQ+J4m1EqQ6+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:16.3174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0329b3a-add5-4b75-2057-08d77272d18e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/dri=
vers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index e8a49f6146c6..d567cd63810f 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -303,8 +303,8 @@ static int stdp4028_ge_b850v3_fw_probe(struct i2c_clien=
t *stdp4028_i2c,
 	i2c_set_clientdata(stdp4028_i2c, ge_b850v3_lvds_ptr);
=20
 	/* drm bridge initialization */
-	ge_b850v3_lvds_ptr->bridge.funcs =3D &ge_b850v3_lvds_funcs;
-	ge_b850v3_lvds_ptr->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&ge_b850v3_lvds_ptr->bridge, dev, &ge_b850v3_lvds_funcs,
+			NULL, NULL);
 	drm_bridge_add(&ge_b850v3_lvds_ptr->bridge);
=20
 	/* Clear pending interrupts since power up. */
--=20
2.23.0

