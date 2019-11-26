Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C000C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72DC2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rXfPspVH";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rXfPspVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfKZNRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:17:30 -0500
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:61408
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728107AbfKZNQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zMoKcmV7qGGAHECqCXtHZ6E+T/kRsQLeMnNAZQSxW0=;
 b=rXfPspVHtHuZXtim4gO8brkWcLT2CkBwYWPwYMReqVEC4tmtgnR4qhZVY+qb3/4mvuaiuYSOtS1gRVAMOst1W001pjL4EQYV+vt7m33oKiSkhKcPsWd5OBHpv7EqeahvOb1fZyZHL8YW7H2XTuFN4hutmnoFBjzfYOwr5zyoU5U=
Received: from VI1PR08CA0151.eurprd08.prod.outlook.com (2603:10a6:800:d5::29)
 by VE1PR08MB5069.eurprd08.prod.outlook.com (2603:10a6:803:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Tue, 26 Nov
 2019 13:16:30 +0000
Received: from VE1EUR03FT008.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by VI1PR08CA0151.outlook.office365.com
 (2603:10a6:800:d5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:30 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT008.mail.protection.outlook.com (10.152.18.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:29 +0000
Received: ("Tessian outbound dbe0f0961e8c:v33"); Tue, 26 Nov 2019 13:16:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5abc290fc018b9a6
X-CR-MTA-TID: 64aa7808
Received: from 223e0bbf9727.4 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3AD3AEE3-B596-499B-8A3B-8DE6CDD0521F.1;
        Tue, 26 Nov 2019 13:16:23 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 223e0bbf9727.4
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHmC/3xlBs4H+U9yFJbr7VqEuT21DjEjyLGsx6ImCUgXCe84xvzq6M5MMgp3rbJ0jA5jKkaIoiUhPDUYVlFAf/8qLOfUAybUvx09zk/sQwhCbp4EU5Qq+6MmaGEcmFDmxwkaz7yX9wt1FUsFdaBtEBYSMq3SuDzU+za6ibMuhDXmrYFELZVDLHYiG6DS4cokTTq8J7OG16m8QVB5veB3THy249Qcqj/Xac7PnwW20LmMHqY8zIB6IFw+x8u9BxlvxPzAWooR6YzTuuuz2arWm9j2/BJhrszzrhbb0krBsjZ+8Gv1BE2IpUplNEl7V1D1wJQ1JY4Ke9bo6183hkKXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zMoKcmV7qGGAHECqCXtHZ6E+T/kRsQLeMnNAZQSxW0=;
 b=AuXKNJ2G9NiNuRR+bgVibmZAgVJ0xhLQS7MJEWLxqXv//kgHFeDh2uKtFHnrVvHh+5fgAamQ6X8JXL5gZsMOP68ZxhVHiFg3CIJSokEwmr7oZ75tSDu7F+bsHZnr3cr819TgoUDymghMWVFSOgrsxwVhQgFs2yaMQhIhptvDhXdsNcbq04puf3niZgC3E7YyOvPe3NiegqFKafENfwYIIZ8KcplV8Q0UMQh7cNDDtaCrB3zFpYc5M+u/GRsE4au9ryGGm3+oUCptT5PmumFFNeEwW8WOEtX8W3iM2ydiEc+CKL7Uxsv1sQ6npOPen7XS3hnIZeL6/eyJg6mjVTVbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zMoKcmV7qGGAHECqCXtHZ6E+T/kRsQLeMnNAZQSxW0=;
 b=rXfPspVHtHuZXtim4gO8brkWcLT2CkBwYWPwYMReqVEC4tmtgnR4qhZVY+qb3/4mvuaiuYSOtS1gRVAMOst1W001pjL4EQYV+vt7m33oKiSkhKcPsWd5OBHpv7EqeahvOb1fZyZHL8YW7H2XTuFN4hutmnoFBjzfYOwr5zyoU5U=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:22 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:22 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 24/30] drm/mcde: dsi: Use drm_bridge_init()
Thread-Topic: [PATCH 24/30] drm/mcde: dsi: Use drm_bridge_init()
Thread-Index: AQHVpFuyLEx86o52+U6S5iv7phXr1Q==
Date:   Tue, 26 Nov 2019 13:16:22 +0000
Message-ID: <20191126131541.47393-25-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 15a26e69-c62c-4195-f6cc-08d77272d9be
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|VE1PR08MB5069:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB50696DE347BC6FED2253F54C8F450@VE1PR08MB5069.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1360;OLM:1360;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Mwb09yBnAQ1AKYBxzs6/EOlsSXTOLo1iyGcv4NRBAhwli7ARpLaN9YIjWHVDd720KtqijgqB2KqC/q1PPfBLR1HoRq3vwVqpRaIP9fpo+6ZXAEQ7gNacLYRHbTrHsH4kt/nnPsozPdvPThwCqopxGgTLYPXEgIt7j3LezxIGMjUJLNdVFHUqThejJTetdrG/ifsKX8tkRYD0AphuMbv6cWB1NJ4/ySNtVgywGyKmJ1RNBq+6tg+uaPz6PpGFnNu3wbuC2s6ev6LG4t2k+nB68ka/fJekcwsL4iT/qNZyTIqsfDD2Q++rqqjacMvIq0gYAAcdOyb6cy70W24g3pfpuKox4xlFsqA2IJbrUU76Fvjkj1zUJDiU4GiMxJpReDFFywYmeGIu65/Z/oBYrnfzoniwl7LzuBrdYZ93MCwHI/0S3NFQGmQLBgSJL0FbPYG/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(2501003)(26826003)(50226002)(47776003)(6486002)(8676002)(70586007)(8936002)(81156014)(8746002)(2906002)(81166006)(4744005)(478600001)(25786009)(6506007)(316002)(66066001)(76176011)(386003)(70206006)(2351001)(186003)(99286004)(76130400001)(54906003)(26005)(5660300002)(1076003)(106002)(356004)(2616005)(446003)(11346002)(3846002)(86362001)(6512007)(6116002)(23756003)(5640700003)(4326008)(336012)(6862004)(36756003)(50466002)(7736002)(22756006)(14454004)(305945005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5069;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 16584345-d1b9-4596-dcc6-08d77272d505
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yr8TpxCtOYC7Sw5I/7VGkNhD3PtEozPXfPsZUWywSNTGBkuKPQe2ClTXlNj0jM3oRNUUphiJRIYM2LIraWbUldiwpr8lBem9fNubKqj+/tE/pMEz/p18OZqu3igfO1bzSo8U+PfgC6SREAxtuMbrt0O07ptV2NmyiRi+ZIVtMlTSKLfr7vT/RP7QrV8VbzKKIb9oLB21++TgMQeTs1dW9PA68aQvlYyG83N3KKHLqSj2kpAekquVNhgQk4vZMDMTd5+AWR6DNdyG2wcEeqZIRfCJUqKr8JxTWP8xBbOuqTb46yzsYLmcNGkMk4H8SsZOWUx5IyYQo2rEvbeboPc0RBf/KFXeERLkGhU206CbBiN7XMH4xmKwMBEgW9MzFIUjfJXufqYzQhol5tt7eusJBsEEcSSkeo2nwMxl4oWYXC9JqdCQWdx5ff9N252snyW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:29.9972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a26e69-c62c-4195-f6cc-08d77272d9be
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/mcde/mcde_dsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_ds=
i.c
index 42fff811653e..d9b9253acccf 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -955,8 +955,7 @@ static int mcde_dsi_bind(struct device *dev, struct dev=
ice *master,
 	d->bridge_out =3D bridge;
=20
 	/* Create a bridge for this DSI channel */
-	d->bridge.funcs =3D &mcde_dsi_bridge_funcs;
-	d->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&d->bridge, dev, &mcde_dsi_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&d->bridge);
=20
 	/* TODO: first come first serve, use a list */
--=20
2.23.0

