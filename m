Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E86FC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA6E206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fvUaaP82";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fvUaaP82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfLEIgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:36:20 -0500
Received: from mail-eopbgr20086.outbound.protection.outlook.com ([40.107.2.86]:24558
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729030AbfLEIgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIB/8z50vBuASSq6iSuVafx4DPXkwq7T4HlbSTTsATE=;
 b=fvUaaP82b1BxI7e/YojWlAuAHflK3AHmHbQeWSP+T3AWLdN1kWGEuf6BJYzyg5atWGb2KxewJprku67Ggs9WaOY5vQ0GK8+nYoTvI3cQO8yO50tnptBW+NrNJZZ9J7U5jR3OCMpNEVZLEJ5k95vFx/4uAIdC1PtcEbKoRKnN7z0=
Received: from VI1PR08CA0111.eurprd08.prod.outlook.com (2603:10a6:800:d4::13)
 by AM0PR08MB3763.eurprd08.prod.outlook.com (2603:10a6:208:109::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Thu, 5 Dec
 2019 08:36:09 +0000
Received: from AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by VI1PR08CA0111.outlook.office365.com
 (2603:10a6:800:d4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Thu, 5 Dec 2019 08:36:09 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT059.mail.protection.outlook.com (10.152.17.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 5 Dec 2019 08:36:09 +0000
Received: ("Tessian outbound a4662a02422d:v37"); Thu, 05 Dec 2019 08:36:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7981b86e7e73f93b
X-CR-MTA-TID: 64aa7808
Received: from ef55844377f8.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A6739013-FDFC-4A91-933B-A7AA873F9A8A.1;
        Thu, 05 Dec 2019 08:36:04 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ef55844377f8.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Dec 2019 08:36:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhejpaP+lbyZNeNa/Jhf7lL2onD2lTLKk0Ej4FSoB4yYANMDaomDTruZo1BHfSKfkenu/py0DMc6r0er7nG6J2DV5+XG+U4GdBhmBMCUM/vbZgsbNCuUHCxa5Czas7XG70xRhTzNrCrXF7CsCqXkk9NJILq57MMmbPsAGRJkz+TenjwxH0YrB4nHbpIJ9WZm0YyTsrWQBAxGPtjY5UQiI8cL1cPRgW6C8vxtHMOt2OglSO8jpPD+xRcwSX6RprAivzW0743CdPfhJ9ZwKG17ekW5QnS0/vAuQ4HeV9zuGgASZv9DD7VHK0Boss1w+G+W+t+YousBMMug5NTZNo0rag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIB/8z50vBuASSq6iSuVafx4DPXkwq7T4HlbSTTsATE=;
 b=jlGs0plwuzgePZ4+s+Kvlw6QnUAMlKTrePIU1wkfaN5DcPLehvtHFqxHrfi0pMb5027t30zNgZgs4ncMxurCXtim19csqdo92lDjXvUwJtNMFKGvbk/h6kqEGwSfZeShpWrjb9YQ+bYvLxO1lsO5cbo3j0vFDV96KRmfrr5oNkDpyIMK83cjccvY6l6mrlrGNsEHQyrRAulBz5N73/tCHPWjxt9H/IfEy2W/njDoAw3rAqO3xaOOsTUQMgBDde1fz2tAhRf5eFiIczgCnys6W+anTJmSYEr+f+1rq4U1n7/B2d1aq6ZK9CQVmg3UH+Kwl0wJRIDuYfrMEdmggmpG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIB/8z50vBuASSq6iSuVafx4DPXkwq7T4HlbSTTsATE=;
 b=fvUaaP82b1BxI7e/YojWlAuAHflK3AHmHbQeWSP+T3AWLdN1kWGEuf6BJYzyg5atWGb2KxewJprku67Ggs9WaOY5vQ0GK8+nYoTvI3cQO8yO50tnptBW+NrNJZZ9J7U5jR3OCMpNEVZLEJ5k95vFx/4uAIdC1PtcEbKoRKnN7z0=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 AM0SPR01MB0026.eurprd08.prod.outlook.com (52.135.152.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 08:35:59 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 08:35:59 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
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
Subject: [PATCH v5 5/5] drm/komeda: Update writeback signal for side_by_side
Thread-Topic: [PATCH v5 5/5] drm/komeda: Update writeback signal for
 side_by_side
Thread-Index: AQHVq0cF03eyLO6qo0idLgyeebDndg==
Date:   Thu, 5 Dec 2019 08:35:59 +0000
Message-ID: <20191205083436.11060-6-james.qian.wang@arm.com>
References: <20191205083436.11060-1-james.qian.wang@arm.com>
In-Reply-To: <20191205083436.11060-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d45f34bc-288b-4e86-f0ff-08d7795e2d8c
X-MS-TrafficTypeDiagnostic: AM0SPR01MB0026:|AM0SPR01MB0026:|AM0PR08MB3763:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3763D272E8A47C97ED1EB24DB35C0@AM0PR08MB3763.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 02426D11FE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(8676002)(5660300002)(71200400001)(71190400001)(7736002)(86362001)(305945005)(2906002)(316002)(36756003)(103116003)(50226002)(1076003)(81156014)(81166006)(6862004)(8936002)(55236004)(6636002)(4326008)(99286004)(186003)(478600001)(11346002)(2616005)(102836004)(26005)(25786009)(76176011)(52116002)(14454004)(6506007)(66446008)(6116002)(54906003)(66946007)(66476007)(66556008)(64756008)(3846002)(37006003)(6436002)(6486002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB0026;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: mFS7CyQlowxH376tvEwyXToG/sUDqBhLVVEg25HPWHduhv6V5GfkxsCQzwNqYDKZ8izQ5bahJ3zwAH33G3LFt2plqXIV5Bt14YtF/Iwa9JkujJsqIwHcV2GOYRr/3jUdLUfE9QAw+/ULA67yyhC2BWTrFDm36qDRV4/ykhSSUAmu4qQGUu5stXwzE9t4I+jN48IeiXbzEtrCs1q0Bm8RQ5WxlacWdsowHJfzuflIi4u0QOXSniKm4nm8qdKnZNz2ME+Zdsjl8TgFiXYm+s+LJTe4vLsE6LoCyRh+5wcq7B0iQIxP3d8sSztkPyiE+kxFiIh21HWY8S2HjaKDCGciKN/KX7YSHF6EA8EG/pars3IumhZcuw0SqhQ8Js0GHIgrTFMwjYgBi8ilfo6bzn9A4DTLV5kXuB9Of1o+ra4MyX/hTOHjpZTMYfXx2KMj7NEO
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0026
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(23756003)(8936002)(3846002)(5660300002)(8746002)(81166006)(8676002)(81156014)(11346002)(6636002)(478600001)(2616005)(316002)(2906002)(6512007)(26826003)(1076003)(37006003)(36906005)(14454004)(356004)(54906003)(70586007)(336012)(103116003)(4326008)(86362001)(6486002)(6116002)(50466002)(70206006)(25786009)(186003)(6506007)(26005)(99286004)(76130400001)(7736002)(50226002)(6862004)(22756006)(102836004)(76176011)(36756003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3763;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 22bd2655-0fcc-4004-114e-08d7795e2774
NoDisclaimer: True
X-Forefront-PRVS: 02426D11FE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjLtOH0qORUqmv4QES8BW4ur3PG96YpPeVEBlgwUj0kPVIbU7OYSQy2ycFHajGNF7nafOcA8GApwRbuArwnvgq5l+/bHT6j8gLhhhdaZyIaO6LUk/78O3Mnw5TI/GtLLlJGRFqs8vZN4bejvY3xmU5ob9SgBVlKRTmLaJQMQe7NQ8FEecXaCQ1bXJQtO1VsVAzNevDr6CC/YmAW4qToTEnhxrLYGDgMZb8p8S2LyexxgTjDzRJPwGVojzXB/w4c6I8kLbGXfyFxd+NKBO5MvCg4yBvTsXDYwqLMgAr2c3nDeadPty/KLz4UaRMEyevojlUsWYBgUKRpv5NEd0G9M3kOJuCYNlQzLfUa5db/nuIbfJAuvoJj2ofEBKP8sfC0S1pCrrRTumMmNM91Z7f8qZyLmjSgI3Avlbo+02NOWk7zKRdeJapntuUYJgkDIPxH7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 08:36:09.3682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45f34bc-288b-4e86-f0ff-08d7795e2d8c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3763
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

