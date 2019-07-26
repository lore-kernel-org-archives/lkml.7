Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD6DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1A6216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3nqo4WzE";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3nqo4WzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfGZHvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:51:25 -0400
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:48128
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbfGZHvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUrCD0Leo0TtWgq8AGKe5YgKp4GAMmDDJNLEblsg/YI=;
 b=3nqo4WzEIqTcvrRzCva7oslFVwYQZ6+9TE3L8yLFjjQ6R9zvijbsw8CuhvyYmpw26Z4XD+X/1srC50MA7d/sMupbN/BmACGHlq27i3O4PNpg+0AOtvpr6LPyXqH05YyC+MmsBlAPWg2TvFYWVAysNbOqLDMY/OmtIIlL7IREfRA=
Received: from AM6PR08CA0028.eurprd08.prod.outlook.com (2603:10a6:20b:c0::16)
 by AM6PR08MB4952.eurprd08.prod.outlook.com (2603:10a6:20b:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.14; Fri, 26 Jul
 2019 07:51:18 +0000
Received: from DB5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by AM6PR08CA0028.outlook.office365.com
 (2603:10a6:20b:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10 via Frontend
 Transport; Fri, 26 Jul 2019 07:51:18 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT005.mail.protection.outlook.com (10.152.20.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Fri, 26 Jul 2019 07:51:16 +0000
Received: ("Tessian outbound 6d016ca6b65d:v26"); Fri, 26 Jul 2019 07:51:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 373e4b7e4d16622f
X-CR-MTA-TID: 64aa7808
Received: from fbcf67064ec2.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 870A09CA-6E51-4156-ADCA-B30C58DDA2BB.1;
        Fri, 26 Jul 2019 07:51:05 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2052.outbound.protection.outlook.com [104.47.6.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fbcf67064ec2.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 26 Jul 2019 07:51:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUqI+sWqjpqMZh13OT5kQwTxeqKJV7Ai/FgDOYf65NmMst9tTSZgQ9UnirMZN0VI9oCPIlQCtmo+HdSwWeCYcKhiWtvVpq1dLTkcqMvuZZIJRFLcshJ6Mc29zxopBFxp8tAUyFd528riFk8rRIXnfF5i7GEhnow0bp1T64by2XIQ3aFi57ckT8f0G7OT0PbRKfrscMhRQjrOQA0rZLWOD2GZFua04Qzr0oB809s+6ywujOtZ7DSVFDlCTZmIizH6urzmTX/b3g9aFnJml/IDKuC7zMKedsr0qV/FJ0H5Ws4Lp0QFXWJNPhJqa0h2qb0DtX9izT7yoKXFrJ7LLX9a0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUrCD0Leo0TtWgq8AGKe5YgKp4GAMmDDJNLEblsg/YI=;
 b=cZ/BFIP4MtftXTHZBLcWvMRpQlGi0g48V/SxbQpL1v/6YiFIU1FzI2jjOvqI+7WX5w4IXwc0sAld3tyuAiDsx+f7GwS7rUvvgHsJBC6wtcwGo8+F83ccnp7wN8Yr9nBeoF+8a1/E+/bOKW8pvSkyU916IctMShMC/EuAXJqzBbcCOx+AjRrdfaKAU4mBKWVVORq2MvKfy1NNJ2nuGPswkJlq8p12t5qc/6i7YPQNOGUMYpt2ZZ2XuYIWkMFPeMD6Q6+ciOeiNStZQxUYLxYKZAyFz2zD1d/fj/+30jkXOdBAW3bLomlCa/nNogcBXRr1RcIgj/JuPWYwnayu60KJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUrCD0Leo0TtWgq8AGKe5YgKp4GAMmDDJNLEblsg/YI=;
 b=3nqo4WzEIqTcvrRzCva7oslFVwYQZ6+9TE3L8yLFjjQ6R9zvijbsw8CuhvyYmpw26Z4XD+X/1srC50MA7d/sMupbN/BmACGHlq27i3O4PNpg+0AOtvpr6LPyXqH05YyC+MmsBlAPWg2TvFYWVAysNbOqLDMY/OmtIIlL7IREfRA=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB5552.eurprd08.prod.outlook.com (20.179.28.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Fri, 26 Jul 2019 07:51:02 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236%2]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 07:51:02 +0000
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
Thread-Index: AQHVQ4beFTTy2Dg0kUOV3ws9alTcfg==
Date:   Fri, 26 Jul 2019 07:51:02 +0000
Message-ID: <1564127450-22601-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 463b76ca-903a-48a5-facb-08d7119e09ae
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB5552;
X-MS-TrafficTypeDiagnostic: VI1PR08MB5552:|AM6PR08MB4952:
X-Microsoft-Antispam-PRVS: <AM6PR08MB49528A48D94971091C27FEA09FC00@AM6PR08MB4952.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3173;OLM:3173;
x-forefront-prvs: 01106E96F6
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(6506007)(4326008)(55236004)(6436002)(53936002)(386003)(2501003)(102836004)(6512007)(2906002)(52116002)(305945005)(99286004)(7736002)(6636002)(86362001)(6116002)(66066001)(25786009)(478600001)(186003)(14454004)(3846002)(54906003)(5660300002)(316002)(26005)(8936002)(36756003)(110136005)(50226002)(2201001)(8676002)(81156014)(81166006)(66556008)(66476007)(66446008)(68736007)(64756008)(476003)(71200400001)(71190400001)(2616005)(256004)(486006)(66946007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5552;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: XMXOrhUDXpidBIwS3WQq8Pus0yR77D1wxedV0UTFb5mPdBXL8r7NgdyxoKz0OvKHSeZh4D7hLNtlKP4FlnC1I7KZdD3F+r1FXvyx181GaFhLmEtLGfaiXlzoSz8xcemHI9CnNhR/0Vk0sjE6XHEZOh3wOo4z/atkjVC0nSQ7lIOXlxcMewyEvhHVaBWiTtIgjXss0k8OkAAyoh5NEk9GEDeT+WPVhP9NukOJR3rfBUPCxS7pHxousFin9wHgszcqpTTXa3fDftuCtxrACcWyV5rqJkI4svGTYLNtDuXlPLj07EZDnaYtlEs6Yx/ExZr+jc/YwS8VDbs4cpn+VrGHXQpcIJ+LMSVPKBt/R8EFf6o0f5NoMLil8yg+3RwLUWMZdzpZISWDzp2DKORckhP7r4h303a8m1jUDcCGOjyPp1Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5552
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(199004)(189003)(6506007)(386003)(26005)(81156014)(2501003)(316002)(81166006)(8936002)(8746002)(6512007)(50466002)(36756003)(4326008)(102836004)(76130400001)(3846002)(6116002)(70206006)(305945005)(7736002)(6486002)(478600001)(186003)(8676002)(26826003)(5660300002)(70586007)(54906003)(86362001)(110136005)(25786009)(22756006)(2906002)(336012)(66066001)(47776003)(50226002)(6636002)(14454004)(2616005)(63350400001)(356004)(63370400001)(99286004)(23756003)(126002)(2201001)(486006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4952;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: db321ca0-4b51-4a31-101f-08d7119e0143
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR08MB4952;
NoDisclaimer: True
X-Forefront-PRVS: 01106E96F6
X-Microsoft-Antispam-Message-Info: zV62WZs7FeZt9EqanWf0z7LjfVorvgtoOqWTS1kaNKoKtxggWXinSENuNkqj+p8JqDR9d62cu5wRzJ0VPhP+f2VdI0yKSGoPu2uABdpTU1hSKKLqOk6YsGrQJbGI/78NnUsw47h9uUrVvo/XR44Rgrmdyu6spGXyscV0cI6BP3QpbU9gb93i7dW+xLhDtKrVzFW8x1gJSlNYUoXH1ykZeH/PurMoh7N7v3hrf8nVcOAlqTwtcErZ/I7gWLXwX3FPJNT3S0NyET+xpFH6sns7t2ONjV4dE7QsZhIG4YVLBo5TBwESDk7IsfsevlKU1ufNJgK2b9/mNjAG2YLg6dSZLPNTo522+H+Z2pUoQDYD18nT8HCToJ1RCh/YrfeMV8Jk8JHqHSfcVpVLXdqhSOHNf4UjQAtQrap0+nLmYJTI4eU=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2019 07:51:16.0621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463b76ca-903a-48a5-facb-08d7119e09ae
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_format_info doesn't have any cpp or block_size (both are zero)
information for arm only afbc format YU08/YU10. we need to compute it
by ourselves.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../drm/arm/display/komeda/komeda_format_caps.c    | 23 ++++++++++++++++++=
++++
 .../drm/arm/display/komeda/komeda_format_caps.h    |  3 +++
 .../drm/arm/display/komeda/komeda_framebuffer.c    |  6 ++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_format_caps.c
index cd4d9f5..3c9e060 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
@@ -35,6 +35,29 @@
 	return NULL;
 }
=20
+u32 komeda_get_afbc_format_bpp(const struct drm_format_info *info, u64 mod=
ifier)
+{
+	u32 bpp;
+
+	WARN_ON(modifier =3D=3D DRM_FORMAT_MOD_LINEAR);
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
+	WARN_ON(bpp =3D=3D 0);
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
index 10bf63e..966d0c7 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
@@ -44,7 +44,7 @@ static int komeda_fb_create_handle(struct drm_framebuffer=
 *fb,
 	const struct drm_format_info *info =3D fb->format;
 	struct drm_gem_object *obj;
 	u32 alignment_w =3D 0, alignment_h =3D 0, alignment_header;
-	u32 n_blocks =3D 0, min_size =3D 0;
+	u32 n_blocks =3D 0, min_size =3D 0, bpp;
=20
 	obj =3D drm_gem_object_lookup(file, mode_cmd->handles[0]);
 	if (!obj) {
@@ -86,10 +86,12 @@ static int komeda_fb_create_handle(struct drm_framebuff=
er *fb,
 	kfb->offset_payload =3D ALIGN(n_blocks * AFBC_HEADER_SIZE,
 				    alignment_header);
=20
+	bpp =3D komeda_get_afbc_format_bpp(info, fb->modifier);
 	kfb->afbc_size =3D kfb->offset_payload + n_blocks *
-			 ALIGN(info->cpp[0] * AFBC_SUPERBLK_PIXELS,
+			 ALIGN(bpp * AFBC_SUPERBLK_PIXELS / 8,
 			       AFBC_SUPERBLK_ALIGNMENT);
 	min_size =3D kfb->afbc_size + fb->offsets[0];
+
 	if (min_size > obj->size) {
 		DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%lx. min_size 0x%x.\n=
",
 			      obj->size, min_size);
--=20
1.9.1

