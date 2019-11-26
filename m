Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2707C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1ABE2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rPFinv9L";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rPFinv9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfKZNQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:15 -0500
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:54919
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbfKZNQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lozbmKQolmfEpGhORJ6KkPbrizY8PP9qfhnG2x9TOEw=;
 b=rPFinv9LH3xI19EM70ZoHgim8wNVn52VBD0kfRsH62AfldAxgysW4vDj+6YkULYq4hHu6JcOGdIOJEPre34GXyB7sKf9WxaBYmaOz6XbLhvtTCj6+z89UNkTVH7c9/qtCaGDVQc2hc9oukFpvr4/oZoUupZRkEkWHN4YmWPdKAI=
Received: from VE1PR08CA0013.eurprd08.prod.outlook.com (2603:10a6:803:104::26)
 by DB6PR0801MB1671.eurprd08.prod.outlook.com (2603:10a6:4:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Tue, 26 Nov
 2019 13:16:10 +0000
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VE1PR08CA0013.outlook.office365.com
 (2603:10a6:803:104::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:10 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:09 +0000
Received: ("Tessian outbound 712c40e503a7:v33"); Tue, 26 Nov 2019 13:16:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c1139fa09dcf615f
X-CR-MTA-TID: 64aa7808
Received: from 687810ec6074.4 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F7D55C45-E4BE-456B-8874-7F153F58846F.1;
        Tue, 26 Nov 2019 13:16:02 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 687810ec6074.4
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtOBf7SlgXOQSOJgtGeFEFolh2pnsf4RhROmt7DjLIajy9hKZJIq1qsqpLHUNLeU842zxWnWR8LIvlwP0+zDUfkDa71uLLpsi2B8FpvTvxzIg3A2jPPpqi6ekCgJQYr56CgCG32e3GU3JHv1qY0medQH3lcPh94sWuhdnkWlETGwqmcytFEf4QC9UqgnrigPzrfgA7Rq9TSaGerLe6Ssq4DGlAFJ9aRGcCJKQ7RwsjHoCXYUfHdakGt709FpQy2naWWFog/c85oesACyae5MQUYwU/47bZz5PATrt8CtroI7bPZESRxn+EWOyOC3+ytV2yW8kBEJ4v05W4j6bHKJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lozbmKQolmfEpGhORJ6KkPbrizY8PP9qfhnG2x9TOEw=;
 b=UGdtSe3zFVuJ94+gYhNkZr6+9UcIyJMdsOPYc1C1sTBR+7KtykfruFBRsEXW0+UqrSJXOigxF5FTSGrBTxNfZGOyQrB+biFd5TDu8HZVtdX8ATAu9WAB9Ib3igGMV+y/0a5uo/mUdH9TzpZHfG/h19eSJMQjpuHXW6qNp2CVrfbcLLt5zDlzZU9WuEsvr4PlszCaTFvrljDUEoCUIkYnJ+Kiuhx+mKWDhoIsgNXTJIfRsL8UH9aglkseflDHEPh8bjsl7TB7mWCH+frG7HKeKRyifGoybssUO67RcG5abEwOZt0C+oFNYPx/IXGKLQ11hwZmSOSZIAVXG5QgqldeOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lozbmKQolmfEpGhORJ6KkPbrizY8PP9qfhnG2x9TOEw=;
 b=rPFinv9LH3xI19EM70ZoHgim8wNVn52VBD0kfRsH62AfldAxgysW4vDj+6YkULYq4hHu6JcOGdIOJEPre34GXyB7sKf9WxaBYmaOz6XbLhvtTCj6+z89UNkTVH7c9/qtCaGDVQc2hc9oukFpvr4/oZoUupZRkEkWHN4YmWPdKAI=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:00 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:00 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/30] drm: Introduce drm_bridge_init()
Thread-Topic: [PATCH 01/30] drm: Introduce drm_bridge_init()
Thread-Index: AQHVpFukMd5nbiwRlEK6zRU7NBRujQ==
Date:   Tue, 26 Nov 2019 13:15:59 +0000
Message-ID: <20191126131541.47393-2-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e3fb669-0c71-4c9f-57c1-08d77272cdb8
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|DB6PR0801MB1671:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB16719C0ED6EC9107E82E0DC68F450@DB6PR0801MB1671.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2803;OLM:2803;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(5024004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pkFiXarJUqAfX5ax59j9bvPQfxDgOCg7YpKcF5pNm5x77H6QsiHQQ8wEZK07Ekf/lfdSpgrrnYNIJg67rvmr1kZSNxw5dMqe0Z0oporjEsSMb1+nQ8MbPeBeXYSKYEn2WKx1jN2Z1c7nbiHCVGRNpXRXXD1QmPTu6C0KxCvTSE4IrIoLsRNxdJ0jbyDWSagg4jl7l6nLpMB3nbZgtcHVHdq3MnMIukQoRLGtlm9O06DJ+ACPAmD+AuO2zZCPHVU2zmoqT5HbLXFyzyG3NFTL1Z+nYzwRYeNGw0d3fskacvKWjS8RmPjXnXgIHAkIaE9L8ng+qEU314pvMUKvie/O4d0hUH5fH8WUWGTbh+VM79lNa5tKelA8EfDPcMMATA8Isj4agLyRNrVDpke+k7qsOO60HEnNP0ZSMOrABm4jyaAIawF2Shg1yTEmemmBNv5q
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(336012)(76130400001)(2906002)(11346002)(6486002)(8676002)(8936002)(8746002)(386003)(5640700003)(305945005)(7736002)(6512007)(81166006)(86362001)(6506007)(2351001)(446003)(81156014)(76176011)(6116002)(36756003)(186003)(22756006)(3846002)(47776003)(66066001)(5024004)(26826003)(70206006)(102836004)(14454004)(23756003)(356004)(26005)(50466002)(478600001)(2501003)(54906003)(25786009)(4326008)(99286004)(316002)(1076003)(5660300002)(50226002)(2616005)(106002)(6862004)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1671;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 561161b2-5d04-4a7b-b109-08d77272c721
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHEj0SHbSUehb/hu3rlKmVSo1cYBUn/BuApKB70P7c+I28IbK4WUx80IjAwNHTwk7yF3+mIntoy9Utsc/Qe+mX19nZebDYdK5EPQG0iSUHGVTiy2H62uD92jBJOg0F5Hz8Dl34dsNbFYJQIVnhqoH9YP3XzzZdZVjeTL3idlK9p7OKFnrVgfg5RzT4JXFtdaEP8uaX+At36sVodlYmbCEKQa+qLuT1kP9VTq4DsNsYpvIxKiRhIslYnLX6WrLAUmbvVKdyRlD2Cp2UqJ1zpUJmjbTozX3RODVpCPy0rhisKcawGH1G+l6npEmxfOrFR/qXWEQciv8/qF/MRygvXG94kWpO8Z8I8zWRAjS+RwKoVdJouATdAEcC4Pu/k+jf5jz5H5GevQj9n4lSV40hAKrpj8zmlB9dxu2K+kk2Isx6XGo3ZVIAGDIm/n/519gvfR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:09.8752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3fb669-0c71-4c9f-57c1-08d77272cdb8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1671
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A simple convenience function to initialize the struct drm_bridge.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/drm_bridge.c | 29 +++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index cba537c99e43..cbe680aa6eac 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -89,6 +89,35 @@ void drm_bridge_remove(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_bridge_remove);
=20
+/**
+ * drm_bridge_init - initialise a drm_bridge structure
+ *
+ * @bridge: bridge control structure
+ * @funcs: control functions
+ * @dev: device
+ * @timings: timing specification for the bridge; optional (may be NULL)
+ * @driver_private: pointer to the bridge driver internal context (may be =
NULL)
+ */
+void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
+		     const struct drm_bridge_funcs *funcs,
+		     const struct drm_bridge_timings *timings,
+		     void *driver_private)
+{
+	WARN_ON(!funcs);
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
index c0a2286a81e9..d6d9d5301551 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -402,6 +402,10 @@ struct drm_bridge {
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

