Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F7FC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042EA206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WBGtg6tV";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WBGtg6tV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfHME4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 00:56:47 -0400
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:18342
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbfHME4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELGSwsk+zynTLRxU+VJpxB9bM0b/m1S4eaWpwfH4Ip4=;
 b=WBGtg6tVVuqBOBF/YmFxwvY9jftvMPsiqsGlevXouqaaKl3AvhsZaZJ3RcvaISzyJtGMPK2inhebUQWRqIgQHlkIdjBrXmVK5VYwWxvzrc5sDoU+DbFCkmD6IJCIkcTvHU3DN9qYM4bgB2OfcWvxHPgW6CnOVCQ8Y2AFkXh6PJ4=
Received: from VI1PR0802CA0016.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::26) by AM6PR08MB4950.eurprd08.prod.outlook.com
 (2603:10a6:20b:e1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.20; Tue, 13 Aug
 2019 04:56:38 +0000
Received: from DB5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by VI1PR0802CA0016.outlook.office365.com
 (2603:10a6:800:aa::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.13 via Frontend
 Transport; Tue, 13 Aug 2019 04:56:38 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT005.mail.protection.outlook.com (10.152.20.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 13 Aug 2019 04:56:35 +0000
Received: ("Tessian outbound cc8a947d4660:v26"); Tue, 13 Aug 2019 04:56:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f56bfa327bedf641
X-CR-MTA-TID: 64aa7808
Received: from 2d74ace07b8c.2 (cr-mta-lb-1.cr-mta-net [104.47.2.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 600BA60B-36EF-41A6-AFDD-39ACEF0B48F9.1;
        Tue, 13 Aug 2019 04:56:22 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2052.outbound.protection.outlook.com [104.47.2.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2d74ace07b8c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 13 Aug 2019 04:56:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a42k6Ui/tmClTldgVCo07zzS5YDRsChG9pE0DIPR6ZtFeC37kr/mpdc9R0pcAuq2WIYshUYWaJRHB5NCxBBYebjH7vmyFUo9zd2yI8vu6e3qGcAt4EjiWanVUhuWpO0jccjxYV5PXc5jTgg58Fa4uflfiEXiKOMED/zsnJbyCpgt0hfpem095AUWmrafMZKqTOeuD4k78NbdMM+sgXqYn+U8ow4rrzg1+aQopGmZx1U6+CjhUUDgd+UjA2rl2WDrcW3RYEzpwdm1aYKvTCxsnJ3WB4cdkHNvW4YbS5QJVdralp/qrvmxkdxuh9EdsVSo1V4yQrWJrTZPf/KFbpQ+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELGSwsk+zynTLRxU+VJpxB9bM0b/m1S4eaWpwfH4Ip4=;
 b=NOJzEFFyKEIGQiG1M6u+yVDGi+2nL4RqExU4V21dwPiyUo/cwG8c+KCrBK8MMRxAUkF0puvlIO5X0LBAGcWTQYvTvBSdTiA1KtGLptcJ6IzVnAhmdoI3jxJue/M6tJ0gIvC5gzd83dUSpbMirmfWITwmu8guBfyvuLLEaALRekpx9UtB+0ozklvR1TN0e7W3owQwCFj+KheLW2JB5OYR01OYwrM1v5qGE0gF7NJ6fZwTrmUkT0Cv99rsdvc51IQfjOIXqSY6dD31AHbKwyvGTjzH/m1OMLcZS40eNaCF3U4kGuZkbyWqiFYcMr/KjK7VR9aSTnKMEIt3gZCpovWTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELGSwsk+zynTLRxU+VJpxB9bM0b/m1S4eaWpwfH4Ip4=;
 b=WBGtg6tVVuqBOBF/YmFxwvY9jftvMPsiqsGlevXouqaaKl3AvhsZaZJ3RcvaISzyJtGMPK2inhebUQWRqIgQHlkIdjBrXmVK5VYwWxvzrc5sDoU+DbFCkmD6IJCIkcTvHU3DN9qYM4bgB2OfcWvxHPgW6CnOVCQ8Y2AFkXh6PJ4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4752.eurprd08.prod.outlook.com (10.255.112.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Tue, 13 Aug 2019 04:56:20 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 04:56:20 +0000
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 4/4] drm/komeda: Enable Layer color management for komeda
Thread-Topic: [PATCH v2 4/4] drm/komeda: Enable Layer color management for
 komeda
Thread-Index: AQHVUZNyccESoC2zR0ORWyBtwFKZLA==
Date:   Tue, 13 Aug 2019 04:56:19 +0000
Message-ID: <20190813045536.28239-5-james.qian.wang@arm.com>
References: <20190813045536.28239-1-james.qian.wang@arm.com>
In-Reply-To: <20190813045536.28239-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 96ec7a66-7e5d-451c-cc5a-08d71faa9e80
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4752;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4752:|AM6PR08MB4950:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB49505137A72A16E40685C98FB3D20@AM6PR08MB4950.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 01283822F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(50226002)(5660300002)(2201001)(110136005)(26005)(316002)(66066001)(6116002)(3846002)(305945005)(2906002)(7736002)(103116003)(71190400001)(71200400001)(30864003)(8676002)(1076003)(54906003)(446003)(55236004)(66946007)(966005)(478600001)(81156014)(14454004)(386003)(6506007)(4326008)(36756003)(52116002)(2616005)(102836004)(25786009)(256004)(11346002)(14444005)(81166006)(186003)(76176011)(6486002)(64756008)(66556008)(66476007)(99286004)(2501003)(6306002)(6512007)(6436002)(86362001)(66446008)(8936002)(486006)(476003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4752;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: yj+BSqhadMT5kN6q5kM8Pt+I8QngsTmcNLEror4wOZcIzwA+9StMwSVuPH5u378I45rwzYMdb0/qQXI0lfeDMrhPo0MObvtQGVyBA7RSh7ED9aOolNB7w7cEeXu78iEyB9M3nsUnJUEJ8YuSMWY1YUXavkBDLpf9lXJ0GlgmdmZIcmxNRJrlIU+8Njy7haLQBmGzTpyK4IJZRTTz0sorUDi1uL5VCwVPjfqfh/u4qtwWbIQ5hKOAfjdjR4xm6lTQ3o8N6SQT284cbGlpsigYcG8JZvxFqLA2NA66iUXJZmfXx0B1Dxautx5VripaBBBuX5et/rWD/RH5UY3GCBpwNWL7KM3WFF1CVdG/qc8Hk6hmXg9iF2JjGBIMXYrmoxUMYYPT8ht3O7N3pjqbOi8TJRklDt7ztIazJQ3FtM/YeME=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4752
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(2980300002)(189003)(199004)(26826003)(2501003)(1076003)(6512007)(478600001)(336012)(486006)(81156014)(4326008)(81166006)(2906002)(36756003)(14444005)(2201001)(22756006)(50466002)(386003)(63370400001)(446003)(70586007)(6306002)(63350400001)(6486002)(70206006)(6506007)(76176011)(23756003)(86362001)(126002)(5660300002)(2616005)(103116003)(8676002)(99286004)(14454004)(76130400001)(356004)(11346002)(50226002)(316002)(186003)(966005)(47776003)(66066001)(102836004)(8746002)(8936002)(476003)(26005)(25786009)(54906003)(110136005)(7736002)(305945005)(30864003)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4950;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: ec62dfa1-281b-48f6-ec4b-08d71faa94b3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(710020)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR08MB4950;
NoDisclaimer: True
X-Forefront-PRVS: 01283822F8
X-Microsoft-Antispam-Message-Info: qK0MaVLYpwskYlax4mFE2BZXPE7y/jcVKWbvv9en6Tj0fqdR4e4VjVq8Vk42AR2Ud42g8MaqJzEl+t4vLZdoHlKDP1F7y7Llm9gVkswufAgyDvItTD8CZjm7MTqXD9IN8GqPh5VzZC/SAU0Om5pbav8u8GNDyFvLt/4BySLSZ3b7hzQDm7wPvT9x4vAfCA0soZbUlvHvvL0Afd/e/Zn8vDowcMr5aVee2fHuDgkPRqsN+WBR3bNtOgEV3ccEtZngI853ZDWAhqSoKmZQFvBujiRjSGIYXrWYi/GT2e9zX9+V/WyWn1xR/CpHNAjK52HUNOU7D6eb283MRQvKOsY8pbHs7YDcl+0an8ArfAhG2p2Cgz+Z6DYRXrNCv84Y7ZmZgeZK0+mlB7Y1IccHC+SZOiQECIhYxsLVS9BNREJkzSg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 04:56:35.9626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ec7a66-7e5d-451c-cc5a-08d71faa9e80
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4950
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- D71 has 3 global layer gamma table which can be used for all layers as
  gamma lookup table, no matter inverse or forward.
- Add komeda_color_manager/state to layer/layer_state for describe the
  color caps for the specific layer which will be initialized in
  d71_layer_init, and for D71 only layer with L_INFO_CM (color mgmt) bit
  can support forward gamma, and CSC.
- Update komeda-CORE code to validate and convert the plane color state to
  komeda_color_state.
- Enable plane color mgmt according to layer komeda_color_manager

This patch depends on:
- https://patchwork.freedesktop.org/series/30876/

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../arm/display/komeda/d71/d71_component.c    | 64 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  |  5 +-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.h  |  2 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  4 +-
 .../display/komeda/komeda_pipeline_state.c    | 53 ++++++++++++++-
 .../gpu/drm/arm/display/komeda/komeda_plane.c | 12 ++++
 .../arm/display/komeda/komeda_private_obj.c   |  4 ++
 7 files changed, 139 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index 55a8cc94808a..c9c40a36e4d2 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -189,6 +189,46 @@ static void d71_layer_update_fb(struct komeda_componen=
t *c,
 	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
 }
=20
+static u32 d71_layer_update_color(struct drm_plane_state *st,
+				  u32 __iomem *reg,
+				  struct komeda_color_state *color_st,
+				  u32 *mask)
+{
+	struct komeda_coeffs_table *igamma =3D color_st->igamma;
+	struct komeda_coeffs_table *fgamma =3D color_st->fgamma;
+	u32 ctrl =3D 0, v =3D 0;
+
+	if (!st->color_mgmt_changed)
+		return 0;
+
+	*mask |=3D L_IT | L_R2R | L_FT;
+
+	if (igamma) {
+		komeda_coeffs_update(igamma);
+		ctrl |=3D L_IT;
+		v =3D L_ITSEL(igamma->hw_id);
+	}
+
+	if (st->ctm) {
+		u32 ctm_coeffs[KOMEDA_N_CTM_COEFFS];
+
+		drm_ctm_to_coeffs(st->ctm, ctm_coeffs);
+		malidp_write_group(reg, LAYER_RGB_RGB_COEFF0,
+				   ARRAY_SIZE(ctm_coeffs),
+				   ctm_coeffs);
+		ctrl |=3D L_R2R; /* enable RGB2RGB conversion */
+	}
+
+	if (fgamma) {
+		komeda_coeffs_update(fgamma);
+		ctrl |=3D L_FT;
+		v |=3D L_FTSEL(fgamma->hw_id);
+	}
+
+	malidp_write32(reg, LAYER_LT_COEFFTAB, v);
+	return ctrl;
+}
+
 static void d71_layer_disable(struct komeda_component *c)
 {
 	malidp_write32_mask(c->reg, BLK_CONTROL, L_EN, 0);
@@ -261,6 +301,8 @@ static void d71_layer_update(struct komeda_component *c=
,
=20
 	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize, st->vsize));
=20
+	ctrl |=3D d71_layer_update_color(plane_st, reg, &st->color_st, &ctrl_mask=
);
+
 	if (kfb->is_va)
 		ctrl |=3D L_TBU_EN;
 	malidp_write32_mask(reg, BLK_CONTROL, ctrl_mask, ctrl);
@@ -365,6 +407,12 @@ static int d71_layer_init(struct d71_dev *d71,
 	else
 		layer->layer_type =3D KOMEDA_FMT_SIMPLE_LAYER;
=20
+	layer->color_mgr.igamma_mgr =3D d71->glb_lt_mgr;
+	if (layer_info & L_INFO_CM) {
+		layer->color_mgr.has_ctm =3D true;
+		layer->color_mgr.fgamma_mgr =3D d71->glb_lt_mgr;
+	}
+
 	set_range(&layer->hsize_in, 4, d71->max_line_size);
 	set_range(&layer->vsize_in, 4, d71->max_vsize);
=20
@@ -1140,6 +1188,21 @@ static int d71_timing_ctrlr_init(struct d71_dev *d71=
,
 	return 0;
 }
=20
+static void d71_gamma_update(struct komeda_coeffs_table *table)
+{
+	malidp_write_group(table->reg, GLB_LT_COEFF_DATA,
+			   GLB_LT_COEFF_NUM, table->coeffs);
+}
+
+static int d71_lt_coeff_init(struct d71_dev *d71,
+			     struct block_header *blk, u32 __iomem *reg)
+{
+	struct komeda_coeffs_manager *mgr =3D d71->glb_lt_mgr;
+	int hw_id =3D BLOCK_INFO_TYPE_ID(blk->block_info);
+
+	return komeda_coeffs_add(mgr, hw_id, reg, d71_gamma_update);
+}
+
 int d71_probe_block(struct d71_dev *d71,
 		    struct block_header *blk, u32 __iomem *reg)
 {
@@ -1202,6 +1265,7 @@ int d71_probe_block(struct d71_dev *d71,
 		break;
=20
 	case D71_BLK_TYPE_GLB_LT_COEFF:
+		err =3D d71_lt_coeff_init(d71, blk, reg);
 		break;
=20
 	case D71_BLK_TYPE_GLB_SCL_COEFF:
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index d567ab7ed314..edd5d7c7f2a2 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -341,7 +341,7 @@ static int d71_enum_resources(struct komeda_dev *mdev)
 	struct komeda_pipeline *pipe;
 	struct block_header blk;
 	u32 __iomem *blk_base;
-	u32 i, value, offset;
+	u32 i, value, offset, coeffs_size;
 	int err;
=20
 	d71 =3D devm_kzalloc(mdev->dev, sizeof(*d71), GFP_KERNEL);
@@ -398,6 +398,9 @@ static int d71_enum_resources(struct komeda_dev *mdev)
 		d71->pipes[i] =3D to_d71_pipeline(pipe);
 	}
=20
+	coeffs_size =3D GLB_LT_COEFF_NUM * sizeof(u32);
+	d71->glb_lt_mgr =3D komeda_coeffs_create_manager(coeffs_size);
+
 	/* loop the register blks and probe */
 	i =3D 2; /* exclude GCU and PERIPH */
 	offset =3D D71_BLOCK_SIZE; /* skip GCU */
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.h
index 84f1878b647d..009c164a1584 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
@@ -39,6 +39,8 @@ struct d71_dev {
 	u32 __iomem	*periph_addr;
=20
 	struct d71_pipeline *pipes[D71_MAX_PIPELINE];
+	 /* global layer transform coefficient table manager */
+	struct komeda_coeffs_manager *glb_lt_mgr;
 };
=20
 #define to_d71_pipeline(x)	container_of(x, struct d71_pipeline, base)
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index a7a84e66549d..4104c81e5032 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include "komeda_color_mgmt.h"
 #include "malidp_utils.h"
=20
 #define KOMEDA_MAX_PIPELINES		2
@@ -226,6 +227,7 @@ struct komeda_layer {
 	struct komeda_component base;
 	/* accepted h/v input range before rotation */
 	struct malidp_range hsize_in, vsize_in;
+	struct komeda_color_manager color_mgr;
 	u32 layer_type; /* RICH, SIMPLE or WB */
 	u32 supported_rots;
 	/* komeda supports layer split which splits a whole image to two parts
@@ -238,7 +240,7 @@ struct komeda_layer {
=20
 struct komeda_layer_state {
 	struct komeda_component_state base;
-	/* layer specific configuration state */
+	struct komeda_color_state color_st;
 	u16 hsize, vsize;
 	u32 rot;
 	u16 afbc_crop_l;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index ea26bc9c2d00..803715c1128e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -95,6 +95,21 @@ komeda_pipeline_get_state_and_set_crtc(struct komeda_pip=
eline *pipe,
 	return st;
 }
=20
+static bool komeda_component_is_new_active(struct komeda_component *c,
+					   struct drm_atomic_state *state)
+{
+	struct komeda_pipeline_state *ppl_old_st;
+
+	ppl_old_st =3D komeda_pipeline_get_old_state(c->pipeline, state);
+	if (IS_ERR(ppl_old_st))
+		return true;
+
+	if (has_bit(c->id, ppl_old_st->active_comps))
+		return false;
+
+	return true;
+}
+
 static struct komeda_component_state *
 komeda_component_get_state(struct komeda_component *c,
 			   struct drm_atomic_state *state)
@@ -279,6 +294,29 @@ komeda_rotate_data_flow(struct komeda_data_flow_cfg *d=
flow, u32 rot)
 	}
 }
=20
+static int
+komeda_validate_plane_color(struct komeda_component *c,
+			    struct komeda_color_manager *color_mgr,
+			    struct komeda_color_state *color_st,
+			    struct drm_plane_state *plane_st)
+{
+	int err;
+
+	if (komeda_component_is_new_active(c, plane_st->state))
+		plane_st->color_mgmt_changed =3D true;
+
+	if (!plane_st->color_mgmt_changed)
+		return 0;
+
+	err =3D komeda_color_validate(color_mgr, color_st,
+				    plane_st->degamma_lut,
+				    plane_st->gamma_lut);
+	if (err)
+		DRM_DEBUG_ATOMIC("%s validate color failed.\n", c->name);
+
+	return err;
+}
+
 static int
 komeda_layer_check_cfg(struct komeda_layer *layer,
 		       struct komeda_fb *kfb,
@@ -362,6 +400,11 @@ komeda_layer_validate(struct komeda_layer *layer,
 		st->addr[i] =3D komeda_fb_get_pixel_addr(kfb, dflow->in_x,
 						       dflow->in_y, i);
=20
+	err =3D komeda_validate_plane_color(&layer->base, &layer->color_mgr,
+					  &st->color_st, plane_st);
+	if (err)
+		return err;
+
 	err =3D komeda_component_validate_private(&layer->base, c_st);
 	if (err)
 		return err;
@@ -1177,7 +1220,7 @@ komeda_pipeline_unbound_components(struct komeda_pipe=
line *pipe,
 {
 	struct drm_atomic_state *drm_st =3D new->obj.state;
 	struct komeda_pipeline_state *old =3D priv_to_pipe_st(pipe->obj.state);
-	struct komeda_component_state *c_st;
+	struct komeda_component_state *st;
 	struct komeda_component *c;
 	u32 disabling_comps, id;
=20
@@ -1188,9 +1231,13 @@ komeda_pipeline_unbound_components(struct komeda_pip=
eline *pipe,
 	/* unbound all disabling component */
 	dp_for_each_set_bit(id, disabling_comps) {
 		c =3D komeda_pipeline_get_component(pipe, id);
-		c_st =3D komeda_component_get_state_and_set_user(c,
+		st =3D komeda_component_get_state_and_set_user(c,
 				drm_st, NULL, new->crtc);
-		WARN_ON(IS_ERR(c_st));
+
+		WARN_ON(IS_ERR(st));
+
+		if (has_bit(id, KOMEDA_PIPELINE_LAYERS))
+			komeda_color_cleanup_state(&to_layer_st(st)->color_st);
 	}
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_plane.c
index 98e915e325dd..69fa1dea41c9 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -11,6 +11,7 @@
 #include "komeda_dev.h"
 #include "komeda_kms.h"
 #include "komeda_framebuffer.h"
+#include "komeda_color_mgmt.h"
=20
 static int
 komeda_plane_init_data_flow(struct drm_plane_state *st,
@@ -250,6 +251,7 @@ static int komeda_plane_add(struct komeda_kms_dev *kms,
 {
 	struct komeda_dev *mdev =3D kms->base.dev_private;
 	struct komeda_component *c =3D &layer->base;
+	struct komeda_color_manager *color_mgr;
 	struct komeda_plane *kplane;
 	struct drm_plane *plane;
 	u32 *formats, n_formats =3D 0;
@@ -306,6 +308,16 @@ static int komeda_plane_add(struct komeda_kms_dev *kms=
,
 	if (err)
 		goto cleanup;
=20
+	err =3D drm_plane_color_create_prop(plane->dev, plane);
+	if (err)
+		goto cleanup;
+
+	color_mgr =3D &layer->color_mgr;
+	drm_plane_enable_color_mgmt(plane,
+			color_mgr->igamma_mgr ? KOMEDA_COLOR_LUT_SIZE : 0,
+			color_mgr->has_ctm,
+			color_mgr->fgamma_mgr ? KOMEDA_COLOR_LUT_SIZE : 0);
+
 	err =3D drm_plane_create_zpos_property(plane, layer->base.id, 0, 8);
 	if (err)
 		goto cleanup;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_private_obj.c
index 914400c4af73..4c474663f554 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
@@ -19,12 +19,15 @@ komeda_component_state_reset(struct komeda_component_st=
ate *st)
 static struct drm_private_state *
 komeda_layer_atomic_duplicate_state(struct drm_private_obj *obj)
 {
+	struct komeda_layer_state *old =3D to_layer_st(priv_to_comp_st(obj->state=
));
 	struct komeda_layer_state *st;
=20
 	st =3D kmemdup(obj->state, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return NULL;
=20
+	komeda_color_duplicate_state(&st->color_st, &old->color_st);
+
 	komeda_component_state_reset(&st->base);
 	__drm_atomic_helper_private_obj_duplicate_state(obj, &st->base.obj);
=20
@@ -37,6 +40,7 @@ komeda_layer_atomic_destroy_state(struct drm_private_obj =
*obj,
 {
 	struct komeda_layer_state *st =3D to_layer_st(priv_to_comp_st(state));
=20
+	komeda_color_cleanup_state(&st->color_st);
 	kfree(st);
 }
=20
--=20
2.20.1

