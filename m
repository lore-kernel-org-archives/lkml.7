Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0582C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0872166E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VL3mOys7";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VL3mOys7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGZIA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:00:56 -0400
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:6885
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfGZIA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9hAvlqZY4rqQmkMA4K7pBcSzfKH1fIUQT0Yt713aek=;
 b=VL3mOys7uIEoxYBQDSMI50MmzJ2paWB1i7DM70EVgVQeiFJNlfVfFi+zjaPC5s7Cf1Ue9qzXPYWxbT51IcnhSNvj7VvBpvHUlgAFEcbfJw4GaMPk/YnyooNPOdUCQgeRsAZIrj64EQjA6qi6r7U0pYRpDjFYKJ48Tc8Cuvy7eXg=
Received: from VI1PR08CA0256.eurprd08.prod.outlook.com (2603:10a6:803:dc::29)
 by HE1PR0801MB1852.eurprd08.prod.outlook.com (2603:10a6:3:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Fri, 26 Jul
 2019 08:00:46 +0000
Received: from DB5EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR08CA0256.outlook.office365.com
 (2603:10a6:803:dc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10 via Frontend
 Transport; Fri, 26 Jul 2019 08:00:46 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT038.mail.protection.outlook.com (10.152.21.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Fri, 26 Jul 2019 08:00:44 +0000
Received: ("Tessian outbound a1fd2c3cfdb0:v26"); Fri, 26 Jul 2019 08:00:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2c38f58e915841d2
X-CR-MTA-TID: 64aa7808
Received: from f8d90f083fa6.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.1.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6DB61585-75E7-4C17-A824-73EFA900CB4B.1;
        Fri, 26 Jul 2019 08:00:32 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2053.outbound.protection.outlook.com [104.47.1.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f8d90f083fa6.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 26 Jul 2019 08:00:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I18vSTr9RFkgDUFEbMrSGGKiQG1tmrtjLibT3KeRi5qeuQPQuWxQTFy6dJ5NSNTwvJYHNDAjHO/so18/92ONVRsQmR+wMpXJHJw/+GO0bGKmlDnpy8a6H091ec4K9Y2GsHrC43zhtaYmVSxR7hXEVtDPP0uht9Bd6B8p89CKQJzxglnvrLkfcTUViRiwI+hZylvjCiQh4OOnorWzZkLrxT9dFf6zCy461o49ynLskH6eE6dTPWt1fSS2uzlbtMCkXo6ia2GQ7z+V+FV3/icv3X7KibK21ZrrQqlc4p2FqweCjU6UJcPHrViLIweSqOnlUcX9qtS+KZ6svirYQtBExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9hAvlqZY4rqQmkMA4K7pBcSzfKH1fIUQT0Yt713aek=;
 b=Dx5aIU6QYL+dhWzi0vALhn5RoYLLIp0m04tOsYJ32+SB93MpvgPOqvFu4GNVrdE/TvhHFx993cZbIcj9/r459iHBP/HUr1id5Ws7WbW3GqQhlbQ8x/ufo4Nn9NC+YJIgPKvmUq3wc47kMpYchpT8z2046CblaJmBVQgeiO2+6WjnVUtKLGT8PBzRJ1QClzQFfhz3aUTIX/mopLsBkFhyR4DYM7oA+1Wyjz+oj4p1HblBivZTXTKOaKW8jipApX2Xtdpca13V13j/n4CEoLA32T5ES4edy6bE5vdpr9munRQs8rF+grvgRlsI83oi0pr1WcAQDAqcInqavQ3V+u1oAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9hAvlqZY4rqQmkMA4K7pBcSzfKH1fIUQT0Yt713aek=;
 b=VL3mOys7uIEoxYBQDSMI50MmzJ2paWB1i7DM70EVgVQeiFJNlfVfFi+zjaPC5s7Cf1Ue9qzXPYWxbT51IcnhSNvj7VvBpvHUlgAFEcbfJw4GaMPk/YnyooNPOdUCQgeRsAZIrj64EQjA6qi6r7U0pYRpDjFYKJ48Tc8Cuvy7eXg=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3853.eurprd08.prod.outlook.com (20.178.80.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.11; Fri, 26 Jul 2019 08:00:29 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236%2]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 08:00:29 +0000
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
Thread-Index: AQHVQ4gxcUI2LA7y70qnz7F7goWSOw==
Date:   Fri, 26 Jul 2019 08:00:29 +0000
Message-ID: <1564128018-22921-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::28) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 46526904-e18f-425f-b199-08d7119f5c3c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3853;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3853:|HE1PR0801MB1852:
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1852CF97C36D616D60627DF59FC00@HE1PR0801MB1852.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:389;OLM:389;
x-forefront-prvs: 01106E96F6
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(189003)(199004)(66476007)(50226002)(66446008)(52116002)(4744005)(86362001)(102836004)(55236004)(2201001)(99286004)(26005)(6512007)(110136005)(8676002)(6116002)(68736007)(186003)(25786009)(14454004)(8936002)(316002)(5660300002)(66066001)(2906002)(2501003)(305945005)(6436002)(478600001)(6636002)(36756003)(81166006)(81156014)(66556008)(4326008)(3846002)(386003)(53936002)(6506007)(7736002)(66946007)(64756008)(54906003)(71190400001)(256004)(71200400001)(486006)(476003)(2616005)(6486002)(5024004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3853;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 6PwNaH/Rs9ix0nQ8HHDRL0MndgXuFTZS8KDG5dFFK3kBsLugawUje6KqR5LObmR+WaTOfA/cB4vNGLRv8CJ8pmCI3nwbIfMzHYzVX9BHPZ/eaHs7VprTXRJyUkpMKOOEOOBcB12l3VQGgvi1R0EwmUxctUMta1Nv2KsS7dn393i9UuREWLNkeUXycU5CKM0xc1GuR0DxO7UmNarNtq4gYB/oUQJ1WvL2SmSRKdqtewKx1n/zT0DV7hpSh9qV8KImLOsTYcV1TXC2p79nZJssWazKCgIMK3yWRUdPZygNEDAt9MABM1P13agxJS5tQstmi/Z3+woF1ynUKxIP2BiBQahDU0GiRaTH96ZSfrrNSWog8XDjCe/goenIIUc0DmrIO82uVpkp/SWH/rPb1jNoPnmbrrolgGJsg+Jf9a9aJ6M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3853
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(199004)(189003)(86362001)(5660300002)(66066001)(2501003)(54906003)(25786009)(81156014)(8936002)(81166006)(36756003)(316002)(8746002)(110136005)(478600001)(2906002)(70586007)(76130400001)(99286004)(356004)(26005)(26826003)(50226002)(14454004)(70206006)(102836004)(386003)(23756003)(305945005)(7736002)(186003)(22756006)(6636002)(476003)(6512007)(6486002)(336012)(5024004)(486006)(8676002)(50466002)(2616005)(4326008)(126002)(63350400001)(3846002)(47776003)(6506007)(63370400001)(6116002)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1852;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5d1cc015-8268-484a-7700-08d7119f5376
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:HE1PR0801MB1852;
NoDisclaimer: True
X-Forefront-PRVS: 01106E96F6
X-Microsoft-Antispam-Message-Info: i5iVij54YVxlyeDUv2kZNVS6RUQn5eccSdp0RP3vN9k8vb9JxtJU6SlOoU9gklbhIbFpAwcKsiIstSbnTTqnb3acyL3wIlLgUhqEi6VzqctyHjDN0TWd+ZfbrNSxZQ+AzV/7oYkug/XJTJojDm7oGguCcQRgiOdnbU7zbOIRqwfwMk3RIl5mf+EBZwAeMneJvkeh7SxxaFNBgZWRiTIEcIRKX0aRItf4+vt9a/NAKyObXZw/Wk1+TX9EsgEYYpye38WgSG8v1qmATTFGEp6li4OlAWbcqtq9WaXBaQc7jnS8VzyrrfJtqQiRoWnkaQt3X9GCpVFcIrQdGWSN14wEtsgLJdlryV0gQYm5cjWBOJ+j/ijciHhMun5cb8GYziHScQFseMiUk/vYmtkDT4v2za9b9fMI/SdlGrC8EiaxVEs=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2019 08:00:44.0637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46526904-e18f-425f-b199-08d7119f5c3c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1852
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize and enable output polling on Komeda.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 1462bac..26f2919 100644
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
@@ -331,6 +332,8 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_=
dev *mdev)
 	if (err)
 		goto uninstall_irq;
=20
+	drm_kms_helper_poll_init(drm);
+
 	return kms;
=20
 uninstall_irq:
@@ -348,6 +351,7 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
 	struct drm_device *drm =3D &kms->base;
 	struct komeda_dev *mdev =3D drm->dev_private;
=20
+	drm_kms_helper_poll_fini(drm);
 	mdev->funcs->disable_irq(mdev);
 	drm_dev_unregister(drm);
 	drm_irq_uninstall(drm);
--=20
1.9.1

