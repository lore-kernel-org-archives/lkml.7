Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1305CC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF81724249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="YgugMVQw";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="YgugMVQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfLEIgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:36:10 -0500
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:36238
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbfLEIgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNE7+1y7dTmC5k0mi/fzuSuQhBHPcnvW+WNpDf6IaTM=;
 b=YgugMVQw3wg3iG1rEvvDfl5fmBAHtD+2QfCMPJLo007NUXu3UgpmGwoWF83AREsU75XRNdarbhZb3UK30urj2x2cOJyFivd80iTAse7xJjpl48p3gHkTpxzt64ohpTz+j/IFQfTjq7/lHKgxKoF3qymBb9JF5xCJJiWyWyZlLG8=
Received: from VE1PR08CA0002.eurprd08.prod.outlook.com (2603:10a6:803:104::15)
 by VI1PR08MB4061.eurprd08.prod.outlook.com (2603:10a6:803:e7::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Thu, 5 Dec
 2019 08:36:01 +0000
Received: from DB5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VE1PR08CA0002.outlook.office365.com
 (2603:10a6:803:104::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Thu, 5 Dec 2019 08:36:01 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT049.mail.protection.outlook.com (10.152.20.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 5 Dec 2019 08:36:00 +0000
Received: ("Tessian outbound 25173d5f5683:v37"); Thu, 05 Dec 2019 08:36:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2a6b0409a2bad344
X-CR-MTA-TID: 64aa7808
Received: from bf5a46e4d812.4
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2CAB80B6-F600-4403-8CE7-BA339EB32632.1;
        Thu, 05 Dec 2019 08:35:55 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bf5a46e4d812.4
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Dec 2019 08:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELb55Zv8J1bvjhImmX+7nrZN0XvIPkVoWwqFARt6GvUe/5tUOgpn54c391DVDGwlk5jKPNt//xTvZXHCtLXr6PAKXvZOxMR2B8AMwc1l438OV25tZ7yh/3FJpHfsSWv4STYMfnmvE9ExURe9C7a5iTrluTwp5Qyr37v2tR9prvyWGT/JA4GHyb1V+oHkwEvb8a5m+skc6ttD9/11p9APK0frh57lk3mipGvPM6KU41DLihjfEzs/E2JTFwgcHrnzwhICRl96r689OlbzrAJk86z/MglHFVUfax19kfwkW0qzDZv7SRHyJ1M7CK7JAmywHzYmhsULkAPVOuhptX4g5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNE7+1y7dTmC5k0mi/fzuSuQhBHPcnvW+WNpDf6IaTM=;
 b=Vg2cjakBM4qFODjAjiFNrd3FLLjZVC2/5A5msjwiERiYUqavCYML9PJ9eAoOR4hvAvpkcM0uYmHqajm1T33G9AZ6SVb6ahxJX7dK+YuNEttAqmsQsacvOgaD0Lo54Jz+sqX3Hh61m70rsROJ6KD5hRAuQU6yU24N4XZIyjzhmN8QOxSL+IUjgYjXH1RQQQIN3IHoH+Jsy297H7qWGyJ0a/j7jdp5oh5CdTA9EIINni1+oI6SE9pmDfuoVjj56JaX3VvT6O0gJT2+GMaC5Nwna0Zqr39Ate2xVh6zpkS2UlQ+GBEsZoT4Z5Xq2Cjw/4tBga1uV1FUbori+x+IPCv+eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNE7+1y7dTmC5k0mi/fzuSuQhBHPcnvW+WNpDf6IaTM=;
 b=YgugMVQw3wg3iG1rEvvDfl5fmBAHtD+2QfCMPJLo007NUXu3UgpmGwoWF83AREsU75XRNdarbhZb3UK30urj2x2cOJyFivd80iTAse7xJjpl48p3gHkTpxzt64ohpTz+j/IFQfTjq7/lHKgxKoF3qymBb9JF5xCJJiWyWyZlLG8=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 AM0SPR01MB0026.eurprd08.prod.outlook.com (52.135.152.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 08:35:51 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 08:35:51 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v5 3/5] drm/komeda: Build side by side display output pipeline
Thread-Topic: [PATCH v5 3/5] drm/komeda: Build side by side display output
 pipeline
Thread-Index: AQHVq0cAtaKlsvJA1kSs3IYKkTMm9w==
Date:   Thu, 5 Dec 2019 08:35:51 +0000
Message-ID: <20191205083436.11060-4-james.qian.wang@arm.com>
References: <20191205083436.11060-1-james.qian.wang@arm.com>
In-Reply-To: <20191205083436.11060-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae797def-9ed3-4b38-d71b-08d7795e288c
X-MS-TrafficTypeDiagnostic: AM0SPR01MB0026:|AM0SPR01MB0026:|VI1PR08MB4061:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB406144A5320D7ADF273059EAB35C0@VI1PR08MB4061.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1284;OLM:1284;
x-forefront-prvs: 02426D11FE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(8676002)(5660300002)(71200400001)(71190400001)(7736002)(86362001)(305945005)(2906002)(316002)(36756003)(103116003)(50226002)(1076003)(81156014)(81166006)(6862004)(8936002)(55236004)(6636002)(4326008)(99286004)(186003)(478600001)(11346002)(2616005)(102836004)(26005)(25786009)(76176011)(52116002)(14454004)(6506007)(66446008)(6116002)(54906003)(66946007)(66476007)(66556008)(64756008)(3846002)(37006003)(6436002)(14444005)(6486002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB0026;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NK1o6x8zWlGzhx1pdK2jpoUp3ydsJVhto+F5qIMlc0V7aX0v/dNZImAjwUdnwOwEgjY5UgUwVgtvswO9GQTicikQFgWPH8jP+f48oWIS98g3MdOjXE+n5jt4ZodCK1FH15SjYXUveFag7ADLQVyw2RxMK4tO9ACrhzQMEdYXNv1i9EadL3z3aVfzB/YwwmCa3MefqODV8OvylCmJ0iRyh09WmMtPmhf4Q4HzMyTaLlMqGDgtHKBeKQNkLSfvNfDK9w+zBZvwRaFj0GsCIEcqAHYtSplgs8yGTXMPxw+kd/9r2uiWNaN5Rw5MyR8mrdpUUojHITx08VWL5wCLF6qn9GD6Wxsa940PaPmtn0aAzU1xZfhLZ8o8w4Z0wuUTVbvlWszUEJwPzNBQL2Nk8iVC8lS1KC/LLASjFYIqHfnlKdd8rKqApsOnVwCZPhHEXqwi
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0026
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(7736002)(305945005)(6486002)(11346002)(26826003)(6506007)(22756006)(6636002)(478600001)(36756003)(37006003)(54906003)(6862004)(81156014)(8676002)(4326008)(81166006)(103116003)(76176011)(356004)(8746002)(8936002)(6512007)(50226002)(99286004)(23756003)(336012)(25786009)(2906002)(14454004)(26005)(5660300002)(186003)(70206006)(76130400001)(70586007)(14444005)(2616005)(50466002)(102836004)(316002)(86362001)(6116002)(1076003)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4061;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a9afa293-b141-40ab-1bf0-08d7795e2288
NoDisclaimer: True
X-Forefront-PRVS: 02426D11FE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDexOrq85YewldhIXxPhYNXVnWHuAyACdwsHK7soHCx5CU689RNYS0vjrw+4MHkNoW9VCTRM9hZdI4p7d1nQv6zJM3gfo/sW8STZmuYjZeZ0/8ULarQdaUBADRx2/V1IZsPW+EOH5qy0jbZ2qZkZj4aEJksEf6sJZaCVCO+ufLxDJWCjbzopu9qdI6u/MxW3CBl8YWKyXsc1Llhcaku1LTFS433/QllHuNVE94V0NgcKNNcUEq7pvCO/IKM4eIabej33RRc2sXhQB4RuQ0E70DfZUHVB6A+LdZrGcxx08y1yL2Bxlmvdv1frQ33aKvqfptcoDgOG/z/S7s5B4vbMXGmz/7I4n+EqYjbbDUrapZUUj2Pfa8dD2wRE1hGEtIu0v0MEUDMsTCekSRIog2X2kbN9GKRCV7Qe7nGeIQGbc2d1hTs14nRkyM91WN2G8f6K
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 08:36:00.9699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae797def-9ed3-4b38-d71b-08d7795e288c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For side by side, the slave pipeline merges to master via image processor

 slave-layers -> slave-compiz-> slave-improc-
                                             \
 master-layers -> master-compiz -------------> master-improc ->

v3: Rebase.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../arm/display/komeda/d71/d71_component.c    |  4 ++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 18 +++++--
 .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
 .../display/komeda/komeda_pipeline_state.c    | 51 ++++++++++++++-----
 .../arm/display/komeda/komeda_wb_connector.c  |  2 +-
 5 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index b6517c46e670..6dadf4413ef3 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -1085,6 +1085,10 @@ static void d71_improc_update(struct komeda_componen=
t *c,
 	else if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB444)
 		ctrl |=3D IPS_CTRL_YUV;
=20
+	/* slave input has been enabled, means side by side */
+	if (has_bit(1, state->active_inputs))
+		ctrl |=3D IPS_CTRL_SBS;
+
 	malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index cee9a1692e71..24928b922fbd 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -385,15 +385,23 @@ komeda_crtc_atomic_flush(struct drm_crtc *crtc,
 	komeda_crtc_do_flush(crtc, old);
 }
=20
-/* Returns the minimum frequency of the aclk rate (main engine clock) in H=
z */
+/*
+ * Returns the minimum frequency of the aclk rate (main engine clock) in H=
z.
+ *
+ * The DPU output can be split into two halves, to stay within the bandwid=
th
+ * capabilities of the external link (dual-link mode).
+ * In these cases, each output link runs at half the pixel clock rate of t=
he
+ * combined display, and has half the number of pixels.
+ * Beside split the output, the DPU internal pixel processing also can be =
split
+ * into two halves (LEFT/RIGHT) and handles by two pipelines simultaneousl=
y.
+ * So if side by side, the pipeline (main engine clock) also can run at ha=
lf
+ * the clock rate of the combined display.
+ */
 static unsigned long
 komeda_calc_min_aclk_rate(struct komeda_crtc *kcrtc,
 			  unsigned long pxlclk)
 {
-	/* Once dual-link one display pipeline drives two display outputs,
-	 * the aclk needs run on the double rate of pxlclk
-	 */
-	if (kcrtc->master->dual_link)
+	if (kcrtc->master->dual_link && !kcrtc->side_by_side)
 		return pxlclk * 2;
 	else
 		return pxlclk;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 4c0946fbaac1..59a81b4476df 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -540,6 +540,7 @@ struct komeda_crtc_state;
 struct komeda_crtc;
=20
 void pipeline_composition_size(struct komeda_crtc_state *kcrtc_st,
+			       bool side_by_side,
 			       u16 *hsize, u16 *vsize);
=20
 int komeda_build_layer_data_flow(struct komeda_layer *layer,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 10a0dc9291b8..b1e90feb5c55 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -654,12 +654,13 @@ komeda_merger_validate(struct komeda_merger *merger,
 }
=20
 void pipeline_composition_size(struct komeda_crtc_state *kcrtc_st,
+			       bool side_by_side,
 			       u16 *hsize, u16 *vsize)
 {
 	struct drm_display_mode *m =3D &kcrtc_st->base.adjusted_mode;
=20
 	if (hsize)
-		*hsize =3D m->hdisplay;
+		*hsize =3D side_by_side ? m->hdisplay / 2 : m->hdisplay;
 	if (vsize)
 		*vsize =3D m->vdisplay;
 }
@@ -670,12 +671,14 @@ komeda_compiz_set_input(struct komeda_compiz *compiz,
 			struct komeda_data_flow_cfg *dflow)
 {
 	struct drm_atomic_state *drm_st =3D kcrtc_st->base.state;
+	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
 	struct komeda_component_state *c_st, *old_st;
 	struct komeda_compiz_input_cfg *cin;
 	u16 compiz_w, compiz_h;
 	int idx =3D dflow->blending_zorder;
=20
-	pipeline_composition_size(kcrtc_st, &compiz_w, &compiz_h);
+	pipeline_composition_size(kcrtc_st, to_kcrtc(crtc)->side_by_side,
+				  &compiz_w, &compiz_h);
 	/* check display rect */
 	if ((dflow->out_x + dflow->out_w > compiz_w) ||
 	    (dflow->out_y + dflow->out_h > compiz_h) ||
@@ -687,7 +690,7 @@ komeda_compiz_set_input(struct komeda_compiz *compiz,
 	}
=20
 	c_st =3D komeda_component_get_state_and_set_user(&compiz->base, drm_st,
-			kcrtc_st->base.crtc, kcrtc_st->base.crtc);
+			crtc, crtc);
 	if (IS_ERR(c_st))
 		return PTR_ERR(c_st);
=20
@@ -721,17 +724,19 @@ komeda_compiz_validate(struct komeda_compiz *compiz,
 		       struct komeda_crtc_state *state,
 		       struct komeda_data_flow_cfg *dflow)
 {
+	struct drm_crtc *crtc =3D state->base.crtc;
 	struct komeda_component_state *c_st;
 	struct komeda_compiz_state *st;
=20
 	c_st =3D komeda_component_get_state_and_set_user(&compiz->base,
-			state->base.state, state->base.crtc, state->base.crtc);
+			state->base.state, crtc, crtc);
 	if (IS_ERR(c_st))
 		return PTR_ERR(c_st);
=20
 	st =3D to_compiz_st(c_st);
=20
-	pipeline_composition_size(state, &st->hsize, &st->vsize);
+	pipeline_composition_size(state, to_kcrtc(crtc)->side_by_side,
+				  &st->hsize, &st->vsize);
=20
 	komeda_component_set_output(&dflow->input, &compiz->base, 0);
=20
@@ -757,7 +762,8 @@ komeda_compiz_validate(struct komeda_compiz *compiz,
 static int
 komeda_improc_validate(struct komeda_improc *improc,
 		       struct komeda_crtc_state *kcrtc_st,
-		       struct komeda_data_flow_cfg *dflow)
+		       struct komeda_data_flow_cfg *m_dflow,
+		       struct komeda_data_flow_cfg *s_dflow)
 {
 	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
 	struct drm_crtc_state *crtc_st =3D &kcrtc_st->base;
@@ -771,8 +777,8 @@ komeda_improc_validate(struct komeda_improc *improc,
=20
 	st =3D to_improc_st(c_st);
=20
-	st->hsize =3D dflow->in_w;
-	st->vsize =3D dflow->in_h;
+	st->hsize =3D m_dflow->in_w;
+	st->vsize =3D m_dflow->in_h;
=20
 	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
 		u32 output_depths, output_formats;
@@ -808,8 +814,10 @@ komeda_improc_validate(struct komeda_improc *improc,
 		drm_ctm_to_coeffs(kcrtc_st->base.ctm, st->ctm_coeffs);
 	}
=20
-	komeda_component_add_input(&st->base, &dflow->input, 0);
-	komeda_component_set_output(&dflow->input, &improc->base, 0);
+	komeda_component_add_input(&st->base, &m_dflow->input, 0);
+	if (s_dflow)
+		komeda_component_add_input(&st->base, &s_dflow->input, 1);
+	komeda_component_set_output(&m_dflow->input, &improc->base, 0);
=20
 	return 0;
 }
@@ -1146,7 +1154,7 @@ komeda_split_sbs_master_data_flow(struct komeda_crtc_=
state *kcrtc_st,
 	u32 disp_end =3D master->out_x + master->out_w;
 	u16 boundary;
=20
-	pipeline_composition_size(kcrtc_st, &boundary, NULL);
+	pipeline_composition_size(kcrtc_st, true, &boundary, NULL);
=20
 	if (disp_end <=3D boundary) {
 		/* the master viewport only located in master side, no need
@@ -1209,7 +1217,7 @@ komeda_split_sbs_slave_data_flow(struct komeda_crtc_s=
tate *kcrtc_st,
 {
 	u16 boundary;
=20
-	pipeline_composition_size(kcrtc_st, &boundary, NULL);
+	pipeline_composition_size(kcrtc_st, true, &boundary, NULL);
=20
 	if (slave->out_x < boundary) {
 		DRM_DEBUG_ATOMIC("SBS Slave plane is only allowed to configure the right=
 part frame.\n");
@@ -1384,7 +1392,20 @@ int komeda_build_display_data_flow(struct komeda_crt=
c *kcrtc,
 	memset(&m_dflow, 0, sizeof(m_dflow));
 	memset(&s_dflow, 0, sizeof(s_dflow));
=20
-	if (slave && has_bit(slave->id, kcrtc_st->active_pipes)) {
+	/* build slave output data flow */
+	if (kcrtc->side_by_side) {
+		/* on side by side, the slave data flows into the improc of
+		 * itself first, and then merge it into master's image processor
+		 */
+		err =3D komeda_compiz_validate(slave->compiz, kcrtc_st, &s_dflow);
+		if (err)
+			return err;
+
+		err =3D komeda_improc_validate(slave->improc, kcrtc_st,
+					     &s_dflow, NULL);
+		if (err)
+			return err;
+	} else if (slave && has_bit(slave->id, kcrtc_st->active_pipes)) {
 		err =3D komeda_compiz_validate(slave->compiz, kcrtc_st, &s_dflow);
 		if (err)
 			return err;
@@ -1400,7 +1421,9 @@ int komeda_build_display_data_flow(struct komeda_crtc=
 *kcrtc,
 	if (err)
 		return err;
=20
-	err =3D komeda_improc_validate(master->improc, kcrtc_st, &m_dflow);
+	/* on side by side, merge the slave dflow into master */
+	err =3D komeda_improc_validate(master->improc, kcrtc_st, &m_dflow,
+				     kcrtc->side_by_side ? &s_dflow : NULL);
 	if (err)
 		return err;
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index e465cc4879c9..17ea021488aa 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -21,7 +21,7 @@ komeda_wb_init_data_flow(struct komeda_layer *wb_layer,
 	dflow->out_h =3D fb->height;
=20
 	/* the write back data comes from the compiz */
-	pipeline_composition_size(kcrtc_st, &dflow->in_w, &dflow->in_h);
+	pipeline_composition_size(kcrtc_st, false, &dflow->in_w, &dflow->in_h);
 	dflow->input.component =3D &wb_layer->base.pipeline->compiz->base;
 	/* compiz doesn't output alpha */
 	dflow->pixel_blend_mode =3D DRM_MODE_BLEND_PIXEL_NONE;
--=20
2.20.1

