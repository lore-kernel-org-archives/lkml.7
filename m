Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10517C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6ECA20659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="wDTcT+Gi";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="wDTcT+Gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfLDLsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:22 -0500
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:16000
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727703AbfLDLsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdtA94mAshVXUemmMQnmXJ2MlYnOXP7KGT14dEW+wMo=;
 b=wDTcT+GiRb3Rjto8H9ONU/TWpWcdFlyoy4D99uhWgnSPQ03ACzUoCsj+whvfJPSrW/8g9r8QXZt6pp3p4nLOfJf9CaW2kd5Vy7CYIs+75NS+JL/Jw8XqmTVn/M0bExrFuIYoy14Wm3fhdaGc6gmptX6t/ElRJ72UFQaF2GRmp3I=
Received: from VI1PR08CA0170.eurprd08.prod.outlook.com (2603:10a6:800:d1::24)
 by VE1PR08MB4767.eurprd08.prod.outlook.com (2603:10a6:802:a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Wed, 4 Dec
 2019 11:48:15 +0000
Received: from AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by VI1PR08CA0170.outlook.office365.com
 (2603:10a6:800:d1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:15 +0000
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
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:15 +0000
Received: ("Tessian outbound a8ced1463995:v37"); Wed, 04 Dec 2019 11:48:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6d6903a92b05bcc9
X-CR-MTA-TID: 64aa7808
Received: from b2b246179d1c.6
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1C65C39C-92E1-4B29-9DE1-4CFDFB0AA921.1;
        Wed, 04 Dec 2019 11:48:07 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b2b246179d1c.6
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqpCeYv+pC8Wv75GQIgMx8N8gYEQocqMdEvU/R5jaXFbhaRpDYhfgjhkQmIb4VjienVOcnyhisEBqPlO+CirqGTcKEFDKyvhGNeSpv9PK2gtXuKFlNKVYxDyZBHkn0i5XeLa4MHQtttGXShHBrWtgap7isims0Wg6VDzI3M1hNFt5oLBYY5MRaGjeBYDuiWhxaAJw/qwULARso3MF1FJ9sybZ+9vCa4Vs/fNEGMirb9sLfmk0kjkzAuI7q33wGjqRovAQbVYZPUvett1hFaH/gShr0mANlGeEAS9RonkZF8ZaktqwphDAL0CD1nsYcm/Z+lpDF5iRcTuhW5JvUU4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdtA94mAshVXUemmMQnmXJ2MlYnOXP7KGT14dEW+wMo=;
 b=Zvai6gVyBwfFpTEFfB0qAu1JqqAn4B9SyOYngFsyg9RhJKHc4nARd+ABArxqlqd7h+oT8VqJULb9ay2xHH/8irslpeNoVVsAd1DMw5HVMmPzLQdiQSkGWeCO4plhxSELSCnHK9ve3oc06Ont9eutZF1HsUOKkuUD7Xny6nlj3OaPafs0av7gH9Gs4F3Rtmy1arJVjjilJokhN+LVV5Ln4My3yCB2/2se1HP77Wp8txvQSRbuKE1k57ZO14jboV7GWJzp+vhD4hZ2HUy3CnhKMk5J2cY1FrBS4QcmzWTUnPrRcgfNKl/j9X+H+OsN19QRNjI8l2CxtuLQ37XprVNRQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdtA94mAshVXUemmMQnmXJ2MlYnOXP7KGT14dEW+wMo=;
 b=wDTcT+GiRb3Rjto8H9ONU/TWpWcdFlyoy4D99uhWgnSPQ03ACzUoCsj+whvfJPSrW/8g9r8QXZt6pp3p4nLOfJf9CaW2kd5Vy7CYIs+75NS+JL/Jw8XqmTVn/M0bExrFuIYoy14Wm3fhdaGc6gmptX6t/ElRJ72UFQaF2GRmp3I=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:05 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:05 +0000
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
Subject: [PATCH v2 04/28] drm/bridge: cdns: Use drm_bridge_init()
Thread-Topic: [PATCH v2 04/28] drm/bridge: cdns: Use drm_bridge_init()
Thread-Index: AQHVqpiwW/k2p/w8QUKECC27jnK8Tg==
Date:   Wed, 4 Dec 2019 11:48:05 +0000
Message-ID: <20191204114732.28514-5-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 98ac9f88-47e2-4a5e-e0e8-08d778afd948
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|VE1PR08MB4767:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB4767335487111AC5F902560C8F5D0@VE1PR08MB4767.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:669;OLM:669;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PNvEq7imDomNeIWunAfEN2y9iqsit1BitK0C75mETaqlLBQj0rgKQgA8DQXYRwQGQM639RCdlWmxUCsoGW4bdczbWGJWrGNIYazlMtaoHW2KS6Q0SOhuFm/Ze05LdUkweiYOWdXhoXZ/GNR6oS12i6hSM6YgUtRwj+6gsFemEoWjqM92EffLfi6Qyz5FSGHhakuYtH1knxFxAe7O+W4Xm02RPgPj3XVdwLwGIyjS+jCEFLrSdXL2jvnUj7N25e19IZlOkFc6xrXuN/f6EpW5vlXJHixEFDOT/c2ryX8WOKXcw7M3ShYfh7kKzK5dWTIrVMfz6isYQQvAinjBb3EmDfFObL9owi8tSbmLv+f2pP3aLEiOsUinYrLvW/h3LocqFfP3aDUH9/MmRSM8lJ5uyi5vHKOXsMuyKygTyASOOLBsdji5Zc/cMErImCA2Dv4P
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(189003)(199004)(23756003)(8676002)(14454004)(2906002)(2616005)(4744005)(76130400001)(305945005)(7736002)(3846002)(1076003)(26826003)(2501003)(70206006)(5660300002)(86362001)(478600001)(5640700003)(36906005)(6512007)(4326008)(316002)(81156014)(22756006)(6486002)(70586007)(6116002)(102836004)(36756003)(76176011)(8936002)(50226002)(50466002)(2351001)(6506007)(186003)(11346002)(6862004)(336012)(99286004)(356004)(54906003)(25786009)(26005)(81166006)(8746002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4767;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d668845e-e3b3-4ca4-2684-08d778afd331
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jVpYiwMc3hJY4CiXLOjoBg+B/nWE8M/SH/xoZyJkH0QN2A76RsTLFKz2NbYvqbilhfGIdx/ryUNoJ1A8gkyX/gRlJjmLxWS0btYlq9MKXlL2N14Xl4d8kez+lzN45P2lb0HdmrkKdcTJ7v8LXx/pjwHSSsp3+pt06pHBSNdWb74tAoEjms4ntgnkkd1U7DFDJj81k+xz/MEG5oUCe4gu7T5PO9S1L8vvzzi7SdQfdw9tezpGMBUJghhCTSRtnZ8qqNpRnXZoBxxZsyqardY0ODcJeFsaUSMhvO3JpYa1aIc53RY0toQ3CF8PHk1YhTmimPUNINY9KwLMh7o7imnFpwdJH0cwNm83gvUBmmMgDhzdgl0EO5+lHuKgHBl2slfEx9m/OGMbM80T1rgTXBdgL9BowBfXG1JC06532AFM89kJ8dm91Vfv4s/+IpB3z4Dp
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:15.5716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ac9f88-47e2-4a5e-e0e8-08d778afd948
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/cdns-dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdn=
s-dsi.c
index 3a5bd4e7fd1e..58b2aa8b6c24 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -1233,8 +1233,8 @@ static int cdns_dsi_drm_probe(struct platform_device =
*pdev)
 	 * CDNS_DPI_INPUT.
 	 */
 	input->id =3D CDNS_DPI_INPUT;
-	input->bridge.funcs =3D &cdns_dsi_bridge_funcs;
-	input->bridge.of_node =3D pdev->dev.of_node;
+	drm_bridge_init(&input->bridge, &pdev->dev, &cdns_dsi_bridge_funcs,
+			NULL, NULL);
=20
 	/* Mask all interrupts before registering the IRQ handler. */
 	writel(0, dsi->regs + MCTL_MAIN_STS_CTL);
--=20
2.23.0

