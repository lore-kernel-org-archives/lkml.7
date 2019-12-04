Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9D8C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB3C2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xR+QFID3";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xR+QFID3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfLDLsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:54 -0500
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:56566
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727850AbfLDLsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ACjV4UGNCWLSq8MibzK+USLBibC30MfoACrBrreo6w=;
 b=xR+QFID3SCM0cWoVSBA4I6BSgRQe4GUbyQa6A9xzNf5AGk1LPbGN5SICdOjNOw7gV9QK6IrIAqJLA+pt+IV0G43bMlnnoFw/Ls4shNiZAGrTdFdiAvGYIdgeeThHr8wxrSH9zGRcl+62g6aphheK2DuP7GZqlRO9vpvUe6122Zc=
Received: from VI1PR08CA0172.eurprd08.prod.outlook.com (2603:10a6:800:d1::26)
 by DBBPR08MB4775.eurprd08.prod.outlook.com (2603:10a6:10:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Wed, 4 Dec
 2019 11:48:33 +0000
Received: from AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by VI1PR08CA0172.outlook.office365.com
 (2603:10a6:800:d1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:33 +0000
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
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:32 +0000
Received: ("Tessian outbound a8ced1463995:v37"); Wed, 04 Dec 2019 11:48:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f609738160676c2d
X-CR-MTA-TID: 64aa7808
Received: from b7ecf5d06a39.10
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C71C4CBE-4543-428D-8819-AC471F306DE4.1;
        Wed, 04 Dec 2019 11:48:22 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b7ecf5d06a39.10
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euiCuXMPMKennQ3P1HAOA0FsjcwQj4cWm9GsvGl0gRxXacXc1HJ6iXy2FZ+wQPnqj6tUZf4j2kNnkDmXrjHy1HU/PPGnfWIuvNkLbQuMgCrL8kd7qyKoMWRJK8s2Vn+o95gJIFwKoxsJIF1CkOrSDcfP0WiM7WBEnrLU1wyL1St6jcptuZrZwJXqlMpLmwNMekStMHqGVO8CKUIEmePUpozIDaB1asmqwr+lO8XgzVUVgfZQx+KfU2RKF6bpJt1T7xwYh6F9blMe0MMnds/Axka/K7Y33OBKWsYNMz99T6dl4Q7ubWWbDuV0QjOibpcbHv1W4h00rdmPPotr2LGTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ACjV4UGNCWLSq8MibzK+USLBibC30MfoACrBrreo6w=;
 b=dEgND/wqxuNRAeDNTOo08n4EjebnpPNWfpbUnBTEbHPhL+nLOzlZm3bJDtoOBsZYuMjaz2jN8g6++fYQz9mB2V0mNh4xgJtyt3+c913YuYtsTxkC9wEF6d72W46GQG6QMZb9xivjSmhcZgER7JMVYvpUu5r4qbWwvhkrNqSYALCTbrYMtr3jpFRtGTijF61vpzF2h9mEdg2kAckll4hI3cMO9BigVuNtIZ2Oppxs087xPGOpEdEVG+tG0UvP6Kod9wzN98XXAmckyXsdW1PVHd/FcmfD0G9DcsWiqFXcXQ3y5y1SEYLV4bLcI4vkz/No7MWhGlWj6VzdS9HYE4T8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ACjV4UGNCWLSq8MibzK+USLBibC30MfoACrBrreo6w=;
 b=xR+QFID3SCM0cWoVSBA4I6BSgRQe4GUbyQa6A9xzNf5AGk1LPbGN5SICdOjNOw7gV9QK6IrIAqJLA+pt+IV0G43bMlnnoFw/Ls4shNiZAGrTdFdiAvGYIdgeeThHr8wxrSH9zGRcl+62g6aphheK2DuP7GZqlRO9vpvUe6122Zc=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:20 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:20 +0000
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
Subject: [PATCH v2 21/28] drm/exynos: mic: Use drm_bridge_init()
Thread-Topic: [PATCH v2 21/28] drm/exynos: mic: Use drm_bridge_init()
Thread-Index: AQHVqpi5K8LO++NS4U2nSxfkhZ2Q5g==
Date:   Wed, 4 Dec 2019 11:48:20 +0000
Message-ID: <20191204114732.28514-22-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0c071c6f-c2a0-4534-dbd3-08d778afe392
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|DBBPR08MB4775:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB47757644F304E410A1E3B5508F5D0@DBBPR08MB4775.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2582;OLM:2582;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(7416002)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: swHtl3lM5DNGW+yfqJ+0LRrIcntQrPyU3gJ3lU2I87mob8849XNBHNH2F54qRwzlArTIpeHWMR6ipbFPAEyjQWL9+bmWEjtncItl2vSaWStTl8Rf7Z0/xV2LjOPoPs2MYKB23vGlFaMcvcubVqkVOtZEZk+/ieh7doUjkMDn34vPyWKrxS39+aRM2W0v1JrCBCn/hlbpaL/h9jEaO4TO9G9tUYiGS/UFr7rbxnlVEMVc5zkxFm0bce56LRJaRdeKz+dE7kBvREiNGEJWq/DSnloPlwrc1ZCd8Ukg1ItOYhCHwMxw7ExZWFkBsMlpyOnpHQnlhe4a7r10GAPA7Q9a5VNCXXeSG6eBfykeZjwFGfpceDqttlrm+bZrFfgRQ8Pq1G4A9ASRygyhTVuDZMpdFFiaAdEzI6sgEExcQvb7SqKV3AqI3S5ekAsUtysOH7r8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(189003)(199004)(5640700003)(54906003)(5660300002)(316002)(6862004)(22756006)(1076003)(356004)(6512007)(99286004)(36906005)(36756003)(305945005)(7736002)(26005)(50466002)(186003)(478600001)(26826003)(25786009)(2616005)(102836004)(336012)(76176011)(6116002)(70586007)(50226002)(6486002)(11346002)(23756003)(8676002)(3846002)(8936002)(76130400001)(2501003)(14454004)(6506007)(81156014)(8746002)(2351001)(450100002)(70206006)(81166006)(86362001)(4326008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4775;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3e801a01-9320-4c23-3ed5-08d778afdc2c
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QRyeX1IG/VZoHk446WD0yQWXLcspHka34I5wSKiKIjE5yUPyzK0k/l8BzYQz482IoTjcEzptst3viKDHq9AHsIy8hEMm8C1dRIawILtpqUleOAg/YdjJ5+Ki0NuZ3rFOEUyz7fEV35dM4KmdgGeosN4KupVFhzoRwZ/NNflrqKL+TjUcLLfnOydOtVZbR9bC6xu0bEyg4vGylnxwXzsU66MEPYVgTzSpHDEloX1zvUO5U6/5iW/8oYp67GJGU2XSHtErMEXxrX5dU55EuoHtNlwFxe57tVgDAhGBW8C/UBTFoagt2fdTi7UUobUn2FjnxHO10K3zlse4syF6JjphvO2BOFkVHR58VYaYDJh1uFN6bBf+lenUnF1r7eqqzbLgQ7UZDr8xYrFDo5OUEbOCjOPJOBlD6A3/uM0Y2lZ7o14WQavWwYG6rYSGPA4JbWw
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:32.6885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c071c6f-c2a0-4534-dbd3-08d778afe392
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4775
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change: no logic depends on driver_private being NULL, so
it's safe to set it earlier in exynos_mic_probe.

Acked-by: Inki Dae <inki.dae@samsung.com>
Tested-by: Inki Dae <inki.dae@samsung.com>
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

