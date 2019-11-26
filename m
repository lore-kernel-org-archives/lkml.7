Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B69C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C66A2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fND/uxG6";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fND/uxG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfKZNQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:26 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:58080
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727777AbfKZNQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKX2QEoiMcI48kOVP6yPNKCVpbRPSGyLW7NiFE2+cdA=;
 b=fND/uxG6DmCfQDDILWaeafM+Hw6cyX1VXsbrWPN/n2BDe70Neb8wTV9Bh14r0j8mUw3qBkkQL/pFn9yAs/AX38n5ZRfzVCs5mYAGhrA2KmD7HeUEGUv1OeQW0bRGmMUlnF1MqDOqcckyl6CiERIH/UPkmPhWJTYeEq1bSfeRGvk=
Received: from VI1PR08CA0187.eurprd08.prod.outlook.com (2603:10a6:800:d2::17)
 by DB6PR08MB2647.eurprd08.prod.outlook.com (2603:10a6:6:22::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Tue, 26 Nov
 2019 13:16:18 +0000
Received: from AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by VI1PR08CA0187.outlook.office365.com
 (2603:10a6:800:d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:18 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT020.mail.protection.outlook.com (10.152.16.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:18 +0000
Received: ("Tessian outbound a8f166c1f585:v33"); Tue, 26 Nov 2019 13:16:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 51c551ae3758d5a3
X-CR-MTA-TID: 64aa7808
Received: from 968035f9f19d.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A4DF99FB-5B7C-4452-B961-7A65C670F671.1;
        Tue, 26 Nov 2019 13:16:10 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2052.outbound.protection.outlook.com [104.47.10.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 968035f9f19d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pqsx+q7WO6s7kCgm44ng7zRUM3Gnv11VAn0ggNwNTawiJ9FQ4MMUZjne5dxj6gwrqzHRoKBwpTWxnPhr1KCcfioNCc6e+WaCrNafWvmEYfpBOT++uVXeAyy1C+2QqIW1jIEWryaVNWNJCVt20vRFl9UeAV83JCzadGyzmR8haQ5UAcdIJ3CQocYXkc0d8la18yzsLSmGWOzxiQ3dQ8/+HJffmqAR5HOyQyR9EnjctaUpT/MgQAkMxlHrWtSU0Rh22saicd2A06uJjhu/ZPjH7FXtTeiVd3L32kpSAZ4Q3zIA9ZQXPp2zxwkWAkEPrrxoh+esbmmNMHO60WOkbMmGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKX2QEoiMcI48kOVP6yPNKCVpbRPSGyLW7NiFE2+cdA=;
 b=crCVIXr9Syiv1xmtQnEKT+ThJqSX7Jnwfjj9gPEb4QNilDu8eCDyOxm2fQIox43GjXWPQ8y/njYLlWLpJRB2+e58vzN/lxbOu7OiRlCT/oWikChLsOIdfvJenkpRK1Sht8VbQfW9vmT6xZ0DywnOHi8Oh1spiFcMUdtUafepR6DohK5atMMoiEv2hRIcrlndcYdOpP9D/o9OXQmx1IRJheVgQeLdcaAkmW1VNEOura9LrseOqAWCchHecmxRCOpJQrc0lTHjATLqlyHc0sRl7OW7PI7jjgZjtE6WB9/ToSOUX0xHSoZ+glvlpV+0jffe4IyD7cFJ9rDJtrNmMtBSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKX2QEoiMcI48kOVP6yPNKCVpbRPSGyLW7NiFE2+cdA=;
 b=fND/uxG6DmCfQDDILWaeafM+Hw6cyX1VXsbrWPN/n2BDe70Neb8wTV9Bh14r0j8mUw3qBkkQL/pFn9yAs/AX38n5ZRfzVCs5mYAGhrA2KmD7HeUEGUv1OeQW0bRGmMUlnF1MqDOqcckyl6CiERIH/UPkmPhWJTYeEq1bSfeRGvk=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:08 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:08 +0000
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
Subject: [PATCH 10/30] drm/bridge: panel: Use drm_bridge_init()
Thread-Topic: [PATCH 10/30] drm/bridge: panel: Use drm_bridge_init()
Thread-Index: AQHVpFuq5irvJSnAN0+ujiTuPMRYMw==
Date:   Tue, 26 Nov 2019 13:16:08 +0000
Message-ID: <20191126131541.47393-11-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 86898401-5fc8-4c3e-f509-08d77272d2e1
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|DB6PR08MB2647:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB2647B2B4576B3018DA17A89A8F450@DB6PR08MB2647.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:176;OLM:176;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: A3NozrP8WLfq2LchbEEdCkQfd3zsfHgS7FCm7JLug0RzxG1F6ANw/7utf44ziNKp/Uz6VY9jIQ6Ctjui5HsB2cbPXqaylwPDux8TuxkS7fVwTQYE5eXT1hegtZhFtSYLrKxUj4e6HxgIogmauyd3/Ymuz/3AkqSs5/qvYhJFzceT9kgwI/d4NqfBLFEzSRtKlBh/cqJstiZb6Ua3IkTvh6firUkZ7Lf/5wtK36wgEE+Z2FLwz2dfj+rAp0lLThCKZ1dPtTqG3WaWVdfqioIFR1F8iD7DJm296ln8JflVqZX4Q1r/HRqJhKiuOQyyTnM2NOLiGbXI+RlMDJliGa1t3KexdgEopqUWypjgkKOn2KgcR58j5uSWQxC1c3RmNVcxxpMtPH7V1hB65nHPA5x0DBt1AJOG4iwGrZmeN7n+9bpNw/78OJCr6KZZ7+0sd6XM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(199004)(189003)(316002)(2616005)(81156014)(2906002)(81166006)(76176011)(446003)(25786009)(8676002)(2501003)(6512007)(11346002)(70586007)(102836004)(2351001)(50226002)(305945005)(26005)(36756003)(76130400001)(4744005)(23756003)(14454004)(8746002)(1076003)(186003)(36906005)(5640700003)(86362001)(478600001)(70206006)(6116002)(8936002)(3846002)(22756006)(5660300002)(50466002)(7736002)(336012)(26826003)(356004)(4326008)(47776003)(99286004)(386003)(6506007)(6862004)(106002)(54906003)(66066001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2647;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e08b4ffd-ff82-4325-222b-08d77272ccba
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUQM/MHp9rDNl0BSP+H7lBGInTJQglHxD3tCFRqL1yTy7gZ7hLLGrZKbju2hvbY0U9Fw1aL8LSVrj8uaI7MpxS5O05FE4ApClCGUheyQg7Z1WrYKtWVN5Q5gzDSwUaPbEgjfGTXTIcCRugEst47gda2/n33wiSrssFcyDenKBRDHaVv2Nswth1jOeT4X5Y4Wlz+j/4JNm+ikFszZTXLzJx5/mTVTCj/+wGRFykTnyuRBy/iL9otugF7U8W57S4pX3rn3IcgJ09rWRSRoZT49rDQRJFANnYWFi9N7Gxa6f7i0+oQK/AoJM0XzQw3nf/LNw7dXFZNAY77Rc7mQzigDZmPPHevhi6/f6E+paw45XL+SXW9b9UmrMZ8XtIPKxFBLcgd8h5kKP1QmeuyneHU8gy1+jqLFszGgV2RbqrMSouX0vtLcO5NMCsnR0PfpIaGT
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:18.5485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86898401-5fc8-4c3e-f509-08d77272d2e1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2647
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

