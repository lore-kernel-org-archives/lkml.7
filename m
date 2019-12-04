Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EE7C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4D020659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="R2WcMyjp";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="R2WcMyjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfLDLsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:52 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:1284
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727848AbfLDLsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vilsu5jMSNUi3GIXJ8OzL1XJBLxVssM7Swc8d5oAicw=;
 b=R2WcMyjpHFGGnIO9nOrQqTlLV10FDsMiYelxwwCkZYdcBveiyJmwEHrXOSi6EcGu7NlsIdN4GRRK0xe5EHVYxrLEyMg34/ZuIhQE5PGyiEwnRdUknMuosxu+z06gDU1V+X3Cl6sp5aVjzDEhJTKMdwvyCWYiBWWo5yBN/MxzdmE=
Received: from VI1PR0801CA0080.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::24) by AM6PR08MB5271.eurprd08.prod.outlook.com
 (2603:10a6:20b:ef::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.21; Wed, 4 Dec
 2019 11:48:32 +0000
Received: from AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by VI1PR0801CA0080.outlook.office365.com
 (2603:10a6:800:7d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:32 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT025.mail.protection.outlook.com (10.152.16.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:32 +0000
Received: ("Tessian outbound 691822eda51f:v37"); Wed, 04 Dec 2019 11:48:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e66cdd9bd9eea70f
X-CR-MTA-TID: 64aa7808
Received: from cee6bfb0cd5a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 777A467F-22C9-4DD3-BBE5-9F6B3BC039EE.1;
        Wed, 04 Dec 2019 11:48:16 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cee6bfb0cd5a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ffq7qRuoNNe85BzJrfbPOhggkt58RN8Xz/8fEwKHpR/d70NV5U9ruC5rK0HzKov5OjbSsYOW39z9YJyhJj3O8Kzld7+MhlCUW8mwX7pO+nCnzjlDpPa5PjZDxMgPVYbjpwd2h9HZZ8NrxV0CqW7l78WXy36tvfGV5IDbkeDPQiF2NoMJN8VinMveDqzvkp9nmafswXVRdb4TvADDCTJz/OA2yY4UdLVUyeHgyppre4tUjuagDwcahkjviA1KuTdJa6OId5S0zhSUfG5c+lrItqp2J3QOrmEWy/7MPOJ72HZcWhxlaiAATIDWtSkAogHrMdIaIEO63k8RQTwTro0BuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vilsu5jMSNUi3GIXJ8OzL1XJBLxVssM7Swc8d5oAicw=;
 b=H2vkkwa8s24Ngq3TT7KzaKLeIR4NTJrmCsGyCtRL4ZG82dXfnNUwZGttn1hGIq4EE/YxWYbRaN1GzOMqa0ItfoU1ijbFVxQKpo1i1aJK+V3xysO+q56rcd3katfsCplHRi+sSD4ushvtUE6/Uzaa1aM0vc6OGypnulxi618IJD6jJvTvgB0FCj2PkEH4ssFGa8asUpw1KMseP7bIN11dCijeaTPzOm/vvykb1B2aWDy/D0DFLozJuIsAwOiUCurt39uwQiJuk5bq5gB5ubROgII3ppo8Gn6PBe4V+vpXmWnGVFt95ch4zrv3cUZ6uX8HkJe1b2Fx3cjakit9320/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vilsu5jMSNUi3GIXJ8OzL1XJBLxVssM7Swc8d5oAicw=;
 b=R2WcMyjpHFGGnIO9nOrQqTlLV10FDsMiYelxwwCkZYdcBveiyJmwEHrXOSi6EcGu7NlsIdN4GRRK0xe5EHVYxrLEyMg34/ZuIhQE5PGyiEwnRdUknMuosxu+z06gDU1V+X3Cl6sp5aVjzDEhJTKMdwvyCWYiBWWo5yBN/MxzdmE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:14 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:14 +0000
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
        Sam Ravnborg <sam@ravnborg.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Douglas Anderson <dianders@chromium.org>,
        Dariusz Marcinkiewicz <darekm@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 14/28] drm/bridge/synopsys: dw-hdmi: Use drm_bridge_init()
Thread-Topic: [PATCH v2 14/28] drm/bridge/synopsys: dw-hdmi: Use
 drm_bridge_init()
Thread-Index: AQHVqpi2+tPFYpee1UK43mAvBMAzdw==
Date:   Wed, 4 Dec 2019 11:48:14 +0000
Message-ID: <20191204114732.28514-15-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 80bc652b-ee0f-440e-1dea-08d778afe33d
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|AM6PR08MB5271:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5271C9B36F050922CA5320BE8F5D0@AM6PR08MB5271.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:176;OLM:176;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(7416002)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 7X9raZhesPa4vWBmDbtMBjSmS+9S3y9DHMxpfVm7gcDnS60H40AFGKeD5l5okTTCZOnn3rz7hSINbTyXUvTTT8Eml3Fz7EfVLdhAh/Ml71840msXhGiC6PlIq8+t0BiiJzMw+CF+HZNIHAtI14Ow4n1kHI9E63oMrW6G6GIHtiaKeScfVQdi/JJc4b3LD4OqoGnRZEEpIpyplVcnFeAqhQgkrqvFjat9IHZwruV7plo7iDbPq3Pfmf/2XlbhRRiGkTxdFRuz43fcU+UufIXkSe/4YRG23nzOB9V2t5LychQDRbE/MyPT+4Dlobf3xTXD+p5pK6vysU8j7Wm5/5lBkvLNyOC8kQdUTr3ycN5EbIh8scplG1d51dcNoNmJTz25ZzxxjghO4b434IgNMl92zbR4pFrtkNu7LGiURfItDEjJxDh1GXh7xXC9njhJxb2f
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(5640700003)(2501003)(36906005)(2906002)(26826003)(86362001)(6486002)(3846002)(316002)(6116002)(54906003)(4326008)(22756006)(478600001)(7736002)(305945005)(14454004)(6512007)(2351001)(50466002)(11346002)(70206006)(70586007)(99286004)(76176011)(36756003)(50226002)(76130400001)(2616005)(336012)(6862004)(102836004)(25786009)(23756003)(8936002)(1076003)(81156014)(8676002)(8746002)(5660300002)(6506007)(186003)(4744005)(81166006)(26005)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5271;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2fa7aed1-e5fa-4da5-86a3-08d778afd870
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uibvfmMU9zxM97CXmfhtBZBTzHaHjBLiZx0DuHnK8NVSgetUi0668mkZrtorSSOzh6qcZr8jD1XhWTc658DwyIOYrIX6oiX77vPvHlavaQL9WJbgfzkrJnVAhIwRoodLFImZDoli/FPgrDtRHx72DohnCsgSzd2XpvAjTVFi9gzWUmH920d7jjFKUF7nCoOU3c8CR/GMFWX1UHBvkn4iXS5OVLVxov34wsvWUmCidtKQBB7Vh0szVkdr3q4iqBOhJMzXYRccSCmBd2SJ3x0NAXy/yu7OYSzz3uPoDZkeHh2Tlz2U5cDq/wp1y0PE3VZ0CGIgUUwIGYx2EHdPXHBWbLchK4vR615idZcJxK5/fOViuCkOLWzlDPWOa0YWEEMiMvzehyuAJteMj3iuint38nyAd818yCFgQTnEEQaY5lOypQ4Y1tvX08K5t1Sa9axa
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:32.2477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bc652b-ee0f-440e-1dea-08d778afe33d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/br=
idge/synopsys/dw-hdmi.c
index dbe38a54870b..6c71ffc9df5a 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2898,11 +2898,8 @@ __dw_hdmi_probe(struct platform_device *pdev,
 			hdmi->ddc =3D NULL;
 	}
=20
-	hdmi->bridge.driver_private =3D hdmi;
-	hdmi->bridge.funcs =3D &dw_hdmi_bridge_funcs;
-#ifdef CONFIG_OF
-	hdmi->bridge.of_node =3D pdev->dev.of_node;
-#endif
+	drm_bridge_init(&hdmi->bridge, &pdev->dev, &dw_hdmi_bridge_funcs,
+			NULL, hdmi);
=20
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.parent =3D dev;
--=20
2.23.0

