Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3123CCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BA120B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="j3k6pGn1";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="j3k6pGn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfJUHXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:23:54 -0400
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:29061
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727047AbfJUHXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC99I3Z56ZuZCx4QJHgqK2QJ3GtYUvtyOKpAuzBHzXI=;
 b=j3k6pGn1gP80nCdACc3YDwKlcmyiLaEVALHjz0b7PI4IqPE1vZ33HG71eh9TyUgZmK9FRcc7SSM+GGalkvGjTit1ToLwxAkMiIHy+sEyY0dSSZGhZwmuq1stOA0KYKL7Me+qxYAwTnsTUAPihSxKzDPRYjcVindif7Cx/tydxXk=
Received: from AM4PR08CA0069.eurprd08.prod.outlook.com (2603:10a6:205:2::40)
 by AM0PR08MB4385.eurprd08.prod.outlook.com (2603:10a6:208:148::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.21; Mon, 21 Oct
 2019 07:23:43 +0000
Received: from DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by AM4PR08CA0069.outlook.office365.com
 (2603:10a6:205:2::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.21 via Frontend
 Transport; Mon, 21 Oct 2019 07:23:43 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT045.mail.protection.outlook.com (10.152.21.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 21 Oct 2019 07:23:41 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Mon, 21 Oct 2019 07:23:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c6431d9452722dc9
X-CR-MTA-TID: 64aa7808
Received: from 2dca2d14250f.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9E25DFA7-8A86-47C2-BFAB-E534FC3623DB.1;
        Mon, 21 Oct 2019 07:23:31 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2dca2d14250f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 21 Oct 2019 07:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erdC2wv+Sk068iTSZKwt1ZIs8ZI1m1m5wL+ZNiXzOARLB/kaxFjCmDYQ6BM4ODpRim1c7vjIbgwHwa8DMTfpr6+a3esxW0eTJKOPvXPHcgXEAiFItyKzKCoucrShVEYG8UhMIk8ykgN1Fq/abbduGQn5MvvK9vLVW3r9o/t/9sNqqOKL7iYXCpfVBCZsQdOi9uuy/G2TM6+Lu+7DtswkF3qv/aSJYSlMUn5Wyrl5r2jiIfmFPGANXl75AVy6NgcGSFYC+giXdwiN675OUd2yHe9+AamScNNo9kaZu1SwKlFP6ftaSfHJZxIuWzq4nWCfTAvodYhIbZU0MffgRWRf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC99I3Z56ZuZCx4QJHgqK2QJ3GtYUvtyOKpAuzBHzXI=;
 b=Kd+Vk53rxD9uyUg86err7dQdA2R+bsOMSbbCCjxoeBsgOiL5N+b/Na8VZXPSyMaDoFog9kDWv8KnGHjJHaotXNW+Bwny0K7KmXiftOlbyJMT0pGWgxTiE15Ii7O5rVrZ99sEwp66gwrSTC3YqhmfhCIl6vQzEUh+7/bDHiloHrIOp1s2HYVH6sSUwq9i/CbJxsEv8PTCW4Ifse0Wj3A/AcgLuOrY3k/TbNvHRmhTSNe4cJK97zgEc9KkRbLad37yZOy/go8hSYQsSaQwtNZinnmhfjo9cNSiF4GLm0gvPyYEAVyWkICRIx3QlsWgfkZzLulf1LHWnJ9537Ptrc/W0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC99I3Z56ZuZCx4QJHgqK2QJ3GtYUvtyOKpAuzBHzXI=;
 b=j3k6pGn1gP80nCdACc3YDwKlcmyiLaEVALHjz0b7PI4IqPE1vZ33HG71eh9TyUgZmK9FRcc7SSM+GGalkvGjTit1ToLwxAkMiIHy+sEyY0dSSZGhZwmuq1stOA0KYKL7Me+qxYAwTnsTUAPihSxKzDPRYjcVindif7Cx/tydxXk=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4831.eurprd08.prod.outlook.com (10.255.115.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Mon, 21 Oct 2019 07:23:29 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 07:23:29 +0000
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
Subject: [PATCH v6 4/4] drm/komeda: Adds gamma and color-transform support for
 DOU-IPS
Thread-Topic: [PATCH v6 4/4] drm/komeda: Adds gamma and color-transform
 support for DOU-IPS
Thread-Index: AQHVh+Bv2LYjVeuTFU+5R6eahc8s7w==
Date:   Mon, 21 Oct 2019 07:23:29 +0000
Message-ID: <20191021072215.3993-5-james.qian.wang@arm.com>
References: <20191021072215.3993-1-james.qian.wang@arm.com>
In-Reply-To: <20191021072215.3993-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0401CA0019.apcprd04.prod.outlook.com
 (2603:1096:202:2::29) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 2cbb4af0-a4ff-46cf-3174-08d755f7995c
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4831:|VE1PR08MB4831:|AM0PR08MB4385:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4385D0B5B0D342E0AF4617FFB3690@AM0PR08MB4385.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2582;OLM:2582;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39850400004)(396003)(136003)(376002)(199004)(189003)(110136005)(6506007)(6486002)(386003)(66066001)(4326008)(8676002)(66946007)(54906003)(99286004)(103116003)(36756003)(6512007)(6436002)(66446008)(64756008)(66556008)(66476007)(55236004)(2171002)(102836004)(2501003)(26005)(14454004)(186003)(81156014)(81166006)(2201001)(478600001)(11346002)(446003)(316002)(2906002)(7736002)(86362001)(71190400001)(71200400001)(256004)(6116002)(25786009)(305945005)(14444005)(486006)(3846002)(76176011)(52116002)(5660300002)(8936002)(2616005)(476003)(1076003)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4831;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Lu2D4UUses/4lCKQk721tUCiG6ME66/kITIOaXGNE7My1e4U4EGFNiiIezn1NGdj0chHNuSrkj4kOzNqjgxYDGJK10Wxptz1ECMKGTKCstY7cDQBxggLFDMgOQYz15SVMHAEtCNcHUUB3lg7q8gC1Es3OZNtEpX3swU+kzvWdxK19D9vFRBLz3/2/eKMduXfwLHuA3iW7Ve4qpWUwX/Ua2sAVqSDz6par/8SChZtELHaMZ3uXhbM9mtyH0JBsKjxg8hH5dsjcm4xOzpJeOIYhyXpMyipyhb18a7kEkEd3cOKGsffmIguB0WPqA3z9ezGc5FchA9kg5tqUnHrAbG6J11IOwe6XeGrrxqbedYL6bFEjilI/kAxfl5PVbojb1Y9XgoFFvB0l3r4Gy7aaDeHmh6t3JJ3exejgMecnJKCrjo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4831
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(47776003)(50466002)(25786009)(66066001)(70586007)(26826003)(23756003)(6512007)(6116002)(2171002)(3846002)(6506007)(336012)(70206006)(386003)(478600001)(50226002)(305945005)(7736002)(356004)(76176011)(486006)(36756003)(476003)(26005)(6486002)(81166006)(81156014)(99286004)(186003)(4326008)(14444005)(5660300002)(8936002)(8746002)(8676002)(2616005)(2201001)(11346002)(2906002)(76130400001)(102836004)(54906003)(446003)(22756006)(14454004)(110136005)(316002)(103116003)(2501003)(86362001)(1076003)(63350400001)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4385;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6071ebe0-6ddb-4be9-6bf8-08d755f791c5
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gx8ZYU1YKCCPGg2SsZUhk+NTW0NVPWYIv4uQhMHm/p0h/ymkU2saQE1qPSwy4apbusgJPrZrJNqBNhB3qHDQHYFegH6cApUkMpUNOeWYHOG/8HAOBoGFWb8MWb33qMLbZbqZwkwZAyfTD58HEWklbDZZA+vY+rM7rgB/TrZlukkp1rvMWogAsy/XW/aGTskrPqLrc59lXPhe3Ac4EsI7JuA6NCrByhl/QCF2r4g7IxPpD6EcGVpadfsZpCUpekrDwRPsR9O9baMwG0+lGcB1+PpWjwFeMlcWf0P8yWgGGJ427Cxhl8aefHnW7hYYOAn/CcwGCJHWewO5P4Y3SQNnK5NL8aAWUnHtUh4jofVaBXJpB3drucaGxpZ90SbFrcA/v4HWPao4bTHQiql3ltxPqssm1H5hY68HBXba7E3egRiLtKo5wTC3Oxso87P4OQX2
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 07:23:41.3943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbb4af0-a4ff-46cf-3174-08d755f7995c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4385
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

