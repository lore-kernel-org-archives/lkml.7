Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF92C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A190320659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Hks2Nh4t";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Hks2Nh4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfLDLtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:49:22 -0500
Received: from mail-eopbgr10075.outbound.protection.outlook.com ([40.107.1.75]:45550
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727874AbfLDLsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DpZqtyyKVj6Kcjcgie43kZcxVAkBsJ624+DdPaI1+U=;
 b=Hks2Nh4tKLaPbxE7stJ3gDOp+YpzvWKVR7KJDXhD6UJ8JS5Gy+wZN0wuahVXRKdbISDc6Bnd8xV9/ymF1dK0896IvraSm6eyY0EYF2zoYC6LT+V7CeIt4OxBsL6VN3eWqiCTf7arhljkwI4NpJJ1ItnoZC0vYzYvznyETl0DiPE=
Received: from VE1PR08CA0012.eurprd08.prod.outlook.com (2603:10a6:803:104::25)
 by AM6PR08MB4708.eurprd08.prod.outlook.com (2603:10a6:20b:ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20; Wed, 4 Dec
 2019 11:48:36 +0000
Received: from DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by VE1PR08CA0012.outlook.office365.com
 (2603:10a6:803:104::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:36 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT048.mail.protection.outlook.com (10.152.21.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:36 +0000
Received: ("Tessian outbound 691822eda51f:v37"); Wed, 04 Dec 2019 11:48:30 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fe38f37264b717bf
X-CR-MTA-TID: 64aa7808
Received: from 65f79e651b26.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 11FFE7A2-17A4-4C25-98E1-1ADCFD12043C.1;
        Wed, 04 Dec 2019 11:48:23 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 65f79e651b26.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GweuT9zZqd4r1pYzXvAT/PxsLgnAS1srfVrK4tjyYrQ64x9lpWFNmz7yEKotwU5fT5UAbvIlBjMPlDjCfR05JuZ99Oju9pjlK5RXqX2YVekvbXzr4nahjdfq3XFvYmooY+6+JyIaQR/oD6jwJ7/Kgxl47EmSJSzlE3F+NpglAKHBE6fv3HJvQxo4Uze0z0isBUH+5hf21zr5QtOcStn6tKCoiedDZfH/1g/k1LjZwbSLFcuOUc+tTvY2k3f6+YCBHZPPV6S7WAcXz4Y5oPky9EngbBMwdWHWQscfpZswWFLhZ7AqdgFjVnKRJweYAtJT4A8VyAS9NP3m2zK/QyxTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DpZqtyyKVj6Kcjcgie43kZcxVAkBsJ624+DdPaI1+U=;
 b=BSO7e9jnLbzv9oaqonRL6ihnuTR1gUamAb51BnwsI4n6C5jG+g41toE/JW9aM/s55+6x7vn5W98htp0MRV2H52uQNSlNr5SgIOUmt5YRrau7lNtHiiw9whZ3XS+0UUCVHzIkFnFiL9VeZB2h19XI9e3OSaW57W85aO9+iIn7Jwa8GnKW9UHZyyaiyQWcDB6ag/C1FgGo1GdJA7wvTjUNRyFOTW1XSCURgQWtPf0DoSqo4BAseSbyEvVBU/zBpvhm/MhGDmY+t8Nn7dQUe0hOE6fJQHu6RGN8EfWpomJ+UWeWZIbrM9KhtfdqIdFoVtINWokaTSQ5XXCKFOsRcuUssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DpZqtyyKVj6Kcjcgie43kZcxVAkBsJ624+DdPaI1+U=;
 b=Hks2Nh4tKLaPbxE7stJ3gDOp+YpzvWKVR7KJDXhD6UJ8JS5Gy+wZN0wuahVXRKdbISDc6Bnd8xV9/ymF1dK0896IvraSm6eyY0EYF2zoYC6LT+V7CeIt4OxBsL6VN3eWqiCTf7arhljkwI4NpJJ1ItnoZC0vYzYvznyETl0DiPE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:21 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:21 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 22/28] drm/i2c: tda998x: Use drm_bridge_init()
Thread-Topic: [PATCH v2 22/28] drm/i2c: tda998x: Use drm_bridge_init()
Thread-Index: AQHVqpi6ihgm+7aiek25lHH7QqgvMA==
Date:   Wed, 4 Dec 2019 11:48:21 +0000
Message-ID: <20191204114732.28514-23-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b15b791-9f16-49d0-29df-08d778afe5a1
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|AM6PR08MB4708:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB47086506B8151147A49B48D78F5D0@AM6PR08MB4708.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:176;OLM:176;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: KYxcctMOwWUkTYEl2YZvoI2q0VKnt8ZwsttTkeFnRqVDZL2q74pFkvX3WGX7GhxVSIvq5x/pfoN3Z1HthjiPOrVtTC8soU4u93Jf8IPvUD9YfJmqjuvIkE7AA93KhjhQIt/+dkg2889k+Jq5wXWFWTkKt4zwRp6Tp1JKBFeapwE3PKdj6n3LVd/L5DEAaqaEfbBeAmADab5/WsNEFcvC5Z69KZOcmlZWxJLm5JstvDYA0YjfKRTXbP+6vRGUAkyLR9PUFm5n7JZ23p4e9ly/sGl8DAHtd+WllRPrYQZQjHIPvI5IRywMphHEUTDmwmDmUD0RQ2WmpKdui+VgEmnLxKk4oomos1Ps2KOA85o3kJCqZTu0jXM4CkEmUOifaawtKnEeprdyO+CmtbOLu1G97dA/gBunUEtZy8+10nWZe+kl/Pw8/Lx0i5zhmH56+RGY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(2501003)(25786009)(76176011)(6512007)(8676002)(54906003)(316002)(11346002)(186003)(86362001)(36756003)(5640700003)(8746002)(81166006)(6486002)(2906002)(99286004)(2616005)(8936002)(1076003)(50226002)(3846002)(336012)(356004)(2351001)(81156014)(6116002)(6506007)(305945005)(22756006)(7736002)(23756003)(50466002)(5660300002)(102836004)(4744005)(4326008)(26826003)(478600001)(26005)(76130400001)(6862004)(70586007)(70206006)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4708;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8f123b41-01bb-42dd-7bba-08d778afdca5
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wi0QXoxn1sgu1sGt5jj3DRN9zhwLiLbQui0PB5cSU9iCWoic6VWwiXMluWHzPCNifSwpfHbERSWoJHpYiaLIYuvdMM6Eq6KB5f9vTEnrDXQIUD+b8eqccY+di04uB1COfErWMJEzkd3oaEhqz5dv0WnpzQBnTvgCJIG8GFH2Xd5Ep7xPugsYrif89DQrGDSFc1kofRau9rooPfwCYvvY9nAhkH9JWd+pN6vN/8ulIJ7DH1/TD7Q0Q5T0eovvp3NDHnFGQTK7RxYlbd9NaSpSc6GEtNz3GmyXL2lZ1r/IsSiTgH9k4kQzBcgE9QTeadcNm2OhV20ZMjjIYMfNDMAERD2ACCBttNjt5cRk2Ni3KLl2yisfrsVqSAfM/WSzv4yVzPMMV2yuKehU18o2SaTJA+ETjkBrE62bdzBtaoNw/XIw2XBrJxeTCe0F1yhjQnQJ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:36.2688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b15b791-9f16-49d0-29df-08d778afe5a1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998=
x_drv.c
index a63790d32d75..f7dfa694aff7 100644
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
+	drm_bridge_init(&priv->bridge, dev, &tda998x_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&priv->bridge);
=20
 	return 0;
--=20
2.23.0

