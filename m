Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C20C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55980206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="r+XbWb5c";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="r+XbWb5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfLEIgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:36:13 -0500
Received: from mail-eopbgr130047.outbound.protection.outlook.com ([40.107.13.47]:6574
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729030AbfLEIgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYH3lh3p96aYyG0U7lY8+jPIWzUDqW/V2y01c6fakes=;
 b=r+XbWb5cpMHMW/6aubrULSjUUtmAEKqThXyCOR/IfnbbvCuptm/WgAr+tJAVK5KMTOgnvzZqPMFePQ/AtCvGW+fJngFWNuZlQPqLO3c2FgdgABDeP+LFSkKxEUhKvGgLlQQBL1/PxfKpG4rSG+PjXipmUdA0vrO3WoJRAWhZHY0=
Received: from VI1PR0802CA0007.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::17) by AM4PR08MB2643.eurprd08.prod.outlook.com
 (2603:10a6:205:5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20; Thu, 5 Dec
 2019 08:36:05 +0000
Received: from DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by VI1PR0802CA0007.outlook.office365.com
 (2603:10a6:800:aa::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Thu, 5 Dec 2019 08:36:04 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT041.mail.protection.outlook.com (10.152.21.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 5 Dec 2019 08:36:04 +0000
Received: ("Tessian outbound d87d9aeb44be:v37"); Thu, 05 Dec 2019 08:36:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ee81c2a020172c2c
X-CR-MTA-TID: 64aa7808
Received: from e035e4a146e2.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9916CFFB-3814-4ED9-A464-FA45E4458BD8.1;
        Thu, 05 Dec 2019 08:35:59 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e035e4a146e2.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Dec 2019 08:35:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7UPgwn6nOxJ+ahKldlVvYA5y2WHTln6jQgfxv7rgw/j83LPocka6S6z/VcZvt0VDvU7gKHM/ZCpWjtmQSxsTf6H5gGuPQ9hOGBBlOSJqz2XqQsBd9/KRwvwLwNDXYQ7Awzu0W6oihD91NIXnhAa/ic/vj0hQh+WuDJtuFZ9gjJuEH9XSB/iqUEhwWbDvjKOYNCujV8/U/4K5Yc30ZK70OnNqzfD9DuOVjU4ToEZnRInaN3vd9VrhbFF8NiJA68ApmBy/XWA/r+zOs7S8FBPNLKRIEp0UNF6ZxCay67wnNM+gczCS41AFqewuO0CZiTM0/0qcFn5bHGhmZ0IIedBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYH3lh3p96aYyG0U7lY8+jPIWzUDqW/V2y01c6fakes=;
 b=lBtPaweMuerNYJWHNbkgDe9TgO94q+aI/KTAx0tWNCuukbr1G6+o1abahY+Vrg85oJ1e/5ZSXlC2hVwfrlx9dI1De26iazhrRGG3EUuLXnvus7fj1NPINZ+lVef1UXav0wRZK64aklWQYtcuJLu6qHAZbL3JvqORElIdt4fVhuwiSFzLqdTgmSeTq8n0LAlAhoHBvpV64Q6ZuNO/NGlUbbBBImF8kth/LE+G2m/JANDCNeCT+dt5Tnk5znlOyGN7XKshZ/SXZqxRY+7IJKkluc4BcHfhd0R82lDOTp9Ajy79OLhes3/8waFO3aDxZsk1/9TFrLYC2gyE6KDXW5hrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYH3lh3p96aYyG0U7lY8+jPIWzUDqW/V2y01c6fakes=;
 b=r+XbWb5cpMHMW/6aubrULSjUUtmAEKqThXyCOR/IfnbbvCuptm/WgAr+tJAVK5KMTOgnvzZqPMFePQ/AtCvGW+fJngFWNuZlQPqLO3c2FgdgABDeP+LFSkKxEUhKvGgLlQQBL1/PxfKpG4rSG+PjXipmUdA0vrO3WoJRAWhZHY0=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 AM0SPR01MB0026.eurprd08.prod.outlook.com (52.135.152.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 08:35:55 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 08:35:55 +0000
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
Subject: [PATCH v5 4/5] drm/komeda: Add side by side support for writeback
Thread-Topic: [PATCH v5 4/5] drm/komeda: Add side by side support for
 writeback
Thread-Index: AQHVq0cCwYnEST8nokauTus8cyAHmQ==
Date:   Thu, 5 Dec 2019 08:35:55 +0000
Message-ID: <20191205083436.11060-5-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59bfdae8-1848-4377-797e-08d7795e2ad0
X-MS-TrafficTypeDiagnostic: AM0SPR01MB0026:|AM0SPR01MB0026:|AM4PR08MB2643:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM4PR08MB264358179589E8075ED23A60B35C0@AM4PR08MB2643.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:785;OLM:785;
x-forefront-prvs: 02426D11FE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(8676002)(5660300002)(71200400001)(71190400001)(7736002)(86362001)(305945005)(2906002)(316002)(36756003)(103116003)(50226002)(1076003)(81156014)(81166006)(6862004)(8936002)(55236004)(6636002)(4326008)(99286004)(186003)(478600001)(11346002)(2616005)(102836004)(26005)(25786009)(76176011)(52116002)(14454004)(6506007)(66446008)(6116002)(54906003)(66946007)(66476007)(66556008)(64756008)(3846002)(37006003)(6436002)(14444005)(6486002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB0026;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8iZeN2qZ8e1Ehz+eMP6Rd0b1cJ5DOk2IG7CJHjvEzSpMAsrJSY+5onI/AOoipevIbjHo2alyXw4N6DL8yC4aN+DBtiH1l4dG+ifLo3x463arq19D8kjQPWnrqxcWSHPjaRyuGzSYzxLzFZgb3f+WlRZsGWsvhf7e5Q47MWl7C15LCEn1BYkRWfnvD7fZG6vYlgf6h0/VhpgUoRf3r6sjiKJEDcHYupySzhz6ezx4pycUHEYAg0VlQU6EbXvDvxERT7YjN1onEW0WgqEc1Y8zgjgtBxQn+Bpc66ur+2Gp6F11o+FrcCDUS8j6Ijc6w1mhKzhfdqTLwj69i+sbFQUWOZFzFzIqnyrAH0uSLL/DrtsSU0EqP8r7nyTuqQY8Ak0njc1NMf1Dqm4KioKkFCcEwBSZUsGkxmxJFPy7w6fjAA9IuSi8kjOqh6UginqNVfjb
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0026
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(8746002)(50226002)(8936002)(81166006)(81156014)(7736002)(50466002)(6486002)(8676002)(305945005)(14444005)(76176011)(5660300002)(4326008)(2906002)(6636002)(22756006)(6512007)(3846002)(23756003)(86362001)(6116002)(6862004)(37006003)(14454004)(103116003)(25786009)(99286004)(6506007)(102836004)(478600001)(26826003)(316002)(54906003)(11346002)(186003)(70206006)(76130400001)(356004)(70586007)(2616005)(336012)(36756003)(26005)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR08MB2643;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e05dc87b-06e6-4169-392e-08d7795e2500
NoDisclaimer: True
X-Forefront-PRVS: 02426D11FE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4cMN2gI2udFQwrQF6zLJURmBiAWs/Ji89d8fu9wa42Z8e2UzHulzvp+JlED99OP5eB5DL6uD+7Ux+NzImodF/BA+H10HvjnzRsuUWUa7apk2R/7gH6rdkRZoZ8JG9JjzA0BjC6/O6g2MlOFE1+U8BZKiWWDrG0oR08YvXZCgGMLpqZ5Hh/DESTTr4sg5CArIHAhNHsGzCiG9zeHG5drtP2dFsrGRFpqZlkGjHns6YUUXgMRScBxM1biwnlRkH5gUCgbniyBV1+loIcE2HPrZ+g5SHO4KgeaIQ3E2neKR338oWc4ljSrwYEZcFHKcNKZ4oS76ASCxrE2fdn/qjPQ+g8n+rY21aSu2XpmlDmrTkcc6oI7gG1HCgGQG6D/qfxFQvoXHI1VR8SSsgklTXVMDNoLOrZ5pPpBMjG+PUnDnpLkLauqYCsVxahf04b05mgp
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 08:36:04.6385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bfdae8-1848-4377-797e-08d7795e2ad0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2643
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

