Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039DDC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8E72196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gXKdIrIo";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gXKdIrIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfJKFnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:43:42 -0400
Received: from mail-eopbgr60041.outbound.protection.outlook.com ([40.107.6.41]:29723
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfJKFnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUBbQ6jci7ZZBrBwHMNuLpOgBHySGEUsJ89UPIG5ETg=;
 b=gXKdIrIoYDlyk23wfjeGXfSe1JLu1JCIUw+hX48B9sUi4QXal1abWQeOiP2+NjopUPHiGDkgeKEJlZ8fLX2DqA51lk45V2EJdRo0PXeEL9TT6BddzAo0t15Hi1OnCN1KQPqblgKxZStip/unBu8zQjU7qR/RQrHTFGxi7eEh6XM=
Received: from VI1PR0802CA0012.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::22) by AM0PR08MB3587.eurprd08.prod.outlook.com
 (2603:10a6:208:dd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 11 Oct
 2019 05:43:32 +0000
Received: from AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::209) by VI1PR0802CA0012.outlook.office365.com
 (2603:10a6:800:aa::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.18 via Frontend
 Transport; Fri, 11 Oct 2019 05:43:32 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT037.mail.protection.outlook.com (10.152.17.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 05:43:30 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Fri, 11 Oct 2019 05:43:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0408181c2184aa88
X-CR-MTA-TID: 64aa7808
Received: from def52121f048.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3536CFD4-E67A-4F19-802B-2882B752D560.1;
        Fri, 11 Oct 2019 05:43:19 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2057.outbound.protection.outlook.com [104.47.0.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id def52121f048.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 11 Oct 2019 05:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIX8KfvK1PC9Hjxr4VOhiihXXqOGTL4eZ0GnjphyqTjA+zRTNLX1cQS/mWrRi8dYkCVVnV4zcCRGbCqiPvowKFGwGD0Xj/hBYDZ0nszkDyEodEbd7moob8vv7klrqKC8vGi3u9pNmhWHPb7++b57LT8r26HmNFTH+1WO1s5eA97ppj9Duu8mPsymQ+sZdZGQJB5DwGOVsY+RA+wIAfPTwQfuldc7oJqofcowEQ0AIyj/TqPI/HnAGOrcGKp7XuTaNhdP3CMB8IxgXlg9FjY/MD99Hbbw44FgC3v/q11z/AwIfyu4ipr1XONkKfzBZsvsgD7EQnkFf3/+n3iSQbACUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUBbQ6jci7ZZBrBwHMNuLpOgBHySGEUsJ89UPIG5ETg=;
 b=SKkZo7Nq3yN0o2wAxO7W1HENmMymzf6Jpvtkth1oHdt/Wk7iOd4yAs0kZPiMUOQwrpzQF7ZwCq/aS3QY+53f0G6EZe31pLB6kse2ccpgwEuHJvbkbDEpN+FFRsjkzb+mF0eobn/Ee9OzlLjvmefRrOO+lWwi8rZbDpjQhYlqIlUGgEeQqKLmaw/uQPiNwGXDdIeeiwff7rItJfvY2vArJtdUCzaLEv921vkZjtjidr//03AaRnMqmaqmVtd311JftF77GF9WtqhLOrJD/262HWhmxKyMVvJEMN0h/V0pJ8VNZrIYfOh2HOHcCVDugoJWMUoDBVHAgkMxXWDaLTUC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUBbQ6jci7ZZBrBwHMNuLpOgBHySGEUsJ89UPIG5ETg=;
 b=gXKdIrIoYDlyk23wfjeGXfSe1JLu1JCIUw+hX48B9sUi4QXal1abWQeOiP2+NjopUPHiGDkgeKEJlZ8fLX2DqA51lk45V2EJdRo0PXeEL9TT6BddzAo0t15Hi1OnCN1KQPqblgKxZStip/unBu8zQjU7qR/RQrHTFGxi7eEh6XM=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5134.eurprd08.prod.outlook.com (10.255.158.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 05:43:16 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 05:43:16 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Topic: [PATCH v2 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Index: AQHVf/bHoOHFMdio50qJmyeMboFsfA==
Date:   Fri, 11 Oct 2019 05:43:16 +0000
Message-ID: <20191011054240.17782-3-james.qian.wang@arm.com>
References: <20191011054240.17782-1-james.qian.wang@arm.com>
In-Reply-To: <20191011054240.17782-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::15) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c98cbcb3-02f2-4213-afed-08d74e0df289
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5134:|VE1PR08MB5134:|AM0PR08MB3587:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB358723E05DF8E28C960A31E3B3970@AM0PR08MB3587.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2043;OLM:2043;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(189003)(199004)(66066001)(486006)(386003)(6506007)(64756008)(99286004)(50226002)(52116002)(81156014)(6486002)(8936002)(81166006)(66946007)(102836004)(8676002)(305945005)(55236004)(26005)(66476007)(71200400001)(6116002)(3846002)(66556008)(6436002)(71190400001)(7736002)(76176011)(36756003)(186003)(2906002)(256004)(476003)(6512007)(2616005)(14444005)(66446008)(446003)(11346002)(54906003)(25786009)(14454004)(2501003)(103116003)(110136005)(316002)(4326008)(5660300002)(86362001)(478600001)(2201001)(1076003)(2171002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5134;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: amr7MgCh3e3rl1SrN65nY/ld+kZSeuJuQFfarRGf1E6lxg9tSJFtf49njxvNROJA6VAtujI5PiKAixykM03LQ/jlBs80ae2aruaZJUigT/+T1dJuBliv6hnqk+PgBu8tCLI7QFUOpkQIcNeOa77Jux2Xs7e7m185eKkU9/GsnL7AKP1B+sd3A4gcWqpWfjCfkb5iJaScmZDlCBdp4LRCwLImsj+Jw2iXCu50KbRDg7jBMpsojvBJ4JhMPZkMwwNR5PgfhrhYdBUJ77BwPHIWRBRTI13h2kU81HjkP1x/SJo5p4NDr5EHsjyzaciAGKfb8IXYolYopEbfLRdCGCQoE+qrmF76Yex2s1xfr9ApXIUR6m4WJRsJizxZAL0SGAZTOXdB2Nk5ziSI3tMOdqYxvyHH3qB7jhViIXogowL/iPg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5134
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(199004)(189003)(6506007)(386003)(76176011)(99286004)(1076003)(103116003)(6116002)(3846002)(6486002)(356004)(26005)(2906002)(102836004)(6512007)(186003)(305945005)(2171002)(7736002)(2201001)(50466002)(86362001)(14444005)(2501003)(23756003)(36906005)(22756006)(8676002)(50226002)(8936002)(54906003)(316002)(110136005)(8746002)(66066001)(26826003)(81156014)(81166006)(47776003)(446003)(11346002)(14454004)(2616005)(476003)(126002)(76130400001)(25786009)(336012)(63350400001)(70206006)(36756003)(70586007)(5660300002)(4326008)(486006)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3587;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3b2cbfa1-1358-412c-b44e-08d74e0de9e9
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Us6W5Nh5FJ5XTSIP0etIuvWMcrggnboiTuhPtdBDQk6Vm1WphTotm1IhnJQ2gmQWs21e7D9ZWxIFqmcZY1jqHAbAn+Xs18sAe3BYBHkI9nFF8+zefTk23wKZuI7En6RfzAnmPc/2xvPqOBAFkRNJlL44pBgYo8YypIEz/AwMfwQa5KXVh/NG8tqQ4IMQlMOBkmSFYJvhtnsxBcXP0IfGKwYgR91L+kwIc7doQ44RqI6ZJCOo0tEESmg6uyztWP79lr7gSyqNDjHEzwaktnGDtv277D5+dKytyHHkY8YsutMuhQ14HWLpSr879E4Soh0JPBbqxmbaRr8bGUMOB4/Nr8GYQNRyuLRR6ckRu7LHmqBNh7ui2OcVShTov9E4rANFsUlBu4KLn/ZVMMcDkkrCcoAHUbTCMw/XHsgYlmOskA4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 05:43:30.6325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c98cbcb3-02f2-4213-afed-08d74e0df289
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3587
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is used to convert drm 3dlut to komeda HW required 1d curve
coeffs values.

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../arm/display/komeda/komeda_color_mgmt.c    | 52 +++++++++++++++++++
 .../arm/display/komeda/komeda_color_mgmt.h    |  9 +++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
index 9d14a92dbb17..c180ce70c26c 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
@@ -65,3 +65,55 @@ const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encodi=
ng, u32 color_range)
=20
 	return coeffs;
 }
+
+struct gamma_curve_sector {
+	u32 boundary_start;
+	u32 num_of_segments;
+	u32 segment_width;
+};
+
+struct gamma_curve_segment {
+	u32 start;
+	u32 end;
+};
+
+static struct gamma_curve_sector sector_tbl[] =3D {
+	{ 0,    4,  4   },
+	{ 16,   4,  4   },
+	{ 32,   4,  8   },
+	{ 64,   4,  16  },
+	{ 128,  4,  32  },
+	{ 256,  4,  64  },
+	{ 512,  16, 32  },
+	{ 1024, 24, 128 },
+};
+
+static void
+drm_lut_to_coeffs(struct drm_property_blob *lut_blob, u32 *coeffs,
+		  struct gamma_curve_sector *sector_tbl, u32 num_sectors)
+{
+	struct drm_color_lut *lut;
+	u32 i, j, in, num =3D 0;
+
+	if (!lut_blob)
+		return;
+
+	lut =3D lut_blob->data;
+
+	for (i =3D 0; i < num_sectors; i++) {
+		for (j =3D 0; j < sector_tbl[i].num_of_segments; j++) {
+			in =3D sector_tbl[i].boundary_start +
+			     j * sector_tbl[i].segment_width;
+
+			coeffs[num++] =3D drm_color_lut_extract(lut[in].red,
+						KOMEDA_COLOR_PRECISION);
+		}
+	}
+
+	coeffs[num] =3D BIT(KOMEDA_COLOR_PRECISION);
+}
+
+void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *coe=
ffs)
+{
+	drm_lut_to_coeffs(lut_blob, coeffs, sector_tbl, ARRAY_SIZE(sector_tbl));
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
index a2df218f58e7..08ab69281648 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
@@ -11,7 +11,14 @@
 #include <drm/drm_color_mgmt.h>
=20
 #define KOMEDA_N_YUV2RGB_COEFFS		12
+#define KOMEDA_N_RGB2YUV_COEFFS		12
+#define KOMEDA_COLOR_PRECISION		12
+#define KOMEDA_N_GAMMA_COEFFS		65
+#define KOMEDA_COLOR_LUT_SIZE		BIT(KOMEDA_COLOR_PRECISION)
+#define KOMEDA_N_CTM_COEFFS		9
+
+void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *coe=
ffs);
=20
 const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_rang=
e);
=20
-#endif
+#endif /*_KOMEDA_COLOR_MGMT_H_*/
--=20
2.20.1

