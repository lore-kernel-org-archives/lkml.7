Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A532C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 02:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F079320873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 02:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Izm72rhm";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Izm72rhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfJOCK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 22:10:58 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:13294
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbfJOCK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 22:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5HRz67eijzeWYcpzNtgVdq0TE9Z8vNJMmkqaVkQzqw=;
 b=Izm72rhmSwJlDJIpjd0npx8k7dUCmLJT/1IignRi6sbTeDr8j+5WXAeL7ZdDhyAe+OaWkXj4crBG4/Y67OZF9FVYVyKc7+YF2ro16cSnKdphlBr7wEopgIjDMkMIoVLfMvrA0td9xX/uJE9Mafr4cxk9nV8f+K+nTQsrZYG2mSk=
Received: from DB6PR0801CA0049.eurprd08.prod.outlook.com (2603:10a6:4:2b::17)
 by DB6PR0802MB2519.eurprd08.prod.outlook.com (2603:10a6:4:a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.19; Tue, 15 Oct
 2019 02:10:49 +0000
Received: from DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by DB6PR0801CA0049.outlook.office365.com
 (2603:10a6:4:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 15 Oct 2019 02:10:49 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT033.mail.protection.outlook.com (10.152.20.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 02:10:48 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Tue, 15 Oct 2019 02:10:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2a09fdb8b27f0855
X-CR-MTA-TID: 64aa7808
Received: from bac45403aab5.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6E88ABB7-A4AB-45F2-8561-53E65A73E125.1;
        Tue, 15 Oct 2019 02:10:40 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bac45403aab5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 15 Oct 2019 02:10:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tx+LM6dJblu3vTc7kI30eBXHWwx+tKuIxj2IFeFNMTK2afc8MYSS2MnW8a2pfcXQbuJzheRrgJHj0QdUgpGJ00xEoUNno5zKwuwEZ+jSXgGZmXp1dRo7NXgodkFALI3WUxeoc3rzG8Jhpf7ONC69qN3vC/eXKJqp7dRMI4XoI97U2W9i9tpMMnKuwSfEBhdRaSAb2mN0MsE3hRmt6bHzkYf6/a5WzGGNoPaz+sSIjs6su521jkGhd58/6gXXnUmEpv/+380Ma15zN+McPplcc/d8r9lxHTuzSinThwFQ7qx5YsxuyDFsYHp2jepewDJhyRi34hipwUNsiSttB3cfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5HRz67eijzeWYcpzNtgVdq0TE9Z8vNJMmkqaVkQzqw=;
 b=Sm13nW8G9K4v/9+o08tuADUz4cMvbWZlNzkKGysUe6ebVXzPiDULKNCZvfxEA03jtSbvGbN5K4ve/cOGwm2k7mYFQFsq4zHf1Rc+CL34bhqk4LAA0vgKaX1k+FptlTznsT37N9WAMbi3jGI3xufX+woM36Bj5or/+n2gs0z1Arim4aESXjuZMwMYFTiACSEhBxNwCuTgLZMOlScXRqhJJgvh5C2A00s86s2AH0J9IlQH5d9xoJlMNKN0hOEPIqOn7fQh2wdacuP4CxRctwZrCrPoH99Yyx2wBTE8GP6Y/Q3tJgSLnV3ObogiVoXSCRQe0UEvW8f2EiFH2lNqmo6bzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5HRz67eijzeWYcpzNtgVdq0TE9Z8vNJMmkqaVkQzqw=;
 b=Izm72rhmSwJlDJIpjd0npx8k7dUCmLJT/1IignRi6sbTeDr8j+5WXAeL7ZdDhyAe+OaWkXj4crBG4/Y67OZF9FVYVyKc7+YF2ro16cSnKdphlBr7wEopgIjDMkMIoVLfMvrA0td9xX/uJE9Mafr4cxk9nV8f+K+nTQsrZYG2mSk=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4799.eurprd08.prod.outlook.com (10.255.115.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Tue, 15 Oct 2019 02:10:37 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 02:10:37 +0000
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
Subject: [PATCH v2 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Topic: [PATCH v2 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Index: AQHVgv289rsMbYlLHUGqAFFZi7hqtg==
Date:   Tue, 15 Oct 2019 02:10:37 +0000
Message-ID: <20191015021016.327-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::18) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ffc12e38-68b3-4fa7-ba1f-08d75114e51b
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4799:|VE1PR08MB4799:|DB6PR0802MB2519:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2519E4D16D58C09B27872B95B3930@DB6PR0802MB2519.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(66066001)(476003)(110136005)(54906003)(66946007)(64756008)(66476007)(66446008)(71200400001)(66556008)(26005)(103116003)(2201001)(86362001)(6512007)(186003)(71190400001)(316002)(6306002)(36756003)(6506007)(386003)(2616005)(486006)(2906002)(256004)(52116002)(14444005)(55236004)(102836004)(2171002)(8936002)(14454004)(478600001)(6486002)(81156014)(81166006)(305945005)(50226002)(966005)(2501003)(4326008)(8676002)(7736002)(5660300002)(1076003)(6116002)(3846002)(25786009)(99286004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4799;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MuaZOcTFiyAAWqz0ivCSWQa2MVBc3ak1ofXvCDlFlHAlZwbcn147SPYDcnYHEaS8rdMXfvK5pJMxsB5NkQzBLE+lIsg78qIzP90T+nzW6Sxt56KHlguQE7D5O63JRX8dw4tyhyNzA1zhxG8t2X8+3VsNcjhv3+/hYFKnJHRCIp0+yI7/RKguMwUXmTgPbKxW5n6k+1azdanJFZrvUFSjoH51/A8FNKoQEUxqpTRcCMcZ7anhYw15lyE3S3sc//NylBaj0ORnr7GsXNgNgeCDItIF+5ZO2XxVcviwNFONqOQOJDM4T8CZaOT1V+yg0itSVuw/NZAzo9OJ/ccCBIVuFxnh3SRDqqB7AJajVOuwdLiqQczcvwE/KLoQsBMvtTGgjJzAs/HETz38nTWUjLRubiwrtfPFEwOrKG5QrupM2E54JRPCe/yUA7uUweYEJFTmxuoFQJbnjdO9hPyanEX36Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4799
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(103116003)(8676002)(26005)(66066001)(14444005)(186003)(2616005)(476003)(1076003)(486006)(336012)(126002)(99286004)(63350400001)(2501003)(6506007)(386003)(2906002)(102836004)(81166006)(3846002)(6116002)(7736002)(50466002)(305945005)(50226002)(22756006)(36756003)(8936002)(6486002)(81156014)(47776003)(8746002)(966005)(6306002)(70206006)(2201001)(5660300002)(316002)(2171002)(25786009)(110136005)(54906003)(23756003)(6512007)(70586007)(356004)(86362001)(76130400001)(14454004)(4326008)(26826003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2519;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3784d254-b0ea-4db3-944b-08d75114de9d
NoDisclaimer: True
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kmWKQNTvSWOYqjQZHkPRWsOVGBdM27QWhezmBvSqrdZbBLVFXChsOgFwlWAGMtW8DqeWqjvRNpxuuZ7HaUgJgpvVnoxBf5mdTMsaz5KHvINKaRmTTVYhhd8KDG9woBVy6MwLz/RXQei/ppO9mKDCx8sVKMqg1oaDpijNuXFvLB/8cVKW6Tag/TiaHPkyRfoeNKpTDf1KOlQFidMgRTuQPDnaYVTbMBt45IC7tv5NQC3UQifIggOFk/9Kba+TPR7KjSGQjk8hFH2K+40kW/rBW8jx5FWXDWi089Y2x2mO7Yw0jBmq9lOAQ5GCEsLuDGvLkw+eKXSdhGgkBt2vZuGov8OpH6y/2Fg2T40PYGzGa5RjXJDzLSKb1c7mQ32qBddUNquJmqXJ/aUto80IOBdN6MJw2IwR3jOiogVk8tOPSlwgwx+d5x6968k/tzjxk6E/QaWcCwcmPksl8cJDlHQGRQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 02:10:48.0719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc12e38-68b3-4fa7-ba1f-08d75114e51b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2519
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Lowry Li (Arm Technology China) (1):
  drm/komeda: Adds gamma and color-transform support for DOU-IPS

james qian wang (Arm Technology China) (3):
  drm: Add a new helper drm_color_ctm_s31_32_to_qm_n()
  drm/komeda: Add drm_lut_to_fgamma_coeffs()
  drm/komeda: Add drm_ctm_to_coeffs()

 .../arm/display/komeda/d71/d71_component.c    | 24 +++++++
 .../arm/display/komeda/komeda_color_mgmt.c    | 66 +++++++++++++++++++
 .../arm/display/komeda/komeda_color_mgmt.h    | 10 ++-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +
 .../display/komeda/komeda_pipeline_state.c    |  6 ++
 drivers/gpu/drm/drm_color_mgmt.c              | 26 ++++++++
 include/drm/drm_color_mgmt.h                  |  2 +
 8 files changed, 138 insertions(+), 1 deletion(-)

--
2.20.1
