Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9721C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E9A20825
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="oZU6ZtXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfFGQfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:35:50 -0400
Received: from mail-eopbgr700045.outbound.protection.outlook.com ([40.107.70.45]:55873
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729620AbfFGQft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ/hV7ieGeb4NTDjrH1pkYQIfC6D9MSDY5G7NhGxwSU=;
 b=oZU6ZtXGDUlTfnS61ASMoMTad6CRvKfOH6mEGLlfdh7u/xRs2i4KuhD2/yS9zMRMM2cY9gaQxFgpTaC7lFI7Y7r84s3T3mtgo8noK44qfuN90KOrlTNwQwd91xwX7CU+dh9r4blusZamL0EH3+Sy3uwuTemV9qtZKD++EtJNlVw=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB5028.namprd05.prod.outlook.com (20.177.241.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 16:35:42 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886%6]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 16:35:42 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     the arch/x86 maintainers <x86@kernel.org>,
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
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 11/15] static_call: Add inline static call infrastructure
Thread-Topic: [PATCH 11/15] static_call: Add inline static call infrastructure
Thread-Index: AQHVG6HczY7CfFoeek66Q905fEQkc6aPNeMAgACrdACAAIV8gA==
Date:   Fri, 7 Jun 2019 16:35:42 +0000
Message-ID: <AF3846D0-01F0-4A42-AEB6-09B0902A659C@vmware.com>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.193241464@infradead.org>
 <37CFAEC1-6D36-4A6D-8C44-F85FCFA053AA@vmware.com>
 <20190607083756.GW3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190607083756.GW3419@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c506c73e-8359-4ddb-4870-08d6eb662f0f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BL0PR05MB5028;
x-ms-traffictypediagnostic: BL0PR05MB5028:
x-microsoft-antispam-prvs: <BL0PR05MB5028761D912ED3552592463DD0100@BL0PR05MB5028.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(51444003)(66556008)(64756008)(66446008)(66476007)(11346002)(446003)(66946007)(25786009)(86362001)(229853002)(73956011)(486006)(33656002)(6436002)(102836004)(14454004)(6506007)(6512007)(82746002)(91956017)(53546011)(6916009)(76116006)(7416002)(476003)(2906002)(54906003)(316002)(26005)(36756003)(6486002)(4326008)(68736007)(83716004)(8936002)(2616005)(81166006)(81156014)(71200400001)(71190400001)(6116002)(3846002)(6246003)(478600001)(186003)(5660300002)(99286004)(305945005)(66066001)(53936002)(14444005)(256004)(76176011)(7736002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB5028;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vkaKhW35wgKz2VCrLlnmLw6Fbl2Fqup3pKmeH6e2qIIzpacEOrkxcf8z2D43i1s0mKv9SvS50MFH40GI9SbqlrepsbpvWIma2xcaaf5f05NwYwNcYUpMyqRNuXehA1ik1deVB4R9/nprvveYdFdhP0YHv3JTt0qRi0uEjmbeKonyUT7uYC12Aa8MLqPo55HOTVdK1Kp95NFVvsQTisLxJDMi06sFZJizr1PqyUHohd2rsxS/xPuXlIlkiSpIsytONc43wBlWHtx1Er1MSmbi4HPATDf2uv/3j/Liq8SSfMalQpETB1ob8AOgkZ8Sj75emts6Qihe3Ms+HL1aiBBNipY4lzzq70DFmY2ASs3KJWyXPhv9QWIrPtDLKLXhCIZ2hK1WV6xviYrcWdHvPdo/iuaRoIp0hyAabNn3CQTAy7o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81B95CB003F4894094434FC7E60C4588@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c506c73e-8359-4ddb-4870-08d6eb662f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 16:35:42.5977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gNywgMjAxOSwgYXQgMTozNyBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSnVuIDA2LCAyMDE5IGF0IDEwOjI0OjE3
UE0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+IA0KPj4+ICtzdGF0aWMgdm9pZCBzdGF0aWNf
Y2FsbF9kZWxfbW9kdWxlKHN0cnVjdCBtb2R1bGUgKm1vZCkNCj4+PiArew0KPj4+ICsJc3RydWN0
IHN0YXRpY19jYWxsX3NpdGUgKnN0YXJ0ID0gbW9kLT5zdGF0aWNfY2FsbF9zaXRlczsNCj4+PiAr
CXN0cnVjdCBzdGF0aWNfY2FsbF9zaXRlICpzdG9wID0gbW9kLT5zdGF0aWNfY2FsbF9zaXRlcyAr
DQo+Pj4gKwkJCQkJbW9kLT5udW1fc3RhdGljX2NhbGxfc2l0ZXM7DQo+Pj4gKwlzdHJ1Y3Qgc3Rh
dGljX2NhbGxfc2l0ZSAqc2l0ZTsNCj4+PiArCXN0cnVjdCBzdGF0aWNfY2FsbF9rZXkgKmtleSwg
KnByZXZfa2V5ID0gTlVMTDsNCj4+PiArCXN0cnVjdCBzdGF0aWNfY2FsbF9tb2QgKnNpdGVfbW9k
Ow0KPj4+ICsNCj4+PiArCWZvciAoc2l0ZSA9IHN0YXJ0OyBzaXRlIDwgc3RvcDsgc2l0ZSsrKSB7
DQo+Pj4gKwkJa2V5ID0gc3RhdGljX2NhbGxfa2V5KHNpdGUpOw0KPj4+ICsJCWlmIChrZXkgPT0g
cHJldl9rZXkpDQo+Pj4gKwkJCWNvbnRpbnVlOw0KPj4+ICsJCXByZXZfa2V5ID0ga2V5Ow0KPj4+
ICsNCj4+PiArCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHNpdGVfbW9kLCAma2V5LT5zaXRlX21vZHMs
IGxpc3QpIHsNCj4+PiArCQkJaWYgKHNpdGVfbW9kLT5tb2QgPT0gbW9kKSB7DQo+Pj4gKwkJCQls
aXN0X2RlbCgmc2l0ZV9tb2QtPmxpc3QpOw0KPj4+ICsJCQkJa2ZyZWUoc2l0ZV9tb2QpOw0KPj4+
ICsJCQkJYnJlYWs7DQo+Pj4gKwkJCX0NCj4+PiArCQl9DQo+Pj4gKwl9DQo+PiANCj4+IEkgdGhp
bmsgdGhhdCBmb3Igc2FmZXR5LCB3aGVuIGEgbW9kdWxlIGlzIHJlbW92ZWQsIGFsbCB0aGUgc3Rh
dGljLWNhbGxzDQo+PiBzaG91bGQgYmUgdHJhdmVyc2VkIHRvIGNoZWNrIHRoYXQgbm9uZSBvZiB0
aGVtIGNhbGxzIGFueSBmdW5jdGlvbiBpbiB0aGUNCj4+IHJlbW92ZWQgbW9kdWxlLiBJZiB0aGF0
IGhhcHBlbnMsIHBlcmhhcHMgaXQgc2hvdWxkIGJlIHBvaXNvbmVkLg0KPiANCj4gV2UgZG9uJ3Qg
ZG8gdGhhdCBmb3Igbm9ybWFsIGluZGlyZWN0IGNhbGxzIGVpdGhlci4uIEkgc3VwcG9zZSB3ZSBj
b3VsZA0KPiBoZXJlLCBidXQgbWVoLg0KPiANCj4+PiArfQ0KPj4+ICsNCj4+PiArc3RhdGljIGlu
dCBzdGF0aWNfY2FsbF9tb2R1bGVfbm90aWZ5KHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsDQo+
Pj4gKwkJCQkgICAgIHVuc2lnbmVkIGxvbmcgdmFsLCB2b2lkICpkYXRhKQ0KPj4+ICt7DQo+Pj4g
KwlzdHJ1Y3QgbW9kdWxlICptb2QgPSBkYXRhOw0KPj4+ICsJaW50IHJldCA9IDA7DQo+Pj4gKw0K
Pj4+ICsJY3B1c19yZWFkX2xvY2soKTsNCj4+PiArCXN0YXRpY19jYWxsX2xvY2soKTsNCj4+PiAr
DQo+Pj4gKwlzd2l0Y2ggKHZhbCkgew0KPj4+ICsJY2FzZSBNT0RVTEVfU1RBVEVfQ09NSU5HOg0K
Pj4+ICsJCW1vZHVsZV9kaXNhYmxlX3JvKG1vZCk7DQo+Pj4gKwkJcmV0ID0gc3RhdGljX2NhbGxf
YWRkX21vZHVsZShtb2QpOw0KPj4+ICsJCW1vZHVsZV9lbmFibGVfcm8obW9kLCBmYWxzZSk7DQo+
PiANCj4+IERvZXNu4oCZdCBpdCBjYXVzZSBzb21lIHBhZ2VzIHRvIGJlIFcrWCA/IENhbiBpdCBi
ZSBhdm9pZGVkPw0KPiANCj4gSSBkb24ndCBrbm93IHdoeSBpdCBkb2VzIHRoaXMsIGp1bXBfbGFi
ZWxzIGRvZXNuJ3Qgc2VlbSB0byBuZWVkIHRoaXMsDQo+IGFuZCBJJ20gbm90IHNlZWluZyB3aGF0
IHN0YXRpY19jYWxsIG5lZWRzIGRpZmZlcmVudGx5Lg0KPiANCj4+PiArCQlpZiAocmV0KSB7DQo+
Pj4gKwkJCVdBUk4oMSwgIkZhaWxlZCB0byBhbGxvY2F0ZSBtZW1vcnkgZm9yIHN0YXRpYyBjYWxs
cyIpOw0KPj4+ICsJCQlzdGF0aWNfY2FsbF9kZWxfbW9kdWxlKG1vZCk7DQo+PiANCj4+IElmIHN0
YXRpY19jYWxsX2FkZF9tb2R1bGUoKSBzdWNjZWVkZWQgaW4gY2hhbmdpbmcgc29tZSBvZiB0aGUg
Y2FsbHMsIGJ1dCBub3QNCj4+IGFsbCwgSSBkb27igJl0IHRoaW5rIHRoYXQgc3RhdGljX2NhbGxf
ZGVsX21vZHVsZSgpIHdpbGwgY29ycmVjdGx5IHVuZG8NCj4+IHN0YXRpY19jYWxsX2FkZF9tb2R1
bGUoKS4gVGhlIGNvZGUgdHJhbnNmb3JtYXRpb25zLCBJIHRoaW5rLCB3aWxsIHJlbWFpbi4NCj4g
DQo+IEh1cm0sIGp1bXBfbGFiZWxzIGhhcyB0aGUgc2FtZSBwcm9ibGVtLg0KPiANCj4gSSB3b25k
ZXIgd2h5IGtlcm5lbC9tb2R1bGUuYzpwcmVwYXJlX2NvbWluZ19tb2R1bGUoKSBkb2Vzbid0IHBy
b3BhZ2F0ZQ0KPiB0aGUgZXJyb3IgZnJvbSB0aGUgbm90aWZpZXIgY2FsbC4gSWYgaXQgd2VyZSB0
byBkbyB0aGF0LCBJIHRoaW5rIHdlJ2xsDQo+IGFib3J0IHRoZSBtb2R1bGUgbG9hZCBhbmQgYW55
IG1vZGlmaWNhdGlvbnMgZ2V0IGxvc3QgYW55d2F5Lg0KDQpUaGlzIG1pZ2h0IGJlIGEgc2VjdXJp
dHkgcHJvYmxlbSwgc2luY2UgaXQgY2FuIGxlYXZlIGluZGlyZWN0IGJyYW5jaGVzLA0Kd2hpY2gg
YXJlIHN1c2NlcHRpYmxlIHRvIFNwZWN0cmUgdjIsIGluIHRoZSBjb2RlLg0KDQo=
