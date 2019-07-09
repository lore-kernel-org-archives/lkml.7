Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5FEC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F80214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="OtEuElw9";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="OtEuElw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfGIH5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:57:22 -0400
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:9710
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfGIH5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9SHeghH8YsF/Lbm6khjeKdt4e0RMCnaqrZAcIjzcA0=;
 b=OtEuElw9saz0MOZsHtpTrG0zvkOMmpL56V7Ua20lX/X4wBEt6NJSARtDNh0PZSd61xEHhtU9aBanmOHJOwZPl5iCen2sR5dzI/H5zqeYxkSIgB2Da7I8oETBpjdnvM6hHO+r7gmDcYjE0crr4+D4q/PEqOx2KYuawAFaXVLKK1k=
Received: from VI1PR08CA0139.eurprd08.prod.outlook.com (2603:10a6:800:d5::17)
 by DB8PR08MB4954.eurprd08.prod.outlook.com (2603:10a6:10:bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2052.18; Tue, 9 Jul
 2019 07:57:18 +0000
Received: from DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR08CA0139.outlook.office365.com
 (2603:10a6:800:d5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.18 via Frontend
 Transport; Tue, 9 Jul 2019 07:57:17 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT051.mail.protection.outlook.com (10.152.21.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 9 Jul 2019 07:57:16 +0000
Received: ("Tessian outbound a1cd17a9f69b:v23"); Tue, 09 Jul 2019 07:57:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 03038269163b7d30
X-CR-MTA-TID: 64aa7808
Received: from c78b36e33537.2 (cr-mta-lb-1.cr-mta-net [104.47.0.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CA6CCEF2-7370-4625-B2E9-28D8EFB98D99.1;
        Tue, 09 Jul 2019 07:57:06 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2056.outbound.protection.outlook.com [104.47.0.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c78b36e33537.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 09 Jul 2019 07:57:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9SHeghH8YsF/Lbm6khjeKdt4e0RMCnaqrZAcIjzcA0=;
 b=OtEuElw9saz0MOZsHtpTrG0zvkOMmpL56V7Ua20lX/X4wBEt6NJSARtDNh0PZSd61xEHhtU9aBanmOHJOwZPl5iCen2sR5dzI/H5zqeYxkSIgB2Da7I8oETBpjdnvM6hHO+r7gmDcYjE0crr4+D4q/PEqOx2KYuawAFaXVLKK1k=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4816.eurprd08.prod.outlook.com (10.255.112.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 07:57:02 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Tue, 9 Jul 2019
 07:57:02 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
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
Subject: [PATCH 0/2] drm/komeda: Add new product "D32" support
Thread-Topic: [PATCH 0/2] drm/komeda: Add new product "D32" support
Thread-Index: AQHVNivkfsTufjYJCUi/AKchas7bNw==
Date:   Tue, 9 Jul 2019 07:57:02 +0000
Message-ID: <20190709075640.22012-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::11) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: e80dd58f-2ebe-4357-2391-08d704430f4b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4816;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4816:|DB8PR08MB4954:
X-Microsoft-Antispam-PRVS: <DB8PR08MB495449C94F1C787EC84B8873B3F10@DB8PR08MB4954.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3173;OLM:3173;
x-forefront-prvs: 0093C80C01
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(66066001)(305945005)(7736002)(2201001)(64756008)(8676002)(81156014)(81166006)(66946007)(73956011)(66446008)(1076003)(8936002)(186003)(66556008)(86362001)(54906003)(110136005)(66476007)(55236004)(386003)(316002)(6506007)(102836004)(71190400001)(71200400001)(52116002)(5660300002)(14454004)(6436002)(103116003)(68736007)(3846002)(6116002)(478600001)(4326008)(36756003)(25786009)(6486002)(53936002)(4744005)(99286004)(6512007)(50226002)(26005)(2501003)(256004)(486006)(14444005)(2906002)(2616005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4816;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: HMZpwUTooPbtR5CSW8TMznPu91DtTTAmZbAMF2m99zM4qz4tj14nnDPBcvgekuSuXnHoJpFk3lS26OkKgDHW6D39wLgHYjCd5qry4Q0JLG9kTkJSTKuXUVYPuXMfuz5cz8JzWbiYqOiCqCAlnry7K+wtkDDzUCyQ2rRj/n9Y2CKCzV7u+PGsc1pbN1q5k22M3ZV4WMACFKXDnTNSKojcMVru0WNh3LsF7ebu2+8LBf/pAuQzXkyFS+YPzUvkMWps8z2ibq5WRAC9+jqpAE6hXR1puwR1euqYUIFkyvxBWl3XGCbhLsizE40T1OTygkFxq8cevhJw64e4zsCRIBygF4B/zDUrPw4oZNI7kh+gIlc66Nl45oRUY9UpPlzOvubvyOeGUqCO1GcSiY25klSrsNwTf1Boj9G9WfNrWf8vIuI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4816
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(2980300002)(199004)(189003)(47776003)(4744005)(66066001)(2501003)(23756003)(26826003)(486006)(316002)(6486002)(76130400001)(103116003)(110136005)(54906003)(25786009)(386003)(26005)(6506007)(186003)(2616005)(102836004)(6116002)(3846002)(126002)(99286004)(476003)(1076003)(2906002)(14444005)(336012)(14454004)(63350400001)(63370400001)(70586007)(478600001)(70206006)(36756003)(86362001)(50466002)(305945005)(7736002)(356004)(4326008)(2201001)(50226002)(22756006)(6512007)(8746002)(81166006)(8936002)(5660300002)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4954;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c08669e5-92c6-4387-801f-08d7044306b0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB8PR08MB4954;
NoDisclaimer: True
X-Forefront-PRVS: 0093C80C01
X-Microsoft-Antispam-Message-Info: Q/a94ptEIpqg3pMnwLOU08PnPfDLIbKFSTVWtxd2DXE9fSWovAkemYIO2iBUVI/akwk49VChPU/pBHSz43JFEXjr9Li00cPa+g5m7vIWHn0pJ8kR3hhnmsDMp67KCeOBKTaIM4ddhSSQA5U8SmTpI60U2woZDCMTrbPq8l2PvYi5twHpzV3BkwJivN4wCBpGrhEEVhjZ5m9FpAKgglUHOVNddlTGEATSa7GuUXDQuOII7GqiffTS8yfqlqtnQWtTZxc1r/eOVvP7wDGgFHxfNY2qIhlm2HB2KF900GknB1EhS09ODZuzOrUYfVDCxDSKa2FDcPIaVJ0B5ZTNytJSQWj4Te6xiiB14DgrChMty8v+ekJrYAQugNHew13J/Ikfq2qVz3MdXnWZRYiDo3sBCPK2X7cbE2bydjf78vK4VRY=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2019 07:57:16.1586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e80dd58f-2ebe-4357-2391-08d704430f4b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables new product "D32" support

James Qian Wang (Arm Technology China) (2):
  drm/komeda: Update the chip identify
  drm/komeda: Enable new product D32 support

 .../drm/arm/display/include/malidp_product.h  |  3 +-
 .../arm/display/komeda/d71/d71_component.c    |  2 +-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 70 +++++++++++++------
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 13 ++++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 62 ++++++++--------
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 14 +---
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 10 +--
 7 files changed, 104 insertions(+), 70 deletions(-)

--
2.20.1
