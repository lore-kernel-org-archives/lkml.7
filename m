Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59B5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FB02196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DGoHfE+h";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DGoHfE+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfKLKk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:40:59 -0500
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:33607
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726964AbfKLKk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TQq3bHNRrYQiNPP2nRVJpod47h6p3GxLvGsKKnTnHo=;
 b=DGoHfE+hYMD4cT2wlzqS2XtmlAGKLxThc/wqMgP3ZqYdAl54CZ4r+IojipD33GDDTD7/WexZF0g7XTRQ9ecijFgbGaI8+3kEb8gKRtG3bJd1CIcEcog7ejVl2oM+XyK5zJ0KhbMXJmWaaKQwuH1OQmra0huQphRM8RnDxWv+Ss4=
Received: from VI1PR08CA0218.eurprd08.prod.outlook.com (2603:10a6:802:15::27)
 by AM5PR0801MB1922.eurprd08.prod.outlook.com (2603:10a6:203:4b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22; Tue, 12 Nov
 2019 10:40:53 +0000
Received: from AM5EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by VI1PR08CA0218.outlook.office365.com
 (2603:10a6:802:15::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.23 via Frontend
 Transport; Tue, 12 Nov 2019 10:40:53 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT030.mail.protection.outlook.com (10.152.16.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Tue, 12 Nov 2019 10:40:53 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Tue, 12 Nov 2019 10:40:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 16091eeb146b9c36
X-CR-MTA-TID: 64aa7808
Received: from a79b2280da58.2 (cr-mta-lb-1.cr-mta-net [104.47.10.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8719C66A-E6A7-461B-A2DA-38CA8FCF4D23.1;
        Tue, 12 Nov 2019 10:40:46 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2053.outbound.protection.outlook.com [104.47.10.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a79b2280da58.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 12 Nov 2019 10:40:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrFuMHW7ZgK2nUdg2qsI8Sq6A//y971CxGSIvdh9+8HHfm1blvIbAPxsKDSEbK2OwkpgEnmlej+wIkfaMhexD4XP92ucO4R6dZxtCNuJE/NMGmOOdhprcEkR4cdU8jr+J3MzanQT+75U842qhcps40H32MusJk4Q+TToYBWrISNPfMl7LiOV00xYBsM9Hwf3H5bGO6RQyWwgN+pWZZ2nrJvAe6B2m8hY5Y4ZaacLjTJWAmmdxap79lFc5utj/FzyNa7uY2h55qZm7Y3uNmTXy1U/r7HjsciNcmi2YHwS7FYNdvkdjteL07FBQoPgm7Nt9bdK9WtqELl2aDpEurT7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TQq3bHNRrYQiNPP2nRVJpod47h6p3GxLvGsKKnTnHo=;
 b=lN73BnBUZv+ZjU9GmObLyFfTMOa+O++A3o/OpizfzB7zum/DHdBuw1vfggVULim4BSD5bZc4AMYZt3j1Hpfba1PQY2itDYotj8z+mwH2FTUSxSUPXm2E9c4dtsenPaFZiwET/qNG/yhBFiaouAtzbquuAbzVCPPAMp5r3bHqH2TdYk8bWKxJHi6npDMuiYqgH3UB4FPf1+BJK83thIyhOCgA8wilTVbukz9LvpM6M4lhQJysxIimT9t+P1jIARcmwgpkNvFhS/yInhv3/1X1fp23ya4xW6tQYDwH2vR63GKXvH4305WN+Lu+P3yF3V6iriZpquk7bq4WhNx2i53uOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TQq3bHNRrYQiNPP2nRVJpod47h6p3GxLvGsKKnTnHo=;
 b=DGoHfE+hYMD4cT2wlzqS2XtmlAGKLxThc/wqMgP3ZqYdAl54CZ4r+IojipD33GDDTD7/WexZF0g7XTRQ9ecijFgbGaI8+3kEb8gKRtG3bJd1CIcEcog7ejVl2oM+XyK5zJ0KhbMXJmWaaKQwuH1OQmra0huQphRM8RnDxWv+Ss4=
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com (10.255.30.207) by
 AM0PR08MB4082.eurprd08.prod.outlook.com (20.178.119.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 12 Nov 2019 10:40:45 +0000
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0]) by AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 10:40:45 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
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
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Subject: [PATCH v9 4/4] drm/komeda: Adds gamma and color-transform support for
 DOU-IPS
Thread-Topic: [PATCH v9 4/4] drm/komeda: Adds gamma and color-transform
 support for DOU-IPS
Thread-Index: AQHVmUWjWKw2oVnDAEWCPL8R/YV3Ug==
Date:   Tue, 12 Nov 2019 10:40:44 +0000
Message-ID: <20191112103956.19074-5-james.qian.wang@arm.com>
References: <20191112103956.19074-1-james.qian.wang@arm.com>
In-Reply-To: <20191112103956.19074-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:203:72::27) To AM0PR08MB4995.eurprd08.prod.outlook.com
 (2603:10a6:208:162::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4871490-f8d9-469e-f089-08d7675ccafe
X-MS-TrafficTypeDiagnostic: AM0PR08MB4082:|AM0PR08MB4082:|AM5PR0801MB1922:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1922E776498E4C2D5D40323AB3770@AM5PR0801MB1922.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2582;OLM:2582;
x-forefront-prvs: 021975AE46
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(199004)(189003)(64756008)(66476007)(66556008)(66946007)(6116002)(66446008)(3846002)(256004)(386003)(8936002)(6506007)(99286004)(2906002)(1076003)(14444005)(102836004)(103116003)(55236004)(4326008)(36756003)(71200400001)(71190400001)(486006)(305945005)(2501003)(76176011)(50226002)(81156014)(81166006)(26005)(8676002)(52116002)(7736002)(186003)(110136005)(54906003)(5660300002)(316002)(86362001)(66066001)(6512007)(478600001)(2616005)(11346002)(446003)(2201001)(6436002)(25786009)(476003)(6486002)(2171002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4082;H:AM0PR08MB4995.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: JVUoa+QCXbQh6WlEr+6RggSotbccpTZmzuLQow8rfBD4g3/sGuHCEYDIdIX3Y5zXqtqimBrZZt5KFY0xWbQHb+UXmvisMLXyyIJ8fBbgfF9BsZxWFDzomM0NxbKTF0JcAAiqETXt4dW7c9FY65e02D8w2FlyO+fsA6eneuCTXJR0vQ9o3oZEyu3InmGGCUF8IeRY9/VOe8tZhnCILkKB9MzUxewIh+fMilgTbi3wUo6Qzq7kv9OQxsSNkF9sTLImzdRdI5c0gBQdAjpFnYhxiQmNdocEMJY69lNO6DmEE6ReHktcdXECIBt7uPvd32xMp20FBV8Mm0Ylt8TN8e7EP5QNwrBjwNlzwFdCuGIJMMh176U4ywBLHn/TftNjvh2s0+xtfK3sf/AWtuqGj8SZdaZitfBVVeZ6itHiw0NDc2cmZ5sFb6o5ZguGM0bd35gH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4082
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT030.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(1110001)(339900001)(189003)(199004)(76176011)(76130400001)(110136005)(2171002)(54906003)(6116002)(3846002)(316002)(36906005)(14444005)(2501003)(6512007)(22756006)(305945005)(5660300002)(47776003)(26826003)(66066001)(103116003)(478600001)(2906002)(14454004)(7736002)(1076003)(50466002)(81156014)(6486002)(86362001)(336012)(26005)(446003)(11346002)(186003)(2201001)(486006)(2616005)(476003)(126002)(6506007)(386003)(102836004)(25786009)(8746002)(356004)(99286004)(70206006)(36756003)(81166006)(8676002)(105606002)(23756003)(8936002)(70586007)(4326008)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1922;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 317e8938-a06e-45a2-a0de-08d7675cc5a6
NoDisclaimer: True
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hU+eAF9ajxrTpsbJUSV849L28wqAlK/ABCp3Hp2QEEjhJO6eYMsJQWocCpfHH04eQA5GrqPBVzEARwqmXc2jOClEgKbtdfoQ4l1AsohBAkkMt0pyj0/VUldRCMMA6im+MEDkcwDfMwXzW4hlddDq0sJY6CFPwMC8jaNRtDs9748Rtl4jqk60g107PpM5a0H9v4cqHOeDanvifoy4ywn8VnqOu5tBIxFHYc3HK3sIByFNVLfDD2aCD0CaUc62e7SWjsMNKEHNrYniKvD95mLGMd23MiV7GHkJzou5G8SLlJiseUuuLyuTyYwe6XLE7QHii7LaevPejAMPCrL5+XwN9mkQPpQ89SFYo6awYVYNYXck2qnNwiQ2Vst0xAL2CbChRQcA3NRhqqQ0N8Exoi00G8S1Pf+A28d2Tr8/zXu8kSDluaHF2l5HKDA4bNKZxeH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 10:40:53.5921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4871490-f8d9-469e-f089-08d7675ccafe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1922
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
Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 20 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 ++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +++
 .../display/komeda/komeda_pipeline_state.c    |  6 ++++++
 4 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index f0ba26e282c3..b6517c46e670 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -1044,7 +1044,9 @@ static int d71_merger_init(struct d71_dev *d71,
 static void d71_improc_update(struct komeda_component *c,
 			      struct komeda_component_state *state)
 {
+	struct drm_crtc_state *crtc_st =3D state->crtc->state;
 	struct komeda_improc_state *st =3D to_improc_st(state);
+	struct d71_pipeline *pipe =3D to_d71_pipeline(c->pipeline);
 	u32 __iomem *reg =3D c->reg;
 	u32 index, mask =3D 0, ctrl =3D 0;
=20
@@ -1055,6 +1057,24 @@ static void d71_improc_update(struct komeda_componen=
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

