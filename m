Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1318FC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEF82067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="F29ohiyg";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="F29ohiyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfJLGvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:51:06 -0400
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:16033
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726728AbfJLGvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiXdlszNeq8zE5ZFA1BjtPvDxy+u6gSNxo5w3PDwaT8=;
 b=F29ohiygwgWSYkFtA7aE/iia2U9KI3MIXTfXAkYTLE2uWo2yQmi+9Ei32w6zsgmORxw1xIh/nKWoRmpvJQ8LwSA4I1rytRzDkrIHsvnRdcmsLzlnMQLaL4Wy++yTxJleB4Hr+5ppouKJXX6O0HeKP31vEkXtFuXCvg0anyeZ6Gk=
Received: from DB7PR08CA0006.eurprd08.prod.outlook.com (2603:10a6:5:16::19) by
 AM6PR08MB5544.eurprd08.prod.outlook.com (2603:10a6:20b:b7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Sat, 12 Oct 2019 06:50:57 +0000
Received: from VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by DB7PR08CA0006.outlook.office365.com
 (2603:10a6:5:16::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Sat, 12 Oct 2019 06:50:57 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT047.mail.protection.outlook.com (10.152.19.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Sat, 12 Oct 2019 06:50:55 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Sat, 12 Oct 2019 06:50:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4224247899f995fa
X-CR-MTA-TID: 64aa7808
Received: from 5fb4bfd047cb.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 186475AA-0EB0-42F4-9655-2BCE654C7C06.1;
        Sat, 12 Oct 2019 06:50:50 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2051.outbound.protection.outlook.com [104.47.0.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5fb4bfd047cb.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sat, 12 Oct 2019 06:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LozcLbUuWYfEYHJDdT+nDXRjQZT8Hs6T4iQn2TH6PRIzp6TwJKLmSM/rc2Yf8rQkXnIXtc+4oEPD+Nu1UbxMCt6alXby1IcQ5ajmehA2IpsNtcqAX7WWkTjGYs28tYkckRI6Vj2jvp3N/cNM9OdvHOYApwZUY8iuhXOUVgf6GvSI5ZPi7jeb4yD3pB+xhD854QnI8reaagUDEaPZz+KWui8Mf6UV5PQH1wEkErQUbD+mDRXdqMDw/TCoPMq18YyRNJN1PCNKNq1NuvnmrLg5YwShhgMvTaAHd79aM7db0n24QV0Itlr047ykrHMGeZkq+GQmZMNjd8Oz8t99weLC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiXdlszNeq8zE5ZFA1BjtPvDxy+u6gSNxo5w3PDwaT8=;
 b=bTzxzDGp4H1MGsyV3NDHmD3h+ysxeMt9s1MswZIAR7kDm6WGbHAYEKDrW7vvzU0lpTMyV5GiJ3IjshoM31/u+23Yt8wdv57CWPF8uajAmPPjhqYFTgDUQ4JKpW5iecyYQvUlcJrs02OtPlhB5fHGtdKavdPKY8xXWzOfQTs2u/7JANBrlWmSUwfvgaOgCMpMZSyK/YKKuldjaSQ2N4Wl6iFPr6T3/7Gf/HTz+NKoVnMet/wiim3gvSAnrqlxFRxQJGghgVVpgrXms1A+HN5DbSUZz1o3GrsXsN6I3rw4fHZ83ZkwtBpDIef3V3QQS+VdMKd5ir90ESMmtWGX7C2fuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiXdlszNeq8zE5ZFA1BjtPvDxy+u6gSNxo5w3PDwaT8=;
 b=F29ohiygwgWSYkFtA7aE/iia2U9KI3MIXTfXAkYTLE2uWo2yQmi+9Ei32w6zsgmORxw1xIh/nKWoRmpvJQ8LwSA4I1rytRzDkrIHsvnRdcmsLzlnMQLaL4Wy++yTxJleB4Hr+5ppouKJXX6O0HeKP31vEkXtFuXCvg0anyeZ6Gk=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3613.eurprd08.prod.outlook.com (20.177.61.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Sat, 12 Oct 2019 06:50:47 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9%4]) with mapi id 15.20.2347.016; Sat, 12 Oct 2019
 06:50:47 +0000
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
Thread-Index: AQHVgMlgRjNZSavPFUK1VMeh9loRYA==
Date:   Sat, 12 Oct 2019 06:50:46 +0000
Message-ID: <20191012065030.12691-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0038.apcprd03.prod.outlook.com
 (2603:1096:203:2f::26) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: f9fecbf8-23db-470e-7c8c-08d74ee0882b
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3613:|VI1PR08MB3613:|AM6PR08MB5544:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5544A64F9F6FF000D369F1299F960@AM6PR08MB5544.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:469;OLM:469;
x-forefront-prvs: 0188D66E61
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(189003)(199004)(26005)(14444005)(66066001)(1076003)(25786009)(14454004)(6512007)(256004)(36756003)(52116002)(186003)(6506007)(55236004)(476003)(486006)(386003)(2616005)(5660300002)(86362001)(4326008)(102836004)(2201001)(71190400001)(71200400001)(2501003)(7736002)(305945005)(54906003)(110136005)(6436002)(6486002)(50226002)(6636002)(66946007)(81156014)(81166006)(66556008)(66476007)(8676002)(66446008)(64756008)(8936002)(316002)(478600001)(2906002)(6116002)(3846002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3613;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: EoC8Jfd1QCRuvseohmqPvjzMKmWxJPw8QQ0pLSbZk0MCjmXC2CcbTTDoRXmNt4WTiNFcngSt74jcsUcuCX2bU/Xe2RfsEW8CkoD5RyQhWpBm5c7Ox253MOUR8ZbATuHANM5/Q9YIebGSYD4u8s+zQw3s75dtf1A05QdZyfQRcrMf8XkeCtCjNMa5drGjtf97HeHlnfBdkImAZK3lxExRt29zHAVB8QuKOxlICLs+xqRQExqTlkQFLIvH37LiWlcMJ0982aGX94WPXYXS91ohViioFvS3y8cALOup3hlKP/rJPaMQ1hI+nDsdtENuKKNZk4atQycHObZYrHqrFN/BdIGsd0JGwSECU7bYfwQSPQHWghSpsyq/dV5jEaN8v0bVUepHG4mGpjx7ldHsXhNilUFEoIe6A577S2AxiX0moHY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3613
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(199004)(189003)(6116002)(6512007)(36756003)(86362001)(2906002)(486006)(126002)(476003)(66066001)(25786009)(2616005)(110136005)(54906003)(316002)(36906005)(2201001)(7736002)(305945005)(6636002)(6486002)(3846002)(14444005)(47776003)(4326008)(22756006)(8676002)(8936002)(1076003)(81166006)(6506007)(81156014)(50226002)(5660300002)(70586007)(70206006)(76130400001)(99286004)(63350400001)(26826003)(478600001)(50466002)(356004)(8746002)(336012)(386003)(102836004)(186003)(23756003)(14454004)(2501003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5544;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: ddaaaea3-3ba9-4066-74f8-08d74ee08291
NoDisclaimer: True
X-Forefront-PRVS: 0188D66E61
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSWcPJSiCZlZA6azxKSnxtPr75dM8DJ0wTA7qc8tfXR6/wawsHELmtzk6zeFb5aY3d3ctE24ipQWNykht8GC8qFBGloN1k7InpMYx+NmZObHwXwolM4/calJ0FE/nrlBmE+RWkVm6Cd+AtchGJDVWIhvUsk6wFKyI6/kPRBiX9G16VZg0dgzmdKkcwmST+TX42+x8xEXS7dQ/GNZsLlh+42qFNfJy+DlrtF5NIBx+IACy7nirsUaYV1IgJWNLhL4L3sgsKh2kVL7oJwXy0F00J441Oh7rXp0MfgiY9I4n/MAIFmSPDcXvuD7+jyCiKH41bgwYR+uewh+tXrWoECJO98PzhBUwZLS7eB/9m4+K1RRDQqtjl/HocS8XOrt+qI3C9xJEbXkIgTDA5wWneor+ckUJlNcO8MB5FhSDzHa7aw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2019 06:50:55.9335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fecbf8-23db-470e-7c8c-08d74ee0882b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5544
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set color_depth according to connector->bpc.

Changes since v1:
 - Fixed min_bpc is effectively set but not used in
komeda_crtc_get_color_config().

Changes since v2:
 - Align the code.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    |  1 +
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 20 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 ++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
 .../display/komeda/komeda_pipeline_state.c    | 18 +++++++++++++++++
 .../arm/display/komeda/komeda_wb_connector.c  |  4 ++++
 6 files changed, 46 insertions(+)

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
index 0ba9c6aa3708..e64bfeaa06c7 100644
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
@@ -756,6 +757,23 @@ komeda_improc_validate(struct komeda_improc *improc,
 	st->hsize =3D dflow->in_w;
 	st->vsize =3D dflow->in_h;
=20
+	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
+		u32 output_depths;
+		u32 avail_depths;
+
+		komeda_crtc_get_color_config(crtc_st, &output_depths);
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

