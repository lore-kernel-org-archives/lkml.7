Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA053C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A390D214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZWvf4Mmu";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZWvf4Mmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfJKFqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:46:06 -0400
Received: from mail-eopbgr30058.outbound.protection.outlook.com ([40.107.3.58]:42497
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfJKFqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIUGSIoTFS+rG3rkaZCUgjh5FrULV5M3gll9vYVFpDA=;
 b=ZWvf4MmuGN72hP4mmwV/VrCiLkamrDatG4jOGGCYg3+1DWSa55DHdkXjWXBO5Lf1U6WEEk/OBQvD+HzI7M3i+uZM0F52gq406RfecpLZtVejF4jPPEv/Af4vDh7TezCEzCT9v/U5pogJm+b/GUMPCFPrGGvPVFk/6hkp5iQAGJw=
Received: from VI1PR0802CA0022.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::32) by VI1PR0802MB2302.eurprd08.prod.outlook.com
 (2603:10a6:800:9e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 11 Oct
 2019 05:45:59 +0000
Received: from VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by VI1PR0802CA0022.outlook.office365.com
 (2603:10a6:800:aa::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 11 Oct 2019 05:45:59 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT062.mail.protection.outlook.com (10.152.18.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 05:45:57 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Fri, 11 Oct 2019 05:45:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c3e3ec89d654538e
X-CR-MTA-TID: 64aa7808
Received: from c5a225462778.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DAF63611-CBC2-4757-98F0-1FDD967470A0.1;
        Fri, 11 Oct 2019 05:45:52 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c5a225462778.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Oct 2019 05:45:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLLoUWN/Dg0zazjSXSt+Y8Zb9dmHpnsIZaM5GOT2cO64KTkAxJMAagXweyQZFzYObWhTDwcmI2/vnecvpR6UnlMCMwAiWzHb1SzvVKKC1tPSut83VkGfXWQSDblAfBU9V+9MXX1dZlqA8AiNUtzvxj3BGBtnIyojNexVGRQDwcogWEaVptRTsVtVx6zX9GdUIx7pgPvfOx6PRopBhaGAGofo+/y9sQ9J5zzbzZgxITVCj23oURtRxTGV2oF7YNpT3AuefPyXPUTDYAbSyG27sa4+KPwYQ3wgQGTIzfFQA00kgOYdOFK8iiDmKW5X0UmPmpyovhSQ+919swy/aLGpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIUGSIoTFS+rG3rkaZCUgjh5FrULV5M3gll9vYVFpDA=;
 b=FuJdvaLExOfd2N4CZZ8qRY+/1qcem1D6j/mi5OWfSkQ+CD1pYEhggUD42Qt3AC4yqtCACgJAfWS2BhETucpkm9OTVlqa982fMTmZ8xfaDR652tcfNVMdKK7XpeNz/Ip6Him24RgYi4zoX3EzfnLhiIlH2GIWWwRahxN44hSIijChLWvM4Y/emp/uA021JPurdZWSqWXPmOivEFhf3Dd5VnfVZcug0bPZnPOlZrbB7hV3ATBhzg26O5os1z4Ua6mGUcdM1Ve4n6rIrbi8jvphfE/C6hdHg4d+d1Zwa1CaN9bKqR5WTlCSStLsKfVG8de1h53m6jEmDCf/AbFzRHRqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIUGSIoTFS+rG3rkaZCUgjh5FrULV5M3gll9vYVFpDA=;
 b=ZWvf4MmuGN72hP4mmwV/VrCiLkamrDatG4jOGGCYg3+1DWSa55DHdkXjWXBO5Lf1U6WEEk/OBQvD+HzI7M3i+uZM0F52gq406RfecpLZtVejF4jPPEv/Af4vDh7TezCEzCT9v/U5pogJm+b/GUMPCFPrGGvPVFk/6hkp5iQAGJw=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5262.eurprd08.prod.outlook.com (20.179.31.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 05:45:50 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 05:45:50 +0000
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
Subject: [PATCH v2 4/4] drm/komeda: Adds gamma and color-transform support for
 DOU-IPS
Thread-Topic: [PATCH v2 4/4] drm/komeda: Adds gamma and color-transform
 support for DOU-IPS
Thread-Index: AQHVf/cjoruYXL2LUkqKp6fLHl28hQ==
Date:   Fri, 11 Oct 2019 05:45:50 +0000
Message-ID: <20191011054459.17984-5-james.qian.wang@arm.com>
References: <20191011054459.17984-1-james.qian.wang@arm.com>
In-Reply-To: <20191011054459.17984-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:203:2e::23) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 84d73b40-c40f-4f3f-ff16-08d74e0e4a65
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5262:|VE1PR08MB5262:|VI1PR0802MB2302:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB230251DB24F968FD09F30EEEB3970@VI1PR0802MB2302.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2958;OLM:2958;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(14454004)(3846002)(81156014)(110136005)(54906003)(76176011)(52116002)(36756003)(2616005)(6116002)(11346002)(476003)(446003)(2201001)(25786009)(50226002)(99286004)(1076003)(8936002)(66066001)(81166006)(386003)(26005)(6506007)(102836004)(8676002)(316002)(4326008)(186003)(55236004)(5660300002)(305945005)(66476007)(66556008)(2501003)(2171002)(64756008)(66446008)(86362001)(6486002)(14444005)(7736002)(2906002)(103116003)(71200400001)(71190400001)(6436002)(66946007)(486006)(6512007)(478600001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5262;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: JFAYJfltCER9MYs+nOxvEz2zdcKGLouxXg6W74MpKFgsIgM5jxRmb9ZnQerHYjCJsLUuZf6tc4yxeNcaaLEwkZxxGkRutOGlg/jwZgLVnyJ5suH73M1+qWs58a6QOS6zC0dLTexUZwEs5KxQIMtnO8n5cj5VE+my/ghTiGvvaLTcztlQkjiLaTaBvKISbqxFPUW2IUEj7IWjLFQ1iVxABj9MdcwcbIWfw0FdZwFIVH0oXRpwVEgx/zD8wd4sWJz0n3/c6j4EGlMttbLyy29DitXyKQdu5hQlQbC14vRsZwOqNSG30bMxkAbPqAmheYazIp9pjtGRkwAn7lDrJOUhbD8HTBc8UU348Nv3FWKBHrf+rUaSEnZX3Y1HN1l9GGNQGHsNHgam7P/iBwZuZM7kWTXAWjITU5NmVM00UP6nz1w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5262
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(2616005)(22756006)(50466002)(76130400001)(478600001)(70586007)(336012)(14444005)(23756003)(186003)(446003)(11346002)(8746002)(6116002)(14454004)(26005)(70206006)(2501003)(63350400001)(8936002)(81166006)(36756003)(2201001)(3846002)(86362001)(81156014)(8676002)(486006)(126002)(476003)(50226002)(4326008)(1076003)(25786009)(26826003)(7736002)(6486002)(6506007)(99286004)(386003)(356004)(102836004)(2906002)(5660300002)(2171002)(76176011)(66066001)(316002)(305945005)(54906003)(47776003)(110136005)(36906005)(103116003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2302;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e65bf5b8-88f2-4062-fbd9-08d74e0e4572
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I49MIV9vuN2ZIfDsFTXxX6lT+jPs8SIJmpYIevPGS6oFERT02eZibqsTf6aMHXE8DTTk3QmHBVgvWMyyPdngwXLO/BRPmQ1j6R3BmeptJ7xvITo9SzQiTL4CtIy1LEekZEHs8TfODoyQsUpqMjfnKd0AXIVSqS3UzGQ1OejHFYiCL2EQdSKIRUvmbY8IwEMwD7PNT/VgFBoOlsOc6pOyZCIIyzqit0E+Xc1MYtP85CoUQhBQfUKRmYiM0KWhmMF2l+n30llRpazbYXu//tVXueUTlDxT9Fwr4l8w4BHSTaYeo39/2LqUSHS6x7BH+lBA2d7NRl2O5O7qPBTAJO3ZZD1smerwLogBmxE+aVqccZk4pposmtviOTXKF0gazmHwy5rnKRTG56wOzjmvhagrS4tbeFc7IyubrIlkE/7r/Yg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 05:45:57.9880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d73b40-c40f-4f3f-ff16-08d74e0e4a65
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2302
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
index 9beeda04818b..406b9d0ca058 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -590,6 +590,8 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
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
index b322f52ba8f2..c5ab8096c85d 100644
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

