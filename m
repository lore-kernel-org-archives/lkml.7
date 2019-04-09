Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83C9C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760B0217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ozAvkOwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDITKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:10:00 -0400
Received: from mail-eopbgr810084.outbound.protection.outlook.com ([40.107.81.84]:45853
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726529AbfDITJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scAius+swqN+kI28x6jFVqbmBzkPBJLkc1Wrcb8Dvss=;
 b=ozAvkOwVNBjY5nZKycTWRIN3cCUUN472+yoSTmR0qwcSEg4S4o/aVO8fuz5TThWHY4hNzfuTEzzX6k6k9Bh9sWM6aLl9py6JbrZz3h6pqZeFK135a3RNjBr9qmdoEmCxd3nXcL3ybv17GmrxjhncOVOlcXnxpM9k2uUcyoifYrQ=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3548.namprd12.prod.outlook.com (20.179.106.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Tue, 9 Apr 2019 19:09:54 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::9d54:69c5:d057:80de]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::9d54:69c5:d057:80de%3]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 19:09:54 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86: mm: Do not use set_{pud,pmd}_safe when splitting the
 large page
Thread-Topic: [PATCH] x86: mm: Do not use set_{pud,pmd}_safe when splitting
 the large page
Thread-Index: AQHU7j7arjEUvuxvBUmbKwd7TTUF0KYzg0qAgAAQgICAAJ9UAA==
Date:   Tue, 9 Apr 2019 19:09:54 +0000
Message-ID: <5511d82d-4443-bd13-a3a5-c1b5a72ce0e9@amd.com>
References: <20190408191103.13501-1-brijesh.singh@amd.com>
 <20190409084031.GO4038@hirez.programming.kicks-ass.net>
 <20190409093935.GH14281@hirez.programming.kicks-ass.net>
In-Reply-To: <20190409093935.GH14281@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0096.namprd12.prod.outlook.com
 (2603:10b6:802:21::31) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7ed85bc-6cc4-4382-af48-08d6bd1ef219
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3548;
x-ms-traffictypediagnostic: DM6PR12MB3548:
x-microsoft-antispam-prvs: <DM6PR12MB354826A46E52806F5B5CE073E52D0@DM6PR12MB3548.namprd12.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(396003)(136003)(51444003)(51914003)(199004)(189003)(6506007)(386003)(4326008)(99286004)(52116002)(31686004)(53936002)(71190400001)(305945005)(53546011)(6486002)(2906002)(7736002)(106356001)(71200400001)(68736007)(86362001)(5660300002)(102836004)(6436002)(76176011)(31696002)(26005)(186003)(25786009)(2616005)(476003)(6246003)(7416002)(14444005)(256004)(11346002)(8936002)(229853002)(66066001)(14454004)(3846002)(6512007)(6116002)(8676002)(36756003)(97736004)(316002)(105586002)(81156014)(54906003)(81166006)(486006)(6916009)(446003)(478600001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3548;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RWAVQEZYdyqz1TAuxJ6ecsMYtF640dHMd8hjh1399ou8/vxTaTAKylzyt8Ut6rrMAwCpNp/IMCgOsH/YpuDXcOdOjjnQYgGZqCjzANzrNppXlRe0FjkSkT4bBO7Aie+znLDhRUlAGAYTTORK7hfQWC6OvMYdkbTnX8YySbvMF0/TlCwc2ylAbpHvtyGi6tIeZEvcCGGP+2ZDeGjcO+Fshr+t06SvJP2Loy5EklXicDwEsor+FWAmWfMBI/UOGVc47JheuXl/pBQEXmR+vbFjtiqbtCBvT2r/8ASjJlVxfuiyN9vosuJ+xq6NA+GGEkhpNHYlqCEhyyTYDucS6EUfol92MbJ5Koqbwert/ozXWxSBJ/vLlRE3YZ2cvBxEg0/sJNQ024CbmayclPp9PylB/L9aL8X8GpyN6oXholCZ7xA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AE5843A02CA224EAF9A493F2F2788A3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ed85bc-6cc4-4382-af48-08d6bd1ef219
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 19:09:54.2452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3548
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvOS8xOSA0OjM5IEFNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMDksIDIwMTkgYXQgMTA6NDA6MzFBTSArMDIwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+
PiBPbiBNb24sIEFwciAwOCwgMjAxOSBhdCAwNzoxMToyMVBNICswMDAwLCBTaW5naCwgQnJpamVz
aCB3cm90ZToNCj4+PiBUaGUgZm9sbG93aW5nIGNvbW1pdCAwYTlmZThjYTg0NGQgKCJ4ODYvbW06
IFZhbGlkYXRlIGtlcm5lbF9waHlzaWNhbF9tYXBwaW5nX2luaXQoKQ0KPj4+IFBURSBwb3B1bGF0
aW9uIikgdHJpZ2dlcnMgdGhlIGJlbG93IHdhcm5pbmcgaW4gdGhlIFNFViBndWVzdC4NCj4+Pg0K
Pj4+IFdBUk5JTkc6IENQVTogMCBQSUQ6IDAgYXQgYXJjaC94ODYvaW5jbHVkZS9hc20vcGdhbGxv
Yy5oOjg3IHBoeXNfcG1kX2luaXQrMHgzMGQvMHgzODYNCj4+PiBDYWxsIFRyYWNlOg0KPj4+ICAg
a2VybmVsX3BoeXNpY2FsX21hcHBpbmdfaW5pdCsweGNlLzB4MjU5DQo+Pj4gICBlYXJseV9zZXRf
bWVtb3J5X2VuY19kZWMrMHgxMGYvMHgxNjANCj4+PiAgIGt2bV9zbXBfcHJlcGFyZV9ib290X2Nw
dSsweDcxLzB4OWQNCj4+PiAgIHN0YXJ0X2tlcm5lbCsweDFjOS8weDUwYg0KPj4+ICAgc2Vjb25k
YXJ5X3N0YXJ0dXBfNjQrMHhhNC8weGIwDQo+Pj4NCj4+PiBUaGUgU0VWIGd1ZXN0IGNhbGxzIGtl
cm5lbF9waHlzaWNhbF9tYXBwaW5nX2luaXQoKSB0byBjbGVhciB0aGUgZW5jcnlwdGlvbg0KPj4+
IG1hc2sgZnJvbSBhbiBleGlzdGluZyBtYXBwaW5nLiBXaGlsZSBjbGVhcmluZyB0aGUgZW5jcnlw
dGlvbiBtYXNrDQo+Pj4ga2VybmVsX3BoeXNpY2FsX21hcHBpbmdfaW5pdCgpIHNwbGl0cyB0aGUg
bGFyZ2UgcGFnZXMgaW50byB0aGUgc21hbGxlci4NCj4+PiBUbyBzcGxpdCB0aGUgcGFnZSwgdGhl
IGtlcm5lbF9waHlzaWNhbF9tYXBwaW5nX2luaXQoKSBhbGxvY2F0ZXMgYSBuZXcgcGFnZQ0KPj4+
IGFuZCB1cGRhdGVzIHRoZSBleGlzdGluZyBlbnRyeS4gVGhlIHNldF97cHVkLHBtZH1fc2FmZSB0
cmlnZ2VycyB3YXJuaW5nDQo+Pj4gd2hlbiB1cGRhdGluZyB0aGUgZW50cnkgd2l0aCBwYWdlIGlu
IHRoZSBwcmVzZW50IHN0YXRlLiBXZSBzaG91bGQgdXNlIHRoZQ0KPj4+IHNldF97cHVkLHBtZH0g
d2hlbiB1cGRhdGluZyBhbiBleGlzdGluZyBlbnRyeSB3aXRoIHRoZSBuZXcgZW50cnkuDQo+Pj4N
Cj4+PiBVcGRhdGluZyBhbiBlbnRyeSB3aWxsIGFsc28gcmVxdWlyZXMgYSBUTEIgZmx1c2guIEN1
cnJlbnRseSB0aGUgY2FsbGVyDQo+Pj4gKGVhcmx5X3NldF9tZW1vcnlfZW5jX2RlYygpKSBpcyB0
YWtpbmcgY2FyZSBvZiBpc3N1aW5nIHRoZSBUTEIgZmx1c2hlcy4NCj4+DQo+PiBJJ20gbm90IGVu
dGlyZWx5IHN1cmUgSSBsaWtlIHRoaXMsIHRoaXMgbWVhbnMgYWxsIHVzZXJzIG9mDQo+PiBrZXJu
ZWxfcGh5c2ljYWxfbWFwcGluZ19pbml0KCkgbm93IG5lZWQgdG8gYmUgYXdhcmUgYW5kIGNhcmVm
dWwuDQo+Pg0KPj4gVGhhdCBzYWlkOyB0aGUgYWx0ZXJuYXRpdmUgaXMgYWRkaW5nIGFuIGFyZ3Vt
ZW50IHRvIHRoZSBmdW5jdGlvbiBhbmQNCj4+IHByb3BhZ2F0aW5nIGl0IHRocm91Z2ggdGhlIGNh
bGxjaGFpbiBhbmQgZHluYW1pY2FsbHkgc3dpdGNoaW5nIGJldHdlZW4NCj4+IF9zYWZlIGFuZCBu
b3QuIFdoaWNoIGRvZXNuJ3Qgc291bmQgaWRlYWwgZWl0aGVyLg0KPj4NCj4+IEFueWJvZHkgZWxz
ZSBnb3QgY2xldmVyIGlkZWFzPw0KPiANCj4gVGhlIG1vcmUgSSB0aGluayBhYm91dCBpdCwgSSB0
aGluayB0aGF0IGlzIGluIGZhY3QgdGhlIHJpZ2h0IHRoaW5nIHRvDQo+IGRvLg0KPiANCj4gUmVu
YW1lIGtlcm5lbF9waHlzaWNhbF9tYXBwaW5nX2luaXQoKSB0byBfXyYgYW5kIGFkZCB0aGF0IGZs
YWcsIHRocmVhZA0KPiBpdCBkb3duIHRvIGFsbCB0aGUgc2V0X3twdWQscG1kLnB0ZX0oKSB0aGlu
Z2llcy4gVGhlbiBhZGQ6DQo+IA0KPiB1bnNpZ25lZCBsb25nIGtlcm5lbF9waHlzaWNhbF9tYXBw
aW5nX2luaXQodW5zaWduZWQgbG9uZyBwYWRkcl9zdGFydCwgdW5zaWduZWQNCj4gCQlsb25nIHBh
ZGRyX2VuZCwgdW5zaWduZWQgbG9uZyBwYWdlX3NpemVfbWFzaykNCj4gew0KPiAJcmV0dXJuIF9f
a2VybmVsX3BoeXNpY2FsX21hcHBpbmdfaW5pdChwYWRkcl9zdGFydCwgcGFkZHJfZW5kLCBwYWdl
X3NpemVfbWFzaywgdHJ1ZSk7DQo+IH0NCj4gDQo+IHVuc2lnbmVkIGxvbmcga2VybmVsX3BoeXNp
Y2FsX21hcHBpbmdfY2hhbmdlKHVuc2lnbmVkIGxvbmcgcGFkZHJfc3RhcnQsIHVuc2lnbmVkDQo+
IAkJbG9uZyBwYWRkcl9lbmQsIHVuc2lnbmVkIGxvbmcgcGFnZV9zaXplX21hc2spDQo+IHsNCj4g
CXVuc2lnbmVkIGxvbmcgbGFzdDsNCj4gDQo+IAlsYXN0ID0gX19rZXJuZWxfcGh5c2ljYWxfbWFw
cGluZ19pbml0KHBhZGRyX3N0YXJ0LCBwYWRkcl9lbmQsIHBhZ2Vfc2l6ZV9tYXNrLCBmYWxzZSk7
DQo+IA0KPiAJX19mbHVzaF90bGJfYWxsKCk7DQo+IA0KPiAJcmV0dXJuIGxhc3Q7DQo+IH0NCj4g
DQo+IE9yIHNvbWV0aGluZyBhbG9uZyB0aG9zZSBsaW5lcy4NCg0KDQp0aGFua3MgZm9yIHRoZSBj
b21tZW50LiBTbyByZWdhcmRpbmcgY2hhbmdpbmcgYWxsIHRoZSBzZXRfe3B1ZCxwbWQscHRlfQ0K
dGhpbmdpZXMsIEkgY2FuIGdvIGluIG9uZSBvZiB0aGUgdHdvIG9wdGlvbnMgYmVsb3csIHBsZWFz
ZSBsZXQgbWUga25vdw0Kd2hpY2ggaXMgcHJlZmVycmVkLg0KDQoxKSBVcGRhdGUgYWxsIHRoZSBm
dW5jdGlvbnMgdG8gY2hlY2sgZm9yIHRoZSBmbGFnIGFuZCB1c2UgdGhlIHNhZmUgdnMNCm5vbi1z
YWZlIHZhcmlhbnRzIGFjY29yZGluZ2x5LiBTb21ldGhpbmcgc2ltaWxhciB0byB0aGlzOg0KDQog
ICAgaWYgKHVzZV9zYWZlKQ0KICAgICAgIHNldF9wbWRfc2FmZSguLi4pDQogICAgZWxzZQ0KICAg
ICAgIHNldF9wbWQoLi4pDQoNCiAgICAuLi4uDQogICAgaWYgKHVzZV9zYWZlKQ0KICAgICAgIHBt
ZF9wb3B1bGF0ZV9rZXJuZWxfc2FmZSguLi4pDQogICAgZWxzZQ0KICAgICAgIHBtZF9wb3B1bGF0
ZSguLi4pDQoNClRoZXJlIGFyZSBtdWx0aXBsZSBwbGFjZXMgd2hlcmUgd2UgbmVlZCB0byBhZGQg
dGhlIGFib3ZlIGNoZWNrLg0KDQoyKSBEZWZpbmUgbmV3IF9fJiB2YXJpYW50cyBvZiBzZXRfe3B1
ZCxwbWQscHRlfSBhbmQgcG9wdWxhdGVfe3B1ZCwuLn0NCmFuZCB1cGRhdGUgdGhlIGNhbGxlcnMg
dG8gdXNlIHRoZSBfXyYuIFNvbWV0aGluZyBsaWtlIHRoaXM6DQoNCiNkZWZpbmUgREVGSU5FX1BP
UFVMQVRFKGZuYW1lLCB0eXBlMSwgdHlwZTIsIHNhZmUpICAgICAgICAgICAgICBcDQpzdGF0aWMg
dm9pZCBpbmxpbmUgX18jI2ZuYW1lKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCAgICAgICAgICAgICAg
XA0KICAgICAgICAgICAgICAgICB0eXBlMSMjX3QgKmFyZzEsIHR5cGUyIyNfdCAqYXJnMiwgYm9v
bCBzYWZlKSAgICBcDQp7CQkJCQkJCQlcDQoJaWYgKHNhZmUpCQkJCQkJXA0KCQlmbmFtZSMjX3Nh
ZmUobW0sIGFyZzEsIGFyZzIpOwkJCVwNCgllbHNlDQoJCWZuYW1lKG1tLCBhcmcxLCBhcmcyKTsJ
CQkJXA0KfQ0KDQpERUZJTkVfUE9QVUxBVEUocDRkX3BvcHVsYXRlLCBwNGQsIHB1ZCwgc2FmZSkN
CkRFRklORV9QT1BVTEFURShwZ2RfcG9wdWxhdGUsIHBnZCwgcDRkLCBzYWZlKQ0KREVGSU5FX1BP
UFVMQVRFKHB1ZF9wb3B1bGF0ZSwgcHVkLCBwbWQsIHNhZmUpDQpERUZJTkVfUE9QVUxBVEUocG1k
X3BvcHVsYXRlX2tlcm5lbCwgcG1kLCBwdGUsIHNhZmUpDQoNCkkgcHJlZmVyICMyIGJlY2F1c2Ug
aXQgc3RpbGwga2VlcHMgdGhlIGNvZGUgcmVhZGFibGUgYW5kIG1pbmltaXplIHRoZQ0KY2hhbmdl
cyBpbiB0aGUgcGF0Y2ggZmlsZS4NCg0KdGhhbmtzDQo=
