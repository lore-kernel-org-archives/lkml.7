Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BE3C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193EE206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Yr87OYLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfFFWYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:24:23 -0400
Received: from mail-eopbgr680070.outbound.protection.outlook.com ([40.107.68.70]:15342
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726599AbfFFWYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZVFPUeUa9e328to5DK/H3iwy0oMcHKEuHMJCgBaPiw=;
 b=Yr87OYLAcX3ojZgO/NIDqoOqug8eLCG5N11v/YzQ0ZAqeMCXVU+IjyLc8drNS+kAH4KVxxSWHhLKQgmFHPNfWpjA09kr1RTJuMxRSF1aUkPk+oF6/qeqfUb1zlr3IpScX/Yc+cS2yx5xcMUY15uDaqYDwn/t1tO6K2Pgc8vw94U=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4901.namprd05.prod.outlook.com (52.135.235.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.3; Thu, 6 Jun 2019 22:24:17 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 22:24:17 +0000
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
Thread-Index: AQHVG6HczY7CfFoeek66Q905fEQkc6aPNeMA
Date:   Thu, 6 Jun 2019 22:24:17 +0000
Message-ID: <37CFAEC1-6D36-4A6D-8C44-F85FCFA053AA@vmware.com>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.193241464@infradead.org>
In-Reply-To: <20190605131945.193241464@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0317d6cb-7ae7-48a9-9a38-08d6eacdb6c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4901;
x-ms-traffictypediagnostic: BYAPR05MB4901:
x-microsoft-antispam-prvs: <BYAPR05MB4901199F749E630159D96D02D0170@BYAPR05MB4901.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(366004)(346002)(199004)(189003)(51444003)(102836004)(86362001)(99286004)(14454004)(5660300002)(36756003)(64756008)(53546011)(6506007)(8676002)(66446008)(186003)(81156014)(76176011)(446003)(486006)(66476007)(66066001)(478600001)(26005)(82746002)(11346002)(33656002)(91956017)(73956011)(66946007)(2616005)(76116006)(71190400001)(7416002)(8936002)(6246003)(6436002)(68736007)(476003)(54906003)(3846002)(316002)(81166006)(66556008)(53936002)(2906002)(6512007)(256004)(14444005)(7736002)(25786009)(4326008)(305945005)(229853002)(6486002)(6916009)(83716004)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4901;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rDUGqols91Ji6RaYKuG0+UEsykaf2Zss1pqV/S8shNikS1iHLTSnjpreJBlwU/LA0PS/xicUaZ8ZYGqJs9e2u5fcY5Wb2fDasutPcrszhSbZf7iiM9jweqMi329RAnLJdKdCdlQLUrvSBsVyC+0GFIBaMqlvMDUi3SRbjvIS0IIAYRCiY4sEoLDl2s7bpqnUrYpwpQuY1QfVONOeulckA24kmR89Eq0b27EibPcMQbBLub6LLI0BefvgMeD/0yCjYjB+En9+v81Wuh7QWUsUVVRhyK0CTomTNyUhwdVj17HxnISjzqL8q2vPof/AcyWF0nGYGw6QPP1jbB7cxTqQ68MF2sE0eKDlOrmZbozJPAgtcqhlMZUzyktQJo8JBT5QMYvi4WahJRush8CojpJot98WUcrpD/fHf3SHIL704Aw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2871A09574065941B49A643C022B13CD@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0317d6cb-7ae7-48a9-9a38-08d6eacdb6c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 22:24:17.3151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gNSwgMjAxOSwgYXQgNjowOCBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IEZyb206IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBy
ZWRoYXQuY29tPg0KPiANCj4gQWRkIGluZnJhc3RydWN0dXJlIGZvciBhbiBhcmNoLXNwZWNpZmlj
IENPTkZJR19IQVZFX1NUQVRJQ19DQUxMX0lOTElORQ0KPiBvcHRpb24sIHdoaWNoIGlzIGEgZmFz
dGVyIHZlcnNpb24gb2YgQ09ORklHX0hBVkVfU1RBVElDX0NBTEwuICBBdA0KPiBydW50aW1lLCB0
aGUgc3RhdGljIGNhbGwgc2l0ZXMgYXJlIHBhdGNoZWQgZGlyZWN0bHksIHJhdGhlciB0aGFuIHVz
aW5nDQo+IHRoZSBvdXQtb2YtbGluZSB0cmFtcG9saW5lcy4NCj4gDQo+IENvbXBhcmVkIHRvIG91
dC1vZi1saW5lIHN0YXRpYyBjYWxscywgdGhlIHBlcmZvcm1hbmNlIGJlbmVmaXRzIGFyZSBtb3Jl
DQo+IG1vZGVzdCwgYnV0IHN0aWxsIG1lYXN1cmFibGUuICBTdGV2ZW4gUm9zdGVkdCBkaWQgc29t
ZSB0cmFjZXBvaW50DQo+IG1lYXN1cmVtZW50czoNCg0KWyBzbmlwIF0NCg0KPiArc3RhdGljIHZv
aWQgc3RhdGljX2NhbGxfZGVsX21vZHVsZShzdHJ1Y3QgbW9kdWxlICptb2QpDQo+ICt7DQo+ICsJ
c3RydWN0IHN0YXRpY19jYWxsX3NpdGUgKnN0YXJ0ID0gbW9kLT5zdGF0aWNfY2FsbF9zaXRlczsN
Cj4gKwlzdHJ1Y3Qgc3RhdGljX2NhbGxfc2l0ZSAqc3RvcCA9IG1vZC0+c3RhdGljX2NhbGxfc2l0
ZXMgKw0KPiArCQkJCQltb2QtPm51bV9zdGF0aWNfY2FsbF9zaXRlczsNCj4gKwlzdHJ1Y3Qgc3Rh
dGljX2NhbGxfc2l0ZSAqc2l0ZTsNCj4gKwlzdHJ1Y3Qgc3RhdGljX2NhbGxfa2V5ICprZXksICpw
cmV2X2tleSA9IE5VTEw7DQo+ICsJc3RydWN0IHN0YXRpY19jYWxsX21vZCAqc2l0ZV9tb2Q7DQo+
ICsNCj4gKwlmb3IgKHNpdGUgPSBzdGFydDsgc2l0ZSA8IHN0b3A7IHNpdGUrKykgew0KPiArCQlr
ZXkgPSBzdGF0aWNfY2FsbF9rZXkoc2l0ZSk7DQo+ICsJCWlmIChrZXkgPT0gcHJldl9rZXkpDQo+
ICsJCQljb250aW51ZTsNCj4gKwkJcHJldl9rZXkgPSBrZXk7DQo+ICsNCj4gKwkJbGlzdF9mb3Jf
ZWFjaF9lbnRyeShzaXRlX21vZCwgJmtleS0+c2l0ZV9tb2RzLCBsaXN0KSB7DQo+ICsJCQlpZiAo
c2l0ZV9tb2QtPm1vZCA9PSBtb2QpIHsNCj4gKwkJCQlsaXN0X2RlbCgmc2l0ZV9tb2QtPmxpc3Qp
Ow0KPiArCQkJCWtmcmVlKHNpdGVfbW9kKTsNCj4gKwkJCQlicmVhazsNCj4gKwkJCX0NCj4gKwkJ
fQ0KPiArCX0NCg0KSSB0aGluayB0aGF0IGZvciBzYWZldHksIHdoZW4gYSBtb2R1bGUgaXMgcmVt
b3ZlZCwgYWxsIHRoZSBzdGF0aWMtY2FsbHMNCnNob3VsZCBiZSB0cmF2ZXJzZWQgdG8gY2hlY2sg
dGhhdCBub25lIG9mIHRoZW0gY2FsbHMgYW55IGZ1bmN0aW9uIGluIHRoZQ0KcmVtb3ZlZCBtb2R1
bGUuIElmIHRoYXQgaGFwcGVucywgcGVyaGFwcyBpdCBzaG91bGQgYmUgcG9pc29uZWQuDQoNCj4g
K30NCj4gKw0KPiArc3RhdGljIGludCBzdGF0aWNfY2FsbF9tb2R1bGVfbm90aWZ5KHN0cnVjdCBu
b3RpZmllcl9ibG9jayAqbmIsDQo+ICsJCQkJICAgICB1bnNpZ25lZCBsb25nIHZhbCwgdm9pZCAq
ZGF0YSkNCj4gK3sNCj4gKwlzdHJ1Y3QgbW9kdWxlICptb2QgPSBkYXRhOw0KPiArCWludCByZXQg
PSAwOw0KPiArDQo+ICsJY3B1c19yZWFkX2xvY2soKTsNCj4gKwlzdGF0aWNfY2FsbF9sb2NrKCk7
DQo+ICsNCj4gKwlzd2l0Y2ggKHZhbCkgew0KPiArCWNhc2UgTU9EVUxFX1NUQVRFX0NPTUlORzoN
Cj4gKwkJbW9kdWxlX2Rpc2FibGVfcm8obW9kKTsNCj4gKwkJcmV0ID0gc3RhdGljX2NhbGxfYWRk
X21vZHVsZShtb2QpOw0KPiArCQltb2R1bGVfZW5hYmxlX3JvKG1vZCwgZmFsc2UpOw0KDQpEb2Vz
buKAmXQgaXQgY2F1c2Ugc29tZSBwYWdlcyB0byBiZSBXK1ggPyBDYW4gaXQgYmUgYXZvaWRlZD8N
Cg0KPiArCQlpZiAocmV0KSB7DQo+ICsJCQlXQVJOKDEsICJGYWlsZWQgdG8gYWxsb2NhdGUgbWVt
b3J5IGZvciBzdGF0aWMgY2FsbHMiKTsNCj4gKwkJCXN0YXRpY19jYWxsX2RlbF9tb2R1bGUobW9k
KTsNCg0KSWYgc3RhdGljX2NhbGxfYWRkX21vZHVsZSgpIHN1Y2NlZWRlZCBpbiBjaGFuZ2luZyBz
b21lIG9mIHRoZSBjYWxscywgYnV0IG5vdA0KYWxsLCBJIGRvbuKAmXQgdGhpbmsgdGhhdCBzdGF0
aWNfY2FsbF9kZWxfbW9kdWxlKCkgd2lsbCBjb3JyZWN0bHkgdW5kbw0Kc3RhdGljX2NhbGxfYWRk
X21vZHVsZSgpLiBUaGUgY29kZSB0cmFuc2Zvcm1hdGlvbnMsIEkgdGhpbmssIHdpbGwgcmVtYWlu
Lg0KDQo=
