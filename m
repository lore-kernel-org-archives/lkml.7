Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559EDC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0EE205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="t8NE4Sib";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="t8NE4Sib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfLEIf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:35:58 -0500
Received: from mail-eopbgr00040.outbound.protection.outlook.com ([40.107.0.40]:20654
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbfLEIf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBBxY4dtQRlii0s47SsBLbJKYHMigVwhrTe2lW2g4UE=;
 b=t8NE4Sibhuv8VhDOG6AwwM7ptkRxMSU1SWU0ZyIPaT7SUpHd/5sNP/2y6LuEpm+eoXR87LuK5tg/un+OCtNI0l3CZjc38TAfIY6RXg2lutP8spbciW9VrboCmvxwPQSvD+O7rd01TzZKe9EIjTGMoHIwIQ8SF5r/7trze89auag=
Received: from HE1PR0802CA0010.eurprd08.prod.outlook.com (2603:10a6:3:bd::20)
 by VI1PR0801MB1677.eurprd08.prod.outlook.com (2603:10a6:800:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14; Thu, 5 Dec
 2019 08:35:49 +0000
Received: from AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by HE1PR0802CA0010.outlook.office365.com
 (2603:10a6:3:bd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Thu, 5 Dec 2019 08:35:49 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT026.mail.protection.outlook.com (10.152.16.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 5 Dec 2019 08:35:49 +0000
Received: ("Tessian outbound 5574dd7ffaa4:v37"); Thu, 05 Dec 2019 08:35:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1df4ec539c909e21
X-CR-MTA-TID: 64aa7808
Received: from 66ba22ffbb8a.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 941BE465-8543-4D86-B077-967965B70159.1;
        Thu, 05 Dec 2019 08:35:43 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 66ba22ffbb8a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Dec 2019 08:35:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXwQMIEToXOcbXYWBRmg16oakfd2UVtHZnsLr+MeNKOykA4O9q48T6iTJJeq9ZKc4ZGqdrFDKqbjguWyuGSGYAyMxb35mDWiZf9YsFoQQ9O9rV7rwPsYHfSZN7hcUoFhZ7VUcJQakrfHURaw/rxvhRR5KBOAod7E9P6hPgQGsIqrv2XBphrrNd56ygP6GVqSWm7KjZCXDdqsZUD6wxe4Vamn5PNdHFLuexRz5xylV7hMA1moc76ML5SMtgC6gvnoRGIu+EwjJfN8Y81hGRfmDYu0O9oaU59WmYgb97D1XuVt0/FgqbWPid2okIOGKNNuADqsWzhiLtM4pBhtn622MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBBxY4dtQRlii0s47SsBLbJKYHMigVwhrTe2lW2g4UE=;
 b=k2sKAH7cL16qK9mE1u3V6d2cowBKOH5TG+CiQeQ+v/0DlqevOMQazn0zlMg9dLLaZ3ga/YBJ/J1jFcPQrmroOnljJEWyuMT5A2R1BXHnBhp1Fd7YBlPV3euO8JZq1SgjuebYi4pRux5IlZbRp45V3j8+Emwr++nZ2zKo6pHPOuhzwUguwbZEVd4/BL/YoxcxxClq2dghOS9Gz7b6o1aueYdLlZl4GWU/+zh0L/FY6QqEbCWdHj40/K6lwN+GRdSH5Nima515c4GcLVyMI99NG04ArjoRnEaKlZ6deigueXsXDfxEPiyRn9Jof5PVNCEEh/B3r8Folh7cmzgiaat+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBBxY4dtQRlii0s47SsBLbJKYHMigVwhrTe2lW2g4UE=;
 b=t8NE4Sibhuv8VhDOG6AwwM7ptkRxMSU1SWU0ZyIPaT7SUpHd/5sNP/2y6LuEpm+eoXR87LuK5tg/un+OCtNI0l3CZjc38TAfIY6RXg2lutP8spbciW9VrboCmvxwPQSvD+O7rd01TzZKe9EIjTGMoHIwIQ8SF5r/7trze89auag=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 AM0SPR01MB0047.eurprd08.prod.outlook.com (20.179.32.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 08:35:42 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 08:35:42 +0000
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
Subject: [PATCH v5 1/5] drm/komeda: Add side by side assembling
Thread-Topic: [PATCH v5 1/5] drm/komeda: Add side by side assembling
Thread-Index: AQHVq0b6iOAY1xrPm0y50+wKBy716g==
Date:   Thu, 5 Dec 2019 08:35:42 +0000
Message-ID: <20191205083436.11060-2-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: c1b654c9-05f6-4102-580a-08d7795e2190
X-MS-TrafficTypeDiagnostic: AM0SPR01MB0047:|AM0SPR01MB0047:|VI1PR0801MB1677:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB167739DE5FE0DF9C8C712399B35C0@VI1PR0801MB1677.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3383;OLM:3383;
x-forefront-prvs: 02426D11FE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(199004)(189003)(8676002)(5660300002)(71190400001)(71200400001)(7736002)(305945005)(2906002)(86362001)(316002)(36756003)(103116003)(81156014)(50226002)(1076003)(81166006)(8936002)(6862004)(6636002)(4326008)(99286004)(478600001)(11346002)(2616005)(186003)(102836004)(25786009)(52116002)(76176011)(14454004)(55236004)(26005)(6512007)(54906003)(66946007)(66476007)(6116002)(66556008)(64756008)(6506007)(66446008)(3846002)(6486002)(37006003)(6436002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB0047;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: EkXjRds04ojdGTFc7eGTB6r7d3kpkcN4k6cxnP3lFSSYpwMdPx6krgHoquskNl9OPP+LqsbS7pg3WNpPPYHiLo/pA2Pfi3x4w7BZkMOuJgJW9B1wzkPzLoOax0eju8wozzN1R8K2rtqmQHnJ8jjz8wz3ULq+OxhMBQdj8xwM3b5XvbxqwilxIwz2FizEEeVFc2GPe1ehmR92810NRH9HPXbghA51e0mJYl2Tgys/SUsOXl+FYHGn+8LEFBAJKRbTVyz+Yuyh6wLK7g/s5Mi07ebVJqtCv45pPgCOGAeYhZe2yNTZvx9ggJ31JL9ItVoDnu3nMnCpLp14V/Di2MXOw6hcm5P4eg1q9Asr/8FFLgoMK9t2W0u9any1MYoyJU2WND1muEKfho0D/0JZVhMQAH+L/yTe+54P6gBKo0OS9CaVQY/HlKHajG5OY/XB/7Hv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0047
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(2616005)(25786009)(99286004)(11346002)(76176011)(356004)(186003)(37006003)(316002)(36906005)(54906003)(4326008)(6862004)(336012)(26826003)(14444005)(478600001)(22756006)(50226002)(36756003)(14454004)(6506007)(102836004)(23756003)(81156014)(26005)(103116003)(6636002)(70586007)(70206006)(50466002)(8746002)(76130400001)(8936002)(7736002)(5660300002)(6486002)(1076003)(3846002)(6512007)(6116002)(305945005)(8676002)(86362001)(2906002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1677;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d495e1e9-993b-461d-57c1-08d7795e1d49
NoDisclaimer: True
X-Forefront-PRVS: 02426D11FE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4rxZY3gvTK6UeGvQrJQrZ3Pe/k+nhZQYwG5msEBEWX+gTtDb5FctuyY9ZfBVd43WU6tl3/sM2raSyIc2X8qDUs4Q8QJjNyzn81pixl4RoVn5l2BGxvd4onT/XHfzZHfRK6zcdVIqaMN3+qSDNr4AZ14ZwtKj903PXMnKcok/PVVwPguydJKMvm8749G3lLkPv2dBgMhomT//JLHpZnNce4tNBXjrzheAsQhYoR9Sg4nd06EoabDIjMP75y0a61KcEb5vHWCCEonRxkee7UjNQ9xHbfM3fwWtjxLqQ2tuXgMoaQiL4CQ4XXQpMQI75R7VbYZp67lzmt78NDif4dZrmmWdt8QzV/YpwnZ4wt/dtiRuMCFoR/A8eAg/Cm/lJnFkWbcQA04Hhq3wclc3XWxN/6mo/hMdbH9QuB6BBnZQjutN+hFltGn8a8oxQ4i3fK3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 08:35:49.2618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b654c9-05f6-4102-580a-08d7795e2190
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1677
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Komeda HW can support side by side, which splits the internal display
processing to two single halves (LEFT/RIGHT) and handle them by two
pipelines separately.
komeda "side by side" is enabled by DT property: "side_by_side_master",
once DT configured side by side, komeda need to verify it with HW's
configuration, and assemble it for the further usage.

v3: Correct a typo.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 13 ++++-
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  4 ++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  9 ++++
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  3 ++
 .../drm/arm/display/komeda/komeda_pipeline.c  | 50 +++++++++++++++++--
 .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
 6 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 1c452ea75999..cee9a1692e71 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -561,21 +561,30 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms=
,
 	kms->n_crtcs =3D 0;
=20
 	for (i =3D 0; i < mdev->n_pipelines; i++) {
+		/* if sbs, one komeda_dev only can represent one CRTC */
+		if (mdev->side_by_side && i !=3D mdev->side_by_side_master)
+			continue;
+
 		crtc =3D &kms->crtcs[kms->n_crtcs];
 		master =3D mdev->pipelines[i];
=20
 		crtc->master =3D master;
 		crtc->slave  =3D komeda_pipeline_get_slave(master);
+		crtc->side_by_side =3D mdev->side_by_side;
=20
 		if (crtc->slave)
 			sprintf(str, "pipe-%d", crtc->slave->id);
 		else
 			sprintf(str, "None");
=20
-		DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s).\n",
-			 kms->n_crtcs, master->id, str);
+		DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s) sbs(%s).\n",
+			 kms->n_crtcs, master->id, str,
+			 crtc->side_by_side ? "On" : "Off");
=20
 		kms->n_crtcs++;
+
+		if (mdev->side_by_side)
+			break;
 	}
=20
 	return 0;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 4e46f650fddf..0d0e8e4ebc9d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -178,6 +178,10 @@ static int komeda_parse_dt(struct device *dev, struct =
komeda_dev *mdev)
 		}
 	}
=20
+	/* this DT node is experimental hence undocumented */
+	mdev->side_by_side =3D !of_property_read_u32(np, "side_by_side_master",
+						   &mdev->side_by_side_master);
+
 	return ret;
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index d406a4d83352..471604b42431 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -183,6 +183,15 @@ struct komeda_dev {
=20
 	/** @irq: irq number */
 	int irq;
+	/**
+	 * @side_by_side:
+	 *
+	 * on sbs the whole display frame will be split to two halves (1:2),
+	 * master pipeline handles the left part, slave for the right part
+	 */
+	bool side_by_side;
+	/** @side_by_side_master: master pipe id for side by side */
+	int side_by_side_master;
=20
 	/** @lock: used to protect dpmode */
 	struct mutex lock;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index 456f3c435719..ae6654fe95e2 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -76,6 +76,9 @@ struct komeda_crtc {
 	 */
 	struct komeda_pipeline *slave;
=20
+	/** @side_by_side: if the master and slave works on side by side mode */
+	bool side_by_side;
+
 	/** @slave_planes: komeda slave planes mask */
 	u32 slave_planes;
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.c
index 452e505a1fd3..104e27cc1dc3 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -326,14 +326,56 @@ static void komeda_pipeline_assemble(struct komeda_pi=
peline *pipe)
 struct komeda_pipeline *
 komeda_pipeline_get_slave(struct komeda_pipeline *master)
 {
-	struct komeda_component *slave;
+	struct komeda_dev *mdev =3D master->mdev;
+	struct komeda_component *comp, *slave;
+	u32 avail_inputs;
+
+	/* on SBS, slave pipeline merge to master via image processor */
+	if (mdev->side_by_side) {
+		comp =3D &master->improc->base;
+		avail_inputs =3D KOMEDA_PIPELINE_IMPROCS;
+	} else {
+		comp =3D &master->compiz->base;
+		avail_inputs =3D KOMEDA_PIPELINE_COMPIZS;
+	}
=20
-	slave =3D komeda_component_pickup_input(&master->compiz->base,
-					      KOMEDA_PIPELINE_COMPIZS);
+	slave =3D komeda_component_pickup_input(comp, avail_inputs);
=20
 	return slave ? slave->pipeline : NULL;
 }
=20
+static int komeda_assemble_side_by_side(struct komeda_dev *mdev)
+{
+	struct komeda_pipeline *master, *slave;
+	int i;
+
+	if (!mdev->side_by_side)
+		return 0;
+
+	if (mdev->side_by_side_master >=3D mdev->n_pipelines) {
+		DRM_ERROR("DT configured side by side master-%d is invalid.\n",
+			  mdev->side_by_side_master);
+		return -EINVAL;
+	}
+
+	master =3D mdev->pipelines[mdev->side_by_side_master];
+	slave =3D komeda_pipeline_get_slave(master);
+	if (!slave || slave->n_layers !=3D master->n_layers) {
+		DRM_ERROR("Current HW doesn't support side by side.\n");
+		return -EINVAL;
+	}
+
+	if (!master->dual_link) {
+		DRM_DEBUG_ATOMIC("SBS can not work without dual link.\n");
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < master->n_layers; i++)
+		master->layers[i]->sbs_slave =3D slave->layers[i];
+
+	return 0;
+}
+
 int komeda_assemble_pipelines(struct komeda_dev *mdev)
 {
 	struct komeda_pipeline *pipe;
@@ -346,7 +388,7 @@ int komeda_assemble_pipelines(struct komeda_dev *mdev)
 		komeda_pipeline_dump(pipe);
 	}
=20
-	return 0;
+	return komeda_assemble_side_by_side(mdev);
 }
=20
 void komeda_pipeline_dump_register(struct komeda_pipeline *pipe,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index ac8725e24853..20a076cce635 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -237,6 +237,7 @@ struct komeda_layer {
 	 * not the source buffer.
 	 */
 	struct komeda_layer *right;
+	struct komeda_layer *sbs_slave;
 };
=20
 struct komeda_layer_state {
--=20
2.20.1

