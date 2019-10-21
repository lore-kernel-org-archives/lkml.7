Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3426BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017E520873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="57mjF/6g";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="57mjF/6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfJUQrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:47:39 -0400
Received: from mail-eopbgr50049.outbound.protection.outlook.com ([40.107.5.49]:1760
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729405AbfJUQrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lFNENYY2WBTzISF1cViWb9ogN+++Rr/m8RIJQFVph0=;
 b=57mjF/6g6NIB1lvp12k7RLxMNkoR8cgA5B2+EmglsgNj8IBQo8DeQa1su1M29swLU+s4pbsakLtbrvwOpNh2yFUQBPMGsLxVrljcsalrrfbeUXjp1Sa3hqQXqe+HRThK/8uI8oUPEksaPuBHPj0HCWuh1frJWVdGtN6ZiUk8OpI=
Received: from VI1PR08CA0161.eurprd08.prod.outlook.com (2603:10a6:800:d1::15)
 by VI1PR08MB3677.eurprd08.prod.outlook.com (2603:10a6:803:85::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Mon, 21 Oct
 2019 16:47:31 +0000
Received: from VE1EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR08CA0161.outlook.office365.com
 (2603:10a6:800:d1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 16:47:31 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT028.mail.protection.outlook.com (10.152.18.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Mon, 21 Oct 2019 16:47:30 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Mon, 21 Oct 2019 16:47:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b2b627294ba105bc
X-CR-MTA-TID: 64aa7808
Received: from e73906f62ecb.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3E7EF3FF-36EC-4CAC-AE51-7A41C97904CD.1;
        Mon, 21 Oct 2019 16:47:17 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e73906f62ecb.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Oct 2019 16:47:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ispBJWdzjzVJqhSOPVru+/3jwKYXJA9SoxiN32xXG7meIBSobfLGiZwi4WDFb3FankZFWq/2kgc0zh4UWBCDl81FBfQuHPjV4bgMO6huQoBbS38ez+CB9UyX+SmmWpak+HIWTwJ/UtQjErmPZvho5qWUYw26T8X1ZyaMQfbsO28veuiKpWDfTDI2Syb1Nta5pGFHGMG/7ZhwzBk1JVmXNQS8MAYbZ00uKdIKHEnXWd+dXj9lbj5WkyQlM90dVNdbRpnZhaIPDmqUtdXl2ozQCf8JMavSG2GnOaMhEh9iE7Yql9gzb7rNxmQPSSiBgOHBvfI6l1pnJWevopMXFdQGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lFNENYY2WBTzISF1cViWb9ogN+++Rr/m8RIJQFVph0=;
 b=mImirJsU7w+enaAWb6S0mbSG/i2jp19WyCLtZGLTmv1eUAAaXGvN/KkArDwngRHjYXFYFu5M307i2Oi5pblprFRKAlfX2qa3QRF4sFoSV/+u5iZPJaXFHSTh7VO9j5RCGLT5sYv6My5U66OYXQi7Ta6aryNq2/pzJrDKS0yWFi4ylKufrx1/jLo2Cm6aW/wl04lh2QlgWVrbmSqdJCHJMS8hj3jNjUqPh7nxaXsHB8pUxkwFm3MQR4Sj/qET2Cbc19zipGzAEuuwDFyQuLyOOkpgZU/6XI+G/rtI8iaLXfzyo4Xr5kXsZpNehjRW8ueapDQLqKCgUzThZOm0KtdOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lFNENYY2WBTzISF1cViWb9ogN+++Rr/m8RIJQFVph0=;
 b=57mjF/6g6NIB1lvp12k7RLxMNkoR8cgA5B2+EmglsgNj8IBQo8DeQa1su1M29swLU+s4pbsakLtbrvwOpNh2yFUQBPMGsLxVrljcsalrrfbeUXjp1Sa3hqQXqe+HRThK/8uI8oUPEksaPuBHPj0HCWuh1frJWVdGtN6ZiUk8OpI=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3231.eurprd08.prod.outlook.com (52.134.123.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.21; Mon, 21 Oct 2019 16:47:14 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2367.022; Mon, 21 Oct 2019
 16:47:14 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] drm/komeda: Add debugfs node to control error verbosity
Thread-Topic: [PATCH 1/5] drm/komeda: Add debugfs node to control error
 verbosity
Thread-Index: AQHViC8xuPMk/kmsbUCVoX21Aq4jyg==
Date:   Mon, 21 Oct 2019 16:47:14 +0000
Message-ID: <20191021164654.9642-2-mihail.atanassov@arm.com>
References: <20191021164654.9642-1-mihail.atanassov@arm.com>
In-Reply-To: <20191021164654.9642-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::15) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b5f6b1e0-5bc3-49b2-124a-08d756465d12
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3231:|VI1PR08MB3231:|VI1PR08MB3677:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3677610B61331B1C8F95B9C58F690@VI1PR08MB3677.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1850;OLM:1850;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(189003)(199004)(66476007)(8936002)(2616005)(81166006)(81156014)(386003)(50226002)(44832011)(76176011)(6506007)(2501003)(102836004)(1076003)(25786009)(71200400001)(6486002)(3846002)(6116002)(476003)(11346002)(316002)(71190400001)(256004)(446003)(99286004)(486006)(54906003)(14454004)(26005)(5640700003)(86362001)(305945005)(7736002)(8676002)(6436002)(6916009)(5660300002)(4326008)(6512007)(66446008)(64756008)(66946007)(66556008)(478600001)(36756003)(52116002)(66066001)(2906002)(2351001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3231;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 2VO7Tqx8aoVFFuhlMZWvq3Ph9VmYVldu8iY4dT0oxoV/uGfZkejSq9tmU8ER9/GMJLDzycAzgZ6PpCk3SsFpRwJStC+XsqlohhX7YpP/fhPZobAfQaWTqU63qzwkR1tN4S6lxWFT1Qu1KrMKc+6cuULSe390LxXKveDNzih230o+FNaHu3sc+2UxYZDgivXELbZkIAkP9hiy6uVCmJx87ZS+ZA4/0uYS3smndEzRlHCNPJ91WOgUAPz1nhi6euLd8Zv6YN3i5aTtcZ75OZXqYFrQsYLIFYxH0oBfEkujsZZHfhfvI7OLZP2I5B9YYY+c3xHPe92vfWZDEr8BcevVqUMbxyxw27nel7y+7YPY2sw7mfOEGorJiCX41H9ZXJFn1Ouo5vlozzRHDWBvOQOXAI6NCVFUgP2KSbFziUyG8SvAbl8HuV3AhFxwe/S+CpS2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3231
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(7736002)(305945005)(47776003)(26826003)(22756006)(6862004)(4326008)(23756003)(86362001)(50466002)(6486002)(2906002)(478600001)(2351001)(14454004)(1076003)(316002)(2501003)(70586007)(70206006)(50226002)(54906003)(76130400001)(486006)(336012)(3846002)(63350400001)(446003)(126002)(8746002)(36906005)(11346002)(99286004)(356004)(102836004)(2616005)(66066001)(186003)(81156014)(81166006)(5640700003)(6512007)(25786009)(6116002)(6506007)(8936002)(76176011)(8676002)(5660300002)(386003)(476003)(26005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3677;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f0cabc26-5c2c-4b5e-39ce-08d756465375
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jF3NqNwo0Y0EpQwrZ7GrGXEUmNLabyIl7N8o8734necETB15nueAU4Oy4dqBERag5i/hrXGL0+2yhO1QBqqGuVz3+eYVNOQ2HIlFjEJ/a8QfRVixj50w6TEDBJ/gOUE0+orslYXGCKieqAGREXYYSz9I630SSeEfuWs7j9OJChtNZuaEG5IW8eeykXPi002Q9n77XS2aBxKLXeYQhL5Ch1kJeoy7f/Ps0q3zNKHfy0/JviNUPn9RnXz92yRIza3X/aTQavmoycYNBEfEDg1WwT/v9aGRs9vBhNIjZifczL0lMjsKYSV9HtjwGFy+MUNe9hthnJVQh3FoYWiswEGop6AObFqXEB/pp62fN+Fhr65ltAOIxGxaU0JB4yWgImtazZcHQS8NaTcDCBgrj07+VcERr6pwe9/oVKIj9RHRf6E=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 16:47:30.2927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f6b1e0-5bc3-49b2-124a-08d756465d12
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3677
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Named 'err_verbosity', currently with only 1 active bit in that
replicates the existing level - print error events once per flip.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c   |  4 ++++
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 14 ++++++++++++--
 drivers/gpu/drm/arm/display/komeda/komeda_event.c |  9 +++++++--
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c   |  2 +-
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 937a6d4c4865..82230c0ddec3 100644
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
@@ -280,6 +282,8 @@ struct komeda_dev *komeda_dev_create(struct device *dev=
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

