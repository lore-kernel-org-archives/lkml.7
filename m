Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F589C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31EA2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yk6jAruH";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yk6jAruH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKUHMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:12:51 -0500
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:58702
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726165AbfKUHMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4eIsz9sa5Hw+dYQo5b5iiwiz5ceZQ+NK39VGfqrZS8=;
 b=yk6jAruHbAmcvb4hk9OE2ZRSMc72ZEgK2dMNRLlTz82pK3O1oHNlDfa3gSYBCdQBt29S4Iz1kHJTkYHvKaS9GeNymjztYDSEhyWiaFU8clROTyDSzBfZBUivw2VJV1lJDg6lWNLybNlhd9/NB8hdPL4V3Opyp+HdN/y0wkY5gKc=
Received: from AM4PR08CA0048.eurprd08.prod.outlook.com (2603:10a6:205:2::19)
 by VI1PR08MB3534.eurprd08.prod.outlook.com (2603:10a6:803:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Thu, 21 Nov
 2019 07:12:32 +0000
Received: from AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by AM4PR08CA0048.outlook.office365.com
 (2603:10a6:205:2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Thu, 21 Nov 2019 07:12:32 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT020.mail.protection.outlook.com (10.152.16.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Thu, 21 Nov 2019 07:12:32 +0000
Received: ("Tessian outbound f7868d7ede10:v33"); Thu, 21 Nov 2019 07:12:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 02f21577ff2f10c2
X-CR-MTA-TID: 64aa7808
Received: from ba210b15cad0.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F4C1910F-3EC2-4E78-B854-30B7F58CF210.1;
        Thu, 21 Nov 2019 07:12:26 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ba210b15cad0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 21 Nov 2019 07:12:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiY0h0c87wfRMBCdicUSjyPmS6nEh9lvC1+XLkmoaB0Av3vJp5nwTI5rif71lUssFjvDCy8plBhSg4GgjWyWyt3/2pwk+b88rnukFb+V2MAECKzhhK3SKGDoutn5Z42fhOxipXW99UyILnrFbpQ3HzjeXvIze9w51LKzwwI387t9e0MXEGxwIuc6dgt415Y4PyVLotA3vO2Pc5qneOUqxTv2iZMv0Oy80fjLUKZ8CSKdg92UNQiLz7TiXhgcL0ZRQKv2LeyAdvskmhXDxNBpe6co3ezE6cFxS+9Qyd7qK1xZBg9r6s7XcwYIu8Q9Uz+XxOWPHZ1vYooUPC6JIu0V1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4eIsz9sa5Hw+dYQo5b5iiwiz5ceZQ+NK39VGfqrZS8=;
 b=BiLF8DUzMkLkbFkWLNP7rKIJu+WHLii/X6AcgiSVQ+uUP3mEI4lbWbjsuN8xn9l9GVSwu0C/PSdeyFGsTqADjFbQ0C7scnuqorBxPIBNh4zzvgURWM0lcFVcT9IIIgX4vyx6rydOOzvNB1rbSgrFMAOpDSQgUbofFtpxUdPuxWE0OCXZhorde1hyb0rRe3JhWd7WxrY6CJEcHN+KhG0Fiz8QNe7bNLed4HHqx2tRivIwMtDjfFbnAuFk4UBKM+R6VlxDaEkeVTPHEMr6rrWRXCikOx5jONSbztI7mrRHFrntX2erACmOmuk0rbNNQbvAZYpUmYy4rWY9MTTCR6DH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4eIsz9sa5Hw+dYQo5b5iiwiz5ceZQ+NK39VGfqrZS8=;
 b=yk6jAruHbAmcvb4hk9OE2ZRSMc72ZEgK2dMNRLlTz82pK3O1oHNlDfa3gSYBCdQBt29S4Iz1kHJTkYHvKaS9GeNymjztYDSEhyWiaFU8clROTyDSzBfZBUivw2VJV1lJDg6lWNLybNlhd9/NB8hdPL4V3Opyp+HdN/y0wkY5gKc=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5069.eurprd08.prod.outlook.com (20.179.29.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 07:12:24 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 07:12:24 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v4 0/6] arm/komeda: Add side_by_side support
Thread-Topic: [PATCH v4 0/6] arm/komeda: Add side_by_side support
Thread-Index: AQHVoDsGkHfFxrNdHkS40M+Z6TvkLw==
Date:   Thu, 21 Nov 2019 07:12:24 +0000
Message-ID: <20191121071205.27511-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 963df451-502d-49c4-df71-08d76e522d4d
X-MS-TrafficTypeDiagnostic: VE1PR08MB5069:|VE1PR08MB5069:|VI1PR08MB3534:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB353441E4D2B9ACA87FFD6E49B34E0@VI1PR08MB3534.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 0228DDDDD7
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(366004)(376002)(346002)(136003)(189003)(199004)(386003)(6636002)(55236004)(102836004)(6506007)(256004)(52116002)(2906002)(14444005)(50226002)(7736002)(305945005)(66446008)(186003)(81166006)(81156014)(8676002)(8936002)(66946007)(6512007)(26005)(2616005)(71200400001)(6486002)(478600001)(71190400001)(6436002)(64756008)(66476007)(66556008)(86362001)(66066001)(4326008)(36756003)(2501003)(6116002)(316002)(3846002)(14454004)(103116003)(99286004)(54906003)(110136005)(25786009)(1076003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5069;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: W8gntgQtNwMTDBvI98seL79Kdg9vsYsrdIPoA+51BDU45/xo9Rsd7ojLFozmdi0ihTAtT1psAVMZ7PIOQ4OX2e3ccb2HZm9OkXZqIjGeDgvWXSXJlFo5smWuaIsocp0Q/vMtCz0rW2OFqfU7EpHM+UcmFN6lVSbKUpWR/aYO6vLgOA5ie6oLi33pgL1dDXhV3/5MTCZ8p3m2k3kTbLVnJ9Z02ahmXF+QcRk9UbugiVXbqPCq/HGPU2ofCkwBx+VroSJFb78CEgrNZv3lO1PIsT5JvtWtYgKKvro4WrGRnRZr588Gzpn2Z4dfIRvCzi4IifqnPZxsELd3NVpnjxtJPWuGGnvg0usJgyBdWZmb2AG9wUHeDsGG4wGOufYAkcxcuznXHsFXftEM/G0aU+XLJKpFCXMznjDlnT6HcpCfNuSnQQfE5XdwBsz5TIrbNbbw
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5069
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(39850400004)(396003)(1110001)(339900001)(199004)(189003)(23756003)(478600001)(336012)(50226002)(26005)(103116003)(2616005)(14454004)(356004)(86362001)(66066001)(386003)(186003)(102836004)(6506007)(47776003)(1076003)(36756003)(14444005)(5660300002)(36906005)(99286004)(110136005)(25786009)(316002)(70206006)(54906003)(70586007)(76130400001)(26826003)(22756006)(8676002)(6512007)(2906002)(3846002)(105606002)(6486002)(50466002)(6116002)(8936002)(305945005)(8746002)(81166006)(81156014)(6636002)(4326008)(7736002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3534;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 010c0b35-99e3-437b-0505-08d76e5228a5
NoDisclaimer: True
X-Forefront-PRVS: 0228DDDDD7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sxDrNVCJrBlX9DFJ8goXboulNdy8lDq2JX5aJoJkMi2XVkT7v0449eQZ+ujJ7mDLaNS2C1svpVO26vEUfJuGiBJsLFv2Krzd6gLhmxIse0GLViGYJOj4en//9C3mwSVE1B9baa+gDiapGwT16LrTLoBRFX3gw/tZ+HFgQa1luqgAJlHAAsdPVFFvIR/kpJE1dphP7H18MeK3DuReAQFGsBui9mYXmfXtHHuA8bmEu7HxcP47VAOZqanYeja3t7/FDiZ05bCN+fdfJpb44LmwtuaQApkrO0FGP+SnVPrB4fiTMsFbGW8EgxgWLbQlP7n7U6zQ2xqZggWBUHOSJMSWWeWqKSvTr4W/3QXhcia0qYx4x85rB5UBlLfKs3S9/IaNSzKBm9NE1ZGt7FgZPPStpeJeAJtQSh7SLrmt+p6U50xXra7fN2xpl42qq37RnAZf
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 07:12:32.1835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 963df451-502d-49c4-df71-08d76e522d4d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3534
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi: All

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
