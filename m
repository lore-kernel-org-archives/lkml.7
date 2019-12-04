Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1874FC2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF4E2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kRRRJTf4";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kRRRJTf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfLDLsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:47 -0500
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:52645
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727823AbfLDLse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFvLZuLVx0CkgA0/ZpPlhqvVnfV4TlettTTn32zufE0=;
 b=kRRRJTf4mPIaHRSXWEAoW9eLeMmteOMEROl+BJhnHywEm1/x+SnppQ55gmrhhZ+r7i43CTxasbR0/ZwqO2FMpfaZoSMteOvkZmXDyA1sPUKwrydOyFSPaDZ2whuwkNf0l/+QdnnbdBU2NHvf/fV9vPnxQhOAqY9SyXOu627BzLY=
Received: from DB6PR0802CA0028.eurprd08.prod.outlook.com (2603:10a6:4:a3::14)
 by DB8PR08MB5323.eurprd08.prod.outlook.com (2603:10a6:10:fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Wed, 4 Dec
 2019 11:48:28 +0000
Received: from DB5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by DB6PR0802CA0028.outlook.office365.com
 (2603:10a6:4:a3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:28 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT040.mail.protection.outlook.com (10.152.20.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:28 +0000
Received: ("Tessian outbound 54081306375c:v37"); Wed, 04 Dec 2019 11:48:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9cd65ecdf5485573
X-CR-MTA-TID: 64aa7808
Received: from cee6bfb0cd5a.5
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F6A44D8C-B783-4F4D-936F-697CE910D5AB.1;
        Wed, 04 Dec 2019 11:48:18 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cee6bfb0cd5a.5
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL7t9FEj7ejUy2M5BVZZx2r5VQMPcUIJJD7uURLyZUCbXQn9Z/zue1/Aa09zvvMm8P/FaeoLLDhmHRXN9PaIG4yEHr81h99nwu+CW7//Ujl77BztII6Ez951LLzNT54fHO1Pwk54ZgZH01yGTRGPArI39jANuw2U9DeBggcz21yqQRTjQEuSved/Q3Sj5Kf69qFXgV1EgpZVhsDdKa54738EfIkRupBIN1f7U4znh/eKrE9OzjaIFF7vkQx26+gEr4FSLE6P4ub1SjbH4n2RCPPgcX8YEgCKVbLbw874iQyrr2aH4k22r4Ig7aHTmLA6YwAuVHkSmhwC5gtmoCJ2og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFvLZuLVx0CkgA0/ZpPlhqvVnfV4TlettTTn32zufE0=;
 b=NbaoFSL6aPbkoZvcqEsibz7x24QnlT6XUt/asm0s40j0Cinv7NcgbQHQBhgDeenC9QVd9EZ2HvaX0JQea6JEPwsi2tWZGy+ODaDy8k+ckLugCxm7kcCVWYSeg4I9npOFvSt35gO55sceR95EgmZsFMW+LLIi0uzdHus6Pr+GAxxvfcIYZLJn9vIpfFk2o4SffbWxaGWqYOqdZgmNoflGbKy9w8GqUZCDJa5iX4jswAw6yU4rC1df/udBLOFZPTmKcPh1hBbkY9xPx2Wv5bSHMLApC29LLBPN3kzG2zTksZIMzszNPFlaIeSJbvh7crFgeWGF6IsaR2u+awQEJQhAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFvLZuLVx0CkgA0/ZpPlhqvVnfV4TlettTTn32zufE0=;
 b=kRRRJTf4mPIaHRSXWEAoW9eLeMmteOMEROl+BJhnHywEm1/x+SnppQ55gmrhhZ+r7i43CTxasbR0/ZwqO2FMpfaZoSMteOvkZmXDyA1sPUKwrydOyFSPaDZ2whuwkNf0l/+QdnnbdBU2NHvf/fV9vPnxQhOAqY9SyXOu627BzLY=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:16 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:16 +0000
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
Subject: [PATCH v2 16/28] drm/bridge: tc358764: Use drm_bridge_init()
Thread-Topic: [PATCH v2 16/28] drm/bridge: tc358764: Use drm_bridge_init()
Thread-Index: AQHVqpi3/vcd+A+epE2FZfNxIDV2vw==
Date:   Wed, 4 Dec 2019 11:48:16 +0000
Message-ID: <20191204114732.28514-17-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9f8ba63d-2b97-4d12-16c7-08d778afe100
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|DB8PR08MB5323:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5323F0E90F8FD28F08D1B7648F5D0@DB8PR08MB5323.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003)(5024004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: iptSpS+N3AMIgAm+fy7D3XvroCa4u7YbadPYWTmTrtx3L+Emg6MwRQq/NSFogDjN4F3h4VmMAEzbdq83p/DD+ixyqmQEUicaWlEcf+4NhoT3SFlyqCXlIuwa2hiyCJUevSvcLTu7vrksiFJpi2Ej2Uqzg7SqG/Ij0K4iNIKwTqWjnpJEDjUgC9J3AVr4oh2tNGyP9fO73mVuoC6qBbJk8d/lGv3YTg5tL9y7WhoQouFXPThjYhHUfjLklI6BY5ELPwTb663ZsOZhFv6+M+f3em6ITMAKApJ/3Eejl1ovL2xm4P7NSvaFt2lRQOT+QBFLLRmBF1apXfEnKjanbL3W9F1oU68AM5a+sMWETHcfj34BwYjH+UiBOvD0ph9/NMXmHc9k6/Ds1lvLDloa322a6bPnw7hqh+4RCPWReXSdkm+1sRF1nj9C5g7oveIOMxCa
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(199004)(189003)(86362001)(4326008)(1076003)(50226002)(8936002)(5660300002)(356004)(76176011)(70586007)(8746002)(81156014)(6862004)(4744005)(8676002)(2351001)(50466002)(305945005)(81166006)(70206006)(36756003)(54906003)(316002)(25786009)(7736002)(26005)(6512007)(26826003)(478600001)(6486002)(2906002)(186003)(14454004)(76130400001)(23756003)(99286004)(6116002)(5024004)(3846002)(6506007)(2501003)(102836004)(5640700003)(336012)(2616005)(11346002)(22756006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5323;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a283bea7-6794-4355-ddd7-08d778afd99d
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/MnznDA5gULyNezSuE/y0LA/LW69CGA/xIrNsxWxhdMSauf3lCepr/n86+9H15wyQCYo2W2ebXS9spNjiODId63OkCd5La2rWMBSjDe3R1aL3b4GxI18sbQ2YIuyoE6qnoeqnoqXNP/6f8KEuoJBfnmSLidNXTVUyaYU+O31Yzw0l9yD+ZLacxSKSLJJtsN9I16aWsXgi6lHHDtnZZDj99IwIyhMRz4H9dC8xpElYkVvfpbcm1f7wE80Qy/cNJ/a17Eos3TPEZuieyfAgOUq7j1W/8dWGOWGXVV0DDo4Fh6ekBc/7rXGxndKlh8RLNYCmT7akEcPbxPk9bh/tqjFYM4ExucKd8RGpzB9FEYd+PVpDAjrM+H/xs/0lfOzOHw4gwjbp4izhy1DzRhm3ozjWwGlTRcEPULcRT4nc18lxUVeldW7jQFdDix25iyb9d8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:28.5123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8ba63d-2b97-4d12-16c7-08d778afe100
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/tc358764.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/tc3=
58764.c
index db298f550a5a..861d4df687ee 100644
--- a/drivers/gpu/drm/bridge/tc358764.c
+++ b/drivers/gpu/drm/bridge/tc358764.c
@@ -457,9 +457,7 @@ static int tc358764_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return ret;
=20
-	ctx->bridge.funcs =3D &tc358764_bridge_funcs;
-	ctx->bridge.of_node =3D dev->of_node;
-
+	drm_bridge_init(&ctx->bridge, dev, &tc358764_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&ctx->bridge);
=20
 	ret =3D mipi_dsi_attach(dsi);
--=20
2.23.0

