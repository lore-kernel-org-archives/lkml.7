Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85531CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DCD20882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lCZpulkX";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lCZpulkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfJUQte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:49:34 -0400
Received: from mail-eopbgr150050.outbound.protection.outlook.com ([40.107.15.50]:21126
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729891AbfJUQtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWsSnQvJtQ+r5qSKgtU+rOw+cTaU+Npr3oF1zqZ62NU=;
 b=lCZpulkXKD+5MMk203KPXYuhPv0BhlFnibjNr+SqNT59Xl0kq1R/i70cvVPHvtlBJTfIWlG20SCp9pGrdafoUzKLOUHAFnUlLfPvlgOAd7nmSUVPmJpAMVHcC6DYFP6mWhtjd3YXYtYfphvCO2Lc92AtKmXJXsRRMLjAdJt1Hug=
Received: from DB6PR0802CA0037.eurprd08.prod.outlook.com (2603:10a6:4:a3::23)
 by DBBPR08MB4492.eurprd08.prod.outlook.com (2603:10a6:10:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Mon, 21 Oct
 2019 16:47:46 +0000
Received: from VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by DB6PR0802CA0037.outlook.office365.com
 (2603:10a6:4:a3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 16:47:46 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT005.mail.protection.outlook.com (10.152.18.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Mon, 21 Oct 2019 16:47:44 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Mon, 21 Oct 2019 16:47:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 668dfe31dcc6a0fb
X-CR-MTA-TID: 64aa7808
Received: from 8df1632baa3c.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9DF02324-B19A-406F-9504-5165503D2FBD.1;
        Mon, 21 Oct 2019 16:47:33 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2051.outbound.protection.outlook.com [104.47.9.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8df1632baa3c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Oct 2019 16:47:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAwBiQGAxZ5uhq8tEv//sBZ5qstEfYRTrBEsPs5Rsqo4bX50xKKXhS6f06m00GjVrlL1sL21blbEJIfzt7Eem0CKclrII7TrFgj7UtiCXj7SC/q1bgASdDDCdv9NUS8a3bo1gQcHqHqHpVTYkcjkVbrv+GRqC+AodJACzemkiZGxcpefFM6IKO8LwAxi13UgJ5pE91A+a4XBonvhUVx6zmZlO9uU+RlSKjVz5yNd7HkUEJBuA+lmNXiGRq0fOqYlGEPL8x8TY2Ld3t7FSbyLMSmm7TXlEPJ5gKD0ep1J1XqmpS0axwVUG+Ov6SlAJSee677W3tByeK8z4RlGzsZSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWsSnQvJtQ+r5qSKgtU+rOw+cTaU+Npr3oF1zqZ62NU=;
 b=NBxvyPYsWVZhXLBeK1QWSZCWfi8qfUIC5t6BVMHO0slTVsZ2x0OoTh4nnLct0IJi9gJZsIDsyFJOs5+P4m59Eb4mgtIMQpBa/O3odWCdf6zNCcjvh/mTry1RP+zU9QyTStLiBvCyXCCDVRUGD1wmIUgxL7t+HQXp7TFXEfn4GB7MQa/zbYOt42NQCUF/EIS94GmkoqH0CSGcPashx7nmK/HVXAzCehZyFXB2ZktWDeMkZpxN7Ylj5krlhmcUJOWBjHh7wCSzRIIrh4UjSnvnIuqEA6MQ19ZKq/etYpV/90q4wV047wLj4FW2K3viknZ8sJ+rpYqUV7rqWXyiAWcO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWsSnQvJtQ+r5qSKgtU+rOw+cTaU+Npr3oF1zqZ62NU=;
 b=lCZpulkXKD+5MMk203KPXYuhPv0BhlFnibjNr+SqNT59Xl0kq1R/i70cvVPHvtlBJTfIWlG20SCp9pGrdafoUzKLOUHAFnUlLfPvlgOAd7nmSUVPmJpAMVHcC6DYFP6mWhtjd3YXYtYfphvCO2Lc92AtKmXJXsRRMLjAdJt1Hug=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3693.eurprd08.prod.outlook.com (20.178.13.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Mon, 21 Oct 2019 16:47:29 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2367.022; Mon, 21 Oct 2019
 16:47:29 +0000
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
Subject: [PATCH 4/5] drm/komeda: Add option to print WARN- and INFO-level IRQ
 events
Thread-Topic: [PATCH 4/5] drm/komeda: Add option to print WARN- and INFO-level
 IRQ events
Thread-Index: AQHViC86lQh6BhWPhkSdWiuXUeWqOw==
Date:   Mon, 21 Oct 2019 16:47:29 +0000
Message-ID: <20191021164654.9642-5-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: aab1b27c-dd4a-4555-858b-08d75646657d
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3693:|VI1PR08MB3693:|DBBPR08MB4492:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB4492A6B422FF0774D107563B8F690@DBBPR08MB4492.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1388;OLM:1388;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(11346002)(6436002)(316002)(54906003)(256004)(8936002)(6512007)(14444005)(2501003)(71200400001)(5640700003)(71190400001)(50226002)(486006)(2906002)(446003)(6486002)(2616005)(44832011)(5660300002)(8676002)(476003)(305945005)(66066001)(36756003)(86362001)(25786009)(14454004)(186003)(478600001)(6506007)(386003)(102836004)(26005)(4326008)(2351001)(81156014)(1076003)(6116002)(3846002)(66946007)(81166006)(66556008)(52116002)(66476007)(7736002)(64756008)(66446008)(99286004)(76176011)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3693;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /LkEXHfkUUbTUyBF3hDHpD6g+u1DEcGGRcjkX8nxTcUdGVb6GzRz1Uz+KWcauw5IpcQcyPTq8b/h20tGOIabjeTx/h5UBEBJ8cGkm+cXYf2E7ZP3Akv92wLaZ6VXeKyR5nkKxRs69AzM8jy0K0xAl+gTNJzvLEkgNW7h89zu4eYWn2AF7AFNVE5bXfhdoASWmhCr7o+Eg66mPipCmO3nn+b0Kl35g/CLAJUGUUAv892Q9I07bbEjYICJlxetfAkp/qKU4LaHFzzNxrHhNyssyN/vEH4Ux2LjobI2C6pjp8rBgue0vwzX0enzs40MFjXESMVtQlfTfHa0xWR9wZYFgZkBC5wLRpewJAhWoHVn7Bp4eGhUJQpbNck4JFXmwXiWpdVHrd3Cj/k797ckNptbZCUFTm4+Ie23TquO0oHqkZ1NIaEwlXSWNqd/hPteZ2g2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3693
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(14454004)(316002)(305945005)(6116002)(2501003)(3846002)(2351001)(36906005)(2906002)(7736002)(54906003)(50466002)(14444005)(486006)(5660300002)(63350400001)(446003)(2616005)(11346002)(126002)(76130400001)(476003)(70206006)(70586007)(6512007)(356004)(336012)(23756003)(6486002)(99286004)(5640700003)(6506007)(6862004)(25786009)(76176011)(47776003)(186003)(4326008)(66066001)(386003)(102836004)(26005)(1076003)(22756006)(86362001)(478600001)(26826003)(8746002)(8676002)(8936002)(81156014)(81166006)(50226002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4492;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f3670ba4-12a0-40d4-70a7-08d756465c6d
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyuAywHau+dQB4LZ0njkyN1exSsm1VfrQ11ETCl26YToCjlzhxHxqJXHS6GV24cWZmcG5eyS9mdYxq5J5kxtbJr8t+XPtsm4x4FoPhmizYJsSyDWZfZRloNCfA8dujWWDdMqdATcB6Io1Z1S3Gbp3biZtQTozR0JCUl7/BYSwhWVRfdT8TxO/Ct7BuG9tBu40q3u1gKlID+nCojB1z95NwopmQIpsKfj9OGzhRNxWOzmnQb6UlViSMnmyTO0ym6whQpl9XOKiP1PqPU0eZt4EE4LO2L8jxPqQzzlvZOHFnev87EITz2EiC9inBZpnPEfjbl71siLtU5ZnYCJYvhWXww4hoMLgm3zdjBE43Q5W+L00Duggm3bHagZ83pCwSkW2NBGlUbNV0EMVI7yUser7YV+Egcs8/P5/DPKxkWpPzBDSQWh6VsApLUECNNnxO+R
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 16:47:44.5568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab1b27c-dd4a-4555-858b-08d75646657d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4492
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extra detail (normally off) almost never hurts.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 11 +++++++++++
 drivers/gpu/drm/arm/display/komeda/komeda_event.c |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 4809000c1efb..d9fc9c48859a 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -51,6 +51,13 @@
=20
 #define KOMEDA_WARN_EVENTS	KOMEDA_ERR_CSCE
=20
+#define KOMEDA_INFO_EVENTS ({0 \
+			    | KOMEDA_EVENT_VSYNC \
+			    | KOMEDA_EVENT_FLIP \
+			    | KOMEDA_EVENT_EOW \
+			    | KOMEDA_EVENT_MODE \
+			    })
+
 /* malidp device id */
 enum {
 	MALI_D71 =3D 0,
@@ -211,6 +218,10 @@ struct komeda_dev {
 	u16 err_verbosity;
 	/* Print a single line per error per frame with error events. */
 #define KOMEDA_DEV_PRINT_ERR_EVENTS BIT(0)
+	/* Print a single line per warning per frame with error events. */
+#define KOMEDA_DEV_PRINT_WARN_EVENTS BIT(1)
+	/* Print a single line per info event per frame with error events. */
+#define KOMEDA_DEV_PRINT_INFO_EVENTS BIT(2)
 	/* Dump DRM state on an error or warning event. */
 #define KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT BIT(8)
 };
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_event.c
index 5da61e7d75d5..bf88463bb4d9 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
@@ -124,6 +124,10 @@ void komeda_print_events(struct komeda_events *evts, s=
truct drm_device *dev)
=20
 	if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
 		print_evts |=3D KOMEDA_ERR_EVENTS;
+	if (err_verbosity & KOMEDA_DEV_PRINT_WARN_EVENTS)
+		print_evts |=3D KOMEDA_WARN_EVENTS;
+	if (err_verbosity & KOMEDA_DEV_PRINT_INFO_EVENTS)
+		print_evts |=3D KOMEDA_INFO_EVENTS;
=20
 	if (evts_mask & print_evts) {
 		char msg[256];
--=20
2.23.0

