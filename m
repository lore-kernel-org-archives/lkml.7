Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51710C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B7121852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lO5mfUjM";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lO5mfUjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfIQPFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:05:33 -0400
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:21338
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727962AbfIQPFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP9iFk7RX6CHTWY3hcW0MLMGf4HZxKv5hIJghkf5lb0=;
 b=lO5mfUjMENiAVpZYKYVDkKlhMctE//6G/Mwl4SG7l+yUDh4lLW6D3XkPzCSV/jQ2xgGZEAXCEmgReUvswyG7Ni5aq0Yt77lpYPaSU8KvMGg8kjmz1Nx4JuE60k9k56d8bFuxY+o2fE/+sgcUjZY2pZgZgtoqPMKsrZmIJdmJc0Q=
Received: from VI1PR08CA0217.eurprd08.prod.outlook.com (2603:10a6:802:15::26)
 by AM5PR0801MB1972.eurprd08.prod.outlook.com (2603:10a6:203:4b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.23; Tue, 17 Sep
 2019 15:05:26 +0000
Received: from AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by VI1PR08CA0217.outlook.office365.com
 (2603:10a6:802:15::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.18 via Frontend
 Transport; Tue, 17 Sep 2019 15:05:26 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT056.mail.protection.outlook.com (10.152.17.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2263.14 via Frontend Transport; Tue, 17 Sep 2019 15:05:24 +0000
Received: ("Tessian outbound 968ab6b62146:v31"); Tue, 17 Sep 2019 15:05:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 605c4ed9ea2b9c5e
X-CR-MTA-TID: 64aa7808
Received: from 00f66f62f898.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 77454D2F-25C9-46C5-BE17-7F5D27DF74E4.1;
        Tue, 17 Sep 2019 15:05:13 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2053.outbound.protection.outlook.com [104.47.0.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 00f66f62f898.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 17 Sep 2019 15:05:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbR17fV/c8knnTGUNym2d+dVeJhcyCagQdg2eYrCIIQ9KK3vhPt1FcCIequvlQGS8dibEfzkzqheSWFpiVav5cXR3iHbe5VuVxLDTRsjch5/duiG015/HM9u2PvFvgQqGJikNS1djVXJoSez2H3h5bmCbJsRrPz0fGY3T221yYO/xIuQCICyPU+KW0OUJ/jMUsB+nb6Bv7On/k94nL9P3iZzxqoa9n+MMQiz8OACOp21HSUIKEo+qx9S6RnVF1w958Aflkruxi6PGuvzJWzPlyIs3GkGlmb28Jk+QscwgOM43AOgVAqiyYgCCySCkMjqJ3/IMRKm24Rsv8zPDHgI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP9iFk7RX6CHTWY3hcW0MLMGf4HZxKv5hIJghkf5lb0=;
 b=hqIEawCAkC3gWl1OCW2mlq5AMvmW3wqzGUjnQMEg5KtZJSghIEn8gaM5RRmnBFMPwYqZgg4a7ic6r7ukbHBp0RX4K1rU4+Qc0F8uaIkkjSGh3SjK17+LKFWOsgB+1RvKch9OAp2pJM0G0QQwakb6K2qVShb7gOzxqjKn0qYQ7tPGTz9oixRG7ocOmdn+0rZC1P5DZ+/VT07i+uzZTDFKqM/Nmik4Jm52jLetik3zPn2c1KCF6t8n7JHGJ5wJiGnaiJcOHPXu1vGPueVqqthToCuUedXKsvT6nK24BzaZ6n0GYuxwFiUtVRsSJxDboIHqJpOvzEBszklTdCoFM6ElbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP9iFk7RX6CHTWY3hcW0MLMGf4HZxKv5hIJghkf5lb0=;
 b=lO5mfUjMENiAVpZYKYVDkKlhMctE//6G/Mwl4SG7l+yUDh4lLW6D3XkPzCSV/jQ2xgGZEAXCEmgReUvswyG7Ni5aq0Yt77lpYPaSU8KvMGg8kjmz1Nx4JuE60k9k56d8bFuxY+o2fE/+sgcUjZY2pZgZgtoqPMKsrZmIJdmJc0Q=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3247.eurprd08.prod.outlook.com (52.134.30.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 15:05:09 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:05:09 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/komeda: Remove in-code use of ifdef
Thread-Topic: [PATCH] drm/komeda: Remove in-code use of ifdef
Thread-Index: AQHVbWlL0OWI56HteESDsGRUxRcZfQ==
Date:   Tue, 17 Sep 2019 15:05:08 +0000
Message-ID: <20190917150314.20892-1-mihail.atanassov@arm.com>
References: <CAKMK7uECMr46Ag8E=eqTKdZxgt_4M42t7GEyNGv0gxpv-TL3Pg@mail.gmail.com>
In-Reply-To: <CAKMK7uECMr46Ag8E=eqTKdZxgt_4M42t7GEyNGv0gxpv-TL3Pg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::14) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 07a205c4-b640-4229-a239-08d73b8077d7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB3247;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3247:|VI1PR08MB3247:|AM5PR0801MB1972:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1972D8263A2F67E2F7F196058F8F0@AM5PR0801MB1972.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3173;OLM:3173;
x-forefront-prvs: 01630974C0
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(189003)(199004)(71190400001)(52116002)(6512007)(2616005)(25786009)(476003)(86362001)(66066001)(81156014)(11346002)(102836004)(316002)(26005)(66556008)(64756008)(66446008)(6436002)(6486002)(446003)(54906003)(50226002)(8936002)(6916009)(81166006)(2906002)(66476007)(6116002)(3846002)(4326008)(99286004)(7736002)(256004)(305945005)(36756003)(186003)(5660300002)(6506007)(66946007)(386003)(76176011)(8676002)(478600001)(71200400001)(14454004)(486006)(44832011)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3247;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 71zfecJ59+DfTVyD06TL1uQ+MlxnmDli6F+/uBIpKGmmWx1SDP4NtVXFv2MHl4nVhFkdOT5dQNAVbbikpkIceWBtMTb5jIh8yNtbUyPkXDKlqqzYZL2o62hDtEPpORHFfnVPxhw+Asz7XbaFhK9F0l2PM5rvmUrsV2oCiSKkW9B/amj5nvdQNVanbAR385swpy7dpOefBoMax9VO4gT5LqTSfFKM5AhBZDXqjJrPbEyCyYrZzB0R9g0Ug6wPAlM6fY+vPl7zxweBv65PD350IM6wV3kFkHT8RZcHX70hAqfr4Xsg+epdoZG4kX6ENrlfsPeBz/uCEhsYGVk1FfVOK+aFLVT2OGVAHVDAaOsL+TxgL/Z/tWMnxkggBN6AGp0GaGJ0Tc8A224srVD/1HXfuaUUYR5c1BTCnFv7fZaMHLU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3247
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(2906002)(86362001)(99286004)(356004)(23756003)(6512007)(1076003)(47776003)(186003)(4326008)(76130400001)(305945005)(486006)(102836004)(70586007)(36906005)(6862004)(70206006)(50466002)(14454004)(26005)(478600001)(316002)(63350400001)(54906003)(6116002)(66066001)(25786009)(36756003)(50226002)(8936002)(3846002)(7736002)(22756006)(5660300002)(476003)(126002)(26826003)(6506007)(336012)(76176011)(81156014)(446003)(2616005)(8746002)(8676002)(6486002)(11346002)(81166006)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1972;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: af7ce52e-666b-44c6-c4c6-08d73b806e0e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM5PR0801MB1972;
NoDisclaimer: True
X-Forefront-PRVS: 01630974C0
X-Microsoft-Antispam-Message-Info: Eck5njgEGhWqr7cok1kEKQ4ndr/3smgVw7Ql1ohlMUjJWxq5VQcH/soaxgoiQkC343kLHqI/9TfYKVhV1qY/lxa8jmR5RhFGhewX8J4HZ2AAwz6aHr+IT7MfOrJ5CgAyW8LsIcRrSkO3Fn4E6yY3gAaSPUocaEyJHbeYJEY9RFMHEbYLkeN+T5dDbUoajt4Jm7p7lBUEyt+qvWu+nPaUaleJZ6q2QC93SyFMCSvNvde9tbIqPi3ZT4OyQxHnWpX55Ks6gV2zeUdasP2+QuA/IhqM/fmGwhbR/eV7wR7b+KOfYoZNGf7SbLyEo4RAgyqzrS6Sj0+Coz/2vVP1Zbvt+xWQgNKprzxDDn3il6XToOl42Y32+CkM38/8og5eRFU8o2yWte9lCbV3PPjb0Foac3Un1rq0BaU38wdyqMDMsFc=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2019 15:05:24.8137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a205c4-b640-4229-a239-08d73b8077d7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1972
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a dummy static inline function in the header instead.

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lowry Li (Arm Technology China) <Lowry.Li@arm.com>
Cc: james qian wang (Arm Technology China) <james.qian.wang@arm.com>
Fixes: 4d74b25ee395 ("drm/komeda: Adds error event print functionality")
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 2 ++
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index e28e7e6563ab..8acf8c0601cc 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -220,6 +220,8 @@ struct komeda_dev *dev_to_mdev(struct device *dev);
=20
 #ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
 void komeda_print_events(struct komeda_events *evts);
+#else
+static inline void komeda_print_events(struct komeda_events *evts) {}
 #endif
=20
 #endif /*_KOMEDA_DEV_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 18d7e2520225..dc85c08e614d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -47,9 +47,7 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *=
data)
 	memset(&evts, 0, sizeof(evts));
 	status =3D mdev->funcs->irq_handler(mdev, &evts);
=20
-#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
 	komeda_print_events(&evts);
-#endif
=20
 	/* Notify the crtc to handle the events */
 	for (i =3D 0; i < kms->n_crtcs; i++)
--=20
2.23.0

