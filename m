Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED93CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7DD20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="QqpqHXPc";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="QqpqHXPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfJUQro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:47:44 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:48174
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729405AbfJUQrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2yjDsqDr+TeKkIanekjVyEis3xaMX3qJidSclXgt24=;
 b=QqpqHXPcUBjttmeWlYY57e05gCm61hv5Lljdi6SfJw6DQJnqtdexMLY7YSyTYnpNq7fvfWKTKffp9idrN843Pmb+Bi/G7bnEh7TcOIT4XhNgnnAV6MGCul7upB2JUm3fyaW2qZZ3gf3hWpSoMODzyCUe6H6D6d9SzhvXygoMO7s=
Received: from VE1PR08CA0003.eurprd08.prod.outlook.com (2603:10a6:803:104::16)
 by VI1PR0801MB1678.eurprd08.prod.outlook.com (2603:10a6:800:51::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Mon, 21 Oct
 2019 16:47:36 +0000
Received: from VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by VE1PR08CA0003.outlook.office365.com
 (2603:10a6:803:104::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 16:47:36 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT030.mail.protection.outlook.com (10.152.18.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Mon, 21 Oct 2019 16:47:35 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Mon, 21 Oct 2019 16:47:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 89bd12e1453a1bd7
X-CR-MTA-TID: 64aa7808
Received: from 26dbf25f3ac7.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9AA667B3-BC90-4D48-A6C9-F3A33A3B69B5.1;
        Mon, 21 Oct 2019 16:47:27 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 26dbf25f3ac7.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Oct 2019 16:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpLw7VCKGQF0I9Wxbi3OUepmlFpgjF4OUW++aSWsnYNeWr726at2Fk5fvYRikwgVgbye95LxX6JWjZFIcbRF2LUZ/PXLPdgUmKGKcJEweyY1O8VV3k0XQjEXykL51egjLwykskbXJ+9s0sRo1+g2muX6pajGB6RnxCdw2mwXDRhWaedxjKO2Sjz+gUWzQWNEDlqbVW0p+swpiWqIdXaBe4t05cUXtc2qM/+9+MusX1G5dzafmRzH8YWoxxlAB6zJZw7T3tt4tlPYpgbGHamgXPsnSEntiAN5wQXmd1NhfcsoD/bS48xxdodL5d0lDiWLCNjyR1wRDdY+LyefnehGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2yjDsqDr+TeKkIanekjVyEis3xaMX3qJidSclXgt24=;
 b=b0dLeeo3FYwc4fpZyiBOrhwv02z2EuvlGoRXyQ77cLwLwc8DNktN3J/GiefLEFIFPUxzx9xnelQHFlt0ZbL85GfYOjBQWhXFz2tGgdy91JSZlrCE2Ua6IAYcG0cLH3idWBcsHr48+qaiIhBX+xUjKzQzSmCIfKifwi7YFS9gGFq0jEmfjc6+r/qsgXUTdy3eAcT+ZrfIEdwQ3gUtvjbo1fb1balEPW+rSWctsc5bBH+OkGMSGrdtS2blZB3t+Gy5MweYJ0iwbYkXjrX0F6y/26ts9N6yC2L1SalIDGj6u3nR52yxCCdJ5RY93bATySz1DBV+4Lm004XBr4kC6fne1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2yjDsqDr+TeKkIanekjVyEis3xaMX3qJidSclXgt24=;
 b=QqpqHXPcUBjttmeWlYY57e05gCm61hv5Lljdi6SfJw6DQJnqtdexMLY7YSyTYnpNq7fvfWKTKffp9idrN843Pmb+Bi/G7bnEh7TcOIT4XhNgnnAV6MGCul7upB2JUm3fyaW2qZZ3gf3hWpSoMODzyCUe6H6D6d9SzhvXygoMO7s=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3693.eurprd08.prod.outlook.com (20.178.13.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Mon, 21 Oct 2019 16:47:24 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2367.022; Mon, 21 Oct 2019
 16:47:24 +0000
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
Subject: [PATCH 3/5] drm/komeda: Optionally dump DRM state on interrupts
Thread-Topic: [PATCH 3/5] drm/komeda: Optionally dump DRM state on interrupts
Thread-Index: AQHViC82sr9B7tdJG0SX6V/x8vl4Ug==
Date:   Mon, 21 Oct 2019 16:47:24 +0000
Message-ID: <20191021164654.9642-4-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 377d79fb-a841-4713-7d30-08d756465ff1
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3693:|VI1PR08MB3693:|VI1PR0801MB1678:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1678AAA55F073105E29427758F690@VI1PR0801MB1678.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(11346002)(6436002)(316002)(54906003)(256004)(8936002)(6512007)(14444005)(2501003)(71200400001)(5640700003)(71190400001)(50226002)(486006)(2906002)(446003)(6486002)(2616005)(44832011)(5660300002)(8676002)(476003)(305945005)(66066001)(36756003)(86362001)(25786009)(14454004)(186003)(478600001)(6506007)(386003)(102836004)(26005)(4326008)(2351001)(81156014)(1076003)(6116002)(3846002)(66946007)(81166006)(66556008)(52116002)(66476007)(7736002)(64756008)(66446008)(99286004)(76176011)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3693;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fI5DFA0OaEvwUGRfBjUPpzYFwp6+qufH86B3IzpDme/hNcrwas42rl1RYOzrMJPeIZ2q6f8U3D1D8ndhzgGxG8dLQWv3tNPFRM5aPCF+97FZ53Pv/ZJovdyEHv4T7jieGQKUwp92S/AHF3ySlxHg5iduTFhpjRKhz6jexhe+dLSGsg98p9R17dPnrbEtXOB1NoRZih9H4MuVBmrnDAtsfP7YCrFT5eYb+okQRDGJVuJs3OV24WiliUsQ+aTppItNJCUD82IxN0mNCPTvybzSxrfXvvgn25NFZgC+XZBRUt67ouRZJeEPqsHCIz72POzorwIxPRwmsQCAUB+ySdaq07ySxkmttrXa5lNe8vTf2eaQbhZt+TCsCrk8apbgHqlEGlb+1AyYPkbJbkz5NQ3Spiq3Xc+GTcv0exOBHgXc3U+mHPgsDNMsHWJA+r6bm4zw
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3693
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(199004)(189003)(14444005)(47776003)(54906003)(316002)(186003)(6862004)(50466002)(36906005)(5660300002)(476003)(126002)(11346002)(446003)(6512007)(486006)(63350400001)(23756003)(336012)(36756003)(99286004)(76176011)(4326008)(22756006)(66066001)(2616005)(102836004)(26005)(386003)(6506007)(305945005)(70586007)(76130400001)(2906002)(356004)(6116002)(3846002)(2501003)(2351001)(478600001)(6486002)(86362001)(1076003)(70206006)(26826003)(50226002)(81156014)(8746002)(81166006)(8936002)(8676002)(5640700003)(25786009)(14454004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1678;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b784c45c-298f-4e8e-90b0-08d75646595f
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtvYqW+AWJlqjrOwGocADLpbzsV4XSNbRyG6H0l0KuRGRprXQrYXyaRrS0LQB3B4jZYFEJf3SxNVty/L9YDytt4QTgTsOYBo2eeWVqy0sT0tKwvov3Sb1EP023moO+nBCAH9QXqeAocARowO61BVZDN98CuTGm2uAYOZtBFbMAOLxJsFnfVANNOUwoesP+D41P6RiZmbvwlntg957ASn1rkERg1/EfSiCAr2c+pC4IPTwuXiNhHJY4TQruYXXhXAPI/1mSJzhbl/i5ECGLzDDHGNXU+uXASx4AaP43kmLI3cjS3s6BQNGrX4NGdGxPkcPg92s/xsXutU1QV5f9YZbY4o3j1gtKywS4y3WQLClhEnLWSvmff94rs6mGp2WcF2bpOxZBXohhA+4wYhWyY+ocbMXs16rODkaCkAGTlyT+ehbTVh1TNNB+/uKKV9/RLt
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 16:47:35.2514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 377d79fb-a841-4713-7d30-08d756465ff1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's potentially useful information when diagnosing error/warn IRQs, so
dump it to dmesg with a drm_info_printer. Hide this extra debug dumping
behind another komeda_dev->err_verbosity bit.

Note that there's not much sense in dumping it for INFO events,
since the VSYNC event will swamp the log.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 5 ++++-
 drivers/gpu/drm/arm/display/komeda/komeda_event.c | 8 +++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 831c375180f8..4809000c1efb 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -205,11 +205,14 @@ struct komeda_dev {
 	/**
 	 * @err_verbosity: bitmask for how much extra info to print on error
 	 *
-	 * See KOMEDA_DEV_* macros for details.
+	 * See KOMEDA_DEV_* macros for details. Low byte contains the debug
+	 * level categories, the high byte contains extra debug options.
 	 */
 	u16 err_verbosity;
 	/* Print a single line per error per frame with error events. */
 #define KOMEDA_DEV_PRINT_ERR_EVENTS BIT(0)
+	/* Dump DRM state on an error or warning event. */
+#define KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT BIT(8)
 };
=20
 static inline bool
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_event.c
index 575ed4df74ed..5da61e7d75d5 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
@@ -4,6 +4,7 @@
  * Author: James.Qian.Wang <james.qian.wang@arm.com>
  *
  */
+#include <drm/drm_atomic.h>
 #include <drm/drm_print.h>
=20
 #include "komeda_dev.h"
@@ -113,6 +114,7 @@ void komeda_print_events(struct komeda_events *evts, st=
ruct drm_device *dev)
 	static bool en_print =3D true;
 	struct komeda_dev *mdev =3D dev->dev_private;
 	u16 const err_verbosity =3D mdev->err_verbosity;
+	u64 evts_mask =3D evts->global | evts->pipes[0] | evts->pipes[1];
=20
 	/* reduce the same msg print, only print the first evt for one frame */
 	if (evts->global || is_new_frame(evts))
@@ -123,9 +125,10 @@ void komeda_print_events(struct komeda_events *evts, s=
truct drm_device *dev)
 	if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
 		print_evts |=3D KOMEDA_ERR_EVENTS;
=20
-	if ((evts->global | evts->pipes[0] | evts->pipes[1]) & print_evts) {
+	if (evts_mask & print_evts) {
 		char msg[256];
 		struct komeda_str str;
+		struct drm_printer p =3D drm_info_printer(dev->dev);
=20
 		str.str =3D msg;
 		str.sz  =3D sizeof(msg);
@@ -139,6 +142,9 @@ void komeda_print_events(struct komeda_events *evts, st=
ruct drm_device *dev)
 		evt_str(&str, evts->pipes[1]);
=20
 		DRM_ERROR("err detect: %s\n", msg);
+		if ((err_verbosity & KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT)
+		    && (evts_mask & (KOMEDA_ERR_EVENTS | KOMEDA_WARN_EVENTS)))
+			drm_state_dump(dev, &p);
=20
 		en_print =3D false;
 	}
--=20
2.23.0

