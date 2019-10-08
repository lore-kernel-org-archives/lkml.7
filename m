Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74B5C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79724206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="sF4cXpAi";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="sF4cXpAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfJHJSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:18:14 -0400
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:33921
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729624AbfJHJSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/LPRXia6sgkEMw4kcIUVdxLcgOsgR63Gx1IE1Ts/as=;
 b=sF4cXpAipWlHj2Tj8zMNA3GzOHDCG/hsUUEIfeHZRTQL3MhGS7PO7p9JQqowDTQDZOoTOL+sZ2ow25AqHHAimwaawkSFpwGEQbjL0bYCsrgY91MXulNMq3I4ENmpR1gsNOvUl8jm4Rchinj7mNsxBUtlSMgLOSScxYviy3F8gwE=
Received: from VI1PR08CA0163.eurprd08.prod.outlook.com (2603:10a6:800:d1::17)
 by AM6PR08MB4722.eurprd08.prod.outlook.com (2603:10a6:20b:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.25; Tue, 8 Oct
 2019 09:18:07 +0000
Received: from DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by VI1PR08CA0163.outlook.office365.com
 (2603:10a6:800:d1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2327.24 via Frontend
 Transport; Tue, 8 Oct 2019 09:18:07 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT018.mail.protection.outlook.com (10.152.20.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 8 Oct 2019 09:18:05 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Tue, 08 Oct 2019 09:18:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c4a88726849cbcbb
X-CR-MTA-TID: 64aa7808
Received: from faf6d678d58a.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 47CF5C05-BED8-4367-8CD4-83D474D9F35A.1;
        Tue, 08 Oct 2019 09:17:55 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id faf6d678d58a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 08 Oct 2019 09:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FskyOVXmne9iHFQ1X79nCTlHTQYwBz6Fe7Q1fI7KSGdBdIQVSC1e94lY7tm4hh3DW/WGE/LVNqQT+ZA+WeTnYLBI5r7zeFn4Ng4+D3QD/O1BzPhzoyEGtiI4ADOEPZnO9TiBQ0KSX2UqKuZ8PbFkYJuj6k1jjUNEVAlXCi0mslMKavDV6Ze/Y+WvPgCarL6bcuIPmomYSZoqyiIpZqX1inuVnslKY/0l3JyciLtWdrzjoxs1IkY2mFnvnnTVUUIAUstfolzxFRwicyF1zO3SWeQvSGJHSVjIiuGBduIA/mOci8Db/cxb7TiqOIRD/DHUVBw9vGF0u5Ge7zot4gdnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/LPRXia6sgkEMw4kcIUVdxLcgOsgR63Gx1IE1Ts/as=;
 b=SiQ9NB5pnIiJaYNO3IeRF5AMpAhUqT6wmLB9vhA6mAemHApiUbZKL8HhRhea/GLCCZ3sHgsQbuQue03iWszyMbbHjdls54RVn4y1ONcQ/1XWfFn2msPkXC6PVssNGHXZ0tagVXVvMDJFnPOYOEybA4BDOjWbNXJ1DTjZ9NwPUFzxnM/eNgj/0ymtIgAmHUj5AVbjsSRPrxz2ujSLr+CAxhE0SGIuVtnZlQCuf88jsejARtdoZws+9N8XuSagm25bM6ExC7eheBxVXfpbwaad1x5cUMT0Lh6kYdLV9MwTlRPbMp2ZofYE26x0NG9H4xMRJeRyL9mIF/41JcxRrjifpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/LPRXia6sgkEMw4kcIUVdxLcgOsgR63Gx1IE1Ts/as=;
 b=sF4cXpAipWlHj2Tj8zMNA3GzOHDCG/hsUUEIfeHZRTQL3MhGS7PO7p9JQqowDTQDZOoTOL+sZ2ow25AqHHAimwaawkSFpwGEQbjL0bYCsrgY91MXulNMq3I4ENmpR1gsNOvUl8jm4Rchinj7mNsxBUtlSMgLOSScxYviy3F8gwE=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3294.eurprd08.prod.outlook.com (52.134.31.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 09:17:53 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9%4]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 09:17:52 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: [PATCH] drm/komeda: Set output color depth for output
Thread-Topic: [PATCH] drm/komeda: Set output color depth for output
Thread-Index: AQHVfblD7I+ubO1huUCp0qQz7Z0Q4Q==
Date:   Tue, 8 Oct 2019 09:17:52 +0000
Message-ID: <20191008091734.19509-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::21) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: a413a5ad-9c04-42e6-07cb-08d74bd06d4a
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3294:|VI1PR08MB3294:|AM6PR08MB4722:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB472246C33ABCF7D6D54B22D49F9A0@AM6PR08MB4722.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:171;OLM:171;
x-forefront-prvs: 01842C458A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(71190400001)(50226002)(64756008)(66476007)(66556008)(256004)(14444005)(3846002)(66446008)(8936002)(6436002)(6116002)(25786009)(102836004)(52116002)(4326008)(6512007)(305945005)(14454004)(478600001)(386003)(110136005)(55236004)(8676002)(81166006)(81156014)(66946007)(99286004)(6506007)(54906003)(36756003)(316002)(7736002)(26005)(66066001)(86362001)(186003)(2906002)(6486002)(476003)(71200400001)(2201001)(1076003)(2616005)(2501003)(486006)(6636002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3294;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: A9hxokkjt2wI5fN9hvXVNO7RKBq0HFVdNNHiTwHGz71e9eZLj31Xq6OuyJepAYKE5kKF0yorPwO/2fcx7VP6U9xpsm+OKyFaRMJ0j+kaXibDy2DK8wtjMY9FtZcaCdHq76rpe5/+yNjGMPTDTXb4o1UxqkuDRgK8N+NVAY/VNwlHy8x394PN2kri3UQOPn+DMes3SrXmKKCClS9Tv1kKqmni0V4Cv0mltqE52SIrqtRRCMjOChNjDRW0e2VXTWrpgmFg6kNFqzsdVjEKyrtQ0Ke7BW+048XAnPrKxlacmo/tF+2QaN+2tfhVGxogfKTEy1YSWYrNhjD/cZeWBwk4K+m6nhXVaR9xEKHSDbINv/lRRiYHGqYdJnrgXxHs9zH0dKjTlfcuIqdQdCDsxvg/6tAFwvOd1QAeKEIe8SI7WoQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3294
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(199004)(189003)(99286004)(2906002)(8676002)(486006)(356004)(14454004)(110136005)(36756003)(2201001)(76130400001)(6512007)(8936002)(50466002)(14444005)(47776003)(8746002)(86362001)(316002)(7736002)(3846002)(6116002)(4326008)(305945005)(70586007)(50226002)(70206006)(66066001)(2501003)(22756006)(1076003)(63350400001)(6486002)(102836004)(476003)(2616005)(54906003)(25786009)(6506007)(386003)(6636002)(478600001)(26826003)(336012)(5660300002)(81166006)(81156014)(126002)(186003)(23756003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4722;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 86a1dbbc-cf2a-4003-cfb4-08d74bd06560
NoDisclaimer: True
X-Forefront-PRVS: 01842C458A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBgfvSalU29OIhnL6TAKBQhl3X9RdcFuk3qiEIYl0zeopOrlQtKVmJADncP7XwQjtEt1Kh0G0epGyw4VHSzbFjDnT1408tLUYwz3B1cS89AAPjsDD2qusyZE613KOgEYo3zLMUg/UU7CrQVq8e5bqLXaTt61GbjE62ED86l0plth+MDAgVsssSTRpz7zfGRgMgZAFOcHdSyk4HWaWUR0RF5oqUzWpk9eNkh9r1L4BSwhfuzePKRhJFFgnfoMhjEeFacSHo2ota0MnvKKhzPYIBgvy4tcDjz7yK6kCdfH6Otd9qVh72Ebovm651e5XGZoijaVZU7XEESuKaOTEuxT1RfLd+QZULwbhXr7qc7HLiR93F3irHCDxY84El61+ZvGENgg0/oQk3OfitvinjT9OXn1qCm4m98ShzbJYMuZFF4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 09:18:05.4563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a413a5ad-9c04-42e6-07cb-08d74bd06d4a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set color_depth according to connector->bpc.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    |  1 +
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 20 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 ++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
 .../display/komeda/komeda_pipeline_state.c    | 19 ++++++++++++++++++
 .../arm/display/komeda/komeda_wb_connector.c  |  4 ++++
 6 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index c3d29c0b051b..27cdb03573c1 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -951,6 +951,7 @@ static void d71_improc_update(struct komeda_component *=
c,
 			       to_d71_input_id(state, index));
=20
 	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
+	malidp_write32(reg, IPS_DEPTH, st->color_depth);
 }
=20
 static void d71_improc_dump(struct komeda_component *c, struct seq_file *s=
f)
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 75263d8cd0bd..baa986b70876 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -17,6 +17,26 @@
 #include "komeda_dev.h"
 #include "komeda_kms.h"
=20
+void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
+				  u32 *color_depths)
+{
+	struct drm_connector *conn;
+	struct drm_connector_state *conn_st;
+	int i, min_bpc =3D 31, conn_bpc =3D 0;
+
+	for_each_new_connector_in_state(crtc_st->state, conn, conn_st, i) {
+		if (conn_st->crtc !=3D crtc_st->crtc)
+			continue;
+
+		conn_bpc =3D conn->display_info.bpc ? conn->display_info.bpc : 8;
+
+		if (conn_bpc < min_bpc)
+			min_bpc =3D conn_bpc;
+	}
+
+	*color_depths =3D GENMASK(conn_bpc, 0);
+}
+
 static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *kcrtc=
_st)
 {
 	u64 pxlclk, aclk;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index 45c498e15e7a..a42503451b5d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -166,6 +166,8 @@ static inline bool has_flip_h(u32 rot)
 		return !!(rotation & DRM_MODE_REFLECT_X);
 }
=20
+void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
+				  u32 *color_depths);
 unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc_st);
=20
 int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_dev *=
mdev);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index b322f52ba8f2..7653f134a8eb 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -323,6 +323,7 @@ struct komeda_improc {
=20
 struct komeda_improc_state {
 	struct komeda_component_state base;
+	u8 color_depth;
 	u16 hsize, vsize;
 };
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 0ba9c6aa3708..e68e8f85ab27 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -743,6 +743,7 @@ komeda_improc_validate(struct komeda_improc *improc,
 		       struct komeda_data_flow_cfg *dflow)
 {
 	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
+	struct drm_crtc_state *crtc_st =3D &kcrtc_st->base;
 	struct komeda_component_state *c_st;
 	struct komeda_improc_state *st;
=20
@@ -756,6 +757,24 @@ komeda_improc_validate(struct komeda_improc *improc,
 	st->hsize =3D dflow->in_w;
 	st->vsize =3D dflow->in_h;
=20
+	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
+		u32 output_depths;
+		u32 avail_depths;
+
+		komeda_crtc_get_color_config(crtc_st,
+					     &output_depths);
+
+		avail_depths =3D output_depths & improc->supported_color_depths;
+		if (avail_depths =3D=3D 0) {
+			DRM_DEBUG_ATOMIC("No available color depths, conn depths: 0x%x & displa=
y: 0x%x\n",
+					 output_depths,
+					 improc->supported_color_depths);
+			return -EINVAL;
+		}
+
+		st->color_depth =3D __fls(avail_depths);
+	}
+
 	komeda_component_add_input(&st->base, &dflow->input, 0);
 	komeda_component_set_output(&dflow->input, &improc->base, 0);
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 2851cac94d86..740a81250630 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -142,6 +142,7 @@ static int komeda_wb_connector_add(struct komeda_kms_de=
v *kms,
 	struct komeda_dev *mdev =3D kms->base.dev_private;
 	struct komeda_wb_connector *kwb_conn;
 	struct drm_writeback_connector *wb_conn;
+	struct drm_display_info *info;
 	u32 *formats, n_formats =3D 0;
 	int err;
=20
@@ -171,6 +172,9 @@ static int komeda_wb_connector_add(struct komeda_kms_de=
v *kms,
=20
 	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs);
=20
+	info =3D &kwb_conn->base.base.display_info;
+	info->bpc =3D __fls(kcrtc->master->improc->supported_color_depths);
+
 	kcrtc->wb_conn =3D kwb_conn;
=20
 	return 0;
--=20
2.17.1

