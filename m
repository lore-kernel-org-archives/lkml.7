Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12952CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C797A21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XqXguAgh";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XqXguAgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389491AbfJWGn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:43:26 -0400
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]:31271
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbfJWGnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=XqXguAghUKa8rRi1mGKxVIGYiWw6fOHuetMEfxaMemJjthQxwyh+iy+gPq3jaU69ZqKQuotVs3HMqcALucdRhXOFydcqRbS/9YU4c42s3uXptMy/qbeqCADL44ktgvaZZXSK+vJvqAdkX2XIwWEbDrmdi68ji7nwFO7+EjmUxfw=
Received: from AM4PR08CA0047.eurprd08.prod.outlook.com (2603:10a6:205:2::18)
 by VI1PR08MB3757.eurprd08.prod.outlook.com (2603:10a6:803:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.19; Wed, 23 Oct
 2019 06:43:20 +0000
Received: from VE1EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by AM4PR08CA0047.outlook.office365.com
 (2603:10a6:205:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20 via Frontend
 Transport; Wed, 23 Oct 2019 06:43:20 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT014.mail.protection.outlook.com (10.152.19.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Wed, 23 Oct 2019 06:43:20 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Wed, 23 Oct 2019 06:43:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4494aeef9282698d
X-CR-MTA-TID: 64aa7808
Received: from 2e476b2de862.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FE1A581A-5A09-4C67-8FDA-8C8499CFE212.1;
        Wed, 23 Oct 2019 06:43:13 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2056.outbound.protection.outlook.com [104.47.4.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2e476b2de862.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 23 Oct 2019 06:43:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiZtsRu3tcDx8dK5yzP9uPS0G+mH/O6j84WSSzkHnDiUg5NqclMu8WlW3TiiXCkENq15hhESFDiwdQkVDwlfXPLNA7G4bLWW19xCYNMWMlg6Yo4of9M4xv5XMhlFMmiigr4IZ/6WNjKOP/R2ZawP/3x2NK8DN+PPpAauWbmWaNlTcN+il6H+T2INfHk+tHD1xWRzyvW4MXABJt8xn6FZad5e3UNIUEA3jFkjndJGKpNh2AEVruXAhNCEGeIAbBY7JBSX4TtYYmztHn21JM9pIPeFaAbNmJCto9zkvU6QxBTDQ2bVTwXR2WRcWKb4s51nrR4dAlPBiBvfQxHtNpHSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=FJASo0QUBUX6blRfKu4BzP+Fd6gnuWwkoLa9aodzqXrPdmTwci3BYyEaB3cMnx14gEl7RP87XOtyqZlCUsuTzAlmX97eIL5RPYqy1spQNycHUN/ugSxZKYfMrYv6Z+U9L/0xLWzBNeF1s08oMZ89oRf76X9oSCw6T0XDgEgkSUmL8jywiZJOadShlZXFTgFTj3qxABAdA+XyvL9dBL6SoQF3/+GFUOZUkOhtqNdfCZ0E/ojNm37zurSaMJwNu3EqgQB500BWVuf5Acr5lUy8JtMMPo+eVEr2/zOS/9xhOqTP3OlVA9h2rybQIxkONM5OPnA/vi/v8+X6fF/W/i5D6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=XqXguAghUKa8rRi1mGKxVIGYiWw6fOHuetMEfxaMemJjthQxwyh+iy+gPq3jaU69ZqKQuotVs3HMqcALucdRhXOFydcqRbS/9YU4c42s3uXptMy/qbeqCADL44ktgvaZZXSK+vJvqAdkX2XIwWEbDrmdi68ji7nwFO7+EjmUxfw=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5198.eurprd08.prod.outlook.com (20.179.31.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 23 Oct 2019 06:43:10 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 06:43:10 +0000
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v7 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Topic: [PATCH v7 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Index: AQHViW0iknm0f8sRVESKRsTsViA0sA==
Date:   Wed, 23 Oct 2019 06:43:09 +0000
Message-ID: <20191023064226.10969-4-james.qian.wang@arm.com>
References: <20191023064226.10969-1-james.qian.wang@arm.com>
In-Reply-To: <20191023064226.10969-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea480cbd-3d78-4591-3262-08d757844b19
X-MS-TrafficTypeDiagnostic: VE1PR08MB5198:|VE1PR08MB5198:|VI1PR08MB3757:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3757767B020FD9F1B8D808A6B36B0@VI1PR08MB3757.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;OLM:3513;
x-forefront-prvs: 019919A9E4
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(199004)(189003)(66446008)(64756008)(66556008)(2501003)(2906002)(66946007)(66476007)(3846002)(36756003)(6116002)(256004)(14454004)(8676002)(486006)(478600001)(25786009)(50226002)(81156014)(2171002)(8936002)(81166006)(4326008)(103116003)(386003)(110136005)(446003)(305945005)(6506007)(316002)(66066001)(102836004)(76176011)(186003)(2616005)(476003)(6512007)(1076003)(5660300002)(99286004)(54906003)(11346002)(52116002)(71200400001)(71190400001)(2201001)(86362001)(6486002)(6436002)(26005)(7736002)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5198;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QMBIruKCqS5TdqYpA45FL7Suk1UelazrwPyXfao7utvo0ex1kG9Sm/Mj7PMnYicaH8iPVV0lbqk3H4+95PQupZy0o8ZWl4lUC/SAAoFwU+OZO3G8NB6ickRor633nCiG1Tpc9L24voCLOOa6bDIbZeUoksDfDyeU96sNyhPD3MeGQSmrZfvC03HCEV8tjdapKCyz+nRrHcnZjKrNevkadS959v6IZv8nsFTDAnwDMjKko8xrlGJ0vmo6FctCrK6mwDH+nZqid4Pf7yQ2Q6tySU/9C2QPUFUbhYOVANKIsS4Otspz6hnKPxPke8Z06VAMuCzpVBwus9yOjjO+lf8+E2Iawo5RSqf8JlVq98FR3ze81tz8ns2C/M0QserRKQxRGD+EQAXDDn839dpzH2gqTwoAU11MYWva1CddD+jF5pQDBdanX0O9dtH2K65DOil4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5198
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(1110001)(339900001)(189003)(199004)(2171002)(99286004)(86362001)(50466002)(305945005)(2906002)(7736002)(2201001)(102836004)(54906003)(386003)(6506007)(110136005)(23756003)(3846002)(36756003)(2501003)(6116002)(103116003)(105606002)(6486002)(486006)(70206006)(8936002)(356004)(11346002)(446003)(70586007)(2616005)(76130400001)(36906005)(26005)(81166006)(336012)(316002)(6512007)(186003)(47776003)(126002)(476003)(66066001)(22756006)(8746002)(25786009)(478600001)(76176011)(5660300002)(14454004)(26826003)(50226002)(8676002)(4326008)(1076003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3757;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5700c133-2ddb-4f50-a579-08d7578444b3
NoDisclaimer: True
X-Forefront-PRVS: 019919A9E4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2UnoiPTEijUIWsQDftRFzp3FytxEi0rddrxgg0nYNn07MyiBlFEDAEJZGl9CBxV7DZLUDIus0ATCgHkivLraTHQwG+msmeqtWl8ViFdcyF8B//MPaf3ysl+TCdcXpLzk6yCORv5W/IRbaG2KZXs0ZX+Tcg3SnIqiGJuIi7pUh4fFr1hAaVDqW0vktR9xAzJa4s4Bt0cnpYI4uAxGXpcxxS36KVa/+IMZzgtCa7CIVlZ5M53QEdJ83tKKAn40+7W4VEOL+2rOa9q19lkqFC+uUq8v2b6tWj70nFct44EekLhmuU/Agcqtk4waYaS27BVDpJQ8zmUeoq8F4uMdZtDn7YW6TAVAUh8DuquAi+AcPHqEXD9TiBRQn+Jx10D6bG5DyBsRnLRrV84EJxHXIGZCGX2GGeNDFPSNdrQhiKpBdPyYZtfiafNFij7xFKLo+uQ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2019 06:43:20.2365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea480cbd-3d78-4591-3262-08d757844b19
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is for converting drm_color_ctm matrix to komeda hardware
required required Q2.12 2's complement CSC matrix.

v2:
  Move the fixpoint conversion function s31_32_to_q2_12() to drm core
  as a shared helper.

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.c | 14 ++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
index c180ce70c26c..d8e449e6ebda 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
@@ -117,3 +117,17 @@ void drm_lut_to_fgamma_coeffs(struct drm_property_blob=
 *lut_blob, u32 *coeffs)
 {
 	drm_lut_to_coeffs(lut_blob, coeffs, sector_tbl, ARRAY_SIZE(sector_tbl));
 }
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
+	for (i =3D 0; i < KOMEDA_N_CTM_COEFFS; i++)
+		coeffs[i] =3D drm_color_ctm_s31_32_to_qm_n(ctm->matrix[i], 3, 12);
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
index 08ab69281648..2f4668466112 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
@@ -18,6 +18,7 @@
 #define KOMEDA_N_CTM_COEFFS		9
=20
 void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *coe=
ffs);
+void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs);
=20
 const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_rang=
e);
=20
--=20
2.20.1

