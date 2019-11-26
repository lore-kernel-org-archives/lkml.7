Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC84C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BDD2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pusOmscy";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pusOmscy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfKZNQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:38 -0500
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:6080
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727946AbfKZNQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pok0SSk5Bh8w7qG9tzg8paAi0CtuxpzJ5qzAThY9f2U=;
 b=pusOmscyYufEpFSCf+1JxVugEIYknT9wzLJze/QxPGJ1neaqXGoNuuo/bUCPQ9nzrZY/YoiEbEvMwucCdGK67E1hAcWNy3eeUwype5UAe7QRWL+M5/36LOue/KaWoowLN2XMgAkLA72eYKNKUkQpjbMzyRNA9QKOWUWB0Cg3QeU=
Received: from HE1PR0802CA0012.eurprd08.prod.outlook.com (2603:10a6:3:bd::22)
 by DB8PR08MB4074.eurprd08.prod.outlook.com (2603:10a6:10:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Tue, 26 Nov
 2019 13:16:24 +0000
Received: from VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by HE1PR0802CA0012.outlook.office365.com
 (2603:10a6:3:bd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:24 +0000
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
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:24 +0000
Received: ("Tessian outbound af6b7800e6cb:v33"); Tue, 26 Nov 2019 13:16:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ea8e42550e4fef53
X-CR-MTA-TID: 64aa7808
Received: from 0334c95094c9.6 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C4D41ABE-9CCF-41DE-94CE-807225FF2535.1;
        Tue, 26 Nov 2019 13:16:13 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0334c95094c9.6
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igidyPR1rNyjclJgme61ZLyM8jf4rQ/pyj/T6loM9lz7cWYmVqrVIgWLUfC+Ukqe29tw8DC4JnOIOmUvkVYIPRNGJ5F1PbkZTmeMf+HHcuClqNbs1agBWCRX+5CjEYAzHBp1K98LNnBCGmdKNEZ8EV49U1PAtqd+SOes9q9Jx1Cax4izzGE2Lc7X0Mmpr44YrrqRpXL4G6qlfFwzf5FbkHHWHftRSQSaraMhExef7bLG8DOwMmXwubTrF4bGq5+NIBZzEJIg52Qt8DLOrCin5gltOPrT2fMBVeZ8NzkPDiJIc8wFZv71uJo5qy4FFLqBdBcgzzynt52wivfb2G67uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pok0SSk5Bh8w7qG9tzg8paAi0CtuxpzJ5qzAThY9f2U=;
 b=m13zfBdn1omJvt8a0NgPLHfFAv2pv0GhqXFdrlJOxBMIQVaIDieBgTjk6YUtEoO811N+PIaM8+AGkA7SrYoJAR/bBTPEhjbv48j55zalO3US6dthPlVcFXkTPt/0dNmgXsDLu/ra0Adrk+KiQ31emAK8CXvs8McWcec6rremhLtC0kyrPB1ctwfPkzry8g80BfC69n1vAf658/L4Fky6jMGC0wrOK8z9pHqwFByn3Ls3OtRcwvnfMqPys7PLXrV6CBHyBhrw2l465Y47EPR7mEYqkEq2xY6ylgJoFvBzDLt6RDLfV1AAIhHH5y5e7tF5Lh2Y/BPT57vr69NJgRm7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pok0SSk5Bh8w7qG9tzg8paAi0CtuxpzJ5qzAThY9f2U=;
 b=pusOmscyYufEpFSCf+1JxVugEIYknT9wzLJze/QxPGJ1neaqXGoNuuo/bUCPQ9nzrZY/YoiEbEvMwucCdGK67E1hAcWNy3eeUwype5UAe7QRWL+M5/36LOue/KaWoowLN2XMgAkLA72eYKNKUkQpjbMzyRNA9QKOWUWB0Cg3QeU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:11 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:11 +0000
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
Subject: [PATCH 13/30] gpu: drm: bridge: sii9234: Use drm_bridge_init()
Thread-Topic: [PATCH 13/30] gpu: drm: bridge: sii9234: Use drm_bridge_init()
Thread-Index: AQHVpFusNtuVOQ8qhEu+Sa4u9CDFbw==
Date:   Tue, 26 Nov 2019 13:16:11 +0000
Message-ID: <20191126131541.47393-14-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 57993a44-1034-4666-9ee8-08d77272d66c
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|DB8PR08MB4074:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB40746BCA58C897918013495C8F450@DB8PR08MB4074.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:949;OLM:949;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: jwTV1iyVExg5PHBt5Eop33DsUoWpNxg5dNg3PvKPbXnW/MJ0BMWX5lEzP3LX7rdtpYVvLKIYI2Fc/TlzF4X+FhVUH0kOHN/WmNJZKFaH+8XS+8ochp4iuJHOijNEYwfFCnaY11jwBM+kWOCFOHp4ykMbrpJp0f1XeX9Icc4oU54ax0OX8L+OZ7479HEy+Jp+89QuyNyvMOpbecCdPDn4KoHYuNEpC3JxGliBdwn04IPGGjIBq2gX4JvnhyVonrTqb7JA0cWVSwBAbpKEha5uu6tThJyEOrFWZSNuqkXDQ6KkYBYXbNj1cWJTE28ErGzDO91DL0WmILHhy6qabQaaieoyWKMz14kKIQt5Q0FT4MArzfIcUW+Q1PY1sWAdNOlW06yDWvhQiWQa8PJBSYUgRHoT9JlhwZIvyJAMLB2HCUQlE2V8KRlY5P/g+1RMxKKy
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(199004)(189003)(36906005)(99286004)(81166006)(25786009)(14454004)(305945005)(2501003)(102836004)(50226002)(478600001)(26826003)(26005)(4744005)(7736002)(186003)(8936002)(5660300002)(8746002)(47776003)(8676002)(81156014)(6116002)(3846002)(36756003)(386003)(6506007)(50466002)(1076003)(76176011)(66066001)(2351001)(23756003)(2616005)(22756006)(6862004)(2906002)(4326008)(5640700003)(76130400001)(6512007)(86362001)(356004)(70586007)(446003)(336012)(11346002)(70206006)(54906003)(106002)(316002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4074;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 812b9369-7264-40d5-c9f6-08d77272ce83
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLePB4b8lpPaHcGIDwVOCSwcPAm2/cBsHu2xQSB6eq4es9wG8tAVmSN/Gfa4uSLJrAJSkRf9pTFbzvqTXqQh7ERqm+IgrlVKX+ukUHy1rln68BAnlAYnPGvMSx+ZVsHbqTHBGIQxC64vovz1PpPseapGYMl7+wU3ykZF3tDHgBfEX0p0tof+Sv8982/XnWbxVstoU2yDl8vZGdpaEG1nnsRPUk5lvTVUqLzzzatO07/oI82MNPcy01AgoDvGrZ5o4lF9jh+iUUfXOUR5DL0yikV6SDje418OlgqxP8QX7AYcR/5lrhhU4pKrDJfXVAMK00nhb+ADb/e99sqpeF7bk7sCndaQ3xzCqJ6FuVE+wcVOLvB1LN0D8Aex6sFrMrAwa7BuiHniWotbnLznuvnC8RUNzkwpMG7nfH7gxB+70Fb/dP7l65eahhYbZDnUO8fW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:24.4414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57993a44-1034-4666-9ee8-08d77272d66c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/sii9234.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9=
234.c
index f81f81b7051f..bfd3832baa1a 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -925,8 +925,7 @@ static int sii9234_probe(struct i2c_client *client,
=20
 	i2c_set_clientdata(client, ctx);
=20
-	ctx->bridge.funcs =3D &sii9234_bridge_funcs;
-	ctx->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&ctx->bridge, dev, &sii9234_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&ctx->bridge);
=20
 	sii9234_cable_in(ctx);
--=20
2.23.0

