Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C3DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8162320674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BYfthaSu";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BYfthaSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfKLKkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:40:40 -0500
Received: from mail-eopbgr30057.outbound.protection.outlook.com ([40.107.3.57]:54500
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727064AbfKLKkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOrt6sxuikDY8QGRHGli7q4d5cAkxgKVtJe6VeR/bEY=;
 b=BYfthaSu9HHZ2+PaeV0/vpwllc7OFmiGAkfM+qBe2Sd6Gnwwz9ROP22yxllZDrBocRWPCUeR24n0tMrLGvqwShE3qUlaKmtAup2rU92vx6dyZ6CHEbCWuhdk2LDISkKivHFXu1vYvBVIiYWi5CfltDH5clfBdRV/9XWZgGZsal4=
Received: from VE1PR08CA0005.eurprd08.prod.outlook.com (2603:10a6:803:104::18)
 by DB6PR08MB2870.eurprd08.prod.outlook.com (2603:10a6:6:20::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.25; Tue, 12 Nov
 2019 10:40:34 +0000
Received: from VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by VE1PR08CA0005.outlook.office365.com
 (2603:10a6:803:104::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Tue, 12 Nov 2019 10:40:34 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT019.mail.protection.outlook.com (10.152.18.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.21 via Frontend Transport; Tue, 12 Nov 2019 10:40:34 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Tue, 12 Nov 2019 10:40:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e4077bbbc7a62a59
X-CR-MTA-TID: 64aa7808
Received: from 6634627f527e.2 (cr-mta-lb-1.cr-mta-net [104.47.10.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 230940A3-5F62-400B-B287-3134D5A2DDF8.1;
        Tue, 12 Nov 2019 10:40:20 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6634627f527e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 12 Nov 2019 10:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZ43ipfjr9Q4zVBIvErYIsLvMMWYxzWMvElNfBY90uTIpvtsmScpmqk0a7nVj7eptb1u01dFDYrZV5ATTfC9Cj+7xTIhjrqkEp3QaRKhl2dlfMeh78B/pHS/g7XkIjfiMfFUoYgQSLB2OmroR6Rgkh2SCX4mvy/a/wDPqV9IRj3Ah84TBs1mvt/tpAnPvmfxuUe/lZhRU2lcVXRUSuCvgUACrZxKyWA9g93e9wkHtltZEDfWEjdE0NglK/qHhNqRemPmnIOLGO6vO+MLyrQfRM5ylxKcoPJdpnuvZx3ZH+MOwLoFb8Uc5TJ2h/Et7Z1zDPy78fC03LFirqLz1lI2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOrt6sxuikDY8QGRHGli7q4d5cAkxgKVtJe6VeR/bEY=;
 b=JUhN1tX76e9Z2EqGxTPsM8ZsQagfwJwzUghQfKZKXUBI5LL0AZr9e0WGDzUMc7soppgjvCwvH+FbVo8CFPQfHWyBuHObaWcktILxQ/wX5hUVfH28PeXwRxTx2gblKL4peKiK2HeLkc5+dlBDIlRHBM0I/eoBegR35Le7JXMLKMEut8wdS0tpvjAm4wC5iTDl7sP1h7coGxTGYZ5WmGn9ytbbILwxzd8B0Z61sQVQgYdMpNGI08IKMQQWv5cDme6yb+vE3H7pvqg8KEKtormRptcohmjIZsXzz96vB872zd1BGDDNYw3qFL9yIWxZ3bgAlM3BCUjIovqUAbX9bREGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOrt6sxuikDY8QGRHGli7q4d5cAkxgKVtJe6VeR/bEY=;
 b=BYfthaSu9HHZ2+PaeV0/vpwllc7OFmiGAkfM+qBe2Sd6Gnwwz9ROP22yxllZDrBocRWPCUeR24n0tMrLGvqwShE3qUlaKmtAup2rU92vx6dyZ6CHEbCWuhdk2LDISkKivHFXu1vYvBVIiYWi5CfltDH5clfBdRV/9XWZgGZsal4=
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com (10.255.30.207) by
 AM0PR08MB4082.eurprd08.prod.outlook.com (20.178.119.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 12 Nov 2019 10:40:17 +0000
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0]) by AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 10:40:17 +0000
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
Subject: [PATCH v9 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Topic: [PATCH v9 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Index: AQHVmUWS62NJlvjRSU6V3as2Z4d7/A==
Date:   Tue, 12 Nov 2019 10:40:16 +0000
Message-ID: <20191112103956.19074-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:203:72::27) To AM0PR08MB4995.eurprd08.prod.outlook.com
 (2603:10a6:208:162::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3022d8f4-4307-4bfa-5123-08d7675cbfa4
X-MS-TrafficTypeDiagnostic: AM0PR08MB4082:|AM0PR08MB4082:|DB6PR08MB2870:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB2870EEA55F1881C2C072AB20B3770@DB6PR08MB2870.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 021975AE46
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(86362001)(6306002)(6512007)(478600001)(66066001)(54906003)(110136005)(316002)(5660300002)(6486002)(966005)(14454004)(2171002)(2616005)(6436002)(25786009)(476003)(2201001)(14444005)(1076003)(6506007)(8936002)(386003)(99286004)(2906002)(4326008)(55236004)(102836004)(103116003)(256004)(66946007)(66556008)(66476007)(64756008)(66446008)(6116002)(3846002)(52116002)(26005)(81166006)(81156014)(8676002)(186003)(7736002)(486006)(71190400001)(71200400001)(36756003)(305945005)(50226002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4082;H:AM0PR08MB4995.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YQNxvY1TyNPbjgLVrwD4W2Cl9fYqdTnz0++6QyG54AYDaPkIRgRhdKmBEqkLVaiqjGjKbMBqXRUrR0N2Bpd/c+geLJPrZgdbCqjt+TvAfAv2VvrUE6tuUQiNpdX/VeR79uRO92Ty7bdLJUFxwupaitqnvgcz7f3TZjC+4QjxdvHR2ojAQYjeMaj2F0Xi9h+ps5M4ZL1MZXpQyxcSxtRFKQSzNo1Xg8wlpj2Zlb00ocpVjZpwqS9G5T8Ryx88DWYK+dcXDRYa5DWRZPYeD18fTUpYcQ3TGDC7MMg9DB6v2iuPrBh0KsZXIkamB8rKj7Q/wfVNnKEeULzqqldTmfRN7Z6igBhoYXJ4OYI+EzyzK4BaVinJsthYn39BRQM03W1rhA15v0u525pxXUiAYMzgQrmKZmixbM/ACZIkHsgQazDlne4b7bRcmM/qGCVLNkzk
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4082
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(396003)(1110001)(339900001)(199004)(189003)(305945005)(2906002)(70206006)(103116003)(966005)(22756006)(76130400001)(14454004)(70586007)(478600001)(186003)(8746002)(386003)(105606002)(23756003)(26826003)(4326008)(8936002)(1076003)(2501003)(50226002)(54906003)(6506007)(7736002)(102836004)(3846002)(6512007)(110136005)(316002)(86362001)(5660300002)(26005)(8676002)(6116002)(99286004)(6486002)(47776003)(476003)(2616005)(66066001)(486006)(81156014)(356004)(126002)(36756003)(50466002)(14444005)(6306002)(81166006)(36906005)(336012)(2201001)(2171002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2870;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0907dd31-87d0-4095-d2bf-08d7675cb4fe
X-MS-Exchange-PUrlCount: 3
NoDisclaimer: True
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NXi+qpn7zW0EUwBtTbfRd2w/39aDOOzK52iuVSCUmDU7TCzW9d33ZOcbTYbBlfbJVNBKpk58XnvASMh5RVCp+AcXYimCOqQ7VBlPryF7aaJZypoQGMq2avBJOdjBUj68JP1MyzWGwWxxo6iK/37ATx44kEf9kNq48a3FnZ8Gp5gQXRuZiwdavsF6cDIIwpqdb58qX/PZXUCcNmFMAIuE+wVIRzwiU542Sp0mo2BoZWTqVbJtSgXVsSMSZMfOuwRmFltNtEoudzyyokFWxgx/7mT9f1kcUDRhxjliJyK1vYthAJTYXN/wUWIiLvY+Mx2cM8CUvvvogilT6G14mmBLpBsEX23xu/pWLxYZIM93Qj9nf0ScQHVSMbEyVFMRsy1ib1UZdX+TeLjfGPnTXG0yBuAtWMQ0znCHnt16cST4fwJCec98CXMNCzcLCGdL+iOfOmcDU2nuC0qmfTP35f41ezrEHQzdQXT9V055aLRFsk=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 10:40:34.4992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3022d8f4-4307-4bfa-5123-08d7675cbfa4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2870
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series actually are regrouped from:
- drm/komeda: Enable layer/plane color-mgmt:
  https://patchwork.freedesktop.org/series/60893/

- drm/komeda: Enable CRTC color-mgmt
  https://patchwork.freedesktop.org/series/61370/

For removing the dependence on:
- https://patchwork.freedesktop.org/series/30876/

Lowry Li (Arm Technology China) (1):
  drm/komeda: Adds gamma and color-transform support for DOU-IPS

james qian wang (Arm Technology China) (3):
  drm/komeda: Add a new helper drm_color_ctm_s31_32_to_qm_n()
  drm/komeda: Add drm_lut_to_fgamma_coeffs()
  drm/komeda: Add drm_ctm_to_coeffs()

v2:
  Move the fixpoint conversion function s31_32_to_q2_12() to drm core
  as a shared helper.

v4:
  Address review comments from Mihai, Daniel and Ilia.

V5:
- Includes the sign bit in the value of m (Qm.n).
- Rebase with drm-misc-next

v6:
  Allows m =3D=3D 0 according to Mihail's comments.

v9:
  Rebase

Lowry Li (Arm Technology China) (1):
  drm/komeda: Adds gamma and color-transform support for DOU-IPS

james qian wang (Arm Technology China) (3):
  drm: Add a new helper drm_color_ctm_s31_32_to_qm_n()
  drm/komeda: Add drm_lut_to_fgamma_coeffs()
  drm/komeda: Add drm_ctm_to_coeffs()

 .../arm/display/komeda/d71/d71_component.c    | 20 ++++++
 .../arm/display/komeda/komeda_color_mgmt.c    | 66 +++++++++++++++++++
 .../arm/display/komeda/komeda_color_mgmt.h    | 10 ++-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +
 .../display/komeda/komeda_pipeline_state.c    |  6 ++
 drivers/gpu/drm/drm_color_mgmt.c              | 35 ++++++++++
 include/drm/drm_color_mgmt.h                  |  1 +
 8 files changed, 142 insertions(+), 1 deletion(-)

--
2.20.1
