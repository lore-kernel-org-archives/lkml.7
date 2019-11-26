Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E010C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F0D20722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="r9QLvUdF";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="r9QLvUdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfKZKyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:54:51 -0500
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:53414
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727777AbfKZKyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozdwu5i3/hwWTAt2jMApdS4K4ThKMteeTtH1N/yWWTs=;
 b=r9QLvUdFX3j5mLXDaxEkqwt/YpEaP/maOapu3XHdWvLF4syT/7Z88GzYA0kdl4cUuxuIds9W46/bTAczWIhb4PxgYk+zr2Dk1LNVhgGnsx64NkX+IBZmFWPCK4TphjBsOcxRJpGqLxrVsPelF3IE5TtmU1XhX0t7UBtPS2TeKwo=
Received: from VI1PR08CA0135.eurprd08.prod.outlook.com (2603:10a6:800:d5::13)
 by HE1PR0801MB1673.eurprd08.prod.outlook.com (2603:10a6:3:86::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.22; Tue, 26 Nov
 2019 10:54:44 +0000
Received: from DB5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VI1PR08CA0135.outlook.office365.com
 (2603:10a6:800:d5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Tue, 26 Nov 2019 10:54:44 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT049.mail.protection.outlook.com (10.152.20.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 10:54:44 +0000
Received: ("Tessian outbound af6b7800e6cb:v33"); Tue, 26 Nov 2019 10:54:44 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7ef36c54749ed1a5
X-CR-MTA-TID: 64aa7808
Received: from b7975cfa7963.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E951E974-0CD1-440B-B775-E251B687E412.1;
        Tue, 26 Nov 2019 10:54:39 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b7975cfa7963.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 10:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt/O2Ubn2uOMXEWyXVFp86QQAezwGbk5VOJ3USWT+BbB14f/8q61G3ei+okv/ZpqcMu6YxNhJQMouABg+RkEAqlv96EkfBqgYpb9AoUDvEh5o9Erypg72bsBIF5zooRWOHKwzFKtb7R4F6NyLdq4jes9qd0MQPiXRCWILMIG2OtFFj3L6obylt5iz7gNevzlxtyrFQDmykoBmzOxnhyr7bivzin9uPL3KyJvqAIWhrWahb2I8xUKl4UIMRjo+dnEUr1gNWpPxCeuBOtCMUVIKkFcTRWKr+h3OWJRJKNQBBq5gTh0fcs2mC+6DL0lNgSgrPdu2qEiveGanC8hIS/NEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozdwu5i3/hwWTAt2jMApdS4K4ThKMteeTtH1N/yWWTs=;
 b=gXapGLO/KPrVt/9tEpz2ROrCvXV0PGI0Q+RDZgH/6bXQnOK5OLZFtbERZi1d+DSoHvnilKPAjK+Saiyim/CSkRAuR/1ERA4LKe4jUnyxJg9Oio/6158SPt0nja4v9flqYoTKebkl6Cbd5ybDxylnToC2ZgPVR+fLG78uXrgg9r5hWeMAliEeFq+53sWU8/a6ViAnF+omj+73BX3RX88CeTFuWG8sEMQPtL7FzOutmEqeO/EuODoLscUzTAjoqioCXSiIqdSLRcz7pI7btdMCp/cB4cHfzm7MLnX7GXxRqVzXG+nhO/rd8WyZCsjt3fD7JIbrYtI/tRY8pM0AFIH0iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozdwu5i3/hwWTAt2jMApdS4K4ThKMteeTtH1N/yWWTs=;
 b=r9QLvUdFX3j5mLXDaxEkqwt/YpEaP/maOapu3XHdWvLF4syT/7Z88GzYA0kdl4cUuxuIds9W46/bTAczWIhb4PxgYk+zr2Dk1LNVhgGnsx64NkX+IBZmFWPCK4TphjBsOcxRJpGqLxrVsPelF3IE5TtmU1XhX0t7UBtPS2TeKwo=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4703.eurprd08.prod.outlook.com (10.255.27.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Tue, 26 Nov 2019 10:54:36 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 10:54:36 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
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
Subject: [PATCH v1 0/2] drm/komeda: refactor sysfs node "config_id"
Thread-Topic: [PATCH v1 0/2] drm/komeda: refactor sysfs node "config_id"
Thread-Index: AQHVpEfkVwoT4/6XW0a9YqN6H1cykw==
Date:   Tue, 26 Nov 2019 10:54:36 +0000
Message-ID: <20191126105412.5978-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0302CA0010.apcprd03.prod.outlook.com
 (2603:1096:202::20) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfb5381d-7e84-4639-95e5-08d7725f0c07
X-MS-TrafficTypeDiagnostic: VE1PR08MB4703:|VE1PR08MB4703:|HE1PR0801MB1673:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1673E12A0590859963431A4AB3450@HE1PR0801MB1673.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1332;OLM:1332;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(2616005)(6436002)(71190400001)(71200400001)(50226002)(6486002)(3846002)(6116002)(103116003)(36756003)(5660300002)(7736002)(6512007)(1076003)(305945005)(4744005)(66476007)(66946007)(99286004)(66446008)(64756008)(66556008)(102836004)(8676002)(66066001)(86362001)(54906003)(81166006)(81156014)(52116002)(110136005)(316002)(2501003)(14454004)(478600001)(186003)(26005)(25786009)(4326008)(386003)(6506007)(6636002)(8936002)(55236004)(2906002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4703;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9hfIXGC4JHtkDXH1pnml1jX6iSmZHThJfvopKj8JwpG4iJLyGHjQFzZZoRx0OlWZYr0xhEw5AH2g8z0UGkUb1fmh2NiFY8Mvu5TjDJf4Pc91dvmXZMiZxmsQ5vfc2quKeckAgrqhNatz4MQYLbP8rXvj6EVsWtwNgryAZCyaA5IlvZTpJU/+pTRI/AHqCnNSgIuI9bRGBUbhDu1UNXSncCpMUyky/qxHMJ/UNPqSTCQVLVxVtBIX0Wv6g1uoPm+dxRZRixx6G6661JyYyaTSINrv3hcegJdtKU3aecbULVi3regCdb64jcHgCGRkumf/ess+Hw+MgOcvCRHEsXjo81yVEiDYGPm4aC1azVNphJaOVfmI4D6u3KT7s3bUigkcioR7xMDxyzFyxiNRNvbE0JVzj4/JkNu2gxY9ub9azCNsO2HkpD1cK5PN3ST7wNFI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4703
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(478600001)(50466002)(4744005)(86362001)(26826003)(5660300002)(1076003)(70206006)(70586007)(2616005)(6512007)(6506007)(7736002)(356004)(305945005)(386003)(2501003)(336012)(110136005)(54906003)(8936002)(3846002)(22756006)(8746002)(36756003)(2906002)(4326008)(6116002)(103116003)(50226002)(102836004)(186003)(81166006)(81156014)(106002)(6486002)(316002)(8676002)(47776003)(99286004)(23756003)(76130400001)(6636002)(26005)(66066001)(14454004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1673;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4af862b8-8b87-4f70-d283-08d7725f06b1
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pexNrCCC6fN0POmkkwsGa7nfN/lTL5lPxdg7Qe7L6IrE9gcjiuC65CvyYsGLRt4TdhHwKWXMLTkhafPf5dFHX2pp0V4XV9mlp500evJC29y4LgAHNTq2+CnA8EYONWJBI+B2TWnRe0b1BQPzAVHMEYvEJAbsozg9ToK/exyBeoRtY9g9xOXJzds4Gl3IwHKIPqIavNRTGjQql2nEk1fTsZE5xSa8p7vtxQRjDE6as+7tUldloGc8vPV8j1ZVE05s+4AVN9thTwcfamp7xyQWSXflrtIMXjz9Z+rRfT86SCqLRvycAVpM6nUN0l2I/3Hqjfp2dLezlx+iN2+F3owR/Zw/vHl8YbhG7vzDc1pEypRBUN6UJXQvKBmz/r16E8Xol4goP+9WA9r5tidtROj/xJyTSIyaoo4F0WN618L9PZWKzf6cLfDzaFjOYAZRBRD6
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 10:54:44.4967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb5381d-7e84-4639-95e5-08d7725f0c07
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split sysfs node "config_id" to multiple files.

James Qian Wang (Arm Technology China) (2):
  drm/komeda: Add a new file komeda_sysfs.c
  drm/komeda: Refactor sysfs node "config_id"

 .../drm/arm/display/include/malidp_product.h  |  13 --
 drivers/gpu/drm/arm/display/komeda/Makefile   |   1 +
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  61 +--------
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |   3 +
 .../gpu/drm/arm/display/komeda/komeda_sysfs.c | 125 ++++++++++++++++++
 5 files changed, 132 insertions(+), 71 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_sysfs.c

--
2.20.1
