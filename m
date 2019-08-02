Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B72C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5CE2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1AkdTzxp";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1AkdTzxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390708AbfHBIIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:08:19 -0400
Received: from mail-eopbgr50049.outbound.protection.outlook.com ([40.107.5.49]:28802
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731650AbfHBIIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhCwJGFi0O694knrT3lvkfD5Jvkl/qoUo/6cShKWVAY=;
 b=1AkdTzxpRFJs6i2Zq/rIVoRCMIoGCi/oTA/5kt+5WGSU2Fqyatzc1506XSYryoEcJtlCmzJ/rjoQY70bEVWk8p2hOCzCWMKLb79HkDsHTaEKYWW5gsSCzFU6iJHraM1yAs6zy3y9ObY+ErroMNZJ4HusUCzbnPsENsqGKw3t1vY=
Received: from DB7PR08CA0021.eurprd08.prod.outlook.com (2603:10a6:5:16::34) by
 AM6PR08MB4951.eurprd08.prod.outlook.com (2603:10a6:20b:e1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Fri, 2 Aug 2019 08:08:10 +0000
Received: from DB5EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by DB7PR08CA0021.outlook.office365.com
 (2603:10a6:5:16::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.12 via Frontend
 Transport; Fri, 2 Aug 2019 08:08:09 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT037.mail.protection.outlook.com (10.152.20.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Fri, 2 Aug 2019 08:08:09 +0000
Received: ("Tessian outbound 578a71fe5eaa:v26"); Fri, 02 Aug 2019 08:08:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fb6cc2a9bdecefa3
X-CR-MTA-TID: 64aa7808
Received: from 438896da951e.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 99A17835-FF15-4A49-8162-01C2CC564A72.1;
        Fri, 02 Aug 2019 08:07:55 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2059.outbound.protection.outlook.com [104.47.8.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 438896da951e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 02 Aug 2019 08:07:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUF+4XvWWyzFlrsTPBId4hYVd9REpfVTpwubQH/b77DSiGP4X0GylUcX1rZ4aHCyMOwD7Tx0ACxcVZFI9avDsaQ54CwioOFQMnibnVxtK8ZsgeNtJecl5NzBf9qw4RqhyZkJUiWPkk3I056epU+/oa4E2Gn+9jFwdtx5tDLDf+qprwWlNzpnmIF4UrEQUud1bg/pMm7jWzVLsxdoimprKahn4xwpLbjX5h2OjyovFkgHyi5aARZY9E+Ipp7b3fQ1rahKnzmjPURMQfSwS/hrC5DoxKsTCo03rORcmT57qJkNCB1pui4dUr/T9SCuUPw7raLjAVzuShzmU+clIo+dtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhCwJGFi0O694knrT3lvkfD5Jvkl/qoUo/6cShKWVAY=;
 b=f7T/FsCNfSt0LUaNYKegsE/uqZQJqINl6o2pk1Bj3vubVYRPfmAABgCih6wObCzjcLPlbxi0+N8OraEllPsRKdRwooXxY7Ua04dEwNdKgWGklI3kYTPyCypnkslZINPkoyyYyC20YJn57quVkMkTSx2x2nX71gwL54676w4u6g4M00BaVjk5F/sO1Oy+aXbDfr0LhAHExnKWB/fmMw1oR5uUvrLKhMdnIIZBUXmf4JU/IPilUKrfJf5PxkZRaK5SyUk4mqYzgL0y93og/RuzSWUna1H9UQjNQVP1TXC4/vZxxoYEsq+8GpAqcDXiX1t9aa9djRpQXIOXNXR1W17Nfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhCwJGFi0O694knrT3lvkfD5Jvkl/qoUo/6cShKWVAY=;
 b=1AkdTzxpRFJs6i2Zq/rIVoRCMIoGCi/oTA/5kt+5WGSU2Fqyatzc1506XSYryoEcJtlCmzJ/rjoQY70bEVWk8p2hOCzCWMKLb79HkDsHTaEKYWW5gsSCzFU6iJHraM1yAs6zy3y9ObY+ErroMNZJ4HusUCzbnPsENsqGKw3t1vY=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3102.eurprd08.prod.outlook.com (52.133.15.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Fri, 2 Aug 2019 08:07:52 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236%2]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 08:07:52 +0000
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
Thread-Index: AQHVSQliwT6n8KpuCU6FxpOSkLMZqQ==
Date:   Fri, 2 Aug 2019 08:07:52 +0000
Message-ID: <1564733249-24329-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0038.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::26) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 2f51f6bf-598b-4945-81fa-08d717208e7b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3102;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3102:|AM6PR08MB4951:
X-Microsoft-Antispam-PRVS: <AM6PR08MB49515738EE01634C0031FE999FD90@AM6PR08MB4951.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1201;OLM:1201;
x-forefront-prvs: 011787B9DD
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(186003)(26005)(8936002)(8676002)(102836004)(55236004)(52116002)(6506007)(386003)(256004)(5024004)(66066001)(81156014)(81166006)(6636002)(64756008)(66446008)(7736002)(66476007)(305945005)(86362001)(68736007)(53936002)(99286004)(2616005)(476003)(14454004)(4326008)(25786009)(478600001)(66556008)(66946007)(486006)(50226002)(6436002)(54906003)(3846002)(6512007)(2906002)(316002)(110136005)(2501003)(6486002)(6116002)(5660300002)(71200400001)(71190400001)(2201001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3102;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 6pdKlfsUqRz3yCXj6tRWg/eHtJi8tvhbyVGDIN1ZFsqmt+7+NTEF53dExSFsuIF0WqYBMnKY1aLsqvSYkpjGmcjKD7FClPQ+I5qqsyw2+xdxPCalP/vlc5K0rehB2nCnJA7dx+L9efh4SpbPaj6NBRtvEd/UwPyaRX93g6tEmPFmXGXmqi1yvEk/9JBJQrFCN3ZzT0MylAM906dWRsmeB6x9qkfc+TwP2hhT3H/kkTuAP/F17ICYoYhYJ/QHJ8TSm19wINmULTJXxt9NYZowN4PadrljhOIndBB1x+22FG9HyyNlSxNkvuwXD4+hmJM/YffkRJb6oneFr1xCSOUlyjeL1KFz+Z3ygaV+RnZAiKGdxT4+XnDvxOgs/VBHMoH38IVjVmdljacp2P/5Y2B3a2cA86dS0f3s+q42tJQlxyc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3102
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(189003)(199004)(3846002)(6116002)(26826003)(66066001)(336012)(14454004)(478600001)(2906002)(356004)(50466002)(4326008)(36756003)(316002)(22756006)(186003)(25786009)(2501003)(23756003)(26005)(102836004)(6486002)(99286004)(6506007)(386003)(81166006)(81156014)(305945005)(8746002)(8676002)(126002)(6512007)(8936002)(54906003)(50226002)(63350400001)(63370400001)(7736002)(86362001)(486006)(2616005)(6636002)(5024004)(5660300002)(110136005)(70586007)(76130400001)(476003)(2201001)(47776003)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4951;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9e0bbf13-e159-47c7-ef55-08d71720844c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(710020)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR08MB4951;
NoDisclaimer: True
X-Forefront-PRVS: 011787B9DD
X-Microsoft-Antispam-Message-Info: FsjncEAfg6U7Fy+tIBIAmjv9+B1f7cmwFRXXlb7U2uB2yXobcBAH740lSIeMsP0MHIpvWnsN1ePMBgnV5MtLdhcmUH5CwT+tU+j4UDgAud/tkkKEy3WWcu7vYAS25uz26llAX0nACOtFm1BMnSVEo8RC+v4uz8JZUQW7UmYNCtmEKhmyDHz86DduzCqy1FaPJojaqu4IOJEPqj5NU7AmVw1J3Ej9kSLGWmu4HbIJupzF/sCg0QAxlomS/IaVX8ece9TBlZp4RILoTBcdjoXy0fj2xRLwDch1uVP5EU1Y02ozX5kls+3SqLgLs6hQwUpPt/xo1HcIbuyCWCKEAkEYdqvM7mLa2pEQY5f0l1EiKLmFmjuxednljHDnv+epEPIQFrO11WrKsBO09XplZK2WeP2RhrK648vfGSsBxpoZZGQ=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2019 08:08:09.2535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f51f6bf-598b-4945-81fa-08d717208e7b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4951
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>

Initialize and enable output polling on Komeda.

Changes since v1:
1. Enable the polling before registering the driver;
2. Disable the polling after unregistering the driver.

Changes since v2:
1. If driver register failed, disable the polling.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 419a8b0..d50e75f 100644
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
@@ -322,6 +325,7 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_=
dev *mdev)
 	return kms;
=20
 cleanup_mode_config:
+	drm_kms_helper_poll_fini(drm);
 	drm->irq_enabled =3D false;
 	drm_mode_config_cleanup(drm);
 	komeda_kms_cleanup_private_objs(kms);
@@ -338,6 +342,7 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
 	drm->irq_enabled =3D false;
 	mdev->funcs->disable_irq(mdev);
 	drm_dev_unregister(drm);
+	drm_kms_helper_poll_fini(drm);
 	component_unbind_all(mdev->dev, drm);
 	komeda_kms_cleanup_private_objs(kms);
 	drm_mode_config_cleanup(drm);
--=20
1.9.1

