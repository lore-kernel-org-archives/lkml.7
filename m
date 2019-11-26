Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7C9C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21242073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Zzhab33A";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Zzhab33A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfKZNQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:43 -0500
Received: from mail-eopbgr60070.outbound.protection.outlook.com ([40.107.6.70]:20336
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728108AbfKZNQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Av9EoDIvHqCagseLb7iy4+qbCZH7UsR3146DKkdXRfQ=;
 b=Zzhab33ACIG0b7lKAjD43tk6xVONdeMKIZUlh3BvSC63pSH5lGegjHFfvhN2GBSkXmueGAR3VuVXa78QJQ+neBIwJnlD5xtdEuFVbsl1oSGZB75OvZiMq5slqCqyL3QkEA8H4l5iMAsU0U/dIHGJXeBLtFuEmEkKC/ErCdpbQ/Q=
Received: from VI1PR08CA0169.eurprd08.prod.outlook.com (2603:10a6:800:d1::23)
 by VI1PR08MB3518.eurprd08.prod.outlook.com (2603:10a6:803:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Tue, 26 Nov
 2019 13:16:30 +0000
Received: from VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR08CA0169.outlook.office365.com
 (2603:10a6:800:d1::23) with Microsoft SMTP Server (version=TLS1_2,
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
 VE1EUR03FT031.mail.protection.outlook.com (10.152.18.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:30 +0000
Received: ("Tessian outbound 37db47aaea47:v33"); Tue, 26 Nov 2019 13:16:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e6da36db19957cc3
X-CR-MTA-TID: 64aa7808
Received: from c5906a3ff2ed.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 02DED840-D516-4059-A031-C07723D36163.1;
        Tue, 26 Nov 2019 13:16:21 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c5906a3ff2ed.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EK5EOG0pXrOMdH44icjcy96SrlhhNeDB5sxHSqnhQvtldaw4hAZkrn3dofB7QA2ZdaeFnoi+GqtMU0ZoUBUGwS7BRlpZjmZh16JWv92FL5jrWV7+U8vbcAnm7Vj3TcxbEvlqTn/86VTXGC1GFVmk7bMjtycOFwW9E6hgc1r6Fsur7Ol/ReUALU2GVODipjpRwU+cpZWdsydd0m45VSMbKnkajO1jll6S+d3Ylx3TsCP8HQDJ4nxkO33d896fQaGJcotaA3+uSQ6Gsal8K+s/RJOMc5WL/Cxcaggi3xyfnVTLqa2L2LreilcO08XpVwA8wYrWZekFNmQw0CDeU/52Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Av9EoDIvHqCagseLb7iy4+qbCZH7UsR3146DKkdXRfQ=;
 b=I25MAtieLPrp6wSy9Jlmu9aPZg/I7A9FBLjEzoFoN0TOfq1xjhP1GOBC7+cYMj1FLNmZ2oCyxOtHb1EOOWumfN+LtZzdJr+uLb+ogM3yLsqKyNjAVwc+8Ojh2sYoXULbgDi3qXUv7YuHQdr0vAaLpN7u14ETBLZTBzja5O3e+bdQwG25zZWBMcDkiQ+qqiGgVnOSb1KClTV4CDjrin37yqWn3S3u1X7Y6Ga5bgPWzHL+Vr8gTThSBItBS2Hxyq6wt6ADoI0bi+vjogn9Quov7xwURxYq7Htj16v/o/joYsopY0SE85YelTbqAIotOnav45Svx4SL1QgD6bJEiARE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Av9EoDIvHqCagseLb7iy4+qbCZH7UsR3146DKkdXRfQ=;
 b=Zzhab33ACIG0b7lKAjD43tk6xVONdeMKIZUlh3BvSC63pSH5lGegjHFfvhN2GBSkXmueGAR3VuVXa78QJQ+neBIwJnlD5xtdEuFVbsl1oSGZB75OvZiMq5slqCqyL3QkEA8H4l5iMAsU0U/dIHGJXeBLtFuEmEkKC/ErCdpbQ/Q=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:19 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:19 +0000
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
Subject: [PATCH 21/30] drm/bridge: ti-tfp410: Use drm_bridge_init()
Thread-Topic: [PATCH 21/30] drm/bridge: ti-tfp410: Use drm_bridge_init()
Thread-Index: AQHVpFuxc2cQozE9BUes8TaR0hE2Hw==
Date:   Tue, 26 Nov 2019 13:16:19 +0000
Message-ID: <20191126131541.47393-22-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7230435a-8fe1-48d3-148b-08d77272d9ce
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|VI1PR08MB3518:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3518A1CF13E128161980483E8F450@VI1PR08MB3518.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ndO50CM+l0GKhxxnyxeuSVrebYpXs7pRiFDM2XisV1lGK7tpLoiL4bxxZVixbGic7EQ5tdQ/vGPWEluQYp5c9WAj7/8N3MfOU7L9+yrqQ5zUUH7p2PQcJ1GpVHdECyrkan9g+INvH4qLankKbF5a3x5udUdd9t1b2Mfds3kkqTtC9Mx3Igz2xEytMYZnHphELyVpPOVnHfU/VX4NKPg9hx2BbMxuurn+wTcOanYOjpsvcKEW2bmHSKBwb9mmMf7WGYk5462o85H5fsnCOdXvzlgDTnJVxxeab7K1Hj+fKYFuANN+TsKWO3uZCFQrMyVKeOFVoeH0f8xUhCio1CGI0UL8wy7741ub+G8Be8yNXBpEeouHsLzl/hh6yzzg4jd5MTDJnAiCCMXX8n+nZDTyx3s0/gpNDS2AlZTIfU4vbPr3WR5S5L6jbTiTNNBArQcA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(76130400001)(50466002)(86362001)(99286004)(5660300002)(23756003)(5640700003)(305945005)(6116002)(66066001)(3846002)(8936002)(26826003)(186003)(102836004)(478600001)(4744005)(7736002)(26005)(1076003)(50226002)(8746002)(6862004)(2906002)(8676002)(81156014)(14454004)(81166006)(106002)(22756006)(6506007)(386003)(4326008)(6486002)(446003)(2616005)(11346002)(36756003)(336012)(25786009)(356004)(316002)(6512007)(2501003)(70586007)(70206006)(54906003)(76176011)(2351001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3518;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 388bcad2-3892-475c-c12b-08d77272d366
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9JtC6N7mmPxMaDcqs7SadMLvFZkXj+sOPRELfw3qwj1EagjCSnCmILoMlpTqs2Gv4oLkjmL9T6eh98E7jfYoQdjVhAIFW33CI5sS9yZ6O8XqyuqyyF0oFa8Xiw+ZG9kc7Dfw5hNb0sRuWJxMTQiB75yxKYrn4l2VTgtiJKqM+OKeCjdcxfbOz6vA0uNfxe6oxK0Du4c0qzAh+sNYbFg6Q6nsw4jQPczu9DSGDOCAHZkBQMO/wRQCnd25TgO2lCGo2jjEhryjrJXkSRosF/msWO35YWXC7KLtAu84G12wkdWnDrg0xqGhVHCgzccqFXVJY7znbLcnwKF83oJ2oXJoJWK5c5EvAGGkoyQIxL7ll2XDHP+RViCll3tZaWmnuhcU+pTFFdUadLtTM4VeO76bKYL+BwVKXqRGVk6A+paHR7o7eXh7Ca1Cue1e0wrpcKRT
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:30.0933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7230435a-8fe1-48d3-148b-08d77272d9ce
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti=
-tfp410.c
index aa3198dc9903..377eca989ff3 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -328,9 +328,8 @@ static int tfp410_init(struct device *dev, bool i2c)
 		return -ENOMEM;
 	dev_set_drvdata(dev, dvi);
=20
-	dvi->bridge.funcs =3D &tfp410_bridge_funcs;
-	dvi->bridge.of_node =3D dev->of_node;
-	dvi->bridge.timings =3D &dvi->timings;
+	drm_bridge_init(&dvi->bridge, dev, &tfp410_bridge_funcs, &dvi->timings,
+			NULL);
 	dvi->dev =3D dev;
=20
 	ret =3D tfp410_parse_timings(dvi, i2c);
--=20
2.23.0

