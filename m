Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D2AC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAE12196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="05N3VmuW";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="05N3VmuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfJKFnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:43:47 -0400
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:11086
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfJKFnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIUGSIoTFS+rG3rkaZCUgjh5FrULV5M3gll9vYVFpDA=;
 b=05N3VmuW+BombtrDyRihPLhEnlvcAczbMfb1pYkQl8FtawDe5qt6y2jMWDJpy2OqMOkMEAufwzaIj4qTniauVD3kSXoF4iOJDGEPxckohcoXDbl8/Kq9oXzhvyh1y2odxpWJ7LG/+9ClNQJUtYgqldCgtgUGOE6E3iA+b3F22es=
Received: from AM6PR08CA0027.eurprd08.prod.outlook.com (2603:10a6:20b:c0::15)
 by VI1PR08MB4335.eurprd08.prod.outlook.com (2603:10a6:803:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Fri, 11 Oct
 2019 05:43:39 +0000
Received: from AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by AM6PR08CA0027.outlook.office365.com
 (2603:10a6:20b:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 11 Oct 2019 05:43:39 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT043.mail.protection.outlook.com (10.152.17.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 05:43:37 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Fri, 11 Oct 2019 05:43:37 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ee808d8164c2722d
X-CR-MTA-TID: 64aa7808
Received: from fd5ed3b62776.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 85D9C0D8-A6AC-4F39-B690-BF3B8484CAA7.1;
        Fri, 11 Oct 2019 05:43:32 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fd5ed3b62776.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 11 Oct 2019 05:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQSVksWfi2JHOMnjim9q4tKncJYJoXJI0DSogRbWMxu0bDHghaRZ8f0ECvra9IQVkK1195GL9fAq8AeiblQkzhEeiEjT2O6VyFCAFHpxVYhgEqJ55q3EuZ20z6wVFF5EZjZd2aw4dzFFmlnEGL1Sr3FXu8mcoQOVEyo3zmeUZUBeFCxqFgp+bxWZSdCDKq2j2CSqxKq+QtzcDQNmnf+1eqjza/twgUu1mqTwr1hFlXEdh6jDmHzLNu72JiyUIuqNFx9nE0slLAXCoy7NH3uDsl6PnHDCxDPxgID5PT9GjgHLMUQrVtRd8bNQOoMb9rAqgz5pgc1apMSMzdJBDRgrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIUGSIoTFS+rG3rkaZCUgjh5FrULV5M3gll9vYVFpDA=;
 b=Ch58dwjpx9SKzbln/LfMGrzzd0obdXcpr1BT4Ho2aNxmmgCrgFFehURz6CiWurm/uLBVpJSCKhPoJrW6GCwb+Vd+kmzJS0nipj8FpoNc0664RRILHUDN5oEt0cNMQQdBC0BV8eCqU3QIjGIUzrX/RNxjOBiBaY2p5rdAHO0t4SMyRQ9eZHPJsCe49N+dWziflfzjAALbQYDtC058Qk2+Ysr48vMpU5A6MnFO8k9jcZwCjmLB4virhINYRNc+yjvnBEF+t/qn2v+ZNMj5Eb3X8mepkpsOxuofr/+FpnSmgPuFBxY5jStMF2eUDhPVuSQcglmDM+tpIcwDDK/02w8igg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIUGSIoTFS+rG3rkaZCUgjh5FrULV5M3gll9vYVFpDA=;
 b=05N3VmuW+BombtrDyRihPLhEnlvcAczbMfb1pYkQl8FtawDe5qt6y2jMWDJpy2OqMOkMEAufwzaIj4qTniauVD3kSXoF4iOJDGEPxckohcoXDbl8/Kq9oXzhvyh1y2odxpWJ7LG/+9ClNQJUtYgqldCgtgUGOE6E3iA+b3F22es=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5134.eurprd08.prod.outlook.com (10.255.158.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 05:43:30 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 05:43:30 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>
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
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Subject: [PATCH v2 4/4] drm/komeda: Adds gamma and color-transform support for
 DOU-IPS
Thread-Topic: [PATCH v2 4/4] drm/komeda: Adds gamma and color-transform
 support for DOU-IPS
Thread-Index: AQHVf/bQ8wvdbeg7lUSqVOfgqlbTpA==
Date:   Fri, 11 Oct 2019 05:43:30 +0000
Message-ID: <20191011054240.17782-5-james.qian.wang@arm.com>
References: <20191011054240.17782-1-james.qian.wang@arm.com>
In-Reply-To: <20191011054240.17782-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::15) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 1c311ca5-2ec7-43da-15aa-08d74e0df707
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5134:|VE1PR08MB5134:|VI1PR08MB4335:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB43357F53031229FE7F1279C6B3970@VI1PR08MB4335.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2958;OLM:2958;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(189003)(199004)(66066001)(486006)(386003)(6506007)(64756008)(99286004)(50226002)(52116002)(81156014)(6486002)(8936002)(81166006)(66946007)(102836004)(8676002)(305945005)(55236004)(26005)(66476007)(71200400001)(6116002)(3846002)(66556008)(6436002)(71190400001)(7736002)(76176011)(36756003)(186003)(2906002)(256004)(476003)(6512007)(2616005)(14444005)(66446008)(446003)(11346002)(54906003)(25786009)(14454004)(2501003)(103116003)(110136005)(316002)(4326008)(5660300002)(86362001)(478600001)(2201001)(1076003)(2171002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5134;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9PNdl4Zbz5TBG3FnTm+9TJrSG3EWK4iMTxGY97c3vAhN7iFLvVmEhtUtqjbyfdRJvzrqg+2Jz7nYJWeyg1f8WC8unT6wOKFjGlKPJw2OGnCAKseIC6rjCRxe2UUE+CvYwWWIm8l08zYzUOTdMQmmXvbS9vCZu4zqEcNmx2xKqo+R0KT2IJsImef3NPgvJNAbi9hXvkI9ZTMx5EqPDUp4coLNtMb9OMkag46p+6P4cOQtbx6AVf+Hrs+OooYc8ypGF0LUcg897wTAoQpfz5HxtcMRdLHcdP1a6PsvYEiaHWNLoArACadq3hnyFLAqTruyv6U9z/scVRt+jH5g/QJcipp7twQMrgkCJTaeTFZj1QnE0OEau5Z1IMNth+2dBuITB2imvKZi36rJruA20YqHLJXkofUurSbPAwS/RLd76UA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5134
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(1076003)(26826003)(7736002)(14454004)(54906003)(110136005)(186003)(26005)(63350400001)(102836004)(305945005)(36906005)(36756003)(316002)(478600001)(4326008)(2171002)(25786009)(5660300002)(23756003)(14444005)(22756006)(76130400001)(6512007)(103116003)(47776003)(2906002)(70206006)(66066001)(50466002)(50226002)(99286004)(8676002)(8746002)(8936002)(81156014)(386003)(6506007)(336012)(6116002)(11346002)(356004)(76176011)(86362001)(6486002)(486006)(2201001)(2616005)(476003)(126002)(3846002)(2501003)(81166006)(446003)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4335;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2a6ceaf6-f21c-4bac-99d7-08d74e0df26e
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9KEUcod+K2WlHVUSoS3xUae4ANeXv+LfIQpPdNaEKtKG/hok9q2NtbY4I6jiDNFqBUWB7jbJk7OrEVWEKNfsEjVTziXjgCTRn+cyy3TdwuLLaa2JIUD0l4sSlbGwx+ZRo31pBOwaIf2pZi/Tg5HS42j3LZudsqeXb8pGRSPrEbqgV4UUNUl7jTDmZbO1UurGCF2vwG2ViX24kBmRFBylaVfN+DAj/cjTsBatmHYoz6dYrsQ4imiFJkTcf8a7loL0pNu6NfN6FySfpnVQrUWjDMHonit4RU6Lp31URKp4kmJBSczgl/9P6Q/LEUTN+SLEyIVcZH1e5gXN5EDyoqY1+TacxMXrcOk6p/Gn5WY7GJ+3NaoOReZxJgLbRpmHiJeCIpU/yRLHhfm4SkpRxkPpTxgTBQZM5VTG+qY1pe7l7M=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 05:43:37.9300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c311ca5-2ec7-43da-15aa-08d74e0df707
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>

Adds gamma and color-transform support for DOU-IPS.
Adds two caps members fgamma_coeffs and ctm_coeffs to komeda_improc_state.
If color management changed, set gamma and color-transform accordingly.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../arm/display/komeda/d71/d71_component.c    | 24 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 ++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +++
 .../display/komeda/komeda_pipeline_state.c    |  6 +++++
 4 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index c3d29c0b051b..e7e5a8e4430e 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -942,15 +942,39 @@ static int d71_merger_init(struct d71_dev *d71,
 static void d71_improc_update(struct komeda_component *c,
 			      struct komeda_component_state *state)
 {
+	struct drm_crtc_state *crtc_st =3D state->crtc->state;
 	struct komeda_improc_state *st =3D to_improc_st(state);
+	struct d71_pipeline *pipe =3D to_d71_pipeline(c->pipeline);
 	u32 __iomem *reg =3D c->reg;
 	u32 index;
+	u32 mask =3D 0, ctrl =3D 0;
=20
 	for_each_changed_input(state, index)
 		malidp_write32(reg, BLK_INPUT_ID0 + index * 4,
 			       to_d71_input_id(state, index));
=20
 	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
+
+	if (crtc_st->color_mgmt_changed) {
+		mask |=3D IPS_CTRL_FT | IPS_CTRL_RGB;
+
+		if (crtc_st->gamma_lut) {
+			malidp_write_group(pipe->dou_ft_coeff_addr, FT_COEFF0,
+					   KOMEDA_N_GAMMA_COEFFS,
+					   st->fgamma_coeffs);
+			ctrl |=3D IPS_CTRL_FT; /* enable gamma */
+		}
+
+		if (crtc_st->ctm) {
+			malidp_write_group(reg, IPS_RGB_RGB_COEFF0,
+					   KOMEDA_N_CTM_COEFFS,
+					   st->ctm_coeffs);
+			ctrl |=3D IPS_CTRL_RGB; /* enable gamut */
+		}
+	}
+
+	if (mask)
+		malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
 }
=20
 static void d71_improc_dump(struct komeda_component *c, struct seq_file *s=
f)
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 9beeda04818b..406b9d0ca058 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -590,6 +590,8 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
=20
 	crtc->port =3D kcrtc->master->of_output_port;
=20
+	drm_crtc_enable_color_mgmt(crtc, 0, true, KOMEDA_COLOR_LUT_SIZE);
+
 	return err;
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index b322f52ba8f2..c5ab8096c85d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -11,6 +11,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include "malidp_utils.h"
+#include "komeda_color_mgmt.h"
=20
 #define KOMEDA_MAX_PIPELINES		2
 #define KOMEDA_PIPELINE_MAX_LAYERS	4
@@ -324,6 +325,8 @@ struct komeda_improc {
 struct komeda_improc_state {
 	struct komeda_component_state base;
 	u16 hsize, vsize;
+	u32 fgamma_coeffs[KOMEDA_N_GAMMA_COEFFS];
+	u32 ctm_coeffs[KOMEDA_N_CTM_COEFFS];
 };
=20
 /* display timing controller */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 0ba9c6aa3708..4a40b37eb1a6 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -756,6 +756,12 @@ komeda_improc_validate(struct komeda_improc *improc,
 	st->hsize =3D dflow->in_w;
 	st->vsize =3D dflow->in_h;
=20
+	if (kcrtc_st->base.color_mgmt_changed) {
+		drm_lut_to_fgamma_coeffs(kcrtc_st->base.gamma_lut,
+					 st->fgamma_coeffs);
+		drm_ctm_to_coeffs(kcrtc_st->base.ctm, st->ctm_coeffs);
+	}
+
 	komeda_component_add_input(&st->base, &dflow->input, 0);
 	komeda_component_set_output(&dflow->input, &improc->base, 0);
=20
--=20
2.20.1

