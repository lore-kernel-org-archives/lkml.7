Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1742C388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 04:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93F921855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 04:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IyLXX6vF";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IyLXX6vF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfI3EzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 00:55:14 -0400
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:25987
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbfI3EzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 00:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpK8QoVPwkG2dNMzEgnGMuEmaJOfHjkcn0pIVo7kdrg=;
 b=IyLXX6vFn7bz19n3soGni8pfNpBphGEszKMwbKTkhxq3zEPmXnraaED74gGn00yklRUksq0CC6Z1JRvAcBKQ8ZWTDWp3cPAXSEoizoa3GjlfiufKxoSDZvI+2CgGN/B8JB5JwY4boWg3rb81m3jXrKgqVg4DXdyuTUMhVcP2xhk=
Received: from HE1PR08CA0071.eurprd08.prod.outlook.com (2603:10a6:7:2a::42) by
 AM5PR0801MB1906.eurprd08.prod.outlook.com (2603:10a6:203:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Mon, 30 Sep
 2019 04:55:05 +0000
Received: from VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by HE1PR08CA0071.outlook.office365.com
 (2603:10a6:7:2a::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15 via Frontend
 Transport; Mon, 30 Sep 2019 04:55:05 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT005.mail.protection.outlook.com (10.152.18.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 04:55:03 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Mon, 30 Sep 2019 04:54:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 49372420f580918c
X-CR-MTA-TID: 64aa7808
Received: from 1a833b181f9a.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3E05B2CF-92EB-4741-9304-3812FB11AC36.1;
        Mon, 30 Sep 2019 04:54:50 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1a833b181f9a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 30 Sep 2019 04:54:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXXg5Aj4ydTNg8KZOMRJpf9t3WHJIaLbF1ObLa5fDP7ju6V+vMH/woTnbDyZiC8qDY7GvJ06aUEp5A1o+Oc2TMmnfGD1BRula2uf7zr9gJWw6zuUO5JTGZPRBEa73NN73SZ3bFUoJIJf99RAt7iTPKFuR9Yp9rdSut2jYDgaqaYKonyP/zNr7QyE57mRHjmuEK4DPtrRDM+SzaIh5cxPZexHhBv5sB9QM3uFgAz40H8K4f6oad771IRkCmGhp0Nvnu9FqPdDuE9gVDnmorta0zMX76O53C6f7xhiaUo6/+FfZbscpOlckWXEc5XB6fp9MSJaZZsHqKWXU7Kyjbh1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpK8QoVPwkG2dNMzEgnGMuEmaJOfHjkcn0pIVo7kdrg=;
 b=CQEJ9/b7oyiZJ5hpfFRsQi4ViT4bmcAGCgtk/iWa8Tk/k3RjFNY5NaEkt6PUhFA7WoJJvnSHPCQySyvIofPXxOhdamaSvbvoTWARVhv7yQ8PQvLK21bPfMT5yL8+ey5IcJRtThzgnMvxcnaL9tsKnvz6DqrK/BHNjDBPkHx7JW6/Grtupz9tsj7RRlxVd6kKnXEjTOYM4aQCvMQNlEG9gB6n5tuChJcrQCAZOIEvmCmNzIg9LSYUawmqP5tZU9fSvVtwfH1T4/fxw9duFhEZ6n0JTK9KEQJaeU4tJkIVVq65Qec+kd5c7nFylYqAXpqdtRP2TZ6ygferaA+1DKo7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpK8QoVPwkG2dNMzEgnGMuEmaJOfHjkcn0pIVo7kdrg=;
 b=IyLXX6vFn7bz19n3soGni8pfNpBphGEszKMwbKTkhxq3zEPmXnraaED74gGn00yklRUksq0CC6Z1JRvAcBKQ8ZWTDWp3cPAXSEoizoa3GjlfiufKxoSDZvI+2CgGN/B8JB5JwY4boWg3rb81m3jXrKgqVg4DXdyuTUMhVcP2xhk=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4671.eurprd08.prod.outlook.com (10.255.115.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 04:54:48 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 04:54:48 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
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
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Subject: [PATCH 3/3] drm/komeda: Adds gamma and color-transform support for
 DOU-IPS
Thread-Topic: [PATCH 3/3] drm/komeda: Adds gamma and color-transform support
 for DOU-IPS
Thread-Index: AQHVd0svDPRxDROFCUC/H9BR83IxGw==
Date:   Mon, 30 Sep 2019 04:54:47 +0000
Message-ID: <20190930045408.8053-4-james.qian.wang@arm.com>
References: <20190930045408.8053-1-james.qian.wang@arm.com>
In-Reply-To: <20190930045408.8053-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:202:17::36) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: a1e6e566-1638-4a90-5022-08d745625b1d
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4671:|VE1PR08MB4671:|AM5PR0801MB1906:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB190640D9895C412B1D85F3D2B3820@AM5PR0801MB1906.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2958;OLM:2958;
x-forefront-prvs: 01762B0D64
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(25786009)(52116002)(55236004)(11346002)(50226002)(486006)(6506007)(8676002)(8936002)(6512007)(99286004)(102836004)(6116002)(6486002)(3846002)(1076003)(2906002)(81166006)(5660300002)(86362001)(2616005)(476003)(446003)(386003)(6436002)(76176011)(81156014)(186003)(54906003)(110136005)(26005)(316002)(14454004)(2201001)(478600001)(66066001)(66446008)(64756008)(66556008)(103116003)(66476007)(66946007)(2501003)(4326008)(36756003)(71200400001)(14444005)(7736002)(71190400001)(305945005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4671;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: oqyqqcr56s1qtHTfzZE8GuHOFdkB5o9iP9mUEhbm1ywYUX4XtznzDABwHvy1uDH8KKSJ+oSQKdrAJXnXcVUh1Fma/UxJGLB8XJyFdm7ngtudt2zw2wf84Dw+IywhCsyOC2a2UFOGI9hflpptIiF/pekY4XcEHb7FBJvAb7J3juGPadcjcGXG9rOts8QRTOU9LyeKIDd2U9m3MFNotk6jlU5eyPxc2s0+GtdgqJpiuYUJfIMBxD73vzGcImvywpGMHIkel3VG10VeM4pxYZCCC7zfD5fOnULfdyRoD3nXTSzp+/nqS8GHAdAAU7AnKfRS0u+ksmASecy1jgKmIbqs3QKL3vjc3y3VWo0CQwEcFmunGXT9Yk0eNtXQk5tYdaDtq6jRUNxsiMiN+ZY6QLnFQx/sYqt//jh5u7m6QxJCpTU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4671
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39850400004)(346002)(396003)(136003)(189003)(199004)(76176011)(2906002)(26005)(70586007)(54906003)(6116002)(386003)(6506007)(70206006)(6512007)(102836004)(66066001)(3846002)(47776003)(76130400001)(99286004)(478600001)(26826003)(6486002)(25786009)(14454004)(316002)(110136005)(36906005)(186003)(103116003)(50466002)(81156014)(81166006)(4326008)(14444005)(2201001)(8936002)(486006)(126002)(86362001)(63350400001)(50226002)(22756006)(1076003)(305945005)(8746002)(2501003)(5660300002)(7736002)(8676002)(446003)(11346002)(2616005)(356004)(36756003)(336012)(23756003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1906;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: cf3335d8-2038-4123-9958-08d7456251bd
NoDisclaimer: True
X-Forefront-PRVS: 01762B0D64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAaq9F3LEYv7KcekLWhV480JmUXf0rqnaFaQ1FiJ4qTj/oVOUTR/pq/wnlmJQcXWWezeGTh/5jDWvHLRkXOaEhm77EUy1ZboOj8I5oCatp/drvo6R3YddWKcGwM5k/KNDx9LBSiF2irZ45VGe8iVXU3hSzQRB/EFL0mLXuMspEVoArYmiC5d7JbDDzxgE+gas6N+u2kG3kd0wsleAYVVspdWH+vwu0+kLf0zU70EAr0B0zh8dmb4pEyXfqESL2VBNzaWRSfYRZgYzlD8VpOcJCH7IoCM+OGPDaWWypnQZxkZ19R4UGPcu4VR6hwb0OXJAJOV3o3Y5YNsB3vpnCD7Z982cYU6NgcuImLljjxoc76dejkcuE29v1tYxdySWsnKl90pEXIsLs1mJxCMRP9vA5/uIWguwctcS6ZVoMhEcaA=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 04:55:03.2892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e6e566-1638-4a90-5022-08d745625b1d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1906
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>

Adds gamma and color-transform support for DOU-IPS.
Adds two caps members fgamma_coeffs and ctm_coeffs to komeda_improc_state.
If color management changed, set gamma and color-transform accordingly.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 24 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 ++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +++
 .../display/komeda/komeda_pipeline_state.c    |  6 +++++
 4 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index c3d29c0b051b..e7e5a8e4430e 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -942,15 +942,39 @@ static int d71_merger_init(struct d71_dev *d71,
 static void d71_improc_update(struct komeda_component *c,
 			      struct komeda_component_state *state)
 {
+	struct drm_crtc_state *crtc_st =3D state->crtc->state;
 	struct komeda_improc_state *st =3D to_improc_st(state);
+	struct d71_pipeline *pipe =3D to_d71_pipeline(c->pipeline);
 	u32 __iomem *reg =3D c->reg;
 	u32 index;
+	u32 mask =3D 0, ctrl =3D 0;
=20
 	for_each_changed_input(state, index)
 		malidp_write32(reg, BLK_INPUT_ID0 + index * 4,
 			       to_d71_input_id(state, index));
=20
 	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
+
+	if (crtc_st->color_mgmt_changed) {
+		mask |=3D IPS_CTRL_FT | IPS_CTRL_RGB;
+
+		if (crtc_st->gamma_lut) {
+			malidp_write_group(pipe->dou_ft_coeff_addr, FT_COEFF0,
+					   KOMEDA_N_GAMMA_COEFFS,
+					   st->fgamma_coeffs);
+			ctrl |=3D IPS_CTRL_FT; /* enable gamma */
+		}
+
+		if (crtc_st->ctm) {
+			malidp_write_group(reg, IPS_RGB_RGB_COEFF0,
+					   KOMEDA_N_CTM_COEFFS,
+					   st->ctm_coeffs);
+			ctrl |=3D IPS_CTRL_RGB; /* enable gamut */
+		}
+	}
+
+	if (mask)
+		malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
 }
=20
 static void d71_improc_dump(struct komeda_component *c, struct seq_file *s=
f)
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 9ca5dbfd0723..33f7362dcc6e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -588,6 +588,8 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
=20
 	crtc->port =3D kcrtc->master->of_output_port;
=20
+	drm_crtc_enable_color_mgmt(crtc, 0, true, KOMEDA_COLOR_LUT_SIZE);
+
 	return err;
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 8401cc0cdfe7..21a50e8ce0b7 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -11,6 +11,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include "malidp_utils.h"
+#include "komeda_color_mgmt.h"
=20
 #define KOMEDA_MAX_PIPELINES		2
 #define KOMEDA_PIPELINE_MAX_LAYERS	4
@@ -324,6 +325,8 @@ struct komeda_improc {
 struct komeda_improc_state {
 	struct komeda_component_state base;
 	u16 hsize, vsize;
+	u32 fgamma_coeffs[KOMEDA_N_GAMMA_COEFFS];
+	u32 ctm_coeffs[KOMEDA_N_CTM_COEFFS];
 };
=20
 /* display timing controller */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 0ba9c6aa3708..4a40b37eb1a6 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -756,6 +756,12 @@ komeda_improc_validate(struct komeda_improc *improc,
 	st->hsize =3D dflow->in_w;
 	st->vsize =3D dflow->in_h;
=20
+	if (kcrtc_st->base.color_mgmt_changed) {
+		drm_lut_to_fgamma_coeffs(kcrtc_st->base.gamma_lut,
+					 st->fgamma_coeffs);
+		drm_ctm_to_coeffs(kcrtc_st->base.ctm, st->ctm_coeffs);
+	}
+
 	komeda_component_add_input(&st->base, &dflow->input, 0);
 	komeda_component_set_output(&dflow->input, &improc->base, 0);
=20
--=20
2.20.1

