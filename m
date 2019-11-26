Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0D4C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02C82084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CgQBF/V9";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CgQBF/V9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfKZNQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:40 -0500
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:14074
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728105AbfKZNQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opfrCUQhstTmEWhDCMZ446EAzDQXpi+cbl+vvgZtrP0=;
 b=CgQBF/V96Kbi+jvdMvPI4lD75fV7KpZJERLH+y0QpNMxzbExmYmBXiqKvWIaHQaV5wEB3JKDJXf/igfAG4kiTJJ0fRLi75+qDJ+WNqib8jnLVgNNOcCCMSSsa2ti1vL7LlE852PPo01P5ijyzpXA8V2sbaVljdHNvyVlp298Now=
Received: from VI1PR08CA0203.eurprd08.prod.outlook.com (2603:10a6:800:d2::33)
 by VI1PR08MB3055.eurprd08.prod.outlook.com (2603:10a6:803:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Tue, 26 Nov
 2019 13:16:28 +0000
Received: from AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by VI1PR08CA0203.outlook.office365.com
 (2603:10a6:800:d2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:28 +0000
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
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:28 +0000
Received: ("Tessian outbound a8f166c1f585:v33"); Tue, 26 Nov 2019 13:16:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 09f6c8284b7389b6
X-CR-MTA-TID: 64aa7808
Received: from ec33c90fb7d1.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 54F74583-3922-40B4-8F12-49906CFECFC1.1;
        Tue, 26 Nov 2019 13:16:20 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ec33c90fb7d1.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0wuxNqpVlKCPA8sd2NmSu3RQxDlolp+dItjuAwYOfgvBAq5MxWO5FiWplCmpZwWvA1jF7/SgetMec6XgwzBeVvEYWDA6eDijdDzq4rGLKcDM8y/9DG/IGN5S8lUhxI6TgCHaNE3qF/03BGNRyygQdIqokeAnsvD3s5N7dE6Qu3SLbqZz+aGITJ3OkUkLOndABqzUfy28Y1JMMk3ZKowv8/nVfIvErFZl02JmS9LObqPMNfSZ1Uh8+Sl82LM3aw45S5GlHJIqjqre9++YUHLR5v8u0fExYkFByN1z+DTSQe2I43aGFEZfN9J9+tAOXGJSaq61iJYwMPAA9CqvRf5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opfrCUQhstTmEWhDCMZ446EAzDQXpi+cbl+vvgZtrP0=;
 b=goRF+BtwqgHdqLFEx+wbQN2joBK7S0yUb3O9GSTyLmfp5EEQ5sTUflWqLeWKMv3Cniy/i1mihVhD8dsoA9Avwpu0k/4/m+WvmsAiCe+kDhKcE8IQiVmAoox2py3sbHjThHY5O0QlUYezZ5HKPM9wLGNvrxDbmazPRTSLp63iBCWxKDg3MILZMrj/bElkB9Q5peOwg7r06445cvbfZvYbV0hR5hQXIx39RPw3QldkzKDGpQ9H8QJgleDmR8jKR63ilj3aVtiMb9ysTNvWSK2hEwCHlSPMe7+5gZtAFr8ZqG5lFBnEZZOO8qXLqNBEiCua7DdTbNi3UQgLhLgEeSUnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opfrCUQhstTmEWhDCMZ446EAzDQXpi+cbl+vvgZtrP0=;
 b=CgQBF/V96Kbi+jvdMvPI4lD75fV7KpZJERLH+y0QpNMxzbExmYmBXiqKvWIaHQaV5wEB3JKDJXf/igfAG4kiTJJ0fRLi75+qDJ+WNqib8jnLVgNNOcCCMSSsa2ti1vL7LlE852PPo01P5ijyzpXA8V2sbaVljdHNvyVlp298Now=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4560.eurprd08.prod.outlook.com (20.179.24.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Tue, 26 Nov 2019 13:16:18 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:18 +0000
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
Subject: [PATCH 20/30] drm/bridge: ti-sn65dsi86: Use drm_bridge_init()
Thread-Topic: [PATCH 20/30] drm/bridge: ti-sn65dsi86: Use drm_bridge_init()
Thread-Index: AQHVpFuwhBOC0MAP/0eKQkaJ/SChuA==
Date:   Tue, 26 Nov 2019 13:16:18 +0000
Message-ID: <20191126131541.47393-21-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: a9948be8-095f-4985-9822-08d77272d89c
X-MS-TrafficTypeDiagnostic: VI1PR08MB4560:|VI1PR08MB4560:|VI1PR08MB3055:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB305569B163CC1643A9E5AAB18F450@VI1PR08MB3055.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(71190400001)(478600001)(1076003)(66476007)(186003)(26005)(5640700003)(52116002)(64756008)(256004)(8676002)(2351001)(66946007)(54906003)(81156014)(44832011)(3846002)(4744005)(6116002)(6436002)(2616005)(66556008)(71200400001)(2906002)(11346002)(66446008)(99286004)(14454004)(81166006)(6916009)(5660300002)(25786009)(2501003)(8936002)(102836004)(66066001)(36756003)(6486002)(6512007)(386003)(4326008)(50226002)(76176011)(316002)(86362001)(7736002)(446003)(6506007)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4560;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Tx2pvzJtc9BABuIhv7DeCv5wFwyraG+bXovA5x6NNvBd18zwSPL4q+eM0/wFnzBfkoKc1FfyZ81LKfrfEgi2OKkR2WbOvDY7M7Uz5chcgUYPIbBuv9uge1PKH2DdGLGhuZEz2DBANNzYFDlC6tv9lC8bTacUvqFHUq1sHeajE+yuUhX1T96akTm9+cNyt912NW9wnYsNN96IjsLGLkoL5S4Z9VjX4okpenOJc1/wLYL4PGzqa3/AZmh8H21TsbYAIuM65r0vQGeERK4KJgPurvE6zs+jbF4X/elCnz0zhYim62p91sQbcnzc4z7+q50X+f+r7gRUkrpMgjXDiFKKRQiFYkiioBlE2PS6561lP5HABGK7A4rkpCGmfDAOnpTPtHk3JIXJ/w4lAhfPVcybPTkX0Ttdblw0wF2tO+eFWX4scYpZSrtjMnuCLm6ih+37
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4560
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(305945005)(336012)(6486002)(2906002)(54906003)(6862004)(186003)(8676002)(6512007)(81166006)(81156014)(4744005)(14454004)(22756006)(25786009)(86362001)(36906005)(316002)(26005)(478600001)(4326008)(5640700003)(106002)(2351001)(7736002)(23756003)(70586007)(386003)(6506007)(356004)(99286004)(8936002)(102836004)(50226002)(70206006)(76176011)(36756003)(1076003)(8746002)(47776003)(11346002)(2616005)(76130400001)(26826003)(3846002)(5660300002)(50466002)(446003)(2501003)(6116002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3055;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9863b37d-7eb5-4087-8610-08d77272d2d2
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: us7vOeaJLx6dKL14MLEpkuqRM6Cn1QMbQlMUjY50Sqs4eLVuNOzs9q0NftOIZ40nlVmkeyhzLuK84YZ3ij0kxWo1d3HHUfpu/EijBl582JKuMFZqRgv48XVUnjpzHzHk9UpeqGaqgnHWCGpGcALGbwQfD1r/gW+Dq9T0SzRLMPyGLGQP8ShIK5FDAlwbPjd20N42RIw7GSeDCLG8hHebIbJDHYJmu8/syC7nzCAxFzRqZXCvqqSPl+pKuu1FprXrNqw4pRM5pakFCyjlBpSJH11Q1gCun+6TSbOychktykC8iRO7U1sd1NIfFkY+7Pbsnpry+lrrYuWHLDkLNGwWRar2py7HmGzjkm+ZobyvkGhXjfW0RSilxcXKcMQHOxpAVR1t6tEp8zd94SiEewnOzuSSaLmju0obQ9DzhAxThCzRbN3jJSeUJ3QCW370uga+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:28.1613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9948be8-095f-4985-9822-08d77272d89c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge=
/ti-sn65dsi86.c
index 43abf01ebd4c..4e236b46f913 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -765,9 +765,8 @@ static int ti_sn_bridge_probe(struct i2c_client *client=
,
 	pdata->aux.transfer =3D ti_sn_aux_transfer;
 	drm_dp_aux_register(&pdata->aux);
=20
-	pdata->bridge.funcs =3D &ti_sn_bridge_funcs;
-	pdata->bridge.of_node =3D client->dev.of_node;
-
+	drm_bridge_init(&pdata->bridge, &client->dev, &ti_sn_bridge_funcs,
+			NULL, NULL);
 	drm_bridge_add(&pdata->bridge);
=20
 	ti_sn_debugfs_init(pdata);
--=20
2.23.0

