Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6A3C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D74F2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="sX5I477C";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="sX5I477C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfLDLsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:42 -0500
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:53825
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727821AbfLDLsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GM8A9kiLcrCKYySajRO3pEQWg5CmJV0PJmVUtGtc3s=;
 b=sX5I477CZHpR2Bb0boh0vHzyqhOsyiTxM+ow0TrtpyZSdX2HcRl2ybL7ojxAItM7gTTH6tpa/iVVb+OR6lspM1WjKxWOsev4Exjpo5+U/re/nCTavMZrCaD3+si/fEHns+R9cZeJbrLZytCHiZHcfrmcmvUN5Ko8MbRqynuqbQE=
Received: from VI1PR0802CA0037.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::23) by VI1PR08MB3453.eurprd08.prod.outlook.com
 (2603:10a6:803:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Wed, 4 Dec
 2019 11:48:28 +0000
Received: from DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VI1PR0802CA0037.outlook.office365.com
 (2603:10a6:800:a9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:27 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT004.mail.protection.outlook.com (10.152.20.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:27 +0000
Received: ("Tessian outbound 224ffa173bf0:v37"); Wed, 04 Dec 2019 11:48:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cbe77d516b08bb0e
X-CR-MTA-TID: 64aa7808
Received: from b7ecf5d06a39.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0A30D741-3C09-4891-B968-A660C3920F5A.1;
        Wed, 04 Dec 2019 11:48:19 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b7ecf5d06a39.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIs68CFEmrv8UUftW+jAA3qE035ydmR++vNsn6Knleupy9CfC+egE5xSSJwogDm6pyPd3E6mzIAaykU/wKYGG5a6ux0SBWQWeSVmkh5LTeZBKAlpSC+vk1yaJcF3jDrpleiHhgZtqWIh1fdz8ODpP2woozKVUD49rDK+aD2WliUXAurgODrujfzOgMDXD0nSybySMOzCH4uuPkXS8O7foLn6SOK2FGNZYj+80QxsX/TuIKMVaBjyplKuUIoPCcKrcTKvIPqogFlFEuyF1W6YdXYEXDmVDeONOqPkE/aRtERUqu4JNSJOBiKgQPsotIKMqqbR6611e7EQdbqj/XMSrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GM8A9kiLcrCKYySajRO3pEQWg5CmJV0PJmVUtGtc3s=;
 b=KnSuTJBFzNrkeB9zKnF3Qe/98AWI62opULSlDdrKH5VQDyL+7jFn3igg2mZzsrhYZ4+KyoRPn0pgkTsNVVP7nxUip0ux/tWKoBVuTEJN9IhtHOkG0lbmCKJM/73Y13Ps7k+YDIHPcwY8bMSRjFcLxeUAmV0BV5Yh98ebRHIVdVrVkvEuPrxee/76IljmH9OSvnbA9iLKx/4kix0RcWj8zmDG0ssI4RfUD95Jas0qfm6BpjT+I4RZAUb6U0S1naX0DzHku0/+ZVQjZo5NobWATv7pf0Z0v1CnimYvraCNGgQnKMABxImSCSSdAIQiwwclMhcVfA23b3WTcT3TcS0dIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GM8A9kiLcrCKYySajRO3pEQWg5CmJV0PJmVUtGtc3s=;
 b=sX5I477CZHpR2Bb0boh0vHzyqhOsyiTxM+ow0TrtpyZSdX2HcRl2ybL7ojxAItM7gTTH6tpa/iVVb+OR6lspM1WjKxWOsev4Exjpo5+U/re/nCTavMZrCaD3+si/fEHns+R9cZeJbrLZytCHiZHcfrmcmvUN5Ko8MbRqynuqbQE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:17 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:17 +0000
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
Subject: [PATCH v2 17/28] drm/bridge: tc358767: Use drm_bridge_init()
Thread-Topic: [PATCH v2 17/28] drm/bridge: tc358767: Use drm_bridge_init()
Thread-Index: AQHVqpi36/4eTQFiyki2i0rMuhwe7A==
Date:   Wed, 4 Dec 2019 11:48:17 +0000
Message-ID: <20191204114732.28514-18-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: d7f8638d-dc8b-4997-7515-08d778afe08b
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|VI1PR08MB3453:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB345360ED9EA41F338B13A9018F5D0@VI1PR08MB3453.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YlxB+HTpQ4d9EpTK+RSJPv3G+F6EDMxwJvpbctT4rgskUowZNTTNmOBedeBwVq0w/DcbkSMwOKViLSC3lnIU/IT4E/dyqiXwwiBeO/6uMY47cnjhywuzboBMpugtvA5cIy3Pmvh5+r2EPUeHwyHgC6nxiLxiFxXrrVocYMn4H7Dq7uyFQoL0K2pSdPY+MjWVqLM2+OkbMj/2RJpiiiuFec/I2W6D6wZSB6j2JEoUIVuvGGdIB5Hlr6OBE/upaZttazMfk25eX8rj8vOkR0kAAi5p8AybFxeYtdvMhgatebmZkvuAcE2jB93zxwGOohnnTwR5UR3Tnxu4YdtKCt7RbSvk8GekQM9hRIq1yiBohFHoTXGBFGpb/s4S24GFQINC6yt4uPpnyMqkSKEdogQuRXFbWCNlHiaUblcsjz0E5w08LhTmmlpVEHF3awfWzOq9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(336012)(2351001)(25786009)(8746002)(8936002)(305945005)(76130400001)(1076003)(5660300002)(7736002)(102836004)(4744005)(23756003)(8676002)(26005)(186003)(2501003)(50226002)(50466002)(26826003)(54906003)(11346002)(76176011)(6506007)(81156014)(478600001)(2616005)(81166006)(14454004)(86362001)(356004)(5640700003)(6862004)(6486002)(99286004)(6512007)(36756003)(4326008)(70586007)(22756006)(6116002)(70206006)(3846002)(2906002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3453;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9514c0e7-2049-4344-f783-08d778afda1d
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjE5f4RQRh1s5MIOs4HN8r39X0yT3xFGnZG+5UhTmiAieb3asdOCaVUynl2ZQ7+G9b1agMWfm1KuItCTrf8VeF20qi/HUt6hyPgpniInU4tp7z2tjhd/FVqB3BvjGSuYgFdznORqZtEc7z23eIeVwehNgVAKQrOOzPT5G6NKb0RwZS6JXS6fcOGuX/cYWB29gXScvlhyNRyrpsSXfR10QegBGVKp/uhOsJ4e6oOPi7/Hk0l36aG+FtHq/BRR3XEWmPss3v1ynPBLstjsl4u4/GdzK/SqLNDh8L8GsN7QiOzUQi3HcqW3BpatvdYKOCG2uSA1e+DB11n9oXkUInr0/Cj4eWxB4CQZZKEwSXMvGFe7Z14aJ/nKdM2Zp83L5ySc6JBnyRRDTqzfoBR48XZ8x6XXyfSkSq8RhxtJItcwyfI2/yAz9hCzEPrjEnj4kwiO
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:27.7559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f8638d-dc8b-4997-7515-08d778afe08b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc3=
58767.c
index 8029478ffebb..7846c1925cbb 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1671,8 +1671,7 @@ static int tc_probe(struct i2c_client *client, const =
struct i2c_device_id *id)
 	if (ret)
 		return ret;
=20
-	tc->bridge.funcs =3D &tc_bridge_funcs;
-	tc->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&tc->bridge, dev, &tc_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&tc->bridge);
=20
 	i2c_set_clientdata(client, tc);
--=20
2.23.0

