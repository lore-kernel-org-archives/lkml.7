Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48446CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0F021872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="u0Vxxxn1";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="u0Vxxxn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389545AbfJWGna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:43:30 -0400
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:36078
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbfJWGna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TQq3bHNRrYQiNPP2nRVJpod47h6p3GxLvGsKKnTnHo=;
 b=u0Vxxxn19sEdzZ575YT13vQ6Fo+s4PIqdft6DWrL65FMiFFGAG+SnGMPqcByiQIvuobVl63i9HDFfDpy/BVMdG/d8L5Oz9L2v/GnvHAR/YX0xV7yLfadxr/P3/CxKLmBM7yq1IfmF6JxUfhlXVVKPIR+WV/rRBwBjf5+RVCL8v8=
Received: from VI1PR08CA0214.eurprd08.prod.outlook.com (2603:10a6:802:15::23)
 by AM4PR08MB2674.eurprd08.prod.outlook.com (2603:10a6:205:a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.19; Wed, 23 Oct
 2019 06:43:25 +0000
Received: from AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by VI1PR08CA0214.outlook.office365.com
 (2603:10a6:802:15::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20 via Frontend
 Transport; Wed, 23 Oct 2019 06:43:25 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT021.mail.protection.outlook.com (10.152.16.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2367.23 via Frontend Transport; Wed, 23 Oct 2019 06:43:25 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Wed, 23 Oct 2019 06:43:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 694ce0f428c59884
X-CR-MTA-TID: 64aa7808
Received: from 7a56dd4b3f30.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D311E4CE-2C2D-4326-9E18-76F81C9B48E4.1;
        Wed, 23 Oct 2019 06:43:18 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7a56dd4b3f30.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 23 Oct 2019 06:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rh6O9JCL0bFJYusmLKOQntTNngI2cXSQUmBnoAHcKa3Al2j28pRAhmOQZ2UzntBGnHszU2mUUtx5xBrNA/J8qh1vWiTL/TZnUPxBf0Xo3ZOm5bG/USSbX4Ib7V6LrwVHzwK6E1IQDD0KXVMqRYIttuyxO2K3+SQbyCbrBgG2WRMwPtwQzIAceDu7Za0vZD03TwR/IG/3jylwKgNL2/zAsFBCoRIyKOpBrquYbTyheRFl5KNZuTtl0DnA5G2MXkI/BsX15tF5DXeINUz4L1WE/cez0QQywmI9VO+DYriW2DYt7aBrmRU7v3Awvjc6xmIEA2dz/mIg8O/BQn5ieutJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TQq3bHNRrYQiNPP2nRVJpod47h6p3GxLvGsKKnTnHo=;
 b=MG8PsjMd2TzJntkTevOXT36eUd0sHiyS5NnrKmhY1R1EErMKtEIF3Hct2blolrZm884Z+8n+A5QY/wXRLNURoRtDDDjeCthEdhA0aTMNFdJVlK+7n3JuN2DYm7Xpws6T2H5X2Nz+rTzVpTXFULG8Hl/s9amP9CGbWQrXAu9RH4bXBkJwgc44rWh2QXGaWEXfP/boxHWkp6blSQ/LF8+7etB5YQrDlUi4z8qc8Z8fIOAmjfHeAstpQn0gqB9XqssdFzo85GQ3/FkTSaq/Ni5v14INPnBvIPxw40tPO0uwYrys/dsNcxcOQjkGdHMfvGrAlb6+mn8GuNRZ//d3Fwke1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TQq3bHNRrYQiNPP2nRVJpod47h6p3GxLvGsKKnTnHo=;
 b=u0Vxxxn19sEdzZ575YT13vQ6Fo+s4PIqdft6DWrL65FMiFFGAG+SnGMPqcByiQIvuobVl63i9HDFfDpy/BVMdG/d8L5Oz9L2v/GnvHAR/YX0xV7yLfadxr/P3/CxKLmBM7yq1IfmF6JxUfhlXVVKPIR+WV/rRBwBjf5+RVCL8v8=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4672.eurprd08.prod.outlook.com (10.255.112.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Wed, 23 Oct 2019 06:43:17 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 06:43:17 +0000
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
Subject: [PATCH v7 4/4] drm/komeda: Adds gamma and color-transform support for
 DOU-IPS
Thread-Topic: [PATCH v7 4/4] drm/komeda: Adds gamma and color-transform
 support for DOU-IPS
Thread-Index: AQHViW0mF05EqmyI+keSzxdB9PsPEA==
Date:   Wed, 23 Oct 2019 06:43:16 +0000
Message-ID: <20191023064226.10969-5-james.qian.wang@arm.com>
References: <20191023064226.10969-1-james.qian.wang@arm.com>
In-Reply-To: <20191023064226.10969-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec884376-af95-4e27-7016-08d757844e0c
X-MS-TrafficTypeDiagnostic: VE1PR08MB4672:|VE1PR08MB4672:|AM4PR08MB2674:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM4PR08MB2674B0EA22C6235C7BE3BD83B36B0@AM4PR08MB2674.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2582;OLM:2582;
x-forefront-prvs: 019919A9E4
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(7736002)(25786009)(2906002)(386003)(71200400001)(4326008)(36756003)(305945005)(6506007)(66066001)(2201001)(71190400001)(102836004)(5660300002)(26005)(478600001)(52116002)(14444005)(55236004)(316002)(86362001)(186003)(6116002)(76176011)(3846002)(256004)(2171002)(66446008)(66946007)(103116003)(64756008)(6512007)(1076003)(66556008)(50226002)(66476007)(476003)(6436002)(8936002)(446003)(2501003)(11346002)(2616005)(6486002)(14454004)(486006)(54906003)(99286004)(81166006)(8676002)(81156014)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4672;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fr4sq5cyeDTqUyanruBlqcfjFbzp+rl5EPRQIcJtfKkD3L9k8Jy2fHsHAvN36ut3U8Nhf2SDhbDOTJCpqHOkkuY4u7exGsNS/J6zbGfUMXZfM/XNxrzP2eUBy+4QcyvaznW6IgFFJcNU3pAGQqZZsy4QwBl09gqML31+eeroGQQDDsNabuzQhFYpN09fT6i+GdI0LtS6VagiAUcx8mnx7Goaa/qdS9Zrb5w3N5WkQrmAxSYIwRm+BjouO55tZXYRBPxUInY3hSmjg1FDQg3Ilx2FYV145I7ulaP0kOBbyvURA68EdN7MDIpKpYnavuz18eUcTWHOKgHOuVxBWRqF1DZjh2Qbke/mXhuWAK8UWYKdMlXiO/qdpCP4uvfqUOB42ZGnLbZAjhPrCY7RNpgkwdM9NEmxUfo3bFT317LUvE4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(1110001)(339900001)(189003)(199004)(81156014)(81166006)(102836004)(86362001)(50466002)(8676002)(386003)(76176011)(1076003)(103116003)(305945005)(6506007)(4326008)(26826003)(14454004)(36756003)(76130400001)(2171002)(99286004)(356004)(105606002)(22756006)(3846002)(6116002)(47776003)(478600001)(6512007)(2501003)(446003)(8936002)(8746002)(50226002)(14444005)(2616005)(11346002)(336012)(126002)(476003)(25786009)(7736002)(6486002)(66066001)(316002)(2201001)(26005)(486006)(70586007)(70206006)(36906005)(5660300002)(2906002)(110136005)(186003)(54906003)(23756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR08MB2674;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: fdc9e2a7-bc07-41eb-ac1c-08d7578448e9
NoDisclaimer: True
X-Forefront-PRVS: 019919A9E4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zV2m7LUwG8cmWARZvfKWhpYI1bFbvZuGblzqLUH58m2dbZMWHhsRr58OPEO2CIwxjzlwwLmNV/nZI0DnWJ0gUDfjqMH1hYlDHsv3rTM7feeD7jgDVftMVoM/s6MuaUjufbZ0/YwnoAayKcIMyqhAnbHngkMH6kQVwnL2qx1gM8WIZBwjTAbVJJjuJc6A6v8ks1lx8A951Wq15qycorrVeEHdR7SdhH271SL8VIlpjN5twuajrRoiNf/73hJVALymIwdT2T7Dzs61H/S45yUPM+RGqCOsoiPkbUJR8klvewu0WEHfZZisEbdR5Kah8FNbbiMatAFnX/UiLyvmTJRURU4/VupS9sJmN4u01a1ypQb8rGyHU43r2JCm2aihmn+77peoZqEyNy2i+H1cTnl/Jlsv0RpjrtVAY41y6jn9Q2g+tFRrhODITFhDt38RqY8l
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2019 06:43:25.2391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec884376-af95-4e27-7016-08d757844e0c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2674
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

