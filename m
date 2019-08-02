Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C8BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EB72087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="znfkw8G+";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="znfkw8G+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405074AbfHBJnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:43:33 -0400
Received: from mail-eopbgr30058.outbound.protection.outlook.com ([40.107.3.58]:36575
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392165AbfHBJna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC3jbMbQ63MLQHJ9M4BjOtJXh3cP2Zhrf529IOH33DA=;
 b=znfkw8G+oLa7ha582+IX+kJunrfpyThkxrr/z0nJDSH5ehRM+j/zCNAcS1sztSyZ6dAkt0t0bA1a22v7B9bfLZGVgkmCzTA7Z0GgXQN1sCB+R4Uqycv60PPqKRaNuaGuMFsoOuOreWDw8upNxAuzf+PS2ptexLJQtj0aZC8JseU=
Received: from VI1PR08CA0109.eurprd08.prod.outlook.com (2603:10a6:800:d4::11)
 by AM5PR0802MB2594.eurprd08.prod.outlook.com (2603:10a6:203:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.17; Fri, 2 Aug
 2019 09:43:25 +0000
Received: from AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by VI1PR08CA0109.outlook.office365.com
 (2603:10a6:800:d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.12 via Frontend
 Transport; Fri, 2 Aug 2019 09:43:24 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT013.mail.protection.outlook.com (10.152.16.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Fri, 2 Aug 2019 09:43:23 +0000
Received: ("Tessian outbound cc8a947d4660:v26"); Fri, 02 Aug 2019 09:43:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d3f901cf4190d08f
X-CR-MTA-TID: 64aa7808
Received: from 9eb9efb7f3be.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1829F428-FC2D-4444-92A1-277576AFEA34.1;
        Fri, 02 Aug 2019 09:43:14 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9eb9efb7f3be.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 02 Aug 2019 09:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lr8LYsL3o1rHOXQYKfMekFWabsz2VNwp6FNGV2Ig4xRKRXeHiumoOCEo+fqf9uddeMa5Hdv58ywxWXb6/Dnojz19CtiLEE3qD7nVzWPKlxusYZ2wG1uAzz1Tz236OnVYKHRyRHYWkKNn6dpEkMNr1I6753waFYw5ZzvvDSSbTmf4ETZ/VX5Sgk//d8VaHHD1Imav8+yfoE6gXVPMBZDvCrClWppOb4KaqGyN18agKpYU75NC25kI5xj4RdYzbljl7sZFblTekm6IOtKF8VCGR7chhPXzB0S+Jb1BK3LWxm/18NpcebJexeNW5lgIRodAsxJ8LII0Qtv/609wtZYN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC3jbMbQ63MLQHJ9M4BjOtJXh3cP2Zhrf529IOH33DA=;
 b=iZu50nqrIW1VrYNRmv6ohA/7ID5MoQqVDoidAT11er8KNr6DnWH4jd6/FOpt6MzZOvWlX0H2/Kr6LDAfN8S+a/l4iEz597bnpzF+p7eDt1X7O6c8+F6W83ZI1Izpi/JFZoeil1Z3H3E+btKHROwW9f1xKQykANe4qkj1G/8SWrN7V5aGkvxFEKlu5lz7zA88h91o32Dl/EwNUQRI/cvdgjuqat6nROsB9dgRUxZ8uHpfldvNk3WGebsMovrEvYFQT70syv4ixtgXon2oHHm7dRSDwbQzc8ycy+JAVw9nwefhMJs4o7pJpkpCuyO6oMwPzWz/OLjAWBGhr4qNbpAIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC3jbMbQ63MLQHJ9M4BjOtJXh3cP2Zhrf529IOH33DA=;
 b=znfkw8G+oLa7ha582+IX+kJunrfpyThkxrr/z0nJDSH5ehRM+j/zCNAcS1sztSyZ6dAkt0t0bA1a22v7B9bfLZGVgkmCzTA7Z0GgXQN1sCB+R4Uqycv60PPqKRaNuaGuMFsoOuOreWDw8upNxAuzf+PS2ptexLJQtj0aZC8JseU=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3551.eurprd08.prod.outlook.com (20.177.61.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Fri, 2 Aug 2019 09:43:10 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::c091:c28c:bb1a:5236%2]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 09:43:10 +0000
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
        nd <nd@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Subject: [PATCH] drm/komeda: Adds error event print functionality
Thread-Topic: [PATCH] drm/komeda: Adds error event print functionality
Thread-Index: AQHVSRayAboXOjuz1kKxLGlCvtrW0Q==
Date:   Fri, 2 Aug 2019 09:43:10 +0000
Message-ID: <1564738954-6101-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::15) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 9af58e48-2a19-4932-3ec6-08d7172ddc83
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3551;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3551:|AM5PR0802MB2594:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2594448C9323D773C60ACCA99FD90@AM5PR0802MB2594.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6430;OLM:6430;
x-forefront-prvs: 011787B9DD
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(6506007)(386003)(110136005)(54906003)(7736002)(6512007)(6436002)(3846002)(6116002)(2906002)(476003)(2201001)(6636002)(478600001)(53936002)(99286004)(305945005)(86362001)(36756003)(68736007)(81156014)(66556008)(52116002)(5660300002)(256004)(66066001)(64756008)(66476007)(71190400001)(55236004)(2501003)(26005)(66446008)(81166006)(2616005)(71200400001)(8936002)(102836004)(186003)(486006)(8676002)(66946007)(4326008)(316002)(14454004)(50226002)(25786009)(6486002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3551;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: WvC8Qx3KUb8OXLDJwp7ISuNNvzSa17XYNrR7e/UFTLzm4rK+TWVo1mhrMXPPPREShLpEp9L6zrdP88tpV0YgrbT9B7brqkckGaA7FKXabfHcVc32FV6UUK4UYMg3vK7ibtJlcm5X2zelgtdGss43M2CmzGKedAbN8pPbq0OL0HwD3+86fCO0Lqe6MWqlT0vIwE21YIKgYOBlT6a72L1gP2RlHwEApBY5SQjyQAnYNHVHiBc7yGjQGnYn68/e912sPGRNM+pOSWqm8XUrymf9Y+vAio2ENBt1djgpB2j63Up9R6OVTh7ERTElNxsMLmZrUnWdFb8rXY0MGlLmS91Wesu/03ICfLd1YH9K6g8+6izOfaM4REb2iGvbAv5EchjCb/WM0DdOcimEaA2FF1Mc+KJANP5y94dHZitDzuhg9tY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3551
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(189003)(199004)(36906005)(23756003)(110136005)(8936002)(8746002)(356004)(14444005)(81166006)(81156014)(36756003)(22756006)(8676002)(2501003)(6486002)(99286004)(478600001)(7736002)(4326008)(25786009)(2201001)(50466002)(54906003)(6512007)(26826003)(305945005)(186003)(70586007)(76130400001)(6636002)(70206006)(26005)(50226002)(14454004)(102836004)(86362001)(2906002)(316002)(486006)(336012)(6506007)(3846002)(476003)(2616005)(63350400001)(63370400001)(66066001)(6116002)(5660300002)(386003)(47776003)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0802MB2594;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 13fb864a-7427-4f8d-6899-08d7172dd4b6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR0802MB2594;
NoDisclaimer: True
X-Forefront-PRVS: 011787B9DD
X-Microsoft-Antispam-Message-Info: ODzVhht4JHSJ2ARKpTNWPQoKJMczLJXOdhaGy/QWO/rSkaVxc3skMEKyUA/u1F0db6CGjLprNldo7l4S6lZcBXB0oFhw+TNq19hYsYM/QkvbUej+8AGHzIPzDEuCwVmErNp7fipm9nM3+pzI7XuMUo59XHg1w4rA8QFV5A4lAHpVN1uc//S2sSRvwROexBQYAZhXtsO3Y9ARhuBkIVf7twSZMm2wdzI/KIMZu80z/kcZ6Yyaerd+JBzV7gDUfBHcp9Dz3yJcxE//I7wuHIsVpO0TW0wyNP9iIyazb3PZmwqvbrqBjexMjhBCvwETKWzIaLqRvPN9AItR2NmJmorACXiJFRUahtUS3h5THltiLvFG713bExqxC+w5Jh6dMF35NyPOv/xnKUsi9y24FLvxSRqt7LoZlB0RDXIDnqOT25s=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2019 09:43:23.5859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af58e48-2a19-4932-3ec6-08d7172ddc83
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2594
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>

Adds to print the event message when error happens and the same event
will not be printed until next vsync.

Changes since v2:
1. Refine komeda_sprintf();
2. Not using STR_SZ macro for the string size in komeda_print_events().

Changes since v1:
1. Handling the event print by CONFIG_KOMEDA_ERROR_PRINT;
2. Changing the max string size to 256.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 drivers/gpu/drm/arm/display/Kconfig               |   6 +
 drivers/gpu/drm/arm/display/komeda/Makefile       |   2 +
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h   |  15 +++
 drivers/gpu/drm/arm/display/komeda/komeda_event.c | 140 ++++++++++++++++++=
++++
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c   |   4 +
 5 files changed, 167 insertions(+)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_event.c

diff --git a/drivers/gpu/drm/arm/display/Kconfig b/drivers/gpu/drm/arm/disp=
lay/Kconfig
index cec0639..e87ff86 100644
--- a/drivers/gpu/drm/arm/display/Kconfig
+++ b/drivers/gpu/drm/arm/display/Kconfig
@@ -12,3 +12,9 @@ config DRM_KOMEDA
 	  Processor driver. It supports the D71 variants of the hardware.
=20
 	  If compiled as a module it will be called komeda.
+
+config DRM_KOMEDA_ERROR_PRINT
+	bool "Enable komeda error print"
+	depends on DRM_KOMEDA
+	help
+	  Choose this option to enable error printing.
diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index 5c3900c..f095a1c 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -22,4 +22,6 @@ komeda-y +=3D \
 	d71/d71_dev.o \
 	d71/d71_component.o
=20
+komeda-$(CONFIG_DRM_KOMEDA_ERROR_PRINT) +=3D komeda_event.o
+
 obj-$(CONFIG_DRM_KOMEDA) +=3D komeda.o
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index d1c86b6..e28e7e6 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -40,6 +40,17 @@
 #define KOMEDA_ERR_TTNG			BIT_ULL(30)
 #define KOMEDA_ERR_TTF			BIT_ULL(31)
=20
+#define KOMEDA_ERR_EVENTS	\
+	(KOMEDA_EVENT_URUN	| KOMEDA_EVENT_IBSY	| KOMEDA_EVENT_OVR |\
+	KOMEDA_ERR_TETO		| KOMEDA_ERR_TEMR	| KOMEDA_ERR_TITR |\
+	KOMEDA_ERR_CPE		| KOMEDA_ERR_CFGE	| KOMEDA_ERR_AXIE |\
+	KOMEDA_ERR_ACE0		| KOMEDA_ERR_ACE1	| KOMEDA_ERR_ACE2 |\
+	KOMEDA_ERR_ACE3		| KOMEDA_ERR_DRIFTTO	| KOMEDA_ERR_FRAMETO |\
+	KOMEDA_ERR_ZME		| KOMEDA_ERR_MERR	| KOMEDA_ERR_TCF |\
+	KOMEDA_ERR_TTNG		| KOMEDA_ERR_TTF)
+
+#define KOMEDA_WARN_EVENTS	KOMEDA_ERR_CSCE
+
 /* malidp device id */
 enum {
 	MALI_D71 =3D 0,
@@ -207,4 +218,8 @@ struct komeda_dev {
=20
 struct komeda_dev *dev_to_mdev(struct device *dev);
=20
+#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
+void komeda_print_events(struct komeda_events *evts);
+#endif
+
 #endif /*_KOMEDA_DEV_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_event.c
new file mode 100644
index 0000000..a36fb86
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2019 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include <drm/drm_print.h>
+
+#include "komeda_dev.h"
+
+struct komeda_str {
+	char *str;
+	u32 sz;
+	u32 len;
+};
+
+/* return 0 on success,  < 0 on no space.
+ */
+static int komeda_sprintf(struct komeda_str *str, const char *fmt, ...)
+{
+	va_list args;
+	int num, free_sz;
+	int err;
+
+	free_sz =3D str->sz - str->len - 1;
+	if (free_sz <=3D 0)
+		return -ENOSPC;
+
+	va_start(args, fmt);
+
+	num =3D vsnprintf(str->str + str->len, free_sz, fmt, args);
+
+	va_end(args);
+
+	if (num < free_sz) {
+		str->len +=3D num;
+		err =3D 0;
+	} else {
+		str->len =3D str->sz - 1;
+		err =3D -ENOSPC;
+	}
+
+	return err;
+}
+
+static void evt_sprintf(struct komeda_str *str, u64 evt, const char *msg)
+{
+	if (evt)
+		komeda_sprintf(str, msg);
+}
+
+static void evt_str(struct komeda_str *str, u64 events)
+{
+	if (events =3D=3D 0ULL) {
+		komeda_sprintf(str, "None");
+		return;
+	}
+
+	evt_sprintf(str, events & KOMEDA_EVENT_VSYNC, "VSYNC|");
+	evt_sprintf(str, events & KOMEDA_EVENT_FLIP, "FLIP|");
+	evt_sprintf(str, events & KOMEDA_EVENT_EOW, "EOW|");
+	evt_sprintf(str, events & KOMEDA_EVENT_MODE, "OP-MODE|");
+
+	evt_sprintf(str, events & KOMEDA_EVENT_URUN, "UNDERRUN|");
+	evt_sprintf(str, events & KOMEDA_EVENT_OVR, "OVERRUN|");
+
+	/* GLB error */
+	evt_sprintf(str, events & KOMEDA_ERR_MERR, "MERR|");
+	evt_sprintf(str, events & KOMEDA_ERR_FRAMETO, "FRAMETO|");
+
+	/* DOU error */
+	evt_sprintf(str, events & KOMEDA_ERR_DRIFTTO, "DRIFTTO|");
+	evt_sprintf(str, events & KOMEDA_ERR_FRAMETO, "FRAMETO|");
+	evt_sprintf(str, events & KOMEDA_ERR_TETO, "TETO|");
+	evt_sprintf(str, events & KOMEDA_ERR_CSCE, "CSCE|");
+
+	/* LPU errors or events */
+	evt_sprintf(str, events & KOMEDA_EVENT_IBSY, "IBSY|");
+	evt_sprintf(str, events & KOMEDA_ERR_AXIE, "AXIE|");
+	evt_sprintf(str, events & KOMEDA_ERR_ACE0, "ACE0|");
+	evt_sprintf(str, events & KOMEDA_ERR_ACE1, "ACE1|");
+	evt_sprintf(str, events & KOMEDA_ERR_ACE2, "ACE2|");
+	evt_sprintf(str, events & KOMEDA_ERR_ACE3, "ACE3|");
+
+	/* LPU TBU errors*/
+	evt_sprintf(str, events & KOMEDA_ERR_TCF, "TCF|");
+	evt_sprintf(str, events & KOMEDA_ERR_TTNG, "TTNG|");
+	evt_sprintf(str, events & KOMEDA_ERR_TITR, "TITR|");
+	evt_sprintf(str, events & KOMEDA_ERR_TEMR, "TEMR|");
+	evt_sprintf(str, events & KOMEDA_ERR_TTF, "TTF|");
+
+	/* CU errors*/
+	evt_sprintf(str, events & KOMEDA_ERR_CPE, "COPROC|");
+	evt_sprintf(str, events & KOMEDA_ERR_ZME, "ZME|");
+	evt_sprintf(str, events & KOMEDA_ERR_CFGE, "CFGE|");
+	evt_sprintf(str, events & KOMEDA_ERR_TEMR, "TEMR|");
+
+	if (str->len > 0 && (str->str[str->len - 1] =3D=3D '|')) {
+		str->str[str->len - 1] =3D 0;
+		str->len--;
+	}
+}
+
+static bool is_new_frame(struct komeda_events *a)
+{
+	return (a->pipes[0] | a->pipes[1]) &
+	       (KOMEDA_EVENT_FLIP | KOMEDA_EVENT_EOW);
+}
+
+void komeda_print_events(struct komeda_events *evts)
+{
+	u64 print_evts =3D KOMEDA_ERR_EVENTS;
+	static bool en_print =3D true;
+
+	/* reduce the same msg print, only print the first evt for one frame */
+	if (evts->global || is_new_frame(evts))
+		en_print =3D true;
+	if (!en_print)
+		return;
+
+	if ((evts->global | evts->pipes[0] | evts->pipes[1]) & print_evts) {
+		char msg[256];
+		struct komeda_str str;
+
+		str.str =3D msg;
+		str.sz  =3D sizeof(msg);
+		str.len =3D 0;
+
+		komeda_sprintf(&str, "gcu: ");
+		evt_str(&str, evts->global);
+		komeda_sprintf(&str, ", pipes[0]: ");
+		evt_str(&str, evts->pipes[0]);
+		komeda_sprintf(&str, ", pipes[1]: ");
+		evt_str(&str, evts->pipes[1]);
+
+		DRM_ERROR("err detect: %s\n", msg);
+
+		en_print =3D false;
+	}
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 419a8b0..0fafc36 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -47,6 +47,10 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void =
*data)
 	memset(&evts, 0, sizeof(evts));
 	status =3D mdev->funcs->irq_handler(mdev, &evts);
=20
+#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
+	komeda_print_events(&evts);
+#endif
+
 	/* Notify the crtc to handle the events */
 	for (i =3D 0; i < kms->n_crtcs; i++)
 		komeda_crtc_handle_event(&kms->crtcs[i], &evts);
--=20
1.9.1

