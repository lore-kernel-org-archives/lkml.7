Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5902BC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DB1214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8CCMlBZK";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8CCMlBZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGIH7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:59:16 -0400
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:28391
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbfGIH7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFpahTymf9bTgfzhyGJ3jRVYKfJNc5Y5uo1w/e06EXY=;
 b=8CCMlBZKfDjCeymC0b8lxHXK+3rTJIWCd4vc9XQ0QlBfwvA80SUrJOgVxJZyrr7GCDI0ShY/PiGKTrlk/hQz1s8wnhil5p16vV0aWsrPMBA7bM11jhiD0hpMcg/XkIl+6u1dIStAWxquN9R4NC3Lv8axSmGdAW5j+XSHuDopOWU=
Received: from VE1PR08CA0025.eurprd08.prod.outlook.com (2603:10a6:803:104::38)
 by DB6PR0802MB2597.eurprd08.prod.outlook.com (2603:10a6:4:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2052.18; Tue, 9 Jul
 2019 07:57:31 +0000
Received: from VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by VE1PR08CA0025.outlook.office365.com
 (2603:10a6:803:104::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.18 via Frontend
 Transport; Tue, 9 Jul 2019 07:57:31 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT024.mail.protection.outlook.com (10.152.18.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 9 Jul 2019 07:57:29 +0000
Received: ("Tessian outbound 8297bef43b9f:v23"); Tue, 09 Jul 2019 07:57:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ee2f6818f3d694bb
X-CR-MTA-TID: 64aa7808
Received: from 6d84653107b5.2 (cr-mta-lb-1.cr-mta-net [104.47.0.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 146FB70C-6B2D-4E9F-A560-60CA5A9B6CCA.1;
        Tue, 09 Jul 2019 07:57:19 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2050.outbound.protection.outlook.com [104.47.0.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6d84653107b5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 09 Jul 2019 07:57:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFpahTymf9bTgfzhyGJ3jRVYKfJNc5Y5uo1w/e06EXY=;
 b=8CCMlBZKfDjCeymC0b8lxHXK+3rTJIWCd4vc9XQ0QlBfwvA80SUrJOgVxJZyrr7GCDI0ShY/PiGKTrlk/hQz1s8wnhil5p16vV0aWsrPMBA7bM11jhiD0hpMcg/XkIl+6u1dIStAWxquN9R4NC3Lv8axSmGdAW5j+XSHuDopOWU=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4816.eurprd08.prod.outlook.com (10.255.112.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 07:57:14 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Tue, 9 Jul 2019
 07:57:14 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 2/2] drm/komeda: Enable new product D32 support
Thread-Topic: [PATCH 2/2] drm/komeda: Enable new product D32 support
Thread-Index: AQHVNivrN+3ktNltckK09VpQIkadOA==
Date:   Tue, 9 Jul 2019 07:57:14 +0000
Message-ID: <20190709075640.22012-3-james.qian.wang@arm.com>
References: <20190709075640.22012-1-james.qian.wang@arm.com>
In-Reply-To: <20190709075640.22012-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::11) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ec133fc4-5e53-4cc8-0b04-08d70443178c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4816;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4816:|DB6PR0802MB2597:
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2597F65CDC733AEB425080FAB3F10@DB6PR0802MB2597.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 0093C80C01
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(66066001)(305945005)(7736002)(2201001)(64756008)(8676002)(81156014)(81166006)(66946007)(73956011)(66446008)(1076003)(8936002)(186003)(66556008)(86362001)(54906003)(110136005)(66476007)(55236004)(386003)(316002)(76176011)(6506007)(102836004)(71190400001)(71200400001)(52116002)(5660300002)(14454004)(6436002)(103116003)(68736007)(446003)(3846002)(6116002)(478600001)(4326008)(11346002)(36756003)(25786009)(6486002)(53936002)(99286004)(6512007)(50226002)(26005)(2501003)(256004)(486006)(14444005)(2906002)(2616005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4816;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: rwaNevanhZYHVQN1D0uu07cLtrR1N4kAfVuYtAE86jL40xYZsf8Kd/qrpA4dZHZxIy+8CjqdqqxwF2tTXrdSQdiaXPsYlPJ2JHi5Fl9LP+1XF7K4R9q3uCkQ3qS5ssYhYAc3O6F3HpdOhL6RRx2lXRboxEIcwK8zPdzy5TX1BAAifi44zNal7row9SmFRpUuO2Sg/aZHa2Ie644Oil9EjCkMaBftKpoQDNhs7ryqLHXzIxN6bKOJiFaPIl9bbUP7NLn6RqsGJ1q2mfQZvjFDcPk6NxxJFDBtmE4Pkpo7w2zlgKRzmP2FXnrBlFeRW2iKUM6A5ALbQsU+AZKCAmvGd3ITUW0zcdFdmbqk/CHgy3sulpBh0421LToEGBAG9LQLFkjpiMES1HHv3EBFYqlOhzDfKjHir7n0ZWUGtws3BrY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4816
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(199004)(189003)(386003)(2906002)(2501003)(476003)(70586007)(70206006)(76176011)(478600001)(186003)(336012)(14454004)(76130400001)(8936002)(26826003)(26005)(356004)(110136005)(54906003)(11346002)(36756003)(6506007)(6486002)(316002)(8746002)(63350400001)(446003)(99286004)(50466002)(126002)(63370400001)(36906005)(81166006)(5660300002)(7736002)(2616005)(305945005)(102836004)(50226002)(81156014)(486006)(14444005)(6116002)(6512007)(2201001)(22756006)(8676002)(25786009)(3846002)(86362001)(47776003)(23756003)(4326008)(103116003)(66066001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2597;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1131f6e0-b330-490d-da54-08d704430e28
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB6PR0802MB2597;
NoDisclaimer: True
X-Forefront-PRVS: 0093C80C01
X-Microsoft-Antispam-Message-Info: G1luECHF43j1b5oyyXyRLKATXvIseOOL0Tau91uc+AjtzyPbbvpXqYcWCETDQRTwiqMXswd6GPxuUC3X0/xiaPiVWhF1LAznLqnk5Y1Zxt+F3Vitg0S6waborDvReLS77/q4XfQ4f+ylJVe9c4rmGEJsHyx9xQpWb0+y7nVly0q4kkP43fUqJP/PzuBht/vugIzfQo5Uhy+ilefTnHYxGHT21XUNNB//8tetfz3jMWfGTrvR1XIge9vmQUu3flhBr1Sycs/45UAF8FyGf4UFnCPZ7p12IILoRhvuQwwce4qfvpRQiVm/VamNlEQpPXm7XUBa4layCcWeE5tcu36QuMf3MsQx9+RAdwbehTq1P9SlLMrRDoC7DDl6IflF/axC6YZs+8yrvwHg9vve+4djk9FOgEFxbN7liIgq1mj2R/Y=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2019 07:57:29.8886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec133fc4-5e53-4cc8-0b04-08d70443178c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2597
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D32 is simple version of D71, the difference is:
- Only has one pipeline
- Drop the periph block and merge it to GCU

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/include/malidp_product.h  |  3 +-
 .../arm/display/komeda/d71/d71_component.c    |  2 +-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 43 ++++++++++++-------
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 13 ++++++
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  1 +
 5 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drivers=
/gpu/drm/arm/display/include/malidp_product.h
index 1053b11352eb..16a8a2c22c42 100644
--- a/drivers/gpu/drm/arm/display/include/malidp_product.h
+++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
@@ -18,7 +18,8 @@
 #define MALIDP_CORE_ID_STATUS(__core_id)     (((__u32)(__core_id)) & 0xFF)

 /* Mali-display product IDs */
-#define MALIDP_D71_PRODUCT_ID   0x0071
+#define MALIDP_D71_PRODUCT_ID	0x0071
+#define MALIDP_D32_PRODUCT_ID	0x0032

 union komeda_config_id {
 	struct {
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index a68954bb594a..593f8b7e9bb6 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -1178,7 +1178,7 @@ static int d71_timing_ctrlr_init(struct d71_dev *d71,

 	ctrlr =3D to_ctrlr(c);

-	ctrlr->supports_dual_link =3D true;
+	ctrlr->supports_dual_link =3D d71->supports_dual_link;
 	ctrlr->supports_vrr =3D true;
 	set_range(&ctrlr->vfp_range, 0, 0x3FF);

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index e383a781c9e9..8f7c44a0b916 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -371,23 +371,33 @@ static int d71_enum_resources(struct komeda_dev *mdev=
)
 		goto err_cleanup;
 	}

-	/* probe PERIPH */
+	/* Only the legacy HW has the periph block, the newer merges the periph
+	 * into GCU
+	 */
 	value =3D malidp_read32(d71->periph_addr, BLK_BLOCK_INFO);
-	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH) {
-		DRM_ERROR("access blk periph but got blk: %d.\n",
-			  BLOCK_INFO_BLK_TYPE(value));
-		err =3D -EINVAL;
-		goto err_cleanup;
+	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH)
+		d71->periph_addr =3D NULL;
+
+	if (d71->periph_addr) {
+		/* probe PERIPHERAL in legacy HW */
+		value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_ID);
+
+		d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2048;
+		d71->max_vsize		=3D 4096;
+		d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
+		d71->supports_dual_link	=3D !!(value & PERIPH_SPLIT_EN);
+		d71->integrates_tbu	=3D !!(value & PERIPH_TBU_EN);
+	} else {
+		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID0);
+		d71->max_line_size	=3D GCU_MAX_LINE_SIZE(value);
+		d71->max_vsize		=3D GCU_MAX_NUM_LINES(value);
+
+		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID1);
+		d71->num_rich_layers	=3D GCU_NUM_RICH_LAYERS(value);
+		d71->supports_dual_link	=3D GCU_DISPLAY_SPLIT_EN(value);
+		d71->integrates_tbu	=3D GCU_DISPLAY_TBU_EN(value);
 	}

-	value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_ID);
-
-	d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2048;
-	d71->max_vsize		=3D 4096;
-	d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
-	d71->supports_dual_link	=3D value & PERIPH_SPLIT_EN ? true : false;
-	d71->integrates_tbu	=3D value & PERIPH_TBU_EN ? true : false;
-
 	for (i =3D 0; i < d71->num_pipelines; i++) {
 		pipe =3D komeda_pipeline_add(mdev, sizeof(struct d71_pipeline),
 					   &d71_pipeline_funcs);
@@ -399,7 +409,7 @@ static int d71_enum_resources(struct komeda_dev *mdev)
 	}

 	/* loop the register blks and probe */
-	i =3D 2; /* exclude GCU and PERIPH */
+	i =3D 1; /* exclude GCU */
 	offset =3D D71_BLOCK_SIZE; /* skip GCU */
 	while (i < d71->num_blocks) {
 		blk_base =3D mdev->reg_base + (offset >> 2);
@@ -409,9 +419,9 @@ static int d71_enum_resources(struct komeda_dev *mdev)
 			err =3D d71_probe_block(d71, &blk, blk_base);
 			if (err)
 				goto err_cleanup;
-			i++;
 		}

+		i++;
 		offset +=3D D71_BLOCK_SIZE;
 	}

@@ -587,6 +597,7 @@ d71_identify(u32 __iomem *reg_base, struct komeda_chip_=
info *chip)

 	switch (product_id) {
 	case MALIDP_D71_PRODUCT_ID:
+	case MALIDP_D32_PRODUCT_ID:
 		funcs =3D &d71_chip_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h b/drivers/gp=
u/drm/arm/display/komeda/d71/d71_regs.h
index 2d5e6d00b42c..da6bd535836d 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
@@ -71,6 +71,19 @@
 #define GCU_CONTROL_MODE(x)	((x) & 0x7)
 #define GCU_CONTROL_SRST	BIT(16)

+/* GCU_CONFIGURATION registers */
+#define GCU_CONFIGURATION_ID0	0x100
+#define GCU_CONFIGURATION_ID1	0x104
+
+/* GCU configuration */
+#define GCU_MAX_LINE_SIZE(x)	((x) & 0xFFFF)
+#define GCU_MAX_NUM_LINES(x)	((x) >> 16)
+#define GCU_NUM_RICH_LAYERS(x)	((x) & 0x7)
+#define GCU_NUM_PIPELINES(x)	(((x) >> 3) & 0x7)
+#define GCU_NUM_SCALERS(x)	(((x) >> 6) & 0x7)
+#define GCU_DISPLAY_SPLIT_EN(x)	(((x) >> 16) & 0x1)
+#define GCU_DISPLAY_TBU_EN(x)	(((x) >> 17) & 0x1)
+
 /* GCU opmode */
 #define INACTIVE_MODE		0
 #define TBU_CONNECT_MODE	1
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index b7a1097c45c4..ad38bbc7431e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -125,6 +125,7 @@ static int komeda_platform_remove(struct platform_devic=
e *pdev)

 static const struct of_device_id komeda_of_match[] =3D {
 	{ .compatible =3D "arm,mali-d71", .data =3D d71_identify, },
+	{ .compatible =3D "arm,mali-d32", .data =3D d71_identify, },
 	{},
 };

--
2.20.1
