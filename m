Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8EDC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A9B20873
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Mm2/zeI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfEQHfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:35:20 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:35904
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727500AbfEQHfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHmjBfuC4vxiTyP58WsAVLZdiIqCRwqeWpLa4rts0ak=;
 b=Mm2/zeI9GFsZ93upGhur22SIKyy9QJUh2AT3sTpnFstEeJjRgjHXt5F3y9dwyhL+Pu6koKSr1SMIHLRh4DXz7sGDyQSf2+sVrhUWiXxpwdqR9b/4YWt9lfh9PV0uHgu4qw3iVU1na/EkRqsUnzMGHPwY/J8OmKtoo+n+x6uus1s=
Received: from DB7PR08MB3865.eurprd08.prod.outlook.com (20.178.84.149) by
 DB7PR08MB3884.eurprd08.prod.outlook.com (20.178.46.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Fri, 17 May 2019 07:35:16 +0000
Received: from DB7PR08MB3865.eurprd08.prod.outlook.com
 ([fe80::1c44:4e1b:c1e1:543e]) by DB7PR08MB3865.eurprd08.prod.outlook.com
 ([fe80::1c44:4e1b:c1e1:543e%7]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 07:35:16 +0000
From:   Raphael Gault <Raphael.Gault@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH 4/6] arm64: pmu: Add hook to handle pmu-related undefined
 instructions
Thread-Topic: [PATCH 4/6] arm64: pmu: Add hook to handle pmu-related undefined
 instructions
Thread-Index: AQHVC+ps829CXrnAbkOTNSFu6HVCF6Zu51UAgAAG+YA=
Date:   Fri, 17 May 2019 07:35:16 +0000
Message-ID: <c7c4c851-51d9-a596-cba2-23252785251c@arm.com>
References: <20190516132148.10085-1-raphael.gault@arm.com>
 <20190516132148.10085-5-raphael.gault@arm.com>
 <20190517071018.GH2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190517071018.GH2623@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::31) To DB7PR08MB3865.eurprd08.prod.outlook.com
 (2603:10a6:10:32::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Raphael.Gault@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e5ae6aa-326a-4a6a-c479-08d6da9a345a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3884;
x-ms-traffictypediagnostic: DB7PR08MB3884:
x-microsoft-antispam-prvs: <DB7PR08MB388454E50431431463762AA9ED0B0@DB7PR08MB3884.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(346002)(39860400002)(199004)(189003)(40434004)(53936002)(6916009)(5660300002)(6246003)(2906002)(66556008)(64756008)(66446008)(66476007)(66946007)(305945005)(73956011)(7736002)(31686004)(68736007)(6116002)(3846002)(8936002)(8676002)(81156014)(81166006)(53546011)(76176011)(386003)(99286004)(102836004)(31696002)(256004)(14444005)(5024004)(36756003)(54906003)(11346002)(14454004)(6506007)(52116002)(66066001)(44832011)(446003)(229853002)(6436002)(6512007)(71190400001)(86362001)(186003)(2616005)(476003)(486006)(316002)(72206003)(478600001)(71200400001)(4326008)(6486002)(26005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3884;H:DB7PR08MB3865.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NDHao45jqJbS5xIFIvl45y5AW0ojN8fuzImtTfZF+b+20FDtrGRSKKK7NyciTm6awXXWhIXVson+AkqggrQjgjiJrM6xeqjAfBSss2mlMoJoXYV07rl0rs1T8swLhvE4POSHQuDDg8eUUCJKwazje5qjlCecXxmim+4PBjE397e1/IAOM+6UlL4N531P3peAZrtGc0IuW+n48FiZpTC/u2RWpGu/RLbS4PmeOwY4R8Exg4rcUkoDYJl/ehZvx0dKKfXK4WEwOyqyr1FrjukK2lMkzshwmWLYnLsbB7LFcdjxSY8C2O2xj+yMxi0gQ1DUaWNLMOOSndKYjipK12kjcfJ2Oq7054i6iW4p0WoVG7KtH9HLi3YbF+98hbzZ+0MRC/6Fd5kDeAm4+E+2ptH5GuLYAl8ycPoOWvz3GBAI9WE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCC04CA52D4D464AB543E1CADCDF7E90@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5ae6aa-326a-4a6a-c479-08d6da9a345a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 07:35:16.0774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDUvMTcvMTkgODoxMCBBTSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIFRo
dSwgTWF5IDE2LCAyMDE5IGF0IDAyOjIxOjQ2UE0gKzAxMDAsIFJhcGhhZWwgR2F1bHQgd3JvdGU6
DQo+PiBJbiBvcmRlciB0byBwcmV2ZW50IHRoZSB1c2Vyc3BhY2UgcHJvY2Vzc2VzIHdoaWNoIGFy
ZSB0cnlpbmcgdG8gYWNjZXNzDQo+PiB0aGUgcmVnaXN0ZXJzIGZyb20gdGhlIHBtdSByZWdpc3Rl
cnMgb24gYSBiaWcuTElUVExFIGVudmlyb25tZW50IHdlDQo+PiBpbnRyb2R1Y2UgYSBob29rIHRv
IGhhbmRsZSB1bmRlZmluZWQgaW5zdHJ1Y3Rpb25zLg0KPj4NCj4+IFRoZSBnb2FsIGhlcmUgaXMg
dG8gcHJldmVudCB0aGUgcHJvY2VzcyB0byBiZSBpbnRlcnJ1cHRlZCBieSBhIHNpZ25hbA0KPj4g
d2hlbiB0aGUgZXJyb3IgaXMgY2F1c2VkIGJ5IHRoZSB0YXNrIGJlaW5nIHNjaGVkdWxlZCB3aGls
ZSBhY2Nlc3NpbmcNCj4+IGEgY291bnRlciwgY2F1c2luZyB0aGUgY291bnRlciBhY2Nlc3MgdG8g
YmUgaW52YWxpZC4gQXMgd2UgYXJlIG5vdCBhYmxlDQo+PiB0byBrbm93IGVmZmljaWVudGx5IHRo
ZSBudW1iZXIgb2YgY291bnRlcnMgYXZhaWxhYmxlIHBoeXNpY2FsbHkgb24gYm90aA0KPj4gcG11
IGluIHRoYXQgY29udGV4dCB3ZSBjb25zaWRlciB0aGF0IGFueSBmYXVsdGluZyBhY2Nlc3MgdG8g
YSBjb3VudGVyDQo+PiB3aGljaCBpcyBhcmNoaXRlY3R1cmFsbHkgY29ycmVjdCBzaG91bGQgbm90
IGNhdXNlIGEgU0lHSUxMIHNpZ25hbCBpZg0KPj4gdGhlIHBlcm1pc3Npb25zIGFyZSBzZXQgYWNj
b3JkaW5nbHkuDQo+DQo+IFRoZSBvdGhlciBhcHByb2FjaCBpcyB1c2luZyByc2VxIGZvciB0aGlz
OyB3aXRoIHRoYXQgeW91IGNhbiBndWFyYW50ZWUNCj4gaXQgd2lsbCBuZXZlciBpc3N1ZSB0aGUg
aW5zdHJ1Y3Rpb24gb24gYSB3cm9uZyBDUFUuDQo+DQo+IFRoYXQgc2FpZDsgZW11bGF0aW5nIHRo
ZSB0aGluZyBpc24ndCBob3JyaWJsZSBlaXRoZXIuDQo+DQo+PiArLyoNCj4+ICsgKiBXZSBwdXQg
MCBpbiB0aGUgdGFyZ2V0IHJlZ2lzdGVyIGlmIHdlDQo+PiArICogYXJlIHJlYWRpbmcgZnJvbSBw
bXUgcmVnaXN0ZXIuIElmIHdlIGFyZQ0KPj4gKyAqIHdyaXRpbmcsIHdlIGRvIG5vdGhpbmcuDQo+
PiArICovDQo+DQo+IFdhaXQgX3doYXRfID8hPyB1c2Vyc3BhY2UgY2FuIF9XUklURV8gdG8gdGhl
c2UgcmVnaXN0ZXJzPw0KPg0KDQpUaGUgdXNlciBjYW4gd3JpdGUgdG8gc29tZSBwbXUgcmVnaXN0
ZXJzIGJ1dCB0aG9zZSBhcmUgbm90IHRoZSBvbmVzIHRoYXQNCmludGVyZXN0IHVzIGhlcmUuIE15
IGNvbW1lbnQgd2FzIGlsbCBmb3JtZWQsIGluZGVlZCB0aGlzIGhvb2sgY2FuIG9ubHkNCmJlIHRy
aWdnZXJlZCBieSByZWFkcyBpbiB0aGlzIGNhc2UuDQpTb3JyeSBhYm91dCB0aGF0Lg0KDQpUaGFu
a3MsDQoNCi0tDQpSYXBoYWVsIEdhdWx0DQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMg
b2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1h
eSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGll
bnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Ns
b3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJw
b3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFu
ayB5b3UuDQo=
