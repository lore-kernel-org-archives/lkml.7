Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D37C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FFA20730
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XuSO4xBG";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XuSO4xBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfLXRfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:35:31 -0500
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:15021
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727140AbfLXRe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v53aWVHznm28DhdSWj+bbqsUrhZa7rN2Ijd6RKwk5wA=;
 b=XuSO4xBGDbB7LXEb+vrTezudWEmTrE944SQnaANZ5i+2gYCuyZWfda9D1CXrUvowLs+kHsc5tTMOCF/RpsTn4WZIfzXCA+4DxtyKGr+4Lx/r/cda6douNHIub6yE0w9rFynu8IJTJukA9sO/ftF7S0J2fNIQ6Hsw3K4dpzp9aQc=
Received: from VI1PR0801CA0074.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::18) by AM7PR08MB5368.eurprd08.prod.outlook.com
 (2603:10a6:20b:103::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Tue, 24 Dec
 2019 17:34:52 +0000
Received: from AM5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by VI1PR0801CA0074.outlook.office365.com
 (2603:10a6:800:7d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:52 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT003.mail.protection.outlook.com (10.152.16.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:52 +0000
Received: ("Tessian outbound 0eaff1016ea4:v40"); Tue, 24 Dec 2019 17:34:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cd98a4721141abbb
X-CR-MTA-TID: 64aa7808
Received: from c54502d9e00b.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A07D49C1-6E2D-48BB-B09A-0F904EB7F8AE.1;
        Tue, 24 Dec 2019 17:34:47 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c54502d9e00b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjxlcvDZYL1YzIgrdxpjtdDaeYpApFWpaPcpp3NIh6w+K75Jsun0RaZljro1mAIc0DGrXjfZhez3nGuAFAUqvydIRb2+2OHwLhDN6vvL/Rg9NLTH1nxIfqjPautnWqprooEJRycWOUYAZb8LZHiOV7EfxLGa3wzkXQwbqB18N1O06eBkmicB3ZEjgS8dUKSbSi+zeGoN9pENB2FiUcsA64RIqHXuL/QOVE/c8L6yeXFzMo6wzm9MDbP/saLIlq6LHgCVcVsw4jLsSf1tjngF6SS1VKGNJiK6XWuCTceYa0XfwZIKuGm5f9l0POVVAa6LNU6Kmz5cOhmP9kCUraIjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v53aWVHznm28DhdSWj+bbqsUrhZa7rN2Ijd6RKwk5wA=;
 b=K/GQnUL1M/R/sGTR9Wcltu/BVLY/TO4XWH89MGi7KZ/0qGF3sDw1rkvAVt8kcSlD/6/LVXaIclCfxRi91FZ8d1h4vy3Uz27hXxTiDGpnV3jt+RiyKMM9x910/RRqStX98HdoOKPijcXeQCCdg3+ymckr0ORK9nWCZhmNiG/uIRgRq9riHzxKXipyu/TaVPy+56BLfBt2nZdfj9JJcSke/glVVEAEs92qSs7QRV9nfp4A8UJgAwbyVU3tSXQlLjlv0xepHLwoTxqSx7rJSUwb9ly85XE/wzKIVNHrEw9w7+mN8UhZmykZk+nRPzhcKAa+1lAq19xxsyWTSO9D2V0MFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v53aWVHznm28DhdSWj+bbqsUrhZa7rN2Ijd6RKwk5wA=;
 b=XuSO4xBGDbB7LXEb+vrTezudWEmTrE944SQnaANZ5i+2gYCuyZWfda9D1CXrUvowLs+kHsc5tTMOCF/RpsTn4WZIfzXCA+4DxtyKGr+4Lx/r/cda6douNHIub6yE0w9rFynu8IJTJukA9sO/ftF7S0J2fNIQ6Hsw3K4dpzp9aQc=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2672.eurprd08.prod.outlook.com (10.170.238.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 17:34:40 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:40 +0000
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
Subject: [PATCH v3 21/35] drm/bridge: sil_sii8620: Use drm_bridge_init()
Thread-Topic: [PATCH v3 21/35] drm/bridge: sil_sii8620: Use drm_bridge_init()
Thread-Index: AQHVuoBrYwqF9kghjkGVCqsPYsD34w==
Date:   Tue, 24 Dec 2019 17:34:40 +0000
Message-ID: <20191224173408.25624-22-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 40630890-8bd2-4f60-e10a-08d788979588
X-MS-TrafficTypeDiagnostic: VI1PR08MB2672:|VI1PR08MB2672:|AM7PR08MB5368:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5368E9EA4D7F4B46EB92DF5F8F290@AM7PR08MB5368.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(26005)(52116002)(6506007)(6486002)(81166006)(6512007)(81156014)(8676002)(8936002)(44832011)(54906003)(478600001)(316002)(6916009)(2906002)(4326008)(2616005)(36756003)(1076003)(66446008)(64756008)(66556008)(66476007)(66946007)(4744005)(5660300002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2672;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: eAvmc8C9AZsVS3I+UtFGtCDfgePTkdGv8pCYTz1MTYRuzhVsdHvNFiNc675kT1AtRDCrEcVNeM9yGIkj5u5oBTLQmf4g9aTVptN6goZ2qKNVMUst4vnHMN0qLQ0Bi4CqmiBwo8j263wRU0VoLohaYATGoBupjGALQCjGpoakoo//sQsPZQW5AdfSvFLzqhtWuOZYYE0Owp59H0qIqNMe3ovmOyCdk+YviItu+ZkXy1ZTYAKF+XS+v1cXaEZyELb4kb1Pn6Q6OAz09WyyAPFT8x0XLQCQZNjIgqrii0FkIigI/dGvNvqEnIdNpSjHRuh35faWFhYvx4+e2ScAKqb0A6kO3aUypC+7ng2+5rhdbO14JZ9uOjdmT9Qce1A6INadPeA9P97NuJoxvrPqaa0sDeq1c9aVBlKItNWHPYSTzP4dhi9MTB0X7QcsEfS+gQXc
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(199004)(189003)(1076003)(2906002)(36906005)(6862004)(107886003)(4326008)(54906003)(356004)(5660300002)(4744005)(26005)(6506007)(316002)(186003)(336012)(26826003)(2616005)(6486002)(8676002)(478600001)(86362001)(6512007)(81166006)(36756003)(81156014)(8936002)(70586007)(76130400001)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5368;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: dbb96bda-812b-4402-67ce-08d788978e30
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZBFu+ktPkYh/LodDHOAbCGxhbJ65E1rhDwAvFJvCOL1+bK0AWU7SrM4V32RDAsp/23mQ3B5DELRwpQYhHhyCfuRoMIa9Dgbxxs+WrcxOQlhFb+4BLCLBAxcecf40OwFAStRpF4+ZVISuNKUwyesdJRbSB1SYu6KPiEZcuGsbSKX+AeMEgSR1m0CUeJXTe/z+wrPh59k+awdDxx6igEVKj0+v1EBvKJlXGqBT1FqB2lxnbKiQ+Mg3O9XemGIMIZn+5mOjGXjKaJotaGuIbSm2FYnlittmQm+D4citSLamPSYTCfTtTZEzXVGJuVHBffKUf7t02ruy4XJFEy08vDiXZQMDz9Nqv/FKrc2bppi0SxiMTlxeEinvsQSYn4j55a86xk2czwxLzGQhyuJsfAyaY/k/XQjKhd5NpFFQ5Zm0UvleV/8Inwx+8NAZ6ym9YGN
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:52.5859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40630890-8bd2-4f60-e10a-08d788979588
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5368
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
 drivers/gpu/drm/bridge/sil-sii8620.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/=
sil-sii8620.c
index 4c0eef406eb1..d67f9a844647 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2337,8 +2337,7 @@ static int sii8620_probe(struct i2c_client *client,
=20
 	i2c_set_clientdata(client, ctx);
=20
-	ctx->bridge.funcs =3D &sii8620_bridge_funcs;
-	ctx->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&ctx->bridge, dev, &sii8620_bridge_funcs, NULL);
 	drm_bridge_add(&ctx->bridge);
=20
 	if (!ctx->extcon)
--=20
2.24.0

