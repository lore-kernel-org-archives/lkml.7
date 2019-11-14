Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0468C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAABB20715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kWkuYjqS";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kWkuYjqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfKNIho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:37:44 -0500
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:19469
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfKNIhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN0Zft+P/jNTEUbHl8hqlOshKgMPAYdWizfLu3gpML8=;
 b=kWkuYjqSlVSWcnPsMi0B2sQbMcUPJ/oz7lQccbnonlxqlSIYrw5sfa45/1z6BfaFQrQ0a2qtimin2F1zPqL3lV7s7teTM4YlZXsGx34YyId4m+KGdmuWDbj5rtl0uFxJXVeep3lK98U1jcyD2rT+TXZ+6mOlg8qqX7QMcZqLfmY=
Received: from AM4PR08CA0060.eurprd08.prod.outlook.com (2603:10a6:205:2::31)
 by AM5PR0801MB1972.eurprd08.prod.outlook.com (2603:10a6:203:4b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Thu, 14 Nov
 2019 08:37:26 +0000
Received: from DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by AM4PR08CA0060.outlook.office365.com
 (2603:10a6:205:2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Thu, 14 Nov 2019 08:37:26 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT024.mail.protection.outlook.com (10.152.20.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Thu, 14 Nov 2019 08:37:26 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Thu, 14 Nov 2019 08:37:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ce607195e87fc3c6
X-CR-MTA-TID: 64aa7808
Received: from cb522d1172fc.2 (cr-mta-lb-1.cr-mta-net [104.47.4.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B9B3BC75-96E3-4677-866F-D5DB87C9C979.1;
        Thu, 14 Nov 2019 08:37:20 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2053.outbound.protection.outlook.com [104.47.4.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cb522d1172fc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 14 Nov 2019 08:37:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6xcU38Z/c8dn5XR546f5a42rgFxxH8X02t2hU603Trkkz5fW9GWSWuIeLCq2MCxqV7jQg3Nbu6aJBHDx4LKph4Guw1r9BVpno2k476L/Y0sbipIpdCpsA0UuKtgiQmI0cQvs2nvIJpTcsW6tSADr2wVukd0okOujC62gsrZR0CDtl35aIPbWpEjIrh8Q2qsSQtpMHBsJwsxKfzrTZeIYPV6kyzivHnldMKG2zeBv+NWJiFFN7EDSrVaRRopFWDzdyqDSpVpl7IsaqR9kbQMwhJC2E0PRqJ0POyYMlYEqxlhC69lmm/aD9YY98vW6GXxRxcGreJkWEXPlzH5voEF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN0Zft+P/jNTEUbHl8hqlOshKgMPAYdWizfLu3gpML8=;
 b=SkScu9cdSIoP/EK/34DmKEqVdCUXWDr+gd/GXExHUVPeBfWEEzQJJ23LD+Ab4dBPQv7giEJAFIDtH8jP4JgqmD04RTXZ9VEgyxA48g71cj7+o87/lJSd4onmQk5BVG9AyQQ3jdXbD7enM0xGQ+8f6ETT67m73SCmFuUp/iZ6+iuYr7Q+xcTV9+eX8sg56KT8XP0yblsNxOUO5KO0YsxKKGMM8BL1JHwry0TK5F2Ky1ShAi4JniFrmDyYQhK5iEevA/P0bEeaJg/Vw1UiI2NfD8fgxr7JQ9JYszuiHpKvTfZ9lw72e5WQ+FWLN9uXI8UDgcaYFg1YTr8n96xhwPBLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN0Zft+P/jNTEUbHl8hqlOshKgMPAYdWizfLu3gpML8=;
 b=kWkuYjqSlVSWcnPsMi0B2sQbMcUPJ/oz7lQccbnonlxqlSIYrw5sfa45/1z6BfaFQrQ0a2qtimin2F1zPqL3lV7s7teTM4YlZXsGx34YyId4m+KGdmuWDbj5rtl0uFxJXVeep3lK98U1jcyD2rT+TXZ+6mOlg8qqX7QMcZqLfmY=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4768.eurprd08.prod.outlook.com (10.255.114.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Thu, 14 Nov 2019 08:37:18 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 08:37:18 +0000
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
Subject: [PATCH v3 0/6] arm/komeda: Add side_by_side support
Thread-Topic: [PATCH v3 0/6] arm/komeda: Add side_by_side support
Thread-Index: AQHVmsa5hZBsqwaKCk6udCfTKRiLJA==
Date:   Thu, 14 Nov 2019 08:37:18 +0000
Message-ID: <20191114083658.27237-1-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: e3d4b7be-7044-49c3-ba32-08d768dde101
X-MS-TrafficTypeDiagnostic: VE1PR08MB4768:|VE1PR08MB4768:|AM5PR0801MB1972:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB19726BE595C2DE54CDD77567B3710@AM5PR0801MB1972.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 02213C82F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(136003)(39850400004)(189003)(199004)(71200400001)(71190400001)(36756003)(305945005)(2906002)(7736002)(110136005)(54906003)(6116002)(316002)(3846002)(99286004)(103116003)(6486002)(8936002)(2616005)(476003)(6436002)(66476007)(66556008)(64756008)(66446008)(66946007)(478600001)(6512007)(50226002)(66066001)(486006)(14454004)(2501003)(5660300002)(52116002)(256004)(14444005)(386003)(55236004)(25786009)(6636002)(102836004)(6506007)(8676002)(4326008)(26005)(81156014)(81166006)(1076003)(186003)(2201001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4768;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vjBad1EY4U2lSzi0N7Jx1n916/pzuhEXhc13JJNnFsVbAVeIoxH4sGd1c0W5nTLum+jgwZgLRCUmM0Uj5jUcMjVAXeN2wyriUL1d+w1F9e1qvbJ2kMZ8gkCsJWkcXaz0uo+6coDsj/KQUri/zlfoQAxClabtIMlUGIyS8QLp47yWCq0nkfTGG5w+mcFdNiQ66tBJv03Dl+NBO5hVOc+u3L5HjxNXQG92xtM7In02lZuALfR/ojGewybDrGAmPe0ECv4CPDsu5H20EY4ZRYxiNMvFCcEuS+ZbzKF/yFE/008dgLBObSfb6E+1bvZvJVCL0iCVHXGmXFeAJbi1tRGIZHKhMrFvy1z+QWNdO8Gowf9R5TPjaBs/xrm4PR5kqB5I1dO+k+F0EIgVph8azkDjBPK4hpj2LcHSDmG+1vcevrRw04hyegDcvx+vaTdYYswt
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4768
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(1110001)(339900001)(189003)(199004)(316002)(305945005)(7736002)(47776003)(14454004)(6636002)(110136005)(5660300002)(25786009)(3846002)(6116002)(26826003)(6486002)(14444005)(36756003)(54906003)(102836004)(126002)(2616005)(476003)(4326008)(99286004)(66066001)(186003)(26005)(486006)(336012)(478600001)(386003)(6506007)(105606002)(70206006)(356004)(2201001)(103116003)(86362001)(1076003)(50226002)(70586007)(23756003)(8936002)(2501003)(81166006)(8746002)(50466002)(81156014)(8676002)(76130400001)(6512007)(2906002)(22756006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1972;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e7ff8c80-3e7c-4a34-e59a-08d768dddbaf
NoDisclaimer: True
X-Forefront-PRVS: 02213C82F8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1b33FC1TyA2yVq5BajB7kvW3O5zgsEV2UKrXHjv3ht3LXU9wSQpFoMIY/quny82aFKN/6K3/pIngDGY9KMBQyvv+Pjv6jrI6PQOiJORmx7nqY5H8+yutfVc/iLx2+Nkb3182RggtUtXU6BFk6v6rjjuyJFL6QAwOexytwEx71e867SDt062qcw6QvMWdFUJe+haqMgezRJDaUkGUAAPsoKuq1CXt5cBaBZinWymDrvfmVuHfqmx70qND8Xu/IBaBx1c2cpgfXO3sQdJNVt4UsWb4d0FiPteqyMu5AtfUgkBXwFMrC4zGu6sG5+Oso8oosKiERm28ZSrAstztpTE9V7Rj4J4wd/7ya1CDaXIsVo+FvpCetJzk4s4hGMPNmJx4ad5LghGI0y71MEu13W7927g211HsbKpbNzbw4bjMrHJG5yldiiT5Wwx0IJjtsr1E
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 08:37:26.7511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d4b7be-7044-49c3-ba32-08d768dde101
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1972
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Komeda HW (two pipelines) can work on side by side mode, which splits the
internal display processing to two halves (LEFT/RIGHT) and handle them by
two pipelines separately and simultaneously.
And since one single pipeline only handles the half display frame, so the
main engine clock requirement can also be halved.

The data flow of side_by_side as blow:

 slave.layer0 ->\                  /-> slave.wb_layer -> mem.fb.right_part
     ...         -> slave.compiz ->
 slave.layer3 ->/                  \-> slave.improcessor->
                                                          \   /-> output-li=
nk0
 master.layer0 ->\                   /-> master.improcessor ->\-> output-li=
nk1
     ...          -> master.compiz ->
 master.layer3 ->/                   \-> master.wb_layer -> mem.fb.left_par=
t

v3: Rebase

james qian wang (Arm Technology China) (6):
  drm/komeda: Add side by side assembling
  drm/komeda: Add side by side plane_state split
  drm/komeda: Build side by side display output pipeline
  drm/komeda: Add side by side support for writeback
  drm/komeda: Update writeback signal for side_by_side
  drm/komeda: Expose side_by_side by sysfs/config_id

 .../drm/arm/display/include/malidp_product.h  |   3 +-
 .../arm/display/komeda/d71/d71_component.c    |   4 +
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  54 ++--
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |   4 +
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |   9 +
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   8 +
 .../drm/arm/display/komeda/komeda_pipeline.c  |  50 +++-
 .../drm/arm/display/komeda/komeda_pipeline.h  |  39 ++-
 .../display/komeda/komeda_pipeline_state.c    | 277 +++++++++++++++++-
 .../gpu/drm/arm/display/komeda/komeda_plane.c |   7 +-
 .../arm/display/komeda/komeda_wb_connector.c  |  11 +-
 11 files changed, 421 insertions(+), 45 deletions(-)

--
2.20.1
