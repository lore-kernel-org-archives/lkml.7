Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE698C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700D320659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3VbH8seW";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3VbH8seW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfLDLsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:19 -0500
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:22144
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfLDLsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xjhaa9GsGlM51nJym8bd1M2smCmftsU3gd0F6TVRRuk=;
 b=3VbH8seW3SUQSdYBl/EKbcaiOIiGiuRTmEK+qiSp1hwKPJ18Mg6Md5+1oqmiUQlz+ap8Ir3YwNUbqxWxIMy/RaRJrMciCygesYe74XUfCiXZv2urC1I6gZ7bTefAEADUTlk69rY1p8Lis8CkQTkes6S3ujY1i1+AspD2FXzKtIc=
Received: from VI1PR08CA0234.eurprd08.prod.outlook.com (2603:10a6:802:15::43)
 by VI1PR0801MB1998.eurprd08.prod.outlook.com (2603:10a6:800:89::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Wed, 4 Dec
 2019 11:48:13 +0000
Received: from AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by VI1PR08CA0234.outlook.office365.com
 (2603:10a6:802:15::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:13 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT033.mail.protection.outlook.com (10.152.16.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:13 +0000
Received: ("Tessian outbound 92d30e517f5d:v37"); Wed, 04 Dec 2019 11:48:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a7ad29d86ff89491
X-CR-MTA-TID: 64aa7808
Received: from b2b246179d1c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 696D05E8-EFF3-4838-9822-C32CE7880CCB.1;
        Wed, 04 Dec 2019 11:48:05 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b2b246179d1c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5GTdsb3ofk+B3vK0M0cuo2S+aWyGE/tpIXwTkJ0Upy0wwrMND5vom3780OvGU37CE9tbJJVjfl4rg4n26YYbinfcIisO61Cy8Ai+RToOcoToF0IqKCzeRhrUuFu+vN5y/S6VmpNdaFKMujUuU1AAq65du31XeQAjn6STpu7V/n2EPvY6IBqq/Gfk/w8Vt194F6oYikX2r2LXGjN9RS3vqPAHrmQbn0rQsWsVevJqpcw8eqf3tRBmIB2zKi3eD41Bja81qIk6fLnwwgYcxOdjjPFGeK0cBoi4PTj7ycOZqlB11VQJnnCCCA0iNv6W/zSiyJqCbztbA/LfDUCVMmEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xjhaa9GsGlM51nJym8bd1M2smCmftsU3gd0F6TVRRuk=;
 b=Ycd/zRGkqocpK2ffSjywdeMDt8ihIdcbNlF66QsiSffQZFGq9ZGINMA+E3Mywp0bvguMRmgqNx3znwkFoTHPt5Z0TrWOquHPag/NmuUrOAF75j6XmNqoJzkTz3v/V81ifPe8KtzEoFe6UHEjv26IETuqxBOmHOSAH+eMtc8YdN05BM2XerInU2h6LSIDvhEpM0vucTvMqXdbqcrcCvVOT8UiVoDur90x0VtLWvDFAyw5BTA1eFfBvZydrgOBGqtoS7MRbkrXrEOunyNZJK6wZueU2AGGlYkyOXov107VsbfjfjO/qMsykLncCFLfOQAUFw7zycdCgVQcPMF0QAxEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xjhaa9GsGlM51nJym8bd1M2smCmftsU3gd0F6TVRRuk=;
 b=3VbH8seW3SUQSdYBl/EKbcaiOIiGiuRTmEK+qiSp1hwKPJ18Mg6Md5+1oqmiUQlz+ap8Ir3YwNUbqxWxIMy/RaRJrMciCygesYe74XUfCiXZv2urC1I6gZ7bTefAEADUTlk69rY1p8Lis8CkQTkes6S3ujY1i1+AspD2FXzKtIc=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:04 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:04 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/28] drm: Introduce drm_bridge_init()
Thread-Topic: [PATCH v2 01/28] drm: Introduce drm_bridge_init()
Thread-Index: AQHVqpiuVXCS0RRq1UGHN2fVy/u6Kw==
Date:   Wed, 4 Dec 2019 11:48:02 +0000
Message-ID: <20191204114732.28514-2-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: bc99de28-cdaa-4ef2-7115-08d778afd7fc
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|VI1PR0801MB1998:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1998378F34D65A9B1F7022238F5D0@VI1PR0801MB1998.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:431;OLM:431;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(14444005)(6506007)(36756003)(5024004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tISuevjz7NtKVm3vNsVGGFDDvSps0mtU0Rvzq8nxLdXLYu2S0NyXbQ5OGoXPubW1p/DiQmRg3HanYZh6Roh6GRS5ljt50lzN4GolVX/83qBDGmSGFRASA00bjJ0G8jg6C98W9NQpBSYYGFCzmmNGjQEMCOmD1RFuKX8v15A9vGaFnk/Vy2RF2jkJ+qqCHqLSY9zZoZ93FxtHHYhzb4R4pzvClQ7c6/6xcuVZPyP8Hd471SEFtV6kcEv+4D4bKkC6nbxTu8sgl6cKdJDc9/S98bszwn8YIlEJoP37D9NpA++1JHwXCV0r4xf8yghdIGbaMP2mwKQQGpCjdhtPXUamCRFGoHGuemx6m6CQnsIl3I+R2VL+U/+hz5hOK4iKjtBL7TL03i/p5hTHa0LxMmPPpJxYgikwRXcsbxgiGIUwplB/96MfflVak1RP4yigjUkt
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(1076003)(5660300002)(6116002)(26005)(3846002)(102836004)(186003)(70206006)(70586007)(76130400001)(356004)(5640700003)(316002)(14444005)(5024004)(99286004)(14454004)(6486002)(86362001)(36906005)(336012)(76176011)(22756006)(7736002)(305945005)(26826003)(23756003)(2501003)(6512007)(50466002)(2351001)(2906002)(6506007)(478600001)(6862004)(4326008)(50226002)(54906003)(2616005)(8676002)(8936002)(8746002)(81156014)(81166006)(36756003)(25786009)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1998;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 477886ba-b609-44f2-f6e5-08d778afd143
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfLz5VjR1H0Qo0cngHcRI1sDJjgw2hKjg975fanGqyFHGEv2B9pN2whJciuZn9qzRcXfBgV6FIv5o5k4EMMLAOged0qJzmgymxzXGMP2pjjpYn2cMCY/T5AjBdiroqNoYRjO+n17Og6BQV9ydjdBKXhHeQJwNdN7pv2iEHWbzP/LQWuTrvA9gQL/xOC7/f17o1FhgvPLD+IC+hGlWOjxxh/K6KW8OonOvffFx1oIJTtxVNVhcFne0vHv7dNS4x3j1kiFb0QHPohOuCEha+DbqaHTer74ha2ASASFyhbuFZeUsiUSV9TiNKVFPPpHeqOMHMZbZfXsf0hAmw92F3zJVH+o/KkFrMlB8yyLdD6uGsU6vA5x3KPrBC+NHJD1hs5fWXEFv/913XCOx1TOpm2LYAQ5uICUm8inkO95GijF+t/8ysNE4XtANN+qhZau7u7f
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:13.3899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc99de28-cdaa-4ef2-7115-08d778afd7fc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1998
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A simple convenience function to initialize the struct drm_bridge. The
goal is to standardize initialization for any bridge registered with
drm_bridge_add() so that we can later add device links for consumers of
those bridges.

v2:
 - s/WARN_ON(!funcs)/WARN_ON(!funcs || !dev)/ as suggested by Daniel
 - expand on some kerneldoc comments as suggested by Daniel
 - update commit message as suggested by Daniel

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/drm_bridge.c | 34 +++++++++++++++++++++++++++++++++-
 include/drm/drm_bridge.h     | 15 ++++++++++++++-
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index cba537c99e43..50e1c1b46e20 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -64,7 +64,10 @@ static DEFINE_MUTEX(bridge_lock);
 static LIST_HEAD(bridge_list);
=20
 /**
- * drm_bridge_add - add the given bridge to the global bridge list
+ * drm_bridge_add - add the given bridge to the global bridge list.
+ *
+ * Drivers should call drm_bridge_init() prior adding it to the list.
+ * Drivers should call drm_bridge_remove() to clean up the bridge list.
  *
  * @bridge: bridge control structure
  */
@@ -89,6 +92,35 @@ void drm_bridge_remove(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_bridge_remove);
=20
+/**
+ * drm_bridge_init - initialise a drm_bridge structure
+ *
+ * @bridge: bridge control structure
+ * @funcs: control functions
+ * @dev: device associated with this drm_bridge
+ * @timings: timing specification for the bridge; optional (may be NULL)
+ * @driver_private: pointer to the bridge driver internal context (may be =
NULL)
+ */
+void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
+		     const struct drm_bridge_funcs *funcs,
+		     const struct drm_bridge_timings *timings,
+		     void *driver_private)
+{
+	WARN_ON(!funcs || !dev);
+
+	bridge->dev =3D NULL;
+	bridge->encoder =3D NULL;
+	bridge->next =3D NULL;
+
+#ifdef CONFIG_OF
+	bridge->of_node =3D dev->of_node;
+#endif
+	bridge->timings =3D timings;
+	bridge->funcs =3D funcs;
+	bridge->driver_private =3D driver_private;
+}
+EXPORT_SYMBOL(drm_bridge_init);
+
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
  *
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index c0a2286a81e9..949e4f401a53 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -373,7 +373,16 @@ struct drm_bridge_timings {
 };
=20
 /**
- * struct drm_bridge - central DRM bridge control structure
+ * struct drm_bridge - central DRM bridge control structure.
+ *
+ * Bridge drivers should call drm_bridge_init() to initialize a bridge
+ * driver, and then register it with drm_bridge_add().
+ *
+ * Users of bridges link a bridge driver into their overall display output
+ * pipeline by calling drm_bridge_attach().
+ *
+ * Modular drivers in OF systems can query the list of registered bridges
+ * with of_drm_find_bridge().
  */
 struct drm_bridge {
 	/** @dev: DRM device this bridge belongs to */
@@ -402,6 +411,10 @@ struct drm_bridge {
=20
 void drm_bridge_add(struct drm_bridge *bridge);
 void drm_bridge_remove(struct drm_bridge *bridge);
+void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
+		     const struct drm_bridge_funcs *funcs,
+		     const struct drm_bridge_timings *timings,
+		     void *driver_private);
 struct drm_bridge *of_drm_find_bridge(struct device_node *np);
 int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *brid=
ge,
 		      struct drm_bridge *previous);
--=20
2.23.0

