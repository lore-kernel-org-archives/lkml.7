Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281D7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC502147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="YXIMb923"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfDDKIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:08:09 -0400
Received: from mail-eopbgr130087.outbound.protection.outlook.com ([40.107.13.87]:34571
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbfDDKII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUPvzulVhCdlCdmvWuxofD/x4xXNPy318UhPbEunRgY=;
 b=YXIMb923SPpf2p+FtQcvjZMuX29lJF9VgTu+sIL6hhNFLWcWudjEABoIs1RIDDahzuMsPBHt6Y2A/D1iyKi5i7zJ/EIYNnH+8FjlvVvJPYS1RaTXOMQSHp2OpSVdDOiPZsaOnp3L+r4mOvrVSGEfSSyVlRM0pWBhrDMbDuB7zFs=
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com (20.177.120.80) by
 DB7PR08MB3450.eurprd08.prod.outlook.com (20.176.238.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 4 Apr 2019 10:08:04 +0000
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a]) by DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a%3]) with mapi id 15.20.1771.011; Thu, 4 Apr 2019
 10:08:04 +0000
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
Subject: [RFC PATCH v2] drm/komeda: fixing of DMA mapping sg segment warning
Thread-Topic: [RFC PATCH v2] drm/komeda: fixing of DMA mapping sg segment
 warning
Thread-Index: AQHU6s5KQMOVm+DvoUynXnNB4vwxrA==
Date:   Thu, 4 Apr 2019 10:08:04 +0000
Message-ID: <1554372474-3594-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To DB7PR08MB3530.eurprd08.prod.outlook.com
 (2603:10a6:10:49::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01d32956-b61f-4bfc-de1e-08d6b8e56d19
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR08MB3450;
x-ms-traffictypediagnostic: DB7PR08MB3450:
x-ms-exchange-purlcount: 4
nodisclaimer: True
x-microsoft-antispam-prvs: <DB7PR08MB345095E7B8C7B8E6DD16F14B9F500@DB7PR08MB3450.eurprd08.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(396003)(376002)(189003)(199004)(4326008)(7736002)(71200400001)(66066001)(97736004)(53936002)(72206003)(25786009)(478600001)(5660300002)(966005)(68736007)(3846002)(6512007)(6506007)(105586002)(110136005)(6116002)(106356001)(26005)(316002)(8676002)(36756003)(50226002)(81156014)(186003)(14454004)(256004)(14444005)(2501003)(486006)(54906003)(2906002)(2201001)(6486002)(2616005)(52116002)(386003)(6436002)(476003)(6306002)(102836004)(8936002)(6636002)(55236004)(71190400001)(305945005)(99286004)(81166006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3450;H:DB7PR08MB3530.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h1VJVuuthXOeXNF+wZ9XtNDhy+fcoV2j+sRnM0VlnuPJQFn3vFvf95grWmwBe5TZcloCwUgxzJkyZlNO776vAJ5gN16bbV7iHNz5ASQrQRCyogIF4opmsBPBKJ0KZj63eVbyLO6tVPkJaN+6aRhyVo4RVavfipYTx4O4g7qu42X4OISi1wfb8lqHy8CM/XpyH+ZAHO895i6NWsdxf/Cv5AfMrfXu1B8adEreH5KUDby7W8R0xJXn8kx5ngnPrx01mnO0PZuKUVUJk+Nan78cTQXm6RLBbtvTVW00Ix/Y1dKcWoR6QKT1PNyt6MdLLxxOlSQDJt9G8LSjsN5TafgVeOVlG4GaKwGwjhfcCRQNtfuN5xC69ppPfhhr8XECn9yMFSvJXT9NWZbg/E1eQKbP4aV902zbsM3kStCX75j2AgQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d32956-b61f-4bfc-de1e-08d6b8e56d19
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 10:08:04.1520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing the DMA mapping sg segment warning, which shows "DMA-API: mapping
sg segment longer than device claims to support [len=3D921600] [max=3D65536=
]".
Fixed by setting the max segment size at Komeda driver.

This patch depends on:
- https://patchwork.freedesktop.org/series/54448/
- https://patchwork.freedesktop.org/series/54449/
- https://patchwork.freedesktop.org/series/54450/
- https://patchwork.freedesktop.org/series/58976/

Changes since v1:
- Adds member description
- Adds patch denpendency in the comment

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 4 ++++
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 2 ++
 2 files changed, 6 insertions(+)

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
index 29e03c4..83ace71 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -149,6 +149,8 @@ struct komeda_dev {
 	struct device *dev;
 	/** @reg_base: the base address of komeda io space */
 	u32 __iomem   *reg_base;
+	/** @dma_parms: the dma parameters of komeda */
+	struct device_dma_parameters dma_parms;
=20
 	/** @chip: the basic chip information */
 	struct komeda_chip_info chip;
--=20
1.9.1

