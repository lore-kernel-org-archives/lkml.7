Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E6EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5878F2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tF1eOEzl";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tF1eOEzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfKZNRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:17:37 -0500
Received: from mail-eopbgr150042.outbound.protection.outlook.com ([40.107.15.42]:17671
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728095AbfKZNQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=277eEL94M2rHw20NJBX8K+BY/jR4YETRuPROMMFpHfU=;
 b=tF1eOEzlOQp76zat/U8OVR7N7/NUkihEyCJo5KHQlq/1dYPJSmu0Ko1u3IJM0Q+au8d8sf+9mJFDjAelLmbBsMnhG8bljm7xwCfEKfkGYknOr3qLxPIvYetlxsi1ziAGom7XKjqNJ3UsuHB0RyzW2pLhLeOcPUBqhj13AtTDUIY=
Received: from DB6PR0802CA0037.eurprd08.prod.outlook.com (2603:10a6:4:a3::23)
 by AM0PR08MB4435.eurprd08.prod.outlook.com (2603:10a6:208:144::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Tue, 26 Nov
 2019 13:16:28 +0000
Received: from VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by DB6PR0802CA0037.outlook.office365.com
 (2603:10a6:4:a3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:28 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT012.mail.protection.outlook.com (10.152.18.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:28 +0000
Received: ("Tessian outbound f7868d7ede10:v33"); Tue, 26 Nov 2019 13:16:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cdcfc23dc0b3637b
X-CR-MTA-TID: 64aa7808
Received: from 206d54aa05cd.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6AB2C9AA-EDBB-45A7-90F3-A373C9AAD4DD.1;
        Tue, 26 Nov 2019 13:16:16 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2058.outbound.protection.outlook.com [104.47.10.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 206d54aa05cd.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qrar5kHH41BVuZLRO0jxVyDHRiocfjmimFLrDYuEnv6Y2pM0Shb9MFLgf1MEsyAGdhS+eG+bZoYeRBgLHLWq+m1ZmtjzVzyK65JhPgaP812NsYwjQt7HA0XAVgZy+b9BIy0cxWQVvQ6nx6JZJeHSgngWu7df84qVqoY3KW1miDi+sCMSjemzGht0ffzqky+HfXccDQ0a0oeQ5U3avFOQBi/AQoi53LMX6VFIXZOF9FVtq3fCFpK6CT2fA7QBAamGPBijs/B4ceN8/lwlGtW2zD5r4CXkjCRxOW03ZI5ugZKO9/JlZ3blkLlbxyjWIob86NqcS350Nd+OUectWDN9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=277eEL94M2rHw20NJBX8K+BY/jR4YETRuPROMMFpHfU=;
 b=KrIQF50cu8q8cfulDMTBgeTVtfBWq0O3BbQgG8R+49zotCfJoHeglFtyEK4yEgAlLEwM6MMv/HsgKR4VwMRumrFkVG4URXm50jK/zrulUz2L9V4mRvj6Fyo1ZzM5ccN343vuBp8zWlNL4Q+evNFMf2vPh3DfzgtPBlXR/jrumpbdR09XuflvOx2zaWt12uRtc6wrKTb9x+EDUjix5l4Gc0G0ghwf40NMciM1YCf3JaKEcBaHLVFVuZP4TO08enqXIxW2hCov63A5onb3qFmq6N/rfy0N1k3SgnCurxAX54jg+HMrPKq9qwC0mpl+GGSrGqTGe2oQaT6mAkz6+UvP4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=277eEL94M2rHw20NJBX8K+BY/jR4YETRuPROMMFpHfU=;
 b=tF1eOEzlOQp76zat/U8OVR7N7/NUkihEyCJo5KHQlq/1dYPJSmu0Ko1u3IJM0Q+au8d8sf+9mJFDjAelLmbBsMnhG8bljm7xwCfEKfkGYknOr3qLxPIvYetlxsi1ziAGom7XKjqNJ3UsuHB0RyzW2pLhLeOcPUBqhj13AtTDUIY=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:15 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:15 +0000
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
        =?iso-8859-1?Q?Yannick_Fertr=E9?= <yannick.fertre@st.com>,
        Matt Redfearn <matt.redfearn@thinci.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 16/30] drm/bridge/synopsys: dsi: Use drm_bridge_init()
Thread-Topic: [PATCH 16/30] drm/bridge/synopsys: dsi: Use drm_bridge_init()
Thread-Index: AQHVpFuuu7uz+7T4vkyXcqiSDJ7s7w==
Date:   Tue, 26 Nov 2019 13:16:15 +0000
Message-ID: <20191126131541.47393-17-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: cc007d0c-8baa-4185-841c-08d77272d8ac
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|AM0PR08MB4435:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB44350EC9BAFE46052C94AAF38F450@AM0PR08MB4435.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:176;OLM:176;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(7416002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 1dEWGvytWJJ9YspW5ENK8y3MBEkBuSyp949tejwzIayrSy59ueAc5L5kC7pePLBS51lrJd/c7b1buHZeoPX+nWc4gnjhTef+Ck9jOcsZtPDqAmNWD2s5IE0VkeLhwxjCYGR0IIpFxZI9smFPpDpeVkVC4ztvALXigfcSwqwiCuahxMh5Vk1XfBOImaBbAcdyQpdnRaVQVtwvXC8pr/33nvhhO1GUmUTcFlvWuf6wOguGtvPGNbDDTjBpQq8P779zQqWLRYvmWwNnbdznlPm/Mb/62R+o6tbhmH/93up3tkcWfYO02oPDKPKfigXlYhgiyFLRQFUEJWMBZBdVW58371hVdIb+iMxPN74eqZgeEx4+wDWRlWto5dS0MOA6GoVFKRzS76k16JGQ/xxIJLpbUZBFNPPqu3Au0oYCTQroImO6sIa5IqYDCzmnLLiXv917
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(199004)(189003)(6512007)(6486002)(5640700003)(386003)(6862004)(76176011)(102836004)(186003)(86362001)(26005)(6506007)(5660300002)(70586007)(70206006)(76130400001)(2616005)(11346002)(336012)(446003)(2501003)(81156014)(1076003)(305945005)(50226002)(3846002)(6116002)(7736002)(8676002)(4744005)(25786009)(81166006)(8746002)(2906002)(4326008)(14454004)(478600001)(8936002)(26826003)(36756003)(2351001)(66066001)(47776003)(106002)(23756003)(54906003)(99286004)(50466002)(22756006)(356004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4435;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7b18cebc-f988-41fc-87a7-08d77272d089
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3sMlgXwmvXHailfRbYJvhmufEF1QyuOp7kTlToN/tTaKp31Rs4dp0YMicpLgzOZxVIaA+ze4kqWpBVFZVYNc9ToukkskOhSoWVi0ulsOtwjei1vm+uzTnqpw7EocR0e64QTzbbAyNYAMpD1o0uvuO5bk0Fkc/A7IuN7jf+V6HhnEMR88u1XU8oodU5sLSY9HWr7DJcAkY7UFb4gVSjI6TEk25kkQ3mYBEEag7B/cv/+QIyxEDcNJhvZhwwaisXOofbjrzoAudeiJ5HzVK8zn4A609wGE7lr1NbdUXIfPmMaPQw5sG+6zn8gyb8F819LaB6ApPzVfchzvz1F8oEXBGI9DGOJa4WKM0m4KrJsdEoGGGdv3kzuPQa8K4VRAHYB+TaO2SA/6zDG6EENNxZ99cBWqWyQpihArMExZ6B8Uq3yEZ3+4anOSTXEZQBTt5sx
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:28.1866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc007d0c-8baa-4185-841c-08d77272d8ac
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-mipi-dsi.c
index b6e793bb653c..051f9aaf5867 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -1052,11 +1052,8 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 		return ERR_PTR(ret);
 	}
=20
-	dsi->bridge.driver_private =3D dsi;
-	dsi->bridge.funcs =3D &dw_mipi_dsi_bridge_funcs;
-#ifdef CONFIG_OF
-	dsi->bridge.of_node =3D pdev->dev.of_node;
-#endif
+	drm_bridge_init(&dsi->bridge, &pdev->dev, &dw_mipi_dsi_bridge_funcs,
+			NULL, dsi);
=20
 	return dsi;
 }
--=20
2.23.0

