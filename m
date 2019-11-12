Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9EEC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386A4214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="C3yI/m+t";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="C3yI/m+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKLLKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:10:21 -0500
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:17799
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfKLLKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsZ15Yl+X1HBg9E+9H28CUeamfDtYCZbnyRDQ7bPAes=;
 b=C3yI/m+teFH3O8aDpWSawTGcGCMtsi3LHv/FshxuMHOCiY8gsKv/tcwoHofkr25aTQTlJEuNF3m0QnBQ53TsY+iS2OgUn3TCLptWeL+AJq9aqatwPirN7ksQRmm8UfyeS/rbMbcUf7OHUB1MWRScySgUkwbPEqk9O5mMJOranUQ=
Received: from VI1PR08CA0108.eurprd08.prod.outlook.com (2603:10a6:800:d3::34)
 by VI1PR08MB3341.eurprd08.prod.outlook.com (2603:10a6:803:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Tue, 12 Nov
 2019 11:10:01 +0000
Received: from DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VI1PR08CA0108.outlook.office365.com
 (2603:10a6:800:d3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22 via Frontend
 Transport; Tue, 12 Nov 2019 11:10:01 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT003.mail.protection.outlook.com (10.152.20.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Tue, 12 Nov 2019 11:10:00 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Tue, 12 Nov 2019 11:09:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6f627c228f40903a
X-CR-MTA-TID: 64aa7808
Received: from 9f68840dfd37.1 (cr-mta-lb-1.cr-mta-net [104.47.13.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5EF64857-DDAD-4E5E-9E93-CD9DBD241507.1;
        Tue, 12 Nov 2019 11:09:53 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9f68840dfd37.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 12 Nov 2019 11:09:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbIs3nBrVNerzE9iH9gLlEw25OIgvyhjWcKc2U7Io6mEICflPr7OFOjwDG0gPx3IGhlc+UA6CDVnv6b/BVUitRYScJtvcCTPDWiu5z6qjeIxYxnW0+hcXY3Y9xQ7VZmOmeQgUvRZshVQyXL5e/gGKUgHsjERH/ccHZQc9nDXx3X3qgSHaBXW4juZEiQlQ6235eL5oeJHg2UW8lzUoXwZv2tD/poBfxf3r0SVdM4ySBlZZheY1kSnbpt9TYbq/6AJarLWBW4dZtJIbL0jjxF4JacuVYrLb8cx8WFnSTnI549owFfNCQBYiAMQyV168PCypXKsGWDe4f1uw1wjFgB9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsZ15Yl+X1HBg9E+9H28CUeamfDtYCZbnyRDQ7bPAes=;
 b=blo76NZTHjwpLFXXZn8oyNGzRXzrfTT/q9/0a/jq9ukd1qnkYMi6HrXxHKX0tI7WwKLykgrCXFJTCERnMFNsakt9ZUPJmV5sByAqaV0HUQg/zTkdKtzcTiCUxIgI9pabRo50rqfLOC+MuH2+1iDNIfs6T4cQfLxXLLe8Y32vlxzMer77KuL5miisw1fMZCb7EV/1HbhYc87bo17X7WG9hXjZtkLC7AovDjmkwSnWZe9KiNT9Fcj1Qkj0PGOVq5xc6Fz80+cInpNKd9HJuNfWa5I9WlbavXTPs7ErkDdx5JPtdADbVXPDOuNdXdhYLKVK3UPCvaxofK+qpGiLrKGU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsZ15Yl+X1HBg9E+9H28CUeamfDtYCZbnyRDQ7bPAes=;
 b=C3yI/m+teFH3O8aDpWSawTGcGCMtsi3LHv/FshxuMHOCiY8gsKv/tcwoHofkr25aTQTlJEuNF3m0QnBQ53TsY+iS2OgUn3TCLptWeL+AJq9aqatwPirN7ksQRmm8UfyeS/rbMbcUf7OHUB1MWRScySgUkwbPEqk9O5mMJOranUQ=
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com (10.255.30.207) by
 AM0PR08MB4481.eurprd08.prod.outlook.com (20.179.36.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 11:09:50 +0000
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0]) by AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:09:50 +0000
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
Subject: [PATCH v10 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Topic: [PATCH v10 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Index: AQHVmUmzadJRLQDUbEqKWZFNceLR8Q==
Date:   Tue, 12 Nov 2019 11:09:50 +0000
Message-ID: <20191112110927.20931-1-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8697d3b7-d6e6-431c-3c21-08d76760dc75
X-MS-TrafficTypeDiagnostic: AM0PR08MB4481:|AM0PR08MB4481:|VI1PR08MB3341:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB33412653B2E2FEED658D344BB3770@VI1PR08MB3341.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 021975AE46
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(66066001)(110136005)(486006)(8676002)(476003)(81166006)(81156014)(8936002)(103116003)(1076003)(2616005)(186003)(86362001)(2501003)(54906003)(305945005)(25786009)(7736002)(71200400001)(71190400001)(14454004)(256004)(55236004)(36756003)(966005)(316002)(478600001)(14444005)(2171002)(52116002)(102836004)(6486002)(66556008)(50226002)(66476007)(66946007)(6506007)(2906002)(66446008)(386003)(6116002)(3846002)(2201001)(26005)(5660300002)(4326008)(99286004)(6512007)(6306002)(6436002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4481;H:AM0PR08MB4995.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rCmpBL2rLFr67aSbp1R7RJ2zXtrvEnsSbLkuGa7XvZ1637/pGIpG2r/iZXsJe++j4p1zhgFPex1ZzUPTGLLnUecJ8tsyvQm42mETYoZlqI73agPl4ecFgBwj69J7Xwrm5kjfh6fVdLJPAFVnDtRAi/kGSHiGym28CTzo8E6frcbf5Mh++l8SiagNvGgP6UoYIS4/HoNoDzd7tiB2Bz5CP5F41umYAwOxC9HdEVfy8RW3LoPDjgx9Wy6/hM5y3QIXU7rMxiNNmiI2Hhne3HB9+t5xpONyCXEITwaYMyONZ8Vd9HBz1KHGHdRXj91rKqdiljX6nmGwvpTA2Dz4Ep/+1DSSaAgKKpAfPbPT5hyaWVcglTeyHPl2jvxOUqWMX19TVFkTOqxfu+VOebVopgzj8bL5nc7aFOMGLRdNYYxt17dhLr8A1mHHHIPVUZGpAuLs2Gs/Sx4fgppkSZDy398QkUFvabYugYxBNQkil2XPZHE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4481
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(1110001)(339900001)(189003)(199004)(4326008)(2201001)(54906003)(6512007)(81156014)(316002)(23756003)(81166006)(70206006)(1076003)(110136005)(70586007)(14444005)(305945005)(6306002)(2501003)(966005)(7736002)(14454004)(86362001)(2171002)(8676002)(6486002)(478600001)(76130400001)(26826003)(66066001)(103116003)(102836004)(36756003)(50466002)(386003)(6506007)(99286004)(356004)(186003)(22756006)(126002)(8936002)(8746002)(2906002)(47776003)(26005)(3846002)(336012)(6116002)(105606002)(2616005)(476003)(486006)(50226002)(25786009)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3341;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 364e61cc-bbf5-4f01-f6d1-08d76760d5f5
NoDisclaimer: True
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcCPckgcRzkyrkg9BKMtYydYYyQbyjdtI68B7fWgxCmS3iiCJUaCVXyD06gOl8rUySMqdQKoJrFwUDz2K3IYyjwdZdmlPZMmXXRsOUw1m+a0bMOWru90kO43RPYIyYIcAd2L9ssZ/iusVgDZHWQwt1omUORNkZbnbpierg1Q9UQmW+sbQazrZ8Ey/YdyTIvKU8avnTnPIO6DWH/Tzzz3tkncucEUle4kEH+EQMg87JFvYGrwCF2Qc56a8EAMUthjOZkl59E+nchP04CdiMNbhobMGtLakPykTx4PQ0trH9PgE+SRAxfodMAndbChpmiUVRRAs/sT/SPW6ea24HVyc3f06IGg6zGs0Rq4QrC3U3M1DNLQBpTAS/LWrocRkrb5qR7O0qUr1JO0/w6JuVU8ztUdoAMfsC2hyRmXIH0c1Wf0GUGDWLaod7tCGTz31y9ZhApNI0Y2XuuabWpdz9U3Q41pNU7N3Eyo+h1LRJlJ6fM=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 11:10:00.8695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8697d3b7-d6e6-431c-3c21-08d76760dc75
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3341
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
 drivers/gpu/drm/drm_color_mgmt.c              | 34 ++++++++++
 include/drm/drm_color_mgmt.h                  |  1 +
 8 files changed, 141 insertions(+), 1 deletion(-)

--
2.20.1
