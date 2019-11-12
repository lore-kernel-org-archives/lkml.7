Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4775BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086352084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Jg3VvbJR";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Jg3VvbJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKLLKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:10:45 -0500
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:22529
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727103AbfKLLKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TQq3bHNRrYQiNPP2nRVJpod47h6p3GxLvGsKKnTnHo=;
 b=Jg3VvbJRrIKCj3qicJQjXB8r4R7iHRiMi1Wk6dGoQBN2uPhQa69Pi3QDVVVocMJdZs3Z+XhENDMlw2WBQgJ7dvP+DVb0l4aEz9OhUjetiInVtRHYyZa0x4wNlOc/esMKqHnIfcgcZSEzCK42VIV4g2Lu1m2HuJN+scQMbNhdv/Y=
Received: from VI1PR08CA0204.eurprd08.prod.outlook.com (2603:10a6:800:d2::34)
 by AM5PR0801MB2002.eurprd08.prod.outlook.com (2603:10a6:203:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Tue, 12 Nov
 2019 11:10:37 +0000
Received: from AM5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by VI1PR08CA0204.outlook.office365.com
 (2603:10a6:800:d2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24 via Frontend
 Transport; Tue, 12 Nov 2019 11:10:37 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT018.mail.protection.outlook.com (10.152.16.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.21 via Frontend Transport; Tue, 12 Nov 2019 11:10:36 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Tue, 12 Nov 2019 11:10:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a83d946742e964e9
X-CR-MTA-TID: 64aa7808
Received: from 1f1d18babe21.2 (cr-mta-lb-1.cr-mta-net [104.47.4.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 386D1A82-C481-45AE-A5C2-96C1125E984D.1;
        Tue, 12 Nov 2019 11:10:30 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1f1d18babe21.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 12 Nov 2019 11:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGKYJbqpRpOr7fI9BHGsHaY9ebh7C5DP2v33xm0Yu8L8FAUPEXDs9z3hTv9prLqd+yYeVP2EABdWbXg0F2BdfCe3TEbIOZi/0OnwgHb8dmJ6TAkR1vtlpXWkbQnJJ3lLPt9FyzrQ8pxNsBfLXHLUJh/93uONRSgT3B2ZDlwcd87nrvikclSJiHv+tCbP0F69rE226unSiUqSBzIYlNhNZz7xR9ZmqBAqTdxiFsukZdTRDe07Uvpo60/8FMcXqfzjY0PPUEkb5KkGWRSbr97y69qvLqWKYNk577KvsPluy7kspgCK4bsC+lUwimKUyGV+7EhADzRtxfrgLoGKVEMfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TQq3bHNRrYQiNPP2nRVJpod47h6p3GxLvGsKKnTnHo=;
 b=LREk9pGuKu4nbZt7Pcql8QVnWkhCzfkbROuwaIGLbGsC/tPTqDZdQlCD4KpCHAOAOniTY2EtxMGcUDZuTf3OAzF7bGJFnl71GXz99BIP+z49ER10ImSEb3jg3dq7QdwjV7RwXoZgZowMqOONOw2MbXVqZU3UrCJvmeJ0hWYjy/Y/5WtCVrmUL1BevelSZ4CIJDN4MtYTS3vZT1Yf3SqnrOqeZ1Dnzx4IA1nDmoKmySIqRa++/MIlU+KOKOsZRDxaC0+cyvoUAFuqfTAkLqkYOuyP7cfhIbHphl7UeZ9z+4b4ipn9U7U60nZkfPosp3u/s2n9O+0CEhD0W30ZqDDY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TQq3bHNRrYQiNPP2nRVJpod47h6p3GxLvGsKKnTnHo=;
 b=Jg3VvbJRrIKCj3qicJQjXB8r4R7iHRiMi1Wk6dGoQBN2uPhQa69Pi3QDVVVocMJdZs3Z+XhENDMlw2WBQgJ7dvP+DVb0l4aEz9OhUjetiInVtRHYyZa0x4wNlOc/esMKqHnIfcgcZSEzCK42VIV4g2Lu1m2HuJN+scQMbNhdv/Y=
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com (10.255.30.207) by
 AM0PR08MB3636.eurprd08.prod.outlook.com (20.177.43.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 11:10:28 +0000
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0]) by AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:10:28 +0000
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
Subject: [PATCH v10 4/4] drm/komeda: Adds gamma and color-transform support
 for DOU-IPS
Thread-Topic: [PATCH v10 4/4] drm/komeda: Adds gamma and color-transform
 support for DOU-IPS
Thread-Index: AQHVmUnKXB2pUdf+WkK/8QFKQOe03w==
Date:   Tue, 12 Nov 2019 11:10:28 +0000
Message-ID: <20191112110927.20931-5-james.qian.wang@arm.com>
References: <20191112110927.20931-1-james.qian.wang@arm.com>
In-Reply-To: <20191112110927.20931-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To AM0PR08MB4995.eurprd08.prod.outlook.com
 (2603:10a6:208:162::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c40f2efd-955e-449f-7f56-08d76760f1f8
X-MS-TrafficTypeDiagnostic: AM0PR08MB3636:|AM0PR08MB3636:|AM5PR0801MB2002:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB20020A6715B820AAF828D915B3770@AM5PR0801MB2002.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2582;OLM:2582;
x-forefront-prvs: 021975AE46
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(2906002)(99286004)(446003)(2616005)(476003)(7736002)(66066001)(6512007)(6436002)(6486002)(11346002)(54906003)(256004)(305945005)(103116003)(14444005)(110136005)(316002)(2201001)(14454004)(6116002)(2501003)(86362001)(3846002)(486006)(71200400001)(71190400001)(186003)(386003)(36756003)(1076003)(6506007)(5660300002)(81166006)(8676002)(4326008)(50226002)(26005)(76176011)(66946007)(2171002)(52116002)(81156014)(66446008)(102836004)(66476007)(64756008)(8936002)(66556008)(25786009)(55236004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3636;H:AM0PR08MB4995.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZcQSEobQAwvDHgwghG8xPqBZs5Y9xYTiJO7DVWJSkdQU4BRD5+dmIe6ViqfluZA5NwO0yNQPorUA0jH3S9daytjE0zS5bTynhSJVQSxpkVLXGwr21BsxBStwTVOH4IfWaB8xvlwPA1nc3FsJzLLitBgg2J9Ttj3FxWPD1kh3EJgQDBbK3HRcqbyD0VThGGKsXYm7pRW/mHRTzUh+HMw2GkgaLcGvLKgjEgM1PBzExExqEk8pCBCkrkU0MtOkl3gvY5KcMo28aVHKWNy2uesZVT8Jpl2Qxl8elZCLG8u9BEAuY6WsoaVqeRIvw/buWUXdApjJhvgcLdB13WT5mXMMvlRk4kNy6szVz8HyNEMwgxBkPiK8T811Vc9ixjEX34RCsLjU8zqw3GLhe5CBa+/CO5ecGVpjg/vIWhX7c0xDO+V0we2iUnfnNHT9VEcbqRLQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3636
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(1110001)(339900001)(199004)(189003)(6116002)(103116003)(6486002)(54906003)(478600001)(70586007)(14444005)(486006)(70206006)(3846002)(47776003)(4326008)(2171002)(6512007)(23756003)(36906005)(2201001)(110136005)(316002)(126002)(26826003)(86362001)(14454004)(81156014)(7736002)(50226002)(5660300002)(102836004)(8936002)(2906002)(81166006)(186003)(6506007)(26005)(76176011)(386003)(66066001)(476003)(8746002)(305945005)(22756006)(8676002)(105606002)(76130400001)(2616005)(50466002)(99286004)(36756003)(1076003)(25786009)(2501003)(356004)(336012)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB2002;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 74479d40-06fa-44af-5c4e-08d76760eca5
NoDisclaimer: True
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLcQaitDdRBJVq5hxRL4k1qBGzyHAusEvI+GuiabLGixA/nsd3C0FfSX1w36IPNFnIUQwFqG9pepSYNgDjrsF56Kz5Ct5jsFcJVK54gJ19Q7oXmi8HIbymUx0Nu4gFtL8SGyAEYaU3UVG6NyRhZ+JmTs8i+bgSa1CVf2Z6WF7ZAv0UYbbJuVhz1Q52sLuHh953pHb+9mFOYDc8DC480m2edKRknpPVa7dTdUXQLVj6CvWcOqKO2RKWEWAnrZgLbOa3gz2Mdoia7ODrrc6/zt/g6PLOHXmQ6rnGTsp0AACTP1qkx0BFkw2PMEyIvkpTs18dfhWbiIbzY5dKZlEHkxc8VWy6ixbeVaU7xeSnpp1rNWZoJSP4dJEKXFWR5pk9Y1WiNM2GusZJV0vXqJ+p0oH7IlrEq8Q1+DRrQJzkMsRnrP/53nMjOb8beyGUAaKr14
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 11:10:36.9629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c40f2efd-955e-449f-7f56-08d76760f1f8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2002
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

