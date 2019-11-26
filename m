Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2352AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D002073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="6uTrHhEy";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="6uTrHhEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfKZNQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:31 -0500
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:61573
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727913AbfKZNQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG65isiFDLr+qbpV61uGylAb5rk13yS4rBT9XdjMRJo=;
 b=6uTrHhEyryREh76cPkiJLlfivrTQozE7Dm4W20qo6TyednHOrrZGlO6AkBASQ9d6i+AjRnBFb7KN8AnnJE8X3fm0Pn3bI9bFKSzUl7+sD3uTiM9ytT9DQ1GSIbecX46wT/ZUbHAOIYdTSC/+RmB+PJ/TdEB/fGUDuTDApm6spuM=
Received: from VI1PR08CA0092.eurprd08.prod.outlook.com (2603:10a6:800:d3::18)
 by AM0PR08MB5396.eurprd08.prod.outlook.com (2603:10a6:208:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Tue, 26 Nov
 2019 13:16:23 +0000
Received: from VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by VI1PR08CA0092.outlook.office365.com
 (2603:10a6:800:d3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:23 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT024.mail.protection.outlook.com (10.152.18.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:22 +0000
Received: ("Tessian outbound 512f710540da:v33"); Tue, 26 Nov 2019 13:16:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e12ce85a70890146
X-CR-MTA-TID: 64aa7808
Received: from 0334c95094c9.4 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 97330A3C-38B3-4381-BE2E-B672BD82A1DC.1;
        Tue, 26 Nov 2019 13:16:12 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0334c95094c9.4
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyNpqlmpgt1JMe0MajkSh80cAYEmqpfAqdopul+rG3Q6GbSERrd+84cT2p/4B4NRIGHHDFvNgGu6E0BVtNknU1WrrqhNVtqxYxay+35iQ0HZYEJMAzzPjGFmZW6GxcuBpc8V0e/yMl5f8mSbCUXrCxwSSKeatuh0hHOc3BSB8kk06hk4Gn2ixyHIIXTOFmVpJYZD0O8gnrknSXICW5+lJ4yc31pc/QTGMjcrX75cIelhPoQgPBL2B5g4e8YvjjABj1XuczpkKU3lpLO76MMCEFRiHDal6kl2FviSzTjwW/WoaoCG1Mzp+OMF1nwzXzV4e+9b7S6wvxxIu4ydHf1naA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG65isiFDLr+qbpV61uGylAb5rk13yS4rBT9XdjMRJo=;
 b=Ve66c937Sfz3AGkeHhSHDPcy3kTo51V5W1/KZgf7H8a07VcXJ61THosiqxZbNxrOXd+VMy8olJfgS/ogllQHvNswf3vxnWkiKGSf0y7qerc8zB6pRMjTpokYrtvbtGb7VEh7PAC2v/No0SFDWa0UP2V/UgF1HEqFCMZ5whqegC6xYqWxJYXOCrAerilpmbf8H8s2f5lzjwUmWvHB59f6X5Go8mwK8iUKlDJ+82HaPWM+cyUZTMsV6gvbrHFJ6W+bBFnciNS3ph+ItCF1FJK/oXQ6gNdiENw0dkDcANuj7oHNr1hJ8DpRJeaZ+YcI0vhfASkXefCFOZsL2/zfxBYnog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG65isiFDLr+qbpV61uGylAb5rk13yS4rBT9XdjMRJo=;
 b=6uTrHhEyryREh76cPkiJLlfivrTQozE7Dm4W20qo6TyednHOrrZGlO6AkBASQ9d6i+AjRnBFb7KN8AnnJE8X3fm0Pn3bI9bFKSzUl7+sD3uTiM9ytT9DQ1GSIbecX46wT/ZUbHAOIYdTSC/+RmB+PJ/TdEB/fGUDuTDApm6spuM=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:10 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:10 +0000
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
Subject: [PATCH 12/30] drm/bridge: sii902x: Use drm_bridge_init()
Thread-Topic: [PATCH 12/30] drm/bridge: sii902x: Use drm_bridge_init()
Thread-Index: AQHVpFurjxmagkJwXkOkEV0fENOC3Q==
Date:   Tue, 26 Nov 2019 13:16:10 +0000
Message-ID: <20191126131541.47393-13-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: df5327a8-6b00-4279-7a91-08d77272d575
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|AM0PR08MB5396:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5396B3991D9D2E2D53C139C88F450@AM0PR08MB5396.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: jSVly2z3FOwpX1PQwHDHlh7BImRa8ioUlO2lM54z6Qb65j8KmKtA1nW+ZyLfNT2SqInwBeAcoNC5nyONFh3ZXf2uh4y6L+xVRhepffRvwIDoycZH9Q3y8Mj1RAJAIweWU8PN2q8aR0D2ayqfVN7aGgCE6PRamGEEAcpE20VxJ4bcybGx3id6v4mUYWu1SOIm3U39SC3dEA0VQUMji/hnQcCLcOthiZHxIiSSt3D2gjSu1XO4wUtAfd2N2+JrEJgRQhO2NRGaARROJsHscM+PRb0ZU7OXfRxa5Y0iL1325Tw5NXfo8uLBrxDRlaWyq7GsTKszNTbse+gJqJRpMixQ9HoDYsADIsHlwwztoldjF/Mi+uUzZD0Vp8dAX25yaMYxYaIkDYo0aRqSd1taV3JU0ELtFTgKw1ANVond/yytedsC+/PapLT5LFv74KNQkxUV
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(26826003)(6486002)(50226002)(70586007)(47776003)(81156014)(8936002)(2906002)(81166006)(8746002)(4744005)(8676002)(25786009)(6506007)(36906005)(316002)(66066001)(5660300002)(76176011)(478600001)(70206006)(2351001)(386003)(76130400001)(54906003)(99286004)(186003)(26005)(14454004)(1076003)(356004)(106002)(22756006)(446003)(2616005)(11346002)(3846002)(86362001)(6512007)(6116002)(23756003)(6862004)(36756003)(5640700003)(4326008)(7736002)(2501003)(50466002)(336012)(305945005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5396;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d08bbc98-40b4-4de8-b207-08d77272cde8
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mTpAF9zN+7TvBxdS9f9B8Om9B5TLyx33J9ElOveM3o1AGFOxIZoksD3FRmX4WG1tSqXa07wAK4qvR5PZQhLT+KRWF+SQJBGAibgfFLEycf7XkhqR6PUhmTE+L7MAeFFEORBBSae1FMPNvw967DEsvF0YDF0g8CLqbd2HA8Ygu7xm0SXOH3V+TFfKXLC/QuYQ/L2ovXcStpnmsjxAH79PbHEBNwo/gk0tbVKnU9cojs21G3ZBx/saYPuKIsP36TkO/KQ8AzPXvmPSRs2UsWqJYmwXN3UBEuwRHJzrMtfOXVcpsOe9k0IAh8TDv///oH4MVZKSPLba9QFz/M+gvAfId7APbkMk2YKVCnlrycQCbk4pUA2D5sdCrVDrPEIdtISW8LJAslhZzRnbYlmgtKp0HofglOQ/iWgJJCTU2LDu6BcVcbjegObAPYoW8e3RZpl
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:22.8217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df5327a8-6b00-4279-7a91-08d77272d575
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5396
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii9=
02x.c
index b70e8c5cf2e1..2a9db621484d 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -1017,9 +1017,8 @@ static int sii902x_probe(struct i2c_client *client,
 			return ret;
 	}
=20
-	sii902x->bridge.funcs =3D &sii902x_bridge_funcs;
-	sii902x->bridge.of_node =3D dev->of_node;
-	sii902x->bridge.timings =3D &default_sii902x_timings;
+	drm_bridge_init(&sii902x->bridge, dev, &sii902x_bridge_funcs,
+			&default_sii902x_timings, NULL);
 	drm_bridge_add(&sii902x->bridge);
=20
 	sii902x_audio_codec_init(sii902x, dev);
--=20
2.23.0

