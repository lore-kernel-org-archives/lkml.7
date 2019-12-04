Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94231C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599B920661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Fd0OGDB8";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Fd0OGDB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfLDLt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:49:56 -0500
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:41733
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727445AbfLDLsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsj1ZwfMocxMmhXuaRq5ay7fcHZ5bq2hDSJxGG7/gpQ=;
 b=Fd0OGDB8+UM/HnzHYjR6RDrj0AuyvIMeqBr7sOTavTAQC6eStzv01tXxazQJQwhLVl41qP7eYC3XYX+7+lOXSB3B2CRdEwOSlopUAxNwm6SYkzO/0MVbq/x8uHySNj7+9vQlxCxeuhzOnhUZ2Ce7FDeYx+lqkmnkiQJsBfikukk=
Received: from VI1PR08CA0269.eurprd08.prod.outlook.com (2603:10a6:803:dc::42)
 by DB6PR0802MB2294.eurprd08.prod.outlook.com (2603:10a6:4:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Wed, 4 Dec
 2019 11:48:15 +0000
Received: from DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by VI1PR08CA0269.outlook.office365.com
 (2603:10a6:803:dc::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:14 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT059.mail.protection.outlook.com (10.152.21.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:14 +0000
Received: ("Tessian outbound d55de055a19b:v37"); Wed, 04 Dec 2019 11:48:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 874064abf3568cd1
X-CR-MTA-TID: 64aa7808
Received: from a83b0422c187.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F2A5E4E6-D138-4B4A-A292-02A1215F4B21.1;
        Wed, 04 Dec 2019 11:48:09 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a83b0422c187.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTK1AaUivdIof3/5nwpn7TozAmjNzEoX5VPodlo4whyV3GEyBpBfvQhggUmSpDJzFgEMDfzCC7uLf025qmzP2MIVmsE9lTGXDYIQ2bLc9lRv+UtpJvxUSzjFMcSVv/zFC+CGOyx+ganbJknYWO+0+eKILYIyIk8KGn6SXfOndXODaJR+sMC40/Nb4w76Ry4PkqpMru+v5mUdAsRKkXhVbt1t/qEbLc5fAv2+fTNq2mYmSI1HD5kO+XAqnr2PQgns3v6FH+tdc43j4/4Rki4eNQ+OmJO7P8VWuZj/6E4FdT+aaB9kmWRCY/fzRTvbRPm57A1GN36vJh0HE8w0OnMbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsj1ZwfMocxMmhXuaRq5ay7fcHZ5bq2hDSJxGG7/gpQ=;
 b=gN3Owv2jCuI1LnjWgmv47ZxJkFKdicdeXMAo2a3mib3S52RuUcbK5MwxNKYZSDgMioV4MwgarlKtA6QAmAhP0rqbICoEWoTL1QbytOw8Fpm6P1JGXZAUbaSuG2f+xGSVGmA6Xf1rQi6Aw0YKf6qSfAxdHRFPsm00n3gUBfG+Q2/x8QCtoDLyGSW0T+FyJ9A44FAT2VZ20RQ3gfAQAUZNtXmVVJqoQvzHvRFuATjm/ypM38N7FxwR5R9TDAZ8oGkTMIYVjdQn1yH2JDM9DvY1rIomDpQCzVCARtHVJxTORG/TXHikWuVxkVBtKICAXxu4KgfG1CBO9cnCBr+B1a/XPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsj1ZwfMocxMmhXuaRq5ay7fcHZ5bq2hDSJxGG7/gpQ=;
 b=Fd0OGDB8+UM/HnzHYjR6RDrj0AuyvIMeqBr7sOTavTAQC6eStzv01tXxazQJQwhLVl41qP7eYC3XYX+7+lOXSB3B2CRdEwOSlopUAxNwm6SYkzO/0MVbq/x8uHySNj7+9vQlxCxeuhzOnhUZ2Ce7FDeYx+lqkmnkiQJsBfikukk=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:06 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:06 +0000
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
Subject: [PATCH v2 05/28] drm/bridge: dumb-vga-dac: Use drm_bridge_init()
Thread-Topic: [PATCH v2 05/28] drm/bridge: dumb-vga-dac: Use drm_bridge_init()
Thread-Index: AQHVqpix5N1UMtua3E6i7lQhXvu6XA==
Date:   Wed, 4 Dec 2019 11:48:06 +0000
Message-ID: <20191204114732.28514-6-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: f90a2584-b050-4be2-8bc3-08d778afd8b9
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|DB6PR0802MB2294:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2294C062DBA9DF7DA89BD6298F5D0@DB6PR0802MB2294.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:46;OLM:46;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: IN46WK0zdOcas2nOV3ChnTBi9Mx7NAQl+gWiMExRQ65CujbceMbaBZnfUYCMQ68VGbUg+LC0swznpyfaubCK3EOAt3jsGhcRSMbnt1Lyv+OuHCT4R9D2JIMlvzjx7lK3Pwru0BfPzhsqgGec8iq/occKB3j7waLj+aM2E9KjSvK0eMRuAYZpAX0HwUHoRa+VFWWzNjIyH/P3hXaKSIZcnPn3KtSt/g5x/svDB7x5vL5XeLTOPMPXlENkXCwMq6FH5CTzX9EYFpFMj/i50YHFi1Cp17Y+6MDusFMOC9EXf+20r36+1Rk2JN4SXfr8RQLsDW6JZ6lJSvuDPFCwIM9VYSdbDSYEaFFysAKDZOjErlH9cEqgxhkgbqlduT7pmRxFOrOmHb/XyPFhVg2oJwKQ1yGKB3h8Nrwp2m45KoF9G6V3Gnjk0KsbV0ydo63EJeIW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(189003)(199004)(7736002)(11346002)(2616005)(102836004)(186003)(6486002)(26005)(76176011)(336012)(6506007)(305945005)(70206006)(76130400001)(81166006)(8676002)(2351001)(8746002)(81156014)(50226002)(8936002)(70586007)(2906002)(3846002)(54906003)(5660300002)(86362001)(6512007)(6116002)(99286004)(5640700003)(1076003)(4326008)(316002)(4744005)(356004)(6862004)(22756006)(26826003)(50466002)(36756003)(478600001)(23756003)(14454004)(25786009)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2294;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5da8f555-4496-4e19-2693-08d778afd3ab
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZGnnPCCts/iKm3Gfw4SWqN/zykBce/4V8UEmjMXPv958uPVZx4/L9kJxMlWX9d3z33I1xtKdcX2KVqhIKkN4LlNoCkn0O55HCELEB+c9JwZzKKKZp3iJXoTJ46AKJ5fS3DQaI9miq40tjaxAzHoSpuK+5vY1HbIbjBl7UGYQcVea4GCEQ8Fwpmj2tiEyMb0BPo6ipTMO8M7KB6z9HxMlNN9L6GgtOap6AqkHKLY7aj48f7upR5NVR+6U1pcTrIVeR5GO2xJNltMR56COY4TDoWE4rkkAjVi0cIPzLlqiVhCY4UBhB8JSL5hfz9b8l6VSizrJYtJF8P7PKmg5U2uRnuUar6e56EyK70+kZyMstOjrL2WW5pErY+2Aufn+9klghEfP0wfzQjpOYLHY8YYrAA2O8g4doqt/eiKpclxUsR44BQ+hXmQgl6ha2cWXgki
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:14.6332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f90a2584-b050-4be2-8bc3-08d778afd8b9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge=
/dumb-vga-dac.c
index cc33dc411b9e..896f27272e38 100644
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
+			of_device_get_match_data(&pdev->dev), NULL);
 	drm_bridge_add(&vga->bridge);
=20
 	return 0;
--=20
2.23.0

