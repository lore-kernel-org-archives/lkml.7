Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF3AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC98206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kLOMuVLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfC1HZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:25:05 -0400
Received: from mail-eopbgr130057.outbound.protection.outlook.com ([40.107.13.57]:2432
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbfC1HZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyX2kz54UWvJwMSXFpx9NAYTFnCVmfZtzGcWXicjrgo=;
 b=kLOMuVLPluxBPq2tZESO8tG4qH8msPqRhT6OFsp+qe/oM1JQZbECINQF40sNGifJieVo4/o7kHIsBMNU/f3u+ssf9RpvZ1cOLPtz6z73kd0cJMxuqkleDfUt+nBNjffuG+tw7f20tnQZk3uQTEdn3sQ1DX+vV/3MsKeSPMG6u+Q=
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com (20.177.120.80) by
 DB7PR08MB3532.eurprd08.prod.outlook.com (20.177.120.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Thu, 28 Mar 2019 07:25:01 +0000
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a]) by DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a%3]) with mapi id 15.20.1750.014; Thu, 28 Mar 2019
 07:25:01 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: [RFC PATCH] drm/komeda: fixing of DMA mapping sg segment warning
Thread-Topic: [RFC PATCH] drm/komeda: fixing of DMA mapping sg segment warning
Thread-Index: AQHU5Tdaj2sOzmoqEEaVRCerOJix/w==
Date:   Thu, 28 Mar 2019 07:25:00 +0000
Message-ID: <1553757859-13506-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0075.apcprd03.prod.outlook.com
 (2603:1096:203:72::15) To DB7PR08MB3530.eurprd08.prod.outlook.com
 (2603:10a6:10:49::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4136f773-35d4-44d3-d567-08d6b34e7ccc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3532;
x-ms-traffictypediagnostic: DB7PR08MB3532:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB7PR08MB35325BE63D9123EC4A91E9839F590@DB7PR08MB3532.eurprd08.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(199004)(189003)(386003)(110136005)(2906002)(6512007)(86362001)(2201001)(14454004)(316002)(25786009)(2616005)(478600001)(54906003)(476003)(4326008)(305945005)(8936002)(256004)(81156014)(97736004)(486006)(72206003)(71190400001)(14444005)(81166006)(8676002)(50226002)(105586002)(106356001)(71200400001)(3846002)(7736002)(26005)(186003)(6116002)(6636002)(68736007)(6486002)(102836004)(36756003)(99286004)(6436002)(6506007)(2501003)(52116002)(53936002)(55236004)(66066001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3532;H:DB7PR08MB3530.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8ejJ4crURF8DGuiOVOwhelNMBvBbOkwjANyfvS1oaP4PqaEr5GKvCwW/43HzIqDsUJkhnWHGz4Rnhep8GKzZ+9VAC/jAYhMybuocXxuuMzL/b/2h4lwnCj6Z7O/CMsxswEEL6JQWQkYTdxXCQwimwlLt0xyjJAkUEwtFV5MjbWv7rMqm98Hf3naNZBcOk5q4TsLnp6GC9OZNPrB5CdR0IGP8m9N14yfSD5NlwQaGQ9AmxY19UQwzZC8+wzFDODzkVrA+3Nab0eu4OsabDF+MPfUUhaS/H2imo6D2caPC1+aI89FtyyTwQyvH5nGh+FJQGRJcx9oyJoaGWZyIM1IqSaSpmtVqHUKptoR1z0bfqigmoh38Wotoc1qhxbwVBNEMyCaLMw5lQ/D/Aa2nZ1qqftfL+Qs/8gkyXc3qNZcnAzA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4136f773-35d4-44d3-d567-08d6b34e7ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 07:25:01.1600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3532
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing the DMA mapping sg segment warning, which shows "DMA-API: mapping
sg segment longer than device claims to support [len=3D921600] [max=3D65536=
]".
Fixed by setting the max segment size at Komeda driver.

Signed-off-by: Lowry Li <lowry.li@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 4 ++++
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 7f25e6a..b4902ae 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -8,6 +8,7 @@
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
+#include <linux/dma-iommu.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -245,6 +246,9 @@ struct komeda_dev *komeda_dev_create(struct device *dev=
)
 		goto err_cleanup;
 	}
=20
+	dev->dma_parms =3D &mdev->dma_parms;
+	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
+
 	err =3D sysfs_create_group(&dev->kobj, &komeda_sysfs_attr_group);
 	if (err) {
 		DRM_ERROR("create sysfs group failed.\n");
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 0c3e32b..d8cfa92 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -146,6 +146,7 @@ enum {
  */
 struct komeda_dev {
 	struct device *dev;
+	struct device_dma_parameters dma_parms;
 	u32 __iomem   *reg_base;
=20
 	struct komeda_chip_info chip;
--=20
1.9.1

