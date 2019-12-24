Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F4EC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A392063A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="STXn+/pl";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="STXn+/pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLXRgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:36:33 -0500
Received: from mail-eopbgr00054.outbound.protection.outlook.com ([40.107.0.54]:47232
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbfLXRel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMZ5ZAVYsnUfr4geYMTE6cLOip6KXPRJVQif8VdxATE=;
 b=STXn+/plckZ+d8m1SpxSJbNO4vAI3tZb5dDqMYbbJZ9wtheewScEb3je71CCMPscuX+obW9WExWdDbpZMoGgaYaAcqcUXvWOL6t3+UvlhZSHHE6/e5v9SoQEz252JCNavhsy+k3BsIZzVtlQY3/92FBLT4qX4KBZtJ4V5vZ+CJE=
Received: from AM6PR08CA0046.eurprd08.prod.outlook.com (2603:10a6:20b:c0::34)
 by VI1PR08MB2957.eurprd08.prod.outlook.com (2603:10a6:803:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Tue, 24 Dec
 2019 17:34:36 +0000
Received: from VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by AM6PR08CA0046.outlook.office365.com
 (2603:10a6:20b:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.16 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:35 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT051.mail.protection.outlook.com (10.152.19.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:35 +0000
Received: ("Tessian outbound 28955e0c1ca8:v40"); Tue, 24 Dec 2019 17:34:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1d032c781cee466d
X-CR-MTA-TID: 64aa7808
Received: from 588b9162f539.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8507C905-0511-4637-8B57-E3A3B8C7BB31.1;
        Tue, 24 Dec 2019 17:34:30 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 588b9162f539.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu19ORQEbGPAGzKjXlVzuw3JQj9NhL4IKRfZPlAQh8WSWqHMDGUfjDQ9xVEgXShvMrLoHEBP10fpx2spF4CMhvrWqemiUlVcBcziSPAWjEcFt4yKadi0SCOe4nwxJc9aBu3kNm0TmTbf0i/ie5Q19AGvK3YXAnmuosBBmzgCgZwjh908lDY9yWsEPXZ+Toz19PjC3K9+8y/p8f66DkVbOogdoeYCqaSibvH0zQN9GwHBo1AdYT0/O/bMEOm9Ovmu5Tcbow5rrPNyAXOHg3piDYfBVIxw8xteHRLd8rwB8E5yexbqPdaVwbB/wJeuV4TcSIiGs88A9k5mD5FZj9hVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMZ5ZAVYsnUfr4geYMTE6cLOip6KXPRJVQif8VdxATE=;
 b=fB/NM5WNNkAp11UQHpleUDGWyR/xLDMkgaIFm6lsZlomFFMiHuC8jljjSIgi/m4hxUwhQRCIpxc/9DQMD38Ekh602PccXHsyZY5UPQSOrW/8Sz1xbJK/zwhmFNOovjPexrFtcsUEhfvLhEjaUPl3uWFi5leYW/Iv7FJ0kEbhSCIMKmUiYDVsUvYjVHNLibKoCwULkLylGEcvygrc4NywEniU1MinwQlq5xgK69RTKHJJsEY+VyP3MZV7YdWYxE6qGN4mT2t/T4WWrGzqWHDxOceNhnjXgKWeXo0GTIN9FaxvdjdKaFC+PauPIyPA8rYwgjXL2+e9S8zzNyuyv285qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMZ5ZAVYsnUfr4geYMTE6cLOip6KXPRJVQif8VdxATE=;
 b=STXn+/plckZ+d8m1SpxSJbNO4vAI3tZb5dDqMYbbJZ9wtheewScEb3je71CCMPscuX+obW9WExWdDbpZMoGgaYaAcqcUXvWOL6t3+UvlhZSHHE6/e5v9SoQEz252JCNavhsy+k3BsIZzVtlQY3/92FBLT4qX4KBZtJ4V5vZ+CJE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2702.eurprd08.prod.outlook.com (10.170.239.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 24 Dec 2019 17:34:28 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:28 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v3 09/35] drm: Introduce drm_bridge_init()
Thread-Topic: [PATCH v3 09/35] drm: Introduce drm_bridge_init()
Thread-Index: AQHVuoBk/kdoLcRc2kWafO/PUjf5nQ==
Date:   Tue, 24 Dec 2019 17:34:28 +0000
Message-ID: <20191224173408.25624-10-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 60a604dd-8773-49fc-4f9d-08d788978b85
X-MS-TrafficTypeDiagnostic: VI1PR08MB2702:|VI1PR08MB2702:|VI1PR08MB2957:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB2957DA4706D6D86DE7911AE38F290@VI1PR08MB2957.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:513;OLM:513;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(81156014)(8676002)(478600001)(36756003)(4326008)(8936002)(66446008)(64756008)(66946007)(66476007)(66556008)(26005)(186003)(44832011)(6506007)(2616005)(81166006)(71200400001)(316002)(2906002)(1076003)(6512007)(54906003)(6916009)(6486002)(86362001)(5660300002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2702;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3pUuxD/eaFpLIPQa5bNvaZXYZ0pxtwXbc57wYiWxRJ8YLWhSSgQ/pdpI9H1NbTMyx9P4UJEGslrxJSv2yK8SEjBk8E/OEV9GOHnc0buTfhEoFBQxUfONxq+UolRc7y8i0QEzxNEab4o75GB0RP9GfVmNj4Zkm32TIgJ+LrqRZTddxFkvfwhJLkSTZF/HeC1w3Na7hlPrj9yUKP9yMUG1i3m2LQ6YMbA9jHd0zSbAjjF4fLZpWiLWjOfhUAM4ssv1hEWxQWAfY5mTJXvcpDW46qi+Cy0m1oUArdj5PAuvltetEOHeYboj9jN4lLRtcl8g8g62OEVcYOmZtgOA8ccrOjVdhma9NjW9FTcR0jW9M6ItgjEalfihzYmCogsq1K2S03QFIwFp+u6XnRfrG5YwmE2S4o+beoK2a7QXzCaOsEuTUduTPN9ZRp0mPxUxaHs8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2702
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(189003)(199004)(26826003)(36756003)(36906005)(6506007)(2616005)(6486002)(186003)(107886003)(26005)(316002)(8936002)(478600001)(54906003)(4326008)(70586007)(1076003)(8676002)(81156014)(81166006)(76130400001)(2906002)(6512007)(6862004)(5660300002)(86362001)(70206006)(336012)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2957;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b9bc5126-9083-475c-7f3a-08d7889786ec
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ie6rahwKpKhmPUo1y1I4MZIEd97Oaz1/DZQIwAmtW7ceWiiJq/MGAmf+JYGNmAEpT6zf2vzcc5P2KNd7ZF+uGt81rpmXleN7R1cB9qf0mwN9FVcDe+ISM271UQ8WNGEAfsKoJnrFxVdrXfsBc3bhkd4k6PUsd3tX7RZU+hjI8bO52XWjhRfZOlKHZ7t9rBSo92P78JbtZInKnIQ81tmnGaVuK/W00Ktas/Ocgv+w9aFDR+OIHtUczc2lgRwX01IJ3X5w106rC3jJLWBoKUp8yDO54i3V4S1OtGjpBUhw1o3Hps8L+F4bhZgxdG0x4Rk2pvKZQ7q1XYKgZdVh7jNZi84Hi8NP1DXTHcdBerKgWVNrihsyI/yDfLFgOI+lZsB4EVMddPbWM2pcEN1IXMFWPezKspBT/oHPHW52lcgbTgrnj2ThEay8fBb5GsgT+/BH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:35.7342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a604dd-8773-49fc-4f9d-08d788978b85
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A simple convenience function to initialize the struct drm_bridge. The
goal is to standardize initialization for any bridge registered with
drm_bridge_add() so that we can later add device links for consumers of
those bridges.

v3:
 - drop driver_private parameter (Laurent)
 - spelling & style updates to docs (Laurent)
 - don't set drm_bridge->dev (field removed)
v2:
 - s/WARN_ON(!funcs)/WARN_ON(!funcs || !dev)/ as suggested by Daniel
 - expand on some kerneldoc comments as suggested by Daniel
 - update commit message as suggested by Daniel

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/drm_bridge.c | 30 ++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     | 12 ++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 258094169706..d6b64e9aec7c 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -67,6 +67,11 @@ static LIST_HEAD(bridge_list);
  * drm_bridge_add - add the given bridge to the global bridge list
  *
  * @bridge: bridge control structure
+ *
+ * Drivers shall call drm_bridge_init() prior to adding the bridge to the =
list.
+ * Before deleting a bridge (usually when the driver is unbound from the
+ * device), drivers shall call drm_bridge_remove() to remove it from the g=
lobal
+ * list.
  */
 void drm_bridge_add(struct drm_bridge *bridge)
 {
@@ -89,6 +94,31 @@ void drm_bridge_remove(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_bridge_remove);
=20
+/**
+ * drm_bridge_init - initialize a drm_bridge structure
+ *
+ * @bridge: bridge control structure
+ * @dev: device associated with this drm_bridge
+ * @funcs: control functions
+ * @timings: timing specification for the bridge; optional (may be NULL)
+ */
+void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
+		     const struct drm_bridge_funcs *funcs,
+		     const struct drm_bridge_timings *timings)
+{
+	WARN_ON(!funcs || !dev);
+
+	bridge->encoder =3D NULL;
+	INIT_LIST_HEAD(&bridge->chain_node);
+
+#ifdef CONFIG_OF
+	bridge->of_node =3D dev->of_node;
+#endif
+	bridge->timings =3D timings;
+	bridge->funcs =3D funcs;
+}
+EXPORT_SYMBOL(drm_bridge_init);
+
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
  *
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index ee175a2f95e6..955d9bd13805 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -378,6 +378,15 @@ struct drm_bridge_timings {
=20
 /**
  * struct drm_bridge - central DRM bridge control structure
+ *
+ * Bridge drivers shall call drm_bridge_init() to initialize a drm_bridge
+ * structure, and then register it with drm_bridge_add().
+ *
+ * Users of bridges link a bridge driver into their overall display output
+ * pipeline by calling drm_bridge_attach().
+ *
+ * Modular drivers in OF systems can query the list of registered bridges
+ * with of_drm_find_bridge().
  */
 struct drm_bridge {
 	/** @encoder: encoder to which this bridge is connected */
@@ -402,6 +411,9 @@ struct drm_bridge {
=20
 void drm_bridge_add(struct drm_bridge *bridge);
 void drm_bridge_remove(struct drm_bridge *bridge);
+void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
+		     const struct drm_bridge_funcs *funcs,
+		     const struct drm_bridge_timings *timings);
 struct drm_bridge *of_drm_find_bridge(struct device_node *np);
 int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *brid=
ge,
 		      struct drm_bridge *previous);
--=20
2.24.0

