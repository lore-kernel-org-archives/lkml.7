Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C172EC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E20120665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="a8A46wVj";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="a8A46wVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfK0RFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:05:52 -0500
Received: from mail-eopbgr140043.outbound.protection.outlook.com ([40.107.14.43]:33790
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbfK0RFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RkxB4FcHHJ9kJiSuN2bQh3PnSvvlqY9WJnFMwl0M7c=;
 b=a8A46wVjKdKrbVaFZwZ81gTWUuOXPz5YQBxkQFwhWV+gTb3UJ0IBDiBuNiS63MHWe7y4pPdQEmYAU9A6p1t2wa7gJeh0OkTrHqH4J1Yx/T9aiF05AVh44z+Tn69EqANwjhnTlPquvVMZYLV4xocTG86cdiRMLKN9RM6m4/zK5rE=
Received: from VI1PR08CA0165.eurprd08.prod.outlook.com (2603:10a6:800:d1::19)
 by AM4PR0802MB2372.eurprd08.prod.outlook.com (2603:10a6:200:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Wed, 27 Nov
 2019 17:05:47 +0000
Received: from VE1EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR08CA0165.outlook.office365.com
 (2603:10a6:800:d1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.19 via Frontend
 Transport; Wed, 27 Nov 2019 17:05:47 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT064.mail.protection.outlook.com (10.152.19.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Wed, 27 Nov 2019 17:05:47 +0000
Received: ("Tessian outbound a8ced1463995:v37"); Wed, 27 Nov 2019 17:05:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e8bdaf8c06de47e7
X-CR-MTA-TID: 64aa7808
Received: from 9b35aa232de1.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 093DDD6A-8041-4F13-A044-08A894671602.1;
        Wed, 27 Nov 2019 17:05:34 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9b35aa232de1.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Nov 2019 17:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgU7o2uauc43IeRoTmRgcN/Pa5oU5jceWHLyA9kG2sjzvmHBTF4rQ23XJxDG7hM8XpzjZ5mlJPQg89hFV33mltdOy6KQ/4EwnmxAxpO52hNOfRH24Mvv+J8ukEJozihd+KpI9Eo6Q0H9YY5ybMqbYCIZ2OOyWSj3wymvnr3WUfRSmEp1arEMGtSkEnfskH61xik4Z6zTRH21SXmFCEnm7ySE4SpmJ+hqJ5B71ARGd1vOlDjiFDLQdVi8bDbggUKhYsu3TxpdOrCkVYxyfQJIRF8DRuagsck1PHxl8G4ySm8UKST3+tVXtgr54bYKsRlUgqkdmoWdI32QsTiYqkRNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RkxB4FcHHJ9kJiSuN2bQh3PnSvvlqY9WJnFMwl0M7c=;
 b=Vu0YPcD4jjhf6K8ySSozx9+BtHR+zyHKEBkVlhsrx0MT0txVyoQWXvRBe6Z4g/9U27y7fBE1RhHZjJ8nUJJgqEBFCj5Y7LT9IXTZPYwypbjYLuBA0R85jJ3reS3Tu0XL6u3LfI/esC8QxZR4DaA79PHzu60kGk1QIutpaMICNXXV6JsF3ho8szspb9c6fZrrx9HZXqGUkACpUP6di1ghtqZIynVztbgHPysKLa/zu7XIzRUnf0GoMd65cQJXpGhVyOUwbaM1pAaVRAzblyGfau4jKzVQM/SqRVm8lcFOHXS0v3DXD+NaJ+SYvHQLjZqboVgE5dgcReowdcvzvTeNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RkxB4FcHHJ9kJiSuN2bQh3PnSvvlqY9WJnFMwl0M7c=;
 b=a8A46wVjKdKrbVaFZwZ81gTWUuOXPz5YQBxkQFwhWV+gTb3UJ0IBDiBuNiS63MHWe7y4pPdQEmYAU9A6p1t2wa7gJeh0OkTrHqH4J1Yx/T9aiF05AVh44z+Tn69EqANwjhnTlPquvVMZYLV4xocTG86cdiRMLKN9RM6m4/zK5rE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3392.eurprd08.prod.outlook.com (20.177.58.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Wed, 27 Nov 2019 17:05:32 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 27 Nov 2019
 17:05:32 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/mediatek: Fix build break
Thread-Topic: [PATCH] drm/mediatek: Fix build break
Thread-Index: AQHVpUTglbQGfFJTpU2EijDb8Zpv/Q==
Date:   Wed, 27 Nov 2019 17:05:32 +0000
Message-ID: <20191127170513.42251-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LNXP265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::21) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30c8a586-f299-4748-8e0a-08d7735c0c41
X-MS-TrafficTypeDiagnostic: VI1PR08MB3392:|VI1PR08MB3392:|AM4PR0802MB2372:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB2372818D94BD21BDF0A98E618F440@AM4PR0802MB2372.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:626;OLM:626;
x-forefront-prvs: 023495660C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(6116002)(52116002)(3846002)(66556008)(66066001)(6486002)(44832011)(5640700003)(386003)(256004)(71200400001)(14444005)(4744005)(6436002)(6512007)(6506007)(6916009)(50226002)(478600001)(2501003)(25786009)(81156014)(8676002)(66946007)(316002)(8936002)(36756003)(2351001)(81166006)(14454004)(305945005)(1076003)(2616005)(7736002)(71190400001)(5660300002)(4326008)(26005)(54906003)(99286004)(186003)(66476007)(86362001)(66446008)(64756008)(7416002)(102836004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3392;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: VL5g8Ufcgrq1hCg23Wz18xRzoEZePF+8V+kUfsC493Re5zBMWAR8zzfbQwi3tl7fGOPWLqBg3Ak+juBxwdKtVVIJY+AYVZzAq9fB4+KNKEFqBfEXxsR392ET7YSdcDA8FU7Hw/jh31fUpnkzTtpMefUHaF8xj07z+U99ROWyfS1VAhHJ15lu89NOfF6mqd92fky8p9CMOuHdN5lmCwQOAP1RSeBg+Po0EZ09fzAYMK+3CgfHOMWUIkRMHLRpx8lNq2kuc3ChX9GQdsr2GRkh36gk1vNC3KhDBtalgl7urgbwEp9mgyXNd/HwvVJZaNfm7Hbb1WZjTUh0OuSHaZFu7G/0122WCb0nvGROyVPYjalJiZ9l/1Oxep0bhNM4254XAupvxS/9fdDDMSpMlnf4krFor6lqPGWWvtl8Wzy6Bn6v750C+dEtVQNkf/I3c+OV
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3392
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(199004)(189003)(86362001)(26005)(8676002)(22756006)(81166006)(36756003)(316002)(8746002)(70206006)(70586007)(4326008)(76130400001)(8936002)(6862004)(50226002)(81156014)(50466002)(47776003)(2351001)(356004)(7736002)(106002)(36906005)(305945005)(478600001)(5660300002)(14444005)(66066001)(14454004)(99286004)(1076003)(25786009)(23756003)(54906003)(386003)(102836004)(6506007)(26826003)(2906002)(6512007)(3846002)(6116002)(4744005)(6486002)(5640700003)(186003)(2616005)(336012)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2372;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0e19c98e-4d7f-4033-61c1-08d7735c0325
NoDisclaimer: True
X-Forefront-PRVS: 023495660C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umuccU9wLkWPedT/QGj5Qob8VLiG94hcs2z+T5gfeAfr2I60EMyuHGWnOeCl5l8De58ldeo84atPYskkYtqNboiPExTjmpbv3/8XFjF9Naga0uHtuGkd7m4RRupGKIy42hUCPWKqAH+4UhT2KRgoC4pWyUqHv9j1UcS96bvKNwQ0i9o8tQ20f44p2Zn8wweUsc1nH1xEhyPINtumhzQjZAqrul5zvshYkU3m8oaZAHKgmGXDrhSLhwiM/nGf4XQvK1nsIyAytA3rh8TgZG0+YsHTsxJN+pETVfnY6C5kQT7G+XNC72n9sXHlZs8/PZoawUans/WwfTyDcYqowx4BuZhqqNKHrJUGwribaApwDckMs1ZRFjXI2nVNk0NyVaAk1+OmYh3NybPAmrBZBU76XGPnBQBi+ZkB0cl+AM69oH/3OhTdAAgiwy3/cOH629JA
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 17:05:47.4141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c8a586-f299-4748-8e0a-08d7735c0c41
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2372
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caused by file removal without adjusting the Makefile.

Fixes: d268f42e6856 ("drm/mediatek: don't open-code drm_gem_fb_create")
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: CK Hu <ck.hu@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/mediatek/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/M=
akefile
index 8067a4be8311..5044dfb8e3d6 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -7,7 +7,6 @@ mediatek-drm-y :=3D mtk_disp_color.o \
 		  mtk_drm_ddp.o \
 		  mtk_drm_ddp_comp.o \
 		  mtk_drm_drv.o \
-		  mtk_drm_fb.o \
 		  mtk_drm_gem.o \
 		  mtk_drm_plane.o \
 		  mtk_dsi.o \
--=20
2.23.0

