Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C593CC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA5D21D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FNxTreWf";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FNxTreWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389191AbfJDOfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:35:13 -0400
Received: from mail-eopbgr50050.outbound.protection.outlook.com ([40.107.5.50]:1174
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388870AbfJDOfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNdHO3i6gvnroogALjLGcMFWCn+EzncaOt64/SWnjVg=;
 b=FNxTreWfT8Q6cX75Ijk/pTB5ag4ENU6AATTMEscN7lTCKYf3hQR5WWcT+4B5ginZ4jyBObFrJtkEY5SwzMGyhColr6U1mCGp8gevSAq0cH+HT29HVWt+RtIYvQniyXACDsrL7parjfi76F37XZBvHA+4sm0ooV/TpMg+IYcM/WU=
Received: from AM4PR08CA0055.eurprd08.prod.outlook.com (2603:10a6:205:2::26)
 by DB8PR08MB5385.eurprd08.prod.outlook.com (2603:10a6:10:115::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23; Fri, 4 Oct
 2019 14:34:51 +0000
Received: from AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by AM4PR08CA0055.outlook.office365.com
 (2603:10a6:205:2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.16 via Frontend
 Transport; Fri, 4 Oct 2019 14:34:51 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT015.mail.protection.outlook.com (10.152.16.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 4 Oct 2019 14:34:51 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Fri, 04 Oct 2019 14:34:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1f8cbc9fb4748bd1
X-CR-MTA-TID: 64aa7808
Received: from 393823e7005a.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5BD2E0D3-AC41-4050-AAB7-AC1F822AAA42.1;
        Fri, 04 Oct 2019 14:34:44 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2054.outbound.protection.outlook.com [104.47.4.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 393823e7005a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 04 Oct 2019 14:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6fW52EVlPO89VZ0t54WyPEOjt4ipnaN3NU3HJ8B/rIQ7Yo6hRRUUwat7MyPE55rlGIwFfTHCcUTFONBiCHohtVqbGOzu+AQ6o1Qm7GAj4J4zTqDMQS14d5tPJn3QC6bkszDq2Lq4X4jxXydv5XG6Pz/lT4R0UrxI1rW1U5fsffzOPTXWFTR2cdOsJSAU/nRvHe0OHp/K1lIEDFjgsJyQHejp+YBLD936hiBFKyzJeGECaQKxQnAbxDPxJ3T4gx+y3KcxzDOoCms8HLD9DQ+DuLSvEhlBqZTsPfsV8Y9FTbTw9wHvTdpiPHe21Tvq7pxtsm64ErIOmciEURLxowYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNdHO3i6gvnroogALjLGcMFWCn+EzncaOt64/SWnjVg=;
 b=SrQ60GCjcgLJWZLO1KRMp61dUD4TMspft5I/AJihjQ+IQfOC8XtJIunEZbzx6zUYyEIwGOBakjyAniETH4yUFaXUQuRhd7+TMU2AaSZA+MrXR3JlQqmBri4zzvkPcVEgTtxkjp6FHpod2TMYPCBejfGbvgHBTOboj44BIYe0zNjp78mvZ0vaY2+HmmWPlTQAxaHMXVUWJtxbIL2SzQ7f8GFqQkiS8Kp0hbk/GFuvkSK0mvxZmtu3f98w0q9qooavIU/6k9Ywpvrfk5X+Lcbmdb0ItCwehDi+bx9ik0LDnpwrE0mweHyoFyLIcvxAycWQDJTW8Xl2hqy29qhjQ+iuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNdHO3i6gvnroogALjLGcMFWCn+EzncaOt64/SWnjVg=;
 b=FNxTreWfT8Q6cX75Ijk/pTB5ag4ENU6AATTMEscN7lTCKYf3hQR5WWcT+4B5ginZ4jyBObFrJtkEY5SwzMGyhColr6U1mCGp8gevSAq0cH+HT29HVWt+RtIYvQniyXACDsrL7parjfi76F37XZBvHA+4sm0ooV/TpMg+IYcM/WU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3791.eurprd08.prod.outlook.com (20.178.15.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 14:34:42 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 14:34:42 +0000
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
Subject: [RFC PATCH 3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Topic: [RFC PATCH 3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Index: AQHVesDbPaY1L1VuWkStjJCfY/hwXQ==
Date:   Fri, 4 Oct 2019 14:34:42 +0000
Message-ID: <20191004143418.53039-4-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8b3a2cc-a54a-420b-fa8a-08d748d80413
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3791:|VI1PR08MB3791:|DB8PR08MB5385:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB538518F7370417EEC9B201538F9E0@DB8PR08MB5385.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:421;OLM:421;
x-forefront-prvs: 018093A9B5
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(189003)(199004)(66066001)(2906002)(36756003)(66946007)(316002)(71200400001)(71190400001)(6512007)(54906003)(256004)(5024004)(14444005)(3846002)(6116002)(5640700003)(6436002)(1076003)(476003)(486006)(7736002)(81166006)(81156014)(44832011)(6486002)(52116002)(8676002)(26005)(386003)(6506007)(2501003)(25786009)(50226002)(86362001)(2616005)(305945005)(478600001)(76176011)(11346002)(446003)(186003)(8936002)(4326008)(6916009)(5660300002)(2351001)(14454004)(66556008)(99286004)(64756008)(66476007)(66446008)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3791;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ixU5OnmONMifDDPRNUhG+1LvhCR4KYL+uezm6Q/bOaJtELic6B4E0RjZ2fmFpYmJ1vzMS8G1SJpw50TAFZBASee3mOKywy7nu91OFp76TabqX5M9OTPNllhC/aqYWvJuc8E36mCTCJW6Leg9UgHGPB9dU8/SBNot0/FMGbmiW+K3JsnYHyRII78rtnA+bDG6b0Xq+tlQECqeIhJF6phjKDOVqS0xiG6NCKO9nFk2z54pSDU8yq0SXJoNodCNKNQfJwWZCmeo3AnhuXXVTf2AEoe7pFpQUNvovp+zWJJU5IHUnRGWg0O+MdSyBAuO9bBLY/498AYMBGTMWvYOh8AW98uoM+rxbFv21SWFfMU+HwmNdO/7Gf8wptC3CHqAdHyp1dI2Nubv21Nx8EGPQhbGhtK4UYNm+BQwSE/WUA+1KGQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3791
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(1110001)(339900001)(199004)(189003)(70206006)(70586007)(50466002)(54906003)(36756003)(76176011)(14454004)(99286004)(356004)(25786009)(2351001)(478600001)(26826003)(316002)(36906005)(22756006)(2906002)(23756003)(8676002)(3846002)(6116002)(66066001)(47776003)(14444005)(5024004)(76130400001)(50226002)(81156014)(81166006)(8936002)(2501003)(305945005)(8746002)(7736002)(1076003)(186003)(86362001)(6862004)(6486002)(26005)(446003)(102836004)(5660300002)(5640700003)(6512007)(2616005)(126002)(486006)(6506007)(386003)(336012)(4326008)(11346002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5385;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1b96fdd2-3b6d-4d12-7262-08d748d7fe4e
NoDisclaimer: True
X-Forefront-PRVS: 018093A9B5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TUGcyDwouOL6nT1j1DTVScpoJJQ3wmBGpys2iNZIgV87g3xQmJzZUufu1v9v4Pupc36LEaU5ajx66mGJhWKHaQAeZZdYsa4KrQYKdv3KCJG6mbXrrZ4VvS6OAvQT9GkG10HtS4ilrv9lkqLWuclXFW+KYyZBfhaP2K9WQWEbuv2VyuBSNvfUvNnT5rKr/f1tAz6AvTKGAgV2XZoDIJR91kBP84EWdOFdKulHHFoP5wum3pmg44AK+OM2b/jHlf9j9ef33pSWfKKXRqDJZWJghufM+9/XiJUB+MPn887EfVpoF7a+eQNX5F+cwR4YqByuj6dleKnRWg4KhySvUGFrsyHsyZLFil7S7zc9bWSzipqa0LTCZR+/YMhdZjI3ivPP22b/xb68HIza+oAVf+yCMXMvmb7ssDX7NqeBKFEw/S4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2019 14:34:51.3887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b3a2cc-a54a-420b-fa8a-08d748d80413
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5385
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support transmitters other than the tda998x, we need to allow
non-component framework bridges to be attached to a dummy drm_encoder in
our driver.

For the existing supported encoder (tda998x), keep the behaviour as-is,
since there's no way to unbind if a drm_bridge module goes away under
our feet.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |   5 +
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  58 ++++++--
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 133 +++++++++++++++++-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   5 +
 4 files changed, 187 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index e392b8ffc372..64d2902e2e0c 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -176,6 +176,11 @@ struct komeda_dev {
=20
 	/** @irq: irq number */
 	int irq;
+	/** @has_components:
+	 *
+	 * if true, use the component framework to bind/unbind driver
+	 */
+	bool has_components;
=20
 	/** @lock: used to protect dpmode */
 	struct mutex lock;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index 9ed25ffe0e22..34cfc6a4c3e4 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -10,6 +10,8 @@
 #include <linux/component.h>
 #include <linux/pm_runtime.h>
 #include <drm/drm_of.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_encoder.h>
 #include "komeda_dev.h"
 #include "komeda_kms.h"
=20
@@ -69,18 +71,35 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node =3D=3D data;
 }
=20
-static void komeda_add_slave(struct device *master,
-			     struct component_match **match,
-			     struct device_node *np,
-			     u32 port, u32 endpoint)
+static int komeda_add_slave(struct device *master,
+			    struct komeda_drv *mdrv,
+			    struct component_match **match,
+			    struct device_node *np,
+			    u32 port, u32 endpoint)
 {
 	struct device_node *remote;
+	struct drm_bridge *bridge;
+	int ret =3D 0;
=20
 	remote =3D of_graph_get_remote_node(np, port, endpoint);
-	if (remote) {
+	if (!remote)
+		return 0;
+
+	if (komeda_remote_device_is_component(np, port, endpoint)) {
+		mdrv->mdev.has_components =3D true;
 		drm_of_component_match_add(master, match, compare_of, remote);
-		of_node_put(remote);
+		goto exit;
+	}
+
+	bridge =3D of_drm_find_bridge(remote);
+	if (!bridge) {
+		ret =3D -EPROBE_DEFER;
+		goto exit;
 	}
+
+exit:
+	of_node_put(remote);
+	return ret;
 }
=20
 static int komeda_platform_probe(struct platform_device *pdev)
@@ -89,6 +108,7 @@ static int komeda_platform_probe(struct platform_device =
*pdev)
 	struct component_match *match =3D NULL;
 	struct device_node *child;
 	struct komeda_drv *mdrv;
+	int ret;
=20
 	if (!dev->of_node)
 		return -ENODEV;
@@ -101,14 +121,27 @@ static int komeda_platform_probe(struct platform_devi=
ce *pdev)
 		if (of_node_cmp(child->name, "pipeline") !=3D 0)
 			continue;
=20
-		/* add connector */
-		komeda_add_slave(dev, &match, child, KOMEDA_OF_PORT_OUTPUT, 0);
-		komeda_add_slave(dev, &match, child, KOMEDA_OF_PORT_OUTPUT, 1);
+		/* attach any remote devices if present */
+		ret =3D komeda_add_slave(dev, mdrv, &match, child,
+				       KOMEDA_OF_PORT_OUTPUT, 0);
+		if (ret)
+			goto free_mdrv;
+		ret =3D komeda_add_slave(dev, mdrv, &match, child,
+				       KOMEDA_OF_PORT_OUTPUT, 1);
+		if (ret)
+			goto free_mdrv;
 	}
=20
 	dev_set_drvdata(dev, mdrv);
=20
-	return component_master_add_with_match(dev, &komeda_master_ops, match);
+	return mdrv->mdev.has_components
+		? component_master_add_with_match(
+			dev, &komeda_master_ops, match)
+		: komeda_bind(dev);
+
+free_mdrv:
+	devm_kfree(dev, mdrv);
+	return ret;
 }
=20
 static int komeda_platform_remove(struct platform_device *pdev)
@@ -116,7 +149,10 @@ static int komeda_platform_remove(struct platform_devi=
ce *pdev)
 	struct device *dev =3D &pdev->dev;
 	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
=20
-	component_master_del(dev, &komeda_master_ops);
+	if (mdrv->mdev.has_components)
+		component_master_del(dev, &komeda_master_ops);
+	else
+		komeda_unbind(dev);
=20
 	dev_set_drvdata(dev, NULL);
 	devm_kfree(dev, mdrv);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 03dcf1d7688f..6eb52d1b20a0 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -6,6 +6,7 @@
  */
 #include <linux/component.h>
 #include <linux/interrupt.h>
+#include <linux/of_graph.h>
=20
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -14,6 +15,8 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_irq.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
=20
@@ -267,6 +270,130 @@ static void komeda_kms_mode_config_init(struct komeda=
_kms_dev *kms,
 	config->helper_private =3D &komeda_mode_config_helpers;
 }
=20
+static void komeda_encoder_destroy(struct drm_encoder *encoder)
+{
+	drm_encoder_cleanup(encoder);
+}
+
+static const struct drm_encoder_funcs komeda_dummy_enc_funcs =3D {
+	.destroy =3D komeda_encoder_destroy,
+};
+
+bool komeda_remote_device_is_component(struct device_node *local,
+				       u32 port, u32 endpoint)
+{
+	struct device_node *remote;
+	char const * const component_devices[] =3D {
+		"nxp,tda998x",
+	};
+	int i;
+	bool ret =3D false;
+
+	remote =3D of_graph_get_remote_node(local, port, endpoint);
+	if (!remote)
+		return false;
+
+	/* Coprocessor endpoints are always component based. */
+	if (port !=3D KOMEDA_OF_PORT_OUTPUT) {
+		ret =3D true;
+		goto exit;
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(component_devices); ++i) {
+		if (of_device_is_compatible(remote, component_devices[i])) {
+			ret =3D true;
+			goto exit;
+		}
+	}
+
+exit:
+	of_node_put(remote);
+	return ret;
+}
+
+static int komeda_encoder_attach_bridge(struct komeda_dev *mdev,
+					struct komeda_kms_dev *kms,
+					struct drm_encoder *encoder,
+					struct device_node *np)
+{
+	struct device_node *remote;
+	struct drm_bridge *bridge;
+	u32 crtcs =3D 0;
+	int ret =3D 0;
+
+	if (komeda_remote_device_is_component(np, KOMEDA_OF_PORT_OUTPUT, 0))
+		return 0;
+
+	remote =3D of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTPUT, 0);
+	if (!remote)
+		return 0;
+
+	bridge =3D of_drm_find_bridge(remote);
+	if (!bridge) {
+		ret =3D -EINVAL;
+		goto exit;
+	}
+
+	crtcs =3D drm_of_find_possible_crtcs(&kms->base, remote);
+
+	encoder->possible_crtcs =3D crtcs ? crtcs : 1;
+
+	ret =3D drm_encoder_init(&kms->base, encoder,
+			       &komeda_dummy_enc_funcs, DRM_MODE_ENCODER_TMDS,
+			       NULL);
+	if (ret)
+		goto exit;
+
+	ret =3D drm_bridge_attach(encoder, bridge, NULL);
+	if (ret)
+		goto exit;
+
+exit:
+	of_node_put(remote);
+	return ret;
+}
+
+static int komeda_encoder_attach_bridges(struct komeda_kms_dev *kms,
+					 struct komeda_dev *mdev)
+{
+	int i, err;
+
+	for (i =3D 0; i < kms->n_crtcs; i++) {
+		err =3D komeda_encoder_attach_bridge(
+			mdev, kms,
+			&kms->encoders[i], mdev->pipelines[i]->of_node);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int komeda_kms_attach_external(struct komeda_kms_dev *kms,
+				      struct komeda_dev *mdev)
+{
+	int err;
+
+	if (mdev->has_components) {
+		err =3D component_bind_all(mdev->dev, kms);
+		if (err)
+			return err;
+	}
+
+	err =3D komeda_encoder_attach_bridges(kms, mdev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void komeda_kms_detach_external(struct komeda_dev *mdev,
+				       struct drm_device *drm)
+{
+	if (mdev->has_components)
+		component_unbind_all(mdev->dev, drm);
+}
+
 int komeda_kms_init(struct komeda_kms_dev *kms, struct komeda_dev *mdev)
 {
 	struct drm_device *drm;
@@ -301,7 +428,7 @@ int komeda_kms_init(struct komeda_kms_dev *kms, struct =
komeda_dev *mdev)
 	if (err)
 		goto cleanup_mode_config;
=20
-	err =3D component_bind_all(mdev->dev, kms);
+	err =3D komeda_kms_attach_external(kms, mdev);
 	if (err)
 		goto cleanup_mode_config;
=20
@@ -332,7 +459,7 @@ int komeda_kms_init(struct komeda_kms_dev *kms, struct =
komeda_dev *mdev)
 	drm->irq_enabled =3D false;
 	mdev->funcs->disable_irq(mdev);
 free_component_binding:
-	component_unbind_all(mdev->dev, drm);
+	komeda_kms_detach_external(mdev, drm);
 cleanup_mode_config:
 	drm_mode_config_cleanup(drm);
 	komeda_kms_cleanup_private_objs(kms);
@@ -351,7 +478,7 @@ void komeda_kms_fini(struct komeda_kms_dev *kms)
 	drm_atomic_helper_shutdown(drm);
 	drm->irq_enabled =3D false;
 	mdev->funcs->disable_irq(mdev);
-	component_unbind_all(mdev->dev, drm);
+	komeda_kms_detach_external(mdev, drm);
 	drm_mode_config_cleanup(drm);
 	komeda_kms_cleanup_private_objs(kms);
 	drm->dev_private =3D NULL;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index e81ceb298034..c2856e19d092 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -12,6 +12,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_device.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_writeback.h>
 #include <drm/drm_print.h>
=20
@@ -123,6 +124,7 @@ struct komeda_kms_dev {
 	int n_crtcs;
 	/** @crtcs: crtcs list */
 	struct komeda_crtc crtcs[KOMEDA_MAX_PIPELINES];
+	struct drm_encoder encoders[KOMEDA_MAX_PIPELINES];
 };
=20
 #define to_kplane(p)	container_of(p, struct komeda_plane, base)
@@ -184,4 +186,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcr=
tc,
 int komeda_kms_init(struct komeda_kms_dev *kms, struct komeda_dev *mdev);
 void komeda_kms_fini(struct komeda_kms_dev *kms);
=20
+bool komeda_remote_device_is_component(struct device_node *local,
+				       u32 port, u32 endpoint);
+
 #endif /*_KOMEDA_KMS_H_*/
--=20
2.23.0

