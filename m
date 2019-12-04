Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ACEC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B462120659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JDz3HQWP";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JDz3HQWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfLDLsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:30 -0500
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:50592
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727784AbfLDLsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=528OVsPgmledT3KzwsU137Xb39xXYhXTngkZrmxaBXM=;
 b=JDz3HQWPwH+NjMGBH2yYBGHDiHQOOZfQs1cQ13uOd2EPRsx293z8LA9C/+6zgmA20OIQ0+28eaJnnaw0AcrJ37/Hibgz4NwU7XmgLk6Rv0rp7HsMIf+Ag+bEDAMP+yEftwNgulU+PU4fCtDpFfIUSEzEddUkLBnzBoePIlzLd5g=
Received: from VI1PR08CA0114.eurprd08.prod.outlook.com (2603:10a6:800:d4::16)
 by AM0PR08MB5107.eurprd08.prod.outlook.com (2603:10a6:208:155::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.21; Wed, 4 Dec
 2019 11:48:20 +0000
Received: from DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR08CA0114.outlook.office365.com
 (2603:10a6:800:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:20 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT046.mail.protection.outlook.com (10.152.21.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:20 +0000
Received: ("Tessian outbound 15590139dbb5:v37"); Wed, 04 Dec 2019 11:48:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a342c5dfa3edf21e
X-CR-MTA-TID: 64aa7808
Received: from a83b0422c187.6
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7D87E0BE-5A85-463A-8541-C3256AAA9683.1;
        Wed, 04 Dec 2019 11:48:10 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a83b0422c187.6
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5MggrRW2E/HAmB0VwVERjZZyhEJWHwQqDN5ozzvU/VSE7CbiSgP6ms2Vc5cPAeiE4dyYeJtPgPNUQjh69WVX+LJmi4TJ7xLZoXFiThUaPRyMdDytkXBJzHEaXDiKT7DPlxRFHfSk9FB1Ji7U6BNm3jXUC73SileqO1qMEKQX5H1Rb76OWDVdit+5Q6ipq07GVxCcIMlZHWL68ucVNvPnhojqXfjlkzA3ehIzDggkyWqAhxDdp+gk+yMk9rnd3yWD+HzWeuyjgIckWqwrECgvkmWrpQRpX36HJDn0cUUVo1YRXETURsL1XJXqWHUojvEYjQJIPCX0qea+unLWnSqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=528OVsPgmledT3KzwsU137Xb39xXYhXTngkZrmxaBXM=;
 b=gxBeW+3E1xf7wgfmiuT142BMvsU3Vq0i3iGiJ9hLgX6zXurAhnO6jAFxeWHZFFVdAmNcaFPZxRrLr/FqtD7tQQ6b4F32EgMeeAieUbJ8O4KKRmys5nxHzK5X7p1pd54l6dIcfie8E7gnaZmExfgqW1IkmFLRUGTNRo9r9Qb1gFtwkMXSTZpRhM3XxfxL097WRFfOVVcX8oDgZUNyv7sxZFdVRVER7e+xrDebj4RVtSj4Yoch7FFuQwgbDb8otcA5fSD0yIlWkAcKWIQ5ONu/TtZnBUek1pfbxjhHgrOSFlFXs7OYo3bfWK4q3/AdvJGoMfBPEA+13J3qNlgtVgTgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=528OVsPgmledT3KzwsU137Xb39xXYhXTngkZrmxaBXM=;
 b=JDz3HQWPwH+NjMGBH2yYBGHDiHQOOZfQs1cQ13uOd2EPRsx293z8LA9C/+6zgmA20OIQ0+28eaJnnaw0AcrJ37/Hibgz4NwU7XmgLk6Rv0rp7HsMIf+Ag+bEDAMP+yEftwNgulU+PU4fCtDpFfIUSEzEddUkLBnzBoePIlzLd5g=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:08 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:08 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/28] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Use
 drm_bridge_init()
Thread-Topic: [PATCH v2 07/28] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw:
 Use drm_bridge_init()
Thread-Index: AQHVqpiymrXEMj6obkmjm7/En3p3CA==
Date:   Wed, 4 Dec 2019 11:48:08 +0000
Message-ID: <20191204114732.28514-8-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 630bcfdb-29a6-4886-ae4c-08d778afdc3d
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|AM0PR08MB5107:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB510786BD29EB843C08E5CD2A8F5D0@AM0PR08MB5107.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(7416002)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(14444005)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MKdSEqua5txfkgGZXQHs3C/HeGq0rfWVoEDU7HSDz4KJdhsLrEgBREJIvY6EuDqbMGS56ok1PYCTd399k+QCOjlCgXo+hl6PZQQgkUrQsSIPluEjo8Jg/pRt48S3yTEzb84XCO/L8rUHqjLZmlh3IZ6IleqZfyIVk0vS2tPeGHxcxJ0zdjMI18XQDGwYysgYKDS8x7H5/4ShSbLAAaTL7IGrHpbMomFOF2iv0WKsqM8OC4DtXhPWjykllyJUtgMaetmeDFuTgjVTRSVytDlK/UHufkbtox8Eslf4h/wTcRbyOmm03hPYVA8BHjIAIb2PzlS+XVkLi7hZTvLcOV9MlPPDnJ2IJPoRpEazlljV+mTOhGqELAc0aZsadsCgg35cek6oz5FVaWBQptfyPvd2UL72L3sEMuZaISjN1ey3DxazrrA9iTiofhkbXYVWGwn8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(76176011)(99286004)(26826003)(2906002)(478600001)(50466002)(76130400001)(2501003)(14444005)(54906003)(102836004)(2616005)(6506007)(3846002)(11346002)(2351001)(26005)(70586007)(6512007)(186003)(70206006)(336012)(7736002)(6116002)(22756006)(50226002)(6486002)(14454004)(316002)(81156014)(8676002)(81166006)(6862004)(23756003)(305945005)(1076003)(4326008)(8746002)(8936002)(5660300002)(36756003)(356004)(4744005)(25786009)(86362001)(5640700003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5107;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e0c94f08-2ef8-41aa-905b-08d778afd4c7
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9xRjoTqj2rUxv2jCEgxzEt2u4bg1/SsHFAh4cg+vXcLAZjqxWeBaeNGht3oqswLh1iBwUN2NyQ8I0g7+UrR5Rif2WL2O08JR9gT7zLAov61cW2EuY6AOobieGkzLvmLiFFF/yVozSOUpNmEBM3rBDMrjJkpSOxCH5JZT7z/48qe3hPbAxOBjA1hwZ4DG5CqquErTXVmJWRo/kZIKGt9BWwJCo2uqe8RFsCCOuyLweD4/3Q/On+wMP8o7hVYv7KEK0XionmqnsZI8ZqFTPCN6jrDkFFX8uuJItQUO76lTdZLcjq0klNzF1ITNOlGVAFeZWxxzQPyMut+OFKc0XiSQL+vUXV5djz6LGM2W3due15jWT+StJzN34+vi/NOJctriJoRUDl4lrQTxOfD9ydVcf8BmoLvKc4GmvoKNAfCmKQvIlUfmNncMue+xNqAs3I2
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:20.5283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 630bcfdb-29a6-4886-ae4c-08d778afdc3d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/dri=
vers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index e8a49f6146c6..d567cd63810f 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -303,8 +303,8 @@ static int stdp4028_ge_b850v3_fw_probe(struct i2c_clien=
t *stdp4028_i2c,
 	i2c_set_clientdata(stdp4028_i2c, ge_b850v3_lvds_ptr);
=20
 	/* drm bridge initialization */
-	ge_b850v3_lvds_ptr->bridge.funcs =3D &ge_b850v3_lvds_funcs;
-	ge_b850v3_lvds_ptr->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&ge_b850v3_lvds_ptr->bridge, dev, &ge_b850v3_lvds_funcs,
+			NULL, NULL);
 	drm_bridge_add(&ge_b850v3_lvds_ptr->bridge);
=20
 	/* Clear pending interrupts since power up. */
--=20
2.23.0

