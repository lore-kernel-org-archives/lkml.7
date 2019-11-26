Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEAEC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DEE2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Wj+E4DSf";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Wj+E4DSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfKZNRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:17:35 -0500
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:28733
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728098AbfKZNQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FstHQUSWa3nWcMPJkk1fSwl0xp0aRPH3Sq6+Vw0/0xU=;
 b=Wj+E4DSfljJKCk7qirbLs7ur8hKal/LE7BR6I5ABSviiblU3wVqFetV2INg2hRza2Xbcjqiq8dmT5hOlbuc40G/83ATBBfHZfEo+ZO4Il0uzxYGrAxZVH8u8CN4cNF59qr3uBnb8XFG5vRCGSzbDwwye2QQdwSDhhLaR7r0ZHYs=
Received: from AM4PR08CA0071.eurprd08.prod.outlook.com (2603:10a6:205:2::42)
 by VI1PR08MB4159.eurprd08.prod.outlook.com (2603:10a6:803:e9::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Tue, 26 Nov
 2019 13:16:29 +0000
Received: from AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by AM4PR08CA0071.outlook.office365.com
 (2603:10a6:205:2::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:29 +0000
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
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:28 +0000
Received: ("Tessian outbound 712c40e503a7:v33"); Tue, 26 Nov 2019 13:16:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: afef6af7145bca95
X-CR-MTA-TID: 64aa7808
Received: from 7fdba39730e8.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D475C91D-1BFE-4EBD-97EB-D2EEE8015BD0.1;
        Tue, 26 Nov 2019 13:16:22 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7fdba39730e8.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMjRqQsxnvFHyUIfYPvHCiMwBeOOPnCbsK7xuKP2dRmofwGIKG8Wc+mR1IHRuzvJcVGeDtBq/SwRqLMrF5shzJ+8YWOpiNyFnxndsZLGQGcvgkQrfI6f72eTrjLv+Ga08bQuO5pxzLD3lRVe5OiLgorgUnQxo+0rRa6nI2jQW8YcUV34SWL+rnplizTi183zA72dezLmah4Vm6HVwL3gMt9w0QZu/hFbPNxvQpUBrRTqKnohsNk+nZQ996Sz63a2gxAdOSGl/AHV9kI+CNihCLebx/BZHsO4T6pRG4gVA9jsEHGmxIlJ8W96dM4Qg2a3gha3UEE5N4pci49HLtu6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FstHQUSWa3nWcMPJkk1fSwl0xp0aRPH3Sq6+Vw0/0xU=;
 b=CmYdyARFJG48Az7IPL3oEYk91giNNDkuB0+xbxQKlsilL4IKdD4YxoBGQ1SXxIpwfXvnPw91GmQnzWPOidHbaiDgJTIjhF4EXiVvCdKSQt9l0hH8/sfdU0qtAwyAbIVj3epZ7K3qZS21R536IWPZG+3YG2wfqvMgjw31dhuENbXS1FM16EcUZHq0OamZSSaFneakq4R4eLLdTZg3y5xrk5nOk2yOz+fjdXmbVSvo5InwN9HRiRYiRMnp/HoLqOq6GEK+labgjUKJvNyuR5kFYg9AD0dOpTet5ehFb39lyMOYp4qz5ZK5kz4DgBX7Zc2WtsH5oFk9wT21GnBDE+SZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FstHQUSWa3nWcMPJkk1fSwl0xp0aRPH3Sq6+Vw0/0xU=;
 b=Wj+E4DSfljJKCk7qirbLs7ur8hKal/LE7BR6I5ABSviiblU3wVqFetV2INg2hRza2Xbcjqiq8dmT5hOlbuc40G/83ATBBfHZfEo+ZO4Il0uzxYGrAxZVH8u8CN4cNF59qr3uBnb8XFG5vRCGSzbDwwye2QQdwSDhhLaR7r0ZHYs=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:20 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:20 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 22/30] drm/exynos: mic: Use drm_bridge_init()
Thread-Topic: [PATCH 22/30] drm/exynos: mic: Use drm_bridge_init()
Thread-Index: AQHVpFuxnqAfcuRdS0imEaOYObrpxQ==
Date:   Tue, 26 Nov 2019 13:16:20 +0000
Message-ID: <20191126131541.47393-23-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 43e2c64d-e434-41bb-f67b-08d77272d915
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|VI1PR08MB4159:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4159CC18D2691DB26E5B4E098F450@VI1PR08MB4159.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2582;OLM:2582;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(7416002)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LV0v24o+/W+UV97i/RxVlDyHyajK8JD8GdVMJo3TTiVnPUvIb+RB6Gx1qUwsuowhry+RlBTnSmNBV9XH9yE2VcLP3QB573KWHd1XDPMHsc4irb/EvAjdnHIQ83CprVdLgG68pUC1duYm36d1abp48PnVnoz5KfmfvOYcVMWGIcczzNHP8p71h+9r2g+m4dP/oohYrlXU2d2L3qVRHwX4RBIdiKPLb9iyIuw+Pq7+DIxqjQxvrIJdvLD8aQpyiZkTGrveXu/eD9XuDu1WSOlpLlhRgcFb3VGLd+NS5Dpc8FkUW6hR2BWA7cZECpNHkDcP7ugX3FRxnU2dD+Xuoc/lW4o2BMriQ++GUyQYWExYeIPpJLCRkWittDul8pb/WTylTyFlZnTJ+mOPX3wL3opcIXZeBMYVGPvEuMsGxYVv8rHS1zJMcjrUOuj8sIr/vzuz
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(76176011)(6116002)(3846002)(26005)(8676002)(81156014)(81166006)(36906005)(50226002)(186003)(54906003)(316002)(5660300002)(356004)(22756006)(6486002)(76130400001)(8936002)(8746002)(86362001)(106002)(99286004)(11346002)(102836004)(446003)(5640700003)(305945005)(6862004)(478600001)(2906002)(26826003)(2351001)(14454004)(2501003)(2616005)(386003)(336012)(6506007)(450100002)(23756003)(1076003)(70586007)(47776003)(70206006)(50466002)(36756003)(25786009)(6512007)(7736002)(4326008)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4159;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 63c1ecbc-9e8e-4606-70cd-08d77272d404
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hKBpmBF2vLDvMBajKZJjokvLGZ86y+x7EzcD1lTGaX+c7SmPHPr96JKDqGrEL7riqiJkUvEh3/fbMYSgRoLOaX+Qlvt9JL4rhxa5jAERdBEIgWCJ5aE84GwTyHu63wGbN+PtoRjHG5QtwBztXpeqNkrMaZ00BVlY33zVQzofj3PQp4oToFYPT+F8Wxm2gNZTqOU3uSPys114gvx9S13sAc1VtujsACa5RN8FLyXiBiWSF0pF1OYdHhxan+u0k43xJ5i+uLZMxzkI0Hpt6JjfOp03+nFx1JEQpNTKzU+LOwyAjG1gMOu4NGbKXIBUIzO4Xz2E99LT99i8yYg9wQd+Z6RAYJdkQPBwOIEADITfn6+LWUK2fsICO282FqAIb5ymKw7MHzcetaJ/vvszp9skg0xxdd9VmlDwr1rhRLxzd1Vpuq3tegHKc2N6ettFTvr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:28.9357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e2c64d-e434-41bb-f67b-08d77272d915
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change: no logic depends on driver_private being NULL, so
it's safe to set it earlier in exynos_mic_probe.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/exynos/exynos_drm_mic.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exyn=
os/exynos_drm_mic.c
index f41d75923557..caad348a5646 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -309,10 +309,6 @@ static const struct drm_bridge_funcs mic_bridge_funcs =
=3D {
 static int exynos_mic_bind(struct device *dev, struct device *master,
 			   void *data)
 {
-	struct exynos_mic *mic =3D dev_get_drvdata(dev);
-
-	mic->bridge.driver_private =3D mic;
-
 	return 0;
 }
=20
@@ -422,9 +418,7 @@ static int exynos_mic_probe(struct platform_device *pde=
v)
=20
 	platform_set_drvdata(pdev, mic);
=20
-	mic->bridge.funcs =3D &mic_bridge_funcs;
-	mic->bridge.of_node =3D dev->of_node;
-
+	drm_bridge_init(&mic->bridge, dev, &mic_bridge_funcs, NULL, mic);
 	drm_bridge_add(&mic->bridge);
=20
 	pm_runtime_enable(dev);
--=20
2.23.0

