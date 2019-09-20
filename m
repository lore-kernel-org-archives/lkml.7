Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D290CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B792086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LH5AE6Pr";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LH5AE6Pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393351AbfITPLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:11:55 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:24165
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390869AbfITPLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHVkMlSR2b6lI592n0vukuzMF2CuiDiXSXEf8V8Zhzw=;
 b=LH5AE6PrFrq8mHV3szGUZQHhZnlFkKZRwqNzi/m6RGZnqW+mP9O93F1orDjmokTY/sMxgGe7BY9FmTEl6wu+igdYdy+fvw9aB4zbEoOC964bfa6p8VCujqpiDCHjxCXWlbRYX3PO5HIlffG9c4wly8BeDx+voq4WJ1ALU/cxBiE=
Received: from VI1PR08CA0192.eurprd08.prod.outlook.com (2603:10a6:800:d2::22)
 by VI1PR08MB2799.eurprd08.prod.outlook.com (2603:10a6:802:19::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Fri, 20 Sep
 2019 15:11:48 +0000
Received: from DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by VI1PR08CA0192.outlook.office365.com
 (2603:10a6:800:d2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.20 via Frontend
 Transport; Fri, 20 Sep 2019 15:11:48 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT061.mail.protection.outlook.com (10.152.21.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Fri, 20 Sep 2019 15:11:47 +0000
Received: ("Tessian outbound 96594883d423:v31"); Fri, 20 Sep 2019 15:11:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 559811f6c7f1a935
X-CR-MTA-TID: 64aa7808
Received: from eb9bcdb5fd13.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3CD20C1C-D022-4971-B17E-3C2D0624BF6B.1;
        Fri, 20 Sep 2019 15:11:37 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2053.outbound.protection.outlook.com [104.47.0.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id eb9bcdb5fd13.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 20 Sep 2019 15:11:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4O34PFubAK/EOitBubVvox0j8+Op7Z+yHC3J1V2t5WMAcCr2VmYrO8J24FJseV5TMXx82nvnxrGeQZ/UMR43RGS5RVqpAfSaje/y7qMnNC3RDSG58PwBnYflqBxHgNNB63zlLNeHuScrvhXu+UteZST7WxKv8RpDdneTgh48pYtum27VvGJ7vV8jC6vIleEUVgImG/LdbrOCVLfrnJwA330XMcnbtGSYvwbz2IbAPCGT78DmJk1yBfaHWQokkx0XW4t+nt5cJwpfMcO/PBvhaTCoU/OUxNAvObYLPpzDvTzFG0nPVNqcM0agv8C9comhnIYx5lRQDQT1QidmBPn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHVkMlSR2b6lI592n0vukuzMF2CuiDiXSXEf8V8Zhzw=;
 b=oc05TgBFek8iNvODGrCcPyk0eXVB0bAmE9NccC0zKbfRjK577cW3eG0KfV2pobo9odrcgzUYvZr7gH1jLGhbEM7vj3oO3nrXDT9eyOM7MsCiy6tFWSDiybX5jCtQiYKdLzU+/sQfUDtydF78V9gAtbA3U6TCI9RD0LIAVr2Q2gargdEVFdvIaqgNBllAcjgOG38zABcMtfpufe37CqnXEGvlNa2VEBeXnGQ3HU+fz3OV/x4kn0qVSHGsfUW1iAYQQVe8gHpd0qmlPqAercPgm7Cq6lTG7YgXXaH3r10I8zhwEd7WpXO2YC6Pdbyg3MfD6w6XJDoRNEa7WndJ1YjQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHVkMlSR2b6lI592n0vukuzMF2CuiDiXSXEf8V8Zhzw=;
 b=LH5AE6PrFrq8mHV3szGUZQHhZnlFkKZRwqNzi/m6RGZnqW+mP9O93F1orDjmokTY/sMxgGe7BY9FmTEl6wu+igdYdy+fvw9aB4zbEoOC964bfa6p8VCujqpiDCHjxCXWlbRYX3PO5HIlffG9c4wly8BeDx+voq4WJ1ALU/cxBiE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3264.eurprd08.prod.outlook.com (52.134.30.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 15:11:35 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f%7]) with mapi id 15.20.2263.023; Fri, 20 Sep 2019
 15:11:34 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/komeda: Fix typos in komeda_splitter_validate
Thread-Topic: [PATCH] drm/komeda: Fix typos in komeda_splitter_validate
Thread-Index: AQHVb8WxZ1V2B5EmMkKFYK26VJ4Bbw==
Date:   Fri, 20 Sep 2019 15:11:34 +0000
Message-ID: <20190920151117.22725-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0326.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::26) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 456bdace-1532-47c9-737a-08d73ddcdb32
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3264;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3264:|VI1PR08MB3264:|VI1PR08MB2799:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB2799B91687E86988022F3A348F880@VI1PR08MB2799.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4125;OLM:4125;
x-forefront-prvs: 0166B75B74
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(486006)(50226002)(44832011)(99286004)(476003)(52116002)(2616005)(6512007)(305945005)(66476007)(8936002)(6486002)(256004)(6436002)(66066001)(14444005)(25786009)(14454004)(5640700003)(81166006)(8676002)(86362001)(6506007)(386003)(81156014)(26005)(102836004)(186003)(478600001)(36756003)(6116002)(54906003)(2351001)(4326008)(66946007)(4744005)(5660300002)(7736002)(316002)(64756008)(6916009)(66556008)(66446008)(71190400001)(71200400001)(3846002)(1076003)(2906002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3264;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: pZ4kEpFU60Lz5LR0rKpbeVpBzCccW+SFe5z2yjrCuiMlQ0DbjJlm/h0geq0mGaqc3wD+3JO5SE0IfZHdI1fcZvsAyaIOi0kcjnnBENmKfKTakO5KTOuc13z9xW2jeIrRjnhSzSrxxIOxNpRfc4CLETJOXF9AGRrRvPbuZw9W+ZQriPZn3JTPsulNhlsRDFrs+vkD852WPd1dnDqDbmASpux7lQDcfEE2ob8QpgJQrp3G1DcLxEmzRrCg78Ywfap9dH2v0NgW75tHslg1cDJAOzY/bZpeIiYQNfbYJJqWagLgLPc4V4GJyfWy7jxtpTM/qij5D4U553kXEwXR+7G2kxvcAwIgJ1sXxRO23wS5NvWh897QccV/Ny3et9vat2u9Z6GrRvdcA/+BtYq2//pqfcfHEgl4x4TQEJdazIkG+fw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3264
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(199004)(189003)(4744005)(86362001)(25786009)(14454004)(4326008)(486006)(186003)(22756006)(70586007)(6862004)(23756003)(50466002)(102836004)(336012)(476003)(478600001)(386003)(6506007)(76130400001)(5660300002)(26826003)(2351001)(126002)(63350400001)(70206006)(26005)(1076003)(99286004)(2616005)(36756003)(6512007)(14444005)(356004)(47776003)(8676002)(81156014)(81166006)(50226002)(305945005)(7736002)(8746002)(8936002)(54906003)(5640700003)(316002)(2906002)(66066001)(3846002)(6116002)(2501003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2799;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3e808726-8e9d-4170-0aa9-08d73ddcd374
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB2799;
NoDisclaimer: True
X-Forefront-PRVS: 0166B75B74
X-Microsoft-Antispam-Message-Info: Y3YoXzQed3suMqGuCZp7iuQw6vYjsXP8pIUNMkYgP9U8j6x7+plYPqpOrcXrO9pZnrUDuHyzPNVRuo0Deau1gUvt3xTFDseGmzKs08S1upWyrZ7zKwyNn3jm/WN+IUFNQg0M1mSLdUl+ZnbFC2CvyRdbtFDgSUMQXVDkUXlZc0bfJ/atAR8iM6WHDQ+OQroji1GDnWUyWFlPaHi3sgZwmBOH5ule3m1fI7nQC2WVHsCBEMCau4bI8K8KGQLznNfZfJkcfa0bfmv83u5rlofcelIo2gLfAF8UPfLtkJ56MkFoX2poCo3TLKKQXaTqIFENirkfoUcVbd/UunrQuKRU9bOCAqE3rIuVa0SJXHQuOG0segKdbe33bqkJ/zns7hLjnVsBnQ7meKx9AerKdI0e/j/vIfFj0GT8qrjKbInUWVg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2019 15:11:47.5330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 456bdace-1532-47c9-737a-08d73ddcdb32
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix both the string and the struct member being printed.

Fixes: 264b9436d23b ("drm/komeda: Enable writeback split support")
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 950235af1e79..de64a6a9964e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -564,8 +564,8 @@ komeda_splitter_validate(struct komeda_splitter *splitt=
er,
 	}
=20
 	if (!in_range(&splitter->vsize, dflow->in_h)) {
-		DRM_DEBUG_ATOMIC("split in_in: %d exceed the acceptable range.\n",
-				 dflow->in_w);
+		DRM_DEBUG_ATOMIC("split in_h: %d exceed the acceptable range.\n",
+				 dflow->in_h);
 		return -EINVAL;
 	}
=20
--=20
2.23.0

