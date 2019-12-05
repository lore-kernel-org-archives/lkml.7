Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDF6C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D7220801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oVj2u/tQ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oVj2u/tQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfLEQdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:33:33 -0500
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:45123
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729022AbfLEQdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSq8FaBNGYJm2IKQvAf45eqd7U2Okvuya8FX1MJXliE=;
 b=oVj2u/tQMC61QFybThqPZHpnJyhxtpImzNNPOv5VeXuKGQ41CKjqqjTwIghVNJ7XOtdu4BNHF5RVnzRrY8n54hvHL8Py6302nFwgRqboOLl58cOmUNHlWFBuqfetBRudI+s0ObJVpdQ4GWPy1vprGgDuKFhVqWDOuI8lAn8A/NU=
Received: from VI1PR08CA0118.eurprd08.prod.outlook.com (2603:10a6:800:d4::20)
 by AM6PR08MB3992.eurprd08.prod.outlook.com (2603:10a6:20b:a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Thu, 5 Dec
 2019 16:33:21 +0000
Received: from VE1EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR08CA0118.outlook.office365.com
 (2603:10a6:800:d4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Thu, 5 Dec 2019 16:33:21 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT013.mail.protection.outlook.com (10.152.19.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 5 Dec 2019 16:33:21 +0000
Received: ("Tessian outbound 1e3e4a1147b7:v37"); Thu, 05 Dec 2019 16:33:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cfb57c77134f187f
X-CR-MTA-TID: 64aa7808
Received: from 22f4eedd990a.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E15AF1D3-97EB-499F-A22C-EBE47F8E967A.1;
        Thu, 05 Dec 2019 16:30:51 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 22f4eedd990a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Dec 2019 16:30:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6CzBkqEK7Mb8S4rB7G/9JNq0DZLPqixvaB8moKsdXDO7Dv9Tm9savQdOMj7n1GLnnoItb2iPEr0+5UeR9Lfltem4Q0CyaKTtbu/W6XOTTuRjpICIB82BDhDqUZbTc4drVIwQY3/HFkMOEwy1BylFfxvSvqVQvUI1TM/A7js0NkWjOWuIsMhw2u8gTs37arf8T8FGVM60WnMosxN0Xdw4l0u/U9/wX6a1jrW5o2QGtMLdOhONu8/7Bu9O11I/SJ0/D4qUbVk33+b06wwsdHZIudEwmpCAm9YGgxn15ms6/cmESSMnt21y2q0YSKpAjDynlLrpKEGoRBiaafRnsUXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSq8FaBNGYJm2IKQvAf45eqd7U2Okvuya8FX1MJXliE=;
 b=kbKQPpQEPapad37i/U9V0L6/RQTXv06oQ3UrN6nVby3BFlYWq3pm63hA0GWurj40WUfimkwVkPOaLdEgMKw1oN5unhcbbll7O0zEH0ml5x43MLXxLVM7dN681Ddqp+TKHWu8Cxiy3knEAICwlt9VrXVYAcrlSSHJ4mOY0sQV53kg1Dtiivi3KSj9KzIpDvLlLIGtk5Bw76H2p0PstT0ndlqZJJGIHYnoCIjwvYcEV9rCouiysRRj1A4O3HlvX18rNGrG9uJTIM2fwf8k9wIRl0CdH4eLBWLW/wezCdk+g6A03cfR0YaRS6NsCQCjB5Y2B1mdzVU8zx8QzQTYRmuOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSq8FaBNGYJm2IKQvAf45eqd7U2Okvuya8FX1MJXliE=;
 b=oVj2u/tQMC61QFybThqPZHpnJyhxtpImzNNPOv5VeXuKGQ41CKjqqjTwIghVNJ7XOtdu4BNHF5RVnzRrY8n54hvHL8Py6302nFwgRqboOLl58cOmUNHlWFBuqfetBRudI+s0ObJVpdQ4GWPy1vprGgDuKFhVqWDOuI8lAn8A/NU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3726.eurprd08.prod.outlook.com (20.178.14.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 16:30:45 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 16:30:45 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] drm: Rename drm_bridge->dev to drm
Thread-Topic: [PATCH] drm: Rename drm_bridge->dev to drm
Thread-Index: AQHVq4lXPN/wPtLXyE2pxOrtyWLc3A==
Date:   Thu, 5 Dec 2019 16:30:45 +0000
Message-ID: <20191205163028.19941-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::14) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d27945bc-14c8-4a93-6d8a-08d779a0d788
X-MS-TrafficTypeDiagnostic: VI1PR08MB3726:|VI1PR08MB3726:|AM6PR08MB3992:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB39920CBDC2C36A9DB72617928F5C0@AM6PR08MB3992.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:249;OLM:249;
x-forefront-prvs: 02426D11FE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(199004)(189003)(66946007)(5640700003)(66476007)(66556008)(64756008)(66446008)(86362001)(6512007)(6486002)(6916009)(71200400001)(71190400001)(966005)(36756003)(478600001)(44832011)(305945005)(52116002)(54906003)(316002)(99286004)(7416002)(30864003)(5660300002)(8676002)(2906002)(14454004)(186003)(2616005)(8936002)(81156014)(81166006)(102836004)(6506007)(1076003)(50226002)(26005)(4326008)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3726;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: sJwks1A+7jlVJesgF3BXIxyt4elKjrMGJfyv/LR0tqiVKH5EcnkeElwylhL7BL7hv2eDwTdvuXzYIzQYH3NBcKR2bhNoL4ooCQddDlblD/9qW/5baRM0pXQ5j39NHHiNN/dQQHXeySzbgIc7lZYnLnWNf1yn6T+IkRBR8KYNUWxmpH2b7PDJuWETctgDqbEVMncUndyLMZnp8ngB7i56j1IPbPkOKxhEbMbcE77dHnb0RWTA0j83xJdq3Dk/SInctTIuuxezCmH6/KNKj/0tiUIBaISqIR/1CGWYi5yXF+TZ10aXD/kq2Ph1A6i1tgS+Dt0gGoJfFi4Z3PNTlUUsjM4miNT4Rsq4JENHeit9cvT5MKI5qjxSlW1zByCUx5gU7+ENkpzQA5dDg5Fnm/ZdQ5iXksxVNAx2EHOL7gLtM8IvAMLZfeX8Fz1Gnvdl8IWh6tHqMczb6tEspNzdDzc2Oc8Ohx74p0oeU9Sa4fwSnWs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3726
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(189003)(199004)(23756003)(70586007)(14454004)(70206006)(1076003)(102836004)(478600001)(30864003)(2906002)(8676002)(26826003)(99286004)(50466002)(5660300002)(6506007)(76130400001)(50226002)(966005)(36756003)(8936002)(107886003)(6486002)(336012)(86362001)(186003)(5640700003)(6512007)(2616005)(54906003)(316002)(25786009)(356004)(26005)(6862004)(22756006)(81166006)(4326008)(81156014)(36906005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3992;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 56d573dc-0ede-4453-632f-08d779a07a50
NoDisclaimer: True
X-Forefront-PRVS: 02426D11FE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phEOjAWjI6TP4BTthdvXjVurwjwTFoJgfXtMm+i/2VsSf8ytJ27oFwNqnFwrbIICk+vOcSCposf/yvChPpgbd2GW0Iki+iKf6Xk+6EN2lieImrLNa+DVxDthAypCSvx8+eDltv2K5hRdLGywHHSVKyWJKGc2JMIfeoObiv6tXxVGQSdgcwgwg8C4C1G3XlZQbRq4bRxR7mL3qeLgrRZIYlWc3pL0YRh+3U82DYF8065hVGco5mQjyBV874Fi1v5gEfZC5g3Cy5MwGXOu/DK+uYmR9Ny5/TgEjyLvSlKNnfNzq3vPo6d+rz1GjyiBmVRHSfG9u9s1OqFEwbPTwzpvtDLLuykUjpHJIcqylU71iB8wzD+xz3DhARZaoDHB9vaQ/G7UVFulXMSNHrX4TEsCgzZtnqQ2/Pj7Hlny17AIaaxcW1Jy590pmpTlSCKXH3bsanzi3TjW8CW8Zl7thYzImN5nyYUgM4p6Jqh9FOCtXO4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 16:33:21.2574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d27945bc-14c8-4a93-6d8a-08d779a0d788
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3992
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'dev' name causes some confusion with 'struct device' [1][2], so use
'drm' instead since this seems to be the prevalent name for 'struct
drm_device' members.

[1] https://patchwork.freedesktop.org/patch/342472/?series=3D70039&rev=3D1
[2] https://patchwork.freedesktop.org/patch/343643/?series=3D70432&rev=3D1

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c         |  2 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c   |  2 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c   |  2 +-
 drivers/gpu/drm/bridge/cdns-dsi.c                    |  2 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c                |  2 +-
 .../gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c |  2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c                 |  2 +-
 drivers/gpu/drm/bridge/panel.c                       |  2 +-
 drivers/gpu/drm/bridge/parade-ps8622.c               |  2 +-
 drivers/gpu/drm/bridge/sii902x.c                     |  6 +++---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c            |  6 +++---
 drivers/gpu/drm/bridge/tc358764.c                    |  4 ++--
 drivers/gpu/drm/bridge/tc358767.c                    |  6 +++---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                |  2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                   |  6 +++---
 drivers/gpu/drm/drm_bridge.c                         | 12 ++++++------
 drivers/gpu/drm/i2c/tda998x_drv.c                    |  2 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                      |  2 +-
 drivers/gpu/drm/msm/edp/edp_bridge.c                 |  2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c               |  4 ++--
 drivers/gpu/drm/rcar-du/rcar_lvds.c                  |  2 +-
 include/drm/drm_bridge.h                             |  4 ++--
 22 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm=
/bridge/adv7511/adv7511_drv.c
index 9e13e466e72c..db7d01cb0923 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -863,7 +863,7 @@ static int adv7511_bridge_attach(struct drm_bridge *bri=
dge)
 		adv->connector.polled =3D DRM_CONNECTOR_POLL_CONNECT |
 				DRM_CONNECTOR_POLL_DISCONNECT;
=20
-	ret =3D drm_connector_init(bridge->dev, &adv->connector,
+	ret =3D drm_connector_init(bridge->drm, &adv->connector,
 				 &adv7511_connector_funcs,
 				 DRM_MODE_CONNECTOR_HDMIA);
 	if (ret) {
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/g=
pu/drm/bridge/analogix/analogix-anx6345.c
index b4f3a923a52a..0e3508aeaa6c 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -541,7 +541,7 @@ static int anx6345_bridge_attach(struct drm_bridge *bri=
dge)
 		return err;
 	}
=20
-	err =3D drm_connector_init(bridge->dev, &anx6345->connector,
+	err =3D drm_connector_init(bridge->drm, &anx6345->connector,
 				 &anx6345_connector_funcs,
 				 DRM_MODE_CONNECTOR_eDP);
 	if (err) {
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/g=
pu/drm/bridge/analogix/analogix-anx78xx.c
index 41867be03751..d5722bc28933 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -908,7 +908,7 @@ static int anx78xx_bridge_attach(struct drm_bridge *bri=
dge)
 		return err;
 	}
=20
-	err =3D drm_connector_init(bridge->dev, &anx78xx->connector,
+	err =3D drm_connector_init(bridge->drm, &anx78xx->connector,
 				 &anx78xx_connector_funcs,
 				 DRM_MODE_CONNECTOR_DisplayPort);
 	if (err) {
diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdn=
s-dsi.c
index 3a5bd4e7fd1e..f6d7e97de66e 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -651,7 +651,7 @@ static int cdns_dsi_bridge_attach(struct drm_bridge *br=
idge)
 	struct cdns_dsi *dsi =3D input_to_dsi(input);
 	struct cdns_dsi_output *output =3D &dsi->output;
=20
-	if (!drm_core_check_feature(bridge->dev, DRIVER_ATOMIC)) {
+	if (!drm_core_check_feature(bridge->drm, DRIVER_ATOMIC)) {
 		dev_err(dsi->base.dev,
 			"cdns-dsi driver is only compatible with DRM devices supporting atomic =
updates");
 		return -ENOTSUPP;
diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge=
/dumb-vga-dac.c
index cc33dc411b9e..30b5e54df381 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -112,7 +112,7 @@ static int dumb_vga_attach(struct drm_bridge *bridge)
=20
 	drm_connector_helper_add(&vga->connector,
 				 &dumb_vga_con_helper_funcs);
-	ret =3D drm_connector_init_with_ddc(bridge->dev, &vga->connector,
+	ret =3D drm_connector_init_with_ddc(bridge->drm, &vga->connector,
 					  &dumb_vga_con_funcs,
 					  DRM_MODE_CONNECTOR_VGA,
 					  vga->ddc);
diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/dri=
vers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index e8a49f6146c6..ab06394cfff7 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -223,7 +223,7 @@ static int ge_b850v3_lvds_attach(struct drm_bridge *bri=
dge)
 	drm_connector_helper_add(connector,
 				 &ge_b850v3_lvds_connector_helper_funcs);
=20
-	ret =3D drm_connector_init(bridge->dev, connector,
+	ret =3D drm_connector_init(bridge->drm, connector,
 				 &ge_b850v3_lvds_connector_funcs,
 				 DRM_MODE_CONNECTOR_DisplayPort);
 	if (ret) {
diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/=
nxp-ptn3460.c
index 57ff01339559..714cb954522a 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -247,7 +247,7 @@ static int ptn3460_bridge_attach(struct drm_bridge *bri=
dge)
 	}
=20
 	ptn_bridge->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
-	ret =3D drm_connector_init(bridge->dev, &ptn_bridge->connector,
+	ret =3D drm_connector_init(bridge->drm, &ptn_bridge->connector,
 			&ptn3460_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
 	if (ret) {
 		DRM_ERROR("Failed to initialize connector with drm\n");
diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.=
c
index f4e293e7cf64..7ed3b3e85f03 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -67,7 +67,7 @@ static int panel_bridge_attach(struct drm_bridge *bridge)
 	drm_connector_helper_add(connector,
 				 &panel_bridge_connector_helper_funcs);
=20
-	ret =3D drm_connector_init(bridge->dev, connector,
+	ret =3D drm_connector_init(bridge->drm, connector,
 				 &panel_bridge_connector_funcs,
 				 panel_bridge->connector_type);
 	if (ret) {
diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridg=
e/parade-ps8622.c
index b7a72dfdcac3..18cc693734b3 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -487,7 +487,7 @@ static int ps8622_attach(struct drm_bridge *bridge)
 	}
=20
 	ps8622->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
-	ret =3D drm_connector_init(bridge->dev, &ps8622->connector,
+	ret =3D drm_connector_init(bridge->drm, &ps8622->connector,
 			&ps8622_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
 	if (ret) {
 		DRM_ERROR("Failed to initialize connector with drm\n");
diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii9=
02x.c
index b70e8c5cf2e1..3d8b3e1eb0aa 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -402,7 +402,7 @@ static void sii902x_bridge_mode_set(struct drm_bridge *=
bridge,
 static int sii902x_bridge_attach(struct drm_bridge *bridge)
 {
 	struct sii902x *sii902x =3D bridge_to_sii902x(bridge);
-	struct drm_device *drm =3D bridge->dev;
+	struct drm_device *drm =3D bridge->drm;
 	int ret;
=20
 	drm_connector_helper_add(&sii902x->connector,
@@ -820,8 +820,8 @@ static irqreturn_t sii902x_interrupt(int irq, void *dat=
a)
=20
 	mutex_unlock(&sii902x->mutex);
=20
-	if ((status & SII902X_HOTPLUG_EVENT) && sii902x->bridge.dev)
-		drm_helper_hpd_irq_event(sii902x->bridge.dev);
+	if ((status & SII902X_HOTPLUG_EVENT) && sii902x->bridge.drm)
+		drm_helper_hpd_irq_event(sii902x->bridge.drm);
=20
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/br=
idge/synopsys/dw-hdmi.c
index dbe38a54870b..7a549cce8536 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2346,7 +2346,7 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *b=
ridge)
=20
 	drm_connector_helper_add(connector, &dw_hdmi_connector_helper_funcs);
=20
-	drm_connector_init_with_ddc(bridge->dev, connector,
+	drm_connector_init_with_ddc(bridge->drm, connector,
 				    &dw_hdmi_connector_funcs,
 				    DRM_MODE_CONNECTOR_HDMIA,
 				    hdmi->ddc);
@@ -2554,8 +2554,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
 		dev_dbg(hdmi->dev, "EVENT=3D%s\n",
 			phy_int_pol & HDMI_PHY_HPD ? "plugin" : "plugout");
-		if (hdmi->bridge.dev)
-			drm_helper_hpd_irq_event(hdmi->bridge.dev);
+		if (hdmi->bridge.drm)
+			drm_helper_hpd_irq_event(hdmi->bridge.drm);
 	}
=20
 	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/tc3=
58764.c
index db298f550a5a..1744d7daa534 100644
--- a/drivers/gpu/drm/bridge/tc358764.c
+++ b/drivers/gpu/drm/bridge/tc358764.c
@@ -352,7 +352,7 @@ static void tc358764_enable(struct drm_bridge *bridge)
 static int tc358764_attach(struct drm_bridge *bridge)
 {
 	struct tc358764 *ctx =3D bridge_to_tc358764(bridge);
-	struct drm_device *drm =3D bridge->dev;
+	struct drm_device *drm =3D bridge->drm;
 	int ret;
=20
 	ctx->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
@@ -378,7 +378,7 @@ static int tc358764_attach(struct drm_bridge *bridge)
 static void tc358764_detach(struct drm_bridge *bridge)
 {
 	struct tc358764 *ctx =3D bridge_to_tc358764(bridge);
-	struct drm_device *drm =3D bridge->dev;
+	struct drm_device *drm =3D bridge->drm;
=20
 	drm_connector_unregister(&ctx->connector);
 	drm_fb_helper_remove_one_connector(drm->fb_helper, &ctx->connector);
diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc3=
58767.c
index 8029478ffebb..fccacd12bb53 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1407,7 +1407,7 @@ static int tc_bridge_attach(struct drm_bridge *bridge=
)
 {
 	u32 bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
 	struct tc_data *tc =3D bridge_to_tc(bridge);
-	struct drm_device *drm =3D bridge->dev;
+	struct drm_device *drm =3D bridge->drm;
 	int ret;
=20
 	/* Create DP/eDP connector */
@@ -1514,7 +1514,7 @@ static irqreturn_t tc_irq_handler(int irq, void *arg)
 		dev_err(tc->dev, "syserr %x\n", stat);
 	}
=20
-	if (tc->hpd_pin >=3D 0 && tc->bridge.dev) {
+	if (tc->hpd_pin >=3D 0 && tc->bridge.drm) {
 		/*
 		 * H is triggered when the GPIO goes high.
 		 *
@@ -1528,7 +1528,7 @@ static irqreturn_t tc_irq_handler(int irq, void *arg)
 			h ? "H" : "", lc ? "LC" : "");
=20
 		if (h || lc)
-			drm_kms_helper_hotplug_event(tc->bridge.dev);
+			drm_kms_helper_hotplug_event(tc->bridge.drm);
 	}
=20
 	regmap_write(tc->regmap, INTSTS_G, val);
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge=
/ti-sn65dsi86.c
index 43abf01ebd4c..23576c3fac9f 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -275,7 +275,7 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridg=
e)
 						   .node =3D NULL,
 						 };
=20
-	ret =3D drm_connector_init(bridge->dev, &pdata->connector,
+	ret =3D drm_connector_init(bridge->drm, &pdata->connector,
 				 &ti_sn_bridge_connector_funcs,
 				 DRM_MODE_CONNECTOR_eDP);
 	if (ret) {
diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti=
-tfp410.c
index aa3198dc9903..cae9fd584ff1 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -135,7 +135,7 @@ static int tfp410_attach(struct drm_bridge *bridge)
=20
 	drm_connector_helper_add(&dvi->connector,
 				 &tfp410_con_helper_funcs);
-	ret =3D drm_connector_init_with_ddc(bridge->dev, &dvi->connector,
+	ret =3D drm_connector_init_with_ddc(bridge->drm, &dvi->connector,
 					  &tfp410_con_funcs,
 					  dvi->connector_type,
 					  dvi->ddc);
@@ -179,8 +179,8 @@ static void tfp410_hpd_work_func(struct work_struct *wo=
rk)
=20
 	dvi =3D container_of(work, struct tfp410, hpd_work.work);
=20
-	if (dvi->bridge.dev)
-		drm_helper_hpd_irq_event(dvi->bridge.dev);
+	if (dvi->bridge.drm)
+		drm_helper_hpd_irq_event(dvi->bridge.drm);
 }
=20
 static irqreturn_t tfp410_hpd_irq_thread(int irq, void *arg)
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index cba537c99e43..80f7a1aa969e 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -119,19 +119,19 @@ int drm_bridge_attach(struct drm_encoder *encoder, st=
ruct drm_bridge *bridge,
 	if (!encoder || !bridge)
 		return -EINVAL;
=20
-	if (previous && (!previous->dev || previous->encoder !=3D encoder))
+	if (previous && (!previous->drm || previous->encoder !=3D encoder))
 		return -EINVAL;
=20
-	if (bridge->dev)
+	if (bridge->drm)
 		return -EBUSY;
=20
-	bridge->dev =3D encoder->dev;
+	bridge->drm =3D encoder->dev;
 	bridge->encoder =3D encoder;
=20
 	if (bridge->funcs->attach) {
 		ret =3D bridge->funcs->attach(bridge);
 		if (ret < 0) {
-			bridge->dev =3D NULL;
+			bridge->drm =3D NULL;
 			bridge->encoder =3D NULL;
 			return ret;
 		}
@@ -151,13 +151,13 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 	if (WARN_ON(!bridge))
 		return;
=20
-	if (WARN_ON(!bridge->dev))
+	if (WARN_ON(!bridge->drm))
 		return;
=20
 	if (bridge->funcs->detach)
 		bridge->funcs->detach(bridge);
=20
-	bridge->dev =3D NULL;
+	bridge->drm =3D NULL;
 }
=20
 /**
diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998=
x_drv.c
index a63790d32d75..fa430e43f5ad 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1360,7 +1360,7 @@ static int tda998x_bridge_attach(struct drm_bridge *b=
ridge)
 {
 	struct tda998x_priv *priv =3D bridge_to_tda998x_priv(bridge);
=20
-	return tda998x_connector_init(priv, bridge->dev);
+	return tda998x_connector_init(priv, bridge->drm);
 }
=20
 static void tda998x_bridge_detach(struct drm_bridge *bridge)
diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_ds=
i.c
index 42fff811653e..4ef14d5cdcb6 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -846,7 +846,7 @@ static void mcde_dsi_bridge_disable(struct drm_bridge *=
bridge)
 static int mcde_dsi_bridge_attach(struct drm_bridge *bridge)
 {
 	struct mcde_dsi *d =3D bridge_to_mcde_dsi(bridge);
-	struct drm_device *drm =3D bridge->dev;
+	struct drm_device *drm =3D bridge->drm;
 	int ret;
=20
 	if (!drm_core_check_feature(drm, DRIVER_ATOMIC)) {
diff --git a/drivers/gpu/drm/msm/edp/edp_bridge.c b/drivers/gpu/drm/msm/edp=
/edp_bridge.c
index 2950bba4aca9..a329c7a79d8d 100644
--- a/drivers/gpu/drm/msm/edp/edp_bridge.c
+++ b/drivers/gpu/drm/msm/edp/edp_bridge.c
@@ -47,7 +47,7 @@ static void edp_bridge_mode_set(struct drm_bridge *bridge=
,
 		const struct drm_display_mode *mode,
 		const struct drm_display_mode *adjusted_mode)
 {
-	struct drm_device *dev =3D bridge->dev;
+	struct drm_device *dev =3D bridge->drm;
 	struct drm_connector *connector;
 	struct edp_bridge *edp_bridge =3D to_edp_bridge(bridge);
 	struct msm_edp *edp =3D edp_bridge->edp;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/h=
dmi/hdmi_bridge.c
index ba81338a9bf8..0add3c88a13e 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -20,7 +20,7 @@ void msm_hdmi_bridge_destroy(struct drm_bridge *bridge)
=20
 static void msm_hdmi_power_on(struct drm_bridge *bridge)
 {
-	struct drm_device *dev =3D bridge->dev;
+	struct drm_device *dev =3D bridge->drm;
 	struct hdmi_bridge *hdmi_bridge =3D to_hdmi_bridge(bridge);
 	struct hdmi *hdmi =3D hdmi_bridge->hdmi;
 	const struct hdmi_platform_config *config =3D hdmi->config;
@@ -56,7 +56,7 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
=20
 static void power_off(struct drm_bridge *bridge)
 {
-	struct drm_device *dev =3D bridge->dev;
+	struct drm_device *dev =3D bridge->drm;
 	struct hdmi_bridge *hdmi_bridge =3D to_hdmi_bridge(bridge);
 	struct hdmi *hdmi =3D hdmi_bridge->hdmi;
 	const struct hdmi_platform_config *config =3D hdmi->config;
diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/=
rcar_lvds.c
index 8c6c172bbf2e..12fcfbf31968 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -622,7 +622,7 @@ static int rcar_lvds_attach(struct drm_bridge *bridge)
 	if (!lvds->panel)
 		return 0;
=20
-	ret =3D drm_connector_init(bridge->dev, connector, &rcar_lvds_conn_funcs,
+	ret =3D drm_connector_init(bridge->drm, connector, &rcar_lvds_conn_funcs,
 				 DRM_MODE_CONNECTOR_LVDS);
 	if (ret < 0)
 		return ret;
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index c0a2286a81e9..795860200ebf 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -376,8 +376,8 @@ struct drm_bridge_timings {
  * struct drm_bridge - central DRM bridge control structure
  */
 struct drm_bridge {
-	/** @dev: DRM device this bridge belongs to */
-	struct drm_device *dev;
+	/** @drm: DRM device this bridge belongs to */
+	struct drm_device *drm;
 	/** @encoder: encoder to which this bridge is connected */
 	struct drm_encoder *encoder;
 	/** @next: the next bridge in the encoder chain */
--=20
2.23.0

