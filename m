Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8581C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EA42077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="86mri5F+";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="86mri5F+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfLLHs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:48:28 -0500
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:42048
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728095AbfLLHs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv8LFHGUc7FlTMS1j/XZGI2wqkF4osTKc6AxXYv2Go4=;
 b=86mri5F+R6LXapp5EwbU0k40NA56Uom+OCF34XwG0sOZH38CMLj+Yg3cUjagvzHajc8T2OcLSgTHr8WPp3A5qTFvLmTriaHJE4L4hfBeRBZgkqxCWa0VF3f5W57/j+uGedePTxl7QuxwiU2unQAILAh1gsZWBM464eVyoFbUEjs=
Received: from VI1PR08CA0120.eurprd08.prod.outlook.com (2603:10a6:800:d4::22)
 by DB8PR08MB5212.eurprd08.prod.outlook.com (2603:10a6:10:bf::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16; Thu, 12 Dec
 2019 07:48:21 +0000
Received: from VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR08CA0120.outlook.office365.com
 (2603:10a6:800:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Thu, 12 Dec 2019 07:48:21 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT060.mail.protection.outlook.com (10.152.19.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 12 Dec 2019 07:48:21 +0000
Received: ("Tessian outbound 1e3e4a1147b7:v37"); Thu, 12 Dec 2019 07:48:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7176d6de12056882
X-CR-MTA-TID: 64aa7808
Received: from d3a567c650a1.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AEC51003-4089-441F-9E8B-62BAC3745974.1;
        Thu, 12 Dec 2019 07:48:16 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d3a567c650a1.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 12 Dec 2019 07:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtotQ7LRraZJesqMiwyuoCsdb4qzTco4bT1xpfxfUSLjxmImcTOTonfUkkdEgo7IsVpbua5DY7JKPYCA9qBH7MtZtz3v9sw216F5T8mGD0DPAlyEwv+YKJbsluZtJ1ZP89EwAIc8yALGjrkRNK7DSjRu/Zrruz74lF+MgHqVVqQSK49MFDoyjz3hJD/yp9cZmOxtNolj/mz7Z2yNWGxcj5efHebU9THdZFF9pVMrj4QeHBowDaqs8G2FqRtIJQrOU29fjz8bTsu/dxglzw9eMS782G88G1FTX8xHv4F4AwyuVtENvLcOpoZgfyJJMbgorjIKIMT2ocjVoW2pZ39n/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv8LFHGUc7FlTMS1j/XZGI2wqkF4osTKc6AxXYv2Go4=;
 b=T2k2JR4YEiU+g4vU/unOpW2E1/yrYpomeIRVKaSw/LHO36f7tlrkYgviAGqmULchmNoEufBn0NnF4OdkJtVRST1VSe8LVmAtI5FakQsXBoBBb8lXG67EV1gA0DFcSxu8CTpU22ysNNiLWIX3e3GsCMf8Rjw/qnEdAZ6wVYNSBvhCdVX/JSRFDPP+crTGykj6S8Had1qnjgkNAwIbOQ7+Mu0wPE2X//r1VaYoL5nQ4/9vhcSZFb9O8OjStgtpl/Lh+AiWghyPnOJ5dHLHGI99JzqDAlh+NKiGIipfj4BQ5YJgkyA4DmahsfhlUvpw7urBW1txw0rVCKKwxadshS8vXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv8LFHGUc7FlTMS1j/XZGI2wqkF4osTKc6AxXYv2Go4=;
 b=86mri5F+R6LXapp5EwbU0k40NA56Uom+OCF34XwG0sOZH38CMLj+Yg3cUjagvzHajc8T2OcLSgTHr8WPp3A5qTFvLmTriaHJE4L4hfBeRBZgkqxCWa0VF3f5W57/j+uGedePTxl7QuxwiU2unQAILAh1gsZWBM464eVyoFbUEjs=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5261.eurprd08.prod.outlook.com (20.179.31.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 12 Dec 2019 07:48:13 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2538.016; Thu, 12 Dec 2019
 07:48:13 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH] drm/komeda: Add runtime_pm support
Thread-Topic: [PATCH] drm/komeda: Add runtime_pm support
Thread-Index: AQHVsMCBN2D7zCEwDUuoMKQ83lPGMg==
Date:   Thu, 12 Dec 2019 07:48:13 +0000
Message-ID: <20191212074756.14678-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4b0a4f69-6f46-426f-a5b5-08d77ed7a916
X-MS-TrafficTypeDiagnostic: VE1PR08MB5261:|VE1PR08MB5261:|DB8PR08MB5212:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB52124CCD0B0428FB20E6414BB3550@DB8PR08MB5212.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4125;OLM:4125;
x-forefront-prvs: 0249EFCB0B
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(189003)(199004)(316002)(52116002)(6512007)(5660300002)(2906002)(4326008)(8676002)(54906003)(1076003)(37006003)(478600001)(8936002)(66476007)(103116003)(6486002)(81156014)(6636002)(71200400001)(66946007)(81166006)(66446008)(6862004)(36756003)(86362001)(6506007)(55236004)(26005)(2616005)(64756008)(186003)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5261;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Zzf2JubaE580f3ZP7H+RJUJndlpLgPiVx4NkvGgMCHGc6FYL18XsoKG1eJbAlzhOstmm5bPSEbggW7z4yzFl8ZAjp3Hv3fEqKLAZHOZRUz+ep+2YA8TEliM+fxIM7d8McbAmEqhMB1ZESQwGYqWpPJPHKOaf6Nyj8MqiBSkj9Y7LMTYnGGRSM6BPjWu4o670kRa0KRsrjY6f20bODE3B9tkSDeRDR2ZfxlOEMYryqLC5WhBCU422Vgk7FdNRpRwA/H9OBmgi4WoLpopeETe5Bhg+uTnh2pLPeYiyTG14L4EK93hf/93qPPpZr2iX2Grom0k/zYGbp6ZOgyZ7Xo7H0ds4rdy15e+rywyoIe4+O2ehx9O7wCFNAvvBwFLb43g6yhq0DO8Gf2rsL6jkXUkaFbUtU0RvNGBJ/OG/N1q8hWribBHWola6ciHTk9HhGeZO
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5261
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(1076003)(478600001)(54906003)(36756003)(4326008)(70586007)(6862004)(37006003)(70206006)(5660300002)(356004)(2906002)(76130400001)(316002)(36906005)(81166006)(8676002)(81156014)(8936002)(6512007)(2616005)(26005)(6486002)(6636002)(336012)(6506007)(26826003)(186003)(103116003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5212;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b647e486-e3a5-4fe4-2909-08d77ed7a3ef
NoDisclaimer: True
X-Forefront-PRVS: 0249EFCB0B
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPRKfVHyjQmmZjkW0v2QmTYKV1NXCcNG+Av25o+ftHMmPXtCUMkA+q5KQBuCEEioCnL4qbOOzyYhcnpCIPeWFfaVq1//f9dHJflo71BucHVhyLIqXvSfYxwsDtL3ONqiKx6/ekomvdeuZD5Z6SfopRceGxj5Tsoz4GkmTafdC3JonF6FQoZnFBrfSQGxQE13looGUCfqM9eMNhm7F/ipcBi1XcxW528igo8ZXWcKltS5hlSrgQ2hg1llk0PT+zeoOsm3fqqOL30fJzTpklO6uhbJy0qAwavuI+2ZbGtRx3nP6qq88JpGOYIIwGqow5Z0Lt4/aSL9urR9Tx8TEup0yX35UCi1JcoC9JQcLLCpIUdvWf5yzkeVJ3R6xxJWWAIqfdneZaJZaFjITBOck/yqCYhVbkTdwpI70Dp//TyCh0IYh8TQFgR2olnUlMr9tOQK
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 07:48:21.4665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0a4f69-6f46-426f-a5b5-08d77ed7a916
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add pm_runtime_get/put to crtc_enable/disable along with the real
  display usage
- Add runtime_get/put to register_show, since register_show() will
  access register, need to wakeup HW.
- For the case that PM is not enabled or configured, manually wakeup HW

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  3 +
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 55 +++++--------------
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 42 ++++++++++++--
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |  6 --
 4 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 1c452ea75999..56bd938961ee 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -5,6 +5,7 @@
  *
  */
 #include <linux/clk.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
=20
 #include <drm/drm_atomic.h>
@@ -274,6 +275,7 @@ static void
 komeda_crtc_atomic_enable(struct drm_crtc *crtc,
 			  struct drm_crtc_state *old)
 {
+	pm_runtime_get_sync(crtc->dev->dev);
 	komeda_crtc_prepare(to_kcrtc(crtc));
 	drm_crtc_vblank_on(crtc);
 	WARN_ON(drm_crtc_vblank_get(crtc));
@@ -372,6 +374,7 @@ komeda_crtc_atomic_disable(struct drm_crtc *crtc,
 	drm_crtc_vblank_put(crtc);
 	drm_crtc_vblank_off(crtc);
 	komeda_crtc_unprepare(kcrtc);
+	pm_runtime_put(crtc->dev->dev);
 }
=20
 static void
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 38b832804bad..1d767473ba8a 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -10,6 +10,7 @@
 #include <linux/of_graph.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/dma-mapping.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
@@ -27,12 +28,16 @@ static int komeda_register_show(struct seq_file *sf, vo=
id *x)
=20
 	seq_puts(sf, "\n=3D=3D=3D=3D=3D=3D Komeda register dump =3D=3D=3D=3D=3D=
=3D=3D=3D=3D\n");
=20
+	pm_runtime_get_sync(mdev->dev);
+
 	if (mdev->funcs->dump_register)
 		mdev->funcs->dump_register(mdev, sf);
=20
 	for (i =3D 0; i < mdev->n_pipelines; i++)
 		komeda_pipeline_dump_register(mdev->pipelines[i], sf);
=20
+	pm_runtime_put(mdev->dev);
+
 	return 0;
 }
=20
@@ -263,15 +268,6 @@ struct komeda_dev *komeda_dev_create(struct device *de=
v)
 	if (!mdev->iommu)
 		DRM_INFO("continue without IOMMU support!\n");
=20
-	if (mdev->iommu && mdev->funcs->connect_iommu) {
-		err =3D mdev->funcs->connect_iommu(mdev);
-		if (err) {
-			DRM_ERROR("connect iommu failed.\n");
-			mdev->iommu =3D NULL;
-			goto disable_clk;
-		}
-	}
-
 	clk_disable_unprepare(mdev->aclk);
=20
 	err =3D sysfs_create_group(&dev->kobj, &komeda_sysfs_attr_group);
@@ -310,11 +306,6 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
 	if (mdev->aclk)
 		clk_prepare_enable(mdev->aclk);
=20
-	if (mdev->iommu && mdev->funcs->disconnect_iommu)
-		if (mdev->funcs->disconnect_iommu(mdev))
-			DRM_ERROR("disconnect iommu failed.\n");
-	mdev->iommu =3D NULL;
-
 	for (i =3D 0; i < mdev->n_pipelines; i++) {
 		komeda_pipeline_destroy(mdev, mdev->pipelines[i]);
 		mdev->pipelines[i] =3D NULL;
@@ -343,44 +334,26 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
=20
 int komeda_dev_resume(struct komeda_dev *mdev)
 {
-	int ret =3D 0;
-
 	clk_prepare_enable(mdev->aclk);
=20
-	if (mdev->iommu && mdev->funcs->connect_iommu) {
-		ret =3D mdev->funcs->connect_iommu(mdev);
-		if (ret < 0) {
-			DRM_ERROR("connect iommu failed.\n");
-			goto disable_clk;
-		}
-	}
-
-	ret =3D mdev->funcs->enable_irq(mdev);
+	mdev->funcs->enable_irq(mdev);
=20
-disable_clk:
-	clk_disable_unprepare(mdev->aclk);
+	if (mdev->iommu && mdev->funcs->connect_iommu)
+		if (mdev->funcs->connect_iommu(mdev))
+			DRM_ERROR("connect iommu failed.\n");
=20
-	return ret;
+	return 0;
 }
=20
 int komeda_dev_suspend(struct komeda_dev *mdev)
 {
-	int ret =3D 0;
-
-	clk_prepare_enable(mdev->aclk);
-
-	if (mdev->iommu && mdev->funcs->disconnect_iommu) {
-		ret =3D mdev->funcs->disconnect_iommu(mdev);
-		if (ret < 0) {
+	if (mdev->iommu && mdev->funcs->disconnect_iommu)
+		if (mdev->funcs->disconnect_iommu(mdev))
 			DRM_ERROR("disconnect iommu failed.\n");
-			goto disable_clk;
-		}
-	}
=20
-	ret =3D mdev->funcs->disable_irq(mdev);
+	mdev->funcs->disable_irq(mdev);
=20
-disable_clk:
 	clk_disable_unprepare(mdev->aclk);
=20
-	return ret;
+	return 0;
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index ad38bbc7431e..ea5cd1e17304 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -33,6 +33,12 @@ static void komeda_unbind(struct device *dev)
 		return;
=20
 	komeda_kms_detach(mdrv->kms);
+
+	if (pm_runtime_enabled(dev))
+		pm_runtime_disable(dev);
+	else
+		komeda_dev_suspend(mdrv->mdev);
+
 	komeda_dev_destroy(mdrv->mdev);
=20
 	dev_set_drvdata(dev, NULL);
@@ -54,6 +60,10 @@ static int komeda_bind(struct device *dev)
 		goto free_mdrv;
 	}
=20
+	pm_runtime_enable(dev);
+	if (!pm_runtime_enabled(dev))
+		komeda_dev_resume(mdrv->mdev);
+
 	mdrv->kms =3D komeda_kms_attach(mdrv->mdev);
 	if (IS_ERR(mdrv->kms)) {
 		err =3D PTR_ERR(mdrv->kms);
@@ -65,6 +75,11 @@ static int komeda_bind(struct device *dev)
 	return 0;
=20
 destroy_mdev:
+	if (pm_runtime_enabled(dev))
+		pm_runtime_disable(dev);
+	else
+		komeda_dev_suspend(mdrv->mdev);
+
 	komeda_dev_destroy(mdrv->mdev);
=20
 free_mdrv:
@@ -131,15 +146,29 @@ static const struct of_device_id komeda_of_match[] =
=3D {
=20
 MODULE_DEVICE_TABLE(of, komeda_of_match);
=20
+static int komeda_rt_pm_suspend(struct device *dev)
+{
+	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
+
+	return komeda_dev_suspend(mdrv->mdev);
+}
+
+static int komeda_rt_pm_resume(struct device *dev)
+{
+	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
+
+	return komeda_dev_resume(mdrv->mdev);
+}
+
 static int __maybe_unused komeda_pm_suspend(struct device *dev)
 {
 	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
-	struct drm_device *drm =3D &mdrv->kms->base;
 	int res;
=20
-	res =3D drm_mode_config_helper_suspend(drm);
+	res =3D drm_mode_config_helper_suspend(&mdrv->kms->base);
=20
-	komeda_dev_suspend(mdrv->mdev);
+	if (!pm_runtime_status_suspended(dev))
+		komeda_dev_suspend(mdrv->mdev);
=20
 	return res;
 }
@@ -147,15 +176,16 @@ static int __maybe_unused komeda_pm_suspend(struct de=
vice *dev)
 static int __maybe_unused komeda_pm_resume(struct device *dev)
 {
 	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
-	struct drm_device *drm =3D &mdrv->kms->base;
=20
-	komeda_dev_resume(mdrv->mdev);
+	if (!pm_runtime_status_suspended(dev))
+		komeda_dev_resume(mdrv->mdev);
=20
-	return drm_mode_config_helper_resume(drm);
+	return drm_mode_config_helper_resume(&mdrv->kms->base);
 }
=20
 static const struct dev_pm_ops komeda_pm_ops =3D {
 	SET_SYSTEM_SLEEP_PM_OPS(komeda_pm_suspend, komeda_pm_resume)
+	SET_RUNTIME_PM_OPS(komeda_rt_pm_suspend, komeda_rt_pm_resume, NULL)
 };
=20
 static struct platform_driver komeda_platform_driver =3D {
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index e30a5b43caa9..9a7dcf92591a 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -307,10 +307,6 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda=
_dev *mdev)
 	if (err)
 		goto free_component_binding;
=20
-	err =3D mdev->funcs->enable_irq(mdev);
-	if (err)
-		goto free_component_binding;
-
 	drm->irq_enabled =3D true;
=20
 	drm_kms_helper_poll_init(drm);
@@ -324,7 +320,6 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_=
dev *mdev)
 free_interrupts:
 	drm_kms_helper_poll_fini(drm);
 	drm->irq_enabled =3D false;
-	mdev->funcs->disable_irq(mdev);
 free_component_binding:
 	component_unbind_all(mdev->dev, drm);
 cleanup_mode_config:
@@ -346,7 +341,6 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
 	drm_kms_helper_poll_fini(drm);
 	drm_atomic_helper_shutdown(drm);
 	drm->irq_enabled =3D false;
-	mdev->funcs->disable_irq(mdev);
 	component_unbind_all(mdev->dev, drm);
 	drm_mode_config_cleanup(drm);
 	komeda_kms_cleanup_private_objs(kms);
--=20
2.20.1

