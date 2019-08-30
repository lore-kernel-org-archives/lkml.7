Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAA3C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8FE2341C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9X89ydxu";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9X89ydxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfH3JJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:09:23 -0400
Received: from mail-eopbgr60073.outbound.protection.outlook.com ([40.107.6.73]:7491
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbfH3JJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpIUF80gtFUGjYDne1JE3vRJP7DQx8AxPmhShOu2w1k=;
 b=9X89ydxuQxASrun1aPT6NDR9vslCFk2ASg51fRAqYrUIstf7WR9f+29z8cVnJVkJk0i9W6S4nRC3OgYgo05t7k3sKI1sl5gGBnAuc6+sarNIFLNEYD1UB/IG0JUpu7o3SVLqcpJlB+M+OSgWZ3NwdJN4D1MDnAtQsrNbxZfaq8Q=
Received: from VI1PR08CA0107.eurprd08.prod.outlook.com (2603:10a6:800:d3::33)
 by VI1PR0801MB1854.eurprd08.prod.outlook.com (2603:10a6:800:5c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18; Fri, 30 Aug
 2019 09:09:10 +0000
Received: from AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by VI1PR08CA0107.outlook.office365.com
 (2603:10a6:800:d3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.19 via Frontend
 Transport; Fri, 30 Aug 2019 09:09:10 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT005.mail.protection.outlook.com (10.152.16.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Fri, 30 Aug 2019 09:09:08 +0000
Received: ("Tessian outbound 802e738ad7e5:v27"); Fri, 30 Aug 2019 09:09:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 29a1aae052f60139
X-CR-MTA-TID: 64aa7808
Received: from 86692351870f.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5CCDC1CC-EB91-48FD-92CB-D5E6C6C9D874.1;
        Fri, 30 Aug 2019 09:08:59 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2053.outbound.protection.outlook.com [104.47.4.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 86692351870f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 30 Aug 2019 09:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlheBtf8ZWHJ2Hw7JPvGvCWWluQu9Ly6Igfkq2nLgEOppSxRQomePm9jaLczAkwG8W3vuRgtvs+n67usfUQpHz99FGplLtnQW9WGwkP/P5ADSQbPTKY1tVV17VMWVFzn8CylxSdTzy8jtMRMTILCndViO1iM3TVsJdEJIkJt9vB35tBYaZUHjlsySPnLmEzOowFDP4gDLZpjIfNVHS8tmnZWYkKzrE8/z3/ag1Hk6OLhTutaTsDErUZ1yYf8aMSrR9NF/79h4kvGqjlAt6FRY6sCiRZcEbvDsYlFXqzlCh5xfkpoMiP1IiKy1HNVNNpQ+bP/76JM5Ni6D+s8VodA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpIUF80gtFUGjYDne1JE3vRJP7DQx8AxPmhShOu2w1k=;
 b=WzeXXpQIsUdaPtRUPjBp+u3OO2HIYkSEQj4VayfZTi2wmLbWTxl+DY3664K3OSj/XWzTh7MEA/j6tUbyt4g3pbLCoQIfFpmf/FFLRpW3PkORNDcVQiwy43jgOTDX4J7EaEcyxtomfQjYXhceBto/FbDf525yRSVr8sUMqi44Z7w5eOgm7iG107T7ERHJCwMbHtsMKijD97HMOlSCCvfB7ESS44QIt4ggWfeArZ/KOIzrwWaVw1D5yolnpMszCQhiXeSYC3byGfsB07slf6jARJUoy1Znf+nNfMuRUvTlYwu/5Xvf7paEBhzuYat9Y27xxlMkcondsX93dgWhRfmi/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpIUF80gtFUGjYDne1JE3vRJP7DQx8AxPmhShOu2w1k=;
 b=9X89ydxuQxASrun1aPT6NDR9vslCFk2ASg51fRAqYrUIstf7WR9f+29z8cVnJVkJk0i9W6S4nRC3OgYgo05t7k3sKI1sl5gGBnAuc6+sarNIFLNEYD1UB/IG0JUpu7o3SVLqcpJlB+M+OSgWZ3NwdJN4D1MDnAtQsrNbxZfaq8Q=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3968.eurprd08.prod.outlook.com (20.178.125.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 30 Aug 2019 09:08:57 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b%3]) with mapi id 15.20.2220.013; Fri, 30 Aug 2019
 09:08:57 +0000
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
Subject: [PATCH v1 1/2] drm/komeda: Add line size support
Thread-Topic: [PATCH v1 1/2] drm/komeda: Add line size support
Thread-Index: AQHVXxKN6AaTkpDpcEmDMqAZzHd17w==
Date:   Fri, 30 Aug 2019 09:08:56 +0000
Message-ID: <20190830090835.8747-2-lowry.li@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b7189b7-35e8-466b-39ce-08d72d29b744
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3968;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3968:|VI1PR08MB3968:|VI1PR0801MB1854:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1854D8A88D68E6053722F23D9FBD0@VI1PR0801MB1854.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 0145758B1D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(4326008)(66446008)(2616005)(25786009)(476003)(8676002)(2906002)(6436002)(2201001)(66556008)(81156014)(81166006)(64756008)(11346002)(99286004)(14454004)(66476007)(5660300002)(486006)(26005)(76176011)(50226002)(86362001)(7736002)(71200400001)(6636002)(66066001)(1076003)(66946007)(71190400001)(446003)(305945005)(186003)(53936002)(3846002)(6512007)(110136005)(6486002)(8936002)(2501003)(102836004)(316002)(54906003)(55236004)(478600001)(386003)(6506007)(52116002)(256004)(6116002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3968;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: OACPd/AC25T7XvgY2Tk1Ovix+axpgzYcj6eLz3ukHp2aTdiBT1CdJxx3yaUd/kJpy51FX/XvoJuzdeUnuTzlu4/G/49fJ86T7FDlJMbcgQSuCEv4IKbzDLFafRZRMBZk7qthHz0xi7LkwySTrrbXf4575omCHyutoaAZttkNOXp3syduClb7ohL79Ei7JU/s0fwIV9d/aHSQcYeUgYn30TpF7yZT4rpXwd+7MRxHB2TF/BvtnY9Yq+g8O5fxiOxnHYR9tw31OnUBPRe+nqfSbD0SW3bX2Jh93FyHHZc4bRkkbEouf9zTZPxmyULZMfdrom4vs6oDrDDHYjv3rKDOyUoS0ECdOW2NrwTcKDNzywsBZwJn1KrbC9NtFnrlULv43ycEhUTjUZSB/TNZvDJyzEQVn1Q/lLhlC9hyZDBf7CM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3968
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(2980300002)(189003)(199004)(386003)(4326008)(2501003)(5660300002)(305945005)(2906002)(81156014)(356004)(8676002)(3846002)(6116002)(50226002)(7736002)(8746002)(8936002)(47776003)(70206006)(14454004)(70586007)(81166006)(76130400001)(66066001)(478600001)(36756003)(26826003)(22756006)(23756003)(86362001)(2201001)(486006)(6636002)(54906003)(336012)(110136005)(446003)(63350400001)(11346002)(126002)(102836004)(26005)(76176011)(99286004)(476003)(186003)(1076003)(2616005)(50466002)(6506007)(36906005)(6486002)(63370400001)(6512007)(25786009)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1854;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8ad5cdfa-d9f5-41aa-dade-08d72d29b00f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0801MB1854;
NoDisclaimer: True
X-Forefront-PRVS: 0145758B1D
X-Microsoft-Antispam-Message-Info: H0+1HNpe38H5YFWZmYBKRBa6GVdCHXCjhs3d9FjFO+Coeh+kP/wQM3IG47zZCYcnv12Gnk8ni0KcExnOHuaazKlbhtxjUZKTZfc3QSk/6dBeWt3PzpHrEpCGDtv6HDDDIu7aOrIwesZRPcxE1NoH9aTkMwcnUvHI1wnHUikfXO4FeJwOCywdNls9Q8YvwE352Y85sUICa3jrZFDaMOLpE07RbRdm7I+UJLLtiNoQ7jGiVkCIoeuxl1tYEODHqn/KdX6mLtPnNJwMDe7hCsL1VN9fUKmurCt9VTXMNr2760YWbkLuF06c9DDCTbfu9seoa/IuHPqqa5NZGEQEdjmCJvmWlb2ZruKiiGCFgurFWl5St3BXNpVBvyCRIWiFmTCf//f3zQ4ZXu5+9MzIZHlMfNReVl6A15VlhRvgatF58VQ=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2019 09:09:08.7064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7189b7-35e8-466b-39ce-08d72d29b744
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On D71, we are using the global line size. From D32, every
component have a line size register to indicate the fifo size.

So this patch is to set line size support and do the line size
check.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 56 ++++++++++++++++---
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h |  8 +--
 .../drm/arm/display/komeda/komeda_pipeline.h  |  2 +
 .../display/komeda/komeda_pipeline_state.c    | 17 ++++++
 4 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index c985932954cb..a56dc56a72fb 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -116,6 +116,23 @@ static void dump_block_header(struct seq_file *sf, voi=
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
@@ -423,7 +440,27 @@ static int d71_layer_init(struct d71_dev *d71,
 		layer->color_mgr.fgamma_mgr =3D d71->glb_lt_mgr;
 	}
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
+	} else  {
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
 	set_range(&layer->vsize_in, 4, d71->max_vsize);
=20
 	malidp_write32(reg, LAYER_PALPHA, D71_PALPHA_DEF_MAP);
@@ -676,9 +713,11 @@ static int d71_wb_layer_init(struct d71_dev *d71,
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
@@ -822,8 +861,8 @@ static int d71_compiz_init(struct d71_dev *d71,
 	if (komeda_product_match(d71->mdev, MALIDP_D77_PRODUCT_ID))
 		compiz->support_channel_scaling =3D true;
=20
-	set_range(&compiz->hsize, D71_MIN_LINE_SIZE, d71->max_line_size);
-	set_range(&compiz->vsize, D71_MIN_VERTICAL_SIZE, d71->max_vsize);
+	set_range(&compiz->hsize, 64, get_blk_line_size(d71, reg));
+	set_range(&compiz->vsize, 64, d71->max_vsize);
=20
 	return 0;
 }
@@ -980,7 +1019,7 @@ static int d71_scaler_init(struct d71_dev *d71,
 	}
=20
 	scaler =3D to_scaler(c);
-	set_range(&scaler->hsize, 4, 2048);
+	set_range(&scaler->hsize, 4, __get_blk_line_size(d71, reg, 2048));
 	set_range(&scaler->vsize, 4, 4096);
 	scaler->max_downscaling =3D 6;
 	scaler->max_upscaling =3D 64;
@@ -1089,7 +1128,7 @@ static int d71_splitter_init(struct d71_dev *d71,
=20
 	splitter =3D to_splitter(c);
=20
-	set_range(&splitter->hsize, 4, d71->max_line_size);
+	set_range(&splitter->hsize, 4, get_blk_line_size(d71, reg));
 	set_range(&splitter->vsize, 4, d71->max_vsize);
=20
 	return 0;
@@ -1240,7 +1279,8 @@ static int d71_merger_init(struct d71_dev *d71,
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
index c1be4594bc92..a58389e623bb 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
@@ -340,6 +340,7 @@
 #define L_INFO_RF		BIT(0)
 #define L_INFO_CM		BIT(1)
 #define L_INFO_ABUF_SIZE(x)	(((x) >> 4) & 0x7)
+#define L_INFO_YUV_MAX_LINESZ(x)	(((x) >> 16) & 0xFFFF)
=20
 /* Scaler registers */
 #define SC_COEFFTAB		0x0DC
@@ -570,13 +571,6 @@ enum d71_blk_type {
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
index 9fe5624172ee..31d392389566 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -246,6 +246,8 @@ struct komeda_layer {
 	struct malidp_range hsize_in, vsize_in;
 	struct komeda_color_manager color_mgr;
 	u32 layer_type; /* RICH, SIMPLE or WB */
+	u32 line_sz;
+	u32 yuv_line_sz; /* maximum line size for YUV422 and YUV420 */
 	u32 supported_rots;
 	/* komeda supports layer split which splits a whole image to two parts
 	 * left and right and handle them by two individual layer processors
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 6974c4e081bf..957c1c01ca78 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -323,6 +323,7 @@ komeda_layer_check_cfg(struct komeda_layer *layer,
 		       struct komeda_data_flow_cfg *dflow)
 {
 	u32 src_x, src_y, src_w, src_h;
+	u32 line_sz, max_line_sz;
=20
 	if (!komeda_fb_is_layer_supported(kfb, layer->layer_type, dflow->rot))
 		return -EINVAL;
@@ -352,6 +353,22 @@ komeda_layer_check_cfg(struct komeda_layer *layer,
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

