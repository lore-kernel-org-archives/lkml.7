Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892CCC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB14208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="uYWhFFEv";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="uYWhFFEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405971AbfITJoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:44:19 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:28654
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405593AbfITJoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkgJ248wODu7xn5bNdFv8RGeSHW8LSmP0M1ZBKun/Wo=;
 b=uYWhFFEvNNO2N1NeGKOLxrUfTMHp7kgyGb+duUo3nhWOkE+qJ7qx3jH7vZM8790pUmj99485PgSoBpYZw6xYdUz2koV6BompW7ZjgtzlOljDE60y2nw8q5O91kxWD215KckWrGmX1i1a3Hr5uxo9YSMELTtT6C3kusCxjivQR/k=
Received: from VI1PR08CA0168.eurprd08.prod.outlook.com (2603:10a6:800:d1::22)
 by VI1PR0802MB2575.eurprd08.prod.outlook.com (2603:10a6:800:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.22; Fri, 20 Sep
 2019 09:43:58 +0000
Received: from VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by VI1PR08CA0168.outlook.office365.com
 (2603:10a6:800:d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.22 via Frontend
 Transport; Fri, 20 Sep 2019 09:43:58 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT042.mail.protection.outlook.com (10.152.19.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Fri, 20 Sep 2019 09:43:56 +0000
Received: ("Tessian outbound 0d576b67b9f5:v31"); Fri, 20 Sep 2019 09:43:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 722dce856f453c08
X-CR-MTA-TID: 64aa7808
Received: from 85a293af43a8.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A3FA5843-D0C7-4062-8275-DFDF911859A7.1;
        Fri, 20 Sep 2019 09:43:49 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2055.outbound.protection.outlook.com [104.47.8.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 85a293af43a8.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 20 Sep 2019 09:43:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYMyrTFMz3zcA5GMMNjv7G28hwFEPM2rbpfZtIWn1x3diMDeeGxXJ4SB279Kop1TvrOayjghDsO5Y0OzPGRwmZolsDJKRlztoxawEqiVvvMZBnmBytzRAUGIcIZhYow5ysBewktAbdI8oga1yPDANVBKkUDhdw9Dw7n37UFi2La7Ip66c6QYz88sMTaqbGJ21JGEIieG9BM9yPS0btmK6Y1NH7aNvXGooe8rZQQfU4rs2Am1HvZ5GPUUIhz0PXoNTmnTQW24dEax4qqoTIhaHx8HQfBFgtGeau/TX3LitLiddoAXmDADC8l7CVDlEvkgpHYxG0sVQLHPwbX5HENWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkgJ248wODu7xn5bNdFv8RGeSHW8LSmP0M1ZBKun/Wo=;
 b=S2jpUeg56ao3fHu4hwFLKQK2EjEqI6b4aXWUBMgTM5nfQtW+TohahcG9tmfBQypsXmoC/ZR12BhEiq8Se2GJ9AIPk0y8FBHkviY1YRljSr5MN5dnpCNkWHqz3cT2L+IjiPqi3Dwqc56oYW555VINVhS1abJZBGMhFv1UhzBqSBeV8JNyz9pGKhv0fQSbWMn71KBwfAdGqUN1RQc11k14ZSYfJRfdYtYDj1/QrlGh8FQ1ZVeJoE5GGFwigrT72iCWVCGw4TbypkE0HII7QNGsLV9yVZWHArXIl3PPHeuMnBePfuCh4DQoBg5LLjFL2wrgjzxWft42taNt0bQqvg7wnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkgJ248wODu7xn5bNdFv8RGeSHW8LSmP0M1ZBKun/Wo=;
 b=uYWhFFEvNNO2N1NeGKOLxrUfTMHp7kgyGb+duUo3nhWOkE+qJ7qx3jH7vZM8790pUmj99485PgSoBpYZw6xYdUz2koV6BompW7ZjgtzlOljDE60y2nw8q5O91kxWD215KckWrGmX1i1a3Hr5uxo9YSMELTtT6C3kusCxjivQR/k=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB5472.eurprd08.prod.outlook.com (52.133.246.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Fri, 20 Sep 2019 09:43:47 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b%3]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 09:43:47 +0000
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
Subject: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Topic: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Index: AQHVb5fml3iiEtk+MEOqXjNduhm+kA==
Date:   Fri, 20 Sep 2019 09:43:47 +0000
Message-ID: <20190920094329.17513-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 77739a83-8693-4e60-56d1-08d73daf0ea9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB5472;
X-MS-TrafficTypeDiagnostic: VI1PR08MB5472:|VI1PR08MB5472:|VI1PR0802MB2575:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB257562CAACA2274F85B57B609F880@VI1PR0802MB2575.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 0166B75B74
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(6506007)(2906002)(386003)(5660300002)(55236004)(316002)(3846002)(50226002)(36756003)(102836004)(52116002)(6636002)(8676002)(81166006)(81156014)(256004)(66946007)(14444005)(64756008)(25786009)(66446008)(66556008)(26005)(110136005)(54906003)(2501003)(66476007)(6116002)(8936002)(99286004)(186003)(2616005)(14454004)(2201001)(66066001)(6486002)(476003)(6436002)(6512007)(486006)(1076003)(86362001)(478600001)(4326008)(71200400001)(71190400001)(305945005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5472;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: hijrYC25nh9GW4/ASh68fDTurXfNlkNBFpO+fhAR4wUKfR8+lU+4gWg/03ft11TZo2rXTWZCOxjm9swLZ4p+yUoyeacqDD6Kn5GHD0BN0wNS/KKf4RpjkkEVmZrdt/qXk2VBGWFCFHetXMlBzu3E9VOZ10qLz3M0iMAXAjYcw3dndquGKSGAIcyvT8L2BA41h6XdzJBJ+7Fd6Oyh5cV9NS3T5VqIlZlvT9WMs5BeMz9an1yY0WJNKaa+DWgZm8n6cCDyzaoTRfcA93QV7RRm3RTvZGooo1SpNNB/j9grjWbnTRuyy2G9u58l9cAnMRBW2uMgMspaN1EpE/6PtJNoU42up11XqnWVQu/VFJV2rN1/r0dx8B9bdl6x8lzw0OPN5xa6oVvsTieV6/H6qWg+if1Dxkj0ESYQ+1oG953Zfss=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5472
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(66066001)(54906003)(1076003)(2616005)(316002)(63350400001)(110136005)(50466002)(36756003)(126002)(336012)(36906005)(3846002)(47776003)(486006)(99286004)(476003)(6116002)(22756006)(356004)(14454004)(6636002)(2501003)(2201001)(4326008)(86362001)(26005)(5660300002)(26826003)(6486002)(81156014)(76130400001)(81166006)(14444005)(8676002)(478600001)(8746002)(8936002)(386003)(70206006)(23756003)(6506007)(6512007)(70586007)(2906002)(50226002)(186003)(102836004)(25786009)(7736002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2575;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 10cedccc-6bb9-4565-9e98-08d73daf0890
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0802MB2575;
NoDisclaimer: True
X-Forefront-PRVS: 0166B75B74
X-Microsoft-Antispam-Message-Info: uJDUz++g3+98UZ2+iOvUFq7z9+8YRQM3EoR211VbvYMJ1R4e05hFUhGklemMMUopPzM1XQgFDl0bFO5dJpEhhdKPj+bh2PN9g/DsGltYNR3AOqk5DrKiWOpSg7nD26AFl7Kw1tz53N6HwfABI0rcpkW9x7I7k7cPLAvif8iUCAcI9sCaut9EIcZPeNXQFLdxbfQGNXUxyuQ/z0GkF2m2rizoEICDrlw8W3C2vbIEXAdS2dpOc6FbF1pYsR0xylYajF/YD58mnE/TeheqngVsNUvXzKzhqV7RAR5/xBeapw5REf4ELJwRqn8dL3pDhxR55OHjFg6m5xAH1EkB18ZZOgW+Qlw4/qABZb7/GJb6gNyhdLPQazgJ8tyu3XCbIjxd8TT8L50HsseGBIiJbQPtKlqn/ZGWGW6gNHGs7czyYkQ=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2019 09:43:56.9353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77739a83-8693-4e60-56d1-08d73daf0ea9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>

Sets color_depth according to connector->bpc.
Adds a new optional DT attribute "color-format" to represent a
preferred color formats for a specific pipeline, and the select order
is:
	YCRCB420 > YCRCB422 > YCRCB444 > RGB444
The color-format can be anyone of these 4 format, one color-format not
only represent one format, but also include the lower formats, like

color-format         preferred_color_formats
YCRCB420        YCRCB420 > YCRCB422 > YCRCB444 > RGB444
YCRCB422        YCRCB422 > YCRCB444 > RGB444
YCRCB444        YCRCB444 > RGB444
RGB444          RGB444

Then the final color_format is calculated by 3 steps:
1. calculate HW available formats.
  avail_formats =3D connector_color_formats & improc->color_formats;
2. filter out un-preferred format.
  avail_formats &=3D preferred_color_formats;
3. select the final format according to the preferred order.
  color_format =3D BIT(__fls(aval_formats));

Changes since v1:
Rebased to the drm-misc-next branch.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 15 ++++++++-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 27 ++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 32 ++++++++++++++++++-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 ++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 ++
 .../display/komeda/komeda_pipeline_state.c    | 31 ++++++++++++++++++
 .../arm/display/komeda/komeda_wb_connector.c  |  5 +++
 7 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index c3d29c0b051b..7b374a3b911e 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -944,13 +944,26 @@ static void d71_improc_update(struct komeda_component=
 *c,
 {
 	struct komeda_improc_state *st =3D to_improc_st(state);
 	u32 __iomem *reg =3D c->reg;
-	u32 index;
+	u32 index, mask =3D 0, ctrl =3D 0;
=20
 	for_each_changed_input(state, index)
 		malidp_write32(reg, BLK_INPUT_ID0 + index * 4,
 			       to_d71_input_id(state, index));
=20
 	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
+	malidp_write32(reg, IPS_DEPTH, st->color_depth);
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
index 624d257da20f..38d5cb20e908 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -18,6 +18,33 @@
 #include "komeda_dev.h"
 #include "komeda_kms.h"
=20
+void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
+				  u32 *color_depths, u32 *color_formats)
+{
+	struct drm_connector *conn;
+	struct drm_connector_state *conn_st;
+	u32 conn_color_formats =3D ~0u;
+	int i, min_bpc =3D 31, conn_bpc =3D 0;
+
+	for_each_new_connector_in_state(crtc_st->state, conn, conn_st, i) {
+		if (conn_st->crtc !=3D crtc_st->crtc)
+			continue;
+
+		conn_bpc =3D conn->display_info.bpc ? conn->display_info.bpc : 8;
+		conn_color_formats &=3D conn->display_info.color_formats;
+
+		if (conn_bpc < min_bpc)
+			min_bpc =3D conn_bpc;
+	}
+
+	/* connector doesn't config any color_format, use RGB444 as default */
+	if (conn_color_formats =3D=3D 0)
+		conn_color_formats =3D DRM_COLOR_FORMAT_RGB444;
+
+	*color_depths =3D GENMASK(conn_bpc, 0);
+	*color_formats =3D conn_color_formats;
+}
+
 static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *kcrtc=
_st)
 {
 	u64 pxlclk, aclk;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 9cbcd56e54cd..bee4633cdd9f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -113,12 +113,34 @@ static struct attribute_group komeda_sysfs_attr_group=
 =3D {
 	.attrs =3D komeda_sysfs_entries,
 };
=20
+static int to_color_format(const char *str)
+{
+	int format;
+
+	if (!strncmp(str, "RGB444", 7)) {
+		format =3D DRM_COLOR_FORMAT_RGB444;
+	} else if (!strncmp(str, "YCRCB444", 9)) {
+		format =3D DRM_COLOR_FORMAT_YCRCB444;
+	} else if (!strncmp(str, "YCRCB422", 9)) {
+		format =3D DRM_COLOR_FORMAT_YCRCB422;
+	} else if (!strncmp(str, "YCRCB420", 9)) {
+		format =3D DRM_COLOR_FORMAT_YCRCB420;
+	} else {
+		DRM_WARN("invalid color_format: %s, please set it to RGB444, YCRCB444, Y=
CRCB422 or YCRCB420\n",
+			 str);
+		format =3D DRM_COLOR_FORMAT_RGB444;
+	}
+
+	return format;
+}
+
 static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_nod=
e *np)
 {
 	struct komeda_pipeline *pipe;
 	struct clk *clk;
 	u32 pipe_id;
-	int ret =3D 0;
+	int ret =3D 0, color_format;
+	const char *str;
=20
 	ret =3D of_property_read_u32(np, "reg", &pipe_id);
 	if (ret !=3D 0 || pipe_id >=3D mdev->n_pipelines)
@@ -133,6 +155,14 @@ static int komeda_parse_pipe_dt(struct komeda_dev *mde=
v, struct device_node *np)
 	}
 	pipe->pxlclk =3D clk;
=20
+	/* fetch DT configured color-format, if not set, use RGB444 */
+	if (!of_property_read_string(np, "color-format", &str))
+		color_format =3D to_color_format(str);
+	else
+		color_format =3D DRM_COLOR_FORMAT_RGB444;
+
+	pipe->improc->preferred_color_formats =3D (color_format << 1) - 1;
+
 	/* enum ports */
 	pipe->of_output_links[0] =3D
 		of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTPUT, 0);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index 45c498e15e7a..456f3c435719 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -166,6 +166,8 @@ static inline bool has_flip_h(u32 rot)
 		return !!(rotation & DRM_MODE_REFLECT_X);
 }
=20
+void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
+				  u32 *color_depths, u32 *color_formats);
 unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc_st);
=20
 int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_dev *=
mdev);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index a7a84e66549d..910d279ae48d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -315,6 +315,8 @@ struct komeda_splitter_state {
 struct komeda_improc {
 	struct komeda_component base;
 	u32 supported_color_formats;  /* DRM_RGB/YUV444/YUV420*/
+	/* the preferred order is from MSB to LSB YUV420 --> RGB444 */
+	u32 preferred_color_formats;
 	u32 supported_color_depths; /* BIT(8) | BIT(10)*/
 	u8 supports_degamma : 1;
 	u8 supports_csc : 1;
@@ -323,6 +325,7 @@ struct komeda_improc {
=20
 struct komeda_improc_state {
 	struct komeda_component_state base;
+	u8 color_format, color_depth;
 	u16 hsize, vsize;
 };
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index ea26bc9c2d00..5526731f5a33 100644
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
@@ -756,6 +757,36 @@ komeda_improc_validate(struct komeda_improc *improc,
 	st->hsize =3D dflow->in_w;
 	st->vsize =3D dflow->in_h;
=20
+	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
+		u32 output_depths, output_formats;
+		u32 avail_depths, avail_formats;
+
+		komeda_crtc_get_color_config(crtc_st, &output_depths,
+					     &output_formats);
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
+		avail_formats =3D output_formats &
+				improc->supported_color_formats &
+				improc->preferred_color_formats;
+		if (avail_formats =3D=3D 0) {
+			DRM_DEBUG_ATOMIC("No available color_formats, conn formats 0x%x & displ=
ay: 0x%x & preferred: 0x%x\n",
+					 output_formats,
+					 improc->supported_color_formats,
+					 improc->preferred_color_formats);
+			return -EINVAL;
+		}
+
+		st->color_depth =3D __fls(avail_depths);
+		st->color_format =3D BIT(__fls(avail_formats));
+	}
+
 	komeda_component_add_input(&st->base, &dflow->input, 0);
 	komeda_component_set_output(&dflow->input, &improc->base, 0);
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 617e1f7b8472..49e5469ba48e 100644
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
@@ -171,6 +172,10 @@ static int komeda_wb_connector_add(struct komeda_kms_d=
ev *kms,
=20
 	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs);
=20
+	info =3D &kwb_conn->base.base.display_info;
+	info->bpc =3D __fls(kcrtc->master->improc->supported_color_depths);
+	info->color_formats =3D kcrtc->master->improc->supported_color_formats;
+
 	kcrtc->wb_conn =3D kwb_conn;
=20
 	return 0;
--=20
2.17.1

