Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C498BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921522070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ksXJ9Hwk";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ksXJ9Hwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKNIiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:38:10 -0500
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:1675
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfKNIiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIB/8z50vBuASSq6iSuVafx4DPXkwq7T4HlbSTTsATE=;
 b=ksXJ9Hwk0sZefHfMGkFPiAIwugHad7dQGrzM0c5e77vKS4tcRKVxTz/N5qbrq06uL5EDVKek6gXyMTa7dC20KZvo8VWGh/y5OLOJUIlclKS3t+k8YHt8SVHB8w3lKM+xUjQWsGRTXldrbM10bVrVCEVMuyrDZwF6AR8OxklmenI=
Received: from VE1PR08CA0031.eurprd08.prod.outlook.com (2603:10a6:803:104::44)
 by AM5PR0802MB2564.eurprd08.prod.outlook.com (2603:10a6:203:a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Thu, 14 Nov
 2019 08:38:01 +0000
Received: from AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VE1PR08CA0031.outlook.office365.com
 (2603:10a6:803:104::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.26 via Frontend
 Transport; Thu, 14 Nov 2019 08:38:01 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT059.mail.protection.outlook.com (10.152.17.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Thu, 14 Nov 2019 08:38:01 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Thu, 14 Nov 2019 08:37:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d850798c1982cdac
X-CR-MTA-TID: 64aa7808
Received: from 11f31d2f9a69.2 (cr-mta-lb-1.cr-mta-net [104.47.10.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D3868E3C-8638-4D8E-B6D8-8E5581D41AFC.1;
        Thu, 14 Nov 2019 08:37:54 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2051.outbound.protection.outlook.com [104.47.10.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 11f31d2f9a69.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 14 Nov 2019 08:37:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv0Un6YLFSi5Ac2pk4Pct8vRCasS6ko/prnftcfbwu0nLXSUi6R2wMW/CXABgxbVfhyby29AL1S61gQKLfEt22LQYX/Tpg7aG+vRpmUWi9u2kvvM9xWqCcGgqEsT1XhKPDtbva+5HUYxaXhdQXwirsCaBh4uoAKDF3F4byUppJr4+RNBSt8YPdn7X8g++dPbKMBkCvBeQcTLhWFYmyxb/hC+uDMhfN86lNlXXCwYaWN7CkMsHgqqA0yr0ej2VvE8/86JMqij8kid/RzN69JS0qRVrYImjew7tYkuV+poKgcmtdYQ+7/nFa9qkKWiknyBorKOIf9G5thQuKfq6aNp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIB/8z50vBuASSq6iSuVafx4DPXkwq7T4HlbSTTsATE=;
 b=SQqv3tv7QLnVa3mzd7J5/qwv25KquamnvE7QrY/zhfeg8w6T0ZFeUf0xj7zCjPCUm2qy3EOlIUMgcCNslP3dhudgEuxEg/izjfdlg68KioXXz2j6ZY7PjkNt5loBJrQ7ys01oI1S8WrIsRqMbMUKatXyO99UVFUOfCtqANT/Ooi0kGpP6EWjLGkx/dYMQ3aL8BSOwKz+DHHKqoKwOMhvfYLsXfGL4kDSAlKxvHmmy4qdc5f/6QFZzq7d7DVIZ19T9HyjttXYMueXqbBGSeBXdt3XGPzI3oGbXafZilpCOfQGkgwvo9yNs1R4Rx1ELu4K9lxWWgWusTLbZx/N2CnaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIB/8z50vBuASSq6iSuVafx4DPXkwq7T4HlbSTTsATE=;
 b=ksXJ9Hwk0sZefHfMGkFPiAIwugHad7dQGrzM0c5e77vKS4tcRKVxTz/N5qbrq06uL5EDVKek6gXyMTa7dC20KZvo8VWGh/y5OLOJUIlclKS3t+k8YHt8SVHB8w3lKM+xUjQWsGRTXldrbM10bVrVCEVMuyrDZwF6AR8OxklmenI=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4768.eurprd08.prod.outlook.com (10.255.114.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Thu, 14 Nov 2019 08:37:52 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 08:37:52 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v3 5/6] drm/komeda: Update writeback signal for side_by_side
Thread-Topic: [PATCH v3 5/6] drm/komeda: Update writeback signal for
 side_by_side
Thread-Index: AQHVmsbNlRubU2tfgE+DaVY2KN4Vzw==
Date:   Thu, 14 Nov 2019 08:37:51 +0000
Message-ID: <20191114083658.27237-6-james.qian.wang@arm.com>
References: <20191114083658.27237-1-james.qian.wang@arm.com>
In-Reply-To: <20191114083658.27237-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::26) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e6b0bcd-0482-40d2-973a-08d768ddf5a1
X-MS-TrafficTypeDiagnostic: VE1PR08MB4768:|VE1PR08MB4768:|AM5PR0802MB2564:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2564141E28F6D89EA82459AFB3710@AM5PR0802MB2564.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 02213C82F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(136003)(39850400004)(189003)(199004)(71200400001)(71190400001)(36756003)(305945005)(2906002)(7736002)(110136005)(54906003)(6116002)(316002)(3846002)(99286004)(103116003)(446003)(11346002)(6486002)(8936002)(2616005)(476003)(6436002)(66476007)(66556008)(64756008)(66446008)(66946007)(478600001)(6512007)(50226002)(66066001)(486006)(14454004)(2501003)(5660300002)(76176011)(52116002)(256004)(386003)(55236004)(25786009)(6636002)(102836004)(6506007)(8676002)(4326008)(26005)(81156014)(81166006)(1076003)(186003)(2201001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4768;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MEsGhWJrshKKYBlpp5akMZgcpvQ6hX2rSiV/hWIINbp4UJb9pCzBRp+FkOcrkBLAuHXJYV00zbjSwzATwCxDz3jB89WklghTyApHhwm4MHjAEQUpYneB0bGO3QsbNoQ4uG02/hlpzK9J4rQNA/KQAZi6nu3ZelmCZnogFEldVFP0vM2yAanM7Bz660BkieL8BAe1tgEUhCUFboiu1XoZroM1fG/A9qwz2SBo3OxE+TB7C0zuCbyC8MM8XCYAB3n4sVOW4BBP8gi5vVSjtAmb7qM6tcONnZF/JmxSxNdERpOkuiiAdKvLSTEvFhtJWLDkUuboZpNnu+tT62Axf1c69F4yDZfHjdGs2zuRdY40S/pUuXoaZ6kGS3uDnHpOnaiBleoWOFdK2M44EZ/MzPLj89ooEBOq9E7htqe67xj3JMqYHn7FYjld/rfCsRrOqQyR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4768
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(1110001)(339900001)(189003)(199004)(8676002)(50226002)(23756003)(446003)(11346002)(102836004)(2501003)(26005)(305945005)(7736002)(66066001)(5660300002)(70586007)(2906002)(6116002)(8936002)(81166006)(3846002)(8746002)(22756006)(76130400001)(81156014)(70206006)(47776003)(54906003)(1076003)(356004)(103116003)(76176011)(486006)(105606002)(386003)(36756003)(476003)(2616005)(126002)(6506007)(99286004)(36906005)(478600001)(186003)(336012)(2201001)(6636002)(50466002)(4326008)(316002)(14454004)(6512007)(26826003)(86362001)(110136005)(6486002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0802MB2564;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 40cf5903-5bd3-467d-49a6-08d768ddefe9
NoDisclaimer: True
X-Forefront-PRVS: 02213C82F8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsJo0tl4de5SzHlJhoEnaeEmKDXNR8r2LcVUPFCU+tIUH0MQ4eyscrR8I0aZKGv3tuO2rnGzQNpKIiHVnep/qlNbAXZkof/mJfaqglYjf1P/vu4VSYFTniYhKD8FboTztssaBf/2hwpLDCoEMH9R6P2l1fyAw4URKN2UVn0qL+ClZghJ9ef/RQbaZpVslW3rd53s9AwICzscKmvOyvdcg97h6LMdtzX9tdnd0KJHduBYY5O6qA4NR2373IWaw7LdqTNWEPPyk+M5CrlZc4K/ZzmIKDuBhAg/jBm92jD8KGITp+JBr1jGROpCz+R3RZpmveYOnHv+3VLlkN12W4ANGLm2JxnR3mw0L3GGtqMS1YkDwf1/JC4XmOpu8h01en1BYxhTiwEg/vIaMYFD3nmW0rE61ZGCV+MC+g7kMKSFBkfzz/ZivFUrNmfv42oBw7Bx
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 08:38:01.3643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6b0bcd-0482-40d2-973a-08d768ddf5a1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2564
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

