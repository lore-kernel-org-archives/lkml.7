Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD6BCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F046F20862
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GfxNNiPj";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GfxNNiPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfKAGzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 02:55:39 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:65152
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfKAGzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 02:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1D24k7HU0R9r/oHzcqJoqA3lobn3dtEv+1CmAU99Gg=;
 b=GfxNNiPjc6hGwvXtOaEjgYDSwgMBLnYKCKacyTdOP9mMq+Ljnya2zXJe/UeBIUmW6pebf00l+DisixnPp6o3Rw9pZ65A/7TlUkh7CML+uFEPg/3m6Lj6RYYSqAYKG75YYd46A7pMvKzif+PNsbyfL8U2MSS2V3w3AVivjYiP460=
Received: from AM6PR08CA0003.eurprd08.prod.outlook.com (2603:10a6:20b:b2::15)
 by DBBPR08MB4489.eurprd08.prod.outlook.com (2603:10a6:10:cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Fri, 1 Nov
 2019 06:53:49 +0000
Received: from DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by AM6PR08CA0003.outlook.office365.com
 (2603:10a6:20b:b2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17 via Frontend
 Transport; Fri, 1 Nov 2019 06:53:49 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT057.mail.protection.outlook.com (10.152.20.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Fri, 1 Nov 2019 06:53:49 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Fri, 01 Nov 2019 06:53:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: afc7a4bc6c2ddb6e
X-CR-MTA-TID: 64aa7808
Received: from 365a51563c8f.2 (cr-mta-lb-1.cr-mta-net [104.47.12.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8528E9D0-152F-4980-8CC2-034399548CFA.1;
        Fri, 01 Nov 2019 06:53:42 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 365a51563c8f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 01 Nov 2019 06:53:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oij4OC59eut+RWuoaJVA9wFpdtsFr8IV7+PrBPf72gSVbbJ97UQJC61PJSlNsO+HFQwbRcpRStQWAqqX63tZrGH3OPkt0NKjxdEBif9v9oO9FhNJeAroPvrLjgbGcvM1z4IhWTcx0pNzawDB+3DLlXpd+C433ej3SQf1e7axjj49XaxaounnmASG0weYkvh2xIMVL1qwljVkfTVDE8fVr8tXpHFymj0f7W1JPyfVrbI4ryycrLgRDl1oYvx3p9HJZH2UDq3hkUiDKm+6IuKzU93dFUMAjIi6yOjHFajBwUCMZdqdBcxj7gJnlna7iDkh9apyWPcA0/FjSz+ZGrpdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1D24k7HU0R9r/oHzcqJoqA3lobn3dtEv+1CmAU99Gg=;
 b=hcvqukfHrBzOWLzAltkJHpGPpPCTCSDVlqnGgc4KHHQ83P1EWPOU19wCzL+9RfOPM6uQnWTrXL65AmUDX5hCOI0GHDZbVep5bxYSiI0eRVysXgeztgI1RHs1sDdhiTlZuwgzrpuZPhJWeCxIgudnfCgMaS0w89GGCH/pgFbFSyEznkoR1opuKEmIHQs5mAKg4KsBztH9S7bSLq7VnuprnnBZVS6/X3hA4mtEFFucn+ckm5EvLR1YaE6B4uajjvKl8k6O0y+x6SciPlYzKUM+87sjpsMhVnC8c41Kg+uy1LlhKLBWOIoxAQZUw23CL8nmopCmmXWOXJ4SgtxMiI8KNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1D24k7HU0R9r/oHzcqJoqA3lobn3dtEv+1CmAU99Gg=;
 b=GfxNNiPjc6hGwvXtOaEjgYDSwgMBLnYKCKacyTdOP9mMq+Ljnya2zXJe/UeBIUmW6pebf00l+DisixnPp6o3Rw9pZ65A/7TlUkh7CML+uFEPg/3m6Lj6RYYSqAYKG75YYd46A7pMvKzif+PNsbyfL8U2MSS2V3w3AVivjYiP460=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1SPR01MB0002.eurprd08.prod.outlook.com (20.179.193.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 06:53:40 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2387.030; Fri, 1 Nov 2019
 06:53:40 +0000
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
Subject: [PATCH v8 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Topic: [PATCH v8 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Index: AQHVkIEXNSRZprgrzkynrrlyleMEKQ==
Date:   Fri, 1 Nov 2019 06:53:40 +0000
Message-ID: <20191101065319.29251-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29e29d3f-4c2f-4b71-2aaf-08d75e983fdc
X-MS-TrafficTypeDiagnostic: VE1SPR01MB0002:|VE1SPR01MB0002:|DBBPR08MB4489:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB44890277520D8886BD4B384BB3620@DBBPR08MB4489.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 020877E0CB
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(66066001)(2616005)(486006)(36756003)(8676002)(966005)(14454004)(5660300002)(476003)(103116003)(2501003)(2171002)(86362001)(3846002)(6116002)(305945005)(2201001)(25786009)(1076003)(6512007)(66476007)(52116002)(71200400001)(71190400001)(386003)(55236004)(6506007)(6436002)(102836004)(6486002)(7736002)(14444005)(6306002)(186003)(99286004)(8936002)(110136005)(4326008)(54906003)(50226002)(478600001)(64756008)(2906002)(66446008)(81156014)(66556008)(316002)(66946007)(81166006)(256004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1SPR01MB0002;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: BO5NfdAZIUNwy+Y+uzRGCp2N7fan96Vx46NItzUSQk3DW/dmkAtNlv11pI7A+BIpouWH2ts9qUM/MjlpFBCzsp++jUrIDztpJKl6/WfPNyyiUM0CRKo2QzNW6PZy6E6cFm+rVrYFqGch30qMImcI2kzPVAIteI5J1jwL1LMk+U36COCia3zmP2v1TPldMwjpL9RCtTptw3LWo9FMQ4NVbmPuAOIJzuPjQKNSMzL2oX1Hv9HUrJMKPxt5wChIyeudRnYN3i/lxOBwOW3f0ZiX1vxdVA7DgMmxxEW7ohfngOlWqoj/RefIQ0D8SZ4A0SWHz2t8ibINNzqLnBL/H0N6qo9lkm+47Ns9Os5TwxTs9j0waYgPlb3DCPEseWjIbRJd65FEMmUJ+ebztdnDnW492VWlne5LXCHC2WLPAGXc5JykqKr1oHG1zKTi3YR1zoLuImykoBOBkm7YLj1DXcryfZcduH8zz3IAtlN9kx4OW7c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1SPR01MB0002
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(1110001)(339900001)(199004)(189003)(3846002)(14444005)(54906003)(110136005)(6306002)(8676002)(2616005)(7736002)(105606002)(6512007)(66066001)(50466002)(336012)(2906002)(486006)(2171002)(26005)(4326008)(25786009)(476003)(8746002)(23756003)(47776003)(81166006)(50226002)(8936002)(2201001)(6116002)(22756006)(966005)(103116003)(356004)(6486002)(86362001)(305945005)(14454004)(99286004)(1076003)(36756003)(5660300002)(316002)(186003)(81156014)(126002)(6506007)(386003)(76130400001)(478600001)(70586007)(70206006)(26826003)(102836004)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4489;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2ec3120d-4d69-4d85-d3a5-08d75e983a08
NoDisclaimer: True
X-Forefront-PRVS: 020877E0CB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urxdvtaVlN9tuflbWNrtwM9w8Sk4zxZ0pjbxK66bcDdj4lkpBx8eG0RtvWI6b09aDmW32eotLNpVVDPLM+IoVfJU4wn7BNsvC4ehwBAfOz4L7UXDat+8gNGD3fyuO3Vt8qDfsWlh7tFRs2oH0jYjU72UGdvSIBI7D+hDHD7aEzhAc0Hb8M6AaXnmQufGjvlIoE9Uj8CYdtW53Gh3k7r7cj34Zax0yp9ULb7KOVOMmRVvPHk7xxc3FX0aZhfmAd4ZmDuKNVnD9P/IwPtj9CcgDVGtAbMDRvTYNr/iXKevAfEzhugejeXtp6AhADyNEMFp1gp2EmtMnrROpq9vACA9KfKYjkrR5I8aNNBTeRsKK+N5uYOhvs3PDFHC61cpaObIuCUC7YCwL98Edq8j9Ysu+fBDwpe9l8/PhB56IAhm1mvG4xt/H5UA/IJ5Vqh3F6DkhsU4JMf4t3UiKCWDNqeyjDTk+abeCuBFBuF8gbP1FXo=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 06:53:49.5127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e29d3f-4c2f-4b71-2aaf-08d75e983fdc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4489
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
