Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6FAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E333920659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RxgJx8wK";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RxgJx8wK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfJOJK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:10:58 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:55864
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfJOJK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73J9/6YbducaZHY0q3DvPdTyfsume7BIftT9rgYXkyI=;
 b=RxgJx8wK2xjKBDLzT3BgqoUfFzWGlrbhqCj6k8IIBQvoyqUx6xqEfwQIAyAgDBg0Cdv+1wEQLaeik4fVKLMwr8X0EdY5+KdwTLGa9FfkvYJAIWp8OsiMqZdl1y3mHBWu42Gs5cen9CWxk9irl4SKjACmcbsCnqMnZTtx8KhItPs=
Received: from VI1PR0801CA0090.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::34) by DBBPR08MB4871.eurprd08.prod.outlook.com
 (2603:10a6:10:da::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.22; Tue, 15 Oct
 2019 09:10:50 +0000
Received: from AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by VI1PR0801CA0090.outlook.office365.com
 (2603:10a6:800:7d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 15 Oct 2019 09:10:50 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT026.mail.protection.outlook.com (10.152.16.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 09:10:49 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Tue, 15 Oct 2019 09:10:44 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6bd4f8444a8ab4e0
X-CR-MTA-TID: 64aa7808
Received: from e2a2fc337256.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 726A4DD6-01E7-45F0-8118-76D35641BF6E.1;
        Tue, 15 Oct 2019 09:10:39 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e2a2fc337256.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Oct 2019 09:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEOnjw/RxKzoV4XVyD30YCJPkNhigXNoX7bTROTPey4W6T5XlhQYsTE04IP5qP9Qk8M6SG5P0IY515hTkoksF0ujwQX0ysqgn0/2mS54wqDvCPTyTMKoRWPZehBPYW3XZsWugMVbp6HcJUlFJ45kOiQqfupVvQaVzBvkwF9Msne8hddcu8WwEFYDvPjivg448QC7fVF/4MNtmfyYlAF2JlM56EwgkDWZlicQfLfO270OsvKHq7yszWc0jP+ptve0aOD+TeMVwe5HAH7pcx9xbqcENslT3iqLn1uSt6VVPi16ijm3Sh/9fF8OVa64ivj/BqbuL6A7m6xIfIon5v9EWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73J9/6YbducaZHY0q3DvPdTyfsume7BIftT9rgYXkyI=;
 b=WrGHe/0MA8ehaPrJvOwqKJEfJFFys5aSOLdD1Tfz1rfMpFPzw/RTiYjl8EGbQ05rI40BJZF4anpzgHOmtAya4y+urwa/RcJVsIg2+Hc8/Y5sXmLEtCbxSfydXakXO84uC1FT7YpMBk7F787gA/wRW8sH7pjbiJMHsSJgYk8hz8cmQE8yi2pEuKCW/k2UO+kc7wStE/UuByXVD1Pn/AUhYqB99obqJi5PUrxTeY1lk9R/oAbMIwvfTdnpQyCTqYuaxTH5al/ygbVaJfs0NP5lHYI2wW1w7x0cCRkHMiZDrR/gw/AR6Umt2guGERhbf5x9YzsfLOESilF/2Yz5Ov9D1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73J9/6YbducaZHY0q3DvPdTyfsume7BIftT9rgYXkyI=;
 b=RxgJx8wK2xjKBDLzT3BgqoUfFzWGlrbhqCj6k8IIBQvoyqUx6xqEfwQIAyAgDBg0Cdv+1wEQLaeik4fVKLMwr8X0EdY5+KdwTLGa9FfkvYJAIWp8OsiMqZdl1y3mHBWu42Gs5cen9CWxk9irl4SKjACmcbsCnqMnZTtx8KhItPs=
Received: from VE1PR08MB5182.eurprd08.prod.outlook.com (20.179.31.89) by
 VE1PR08MB4734.eurprd08.prod.outlook.com (10.255.112.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Tue, 15 Oct 2019 09:10:36 +0000
Received: from VE1PR08MB5182.eurprd08.prod.outlook.com
 ([fe80::a54d:cc87:644c:e3ba]) by VE1PR08MB5182.eurprd08.prod.outlook.com
 ([fe80::a54d:cc87:644c:e3ba%6]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 09:10:36 +0000
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
Subject: [PATCH] drm/komeda: Adds output-color format support
Thread-Topic: [PATCH] drm/komeda: Adds output-color format support
Thread-Index: AQHVgzho76HHJMWyq0e6Tzi6Iw+N9w==
Date:   Tue, 15 Oct 2019 09:10:36 +0000
Message-ID: <20191015091019.26021-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0039.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::27) To VE1PR08MB5182.eurprd08.prod.outlook.com
 (2603:10a6:803:10c::25)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d6c8de94-89c3-42fa-4b9f-08d7514f9212
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4734:|VE1PR08MB4734:|DBBPR08MB4871:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB4871F136F2486F6F585529C29F930@DBBPR08MB4871.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:451;OLM:451;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(4326008)(14444005)(55236004)(71200400001)(14454004)(102836004)(36756003)(25786009)(478600001)(110136005)(66446008)(1076003)(64756008)(52116002)(50226002)(256004)(305945005)(66476007)(66946007)(66556008)(99286004)(54906003)(7736002)(386003)(6636002)(6506007)(86362001)(66066001)(2201001)(2906002)(26005)(6512007)(6116002)(2501003)(6436002)(186003)(476003)(2616005)(486006)(71190400001)(6486002)(5660300002)(8936002)(81166006)(81156014)(8676002)(316002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4734;H:VE1PR08MB5182.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rjKQyd8ErP++ptaWHSXmmdD6oKPy98YJZod9WbMiMlUegtknfS1bahnRu/43oQFqe2ScSfBtrrw2XP/BtB9PG9M2ZH3LuWBjI7m2c+VbW1NxWEVz8+PBhhNWBCySj/5txjr34FXMbMLoE+uVDxy8XNri8D5Q5UTuFUHOsjmOpxVS4PYMmN3bZh0ytji465DkZITe4xJ64Ll7R/CwH0pJPd3lDotItbZSoX70DUydpuBQJz2Sh8leaKJPEVcnaycMzT9YMkMYRJ9MtaJaXBaqDLv1pCumuxExfTbGz+yZRS9IKu60yTzqIRuBnurq5MaK+qbvcxNCWduUW7XgByKLxvljmimlSEr9U/ekfK/Hu3FiretAiO55GqkCkSN0fuFdEJO3KRWRUMsrRfQIbAaX6a9+hru7/Oz0+sA1yqulOpg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4734
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(2201001)(102836004)(110136005)(316002)(63350400001)(6512007)(2501003)(36906005)(99286004)(386003)(6506007)(8746002)(23756003)(86362001)(22756006)(54906003)(66066001)(26005)(26826003)(6486002)(50226002)(478600001)(5660300002)(8936002)(1076003)(47776003)(186003)(6636002)(3846002)(14444005)(6116002)(81166006)(81156014)(36756003)(2616005)(14454004)(8676002)(486006)(356004)(336012)(2906002)(70586007)(4326008)(25786009)(126002)(50466002)(305945005)(7736002)(70206006)(476003)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4871;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 85b9f9f3-bb41-4177-75f7-08d7514f8a6b
NoDisclaimer: True
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFuh/IQRoA+502nIrsxzxx+QHnEXQIoaTTNNOAmyFFSb0efNc+7WugyPWcm8CEqdetaAgFQgSBSp5Pkr4SOZ0lhPVMOegKFBWRbuIcUtcbKX7UnaFS99+p8C2p0pj1HQdXQDJ++GQvwLrKZBOq5/a58s1Rhcqq4NjgWis+k9baKxbJNay7Z3a5VkgUEzJULThDoA/fnTBtLA7tq0bJeMB5GuAiiBxbvMyXKkCF0uV9TYMT1jzHnr2BYbaUtMfC/da9Y0Dk8CPvvFjdi1TWL3fkUjmee8Y69iZtVJCetv+AlST4RkXc2TNQcGtMEF0TpI98inokCfMHbaCLzG4exC3EFWk45XpxVZFpobzc2UTZS7liy6r6LTVCstw/clyWcBVyC8PH2YFEjXqLA9k20NQO/ePG1FXb+I7CuoFV8s/d0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 09:10:49.0422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c8de94-89c3-42fa-4b9f-08d7514f9212
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4871
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sets output color format according to the connector formats and
display supported formats. Default value is RGB444 and only force
YUV format which must be YUV.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../drm/arm/display/komeda/d71/d71_component.c  | 14 +++++++++++++-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c    |  9 ++++++++-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h |  2 +-
 .../drm/arm/display/komeda/komeda_pipeline.h    |  2 +-
 .../arm/display/komeda/komeda_pipeline_state.c  | 17 ++++++++++++++---
 .../arm/display/komeda/komeda_wb_connector.c    |  1 +
 6 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index 27cdb03573c1..7b374a3b911e 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -944,7 +944,7 @@ static void d71_improc_update(struct komeda_component *=
c,
 {
 	struct komeda_improc_state *st =3D to_improc_st(state);
 	u32 __iomem *reg =3D c->reg;
-	u32 index;
+	u32 index, mask =3D 0, ctrl =3D 0;
=20
 	for_each_changed_input(state, index)
 		malidp_write32(reg, BLK_INPUT_ID0 + index * 4,
@@ -952,6 +952,18 @@ static void d71_improc_update(struct komeda_component =
*c,
=20
 	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
 	malidp_write32(reg, IPS_DEPTH, st->color_depth);
+
+	mask |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422 | IPS_CTRL_CHD420;
+
+	/* config color format */
+	if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB420)
+		ctrl |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422 | IPS_CTRL_CHD420;
+	else if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB422)
+		ctrl |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422;
+	else if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB444)
+		ctrl |=3D IPS_CTRL_YUV;
+
+	malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
 }
=20
 static void d71_improc_dump(struct komeda_component *c, struct seq_file *s=
f)
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index fe295c4fca71..c9b8d2d5e195 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -18,10 +18,11 @@
 #include "komeda_kms.h"
=20
 void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
-				  u32 *color_depths)
+				  u32 *color_depths, u32 *color_formats)
 {
 	struct drm_connector *conn;
 	struct drm_connector_state *conn_st;
+	u32 conn_color_formats =3D ~0u;
 	int i, min_bpc =3D 31, conn_bpc =3D 0;
=20
 	for_each_new_connector_in_state(crtc_st->state, conn, conn_st, i) {
@@ -29,12 +30,18 @@ void komeda_crtc_get_color_config(struct drm_crtc_state=
 *crtc_st,
 			continue;
=20
 		conn_bpc =3D conn->display_info.bpc ? conn->display_info.bpc : 8;
+		conn_color_formats &=3D conn->display_info.color_formats;
=20
 		if (conn_bpc < min_bpc)
 			min_bpc =3D conn_bpc;
 	}
=20
+	/* connector doesn't config any color_format, use RGB444 as default */
+	if (!conn_color_formats)
+		conn_color_formats =3D DRM_COLOR_FORMAT_RGB444;
+
 	*color_depths =3D GENMASK(min_bpc, 0);
+	*color_formats =3D conn_color_formats;
 }
=20
 static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *kcrtc=
_st)
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index a42503451b5d..456f3c435719 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -167,7 +167,7 @@ static inline bool has_flip_h(u32 rot)
 }
=20
 void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
-				  u32 *color_depths);
+				  u32 *color_depths, u32 *color_formats);
 unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc_st);
=20
 int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_dev *=
mdev);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 7653f134a8eb..c0f53b19b62d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -323,7 +323,7 @@ struct komeda_improc {
=20
 struct komeda_improc_state {
 	struct komeda_component_state base;
-	u8 color_depth;
+	u8 color_format, color_depth;
 	u16 hsize, vsize;
 };
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index e64bfeaa06c7..948d1951c8eb 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -758,10 +758,11 @@ komeda_improc_validate(struct komeda_improc *improc,
 	st->vsize =3D dflow->in_h;
=20
 	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
-		u32 output_depths;
-		u32 avail_depths;
+		u32 output_depths, output_formats;
+		u32 avail_depths, avail_formats;
=20
-		komeda_crtc_get_color_config(crtc_st, &output_depths);
+		komeda_crtc_get_color_config(crtc_st, &output_depths,
+					     &output_formats);
=20
 		avail_depths =3D output_depths & improc->supported_color_depths;
 		if (avail_depths =3D=3D 0) {
@@ -771,7 +772,17 @@ komeda_improc_validate(struct komeda_improc *improc,
 			return -EINVAL;
 		}
=20
+		avail_formats =3D output_formats &
+				improc->supported_color_formats;
+		if (!avail_formats) {
+			DRM_DEBUG_ATOMIC("No available color_formats, conn formats 0x%x & displ=
ay: 0x%x\n",
+					 output_formats,
+					 improc->supported_color_formats);
+			return -EINVAL;
+		}
+
 		st->color_depth =3D __fls(avail_depths);
+		st->color_format =3D BIT(__ffs(avail_formats));
 	}
=20
 	komeda_component_add_input(&st->base, &dflow->input, 0);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 740a81250630..abfa587db189 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -174,6 +174,7 @@ static int komeda_wb_connector_add(struct komeda_kms_de=
v *kms,
=20
 	info =3D &kwb_conn->base.base.display_info;
 	info->bpc =3D __fls(kcrtc->master->improc->supported_color_depths);
+	info->color_formats =3D kcrtc->master->improc->supported_color_formats;
=20
 	kcrtc->wb_conn =3D kwb_conn;
=20
--=20
2.17.1

