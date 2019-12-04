Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB615C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853F920661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8waFNdZl";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8waFNdZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfLDLtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:49:51 -0500
Received: from mail-eopbgr00066.outbound.protection.outlook.com ([40.107.0.66]:60523
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727789AbfLDLsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKX2QEoiMcI48kOVP6yPNKCVpbRPSGyLW7NiFE2+cdA=;
 b=8waFNdZlu5B7rSyhtJoawQEVA+7W+8VQaPdrKX0vIBMhy57U+ZCvU1HZR+rJXU5onDq3IgnpVHDJRigqog/q3E82R48FEHzPucmRsp7Bm8IIgw7EhJjXh2E+pYDA+AKBUOHxXoUPqULrxTNuvlQCjnx1TafjsSTzDGrfCu46NdM=
Received: from VI1PR08CA0271.eurprd08.prod.outlook.com (2603:10a6:803:dc::44)
 by VI1PR0801MB2063.eurprd08.prod.outlook.com (2603:10a6:800:8c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18; Wed, 4 Dec
 2019 11:48:21 +0000
Received: from DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VI1PR08CA0271.outlook.office365.com
 (2603:10a6:803:dc::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:21 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT059.mail.protection.outlook.com (10.152.21.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:21 +0000
Received: ("Tessian outbound d55de055a19b:v37"); Wed, 04 Dec 2019 11:48:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5650f19524fa2463
X-CR-MTA-TID: 64aa7808
Received: from a83b0422c187.10
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EF83EFD7-450A-4D9A-924A-75C692893502.1;
        Wed, 04 Dec 2019 11:48:11 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a83b0422c187.10
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEfaWgHCCcjs2b6hm3SHyoTteuuye8fF5TYcc0GTm0qabvibFU/pU93XH4HOss2ZR43ddepnoXnj2d0XdVPa1zPZMYi5vInLKBYdYPcDohFuZcLI8PT1FUoV1gSAhbG8D2qFsTJw0B4ArQwbA2JNx6qy0GIM8SybkPu3JHMV/y/1aspUq/u6G3/BvcCaCbWbyEJ5l/4geKNOhsZLDTbNffKxJVisqN5NDCfi6XYje338m/ZmkIm1Fl2ZgBrBzusn6qf/xTKPAIDV4rwLrszm0+7D9JziSPZAaMWW6STCoZ+QzGxycVlNOl9SVwFH850ajv6kTuso2Ybo2DTpq4KnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKX2QEoiMcI48kOVP6yPNKCVpbRPSGyLW7NiFE2+cdA=;
 b=aCo57wA707PenYc5hwFoCCAUgIODSKRf6Tgvp9Jo8rZmI4IH8zFp6ZGu6YsHyIozQuZ3a31SCs8E9O6L/wrMazIJkJrN/o7aKMqU4HxH7wDjgP1H4Xmnp/eIivJLca5Z7on2j6pQNK9qxVRbV0uWAyPjan9yuwSQMz27hhLMsCUYxMHrLznP8cm/TSsFRjNph3BLW+aLsZgT1UgQM27MPBS9D1JZtYkOiEHnnMM/PszF6Ky13/Q2MiCde0ZgGA4iZ2Mkst6YBuYOuHkOimCC6MtlxJNDQCAvPpXd6T80IenlZXiRX5iAX05Q2sRv1owig7oyxtFuww+U4EB6PjmhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKX2QEoiMcI48kOVP6yPNKCVpbRPSGyLW7NiFE2+cdA=;
 b=8waFNdZlu5B7rSyhtJoawQEVA+7W+8VQaPdrKX0vIBMhy57U+ZCvU1HZR+rJXU5onDq3IgnpVHDJRigqog/q3E82R48FEHzPucmRsp7Bm8IIgw7EhJjXh2E+pYDA+AKBUOHxXoUPqULrxTNuvlQCjnx1TafjsSTzDGrfCu46NdM=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:10 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:10 +0000
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
Subject: [PATCH v2 09/28] drm/bridge: panel: Use drm_bridge_init()
Thread-Topic: [PATCH v2 09/28] drm/bridge: panel: Use drm_bridge_init()
Thread-Index: AQHVqpizLmyi9uuCLEufX5SpMevoGw==
Date:   Wed, 4 Dec 2019 11:48:10 +0000
Message-ID: <20191204114732.28514-10-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: faf0bd70-7dd9-44c9-d709-08d778afdc87
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|VI1PR0801MB2063:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB206379A2C31D317A606649958F5D0@VI1PR0801MB2063.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:176;OLM:176;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: O4EEZbtDM4zoQx3SSpZjXEJwGiDU5/SV48sxyj4/tEJ5Cm1+41yPtR9I8l2s0jggcYDbr2OL+FLra2bQP5Wj0RPklmRkd08/SdM1JIxsuTCwgoJIzWABw+1Sel0TBHyONEls57xmnMvr1UUy/RzLvji6B9I2W58XQEilpzV6KaiJ6WCOXBdeRes4z2hZlwoB+3uVo9ipcUQ+ZIEzhgiNWNVxhfKDgnBdv8OVyiPA5il6GfjWgtwlhtJXxSzfS+4qg3WZWKMu56DOfcVH//AKizPOcIJgcdIP4cKYsWgsUArMDCpQuiogmi6304uohMm2jcYVqMkIlqLlbq1kRCWg2abCp24Ym0zCdp4JKYCtA6HsxaN810XT/zrajQathrc/2P6A6dIpQbB70CmM02wLdWM6qQd6bP3bzVNn+g6rfMNxpcfU/Zx0f4YM6DwRu1N6
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(189003)(199004)(4744005)(99286004)(14454004)(26005)(5660300002)(50226002)(6512007)(356004)(86362001)(23756003)(336012)(6486002)(76130400001)(50466002)(22756006)(1076003)(478600001)(70586007)(70206006)(5640700003)(2501003)(8676002)(305945005)(2351001)(25786009)(2906002)(36756003)(54906003)(316002)(4326008)(6506007)(186003)(81166006)(6862004)(11346002)(8936002)(2616005)(81156014)(76176011)(6116002)(102836004)(3846002)(7736002)(26826003)(8746002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB2063;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4f489c83-9237-4450-74f9-08d778afd5d0
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckjTtvgOXw9DmFMmq8tAazSFxIdCtXYrzGsnr2nvQ7RrBwsdmQZAodkOx9eJf11t/UGZrz6xUqWi7loIaZHHttoeJvjjFnlWm5U+h20h1J7BrbPrZobXOxKvgNAb6wjsRURFa3QqClXhEg3WB/Q0s7EPGHYu2wzPd2hHv3NWOoKkIjaBTxvi6IekLcKHXgkghHXJG0qfpzf4eH5MvDsgoXAQTi6RwqYbnwDICPUaTKAeuPr0FC4CShrBoI6UAme7E0tyNAg0QlYlfxGbD4OI0fJIogpsbUy/tx+9Pixsta7rwdS2DCUDQglhd/XKLML7aYFOL16eYO9R2FP4PAbuzOv1ATyTkkik9FD+M4vAObKMQPbtXM0gU78sN9JjhaM+2836U83qPEfSQ0fDa6OU3tZ5KCpUoxDs3/42m8evRU5OHI5tbMFp65z3zZkg26vQ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:21.0056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf0bd70-7dd9-44c9-d709-08d778afdc87
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/panel.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.=
c
index f4e293e7cf64..91d68d0337cc 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -192,11 +192,8 @@ struct drm_bridge *drm_panel_bridge_add_typed(struct d=
rm_panel *panel,
 	panel_bridge->connector_type =3D connector_type;
 	panel_bridge->panel =3D panel;
=20
-	panel_bridge->bridge.funcs =3D &panel_bridge_bridge_funcs;
-#ifdef CONFIG_OF
-	panel_bridge->bridge.of_node =3D panel->dev->of_node;
-#endif
-
+	drm_bridge_init(&panel_bridge->bridge, panel->dev,
+			&panel_bridge_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&panel_bridge->bridge);
=20
 	return &panel_bridge->bridge;
--=20
2.23.0

