Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC921C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9281E21D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9JZlXfB7";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9JZlXfB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389176AbfJDOfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:35:06 -0400
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:52494
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389161AbfJDOfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc4lele6dIwjU4c6a3L+IzKflQgRbWkIRbEL8ZX6qzA=;
 b=9JZlXfB7LJbzJvQaa8xLU84rrHTSOS+STRcYPB6o/20ReacSF/2J9dGyUPKqye51F4M7fm+s8QhYnCZLLfH+KXAMU2Y+wbzJ+ukTwXFN7YaV91axFg1dII+8fOObkG25lxnU7ccrnQz/AuDETBwFrqbtDkS+JTmk6WzN81llQy4=
Received: from VI1PR08CA0272.eurprd08.prod.outlook.com (2603:10a6:803:dc::45)
 by AM0PR08MB5153.eurprd08.prod.outlook.com (2603:10a6:208:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17; Fri, 4 Oct
 2019 14:34:54 +0000
Received: from AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by VI1PR08CA0272.outlook.office365.com
 (2603:10a6:803:dc::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20 via Frontend
 Transport; Fri, 4 Oct 2019 14:34:54 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT014.mail.protection.outlook.com (10.152.16.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 4 Oct 2019 14:34:53 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Fri, 04 Oct 2019 14:34:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7d279d107cd0a66c
X-CR-MTA-TID: 64aa7808
Received: from f3d1354be0af.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B1CC4576-DB53-4375-8097-66DA055768B4.1;
        Fri, 04 Oct 2019 14:34:39 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2055.outbound.protection.outlook.com [104.47.4.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f3d1354be0af.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 04 Oct 2019 14:34:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLEk20M19ajPf8Eb5spizCSEPkGKxxgB/VTC9OjWNZ7y/xubWyfyd7QKoJuXAfRGumU1YscWq0qUFBu8fmTqEgdCRzZag2dp6pYSXHkD1H7CyPW2dyUgse3bIa1Ei67YkE3gNAsEX6lfc+cmpNAF0GnAutcp67os0tQ82uLkSW+cT8wgZX7TaOfMChYynNw9trw+PSF7jNDwoo+/+LtVV0CHGGsOcDaxbkuW0xuk+F62oPo7UiBp/bzLIB09Sk77aUjffuJtMcFTIu8TEpR3QXitkWgCM1eh7Lwjx6OwCRShOPZoJu+EOXZ5fqJBhkZEuHH4asOkcxq5G/9UPD+3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc4lele6dIwjU4c6a3L+IzKflQgRbWkIRbEL8ZX6qzA=;
 b=O3jKOZS75GTyBRYqgZLMR1Q3/Ju63+m6/8JC88N0RkK0UIsiHcLXlyaKAFYFHOgmMUInqDLSXwtquGHxqq/JDzdJ2g9AKL64TSXCEX9B7imR+CefrJK1dmXaiKdtGtnAKzn8IrMT3YBrKpbk00yMTMAP3ZoZrR0McAxK05NYJMMSgufn9OW2cLo9z5KOf1CvevU7jrsW9REt3y/A+sauXUTasZa05VW2oLk7A8QbGMI3ijTrFP6efnpI8XLet1d4p1LBa5OPA7bxEDHpchebaQvsh+MONovPWz99dnaASoWTzAtQNOjfDuHDf4t7Ivxs4+O00UajnQWL1lfUYKZ6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc4lele6dIwjU4c6a3L+IzKflQgRbWkIRbEL8ZX6qzA=;
 b=9JZlXfB7LJbzJvQaa8xLU84rrHTSOS+STRcYPB6o/20ReacSF/2J9dGyUPKqye51F4M7fm+s8QhYnCZLLfH+KXAMU2Y+wbzJ+ukTwXFN7YaV91axFg1dII+8fOObkG25lxnU7ccrnQz/AuDETBwFrqbtDkS+JTmk6WzN81llQy4=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4288.eurprd08.prod.outlook.com (20.179.25.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 14:34:37 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 14:34:37 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] drm/komeda: Consolidate struct komeda_drv allocations
Thread-Topic: [PATCH 1/3] drm/komeda: Consolidate struct komeda_drv
 allocations
Thread-Index: AQHVesDZif8RFMaQBUOH/Gc/fEStZw==
Date:   Fri, 4 Oct 2019 14:34:37 +0000
Message-ID: <20191004143418.53039-2-mihail.atanassov@arm.com>
References: <20191004143418.53039-1-mihail.atanassov@arm.com>
In-Reply-To: <20191004143418.53039-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LNXP265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::13) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d97fa052-b3db-41d1-b6fd-08d748d80565
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB4288:|VI1PR08MB4288:|AM0PR08MB5153:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB515331D3CBFF4F88392C3B4E8F9E0@AM0PR08MB5153.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:185;OLM:185;
x-forefront-prvs: 018093A9B5
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(199004)(189003)(1076003)(66066001)(14454004)(66556008)(102836004)(2906002)(5660300002)(478600001)(36756003)(76176011)(26005)(50226002)(3846002)(2501003)(6116002)(11346002)(66446008)(386003)(186003)(64756008)(6506007)(66476007)(8936002)(66946007)(5024004)(14444005)(2616005)(4326008)(256004)(44832011)(81166006)(6512007)(99286004)(486006)(6436002)(5640700003)(8676002)(6486002)(86362001)(25786009)(71190400001)(476003)(6916009)(7736002)(305945005)(71200400001)(446003)(2351001)(54906003)(316002)(52116002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4288;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5+c4P3D84usX9SQ0peKaoAbt8WogtBHW2uWJjQV10LzLibcmru/8t1xY0Zy6N60TEka3TtEZiVadgFR4/gHw0WVdrMC3CS0vY52FLz/g+gZxz+es2dy3qjn/wAx5iKIhj4IKT/1VHXcZL6CaRZCGYT+1gVes2KQPgfzStzC++JdwwoRNb60UMPZbm63U4vku7R4Uz3iKxGibSjmRp6I8J2u5/2Y9fzXSi5Iyr4OLUVnovghKVRLZN/HQaSx2iSqp1fXEFy1qqgJT/arehcvOHN+p5bpoYGbjCER8hRk+tGNQK0WduR+T4ML6rcB6YCuOvb0E7ZjFn5W7OYr7CA5YmW8CXVO/YzY42Rcb6V3VCkJcc3zNlaB+jwTcJ2F+gKtxoDCBZAPDMGM4X2a9wSqaVbKR2REnzZrKVm9NaDvM4Xg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4288
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(356004)(6486002)(186003)(336012)(6506007)(8936002)(66066001)(8746002)(305945005)(316002)(76130400001)(50226002)(7736002)(2616005)(126002)(4326008)(3846002)(6116002)(386003)(26826003)(36906005)(54906003)(476003)(478600001)(2501003)(99286004)(23756003)(50466002)(25786009)(47776003)(11346002)(76176011)(6862004)(86362001)(36756003)(63350400001)(2906002)(8676002)(2351001)(22756006)(5640700003)(70586007)(5660300002)(14444005)(5024004)(446003)(1076003)(486006)(14454004)(81166006)(102836004)(70206006)(6512007)(26005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5153;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: bde6a659-115a-4591-14f4-08d748d7fb71
NoDisclaimer: True
X-Forefront-PRVS: 018093A9B5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBQJu3tAct/YVpda6kNXp+Ut4aAYid1yOFRSZdPRc5SUj+LLc0WbdGgv56g40hKzGp7Kv4Z8NSk/eCFfRLMSIdwMW7cCo3lWoTZy1TOAQCH3hEDxFCO1bCQna+AotyqxFI6FA0rl56caooBrbORjWJrQj1IBe5jG7dKmtuePgLaA9AHh15x3FPOs2ZKAvt8ZrxI6DcsTqHfixp4bZHZnth+dSVipM7ueLkzrVvndhwzfAzbYYCnW9+YGQuKRGmUGVvoKTKWUFDsPIa55pbaCAofWaELEB0QfOdl1u2U+0epRww3rZjgj9R0OjYSm8enrD4OSFNcJmIjXkdaLxN8vBy/ElsdPrQG4HTjgMb6tMiVYhGCG8geUvNcp97uHzWGP41UWQ+OQoreyjsxYdYp0wOgzXyAgKhol1BaCogHj7Xg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2019 14:34:53.6041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d97fa052-b3db-41d1-b6fd-08d748d80565
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct komeda_drv has two pointer members only, and both
it and its members get allocated separately. Since both
members' types are in scope, there's not a lot to gain by
keeping the indirection around.

To avoid double-free issues, provide a barebones ->release()
hook for the driver.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 21 ++++-------
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  4 +--
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 36 +++++++++----------
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 26 ++++++++------
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  4 +--
 5 files changed, 42 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 937a6d4c4865..c84f978cacc3 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -179,28 +179,23 @@ static int komeda_parse_dt(struct device *dev, struct=
 komeda_dev *mdev)
 	return ret;
 }
=20
-struct komeda_dev *komeda_dev_create(struct device *dev)
+int komeda_dev_init(struct komeda_dev *mdev, struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
 	const struct komeda_product_data *product;
-	struct komeda_dev *mdev;
 	struct resource *io_res;
 	int err =3D 0;
=20
 	product =3D of_device_get_match_data(dev);
 	if (!product)
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
=20
 	io_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!io_res) {
 		DRM_ERROR("No registers defined.\n");
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 	}
=20
-	mdev =3D devm_kzalloc(dev, sizeof(*mdev), GFP_KERNEL);
-	if (!mdev)
-		return ERR_PTR(-ENOMEM);
-
 	mutex_init(&mdev->lock);
=20
 	mdev->dev =3D dev;
@@ -284,16 +279,16 @@ struct komeda_dev *komeda_dev_create(struct device *d=
ev)
 	komeda_debugfs_init(mdev);
 #endif
=20
-	return mdev;
+	return 0;
=20
 disable_clk:
 	clk_disable_unprepare(mdev->aclk);
 err_cleanup:
-	komeda_dev_destroy(mdev);
-	return ERR_PTR(err);
+	komeda_dev_fini(mdev);
+	return err;
 }
=20
-void komeda_dev_destroy(struct komeda_dev *mdev)
+void komeda_dev_fini(struct komeda_dev *mdev)
 {
 	struct device *dev =3D mdev->dev;
 	const struct komeda_dev_funcs *funcs =3D mdev->funcs;
@@ -335,8 +330,6 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
 		devm_clk_put(dev, mdev->aclk);
 		mdev->aclk =3D NULL;
 	}
-
-	devm_kfree(dev, mdev);
 }
=20
 int komeda_dev_resume(struct komeda_dev *mdev)
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 414200233b64..e392b8ffc372 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -213,8 +213,8 @@ komeda_product_match(struct komeda_dev *mdev, u32 targe=
t)
 const struct komeda_dev_funcs *
 d71_identify(u32 __iomem *reg, struct komeda_chip_info *chip);
=20
-struct komeda_dev *komeda_dev_create(struct device *dev);
-void komeda_dev_destroy(struct komeda_dev *mdev);
+int komeda_dev_init(struct komeda_dev *mdev, struct device *dev);
+void komeda_dev_fini(struct komeda_dev *mdev);
=20
 struct komeda_dev *dev_to_mdev(struct device *dev);
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index d6c2222c5d33..660181bdc008 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -14,15 +14,15 @@
 #include "komeda_kms.h"
=20
 struct komeda_drv {
-	struct komeda_dev *mdev;
-	struct komeda_kms_dev *kms;
+	struct komeda_dev mdev;
+	struct komeda_kms_dev kms;
 };
=20
 struct komeda_dev *dev_to_mdev(struct device *dev)
 {
 	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
=20
-	return mdrv ? mdrv->mdev : NULL;
+	return mdrv ? &mdrv->mdev : NULL;
 }
=20
 static void komeda_unbind(struct device *dev)
@@ -32,8 +32,8 @@ static void komeda_unbind(struct device *dev)
 	if (!mdrv)
 		return;
=20
-	komeda_kms_detach(mdrv->kms);
-	komeda_dev_destroy(mdrv->mdev);
+	komeda_kms_fini(mdrv->kms);
+	komeda_dev_fini(mdrv->mdev);
=20
 	dev_set_drvdata(dev, NULL);
 	devm_kfree(dev, mdrv);
@@ -48,24 +48,20 @@ static int komeda_bind(struct device *dev)
 	if (!mdrv)
 		return -ENOMEM;
=20
-	mdrv->mdev =3D komeda_dev_create(dev);
-	if (IS_ERR(mdrv->mdev)) {
-		err =3D PTR_ERR(mdrv->mdev);
+	err =3D komeda_dev_init(&mdrv->mdev, dev);
+	if (err)
 		goto free_mdrv;
-	}
=20
-	mdrv->kms =3D komeda_kms_attach(mdrv->mdev);
-	if (IS_ERR(mdrv->kms)) {
-		err =3D PTR_ERR(mdrv->kms);
-		goto destroy_mdev;
-	}
+	err =3D komeda_kms_init(&mdrv->kms, &mdrv->mdev);
+	if (err)
+		goto fini_mdev;
=20
 	dev_set_drvdata(dev, mdrv);
=20
 	return 0;
=20
-destroy_mdev:
-	komeda_dev_destroy(mdrv->mdev);
+fini_mdev:
+	komeda_dev_fini(&mdrv->mdev);
=20
 free_mdrv:
 	devm_kfree(dev, mdrv);
@@ -140,12 +136,12 @@ MODULE_DEVICE_TABLE(of, komeda_of_match);
 static int __maybe_unused komeda_pm_suspend(struct device *dev)
 {
 	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
-	struct drm_device *drm =3D &mdrv->kms->base;
+	struct drm_device *drm =3D &mdrv->kms.base;
 	int res;
=20
 	res =3D drm_mode_config_helper_suspend(drm);
=20
-	komeda_dev_suspend(mdrv->mdev);
+	komeda_dev_suspend(&mdrv->mdev);
=20
 	return res;
 }
@@ -153,9 +149,9 @@ static int __maybe_unused komeda_pm_suspend(struct devi=
ce *dev)
 static int __maybe_unused komeda_pm_resume(struct device *dev)
 {
 	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
-	struct drm_device *drm =3D &mdrv->kms->base;
+	struct drm_device *drm =3D &mdrv->kms.base;
=20
-	komeda_dev_resume(mdrv->mdev);
+	komeda_dev_resume(&mdrv->mdev);
=20
 	return drm_mode_config_helper_resume(drm);
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index d49772de93e0..03dcf1d7688f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -23,6 +23,15 @@
=20
 DEFINE_DRM_GEM_CMA_FOPS(komeda_cma_fops);
=20
+static void komeda_kms_release(struct drm_device *dev)
+{
+	drm_dev_fini(dev);
+	/*
+	 * No need to kfree(dev) since we're stored in an aggregate struct
+	 * that's managed separately.
+	 */
+}
+
 static int komeda_gem_cma_dumb_create(struct drm_file *file,
 				      struct drm_device *dev,
 				      struct drm_mode_create_dumb *args)
@@ -60,6 +69,7 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *=
data)
 static struct drm_driver komeda_kms_driver =3D {
 	.driver_features =3D DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.lastclose			=3D drm_fb_helper_lastclose,
+	.release			=3D komeda_kms_release,
 	.gem_free_object_unlocked	=3D drm_gem_cma_free_object,
 	.gem_vm_ops			=3D &drm_gem_cma_vm_ops,
 	.dumb_create			=3D komeda_gem_cma_dumb_create,
@@ -257,19 +267,15 @@ static void komeda_kms_mode_config_init(struct komeda=
_kms_dev *kms,
 	config->helper_private =3D &komeda_mode_config_helpers;
 }
=20
-struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
+int komeda_kms_init(struct komeda_kms_dev *kms, struct komeda_dev *mdev)
 {
-	struct komeda_kms_dev *kms =3D kzalloc(sizeof(*kms), GFP_KERNEL);
 	struct drm_device *drm;
 	int err;
=20
-	if (!kms)
-		return ERR_PTR(-ENOMEM);
-
 	drm =3D &kms->base;
 	err =3D drm_dev_init(drm, &komeda_kms_driver, mdev->dev);
 	if (err)
-		goto free_kms;
+		return err;
=20
 	drm->dev_private =3D mdev;
=20
@@ -319,7 +325,7 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_=
dev *mdev)
 	if (err)
 		goto free_interrupts;
=20
-	return kms;
+	return 0;
=20
 free_interrupts:
 	drm_kms_helper_poll_fini(drm);
@@ -332,12 +338,10 @@ struct komeda_kms_dev *komeda_kms_attach(struct komed=
a_dev *mdev)
 	komeda_kms_cleanup_private_objs(kms);
 	drm->dev_private =3D NULL;
 	drm_dev_put(drm);
-free_kms:
-	kfree(kms);
-	return ERR_PTR(err);
+	return err;
 }
=20
-void komeda_kms_detach(struct komeda_kms_dev *kms)
+void komeda_kms_fini(struct komeda_kms_dev *kms)
 {
 	struct drm_device *drm =3D &kms->base;
 	struct komeda_dev *mdev =3D drm->dev_private;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index 45c498e15e7a..e81ceb298034 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -181,7 +181,7 @@ void komeda_kms_cleanup_private_objs(struct komeda_kms_=
dev *kms);
 void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
 			      struct komeda_events *evts);
=20
-struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev);
-void komeda_kms_detach(struct komeda_kms_dev *kms);
+int komeda_kms_init(struct komeda_kms_dev *kms, struct komeda_dev *mdev);
+void komeda_kms_fini(struct komeda_kms_dev *kms);
=20
 #endif /*_KOMEDA_KMS_H_*/
--=20
2.23.0

