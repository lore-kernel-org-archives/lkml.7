Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C9FC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F339420706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IxPKYBuT";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IxPKYBuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLXRfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:35:23 -0500
Received: from mail-eopbgr50049.outbound.protection.outlook.com ([40.107.5.49]:27303
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727198AbfLXRfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij1zgGB0KfFqajqv2PzSevnA3ctHjx8hNIITFYHHNAs=;
 b=IxPKYBuTlpAcK45NKq1I1EcXAPe5hkntZn070+6LGZeFIQyhEz/Ady1tEHg+FENfvDtn0TheXAS9ziSUInOhmvXTvjmRG6KHB3Xx+wXGK77BGfRMihQ97usqgPA4HhJpnVZcPjWyeMWtOCBpKFqbDYpz9oO6z1WYsU3SgcWId/Q=
Received: from AM6PR08CA0014.eurprd08.prod.outlook.com (2603:10a6:20b:b2::26)
 by VI1PR08MB4109.eurprd08.prod.outlook.com (2603:10a6:803:e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Tue, 24 Dec
 2019 17:34:56 +0000
Received: from AM5EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by AM6PR08CA0014.outlook.office365.com
 (2603:10a6:20b:b2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:56 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT006.mail.protection.outlook.com (10.152.16.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:56 +0000
Received: ("Tessian outbound 1da651c29646:v40"); Tue, 24 Dec 2019 17:34:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2a48b47ca8cbd3d1
X-CR-MTA-TID: 64aa7808
Received: from c54502d9e00b.7
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 547571E1-1620-4766-B034-6F6E66A31FFC.1;
        Tue, 24 Dec 2019 17:34:50 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c54502d9e00b.7
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frY2BUWOCpwfq6WH0kNWOvMkAXgdnD50peGpvwHStx8KFW+gZPoWDf2EUwhQe6yTJVynNIeWmIUzeAM3z2BHYvSnu6NWTZcAAaFx4xe1IbhwyBYoT73re/DYlAmzWJO8MOoZUHRQ1WekC8ZjUUx+NEOc/TNCM1sBrDugm3b9klPasFEV7SAv/xly5xMf9CGS66E5Qfi76itgKhVZWYjq2lRn/WfN3Gfi0YHd/YE5Ioq4pYqpnwMZmnFGMA+qYqOiMyHyE51AnvnFQN9MlF2iCSfgM9f3TZO+FaaoFyuyH70D27LiKX8utOySTjLUbsC7ijWVvMtVqU5603LTvs9c2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij1zgGB0KfFqajqv2PzSevnA3ctHjx8hNIITFYHHNAs=;
 b=JpmOBjG+ztg2d65AzBK2UkGv70YQa4LOLXkEwklCqlSinfJWK9Wvyg7uJrOr/m3htytHAQFKJ3DmiYgmaeIVUYPjhJY7mSU4DU2I48YeCe4TGjKG6YTzVb+ex6kx4xBI5/JcAjiiXby9uSRMbc2xojbmPeQOF//ZQHRcw0tT0tEqE2OxA/V69S5vO6BdmdfSvWEgBkHY8aKhPXBSHKv5n0ZmAay+v+Sk30zRQX5oo6FqXxRk4ugKP4HrkoPsLlxXsilGD/K2m0tSMiAEB3q+zO3034wEmdIn0yQ0k15DTfNeXpbptFvx4DKOjG90fOA/oHwsG8VPZkXilVFbTv70rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij1zgGB0KfFqajqv2PzSevnA3ctHjx8hNIITFYHHNAs=;
 b=IxPKYBuTlpAcK45NKq1I1EcXAPe5hkntZn070+6LGZeFIQyhEz/Ady1tEHg+FENfvDtn0TheXAS9ziSUInOhmvXTvjmRG6KHB3Xx+wXGK77BGfRMihQ97usqgPA4HhJpnVZcPjWyeMWtOCBpKFqbDYpz9oO6z1WYsU3SgcWId/Q=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2672.eurprd08.prod.outlook.com (10.170.238.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 17:34:44 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:44 +0000
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
Subject: [PATCH v3 26/35] drm/bridge: thc63: Use drm_bridge_init()
Thread-Topic: [PATCH v3 26/35] drm/bridge: thc63: Use drm_bridge_init()
Thread-Index: AQHVuoButaaZf4N+00m7TBopJFb9qQ==
Date:   Tue, 24 Dec 2019 17:34:44 +0000
Message-ID: <20191224173408.25624-27-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 39e6437a-7a6d-453f-20ac-08d788979797
X-MS-TrafficTypeDiagnostic: VI1PR08MB2672:|VI1PR08MB2672:|VI1PR08MB4109:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4109C4CBB407B53923EDB6468F290@VI1PR08MB4109.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(26005)(52116002)(6506007)(6486002)(81166006)(6512007)(81156014)(8676002)(8936002)(44832011)(54906003)(478600001)(316002)(6916009)(2906002)(4326008)(2616005)(36756003)(1076003)(66446008)(64756008)(66556008)(66476007)(66946007)(4744005)(5660300002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2672;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: WMsyq7C3kfZWGUUNn7sKk+UO1rof4nJh3GmA/3BnvvGh0U5r8gc5a8Z656ifKaHG77//HXIILcfQSO5lWx2caCYxnxKjwKjcT6fLn90m1lX8JxKPIXjIn7ICikI/aEofPhlf7+CG1FFYpamhTT4Jziu9eJjVFdalIDZh8E7ijndz0ZE7WUKsyxLZ51IbIxo5LRh4ZqDXtxRnM5vSF//OsiOzm+Ko38HsHgOHx2lxW1HR02LKYoRCgePOtHITS9aH/WwFnuRdVzbS/a5++rG2GFlqHtKq/WU1Hu0b+O/+fC38/LrjIYgujU/swanNXW6JhRUIFyeDwLKqtc7g+n5wXBWvTNGphwwB591idjW3y8OscY7lag/JXrY3/UhyfSu+hjHueLKjTXVF7ssL4+S3ZBgpLTGN2s3Pl4gXjF4rptN2OiHN1mi6DXDVWZLfhy07
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(8676002)(478600001)(6512007)(86362001)(2616005)(186003)(336012)(26826003)(6486002)(70586007)(70206006)(76130400001)(81156014)(81166006)(36756003)(8936002)(4326008)(6862004)(36906005)(1076003)(2906002)(6506007)(316002)(54906003)(26005)(4744005)(356004)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4109;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 861b6978-b8f6-44b3-6dc9-08d788979090
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVKNLkk/PR9mBFChhJ/J+3K/yok+MG6huLnsbvluxsre/Nxp2vI0w/WTnBcVirDgGfkbK1Mrq8yzyWQN/Lx9+2BaSkYZo3grkduLpvepc2ZwnWJ8gBXp4cmmdzK1AmMqcC8gB18b/ClTK96mwAoB7pzuathKe0D7OgLk4Qwc1C3jg0gElnCt2REDBTj4VHq4dP6nXmcdfp5g7uN6+UahGvpkPJFhtyQeWrfbGuQpde6irzRvBnvfUiqMMsRwQRChQHJKyijmIy1fDAwhQTM2+1qHQ8g+QvPNV3Qz8p4cfQ94VZTcSDzkViOzzBTA8zZ84LOUwleRfHLWav+JBdJpltdnRa3ylEbnU3MpohBKoPl1RxD2CUo/wAO7IYHCaZg2MaI6SXwyq9RXQJ0BMwo3aHDLCzEmm6RfFgbb+V28ngE0XM3dernmQMh7FvW2ft0h
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:56.0297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e6437a-7a6d-453f-20ac-08d788979797
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

v3:
 - drop driver_private argument (Laurent)

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/thc63lvd1024.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge=
/thc63lvd1024.c
index 784f4e4eea05..30f6a76850f8 100644
--- a/drivers/gpu/drm/bridge/thc63lvd1024.c
+++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
@@ -218,10 +218,8 @@ static int thc63_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
=20
-	thc63->bridge.of_node =3D pdev->dev.of_node;
-	thc63->bridge.funcs =3D &thc63_bridge_func;
-	thc63->bridge.timings =3D &thc63->timings;
-
+	drm_bridge_init(&thc63->bridge, &pdev->dev, &thc63_bridge_func,
+			&thc63->timings);
 	drm_bridge_add(&thc63->bridge);
=20
 	return 0;
--=20
2.24.0

