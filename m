Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E52C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB092073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="REVwHFK4";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="REVwHFK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfKZNQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:55 -0500
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:15509
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728179AbfKZNQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwWUgh4a/99W8HIctunJRzMXApJ6JnBQ7MIy/xuhdE8=;
 b=REVwHFK4ix5yiIsKLIEF9PPRWmXhU66yy4T+YHyckbNsLAWgMOefFVtv8MGgn6IpgJkqocbZ8dXr/DRSlWBlCMqN90XkSS6+WTUCWYLnbWo0HR8gjXkK8N122ZpRnAf8El/wYn/RAKlQ/lY/jtMP4uFViDcUeSvWyIp1c6nbYwE=
Received: from VI1PR08CA0190.eurprd08.prod.outlook.com (2603:10a6:800:d2::20)
 by HE1PR0801MB1754.eurprd08.prod.outlook.com (2603:10a6:3:84::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Tue, 26 Nov
 2019 13:16:40 +0000
Received: from AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by VI1PR08CA0190.outlook.office365.com
 (2603:10a6:800:d2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:39 +0000
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
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:39 +0000
Received: ("Tessian outbound af6b7800e6cb:v33"); Tue, 26 Nov 2019 13:16:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 551831df112d173d
X-CR-MTA-TID: 64aa7808
Received: from ec33c90fb7d1.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1FE755C1-A806-469A-BCC2-2777D3014020.1;
        Tue, 26 Nov 2019 13:16:19 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ec33c90fb7d1.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipXIWdqkCZxeGhW2gwPAdVOugY7ee2RFtW0zpVTDTE3ElX0VAyIaYgnsXZz/ziU7vB9MfUv4IH9T1Us/W9zlEKpaZ3HWuarFeU8w0y8qzqvexzm3vtS/kY8RFAgv+oPuRVJTlpO3yvfNOREIY/fNGmSqa4lBQ7gGeuetidLpvyCxLyItPPuoprJoWYywZ6IBdvqSvjAt86MKY2OfDaZb6mapsnuqTXqw5AxoXhjH2te4cveCixIxtug8BqY2h9PCvRw4/U3KuKvVdNofmEIxoFDTfqnnwc2OXI2ZN/w65vFKkh4EqKKyj2JI8923cgWs4kTiAWkTlLuepT6aHEtfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwWUgh4a/99W8HIctunJRzMXApJ6JnBQ7MIy/xuhdE8=;
 b=UpWvjvAzQNipac5z0VL//JK5qXm17xooJrHkEWbPe1DJhFTvtSKUAEIb7QToj2HuIVpvNT0LK9b2v1vtAsRlMasE8drpL2RKwT5Pc60Y7H9o8Sr4UDOzx9EzCnb6fnXW74K9PZ/LgmKjNodKE80uGYYh3HX5pU+eO/zUYtoOPhoAOP2DqA+UwpaTf6gxtDuU6rWk6n94kHj4aD97Vjzj5b4v/AO7qui9l9Ff7Fj6Kq+KlXK5uqAdscuC7yIKQIQowvUMPbm1T7c5CJ3bLowk0YvzsOxCZDCY8NiQdDo5i6kpLd1NcM8oe1XhEWK48T7gp+Ija02Z5ukUmWeDzwmabw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwWUgh4a/99W8HIctunJRzMXApJ6JnBQ7MIy/xuhdE8=;
 b=REVwHFK4ix5yiIsKLIEF9PPRWmXhU66yy4T+YHyckbNsLAWgMOefFVtv8MGgn6IpgJkqocbZ8dXr/DRSlWBlCMqN90XkSS6+WTUCWYLnbWo0HR8gjXkK8N122ZpRnAf8El/wYn/RAKlQ/lY/jtMP4uFViDcUeSvWyIp1c6nbYwE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4560.eurprd08.prod.outlook.com (20.179.24.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Tue, 26 Nov 2019 13:16:18 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:17 +0000
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
Subject: [PATCH 19/30] drm/bridge: thc63: Use drm_bridge_init()
Thread-Topic: [PATCH 19/30] drm/bridge: thc63: Use drm_bridge_init()
Thread-Index: AQHVpFuv1f0rKFruYE6C6McKrV2JsQ==
Date:   Tue, 26 Nov 2019 13:16:17 +0000
Message-ID: <20191126131541.47393-20-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: b43de88f-80a5-4d61-c3b5-08d77272df7c
X-MS-TrafficTypeDiagnostic: VI1PR08MB4560:|VI1PR08MB4560:|HE1PR0801MB1754:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1754DC13555C9FE80F1430488F450@HE1PR0801MB1754.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(71190400001)(478600001)(1076003)(66476007)(186003)(26005)(5640700003)(52116002)(64756008)(256004)(8676002)(2351001)(66946007)(54906003)(81156014)(44832011)(3846002)(4744005)(6116002)(6436002)(2616005)(66556008)(71200400001)(2906002)(11346002)(66446008)(99286004)(14454004)(81166006)(6916009)(5660300002)(25786009)(2501003)(8936002)(102836004)(66066001)(36756003)(6486002)(6512007)(386003)(4326008)(50226002)(76176011)(316002)(86362001)(7736002)(446003)(6506007)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4560;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: +wEj2TXnLyjilv0qLzlz0ARpoMHoqNgcARY+GDh2B/SJSuAa7FJmRi16O2nxycLU6XrN+vtFmu5TJNNwMa848vqSzn3hpDuJB/HLqvdbTwQhJSk06sxwmdX4aVdQWLDL2gFU+u2pEM4DECv56+B5N8TBBd0RvRL9KdF63ZsDLrvDAdYkbmTcW9kG+lTYvFH8fJJ5ljj9Oir3nFrgsffehDQDf4F/sUHEJtzyK/8rPdC8nMZu12G6wdYvojYTKQbQyje0LbMEZlK6Mrig8/r7YEtFZcrA6pNxM5tagf5j8AmicXpqx2jftlH+sSoXieLMEKVYz4XnpGbpXik4rNT5Iq8TMmeFmBBBoYjsJm008qYtizCXqIkoEwKBQRh7lRKkBHV0SjXuoGNRYtj9BBeUkjMs3V1hEGQc+UqCq/259n14ajvsY/DDpoYqw3nvPITY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4560
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(189003)(199004)(8936002)(102836004)(99286004)(76176011)(8746002)(1076003)(36756003)(70206006)(50226002)(6506007)(386003)(70586007)(23756003)(356004)(50466002)(5660300002)(3846002)(66066001)(6116002)(446003)(2501003)(2616005)(11346002)(47776003)(76130400001)(26826003)(6512007)(81156014)(81166006)(8676002)(186003)(14454004)(4744005)(22756006)(336012)(305945005)(54906003)(6862004)(2906002)(6486002)(2351001)(106002)(7736002)(316002)(25786009)(86362001)(36906005)(5640700003)(4326008)(478600001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1754;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 401d8086-1aeb-4fcf-a152-08d77272d243
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZMGwuN0ds7YvS5X7WO1KpCpiBjKC6uZMVnDh38F6bxBfqbQOjT3UftU51obRU3T5MHB7QR30WEzCi7EoGB2JYAh7ExTxlRnqmGJc8mHhV66jH2e3N+LBKpuUCHpFzhIGeexLRg6k/DKHlkuYblBM/ikIA2iwfX4T5i1EBVbMeOo3MYbwNE97IAe76GopCoxIRA1g+dvX86SUgFTGsoCGxI82edY13wcduO5EaPGhGJR2w/NaGXihM1PfS7p0nudi/1V0BXjhiwG4PojphdPXW+K03egBk06hhDQi1J5WIqkl8RS8Fsd+wSQYCCUlyGhKmgkKm0DSjy+I0GxO15z7+0tVny7qbS7zutQ7Wu305RdjujOSCjEc/gOxsL20RY73VKUROxY2EjbEXPe2NO/FxS9vmgDbofmbHJjuldunLHTO/3TQFr1qdY2tyx1iAWk
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:39.6917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b43de88f-80a5-4d61-c3b5-08d77272df7c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/thc63lvd1024.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge=
/thc63lvd1024.c
index 3d74129b2995..abe806db5f4d 100644
--- a/drivers/gpu/drm/bridge/thc63lvd1024.c
+++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
@@ -218,11 +218,8 @@ static int thc63_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
=20
-	thc63->bridge.driver_private =3D thc63;
-	thc63->bridge.of_node =3D pdev->dev.of_node;
-	thc63->bridge.funcs =3D &thc63_bridge_func;
-	thc63->bridge.timings =3D &thc63->timings;
-
+	drm_bridge_init(&thc63->bridge, &pdev->dev, &thc63_bridge_func,
+			&thc63->timings, thc63);
 	drm_bridge_add(&thc63->bridge);
=20
 	return 0;
--=20
2.23.0

