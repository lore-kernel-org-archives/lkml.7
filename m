Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA5FC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44856206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lqagpC5w";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lqagpC5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbfHFGc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:32:27 -0400
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:32373
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfHFGc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0VVT2eU3D2sKLwNOSEdmVusF+uJxLrn88fc+KWl1XM=;
 b=lqagpC5wEd8SodC/4g9wFckJBqvXqZbVMRHbCUn+8RBZ4jy8+WObb2aIMQDCKjMSAS6LZV5/i0JhG91N3muel5i2M+uKsCJglCP4p8Hnc7ijVhrM61qySsgiziGNn7VJ94PZkSRFoTSGlGyIkUXdyjYoHCRGfGvng8ADE1BmJ90=
Received: from VI1PR08CA0184.eurprd08.prod.outlook.com (2603:10a6:800:d2::14)
 by AM5PR0802MB2596.eurprd08.prod.outlook.com (2603:10a6:203:98::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.17; Tue, 6 Aug
 2019 06:32:16 +0000
Received: from DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR08CA0184.outlook.office365.com
 (2603:10a6:800:d2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.14 via Frontend
 Transport; Tue, 6 Aug 2019 06:32:15 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT046.mail.protection.outlook.com (10.152.21.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 6 Aug 2019 06:32:13 +0000
Received: ("Tessian outbound 1e6e633a5b56:v26"); Tue, 06 Aug 2019 06:32:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1dc7c2af83c44a27
X-CR-MTA-TID: 64aa7808
Received: from 310830fd9a82.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8BF8C2CC-FDCB-4037-9A17-FEE038CB7D2A.1;
        Tue, 06 Aug 2019 06:32:02 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 310830fd9a82.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 06 Aug 2019 06:32:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc0fC0e6b3QnpyzaYSvIA0l6pkTXrQn7AudENQv3fJnQRqKZv2IwgZK/HB7sCc/no99L2XFD3QSmsUINTl4y4OznSwOtvXVpxNY7v9scnxkBqvJGRbZ+SHOZBpU2vFD/OpvjqLeq7fiY48LGSxierk9MgGkzuDqtJh1O5i4Xjh3IFymtvLXdP/6nbpVH9X8FotwP2VY4ayuCpJ4hXIaK94Kvwtmy/kK45FcrujOX7KhcphkGLIiPMwElIbNKDXSV3cmpSaHMJLR2n7AwPT4xvFjyeNrNJSFHxqdu21LRsUyeBn8Jv7UFK/LdjykhITxw6Tj6xslbvIuPnGh5D+KW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0VVT2eU3D2sKLwNOSEdmVusF+uJxLrn88fc+KWl1XM=;
 b=RW/gVMqFEU2QOnirD5qSJ6Mu2a18fJ9cL8fp6qoGBUzJphbbDlx9PH+d0p+KdSqSclpv7Yt9tAGESAUnC9UcanjRHQHoSrsTCpwufShmZWg3T3YdvHOpx8v1oThP0q3unKRjBFbIZspSt7qMkERpENQwVvLwvIP4yXqfR5aJq7ieTOgQF3G5RlqIIhojOHp7dX9WGfJDymKLIEa/Pw4y56ONjot5ZI4IDT87KqRIXCP31071WQUN5PXGLWRSGxhMqMGBHniL6YNY0HwyintGHuWhdJagxGaV9UaBJcNRz9TWx7Zk9Tw71oueJ+lFgHV8pM53HfxSgxcUA6wNrpMuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0VVT2eU3D2sKLwNOSEdmVusF+uJxLrn88fc+KWl1XM=;
 b=lqagpC5wEd8SodC/4g9wFckJBqvXqZbVMRHbCUn+8RBZ4jy8+WObb2aIMQDCKjMSAS6LZV5/i0JhG91N3muel5i2M+uKsCJglCP4p8Hnc7ijVhrM61qySsgiziGNn7VJ94PZkSRFoTSGlGyIkUXdyjYoHCRGfGvng8ADE1BmJ90=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3598.eurprd08.prod.outlook.com (20.177.61.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Tue, 6 Aug 2019 06:31:56 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236%2]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 06:31:56 +0000
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
Subject: [PATCH] drm/komeda: Adds internal bpp computing for arm afbc only
 format YU08 YU10
Thread-Topic: [PATCH] drm/komeda: Adds internal bpp computing for arm afbc
 only format YU08 YU10
Thread-Index: AQHVTCCkV8nwhj7hV0i5q+YUMqL9nw==
Date:   Tue, 6 Aug 2019 06:31:56 +0000
Message-ID: <1565073104-24047-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0057.apcprd03.prod.outlook.com
 (2603:1096:202:17::27) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c0685859-016d-4dbd-240a-08d71a37d162
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3598;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3598:|AM5PR0802MB2596:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2596AD39055F1FE7EB406DDB9FD50@AM5PR0802MB2596.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3826;OLM:3826;
x-forefront-prvs: 0121F24F22
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(189003)(199004)(25786009)(478600001)(2616005)(476003)(6506007)(6636002)(36756003)(14454004)(66946007)(86362001)(2501003)(4326008)(386003)(316002)(2201001)(81156014)(55236004)(102836004)(50226002)(110136005)(305945005)(7736002)(5660300002)(6512007)(3846002)(71200400001)(14444005)(71190400001)(6116002)(186003)(99286004)(64756008)(6486002)(8936002)(486006)(53936002)(8676002)(66556008)(54906003)(66476007)(66446008)(81166006)(66066001)(68736007)(2906002)(6436002)(52116002)(26005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3598;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: I7hIuDbOcBD0Q9CXIyVvVMZFu5rRHlDeuRTEyaEmv74mw3BZLlpu6l1xykmp4/V65UoPygO44lQ1UIGtO5iKi6QHWR4keBI0YTOFiTN3dQZth6kraP00vub0npL7FnLZ4PixZz758+ZWy8Zh9S7XLXI/w16Kkoi+JpgRi4XqlNKEgJ6z87sEmy3SdWYkbVaORMa/MZyjltC1xYPu9FJeTf+zZzwfJjKBTwjMAXT0Hy9Sg/IkbXHAcH+Dz6mxn7gecYyjF7dOSy6xsvlndRzoOMuT8FeG+EAHzqkdqMtXyCSR7pTQxZa67Jd+A/j71iBnt9uM+TZeW1Mjrq5bIatH8wCaIzH21crj47QnLiZ+rlX/jLJK42u8hRPp2NAsc/abn1NZP3egPBQ3Xz2qGJLXAa10urgwWa4Kn4d5jGGRZlI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3598
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(2980300002)(199004)(189003)(4326008)(6486002)(356004)(76130400001)(6512007)(126002)(486006)(70586007)(476003)(2616005)(8746002)(8936002)(70206006)(8676002)(50466002)(50226002)(63350400001)(63370400001)(186003)(26005)(25786009)(5660300002)(47776003)(66066001)(336012)(6636002)(81156014)(81166006)(14454004)(2906002)(99286004)(36756003)(14444005)(86362001)(110136005)(22756006)(54906003)(305945005)(7736002)(26826003)(6116002)(3846002)(478600001)(2501003)(2201001)(316002)(386003)(102836004)(23756003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0802MB2596;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: edba3253-9b86-48e7-2d57-08d71a37c6f8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR0802MB2596;
NoDisclaimer: True
X-Forefront-PRVS: 0121F24F22
X-Microsoft-Antispam-Message-Info: l7UCp9RdZ0ZNxOZ+xa9ozhySSvDna9nAbboHO8bm0coGG33RbD5Qxu/Rg+ok0N4hZVCuXnVRhkNHuAQv+Wai28Y/h5uHkPb2B1r1sz6P0rilZJJ/4QWQE06gjNtrDgM7qVIJvIPlLSKGBoP4t/uqgIQNcuACkGGGrgbPLkFh5/Q0ZZzDp/QagDfJtYwVSBxIG/DSd2y4DowHOCqOG/h6f8KsmDukXj/QhMwUhoBi0RTcv2gM5+kxEEewLMH2Q7iZ5tFB6T0/W8c+sGyX44y5clubw8pCMthTNp+wIvftVb/pErYaIRJKNPe7mk2z1yFubq0xBlk4EOlMjgThihxdTZzuMa4D2Bita2/Xxn2hqLm3GZ313G7yGs6D4+QIT7t/ViAEEWq31LVQzOznKZon9ziz9QNXW+pN7ha2mpr74Ys=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2019 06:32:13.3887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0685859-016d-4dbd-240a-08d71a37d162
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2596
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>

The drm_format_info doesn't have any cpp or block_size (both are zero)
information for arm only afbc format YU08/YU10. we need to compute it
by ourselves.

Changes since v1:
1. Removed redundant warning check in komeda_get_afbc_format_bpp();
2. Removed a redundant empty line;
3. Rebased the branch.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_format_caps.c   | 19 +++++++++++++++=
++++
 .../gpu/drm/arm/display/komeda/komeda_format_caps.h   |  3 +++
 .../gpu/drm/arm/display/komeda/komeda_framebuffer.c   |  5 +++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_format_caps.c
index cd4d9f5..c9a1edb 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
@@ -35,6 +35,25 @@
 	return NULL;
 }
=20
+u32 komeda_get_afbc_format_bpp(const struct drm_format_info *info, u64 mod=
ifier)
+{
+	u32 bpp;
+
+	switch (info->format) {
+	case DRM_FORMAT_YUV420_8BIT:
+		bpp =3D 12;
+		break;
+	case DRM_FORMAT_YUV420_10BIT:
+		bpp =3D 15;
+		break;
+	default:
+		bpp =3D info->cpp[0] * 8;
+		break;
+	}
+
+	return bpp;
+}
+
 /* Two assumptions
  * 1. RGB always has YTR
  * 2. Tiled RGB always has SC
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h b/driv=
ers/gpu/drm/arm/display/komeda/komeda_format_caps.h
index 3631910..32273cf 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
@@ -97,6 +97,9 @@ static inline const char *komeda_get_format_name(u32 four=
cc, u64 modifier)
 komeda_get_format_caps(struct komeda_format_caps_table *table,
 		       u32 fourcc, u64 modifier);
=20
+u32 komeda_get_afbc_format_bpp(const struct drm_format_info *info,
+			       u64 modifier);
+
 u32 *komeda_get_layer_fourcc_list(struct komeda_format_caps_table *table,
 				  u32 layer_type, u32 *n_fmts);
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
index 3b0a70e..1b01a62 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
@@ -43,7 +43,7 @@ static int komeda_fb_create_handle(struct drm_framebuffer=
 *fb,
 	struct drm_framebuffer *fb =3D &kfb->base;
 	const struct drm_format_info *info =3D fb->format;
 	struct drm_gem_object *obj;
-	u32 alignment_w =3D 0, alignment_h =3D 0, alignment_header, n_blocks;
+	u32 alignment_w =3D 0, alignment_h =3D 0, alignment_header, n_blocks, bpp=
;
 	u64 min_size;
=20
 	obj =3D drm_gem_object_lookup(file, mode_cmd->handles[0]);
@@ -88,8 +88,9 @@ static int komeda_fb_create_handle(struct drm_framebuffer=
 *fb,
 	kfb->offset_payload =3D ALIGN(n_blocks * AFBC_HEADER_SIZE,
 				    alignment_header);
=20
+	bpp =3D komeda_get_afbc_format_bpp(info, fb->modifier);
 	kfb->afbc_size =3D kfb->offset_payload + n_blocks *
-			 ALIGN(info->cpp[0] * AFBC_SUPERBLK_PIXELS,
+			 ALIGN(bpp * AFBC_SUPERBLK_PIXELS / 8,
 			       AFBC_SUPERBLK_ALIGNMENT);
 	min_size =3D kfb->afbc_size + fb->offsets[0];
 	if (min_size > obj->size) {
--=20
1.9.1

