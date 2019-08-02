Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC05C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8C02087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="5e0PfDYf";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="5e0PfDYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390198AbfHBHye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 03:54:34 -0400
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:34951
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728272AbfHBHyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q4VOJv4sIthbrtsAtfzgaI6IW9iBzuv5h7aL5dEkuA=;
 b=5e0PfDYfrG6/HT2XUrFtLmx2sJnlKNLHbeBxH57o5CdcRZQVuO0rkUxPvy+BTOXMjrG4BmnYXQAW5raE2rLOzWx+k0YTM0qGHhpL9zI7Naq8RJ2g+p92A5SuYtInI8pSp88MCELdjU5S3kgn7Mn9FFgUBwEV9+Wy+yNxE104hAk=
Received: from VI1PR0801CA0075.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::19) by HE1PR0801MB1849.eurprd08.prod.outlook.com
 (2603:10a6:3:89::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.17; Fri, 2 Aug
 2019 07:54:26 +0000
Received: from VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR0801CA0075.outlook.office365.com
 (2603:10a6:800:7d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.14 via Frontend
 Transport; Fri, 2 Aug 2019 07:54:26 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT037.mail.protection.outlook.com (10.152.19.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Fri, 2 Aug 2019 07:54:25 +0000
Received: ("Tessian outbound 1e6e633a5b56:v26"); Fri, 02 Aug 2019 07:54:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d136707a997d807c
X-CR-MTA-TID: 64aa7808
Received: from 1be130d0ede0.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E442837A-86C6-48D1-89F1-AE8EB9779A79.1;
        Fri, 02 Aug 2019 07:54:15 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2050.outbound.protection.outlook.com [104.47.6.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1be130d0ede0.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 02 Aug 2019 07:54:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPtHap0TzNaU4dugvur4VcCz5j8Hc5BqD/+v6IMN6/6+x/nUho6VgQzTlcgsRgXgFB/5SRGNYAS21N0mbV/aGzaMzr3sjl3qMMAwjDEqu2h9iHlANiwe2Ui6GYVKvyqI7jZOWNpJ9PvkFqGT3dbVQVI+mWJd7pBNU4PxF7/7yB9xskJ1Y0/L9kzNpd5xj+Jb0TqVJ8mEuGrcg5EMpoDFXLC5UzW0pylQF9uH+rTdd21M2uJXw1qKi10CFEdUcrsc2fcXRa4SxGdSemxH8LRtqeuFAlufToK9A06s180rjWnSBzsHANJSrwPTxG/MN+j1dfl2COmTNs8C2v70jItHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q4VOJv4sIthbrtsAtfzgaI6IW9iBzuv5h7aL5dEkuA=;
 b=XGP6ehLnQLcKnxO/dyi8/gS22ocJPpkV0s00s1iaBpXzBLvALbDu4KSewPL+ju2BiijEdkOayuz6NdrzL+utPQCMNxivXG36ypBoge4Cv7cJflilALzuWuXjdfEjkHEA+jSOT0FAkBjXawyZ0zn3jDtR6IWF2RNyTDyc/MxaDrorYF/a1tDHAVXkAJHyTfLfX+ugI/JGPnDiVsTk47+6mw9sOcCxrG/OR6FHzfXDwtX6QPV4wnBhA8wlaYEegw1etZI4ZzkdiaiNlhcPgVCNoR+7czXE+7zSrxrIiY0MYdBtmf0qTdAU0CFJ2Cd2gKWWrGgv+/tt9+gdXCXtCrVt9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q4VOJv4sIthbrtsAtfzgaI6IW9iBzuv5h7aL5dEkuA=;
 b=5e0PfDYfrG6/HT2XUrFtLmx2sJnlKNLHbeBxH57o5CdcRZQVuO0rkUxPvy+BTOXMjrG4BmnYXQAW5raE2rLOzWx+k0YTM0qGHhpL9zI7Naq8RJ2g+p92A5SuYtInI8pSp88MCELdjU5S3kgn7Mn9FFgUBwEV9+Wy+yNxE104hAk=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB5389.eurprd08.prod.outlook.com (52.133.245.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Fri, 2 Aug 2019 07:54:12 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236%2]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 07:54:12 +0000
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
Subject: [PATCH] drm/komeda: Initialize and enable output polling on Komeda
Thread-Topic: [PATCH] drm/komeda: Initialize and enable output polling on
 Komeda
Thread-Index: AQHVSQd44sHRrT3d4ECbTQknG5FM2Q==
Date:   Fri, 2 Aug 2019 07:54:12 +0000
Message-ID: <1564732428-23641-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0072.apcprd03.prod.outlook.com
 (2603:1096:203:52::36) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 2e69d460-2237-48bc-3f9f-08d7171ea34f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB5389;
X-MS-TrafficTypeDiagnostic: VI1PR08MB5389:|HE1PR0801MB1849:
X-Microsoft-Antispam-PRVS: <HE1PR0801MB184932FD430726B7969044939FD90@HE1PR0801MB1849.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1201;OLM:1201;
x-forefront-prvs: 011787B9DD
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(189003)(199004)(26005)(66066001)(2501003)(6512007)(476003)(6486002)(186003)(2616005)(55236004)(71190400001)(102836004)(4326008)(81156014)(71200400001)(81166006)(6436002)(386003)(8936002)(6506007)(2201001)(2906002)(478600001)(7736002)(305945005)(6636002)(68736007)(66446008)(86362001)(3846002)(6116002)(256004)(54906003)(14454004)(25786009)(110136005)(486006)(8676002)(316002)(66946007)(36756003)(66476007)(66556008)(64756008)(5660300002)(5024004)(53936002)(99286004)(50226002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5389;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 9qGqMFj7I5QQtlMLJw6M2MJUjwQ+FJZQSrRGGsjVNpYE4k+3+tEZV9HNT4UKqLCZwLwsAW+qYJzFnQAzsBxDmMExVLZDpHOnf8s6re3dhkp18LQkb7rIWgenBYkvey/XwvDW/knVYiZjwlAndVeC4stG668y5ToB2kzlLq9Cd1CrCDNg4I4+vrkKV04hGr9peuniXVIRW+IixSrxMOGnCa8hq5Wy68Zq78bZ5G0gE7+svd+5oANcJYiJGCPAWNiNNcg9WETT+8c7xx4bQIekif/GQ5gs2OH7H+PbPVsv9neasoMenP4CarITsc+FfkSPLIDbSMYymFtaZTeYP6FKJ5MAs3QsoAHRFSNzcAtnT0CWGt27X6sWxLgwTNKzWcR2hM7+aHVEX6t8cLR7Y47VA05vFYcTW2zAfDxE7DhNsPo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5389
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(2980300002)(189003)(199004)(102836004)(478600001)(486006)(2201001)(6512007)(26826003)(25786009)(14454004)(6636002)(70586007)(76130400001)(336012)(99286004)(22756006)(6506007)(47776003)(26005)(2501003)(2906002)(5660300002)(186003)(2616005)(126002)(476003)(6486002)(386003)(66066001)(316002)(54906003)(50226002)(36756003)(6116002)(3846002)(8936002)(305945005)(7736002)(110136005)(5024004)(36906005)(356004)(63350400001)(8746002)(23756003)(4326008)(50466002)(63370400001)(70206006)(8676002)(81156014)(81166006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1849;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: edc42580-d326-47d0-aba4-08d7171e9b27
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:HE1PR0801MB1849;
NoDisclaimer: True
X-Forefront-PRVS: 011787B9DD
X-Microsoft-Antispam-Message-Info: sCWglVKMW6Pv4ge04AD2cpj24XQ/4RzCHzOe7n4XkfsUCorViOphKqSQPk20zkbUJjmzPip+LrlSHgRIOjVfZD3dLCaME98tZ7Qec+ZQmtkXsX9PxZ9EUwA1CimdFtgNRdX8R7GrBwZnzuqRNqLC2Us4krGloSRWMZQZnzXqZ8zFxIv+KT+dQI3g5zp/gQaV/YfU3jy1Y6ajnjTrBGsGjf5SS6HzbXyTMpIZ+y2yB/L1OTRx1y3D+7Bqqf5IcG+TdAkl3aSUIl3tuDS1sJKrOc2KklNwZMkeblXDJgbpd0nh7VapVxkvqWyJH5rZQFuQFTP530sAsCgJGFu8gljE76IBrDDO6Bp9t6ZNLQl0jeaOht+upGipCSyZZxjIFy3IRDk3ibJv4TIMl+Vwl4cxW0cyQsH6JA6Wub2BlAzWZww=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2019 07:54:25.1231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e69d460-2237-48bc-3f9f-08d7171ea34f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1849
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>

Initialize and enable output polling on Komeda.

Changes since v1:
1. Enable the polling before registering the driver;
2. Disable the polling after unregistering the driver.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 419a8b0..25716a30 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -15,6 +15,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_irq.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_probe_helper.h>
=20
 #include "komeda_dev.h"
 #include "komeda_framebuffer.h"
@@ -315,6 +316,8 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_=
dev *mdev)
=20
 	drm->irq_enabled =3D true;
=20
+	drm_kms_helper_poll_init(drm);
+
 	err =3D drm_dev_register(drm, 0);
 	if (err)
 		goto cleanup_mode_config;
@@ -338,6 +341,7 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
 	drm->irq_enabled =3D false;
 	mdev->funcs->disable_irq(mdev);
 	drm_dev_unregister(drm);
+	drm_kms_helper_poll_fini(drm);
 	component_unbind_all(mdev->dev, drm);
 	komeda_kms_cleanup_private_objs(kms);
 	drm_mode_config_cleanup(drm);
--=20
1.9.1

