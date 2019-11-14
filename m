Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B5BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D172070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jlJb+NgW";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jlJb+NgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKNIh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:37:59 -0500
Received: from mail-eopbgr150052.outbound.protection.outlook.com ([40.107.15.52]:23428
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726655AbfKNIh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6+a5Psi7mCFZ/4vt4yM7Jk/O+MZAzQ5WNcQIh0wvKA=;
 b=jlJb+NgWuAA+RGJY/eCb4GbyucGJT/0JIWHx+zdskEESUOmZd3rY+wJA4J/IrNuKIwUjC0anfAzrWQ0TMks5s7mahSyII+ma5zdb0nFtXN6ezZoXAl7skQ0Y6iu6x+q25UI+imthZ8oO2EnPPhfMwrUwQ+MSUKTOY1wkRL0ajXo=
Received: from VI1PR0802CA0001.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::11) by AM6PR08MB3383.eurprd08.prod.outlook.com
 (2603:10a6:20b:50::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Thu, 14 Nov
 2019 08:37:53 +0000
Received: from VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR0802CA0001.outlook.office365.com
 (2603:10a6:800:aa::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Thu, 14 Nov 2019 08:37:53 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT062.mail.protection.outlook.com (10.152.18.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Thu, 14 Nov 2019 08:37:53 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Thu, 14 Nov 2019 08:37:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c1345366ad8226f6
X-CR-MTA-TID: 64aa7808
Received: from dd3debd63a60.1 (cr-mta-lb-1.cr-mta-net [104.47.10.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 93E11345-17E2-48F0-A2AB-35C6EB4C1C3A.1;
        Thu, 14 Nov 2019 08:37:46 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2055.outbound.protection.outlook.com [104.47.10.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id dd3debd63a60.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 14 Nov 2019 08:37:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaTbobBjPYl1M+1N7VGauGIwbJptptuWTx3iMmqLpd7vgaWNnVKGnJcdeHMuATr08VJ0uqGtyvd+Wy2G0wA6bnpmj7sVbIwxDyd/e8ThFnrpShKraxW2X4Riq3G7JITSWZOMyWadEKQrHlpwmsAQuC64vvoNMUDbds9ytzUUKYOV5ROenLSFV8Fsrv1bDrwDB1XRRd2lx8WFyyndagcgtDtEPMKpsQ853S4XIBpdFnAnFZtjZlNX8tXbsw/SEB2R+HdfwTQk7Cw2Ti406SoYmitvQBhnAgUItXnW0NTixGsd+4T90zHux04C7rZA5X775xA5OyZ/B3ykfTsmR/skEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6+a5Psi7mCFZ/4vt4yM7Jk/O+MZAzQ5WNcQIh0wvKA=;
 b=gUShl2LaT2/iO9ZcfUllMbZWle+L8hXF2ArMb0NhVw1vHhL+G4RuXVPU7PCSsoLUlpMD+2BgC9PzvG0SB2EVvGqxYd83haw4EQ8tirWF9B+DNVMOX7z3tgp/AbTv9IbeB4TEzxNNcOf5JOda+pZPY4d5dTn/pis1F9+UKzgZ4JAlV1+dMnkd5+vdJsTlYp+JImUBs95csdqizvM/CtezgzwiN2kDAzCl3Lb9zWtne/3ofKUwkBfCrz7K7tDMh2ho8BDUHr7f+TEiR0Jv7E4XjJXviguo8kX1W78OeB3Y8CRpFuoJ7WHWrKSYHe40ED4T42h0shj4TdTmGreu9Nj6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6+a5Psi7mCFZ/4vt4yM7Jk/O+MZAzQ5WNcQIh0wvKA=;
 b=jlJb+NgWuAA+RGJY/eCb4GbyucGJT/0JIWHx+zdskEESUOmZd3rY+wJA4J/IrNuKIwUjC0anfAzrWQ0TMks5s7mahSyII+ma5zdb0nFtXN6ezZoXAl7skQ0Y6iu6x+q25UI+imthZ8oO2EnPPhfMwrUwQ+MSUKTOY1wkRL0ajXo=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4768.eurprd08.prod.outlook.com (10.255.114.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Thu, 14 Nov 2019 08:37:45 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 08:37:45 +0000
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
Subject: [PATCH v3 4/6] drm/komeda: Add side by side support for writeback
Thread-Topic: [PATCH v3 4/6] drm/komeda: Add side by side support for
 writeback
Thread-Index: AQHVmsbJAUP90/z/aUK+AT3UlbeKyQ==
Date:   Thu, 14 Nov 2019 08:37:45 +0000
Message-ID: <20191114083658.27237-5-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 30be2c36-b5a6-4d62-07ac-08d768ddf0c9
X-MS-TrafficTypeDiagnostic: VE1PR08MB4768:|VE1PR08MB4768:|AM6PR08MB3383:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB338359C5CDA9FFB91291F508B3710@AM6PR08MB3383.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:785;OLM:785;
x-forefront-prvs: 02213C82F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(136003)(39850400004)(189003)(199004)(71200400001)(71190400001)(36756003)(305945005)(2906002)(7736002)(110136005)(54906003)(6116002)(316002)(3846002)(99286004)(103116003)(446003)(11346002)(6486002)(8936002)(2616005)(476003)(6436002)(66476007)(66556008)(64756008)(66446008)(66946007)(478600001)(6512007)(50226002)(66066001)(486006)(14454004)(2501003)(5660300002)(76176011)(52116002)(256004)(14444005)(386003)(55236004)(25786009)(6636002)(102836004)(6506007)(8676002)(4326008)(26005)(81156014)(81166006)(1076003)(186003)(2201001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4768;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: oOY6FzM6hdZTUvcgfTojVJ5vEBWcT5yHj5U2wl/PvpK4XcPepIw40kZOZGqjuvmrwxCvPYo3c+UGBq1ui/VwcYhB7zaftNXQmG89+muH8AW7UrxP/5/r8ym88s+Zt6GyvUMhx94nJGoGGu7OgIW7CeokSAvYrHe7wHio0FKtGPU9wa6XBUjavhYg98s/aiSglYIFbZwbDtiWz8868fJUdBrrZ0FwgMqRj2qpP1TnimRscoEBDIR2ogvxD9R7k9Ld72UH0sRTK3Qw49Kf5sRnUqcuNhF65Y+Iy61WpKRvfBSVmQO+2fLtn1U9ruIb3k/KuOeUVgkb0aCKl/lf37MTnG9DtlLxaVFNP0qoClHZu4yn9/xR+IMr9Vk07TOgE4fI4/O/ACYir65tB29Z4qrST0/yKMDUCPy6Zbs/1nr9ROvZBKhTbgw58t7RL/HLf/EG
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4768
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(1110001)(339900001)(199004)(189003)(47776003)(1076003)(36756003)(103116003)(6486002)(70206006)(70586007)(26826003)(76130400001)(446003)(11346002)(478600001)(14454004)(105606002)(486006)(66066001)(23756003)(356004)(50466002)(5660300002)(25786009)(2616005)(476003)(126002)(54906003)(22756006)(102836004)(2201001)(2906002)(110136005)(6636002)(336012)(14444005)(6506007)(386003)(6116002)(3846002)(86362001)(76176011)(4326008)(316002)(2501003)(7736002)(36906005)(8676002)(6512007)(186003)(81166006)(81156014)(8746002)(8936002)(305945005)(50226002)(26005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3383;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 15078e7f-8e87-402d-ae93-08d768ddebc0
NoDisclaimer: True
X-Forefront-PRVS: 02213C82F8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDtR/mlR8mI+SitjmfNtiKafH2+v1DTNf9Px6CcSTVBBTFa387UKtO7JAqORAIG04+/yMRhb8YeIpNVmus0nqdd3V1B/Mvm+nOfgNQIJyEToAfLK3EPbRhqM/9BKgA1bjb63SQQ4aUP3OO+jXr6+AHW2bWaQJTw00NiZudYJ1eUv/I2CnFUv5sUDqxPX18GEBLvDebys/XtBXNrtu21BJQpboCSKkWNyAPo+Im5KIHrX6iMc6PCvox+QFqq8BOn/ihpCzGZM63z66uUcOKp2eSQuaWlzVKYea8HZd+k1lzZFOj7UK/iuiEoxJ23XsblQKnKXluupAB4uriwbLwwSftPxhhHZUO26h2pYRg+V15GpqQAQcEpnFQU2AXQ55279C47Z0sJA2H73hpSYm59/046eLdXjKzcGUoVHCBvtuz0uoWFsp0CKHAIPQapYyIEc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 08:37:53.1881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30be2c36-b5a6-4d62-07ac-08d768ddf0c9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3383
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
index 4dbf71455d1d..ab4d9ad79083 100644
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

