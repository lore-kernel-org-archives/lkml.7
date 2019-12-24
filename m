Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE8DC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908622073B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="usmtWERA";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="usmtWERA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfLXRfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:35:14 -0500
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:54302
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727100AbfLXRfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxRYpe23n7dy7b4xNr+17/rCdHeDZtT2aEL2+bftShU=;
 b=usmtWERAFD61jhkY/vAg1uNWIEkDrelRPx4MG8sENRUIAppI/occBfDw0wffBCk3E8a9hMEeYDenkIpm7ctFtlauTId/0fwyIfLLi5kaUEgfs97yObJNSNvNY5nAQP09ZZqHMxnsX2L+cy+1XAva64DArLgSWHSj0SEmH737DjY=
Received: from DB6PR0801CA0059.eurprd08.prod.outlook.com (2603:10a6:4:2b::27)
 by HE1PR0802MB2314.eurprd08.prod.outlook.com (2603:10a6:3:c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.17; Tue, 24 Dec
 2019 17:34:58 +0000
Received: from AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by DB6PR0801CA0059.outlook.office365.com
 (2603:10a6:4:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:58 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT047.mail.protection.outlook.com (10.152.16.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:58 +0000
Received: ("Tessian outbound e09e55c05044:v40"); Tue, 24 Dec 2019 17:34:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d8019d59f46ddbe8
X-CR-MTA-TID: 64aa7808
Received: from c54502d9e00b.9
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9D08A116-2684-4791-ABAA-9C480227C20D.1;
        Tue, 24 Dec 2019 17:34:52 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c54502d9e00b.9
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrHn3wQ6M0bvffvQ5b5c6bynU0qVBFqBvkgn6O/QcuPKtjV2SnCrgY4rMtzGdgwh72ol/Oovwa8RCKJtpUgeYxtNcO2o+Z0vqtQZ7jvkqKR9wYITZ977L7rJ+doIS2cycEDEduEstBP62dfPtR5VxZGxGMf+h0xJsgrwJMox4v0CFAaFZFYhiW37epApZCUN/drUR+Fxl/qB/v2CvpGeWzs2BHY77WgHTzxQ+gDANnKOoKGrLunr6VeE/XxJ2HQGDqSBDG/FplL3T306RG5QpCE+ohm5sw2ZHg+8H7nvXGGj455sVeCid4CDhD/k5utfEC9dJSVmXlYDZwIMuoGBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxRYpe23n7dy7b4xNr+17/rCdHeDZtT2aEL2+bftShU=;
 b=cCPjC8pusJvRQ1JthGSdhnsbwenkeSoX83lPenmSYqklEBo4sIbBrCtw5i9DfNQBkOfHqQw/wxifeRHMVOSi6oQaJt+h87r1nOXE9YL2sJbQbCUm3tVI0W15aBIiXP9YCwZ/PAVtxz4B4E5p/XRDcu+h5ksRysMlB2dPeiEatkxbSe3wV73U9uyJ5kQal3eT6nG5ChdhuKF69hekTiquFYBRefGMTgsgjJU++7C6Eog+8cG9e8lG8MeEp22PiFNnkfXTnQ3BfbF5jpc9Yie1S5AkuS5eJ0ceNahH4Fppdz9RKNOJGWbRpBUJj76AKOjxFpquEWa9GTNmHh6ZEqUbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxRYpe23n7dy7b4xNr+17/rCdHeDZtT2aEL2+bftShU=;
 b=usmtWERAFD61jhkY/vAg1uNWIEkDrelRPx4MG8sENRUIAppI/occBfDw0wffBCk3E8a9hMEeYDenkIpm7ctFtlauTId/0fwyIfLLi5kaUEgfs97yObJNSNvNY5nAQP09ZZqHMxnsX2L+cy+1XAva64DArLgSWHSj0SEmH737DjY=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2672.eurprd08.prod.outlook.com (10.170.238.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 17:34:46 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:46 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 28/35] drm/bridge: ti-tfp410: Use drm_bridge_init()
Thread-Topic: [PATCH v3 28/35] drm/bridge: ti-tfp410: Use drm_bridge_init()
Thread-Index: AQHVuoBvobAi1dyG3ka8Omo6Vc03LQ==
Date:   Tue, 24 Dec 2019 17:34:46 +0000
Message-ID: <20191224173408.25624-29-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 394fe784-e355-4e7f-ac26-08d7889798c9
X-MS-TrafficTypeDiagnostic: VI1PR08MB2672:|VI1PR08MB2672:|HE1PR0802MB2314:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2314D5D4BE64B9E7C418B55B8F290@HE1PR0802MB2314.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(26005)(52116002)(6506007)(6486002)(81166006)(6512007)(81156014)(8676002)(8936002)(44832011)(54906003)(478600001)(316002)(6916009)(2906002)(4326008)(2616005)(36756003)(1076003)(66446008)(64756008)(66556008)(66476007)(66946007)(4744005)(5660300002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2672;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4psd9pZKHwp92gt0NScfDJAWbQ6MmDKL0W7wryD1wKv2ji+jSVYfr+1sHGFJK5/IS3HU8gO1c7hkR5rvkE0W83m26/vQU27nB74hztp0bxmQaDXJJBid91eEj+QRvKuxx0BeOYKhMB/UhbI97HJ06NVzS4jr/EhubkeRbiD/M6bxl3P+NrlaBOG0xQ12DHZ8QMLTD2urgSy2U6UWkUbhuMblkaRMYB+vIZFeR8Ld7PknU5bqkC+6WFCAtu6ZuqeDOWJJkuW+wdOJsWnrn33oWgyA+fQzXZln0ZoYQzMLVMIcnMtVRiSsWmTyfaEPUs8WO9H81Ygnow0D1hR3TiMtSrxL4Zca6F1sQqMsSKj7nG4m2Y1c9p2HmZmBpVJ/txiZ/EHEm/a/JEzQ4h0l/RP5fWvcP+p3357Ipd0GC/WefNn8bvdHBI/ZW8o6xsO5DHSx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(189003)(199004)(8676002)(81156014)(81166006)(8936002)(2906002)(4326008)(6512007)(6486002)(6862004)(76130400001)(107886003)(70206006)(54906003)(70586007)(356004)(316002)(36906005)(26826003)(4744005)(36756003)(26005)(5660300002)(478600001)(336012)(6506007)(2616005)(86362001)(186003)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2314;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 560f428a-ad90-4358-e966-08d7889791ad
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+CFVYOwF3u6yyAzfSzHDZUjq9CiWAyM32C2Hg8WJ7bihBFduLu0Z/UQl+8vWhpt5UK9oOySWp6r8N6WdYiXAki7le3nD01OQJU0O+eLffZRu15jZY7RiNkLbRIFTLwgd2qurQlCpXFGhjmp42sH+/2Hj48yMc00Vdt1vH7u+FSldJNKNvbwfWr4YNAnvT0nYHxu99odopG1JvA7JpMfA4HqV1iZPdJ6UuYvITpmMPvt2Qd+22jYDSTMUw9KyU5xFrUimCeY5th8G79lKwbfR8YlOCPyS7alMThTd1uTVHUFoFIxDYfPhw2AnuaOQhcRqkdwD91L2S4hZAbNPNfTjQKv8BVQOz40o8w0g+LGbAyrxs4qoLraXCTKve2DA2J+xHh/OFTqpzVdQeohVQXF62kfPaglDAxZMyqcFV1Z354sOoMKHNPh1igN1rKACF0t
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:58.0436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 394fe784-e355-4e7f-ac26-08d7889798c9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2314
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

v3:
 - drop driver_private argument (Laurent)

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti=
-tfp410.c
index 76229367e2f4..6371530943a1 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -328,9 +328,7 @@ static int tfp410_init(struct device *dev, bool i2c)
 		return -ENOMEM;
 	dev_set_drvdata(dev, dvi);
=20
-	dvi->bridge.funcs =3D &tfp410_bridge_funcs;
-	dvi->bridge.of_node =3D dev->of_node;
-	dvi->bridge.timings =3D &dvi->timings;
+	drm_bridge_init(&dvi->bridge, dev, &tfp410_bridge_funcs, &dvi->timings);
 	dvi->dev =3D dev;
=20
 	ret =3D tfp410_parse_timings(dvi, i2c);
--=20
2.24.0

