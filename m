Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB7EC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBCD23426
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7BaoVmvE";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7BaoVmvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfHUMib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:38:31 -0400
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:64438
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbfHUMi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzW4OBei4DgPRiq4SCyFc5FiXuLX7E7rIz7wwDQ7ATc=;
 b=7BaoVmvEfsKlt/ceBdaDCvPylH8U3h1e7TmWKH6s6+5a7S3GxVE1W8IX9klcNOwOlyxSYjy7fXF7kIhKhbNCvG1s9Ay4jQLTdOEPf3S4dW+MJ6HTkMb9iUzS40kpGd4VgliTTNQOABeveiTYPeUkJ5FmnyNhHE+/ERbtyaMAouI=
Received: from VI1PR08CA0143.eurprd08.prod.outlook.com (2603:10a6:800:d5::21)
 by AM6SPR01MB14.eurprd08.prod.outlook.com (2603:10a6:209:3c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.18; Wed, 21 Aug
 2019 12:38:23 +0000
Received: from AM5EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by VI1PR08CA0143.outlook.office365.com
 (2603:10a6:800:d5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.14 via Frontend
 Transport; Wed, 21 Aug 2019 12:38:23 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT042.mail.protection.outlook.com (10.152.17.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16 via Frontend Transport; Wed, 21 Aug 2019 12:38:21 +0000
Received: ("Tessian outbound 578a71fe5eaa:v26"); Wed, 21 Aug 2019 12:38:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 33f18c84a0682617
X-CR-MTA-TID: 64aa7808
Received: from 1a1855c622c7.1 (cr-mta-lb-1.cr-mta-net [104.47.14.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0CCE1B7E-50D0-47C9-8BF7-E0A14A88A52C.1;
        Wed, 21 Aug 2019 12:38:15 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1a1855c622c7.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 21 Aug 2019 12:38:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCGtyTm1T3BfkhpAJPRv9jZBYLOCiPdzd4/+9Z/3yvFCwPAvvtg3nxl1ZariCF7l450UTjGdoiZSKAYv1OpEGALTqwdog0LZtFFyqbvwQG37R/fl3zluZ2pqmYgndkdjfBtGwWJ3KrL19uCFlnDo5pkJBoPuC2AJMyfzGw/1cvwYWyMJIxJwp7qfYz3v082dWnOQq5+cV2LPg6JlwX2cdexg7u8mfQAuZv9vwZM6LrtG2rFwMi5TkpcHJXrUCOPkghhV7twl4IJQsUIoCmfXxxHgCVPN7OYSNMeS6M1bh1oysNCU/zkXsSb97enUwl1HbBoNDvYoR5FIGQCOnra8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzW4OBei4DgPRiq4SCyFc5FiXuLX7E7rIz7wwDQ7ATc=;
 b=VPFsAo+p7k8E6XrMgV4oykMsJrIkbANIYPip5e89/SQo3UgKUMQSFmMEFGTC9Xw5GEeMVYvayZ5SVchF9hLkUPWfSSxws2H6Tb7tQz0MpNy+Y8hU5Lsk3PLH6u4LwrTD1E/X/Nm1LIqLeyNw90Y097HbSiwwPiSoedS9q/w3O++RuTBCEBoafGnXJY8WBQqc+55fl5bEcv2ZzGPCvfidB215euYFsV2RU22C2vI19Scir9/Bh2yS1kctba8Gg9TjnCl8MWSTe51s+w8uCdyLmeMlKULRVIKiB6iA//PW6hEfwduHZmg1VSKZSm59ffWa9AIDjIPcj+EChDP8M+RLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzW4OBei4DgPRiq4SCyFc5FiXuLX7E7rIz7wwDQ7ATc=;
 b=7BaoVmvEfsKlt/ceBdaDCvPylH8U3h1e7TmWKH6s6+5a7S3GxVE1W8IX9klcNOwOlyxSYjy7fXF7kIhKhbNCvG1s9Ay4jQLTdOEPf3S4dW+MJ6HTkMb9iUzS40kpGd4VgliTTNQOABeveiTYPeUkJ5FmnyNhHE+/ERbtyaMAouI=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2129.eurprd08.prod.outlook.com (10.172.217.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 12:38:10 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::f482:c808:6949:f621]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::f482:c808:6949:f621%11]) with mapi id 15.20.2178.020; Wed, 21 Aug
 2019 12:38:10 +0000
From:   James Clark <James.Clark@arm.com>
To:     Tan Xiaojun <tanxiaojun@huawei.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Kim Phillips <Kim.Phillips@arm.com>
CC:     "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [RFC PATCH 3/3] perf report: add --spe options for arm-spe
Thread-Topic: [RFC PATCH 3/3] perf report: add --spe options for arm-spe
Thread-Index: AQHVSRBXkaPHz6ngKEmGqBp9O9uaWqcFqHEA
Date:   Wed, 21 Aug 2019 12:38:10 +0000
Message-ID: <8e8deead-6d59-9203-a01a-fe63362ebdf0@arm.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
 <1564738813-10944-4-git-send-email-tanxiaojun@huawei.com>
In-Reply-To: <1564738813-10944-4-git-send-email-tanxiaojun@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LNXP265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::25) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 85a4a6d6-adc5-406a-deba-08d7263473ba
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR0802MB2129;
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2129:|AM6SPR01MB14:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6SPR01MB149194A1AE49E43FDE89DBE2AA0@AM6SPR01MB14.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0136C1DDA4
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(5660300002)(316002)(110136005)(71200400001)(81166006)(36756003)(81156014)(4326008)(6246003)(8936002)(6436002)(54906003)(2201001)(31696002)(478600001)(3846002)(6116002)(8676002)(71190400001)(6512007)(14454004)(2906002)(66946007)(66556008)(64756008)(53546011)(6506007)(26005)(386003)(102836004)(2501003)(99286004)(11346002)(446003)(476003)(31686004)(486006)(2616005)(86362001)(66066001)(66446008)(53936002)(66476007)(229853002)(7416002)(6486002)(25786009)(76176011)(256004)(44832011)(6636002)(7736002)(52116002)(305945005)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2129;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: KcGSoTq6lCQSyx/lAdP22xFCP/cltFo9YtZyGTq4bqp08zobLTPnBoHtgyIYOBjGhMjp7rRaAoUrihoIP66FWXDbgYTLctn/FmsbajwiWL66wJC2+IY/B9YI1wQLOO8z9184Qm76LR7zy5BkJOL4AR4gU19CTQ+TRuWEydUC4eHwQa4QQQR1s3fTqc7kWtw80hu7wSqZPabmIEhPAOqyKAkWoNtCkeczhEiYhCuCNHa8ZpgAh9CiJ2gPPjoyCnA8Kr/6s5kyvxRx6PQTrW3PRBDsyB5vx2LnJdxFv0Cx99wclaeS3S/aL4gtW/6aSrMgfFZQYf7t9GMRKkVQauMQtBAWKIAZZDmIpb+Jkc8tQA9bHxImBG87OMJS07C40Ae9g2LzSV70d1y87l7gHxoXcnuYtbYNlVmXXmWTEgP+qEs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB474E42E6D57B4E8EF98A8302A3F913@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2129
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(199004)(189003)(6246003)(186003)(305945005)(486006)(76130400001)(47776003)(2616005)(7736002)(476003)(31686004)(6636002)(478600001)(446003)(63370400001)(66066001)(63350400001)(4326008)(26826003)(36906005)(6116002)(450100002)(436003)(11346002)(6512007)(126002)(25786009)(22756006)(2906002)(81156014)(81166006)(6506007)(386003)(5660300002)(70206006)(70586007)(6486002)(316002)(86362001)(36756003)(3846002)(336012)(54906003)(2201001)(8676002)(99286004)(76176011)(14454004)(23676004)(229853002)(2486003)(356004)(102836004)(8936002)(26005)(110136005)(50466002)(31696002)(2501003)(53546011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6SPR01MB14;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 25559f21-56b4-45fd-35b3-08d726346cab
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(710020)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6SPR01MB14;
NoDisclaimer: True
X-Forefront-PRVS: 0136C1DDA4
X-Microsoft-Antispam-Message-Info: xw0TH+wjJ3hUfHGZutXF8L2LAx32XaY4rizoh4mkBJURVm9GP3pY7toSInltV0AKSB90MXsThH1dIYjjxkJvDgUpssXw17ZgGyg331vN5CCDggpX3SXqFTQOUtyvKNN+pROXy8FcMmM8LphUhwzhQPGnrkU/M45rl13lS3mc/lY7ST46SZvbKBFRaGLunGTVf/3jF96mj3dAZ3sE4VaI4OO2fEZ0VAYD8p+0h9zWiPc9i5I+6GGNNGzghjfuXGNbmTPCv9HGNb1z0LxdnRYHU60TaFGGQOpNWTM0ucnQgiEoGbIs59ZS1b/97EVEFGEcpgaLalsoyYze6EPMt/sMQl10Fc52yQ8rCAGSrQzK68NZSmpdZFn96a1Tsk1aAB+qVVJtUfeq+4rh7wIWOYKxtDp2Sc4nADK5mCg2stioTeQ=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2019 12:38:21.6704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a4a6d6-adc5-406a-deba-08d7263473ba
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkkgYWxzbyBoYWQgYSBsb29rIGF0IHRoaXMgYW5kIGhhZCBhIHF1ZXN0aW9uIGFib3V0
IHRoZSAtLXNwZSBvcHRpb24uDQpJdCBzZWVtcyB0aGF0IHdoYXRldmVyIG9wdGlvbnMgSSBnaXZl
IGl0LCB0aGUgb3V0cHV0IGlzIHRoZSBzYW1lOg0KDQoJcGVyZiByZXBvcnQgDQpBbmQNCglwZXJm
IHJlcG9ydCAtLXNwZT10DQoNCkJvdGggZ2l2ZSB0aGUgc2FtZSByZXN1bHQ6DQoNCgkjIFNhbXBs
ZXM6IDQgIG9mIGV2ZW50ICdsbGMtbWlzcycNCgkjIEV2ZW50IGNvdW50IChhcHByb3guKTogNA0K
CSMNCgkjIENoaWxkcmVuICAgICAgU2VsZiAgQ29tbWFuZCAgU2hhcmVkIE9iamVjdCAgICAgIFN5
bWJvbCAgICAgICAgICAgICAgICAgICAgDQoJIyAuLi4uLi4uLiAgLi4uLi4uLi4gIC4uLi4uLi4g
IC4uLi4uLi4uLi4uLi4uLi4uICAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KCSMNCgkuLi4N
CgkjIFNhbXBsZXM6IDAgIG9mIGV2ZW50ICd0bGItbWlzcycNCgkjIEV2ZW50IGNvdW50IChhcHBy
b3guKTogMA0KCSMNCgkjIENoaWxkcmVuICAgICAgU2VsZiAgQ29tbWFuZCAgU2hhcmVkIE9iamVj
dCAgU3ltYm9sDQoJIyAuLi4uLi4uLiAgLi4uLi4uLi4gIC4uLi4uLi4gIC4uLi4uLi4uLi4uLi4g
IC4uLi4uLg0KCSMNCg0KCSMgU2FtcGxlczogODMgIG9mIGV2ZW50ICdicmFuY2gtbWlzcycNCgkj
IEV2ZW50IGNvdW50IChhcHByb3guKTogODMNCgkjDQoJIyBDaGlsZHJlbiAgICAgIFNlbGYgIENv
bW1hbmQgIFNoYXJlZCBPYmplY3QgICAgICBTeW1ib2wgICAgICAgICAgICAgICAgICAgDQoJIyAu
Li4uLi4uLiAgLi4uLi4uLi4gIC4uLi4uLi4gIC4uLi4uLi4uLi4uLi4uLi4uICAuLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uDQoJIw0KCS4uLg0KDQpJIHdvdWxkIGhhdmUgZXhwZWN0ZWQgaXQgdG8g
bm90IGluY2x1ZGUgdGhlIGJyYW5jaCBhbmQgTExDIHNlY3Rpb25zIGZvciB0aGUgc2Vjb25kDQpj
b21tYW5kIHdpdGggLS1zcGU9dC4NCg0KQW5kIHRoYXQgbGVhZHMgbWUgdG8gYW5vdGhlciBwb2lu
dC4gRG9lcyBpdCBtYWtlIHNlbnNlIHRvIGhhdmUgdGhpcyBvcHRpb24gYXMgYSBwb3N0DQpwcm9j
ZXNzaW5nIHN0ZXA/IFNQRSBhbHJlYWR5IGhhcyBzdXBwb3J0IGZvciBmaWx0ZXJpbmcgZXZlbnRz
IGF0IGNvbGxlY3Rpb24gdGltZSB3aXRoDQp0aGUgUE1TRkNSX0VMMSByZWdpc3Rlci4NCg0KU2hv
dWxkIHdlIHRyeSB0byBtYWtlIHRoZSBpbnRlcmZhY2UgbW9yZSBsaWtlIFBFQlMsIHdoZXJlIHlv
dSBzcGVjaWZ5IHdoaWNoIGV2ZW50cyB5b3UNCmFyZSBpbnRlcmVzdGVkIGluIGRvaW5nIHByZWNp
c2UgdHJhY2luZyBvbiBsaWtlIHRoaXM/DQoNCglwZXJmIHJlY29yZCAtZSBicmFuY2gtbWlzc2Vz
OnBwDQoNCkFuZCB0aGVuIHBlcmYgY291bGQgdXNlIHRoZSBtb2RpZmllciB0byBjb25maWd1cmUg
U1BFIHNvIHRoYXQgaXQgb25seSByZWNvcmRzIGJyYW5jaA0KbWlzc2VzPyBUaGUgYmVuZWZpdHMg
b2YgdGhpcyB3b3VsZCBiZSBrZWVwaW5nIHRoZSB1c2VyIGludGVyZmFjZSBmb3IgcHJlY2lzZSB0
cmFjaW5nDQpzaW1pbGFyIGJldHdlZW4gcGxhdGZvcm1zLg0KDQpUaGFua3MNCkphbWVzDQoNCk9u
IDAyLzA4LzIwMTkgMTA6NDAsIFRhbiBYaWFvanVuIHdyb3RlOg0KPiBUaGUgcHJldmlvdXMgcGF0
Y2ggYWRkZWQgc3VwcG9ydCBpbiAicGVyZiByZXBvcnQiIGZvciBzb21lIGFybS1zcGUNCj4gZXZl
bnRzKGxsYy1taXNzLCB0bGItbWlzcywgYnJhbmNoLW1pc3MpLiBUaGlzIHBhdGNoIGFkZHMgdGhl
aXIgaGVscA0KPiBpbnN0cnVjdGlvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUYW4gWGlhb2p1
biA8dGFueGlhb2p1bkBodWF3ZWkuY29tPg0KPiAtLS0NCj4gIHRvb2xzL3BlcmYvRG9jdW1lbnRh
dGlvbi9wZXJmLXJlcG9ydC50eHQgfCA5ICsrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvRG9jdW1lbnRhdGlv
bi9wZXJmLXJlcG9ydC50eHQgYi90b29scy9wZXJmL0RvY3VtZW50YXRpb24vcGVyZi1yZXBvcnQu
dHh0DQo+IGluZGV4IDk4NzI2MWQuLmQ5OThkNGIgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3BlcmYv
RG9jdW1lbnRhdGlvbi9wZXJmLXJlcG9ydC50eHQNCj4gKysrIGIvdG9vbHMvcGVyZi9Eb2N1bWVu
dGF0aW9uL3BlcmYtcmVwb3J0LnR4dA0KPiBAQCAtNDQ1LDYgKzQ0NSwxNSBAQCBpbmNsdWRlOjpp
dHJhY2UudHh0W10NCj4gIA0KPiAgCVRvIGRpc2FibGUgZGVjb2RpbmcgZW50aXJlbHksIHVzZSAt
LW5vLWl0cmFjZS4NCj4gIA0KPiArLS1zcGU6Og0KPiArCU9wdGlvbnMgZm9yIGRlY29kaW5nIGFy
bS1zcGUgdHJhY2luZyBkYXRhLiBUaGUgb3B0aW9ucyBhcmU6DQo+ICsNCj4gKwkJbAlzeW50aGVz
aXplIGxsYyBtaXNzIGV2ZW50cw0KPiArCQl0CXN5bnRoZXNpemUgdGxiIG1pc3MgZXZlbnRzDQo+
ICsJCWIJc3ludGhlc2l6ZSBicmFuY2ggbWlzcyBldmVudHMNCj4gKw0KPiArCVRoZSBkZWZhdWx0
IGlzIGFsbCBldmVudHMgaS5lLiB0aGUgc2FtZSBhcyAtLXNwZT1sdGINCj4gKw0KPiAgLS1mdWxs
LXNvdXJjZS1wYXRoOjoNCj4gIAlTaG93IHRoZSBmdWxsIHBhdGggZm9yIHNvdXJjZSBmaWxlcyBm
b3Igc3JjbGluZSBvdXRwdXQuDQo+ICANCj4gDQo=
