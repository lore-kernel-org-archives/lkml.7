Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED90C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB172341C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MWfexYje";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MWfexYje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfH3JJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:09:25 -0400
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:9639
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726653AbfH3JJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSMc1HqSU+dzendcqlE9OfD9/c0XihGFHJVU3k7trI8=;
 b=MWfexYje0ICxVEZwVm2Lu/JyrRkKBu6JTwLWMzsBs4cgv5DPPD8lFoPEP611QodrR9wqgMHvVbqWtqIzTuBy4QsoZfQkM4t3FTqcwH9KD+liB2PrhZiX+gHRrZhZE/hhkHfvDvuSVTuzDdlTX16XOD5WN3JAyXre0TmjRseCiGI=
Received: from AM6PR08CA0045.eurprd08.prod.outlook.com (2603:10a6:20b:c0::33)
 by AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Fri, 30 Aug
 2019 09:09:15 +0000
Received: from VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by AM6PR08CA0045.outlook.office365.com
 (2603:10a6:20b:c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.19 via Frontend
 Transport; Fri, 30 Aug 2019 09:09:15 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT046.mail.protection.outlook.com (10.152.19.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Fri, 30 Aug 2019 09:09:13 +0000
Received: ("Tessian outbound f83cc93ed55d:v27"); Fri, 30 Aug 2019 09:09:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 33a83909e35bc09e
X-CR-MTA-TID: 64aa7808
Received: from b8f5e11fa501.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E6D07AB8-7E5C-4BB6-8533-857B34935776.1;
        Fri, 30 Aug 2019 09:09:04 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b8f5e11fa501.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 30 Aug 2019 09:09:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0Q+hoHo73AcGsGA5vIaMzqnY1k/BzibpKp7qskepjgYnGw+S232JWIBPG44DF6D/pI6ZvdtySvCK8gd96EphIG3AmJwZr5AExOKBZwaIQ/RgxeYQguqqQnt3iT2Xh8Us6F+X0ay42vb6aLTVzW4B4PmktcuOKyIgh6QFCXao0rShu+6U2+3hsj+521wwJvVpyYhUjSHgOHxOxg3YBA5Gv/xX7GJYRAjU7tX4MrmeMnu+maFoQgjFLuqws21HSEV81T9+wZNVOyccbkUb6Rg9s7qn8cUZdtrRB7ocDpJPbMav5rbfzM4mHOa3leUoWVdf46hKVUKpL8Hde8icZ9c9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSMc1HqSU+dzendcqlE9OfD9/c0XihGFHJVU3k7trI8=;
 b=T7HNRA4RhQagVLyX0VHsjJZmOpmG7RIDBYC0p/KZ32fCveb9PUMcuhejcWGIgNuHIBGZ9SvAf43b8v2I/lJ5XbJHDUkQlXJPKE/nw5+eXKSjTybAiVAzsIPPwXCpbH7tCL2bVT/aDs8Pc0LF3eNa779FOTUOdqTBiY1qT4uqA7T/EobsoGlZZwsap2E5mg2tbbCHS/FiqxnYkMKP50NbwQ9e4mdOu+Es0pYZ3hbu2fkdnfrzCBIfYbP/A8wAdsF6tKlnY8h/qms13sIhg89H4+bNQA1qtBNxo9pOrgvJXUHCzEdLgwN5SsoedYAaABmYUKRVidTsZYtO+Gk7XH/YBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSMc1HqSU+dzendcqlE9OfD9/c0XihGFHJVU3k7trI8=;
 b=MWfexYje0ICxVEZwVm2Lu/JyrRkKBu6JTwLWMzsBs4cgv5DPPD8lFoPEP611QodrR9wqgMHvVbqWtqIzTuBy4QsoZfQkM4t3FTqcwH9KD+liB2PrhZiX+gHRrZhZE/hhkHfvDvuSVTuzDdlTX16XOD5WN3JAyXre0TmjRseCiGI=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3968.eurprd08.prod.outlook.com (20.178.125.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 30 Aug 2019 09:09:02 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b%3]) with mapi id 15.20.2220.013; Fri, 30 Aug 2019
 09:09:02 +0000
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
Subject: [PATCH v1 2/2] drm/komeda: Adds layer horizontal input size
 limitation check for D71
Thread-Topic: [PATCH v1 2/2] drm/komeda: Adds layer horizontal input size
 limitation check for D71
Thread-Index: AQHVXxKQ/pMPgbpj00WfLBjX5GisAQ==
Date:   Fri, 30 Aug 2019 09:09:02 +0000
Message-ID: <20190830090835.8747-3-lowry.li@arm.com>
References: <20190830090835.8747-1-lowry.li@arm.com>
In-Reply-To: <20190830090835.8747-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::14) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 1b3ea689-52ce-43ec-b2a7-08d72d29ba5e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3968;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3968:|VI1PR08MB3968:|AM0PR08MB4946:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB49466B0535827DF42DB8995D9FBD0@AM0PR08MB4946.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4941;OLM:4941;
x-forefront-prvs: 0145758B1D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(4326008)(66446008)(2616005)(25786009)(476003)(8676002)(2906002)(6436002)(2201001)(66556008)(81156014)(81166006)(64756008)(11346002)(99286004)(14454004)(66476007)(5660300002)(486006)(26005)(76176011)(50226002)(86362001)(7736002)(71200400001)(6636002)(66066001)(1076003)(66946007)(71190400001)(446003)(305945005)(186003)(53936002)(3846002)(14444005)(6512007)(110136005)(6486002)(8936002)(2501003)(102836004)(316002)(54906003)(55236004)(478600001)(386003)(6506007)(52116002)(256004)(6116002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3968;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: H2PdfDSjdup/gutTsHBBmHRHR8kawuYE/5qji4XmhRlJsd7/Dx8EUm9JuZ8Wpq5syZmeyuUMBFXX01+qE+gstfOWNQCdY13R+6cn9uWKdXSaYxFRcOUpcCEv5irdgCAzxeBtC7K2Gs/ATsBTx5wfn7tpeZ35+U9EI3vB8UW1swmDTKjqM56QGh665RvQqMtRD/33fd6+LWgt8MkfzWNs/8JFhUAUcfwQUZ4uW4gUTeq/5NhhHKPcgb1f24clWKwMuZj+jKZ1dgqDvoqHdQvoqjvRlOuFQSga2RR9Bs0DEr8G8uY6m4wm6b+I9RcAe00BMTpEd7oUVzQWJkp2llRFAdOSOqrEAEwszvj2mlM+5HHfvaroBM0YMZh1oGsnpNhC6QPKvQtQQTs4tQ7sVF7asrVVUSj6ioQiWryOd20U0LA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3968
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(2980300002)(199004)(189003)(36906005)(26005)(478600001)(1076003)(2501003)(6486002)(2906002)(22756006)(6506007)(47776003)(8746002)(5660300002)(23756003)(50466002)(99286004)(486006)(386003)(26826003)(476003)(2616005)(14454004)(14444005)(7736002)(126002)(446003)(6636002)(54906003)(63350400001)(63370400001)(86362001)(186003)(102836004)(66066001)(336012)(8676002)(81166006)(2201001)(6512007)(81156014)(305945005)(70586007)(110136005)(36756003)(4326008)(70206006)(3846002)(6116002)(356004)(50226002)(76130400001)(25786009)(8936002)(76176011)(11346002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4946;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 75274041-b547-41ab-da49-08d72d29b312
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB4946;
NoDisclaimer: True
X-Forefront-PRVS: 0145758B1D
X-Microsoft-Antispam-Message-Info: jIQ0yLRVVuTbsk99n5/ybULzm8kSJ9o0bJleEhbezRo7yQ5jZHtfAeF8Ki2lcnIEyD5JOO7ocLcFhnkgWN7JmQ1mW25qFKiDDOV3t+2vaFpj2p3VIy2QI9ym5ad0tNOGJxj8fSxLFPH+ixjEz773JkpjRqcx34aM5k/uS6rl8BduVtJmbIJ/zJaDAFM8MFd2mA2nOeuXWBu5oGC2fE1ySBLbhTO+31wAekBYKsq/DQmgtbuClwdUq3mSkMCwt7rYtiU+T/fIbHi7sthtFCP/vBxvfljZR3U55r9YTMrDk6KaR7Yau2kvJ9/wLN9zfsjFS5AXkgPFv+9s0ZX0zsSP5QturqX4DxfOS2Bf4iSVShFIKu4jrAOXDS9nuvS5ooV9t33q9HvAOMcqokWL+hOBh1T3FZp9P+vgK5/dgQipb/M=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2019 09:09:13.8630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3ea689-52ce-43ec-b2a7-08d72d29ba5e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds maximum line size check according to the AFBC decoder limitation
and special Line size limitation(2046) for format: YUV420_10BIT and X0L2.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index a56dc56a72fb..41b5bfcbd027 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -401,7 +401,56 @@ static void d71_layer_dump(struct komeda_component *c,=
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

