Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42E3C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633C52077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lh58ZyPx";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lh58ZyPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfLDLt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:49:28 -0500
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:31463
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727852AbfLDLsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC07oWCTRqP/8StEgXjpaLEu5lG/XpQZxdcu8dfM6Zo=;
 b=lh58ZyPxGfqLQdQxsGZa15/2Daj+nB64KB5JBa8eof++k/xA3WtcqpbM1BqtSyjUBhTPRUkTGdYzEgVZK5UVlKN/vueJkbHDH44NpRK5I1tEbuJ/t86l3GLKfsjcZNxc2Yw6frm6lnjlmh6/2V0qWa2iZQ0sC9vea1Vf2fbkG2o=
Received: from VI1PR08CA0170.eurprd08.prod.outlook.com (2603:10a6:800:d1::24)
 by HE1PR0802MB2617.eurprd08.prod.outlook.com (2603:10a6:3:e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Wed, 4 Dec
 2019 11:48:33 +0000
Received: from AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by VI1PR08CA0170.outlook.office365.com
 (2603:10a6:800:d1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:33 +0000
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
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:32 +0000
Received: ("Tessian outbound d55de055a19b:v37"); Wed, 04 Dec 2019 11:48:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5dc754a238b73100
X-CR-MTA-TID: 64aa7808
Received: from 14edbbfce2ee.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FE97C952-65B2-4035-BCAC-6B9C9FB016C8.1;
        Wed, 04 Dec 2019 11:48:24 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 14edbbfce2ee.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APbrI4Urj9VExqMHSrIue4bVG/GX7/ns+f2PGDF/bhjZM3FsfI9R3e8PPqvxMb7YjClfG4Ef7G5h4Q79cMLL5FqWDeSS5ixqfNrIb9ZPu0R9uTgVTS4Qo+5Db56Dc5gM8LWnY6i+SYN3kEbSsh1uXiTx2IHtHzBWrT8gJesHftw/TQjbnlOP6ETR6I5dpLfctTBcWNMLBCWYa7OE7eoukn1o1h9J9twIeLi//c4igOqRM8klduvPfXo3nga1oHtuJ+qqWS46qB6YNPojO3RlQ0kTBOBTq23J8L0dLFD0KAHt66ufwwpmJE+hNMepHVaKBY5ML87300jJdaZPJDiI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC07oWCTRqP/8StEgXjpaLEu5lG/XpQZxdcu8dfM6Zo=;
 b=W/7rkHZrQ8z0yhNmT1VSahZkRIrr78RnAxHjHkL/lii3NX2ZzIEPI9EA/tEy2kWt2iCwKl38TOWqzoMcUHM9rt8Samr7hMRrccFdDNFnzbhI+bEigNWm9E810mGRTI6gWzOKXV+Rj4slRJsZ1rN6Ep48xu3G6GBjqUTTE/R/rdxjRbDpHYdS2xEUmwYpr2UHZMmCPWamoaia5ZaaPAbRiAQ9vrvcuDGPc/bGAlvS0gYnINGu6H4KBBuza2esna8JSuBvqr+proBujtP8dbNZF+rPBoHv8St6GxgCbTMge3MO3b3PDv9k39jpEfKzcOlXvnfQ4onCoGrtZW+A6cRJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC07oWCTRqP/8StEgXjpaLEu5lG/XpQZxdcu8dfM6Zo=;
 b=lh58ZyPxGfqLQdQxsGZa15/2Daj+nB64KB5JBa8eof++k/xA3WtcqpbM1BqtSyjUBhTPRUkTGdYzEgVZK5UVlKN/vueJkbHDH44NpRK5I1tEbuJ/t86l3GLKfsjcZNxc2Yw6frm6lnjlmh6/2V0qWa2iZQ0sC9vea1Vf2fbkG2o=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:22 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:22 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 23/28] drm/mcde: dsi: Use drm_bridge_init()
Thread-Topic: [PATCH v2 23/28] drm/mcde: dsi: Use drm_bridge_init()
Thread-Index: AQHVqpi6sdi//MuIqU22o6K6k+uyEw==
Date:   Wed, 4 Dec 2019 11:48:22 +0000
Message-ID: <20191204114732.28514-24-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 48f5fbd8-84b8-4491-0bcf-08d778afe3a3
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|HE1PR0802MB2617:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB26174F6334577060A93A371F8F5D0@HE1PR0802MB2617.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1360;OLM:1360;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: FTFVj+gPip62yXlCKKHms13eg4qBbi4IKGzrINZZtBCQQpz+6vmmx+0ODL+hyeHSicOokn5WbGptrRKz6wfj3D2UnfBbzMV4XRzI0vld2NBZ0q+asrrsWKBnEJE3y3VgT34OuwBzBI97oXuPoNIc2KocY+Mp6xuK4N4iCQyhG3fxqWq1GtgcaCbUabioUeuJpOrJu3VCYCvdtqg4SO8jVzG1BzcMGXgtZ70qLBFUvhg/jhnIa8C5WC3vYogc1rbMVFsYGk7Is/b0bqNFeA9/waVD5L8MZyQdwr+S8l5ee3qhj4QTuJZ6KBdvD5h6NWTuAO8L+apJ2oPrTFULzA8Jo0kWy/KQbZSn4Oz/xgTi0DFeFvem82LUC5gCkaS/ChqWsbWWR9rgj1zirhtBVrzxcz55HXGJA1Nq5VqeqLJpNx+vS8PaPalzH+Zdil7z7cR4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(199004)(189003)(6862004)(5640700003)(99286004)(2351001)(76130400001)(6486002)(22756006)(316002)(36906005)(7736002)(36756003)(305945005)(54906003)(70206006)(6512007)(70586007)(6116002)(3846002)(4326008)(2906002)(356004)(25786009)(50466002)(8676002)(8936002)(14454004)(50226002)(336012)(186003)(76176011)(81166006)(81156014)(23756003)(478600001)(8746002)(102836004)(2616005)(26005)(1076003)(26826003)(4744005)(2501003)(86362001)(6506007)(11346002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2617;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 179ba75c-0e52-4ff5-0fa1-08d778afdd1b
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61qJOuz7NRfozOgHAqiPgJxy78ivSt3PvHU6WsI4TaVnTT4RCcpN+DatlvgE+M5cTTrIuM1YmTvYG7ntsWDPBSw/d8chucJaSeC6R4hVCistLHMacTlSUueqaOrr3IZCUXzVJ7QSm9moyES0krcck0EDSuLq/HJD6zCSJqgeE7SsWQkkIxxBgk+T2BtHxG8lKaWVZ6vdcvqnLPCfC4rHFgV2IoG+Fghqdl3Y8C8n4u3/gJ5XHY2PKLMdeGjQo3jxpf63I+GB6AaOMadNHwfIzP/GA1PF55k+In7LT4Eo+LKV78p5Kuat4pcgjAZ0pepERub2R+/4xZWijbSx7T9OStVtsPqkS+MV7VP+A49sAMlevYvVOzbcTfRgSfxp64hfbiS9jB4/sqLO9Vmirq3ycYuriFBczFW0Kphkb/QHwKxKs/abzAL9z0IH0/IjaLqd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:32.9147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f5fbd8-84b8-4491-0bcf-08d778afe3a3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2617
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/mcde/mcde_dsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_ds=
i.c
index 42fff811653e..d9b9253acccf 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -955,8 +955,7 @@ static int mcde_dsi_bind(struct device *dev, struct dev=
ice *master,
 	d->bridge_out =3D bridge;
=20
 	/* Create a bridge for this DSI channel */
-	d->bridge.funcs =3D &mcde_dsi_bridge_funcs;
-	d->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&d->bridge, dev, &mcde_dsi_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&d->bridge);
=20
 	/* TODO: first come first serve, use a list */
--=20
2.23.0

