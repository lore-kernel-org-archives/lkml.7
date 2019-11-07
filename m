Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2DEFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EF321D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="OpbLGSyv";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="OpbLGSyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbfKGLmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:42:47 -0500
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:29333
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfKGLmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b3iYlLZWzR/gv7TQUT6UmWjYNPax9/PEPOebKvxCHE=;
 b=OpbLGSyvQz6d0KOmYEkm2f3VyTunopVEoT9Oc1W88pmJdminO/AqbC1hOkoxdNe3cUIn7MTV5W/fnKfm8rmUxZiVt9seYrVs4J28kBcatocqtwV+gN3Uo4S/r/O507H0+7A/o0IfKJRwfUucpts487lI6852wFqmOrR84KEK3Vs=
Received: from VI1PR08CA0195.eurprd08.prod.outlook.com (2603:10a6:800:d2::25)
 by DB6PR08MB2648.eurprd08.prod.outlook.com (2603:10a6:6:17::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Thu, 7 Nov
 2019 11:42:43 +0000
Received: from AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by VI1PR08CA0195.outlook.office365.com
 (2603:10a6:800:d2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Thu, 7 Nov 2019 11:42:42 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT015.mail.protection.outlook.com (10.152.16.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.21 via Frontend Transport; Thu, 7 Nov 2019 11:42:42 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Thu, 07 Nov 2019 11:42:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4826ba7dcdbc61c1
X-CR-MTA-TID: 64aa7808
Received: from d74b0305b8f4.2 (cr-mta-lb-1.cr-mta-net [104.47.10.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BDC9ABAD-C30F-491D-856C-536121798DAD.1;
        Thu, 07 Nov 2019 11:42:34 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d74b0305b8f4.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 07 Nov 2019 11:42:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMnaPiy0w03Jr9WS7EMWxfqGW73SdCFfHrDUm8OLTZUwW4Hlq19R+r5MvbZqwCZBKAHM1z1pcTDaQMMNEbIzoC7Jm/T4WaObBQakc0shhAIcnY2NF3CVy+fUhgmONqdPSrvJgvKJEkl8P4gtHowhrX6xK0cnLlfH7/Nd4wAzNjnTjCB+ZweAUEphZYnqEBqAuMXFSsn8iaFiqh23N/XCDfi4YeMl/M/Xe0o+8X2cQIumOycTzKRUmdSNCkAv3gD+Oz/lR6IEmzuBqLbJxrKAZeG7c5UsMaPsxFFSKFC7QnWOYgwrH44qfVAyqdtmCb6bOZptP+G12TovfqcuMMj4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b3iYlLZWzR/gv7TQUT6UmWjYNPax9/PEPOebKvxCHE=;
 b=btguVs0hRqaSOsyFxyWwZh44IDJN3O06f1Q/GwUWsyh95on2KRNP6L+jdztith65ZpcYcomJT7Pzwc7858UX9IqHO7gkbg50I789EEJhngHwJI8Gs6R6rPjQ7J/lFdHS8TYUQI8+WD/tIAH+vEdLuiNi+SLyyuYznDKX0fsnHODJon3ezRvbq1gRlG6TDjWrVn0MPSYBupfQy5PeaVMVaTtnUxgy9XnLfwAsUI2oQgUJ1rBn6iDD7iASIG5XdAb3LPVBrFgrjHvALuy0aFqBzOGXuZ/0QE2jaO/Vpt7CPNAtEzV1f6XrW+VlDHAc3hcev3JED3Ly+fuzSJFdp2UGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b3iYlLZWzR/gv7TQUT6UmWjYNPax9/PEPOebKvxCHE=;
 b=OpbLGSyvQz6d0KOmYEkm2f3VyTunopVEoT9Oc1W88pmJdminO/AqbC1hOkoxdNe3cUIn7MTV5W/fnKfm8rmUxZiVt9seYrVs4J28kBcatocqtwV+gN3Uo4S/r/O507H0+7A/o0IfKJRwfUucpts487lI6852wFqmOrR84KEK3Vs=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4351.eurprd08.prod.outlook.com (20.179.27.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 11:42:33 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 11:42:33 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] drm/komeda: Remove CONFIG_KOMEDA_ERROR_PRINT
Thread-Topic: [PATCH v2 2/5] drm/komeda: Remove CONFIG_KOMEDA_ERROR_PRINT
Thread-Index: AQHVlWBx2XXtfB7TZUW+rZWpSHV87g==
Date:   Thu, 7 Nov 2019 11:42:32 +0000
Message-ID: <20191107114155.54307-3-mihail.atanassov@arm.com>
References: <20191107114155.54307-1-mihail.atanassov@arm.com>
In-Reply-To: <20191107114155.54307-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a2fcf57-04a3-464e-192f-08d763779986
X-MS-TrafficTypeDiagnostic: VI1PR08MB4351:|VI1PR08MB4351:|DB6PR08MB2648:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB26481600AC2075CFED0308648F780@DB6PR08MB2648.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1051;OLM:1051;
x-forefront-prvs: 0214EB3F68
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(11346002)(316002)(54906003)(446003)(476003)(50226002)(71200400001)(6512007)(305945005)(6916009)(2906002)(8936002)(2616005)(44832011)(4326008)(6436002)(66066001)(256004)(486006)(86362001)(26005)(71190400001)(36756003)(52116002)(2351001)(14444005)(6506007)(99286004)(6486002)(102836004)(2501003)(76176011)(386003)(186003)(6116002)(14454004)(66946007)(66476007)(66556008)(64756008)(66446008)(25786009)(478600001)(1076003)(3846002)(8676002)(81166006)(81156014)(7736002)(5640700003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4351;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZZZB3el+pAAntxthtfbiPspqYYl/hnAHWMIbzr0q83FvDdB7TnteaNCxSwfAw/RHFReQfAtUyrbVHkRdoO24YWNr2SJIxFcmKjrVNDJ3I0ko2IdQqu1hcZTvUxLsD3SMgxF/HuZvHrcfigy7jkH9Gk3KzSl2YY34NI3SDMdAdCxFOK18Zm3X/BpqWeCdOr4atQpn4KrHe3z6IuQrHg5zDguIOC3u0t1Erko0uu69Q0EfDgwcf57HjfRmRBEIRPGwqR/G+r5/1VNCka92XYpYIbfrFC6SHUpEKz6oROCNyG47LYDC+FUpoTUsPvWNqt/NmkkGCdwT/+j83rzjOsGmbsrvLmnlcUQrQSlqhutAcfF4r2xmy+4JMoHYSjBh/Cc4Fr+21ZoK/YWuJDhgG+R65chltd9ku+zOngN60YUHBovMjBy2OOf2b9TlKkzLZlJR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4351
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(1110001)(339900001)(199004)(189003)(6506007)(126002)(386003)(446003)(2616005)(105606002)(11346002)(99286004)(486006)(305945005)(22756006)(102836004)(476003)(26005)(186003)(2501003)(54906003)(50466002)(7736002)(478600001)(26826003)(14454004)(5640700003)(316002)(336012)(2351001)(6486002)(356004)(6512007)(25786009)(5660300002)(1076003)(36756003)(8676002)(14444005)(8936002)(81156014)(47776003)(70586007)(70206006)(8746002)(81166006)(50226002)(66066001)(23756003)(76176011)(86362001)(3846002)(6862004)(76130400001)(2906002)(4326008)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2648;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e53b8a69-a7f0-44bf-589a-08d7637793a7
NoDisclaimer: True
X-Forefront-PRVS: 0214EB3F68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8Ze6zLB9uLRXwS50euEAbuADYfLEgWZ9lBXqMnMIPXhpR6U21WP58k7Q/kJmyn1+OqnNCaPrNk0eSEzaEh6sh3kZv7ZjaCgrBquJfjpmwbRl8BuqbZzqS28cQzf7OWdHzN+g4mKNJru+5qgVFA9bvRh9JP+D8u97UtaCvArdKVH67sXCMSuh7dxOH2Xa1ZW4KWh1lmBYiVLveKC4Ae0IVma8gCV3o5y1ii0iyy83YOKfDq/hmISpepsPj2nNsmSn6MS1Cb/1QYBkXYLtqukn8rmlNsMWOPGrHNWL/ULov+C8aqJD4RgSg/IuUZMW9vyxpc5ogyeL9ks8DQADa4UMXN1fQJ/T/SjFQnDvuDZUzkwO/uWIMWT1SL4aSYJ5WBsfhXU/w6RY2v1Un84yegrdIms+1U5Hm1GVeyMpKmegDyTrpnjB7t19o9iZNVBmJE8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 11:42:42.3544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2fcf57-04a3-464e-192f-08d763779986
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there's a debugfs node to control the same, remove the
config option.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/Kconfig             | 6 ------
 drivers/gpu/drm/arm/display/komeda/Makefile     | 5 ++---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 6 ------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/Kconfig b/drivers/gpu/drm/arm/disp=
lay/Kconfig
index e87ff8623076..cec0639e3aa1 100644
--- a/drivers/gpu/drm/arm/display/Kconfig
+++ b/drivers/gpu/drm/arm/display/Kconfig
@@ -12,9 +12,3 @@ config DRM_KOMEDA
 	  Processor driver. It supports the D71 variants of the hardware.
=20
 	  If compiled as a module it will be called komeda.
-
-config DRM_KOMEDA_ERROR_PRINT
-	bool "Enable komeda error print"
-	depends on DRM_KOMEDA
-	help
-	  Choose this option to enable error printing.
diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index f095a1c68ac7..1931a7fa1a14 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -16,12 +16,11 @@ komeda-y :=3D \
 	komeda_crtc.o \
 	komeda_plane.o \
 	komeda_wb_connector.o \
-	komeda_private_obj.o
+	komeda_private_obj.o \
+	komeda_event.o
=20
 komeda-y +=3D \
 	d71/d71_dev.o \
 	d71/d71_component.o
=20
-komeda-$(CONFIG_DRM_KOMEDA_ERROR_PRINT) +=3D komeda_event.o
-
 obj-$(CONFIG_DRM_KOMEDA) +=3D komeda.o
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index b5bd3d5898ee..831c375180f8 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -226,13 +226,7 @@ void komeda_dev_destroy(struct komeda_dev *mdev);
=20
 struct komeda_dev *dev_to_mdev(struct device *dev);
=20
-#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
 void komeda_print_events(struct komeda_events *evts, struct drm_device *de=
v);
-#else
-static inline void komeda_print_events(struct komeda_events *evts,
-				       struct drm_device *dev)
-{}
-#endif
=20
 int komeda_dev_resume(struct komeda_dev *mdev);
 int komeda_dev_suspend(struct komeda_dev *mdev);
--=20
2.23.0

