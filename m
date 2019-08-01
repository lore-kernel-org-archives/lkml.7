Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159B7C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5B020B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Jeyt/5sY";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Jeyt/5sY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfHALhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:37:47 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:10830
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729316AbfHALhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B3kRhxDKN309WlgD0F4Z17E9I1IFbdDJKdWWR1UfrI=;
 b=Jeyt/5sYkSf0oPa0TD/SHq8fC1B4tx/XSern2gwgdmvU9G1XmWQ8QE5KiqU22P0jpbPMTFA1yCiA+t5l6bWj7qrR+CmMLeML4zZ78FKLz/DfkZuV2NejGUkQpI82W8NV+1WC13jXunJ3tM/OOTHEBDphZc4nX9up1t0NyVf9zJk=
Received: from VI1PR0802CA0047.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::33) by DB6PR0801MB1845.eurprd08.prod.outlook.com
 (2603:10a6:4:39::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.14; Thu, 1 Aug
 2019 11:37:35 +0000
Received: from VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR0802CA0047.outlook.office365.com
 (2603:10a6:800:a9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.12 via Frontend
 Transport; Thu, 1 Aug 2019 11:37:35 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT059.mail.protection.outlook.com (10.152.19.60) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Thu, 1 Aug 2019 11:37:33 +0000
Received: ("Tessian outbound 71602e13cd49:v26"); Thu, 01 Aug 2019 11:37:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 91774eda1974e065
X-CR-MTA-TID: 64aa7808
Received: from 6ae7899e46a2.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 90B8A925-0D84-40E3-B445-75FCBB61EF7B.1;
        Thu, 01 Aug 2019 11:37:18 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6ae7899e46a2.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Thu, 01 Aug 2019 11:37:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICS8VHzsCL7roMXesHcMsxFYaDnnUCMrLYkXTlmAEMIA4TUDcKGf9ierVLfyoTxIkNG8x4NHRfGbsfhK9ew5iVA+opSg4w+iJEMvZJkDPkeliSdqLfkFBARdt2/NjTtIuRSixaoe6h2rHIup4sG3/5xVge+IFXaHd0B6ek+LqeKxSkgj3HHHDTrtTTme5BF8sDlkwFYI7cD6noDNAzvTMkyJVRXyiWVRqabYX7hZgrGp7EQsNMn8EtG1ryiQB+Isdzlr8lEHLSGoP5742Y4aPBZQqOmEKcE1TizJdm5bBnxJg/5n0SZ7DmkBEwvAOHISk7fPL4gMNucHzJRQ/qA1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B3kRhxDKN309WlgD0F4Z17E9I1IFbdDJKdWWR1UfrI=;
 b=XbkPgVW+xe5ebIRYv7WZh5YtzKLTjgi4bJmP9Oi69t6MjchlKPo+CkQayKvPUjlm0oolaCi981MSTnTgLtWgmK73pZ3+hZliyd32tFH0n56lZ9mTWPd1yRGNQtB7OuvXjAEpHgL179dGqVN8DYW2G+m0FCgln3OX//LcQBUIUYR1/rIb3+LKuxyYIOoEak2yWtHwBGn9HcWGpIHDFhLUVTyl7aM1Z/UTx2t864FDhmBGH5rHLIPQYz7+0BJy72scSOMKErulIe5PFjQT8kHmxP2r7QZlK4OgoSCtAz7mVrC+6W/TZCimv+1/42yTiT/EDEzPR5QNdLIpmBVScKvIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B3kRhxDKN309WlgD0F4Z17E9I1IFbdDJKdWWR1UfrI=;
 b=Jeyt/5sYkSf0oPa0TD/SHq8fC1B4tx/XSern2gwgdmvU9G1XmWQ8QE5KiqU22P0jpbPMTFA1yCiA+t5l6bWj7qrR+CmMLeML4zZ78FKLz/DfkZuV2NejGUkQpI82W8NV+1WC13jXunJ3tM/OOTHEBDphZc4nX9up1t0NyVf9zJk=
Received: from AM7PR08MB5477.eurprd08.prod.outlook.com (10.141.174.204) by
 AM7PR08MB5528.eurprd08.prod.outlook.com (10.141.175.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Thu, 1 Aug 2019 11:37:16 +0000
Received: from AM7PR08MB5477.eurprd08.prod.outlook.com
 ([fe80::a8b8:cc18:ded9:6fdb]) by AM7PR08MB5477.eurprd08.prod.outlook.com
 ([fe80::a8b8:cc18:ded9:6fdb%3]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 11:37:16 +0000
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
Subject: [PATCH] drm/komeda: Adds error event print functionality
Thread-Topic: [PATCH] drm/komeda: Adds error event print functionality
Thread-Index: AQHVSF13B+//d/diR06VTAGnMwmj+A==
Date:   Thu, 1 Aug 2019 11:37:15 +0000
Message-ID: <1564659415-14548-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0158.apcprd02.prod.outlook.com
 (2603:1096:201:1f::18) To AM7PR08MB5477.eurprd08.prod.outlook.com
 (2603:10a6:20b:10f::12)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 478afb0d-a78a-40f7-91b0-08d71674a522
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM7PR08MB5528;
X-MS-TrafficTypeDiagnostic: AM7PR08MB5528:|DB6PR0801MB1845:
X-Microsoft-Antispam-PRVS: <DB6PR0801MB184511197C29CEAE3EE943DA9FDE0@DB6PR0801MB1845.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6430;OLM:6430;
x-forefront-prvs: 01165471DB
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(6506007)(386003)(66066001)(52116002)(102836004)(14454004)(26005)(186003)(50226002)(81156014)(55236004)(2501003)(99286004)(6436002)(54906003)(316002)(81166006)(8936002)(8676002)(53936002)(6486002)(3846002)(6116002)(6636002)(110136005)(6512007)(478600001)(66476007)(66946007)(66556008)(64756008)(66446008)(86362001)(25786009)(4326008)(2906002)(2201001)(305945005)(7736002)(71190400001)(71200400001)(5660300002)(68736007)(14444005)(36756003)(2616005)(476003)(486006)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5528;H:AM7PR08MB5477.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: D7Nkfxd+7gYRkfR0toDWqukx6MQirT1+MnZ2dlheVYnNAiFqTWqAGKuCnnP7cMkIv0hgEHNLKJ5uk2gZunPs4lcXpPlta3bUOqpLhlwFN73CUNiKgSKUTRwDHGRcyolsIS9NtiYkUlmGB//4Ty04UvGVP0h01ufDbBdWiopRLngmuDC4nawVYV3J2eUq8ACL5TiLOM7uc1oMt00ws8K6KCbYd+ygCfh5WN6thxKDTKF4HDuv8MISuF31KxCmxloAn4q+YkVc4IZUbWdl/19p7Bzm56z0DAHRnoVrEM332hbvVF0h5D65vsMRqAmhDB93jh0yLahLyLoRspaG2yTF7i9t5nm9mozbHtDgQFACftoVwewvfatSJKgc/JQ+W6yF8PI2kk3apkF7MyIuKsVXTH34ksvowKcju/3QxNj60FQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5528
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(199004)(189003)(76130400001)(14444005)(336012)(2201001)(4326008)(5660300002)(81166006)(2616005)(110136005)(50466002)(2501003)(36906005)(102836004)(47776003)(70206006)(70586007)(54906003)(66066001)(126002)(36756003)(316002)(86362001)(63350400001)(2906002)(486006)(476003)(63370400001)(81156014)(356004)(50226002)(3846002)(6116002)(478600001)(6486002)(25786009)(26826003)(99286004)(8676002)(23756003)(6506007)(14454004)(7736002)(26005)(6512007)(8746002)(305945005)(386003)(6636002)(8936002)(22756006)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1845;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: bd442fc2-e183-49d7-18f4-08d716749a54
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(710020)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB6PR0801MB1845;
NoDisclaimer: True
X-Forefront-PRVS: 01165471DB
X-Microsoft-Antispam-Message-Info: pTyXLP4e8UGXJKBc2J5P5ZO+U2BRFFrQMHyKwGGF4KuwC37LCgEETHSrlFP2gvaXcmLwEk7ogoFBtpbQuARMf9h8HFS4TXJxl7DTPOIpuRekrI00BD7Hr3QrxlW8pq8Htjrb5v5I2RRdoQAVmcXV8UssAlwCP1G7ZlmvX9yZhHkhaNu/yivKZdN4TSMQEPzumxzYM9hereMKozOtbMNKcC7kOcSVbYzwTj9gIu3iYnj36+Px8d5+k4DKX6wVlxj8A8TVsDhrpbOgVW1rsx7/8EvlxoB64h7e1baN4sgaMZA3w7TPGq55/h0tjpRpbLz7dNDeztJXnjw9o9924ZfK8VJSnX9PI6eC1GUyGtTzR1b02OFzwHMQPJrCzRTWl8/sT+wDYJCRESBEN+aQp67Fc0C3hXIlbLcUKlvimn1AS7c=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2019 11:37:33.7076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 478afb0d-a78a-40f7-91b0-08d71674a522
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1845
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>

Adds to print the event message when error happens and the same event
will not be printed until next vsync.

Changes since v1:
1. Handling the event print by CONFIG_KOMEDA_ERROR_PRINT;
2. Changing the max string size to 256.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 drivers/gpu/drm/arm/display/Kconfig               |   6 +
 drivers/gpu/drm/arm/display/komeda/Makefile       |   2 +
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h   |  15 +++
 drivers/gpu/drm/arm/display/komeda/komeda_event.c | 141 ++++++++++++++++++=
++++
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c   |   4 +
 5 files changed, 168 insertions(+)
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
index 0000000..57b60cd
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
@@ -0,0 +1,141 @@
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
+	free_sz =3D str->sz - str->len;
+	if (free_sz <=3D 0)
+		return -ENOSPC;
+
+	va_start(args, fmt);
+
+	num =3D vsnprintf(str->str + str->len, free_sz, fmt, args);
+
+	va_end(args);
+
+	if (num <=3D free_sz) {
+		str->len +=3D num;
+		err =3D 0;
+	} else {
+		str->len =3D str->sz;
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
+		evt_sprintf(str, 1, "None");
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
+		#define STR_SZ		256
+		char msg[STR_SZ];
+		struct komeda_str str;
+
+		str.str =3D msg;
+		str.sz  =3D STR_SZ;
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

