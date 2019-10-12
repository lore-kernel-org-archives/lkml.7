Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93663C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536B720673
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pU5lSgeK";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pU5lSgeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfJLG0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:26:44 -0400
Received: from mail-eopbgr60070.outbound.protection.outlook.com ([40.107.6.70]:40615
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbfJLG0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD/tzP/t5qqkBpL7C5G83qv6cL0cAmnLqDZ9yZP/cPc=;
 b=pU5lSgeK/wwtu2VDTdLf0oRgdJFL5VhhamKQA3rZkkcYwppsv20w5a6LImH3aADjb3Y+kb+8Pp8b2OmtbQzWC2j5PnBrkrO+AFyiyTxbQXKrK0L2uZ909RrPNeYxzOKfNZsEhpHzDVp40JqSwbtSqzjvUaOXhQHj8SzRrxcjSWE=
Received: from VE1PR08CA0031.eurprd08.prod.outlook.com (2603:10a6:803:104::44)
 by AM6PR08MB3445.eurprd08.prod.outlook.com (2603:10a6:20b:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Sat, 12 Oct
 2019 06:26:34 +0000
Received: from AM5EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by VE1PR08CA0031.outlook.office365.com
 (2603:10a6:803:104::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.18 via Frontend
 Transport; Sat, 12 Oct 2019 06:26:34 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT019.mail.protection.outlook.com (10.152.16.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Sat, 12 Oct 2019 06:26:32 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Sat, 12 Oct 2019 06:26:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a185b82287f8635d
X-CR-MTA-TID: 64aa7808
Received: from 5c701183a6d3.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6F80B5D7-E877-42E1-BD8E-1130365308D1.1;
        Sat, 12 Oct 2019 06:26:23 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5c701183a6d3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sat, 12 Oct 2019 06:26:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU34M8uZ2iHw/SaOi1KjLR/98cM8uXShe0NsQ7eet9xgahivvelYIHbrmS72/ll7ER2x69kpWRXJGYbPB0JdEuGUTXvEm9KdFhyY0ObJzlcyh+GVtpOyEEkbkyiM1nN3thsx7W0XrEtv/HDtnbkEakeB6yOkZKprY8m8KDh2O3oR7bOIMuaBltsyl1q9Q8cB3JMbCoHq3V9LzTbqwncDvzrBXn0MZnSsApwPGsxLSQYFJ3YM+f+AYT43j8JC3OQh6dskfZWVmL/BwCf4gfllKDb0EzhUvdzTv5bvA7cFKxyh2C1lZiGvquVdTIOT82tcTTOnapBuiwZ5QQTlQv/LNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD/tzP/t5qqkBpL7C5G83qv6cL0cAmnLqDZ9yZP/cPc=;
 b=BGooKosJCu83a9+WJa89FKdl7AmoAlczadWFaY+XPLDUdqC33yZd/d8dnwuiF/+VQ9aO/mnktMpFutd2zOeNct4S1YrsLwQjhtrLRupn8rk6fGAuarCtyqGFW/SMOQyEsimpUr2SZks128ksSupN9vYVTEtYDMBECOw/GB7Tvq7pfuUb6uW0/phWG8tJVo4fBG7wTiZtEAn+AihBhRjdv72N4Pjce0x41ndmz7/L+7fBiTVzQBG2N4MWCywi6mMlGwAJAOJaRNihIUKzjK3t2jKy3JcHZUM3d4xK1Wa82sW6afjLhw9EeP72DPXro+Qrzt3UmEoNzJQ042CwIFFO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD/tzP/t5qqkBpL7C5G83qv6cL0cAmnLqDZ9yZP/cPc=;
 b=pU5lSgeK/wwtu2VDTdLf0oRgdJFL5VhhamKQA3rZkkcYwppsv20w5a6LImH3aADjb3Y+kb+8Pp8b2OmtbQzWC2j5PnBrkrO+AFyiyTxbQXKrK0L2uZ909RrPNeYxzOKfNZsEhpHzDVp40JqSwbtSqzjvUaOXhQHj8SzRrxcjSWE=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB4191.eurprd08.prod.outlook.com (20.178.204.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Sat, 12 Oct 2019 06:26:20 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9%4]) with mapi id 15.20.2347.016; Sat, 12 Oct 2019
 06:26:20 +0000
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
Thread-Index: AQHVgMX1QcaKushXkkSa5yEyPB0t2w==
Date:   Sat, 12 Oct 2019 06:26:20 +0000
Message-ID: <20191012062603.25258-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 6212076e-59e9-493b-dd96-08d74edd1fed
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB4191:|VI1PR08MB4191:|AM6PR08MB3445:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3445F223E8476B2E255DAC979F960@AM6PR08MB3445.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:418;OLM:418;
x-forefront-prvs: 0188D66E61
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(3846002)(6116002)(7736002)(26005)(81156014)(102836004)(2201001)(305945005)(186003)(2906002)(6436002)(316002)(81166006)(256004)(50226002)(14454004)(71190400001)(486006)(14444005)(71200400001)(86362001)(8936002)(476003)(6486002)(54906003)(110136005)(6512007)(1076003)(99286004)(25786009)(2616005)(66446008)(52116002)(66946007)(5660300002)(64756008)(66556008)(6636002)(36756003)(66476007)(6506007)(386003)(4326008)(66066001)(2501003)(55236004)(8676002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4191;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lMLoGUsL+CdIFMoAWPcwV+pwWW4Kd1Jtb9XGKY3QOqmq9zL68K4vRhYdxFYN/DFsOF+OoZWdfouAtFlJVM137Km4KUUGs5qs8XLQmBZh7XBFe2kMYLkw+JGLPwJNVofa5mXi1BZCSf/IzkzQIUGhP4mcKyYAYgAYhUSlW3p+sqKR9kHuEmafKs+BnSZ+3K6tKoEbkqULhnSMsHnsHGV/9zRtG/4h0seE6qy9KBFQBbVJEJINx01T9FuluZuf+RFUtpboCcgS69stM0MeOZ0AaMJYeEZTGqSbt9q4koTbSCdnxiiSEd7T4qSpMLWdHL2wTiDyRVLWc8YCYYsx6D7hqi8O3dzRmmyE8/qrZ2gnWDHw7FW63tEfiRGWVQbdfInVgECHODvt/3tB13mjDHsxlnZpp+qli29udXyaASNSbHY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4191
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(189003)(199004)(7736002)(6512007)(36906005)(99286004)(316002)(70586007)(70206006)(81156014)(2501003)(81166006)(36756003)(8676002)(110136005)(54906003)(4326008)(76130400001)(6486002)(14454004)(1076003)(5660300002)(47776003)(66066001)(336012)(2906002)(14444005)(23756003)(25786009)(356004)(386003)(2201001)(186003)(6116002)(3846002)(6506007)(26005)(478600001)(6636002)(305945005)(102836004)(86362001)(22756006)(50466002)(126002)(63350400001)(486006)(2616005)(476003)(8936002)(50226002)(8746002)(26826003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3445;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: de6ab840-5988-424c-2a46-08d74edd1850
NoDisclaimer: True
X-Forefront-PRVS: 0188D66E61
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FT4Xlt0036y/UQp4fSjTYE+RqbPS/FkzfQEEBE/5F93eryGRRQ0T+p/h7DFO8ZinoG2ScWRUzYiATlRU3C8hcFeTBhu7ePpef5KO6WB2BblDTrNAdidySLwIib9qE04Hjg5b7SdJQhCW8W/h1iNlVgK+Un7u4oq1n0Ag390NCglUTAJjcq7E/64EShJlQECbjcqPQDIhkcEb4xXO+Y3x9pYryVWPrKpYsBnNPxdO+5LJS1owHHCT/D5ouREf+uv5Mvb+u10swSwoh6XxlTMxDbU0dOQqvPDrpuMqbYLZhfL7zyGvKwDGmDG5W4URtQRe7+gbabliESjThE+XZuvN6MoiI23pe2Ww1hyGbugsaslGQXcG6oVCM2aiE4UcdD+WnOg2Vcw4TcdNoFJ+GWvs+Sc5YYwWSOl8JyTHDOFeQUA=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2019 06:26:32.5925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6212076e-59e9-493b-dd96-08d74edd1fed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set color_depth according to connector->bpc.

Changes since v1:
 - Fixed min_bpc is effectively set but not used in
komeda_crtc_get_color_config().

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
index 75263d8cd0bd..fe295c4fca71 100644
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
+	*color_depths =3D GENMASK(min_bpc, 0);
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

