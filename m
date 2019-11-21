Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5543C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DD52089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KtJUwB97";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KtJUwB97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKUHNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:13:04 -0500
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:51335
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfKUHND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIB/8z50vBuASSq6iSuVafx4DPXkwq7T4HlbSTTsATE=;
 b=KtJUwB971rsWqetTIZzgt9sSjapcCf6AUMSD9s0a5ThUkvUESvbPFB0m0l/6FswTXHADxlNgdzDxK1BDJf5sQdltxtxErSDEAJKNiQRDP1GM0M+pogheIvnzwqwDjpPxnmu1hBt+rG3JNgcZPiTzY3AvGnSoqzVSvEXM0Gtf7c8=
Received: from AM4PR08CA0052.eurprd08.prod.outlook.com (2603:10a6:205:2::23)
 by VI1PR0801MB2126.eurprd08.prod.outlook.com (2603:10a6:800:51::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Thu, 21 Nov
 2019 07:12:58 +0000
Received: from AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by AM4PR08CA0052.outlook.office365.com
 (2603:10a6:205:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Thu, 21 Nov 2019 07:12:58 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT020.mail.protection.outlook.com (10.152.16.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Thu, 21 Nov 2019 07:12:58 +0000
Received: ("Tessian outbound f7868d7ede10:v33"); Thu, 21 Nov 2019 07:12:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 42ac78c10f20c637
X-CR-MTA-TID: 64aa7808
Received: from fcc1ffd6d176.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 01C109A0-B95E-456C-88C5-079E43941A38.1;
        Thu, 21 Nov 2019 07:12:52 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fcc1ffd6d176.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 21 Nov 2019 07:12:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4W7vO2CUU3IwMkxZ/ngLIkrKvIF9EWoWLUV1YhC/uD/zBy+ugru9XDQEVdeHdjW6zWtSJqVGq9eRqusUIUdhJl6TQuvbxWp+ltuVXf5helfMXZxybWbJQ3Ve68qOJvbvtnnlYfszzDywSTWdTPoP2oNWIEj3VLaIaC7KC95ysIRJihcBUuLVU8wUVHeky/W60YZN1f/mbSDKGYahQUQSkEpY/x0LyB1S6gjE6tm1ewL4kTrzCFsdgBlgQCfd3n1Nd70bFHeso63Ti0eh5gSH5+w36Lbjr778a/D+tx4mj9p3uOVd+P93YgbxeqSj+bywCoARMQX9PxEYwfPOJOCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIB/8z50vBuASSq6iSuVafx4DPXkwq7T4HlbSTTsATE=;
 b=GtFFxpLTFmNPt5SwTwKq5knXPZa+e7tJeZcjGX02fW5AI67hq/U1vm1WlPjE0FYtLUI0D9oRcfJhB+fwQuOJzo5hCaGWHA6YBVsLUDuTz1SsdOpgUUNwK5vTomnV1VMzIXIikCzl8QTO6SlSyNfNcgtx3TMfSWjzaRO93OVJrTsKrBkMLs324215bXvuHvkqcLXS4yQd5PT1odUhrWXMvf83PXInhZjboCxo0OY0w+ppxeo/4EkugV5SK59SWcquC32XAGio6HjkqbBqFCsNdAbIG+aPpZjCWNm18SFQzlzFD3fFlCIST/3B5B0tHbgaSDRYAub9IAS6RZth5noXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIB/8z50vBuASSq6iSuVafx4DPXkwq7T4HlbSTTsATE=;
 b=KtJUwB971rsWqetTIZzgt9sSjapcCf6AUMSD9s0a5ThUkvUESvbPFB0m0l/6FswTXHADxlNgdzDxK1BDJf5sQdltxtxErSDEAJKNiQRDP1GM0M+pogheIvnzwqwDjpPxnmu1hBt+rG3JNgcZPiTzY3AvGnSoqzVSvEXM0Gtf7c8=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5069.eurprd08.prod.outlook.com (20.179.29.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 07:12:50 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 07:12:50 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v4 5/6] drm/komeda: Update writeback signal for side_by_side
Thread-Topic: [PATCH v4 5/6] drm/komeda: Update writeback signal for
 side_by_side
Thread-Index: AQHVoDsVP7DZARWDIkCVgBtVHxZ+nw==
Date:   Thu, 21 Nov 2019 07:12:50 +0000
Message-ID: <20191121071205.27511-6-james.qian.wang@arm.com>
References: <20191121071205.27511-1-james.qian.wang@arm.com>
In-Reply-To: <20191121071205.27511-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3de3291-eec6-4a71-2361-08d76e523cbc
X-MS-TrafficTypeDiagnostic: VE1PR08MB5069:|VE1PR08MB5069:|VI1PR0801MB2126:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2126E58F1B576ADAF22630B7B34E0@VI1PR0801MB2126.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 0228DDDDD7
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(366004)(376002)(346002)(136003)(189003)(199004)(386003)(6636002)(55236004)(102836004)(6506007)(76176011)(256004)(52116002)(2906002)(50226002)(7736002)(305945005)(66446008)(186003)(81166006)(81156014)(8676002)(8936002)(66946007)(6512007)(26005)(2616005)(71200400001)(6486002)(446003)(478600001)(11346002)(71190400001)(6436002)(64756008)(66476007)(66556008)(86362001)(66066001)(4326008)(36756003)(2501003)(6116002)(316002)(3846002)(14454004)(103116003)(99286004)(54906003)(110136005)(25786009)(1076003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5069;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 25JaAhMhi4pPfQfyhnS467tH9z3KJNSotjXLzoKX5EVMOVFwTEgAIcKeTsOz5cUHpwRm3jzDzo2qDyQKO21NG3iVU4VxygsXlb/WragdzNMKGOwR4KTyukIc8YhWlwUoyECs2AgoOrBbIiU1dPCISjI4FsoUIji6ou5F1pIFFavevf21MwfkY/S1Zo9usmcoE1RFH7TtQBD9ib1T1ejBTWzdTuEZ5qnpaGSuIxZm6AuP/j+6FxrRHF6NMI/AWZkMPuzM1dNnSNbtFDxBsaX65+F9dVgD9xqfTkFng+wr4VXDe6dOUX4xLpKxOZF4JZWga+d/12yc17/hMUFxUZ4ZnqmDWl3y1PW/5Fl2HSeYu3StKPSIxEViRWlDFpO8VfMoFPV84eAjtCHJmPqvymlEYhYtkXGPOpblTTk8T8ns7RFfPxMwKArr2wXJIcTAUX6Z
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5069
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(1110001)(339900001)(189003)(199004)(186003)(316002)(110136005)(8936002)(8746002)(50226002)(336012)(36906005)(26005)(99286004)(81166006)(8676002)(70586007)(6506007)(386003)(70206006)(102836004)(81156014)(446003)(2616005)(1076003)(11346002)(54906003)(14454004)(26826003)(478600001)(356004)(76130400001)(105606002)(22756006)(36756003)(25786009)(3846002)(305945005)(7736002)(5660300002)(76176011)(6512007)(4326008)(6116002)(50466002)(86362001)(2501003)(6636002)(103116003)(6486002)(23756003)(66066001)(47776003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB2126;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6fd09a5e-c187-466d-315a-08d76e52380e
NoDisclaimer: True
X-Forefront-PRVS: 0228DDDDD7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWqMqQBECh73IqXq9mppz7W9FgKVsrLlL/Pq+HtrVMplA+0iz2nZDYh8lDCKZsRq3/Wg3pgSDCZluIrHGndYHdurLq5J/ZeexPjlVh9tr9Mlow3iFNrH4+Akj5qgt/BjHfZpp+11G0xzieoqKod1ng5H9RPnTz9EVd5rZOMlA0jgIPZ/7Ea7tQ+YIz5YG4eRO1493ZdBXRozZ1b/28tbYFtc9pX317O1MNPFCodg1d+ZpC0OWFZy+loTdGRWeIIQiAxj8N8GeseymrUqrcPFeqM3WYLPtktUOXnklHxdOtjykAUlziAxZz2awtgHwiHojOGUUni14oZelm1F3FfwkPMW3lPMODhT9r3Dd1Oo3wdrM9soTZlXkTzOj6MpaM9/V9fkMI+EzoErbWAz5bjK7ZvfTdcV+EcBGJNcaKB6y39EJiuCnpcaEujWuJ0GCm3V
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 07:12:58.0930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3de3291-eec6-4a71-2361-08d76e523cbc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In side by side mode, a writeback job is completed by two pipelines: left
by master and right by slave, we need to wait both pipeline finished (EOW),
then can signal the writeback job completion.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 23 ++++++++++---------
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  5 ++++
 .../arm/display/komeda/komeda_wb_connector.c  |  3 +++
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 24928b922fbd..78351b7135f8 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -193,27 +193,28 @@ komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
 	return err;
 }
=20
-void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
+void komeda_crtc_handle_event(struct komeda_crtc *kcrtc,
 			      struct komeda_events *evts)
 {
 	struct drm_crtc *crtc =3D &kcrtc->base;
+	struct komeda_wb_connector *wb_conn =3D kcrtc->wb_conn;
 	u32 events =3D evts->pipes[kcrtc->master->id];
=20
 	if (events & KOMEDA_EVENT_VSYNC)
 		drm_crtc_handle_vblank(crtc);
=20
-	if (events & KOMEDA_EVENT_EOW) {
-		struct komeda_wb_connector *wb_conn =3D kcrtc->wb_conn;
+	/* handles writeback event */
+	if (events & KOMEDA_EVENT_EOW)
+		wb_conn->complete_pipes |=3D BIT(kcrtc->master->id);
=20
-		if (wb_conn)
-			drm_writeback_signal_completion(&wb_conn->base, 0);
-		else
-			DRM_WARN("CRTC[%d]: EOW happen but no wb_connector.\n",
-				 drm_crtc_index(&kcrtc->base));
+	if (kcrtc->side_by_side &&
+	    (evts->pipes[kcrtc->slave->id] & KOMEDA_EVENT_EOW))
+		wb_conn->complete_pipes |=3D BIT(kcrtc->slave->id);
+
+	if (wb_conn->expected_pipes =3D=3D wb_conn->complete_pipes) {
+		wb_conn->complete_pipes =3D 0;
+		drm_writeback_signal_completion(&wb_conn->base, 0);
 	}
-	/* will handle it together with the write back support */
-	if (events & KOMEDA_EVENT_EOW)
-		DRM_DEBUG("EOW.\n");
=20
 	if (events & KOMEDA_EVENT_FLIP) {
 		unsigned long flags;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index ae6654fe95e2..174fb0a0b49b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -58,6 +58,11 @@ struct komeda_wb_connector {
=20
 	/** @wb_layer: represents associated writeback pipeline of komeda */
 	struct komeda_layer *wb_layer;
+
+	/** @expected_pipes: pipelines are used for the writeback job */
+	u32 expected_pipes;
+	/** @complete_pipes: pipelines which have finished writeback */
+	u32 complete_pipes;
 };
=20
 /**
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 44e628747654..d6833ea3b822 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -157,6 +157,9 @@ static int komeda_wb_connector_add(struct komeda_kms_de=
v *kms,
 		return -ENOMEM;
=20
 	kwb_conn->wb_layer =3D kcrtc->master->wb_layer;
+	kwb_conn->expected_pipes =3D BIT(kcrtc->master->id);
+	if (kcrtc->side_by_side)
+		kwb_conn->expected_pipes |=3D BIT(kcrtc->slave->id);
=20
 	wb_conn =3D &kwb_conn->base;
 	wb_conn->encoder.possible_crtcs =3D BIT(drm_crtc_index(&kcrtc->base));
--=20
2.20.1

