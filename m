Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436B1C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A36A20706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="b1kCR7ul";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="b1kCR7ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfLXRff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:35:35 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:39936
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727426AbfLXRfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVZarQjsU28R+N1QwEuqps/CDVpSAjCmb1/79SiplUg=;
 b=b1kCR7ulEtXtWbJj4MY33FI6/j1Eg4U98FE4WX9cLBBruZGb6nWeVKOsc/bOYEIeBK8idRI6xUZ0IutnVAQ7E84R+bgwZzJM+ZK8CsbFHH6rG/84qL1slsaC+qa8KqfIfcXPGPFFNQHP808vWJOIA8VMsCkGp6pjqPOJ2oXtFL8=
Received: from AM6PR08CA0024.eurprd08.prod.outlook.com (2603:10a6:20b:b2::36)
 by DB7PR08MB3033.eurprd08.prod.outlook.com (2603:10a6:5:17::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Tue, 24 Dec
 2019 17:35:28 +0000
Received: from AM5EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by AM6PR08CA0024.outlook.office365.com
 (2603:10a6:20b:b2::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Tue, 24 Dec 2019 17:35:28 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT051.mail.protection.outlook.com (10.152.16.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:35:28 +0000
Received: ("Tessian outbound 28955e0c1ca8:v40"); Tue, 24 Dec 2019 17:35:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: adfd243c25563ec9
X-CR-MTA-TID: 64aa7808
Received: from 2398bdd0a748.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B3DAF619-FB6B-47E2-8BF8-7B013B5426AB.1;
        Tue, 24 Dec 2019 17:35:22 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2398bdd0a748.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:35:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOqKo6HTKj4v/hU6S268kIfCuEmWAZb1N7mLkmTezUDpohM0GpWMJvd7T+SC/k3CZwTcpk9gqG6c8KI7exOknmwuLdJv7ruDsc8C7UueuA5d7GPxODb3Tc+vgY2PnAnDbqbgHgc6fb0AwReCQFSQ/Tlp0pj3TtO95nOgR8DAV8Tyz/gBiGoANUUOJXLTyLq/ld5kC/MCcprKoAvun+jQ9AbUVbNWpCJjiwz/B5aPvaG8urWeEQtgPmeKGUfR2uMMv0JX8hVT77LqTyct9yHINRd2UJ68SywYB0Wxz0yqfhzcgfu0DbPVm1fNRyN/Eb6YI8AgG1YvGWUa/66inNUd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVZarQjsU28R+N1QwEuqps/CDVpSAjCmb1/79SiplUg=;
 b=PBBjBw2wSvKwdNlrL/+i1O7PXMJofLSwJozxPGA7Fo+ucwdKtOFguy3UrT/PWiRWMAkWf/9RzkTNMoJ9I5ZXmmZVTcxMhQy8lbTpDITY3KkyeI2yUao0ESQ2bFpWiySveLThrrEuo8PbRaW+mb5JHfy+dlKwqL5rBNKoaSgycqFfH19D4me3/CA1OXP22pfoLZccoPaGHl1bfLXEe41sWAzGCTpSc3dj28Nb1rWwwtaLCvci52BMRRJaIYJFnZm7JYbPk15IlabzIYmd8EZWQI7pcSdyul7KEXhC2hot+5i/VDrd5nBeuZKbuW+BYYXG4sSZ0iwMn259drVxUWRGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVZarQjsU28R+N1QwEuqps/CDVpSAjCmb1/79SiplUg=;
 b=b1kCR7ulEtXtWbJj4MY33FI6/j1Eg4U98FE4WX9cLBBruZGb6nWeVKOsc/bOYEIeBK8idRI6xUZ0IutnVAQ7E84R+bgwZzJM+ZK8CsbFHH6rG/84qL1slsaC+qa8KqfIfcXPGPFFNQHP808vWJOIA8VMsCkGp6pjqPOJ2oXtFL8=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2672.eurprd08.prod.outlook.com (10.170.238.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 17:35:20 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:35:20 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 30/35] drm/i2c: tda998x: Use drm_bridge_init()
Thread-Topic: [PATCH v3 30/35] drm/i2c: tda998x: Use drm_bridge_init()
Thread-Index: AQHVuoBxMitMAq+IjUaHDTMsFdoeCQ==
Date:   Tue, 24 Dec 2019 17:34:50 +0000
Message-ID: <20191224173408.25624-31-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 296a0cc7-7631-4ece-207d-08d78897aaf2
X-MS-TrafficTypeDiagnostic: VI1PR08MB2672:|VI1PR08MB2672:|DB7PR08MB3033:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3033334AD470011EF93583FE8F290@DB7PR08MB3033.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:176;OLM:176;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(26005)(52116002)(6506007)(6486002)(81166006)(6512007)(81156014)(8676002)(8936002)(44832011)(54906003)(478600001)(316002)(6916009)(2906002)(4326008)(2616005)(36756003)(1076003)(66446008)(64756008)(66556008)(66476007)(66946007)(4744005)(5660300002)(6666004)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2672;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NhdqPEbz0LXM1p5iKp1G5BthBtA5F57cyYnQXLff6nmCbhW8rCkelu+JxtPiM3zSK3g0oZSNCutiFT80Q5eKaQ5+F4IJk97JjUUQeZz1lmc8ebMq65SlY9uM6EZvjAAiDYKx75Es/XPFLC2WzGoaSQ5/1UV6jZAEttFj73rbLaQcD97x+P9SrlNtWYf8ff4LAoA2d5uGsA7uyy6OYP8g2RtpZJbTaOFjQXqNcxbhaqGjme6uBZziraNubjlO3Ndz/Y7E/dPl7FzL2eJ5O0I5IH0KEWrBbhz9CJxputsjXrmmL4As3OwpN7uM5IRiiJUsCzDm66ZWg0DQXYTeeYRS4sDM6vPntA1zRWDCKdzRYmYeFF8uP+sz4XdYXCJe98FyJ27U0wJUsB1GH4SIlmvum7l53B9U+OWjnR9P06zz7DpoustW2iB7C+jkLZfdKTZZ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(189003)(199004)(2616005)(107886003)(6486002)(356004)(6666004)(1076003)(2906002)(6506007)(6512007)(6862004)(4326008)(76130400001)(86362001)(54906003)(36906005)(81166006)(70586007)(336012)(70206006)(316002)(26005)(8676002)(8936002)(26826003)(186003)(4744005)(478600001)(36756003)(81156014)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3033;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f71dee4e-a68b-4a4b-fcf9-08d788979444
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPcjqMrESbuN0jGz4Bc3GS3ZJpmNIoQ5M8uG86zIIwPR/GNoO83L2GuBPjGyy2wwaX1yGzVSekvWeo5PF5qNsDHbBKUxkgcGrGPYOXgDv9WQb7ASHBjSuCQiG9Ms0yqTsub5ZUM3aN0IPe6X+kjjLI9H0dsYgqz71foAAWNUACfMu/JtxvlQL9wV+ucd32i8NyldLBu+zvtI07UV9ZYUAak0fIZfPez6Mj6wBliG/4JRzcVC2vtDOyzFox4/0naHZmBm3Fe1hTg3R0HgpyCl+MXtQivO0B2hx9Cnl8UCmqqrKksNUSU4NhfnKcaWx9IkJQ5lWMdAdGe+ijf+aCW8DsRkusHeR82mNswpG7zA0ROIy717kfJcO8HuQ1IUd2wToVE7/dajZ0xxKjdIc2qX+Kfy+DYMYccH1qcEX/MSKuNfDhCsTrywx70f0znhE7a8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:35:28.4867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 296a0cc7-7631-4ece-207d-08d78897aaf2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3033
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
 drivers/gpu/drm/i2c/tda998x_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998=
x_drv.c
index 17a66ef3dfd4..90475d4eec58 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1974,11 +1974,7 @@ static int tda998x_create(struct device *dev)
 			goto fail;
 	}
=20
-	priv->bridge.funcs =3D &tda998x_bridge_funcs;
-#ifdef CONFIG_OF
-	priv->bridge.of_node =3D dev->of_node;
-#endif
-
+	drm_bridge_init(&priv->bridge, dev, &tda998x_bridge_funcs, NULL);
 	drm_bridge_add(&priv->bridge);
=20
 	return 0;
--=20
2.24.0

