Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0B6C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A278020820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="pBr6d7ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbfFJTUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:20:39 -0400
Received: from mail-eopbgr680081.outbound.protection.outlook.com ([40.107.68.81]:18085
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387674AbfFJTUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkOn8hWKWD3Uqqo3/SWA0LVrZOiGx7yxp+ppUVerLZ4=;
 b=pBr6d7tsQRu+/cUL33sRN86NByFb73yEyp/RIgolAFXwV8HbJiwffozXGnJnhBjZ67bM0LbSldvGgPjFig2QuRgcXpfpgurht2XZnA+H7u9dyZ7so7Y8BiPxOuEoDFTfgbLo/9tWVZwC9j56H3hLtHREqhH8NbGVh9Hmfwpb8zE=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6007.namprd05.prod.outlook.com (20.178.53.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.9; Mon, 10 Jun 2019 19:20:31 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::134:af66:bedb:ead9]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::134:af66:bedb:ead9%3]) with mapi id 15.20.1987.008; Mon, 10 Jun 2019
 19:20:31 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 13/15] x86/static_call: Add inline static call
 implementation for x86-64
Thread-Topic: [PATCH 13/15] x86/static_call: Add inline static call
 implementation for x86-64
Thread-Index: AQHVG6HbUZEsVsjdrUOVxRZQdAn/WKaVPtyAgAADVICAAAKdgIAABxEA
Date:   Mon, 10 Jun 2019 19:20:31 +0000
Message-ID: <F9768052-29D8-48EF-86E9-B4C3C5672A67@vmware.com>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.313688119@infradead.org>
 <20190610183357.zj6rwdpgw36anpfc@treble>
 <40096B8A-C063-4219-89FC-A8E42981BF28@vmware.com>
 <20190610185513.pbtc7udpkfd5jsuu@treble>
In-Reply-To: <20190610185513.pbtc7udpkfd5jsuu@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8f0271a-672e-41be-922e-08d6edd8b463
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6007;
x-ms-traffictypediagnostic: BYAPR05MB6007:
x-microsoft-antispam-prvs: <BYAPR05MB6007CAFE66C9B4C25A0D0984D0130@BYAPR05MB6007.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(54094003)(66556008)(64756008)(73956011)(4326008)(66446008)(66066001)(76116006)(316002)(81166006)(81156014)(54906003)(8676002)(66476007)(446003)(5660300002)(11346002)(486006)(66946007)(305945005)(7736002)(33656002)(6246003)(68736007)(82746002)(2616005)(476003)(36756003)(6916009)(83716004)(76176011)(86362001)(229853002)(53546011)(6506007)(25786009)(256004)(478600001)(102836004)(71190400001)(71200400001)(6436002)(6512007)(2906002)(14444005)(99286004)(53936002)(26005)(14454004)(6116002)(6486002)(7416002)(3846002)(8936002)(186003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6007;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LJS/hjHGGwFlz7hkolclIO0cMoTwD/DudhhQ7gNA2VvbbocJWgCtc02oANN57LM5CGIGbr6th401a+8v2n036XsOXGnyX21R9CuT11/EC0PQtHEEm4BpImaWBZQ7qNP7Q9pVWinO9g4jLXal26Ux5Y8LC03C6ewIxOdz64zOokh5Bo5JnZRFsqm8djYSvMJKxbzR6IqCn3AiJawS+LzydfvCSmv3d2AHoKWcG1nkBdH8OxdlCrcEhqZ+CaY9zl5juiA1zPdqsKVXnJ25jYidLxvWAOM90LV3wMF+1O86/no92O81zw3zuVohCPfYNGx9nbxfXMh6wh96qMypgIEspFwBDJEBcq6yz14U/KUp8ua6ZbCwd+jaFhonQB0enYbndt0d0zL2kMBtiSfCPUCdc0Q+n2yVqpMsmGB6dcHorzo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FA3C5C05D143845839BEF74E6D37DF1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f0271a-672e-41be-922e-08d6edd8b463
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 19:20:31.1828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gMTAsIDIwMTksIGF0IDExOjU1IEFNLCBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEp1biAxMCwgMjAxOSBhdCAwNjo0NTo1
MlBNICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+IE9uIEp1biAxMCwgMjAxOSwgYXQgMTE6
MzMgQU0sIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUByZWRoYXQuY29tPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiBXZWQsIEp1biAwNSwgMjAxOSBhdCAwMzowODowNlBNICswMjAwLCBQZXRlciBaaWps
c3RyYSB3cm90ZToNCj4+Pj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc3RhdGljX2NhbGwu
aA0KPj4+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zdGF0aWNfY2FsbC5oDQo+Pj4+IEBA
IC0yLDYgKzIsMjAgQEANCj4+Pj4gI2lmbmRlZiBfQVNNX1NUQVRJQ19DQUxMX0gNCj4+Pj4gI2Rl
ZmluZSBfQVNNX1NUQVRJQ19DQUxMX0gNCj4+Pj4gDQo+Pj4+ICsjaW5jbHVkZSA8YXNtL2FzbS1v
ZmZzZXRzLmg+DQo+Pj4+ICsNCj4+Pj4gKyNpZmRlZiBDT05GSUdfSEFWRV9TVEFUSUNfQ0FMTF9J
TkxJTkUNCj4+Pj4gKw0KPj4+PiArLyoNCj4+Pj4gKyAqIFRoaXMgdHJhbXBvbGluZSBpcyBvbmx5
IHVzZWQgZHVyaW5nIGJvb3QgLyBtb2R1bGUgaW5pdCwgc28gaXQncyBzYWZlIHRvIHVzZQ0KPj4+
PiArICogdGhlIGluZGlyZWN0IGJyYW5jaCB3aXRob3V0IGEgcmV0cG9saW5lLg0KPj4+PiArICov
DQo+Pj4+ICsjZGVmaW5lIF9fQVJDSF9TVEFUSUNfQ0FMTF9UUkFNUF9KTVAoa2V5LCBmdW5jKQkJ
CQlcDQo+Pj4+ICsJQU5OT1RBVEVfUkVUUE9MSU5FX1NBRkUJCQkJCQlcDQo+Pj4+ICsJImptcHEg
KiIgX19zdHJpbmdpZnkoa2V5KSAiKyIgX19zdHJpbmdpZnkoU0NfS0VZX2Z1bmMpICIoJXJpcCkg
XG4iDQo+Pj4+ICsNCj4+Pj4gKyNlbHNlIC8qICFDT05GSUdfSEFWRV9TVEFUSUNfQ0FMTF9JTkxJ
TkUgKi8NCj4+PiANCj4+PiBJIHdvbmRlciBpZiB3ZSBjYW4gc2ltcGxpZnkgdGhpcyAoYW5kIGRy
b3AgdGhlIGluZGlyZWN0IGJyYW5jaCkgYnkNCj4+PiBnZXR0aW5nIHJpZCBvZiB0aGUgYWJvdmUg
Y3J1ZnQsIGFuZCBpbnN0ZWFkIGp1c3QgdXNlIHRoZSBvdXQtb2YtbGluZQ0KPj4+IHRyYW1wb2xp
bmUgYXMgdGhlIGRlZmF1bHQgZm9yIGlubGluZSBhcyB3ZWxsLg0KPj4+IA0KPj4+IFRoZW4gdGhl
IGlubGluZSBjYXNlIGNvdWxkIGZhbGwgYmFjayB0byB0aGUgb3V0LW9mLWxpbmUgaW1wbGVtZW50
YXRpb24NCj4+PiAoYnkgcGF0Y2hpbmcgdGhlIHRyYW1wb2xpbmUncyBqbXAgZGVzdCkgYmVmb3Jl
IHN0YXRpY19jYWxsX2luaXRpYWxpemVkDQo+Pj4gaXMgc2V0Lg0KPj4gDQo+PiBJIG11c3QgYmUg
bWlzc2luZyBzb21lIGNvbnRleHQgLSBidXQgd2hhdCBndWFyYW50ZWVzIHRoYXQgdGhpcyBpbmRp
cmVjdA0KPj4gYnJhbmNoIHdvdWxkIGJlIGV4YWN0bHkgNSBieXRlcyBsb25nPyBJc27igJl0IHRo
ZXJlIGFuIGFzc3VtcHRpb24gdGhhdCB0aGlzDQo+PiB3b3VsZCBiZSB0aGUgY2FzZT8gU2hvdWxk
buKAmXQgdGhlcmUgYmUgc29tZSBoYW5kbGluZyBvZiB0aGUgcGFkZGluZz8NCj4gDQo+IFdlIGRv
bid0IHBhdGNoIHRoZSBpbmRpcmVjdCBicmFuY2guICBJdCdzIGp1c3QgcGFydCBvZiBhIHRlbXBv
cmFyeQ0KPiB0cmFtcG9saW5lIHdoaWNoIGlzIGNhbGxlZCBieSB0aGUgY2FsbCBzaXRlLCBhbmQg
d2hpY2ggZG9lcyAiam1wDQo+IGtleS0+ZnVuYyIgZHVyaW5nIGJvb3QgdW50aWwgc3RhdGljIGNh
bGwgaW5pdGlhbGl6YXRpb24gaXMgZG9uZS4NCj4gDQo+IChUaG91Z2ggSSdtIHN1Z2dlc3Rpbmcg
cmVtb3ZpbmcgdGhhdC4pDQoNCk9oLi4uIEkgc2VlLg0KDQpPbiBhbm90aGVyIG5vdGUgLSBldmVu
IGlmIHRoaXMgYnJhbmNoIGlzIG9ubHkgZXhlY3V0ZWQgZHVyaW5nIG1vZHVsZQ0KaW5pdGlhbGl6
YXRpb24sIGl0IGRvZXMgc2VlbSBzYWZlciB0byB1c2UgYSByZXRwb2xpbmUgaW5zdGVhZCBvZiBh
biBpbmRpcmVjdA0KYnJhbmNoIChjb25zaWRlciBhIGJyYW5jaCB0aGF0IGlzIHJ1biBtYW55IHRp
bWVzIG9uIG9uZSBoYXJkd2FyZSB0aHJlYWQgb24NClNNVCwgd2hlbiBTVElCUCBpcyBub3Qgc2V0
LCBhbmQgYXR0YWNrZXIgY29kZSBpcyBydW4gb24gdGhlIHNlY29uZCB0aHJlYWQpLg0KDQpJIGd1
ZXNzIHlvdSBkb27igJl0IHNpbXBseSBjYWxsIHRoZSByZXRwb2xpbmUgY29kZSBzbyBzaW5jZSB5
b3UgZG9u4oCZdCBoYXZlIGENCmNsb2JiZXJlZCByZWdpc3RlciB0byBob2xkIHRoZSB0YXJnZXQu
IEJ1dCBpdCBzdGlsbCBzZWVtcyBwb3NzaWJsZSB0byB1c2UNCmEgcmV0cG9saW5lLiBBbnlob3cs
IGl0IG1pZ2h0IGJlIGEgbW9vdCBkaXNjdXNzaW9uIGlmIHRoaXMgY29kZSBpcyByZW1vdmVkLg0K
DQo=
