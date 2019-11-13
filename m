Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117BEC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BBF222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="p7Qu2nLV";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="p7Qu2nLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfKMOr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:47:58 -0500
Received: from mail-eopbgr40077.outbound.protection.outlook.com ([40.107.4.77]:49448
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727831AbfKMOr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BFf11b8MdnhfT65eiCHqZxq9nGO00dZjx/g+9rtIPE=;
 b=p7Qu2nLVd4sdFqQq2zdDAHBn7CrmZB05zORjwp3zjArABgimfQ6a4X+KsHfGgcrPVyoRSrsH9XFd4jdns9C6L2YtF9KfexjeyPLEML6wca8DFDBY8AL28mvk0Kso0RwBeUtABdsdI07ychP0f1nfCMkcBjoKeVAGWNGMy4ArMQY=
Received: from AM6PR08CA0031.eurprd08.prod.outlook.com (2603:10a6:20b:c0::19)
 by DB8PR08MB5020.eurprd08.prod.outlook.com (2603:10a6:10:e3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Wed, 13 Nov
 2019 14:47:51 +0000
Received: from DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by AM6PR08CA0031.outlook.office365.com
 (2603:10a6:20b:c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Wed, 13 Nov 2019 14:47:51 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT012.mail.protection.outlook.com (10.152.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 14:47:50 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Wed, 13 Nov 2019 14:47:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f353fcab1698df6d
X-CR-MTA-TID: 64aa7808
Received: from 98616bc3f0e7.1 (cr-mta-lb-1.cr-mta-net [104.47.0.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1BC92F27-6968-4B5B-A6F2-B3AB523AA28E.1;
        Wed, 13 Nov 2019 14:47:45 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2050.outbound.protection.outlook.com [104.47.0.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 98616bc3f0e7.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 13 Nov 2019 14:47:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkSWGUKerBGWd/kjEYfuEnzpIgQcB5LSaQFZzGDXs2xX3x4yj+59PFjv29yye/Gh/lkXfvlJknbS/6aJ1WSpfNdvQA9KyEPxw4a6QiuiZiLuqCAb7+S+pxnBM7bU2lwoPn8yML+HJtL8XnB1471x/Hj/QmIClNcFExCOooTVUR2ErkeVhi1Trzt+0pAAKYwY8BQqu/cKAU7tmn4ENf5Qnh8GeW9L2aP5B6BUJWgN237g6w280LlbQWOM9eVwVv1jcBjytb19mMDJGSzOh276ZxFbt0pkCVuaW/j8TCPybthZVfcKCITDX0YZPaeFuqtCPAVFS+ntXXo4gMZkje9PLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BFf11b8MdnhfT65eiCHqZxq9nGO00dZjx/g+9rtIPE=;
 b=hCva2b9niKicv4BCNI2Cp9Lz3CsJmIrCCLS5OxVV3njBCbdBOm3BiAlQU4QMisCZ3F4uhXrfy1B4TSZSK42IAVBxBybfq/C1w5Nn7u9qdP9TAIF9dul2W3MNgf7ct3nhWn8lh99UBA0lXmtkNEDRjwm5uRN37GA5w1VQfDr4Ytj4Owe7fXZ6n25N7bdXXlJxY5Fd6LhyAjKE4Zw1kYhy+4bbNub0qg8Tn5jSqP06Y+xrSqmQ+OZ7kurKJc7Al+dx7RIXyyUbQ/LCxTn8GSspYPrCbgjkrmIDWQNza8+PF6UfzzYPAt84mpDdOZ9ayyuK6ph3nZVS0AUiv5FQTKPSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BFf11b8MdnhfT65eiCHqZxq9nGO00dZjx/g+9rtIPE=;
 b=p7Qu2nLVd4sdFqQq2zdDAHBn7CrmZB05zORjwp3zjArABgimfQ6a4X+KsHfGgcrPVyoRSrsH9XFd4jdns9C6L2YtF9KfexjeyPLEML6wca8DFDBY8AL28mvk0Kso0RwBeUtABdsdI07ychP0f1nfCMkcBjoKeVAGWNGMy4ArMQY=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2162.eurprd08.prod.outlook.com (10.172.216.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 14:47:43 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::2019:b825:f77c:a99]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::2019:b825:f77c:a99%2]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 14:47:43 +0000
From:   James Clark <James.Clark@arm.com>
To:     Tan Xiaojun <tanxiaojun@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [RFC v2 4/4] perf tools: Support "branch-misses:pp" on arm64
Thread-Topic: [RFC v2 4/4] perf tools: Support "branch-misses:pp" on arm64
Thread-Index: AQHVinOCdAafC6cxzk2KUX39BmOYH6dp9Ys9gACxWACAHqbBgA==
Date:   Wed, 13 Nov 2019 14:47:43 +0000
Message-ID: <609eb078-7998-9e4a-ca04-6c40a8a47f84@arm.com>
References: <20191024144830.16534-1-tanxiaojun@huawei.com>
 <20191024144830.16534-5-tanxiaojun@huawei.com>
 <AM4PR0802MB224263700592195B3BAE9D5AE26A0@AM4PR0802MB2242.eurprd08.prod.outlook.com>
 <38c18a3e-1b9a-05fe-63f6-920af2f53fc7@huawei.com>
In-Reply-To: <38c18a3e-1b9a-05fe-63f6-920af2f53fc7@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.96.140]
x-clientproxiedby: DM6PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:5:bc::45) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 945afc4c-d0ce-4b9b-dec1-08d768487524
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2162:|DB8PR08MB5020:
X-Microsoft-Antispam-PRVS: <DB8PR08MB5020B0B344E6B1CAF701A843E2760@DB8PR08MB5020.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0220D4B98D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(66556008)(31686004)(66066001)(476003)(316002)(6512007)(229853002)(6436002)(186003)(2906002)(36756003)(14454004)(478600001)(81166006)(66446008)(25786009)(26005)(86362001)(64756008)(6246003)(66476007)(44832011)(6486002)(486006)(8676002)(81156014)(31696002)(8936002)(305945005)(7736002)(6916009)(256004)(6116002)(3846002)(76176011)(66946007)(102836004)(5660300002)(99286004)(6506007)(386003)(2616005)(54906003)(4326008)(446003)(52116002)(71190400001)(71200400001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2162;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ToENkph3mJMrRUGYe2/5hS5+NhDTSe94f/B/UE5CgvWuySpMHxJCCSQJtjkWtLU1zuyvdl9i2hu1itSf4uGj5h65lGBD5pt2YQmTjEpxEOIVJqhDb3VqVUaDwxbJsGuIa5hN9b6Sbx1ukAs7jPRMNvxfT6C/2bDqxcb/GhxZ9B8nGMjSBd9MT0Txx0aUFVKc1P5xGufmujd4YeEo0yYWsI46ZsakekBfZ7aeJno+df1ugWPOTFoPAcLoNtqCYq5W1rnzr/vYdtanON9LKVAvqRUoh/mKjiAmkTbzI09MeXSuIHah7P7Fn5Dk8XvA5MFY9fZRwLwWrBQb67jxgJ8nEZTMGGcMfYZNJ8cJMYoZ51O+O2pdrfk/lAZEffO70fkxO20ExYBHWqDwi/ei9SIhksBnTeNTbpD5OFp/l2qKvZDPE8+1LTaxk1E8uCFWtOCa
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <14A112AD9D913E45AA94E34218DE033C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2162
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(1110001)(339900001)(189003)(199004)(476003)(66066001)(47776003)(3846002)(6116002)(2616005)(7736002)(22756006)(486006)(305945005)(450100002)(6512007)(14454004)(126002)(25786009)(186003)(229853002)(70586007)(70206006)(11346002)(336012)(6486002)(356004)(436003)(446003)(99286004)(105606002)(5660300002)(316002)(8936002)(36756003)(54906003)(76130400001)(6862004)(23676004)(31686004)(50466002)(4326008)(76176011)(386003)(26826003)(6246003)(2486003)(86362001)(81156014)(2906002)(102836004)(26005)(81166006)(6506007)(478600001)(8676002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5020;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7801d81c-ca88-4205-55d1-08d768487072
NoDisclaimer: True
X-Forefront-PRVS: 0220D4B98D
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0W07waIDttCJWnVZD6PX1Gr2QLUkaK9Hzfq7NzdnG4zBsxrDwRlwv/M0YbIFXh8Y0TJyy/azwpxz3pnkCWP6UWTzW6NdPOOc9dPz5d8fb5nVtgplFvroGGEUI06ooGU31m0TPZ5tBB1PvxBVg8SogTUpY29xXWlhv7Tx2Ew9heRrC6oley7LthRcmtDbjdZrO/4X/3c1FrVTqiqmQChesxkHQuJ8g+vpr/2BTazNWsUM9lfJvgd/G1fmHN/W55TCmdopHZzQLKP40/wt8LvO35xdaOoDxM/5yY7Dx4eL281RcEet6fhQLGXT4Yq2cz6HohOV9dhtr497qCaP/qe3GZGuqYaK1j5vNvkhIfkzWK/ZAAWtAn6rkHSOrAiKAo13S41BMoiamLO9GCGBSSScTg59r/VWmJMmh0VV3yGHWvd+eDuXu8+JoZM488+X4e/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 14:47:50.7708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945afc4c-d0ce-4b9b-dec1-08d768487524
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWGlhb2p1biwNCg0KPiBJIGNhbid0IHJlcHJvZHVjZSB0aGlzIHByb2JsZW0uIElmIHRoZSBj
dXJyZW50IHN5c3RlbSBkb2Vzbid0IHN1cHBvcnQgc3BlLCBpdCBzaG91bGRuJ3QgcmVwb3J0IGFu
IGVycm9yLiBJIHVzZSB0aGUgbGF0ZXN0IGNvZGVzIG9mIHRoZSBtYWlubGluZToNCg0KSSB0aGlu
ayB0aGUgcHJvYmxlbSBpcyByZWxhdGVkIHRvIHRoZSAndHlwZScgYXR0cmlidXRlIG9mIHRoZSBl
dmVudC4gVG8gb3BlbiB0aGUgU1BFIFBNVSB0aGUgZXZlbnQgdHlwZSBvbiB0aGUgcGxhdGZvcm0g
SSdtIHVzaW5nIGlzICc3Jy4gSWYgSSBjaGFuZ2UNCnRoZSBjb2RlIGxpa2UgdGhpcywgdGhlIHBy
b2JsZW0gaXMgZml4ZWQ6DQoNCkBAIC05MTQsMTMgKzkxNCwyNyBAQCB2b2lkIGFybV9zcGVfcHJl
Y2lzZV9pcF9zdXBwb3J0KHN0cnVjdCBldmxpc3QgKmV2bGlzdCwgc3RydWN0IGV2c2VsICpldnNl
bCkNCiAgICAgICAgICAgICAgICBwbXUgPSBwZXJmX3BtdV9fZmluZCgiYXJtX3NwZV8wIik7DQog
ICAgICAgICAgICAgICAgaWYgKHBtdSkgew0KICAgICAgICAgICAgICAgICAgICAgICAgZXZzZWwt
PnBtdV9uYW1lID0gcG11LT5uYW1lOw0KLSAgICAgICAgICAgICAgICAgICAgICAgZXZzZWwtPmNv
cmUuYXR0ci50eXBlID0gUEVSRl9SRUNPUkRfQVVYVFJBQ0U7DQotICAgICAgICAgICAgICAgICAg
ICAgICBldnNlbC0+Y29yZS5hdHRyLmNvbmZpZyA9IFNQRV9BVFRSX1RTX0VOQUJMRQ0KLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBTUEVfQVRUUl9QQV9F
TkFCTEUNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
U1BFX0FUVFJfSklUVEVSDQorICAgICAgICAgICAgICAgICAgICAgICBldnNlbC0+Y29yZS5hdHRy
LnR5cGUgPSBwbXUtPnR5cGU7DQorICAgICAgICAgICAgICAgICAgICAgICBldnNlbC0+Y29yZS5h
dHRyLmNvbmZpZyB8PSBTUEVfQVRUUl9UU19FTkFCTEUNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgU1BFX0FUVFJfQlJBTkNIX0ZJTFRFUjsNCg0KQWxz
byBkbyB5b3UgdGhpbmsgaml0dGVyIHNob3VsZCBiZSBlbmFibGVkIGJ5IGRlZmF1bHQ/IEkgdGhv
dWdodCB0aGF0IGl0IG1pZ2h0IG1ha2UgdGhlIGRhdGEgbGVzcyBwcmVjaXNlLCBzbyBJIHJlbW92
ZWQgaXQgaGVyZS4NCg0KLUphbWVzDQoNCj4gDQo+IGNvbW1pdCBmMTE2Yjk2Njg1YTA0NmE4OWMy
NWQ0YTZiYTJkYTQ4OTE0NWM4ODg4IChtYWlubGluZS9tYXN0ZXIpDQo+IE1lcmdlOiBmNjMyYmZh
YTMzZWQgNjAzZDkyOTlkYTMyDQo+IEF1dGhvcjogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxp
bnV4LWZvdW5kYXRpb24ub3JnPg0KPiBEYXRlOiAgIFRodSBPY3QgMjQgMDY6MTM6NDUgMjAxOSAt
MDQwMA0KPiANCj4gICAgIE1lcmdlIHRhZyAnbWZkLWZpeGVzLTUuNCcgb2YgZ2l0Oi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2xlZS9tZmQNCj4gDQo+IEkgd2lsbCBn
byBhbmQgc2VlIHdoeSB0aGlzIHdpbGwgYmUgcmVwb3J0ZWQuDQo+IA0KPj4NCj4+DQo+PiBJIHdv
dWxkIGhhdmUgZXhwZWN0ZWQgdG8gdXNlIHRoZSBldmVudCBuYW1lIHRoYXQgaXMgbGlzdGVkIGlu
IHRoZSBTUEUgZG9jdW1lbnRhdGlvbiBmb3IgYnJhbmNoIG1pc3NlcyB3aGljaCBpcyBicl9taXNf
cHJlZCBvciBicl9taXNfcHJlZF9yZXRpcmVkOg0KPj4NCj4+IMKgwqDCoCBFWzddLCBieXRlIDAg
Yml0IFs3XQ0KPj4gwqDCoMKgIE1pc3ByZWRpY3RlZC4gVGhlIGRlZmluZWQgdmFsdWVzIG9mIHRo
aXMgYml0IGFyZToNCj4+IMKgwqDCoCAwIERpZCBub3QgY2F1c2UgY29ycmVjdGlvbiB0byB0aGUg
cHJlZGljdGVkIHByb2dyYW0gZmxvdy4NCj4+IMKgwqDCoCAxIEEgYnJhbmNoIHRoYXQgY2F1c2Vk
IGEgY29ycmVjdGlvbiB0byB0aGUgcHJlZGljdGVkIHByb2dyYW0gZmxvdy4NCj4+DQo+PiDCoMKg
wqAgSWYgUE1VdjMgaXMgaW1wbGVtZW50ZWQgdGhpcyBFdmVudCBpcyByZXF1aXJlZCB0byBiZSBp
bXBsZW1lbnRlZCBjb25zaXN0ZW50bHkgd2l0aCBlaXRoZXIgQlJfTUlTX1BSRUQgb3IgQlJfTUlT
X1BSRURfUkVUSVJFRC4NCj4+DQo+IA0KPiBEbyB5b3UgbWVhbiB0aGF0IEkgY2FuIGFkZCB0aGVz
ZSBhcyBuZXcgZXZlbnRzIHRvIHBlcmY/IElmIHdlIHRoaW5rIG9mIHRoZW0gYXMgbmV3IGV2ZW50
cywgd2hhdCBzaG91bGQgd2UgZG8gaWYgdGhlIHVzZXIgZG9lcyBub3QgYWRkIDpwcCBmb3IgdGhl
bT8NCj4gKE9yIGZvciB0aGVzZSBldmVudHMsIHVzZXJzIGNhbiBvbmx5IGFkZCA6cHAgdG8gdXNl
IHRoZW0/KQ0KPiANCj4+DQo+PiArwqDCoMKgwqDCoMKgIGlmICghc3RyY21wKHBlcmZfZW52X19h
cmNoKGV2bGlzdC0+ZW52KSwgImFybTY0IikNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAmJiBldnNlbC0+Y29yZS5hdHRyLmNvbmZpZyA9PSBQRVJGX0NP
VU5UX0hXX0JSQU5DSF9NSVNTRVMNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAmJiBldnNlbC0+Y29yZS5hdHRyLnByZWNpc2VfaXApIHsNCj4+DQo+PiBB
cyBJIG1lbnRpb25lZCBhYm92ZSBQRVJGX0NPVU5UX0hXX0JSQU5DSF9NSVNTRVNkb2Vzbid0IHNl
ZW0gdG8gbWF0Y2ggdXAgd2l0aCB0aGUgYWN0dWFsIGV2ZW50IGNvdW50ZXIgdGhhdCBpcyBhc3Nv
Y2lhdGVkIHdpdGggdGhpcyBTUEUgZXZlbnQgKEJSX01JU19QUkVEKS4gVGhlIGZpeCBmb3IgdGhp
cyBpcyBwcm9iYWJseSBhcyBzaW1wbGUgYXMgYWRkaW5nIGFuIE9SIGZvciB0aGUgb3RoZXIgYWxp
YXNlcyBmb3IgYnJhbmNoIG1pc3ByZWRpY3RzLg0KPiANCj4gV2hhdCB5b3UgbWVhbiBpcyB0aGF0
IHdlIGNhbiBmaWx0ZXIgd2l0aCBzcGUgZXZlbnRzKGxpa2UgQlJfTUlTX1BSRUQpIGZpcnN0LCBh
bmQgaWYgd2UgaGF2ZSBvdGhlciBldmVudHMgdGhhdCBhcmUgZXhhY3RseSB0aGUgc2FtZShubyBt
b3JlIGZvciBub3cpLCB0aGVuIHdlIGNhbiBoYW5kbGUgdGhlbSBieSBhZGRpbmcgT1IgaW4gdGhl
IGZ1dHVyZT8NCj4gDQo+Pg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG11ID0g
cGVyZl9wbXVfX2ZpbmQoImFybV9zcGVfMCIpOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKHBtdSkgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGV2c2VsLT5wbXVfbmFtZSA9IHBtdS0+bmFtZTsNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBldnNlbC0+Y29yZS5hdHRyLnR5cGUgPSBQ
RVJGX1JFQ09SRF9BVVhUUkFDRTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBldnNlbC0+Y29yZS5hdHRyLmNvbmZpZyA9IFNQRV9BVFRSX1RTX0VOQUJM
RQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgU1BFX0FUVFJfUEFf
RU5BQkxFDQo+Pg0KPj4gSSB3b3VsZG4ndCBzZXQgcGh5c2ljYWwgYWRkcmVzc2VzIGJ5IGRlZmF1
bHQgYXMgdGhpcyByZXF1aXJlcyByb290LiBJIHdvdWxkIGxlYXZlIHRoYXQgdG8gdGhlIHVzZXIg
aWYgdGhleSB3YW50IHRvIG1hbnVhbGx5IGNvbmZpZ3VyZSBTUEUuDQo+IA0KPiBZZXMuIFlvdSBh
cmUgcmlnaHQuIEkgZ290IGEgZXJyb3IgZm9yIHRoaXMgY2FzZS4gSSB3aWxsIGZpeCBpdC4NCj4g
DQo+IC0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAuL3BlcmYgcmVjb3JkIC1lIGJyYW5jaC1taXNzZXM6
cCBscw0KPiBFcnJvcjoNCj4gWW91IG1heSBub3QgaGF2ZSBwZXJtaXNzaW9uIHRvIGNvbGxlY3Qg
c3RhdHMuDQo+IC4uLg0KPiAtLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IFRoYW5rcy4NCj4gWGlh
b2p1bi4NCj4gDQo+Pg0KPj4gSSBoYXZlIG9ubHkgbG9va2VkIGJyaWVmbHkgYW5kIEkgd2lsbCBk
byBzb21lIG1vcmUgdGVzdGluZy4NCj4+DQo+Pg0KPj4gVGhhbmtzDQo+PiBKYW1lcw0KPj4NCj4+
DQo+IA0KPiANCg==
