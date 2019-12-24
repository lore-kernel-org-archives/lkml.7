Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A2EC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF4E2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ycDhivft";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ycDhivft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLXRe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:34:58 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:62625
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbfLXRew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74Er7HGJjw1Cwr3bFeUYspIQ5XLO7ZkancZfqNVar4k=;
 b=ycDhivftC93rR0pUMxG/HoLSv+0QxEXBdqMe9UPYQm9AFHFunOuREpJMIQvqsj6kTlk3rGmfmTCT3DChLCc+b70XVPaLbEFVND7w1qPi7Op/oI6Rrba99b2S0MN89LPnYhaen83P2YbGV5AO+wD5Xh7A+vzxWtChni+er8Mb/DU=
Received: from VI1PR08CA0123.eurprd08.prod.outlook.com (2603:10a6:800:d4::25)
 by HE1PR0801MB1740.eurprd08.prod.outlook.com (2603:10a6:3:88::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.16; Tue, 24 Dec
 2019 17:34:47 +0000
Received: from AM5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by VI1PR08CA0123.outlook.office365.com
 (2603:10a6:800:d4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:47 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT064.mail.protection.outlook.com (10.152.17.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:47 +0000
Received: ("Tessian outbound 0eaff1016ea4:v40"); Tue, 24 Dec 2019 17:34:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 647041dd202bc325
X-CR-MTA-TID: 64aa7808
Received: from bdd2edd0996c.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9028DC3C-AB21-4F1A-B25C-9CF4DAA2E21F.1;
        Tue, 24 Dec 2019 17:34:41 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bdd2edd0996c.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KI4mP7Zw9NfJlvIFdK/6Hw1lgCUogkxFtWp9y0c8Yw57lstS1MAHl3gW03QBqxRWSXrLw0MvIZgu2JJ9ajaww3UGKZdWDgLeRMwUbrTo+e6oBObaJOwqtPMA0IiL4jwnaENFMmqfNqlnNdDM9J9HvPrzy/vZjHPxGw7a7uhzL9fVQEwHW4PYjpKJoVX27SkGYWvj+RxGg99yf5DC6yqrGaCQT5TL7AilCLZQM6a6dqwpclcR5xIjfcWYQL83ZcomyVYcDu4gxxI2gJehts7AyZbJcgDquJBt0rPvMtWwLZhIoAn8jmI2Vk9BhOWsvvDSDduZoTkDEz7NFPT0X85Dwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74Er7HGJjw1Cwr3bFeUYspIQ5XLO7ZkancZfqNVar4k=;
 b=Dzn2y/ri5z5XeRXQhsq7x3yNJjMVgE8gmd1Di8DpY2v3JhaZxwhNPPMn2VFhrmLtSOLci2ykpI2hk35mCvMd4gddlIH7c4/NLGQ2wng4O8As+zbLow+Ljr22BEFiQaRMGq5tqxzqrvcxEN68ej4njNBdmFE5lH6pDm8QbfA2ttdf0EyVL1yV5IsOKqjyToQ+kITK8rb//1T80hIQgytD5l0NE8Thlp0P+MQIQc+bIP7J4Cr3IM2nG+eeMgOD6CJ9CROJUwP98hv7jGIKvIiPBtrfmuNsXY6SU7vAVwvgb0dKV1FXVQKdAG+u3rJBgXSPv2GEyM9wshUan0U6GQ5bRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74Er7HGJjw1Cwr3bFeUYspIQ5XLO7ZkancZfqNVar4k=;
 b=ycDhivftC93rR0pUMxG/HoLSv+0QxEXBdqMe9UPYQm9AFHFunOuREpJMIQvqsj6kTlk3rGmfmTCT3DChLCc+b70XVPaLbEFVND7w1qPi7Op/oI6Rrba99b2S0MN89LPnYhaen83P2YbGV5AO+wD5Xh7A+vzxWtChni+er8Mb/DU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2672.eurprd08.prod.outlook.com (10.170.238.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 17:34:37 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:37 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 17/35] drm/bridge: panel: Use drm_bridge_init()
Thread-Topic: [PATCH v3 17/35] drm/bridge: panel: Use drm_bridge_init()
Thread-Index: AQHVuoBpmY1c5Klab0qW7+hkdLtpeg==
Date:   Tue, 24 Dec 2019 17:34:36 +0000
Message-ID: <20191224173408.25624-18-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: ce6e036f-a86e-425b-64af-08d788979242
X-MS-TrafficTypeDiagnostic: VI1PR08MB2672:|VI1PR08MB2672:|HE1PR0801MB1740:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1740DCF2CA758B2A59360E588F290@HE1PR0801MB1740.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:176;OLM:176;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(26005)(52116002)(6506007)(6486002)(81166006)(6512007)(81156014)(8676002)(8936002)(44832011)(54906003)(478600001)(316002)(6916009)(2906002)(4326008)(2616005)(36756003)(1076003)(66446008)(64756008)(66556008)(66476007)(66946007)(4744005)(5660300002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2672;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: wcWghvz8NiLzq2Z4JNRdzJSi6cUehBlsWaz11eEnoc9pwHtxzRyYd1CtlSX++gL/dTS99opXownq0zeImIzScv5pw/1IWIv8FtmWv5c36QHr0DmL2qOIyvJCwkTXtWY+sTqFurGJuAyLsgVsJ1M3ZU9Yo2qMgdtuzANtaRG05021GckZGDbMTjf8kHAkIUfRFT1xFsEC/6jzgGb0iuzqbH70nxwHTjlxbVNo7z5nj4e1CjdX34DQkl+yZnXR7ED6L3MGB9NhYs1vMkG9buIVN8b0bMvjFSba3hnTw0rlS4DhUYEo84SfkWqTqRLPLcrvTHETjG87eYAszlkI2ZqWZw8/L4omxWWPqZCpnNa38yk7Fddjyt+t+acBwCm98Qg0gkLzUPX+QzM3sC5nmpp9l2SkL/p13QuLIsliCYYv63cGTof4D/xay++qm/gxcNlV
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(70206006)(81166006)(26826003)(4744005)(81156014)(70586007)(2906002)(478600001)(1076003)(6512007)(4326008)(6486002)(76130400001)(54906003)(8936002)(6506007)(356004)(6862004)(107886003)(86362001)(316002)(36906005)(186003)(2616005)(5660300002)(26005)(36756003)(336012)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1740;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: bb5b6ea5-0a63-4a85-fe16-08d788978c0d
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRLNRczC5oTv4WSx2IfRVAcQJhvsmVGvWtKBxs1mboVldKAtrmXcRJZ4uA+gj/H94GpcaqAxrxEFKHWBdTofJ6Mg5M1T8ds+F1PtOlzmGVKNqfE+xqKcTLNprxhdhqCg8LWIRQ7fqDrccxJIBnt3ncDvzjQ64Qb5M/Y7OOCZjUiPSSPyfplhmHScrU3OhB6nSviuwfb7FTm4UuzSPsFGL/wCIcTXZb5Kl6ejZPh8cZRvliGrjMoHaHmiNMN8BHmqyzHfCTCRMkjyJd9O3eZ3wBix8LsgEihvaoS1+J3wIrtXChnCG9FnGWjD2KRHh/76vKYpBKapK7g47gd1whkz3G875ZO4SIDW5Xm16ihTVXyzyWhPJcPtZd009KdQ/E+Ujfqhj3SMMwP3cAy8Am83Lm7vvL8ZE1REd0YSnDVy54RjwtoZsAtrC2uI4fxxaPeC
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:47.0777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6e036f-a86e-425b-64af-08d788979242
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

v3:
 - drop driver_private argument (Laurent)

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/panel.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.=
c
index 4ba4e9d9537a..b8a87a4956b6 100644
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
+			&panel_bridge_bridge_funcs, NULL);
 	drm_bridge_add(&panel_bridge->bridge);
=20
 	return &panel_bridge->bridge;
--=20
2.24.0

