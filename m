Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77F0C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746BA20726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XU73e0MN";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XU73e0MN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLJIs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:48:58 -0500
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:32526
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfLJIs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOWuTGlIb85XqmFSw5Y6ts0GT4ZqZESMemMiq0nEuaA=;
 b=XU73e0MNi030/MrdJL8H4VV6uf4mmgFA3qv1UNdITaqv1/SV9eE9NgKZd2b9C//Dn5KHvCt8lmI3+FwCjdmkbS6Kg75n0bfKqNt5FeiGtWHM+JS8DQhh8xe56q2dqQfMrr8hgNyv9lA+2rhufXxIsMKoc8NfbKYIAjtc4wtWDl4=
Received: from VI1PR08CA0234.eurprd08.prod.outlook.com (2603:10a6:802:15::43)
 by DB6PR0801MB2008.eurprd08.prod.outlook.com (2603:10a6:4:77::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.17; Tue, 10 Dec
 2019 08:48:51 +0000
Received: from AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by VI1PR08CA0234.outlook.office365.com
 (2603:10a6:802:15::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Tue, 10 Dec 2019 08:48:51 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT004.mail.protection.outlook.com (10.152.16.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Tue, 10 Dec 2019 08:48:51 +0000
Received: ("Tessian outbound 1e3e4a1147b7:v37"); Tue, 10 Dec 2019 08:48:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0a5805570502bca8
X-CR-MTA-TID: 64aa7808
Received: from 76e75d32b073.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 04062F71-9C93-42C1-AA2D-C3A19EC8F5B8.1;
        Tue, 10 Dec 2019 08:48:45 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 76e75d32b073.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 10 Dec 2019 08:48:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irO9ukmbTStOKE0iTd1DOnyGeZ6hYeA7nwETLSZTqJb31vvQ/FXtFieozaNod5t5iYiUSzCQMwIQ4vZFfIntQKqIDPKVC9/MJ6GasmKuqS99rY8+oMvQ1mrI3Z26U+8dEIAwGYAY0yjR5cT29AILjXUl0O3DboLLl5s9sj7BhM5tslFolps2p3dlXs9T8h2MHcOcyWRw29/0SQFMF9y6qx9j6PKeB/9tm3RbrNoAZ2k9TGXisdGnk3YLqG2VJh6szNVK7KB22g1YCSYqCLk35cNW9RDrdtM+vAwlQowOOJ5qqaoS/8mDaubXN4sOXy7LQQ9PD6V8lJdqeXIBJ9kkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOWuTGlIb85XqmFSw5Y6ts0GT4ZqZESMemMiq0nEuaA=;
 b=IR0f3/BFlaN3uDKvs1V7EY9zuoZwCxjHat+5tiS8t+xdwQQk3rq8CYj3mj+6/Pr1SraDji5I0cMDUJjYeibvkMKJEZlvBejAHsWf3N4HmcIMzCLUpVKFfZ+xJcd6dzcAoEuwW54G/tlp8ViZEn6r3v97WW6A0AZEqFtvbMazXFKyDUCmSR3bhjF0Pecr8hgKM4OOoI8jwpeM7y4IRhe75Es5fKnMSOvU1fIDnVWNEmXeHgFPOvMDk9fHZiKeI2rVepddwc1npnPyxgRlf456+ku/MYqzZO0Hxq1bmnyjh5RV5hGUGkmUog/tAw8aKrdMuXGUlWSxdHXqwB/uLCkxWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOWuTGlIb85XqmFSw5Y6ts0GT4ZqZESMemMiq0nEuaA=;
 b=XU73e0MNi030/MrdJL8H4VV6uf4mmgFA3qv1UNdITaqv1/SV9eE9NgKZd2b9C//Dn5KHvCt8lmI3+FwCjdmkbS6Kg75n0bfKqNt5FeiGtWHM+JS8DQhh8xe56q2dqQfMrr8hgNyv9lA+2rhufXxIsMKoc8NfbKYIAjtc4wtWDl4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5182.eurprd08.prod.outlook.com (20.179.31.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 08:48:42 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 08:48:42 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v3 0/2] drm/komeda: Add new product "D32" support
Thread-Topic: [PATCH v3 0/2] drm/komeda: Add new product "D32" support
Thread-Index: AQHVrzagsCbotHFGX02GRYU5HNi2+A==
Date:   Tue, 10 Dec 2019 08:48:42 +0000
Message-ID: <20191210084828.19664-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: LO2P265CA0283.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::31) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7bfb4d0-c109-448a-e7c5-08d77d4dc7a7
X-MS-TrafficTypeDiagnostic: VE1PR08MB5182:|VE1PR08MB5182:|DB6PR0801MB2008:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2008114B4EF89FA8E0DB681DB35B0@DB6PR0801MB2008.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3173;OLM:3173;
x-forefront-prvs: 02475B2A01
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(53754006)(54906003)(4326008)(66446008)(26005)(1076003)(103116003)(66556008)(37006003)(186003)(66946007)(64756008)(8676002)(66476007)(36756003)(6862004)(305945005)(2616005)(2906002)(71200400001)(6486002)(86362001)(4744005)(478600001)(6512007)(6636002)(316002)(71190400001)(5660300002)(55236004)(81156014)(81166006)(8936002)(52116002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5182;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LKBXS/kv77coucQl8Z8aaWbwk/dFllF7BB25gKs/v5VdCCcTKiTfN59hRZgRUyUmCM6ZcSyXC24APH3ZRXePJPAQweZbGKc/fEHTg9Gcbj8Fnv7UO4jtIp/f/LjJ9tt87NhbIcdC/qFzE7Im/nzWUNVwxbAjh8omwZ4ZaSUZU1znO9b34SKQSBgorEDB+1FceJy78AHi9rE/Epwxr9xPIPe4nRJElNbTEFALlkdehT42VWYAhABo/3JjzccwfUz/JD5kiakWW/oIQQKkYN1nICc5py59O0nj5pumCV+OTpzSbzQOACoLlfgTluTPCfkENeCivFYTEa4cQZG1bEwt5P+LGEyjjrgj7f50oqtsngA0i4NrIRoIU8/9ZtLeYR9EatW+PR4LTaxwSCLw0c5tXoUmI8JTKK2daCuSZArAT/DZXz65qGlT2yf1IV4n7wVJ8fxVplYQdFkEpKflBI6sc4XWToewnGApMEZMMgPPXtk5WnvioD2OC5Cnu6eAyDLq
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5182
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(53754006)(189003)(199004)(356004)(4326008)(8676002)(81156014)(6512007)(2906002)(2616005)(8936002)(81166006)(4744005)(26005)(5660300002)(36756003)(6862004)(103116003)(70586007)(6486002)(36906005)(316002)(305945005)(76130400001)(1076003)(70206006)(6636002)(86362001)(37006003)(26826003)(54906003)(6506007)(336012)(478600001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB2008;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e374416c-eaff-45c2-24f7-08d77d4dc24f
NoDisclaimer: True
X-Forefront-PRVS: 02475B2A01
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jKNE/j4/UOtq8UBRwRhZt2+fIpxk+K/Z/qYFzRHWev74jtV6UNJC/5hNANP3FcRW009WDoQl6Hlsi9GpZ5VPW4wa+Mi8HnQxFUGBN2V5bSrVUHJr4dRnA9gYfSX4AE9b3ZByRCLyShps6J8w5k8ZNyO69eGsL63S0LV2LHEyelsFi8bmjhu/pRhN2H4/0+fJHiOtWDF3ik7Syd1DwZflVrEus55copkbkhYI2MxX/Gw+IDPbUCy6yDbENr7i6tP7r2jjF2frLmSQWuE/ZC4LklgFbeoX90pOr8H/1SLjKNLSbPOiKrOg06QFrSwEH/cdBYkceuMamlVtNSfaDszBHhL+XLwqzGcR4jxVfsUTLkMvhGccOOQVSaNwAewK9+qFpWQd4ljgDUZfoux7OE+yio6L+ZXdqMcHuDSXjcAzbhOxQQuOF6IdgFXeU/6eQpxnwlhLLJZjlU1ysczQ84QaeoKZIkJdEY4MVVL6+aYQNfPMTVnvhSu4VacDB4c5bJD
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 08:48:51.1237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bfb4d0-c109-448a-e7c5-08d77d4dc7a7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

This series enables new product "D32" support

v2: Rebase
v3: Address Mihail's review comments.

james qian wang (Arm Technology China) (2):
  drm/komeda: Update the chip identify
  drm/komeda: Enable new product D32 support

 .../drm/arm/display/include/malidp_product.h  |  3 +-
 .../arm/display/komeda/d71/d71_component.c    |  2 +-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 58 +++++++++++++-----
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 13 ++++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 61 ++++++++++---------
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 14 +----
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 10 +--
 7 files changed, 96 insertions(+), 65 deletions(-)

--
2.20.1
