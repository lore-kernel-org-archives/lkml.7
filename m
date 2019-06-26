Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC259C48BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8532063F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Iuc2V5mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFZB5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:57:51 -0400
Received: from mail-eopbgr780088.outbound.protection.outlook.com ([40.107.78.88]:1728
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbfFZB5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCgU2UIfthTc7xUNHwpOrLgWLHU77DfS0BTrmmOH1Gg=;
 b=Iuc2V5mriIE+rdiWksQpVH1QvXNXvLLbj9o4mFQvCmOvq5I3JPkZaOFAi5jmvIZp2peWSobVB+qQEy6zwX90pxxmuLqtNIu3UjVihfwgPTB22OpfXltxM0l7vffG0itrni6Wmw8Cxu7UmL0Vp2AYl9VHkswjsJ2jo7K+I/dPh9I=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5208.namprd05.prod.outlook.com (20.177.231.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.12; Wed, 26 Jun 2019 01:57:46 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2008.007; Wed, 26 Jun 2019
 01:57:45 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 3/9] x86/mm/tlb: Refactor common code into
 flush_tlb_on_cpus()
Thread-Topic: [PATCH 3/9] x86/mm/tlb: Refactor common code into
 flush_tlb_on_cpus()
Thread-Index: AQHVIbQhVsEritjn5k+CF/E65fz2xqas8JOAgABRHIA=
Date:   Wed, 26 Jun 2019 01:57:45 +0000
Message-ID: <30E271DF-8D6B-4D5F-8033-9B17F6990994@vmware.com>
References: <20190613064813.8102-1-namit@vmware.com>
 <20190613064813.8102-4-namit@vmware.com>
 <9079f1f2-103b-42ca-853e-07ae2566eb72@intel.com>
In-Reply-To: <9079f1f2-103b-42ca-853e-07ae2566eb72@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [204.134.128.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2514195d-ff27-47d0-ff09-08d6f9d9af0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5208;
x-ms-traffictypediagnostic: BYAPR05MB5208:
x-microsoft-antispam-prvs: <BYAPR05MB5208403A8B4134BD4A601F6FD0E20@BYAPR05MB5208.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(39860400002)(136003)(51914003)(189003)(199004)(8676002)(64756008)(71200400001)(3846002)(66556008)(73956011)(6116002)(66446008)(33656002)(54906003)(478600001)(6436002)(486006)(76116006)(316002)(5660300002)(14444005)(256004)(6916009)(25786009)(102836004)(14454004)(71190400001)(53936002)(53546011)(6486002)(26005)(66066001)(6506007)(91956017)(66476007)(4326008)(66946007)(86362001)(186003)(229853002)(305945005)(6246003)(2616005)(36756003)(11346002)(7736002)(446003)(81166006)(81156014)(476003)(2906002)(68736007)(76176011)(99286004)(6512007)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5208;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pWzwdvvTncVvWHVRBKSPga2TFNwzpCew6vmmLODKF/oAjF71wxwj/3Q+Zhay9GdRHFwLBW71yoxlrXKNcT0zH9MJappzzs6B21CrNd5x1dcKjNz92G+IpeyXhbOEW3RuiyR3ydiVAWITeCB6XmK8/xSwkTXnMEP7km8j3w9cNwXdBlUBScsgqbzzgjplAo5wC/IMYjY+dO06gsKFw3T397nSaZj/HWGaaGrmkYmCEL6rWiGGNQ1JQDOd3XN3ySL2HyZG0+fmYHS/XMQiEhUH1e7B3nxN14lP0hnkMcirErWY39cItSfFPXRLa3GvSOkprphmHTwOO+3MxGntSXkOMz/NHtqj1UA0ZY1yUIEroftuk1n80MJsE0xVBnsZrZ/EYKXIdcnYlVECMXj7DFzj9GhVXx4sYTP1qzlwEcFhjfo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <850B46AB0029C6479810B656182E5A57@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2514195d-ff27-47d0-ff09-08d6f9d9af0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 01:57:45.8477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gMjUsIDIwMTksIGF0IDI6MDcgUE0sIERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBp
bnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gNi8xMi8xOSAxMTo0OCBQTSwgTmFkYXYgQW1pdCB3
cm90ZToNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS90bGIuYyBiL2FyY2gveDg2L21tL3Rs
Yi5jDQo+PiBpbmRleCA5MWY2ZGI5MjU1NGMuLmMzNGJjZjAzZjA2ZiAxMDA2NDQNCj4+IC0tLSBh
L2FyY2gveDg2L21tL3RsYi5jDQo+PiArKysgYi9hcmNoL3g4Ni9tbS90bGIuYw0KPj4gQEAgLTcz
NCw3ICs3MzQsMTEgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgZmx1c2hfdGxiX2luZm8gKmdldF9m
bHVzaF90bGJfaW5mbyhzdHJ1Y3QgbW1fc3RydWN0ICptbSwNCj4+IAkJCXVuc2lnbmVkIGludCBz
dHJpZGVfc2hpZnQsIGJvb2wgZnJlZWRfdGFibGVzLA0KPj4gCQkJdTY0IG5ld190bGJfZ2VuKQ0K
Pj4gew0KPj4gLQlzdHJ1Y3QgZmx1c2hfdGxiX2luZm8gKmluZm8gPSB0aGlzX2NwdV9wdHIoJmZs
dXNoX3RsYl9pbmZvKTsNCj4+ICsJc3RydWN0IGZsdXNoX3RsYl9pbmZvICppbmZvOw0KPj4gKw0K
Pj4gKwlwcmVlbXB0X2Rpc2FibGUoKTsNCj4+ICsNCj4+ICsJaW5mbyA9IHRoaXNfY3B1X3B0cigm
Zmx1c2hfdGxiX2luZm8pOw0KPj4gDQo+PiAjaWZkZWYgQ09ORklHX0RFQlVHX1ZNDQo+PiAJLyoN
Cj4+IEBAIC03NjIsNiArNzY2LDIzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBwdXRfZmx1c2hfdGxi
X2luZm8odm9pZCkNCj4+IAliYXJyaWVyKCk7DQo+PiAJdGhpc19jcHVfZGVjKGZsdXNoX3RsYl9p
bmZvX2lkeCk7DQo+PiAjZW5kaWYNCj4+ICsJcHJlZW1wdF9lbmFibGUoKTsNCj4+ICt9DQo+IA0K
PiBUaGUgYWRkaXRpb24gb2YgdGhpcyBkaXNhYmxlL2VuYWJsZSBwYWlyIGlzIHVuY2hhbmdlbG9n
Z2VkIGFuZA0KPiB1bmNvbW1lbnRlZC4gIEkgdGhpbmsgaXQgbWFrZXMgc2Vuc2Ugc2luY2Ugd2Ug
ZG8gbmVlZCB0byBtYWtlIHN1cmUgd2UNCj4gc3RheSBvbiB0aGlzIENQVSwgYnV0IGl0IHdvdWxk
IGJlIG5pY2UgdG8gbWVudGlvbi4NCg0KSeKAmWxsIGFkZCBzb21lIGNvbW1lbnRzIGFuZCB1cGRh
dGUgdGhlIGNoYW5nZWxpbmcgLiBJIHNlZSBJIG1hcmtlZA0KZ2V0X2ZsdXNoX3RsYl9pbmZvKCkg
YXMg4oCcaW5saW5l4oCdIGZvciBubyByZWFzb24uIEnigJltIGdvaW5nIHRvIHJlbW92ZSBpdCBp
bg0KdGhpcyBwYXRjaCwgdW5sZXNzIHlvdSBzYXkgaXQgc2hvdWxkIGJlIGluIGEgc2VwYXJhdGUg
cGF0Y2guDQoNCj4+ICtzdGF0aWMgdm9pZCBmbHVzaF90bGJfb25fY3B1cyhjb25zdCBjcHVtYXNr
X3QgKmNwdW1hc2ssDQo+PiArCQkJICAgICAgY29uc3Qgc3RydWN0IGZsdXNoX3RsYl9pbmZvICpp
bmZvKQ0KPj4gK3sNCj4gDQo+IE1pZ2h0IGJlIG5pY2UgdG8gbWVudGlvbiB0aGF0IHByZWVtcHQg
bXVzdCBiZSBkaXNhYmxlZC4gIEl0J3Mga2luZGENCj4gaW1wbGllZCBmcm9tIHRoZSBzbXBfcHJv
Y2Vzc29yX2lkKCksIGJ1dCBiZWluZyBleHBsaWNpdCBpcyBhbHdheXMgbmljZSB0b28uDQoNCkkg
d2lsbCBhZGQgYSBjb21tZW50LCBhbHRob3VnaCBzbXBfcHJvY2Vzc29yX2lkKCkgc2hvdWxkIGFu
eWhvdyBzaG91dCBhdCB5b3UNCmlmIHlvdSB1c2UgaXQgd2l0aCBDT05GSUdfREVCVUdfUFJFRU1Q
VD15Lg0KDQo+PiArCWludCB0aGlzX2NwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsNCj4+ICsNCj4+
ICsJaWYgKGNwdW1hc2tfdGVzdF9jcHUodGhpc19jcHUsIGNwdW1hc2spKSB7DQo+PiArCQlsb2Nr
ZGVwX2Fzc2VydF9pcnFzX2VuYWJsZWQoKTsNCj4+ICsJCWxvY2FsX2lycV9kaXNhYmxlKCk7DQo+
PiArCQlmbHVzaF90bGJfZnVuY19sb2NhbChpbmZvLCBUTEJfTE9DQUxfTU1fU0hPT1RET1dOKTsN
Cj4+ICsJCWxvY2FsX2lycV9lbmFibGUoKTsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlpZiAoY3B1bWFz
a19hbnlfYnV0KGNwdW1hc2ssIHRoaXNfY3B1KSA8IG5yX2NwdV9pZHMpDQo+PiArCQlmbHVzaF90
bGJfb3RoZXJzKGNwdW1hc2ssIGluZm8pOw0KPj4gfQ0KPj4gDQo+PiB2b2lkIGZsdXNoX3RsYl9t
bV9yYW5nZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgdW5zaWduZWQgbG9uZyBzdGFydCwNCj4+IEBA
IC03NzAsOSArNzkxLDYgQEAgdm9pZCBmbHVzaF90bGJfbW1fcmFuZ2Uoc3RydWN0IG1tX3N0cnVj
dCAqbW0sIHVuc2lnbmVkIGxvbmcgc3RhcnQsDQo+PiB7DQo+PiAJc3RydWN0IGZsdXNoX3RsYl9p
bmZvICppbmZvOw0KPj4gCXU2NCBuZXdfdGxiX2dlbjsNCj4+IC0JaW50IGNwdTsNCj4+IC0NCj4+
IC0JY3B1ID0gZ2V0X2NwdSgpOw0KPj4gDQo+PiAJLyogU2hvdWxkIHdlIGZsdXNoIGp1c3QgdGhl
IHJlcXVlc3RlZCByYW5nZT8gKi8NCj4+IAlpZiAoKGVuZCA9PSBUTEJfRkxVU0hfQUxMKSB8fA0K
Pj4gQEAgLTc4NywxOCArODA1LDE4IEBAIHZvaWQgZmx1c2hfdGxiX21tX3JhbmdlKHN0cnVjdCBt
bV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0KPj4gCWluZm8gPSBnZXRfZmx1c2hf
dGxiX2luZm8obW0sIHN0YXJ0LCBlbmQsIHN0cmlkZV9zaGlmdCwgZnJlZWRfdGFibGVzLA0KPj4g
CQkJCSAgbmV3X3RsYl9nZW4pOw0KPj4gDQo+PiAtCWlmIChtbSA9PSB0aGlzX2NwdV9yZWFkKGNw
dV90bGJzdGF0ZS5sb2FkZWRfbW0pKSB7DQo+PiAtCQlsb2NrZGVwX2Fzc2VydF9pcnFzX2VuYWJs
ZWQoKTsNCj4+IC0JCWxvY2FsX2lycV9kaXNhYmxlKCk7DQo+PiAtCQlmbHVzaF90bGJfZnVuY19s
b2NhbChpbmZvLCBUTEJfTE9DQUxfTU1fU0hPT1RET1dOKTsNCj4+IC0JCWxvY2FsX2lycV9lbmFi
bGUoKTsNCj4+IC0JfQ0KPj4gKwkvKg0KPj4gKwkgKiBBc3NlcnQgdGhhdCBtbV9jcHVtYXNrKCkg
Y29ycmVzcG9uZHMgd2l0aCB0aGUgbG9hZGVkIG1tLiBXZSBnb3Qgb25lDQo+PiArCSAqIGV4Y2Vw
dGlvbjogZm9yIGluaXRfbW0gd2UgZG8gbm90IG5lZWQgdG8gZmx1c2ggYW55dGhpbmcsIGFuZCB0
aGUNCj4+ICsJICogY3B1bWFzayBkb2VzIG5vdCBjb3JyZXNwb25kIHdpdGggbG9hZGVkX21tLg0K
Pj4gKwkgKi8NCj4+ICsJVk1fV0FSTl9PTl9PTkNFKGNwdW1hc2tfdGVzdF9jcHUoc21wX3Byb2Nl
c3Nvcl9pZCgpLCBtbV9jcHVtYXNrKG1tKSkgIT0NCj4+ICsJCQkobW0gPT0gdGhpc19jcHVfcmVh
ZChjcHVfdGxic3RhdGUubG9hZGVkX21tKSkgJiYNCj4+ICsJCQltbSAhPSAmaW5pdF9tbSk7DQo+
IA0KPiBWZXJ5IHZlcnkgY29vbC4gIFlvdSB0aG91Z2h0ICJ0aGVzZSBzaG91bGQgYmUgZXF1aXZh
bGVudCIsIGFuZCB5b3UgYWRkZWQNCj4gYSBjb3JyZXNwb25kaW5nIHdhcm5pbmcgdG8gZW5zdXJl
IHRoZXkgYXJlLg0KDQpUaGUgY3JlZGl0IGZvciB0aGlzIGFzc2VydGlvbiBnb2VzIHRvIFBldGVy
IHdobyBzdWdnZXN0ZWQgSSBhZGQgaXQuLi4NCg0KPiANCj4+IC0JaWYgKGNwdW1hc2tfYW55X2J1
dChtbV9jcHVtYXNrKG1tKSwgY3B1KSA8IG5yX2NwdV9pZHMpDQo+PiAtCQlmbHVzaF90bGJfb3Ro
ZXJzKG1tX2NwdW1hc2sobW0pLCBpbmZvKTsNCj4+ICsJZmx1c2hfdGxiX29uX2NwdXMobW1fY3B1
bWFzayhtbSksIGluZm8pOw0KPj4gDQo+PiAJcHV0X2ZsdXNoX3RsYl9pbmZvKCk7DQo+PiAtCXB1
dF9jcHUoKTsNCj4+IH0NCj4gDQo+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IERhdmUgSGFuc2VuIDxk
YXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3Mgb2Yg
dGhpcyBwYXRjaCBhbmQgdGhlIG90aGVycyAoZG9u4oCZdCB3b3JyeSwgSSB3b27igJl0DQphZGQg
dGhlIOKAnFJldmlld2VkLWJ54oCdIHRhZyB0byB0aGUgb3RoZXJzKS4=
