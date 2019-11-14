Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E783C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36132070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gYULTnwe";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gYULTnwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfKNIht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:37:49 -0500
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:49600
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726598AbfKNIhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXaZQA7UF04Za11ENfBrPY7rcZqwyDjhxx+VWI/tpIc=;
 b=gYULTnweHQemebVjJv7hheJGrTqfS70mKuVwllTVv8e1Y8sJTkSdW02Va0GqhSHzZn6YUqjASQjuOpUUrndjpOWQz3K2Lk0V+v9fTOTToSR/Rk9yRPwM6mxJiq4H3TMw19o6tEDgVZgZZzNwtX6bNcVbfUzIypqkU/5gV8zAH60=
Received: from AM6PR08CA0043.eurprd08.prod.outlook.com (2603:10a6:20b:c0::31)
 by AM0PR08MB5010.eurprd08.prod.outlook.com (2603:10a6:208:15c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Thu, 14 Nov
 2019 08:37:42 +0000
Received: from DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by AM6PR08CA0043.outlook.office365.com
 (2603:10a6:20b:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Thu, 14 Nov 2019 08:37:42 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT056.mail.protection.outlook.com (10.152.21.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2451.23 via Frontend Transport; Thu, 14 Nov 2019 08:37:42 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Thu, 14 Nov 2019 08:37:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f5177b4959325318
X-CR-MTA-TID: 64aa7808
Received: from 8070f748806f.2 (cr-mta-lb-1.cr-mta-net [104.47.10.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 406F1985-65D6-4018-92A5-055851AC78B8.1;
        Thu, 14 Nov 2019 08:37:35 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2054.outbound.protection.outlook.com [104.47.10.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8070f748806f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 14 Nov 2019 08:37:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AczfD67exZWKdOPNUrUwO4/oB92Y6mFzuUf43DzAquaKROmZL7VAHeHSJFDWZ2g4MDpYfCmgeY9q1ZqrSx8A/4GKYLV57Wx6k+AtRNWwNA/ZfKExjCBO0o21lcKgV6NWHImfdSmKg2UXKtYga76EhGrOqGEC5qa9evqEDhiV/RpPtMfmhrxc9jbWsufPIgeSMo3sSHi3dMZX97ZlaQ9ErBdtDCNJZ0a8vmSMkrQcPv9B5PNSend5mqp411Ydonl63J2of5ZiTad7DzUu37phOMAG7tOCDb3RhxHinqPycHUNTKhkP2HQwz1FJB2iaZOj32oVDuYzmY9Yzbc/fOMiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXaZQA7UF04Za11ENfBrPY7rcZqwyDjhxx+VWI/tpIc=;
 b=gLfy6m8ymXoGkQAo//NNZw5Tvu13kZfeOUkFo30eJAgV3bfkoVr/YTz0/bYEP2NPVwOHMSeOZvLpOVUYFCVYJ8/h4bGoOaSvhbCbPKLG6eJbz5yHLcZ3f1ZWT1p3tzKUr0wcxPqhUJyskW6pHTUO2tWlR1jkrQ+KYKYezl2o7ADSSFjSOcqtcZieVDJ4W37XwUcxLEV7IAm1891ceHzQQ+pUlS5d4pnLT7Nk07wI2zZSL67Y1NEy107Nhgv/b3UYluByp3vCk7DyuQwuY11eBz2F0zGXfNF9os1SdduBaQYlwN7x7DkXpntRBU7xQCidKXesXzJNwWaJq7xVgCYvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXaZQA7UF04Za11ENfBrPY7rcZqwyDjhxx+VWI/tpIc=;
 b=gYULTnweHQemebVjJv7hheJGrTqfS70mKuVwllTVv8e1Y8sJTkSdW02Va0GqhSHzZn6YUqjASQjuOpUUrndjpOWQz3K2Lk0V+v9fTOTToSR/Rk9yRPwM6mxJiq4H3TMw19o6tEDgVZgZZzNwtX6bNcVbfUzIypqkU/5gV8zAH60=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4768.eurprd08.prod.outlook.com (10.255.114.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Thu, 14 Nov 2019 08:37:31 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 08:37:31 +0000
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
Subject: [PATCH v3 2/6] drm/komeda: Add side by side plane_state split
Thread-Topic: [PATCH v3 2/6] drm/komeda: Add side by side plane_state split
Thread-Index: AQHVmsbB0qq5bjF9AkuUGZwZ2Z2ZNw==
Date:   Thu, 14 Nov 2019 08:37:31 +0000
Message-ID: <20191114083658.27237-3-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 70bc92f7-2c2a-4f9f-c53f-08d768ddea37
X-MS-TrafficTypeDiagnostic: VE1PR08MB4768:|VE1PR08MB4768:|AM0PR08MB5010:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5010BEF3E9B9E48B9D41B2FEB3710@AM0PR08MB5010.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4502;OLM:4502;
x-forefront-prvs: 02213C82F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(376002)(346002)(396003)(136003)(39850400004)(189003)(199004)(71200400001)(71190400001)(36756003)(305945005)(2906002)(7736002)(110136005)(54906003)(6116002)(316002)(3846002)(99286004)(103116003)(446003)(11346002)(30864003)(6486002)(8936002)(2616005)(476003)(6436002)(66476007)(66556008)(64756008)(66446008)(66946007)(478600001)(6512007)(50226002)(66066001)(486006)(14454004)(2501003)(5660300002)(76176011)(52116002)(256004)(386003)(55236004)(25786009)(6636002)(102836004)(6506007)(8676002)(4326008)(26005)(81156014)(81166006)(1076003)(186003)(2201001)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4768;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Z2UwdOGojHSTDCvTrwp1qcy7dVgiuMy2E5Xn4ei4byl7h5pqh3P96T1/FbWhc5QSbauUyamwJJrUdyTxWyyy0QmnCnweQZlRLl0KBv051s9dpel15frWxe3hiFuDuELNsOvcqGi95xvaNfAeCk9hk7l/kh24jbJpgZO2wPEN/M53WvTyzEr2FppakikI4CwgML1Xjuh1gdUq5EVbBmclqQ2C1k25q/jRVMIo+ofE+xTCnYgCrhfDZSseSExCrJco/w0QtxKyFDPxSixsABp3YkZ8XcUy0iAcUIFBkvkL0Q+MkKsVbgqk0sZ0FqSF+bfUSy5WUfBe/TEgI4+il7mxeY85ok7guN8DPmlEJ2XDZBqLLNNWRq4ZXnzeQdHblvZkivfCswSMf5iEiAx3B2l5lLvQP2wg8TzSl9QhJeCae/YPggjmd/l5nlo3PaBm3h8e
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4768
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(136003)(346002)(39850400004)(396003)(1110001)(339900001)(199004)(189003)(316002)(23756003)(99286004)(76176011)(30864003)(25786009)(6636002)(6512007)(1076003)(8676002)(3846002)(7736002)(356004)(305945005)(486006)(6506007)(47776003)(386003)(186003)(110136005)(6116002)(66066001)(26005)(102836004)(76130400001)(2906002)(54906003)(5660300002)(6486002)(105606002)(70206006)(70586007)(4326008)(2201001)(36756003)(50226002)(11346002)(103116003)(126002)(14454004)(50466002)(22756006)(446003)(2501003)(476003)(478600001)(26826003)(81156014)(8746002)(336012)(86362001)(8936002)(81166006)(2616005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5010;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 914ebf95-08d9-4411-4c53-08d768dde3b7
NoDisclaimer: True
X-Forefront-PRVS: 02213C82F8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BV7kLuwOnae+eaqpMhZnq0s9XFwvbckFovKvFsC5BQGxJDjxggu/7RwZvhJX3OxDkbTUsXgsl0Qt31Dh5xBJMdA9SX/qkSbYnm48D6eK3wzGteR+ITk8TO2Ug8FThyJsk4ds2zVb/vZUCdE9AuwgQzPZxGI6FQ4S2sjKUJxsG69qHx0E8HHM1PiQmPnsOg1COaEkeOXmGrPNRo/iJ3j/YOj5E1SWRnbyMPyVss0n0p5PeKbe8zrYJHEIQAPK3ry0whj6ucm1nGVc/Ifz+xayt47cQeZuHvokIgEs+6D5fLt0vLtsjrxtXoI5DGdn8qXcxEG1flSpX5iHb2oyuPbMdF/NRDM4bUZCuYRtMAwhYfnYeUWg/ms8LWLsPxKa85+scbiu3jX/Mnat2gaUEzEpcNVulMQJVxTmnHUWPXv/R0t33QhVxhR6hPPxSedWTYh
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 08:37:42.2038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bc92f7-2c2a-4f9f-c53f-08d768ddea37
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5010
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
index 0930234abb9d..5de0d231a1c3 100644
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
+				master->in_x =3D src_w + src_x - master->in_w;
+			else
+				slave->in_x =3D src_w + src_x - slave->in_w;
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

