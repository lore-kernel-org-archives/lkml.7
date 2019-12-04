Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C6AC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB91020659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gjkhBQkl";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gjkhBQkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfLDLtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:49:07 -0500
Received: from mail-eopbgr150085.outbound.protection.outlook.com ([40.107.15.85]:36582
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727883AbfLDLsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5WCE2P1/Ewa/uQFzzi0Jlc3+KKSsTwCAJn/FZJulyM=;
 b=gjkhBQklYpQsyBAjs90nPQ0PBQ7SL1KVIWblXPZI3eg+Uen+LQ8wqibrAYXklxVrwvEfVYX3XpLfQmgNNoUOJjCb9iT5ZsKwgEd3q9mW/BaQZhWvaD/pUImDfgMsWsIKGB0Zxkf2puFVwnXqzFapc81uA6nQgW0G1Irm9Ap6S3U=
Received: from VI1PR08CA0162.eurprd08.prod.outlook.com (2603:10a6:800:d1::16)
 by AM7PR08MB5320.eurprd08.prod.outlook.com (2603:10a6:20b:103::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Wed, 4 Dec
 2019 11:48:37 +0000
Received: from AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by VI1PR08CA0162.outlook.office365.com
 (2603:10a6:800:d1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:37 +0000
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
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:37 +0000
Received: ("Tessian outbound a8ced1463995:v37"); Wed, 04 Dec 2019 11:48:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e4efc0fee19f085a
X-CR-MTA-TID: 64aa7808
Received: from de4fd4e6043b.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F94B99F8-FAC5-4333-90A5-0E540A7D282A.1;
        Wed, 04 Dec 2019 11:48:28 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id de4fd4e6043b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R82Py72BOK4PRkvD6Mq3AHPqBEgffFNbDSQK81+H5/a+xpNLdwIvZNaIiTnSmh22fvuydZPY0ntgf/Ou1vc1DPXDCYlZbzocVhNESPKrAYmhQJ2Udn7DBvKkqlbhyjW95gywCNcWkzyJeIHYGwCQXJ6y1HhVSOOKN5r2dheEuaPPg5Qri2t702VQ5R7vAe3t9LdTclZTDqLBsCz9BRUWvr3hYPhSoTDla909MdstGEYG/CU4TxgG61AQr4LoQxj4ogTg2/QVR9bIS21VQVH+bFiIdr+ENnAynhaLCHGyKNHFzqVlZgy6CSIeVX/FWevNecA6q7C7EXupoxQGdMimxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5WCE2P1/Ewa/uQFzzi0Jlc3+KKSsTwCAJn/FZJulyM=;
 b=XWIut7RxFlPrYIXj7pSm1zvl0fcNDiaDpXw0j6XgancvaHp7tapPdHHh+mSpr+u2i6Ujs6CsdxKG7joaxPvbQLlDPi00gZxjXXEYKhREzbwUt0F14H9idz20KVDSpHCzM76l479PLv6XOP30Csm5ZHfkS27dfkaeElm0Q4qRBMoRWPbLvTQ8i4FF9M0oL6e87qVLFP1EVup1HbrL1dKhPDTaCl4OTTDW2M+PPMTS1y2M8f1KJdY/6NTRH8c8MMD1bo8Pxh2+GiOzo9Rd/ifGWZfOmEf4ELLdhloA28yerR76fYDFHbWgJIIAIrkT45TDoK7W0jIVVUncAr+5pcn/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5WCE2P1/Ewa/uQFzzi0Jlc3+KKSsTwCAJn/FZJulyM=;
 b=gjkhBQklYpQsyBAjs90nPQ0PBQ7SL1KVIWblXPZI3eg+Uen+LQ8wqibrAYXklxVrwvEfVYX3XpLfQmgNNoUOJjCb9iT5ZsKwgEd3q9mW/BaQZhWvaD/pUImDfgMsWsIKGB0Zxkf2puFVwnXqzFapc81uA6nQgW0G1Irm9Ap6S3U=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4624.eurprd08.prod.outlook.com (20.178.13.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Wed, 4 Dec 2019 11:48:25 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:25 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 27/28] drm/sti: Use drm_bridge_init()
Thread-Topic: [PATCH v2 27/28] drm/sti: Use drm_bridge_init()
Thread-Index: AQHVqpi89ZSI0/jtHUG0V0fAqzMiWA==
Date:   Wed, 4 Dec 2019 11:48:25 +0000
Message-ID: <20191204114732.28514-28-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: c704ff17-c680-42a5-4a9e-08d778afe676
X-MS-TrafficTypeDiagnostic: VI1PR08MB4624:|VI1PR08MB4624:|AM7PR08MB5320:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53201CCD8892BD68498AF8B78F5D0@AM7PR08MB5320.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1169;OLM:1169;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(2351001)(305945005)(316002)(6436002)(81166006)(7736002)(6916009)(4326008)(186003)(99286004)(6486002)(66446008)(5640700003)(66476007)(1076003)(66556008)(54906003)(2501003)(5660300002)(66946007)(64756008)(6512007)(86362001)(11346002)(2906002)(44832011)(2616005)(14454004)(50226002)(6506007)(36756003)(25786009)(5024004)(81156014)(8676002)(3846002)(71190400001)(52116002)(26005)(478600001)(71200400001)(8936002)(102836004)(6116002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4624;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: v233dY/6lxNaaPA0Yk15MvBwRrVKY2JKpR3dvlr0WV+6wh9755I4tMiFwOTEg+pBmuzZOdSFo9C0G2/KGNz6aKd89iccKGDW29jnb9nBN7jFcX6IrWjwx3ITkJUjBhg3ViTSXew42KdL+wZrCic2lRVaVRWnU43JBIfTqyV7Qd7ej2LU3JDhILocFW3kDO5lvNZP6ke7BvQcT8rvYWhj9FB8Dz4H04VPuSTBxE2CSI+NjOJf8FWiMgRd253KMajm8CckEHaasOrKxtZqGiWo8LySHWZ56PzX4QXhez0TF8v8RByHcGJ7bEjtYsRfRfx4L7KVPdfEccZW2BpMs9mxlj9OzMPeroKwhiwU/1hVZnbizncSeN6asdDL5Y7qposhEigAGDF3+hsvGMpa3HCGqz92oZ3s2PgFlXySxHmnyJl/WV7rJnw3DgokbqDBkl/b
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4624
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(186003)(1076003)(2501003)(50466002)(76130400001)(26826003)(6116002)(478600001)(6506007)(25786009)(26005)(102836004)(14454004)(2351001)(99286004)(4326008)(70586007)(50226002)(6862004)(70206006)(86362001)(54906003)(336012)(2616005)(8746002)(81156014)(81166006)(5660300002)(8676002)(8936002)(11346002)(305945005)(7736002)(6512007)(36756003)(6486002)(3846002)(316002)(36906005)(22756006)(5024004)(5640700003)(356004)(2906002)(23756003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5320;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c52ba38a-ccd5-49d0-5f49-08d778afdef1
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLMnZWMV+12z+zqGGxbaVbCJuI3KC22Kff8y3426NXsjTOfWGtQq73dzL5VYirlJZ0yA4KsG6HAIitFMkrjXBOBoZPGb9iGDijj5jabJ/XqTsJCd6B4nBB9+kfdQO7FaBN43zTTRpo4XnbMcX+j1gdZj6MiuX2FplI2lzuQjd3Bj+oTct5v1FtNef9qQ4K42zTIwym5YyO35Jv/mnphaKWkLRlAD6QKZWG/JKaNID40J4BpvFWgqFQHtAzTXjeeMTfHFuIyVOx7VOLzFfZvXaythBNNvOd4F/3WXZv+zT8srARRxQypSP8FPOgjlMNOB/v72ak2xsyKL8wXnwiGcSSASwXwbsMYLyAG8BQit3URGgmPv59mTjbjeF47qGTwOkc6MCkZb/j5V6HfNHz3/jMSB6lDKMDtrSIg7lcrmXtpCqIhXBQMYhnN9VtW6ZdEg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:37.6796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c704ff17-c680-42a5-4a9e-08d778afe676
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

v2:
 - Also apply drm_bridge_init() in sti_hdmi.c and sti_hda.c (Sam,
   Benjamin)

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/sti/sti_dvo.c  | 4 +---
 drivers/gpu/drm/sti/sti_hda.c  | 3 +--
 drivers/gpu/drm/sti/sti_hdmi.c | 3 +--
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index 68289b0b063a..20a3956b33bc 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -462,9 +462,7 @@ static int sti_dvo_bind(struct device *dev, struct devi=
ce *master, void *data)
 	if (!bridge)
 		return -ENOMEM;
=20
-	bridge->driver_private =3D dvo;
-	bridge->funcs =3D &sti_dvo_bridge_funcs;
-	bridge->of_node =3D dvo->dev.of_node;
+	drm_bridge_init(bridge, &dvo->dev, &sti_dvo_bridge_funcs, NULL, dvo);
 	drm_bridge_add(bridge);
=20
 	err =3D drm_bridge_attach(encoder, bridge, NULL);
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 8f7bf33815fd..c7296e354a34 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -699,8 +699,7 @@ static int sti_hda_bind(struct device *dev, struct devi=
ce *master, void *data)
 	if (!bridge)
 		return -ENOMEM;
=20
-	bridge->driver_private =3D hda;
-	bridge->funcs =3D &sti_hda_bridge_funcs;
+	drm_bridge_init(bridge, dev, &sti_hda_bridge_funcs, NULL, hda);
 	drm_bridge_attach(encoder, bridge, NULL);
=20
 	connector->encoder =3D encoder;
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.=
c
index 814560ead4e1..c9ae3e18fa5d 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1279,8 +1279,7 @@ static int sti_hdmi_bind(struct device *dev, struct d=
evice *master, void *data)
 	if (!bridge)
 		return -EINVAL;
=20
-	bridge->driver_private =3D hdmi;
-	bridge->funcs =3D &sti_hdmi_bridge_funcs;
+	drm_bridge_init(bridge, dev, &sti_hdmi_bridge_funcs, NULL, hdmi);
 	drm_bridge_attach(encoder, bridge, NULL);
=20
 	connector->encoder =3D encoder;
--=20
2.23.0

