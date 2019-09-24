Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B704C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C6F214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="2/rbwzHd";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="2/rbwzHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409292AbfIXH02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:26:28 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:3339
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409285AbfIXH01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1qONKm7zLfHHGS3KQK0e+VJDfs5imqssR67PDyd8Cw=;
 b=2/rbwzHd83C4OPAtTczUFpdyilkvoFwrvY7MuzsI01iVzi0VjK5ZN2oGeBVMHFOGBLLSiL4Nv1puTMWXV9fTQMWsZIGT5wFZbh/pVNPmm5ONVNwhhWmgJRBu6eRwfVxor5LV85NeyYrIHDPcy+zLoNRu3Udqn8lyolAN/DGebco=
Received: from VI1PR08CA0141.eurprd08.prod.outlook.com (2603:10a6:800:d5::19)
 by AM6PR08MB3048.eurprd08.prod.outlook.com (2603:10a6:209:46::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18; Tue, 24 Sep
 2019 07:26:21 +0000
Received: from DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by VI1PR08CA0141.outlook.office365.com
 (2603:10a6:800:d5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.23 via Frontend
 Transport; Tue, 24 Sep 2019 07:26:21 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT056.mail.protection.outlook.com (10.152.21.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Tue, 24 Sep 2019 07:26:19 +0000
Received: ("Tessian outbound 96594883d423:v31"); Tue, 24 Sep 2019 07:26:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cda21f6be1be124b
X-CR-MTA-TID: 64aa7808
Received: from 621e70ca2ba0.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CE4A5AFC-25C9-4936-81B7-6EDA065A4D1F.1;
        Tue, 24 Sep 2019 07:26:10 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2056.outbound.protection.outlook.com [104.47.2.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 621e70ca2ba0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Sep 2019 07:26:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFw3E3qlZO1lgH17ijz7O2N303r+SI14zHctYS0VOa5YsxeQSq7yV1CR6YFtrfXups+Q1OabUJtX8myw8P9yL5e0d/28a0oBGUtBzM9Hshh5yxOQNL99Ap8yci1TdnIi8FsjbKKnsAfR0J0QvxXET/PveiarMH7a3fCfAEUfUyk7VFQ7nYfsTAS62TO8tH1m6rXWjV1gqLVC/EYqAvWt6zlBwloXoICnA1sC3+mhDPVMgtxpRUsxasbsSIAKS62jq97AMVXXmH+scgsOosDhw/f9JKXPd5pE23W1z+2FznEZXA8I8CT43hcGktKrhVBhVBKjWBBwpALLPV4eIa4HAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1qONKm7zLfHHGS3KQK0e+VJDfs5imqssR67PDyd8Cw=;
 b=jxJvRwZRqwMhT+zdLowUfcB1Oh0ZeZ/F0OrBkoMCceDHiftSq887p//1DkvzJ7LPr7JutIO8G8T0qcZXzPBCQMllM9sheeKYakNy18wEkcT+MnHFS8r1ks86l6ZjQ1W81zkiNhWiIEx78cUOJL0kRDenvByS9tM37U+I3bnP4/blNbdiFM6YxZeZvoK6E85+SK5l8Ho2qWGT5vsymzaoSimUBB6l5WkdvxoFMvNhk38Qkr4/pkCqR0aOWya2WHwSjHHGnpZutMSI2w2tlxAqduv6Np+Wc4PXmCyl9qiLCJJYxxBAQ3zcTVKFDjCF6D0xgqNQAe5eQLWX/BBMG62cng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1qONKm7zLfHHGS3KQK0e+VJDfs5imqssR67PDyd8Cw=;
 b=2/rbwzHd83C4OPAtTczUFpdyilkvoFwrvY7MuzsI01iVzi0VjK5ZN2oGeBVMHFOGBLLSiL4Nv1puTMWXV9fTQMWsZIGT5wFZbh/pVNPmm5ONVNwhhWmgJRBu6eRwfVxor5LV85NeyYrIHDPcy+zLoNRu3Udqn8lyolAN/DGebco=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3998.eurprd08.prod.outlook.com (20.178.126.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 07:26:08 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b%3]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:26:08 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: [PATCH v2 0/2] drm/komeda: Add layer line size support
Thread-Topic: [PATCH v2 0/2] drm/komeda: Add layer line size support
Thread-Index: AQHVcqlVmhY/YSfl3kekDKd3eVM8yw==
Date:   Tue, 24 Sep 2019 07:26:08 +0000
Message-ID: <20190924072552.32446-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::16) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 46b398b5-5508-45fd-5e43-08d740c07e6f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3998;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3998:|VI1PR08MB3998:|AM6PR08MB3048:
X-MS-Exchange-PUrlCount: 2
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3048E8F3018BD5DFA5712E3A9F840@AM6PR08MB3048.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 0170DAF08C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(50226002)(102836004)(478600001)(55236004)(66556008)(316002)(4326008)(66946007)(2501003)(25786009)(476003)(186003)(66066001)(2616005)(52116002)(26005)(6506007)(386003)(54906003)(99286004)(4744005)(5660300002)(6116002)(66446008)(3846002)(966005)(8936002)(486006)(1076003)(86362001)(8676002)(110136005)(66476007)(64756008)(81156014)(6486002)(36756003)(6636002)(71200400001)(71190400001)(14454004)(2906002)(6512007)(81166006)(2201001)(6306002)(7736002)(6436002)(305945005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3998;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: pKRgByjyqqXtp/ZvUhrE8C1DL3iojvf/kywFJ1TwGl27gLMD0F10yWg2qfNreQE2OnyxOhz6uu3LrCVUVRO6PqHCUN1SktGL6KLHjyykRsm2pRYZi38bXjEI//UwMEpirgPvSLaN/uA44KtbRzXn13vXzk9zhF1+bNkYwgnsBucFGOpXhHtUAQkCqhW+yq6jTsbSOgJk7xnL2A29aslTKmrkpqBXkuvtYPy8iCBHf+sb1bRGp/IOrHa2kNjCzKt9LvQzeQVdECgExyi9hjmfND1ENynxZeQQn9Ec+1pp/HR+y3wLP/UzR64MdS7RpB1YrUmV+DyDj1Y459zYWzStu0JwPu9ndo1RwzhOqTVtsNLxy8KfuA/jmD/y/nC1X6aUoClPbgFCncc3xbfOg1qu+TEwKHs3FsSye91Nv2itjJU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3998
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(189003)(199004)(305945005)(356004)(23756003)(8936002)(486006)(316002)(36756003)(336012)(4744005)(6512007)(81166006)(8676002)(81156014)(50226002)(8746002)(4326008)(1076003)(6486002)(66066001)(47776003)(54906003)(26826003)(6306002)(25786009)(14454004)(5660300002)(110136005)(386003)(76130400001)(26005)(478600001)(22756006)(966005)(6636002)(2906002)(6116002)(3846002)(2201001)(63350400001)(102836004)(6506007)(7736002)(2616005)(99286004)(126002)(50466002)(186003)(70586007)(476003)(2501003)(86362001)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3048;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f16ea686-3245-4a24-8da6-08d740c0774f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR08MB3048;
NoDisclaimer: True
X-Forefront-PRVS: 0170DAF08C
X-Microsoft-Antispam-Message-Info: xy5YVu4qqPqnguW82Vj6le4Puq3rRr5VPWKk1/cFqLLQWLhsHtTTCayTGFXJ9ooN8AZL8jYlfHRdcZtFMALIYi0U5OHUdMQcCDVxZmiQqb+bQu4A0tKtxosPQsBuXWH6VHeWwFeN/pvtod+6h6an+InYNw39qINW+sE0wXm4fkfB7tDg0eIhrTDTKfULzIpI8rKW379gL4pqAv5+bCeiT+Kboh1CMgDNuxcRdSHYg90xpEi84ewE6T7XUFkXe36H7+7L1kNkX+eN0aw7j3Gxh1BcAtPRgIf5Wcnkx1gEEPYPXP+f2KEofwL9+d3GVeT5fdHikQPVLBwSto5/WbdWKXlkvntI0i8muew457/P+skSI4AoD4Nq1g5UEjFs/ROT57qQrm2Lihff6J8hjyIryEiQ6xXbmkYIfigavBI9wtw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2019 07:26:19.4840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b398b5-5508-45fd-5e43-08d740c07e6f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From D32 every component have a line size register to indicate internal
fifo size, instead of using the global line_sz.

This serie aims at adding the layer line size support and check
accordingly on both D71 and D32 or newer.

Depends on:
https://patchwork.freedesktop.org/series/62377/
https://patchwork.freedesktop.org/series/62181/

Changes since v1:
Rebases to drm-misc-next branch.

Lowry Li (Arm Technology China) (2):
  drm/komeda: Add line size support
  drm/komeda: Adds layer horizontal input size limitation check for D71

 .../arm/display/komeda/d71/d71_component.c    | 106 ++++++++++++++++--
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h |   9 +-
 .../drm/arm/display/komeda/komeda_pipeline.h  |   2 +
 .../display/komeda/komeda_pipeline_state.c    |  17 +++
 4 files changed, 119 insertions(+), 15 deletions(-)

--=20
2.17.1

