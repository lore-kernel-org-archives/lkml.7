Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C4EC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F47921D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MDIcln5Y";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MDIcln5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbfKGLmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:42:46 -0500
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:64999
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733181AbfKGLmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Px3I5x1exalU7sGPOYZ9So+eq2jzh/DWgR8Nc28y2p4=;
 b=MDIcln5YVLw6ZbC2AFHkCetlmx6MjLTc5GHrSUiLdDI5H6eKOlFMpoH/X70r0I0QWV/ImCiwsrH1s2yZ2cRRNkatG0PiA2eeJ0aJ74k9F8GigHNi35TwJItz60xAbbchiiqRyIQT9lGiBoAxYLVXFsNR17nL2ppM4t8zGwGmxQ8=
Received: from VI1PR08CA0185.eurprd08.prod.outlook.com (2603:10a6:800:d2::15)
 by VE1PR08MB5072.eurprd08.prod.outlook.com (2603:10a6:803:10a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Thu, 7 Nov
 2019 11:42:39 +0000
Received: from AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::209) by VI1PR08CA0185.outlook.office365.com
 (2603:10a6:800:d2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 11:42:39 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT037.mail.protection.outlook.com (10.152.17.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Thu, 7 Nov 2019 11:42:39 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Thu, 07 Nov 2019 11:42:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 645030880de1a3c0
X-CR-MTA-TID: 64aa7808
Received: from 0078b69d08ee.2 (cr-mta-lb-1.cr-mta-net [104.47.10.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 31FF26D5-CEA3-4BE4-BA96-E536CF898A93.1;
        Thu, 07 Nov 2019 11:42:30 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2059.outbound.protection.outlook.com [104.47.10.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0078b69d08ee.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 07 Nov 2019 11:42:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ioa/rERS0IR96CSsebILIvJdVJfjfUwQ+a7LD3u/cN5l4Gpz+mjOA+8W/1WTo6htPTSHgxZaNnTA8ILz1rFhv1EdLXDSqHWlM8pFnxgDZRAei+iT4RqA6kDNOY9h9Sj2A3lA1rhrTEDAUOtQYx23tqT7DS3116XB71sbxYtXX6VzTjIs/QyUE7pjS1zhkuC136cxbI+H92vbGk95pzgbCDGCcKDhVmCBVmpuHevG1K6Bb75nVcAAtbFlhMWKCoFNrxNKCA10QwWO5BPQIsU/a+RI5SKWLJTo2Vg7iW8jmbgfq0eQL5o7tUdDIP82z/ZEJCsxC7UaTm/BQcamrx+xuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Px3I5x1exalU7sGPOYZ9So+eq2jzh/DWgR8Nc28y2p4=;
 b=Ige5gDllKU8Jl7sUi8isYnY40owRp57XStDVnugbNw6dc1rTwyZ5yUfNsL3UiS6fnGOhDsAsFjSWVns+k7e1yzWFx1P7hw0VSl1MiijSyx2+TI4/HD1Lt34bzM+ZHSi+OxQ67o5mNmHikaNtTDTNEdpYFHZkdjfJ2CiFqSFMHg0cIKwQ8OI9qgJ2rBuDAtyjItt7c+iByieR4jiNYYf7X+TP6wTqnH/p+KaeYGC+yZytXihbL8Zzj50znGbi6YAoynlyzxMGCME9lzcJUjcrNgphLTwtS7eC2KeU05dPxYBU/KljzdtRED0+G87gSZ/63nnBfBXprkIyHibDUoKvIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Px3I5x1exalU7sGPOYZ9So+eq2jzh/DWgR8Nc28y2p4=;
 b=MDIcln5YVLw6ZbC2AFHkCetlmx6MjLTc5GHrSUiLdDI5H6eKOlFMpoH/X70r0I0QWV/ImCiwsrH1s2yZ2cRRNkatG0PiA2eeJ0aJ74k9F8GigHNi35TwJItz60xAbbchiiqRyIQT9lGiBoAxYLVXFsNR17nL2ppM4t8zGwGmxQ8=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4351.eurprd08.prod.outlook.com (20.179.27.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 11:42:29 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 11:42:29 +0000
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
Subject: [PATCH v2 1/5] drm/komeda: Add debugfs node to control error
 verbosity
Thread-Topic: [PATCH v2 1/5] drm/komeda: Add debugfs node to control error
 verbosity
Thread-Index: AQHVlWBvEMFUMNrqkUyDY5X/ImK4tw==
Date:   Thu, 7 Nov 2019 11:42:28 +0000
Message-ID: <20191107114155.54307-2-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8362b5c-e220-4b16-bcea-08d76377978d
X-MS-TrafficTypeDiagnostic: VI1PR08MB4351:|VI1PR08MB4351:|VE1PR08MB5072:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB50728CB7B311F44186AFB1458F780@VE1PR08MB5072.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1850;OLM:1850;
x-forefront-prvs: 0214EB3F68
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(11346002)(316002)(54906003)(446003)(476003)(50226002)(71200400001)(6512007)(305945005)(6916009)(2906002)(8936002)(2616005)(44832011)(4326008)(6436002)(66066001)(256004)(486006)(86362001)(26005)(71190400001)(36756003)(52116002)(2351001)(6506007)(99286004)(6486002)(102836004)(2501003)(76176011)(386003)(186003)(6116002)(14454004)(66946007)(66476007)(66556008)(64756008)(66446008)(25786009)(478600001)(1076003)(3846002)(8676002)(81166006)(81156014)(7736002)(5640700003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4351;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: O6fniMMiVL7OOTWcx4Fpdn0GZf/4hC/7AiTbyJwvDTeRaPWaOCgbb6d3XBgVaVounvbFj2azzgmxdCxv6b8Hd7QGemG/8lTedZGqSH+ZOcEFTTIyEYBJ9rpapOvRYEdy4TacFDWw68BrYywusoOpWFLwNZowH/t4iC+3wkcCgOms7FKokjYwZYPMTOk8Qt6mGpZKqNr9maK3gqVY36DL2GZaK7awGdczv+yg6+e0Bt07rMd/UltxKmv/HS/Zj6O8o0PpUYKLvZFsth0Wf6EKrie/KgdL64c/FNMXBolBMQnN0m9HukqSn38A2xO8Vl57jZ3AZkTv7ImDRw/i1vfKnnrzYQs87NJII1TRRZYF8LYlxOvgPrzNXLSmJuK/Y1UnJjSpt7nLYhHc6DEzlSJZ9ZRdHj8hgaoXUnmBymDnYG1OFf91umvIafj3nUhsiNao
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4351
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(1110001)(339900001)(189003)(199004)(99286004)(26005)(1076003)(476003)(11346002)(2616005)(70206006)(336012)(76130400001)(50226002)(446003)(70586007)(386003)(102836004)(186003)(50466002)(6506007)(54906003)(22756006)(76176011)(81156014)(66066001)(8746002)(81166006)(5660300002)(36756003)(8936002)(8676002)(126002)(486006)(316002)(23756003)(2906002)(6862004)(47776003)(86362001)(5640700003)(6512007)(356004)(4326008)(305945005)(25786009)(6486002)(3846002)(6116002)(2501003)(14454004)(2351001)(478600001)(7736002)(26826003)(105606002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5072;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 92ec3c68-c2d0-4213-9fd9-08d763779159
NoDisclaimer: True
X-Forefront-PRVS: 0214EB3F68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSz5dTWCI3mbMnFESpvvjH8GIpXUc/jrjjhg8Nz+6d9i78/zV9XxMRH7zSRkTRlN+hzJFQNEtRL559dIcL+SkXhwRtQTC/psZjz3J3GnHdows0irOj3O9sf5KPKlofjjzjQV2jwsU0E36dN4KHChvd3QT2dLKflpd/RlXgyrB3i8P8aicpt0ZdZrYXQVG8tRRW22b5+rG121Nag1i3bcaZIEqDnNBk+b1pWTlbetkKYeEaOll3XqQSt9xOE3X8UXiHiSPLt5M+2p1TDI85Sp8c0RtWpLOtqCjg5gzmOlacF343Jm8gxf38Tq7B57/p3yHxUepip8yhRu6n8kiVPaV4EVchcvZUDwMx36G3QqpyfsZ3GpbbDSlHPhuoAqMCpspowFOyhZxIC1RpjFk+pa5CXhjTqX85OsbSG26VF6btUGEEkhsSAi/VO6YxcGdJFH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 11:42:39.0550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8362b5c-e220-4b16-bcea-08d76377978d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Named 'err_verbosity', currently with only 1 active bit in that
replicates the existing level - print error events once per flip.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c   |  4 ++++
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 14 ++++++++++++--
 drivers/gpu/drm/arm/display/komeda/komeda_event.c |  9 +++++++--
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c   |  2 +-
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 14d5c5da9e3b..4e46f650fddf 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -58,6 +58,8 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
 	mdev->debugfs_root =3D debugfs_create_dir("komeda", NULL);
 	debugfs_create_file("register", 0444, mdev->debugfs_root,
 			    mdev, &komeda_register_fops);
+	debugfs_create_x16("err_verbosity", 0664, mdev->debugfs_root,
+			   &mdev->err_verbosity);
 }
 #endif
=20
@@ -273,6 +275,8 @@ struct komeda_dev *komeda_dev_create(struct device *dev=
)
 		goto err_cleanup;
 	}
=20
+	mdev->err_verbosity =3D KOMEDA_DEV_PRINT_ERR_EVENTS;
+
 #ifdef CONFIG_DEBUG_FS
 	komeda_debugfs_init(mdev);
 #endif
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 414200233b64..b5bd3d5898ee 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -202,6 +202,14 @@ struct komeda_dev {
=20
 	/** @debugfs_root: root directory of komeda debugfs */
 	struct dentry *debugfs_root;
+	/**
+	 * @err_verbosity: bitmask for how much extra info to print on error
+	 *
+	 * See KOMEDA_DEV_* macros for details.
+	 */
+	u16 err_verbosity;
+	/* Print a single line per error per frame with error events. */
+#define KOMEDA_DEV_PRINT_ERR_EVENTS BIT(0)
 };
=20
 static inline bool
@@ -219,9 +227,11 @@ void komeda_dev_destroy(struct komeda_dev *mdev);
 struct komeda_dev *dev_to_mdev(struct device *dev);
=20
 #ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
-void komeda_print_events(struct komeda_events *evts);
+void komeda_print_events(struct komeda_events *evts, struct drm_device *de=
v);
 #else
-static inline void komeda_print_events(struct komeda_events *evts) {}
+static inline void komeda_print_events(struct komeda_events *evts,
+				       struct drm_device *dev)
+{}
 #endif
=20
 int komeda_dev_resume(struct komeda_dev *mdev);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_event.c
index a36fb86cc054..575ed4df74ed 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
@@ -107,10 +107,12 @@ static bool is_new_frame(struct komeda_events *a)
 	       (KOMEDA_EVENT_FLIP | KOMEDA_EVENT_EOW);
 }
=20
-void komeda_print_events(struct komeda_events *evts)
+void komeda_print_events(struct komeda_events *evts, struct drm_device *de=
v)
 {
-	u64 print_evts =3D KOMEDA_ERR_EVENTS;
+	u64 print_evts =3D 0;
 	static bool en_print =3D true;
+	struct komeda_dev *mdev =3D dev->dev_private;
+	u16 const err_verbosity =3D mdev->err_verbosity;
=20
 	/* reduce the same msg print, only print the first evt for one frame */
 	if (evts->global || is_new_frame(evts))
@@ -118,6 +120,9 @@ void komeda_print_events(struct komeda_events *evts)
 	if (!en_print)
 		return;
=20
+	if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
+		print_evts |=3D KOMEDA_ERR_EVENTS;
+
 	if ((evts->global | evts->pipes[0] | evts->pipes[1]) & print_evts) {
 		char msg[256];
 		struct komeda_str str;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index d49772de93e0..e30a5b43caa9 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -48,7 +48,7 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *=
data)
 	memset(&evts, 0, sizeof(evts));
 	status =3D mdev->funcs->irq_handler(mdev, &evts);
=20
-	komeda_print_events(&evts);
+	komeda_print_events(&evts, drm);
=20
 	/* Notify the crtc to handle the events */
 	for (i =3D 0; i < kms->n_crtcs; i++)
--=20
2.23.0

