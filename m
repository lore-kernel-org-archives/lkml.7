Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6924C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918402063A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gbgH+8ZZ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gbgH+8ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfLXRg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:36:26 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:55879
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726960AbfLXRer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8GXw6v+q/NY8DJdmPHOebrg0bk/YbknsMy1IZGdVos=;
 b=gbgH+8ZZx49Tw9NNtPT6wy8LhimVjyZ0qprs7Lu2PjrshEP958uMkF07hoFQs1+J5N/EBtLKWxYaaOoo9jovGddvlZhQguX4oFTsZIO/lrlP/hKZXQJ0hSL0lPbQsMqE8RDc65El1TTowY/cNb15QrhL4Xkl1OSG7mVaO2vepdA=
Received: from AM6PR08CA0046.eurprd08.prod.outlook.com (2603:10a6:20b:c0::34)
 by DBBPR08MB4870.eurprd08.prod.outlook.com (2603:10a6:10:f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.15; Tue, 24 Dec
 2019 17:34:41 +0000
Received: from VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by AM6PR08CA0046.outlook.office365.com
 (2603:10a6:20b:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.16 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:41 +0000
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
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:41 +0000
Received: ("Tessian outbound ba41a0333779:v40"); Tue, 24 Dec 2019 17:34:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 10088ed5be068d1e
X-CR-MTA-TID: 64aa7808
Received: from a20093a6efd9.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 47256F7C-3E27-478B-BABE-4AD1BFE37FE4.1;
        Tue, 24 Dec 2019 17:34:35 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a20093a6efd9.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS8QHrJAXBO6hN2FR6SL+AuJR68j5R4W2AIzZCPFuIXaep3tCnak2HyAvulfQbb5wqKHqIpquTE4z2r9vIff4t4CL+ClMbe3rEF956LdA7G0UHLmErFK/mN3F3WvV/PA4TyjKjb/gFEOOY79RxPeAQp7HEhNGqFkeMvGwvb8y35PojKbBd652A+ZpbViwtuINWs263d7y5BYmAL8Riyr6kUTDmv7CWPgzVGSgwS89HuVW/YasIpzu6waRDoU4yG1MMpEpwMc0kX5qxpCeIiZ2z157eVsNfrdLUI8WVbeHg6HGKOfYp9YeYVObFKDwQjdOivzdabeGbtwYdcgh8EAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8GXw6v+q/NY8DJdmPHOebrg0bk/YbknsMy1IZGdVos=;
 b=kuVKWNBL/R7dX4tunBsUl+PTLV5Dh7Pl95AZbh+zBjp7yd6xVYMrari3jD2b5PGFDRtAhHL03Q2oqTIGbNvYiCMn6iy/9bYFZmxTYk+0jkIq+U+Nq1HvIH1iWSPuhQ0xcKKEtnDIdcyPK/ANbva+5ln83uk2PwoKG3qaYpywO0oK3cbTsazjLn3NyY9uhhRZ+5WENWO9/57zfDBacQ66iTDHO8ZvhUkhx8rS1TSdvYwFUA8sdpYCBBfjipLDMfSWK6r7LyEUoaPbPS5nEe26wNGfp14P7dTRv5RVNb7zcCel8qEgUHkoMSZIZMPkc7wOfDeBi0Sx1gvp5Pr9KtnEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8GXw6v+q/NY8DJdmPHOebrg0bk/YbknsMy1IZGdVos=;
 b=gbgH+8ZZx49Tw9NNtPT6wy8LhimVjyZ0qprs7Lu2PjrshEP958uMkF07hoFQs1+J5N/EBtLKWxYaaOoo9jovGddvlZhQguX4oFTsZIO/lrlP/hKZXQJ0hSL0lPbQsMqE8RDc65El1TTowY/cNb15QrhL4Xkl1OSG7mVaO2vepdA=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2702.eurprd08.prod.outlook.com (10.170.239.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 24 Dec 2019 17:34:34 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:34 +0000
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
Subject: [PATCH v3 13/35] drm/bridge: dumb-vga-dac: Use drm_bridge_init()
Thread-Topic: [PATCH v3 13/35] drm/bridge: dumb-vga-dac: Use drm_bridge_init()
Thread-Index: AQHVuoBnmIESwf0th06/ctvQqHI7lA==
Date:   Tue, 24 Dec 2019 17:34:32 +0000
Message-ID: <20191224173408.25624-14-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: f0d289fa-a9ca-46c5-049f-08d788978ec3
X-MS-TrafficTypeDiagnostic: VI1PR08MB2702:|VI1PR08MB2702:|DBBPR08MB4870:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB4870DC88FC998C18C7787FAD8F290@DBBPR08MB4870.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:46;OLM:46;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(81156014)(8676002)(478600001)(36756003)(4326008)(8936002)(66446008)(64756008)(66946007)(66476007)(66556008)(26005)(186003)(44832011)(6506007)(2616005)(81166006)(71200400001)(316002)(2906002)(1076003)(6512007)(4744005)(54906003)(6916009)(6486002)(86362001)(5660300002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2702;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: AwQefWC9xvOeB9znZGMWlxH+sZgiJBW8J3u0P0foTGF8+OYYzqiyNLu0815F8ycKGsro0WKmr3UyyhTKXg6I0zOs/AelXaYrVoDZM3tOQLQ3qmYinN+ch4n6a4U5w3FV4ukVBWVN3+lixUYTFc6wB91eFjErWkhdGIoFkK/9/WkPfsfZZrNGKnfv37cGVtqSlfhbqlajb4Z7pPkSB528RiLE21gTIYEbasPyOzVQaiPBFfEjJDp8aXwMg9ji2Y4jZ7lNddzVhiKriqS2O3CmbFUfo1p+5WxXMd0cYe3qV3gijuOFLsdF9e0g2FQ45a0kHsJNpu3I/gLNinittDgV/TaslrczW7KexYpbZ+8R/8+qoLItQ6flNLRvVou05NXA/NiZnyLmB2Cole/rOE62I4EFZguQ/ej60azKj0ldMQqiFS+TSukB88S5LW+9BCAY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2702
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(6512007)(70586007)(2616005)(26826003)(6506007)(26005)(478600001)(36756003)(2906002)(1076003)(8936002)(81166006)(81156014)(8676002)(107886003)(186003)(4326008)(6862004)(70206006)(356004)(54906003)(6486002)(5660300002)(336012)(76130400001)(86362001)(316002)(4744005)(36906005);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4870;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a4fcc757-37b3-43aa-0f61-08d788978918
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pj/1T/BSIJk84jlIsqMngOQR0LS3G950+TKUmnY4E0AFUGTcgVN9e1Ak9L/Guflo5g+dU6gnaXeiLXu+3LRwJOkyps4TR5kt5FsGqWdKtsFxvZiWABVyoa44JXmPCDtc+NeGyX0F0zY1e2VfnBZ8cwP7sHhZ/NhFI/O3uqKMp/e7neyre1BL9Gf+jdD4R14dRwHRd0dphSP/gURSy59+PISQxRGOtrS4IdyXuLgKa30VcnM4PAjF5txGgmu8r/Qumbo9OHUWAeX2piucDavi8eD7wmy1pIqFuBB3OXC2yXpmFqtT4HUwksxjrwuhGfuXcv6RbJ5d3eEKCQtqgA48TfOeLVNU3j0nUYmyNVfpzrivGSIC41ktD7+DGcp2GR3joWads0GtySrrpUCZsCdC9JOVQIGzXTMn0i2xWGX01veNB27YPYhPCt7SWkzmRrBm
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:41.1668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d289fa-a9ca-46c5-049f-08d788978ec3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4870
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
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge=
/dumb-vga-dac.c
index 67ad6cecf68d..a737042a350b 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -205,10 +205,8 @@ static int dumb_vga_probe(struct platform_device *pdev=
)
 		}
 	}
=20
-	vga->bridge.funcs =3D &dumb_vga_bridge_funcs;
-	vga->bridge.of_node =3D pdev->dev.of_node;
-	vga->bridge.timings =3D of_device_get_match_data(&pdev->dev);
-
+	drm_bridge_init(&vga->bridge, &pdev->dev, &dumb_vga_bridge_funcs,
+			of_device_get_match_data(&pdev->dev));
 	drm_bridge_add(&vga->bridge);
=20
 	return 0;
--=20
2.24.0

