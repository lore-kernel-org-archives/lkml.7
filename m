Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C6FC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B340A214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FgmWlPls";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FgmWlPls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409306AbfIXH0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:26:34 -0400
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:6272
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409285AbfIXH0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZsp5b9CREF6o15QmOw7iKDF5xz9u0ShN5TG4mS9xYQ=;
 b=FgmWlPlsjZjAkUp4vR0jFGLtraIiSJQ8Ox8jDce/P1sE3yXXaBoViWlDaVveO72Cg1i/TnJ0B++C8HUd0LcTScpGaRNBDHYT9WaiS+cZ84invRv4YHA/EKGvjJc3egJ9D3dR1x+Zw+Ayb+mtVJexB7Bm8v1IZPxvdBWDF2lAsrM=
Received: from HE1PR0802CA0001.eurprd08.prod.outlook.com (2603:10a6:3:bd::11)
 by AM0PR08MB3826.eurprd08.prod.outlook.com (2603:10a6:208:105::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Tue, 24 Sep
 2019 07:26:27 +0000
Received: from AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by HE1PR0802CA0001.outlook.office365.com
 (2603:10a6:3:bd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Tue, 24 Sep 2019 07:26:27 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT016.mail.protection.outlook.com (10.152.16.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25 via Frontend Transport; Tue, 24 Sep 2019 07:26:25 +0000
Received: ("Tessian outbound 5061e1b5386c:v31"); Tue, 24 Sep 2019 07:26:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e48258766da11404
X-CR-MTA-TID: 64aa7808
Received: from 12b73542b0cc.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 61407BBD-25A9-4578-952B-CA282CD94D24.1;
        Tue, 24 Sep 2019 07:26:15 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2056.outbound.protection.outlook.com [104.47.2.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 12b73542b0cc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Sep 2019 07:26:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+m0IoCG6aM3XJXJA5a9Af4nwBeaXAhngPUH/Q06zvjFrt4/juMc5hL2IhKfHV9Toi4eRqLviYUArqgEtV2hxB7nf72GZ/LLu11x3Km4F97QKcV88k2yEkz1AOtcvn2Jbelu9rA0t5m/6j+H0AqkygT8IL8zw+CUXKit9BOoAAPq2LbOf5DZGAY+TQeMtCoajdU0lyFmHLZmX3mXKaEACruvAKnJ2Ti6nRDNAVChwkz1zOVwpCBtzjb3x3a6w5U5VXIsW2olf9IOCAnyRJJVT2XbR1nomvz/Vk7PylhzTNE7lznUbqv0J0R7kCXzjCLuc568iNCYI77MatWA3dPURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZsp5b9CREF6o15QmOw7iKDF5xz9u0ShN5TG4mS9xYQ=;
 b=XCWHe15irX8oozp8HgZKEr9u3bjNhX09CpxwutvUSkPhuKO9kalliV8BK9C5YLfu93LQzRIDrUZA2slrnzjt/BBdGWtOia6r0WS/HeG168qyLKD/WrB7/W63Igl3RAfJh0PxcZH8JddA0Iw9XJbwuQKR6j2QXQf+W13AZxzvniFaohTYNx8DHoAm9DkPwsltO83/DsRnD4aQajPSlGQ72Dkye31nYcIBgiiQhudZRNohtBXVUEWRqq2jBc/XI7CUYVqXAYEmY/gjzJDSXGv7fzNm7wriDtSA5z6ZXnSLc0AtdgmSrxqQfnv3fsvKF0aMSvwNihwlxyfprhAA6nx66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZsp5b9CREF6o15QmOw7iKDF5xz9u0ShN5TG4mS9xYQ=;
 b=FgmWlPlsjZjAkUp4vR0jFGLtraIiSJQ8Ox8jDce/P1sE3yXXaBoViWlDaVveO72Cg1i/TnJ0B++C8HUd0LcTScpGaRNBDHYT9WaiS+cZ84invRv4YHA/EKGvjJc3egJ9D3dR1x+Zw+Ayb+mtVJexB7Bm8v1IZPxvdBWDF2lAsrM=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3998.eurprd08.prod.outlook.com (20.178.126.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 07:26:13 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b%3]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:26:13 +0000
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
Subject: [PATCH v2 1/2] drm/komeda: Add line size support
Thread-Topic: [PATCH v2 1/2] drm/komeda: Add line size support
Thread-Index: AQHVcqlYDphWl6Q560C4rpnwGAgy5A==
Date:   Tue, 24 Sep 2019 07:26:13 +0000
Message-ID: <20190924072552.32446-2-lowry.li@arm.com>
References: <20190924072552.32446-1-lowry.li@arm.com>
In-Reply-To: <20190924072552.32446-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::16) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: e837bcf1-a3cd-443d-2fad-08d740c08212
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3998;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3998:|VI1PR08MB3998:|AM0PR08MB3826:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB382693B715A828D9988A8A9B9F840@AM0PR08MB3826.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 0170DAF08C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(50226002)(102836004)(478600001)(55236004)(66556008)(316002)(4326008)(66946007)(2501003)(25786009)(476003)(11346002)(186003)(66066001)(2616005)(52116002)(26005)(6506007)(386003)(54906003)(99286004)(446003)(76176011)(5660300002)(6116002)(66446008)(3846002)(8936002)(486006)(1076003)(86362001)(8676002)(110136005)(66476007)(64756008)(81156014)(6486002)(36756003)(6636002)(71200400001)(71190400001)(14454004)(2906002)(6512007)(81166006)(2201001)(7736002)(6436002)(305945005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3998;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: +rso/FxiU4b0tJ+AttQQUsaIuIeTtZ8CmPg+O2thu+FJqH9ULjRoIwK5I43j4cpQ7KIxsuCpk/8kpXWQnVKNQt4/PnrvxuUF2G2nWobmAUWYoNEYCjTTIwP5s+Eeed16MeJbmZuvD1mVJYjSHqODMWGcXpI7NvOLPUIKGy7afuXfCwqfG6vnMr++Zhqt3DoOHcmH65mQ9JQygAfZpauk2EUzTFKqrxd/aeTiOc+lNhY1mgWsNbZEZqpE2N7V8lOufDcbBnN7qhgPLuPSoZ1fpvo6kvLKFBs0WyZF4OgiaGrhaCePGbxnIU0rQHFYq80H7IFiRRzJ8Brp2nF6cLc90HNNkIW1663Ocl8c2iEim6p6FE63eixsAEPc8wJ8aTH5eg/iMuFxmxkrMWOFeSMKgoUpJfqVM4qtt8jXyYGuf28=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3998
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(22756006)(36756003)(478600001)(2616005)(50466002)(50226002)(476003)(66066001)(70206006)(70586007)(86362001)(356004)(6486002)(8676002)(11346002)(26826003)(6512007)(54906003)(14454004)(1076003)(81156014)(8746002)(63350400001)(446003)(8936002)(81166006)(336012)(6636002)(486006)(102836004)(26005)(316002)(76176011)(36906005)(23756003)(110136005)(305945005)(7736002)(3846002)(6506007)(99286004)(386003)(6116002)(5660300002)(2201001)(126002)(2501003)(186003)(25786009)(47776003)(4326008)(76130400001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3826;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 01974bbc-ba72-4081-9387-08d740c07a81
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB3826;
NoDisclaimer: True
X-Forefront-PRVS: 0170DAF08C
X-Microsoft-Antispam-Message-Info: 2PNNJ28RuMawLqnLdgLvX5YSUMt2ok/qzatvQahY8U5Wnrmu1pVmVrmA6GkGtlh5xVwB2LzoDZeRrVfZOo/J30gsm4al7l7osKHOLD44u9NLE7FQXsy6bR9hJgJiP78TVJ54PJ2J44M1U8dxKkNcgThKAmSEv5ZfVKvgIoPNxJhasnK4TGFKyVDP7+HMlCCMbLmCRqVGMLi8Cd5XuoEgLfCWFP3jmGWvG6paZx/gQxZdTvOHFrstYegWCshmV2wnkyJtwFWLVDSdpVPbNn9gMVMnl45lAZoECZxfxD816AuFTpLLU15CJuMPcXU9QrlZgZRY5VehONpqflJCqd2yAXWsvXCf3b5hv6Tm/1BbwEmBp7Q6Z0bBe0RBQeYIJomOWZ89zaTRv5L0vIWfihWH0d8BbCl7BDBA7lJIgHHrEAA=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2019 07:26:25.5592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e837bcf1-a3cd-443d-2fad-08d740c08212
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3826
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>

On D71, we are using the global line size. From D32, every
component have a line size register to indicate the fifo size.

So this patch is to set line size support and do the line size
check.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 57 ++++++++++++++++---
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h |  9 +--
 .../drm/arm/display/komeda/komeda_pipeline.h  |  2 +
 .../display/komeda/komeda_pipeline_state.c    | 17 ++++++
 4 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index 7b374a3b911e..357837b9d6ed 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -106,6 +106,23 @@ static void dump_block_header(struct seq_file *sf, voi=
d __iomem *reg)
 			   i, hdr.output_ids[i]);
 }
=20
+/* On D71, we are using the global line size. From D32, every component ha=
ve
+ * a line size register to indicate the fifo size.
+ */
+static u32 __get_blk_line_size(struct d71_dev *d71, u32 __iomem *reg,
+			       u32 max_default)
+{
+	if (!d71->periph_addr)
+		max_default =3D malidp_read32(reg, BLK_MAX_LINE_SIZE);
+
+	return max_default;
+}
+
+static u32 get_blk_line_size(struct d71_dev *d71, u32 __iomem *reg)
+{
+	return __get_blk_line_size(d71, reg, d71->max_line_size);
+}
+
 static u32 to_rot_ctrl(u32 rot)
 {
 	u32 lr_ctrl =3D 0;
@@ -365,7 +382,28 @@ static int d71_layer_init(struct d71_dev *d71,
 	else
 		layer->layer_type =3D KOMEDA_FMT_SIMPLE_LAYER;
=20
-	set_range(&layer->hsize_in, 4, d71->max_line_size);
+	if (!d71->periph_addr) {
+		/* D32 or newer product */
+		layer->line_sz =3D malidp_read32(reg, BLK_MAX_LINE_SIZE);
+		layer->yuv_line_sz =3D L_INFO_YUV_MAX_LINESZ(layer_info);
+	} else if (d71->max_line_size > 2048) {
+		/* D71 4K */
+		layer->line_sz =3D d71->max_line_size;
+		layer->yuv_line_sz =3D layer->line_sz / 2;
+	} else	{
+		/* D71 2K */
+		if (layer->layer_type =3D=3D KOMEDA_FMT_RICH_LAYER) {
+			/* rich layer is 4K configuration */
+			layer->line_sz =3D d71->max_line_size * 2;
+			layer->yuv_line_sz =3D layer->line_sz / 2;
+		} else {
+			layer->line_sz =3D d71->max_line_size;
+			layer->yuv_line_sz =3D 0;
+		}
+	}
+
+	set_range(&layer->hsize_in, 4, layer->line_sz);
+
 	set_range(&layer->vsize_in, 4, d71->max_vsize);
=20
 	malidp_write32(reg, LAYER_PALPHA, D71_PALPHA_DEF_MAP);
@@ -456,9 +494,11 @@ static int d71_wb_layer_init(struct d71_dev *d71,
=20
 	wb_layer =3D to_layer(c);
 	wb_layer->layer_type =3D KOMEDA_FMT_WB_LAYER;
+	wb_layer->line_sz =3D get_blk_line_size(d71, reg);
+	wb_layer->yuv_line_sz =3D wb_layer->line_sz;
=20
-	set_range(&wb_layer->hsize_in, D71_MIN_LINE_SIZE, d71->max_line_size);
-	set_range(&wb_layer->vsize_in, D71_MIN_VERTICAL_SIZE, d71->max_vsize);
+	set_range(&wb_layer->hsize_in, 64, wb_layer->line_sz);
+	set_range(&wb_layer->vsize_in, 64, d71->max_vsize);
=20
 	return 0;
 }
@@ -595,8 +635,8 @@ static int d71_compiz_init(struct d71_dev *d71,
=20
 	compiz =3D to_compiz(c);
=20
-	set_range(&compiz->hsize, D71_MIN_LINE_SIZE, d71->max_line_size);
-	set_range(&compiz->vsize, D71_MIN_VERTICAL_SIZE, d71->max_vsize);
+	set_range(&compiz->hsize, 64, get_blk_line_size(d71, reg));
+	set_range(&compiz->vsize, 64, d71->max_vsize);
=20
 	return 0;
 }
@@ -753,7 +793,7 @@ static int d71_scaler_init(struct d71_dev *d71,
 	}
=20
 	scaler =3D to_scaler(c);
-	set_range(&scaler->hsize, 4, 2048);
+	set_range(&scaler->hsize, 4, __get_blk_line_size(d71, reg, 2048));
 	set_range(&scaler->vsize, 4, 4096);
 	scaler->max_downscaling =3D 6;
 	scaler->max_upscaling =3D 64;
@@ -862,7 +902,7 @@ static int d71_splitter_init(struct d71_dev *d71,
=20
 	splitter =3D to_splitter(c);
=20
-	set_range(&splitter->hsize, 4, d71->max_line_size);
+	set_range(&splitter->hsize, 4, get_blk_line_size(d71, reg));
 	set_range(&splitter->vsize, 4, d71->max_vsize);
=20
 	return 0;
@@ -933,7 +973,8 @@ static int d71_merger_init(struct d71_dev *d71,
=20
 	merger =3D to_merger(c);
=20
-	set_range(&merger->hsize_merged, 4, 4032);
+	set_range(&merger->hsize_merged, 4,
+		  __get_blk_line_size(d71, reg, 4032));
 	set_range(&merger->vsize_merged, 4, 4096);
=20
 	return 0;
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h b/drivers/gp=
u/drm/arm/display/komeda/d71/d71_regs.h
index 2d5e6d00b42c..1727dc993909 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
@@ -10,6 +10,7 @@
 /* Common block registers offset */
 #define BLK_BLOCK_INFO		0x000
 #define BLK_PIPELINE_INFO	0x004
+#define BLK_MAX_LINE_SIZE	0x008
 #define BLK_VALID_INPUT_ID0	0x020
 #define BLK_OUTPUT_ID0		0x060
 #define BLK_INPUT_ID0		0x080
@@ -321,6 +322,7 @@
 #define L_INFO_RF		BIT(0)
 #define L_INFO_CM		BIT(1)
 #define L_INFO_ABUF_SIZE(x)	(((x) >> 4) & 0x7)
+#define L_INFO_YUV_MAX_LINESZ(x)	(((x) >> 16) & 0xFFFF)
=20
 /* Scaler registers */
 #define SC_COEFFTAB		0x0DC
@@ -494,13 +496,6 @@ enum d71_blk_type {
 #define D71_DEFAULT_PREPRETCH_LINE	5
 #define D71_BUS_WIDTH_16_BYTES		16
=20
-#define D71_MIN_LINE_SIZE		64
-#define D71_MIN_VERTICAL_SIZE		64
-#define D71_SC_MIN_LIN_SIZE		4
-#define D71_SC_MIN_VERTICAL_SIZE	4
-#define D71_SC_MAX_LIN_SIZE		2048
-#define D71_SC_MAX_VERTICAL_SIZE	4096
-
 #define D71_SC_MAX_UPSCALING		64
 #define D71_SC_MAX_DOWNSCALING		6
 #define D71_SC_SPLIT_OVERLAP		8
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 910d279ae48d..92aba58ce2a5 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -227,6 +227,8 @@ struct komeda_layer {
 	/* accepted h/v input range before rotation */
 	struct malidp_range hsize_in, vsize_in;
 	u32 layer_type; /* RICH, SIMPLE or WB */
+	u32 line_sz;
+	u32 yuv_line_sz; /* maximum line size for YUV422 and YUV420 */
 	u32 supported_rots;
 	/* komeda supports layer split which splits a whole image to two parts
 	 * left and right and handle them by two individual layer processors
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 5526731f5a33..6df442666cfe 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -285,6 +285,7 @@ komeda_layer_check_cfg(struct komeda_layer *layer,
 		       struct komeda_data_flow_cfg *dflow)
 {
 	u32 src_x, src_y, src_w, src_h;
+	u32 line_sz, max_line_sz;
=20
 	if (!komeda_fb_is_layer_supported(kfb, layer->layer_type, dflow->rot))
 		return -EINVAL;
@@ -314,6 +315,22 @@ komeda_layer_check_cfg(struct komeda_layer *layer,
 		return -EINVAL;
 	}
=20
+	if (drm_rotation_90_or_270(dflow->rot))
+		line_sz =3D dflow->in_h;
+	else
+		line_sz =3D dflow->in_w;
+
+	if (kfb->base.format->hsub > 1)
+		max_line_sz =3D layer->yuv_line_sz;
+	else
+		max_line_sz =3D layer->line_sz;
+
+	if (line_sz > max_line_sz) {
+		DRM_DEBUG_ATOMIC("Required line_sz: %d exceeds the max size %d\n",
+				 line_sz, max_line_sz);
+		return -EINVAL;
+	}
+
 	return 0;
 }
=20
--=20
2.17.1

