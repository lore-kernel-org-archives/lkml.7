Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3594FC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E637520661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qHKchLZm";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qHKchLZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfLDLtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:49:49 -0500
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:62117
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727773AbfLDLsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4D/5bCj6TvVVRDvDiedXMOypvZfwR1Fa0QcscRNJGw=;
 b=qHKchLZmToYpbLDyF/t5oLprL48HF4p2FapqhvxRirMF6eE8yqtY7Dfz8ucnyfojBb8W11YBJr7SO38PFFI6D7jsykB8bjjlVKUNttKx4ysYNWzwXebSLQ6C4jm6qcWu3VIeUZCpER/QY8yHGt7BmXaiHwMBK8SgfHN/8HQupo4=
Received: from VI1PR08CA0172.eurprd08.prod.outlook.com (2603:10a6:800:d1::26)
 by VI1PR0802MB2301.eurprd08.prod.outlook.com (2603:10a6:800:a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Wed, 4 Dec
 2019 11:48:19 +0000
Received: from AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by VI1PR08CA0172.outlook.office365.com
 (2603:10a6:800:d1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:19 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT061.mail.protection.outlook.com (10.152.16.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:19 +0000
Received: ("Tessian outbound a8ced1463995:v37"); Wed, 04 Dec 2019 11:48:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7d2b493a6b18cf10
X-CR-MTA-TID: 64aa7808
Received: from a83b0422c187.7
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3A9492E8-5F22-4BB0-8745-A2FB1B13939A.1;
        Wed, 04 Dec 2019 11:48:11 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a83b0422c187.7
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRPP6zms+jidUZU5mLeXrQTG6Sy1+Wpg+GMn9kFSjzriRhFgcganqwW3Quo60KxA30oZVcEdvc8PvCNmHAA+4y5l16vYXXd3Zqjj7RVgyiQ2jW4xCnStqaLDxXMvgLgG0wOAatw9F/PEnv88g5QTDARH7kc1MrtOXVJuWq7Zd/yihAohbgMBvC0aKus60/iNknaYUxxPegfEiAvlcrhsdVb5iik9wqMlBP7NzUiBjJkOdcOifICJMgY6yYLOHNAwkXo/bcJKYTQ/bYOdBQE4J+X60+Rnn7VJOBL2u09HY7JdZIRIoRHICZAlD9DbZGT6kw9ziasH30SfBRMdIw5wUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4D/5bCj6TvVVRDvDiedXMOypvZfwR1Fa0QcscRNJGw=;
 b=VU8oQ4DR11oQwM0rv0sDNgsWGKLPw9ImtaR8fE1ZrhW0vAuEra1KFKkl3r0f94pKmS5IONAK7/f3OEriH7NxKh25CPwf+Vw3Dib7BkPBE+o0RFidFbarzzk4MqB8tNhtwxJm1ipd4jfZivSY6jadD/XBJMSdKlnW4RED/ifg7acw4wo+NRX3s9nyVW4v5ZMkX4vMnDas8CKGRehalYM/vbDdRIqGU1//nSQAa4lyLoJYy/aytR+CZx9oiMxHMSaGrzsRcCD9SJUVS27kthwPIisWztlck5Dzxc+0CkRHvrVgfQfk5iAfpu3XnLwf2Jg2T7IYXugzBPvHugCP4Jzwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4D/5bCj6TvVVRDvDiedXMOypvZfwR1Fa0QcscRNJGw=;
 b=qHKchLZmToYpbLDyF/t5oLprL48HF4p2FapqhvxRirMF6eE8yqtY7Dfz8ucnyfojBb8W11YBJr7SO38PFFI6D7jsykB8bjjlVKUNttKx4ysYNWzwXebSLQ6C4jm6qcWu3VIeUZCpER/QY8yHGt7BmXaiHwMBK8SgfHN/8HQupo4=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:09 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:09 +0000
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
Subject: [PATCH v2 08/28] drm/bridge: nxp-ptn3460: Use drm_bridge_init()
Thread-Topic: [PATCH v2 08/28] drm/bridge: nxp-ptn3460: Use drm_bridge_init()
Thread-Index: AQHVqpiy6ytrz+vg8UKnMUPo552Mew==
Date:   Wed, 4 Dec 2019 11:48:09 +0000
Message-ID: <20191204114732.28514-9-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0c7ae33b-93e8-428e-f4fd-08d778afdb58
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|VI1PR0802MB2301:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB23012C597139F7C067C3C6068F5D0@VI1PR0802MB2301.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: u+z2xKS1NpF3jRkmPj+e6cu+Bk/7M6ZzZs1O0VaLdCv++pjg5iyKhr2pFJIH81IzRBH++/rA+IKqeTIaQQYVEoKiBP+fU52Hc2pedLz74TqVJWMBo9kXls2bgNR1xkNGidxfYaS/Tjc9EOpvG7Le1ka2nrpKTgQVjlCzl8IeAZ15jlzajRX1hi280FiP3cXFQT7CBvsUR+FSEGLEkBWwP6riY8vziK9AayHbtEVKr6sesBDP0AMZmNMIBgy774WyDBBEAAQ2N5hsmydUE6rnlLSkhnhnKt/qdwUnPWK11+7dbXYmB8BBCVInStQPD4zbwcp6XlDjBj28UViJ7xGx6UIpLzv33wiZYtMjDdAs7kSovLl4YECDdZksyxKA1EP1G2UIsn3G8zVtmoAEm5rprPo4vlQCS/K5MGOyIXNvymCEaKYXYTT5f6rIz4T/+xuO
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(199004)(189003)(86362001)(4326008)(8936002)(50226002)(5660300002)(356004)(1076003)(2351001)(70586007)(8746002)(81156014)(6862004)(8676002)(4744005)(305945005)(50466002)(81166006)(70206006)(36756003)(54906003)(316002)(36906005)(25786009)(7736002)(76176011)(26005)(6506007)(6512007)(26826003)(23756003)(478600001)(6486002)(2906002)(186003)(14454004)(76130400001)(99286004)(3846002)(6116002)(11346002)(102836004)(2616005)(5640700003)(2501003)(336012)(22756006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2301;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 68fad433-7271-4028-ae80-08d778afd545
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oH6+w+6ZXWS36+8Yw8YLHcRqPO+fJDwIpvDrqh8PXG7juQy/arkk/FwgQEkmGlWyM1rNjA30WI6yYUUPMYI4rxa0dFREo1Vi+E6f5LHtTUN9tWi0AZ78IAJ59BKnSZwT6rCWwNgVKuIv5iGW0onjcnGpkGl1oUdX5zHbe2Q8KY/xtcTsj+fyBZ/S80hVdajWW2ItSQGbwvjeftDrVz2/m6YnxLZEfxCUhqvl80EJ5qy6kx++8Wn6y3mILi0Eit1/TmRxLYquPIAVqWjl0JH/FyWAPnk1RwajxZpQw63CzAaPA56Kk5ndDhO2U/gCr9YLZtFVButHD/m17D3dugXNgXbM4wqCEeOe6Vc5y0HGWZLSHVAHzalkLE16kYby61GE1+7MG7wltyGh4BDzZzZnrRbSryBDJJtK0nH65Wq2O9rrQGA2KmJft4PkridVNyOH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:19.0324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7ae33b-93e8-428e-f4fd-08d778afdb58
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/nxp-ptn3460.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/=
nxp-ptn3460.c
index 57ff01339559..2656a188b434 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -320,8 +320,8 @@ static int ptn3460_probe(struct i2c_client *client,
 		return ret;
 	}
=20
-	ptn_bridge->bridge.funcs =3D &ptn3460_bridge_funcs;
-	ptn_bridge->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&ptn_bridge->bridge, dev, &ptn3460_bridge_funcs,
+			NULL, NULL);
 	drm_bridge_add(&ptn_bridge->bridge);
=20
 	i2c_set_clientdata(client, ptn_bridge);
--=20
2.23.0

