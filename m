Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF829C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887F920661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="uUNDc+HH";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="uUNDc+HH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfLDLtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:49:45 -0500
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:58222
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727637AbfLDLs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br0IlITciAKMvoJF61FmiO4/HJaoP04jFIkFIztPEYA=;
 b=uUNDc+HHCbMYXzI6UrL/Cx/cB4W9VkAX2bV96BJdpqNIO1mGf9xR+8XoVf8maf3vVW+KeuDd8UnBTClvPsNK0HD7WNHOH5j6d06L6phbAr42kkO31bRbuVO8/vQQwy8SyORqZ4dQC5tyaVYYBe8gcaJw8QZkeikw2AtIV585JAE=
Received: from VE1PR08CA0006.eurprd08.prod.outlook.com (2603:10a6:803:104::19)
 by AM6PR08MB4689.eurprd08.prod.outlook.com (2603:10a6:20b:c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Wed, 4 Dec
 2019 11:48:22 +0000
Received: from DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by VE1PR08CA0006.outlook.office365.com
 (2603:10a6:803:104::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:22 +0000
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
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:22 +0000
Received: ("Tessian outbound 691822eda51f:v37"); Wed, 04 Dec 2019 11:48:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7627a8a30590dbf4
X-CR-MTA-TID: 64aa7808
Received: from a83b0422c187.12
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DA34D32C-9E51-47F9-9857-E42DB5C7A577.1;
        Wed, 04 Dec 2019 11:48:12 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a83b0422c187.12
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUFyKGLDv8P+18xYbOG805g1B+VKWZ/is0j+0N3/5mJ/vpNnIODRwb6SoPLMf9ecB0ZeVkkWGSlFsJ8/Hb/gbX8KFrh5jJYFkiGRuULvX8mq+kiUy6MJRIk3PvpHp0/vzio5FfkrzGBVrAZ5bVB3hYYj2PHucPqN0KDckKxlLRdjITYue4qx1C0n0q7i27i1JfYGa8v/qE2Y1ohqSdmJMl/ZzKF6N9IfGFaTQfaBhTfAM/dFKCmqpGjFUGLVXAbA4Ty5a+uUPL8h6cQKO5qkBi7rVprhwj/3TMMqqGI0dEZ6ISDBi+IwIoOSX7nYjamRRKz6oyPMqIbzNqsSJhlBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br0IlITciAKMvoJF61FmiO4/HJaoP04jFIkFIztPEYA=;
 b=FcHV6oyJvyq7H//1R/6aWcRZ2iqzxk4fNsPW38wY+mwly+A2N35wbtrSgeHvvWROLDR4+j1SEe37jXQQWOUjrxmlLuDm5rmrRE+hA0p/vn0SMQ8vXLjv8BQyIStF4rMWioLzGaSHcefMh9tsYERaezmjY8G7cAywg0N33CUq1EUAJEmnMid+qskdOjfnLD/9zvnNhXi1z1vz8Rg1e04OLVEFH6AOvowKRixav4Ei2OTH1ON9/nbpCVWOdl14+SW471A9XoIjgr3ayUtHLDb2pXG8jmHdwoeqhAxNsn95P2yfqoKvogAKT4VIQXSRRPdbU7ZvfXNhiFQDraj5eZYELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br0IlITciAKMvoJF61FmiO4/HJaoP04jFIkFIztPEYA=;
 b=uUNDc+HHCbMYXzI6UrL/Cx/cB4W9VkAX2bV96BJdpqNIO1mGf9xR+8XoVf8maf3vVW+KeuDd8UnBTClvPsNK0HD7WNHOH5j6d06L6phbAr42kkO31bRbuVO8/vQQwy8SyORqZ4dQC5tyaVYYBe8gcaJw8QZkeikw2AtIV585JAE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:11 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:10 +0000
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
Subject: [PATCH v2 10/28] drm/bridge: ps8622: Use drm_bridge_init()
Thread-Topic: [PATCH v2 10/28] drm/bridge: ps8622: Use drm_bridge_init()
Thread-Index: AQHVqpizay7d4VaJM0yJ4GyAV6AMEA==
Date:   Wed, 4 Dec 2019 11:48:10 +0000
Message-ID: <20191204114732.28514-11-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2503459f-7edf-4b87-86be-08d778afdd78
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|AM6PR08MB4689:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4689FE4D1CC01167694F43CE8F5D0@AM6PR08MB4689.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: W4PlH/TcKXIKVdX9JPXJP0R19/a92nQgR2DgxDQoZlPVetYuDugHHLEEkrV3l/vlsizDHViEAk2dz2fxS6ImMUMUqrsNsv9yWic18B9wMbiQaMT7FnWjaB2EFay8hKfmBwkceFcfYTfOim/Gbl3IyCOenpVmlJn0wDLPcjM6RNnk5FE7s/6OOqsURqqoMct5g2DzKew3P5TxeheUvNz4VBGn5oyevoXE1c9HExKKKPaZqM+cFbmrGwTkILlpTboYgpQJF+g7JTCpWMRcNjv3+xfv/JVFvP/XLz8+zUcoR6V65dKH4h5D0hFhmUQZWQ4LTusLaFmJTS7FMCuX4nde4psfJ+dqoWjKORg9E+emmWIvpcob3JcXrhca0smrQ/5BP0c8vq6U+mnm8zvRe5gJs1KlqzDtgdcJXtK9AjEZOAb6ydf3KWpKAbGeNMrpiAdA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(1076003)(7736002)(50226002)(81166006)(2351001)(23756003)(356004)(4744005)(22756006)(8676002)(305945005)(2501003)(81156014)(86362001)(36756003)(2906002)(5660300002)(8936002)(8746002)(14454004)(99286004)(54906003)(11346002)(5640700003)(102836004)(186003)(2616005)(478600001)(336012)(6512007)(26005)(6862004)(26826003)(70586007)(76130400001)(316002)(3846002)(50466002)(6506007)(70206006)(25786009)(4326008)(6116002)(76176011)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4689;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4ed00b8f-41c3-49c1-63c0-08d778afd649
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KsM9tVbItyTW5rN2gwhY3jUxLmxAF7d9VDX5OWsqUIB2q28Rih7MktZZxvEwbRnHxFmScXDd8rzPvOLHyrU7wYqdxFgSbe7TvJOIKPItpMbTd0377SO8q/bSAwO3j5cNvsTc5ODlfiTJrgosy4UFyAKxGyS1/SUMrj1XKGQU4JhO51nMfvnew7s12gQjj+WJ1Q/DH7NIl4jVjiBMiTY+N7pho/rSDiqT5MP52YJjO46GosL54G2LyX8fqtAvggYupMS+E7Uj+7pntYskaTNXBBUQoUeaqZJo4k6E94FPD3aEGl7TvBpmNWyEUBPS/KfR40mobWkM7A5XHRdDmXlOkWqB8Qeq3saQ3pTVnhYIXRNFqrTY9IxSmX0+iRvBhs1146wS8VQOgOObCYhdPh3GD7hELA5b69p3N3tv2ZqTWqLGlkgSZ95X6QTyCdMy+iU
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:22.5967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2503459f-7edf-4b87-86be-08d778afdd78
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4689
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/parade-ps8622.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridg=
e/parade-ps8622.c
index b7a72dfdcac3..8454dbb238bb 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -588,8 +588,7 @@ static int ps8622_probe(struct i2c_client *client,
 		ps8622->bl->props.brightness =3D PS8622_MAX_BRIGHTNESS;
 	}
=20
-	ps8622->bridge.funcs =3D &ps8622_bridge_funcs;
-	ps8622->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&ps8622->bridge, dev, &ps8622_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&ps8622->bridge);
=20
 	i2c_set_clientdata(client, ps8622);
--=20
2.23.0

