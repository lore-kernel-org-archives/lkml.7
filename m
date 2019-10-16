Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6B4FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30A021928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="v6LlkbKr";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="v6LlkbKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404659AbfJPKex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:34:53 -0400
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:63106
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392462AbfJPKew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTLIBaRIXBywulqqapRfWZZE7ga1kAVvsh5MVHvOcGM=;
 b=v6LlkbKrB0oh022g70bFJsEIE2XHwbYRLPWUSHmTECKpbdGwFv28zaSIxIXh8C5YccpuypsBQhJiHXCEDBeywE3PAqflPkktKsHM5fqL1LTX5I7C90PZi0ukCpkfR8yHL6Vc/ggnrOJYxaZ9tHHh/g1/BFSzXybo+lXA8zDZ6S4=
Received: from HE1PR08CA0044.eurprd08.prod.outlook.com (2603:10a6:7:2a::15) by
 VI1PR0801MB1743.eurprd08.prod.outlook.com (2603:10a6:800:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Wed, 16 Oct
 2019 10:34:47 +0000
Received: from DB5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by HE1PR08CA0044.outlook.office365.com
 (2603:10a6:7:2a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 16 Oct 2019 10:34:46 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT058.mail.protection.outlook.com (10.152.20.255) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 10:34:45 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Wed, 16 Oct 2019 10:34:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ed6632e7ef1f2c9e
X-CR-MTA-TID: 64aa7808
Received: from cc6315660be6.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 647D6AB5-3CFD-4314-A2A5-1A5B8AF87251.1;
        Wed, 16 Oct 2019 10:34:35 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cc6315660be6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Oct 2019 10:34:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwUverQXsU/W89UymcmONmasOsobpum6QDoN7kgFJvnXYvFG21DMQhFzFGEOPOzIy8ym7MTZZgRTAk3Dp6v/SRO1P4lIDdeZLrO4RIDC9DJjke8Vo0/VtPIUwJWozU9i0D/lEu1Sa8qyrdB161Y5z+7lxPPAKWQTPax8tySwcAUFbB2VoD3ifJlB2m6KfKCxdlh4rxOcO7UU6TJvaRaw52oczyCDGVaj58t6i80DPz80vz/5v8lqO4bEt19VpMJO5CR3jnX3HOY2r3gzNoXQP0HBdhHKT9ukCLQ1HGxSVqtk+85jdRNMv6ojnEPTn7Icjpp0SZhmFEKD4tEVAL+uMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTLIBaRIXBywulqqapRfWZZE7ga1kAVvsh5MVHvOcGM=;
 b=YyicKbbcNMX1Gk29GMsgNBK+baTKuBo6HFM4BMZKHmv1PJNa0CERXkVmbDliMMKHtYnzNEQsueF0gEgIZXMr/6YX/1LhhtyXAJIxlBuQ2sRtKeXQScBuAbANGhXKtlHpAys1J5V9rmC3tS3ThRnxuJ0qykoSRjShM6Y7xe4HhHTs1+5xaYsBrvX9+QfzE5eS8L5YIslkJWBs1dzYmQ/oLDnP6Gq74pMDxQQWzf5zo8sGWpdmtKmM7PLSKseK84xJF7C56tqXhkuMbD7jzMrT4PWDLkHIssW5md5tQrmJnJZ1BB4CteSUrD7S9f6Ru0ubfV+gXkrG4YTQJYKGlBA3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTLIBaRIXBywulqqapRfWZZE7ga1kAVvsh5MVHvOcGM=;
 b=v6LlkbKrB0oh022g70bFJsEIE2XHwbYRLPWUSHmTECKpbdGwFv28zaSIxIXh8C5YccpuypsBQhJiHXCEDBeywE3PAqflPkktKsHM5fqL1LTX5I7C90PZi0ukCpkfR8yHL6Vc/ggnrOJYxaZ9tHHh/g1/BFSzXybo+lXA8zDZ6S4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5152.eurprd08.prod.outlook.com (20.179.30.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 16 Oct 2019 10:34:30 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 10:34:30 +0000
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
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Subject: [PATCH v5 4/4] drm/komeda: Adds gamma and color-transform support for
 DOU-IPS
Thread-Topic: [PATCH v5 4/4] drm/komeda: Adds gamma and color-transform
 support for DOU-IPS
Thread-Index: AQHVhA1KKjv8+ZR4kki+4DzZfnBljg==
Date:   Wed, 16 Oct 2019 10:34:30 +0000
Message-ID: <20191016103339.25858-5-james.qian.wang@arm.com>
References: <20191016103339.25858-1-james.qian.wang@arm.com>
In-Reply-To: <20191016103339.25858-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8dd0fa02-d450-4281-1b74-08d752247643
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5152:|VE1PR08MB5152:|VI1PR0801MB1743:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1743B866E46981440D6E114FB3920@VI1PR0801MB1743.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2582;OLM:2582;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(189003)(199004)(6506007)(4326008)(2171002)(25786009)(478600001)(66066001)(99286004)(103116003)(76176011)(52116002)(71190400001)(64756008)(71200400001)(256004)(14444005)(66446008)(66476007)(36756003)(66946007)(14454004)(66556008)(8936002)(50226002)(8676002)(386003)(81166006)(81156014)(486006)(26005)(2501003)(186003)(55236004)(2906002)(5660300002)(110136005)(1076003)(305945005)(446003)(2201001)(6486002)(6436002)(11346002)(476003)(6512007)(316002)(6116002)(3846002)(102836004)(54906003)(86362001)(2616005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5152;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: aqLUHqH8Rkexwy/Q+geqpVkYcQCqBlQTlXgJ8kQMtQMwXvmIt93V4vwTGHpzJflQer9pVaAhLXq2ygVREDd+QkdwNdSXgHSk4pItPHhfztur42YsS5hidsnQd9aIETBR2Gngwe95/2OIyk1G6DKsGlQWDVdHvXTj7MH7/86PNQ844wSwkCzDbzCbobBXHVMHk3cQmlk5/nStZcL3NICfc9bSwEul8EDWhFOB90jvwHmxL7eNGlYt4H+99K82fMECccQ9afyep+hKA0pDZ1XOgClSvcUJ2Q4k4KUF7cDUerCwQCjtKBZnnc33TxFLRGjyzMvMi7jvlcSU4yoQHfBXcC7a7sK7rrgR66DTdYf/ihMuKbhAueBgKS6LbDd31vn0+iJBkoC2OK2carzC/8+aIM8cc/tHETBR3JmuAhMNJy4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5152
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(189003)(199004)(5660300002)(2201001)(50466002)(8676002)(4326008)(14454004)(36756003)(26005)(70586007)(102836004)(26826003)(25786009)(478600001)(76130400001)(23756003)(86362001)(22756006)(1076003)(486006)(110136005)(103116003)(66066001)(336012)(2906002)(54906003)(63350400001)(2171002)(7736002)(11346002)(126002)(47776003)(476003)(2616005)(446003)(316002)(50226002)(6116002)(356004)(14444005)(2501003)(386003)(6506007)(76176011)(186003)(70206006)(99286004)(305945005)(6486002)(8746002)(3846002)(81166006)(6512007)(8936002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1743;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4e9eaf6b-3e12-4541-972e-08d752246d1a
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHWVjJFtxR2SVj/BFHc7r96K/ZSURHn0xs1oKDXaXs4Sz9TypsNggDoEqwX9KF2c07/CybRbJEeb9PrX8U5HhXXmt9dAsk7sd3/oLT/fwpLxmFBiw520OR+f1GfQIzvXsvr2sOPFgJcI6xTOxBraTDRhgssjxr6mSgxAG5VyAq+xhe4OIElsTPZtQrnF4wZ7nINPV6Op+KS0DjMwGQCtwJ9q1+yIrOWGbH11UcT9xsZbCQzjudMvBssrQvB4W6frfrH7z+b1Fia/y3VreDjaLVlffNTUdwxODwWStp4Q4OEkz/m8xlbF/jzvuGkxbrUHlNww/GrYaLL+M1OduJRie6cwtak7GB7KoeLyJoL7UHfF5I2fpsqYugnEeVfP/LBJGJRIb9W5mTzgsvnDM8QfkvOudV/Zk1o53oPTJmiRT8k=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 10:34:45.2103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd0fa02-d450-4281-1b74-08d752247643
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1743
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>

Adds gamma and color-transform support for DOU-IPS.
Adds two caps members fgamma_coeffs and ctm_coeffs to komeda_improc_state.
If color management changed, set gamma and color-transform accordingly.

v5: Rebase with drm-misc-next

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 20 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 ++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +++
 .../display/komeda/komeda_pipeline_state.c    |  6 ++++++
 4 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index 6740b8422f11..63a1b6f9cbba 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -1032,7 +1032,9 @@ static int d71_merger_init(struct d71_dev *d71,
 static void d71_improc_update(struct komeda_component *c,
 			      struct komeda_component_state *state)
 {
+	struct drm_crtc_state *crtc_st =3D state->crtc->state;
 	struct komeda_improc_state *st =3D to_improc_st(state);
+	struct d71_pipeline *pipe =3D to_d71_pipeline(c->pipeline);
 	u32 __iomem *reg =3D c->reg;
 	u32 index, mask =3D 0, ctrl =3D 0;
=20
@@ -1043,6 +1045,24 @@ static void d71_improc_update(struct komeda_componen=
t *c,
 	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
 	malidp_write32(reg, IPS_DEPTH, st->color_depth);
=20
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
 	mask |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422 | IPS_CTRL_CHD420;
=20
 	/* config color format */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 252015210fbc..1c452ea75999 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -617,6 +617,8 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
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
index bd6ca7c87037..ac8725e24853 100644
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
@@ -327,6 +328,8 @@ struct komeda_improc_state {
 	struct komeda_component_state base;
 	u8 color_format, color_depth;
 	u16 hsize, vsize;
+	u32 fgamma_coeffs[KOMEDA_N_GAMMA_COEFFS];
+	u32 ctm_coeffs[KOMEDA_N_CTM_COEFFS];
 };
=20
 /* display timing controller */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 42bdc63dcffa..0930234abb9d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -802,6 +802,12 @@ komeda_improc_validate(struct komeda_improc *improc,
 		st->color_format =3D BIT(__ffs(avail_formats));
 	}
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

