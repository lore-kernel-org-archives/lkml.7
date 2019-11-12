Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF2FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCE02084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="h8GeG11u";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="h8GeG11u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKLLKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:10:34 -0500
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:64603
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfKLLKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=h8GeG11ulgLAUBiVbkVEaFhHzw1PMP086RvWRq5WnCtcbvF1HyhTGW6qWm30dBcYIMfJAdiwy8ZU1z385UNJnO9Lc0YswqeGYv10hWovJ9BWifYc92fXUj8op9uKb3SUFI3vukdWNeeRMVKnKkGZNXQ9OlWfV2vUnvEGc/Mu/qE=
Received: from VE1PR08CA0019.eurprd08.prod.outlook.com (2603:10a6:803:104::32)
 by AM6PR08MB3478.eurprd08.prod.outlook.com (2603:10a6:20b:4a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.23; Tue, 12 Nov
 2019 11:10:28 +0000
Received: from DB5EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VE1PR08CA0019.outlook.office365.com
 (2603:10a6:803:104::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Tue, 12 Nov 2019 11:10:28 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT011.mail.protection.outlook.com (10.152.20.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Tue, 12 Nov 2019 11:10:27 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Tue, 12 Nov 2019 11:10:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 027fd423d32f3d12
X-CR-MTA-TID: 64aa7808
Received: from ce5f38f6e7fd.2 (cr-mta-lb-1.cr-mta-net [104.47.4.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8501F687-5FC8-47C7-A37C-12BEA18BA52A.1;
        Tue, 12 Nov 2019 11:10:20 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ce5f38f6e7fd.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 12 Nov 2019 11:10:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOTYJxHtNEpwd83fJdyDyzwRCL5q1RDb7OCtxvsJCFBhqv27GIFv5IcZcKlniNmu3+aIA3/cprLp1B2RcgUmQ7+Fq9QMgDUIREK9rcdpusWY/Z6nl12U2Z9o2LPWDTDqdNT494ZCn33hJQiPYNtCzcaXwB6GI1VGGibQY/aiKfO2//ZnCfHRp2a7q6pXtzfPa+uAcYutugQdmmcP0D8NehTyg/YlfTyNjUu2E4Ioq6APoXX5vAVM+6ALAwgZxyj2QCUbtgAFVLpv3KhtvPpVavTqL3jKxCQcmUJUKixiDQFyKUgOzAyqrh+66FjjNyTyzZ9WDoanO6i/O6aL+hxd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=LGQfxE9Lk28dFr/MvuBomSM8MqYAeN29QgcjW5SyQ3JrfW2CbCvs5qdiLpcBQywr6H0kHTW5D6PE8w5W2de0f9Z707r3X6sLNRFi9UmI6wHII2Tow5hC9hrbxEgw2JLCoeBPH5ux9dNuAGUsIzA9wD7Z2AjCb1Q/dV4tRZA5PPoaD3RUhZIAe552fDbzdpn4J2guBPvCRFbiIggq6GYr5FMJ2kEANhjk3VoqRFI0BPjPQzgBAfrYMpucFVBvNKBarsi5cfRFRbwCCXC48bb8iohdOJrS+8HnaxJImYvrHWaEFXtLzRBrlsBtOsUpCSCyGdqtOG8rT2s4aqvRii28bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=h8GeG11ulgLAUBiVbkVEaFhHzw1PMP086RvWRq5WnCtcbvF1HyhTGW6qWm30dBcYIMfJAdiwy8ZU1z385UNJnO9Lc0YswqeGYv10hWovJ9BWifYc92fXUj8op9uKb3SUFI3vukdWNeeRMVKnKkGZNXQ9OlWfV2vUnvEGc/Mu/qE=
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com (10.255.30.207) by
 AM0PR08MB3636.eurprd08.prod.outlook.com (20.177.43.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 11:10:18 +0000
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0]) by AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:10:18 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v10 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Topic: [PATCH v10 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Index: AQHVmUnEN7Mkw/Fd7UqlRzpEzWbLAw==
Date:   Tue, 12 Nov 2019 11:10:18 +0000
Message-ID: <20191112110927.20931-4-james.qian.wang@arm.com>
References: <20191112110927.20931-1-james.qian.wang@arm.com>
In-Reply-To: <20191112110927.20931-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To AM0PR08MB4995.eurprd08.prod.outlook.com
 (2603:10a6:208:162::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8fc54229-fff9-4fa7-b271-08d76760ec8a
X-MS-TrafficTypeDiagnostic: AM0PR08MB3636:|AM0PR08MB3636:|AM6PR08MB3478:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3478EB786E1515A88640E5A5B3770@AM6PR08MB3478.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;OLM:3513;
x-forefront-prvs: 021975AE46
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(2906002)(99286004)(446003)(2616005)(476003)(7736002)(66066001)(6512007)(6436002)(6486002)(11346002)(54906003)(256004)(305945005)(103116003)(110136005)(316002)(2201001)(14454004)(6116002)(2501003)(86362001)(3846002)(486006)(71200400001)(71190400001)(186003)(386003)(36756003)(1076003)(6506007)(5660300002)(81166006)(8676002)(4326008)(50226002)(26005)(76176011)(66946007)(2171002)(52116002)(81156014)(66446008)(102836004)(66476007)(64756008)(8936002)(66556008)(25786009)(55236004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3636;H:AM0PR08MB4995.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: v6S7xoxEQ6a4ktTxsZZslhXSYoGeQFJLRixLZSXbgYToQTolzVKSVn6CNY3QKzFEgTnXvpqyvr4IEG41DgqcfvpcSk7qH3uRH1DzWPXhZPf/yHI6kMCXENbHL2a65OkclUHiHvSLi+KapOGbfCyjS9nl3FzKIU8DDLN1I4nyy9X3UNzrs5ZTcbLJb0TG7virp1Kj7uckyNANTyAntTzBx7MZ/u2v9Y+JCSaeyix+OHcE22OqDBPxpAeXvAgvA4XUxchw8TIHVDfClm8bRgZb491/Bg2+r2cEFEya6kzvsFSCXthK3UIkCpn8PsUFl6AkgdrUvWXNswtUenDbFzo45p7Vr/aaM+ntDD0eQgDG+aM68cG8katPic6RyGtD801n99GrTNUXF9Grwpu3ZiNWT8q314W9IMiyqMZ2FWS33fHAiGmPIwGjRh6vSbrDR3sf
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3636
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(1110001)(339900001)(189003)(199004)(76130400001)(76176011)(5660300002)(2201001)(478600001)(356004)(2171002)(446003)(486006)(11346002)(2616005)(6512007)(476003)(126002)(81156014)(81166006)(4326008)(22756006)(8746002)(8936002)(305945005)(7736002)(14454004)(6486002)(8676002)(26826003)(2501003)(6116002)(50466002)(103116003)(3846002)(47776003)(70206006)(50226002)(105606002)(25786009)(26005)(23756003)(36756003)(110136005)(1076003)(316002)(2906002)(86362001)(54906003)(99286004)(66066001)(70586007)(6506007)(336012)(102836004)(386003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3478;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 305e0879-1316-4f33-2c7b-08d76760e6c4
NoDisclaimer: True
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5SPyki5PuLcm1yeKGUL0zCGe4hJ3182rp+KbMn0a2o4hqVGHGkteeqaF1jgHWLdUZw0fWc3hSEr2B6AeMlXa2qn7yCS6keojJlu4ys5u6H3jKGk3hs/hsnr/p43GgLlWS3Z7GKyWGjkOz6qnl6MR5czql4NpUdCQv3PGeLZjtZ9yFjPwa3deY3bSuM+AWkIYlNu7FbKVD4BQLy8dEsHo9+bGlS7ocbrMTNP1igLHwOMeaGej8CAICdesa2nP7vqv5OE84/xfhPESpHS8p2id5aQqrPz1TyRJ8VMsrNc+6iIxBjmcpdwhEDtd9s1LX1oh7BB3T47cPGPQ/GSPbVL29AWGvmta1EdY5yEuwqZJjR8oTgCEaLmZ7oze/z8yqgayHl+7aHPnnQpgviWKgbbatc9tjt1AGtaiIph8MVkMHXCT6VkHpCvESCCUghVjUHQ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 11:10:27.8678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc54229-fff9-4fa7-b271-08d76760ec8a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3478
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

