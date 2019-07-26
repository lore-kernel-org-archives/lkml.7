Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B55CC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE402166E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="QaZ0ARBZ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="QaZ0ARBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfGZIGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:06:36 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:60901
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfGZIGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUfoFgrtNmB/wYkagr+4myXoTJddbZcjxtK+yvMwbjY=;
 b=QaZ0ARBZZDSzkjjyM4eWKs2XzgVijlSOySWmaU5tBeuGUeru06ZePsHjPiF6MtQfsznQmAV5uvCHHaEZvCIrs117emrzsWRGx23U8k584Pr4hiJIRgrWzEVjzd0pbHEpLslxV59Qfmw59Ncz7yr40BqzQ4GPYiRVbn9PFbwVKhU=
Received: from HE1PR08CA0056.eurprd08.prod.outlook.com (10.170.248.155) by
 AM5PR0801MB1844.eurprd08.prod.outlook.com (10.169.246.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Fri, 26 Jul 2019 08:06:29 +0000
Received: from VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by HE1PR08CA0056.outlook.office365.com
 (2603:10a6:7:2a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.14 via Frontend
 Transport; Fri, 26 Jul 2019 08:06:29 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT061.mail.protection.outlook.com (10.152.19.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18 via Frontend Transport; Fri, 26 Jul 2019 08:06:28 +0000
Received: ("Tessian outbound 220137ab7b0b:v26"); Fri, 26 Jul 2019 08:06:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d5257653352837db
X-CR-MTA-TID: 64aa7808
Received: from 0336800e1fa2.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 84EFA102-3C93-485C-87EA-D9EC5F7848F5.1;
        Fri, 26 Jul 2019 08:06:20 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2057.outbound.protection.outlook.com [104.47.5.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0336800e1fa2.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 26 Jul 2019 08:06:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6I1/C1u6d1vY19FQmYbaHXnaItPMWCDmyIqi6E9OU2f4/nPnERFo2a7gpZRRHW/YjUi0cRenNMHeT1dvYi+ekbYzFoMBTa9MQOA8RgYihLgItSVlKg8Gd44U25L+3ADDJQl6lUuwdYO3j7h7jdZ1CTJ9iwR9foHzBjV5zhrS0F7Gn8br/quQziPx5ujTeEjSEbWZNQqCJzaUt9AQ8kIuWr4CkpMIQEmghv9iS5Hwi/12kH4EktAq1NPvTfhuRtkJi4Pp/uScnOGeTQti9xa1C9D/aSly+MBfHouF2Yt6Pma+yKUwWUaf/ON7sz8GqJTxITcD23bs43ULc48i18QeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUfoFgrtNmB/wYkagr+4myXoTJddbZcjxtK+yvMwbjY=;
 b=B8/FuAr99f8bA5RMw07NL2CKhMvz5hg0nH0/pFGojoNWso14QZVTwA+gWk2ndK3pjlmLjt/bBKtRjUEmUyfIvlVCFs7Hbepz3up/0tCZ9Ego7JoHTrXGYoUT+Vn6eih/yslgHsy7cNdVVLVrYS+xvIMFQ8oPrUAoR6ejRLsXJUgNWNKxzLQrGYsRVZyC0dDXarumrBvrY4RixyptFObCtMzCmMfXEE4CuWUqioGdG4YKJrZRv+mDY1Nwi0AOmQKie75OqTnaA3gMZ2VdRvSD4v49whKfLUd7lCsFyVjS7ebTkZePHXDimp7bnxZ28z+G+ZvpxiUN0dMG01+vcKcXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUfoFgrtNmB/wYkagr+4myXoTJddbZcjxtK+yvMwbjY=;
 b=QaZ0ARBZZDSzkjjyM4eWKs2XzgVijlSOySWmaU5tBeuGUeru06ZePsHjPiF6MtQfsznQmAV5uvCHHaEZvCIrs117emrzsWRGx23U8k584Pr4hiJIRgrWzEVjzd0pbHEpLslxV59Qfmw59Ncz7yr40BqzQ4GPYiRVbn9PFbwVKhU=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB2941.eurprd08.prod.outlook.com (10.170.238.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Fri, 26 Jul 2019 08:06:16 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236%2]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 08:06:16 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: [PATCH] drm/komeda: Adds more check in mode_valid
Thread-Topic: [PATCH] drm/komeda: Adds more check in mode_valid
Thread-Index: AQHVQ4j/fedIk6fUkkilpyBPPcwKlQ==
Date:   Fri, 26 Jul 2019 08:06:16 +0000
Message-ID: <1564128364-23055-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:203:52::26) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c5464837-af6a-4867-a032-08d711a02990
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB2941;
X-MS-TrafficTypeDiagnostic: VI1PR08MB2941:|AM5PR0801MB1844:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB18447784BCE814F3AC9687C19FC00@AM5PR0801MB1844.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2449;OLM:2449;
x-forefront-prvs: 01106E96F6
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(50226002)(5660300002)(14454004)(486006)(476003)(54906003)(110136005)(256004)(2616005)(305945005)(6636002)(81166006)(14444005)(81156014)(186003)(68736007)(26005)(478600001)(2501003)(6436002)(71190400001)(52116002)(71200400001)(6486002)(66066001)(4326008)(36756003)(25786009)(53936002)(2906002)(316002)(6512007)(99286004)(3846002)(8936002)(102836004)(7736002)(55236004)(6116002)(2201001)(386003)(6506007)(86362001)(66946007)(66556008)(64756008)(66446008)(66476007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2941;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: lswQ9Kg3RaILZGa9HKn06dhjVl0rXyobOsRSKiqTUGr4Lhsl6fTyVJTNE8Jmwh0tDX1Xl1KHKC7yEaE8XGq19fZ+DqLV3h/VlBt0uK2V0FxCf8IpjsUlhm9vdsFwIrtVse5jTGZdd7lTQrM45HQ1W0QUGJRYkzHFYgFan6UzkSG9GCfs+3ZZot+HXhPcYnZjxr5xnBdnPTZtqf3BELxNguPFe0JSayes9YX+gAe7OOMWULmu4aomHqEnaE4R1IHAy44+9a+H9/LXaYiJwyrrB59oNOxHs0Q91WRzBQ5Oxap/6HNIFgjA/0tN/d88uDZU1N2Cm3CUkFYadwdzNVbmwWxXLKHUOB6tjJJSWyppt5TdzFeQJrzlG7YwjsEFQCOSW/QsjGBNKx5JcTvr8Fm2S3UJwBuahBYPxiVjCRZTzW4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2941
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(199004)(189003)(316002)(8746002)(102836004)(305945005)(8676002)(8936002)(486006)(81156014)(14454004)(386003)(2201001)(50466002)(6506007)(6636002)(478600001)(2616005)(26826003)(476003)(6116002)(6486002)(14444005)(336012)(63370400001)(50226002)(4326008)(5660300002)(54906003)(23756003)(186003)(110136005)(26005)(2906002)(356004)(66066001)(22756006)(70586007)(7736002)(25786009)(70206006)(47776003)(81166006)(2501003)(36756003)(36906005)(63350400001)(126002)(86362001)(6512007)(3846002)(76130400001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1844;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a1576bdc-ab5f-4370-c210-08d711a021f4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR0801MB1844;
NoDisclaimer: True
X-Forefront-PRVS: 01106E96F6
X-Microsoft-Antispam-Message-Info: B3LD+6ThlDiEWRRD/ly9Hpv4z+UMpwA4PYQpD4NBvwlwSV8MBDsYwGh9pibbDTgHj3EODHJbJvR3iKrD329JhV5LS6MClEOKJU6n9IhGPMDqKQu3F3y5WIoBf9Nry5BangNG2XomaNvisUyJpxB0AXPa460X1udcuHHeTCnF16O46ZwCuJzsZlD1FxtiEEk9P7TX6VckuTm6pwenEEZ/0W0+wEC6oozBMC3Yq+e6B5Gm9vPhxPhYivQdVq8yq+UzAze6eCP1lFnnsWHc/b/RXIYOHrNaCJVmoBvUoYWDTo2hCn14OjF/IlHea8vT9ic8uwDtPSvSJodiQFbGSLDkxSffDyYuEXx9YVs81AVnqsvYFnNx3oascQys3OwvH8peV4p6H/hgNiGTkodU6wLGuFrByY4alX+npgtSBdlum6Q=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2019 08:06:28.4677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5464837-af6a-4867-a032-08d711a02990
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1844
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the checks for vrefresh, crtc_hdisplay and crtc_vdisplay.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 28 ++++++++++++++++++++=
+++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 2fed1f6..017f6b6 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -403,11 +403,37 @@ unsigned long komeda_crtc_get_aclk(struct komeda_crtc=
_state *kcrtc_st)
 	struct komeda_dev *mdev =3D crtc->dev->dev_private;
 	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
 	struct komeda_pipeline *master =3D kcrtc->master;
-	unsigned long min_pxlclk, min_aclk;
+	struct komeda_compiz *compiz =3D master->compiz;
+	unsigned long min_pxlclk, min_aclk, delta, full_frame;
+	int hdisplay =3D m->hdisplay;
=20
 	if (m->flags & DRM_MODE_FLAG_INTERLACE)
 		return MODE_NO_INTERLACE;
=20
+	full_frame =3D m->htotal * m->vtotal;
+	delta =3D abs(m->clock * 1000 - m->vrefresh * full_frame);
+	if (m->vrefresh && (delta > full_frame)) {
+		DRM_DEBUG_ATOMIC("mode clock check error!\n");
+		return MODE_CLOCK_RANGE;
+	}
+
+	if (kcrtc->side_by_side)
+		hdisplay /=3D 2;
+
+	if (!in_range(&compiz->hsize, hdisplay)) {
+		DRM_DEBUG_ATOMIC("hdisplay[%u] is out of range[%u, %u]!\n",
+				 hdisplay, compiz->hsize.start,
+				 compiz->hsize.end);
+		return MODE_BAD_HVALUE;
+	}
+
+	if (!in_range(&compiz->vsize, m->vdisplay)) {
+		DRM_DEBUG_ATOMIC("vdisplay[%u] is out of range[%u, %u]!\n",
+				 m->vdisplay, compiz->vsize.start,
+				 compiz->vsize.end);
+		return MODE_BAD_VVALUE;
+	}
+
 	min_pxlclk =3D m->clock * 1000;
 	if (master->dual_link)
 		min_pxlclk /=3D 2;
--=20
1.9.1

