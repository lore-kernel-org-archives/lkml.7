Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142CAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB79A2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="50wLLw3T";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="50wLLw3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfKZNQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:48 -0500
Received: from mail-eopbgr60070.outbound.protection.outlook.com ([40.107.6.70]:16908
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728130AbfKZNQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFvLZuLVx0CkgA0/ZpPlhqvVnfV4TlettTTn32zufE0=;
 b=50wLLw3TXGvWp2dtsBQXj0HUr4rS15+vfDvXBZGEUK9F+1pRWB4yHkFwPatJgwGSUeZUPSy5E/BUgiPLA6ZONPEvJtjfZGN4/EnR7BuQaLRk5KGOJwsOKlSWbNYaQlkn2b7LQUKs8IkQr3g5wLhWz8N0Qv/8U+O4Us5/0R++5WA=
Received: from VI1PR08CA0191.eurprd08.prod.outlook.com (2603:10a6:800:d2::21)
 by DB7PR08MB3531.eurprd08.prod.outlook.com (2603:10a6:10:49::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21; Tue, 26 Nov
 2019 13:16:33 +0000
Received: from AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by VI1PR08CA0191.outlook.office365.com
 (2603:10a6:800:d2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:33 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT020.mail.protection.outlook.com (10.152.16.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:33 +0000
Received: ("Tessian outbound af6b7800e6cb:v33"); Tue, 26 Nov 2019 13:16:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5fd3d59c4e12c313
X-CR-MTA-TID: 64aa7808
Received: from 206d54aa05cd.4 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2D8174F7-A801-4DB8-9F5A-0A7DEC77055C.1;
        Tue, 26 Nov 2019 13:16:17 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2058.outbound.protection.outlook.com [104.47.10.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 206d54aa05cd.4
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3unJYRilQJMF1AM7nttyN1taKwQeiXjzxaX4BYpfOm/6voTf6i3DklcYL73dX3chW1eAMfrd2lJ3HI1Oo4+4GuvnJElhB5ISVVdzmBrAl2KtfN/ntuvX52cNKeMkN/9psnOAKIXakO58a0SQ1kM9cG7LSwtUIgpk0TnAjKo9vpN3JgrNWMc8k1f+BobbMrdnHb6u/DWQTRfyX/EO+77XSPijVA54/JgEJgqNsV0Ax2qP3tlWfgy5LENN5EIUii8LE952tRhFAJdn6JDB8v/IjN6dYSZKvdYGWjHMn+B88Fsn95TUHeWZ1pDGTpgR0Yz5UkxQz8Ys+F4MkrjMUOVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFvLZuLVx0CkgA0/ZpPlhqvVnfV4TlettTTn32zufE0=;
 b=lHo2jjPrDHWxJpg6mxvLhr50g1Ntz30vobhms0eECWutxS1dNQDHjloTq6oG8/B7nIJL6IQR9hEyslcdI475nxfDorib3ULna1JysNCSEn5/KN+NSAKQTFthGO2BEPHcMMbXCP9J35yFcrGAiId9ztPS4vzMD+yY4kBegw92zSrXvyznDbHaNAYdnX9cfhRZd12akHQvBn+HGteYjpg7xH0jKlL5NPJnnteCayE6voxL0i0ZryTReTEK2XAJuGUHWw57RhsaQVR5ZVtAQxG/6KCVU3tAFlHnSn7L9OMpLeyE6Ix32XVVOYQfS/rvH+LmakZpb+7nrxcjN71Rmkc76A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFvLZuLVx0CkgA0/ZpPlhqvVnfV4TlettTTn32zufE0=;
 b=50wLLw3TXGvWp2dtsBQXj0HUr4rS15+vfDvXBZGEUK9F+1pRWB4yHkFwPatJgwGSUeZUPSy5E/BUgiPLA6ZONPEvJtjfZGN4/EnR7BuQaLRk5KGOJwsOKlSWbNYaQlkn2b7LQUKs8IkQr3g5wLhWz8N0Qv/8U+O4Us5/0R++5WA=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:16 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:16 +0000
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
Subject: [PATCH 17/30] drm/bridge: tc358764: Use drm_bridge_init()
Thread-Topic: [PATCH 17/30] drm/bridge: tc358764: Use drm_bridge_init()
Thread-Index: AQHVpFuuQXVEpOM6HUSYvP61oYNULA==
Date:   Tue, 26 Nov 2019 13:16:15 +0000
Message-ID: <20191126131541.47393-18-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77dafea5-a6b9-491b-cd4d-08d77272db9a
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|DB7PR08MB3531:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB35318B696D2FDE369D5460688F450@DB7PR08MB3531.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(5024004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hkkYl2StNqQc4+vH2kf5Yv69Fnpty2t1n8x5cz5y1SjcW4GPXoXy9vA+AVt2YFcE/pJk9uAyJSN/Lwuu6oA8tDkQfq0vKNTWEc0dd1P+3g0MAUWqXTH7pI7zLVhOLGN8rXaXNSbAR7M95fmxRaWv+NycoD6Pfxjmfy+VUWCLwtnogkMIheqKf/Ly5+1inuuthq1LJdpGBr/XHZHZWantjAVT92HN5a1EG4XCeYVtd3xXAT5tik88YusUOBatethKMwLKClSOxVagXhXjZEJOf7aPJIrE+wJZXKIgV2s4Z2VcG+dvZY/a2G+vk6dLaVcGk5cyxsCrzgUDPwi2neVcYW3LUoqaP1a1TTucnfYOxPF7GLYfm1gRZqiPwTXjvu5tWglBHHFr1EhPeP9kGz8JHH2R1EsjLybCz8tp4ANEuU7utXe/jkY2DtCSCF+r6+Ao
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(336012)(36756003)(4744005)(26826003)(25786009)(305945005)(316002)(7736002)(478600001)(5640700003)(14454004)(36906005)(186003)(54906003)(106002)(2906002)(446003)(6116002)(26005)(11346002)(2616005)(8676002)(81166006)(50226002)(81156014)(8936002)(3846002)(8746002)(76130400001)(70206006)(5660300002)(70586007)(50466002)(2501003)(76176011)(22756006)(2351001)(99286004)(6862004)(47776003)(6486002)(356004)(6512007)(102836004)(66066001)(386003)(6506007)(4326008)(23756003)(1076003)(5024004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3531;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f49a15b0-70a2-47cf-192b-08d77272d123
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHQoDn4rlKJRMrRYyyZLfI0P39gfM1vk5Iir8QR43c38M3myx2fErVsRn5iqpRowVEIHLQKpIiEvXX/NsCHDoiDEHH2PtqJvh4SUy48FtlcVCCHZvDg8XaOS2CR5WTNFwfjIqP9N+b5ursh21N95BiU8faWIG0pChivt54gWeosROhpXRfpo1W9phqB0PwOILkp5/dXggAp5ILa8yFifIMtXoqfzhZLiP3ZrYTlFEZed8+nIISQ+DCFpp+r0XLdMKfL4uKffcznRcMdBkV5Idn8e08q7W7Y143OIRYMIVjCvRG42nrfwob2uoq0H8zAAq+sM1wIQuZpb4/b+y8KC59R+bNmPUHRG1rNPlzCN6vbbExky/eTvL7RR7wwHNSMSFZIbl50PDRjd+g/SrxJBOAOHRKKGjPVQqEs+CtOEJbULwbxjoCzRSQ5Pa7TYm/1h
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:33.1767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dafea5-a6b9-491b-cd4d-08d77272db9a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3531
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/tc358764.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/tc3=
58764.c
index db298f550a5a..861d4df687ee 100644
--- a/drivers/gpu/drm/bridge/tc358764.c
+++ b/drivers/gpu/drm/bridge/tc358764.c
@@ -457,9 +457,7 @@ static int tc358764_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return ret;
=20
-	ctx->bridge.funcs =3D &tc358764_bridge_funcs;
-	ctx->bridge.of_node =3D dev->of_node;
-
+	drm_bridge_init(&ctx->bridge, dev, &tc358764_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&ctx->bridge);
=20
 	ret =3D mipi_dsi_attach(dsi);
--=20
2.23.0

