Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69423C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 01:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B552206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 01:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qQlP2UCn";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qQlP2UCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403952AbfIWB7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 21:59:46 -0400
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:47618
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403815AbfIWB7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 21:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkVpM/4SufNqFKctYlV5jXe82yzzwSsY+7peY6Zd000=;
 b=qQlP2UCn6BwkGQQJUJtBvC3fqVLGz6G6nI8ufVQz0tDErLBD3/M2R49/qtCC351/XnuppR4H8PWDr2N6a8xAt/zuJ0aYjv+2M0UBxkLGOOtl6Ge3hia0vVaJL4R6jJ5y6ePvV5e1cvGCDIV+nmPxXGDctn5RxmczQkBTKGw74uE=
Received: from VI1PR08CA0186.eurprd08.prod.outlook.com (2603:10a6:800:d2::16)
 by VI1PR0802MB2141.eurprd08.prod.outlook.com (2603:10a6:800:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Mon, 23 Sep
 2019 01:59:34 +0000
Received: from DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by VI1PR08CA0186.outlook.office365.com
 (2603:10a6:800:d2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Mon, 23 Sep 2019 01:59:34 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT053.mail.protection.outlook.com (10.152.21.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Mon, 23 Sep 2019 01:59:32 +0000
Received: ("Tessian outbound 55d20e99e8e2:v31"); Mon, 23 Sep 2019 01:59:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f48b24df6bd95348
X-CR-MTA-TID: 64aa7808
Received: from fbaa96855148.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A5BEA2ED-2FCA-4280-B996-33DE8C72E4BC.1;
        Mon, 23 Sep 2019 01:59:27 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fbaa96855148.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 23 Sep 2019 01:59:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqekGOIxE3lB01y+m7TftbSui79huAbPo9zzUAyKUldHrPOx23DM3M1uciNGIonDEIeqqbW8TAWQOyrEjvtzRbKxEmjkCPiE4x7Rdsm+8ugbSnAKSgfLuUatSBF9otAmxrTyQSNp8bHk4tHC4Xl/dTs8KFtkvGZ1qHGn56/Po3j5piscPdZb4h+5l7b0WEIax5Yq496iHGwLT8leleDdfzxKtdubNKZ5fqHlZYFFBHSu47TPntinOfzvIi/tNQSDY+acpGZLZOmEUcMxVo7Cu/+pKzHWxoExTFT+efp+IbsM6FYIb7FokCHVh3Sxzv+MxtaWPse+oTATgoF/raBQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkVpM/4SufNqFKctYlV5jXe82yzzwSsY+7peY6Zd000=;
 b=UjXG6808v8n3JVqr0n/xQlmytx6UxuW0reI/+wtBEfK78ZdYflsztgy3+o4NS5Upk2DZOf7d6bQOBog9p61x2J56GfmESAYuD7mC1MBMwBwgdWNz7psntTrdwj0ISn7uLvfvKTo9oMk5ltJhegJbnOupcQSyV34LWykaBErC907OBiANDdzBXw1waYUj4BWOyZDDghfhDjRS5IjJf1woKWIi58mMGMoPiKwcigvQXcaYiGq+48F+//Td2h4Vt04bIVy63hVnIz7Zc3Xsyg+nQsFZKfLSMZ+3YUAJn5eLUfhvjRi+5uki+d3A3f9aeN9wbL+XToCWLh0RxFJfQLx7qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkVpM/4SufNqFKctYlV5jXe82yzzwSsY+7peY6Zd000=;
 b=qQlP2UCn6BwkGQQJUJtBvC3fqVLGz6G6nI8ufVQz0tDErLBD3/M2R49/qtCC351/XnuppR4H8PWDr2N6a8xAt/zuJ0aYjv+2M0UBxkLGOOtl6Ge3hia0vVaJL4R6jJ5y6ePvV5e1cvGCDIV+nmPxXGDctn5RxmczQkBTKGw74uE=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB2783.eurprd08.prod.outlook.com (10.170.236.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Mon, 23 Sep 2019 01:59:25 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b%3]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 01:59:25 +0000
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
Subject: [PATCH] drm/komeda: Adds power management support
Thread-Topic: [PATCH] drm/komeda: Adds power management support
Thread-Index: AQHVcbKG61D12b8o90a0WJVQdsEzVw==
Date:   Mon, 23 Sep 2019 01:59:25 +0000
Message-ID: <20190923015908.26627-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::22) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: cc6b632d-3c3b-48cf-f155-08d73fc9ad7c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB2783;
X-MS-TrafficTypeDiagnostic: VI1PR08MB2783:|VI1PR08MB2783:|VI1PR0802MB2141:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB21410E2EDC229CE3F58E82E89F850@VI1PR0802MB2141.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6430;OLM:6430;
x-forefront-prvs: 0169092318
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(189003)(199004)(86362001)(36756003)(476003)(6512007)(6306002)(99286004)(6486002)(486006)(25786009)(2616005)(256004)(14444005)(52116002)(305945005)(6636002)(71200400001)(186003)(8676002)(81166006)(7736002)(81156014)(386003)(6506007)(8936002)(26005)(102836004)(71190400001)(6436002)(4326008)(2201001)(55236004)(50226002)(6116002)(2501003)(5660300002)(3846002)(66066001)(66946007)(110136005)(478600001)(966005)(66476007)(66556008)(64756008)(66446008)(54906003)(2906002)(14454004)(1076003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2783;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: m1JXKMmxNHoi3TrcTC6PDgU7RZuOx2Z5rlJLsIpbWKkMTdEHbl/xQWYUiR4P7fwWuEnXVL1+6TlKlG7NRA9sUrINGGAyqAYrbhp+08JsEZ+fGIPRwIb7fB/hNxuo5uERl5LIjk81mIkGlnHU76I1yvBz8iW4UYcVx+eXTrWAFc5s+h0+zwylXksOABvGWFTVOSTU3L+i9DlRF5z8Vv1jEdxjoOfC2paZ94uOFnTlcUJ+mzC3Bu2KAvXHEuKPyxzCBV0HC5OeZleYPUkWh7J4+Y7LmSH1umR9ukthaIw3DQMcvBmtnhyyaKRd/QT3jErcYRPbMr0nDMbu0RrGoHaAEBt/4W48JS4TVSDkXt8/FLXwR+Hc0BxraAtXQiAiFt5ra1o54M3OEZ4gZvT6mYZ+wTF+X2JVxNdcRfJjyc2CyWI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2783
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39850400004)(199004)(189003)(6306002)(47776003)(486006)(2616005)(14444005)(336012)(2501003)(476003)(66066001)(126002)(50466002)(86362001)(186003)(3846002)(6506007)(6116002)(99286004)(386003)(356004)(14454004)(2906002)(70206006)(76130400001)(70586007)(6636002)(22756006)(305945005)(4326008)(26005)(2201001)(63350400001)(26826003)(5660300002)(25786009)(50226002)(23756003)(81156014)(316002)(110136005)(6486002)(54906003)(966005)(81166006)(478600001)(8676002)(1076003)(102836004)(36756003)(7736002)(8746002)(8936002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2141;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7659b1cb-acf3-4bcb-1c7c-08d73fc9a8d5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0802MB2141;
NoDisclaimer: True
X-Forefront-PRVS: 0169092318
X-Microsoft-Antispam-Message-Info: 0/sbOQYDGwJLzi6QwOi2A7i8d73l3hNQNEJoGHMnWeOFuFRib41gu4nbrTdXE3gXJkYNYko2z//stby9D1cdiRByhYHO6LU6J1AYPLjK+l7acED/1e4fsDUx4QepkbA7t4SvbAG2X45U8yQ39QGBx1ebNWE15E/OTrgNvKmmAYnPDj5iyjPiJfZlqOaOQCCLdSJzbVaUeWISSyPb1Ck3+R6cRTJneq9L6whG66niFY0+GDleMOG9nXd8ezd0/za2kLqjEktVWXtGUXh8qKbKsJebxDP1Beyk2U6sGRAxS9rd+5T7ED2DlmcqjBLCcNQK4PmupXv0WH78jCEWftHBdquTZXq1rrIgmErkqgkT2JAtYz2/dFM7iOmx7n6DFNpnXxJipIMMTtby66X7k74crCvI2qzvpX/4TugCN+SkyIY=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 01:59:32.7347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6b632d-3c3b-48cf-f155-08d73fc9ad7c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>

Adds system power management support in KMS kernel driver.

Depends on:
https://patchwork.freedesktop.org/series/62377/

Changes since v1:
Since we have unified mclk/pclk/pipeline->aclk to one mclk, which will
be turned on/off when crtc atomic enable/disable, removed runtime power
management.
Removes run time get/put related flow.
Adds to disable the aclk when register access finished.

Changes since v2:
Rebases to the drm-misc-next branch.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  1 -
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 65 +++++++++++++++++--
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  3 +
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 30 ++++++++-
 4 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 38d5cb20e908..b47c0dabd0d1 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -5,7 +5,6 @@
  *
  */
 #include <linux/clk.h>
-#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
=20
 #include <drm/drm_atomic.h>
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index bee4633cdd9f..8a03324f02a5 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -258,7 +258,7 @@ struct komeda_dev *komeda_dev_create(struct device *dev=
)
 			  product->product_id,
 			  MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id));
 		err =3D -ENODEV;
-		goto err_cleanup;
+		goto disable_clk;
 	}
=20
 	DRM_INFO("Found ARM Mali-D%x version r%dp%d\n",
@@ -271,19 +271,19 @@ struct komeda_dev *komeda_dev_create(struct device *d=
ev)
 	err =3D mdev->funcs->enum_resources(mdev);
 	if (err) {
 		DRM_ERROR("enumerate display resource failed.\n");
-		goto err_cleanup;
+		goto disable_clk;
 	}
=20
 	err =3D komeda_parse_dt(dev, mdev);
 	if (err) {
 		DRM_ERROR("parse device tree failed.\n");
-		goto err_cleanup;
+		goto disable_clk;
 	}
=20
 	err =3D komeda_assemble_pipelines(mdev);
 	if (err) {
 		DRM_ERROR("assemble display pipelines failed.\n");
-		goto err_cleanup;
+		goto disable_clk;
 	}
=20
 	dev->dma_parms =3D &mdev->dma_parms;
@@ -296,11 +296,14 @@ struct komeda_dev *komeda_dev_create(struct device *d=
ev)
 	if (mdev->iommu && mdev->funcs->connect_iommu) {
 		err =3D mdev->funcs->connect_iommu(mdev);
 		if (err) {
+			DRM_ERROR("connect iommu failed.\n");
 			mdev->iommu =3D NULL;
-			goto err_cleanup;
+			goto disable_clk;
 		}
 	}
=20
+	clk_disable_unprepare(mdev->aclk);
+
 	err =3D sysfs_create_group(&dev->kobj, &komeda_sysfs_attr_group);
 	if (err) {
 		DRM_ERROR("create sysfs group failed.\n");
@@ -313,6 +316,8 @@ struct komeda_dev *komeda_dev_create(struct device *dev=
)
=20
 	return mdev;
=20
+disable_clk:
+	clk_disable_unprepare(mdev->aclk);
 err_cleanup:
 	komeda_dev_destroy(mdev);
 	return ERR_PTR(err);
@@ -330,8 +335,12 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
 	debugfs_remove_recursive(mdev->debugfs_root);
 #endif
=20
+	if (mdev->aclk)
+		clk_prepare_enable(mdev->aclk);
+
 	if (mdev->iommu && mdev->funcs->disconnect_iommu)
-		mdev->funcs->disconnect_iommu(mdev);
+		if (mdev->funcs->disconnect_iommu(mdev))
+			DRM_ERROR("disconnect iommu failed.\n");
 	mdev->iommu =3D NULL;
=20
 	for (i =3D 0; i < mdev->n_pipelines; i++) {
@@ -359,3 +368,47 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
=20
 	devm_kfree(dev, mdev);
 }
+
+int komeda_dev_resume(struct komeda_dev *mdev)
+{
+	int ret =3D 0;
+
+	clk_prepare_enable(mdev->aclk);
+
+	if (mdev->iommu && mdev->funcs->connect_iommu) {
+		ret =3D mdev->funcs->connect_iommu(mdev);
+		if (ret < 0) {
+			DRM_ERROR("connect iommu failed.\n");
+			goto disable_clk;
+		}
+	}
+
+	ret =3D mdev->funcs->enable_irq(mdev);
+
+disable_clk:
+	clk_disable_unprepare(mdev->aclk);
+
+	return ret;
+}
+
+int komeda_dev_suspend(struct komeda_dev *mdev)
+{
+	int ret =3D 0;
+
+	clk_prepare_enable(mdev->aclk);
+
+	if (mdev->iommu && mdev->funcs->disconnect_iommu) {
+		ret =3D mdev->funcs->disconnect_iommu(mdev);
+		if (ret < 0) {
+			DRM_ERROR("disconnect iommu failed.\n");
+			goto disable_clk;
+		}
+	}
+
+	ret =3D mdev->funcs->disable_irq(mdev);
+
+disable_clk:
+	clk_disable_unprepare(mdev->aclk);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 8acf8c0601cc..414200233b64 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -224,4 +224,7 @@ void komeda_print_events(struct komeda_events *evts);
 static inline void komeda_print_events(struct komeda_events *evts) {}
 #endif
=20
+int komeda_dev_resume(struct komeda_dev *mdev);
+int komeda_dev_suspend(struct komeda_dev *mdev);
+
 #endif /*_KOMEDA_DEV_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index 69ace6f9055d..d6c2222c5d33 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/component.h>
+#include <linux/pm_runtime.h>
 #include <drm/drm_of.h>
 #include "komeda_dev.h"
 #include "komeda_kms.h"
@@ -136,13 +137,40 @@ static const struct of_device_id komeda_of_match[] =
=3D {
=20
 MODULE_DEVICE_TABLE(of, komeda_of_match);
=20
+static int __maybe_unused komeda_pm_suspend(struct device *dev)
+{
+	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
+	struct drm_device *drm =3D &mdrv->kms->base;
+	int res;
+
+	res =3D drm_mode_config_helper_suspend(drm);
+
+	komeda_dev_suspend(mdrv->mdev);
+
+	return res;
+}
+
+static int __maybe_unused komeda_pm_resume(struct device *dev)
+{
+	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
+	struct drm_device *drm =3D &mdrv->kms->base;
+
+	komeda_dev_resume(mdrv->mdev);
+
+	return drm_mode_config_helper_resume(drm);
+}
+
+static const struct dev_pm_ops komeda_pm_ops =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(komeda_pm_suspend, komeda_pm_resume)
+};
+
 static struct platform_driver komeda_platform_driver =3D {
 	.probe	=3D komeda_platform_probe,
 	.remove	=3D komeda_platform_remove,
 	.driver	=3D {
 		.name =3D "komeda",
 		.of_match_table	=3D komeda_of_match,
-		.pm =3D NULL,
+		.pm =3D &komeda_pm_ops,
 	},
 };
=20
--=20
2.17.1

