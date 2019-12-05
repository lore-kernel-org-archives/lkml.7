Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C90DC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CD521823
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9RHxkjtV";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9RHxkjtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfLEIgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:36:03 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:61603
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbfLEIgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/OhMdzAJRV+IRQdte4BkdgRPzZxlKwzEQRrhZRPdE0=;
 b=9RHxkjtVm0+QHXVWCB3Y4fYEhuhU0qkmwVzaV/snOjrMhQvhVV5FwZBCsOwd8uFHWGyrKkXc/OeLRnQZiWvRRoZcNN0zCMDCQ42zKBBCgOMmyhlTP3p8VGSTuNwlxZhDvtNsyQd5KSjv30Iq6KZJk3wqGqfkSx/7OprvODOyqj0=
Received: from DB6PR0802CA0038.eurprd08.prod.outlook.com (2603:10a6:4:a3::24)
 by VI1PR08MB3231.eurprd08.prod.outlook.com (2603:10a6:803:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.21; Thu, 5 Dec
 2019 08:35:57 +0000
Received: from DB5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by DB6PR0802CA0038.outlook.office365.com
 (2603:10a6:4:a3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Thu, 5 Dec 2019 08:35:57 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT043.mail.protection.outlook.com (10.152.20.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 5 Dec 2019 08:35:57 +0000
Received: ("Tessian outbound 58ad627f3883:v37"); Thu, 05 Dec 2019 08:35:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c41360b18cef0d76
X-CR-MTA-TID: 64aa7808
Received: from bf5a46e4d812.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6A5B37E9-B0A1-446B-96AF-988C67689BFD.1;
        Thu, 05 Dec 2019 08:35:52 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bf5a46e4d812.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Dec 2019 08:35:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhrLSmdnfEN75/OO2Ta1R4uciqBgyXqbGsrMUNRR/Igmdjg8Lt59uXZsO/zjIYOQqpxwZDO+4+UZzIrlWfD829q2MPLTeOfP7cBqmcteHEnBXHst0Zbnzx/H40ZM3x62dS8hYejOweCZDHxKAIhD1C0Y8WRgTvpWM1ZFtrrui/c1EbNjsuuSZtcTwuZ+FUn1yJh0Da+TTJSHrX7flWTIO9FaSgTHgiMSI4yPyV5OAAit9aLD9+wfUq49pgtGdSQeVy267+zMlI2mFZo0lI11Z3NMhegOlNmkJAyzw7/bbpFkl0/KcSwRK3HCmKg+vCbUg+ne8ItCszw0FlCODiRXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/OhMdzAJRV+IRQdte4BkdgRPzZxlKwzEQRrhZRPdE0=;
 b=jYSjyDg+pq/y9YbK7gJ2cwdJ7OLeRVET+RhTb2UJucucNdBtx4K+4PH74dTB5SjFeST8lgCxbU83+pIclNRrNJKsEY3ft0ccQQE4EWbE0dpmy80aqASqbYf1h636YcKI5og4E2UJritxT8oH8xnYh2TSD+gzKASY2X56WZg797m82M+DOBQmIhlKoXUnXe7t46eK0RhunJSilYGPOySJVh+keIL5ykKfQ8s50BzF8ii4m3xtkfExk1E+jqGBEN+n5qHGAgovH64e4kBcqhVxTqZaitFfiNiajpySgfaKXfhU0ztVPR6VvPNol1XrIkwVfiX4GCVOzMSGvZxCVvdBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/OhMdzAJRV+IRQdte4BkdgRPzZxlKwzEQRrhZRPdE0=;
 b=9RHxkjtVm0+QHXVWCB3Y4fYEhuhU0qkmwVzaV/snOjrMhQvhVV5FwZBCsOwd8uFHWGyrKkXc/OeLRnQZiWvRRoZcNN0zCMDCQ42zKBBCgOMmyhlTP3p8VGSTuNwlxZhDvtNsyQd5KSjv30Iq6KZJk3wqGqfkSx/7OprvODOyqj0=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 AM0SPR01MB0026.eurprd08.prod.outlook.com (52.135.152.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 08:35:46 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 08:35:46 +0000
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
Subject: [PATCH v5 2/5] drm/komeda: Add side by side plane_state split
Thread-Topic: [PATCH v5 2/5] drm/komeda: Add side by side plane_state split
Thread-Index: AQHVq0b9krcw3mF3h0STgmIBRWIhMA==
Date:   Thu, 5 Dec 2019 08:35:46 +0000
Message-ID: <20191205083436.11060-3-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0359bae5-4741-4623-3df1-08d7795e269b
X-MS-TrafficTypeDiagnostic: AM0SPR01MB0026:|AM0SPR01MB0026:|VI1PR08MB3231:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB323144330AF794BB85131A15B35C0@VI1PR08MB3231.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4502;OLM:4502;
x-forefront-prvs: 02426D11FE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(8676002)(5660300002)(71200400001)(71190400001)(7736002)(86362001)(305945005)(2906002)(316002)(36756003)(103116003)(50226002)(1076003)(81156014)(81166006)(30864003)(6862004)(8936002)(55236004)(6636002)(4326008)(99286004)(186003)(478600001)(11346002)(2616005)(102836004)(26005)(25786009)(76176011)(52116002)(14454004)(6506007)(66446008)(6116002)(54906003)(66946007)(66476007)(66556008)(64756008)(3846002)(37006003)(6436002)(6486002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB0026;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: scfnTR/llEvGg/E97bCKYR6sSzXTuVhvOkZrIRIFgLWLA/QAtO4ZbZbof1riVYqQWZ6plFilSpOK3qvL90PZtRO/vEqhSvqxaP6KFJ2JDrSGqCKVpG8c4TeDU1uJrMndHoQey1WVhUPu+UbwPFnS2s+yX4wfm+xg7GSJ/LLp2Jqjd2S1WDJHbhjVvKTDgL518ZAJ9QslxI5IoNbnw1/UBAINGpXkAPGjOM+IO/FZI4h/sYABxfmF4/cHuixD11dz6LJgeSPzvCYaO6MGH5Lc9cdrzfpgVfLjsvmR2FbuuGtECmOjA02NihZBQgz4/Ya6qSv5af6lZLv1UZvLH2Lzk/oxxNj7Xj5fwJWSg8o7EgqlCV6Cd0v2iXo+LXKBIzpUYcJG3Ts0GPGNJA+UEes+fCmhzypVMnZfn9OCvMbuJsiQqS4ivizXkngRm1O0ljPi
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0026
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(70586007)(1076003)(103116003)(54906003)(6116002)(4326008)(3846002)(2906002)(26826003)(86362001)(70206006)(36756003)(102836004)(25786009)(6862004)(30864003)(7736002)(305945005)(37006003)(478600001)(6636002)(26005)(6506007)(22756006)(76176011)(2616005)(356004)(8676002)(99286004)(81156014)(5660300002)(81166006)(23756003)(8746002)(76130400001)(8936002)(11346002)(50466002)(14454004)(336012)(6512007)(50226002)(186003)(316002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3231;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2e541917-d1df-449b-1ea4-08d7795e1fbc
NoDisclaimer: True
X-Forefront-PRVS: 02426D11FE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /sOBHjjknjiTDJ4tn75WeVS7sIqXGFWrsbz1fA5vopYzDeTBQxukRkVJG64DJNy6jwVyqlhAt2mivDy3b4HCpiAEXOpiWGwJX7iETLtWDeaBiPy/Nva8CNnoSkRsqISO1AjsKPlazTUJKIJtqJLs240m7+vCboUjAx+HFule72EqXWKIrhU28CLOLH4+Zthlm1ukFk+L/psc1PW8gAstpy6LorztUk6wLzmydfDZS69KNuL6u2Y106yDUxEzrDVTAg+PRan5eUJw/b9AoDLWz+V9iC/mAK6jVKAvKkyhShYs/wpRDMo3AvtVhRQzgEcunOVWBTNL2Kk3SchdwQJf5JLgMyTVhs9YbJT7VRjWHBEOiBOpMS+ZLMrd6GfB6ExG/zis/7x+65FPm3GAXolXe4y+jAodaGD7Tds8rxYxidlihGxSXg4QYaZyEDJd5IrP
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 08:35:57.7118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0359bae5-4741-4623-3df1-08d7795e269b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On side by side mode, The full display frame will be split into two parts
(Left/Right), and each part will be handled by a single pipeline separately
master pipeline for left part, slave for right.

To simplify the usage and implementation, komeda use the following scheme
to do the side by side split
1. The planes also have been grouped into two classes:
   master-planes and slave-planes.
2. The master plane can display its image on any location of the final/full
   display frame, komeda will help to split the plane configuration to two
   parts and fed them into master and slave pipelines.
3. The slave plane only can put its display rect on the right part of the
   final display frame, and its data is only can be fed into the slave
   pipeline.

From the perspective of resource usage and assignment:
The master plane can use the resources from the master pipeline and slave
pipeline both, but slave plane only can use the slave pipeline resources.

With such scheme, the usage of master planes are same as the none
side_by_side mode. user can easily skip the slave planes and no need to
consider side_by_side for them.

v4: Address Mihail's review comments.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/komeda/komeda_pipeline.h  |  33 ++-
 .../display/komeda/komeda_pipeline_state.c    | 188 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_plane.c |   7 +-
 3 files changed, 220 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 20a076cce635..4c0946fbaac1 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -521,6 +521,20 @@ komeda_component_pickup_output(struct komeda_component=
 *c, u32 avail_comps)
 	return komeda_pipeline_get_first_component(c->pipeline, avail_inputs);
 }
=20
+static inline const char *
+komeda_data_flow_msg(struct komeda_data_flow_cfg *config)
+{
+	static char str[128];
+
+	snprintf(str, sizeof(str),
+		 "rot: %x src[x/y:%d/%d, w/h:%d/%d] disp[x/y:%d/%d, w/h:%d/%d]",
+		 config->rot,
+		 config->in_x, config->in_y, config->in_w, config->in_h,
+		 config->out_x, config->out_y, config->out_w, config->out_h);
+
+	return str;
+}
+
 struct komeda_plane_state;
 struct komeda_crtc_state;
 struct komeda_crtc;
@@ -532,22 +546,27 @@ int komeda_build_layer_data_flow(struct komeda_layer =
*layer,
 				 struct komeda_plane_state *kplane_st,
 				 struct komeda_crtc_state *kcrtc_st,
 				 struct komeda_data_flow_cfg *dflow);
-int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
-			      struct drm_connector_state *conn_st,
-			      struct komeda_crtc_state *kcrtc_st,
-			      struct komeda_data_flow_cfg *dflow);
-int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
-				   struct komeda_crtc_state *kcrtc_st);
-
 int komeda_build_layer_split_data_flow(struct komeda_layer *left,
 				       struct komeda_plane_state *kplane_st,
 				       struct komeda_crtc_state *kcrtc_st,
 				       struct komeda_data_flow_cfg *dflow);
+int komeda_build_layer_sbs_data_flow(struct komeda_layer *layer,
+				     struct komeda_plane_state *kplane_st,
+				     struct komeda_crtc_state *kcrtc_st,
+				     struct komeda_data_flow_cfg *dflow);
+
+int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
+			      struct drm_connector_state *conn_st,
+			      struct komeda_crtc_state *kcrtc_st,
+			      struct komeda_data_flow_cfg *dflow);
 int komeda_build_wb_split_data_flow(struct komeda_layer *wb_layer,
 				    struct drm_connector_state *conn_st,
 				    struct komeda_crtc_state *kcrtc_st,
 				    struct komeda_data_flow_cfg *dflow);
=20
+int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
+				   struct komeda_crtc_state *kcrtc_st);
+
 int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
 				       struct komeda_crtc_state *kcrtc_st);
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 0930234abb9d..10a0dc9291b8 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -1130,6 +1130,194 @@ int komeda_build_layer_split_data_flow(struct komed=
a_layer *left,
 	return err;
 }
=20
+/* split func will split configuration of master plane to two layer data
+ * flows, which will be fed into master and slave pipeline then.
+ * NOTE: @m_dflow is first used as input argument to pass the configuratio=
n of
+ *	 master_plane. when the split is done, @*m_dflow @*s_dflow are the
+ *	 output data flow for pipeline.
+ */
+static int
+komeda_split_sbs_master_data_flow(struct komeda_crtc_state *kcrtc_st,
+				  struct komeda_data_flow_cfg **m_dflow,
+				  struct komeda_data_flow_cfg **s_dflow)
+{
+	struct komeda_data_flow_cfg *master =3D *m_dflow;
+	struct komeda_data_flow_cfg *slave =3D *s_dflow;
+	u32 disp_end =3D master->out_x + master->out_w;
+	u16 boundary;
+
+	pipeline_composition_size(kcrtc_st, &boundary, NULL);
+
+	if (disp_end <=3D boundary) {
+		/* the master viewport only located in master side, no need
+		 * slave anymore
+		 */
+		*s_dflow =3D NULL;
+	} else if ((master->out_x < boundary) && (disp_end > boundary)) {
+		/* the master viewport across two pipelines, split it */
+		bool flip_h =3D has_flip_h(master->rot);
+		bool r90  =3D drm_rotation_90_or_270(master->rot);
+		u32 src_x =3D master->in_x;
+		u32 src_y =3D master->in_y;
+		u32 src_w =3D master->in_w;
+		u32 src_h =3D master->in_h;
+
+		if (master->en_scaling || master->en_img_enhancement) {
+			DRM_DEBUG_ATOMIC("sbs doesn't support to split a scaling image.\n");
+			return -EINVAL;
+		}
+
+		memcpy(slave, master, sizeof(*master));
+
+		/* master for left part of display, slave for the right part */
+		/* split the disp_rect */
+		master->out_w =3D boundary - master->out_x;
+		slave->out_w  =3D disp_end - boundary;
+		slave->out_x  =3D 0;
+
+		if (r90) {
+			master->in_h =3D master->out_w;
+			slave->in_h =3D slave->out_w;
+
+			if (flip_h)
+				master->in_y =3D src_y + src_h - master->in_h;
+			else
+				slave->in_y =3D src_y + src_h - slave->in_h;
+		} else {
+			master->in_w =3D master->out_w;
+			slave->in_w =3D slave->out_w;
+
+			/* on flip_h, the left display content from the right-source */
+			if (flip_h)
+				master->in_x =3D src_x + src_w - master->in_w;
+			else
+				slave->in_x =3D src_x + src_w - slave->in_w;
+		}
+	} else if (master->out_x >=3D boundary) {
+		/* disp_rect only locate in right part, move the dflow to slave */
+		master->out_x -=3D boundary;
+		*s_dflow =3D master;
+		*m_dflow =3D NULL;
+	}
+
+	return 0;
+}
+
+static int
+komeda_split_sbs_slave_data_flow(struct komeda_crtc_state *kcrtc_st,
+				 struct komeda_data_flow_cfg *slave)
+{
+	u16 boundary;
+
+	pipeline_composition_size(kcrtc_st, &boundary, NULL);
+
+	if (slave->out_x < boundary) {
+		DRM_DEBUG_ATOMIC("SBS Slave plane is only allowed to configure the right=
 part frame.\n");
+		return -EINVAL;
+	}
+
+	/* slave->disp_rect locate in the right part */
+	slave->out_x -=3D boundary;
+
+	return 0;
+}
+
+/* On side by side mode, The full display frame will be split to two parts
+ * (Left/Right), and each part will be handled by a single pipeline separa=
tely,
+ * master pipeline for left part, slave for right.
+ *
+ * To simplify the usage and implementation, komeda use the following sche=
me
+ * to do the side by side split
+ * 1. The planes also have been grouped into two classes:
+ *    master-planes and slave-planes.
+ * 2. The master plane can display its image on any location of the final/=
full
+ *    display frame, komeda will help to split the plane configuration to =
two
+ *    parts and fed them into master and slave pipelines.
+ * 3. The slave plane only can put its display rect on the right part of t=
he
+ *    final display frame, and its data is only can be fed into the slave
+ *    pipeline.
+ *
+ * From the perspective of resource usage and assignment:
+ * The master plane can use the resources from the master pipeline and sla=
ve
+ * pipeline both, but slave plane only can use the slave pipeline resource=
s.
+ *
+ * With such scheme, the usage of master planes are same as the none
+ * side_by_side mode. user can easily skip the slave planes and no need to
+ * consider side_by_side for them.
+ *
+ * NOTE: side_by_side split is occurred on pipeline level which split the =
plane
+ *	 data flow into pipelines, but the layer split is a pipeline
+ *	 internal split which splits the data flow into pipeline layers.
+ *	 So komeda still supports to apply a further layer split to the sbs
+ *	 split data flow.
+ */
+int komeda_build_layer_sbs_data_flow(struct komeda_layer *layer,
+				     struct komeda_plane_state *kplane_st,
+				     struct komeda_crtc_state *kcrtc_st,
+				     struct komeda_data_flow_cfg *dflow)
+{
+	struct komeda_crtc *kcrtc =3D to_kcrtc(kcrtc_st->base.crtc);
+	struct drm_plane *plane =3D kplane_st->base.plane;
+	struct komeda_data_flow_cfg temp, *master_dflow, *slave_dflow;
+	struct komeda_layer *master, *slave;
+	bool master_plane =3D layer->base.pipeline =3D=3D kcrtc->master;
+	int err;
+
+	DRM_DEBUG_ATOMIC("SBS prepare %s-[PLANE:%d:%s]: %s.\n",
+			 master_plane ? "Master" : "Slave",
+			 plane->base.id, plane->name,
+			 komeda_data_flow_msg(dflow));
+
+	if (master_plane) {
+		master =3D layer;
+		slave =3D layer->sbs_slave;
+		master_dflow =3D dflow;
+		slave_dflow  =3D &temp;
+		err =3D komeda_split_sbs_master_data_flow(kcrtc_st,
+				&master_dflow, &slave_dflow);
+	} else {
+		master =3D NULL;
+		slave =3D layer;
+		master_dflow =3D NULL;
+		slave_dflow =3D dflow;
+		err =3D komeda_split_sbs_slave_data_flow(kcrtc_st, slave_dflow);
+	}
+
+	if (err)
+		return err;
+
+	if (master_dflow) {
+		DRM_DEBUG_ATOMIC("SBS Master-%s assigned: %s\n",
+			master->base.name, komeda_data_flow_msg(master_dflow));
+
+		if (master_dflow->en_split)
+			err =3D komeda_build_layer_split_data_flow(master,
+					kplane_st, kcrtc_st, master_dflow);
+		else
+			err =3D komeda_build_layer_data_flow(master,
+					kplane_st, kcrtc_st, master_dflow);
+
+		if (err)
+			return err;
+	}
+
+	if (slave_dflow) {
+		DRM_DEBUG_ATOMIC("SBS Slave-%s assigned: %s\n",
+			slave->base.name, komeda_data_flow_msg(slave_dflow));
+
+		if (slave_dflow->en_split)
+			err =3D komeda_build_layer_split_data_flow(slave,
+					kplane_st, kcrtc_st, slave_dflow);
+		else
+			err =3D komeda_build_layer_data_flow(slave,
+					kplane_st, kcrtc_st, slave_dflow);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /* writeback data path: compiz -> scaler -> wb_layer -> memory */
 int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
 			      struct drm_connector_state *conn_st,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_plane.c
index 98e915e325dd..2644f0727570 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -77,6 +77,7 @@ komeda_plane_atomic_check(struct drm_plane *plane,
 	struct komeda_plane_state *kplane_st =3D to_kplane_st(state);
 	struct komeda_layer *layer =3D kplane->layer;
 	struct drm_crtc_state *crtc_st;
+	struct komeda_crtc *kcrtc;
 	struct komeda_crtc_state *kcrtc_st;
 	struct komeda_data_flow_cfg dflow;
 	int err;
@@ -94,13 +95,17 @@ komeda_plane_atomic_check(struct drm_plane *plane,
 	if (!crtc_st->active)
 		return 0;
=20
+	kcrtc =3D to_kcrtc(crtc_st->crtc);
 	kcrtc_st =3D to_kcrtc_st(crtc_st);
=20
 	err =3D komeda_plane_init_data_flow(state, kcrtc_st, &dflow);
 	if (err)
 		return err;
=20
-	if (dflow.en_split)
+	if (kcrtc->side_by_side)
+		err =3D komeda_build_layer_sbs_data_flow(layer,
+				kplane_st, kcrtc_st, &dflow);
+	else if (dflow.en_split)
 		err =3D komeda_build_layer_split_data_flow(layer,
 				kplane_st, kcrtc_st, &dflow);
 	else
--=20
2.20.1

