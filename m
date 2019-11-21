Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB86DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ABC2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KAy/nWBP";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KAy/nWBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKUHMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:12:53 -0500
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:12270
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726658AbfKUHMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/OhMdzAJRV+IRQdte4BkdgRPzZxlKwzEQRrhZRPdE0=;
 b=KAy/nWBPOU57HCg91TgYooyg2DAotCg56o0a+lanImUNAiMFKFxn/xyrskzy+UNQZpZam9/Eac1FXI1db8SU2cJBdxkFHicWVtIJPcFfnLaTNxSIqxt6YhLKe4iHHQQfQ0HBLcffSP6EY8tKpiQR5uhZdPqGOT7EInHgvOJZhLQ=
Received: from VI1PR0802CA0004.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::14) by AM6PR08MB5219.eurprd08.prod.outlook.com
 (2603:10a6:20b:ce::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Thu, 21 Nov
 2019 07:12:43 +0000
Received: from VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR0802CA0004.outlook.office365.com
 (2603:10a6:800:aa::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Thu, 21 Nov 2019 07:12:43 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT044.mail.protection.outlook.com (10.152.19.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Thu, 21 Nov 2019 07:12:42 +0000
Received: ("Tessian outbound 512f710540da:v33"); Thu, 21 Nov 2019 07:12:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a651b666fee35c7e
X-CR-MTA-TID: 64aa7808
Received: from f051d0fe52c9.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A381078F-9238-42AD-88CB-4ED4FDF8B29C.1;
        Thu, 21 Nov 2019 07:12:36 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f051d0fe52c9.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 21 Nov 2019 07:12:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9vzyEaqOHDIVBxlzAnCjK0KSeYejrNb6c2gNpyohjMmnKCpRM494Rj0ozzAIplAQp5eYAiMOqJnOFENPj8TuGMWGFoW+ssJnfh3d1fjj7OGgLA8ma90LY8uDtEAH/wzK3RlFjdWJfHiOEMp61hnHbvSopaX0V4rZDScKl/bDkSNLrgGOMMKT4cDj5LeLrPtfq1T42xnG72Ou1CvbvaXIduAhmxyPoIVcnpAUkl5FYPTvrY+IfqkXgU2yUFJlW0w8KmhUISx9Ww/C+/9nqKt9H231+6f8AaF6go661NPcGRYfrR6CeoIR2OFDBGnCoJOFf3yzlCP8p+PY7FW3v76iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/OhMdzAJRV+IRQdte4BkdgRPzZxlKwzEQRrhZRPdE0=;
 b=f76Atr507Ck0ibJm8gihU8x9X+n1lY4X7OhTqrtYYnV5Vh5ONH1KTGB2rmtBcyQFJNCQss7TEsTq0zGYSJpNrkKaB0nFJu8SjQKz+Ff/lnzg0XNn29yMdU/6fPiI5qx+/z5Cnb5/7vEHmgRarGxncWOL53/Lovrehb90x8J6pCOQi/aobmCVPkilMaVtlSEYHRlYHgjTPprk9XdF8ZQrM+ezkM8SFa21eGlInXXRj+i6nSRIErC0Ta+ZUBunXjGsobeP0PyueXK75RJYCqD2tRFjtteN6C5BiqVaqqqTabaZPyr/4pwMxvCiA2gF4o666uEqs34qLNTo5nYTlHwUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/OhMdzAJRV+IRQdte4BkdgRPzZxlKwzEQRrhZRPdE0=;
 b=KAy/nWBPOU57HCg91TgYooyg2DAotCg56o0a+lanImUNAiMFKFxn/xyrskzy+UNQZpZam9/Eac1FXI1db8SU2cJBdxkFHicWVtIJPcFfnLaTNxSIqxt6YhLKe4iHHQQfQ0HBLcffSP6EY8tKpiQR5uhZdPqGOT7EInHgvOJZhLQ=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5069.eurprd08.prod.outlook.com (20.179.29.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 07:12:35 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 07:12:35 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
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
Subject: [PATCH v4 2/6] drm/komeda: Add side by side plane_state split
Thread-Topic: [PATCH v4 2/6] drm/komeda: Add side by side plane_state split
Thread-Index: AQHVoDsMGprGuC7czEO9IQLJopwUpg==
Date:   Thu, 21 Nov 2019 07:12:35 +0000
Message-ID: <20191121071205.27511-3-james.qian.wang@arm.com>
References: <20191121071205.27511-1-james.qian.wang@arm.com>
In-Reply-To: <20191121071205.27511-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 537d9a3c-c99d-4fdb-03a3-08d76e5233c3
X-MS-TrafficTypeDiagnostic: VE1PR08MB5069:|VE1PR08MB5069:|AM6PR08MB5219:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5219A4C707B7F2B1A5410940B34E0@AM6PR08MB5219.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4502;OLM:4502;
x-forefront-prvs: 0228DDDDD7
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(366004)(376002)(346002)(136003)(189003)(199004)(386003)(6636002)(55236004)(102836004)(6506007)(76176011)(256004)(30864003)(52116002)(2906002)(50226002)(7736002)(305945005)(66446008)(186003)(81166006)(81156014)(8676002)(8936002)(66946007)(6512007)(26005)(2616005)(71200400001)(6486002)(446003)(478600001)(11346002)(71190400001)(6436002)(64756008)(66476007)(66556008)(86362001)(66066001)(4326008)(36756003)(2501003)(6116002)(316002)(3846002)(14454004)(103116003)(99286004)(54906003)(110136005)(25786009)(1076003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5069;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qyfm7voAzvhXTOnJFevu2Y5HrPS5BJOj4A5+FuErpuOHxz8SeK3gee5fpWIgsUkYlesjlTGbW4+JhyIjrsBg9A8A1iN8RXvZp8rCr9QSxDwvgxF0BBI8Q/I1Inh7EGrSNIBYa9wzyRkMMiDsjEWJoQgunUOfXwMT8eXoR8toqtC2OaIaafJk0hqhUj1GI2u5G/C+h8Uotbjaw/aHCzeVRKEgbjvSZKjzmXbh/MLYhWFhNhIlI/W1bqtjc//oCCXCca654/3PGVivgG9JWMp6rJc/MN4HI3GoShqe1YvGkwLLX7wYi/Odo4ry26QlKMX3eyKPXgoILLfScTPqi504o/RWVpRIuzce5Np+032eJCnWiI4o0Jt3+jF/NGzeUaoAzexEooRt8d+f0RNx3oLwvXwfsht1Wjp4bIUwiSzgubF2eWqZpZnrGurDoltyeKYQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5069
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(1110001)(339900001)(199004)(189003)(2501003)(7736002)(105606002)(305945005)(50466002)(6636002)(2906002)(110136005)(5660300002)(3846002)(6512007)(6116002)(66066001)(103116003)(6486002)(316002)(76176011)(54906003)(86362001)(36906005)(6506007)(23756003)(102836004)(386003)(50226002)(26005)(186003)(76130400001)(36756003)(70586007)(4326008)(47776003)(99286004)(336012)(356004)(478600001)(8746002)(14454004)(8936002)(81156014)(8676002)(25786009)(30864003)(22756006)(2616005)(1076003)(26826003)(81166006)(70206006)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5219;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0d566fae-6401-4b2f-a56d-08d76e522ed5
NoDisclaimer: True
X-Forefront-PRVS: 0228DDDDD7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VH1ToZSnHNuZ7Aea6xsJJzbrbhSksE3YeYec/7yazEtJ515xX1V4Gd2WeXe84vCwXgyQ5sG2W/W6NK6d/A3zFBkGOFH4axofuAPZry8se+UWCffgPwseXpEM1egP2cAiFuVpiOXsKlVFC7A8QH+sNpmCJCk8APSsrBSjR4XWD69+G4QChQ1UaDZeUMtHVUeTH0jBeOedJR33BG1+7+EKd7JhF/kKgdVL07bg8CsuDoBGKAtmgrZGu1/KtKylqv+Cp+98GxZnghySscGL3bJ7uVR3IRF7YgNpNxHfXHoRjyoZmzZNEGif/JXiLmryuwdhRf7QJTfwEuSJGIE63aKSBRWUw0Ktrb8xi8FjI6+UHvi06QQrX12kPawexJ7rxD71mOS+sURWlQO7KgeE06NgoPLzHJjEb7Ko3lilm2Eg1KOkgpY5z/eYTSlCGVBvmv9Y
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 07:12:42.9625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 537d9a3c-c99d-4fdb-03a3-08d76e5233c3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On side by side mode, The full display frame will be split into two parts
(Left/Right), and each part will be handled by a single pipeline separately
master pipeline for left part, slave for right.

To simplify the usage and implementation, komeda use the following scheme
to do the side by side split
1. The planes also have been grouped into two classes:
   master-planes and slave-planes.
2. The master plane can display its image on any location of the final/full
   display frame, komeda will help to split the plane configuration to two
   parts and fed them into master and slave pipelines.
3. The slave plane only can put its display rect on the right part of the
   final display frame, and its data is only can be fed into the slave
   pipeline.

From the perspective of resource usage and assignment:
The master plane can use the resources from the master pipeline and slave
pipeline both, but slave plane only can use the slave pipeline resources.

With such scheme, the usage of master planes are same as the none
side_by_side mode. user can easily skip the slave planes and no need to
consider side_by_side for them.

v4: Address Mihail's review comments.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/komeda/komeda_pipeline.h  |  33 ++-
 .../display/komeda/komeda_pipeline_state.c    | 188 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_plane.c |   7 +-
 3 files changed, 220 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 20a076cce635..4c0946fbaac1 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -521,6 +521,20 @@ komeda_component_pickup_output(struct komeda_component=
 *c, u32 avail_comps)
 	return komeda_pipeline_get_first_component(c->pipeline, avail_inputs);
 }
=20
+static inline const char *
+komeda_data_flow_msg(struct komeda_data_flow_cfg *config)
+{
+	static char str[128];
+
+	snprintf(str, sizeof(str),
+		 "rot: %x src[x/y:%d/%d, w/h:%d/%d] disp[x/y:%d/%d, w/h:%d/%d]",
+		 config->rot,
+		 config->in_x, config->in_y, config->in_w, config->in_h,
+		 config->out_x, config->out_y, config->out_w, config->out_h);
+
+	return str;
+}
+
 struct komeda_plane_state;
 struct komeda_crtc_state;
 struct komeda_crtc;
@@ -532,22 +546,27 @@ int komeda_build_layer_data_flow(struct komeda_layer =
*layer,
 				 struct komeda_plane_state *kplane_st,
 				 struct komeda_crtc_state *kcrtc_st,
 				 struct komeda_data_flow_cfg *dflow);
-int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
-			      struct drm_connector_state *conn_st,
-			      struct komeda_crtc_state *kcrtc_st,
-			      struct komeda_data_flow_cfg *dflow);
-int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
-				   struct komeda_crtc_state *kcrtc_st);
-
 int komeda_build_layer_split_data_flow(struct komeda_layer *left,
 				       struct komeda_plane_state *kplane_st,
 				       struct komeda_crtc_state *kcrtc_st,
 				       struct komeda_data_flow_cfg *dflow);
+int komeda_build_layer_sbs_data_flow(struct komeda_layer *layer,
+				     struct komeda_plane_state *kplane_st,
+				     struct komeda_crtc_state *kcrtc_st,
+				     struct komeda_data_flow_cfg *dflow);
+
+int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
+			      struct drm_connector_state *conn_st,
+			      struct komeda_crtc_state *kcrtc_st,
+			      struct komeda_data_flow_cfg *dflow);
 int komeda_build_wb_split_data_flow(struct komeda_layer *wb_layer,
 				    struct drm_connector_state *conn_st,
 				    struct komeda_crtc_state *kcrtc_st,
 				    struct komeda_data_flow_cfg *dflow);
=20
+int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
+				   struct komeda_crtc_state *kcrtc_st);
+
 int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
 				       struct komeda_crtc_state *kcrtc_st);
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 0930234abb9d..10a0dc9291b8 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -1130,6 +1130,194 @@ int komeda_build_layer_split_data_flow(struct komed=
a_layer *left,
 	return err;
 }
=20
+/* split func will split configuration of master plane to two layer data
+ * flows, which will be fed into master and slave pipeline then.
+ * NOTE: @m_dflow is first used as input argument to pass the configuratio=
n of
+ *	 master_plane. when the split is done, @*m_dflow @*s_dflow are the
+ *	 output data flow for pipeline.
+ */
+static int
+komeda_split_sbs_master_data_flow(struct komeda_crtc_state *kcrtc_st,
+				  struct komeda_data_flow_cfg **m_dflow,
+				  struct komeda_data_flow_cfg **s_dflow)
+{
+	struct komeda_data_flow_cfg *master =3D *m_dflow;
+	struct komeda_data_flow_cfg *slave =3D *s_dflow;
+	u32 disp_end =3D master->out_x + master->out_w;
+	u16 boundary;
+
+	pipeline_composition_size(kcrtc_st, &boundary, NULL);
+
+	if (disp_end <=3D boundary) {
+		/* the master viewport only located in master side, no need
+		 * slave anymore
+		 */
+		*s_dflow =3D NULL;
+	} else if ((master->out_x < boundary) && (disp_end > boundary)) {
+		/* the master viewport across two pipelines, split it */
+		bool flip_h =3D has_flip_h(master->rot);
+		bool r90  =3D drm_rotation_90_or_270(master->rot);
+		u32 src_x =3D master->in_x;
+		u32 src_y =3D master->in_y;
+		u32 src_w =3D master->in_w;
+		u32 src_h =3D master->in_h;
+
+		if (master->en_scaling || master->en_img_enhancement) {
+			DRM_DEBUG_ATOMIC("sbs doesn't support to split a scaling image.\n");
+			return -EINVAL;
+		}
+
+		memcpy(slave, master, sizeof(*master));
+
+		/* master for left part of display, slave for the right part */
+		/* split the disp_rect */
+		master->out_w =3D boundary - master->out_x;
+		slave->out_w  =3D disp_end - boundary;
+		slave->out_x  =3D 0;
+
+		if (r90) {
+			master->in_h =3D master->out_w;
+			slave->in_h =3D slave->out_w;
+
+			if (flip_h)
+				master->in_y =3D src_y + src_h - master->in_h;
+			else
+				slave->in_y =3D src_y + src_h - slave->in_h;
+		} else {
+			master->in_w =3D master->out_w;
+			slave->in_w =3D slave->out_w;
+
+			/* on flip_h, the left display content from the right-source */
+			if (flip_h)
+				master->in_x =3D src_x + src_w - master->in_w;
+			else
+				slave->in_x =3D src_x + src_w - slave->in_w;
+		}
+	} else if (master->out_x >=3D boundary) {
+		/* disp_rect only locate in right part, move the dflow to slave */
+		master->out_x -=3D boundary;
+		*s_dflow =3D master;
+		*m_dflow =3D NULL;
+	}
+
+	return 0;
+}
+
+static int
+komeda_split_sbs_slave_data_flow(struct komeda_crtc_state *kcrtc_st,
+				 struct komeda_data_flow_cfg *slave)
+{
+	u16 boundary;
+
+	pipeline_composition_size(kcrtc_st, &boundary, NULL);
+
+	if (slave->out_x < boundary) {
+		DRM_DEBUG_ATOMIC("SBS Slave plane is only allowed to configure the right=
 part frame.\n");
+		return -EINVAL;
+	}
+
+	/* slave->disp_rect locate in the right part */
+	slave->out_x -=3D boundary;
+
+	return 0;
+}
+
+/* On side by side mode, The full display frame will be split to two parts
+ * (Left/Right), and each part will be handled by a single pipeline separa=
tely,
+ * master pipeline for left part, slave for right.
+ *
+ * To simplify the usage and implementation, komeda use the following sche=
me
+ * to do the side by side split
+ * 1. The planes also have been grouped into two classes:
+ *    master-planes and slave-planes.
+ * 2. The master plane can display its image on any location of the final/=
full
+ *    display frame, komeda will help to split the plane configuration to =
two
+ *    parts and fed them into master and slave pipelines.
+ * 3. The slave plane only can put its display rect on the right part of t=
he
+ *    final display frame, and its data is only can be fed into the slave
+ *    pipeline.
+ *
+ * From the perspective of resource usage and assignment:
+ * The master plane can use the resources from the master pipeline and sla=
ve
+ * pipeline both, but slave plane only can use the slave pipeline resource=
s.
+ *
+ * With such scheme, the usage of master planes are same as the none
+ * side_by_side mode. user can easily skip the slave planes and no need to
+ * consider side_by_side for them.
+ *
+ * NOTE: side_by_side split is occurred on pipeline level which split the =
plane
+ *	 data flow into pipelines, but the layer split is a pipeline
+ *	 internal split which splits the data flow into pipeline layers.
+ *	 So komeda still supports to apply a further layer split to the sbs
+ *	 split data flow.
+ */
+int komeda_build_layer_sbs_data_flow(struct komeda_layer *layer,
+				     struct komeda_plane_state *kplane_st,
+				     struct komeda_crtc_state *kcrtc_st,
+				     struct komeda_data_flow_cfg *dflow)
+{
+	struct komeda_crtc *kcrtc =3D to_kcrtc(kcrtc_st->base.crtc);
+	struct drm_plane *plane =3D kplane_st->base.plane;
+	struct komeda_data_flow_cfg temp, *master_dflow, *slave_dflow;
+	struct komeda_layer *master, *slave;
+	bool master_plane =3D layer->base.pipeline =3D=3D kcrtc->master;
+	int err;
+
+	DRM_DEBUG_ATOMIC("SBS prepare %s-[PLANE:%d:%s]: %s.\n",
+			 master_plane ? "Master" : "Slave",
+			 plane->base.id, plane->name,
+			 komeda_data_flow_msg(dflow));
+
+	if (master_plane) {
+		master =3D layer;
+		slave =3D layer->sbs_slave;
+		master_dflow =3D dflow;
+		slave_dflow  =3D &temp;
+		err =3D komeda_split_sbs_master_data_flow(kcrtc_st,
+				&master_dflow, &slave_dflow);
+	} else {
+		master =3D NULL;
+		slave =3D layer;
+		master_dflow =3D NULL;
+		slave_dflow =3D dflow;
+		err =3D komeda_split_sbs_slave_data_flow(kcrtc_st, slave_dflow);
+	}
+
+	if (err)
+		return err;
+
+	if (master_dflow) {
+		DRM_DEBUG_ATOMIC("SBS Master-%s assigned: %s\n",
+			master->base.name, komeda_data_flow_msg(master_dflow));
+
+		if (master_dflow->en_split)
+			err =3D komeda_build_layer_split_data_flow(master,
+					kplane_st, kcrtc_st, master_dflow);
+		else
+			err =3D komeda_build_layer_data_flow(master,
+					kplane_st, kcrtc_st, master_dflow);
+
+		if (err)
+			return err;
+	}
+
+	if (slave_dflow) {
+		DRM_DEBUG_ATOMIC("SBS Slave-%s assigned: %s\n",
+			slave->base.name, komeda_data_flow_msg(slave_dflow));
+
+		if (slave_dflow->en_split)
+			err =3D komeda_build_layer_split_data_flow(slave,
+					kplane_st, kcrtc_st, slave_dflow);
+		else
+			err =3D komeda_build_layer_data_flow(slave,
+					kplane_st, kcrtc_st, slave_dflow);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /* writeback data path: compiz -> scaler -> wb_layer -> memory */
 int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
 			      struct drm_connector_state *conn_st,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_plane.c
index 98e915e325dd..2644f0727570 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -77,6 +77,7 @@ komeda_plane_atomic_check(struct drm_plane *plane,
 	struct komeda_plane_state *kplane_st =3D to_kplane_st(state);
 	struct komeda_layer *layer =3D kplane->layer;
 	struct drm_crtc_state *crtc_st;
+	struct komeda_crtc *kcrtc;
 	struct komeda_crtc_state *kcrtc_st;
 	struct komeda_data_flow_cfg dflow;
 	int err;
@@ -94,13 +95,17 @@ komeda_plane_atomic_check(struct drm_plane *plane,
 	if (!crtc_st->active)
 		return 0;
=20
+	kcrtc =3D to_kcrtc(crtc_st->crtc);
 	kcrtc_st =3D to_kcrtc_st(crtc_st);
=20
 	err =3D komeda_plane_init_data_flow(state, kcrtc_st, &dflow);
 	if (err)
 		return err;
=20
-	if (dflow.en_split)
+	if (kcrtc->side_by_side)
+		err =3D komeda_build_layer_sbs_data_flow(layer,
+				kplane_st, kcrtc_st, &dflow);
+	else if (dflow.en_split)
 		err =3D komeda_build_layer_split_data_flow(layer,
 				kplane_st, kcrtc_st, &dflow);
 	else
--=20
2.20.1

