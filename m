Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F992C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418A62073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7mdGnpAb";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7mdGnpAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfKZNQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:35 -0500
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:64526
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727897AbfKZNQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MgqguEy0jasCHbpHxT7B0woU2qwbfZInWMJIuCHW7o=;
 b=7mdGnpAbAI9MuVi7PlT1ATzFNntIIl7eSuetpq+adU9L14NhWFX06ejRixfp+vlDd9sxYaFQ3/3XK6+VDq9bgydjfHwNgY877K0F0AhtatX9aEqh2HGYbAgFYpAIaDGQESdGPc3tL5G9N4wxwQDsAdwX+lni269cBJsUTNww7SY=
Received: from AM4PR08CA0063.eurprd08.prod.outlook.com (2603:10a6:205:2::34)
 by HE1PR0802MB2377.eurprd08.prod.outlook.com (2603:10a6:3:c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.22; Tue, 26 Nov
 2019 13:16:21 +0000
Received: from AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by AM4PR08CA0063.outlook.office365.com
 (2603:10a6:205:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:21 +0000
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
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:21 +0000
Received: ("Tessian outbound 712c40e503a7:v33"); Tue, 26 Nov 2019 13:16:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ff11807944074eea
X-CR-MTA-TID: 64aa7808
Received: from 1f05e3404f54.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C93E48AB-7CD8-460B-99B2-B8A7AA318EB5.1;
        Tue, 26 Nov 2019 13:16:14 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1f05e3404f54.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDhI7WIoxll0MHYZgVNDhNE7dKtyg1toiocS0iD+SmS2iRTRTiNZrasTG7n8pUGn8fIy23RPhqipEEUrGwFxidUr0Z+UbMg5Orz+r34ignruDMUbIJbTySOI4DLVxDVDQmd4+hPq3EW4dXlVUxOe35irvz7IV1/pmnfaO0CIoll9Zab5EbtgMLcgXSlZNfl+x/FqPb2/XfZuacg4xQgijLparghIbqca7wyn20EZYBtr7A+Fo1yGlABPiQjK9fwqbuZ7dRf09XsKFi01Ed2xKio4Pem6UvtQqZ+Ttx82h5zmzk2AEGSDpsAcXwfpTR8AyuGkfocGy6y2VzQ9WT7O+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MgqguEy0jasCHbpHxT7B0woU2qwbfZInWMJIuCHW7o=;
 b=PRpTEmu10eQZK2cak1H/kBuh5Cn7EyTNf249/CaPw5M2yjvnxnEgew4Azl/Wd0lm9FYAGXjeiE+PoNXUAU6r8rQzHST9xLZIYDZ12MAYrfRxVJmTnY2uuEmP/Gwxf3KBcq9r5lv3uMhgmCgKh2xa7xUc8wEepQMOXR/sGwDLL4//7wT97iNOAwo6bSfewbdR60cXSjd4k/S0AN38AUvwQHc2155x4U3VMbe0S3MuZPDwEt2Z6zLlJRa+J1vffxQ9mv3tsffRi6BzOHy2XCBmYZgZDr9NRaJxkxDQI7qrJrFIz8s0MX2y3jlZ+6CA4TWhnDYyjhgTUpcmSTrDxZsiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MgqguEy0jasCHbpHxT7B0woU2qwbfZInWMJIuCHW7o=;
 b=7mdGnpAbAI9MuVi7PlT1ATzFNntIIl7eSuetpq+adU9L14NhWFX06ejRixfp+vlDd9sxYaFQ3/3XK6+VDq9bgydjfHwNgY877K0F0AhtatX9aEqh2HGYbAgFYpAIaDGQESdGPc3tL5G9N4wxwQDsAdwX+lni269cBJsUTNww7SY=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:13 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:12 +0000
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
Subject: [PATCH 14/30] drm/bridge: sil_sii8620: Use drm_bridge_init()
Thread-Topic: [PATCH 14/30] drm/bridge: sil_sii8620: Use drm_bridge_init()
Thread-Index: AQHVpFusBDgtM9ENkEKxMg8CrEW9Uw==
Date:   Tue, 26 Nov 2019 13:16:12 +0000
Message-ID: <20191126131541.47393-15-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1c01471e-4a12-4781-f58a-08d77272d496
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|HE1PR0802MB2377:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB23772198279AFC0260C111908F450@HE1PR0802MB2377.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Kr4JQXa2ZFf9DeYAr8nInYzhyyuXXX7oIDuvdph6ywA7fQDwpd9elpi3td5z7TEeSI9MtbCgu/GtCYY9vwXdBd2UTEjEgLaFWyxSQT8JCKE3CVJY2fjtGs6UT/Ggl/CP9xHNUFe5qbo8j793pc1xLhjEx0lZWo7+AYk82KRX5VS11Ax0688NpGj8D+V5UjCJVhKqa+PoXxAz6Roo1VSCvZjNH3zCDaoow7cCWdEOJK6A+3VR5ar3KZIFAtssFXHD23dlBGECAMnfXIw8ubjsFDRLPHIQIJ/z83244Ff4bQrif1La2ICmsvtadAHsxedSl1yUIMt63EA6zyN0a/06t1W6YKP/QFP5vKUJSKbLJxIT9Nl61C4uxeqfp9V3YwlKeIz8dtraSPLfUkXpmE33/OA/Hq3EHT4do4m768UqtkrgZ6/xuXsgoZcLUNzWY+yb
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(199004)(189003)(386003)(7736002)(76176011)(99286004)(478600001)(26826003)(102836004)(186003)(2351001)(8936002)(54906003)(316002)(305945005)(6506007)(106002)(50226002)(8676002)(36906005)(2906002)(50466002)(25786009)(23756003)(5640700003)(70206006)(22756006)(81166006)(8746002)(70586007)(81156014)(76130400001)(47776003)(2501003)(14454004)(5660300002)(4326008)(3846002)(6116002)(66066001)(356004)(86362001)(336012)(36756003)(11346002)(6862004)(2616005)(26005)(1076003)(6512007)(446003)(4744005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2377;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 00fea5f2-bb0f-4bbe-413e-08d77272cf20
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YqQENTyQgmodcMbnXrum55SwyfwUrnXnv7+VFMbxIHOYCFkaJAn1P8+Q3hDWsuzFPvsto70qmUq3c+ALJzDjs7n4I4bzFTImnApetoC2VXIlWvT7B7FcDT4fJCTPeG4CRMRXvnIk+vKpcPqlcIX7YoVvn7vBpOGRcL9bBL/Sz9L6ewX7pYrNTZzDtrYk9kYq91J41AuP3bw0tOxV544ag8kK/jvi7jwZpsohLhB3KHI479/TCoQ/BDfqRbrVbbGxhrGpFB2nwxitIZ7COOogtcuMjRYzXTAEleLBK1+Ydzlvjb5akzDi5M8ZxtIC83GyNYgKTxH3599bgKf7AgjvphZfEu6ZbW7szWhRFMCErCcignPBnkh2tEPXPyDRz0FGvnCoXsza+dxg8Go6HouPtRG63mVYTu0pp6X6nLx4H4INjYWmCl4Yccxs89Yj2cFr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:21.3875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c01471e-4a12-4781-f58a-08d77272d496
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2377
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/=
sil-sii8620.c
index 4c0eef406eb1..482dc2291350 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2337,8 +2337,7 @@ static int sii8620_probe(struct i2c_client *client,
=20
 	i2c_set_clientdata(client, ctx);
=20
-	ctx->bridge.funcs =3D &sii8620_bridge_funcs;
-	ctx->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&ctx->bridge, dev, &sii8620_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&ctx->bridge);
=20
 	if (!ctx->extcon)
--=20
2.23.0

