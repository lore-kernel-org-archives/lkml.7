Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D205C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582DA2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Uo6sRxoV";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Uo6sRxoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfKUHM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:12:58 -0500
Received: from mail-eopbgr00073.outbound.protection.outlook.com ([40.107.0.73]:64166
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726658AbfKUHM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYH3lh3p96aYyG0U7lY8+jPIWzUDqW/V2y01c6fakes=;
 b=Uo6sRxoVF1XaErz2VSDdZJ7e8QXzIZJctWe4xrdixnfwwfH9XteVdcuplVq4J3sInElbsaABWiiDVmxONA6rfocC5ktwtxKERyhmtlcYzB/OUbzNCy3SfthwOqJo7JlIRzXYCjP7LoRYepwt3ojBF8beYr7G3Ns4Sn8kagSAvxs=
Received: from AM4PR08CA0058.eurprd08.prod.outlook.com (2603:10a6:205:2::29)
 by DB8PR08MB5497.eurprd08.prod.outlook.com (2603:10a6:10:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Thu, 21 Nov
 2019 07:12:53 +0000
Received: from AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by AM4PR08CA0058.outlook.office365.com
 (2603:10a6:205:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Thu, 21 Nov 2019 07:12:53 +0000
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
 15.20.2474.17 via Frontend Transport; Thu, 21 Nov 2019 07:12:53 +0000
Received: ("Tessian outbound f7868d7ede10:v33"); Thu, 21 Nov 2019 07:12:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 448b6a653e5d64b2
X-CR-MTA-TID: 64aa7808
Received: from e29630e7d491.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 569D2F7C-CD4D-4EF3-9A12-592DF533411E.1;
        Thu, 21 Nov 2019 07:12:47 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e29630e7d491.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 21 Nov 2019 07:12:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/HwmQFeuZ4m9mfZGyfsvXFcn8bpPOqFLbYRs6/p6SKquh1DZ+ETIC11eKtVAWNC3cdX33W8L2inAU7gqAyCgCVDWJy7z5TomuOiNIXYJicO/qgYBKJ/pyCnEBf4pSKBRjNgfvPhdqBb3Ozu9MB2s/R9+1ELRj5ocMrrR2BUuQ9U4c1vX2kwRAz59Ihbbbv9WWhmFSn5s0AoaQut+CkATIMXB9W3xSblJNOyA7VV6DpVKdP0Mkh4O8r4JV4NBrSp+6dUtcfm7NXyIewmg+zDX5KwQx3tKMHZzsfCDSCQJyAFNDgPMju5VeEwExWGZMu3MpyUXoTTr/vIPq2lCQ30aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYH3lh3p96aYyG0U7lY8+jPIWzUDqW/V2y01c6fakes=;
 b=gDQNE5pCServBUoxjVVWB+HmycIp09U2R+S1sOFda+cntsjxxFbdlrUs117wop/7LV008Wy1ARQYYNJqpkBturqSxAPYEI8JktkOzEHuWiEPfLgJ+kth2YJLlCuLUMM+Td63rsIGpfeUb0jlI96ChOFaoCToAZ38XblcxVsnKtqi1I80KxB5VHhPbsYXF+AL0heK9udja+ZeyWRJ2QlilpXUr4uOoL59Vaiv64aCDKpam/02Gp74nrSuKAH1ghP092ImVqqA8Hfq0tl7BivoyN/tfh2LDX7sx8IA+iP6KoTJ4ACRTR2CELf0cHicG279YeOzcT+YDm/giD4HkBI5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYH3lh3p96aYyG0U7lY8+jPIWzUDqW/V2y01c6fakes=;
 b=Uo6sRxoVF1XaErz2VSDdZJ7e8QXzIZJctWe4xrdixnfwwfH9XteVdcuplVq4J3sInElbsaABWiiDVmxONA6rfocC5ktwtxKERyhmtlcYzB/OUbzNCy3SfthwOqJo7JlIRzXYCjP7LoRYepwt3ojBF8beYr7G3Ns4Sn8kagSAvxs=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5069.eurprd08.prod.outlook.com (20.179.29.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 07:12:45 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 07:12:45 +0000
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
Subject: [PATCH v4 4/6] drm/komeda: Add side by side support for writeback
Thread-Topic: [PATCH v4 4/6] drm/komeda: Add side by side support for
 writeback
Thread-Index: AQHVoDsStpijpsQiP0y4YgTpq6Fi4A==
Date:   Thu, 21 Nov 2019 07:12:45 +0000
Message-ID: <20191121071205.27511-5-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8cfd685b-604b-4359-6975-08d76e5239c6
X-MS-TrafficTypeDiagnostic: VE1PR08MB5069:|VE1PR08MB5069:|DB8PR08MB5497:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5497AEFE2158925EEB75D5EDB34E0@DB8PR08MB5497.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:785;OLM:785;
x-forefront-prvs: 0228DDDDD7
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(366004)(376002)(346002)(136003)(189003)(199004)(386003)(6636002)(55236004)(102836004)(6506007)(76176011)(256004)(52116002)(2906002)(14444005)(50226002)(7736002)(305945005)(66446008)(186003)(81166006)(81156014)(8676002)(8936002)(66946007)(6512007)(26005)(2616005)(71200400001)(6486002)(446003)(478600001)(11346002)(71190400001)(6436002)(64756008)(66476007)(66556008)(86362001)(66066001)(4326008)(36756003)(2501003)(6116002)(316002)(3846002)(14454004)(103116003)(99286004)(54906003)(110136005)(25786009)(1076003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5069;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lBzoTroHGeo157bRzbhmiwpump8UiAdoGDTDdu1LHKSxoaWYvRaAMywkB3fSKP9ofQHCOm65PU4H4ffrfD3GiWK17Gnlrj47vITJndnwumUznJvRM+JMENQ6hCu1jCF5JKS+Ng5/kBh2lf8EmLpb2wmjyV6CCCDEh/j3SHDYT5vI6lY/zQQ30su8TLhZuKviDv6dq4U2bR7B8LrdADnJMBdJ2gVjcO4DTQmeaxi5FmslnXh8CafGeoupMq6Re3fgKALnUL2H5yPnIoLszOTXUNFL9Sh8SmSepyMDO2YCF/Rm3kvaOneHxA+o2JxlHHz9waGIvqWg8pG446RS/tRReYNyUpm7VNxQkJz+7cHDtSa12I7+sl9mph4nRPk99hzY0WTISLXlUWQ4s2fezuZpji+6xnd/KqOYB4ZcEmhkLmj+PC7k6GuStqArFODzfoVe
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5069
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(1110001)(339900001)(189003)(199004)(386003)(6506007)(6486002)(22756006)(316002)(36906005)(54906003)(23756003)(356004)(336012)(50466002)(3846002)(6636002)(14444005)(110136005)(105606002)(103116003)(36756003)(2906002)(99286004)(6116002)(2616005)(305945005)(26005)(186003)(76130400001)(76176011)(70206006)(70586007)(5660300002)(102836004)(47776003)(8676002)(8936002)(4326008)(2501003)(446003)(25786009)(50226002)(81156014)(478600001)(86362001)(11346002)(7736002)(26826003)(66066001)(14454004)(6512007)(81166006)(8746002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5497;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c64a12e7-a0bc-40ca-3913-08d76e523503
NoDisclaimer: True
X-Forefront-PRVS: 0228DDDDD7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRRL5Tyen/Wt16be6dFQMpW3i8UQu0m4ju2IB+//b4WvHeYLxUFRHirmTEtVfWIz8+xlRkggo3vXGndr32JqvdtcjQBo+fLDn6POU29EyL/wPIsZ1A9Wh/Bm2nVcCh/Lq3WBlEAP/CmY8TFUuByJzq+vXT9pAl5Rz1u/JR1iD72xO56ir/ukh7LS0MWTErQfvXsu71N0opSGxd4kFV13ZQpQL2VLXF1WQbWCi3+2uM4Rmbd0+SFAJmzMjiSRa/pOr2QdKvckNp5YTKrJ4DgdPhoQ5CGUBuZGnLYXvC3riV1oM+Zcno8iy3p/pnF1yiCW0t1az09P4b3szXdtNACzjL5x670TQFuXghSZPuUjycXbxYiOnX8u4S53mEOQXABSvHmYxGjrCMrMz5foqg05JU0AvDNE0khloz3rb/W0zAG0OI6RSgAQZ+WfxSBtBlfB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 07:12:53.1061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfd685b-604b-4359-6975-08d76e5239c6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5497
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In side by side mode, the master pipeline writeback the left frame and the
slave writeback the right part, the data flow as below:

  slave.compiz -> slave.wb_layer -> fb (right-part)
  master.compiz -> master.wb_layer -> fb (left-part)

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/komeda/komeda_pipeline.h  |  4 ++
 .../display/komeda/komeda_pipeline_state.c    | 42 +++++++++++++++++++
 .../arm/display/komeda/komeda_wb_connector.c  |  6 ++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 59a81b4476df..76621a972803 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -564,6 +564,10 @@ int komeda_build_wb_split_data_flow(struct komeda_laye=
r *wb_layer,
 				    struct drm_connector_state *conn_st,
 				    struct komeda_crtc_state *kcrtc_st,
 				    struct komeda_data_flow_cfg *dflow);
+int komeda_build_wb_sbs_data_flow(struct komeda_crtc *kcrtc,
+				  struct drm_connector_state *conn_st,
+				  struct komeda_crtc_state *kcrtc_st,
+				  struct komeda_data_flow_cfg *wb_dflow);
=20
 int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
 				   struct komeda_crtc_state *kcrtc_st);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index b1e90feb5c55..79f7e7b6526f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -1377,6 +1377,48 @@ int komeda_build_wb_split_data_flow(struct komeda_la=
yer *wb_layer,
 	return komeda_wb_layer_validate(wb_layer, conn_st, dflow);
 }
=20
+/* writeback side by side split data path:
+ *
+ * slave.compiz -> slave.wb_layer - > fb (right-part)
+ * master.compiz -> master.wb_layer -> fb (left-part)
+ */
+int komeda_build_wb_sbs_data_flow(struct komeda_crtc *kcrtc,
+				  struct drm_connector_state *conn_st,
+				  struct komeda_crtc_state *kcrtc_st,
+				  struct komeda_data_flow_cfg *wb_dflow)
+{
+	struct komeda_pipeline *master =3D kcrtc->master;
+	struct komeda_pipeline *slave =3D kcrtc->slave;
+	struct komeda_data_flow_cfg m_dflow, s_dflow;
+	int err;
+
+	if (wb_dflow->en_scaling || wb_dflow->en_img_enhancement) {
+		DRM_DEBUG_ATOMIC("sbs doesn't support WB_scaling\n");
+		return -EINVAL;
+	}
+
+	memcpy(&m_dflow, wb_dflow, sizeof(*wb_dflow));
+	memcpy(&s_dflow, wb_dflow, sizeof(*wb_dflow));
+
+	/* master writeout the left part */
+	m_dflow.in_w >>=3D 1;
+	m_dflow.out_w >>=3D 1;
+	m_dflow.input.component =3D &master->compiz->base;
+
+	/* slave writeout the right part */
+	s_dflow.in_w >>=3D 1;
+	s_dflow.out_w >>=3D 1;
+	s_dflow.in_x +=3D m_dflow.in_w;
+	s_dflow.out_x +=3D m_dflow.out_w;
+	s_dflow.input.component =3D &slave->compiz->base;
+
+	err =3D komeda_wb_layer_validate(master->wb_layer, conn_st, &m_dflow);
+	if (err)
+		return err;
+
+	return komeda_wb_layer_validate(slave->wb_layer, conn_st, &s_dflow);
+}
+
 /* build display output data flow, the data path is:
  * compiz -> improc -> timing_ctrlr
  */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 17ea021488aa..44e628747654 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -37,6 +37,7 @@ komeda_wb_encoder_atomic_check(struct drm_encoder *encode=
r,
 			       struct drm_crtc_state *crtc_st,
 			       struct drm_connector_state *conn_st)
 {
+	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc_st->crtc);
 	struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(crtc_st);
 	struct drm_writeback_job *writeback_job =3D conn_st->writeback_job;
 	struct komeda_layer *wb_layer;
@@ -65,7 +66,10 @@ komeda_wb_encoder_atomic_check(struct drm_encoder *encod=
er,
 	if (err)
 		return err;
=20
-	if (dflow.en_split)
+	if (kcrtc->side_by_side)
+		err =3D komeda_build_wb_sbs_data_flow(kcrtc,
+				conn_st, kcrtc_st, &dflow);
+	else if (dflow.en_split)
 		err =3D komeda_build_wb_split_data_flow(wb_layer,
 				conn_st, kcrtc_st, &dflow);
 	else
--=20
2.20.1

