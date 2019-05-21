Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BFAC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A749B2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ezqOs1QN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfEUMvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:51:01 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:46662
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727044AbfEUMvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX+B1XPU8Uj+Estbi0WpXCgbgJrpyoC40UivxMNAfQ0=;
 b=ezqOs1QNw9RhhewhAdF+kZS+OF1GFuI6AoGEUqYErsHSmfwLMPD8QO1NAu0rs9RD/8asj4u76n1UjHYSJIsMjz4ECAz/iByOczZGVF2u0k4RCXMHludG2r7hkgr1JD4EaBoieU5rgt13LbOgL+81dmvI0sLJXnWAXB5oKRL2k2s=
Received: from DB7PR08MB3865.eurprd08.prod.outlook.com (20.178.84.149) by
 DB7PR08MB3468.eurprd08.prod.outlook.com (20.176.238.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Tue, 21 May 2019 12:50:58 +0000
Received: from DB7PR08MB3865.eurprd08.prod.outlook.com
 ([fe80::1c44:4e1b:c1e1:543e]) by DB7PR08MB3865.eurprd08.prod.outlook.com
 ([fe80::1c44:4e1b:c1e1:543e%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 12:50:58 +0000
From:   Raphael Gault <Raphael.Gault@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Julien Thierry <Julien.Thierry@arm.com>
Subject: Re: [RFC V2 00/16] objtool: Add support for Arm64
Thread-Topic: [RFC V2 00/16] objtool: Add support for Arm64
Thread-Index: AQHVC9NuTdVCDaa9ZEK795yYRfBvDKZtz9WAgAfALQA=
Date:   Tue, 21 May 2019 12:50:57 +0000
Message-ID: <26692833-0e5b-cfe0-0ffd-c2c2f0815935@arm.com>
References: <20190516103655.5509-1-raphael.gault@arm.com>
 <20190516142917.nuhh6dmfiufxqzls@treble>
In-Reply-To: <20190516142917.nuhh6dmfiufxqzls@treble>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::22) To DB7PR08MB3865.eurprd08.prod.outlook.com
 (2603:10a6:10:32::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Raphael.Gault@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bac8ef6-c30a-479c-dfad-08d6ddeaf82f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3468;
x-ms-traffictypediagnostic: DB7PR08MB3468:
x-microsoft-antispam-prvs: <DB7PR08MB3468758FA32DA72D354D550BED070@DB7PR08MB3468.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(366004)(376002)(40434004)(199004)(189003)(54014002)(478600001)(305945005)(8676002)(81166006)(81156014)(14454004)(72206003)(6512007)(316002)(8936002)(66066001)(7736002)(66946007)(66446008)(66476007)(73956011)(71200400001)(71190400001)(6436002)(64756008)(66556008)(6916009)(36756003)(99286004)(102836004)(6116002)(54906003)(2906002)(3846002)(486006)(86362001)(2616005)(446003)(26005)(14444005)(5024004)(11346002)(31696002)(44832011)(476003)(256004)(186003)(31686004)(53936002)(6486002)(25786009)(5660300002)(229853002)(52116002)(53546011)(76176011)(6506007)(386003)(4326008)(6246003)(68736007)(10944002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3468;H:DB7PR08MB3865.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5yUjSRvVTsHz2zohfBstl5qD4AjV0iAvAGz5daTDDi71Yhjtm5+9thFdTAc8EdWJuoD0XtQd9yDGheI/Lyvm/37+Sssa4HQvGvpmyHUao3I1zA4HyPLZw/7us4VHnypGZ9t6+aqR80voTjDZQNZ9votFnpnGgOz807f1CxD4vUc/x2s1SN4SF7IxaIOVq62XPRnJUKEGUiRMoQfdDkWLj8a8na1H9Wj84X4MJm2CjpKvBbhX6Xu3emd4r63Su2pxB1zZqJdBSPOnb1eqmIw+Ka6tM8g9KWSGRtreJB7LVRxJfbkySgOSDIrHcGioJRh3Lm6UXyrItcGQ1/8EQzvWGllclbyXQmefDr9Z9HfgtqDWutHJEWH/hVYLDmApdxFIos7KctLcxwPbody3xi6lB2OEoiyCKof8GrVSFqY8zXQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B927C8926921641BAA5042413FC236B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bac8ef6-c30a-479c-dfad-08d6ddeaf82f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 12:50:57.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3468
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9zaCwNCg0KVGhhbmtzIGZvciBvZmZlcmluZyB5b3VyIGhlbHAgYW5kIHNvcnJ5IGZvciB0
aGUgbGF0ZSBhbnN3ZXIuDQoNCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBhIHRhYmxlIG9mIG9m
ZnNldHMgaXMgYnVpbHQgYnkgR0NDLCB0aG9zZQ0Kb2Zmc2V0cyBiZWluZyBzY2FsZWQgYnkgNCBi
ZWZvcmUgYWRkaW5nIHRoZW0gdG8gdGhlIGJhc2UgbGFiZWwuDQpJIGJlbGlldmUgdGhlIG9mZnNl
dHMgYXJlIHN0b3JlZCBpbiB0aGUgLnJvZGF0YSBzZWN0aW9uLiBUbyBmaW5kIHRoZQ0Kc2l6ZSBv
ZiB0aGF0IHRhYmxlLCBpdCBpcyBuZWVkZWQgdG8gZmluZCBhIGNvbXBhcmlzb24sIHdoaWNoIGNh
biBiZQ0Kb3B0aW1pemVkIG91dCBhcHByZW50bHkuIEluIHRoYXQgY2FzZSB0aGUgZW5kIG9mIHRo
ZSBhcnJheSBjYW4gYmUgZm91bmQNCmJ5IGxvY2F0aW5nIGxhYmVscyBwb2ludGluZyB0byBkYXRh
IGJlaGluZCBpdCAod2hpY2ggaXMgbm90IDEwMCUgc2FmZSkuDQoNCk9uIDUvMTYvMTkgMzoyOSBQ
TSwgSm9zaCBQb2ltYm9ldWYgd3JvdGU6DQo+IE9uIFRodSwgTWF5IDE2LCAyMDE5IGF0IDExOjM2
OjM5QU0gKzAxMDAsIFJhcGhhZWwgR2F1bHQgd3JvdGU6DQo+PiBOb3Rld29ydGh5IHBvaW50czoN
Cj4+ICogSSBzdGlsbCBoYXZlbid0IGZpZ3VyZWQgb3V0IGhvdyB0byBkZXRlY3Qgc3dpdGNoLXRh
YmxlcyBvbiBhcm02NC4gSQ0KPj4gaGF2ZSBhIGJldHRlciB1bmRlcnN0YW5kaW5nIG9mIHRoZW0g
YnV0IHN0aWxsIGhhdmVuJ3QgaW1wbGVtZW50ZWQgY2hlY2tzDQo+PiBhcyBpdCBkb2Vzbid0IGxv
b2sgdHJpdmlhbCBhdCBhbGwuDQo+DQo+IFN3aXRjaCB0YWJsZXMgd2VyZSB0cmlja3kgdG8gZ2V0
IHJpZ2h0IG9uIHg4Ni4gIElmIHlvdSBzaGFyZSBhbiBleGFtcGxlDQo+IChvciBldmVuIGp1c3Qg
YSAubyBmaWxlKSBJIGNhbiB0YWtlIGEgbG9vay4gIEhvcGVmdWxseSB0aGV5J3JlIHNvbWV3aGF0
DQo+IHNpbWlsYXIgdG8geDg2IHN3aXRjaCB0YWJsZXMuICBPdGhlcndpc2Ugd2UgbWF5IHdhbnQg
dG8gY29uc2lkZXIgYQ0KPiBkaWZmZXJlbnQgYXBwcm9hY2ggKGZvciBleGFtcGxlIG1heWJlIGEg
R0NDIHBsdWdpbiBjb3VsZCBoZWxwIGFubm90YXRlDQo+IHRoZW0pLg0KPg0KDQpUaGUgY2FzZSB3
aGljaCBtYWRlIG1lIHJlYWxpemUgdGhlIGlzc3VlIGlzIHRoZSBvbmUgb2YNCmFyY2gvYXJtNjQv
a2VybmVsL21vZHVsZS5vOmFwcGx5X3JlbG9jYXRlX2FkZDoNCg0KYGBgDQpXaGF0IHNlZW1zIHRv
IGhhcHBlbiBpbiB0aGUgY2FzZSBvZiBtb2R1bGUubyBpczoNCiAgMzM0OiAgIDkwMDAwMDE1ICAg
ICAgICBhZHJwICAgIHgyMSwgMCA8ZG9fcmVsb2M+DQp3aGljaCByZXRyaWV2ZXMgdGhlIGxvY2F0
aW9uIG9mIGFuIG9mZnNldCBpbiB0aGUgcm9kYXRhIHNlY3Rpb24sIGFuZCBhDQpiaXQgbGF0ZXIg
d2UgZG8gc29tZSBleHRyYSBjb21wdXRhdGlvbiB3aXRoIGl0IGluIG9yZGVyIHRvIGNvbXB1dGUg
dGhlDQpqdW1wIGRlc3RpbmF0aW9uOg0KICAzZTA6ICAgNzg2MjVhYTAgICAgICAgIGxkcmggICAg
dzAsIFt4MjEsIHcyLCB1eHR3ICMxXQ0KICAzZTQ6ICAgMTAwMDAwNjEgICAgICAgIGFkciAgICAg
eDEsIDNmMCA8YXBwbHlfcmVsb2NhdGVfYWRkKzB4Zjg+DQogIDNlODogICA4YjIwYTgyMCAgICAg
ICAgYWRkICAgICB4MCwgeDEsIHcwLCBzeHRoICMyDQogIDNlYzogICBkNjFmMDAwMCAgICAgICAg
YnIgICAgICB4MA0KYGBgDQoNClBsZWFzZSBrZWVwIGluIG1pbmQgdGhhdCB0aGUgYWN0dWFsIG9m
ZnNldHMgbWlnaHQgdmFyeS4NCg0KSSdtIGhhcHB5IHRvIHByb3ZpZGUgbW9yZSBkZXRhaWxzIGFi
b3V0IHdoYXQgSSBoYXZlIGlkZW50aWZpZWQgaWYgeW91DQp3YW50IG1lIHRvLg0KDQpUaGFua3Ms
DQoNCi0tDQpSYXBoYWVsIEdhdWx0DQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2Yg
dGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBh
bHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQs
IHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3Nl
IHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3Nl
LCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5
b3UuDQo=
