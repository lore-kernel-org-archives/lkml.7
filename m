Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1B2C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60D921783
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ml5iZMVD";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ml5iZMVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438865AbfIXIBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 04:01:13 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:17024
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405186AbfIXIBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=432SZBl+XgNRowFEJpvuppz3A/j8ZcamL456V3bwWEE=;
 b=Ml5iZMVDZPxpeMG4PwAMZeC5oP8T0GktvNMruvTgW4ls+BRDdOiaebV2UXH1l9LegkpyS9bb/YZ/1NXAjV1aLz++pVfSXrp1/1jKSmDG1FoMOFgqc9yW/a4ZUxa0C4XpY/UGT5wnHQjmdAUgoml72qY+90ECjYA6RmxaoQXaVdg=
Received: from VI1PR08CA0118.eurprd08.prod.outlook.com (2603:10a6:800:d4::20)
 by AM0PR08MB4451.eurprd08.prod.outlook.com (2603:10a6:208:142::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Tue, 24 Sep
 2019 08:01:05 +0000
Received: from VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR08CA0118.outlook.office365.com
 (2603:10a6:800:d4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Tue, 24 Sep 2019 08:01:05 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT030.mail.protection.outlook.com (10.152.18.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Tue, 24 Sep 2019 08:01:03 +0000
Received: ("Tessian outbound 968ab6b62146:v31"); Tue, 24 Sep 2019 08:00:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 43709aea24852b2a
X-CR-MTA-TID: 64aa7808
Received: from 5795323429b6.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D03866E2-2541-4477-A523-3DBB1954CFBA.1;
        Tue, 24 Sep 2019 08:00:53 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2055.outbound.protection.outlook.com [104.47.0.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5795323429b6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 24 Sep 2019 08:00:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k48E04jdjUIqICSRAhcpPVAC2A6VvOvk3Etuptg5BpK0r2kGgpoHyk8fRUXQEefa2ZOZFAtwVbtzOpODd2ABofit3hEDxjYTVJOHDkWvIEAwb+1z9WO/f8dgsj5dC17JJEUzxvX1Zf6XhxP1XVaHqqI9R6rlCHvcZyD22PMxT0b3WhhvqZSfgFNtXp1VjSLgtA03tlJuis8s7EPryZIhT3+xJC6Yr9U5yJVty/1L/FQ1EpAS9WQADKndcG9Em1ch51c1c3fW/kq+Q1C6F6xLjdD3yDXspdt6c/VmDK8VT2M5c43/5NvsS926ZFNLlz8pT9m8VooMnrDposliWA6GkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=432SZBl+XgNRowFEJpvuppz3A/j8ZcamL456V3bwWEE=;
 b=MyMcZOF6faL/3kO0L0z3snuGJwKR3W0bb21wJBMLVUVRLUCIbSLvWasscX9EDgtdIsq1+y17cZ0KlPy3lzVGO1IZqWvPJ6qDPLYmI23TMGamBBINoDwNGSY5NM5NuaOPfARKfjVjG1LTFk4Kc48zTY4CChZ0nhXTPCrA88+ppUxaDaDd80ytTmb8WfKCswvyEC5IIsxPmwXjpTW6NWnoYv+8ljunSMIktzudF124/LXO3aR/6OCRP8v6yyt4o10Iab1uHTQfQZRsv+MH5PMdlGkUEij+Rijj5lD+t1MISW0qsGy86fhb9Wk9P8/5R93oMlFwmYCwsgjSgYg3REEIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=432SZBl+XgNRowFEJpvuppz3A/j8ZcamL456V3bwWEE=;
 b=Ml5iZMVDZPxpeMG4PwAMZeC5oP8T0GktvNMruvTgW4ls+BRDdOiaebV2UXH1l9LegkpyS9bb/YZ/1NXAjV1aLz++pVfSXrp1/1jKSmDG1FoMOFgqc9yW/a4ZUxa0C4XpY/UGT5wnHQjmdAUgoml72qY+90ECjYA6RmxaoQXaVdg=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3342.eurprd08.prod.outlook.com (52.134.31.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 08:00:50 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b%3]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 08:00:49 +0000
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
Subject: [PATCH v2 2/2] drm/komeda: Adds layer horizontal input size
 limitation check for D71
Thread-Topic: [PATCH v2 2/2] drm/komeda: Adds layer horizontal input size
 limitation check for D71
Thread-Index: AQHVcq4tpEcv3GJQ1Eqd/4hiDuATxQ==
Date:   Tue, 24 Sep 2019 08:00:49 +0000
Message-ID: <20190924080022.19250-3-lowry.li@arm.com>
References: <20190924080022.19250-1-lowry.li@arm.com>
In-Reply-To: <20190924080022.19250-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::34) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 1f6708f8-fcfb-4b66-73e0-08d740c558e5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3342;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3342:|VI1PR08MB3342:|AM0PR08MB4451:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB44513366F451C4710DFECF8E9F840@AM0PR08MB4451.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4941;OLM:4941;
x-forefront-prvs: 0170DAF08C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(6116002)(66066001)(1076003)(81166006)(305945005)(71190400001)(14444005)(186003)(71200400001)(2906002)(25786009)(66946007)(52116002)(6512007)(446003)(8676002)(478600001)(64756008)(66556008)(11346002)(316002)(7736002)(386003)(6506007)(476003)(54906003)(2616005)(36756003)(6486002)(76176011)(486006)(66446008)(86362001)(110136005)(5660300002)(66476007)(14454004)(50226002)(6636002)(55236004)(81156014)(3846002)(8936002)(4326008)(2201001)(102836004)(26005)(99286004)(6436002)(256004)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3342;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: LGXSt/yIp7pcZUvNuKFxRz/srddymqUfYDNiKMCdsqJbPguqeOcHJZqo6LT5LgOFQTSC/Ty5tqxoLlsyS6HAm2Bz0AzTpR8OYyOJSIagYSShocHkdT8z8y1rXJMi/q75aqPe3H3LdSGgaPlF6QQFUbHS1deZ3TbQ6Ar+Eu3VbV9AU7YHqALH8CbD2WzvqaylHkIvcl67Y5macLPUC8RB7DfxsQru/tZm9INWdFBzy1dzPjCUp3gIJ5KwNAm4cLDYPg8zV0fDW4QvUiJynIIqjqhn0HTaDjcWxyrxlNt2qHhpTXJhylJKjn9+4JiLruaBu/OZM+sfuXBJaAgEOJTv4dx/xRguxJzhmSgKIRhv0pNz/0f5cTK8soN0f6deFMEY+JlGL3+frIjqvbBoWQOj+9D93o6R9zf7ysEgnxXy62s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3342
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(189003)(199004)(2201001)(478600001)(66066001)(3846002)(186003)(356004)(6116002)(2906002)(11346002)(102836004)(4326008)(26005)(336012)(446003)(126002)(2616005)(486006)(14454004)(386003)(6506007)(25786009)(23756003)(47776003)(36756003)(99286004)(2501003)(76176011)(70586007)(70206006)(1076003)(7736002)(76130400001)(6486002)(63350400001)(476003)(316002)(110136005)(26826003)(54906003)(81166006)(14444005)(36906005)(8746002)(8936002)(50226002)(305945005)(6512007)(86362001)(8676002)(6636002)(81156014)(5660300002)(22756006)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4451;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8d72181d-ab46-4505-75e0-08d740c5504a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR08MB4451;
NoDisclaimer: True
X-Forefront-PRVS: 0170DAF08C
X-Microsoft-Antispam-Message-Info: c5IuokTgWczRJ+bmI/kPOr8eYjAicKYQ6s8jdm//RDGTac2wlhb31WhYwhM28V3sLfLQ1OEP/qRsNn02L8rUzzHWLgAG0ZGy1/SYpMVOMWneLyIyTb6jNN6V2HV5sSGH9xFjeMpaZNN+RRw8cM3gtzdNJ6JEiFEKL61p4iY+d8s7Jy+x/RO1aeEgRg1Affbg93n+TCWGSAf3qUQpUertjAjmBz97ECqYlzP6vePYpAO0ILGam1FrIbSIPbBG9QMA3ZmW81sQFXlfXUXjnA5dcmzKqOrdyPux7/h/B/w+u3U3zL6KYTLqH4Z/mHNAESMBJERc9/eVEFUVYsi6jCCWzciNghBr2P6Za/yefyUC8wtQXR+tf26DO6FRLPJfNcP+GF6r1ZwS9knHC13cIGs8xu7XffkMKggljAlYJXIbvbw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2019 08:01:03.9321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6708f8-fcfb-4b66-73e0-08d740c558e5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>

Adds maximum line size check according to the AFBC decoder limitation
and special Line size limitation(2046) for format: YUV420_10BIT and X0L2.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index 357837b9d6ed..6740b8422f11 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -349,7 +349,56 @@ static void d71_layer_dump(struct komeda_component *c,=
 struct seq_file *sf)
 	seq_printf(sf, "%sAD_V_CROP:\t\t0x%X\n", prefix, v[2]);
 }
=20
+static int d71_layer_validate(struct komeda_component *c,
+			      struct komeda_component_state *state)
+{
+	struct komeda_layer_state *st =3D to_layer_st(state);
+	struct komeda_layer *layer =3D to_layer(c);
+	struct drm_plane_state *plane_st;
+	struct drm_framebuffer *fb;
+	u32 fourcc, line_sz, max_line_sz;
+
+	plane_st =3D drm_atomic_get_new_plane_state(state->obj.state,
+						  state->plane);
+	fb =3D plane_st->fb;
+	fourcc =3D fb->format->format;
+
+	if (drm_rotation_90_or_270(st->rot))
+		line_sz =3D st->vsize - st->afbc_crop_t - st->afbc_crop_b;
+	else
+		line_sz =3D st->hsize - st->afbc_crop_l - st->afbc_crop_r;
+
+	if (fb->modifier) {
+		if ((fb->modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) =3D=3D
+			AFBC_FORMAT_MOD_BLOCK_SIZE_32x8)
+			max_line_sz =3D layer->line_sz;
+		else
+			max_line_sz =3D layer->line_sz / 2;
+
+		if (line_sz > max_line_sz) {
+			DRM_DEBUG_ATOMIC("afbc request line_sz: %d exceed the max afbc line_sz:=
 %d.\n",
+					 line_sz, max_line_sz);
+			return -EINVAL;
+		}
+	}
+
+	if (fourcc =3D=3D DRM_FORMAT_YUV420_10BIT && line_sz > 2046 && (st->afbc_=
crop_l % 4)) {
+		DRM_DEBUG_ATOMIC("YUV420_10BIT input_hsize: %d exceed the max size 2046.=
\n",
+				 line_sz);
+		return -EINVAL;
+	}
+
+	if (fourcc =3D=3D DRM_FORMAT_X0L2 && line_sz > 2046 && (st->addr[0] % 16)=
) {
+		DRM_DEBUG_ATOMIC("X0L2 input_hsize: %d exceed the max size 2046.\n",
+				 line_sz);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct komeda_component_funcs d71_layer_funcs =3D {
+	.validate	=3D d71_layer_validate,
 	.update		=3D d71_layer_update,
 	.disable	=3D d71_layer_disable,
 	.dump_register	=3D d71_layer_dump,
--=20
2.17.1

