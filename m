Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C431CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4B2214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Vxyi44lk";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Vxyi44lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbfJWGnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:43:04 -0400
Received: from mail-eopbgr50057.outbound.protection.outlook.com ([40.107.5.57]:5582
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbfJWGnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lTSa4rYX3Lu+7lcq+ZpvV7iUcBTi5ViWo+mOBrwSCc=;
 b=Vxyi44lkeaJ1b892p5s60h+IFKaa7Lc70/7tw7lF04Z4R3Rf+MhAHUMYRc2TixzW9pwZlhC/GrW++qRV4GYY4I24RozPy9Q/rFcF6sziKoy/yI4xCId2nTSN4FS+z6CZH5yLmoSxXx/ny6/MU9/AMG3ehYwKw+vZINA1ev7ik6A=
Received: from VI1PR08CA0205.eurprd08.prod.outlook.com (2603:10a6:802:15::14)
 by VI1PR0801MB2093.eurprd08.prod.outlook.com (2603:10a6:800:8a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Wed, 23 Oct
 2019 06:42:57 +0000
Received: from AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by VI1PR08CA0205.outlook.office365.com
 (2603:10a6:802:15::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.24 via Frontend
 Transport; Wed, 23 Oct 2019 06:42:57 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT021.mail.protection.outlook.com (10.152.16.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2367.23 via Frontend Transport; Wed, 23 Oct 2019 06:42:57 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Wed, 23 Oct 2019 06:42:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 749f9fa2822c9903
X-CR-MTA-TID: 64aa7808
Received: from 412c556dc9cc.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E0AD913C-C24C-4F21-BBAD-37BCAFC2CBED.1;
        Wed, 23 Oct 2019 06:42:50 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2055.outbound.protection.outlook.com [104.47.8.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 412c556dc9cc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 23 Oct 2019 06:42:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bD2Bl2q5fIQMLmQubbx+FqQGWv2Pw0bJt4EUi6ATZHpQo212nbD8PQmcPEW9Hqo01qClANMtgvem44TS0OypyHjPJ3rdw27emMZELL1wLznSe8lJPTPma+xErMLm7HPyMWVGa6aaTGhf4b8cr7EUj2ToSRfTusyOKhVjKXQ1fYevnKLR/DfK1VF/UTrgTmioQM//XkC/HmjcYUxxLm29S6jM6J0SkDGd4ATLxDbRXm0ckIhTh6eG+pT5UCXB7vY7UJgQs6FLaoVY55yfmCRnkx3cJtBbsH8EPYYjRgcJbGba7N9dxaHM3uh28DdMzhHtrd5SOVSi2dM92H+o//vC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lTSa4rYX3Lu+7lcq+ZpvV7iUcBTi5ViWo+mOBrwSCc=;
 b=Oi5R5p7gdP0PQVmrq2PHPJSxxHDYv2XULITj4qE6F/2jJGqXdzk64gk9cOcWIzhYLk2givbMd32XFaBDlunJaiuwUURnWCzggg1700mVDzwEycESaL3b84S/I7Uz0bjZdis2pRNf9ZL+Z/7xbwp4xa3e1I22fRPv1Y5HmdWiqzncnDMDf6lXjRCgsHL73HHU62e2YFbV+S4P+TBICxHifmU8drZewcqmNI2nzV5Spe1w54LRywO70kN1BVUpQNe/EIp9LBMU89IuV6cXntqCtjbNonBygctGOY85Aka2trUzPYCJCyCjEhtExR+6Bh9XwqmPKC3GyFXFFwrcZnOGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lTSa4rYX3Lu+7lcq+ZpvV7iUcBTi5ViWo+mOBrwSCc=;
 b=Vxyi44lkeaJ1b892p5s60h+IFKaa7Lc70/7tw7lF04Z4R3Rf+MhAHUMYRc2TixzW9pwZlhC/GrW++qRV4GYY4I24RozPy9Q/rFcF6sziKoy/yI4xCId2nTSN4FS+z6CZH5yLmoSxXx/ny6/MU9/AMG3ehYwKw+vZINA1ev7ik6A=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4672.eurprd08.prod.outlook.com (10.255.112.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Wed, 23 Oct 2019 06:42:48 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 06:42:48 +0000
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
Subject: [PATCH v7 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Topic: [PATCH v7 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Index: AQHViW0VA353AtWU20SzEX5jAx7+KQ==
Date:   Wed, 23 Oct 2019 06:42:48 +0000
Message-ID: <20191023064226.10969-1-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2de4b356-228e-4feb-fe1c-08d757843d69
X-MS-TrafficTypeDiagnostic: VE1PR08MB4672:|VE1PR08MB4672:|VI1PR0801MB2093:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2093428307CC2365EB5DF152B36B0@VI1PR0801MB2093.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 019919A9E4
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(7736002)(25786009)(2906002)(386003)(71200400001)(4326008)(36756003)(305945005)(6506007)(66066001)(2201001)(71190400001)(102836004)(5660300002)(26005)(478600001)(52116002)(14444005)(55236004)(316002)(86362001)(186003)(6116002)(3846002)(256004)(2171002)(966005)(66446008)(66946007)(103116003)(64756008)(6512007)(1076003)(66556008)(50226002)(6306002)(66476007)(476003)(6436002)(8936002)(2501003)(2616005)(6486002)(14454004)(486006)(54906003)(99286004)(81166006)(8676002)(81156014)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4672;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: P6jeJ0OFS6+P8ET+tc1BGhYCwoxta7oVSAVP7NSiye3CdXGviIPYVWklP8uBFXTJ/r6Ca3SmmqdRY5dDFf3VguN7yZuO7o5m3fciMd7afw63AzpUy+rvFHz9dSd6Xusg360Dig3CPL2tJVikYe2uQS3SgWxLKar5k4W0xm5YKVRrWUt6zfhCrwqKLgLNnPx0xKqVmd6rTKrHUK4YJOX/SZAJM0x2SlZ2mr4BTMU2Azk4B+znjm7ZJnFseu+FJwE5hLQom8t9UXD1/Qwraoa6Pk+xPz80PrMGUfhUxvtrW/4qHwrWW60xZk/VVXXagDWtQ100m9lVCU91r3kLUX+You5pS6/KZERoDmKeqT/emqs3/Ur7YbQcsC8jiwY+XedQxEL2nGT4sl16DkOk+sxsriezbYoQVmo367xtGGKqT4YVcRaZ1UlMgtcKd5E4T7qw
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(1110001)(339900001)(189003)(199004)(7736002)(1076003)(478600001)(6486002)(105606002)(6116002)(86362001)(70206006)(2201001)(76130400001)(3846002)(2501003)(356004)(26826003)(14454004)(2906002)(25786009)(966005)(70586007)(8746002)(81166006)(81156014)(50226002)(8936002)(103116003)(305945005)(8676002)(110136005)(186003)(36906005)(54906003)(5660300002)(486006)(47776003)(316002)(14444005)(2171002)(22756006)(99286004)(102836004)(26005)(36756003)(386003)(4326008)(66066001)(6506007)(6306002)(126002)(476003)(6512007)(23756003)(336012)(2616005)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB2093;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 69611141-e065-4ee6-c747-08d7578437f9
NoDisclaimer: True
X-Forefront-PRVS: 019919A9E4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etUI+uV3ZyIokMU3K4FGaSUQkZOzWmpAFiW5tSVZZ4QmxsMp5gzhHYh3M7mdjZdT3Md+uRdynaMxO+2Waa1BVBgByCr/KqnbVTzIJzgh1QPGr1t2w7bgS9pS3Lr9rx8Lw9MrL9ZTGXaQL3/B8vTHuCpzTfuWlRoSM9oE4AHTBDbzrAjp8kIIBkD+qtE9gHabml2DtKOQuCgDidwjD8rWaYP44KNY37jqUBMo52Pf44TvqjR+vv89PqfUQVdW97lptd2gvhjWxXb8Ix9lHe2ZZ0DFGCNn4drc0+lYuHpq6BhNRQVnXe5AbDoIkav4+GLBmzktN8eELY66fWN0lKeF7Xy5+B30sXm7bQPNwyQMxduax8m4WgaULAFCeaERh5sdaGNQehb+y0QRSYNm+H9UPnUNCMuTShs4dU4Shn7p5M3D3Vm/zXg+v1WKUOFLhE7XM2Xh5Mpe2O1adxVtXVau76jogSfqrYArgznflRgqIN0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2019 06:42:57.3280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de4b356-228e-4feb-fe1c-08d757843d69
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

This series enable CRTC color-mgmt for komeda driver, for current komeda HW
which only supports color conversion and forward gamma for CRTC.

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
 drivers/gpu/drm/drm_color_mgmt.c              | 36 ++++++++++
 include/drm/drm_color_mgmt.h                  |  2 +
 8 files changed, 144 insertions(+), 1 deletion(-)

--
2.20.1
