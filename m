Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1ECC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FF1206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="68So3K9Z";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="68So3K9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfHME4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 00:56:31 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:36484
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbfHME43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lht/FXnDUDdG/2htzFfQqSr71W++svRRJXgUnujKmXo=;
 b=68So3K9Z+gsyBSknXWc6z95iWaDo6fRYF0JVcEjN31Zu4OBo5deEHaaicxwJRavKsHc6MBIV3yRu30RrqoBypyKKIsUECaNLjNQUpxttpDpNrTCY4PNEnWBHiLptkbEp6Hm0gp2OgmDO3e/JBfAhHtcEBdrN3eTKYgvZ8cMPM7g=
Received: from DB7PR08CA0002.eurprd08.prod.outlook.com (2603:10a6:5:16::15) by
 VE1PR08MB4959.eurprd08.prod.outlook.com (2603:10a6:803:110::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16; Tue, 13 Aug
 2019 04:56:22 +0000
Received: from AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by DB7PR08CA0002.outlook.office365.com
 (2603:10a6:5:16::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Tue, 13 Aug 2019 04:56:21 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT057.mail.protection.outlook.com (10.152.17.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 13 Aug 2019 04:56:20 +0000
Received: ("Tessian outbound 220137ab7b0b:v26"); Tue, 13 Aug 2019 04:56:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5a4466e494ac27c0
X-CR-MTA-TID: 64aa7808
Received: from 48d282c98ec2.2 (cr-mta-lb-1.cr-mta-net [104.47.2.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3EA0245D-8345-4038-BA22-129FD4567396.1;
        Tue, 13 Aug 2019 04:56:10 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2052.outbound.protection.outlook.com [104.47.2.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 48d282c98ec2.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 13 Aug 2019 04:56:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eodcI3b4cbg8foLpxrxIw4vzu6Xnt+gtPnTetX8YBVwRgO3BWbKO9jRZnl0uNB8BuFnhmOdGfqYNga+1kb7vE0m/6oQMOh/ckTulFV330kplrEnj/+RH680e37eXNDSxs4hqfkJ3DBSS8eTuyibg5psoWcjMMJI0dfjcR1bIrIGHImiGWSctyKqXEnwiL6XU4kUvwR3Z1edjFlssdJu2jEWlqArxQLPwe8pLUyJkympqMwB/hQrT6syt/7KB8JINLNBXn/d4AF26VL9NuF6V2a1NjdyeTleBQ/RahMbjbTpQ3JoubkyQS0Cs2kGlZKyxVluaypLdhBwcG2TXgUXfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lht/FXnDUDdG/2htzFfQqSr71W++svRRJXgUnujKmXo=;
 b=ZP0XO+xqGF7wjwIdMEgTddKNI/rFv7VTv8R362eaF4bD+9hVjQCReE5/VMXM553WB/2EUsnEjDS7XOo1GBYJNsZg+1LBaF78lswed4R4MT6Ydo533FO29EouiiRLAh4HjKhKlGWbwQjxnIcfjxZBJZ6/k3UIF0nnpQ24sn8aQuRipSd+vH0T1lLSfyx+2IKV57b4XKd38t//EzJvlOynk+v67DCb6iCYqKuZiwT+IfS4SNJP9a2ADarEceqTmo0Klt7I4cRZcsAujdMzt1xXn27x9bt7j4+1lepFM2+Imx1isZIGwMac+hE7f7fVRCBRTXGKpzLQ17ZJUCcnkV6ulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lht/FXnDUDdG/2htzFfQqSr71W++svRRJXgUnujKmXo=;
 b=68So3K9Z+gsyBSknXWc6z95iWaDo6fRYF0JVcEjN31Zu4OBo5deEHaaicxwJRavKsHc6MBIV3yRu30RrqoBypyKKIsUECaNLjNQUpxttpDpNrTCY4PNEnWBHiLptkbEp6Hm0gp2OgmDO3e/JBfAhHtcEBdrN3eTKYgvZ8cMPM7g=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4752.eurprd08.prod.outlook.com (10.255.112.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Tue, 13 Aug 2019 04:56:07 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 04:56:07 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 2/4] drm/komeda: Introduce komeda_color_manager/state
Thread-Topic: [PATCH v2 2/4] drm/komeda: Introduce komeda_color_manager/state
Thread-Index: AQHVUZNrgGWWre2e4Eyh5LBkmfNYaA==
Date:   Tue, 13 Aug 2019 04:56:07 +0000
Message-ID: <20190813045536.28239-3-james.qian.wang@arm.com>
References: <20190813045536.28239-1-james.qian.wang@arm.com>
In-Reply-To: <20190813045536.28239-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 78c022dc-2351-412d-dc38-08d71faa950f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4752;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4752:|VE1PR08MB4959:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB4959C09CF9E9760801BAC325B3D20@VE1PR08MB4959.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3276;OLM:3276;
x-forefront-prvs: 01283822F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(50226002)(5660300002)(2201001)(110136005)(26005)(316002)(66066001)(6116002)(3846002)(305945005)(2906002)(7736002)(103116003)(71190400001)(71200400001)(8676002)(1076003)(54906003)(446003)(55236004)(66946007)(478600001)(81156014)(14454004)(386003)(6506007)(4326008)(36756003)(52116002)(2616005)(102836004)(25786009)(256004)(11346002)(14444005)(81166006)(186003)(76176011)(6486002)(64756008)(66556008)(66476007)(99286004)(2501003)(6512007)(6436002)(86362001)(66446008)(8936002)(486006)(476003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4752;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 2gpb+2vaeXz6XazK4aNvYeXepjiL48SMVgwale7OvV6sP6itJz8pJSWjhgwA0iaqC21MnEmciDnkvU10wj4EZIJEudFNAfldzIoyww90TxW4XAdl/I3KMI4RzfBOhMk1Hx3XdVeOAEmjnmrUY5EW0D6cB5gQFi4qoL3f9Nz+ve/9b9Rc47VhrlWiW18NRHGSN9r+LEB/vdlRz3s7GtwiF/rzHVbp7JCw27H6Fi9EosieMsLytUkjNMCy+bsfEEW1AlZXTimNOkqrYtQzuFqm+qshr8IrRGvuQEo2utbSdd5LZiApG/SNWD3K9I9N/7Ag0fPKMWldih4/m5r90H41sRvPfCYZkhD4RRj4w9Scet3FvV0T4BJJWqrLVf+dW/GBPnIhv/Za+kBOU15mRZRBSItsHdR+jn6wS1EK64vCb3I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4752
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(189003)(199004)(305945005)(47776003)(26005)(76176011)(66066001)(81166006)(2501003)(99286004)(7736002)(81156014)(50226002)(102836004)(8936002)(8746002)(6506007)(386003)(36756003)(2906002)(63370400001)(6512007)(446003)(6486002)(2201001)(63350400001)(11346002)(486006)(4326008)(14444005)(336012)(25786009)(86362001)(2616005)(476003)(26826003)(1076003)(103116003)(70586007)(23756003)(70206006)(356004)(126002)(3846002)(478600001)(50466002)(14454004)(316002)(8676002)(186003)(110136005)(54906003)(6116002)(36906005)(22756006)(76130400001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4959;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7f5b7130-b506-43d4-376a-08d71faa8d6c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VE1PR08MB4959;
NoDisclaimer: True
X-Forefront-PRVS: 01283822F8
X-Microsoft-Antispam-Message-Info: O5l+hgsRpdB0bEKpqxN7pg0VvI2E1P6YvDkvfEH9SjeXA7ZcHcvU+IOJUxOpJd9PMV3uP845+E04hetFpSuWZagEy47ekipIOSOloeFJ0/6yIVQY1O548iCdqmC6H9faDhUfvVsvtNC+ddgdV1Q/Rk3Acpxw9aH7eISX47dASO1sMrfHCpYDS2Ra2jNaEjMPB9g1EzwcJjqsfvw3KcP9MyzklltdISdnw4458wNmkvyF2mvcfXL9hjlPrIjhWNE6sjrqUPmEaacbmEqHy9JS7T1Uua3YDABsTh62udCAyLhouCOtVZhw2kAAmirs/GkvuAHqmcvLW54Xv87/DmynpQbOhfPwb4OdfUfmGY3jDwllAZ+jmwuEZ8K+kR70zD2Sz6mF3VrkhlXEL18qupX+gOlGjXS4BYrDc3pQWiOKPfE=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 04:56:20.1209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c022dc-2351-412d-dc38-08d71faa950f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many komeda component support color management like layer and IPS, so
komeda_color_manager/state are introduced to manager gamma, csc and degamma
together for easily share it to multiple componpent.

And for komeda_color_manager which:
- convert drm 3d gamma lut to komeda specific gamma coeffs
- gamma table management and hide the HW difference for komeda-CORE

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../arm/display/komeda/komeda_color_mgmt.c    | 126 ++++++++++++++++++
 .../arm/display/komeda/komeda_color_mgmt.h    |  32 ++++-
 2 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
index 9d14a92dbb17..bf2388d641b9 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
@@ -4,7 +4,9 @@
  * Author: James.Qian.Wang <james.qian.wang@arm.com>
  *
  */
+#include <drm/drm_print.h>
=20
+#include "malidp_utils.h"
 #include "komeda_color_mgmt.h"
=20
 /* 10bit precision YUV2RGB matrix */
@@ -65,3 +67,127 @@ const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encod=
ing, u32 color_range)
=20
 	return coeffs;
 }
+
+struct gamma_curve_sector {
+	u32 boundary_start;
+	u32 num_of_segments;
+	u32 segment_width;
+};
+
+struct gamma_curve_segment {
+	u32 start;
+	u32 end;
+};
+
+static struct gamma_curve_sector sector_tbl[] =3D {
+	{ 0,    4,  4   },
+	{ 16,   4,  4   },
+	{ 32,   4,  8   },
+	{ 64,   4,  16  },
+	{ 128,  4,  32  },
+	{ 256,  4,  64  },
+	{ 512,  16, 32  },
+	{ 1024, 24, 128 },
+};
+
+static struct gamma_curve_sector igamma_sector_tbl[] =3D {
+	{0, 64, 64},
+};
+
+static void
+drm_lut_to_coeffs(struct drm_property_blob *lut_blob, u32 *coeffs,
+		  struct gamma_curve_sector *sector_tbl, u32 num_sectors)
+{
+	struct drm_color_lut *lut;
+	u32 i, j, in, num =3D 0;
+
+	if (!lut_blob)
+		return;
+
+	lut =3D lut_blob->data;
+
+	for (i =3D 0; i < num_sectors; i++) {
+		for (j =3D 0; j < sector_tbl[i].num_of_segments; j++) {
+			in =3D sector_tbl[i].boundary_start +
+			     j * sector_tbl[i].segment_width;
+
+			coeffs[num++] =3D drm_color_lut_extract(lut[in].red,
+						KOMEDA_COLOR_PRECISION);
+		}
+	}
+
+	coeffs[num] =3D BIT(KOMEDA_COLOR_PRECISION);
+}
+
+void drm_lut_to_igamma_coeffs(struct drm_property_blob *lut_blob, u32 *coe=
ffs)
+{
+	drm_lut_to_coeffs(lut_blob, coeffs,
+			  igamma_sector_tbl, ARRAY_SIZE(igamma_sector_tbl));
+}
+
+void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *coe=
ffs)
+{
+	drm_lut_to_coeffs(lut_blob, coeffs,
+			  sector_tbl, ARRAY_SIZE(sector_tbl));
+}
+
+void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs)
+{
+	struct drm_color_ctm *ctm;
+	u32 i;
+
+	if (!ctm_blob)
+		return;
+
+	ctm =3D ctm_blob->data;
+
+	for (i =3D 0; i < KOMEDA_N_CTM_COEFFS; ++i) {
+		/* Convert from S31.32 to Q3.12. */
+		s64 v =3D ctm->matrix[i];
+
+		coeffs[i] =3D clamp_val(v, 1 - (1LL << 34), (1LL << 34) - 1) >> 20;
+	}
+}
+
+void komeda_color_duplicate_state(struct komeda_color_state *new,
+				  struct komeda_color_state *old)
+{
+	new->igamma =3D komeda_coeffs_get(old->igamma);
+	new->fgamma =3D komeda_coeffs_get(old->fgamma);
+}
+
+void komeda_color_cleanup_state(struct komeda_color_state *color_st)
+{
+	komeda_coeffs_put(color_st->igamma);
+	komeda_coeffs_put(color_st->fgamma);
+}
+
+int komeda_color_validate(struct komeda_color_manager *mgr,
+			  struct komeda_color_state *st,
+			  struct drm_property_blob *igamma_blob,
+			  struct drm_property_blob *fgamma_blob)
+{
+	u32 coeffs[KOMEDA_N_GAMMA_COEFFS];
+
+	komeda_color_cleanup_state(st);
+
+	if (igamma_blob) {
+		drm_lut_to_igamma_coeffs(igamma_blob, coeffs);
+		st->igamma =3D komeda_coeffs_request(mgr->igamma_mgr, coeffs);
+		if (!st->igamma) {
+			DRM_DEBUG_ATOMIC("request igamma table failed.\n");
+			return -EBUSY;
+		}
+	}
+
+	if (fgamma_blob) {
+		drm_lut_to_fgamma_coeffs(fgamma_blob, coeffs);
+		st->fgamma =3D komeda_coeffs_request(mgr->fgamma_mgr, coeffs);
+		if (!st->fgamma) {
+			DRM_DEBUG_ATOMIC("request fgamma table failed.\n");
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
index a2df218f58e7..41a96b3b540f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
@@ -4,14 +4,42 @@
  * Author: James.Qian.Wang <james.qian.wang@arm.com>
  *
  */
-
 #ifndef _KOMEDA_COLOR_MGMT_H_
 #define _KOMEDA_COLOR_MGMT_H_
=20
 #include <drm/drm_color_mgmt.h>
+#include "komeda_coeffs.h"
=20
 #define KOMEDA_N_YUV2RGB_COEFFS		12
+#define KOMEDA_N_RGB2YUV_COEFFS		12
+#define KOMEDA_COLOR_PRECISION		12
+#define KOMEDA_N_GAMMA_COEFFS		65
+#define KOMEDA_COLOR_LUT_SIZE		BIT(KOMEDA_COLOR_PRECISION)
+#define KOMEDA_N_CTM_COEFFS		9
+
+struct komeda_color_manager {
+	struct komeda_coeffs_manager *igamma_mgr;
+	struct komeda_coeffs_manager *fgamma_mgr;
+	bool has_ctm;
+};
+
+struct komeda_color_state {
+	struct komeda_coeffs_table *igamma;
+	struct komeda_coeffs_table *fgamma;
+};
+
+void komeda_color_duplicate_state(struct komeda_color_state *new,
+				  struct komeda_color_state *old);
+void komeda_color_cleanup_state(struct komeda_color_state *color_st);
+int komeda_color_validate(struct komeda_color_manager *mgr,
+			  struct komeda_color_state *st,
+			  struct drm_property_blob *igamma_blob,
+			  struct drm_property_blob *fgamma_blob);
+
+void drm_lut_to_igamma_coeffs(struct drm_property_blob *lut_blob, u32 *coe=
ffs);
+void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *coe=
ffs);
+void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs);
=20
 const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_rang=
e);
=20
-#endif
+#endif /*_KOMEDA_COLOR_MGMT_H_*/
--=20
2.20.1

