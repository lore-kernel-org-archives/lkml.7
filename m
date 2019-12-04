Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6487C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857442077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="4XlCn6UL";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="4XlCn6UL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfLDLtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:49:35 -0500
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:3233
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727836AbfLDLse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwWUgh4a/99W8HIctunJRzMXApJ6JnBQ7MIy/xuhdE8=;
 b=4XlCn6ULN3JnLv+UCmzSEhfXjX6ZqFEA9uTNha+DT0UNEa/jgOND4FYoOXZ1wx6Bfk/kNZg2zGfsGxjHb8E/Kq2ZEKjfA7ZZePJzkOyk/ZSOigWFwu7uadbGvDidkhl/AzBL/NXbGAqO/WKJvLtx9ZWQAZlYraxl1VjecVJgjhQ=
Received: from VI1PR0801CA0073.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::17) by DBBPR08MB4694.eurprd08.prod.outlook.com
 (2603:10a6:10:de::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20; Wed, 4 Dec
 2019 11:48:29 +0000
Received: from AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR0801CA0073.outlook.office365.com
 (2603:10a6:800:7d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:29 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT025.mail.protection.outlook.com (10.152.16.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:29 +0000
Received: ("Tessian outbound 15590139dbb5:v37"); Wed, 04 Dec 2019 11:48:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 27331de2f3e13bad
X-CR-MTA-TID: 64aa7808
Received: from b7ecf5d06a39.4
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 71ECDB19-0260-489E-A2B5-B7D66CE871D0.1;
        Wed, 04 Dec 2019 11:48:20 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b7ecf5d06a39.4
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaVAcPHdmFj5xxUKd//I9lqIkojJBedBjn6Cv59p4Btb+YDPZshaqNCnHF8VTxxyUJ6HI7uox/NkjxV0ZyciSZthD8EVPjnwX9OxwaArg9An+845bBRbfThPf74jFfJsIrFFc/gA0e9Z4WuM+PTIW7t+qn24yJIlZI5kCtDsM0Y3zsx8eUDqyqESlxZNHW4ZS/+qkbJHSIKGJwRhGpJEEDWd0pEfnpoxcQMUp+ePi3pbWrg5nekqAcT29AoYAvTTaR8gARI6/OBXAibTwha6dU6JZtcNaXSHO0oN0io03ERltL8syhpnrAhYBfRNn61ODSopI0fd7Nj5bj9iaYNpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwWUgh4a/99W8HIctunJRzMXApJ6JnBQ7MIy/xuhdE8=;
 b=nxSEzO/HhSJPBhcnqMY9hP+bzdy76+qQFZGqClJt/QHEWHT6P7hmsRIwxjbFG/Z4zda6rJHZdK59GgkPJ4ulof2mpm9LEwQiCJa84WhE+OAajryytKS8we7L7XP88edK+S5fp+T4WUlJ3COJrcEWIhUo59tFK/jihb4zicFPIRgo481S90HFBQjS5RocmN47cOpz529jPdetEqaE8jV/fQn2FlBRJWKNCuJPGHDMrg1YdLWBZwhDkD9m5iK4b5pBAqB7uUzCiJ/QTPB9TPqL3dvwDuZoQ5Mhe7MyDxDegw4WRGzWbie1RcA6P7mR8vrhG/dQkLe4iGkW4LaC6b4rVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwWUgh4a/99W8HIctunJRzMXApJ6JnBQ7MIy/xuhdE8=;
 b=4XlCn6ULN3JnLv+UCmzSEhfXjX6ZqFEA9uTNha+DT0UNEa/jgOND4FYoOXZ1wx6Bfk/kNZg2zGfsGxjHb8E/Kq2ZEKjfA7ZZePJzkOyk/ZSOigWFwu7uadbGvDidkhl/AzBL/NXbGAqO/WKJvLtx9ZWQAZlYraxl1VjecVJgjhQ=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:18 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:18 +0000
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
Subject: [PATCH v2 18/28] drm/bridge: thc63: Use drm_bridge_init()
Thread-Topic: [PATCH v2 18/28] drm/bridge: thc63: Use drm_bridge_init()
Thread-Index: AQHVqpi4C2DlW8sHgkeTmalYje2zzw==
Date:   Wed, 4 Dec 2019 11:48:18 +0000
Message-ID: <20191204114732.28514-19-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 92d839b2-5173-4400-d154-08d778afe15e
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|DBBPR08MB4694:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB46946DC5B496463CA13835628F5D0@DBBPR08MB4694.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: +q5LvAbCGZNpkVIGpm0CMbyOO69cj4/PxagVTIhBMnhQK4O5f2T9WJoqzFBx/5gQOro+nUOri72/1Mm4grjRQj6KpxYKQ34hrcAKRucNhAtN5DFrUMbKHBPSQvBlVrCZZJ1zq2pLdIXtlO9ydzYKCiW4wAceDpSmxAeeIgIGYnlpt+BQSluWrH7UJUM1i2nKwiSEGgcZCLLvo1EfYOdpg3ihQA9xdtS/Zk8UUzbyTAALYtRG9VzII1sAa5AdOqjTt4h1ij+UmGpogwDRVcpPn0qLCcZgmkDLKPwtjMynftIlT7B/Zzce4RluA4B5Rqh1zVMQCT9frAMdz8Iyf7w12dTR2oI5/m8YuwrhhvAV+17P7K9gs+yfCOBdtjNdMKv2dQLFTWAWbwZWtfkoMkDnV0U7WJelolkUWGT9FIM5t7xGJ7uzwEPDudWho1A3MDab
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(6486002)(26005)(99286004)(6862004)(186003)(6116002)(4326008)(336012)(22756006)(102836004)(76176011)(3846002)(305945005)(5640700003)(6506007)(6512007)(11346002)(70206006)(2616005)(7736002)(478600001)(26826003)(70586007)(36756003)(25786009)(86362001)(50466002)(1076003)(5660300002)(76130400001)(4744005)(23756003)(2351001)(8936002)(54906003)(316002)(36906005)(8746002)(2906002)(8676002)(2501003)(81166006)(81156014)(14454004)(356004)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4694;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 93a0caf9-3893-42b6-1dff-08d778afdaa1
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSsJhBB83tM70RfAy0DnLFg4bSaTtP78cGe1QqfIJhMSg/IBzSlYL26QRL2okCo7o5Mmu4MdDFr0IcxnS/V/qzWtIi5vNKjuLKVXFPR5sRpuA9psg+LpIyj9+zwoFiLj7nOB27pgW12HCP+42bz+FxZ4voK0+nxen9SQT0gjjjiT++Ebrf2LIGIli0eJWIbmAgMMXonZbBoUSh4Y24915EphPwDgtlJEJgOWap1jqKa7OhFwCGYkH07vMlJCaQn7zrsegmUA3cuoLcHY3etw0SBLaIMg/V5GYkgdqowWQSbH3SnAX53QTOAMx9AcjwO4wKg5nw2vlZQqlAS+UZCjzsxnpVmBRhAhPIlXg1eZWI5QDaLCHXoJ4L1+Rv5Xke4+AKP3jO+9tde7niG315BpdgkN6VhuQGJ4R1Un8Qz+6SBpzci2FFJ+olJNhB+8q1hh
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:29.0731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d839b2-5173-4400-d154-08d778afe15e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/thc63lvd1024.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge=
/thc63lvd1024.c
index 3d74129b2995..abe806db5f4d 100644
--- a/drivers/gpu/drm/bridge/thc63lvd1024.c
+++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
@@ -218,11 +218,8 @@ static int thc63_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
=20
-	thc63->bridge.driver_private =3D thc63;
-	thc63->bridge.of_node =3D pdev->dev.of_node;
-	thc63->bridge.funcs =3D &thc63_bridge_func;
-	thc63->bridge.timings =3D &thc63->timings;
-
+	drm_bridge_init(&thc63->bridge, &pdev->dev, &thc63_bridge_func,
+			&thc63->timings, thc63);
 	drm_bridge_add(&thc63->bridge);
=20
 	return 0;
--=20
2.23.0

