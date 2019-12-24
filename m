Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3424C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C8C20730
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vrmpy9rj";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vrmpy9rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfLXRfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:35:00 -0500
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:46307
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727100AbfLXRey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4Fbeyxa4xk1mtIQf01xWGzMfySjhoIiCQk9dUa48Ak=;
 b=vrmpy9rjq7gbhax22znLTNWddQ1zQ9HtBGWtkFEr6oUzeB2BO9oyIVFD4hFv6gdatmKv0SZbw3zLkHsUCFy7X3oDgT8ZiyfG2W93eNGTlRT9f2Y10odB7Fp7cdqwtPSaM8NSGYhwmZMeP3zh5//4T8ecwAidyQWEIS52i7epeqg=
Received: from AM4PR08CA0064.eurprd08.prod.outlook.com (2603:10a6:205:2::35)
 by DB6PR0801MB1927.eurprd08.prod.outlook.com (2603:10a6:4:75::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.16; Tue, 24 Dec
 2019 17:34:49 +0000
Received: from AM5EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by AM4PR08CA0064.outlook.office365.com
 (2603:10a6:205:2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:49 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT017.mail.protection.outlook.com (10.152.16.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:49 +0000
Received: ("Tessian outbound 1da651c29646:v40"); Tue, 24 Dec 2019 17:34:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 666611e05d6633df
X-CR-MTA-TID: 64aa7808
Received: from bdd2edd0996c.6
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DEE49349-58AC-40D8-A225-A0875AD6EF92.1;
        Tue, 24 Dec 2019 17:34:44 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bdd2edd0996c.6
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rr3+mnWJIQVh1AtC5+PQqOMHZsEWbbsSe7J0+MUuTEDtEZET/LDmdAop/p689EQK6e13BkN7o6nu+egGKnHvJQMDSB+EeWLCJkFT9Hr9Wnn+IvRmJD0LIOCtecoDt9xhkyMeqSO0AqS//ksH6CwqshiuKX951LIs2CY99ixU13cge0MyRrgeH/cZr/uIcLfe7JITGUjA81TD/8dxFy68SBitARheL16dhp1cJlZTP7I9yzoJ5hTWdgvxWxQHOEyvgE+2PdkaYA0ZxFCDLbj9NaAhQG8zN5Khs+as1BxCn65hPmUbnbmLtzqzeJGiBPWUbFWfVqEusYRvy9B6eAab6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4Fbeyxa4xk1mtIQf01xWGzMfySjhoIiCQk9dUa48Ak=;
 b=GMYE6sDHUOXZAbJfmpiAerTRXGI+PlpO0jKcFmvGVViMZrEDOXftd6otnJ2es/mmPnnIqTiPXGVKnZwK/3jzLW8uQ+rgn93EjG7zZYg9EjP5AzSvY94PXkBrNt8LeLwfJMuXusVoFahbKOGRNHhKksoTjw2yoeOJD/Y7eu0Hcwgq4Cz1CtGzqkcMPrF7iJ11nMPSk3DJBuPzUvE5jKozUIm6P8D9fkLRRtw9au1WlaG0a8Al/lnjBtDHLUsGAAa+ZrJBkQtcGRCwfcyY+ciaHQiPNltAP/j9c80rSYZCF3Y50o6viWJ7yoy1awDrxboTsGpZhERQoIUcxm+1CGk5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4Fbeyxa4xk1mtIQf01xWGzMfySjhoIiCQk9dUa48Ak=;
 b=vrmpy9rjq7gbhax22znLTNWddQ1zQ9HtBGWtkFEr6oUzeB2BO9oyIVFD4hFv6gdatmKv0SZbw3zLkHsUCFy7X3oDgT8ZiyfG2W93eNGTlRT9f2Y10odB7Fp7cdqwtPSaM8NSGYhwmZMeP3zh5//4T8ecwAidyQWEIS52i7epeqg=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2672.eurprd08.prod.outlook.com (10.170.238.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 17:34:39 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:39 +0000
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
Subject: [PATCH v3 19/35] drm/bridge: sii902x: Use drm_bridge_init()
Thread-Topic: [PATCH v3 19/35] drm/bridge: sii902x: Use drm_bridge_init()
Thread-Index: AQHVuoBq8VaaLiR3k0KgAe5FATOv1w==
Date:   Tue, 24 Dec 2019 17:34:38 +0000
Message-ID: <20191224173408.25624-20-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: e794d8ba-16e8-4725-1cc6-08d7889793b6
X-MS-TrafficTypeDiagnostic: VI1PR08MB2672:|VI1PR08MB2672:|DB6PR0801MB1927:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1927F73F28FF3C95F29BE3068F290@DB6PR0801MB1927.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(26005)(52116002)(6506007)(6486002)(81166006)(6512007)(81156014)(8676002)(8936002)(44832011)(54906003)(478600001)(316002)(6916009)(2906002)(4326008)(2616005)(36756003)(1076003)(66446008)(64756008)(66556008)(66476007)(66946007)(4744005)(5660300002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2672;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fjANJfh4qqnsFszmQ/eoj61fWnRQEHJ/Hug+FzbvnvMy7+vTiU+Ih+KD9FdnKD7VxnH0FLz1YVJQxyJRrZBl5XloQydgAUhBzrZ5iE+Hyo+zxRGKCTzWLC/JuCTmgkx3Rl9OwSt5qmQrJlWhMrjO1XOM29JJ4UvkQ63gVhy9xezhhY2jlGtIKAHm45KZuL/VrF+nL1VXic6rCae5vSHQKHpzGyzsaGHUHpskEH/gx2RcaCv+jCBQ+DnON2d42xgjRSwpIucFZGoK1mJ89RsUMnKSfVmvKFNeGfFwamqrKGtpwXAjQWKzIMPA720FxUm0pZM3rpadY1gbh96kSAAy0NTv/ecQIgjf3yAq5RT/lFJBTQRwahsqU2LxL9x1OmW3CmZ0OkxbZL+uNMYVkyeM2tiqgm9kAfIHfjS+VRr8ae2kpv9J7f1Hz/oxpYkv0QQQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(70586007)(5660300002)(2906002)(76130400001)(4744005)(1076003)(54906003)(26826003)(107886003)(70206006)(6512007)(86362001)(316002)(8676002)(36756003)(6862004)(8936002)(6506007)(4326008)(478600001)(81166006)(81156014)(2616005)(6486002)(26005)(356004)(36906005)(186003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1927;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 537341a3-aca3-4a6d-5b9b-08d788978d27
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwi7kJkiwgZTuBS4vaVNSJ0uZsjGNLVTBDUxKcC7/VkmePd879FIhsCXHnrbsDpNU2Qq84xAQ8lLmSiK+aLLhg+eqeNdvqBQ6q6jkAY5jr32/8Z92yoBSg9q4zlNUhHEWj6KWwux44/46hAm+pvtlRow/JooDwadzZch7C/Q4fm9o/j8R/kMqACMD8IfuIGltotGYI9C32aSR1eszpAvNondoYuqfHSEo1AOdoqWCCBKXwwBISsM5gJUzI9a8xKlPAoMQkgNI09idhgIanVjRmenC3VPk4PnF1qz3VWRMuOmxEsL+09sO+yyDJH6nOFJwW80nj6psZAXH4J5f8o8qXge9uh379JMYm5p25HhoGiehIrtetxxHHc93D9BFJ352FWsoH1LUz2Nc3lv/wq+808LId3hFofpI7UP4S9zHBs22eeyFlRjFX5Joo2NMwW2
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:49.5218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e794d8ba-16e8-4725-1cc6-08d7889793b6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1927
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
 drivers/gpu/drm/bridge/sii902x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii9=
02x.c
index 6ca297d78a26..6f454e5ce258 100644
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
+			&default_sii902x_timings);
 	drm_bridge_add(&sii902x->bridge);
=20
 	sii902x_audio_codec_init(sii902x, dev);
--=20
2.24.0

