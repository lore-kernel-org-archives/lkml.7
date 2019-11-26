Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1B9C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28872084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="n6j5qno9";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="n6j5qno9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfKZNRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:17:33 -0500
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:62607
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728096AbfKZNQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vilsu5jMSNUi3GIXJ8OzL1XJBLxVssM7Swc8d5oAicw=;
 b=n6j5qno9iQAUpFoxgICFX2aqCqv76MB6uHcSJscFq5u10lFZ8t46hmHPUkT6XR8WwE/GVKay4mHNrp+pRhEDGRvM5WBLXRQ1XO0DLqaEkj3tOJZYXeYzP0wTmCWijILHT9EXnlYqfJ5k4+lYAXz96df1t9Gb/v9kGwAzFnx49dI=
Received: from VI1PR08CA0091.eurprd08.prod.outlook.com (2603:10a6:800:d3::17)
 by AM6PR08MB5016.eurprd08.prod.outlook.com (2603:10a6:20b:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21; Tue, 26 Nov
 2019 13:16:27 +0000
Received: from VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR08CA0091.outlook.office365.com
 (2603:10a6:800:d3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:27 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT024.mail.protection.outlook.com (10.152.18.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:27 +0000
Received: ("Tessian outbound 512f710540da:v33"); Tue, 26 Nov 2019 13:16:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 14a54b3d4b260c8d
X-CR-MTA-TID: 64aa7808
Received: from 1f05e3404f54.4 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A14B7087-685A-4C15-A8D8-618B226C6238.1;
        Tue, 26 Nov 2019 13:16:15 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1f05e3404f54.4
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hg5HC5WqpZBW1W5iW7RgTmYyvLi3EzhqdcVteoTkP5/xjzG6jjSSFMeWhpRlPaZm71bZ01ntdPDblfC1dwLAUXHqMa+CP+N8g9cPrcPKxCmYRbmb1gS5+3Y8KKX9skTme715TEyssbGYjw8ebYykSTsTJbcxcxPj0PGJynW7rb8Fslf1Z2B8UukfyyR/v8DTWfbMRwlY27ztPCzkklrfe+voH1QsLkW8vTxEcTZHuIogrK6qvJWUHbfpEfurOOxdM9yN37vJlFV3oygxBCAcwmeOTsvtLoRuPfu3wYyhhyLxDoDDTdiCtuWU24AJSKDGnyUS5aVmHv/a5vGO1j5cHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vilsu5jMSNUi3GIXJ8OzL1XJBLxVssM7Swc8d5oAicw=;
 b=TU/wxXzc65EkjrwiL42/5l9dk4jHK4ZRy4j269QTSujLHQH+meUL/Nd2tod4dmPf3mi2ovdnHYqceZYKEugvHVED5jODPxhEkWLijyD8d1XtzSNrwwncW21F1aOFYUGHvuJtz47kQ4VNnm8fXZCayPF1kqiET7B6RQmuE84Emw+3VeXnfeK4QVDNf4Q5esPNMr8ifOWbKpaFkcnx3Sel6ZBfnPLTMvcpjxh+BesnpjDRVifjvPmYApnZBtzXa6IVOCw7HJvEinxhwE7UbdgNHmjqKsdaPpBnr3Ml3uYCm9H9j+SgereHOG+2SJTO57NaD2tdTfymkUXa6eV5d/z5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vilsu5jMSNUi3GIXJ8OzL1XJBLxVssM7Swc8d5oAicw=;
 b=n6j5qno9iQAUpFoxgICFX2aqCqv76MB6uHcSJscFq5u10lFZ8t46hmHPUkT6XR8WwE/GVKay4mHNrp+pRhEDGRvM5WBLXRQ1XO0DLqaEkj3tOJZYXeYzP0wTmCWijILHT9EXnlYqfJ5k4+lYAXz96df1t9Gb/v9kGwAzFnx49dI=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:14 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:14 +0000
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
Subject: [PATCH 15/30] drm/bridge: dw-hdmi: Use drm_bridge_init()
Thread-Topic: [PATCH 15/30] drm/bridge: dw-hdmi: Use drm_bridge_init()
Thread-Index: AQHVpFutBY9NvXIj8kOLyzzzKOI9DA==
Date:   Tue, 26 Nov 2019 13:16:13 +0000
Message-ID: <20191126131541.47393-16-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 758d3271-dc8b-4d45-ba21-08d77272d81c
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|AM6PR08MB5016:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5016FB8EBB43326785B0AB998F450@AM6PR08MB5016.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:176;OLM:176;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(7416002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 2zd+vT0h3SviPrE0eHCowk83FuOxGhECEAs6rMgVcYhXv1PHOItTfHL9b5myzw46+pzLBphmUctKLvvLu1Ih6aglWV785SRBc2vE6eRNhGv1rPcOJC9bcqfZG1uy1gGE31h6/GkDTE7s3lNE/jMbFeTzAqMzisXp+XrNX3ohmyY+0DH5bLY/hs7rTwq1UaOhzQ3+yl1ggQyvD+yjPJ2Go+/rRB0vxToM4JaVfmlsROdb7BxtTbMFETxHjstQ8EzUESTwZmf6k6WHh5o0wQIEicD2SFjnvec+ZczpOJldLHr/IVMUxE73pz0kYJDnK2zknnNAwLMqqgXqrUUawxl4Y3JS9pnjZb82Cbx/aMaQ1qnlNjDJ9JIEGeJuM1+k8P7PRBmfbYaF3LFJM+G3oQxTNJGypXM2oT5hz/DnvnzjVX0blhBZ9VB2sngLCRigeCeJ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(86362001)(26826003)(5640700003)(25786009)(4326008)(2906002)(186003)(6116002)(478600001)(2351001)(6486002)(7736002)(8746002)(2501003)(446003)(8936002)(70206006)(5660300002)(70586007)(22756006)(14454004)(81156014)(81166006)(8676002)(36756003)(6862004)(2616005)(336012)(50226002)(3846002)(50466002)(6506007)(4744005)(47776003)(76176011)(1076003)(356004)(99286004)(11346002)(26005)(106002)(316002)(102836004)(66066001)(54906003)(6512007)(386003)(23756003)(76130400001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5016;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1f4c26f0-fb9a-48ec-f61a-08d77272cfef
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SG6YdjZus8i8H0s8IxLD0adqUrPuls8rXjQHwtLZCtrydvGcSTlxX3nrhuMtNsMaS1H5x1dRtmc/8s6U+A2qVDAVnRia10g8YsNcMDEGKx1k5Hb1VZNFbD/YmHvY2reHKgr71dcFvOD3UPihkoqrJpzp1Vdzi0m9bToRtr0KYeN6hMqyYXJuzjEIyHKKqh18d3+xq5p7r+kO4i/gdiThVKQ+nqZWF9pdoIq8+mDXUHHAX/4E2PrmHAn3zLERnPM0N43gXr3Vv3z2l8OPIcgXWYh8zy6ZXYnheZe5lkx184ubP3b2cD3xsNh9+KlnGepxlhSgn6GcScvRYPSwH14qKswLZUDT+qJ9Aic6wEQit+hjXu722RXPJwosPUX4QDSND26gVC77TPrOUndaSF1cBy9HbY3SMfIpyvGhvfmbJgznwmVCrKx29j0gE86ji8X7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:27.2753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 758d3271-dc8b-4d45-ba21-08d77272d81c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5016
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

