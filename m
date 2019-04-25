Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE3FC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E27205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="DK9E5P4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfDYTmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:42:11 -0400
Received: from mail-eopbgr760088.outbound.protection.outlook.com ([40.107.76.88]:55107
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbfDYTmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Szpztop4g8mkoEOjNkf7dGV3p9Cj4XLw0LvVRq8R9Vw=;
 b=DK9E5P4Ch+R1fAQQlgfeUw2JBchLD176aMcogJdjwn9o6gFKLGxUWD5LXgxKvS2zZcN4dtj0i8HgZqbfCrdySLnWq+odNOvxVR4vXGDXXPZnHri1337s6Sdk9du4kDlnPkmZhqTWpGGhNdcLuUnr9RiZPktsUhFRf14hYPTqnv4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6630.namprd05.prod.outlook.com (20.179.60.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 19:42:06 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094%3]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 19:42:06 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2] x86/mm/tlb: Remove flush_tlb_info from the stack
Thread-Topic: [PATCH v2] x86/mm/tlb: Remove flush_tlb_info from the stack
Thread-Index: AQHU+5HncRUmcKTEhES/sxCi8aqoJ6ZNQ0QAgAADhIA=
Date:   Thu, 25 Apr 2019 19:42:06 +0000
Message-ID: <82E44F4A-E52D-4666-95B5-C6248A14A442@vmware.com>
References: <20190425180828.24959-1-namit@vmware.com>
 <20190425192930.GA91578@gmail.com>
In-Reply-To: <20190425192930.GA91578@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 472cb840-2d2d-435e-236e-08d6c9b61936
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB6630;
x-ms-traffictypediagnostic: BYAPR05MB6630:
x-microsoft-antispam-prvs: <BYAPR05MB66302596744DE64537AAA164D03D0@BYAPR05MB6630.namprd05.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(189003)(68736007)(73956011)(66476007)(26005)(316002)(478600001)(229853002)(66556008)(6246003)(53546011)(76116006)(54906003)(2906002)(256004)(14454004)(66446008)(64756008)(81166006)(6506007)(33656002)(4326008)(25786009)(8936002)(7736002)(3846002)(305945005)(6116002)(446003)(6486002)(66066001)(86362001)(71200400001)(36756003)(102836004)(82746002)(6512007)(2616005)(476003)(11346002)(6436002)(53936002)(99286004)(486006)(71190400001)(83716004)(97736004)(81156014)(76176011)(8676002)(186003)(66946007)(6916009)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6630;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4WVvnlGfdBGvdcYQq5NbFccd1pfN1lWjKtiMC89gKpSYA3FWyJasUcF2uZjcbphser+oy+uyOXBwI7xFm4/FcgbEVLPoRkz6fm/ZZVhBW5a8wp1DNxvVS8qbi9uKuKxAktcR9kg4s1/WvylM+syZJ137cH/53DoTrXh5lPJEfJuYZLUQVzl4MLRqPW/eUiou40SLvC3Vut2QuWB1xAkARBWAKvoSfFFxCnAWyYYV8OLa3NwpLOWkY4xIkMx7HeW12vK2VGq5LpiynwJVEShxr2HLDe3Blh/ZswTGBelqoYgWw3Yhu/0EvtO1Lo7yh8bWWsDThelGiuIoFjnExuFaJ+A3j3yRqqwngbXuDofL2G5HepagclX11E/i/M3U+zILWS1Z5jh9XWmPTBXt1ibWZbYVkFvDlX3qFaPaH+JK95Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FC1DD67E908324A9649274E2B90E948@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472cb840-2d2d-435e-236e-08d6c9b61936
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 19:42:06.2283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBBcHIgMjUsIDIwMTksIGF0IDEyOjI5IFBNLCBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVs
Lm9yZz4gd3JvdGU6DQo+IA0KPiANCj4gKiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3
cm90ZToNCj4gDQo+PiBNb3ZlIGZsdXNoX3RsYl9pbmZvIHZhcmlhYmxlcyBvZmYgdGhlIHN0YWNr
LiBUaGlzIGFsbG93cyB0byBhbGlnbg0KPj4gZmx1c2hfdGxiX2luZm8gdG8gY2FjaGUtbGluZSBh
bmQgYXZvaWQgcG90ZW50aWFsbHkgdW5uZWNlc3NhcnkgY2FjaGUNCj4+IGxpbmUgbW92ZW1lbnRz
LiBJdCBhbHNvIGFsbG93cyB0byBoYXZlIGEgZml4ZWQgdmlydHVhbC10by1waHlzaWNhbA0KPj4g
dHJhbnNsYXRpb24gb2YgdGhlIHZhcmlhYmxlcywgd2hpY2ggcmVkdWNlcyBUTEIgbWlzc2VzLg0K
Pj4gDQo+PiBVc2UgcGVyLUNQVSBzdHJ1Y3QgZm9yIGZsdXNoX3RsYl9tbV9yYW5nZSgpIGFuZA0K
Pj4gZmx1c2hfdGxiX2tlcm5lbF9yYW5nZSgpLiBBZGQgZGVidWcgYXNzZXJ0aW9ucyB0byBlbnN1
cmUgdGhlcmUgYXJlDQo+PiBubyBuZXN0ZWQgVExCIGZsdXNoZXMgdGhhdCBtaWdodCBvdmVyd3Jp
dGUgdGhlIHBlci1DUFUgZGF0YS4gRm9yDQo+PiBhcmNoX3RsYmJhdGNoX2ZsdXNoKCkgdXNlIGEg
Y29uc3Qgc3RydWN0Lg0KPj4gDQo+PiBSZXN1bHRzIHdoZW4gcnVubmluZyBhIG1pY3JvYmVuY2ht
YXJrcyB0aGF0IHBlcmZvcm1zIDEwXjYgTUFEVl9ET05URUVEDQo+PiBvcGVyYXRpb25zIGFuZCB0
b3VjaGluZyBhIHBhZ2UsIGluIHdoaWNoIDMgYWRkaXRpb25hbCB0aHJlYWRzIHJ1biBhDQo+PiBi
dXN5LXdhaXQgbG9vcCAoNSBydW5zLCBQVEkgYW5kIHJldHBvbGluZXMgYXJlIHR1cm5lZCBvZmYp
Og0KPj4gDQo+PiAJCQliYXNlCQlvZmYtc3RhY2sNCj4+IAkJCS0tLS0JCS0tLS0tLS0tLQ0KPj4g
YXZnICh1c2VjL29wKQkJMS42MjkJCTEuNTcwCSgtMyUpDQo+PiBzdGRkZXYJCQkwLjAxNAkJMC4w
MDkNCj4+IA0KPj4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4+
IENjOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCj4+IENjOiBEYXZlIEhhbnNl
biA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPj4gQ2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxp
ZW44LmRlPg0KPj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPj4g
U2lnbmVkLW9mZi1ieTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4+IA0KPj4gLS0t
DQo+PiANCj4+IHYxLT52MjoNCj4+IC0gSW5pdGlhbGl6ZSBhbGwgZmx1c2hfdGxiX2luZm8gZmll
bGRzIFtBbmR5XQ0KPj4gLS0tDQo+PiBhcmNoL3g4Ni9tbS90bGIuYyB8IDEwMCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+PiAxIGZpbGUgY2hhbmdlZCwg
NzQgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9tbS90bGIuYyBiL2FyY2gveDg2L21tL3RsYi5jDQo+PiBpbmRleCA0ODdiODQ3NGMw
MWMuLmFhYzE5MWViMmI5MCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L21tL3RsYi5jDQo+PiAr
KysgYi9hcmNoL3g4Ni9tbS90bGIuYw0KPj4gQEAgLTYzNCw3ICs2MzQsNyBAQCBzdGF0aWMgdm9p
ZCBmbHVzaF90bGJfZnVuY19jb21tb24oY29uc3Qgc3RydWN0IGZsdXNoX3RsYl9pbmZvICpmLA0K
Pj4gCXRoaXNfY3B1X3dyaXRlKGNwdV90bGJzdGF0ZS5jdHhzW2xvYWRlZF9tbV9hc2lkXS50bGJf
Z2VuLCBtbV90bGJfZ2VuKTsNCj4+IH0NCj4+IA0KPj4gLXN0YXRpYyB2b2lkIGZsdXNoX3RsYl9m
dW5jX2xvY2FsKHZvaWQgKmluZm8sIGVudW0gdGxiX2ZsdXNoX3JlYXNvbiByZWFzb24pDQo+PiAr
c3RhdGljIHZvaWQgZmx1c2hfdGxiX2Z1bmNfbG9jYWwoY29uc3Qgdm9pZCAqaW5mbywgZW51bSB0
bGJfZmx1c2hfcmVhc29uIHJlYXNvbikNCj4+IHsNCj4+IAljb25zdCBzdHJ1Y3QgZmx1c2hfdGxi
X2luZm8gKmYgPSBpbmZvOw0KPj4gDQo+PiBAQCAtNzIyLDQzICs3MjIsODEgQEAgdm9pZCBuYXRp
dmVfZmx1c2hfdGxiX290aGVycyhjb25zdCBzdHJ1Y3QgY3B1bWFzayAqY3B1bWFzaywNCj4+ICAq
Lw0KPj4gdW5zaWduZWQgbG9uZyB0bGJfc2luZ2xlX3BhZ2VfZmx1c2hfY2VpbGluZyBfX3JlYWRf
bW9zdGx5ID0gMzM7DQo+PiANCj4+ICtzdGF0aWMgREVGSU5FX1BFUl9DUFVfU0hBUkVEX0FMSUdO
RUQoc3RydWN0IGZsdXNoX3RsYl9pbmZvLCBmbHVzaF90bGJfaW5mbyk7DQo+PiArDQo+PiArI2lm
ZGVmIENPTkZJR19ERUJVR19WTQ0KPj4gK3N0YXRpYyBERUZJTkVfUEVSX0NQVSh1bnNpZ25lZCBp
bnQsIGZsdXNoX3RsYl9pbmZvX2lkeCk7DQo+PiArI2VuZGlmDQo+PiArDQo+PiArc3RhdGljIGlu
bGluZSBzdHJ1Y3QgZmx1c2hfdGxiX2luZm8gKmdldF9mbHVzaF90bGJfaW5mbyhzdHJ1Y3QgbW1f
c3RydWN0ICptbSwNCj4+ICsJCQl1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGVu
ZCwNCj4+ICsJCQl1bnNpZ25lZCBpbnQgc3RyaWRlX3NoaWZ0LCBib29sIGZyZWVkX3RhYmxlcywN
Cj4+ICsJCQl1NjQgbmV3X3RsYl9nZW4pDQo+PiArew0KPj4gKwlzdHJ1Y3QgZmx1c2hfdGxiX2lu
Zm8gKmluZm8gPSB0aGlzX2NwdV9wdHIoJmZsdXNoX3RsYl9pbmZvKTsNCj4+ICsNCj4+ICsjaWZk
ZWYgQ09ORklHX0RFQlVHX1ZNDQo+PiArCS8qDQo+PiArCSAqIEVuc3VyZSB0aGF0IHRoZSBmb2xs
b3dpbmcgY29kZSBpcyBub24tcmVlbnRyYW50IGFuZCBmbHVzaF90bGJfaW5mbw0KPj4gKwkgKiBp
cyBub3Qgb3ZlcndyaXR0ZW4uIFRoaXMgbWVhbnMgbm8gVExCIGZsdXNoaW5nIGlzIGluaXRpYXRl
ZCBieQ0KPj4gKwkgKiBpbnRlcnJ1cHQgaGFuZGxlcnMgYW5kIG1hY2hpbmUtY2hlY2sgZXhjZXB0
aW9uIGhhbmRsZXJzLg0KPj4gKwkgKi8NCj4+ICsJQlVHX09OKHRoaXNfY3B1X2luY19yZXR1cm4o
Zmx1c2hfdGxiX2luZm9faWR4KSAhPSAxKTsNCj4+ICsjZW5kaWYNCj4gDQo+IGlzbid0IHRoaXMg
ZWZmZWN0aXZlbHkgVk1fQlVHX09OKCk/DQoNCk5vdCBleGFjdGx5LiBXaGVuIENPTkZJR19ERUJV
R19WTSBpcyBvZmYgd2UgZ2V0DQoNCgkjZGVmaW5lIFZNX0JVR19PTihjb25kKSBCVUlMRF9CVUdf
T05fSU5WQUxJRChjb25kKQ0KDQpUaGlzIHdpbGwgY2F1c2UgdGhlIGJ1aWxkIHRvIGZhaWwgc2lu
Y2UgZmx1c2hfdGxiX2luZm9faWR4IGlzIG5vdCBkZWZpbmVkIGluDQp3aGVuIENPTkZJR19ERUJV
R19WTSBpcyBvZmYuDQoNCg0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBwdXRfZmx1c2hfdGxiX2lu
Zm8odm9pZCkNCj4+ICt7DQo+PiArI2lmZGVmIENPTkZJR19ERUJVR19WTQ0KPj4gKwkvKiBDb21w
bGV0ZSByZWVudHJlbmN5IHByZXZlbnRpb24gY2hlY2tzICovDQo+PiArCWJhcnJpZXIoKTsNCj4+
ICsJdGhpc19jcHVfZGVjKGZsdXNoX3RsYl9pbmZvX2lkeCk7DQo+PiArI2VuZGlmDQo+IA0KPiBJ
biBwcmluY2lwbGUgdGhpc19jcHVfZGVjKCkgc2hvdWxkIGltcGx5IGEgY29tcGlsZXIgYmFycmll
cj8NCg0KdGhpc19jcHVfZGVjKCkgaXMgZXZlbnR1YWxseSBleHBhbmRlZCB0byB0aGUgbWFjcm8g
b2YgcGVyY3B1X2FkZF9vcCgpLiBBbmQNCnRoZSBpbmxpbmUgYXNzZW1ibHkgZG9lcyBub3QgaGF2
ZSBhIOKAnG1lbW9yeeKAnSBjbG9iYmVyLCBzbyBJIGRvbuKAmXQgdGhpbmsgc28uDQoNCkkgd2ls
bCBhZGRyZXNzIHlvdXIgb3RoZXIgY29tbWVudHMuIFRoYW5rcyENCg0K
