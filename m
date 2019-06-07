Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D261BC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF70208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="gFhxhuJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfFGFlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 01:41:46 -0400
Received: from mail-eopbgr690041.outbound.protection.outlook.com ([40.107.69.41]:64494
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbfFGFlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 01:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXAnmXirvmyEqIvSdkt25aZbde3fhOGHrPepgF7DfEo=;
 b=gFhxhuJW6DKcGP2BLlANnpNgJBGQ9KxSknNgvCE8PeN0xCn7tj1LI/e14ArEUhJkJ650Z1AAxaUpcldv8XzNIx3OGy3M21ZNAW306iFZP9e0iDgUPOc9IdCSQg1U2Kok9mJOcKsOUS8wWdJnObWVnIaO0U5DmGzaJ1nh0iGGaUk=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB5569.namprd05.prod.outlook.com (10.167.240.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 05:41:42 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886%6]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 05:41:42 +0000
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
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Thread-Topic: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Thread-Index: AQHVG6Hh/1D55TFaG0m2GIoqEoQysaaPsBmA
Date:   Fri, 7 Jun 2019 05:41:42 +0000
Message-ID: <7C13A4B6-6D5B-44C4-B238-58DC5926D7E1@vmware.com>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
In-Reply-To: <20190605131945.005681046@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 482eeeff-9204-4116-8a74-08d6eb0ad220
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR05MB5569;
x-ms-traffictypediagnostic: BL0PR05MB5569:
x-microsoft-antispam-prvs: <BL0PR05MB55693FC310590A0EC4390396D0100@BL0PR05MB5569.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(39860400002)(366004)(346002)(199004)(189003)(8936002)(33656002)(6512007)(256004)(14444005)(66476007)(76176011)(6246003)(64756008)(316002)(26005)(25786009)(476003)(71200400001)(71190400001)(83716004)(66946007)(82746002)(99286004)(102836004)(6506007)(186003)(53546011)(2616005)(6916009)(54906003)(6436002)(305945005)(14454004)(478600001)(73956011)(36756003)(7736002)(86362001)(76116006)(68736007)(66556008)(91956017)(7416002)(4326008)(2906002)(11346002)(66446008)(5660300002)(3846002)(446003)(81156014)(6116002)(81166006)(486006)(53936002)(8676002)(229853002)(66066001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB5569;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pQ3NbK66Xbo0CpQ8/yCBaC0ySlycb/DVRosgXnZ4aMq9o09V7h1RuPCTDeHfzie++/q/6klyElpWrR82TRtd3VOaF9SyAwg8i/2N52jYyCa9UFHmhFXsRjNXwrHorh/XZ0xEGNmAL8c0uZlJpKe6tMQQMKGoQhTcy6N4JtF5OC+VsM+YVTFhcM+ouQCVHHBAc8IQioXF6FZmZez2lpzrB4urfCIVgIVmYuSeNpuwsWDLxR+a3Tu927vgml4e3hMVu5G43jseWZvTGkAskNTyur1RZe2wuyI+aa6h/aZjnx5fANSyFvnyWdAzV7tnd2YfrFAJU0RFh7TZ1DH1bdIlK9sogTeHR4mKqv8dg9WU4IbH3gLzYuX7HxnD9Al5Ev0e1HLkBguudFgLfTiCHo7HuoFQot4BDAQxysmpCvxo+C0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E654BC4F470A4843A40E61E63634558C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482eeeff-9204-4116-8a74-08d6eb0ad220
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 05:41:42.6132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gNSwgMjAxOSwgYXQgNjowOCBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IEluIHByZXBhcmF0aW9uIGZvciBzdGF0aWNfY2FsbCBz
dXBwb3J0LCB0ZWFjaCB0ZXh0X3Bva2VfYnAoKSB0bw0KPiBlbXVsYXRlIGluc3RydWN0aW9ucywg
aW5jbHVkaW5nIENBTEwuDQo+IA0KPiBUaGUgY3VycmVudCB0ZXh0X3Bva2VfYnAoKSB0YWtlcyBh
IEBoYW5kbGVyIGFyZ3VtZW50IHdoaWNoIGlzIHVzZWQgYXMNCj4gYSBqdW1wIHRhcmdldCB3aGVu
IHRoZSB0ZW1wb3JhcnkgSU5UMyBpcyBoaXQgYnkgYSBkaWZmZXJlbnQgQ1BVLg0KPiANCj4gV2hl
biBwYXRjaGluZyBDQUxMIGluc3RydWN0aW9ucywgdGhpcyBkb2Vzbid0IHdvcmsgYmVjYXVzZSB3
ZSdkIG1pc3MNCj4gdGhlIFBVU0ggb2YgdGhlIHJldHVybiBhZGRyZXNzLiBJbnN0ZWFkLCB0ZWFj
aCBwb2tlX2ludDNfaGFuZGxlcigpIHRvDQo+IGVtdWxhdGUgYW4gaW5zdHJ1Y3Rpb24sIHR5cGlj
YWxseSB0aGUgaW5zdHJ1Y3Rpb24gd2UncmUgcGF0Y2hpbmcgaW4uDQo+IA0KPiBUaGlzIGZpdHMg
YWxtb3N0IGFsbCB0ZXh0X3Bva2VfYnAoKSB1c2VycywgZXhjZXB0DQo+IGFyY2hfdW5vcHRpbWl6
ZV9rcHJvYmUoKSB3aGljaCByZXN0b3JlcyByYW5kb20gdGV4dCwgYW5kIGZvciB0aGF0IHNpdGUN
Cj4gd2UgaGF2ZSB0byBidWlsZCBhbiBleHBsaWNpdCBlbXVsYXRlIGluc3RydWN0aW9uLg0KPiAN
Cj4gQ2M6IERhbmllbCBCcmlzdG90IGRlIE9saXZlaXJhIDxicmlzdG90QHJlZGhhdC5jb20+DQo+
IENjOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRl
ciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4gLS0tDQo+IGFyY2gv
eDg2L2luY2x1ZGUvYXNtL3RleHQtcGF0Y2hpbmcuaCB8ICAgIDIgLQ0KPiBhcmNoL3g4Ni9rZXJu
ZWwvYWx0ZXJuYXRpdmUuYyAgICAgICAgfCAgIDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tDQo+IGFyY2gveDg2L2tlcm5lbC9qdW1wX2xhYmVsLmMgICAgICAgICB8ICAgIDMg
LS0NCj4gYXJjaC94ODYva2VybmVsL2twcm9iZXMvb3B0LmMgICAgICAgIHwgICAxMSArKysrKy0t
LQ0KPiA0IGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0K
PiANCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdGV4dC1wYXRjaGluZy5oDQo+ICsrKyBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3RleHQtcGF0Y2hpbmcuaA0KPiBAQCAtMzcsNyArMzcsNyBA
QCBleHRlcm4gdm9pZCB0ZXh0X3Bva2VfZWFybHkodm9pZCAqYWRkciwNCj4gZXh0ZXJuIHZvaWQg
KnRleHRfcG9rZSh2b2lkICphZGRyLCBjb25zdCB2b2lkICpvcGNvZGUsIHNpemVfdCBsZW4pOw0K
PiBleHRlcm4gdm9pZCAqdGV4dF9wb2tlX2tnZGIodm9pZCAqYWRkciwgY29uc3Qgdm9pZCAqb3Bj
b2RlLCBzaXplX3QgbGVuKTsNCj4gZXh0ZXJuIGludCBwb2tlX2ludDNfaGFuZGxlcihzdHJ1Y3Qg
cHRfcmVncyAqcmVncyk7DQo+IC1leHRlcm4gdm9pZCB0ZXh0X3Bva2VfYnAodm9pZCAqYWRkciwg
Y29uc3Qgdm9pZCAqb3Bjb2RlLCBzaXplX3QgbGVuLCB2b2lkICpoYW5kbGVyKTsNCj4gK2V4dGVy
biB2b2lkIHRleHRfcG9rZV9icCh2b2lkICphZGRyLCBjb25zdCB2b2lkICpvcGNvZGUsIHNpemVf
dCBsZW4sIGNvbnN0IHZvaWQgKmVtdWxhdGUpOw0KPiBleHRlcm4gaW50IGFmdGVyX2Jvb3RtZW07
DQo+IGV4dGVybiBfX3JvX2FmdGVyX2luaXQgc3RydWN0IG1tX3N0cnVjdCAqcG9raW5nX21tOw0K
PiBleHRlcm4gX19yb19hZnRlcl9pbml0IHVuc2lnbmVkIGxvbmcgcG9raW5nX2FkZHI7DQo+IC0t
LSBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5l
bC9hbHRlcm5hdGl2ZS5jDQo+IEBAIC05MjEsMTkgKzkyMSwyNSBAQCBzdGF0aWMgdm9pZCBkb19z
eW5jX2NvcmUodm9pZCAqaW5mbykNCj4gfQ0KPiANCj4gc3RhdGljIGJvb2wgYnBfcGF0Y2hpbmdf
aW5fcHJvZ3Jlc3M7DQo+IC1zdGF0aWMgdm9pZCAqYnBfaW50M19oYW5kbGVyLCAqYnBfaW50M19h
ZGRyOw0KPiArc3RhdGljIGNvbnN0IHZvaWQgKmJwX2ludDNfb3Bjb2RlLCAqYnBfaW50M19hZGRy
Ow0KPiANCj4gaW50IHBva2VfaW50M19oYW5kbGVyKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPiB7
DQo+ICsJbG9uZyBpcCA9IHJlZ3MtPmlwIC0gSU5UM19JTlNOX1NJWkUgKyBDQUxMX0lOU05fU0la
RTsNCj4gKwlzdHJ1Y3Qgb3Bjb2RlIHsNCj4gKwkJdTggaW5zbjsNCj4gKwkJczMyIHJlbDsNCj4g
Kwl9IF9fcGFja2VkIG9wY29kZTsNCj4gKw0KPiAJLyoNCj4gCSAqIEhhdmluZyBvYnNlcnZlZCBv
dXIgSU5UMyBpbnN0cnVjdGlvbiwgd2Ugbm93IG11c3Qgb2JzZXJ2ZQ0KPiAJICogYnBfcGF0Y2hp
bmdfaW5fcHJvZ3Jlc3MuDQo+IAkgKg0KPiAtCSAqIAlpbl9wcm9ncmVzcyA9IFRSVUUJCUlOVDMN
Cj4gLQkgKiAJV01CCQkJCVJNQg0KPiAtCSAqIAl3cml0ZSBJTlQzCQkJaWYgKGluX3Byb2dyZXNz
KQ0KPiArCSAqCWluX3Byb2dyZXNzID0gVFJVRQkJSU5UMw0KPiArCSAqCVdNQgkJCQlSTUINCj4g
KwkgKgl3cml0ZSBJTlQzCQkJaWYgKGluX3Byb2dyZXNzKQ0KDQpJIGRvbuKAmXQgc2VlIHdoYXQg
aGFzIGNoYW5nZWQgaW4gdGhpcyBjaHVua+KApiBXaGl0ZXNwYWNlcz8NCg0KPiAJICoNCj4gLQkg
KiBJZGVtIGZvciBicF9pbnQzX2hhbmRsZXIuDQo+ICsJICogSWRlbSBmb3IgYnBfaW50M19vcGNv
ZGUuDQo+IAkgKi8NCj4gCXNtcF9ybWIoKTsNCj4gDQo+IEBAIC05NDMsOCArOTQ5LDIxIEBAIGlu
dCBwb2tlX2ludDNfaGFuZGxlcihzdHJ1Y3QgcHRfcmVncyAqcmUNCj4gCWlmICh1c2VyX21vZGUo
cmVncykgfHwgcmVncy0+aXAgIT0gKHVuc2lnbmVkIGxvbmcpYnBfaW50M19hZGRyKQ0KPiAJCXJl
dHVybiAwOw0KPiANCj4gLQkvKiBzZXQgdXAgdGhlIHNwZWNpZmllZCBicmVha3BvaW50IGhhbmRs
ZXIgKi8NCj4gLQlyZWdzLT5pcCA9ICh1bnNpZ25lZCBsb25nKSBicF9pbnQzX2hhbmRsZXI7DQo+
ICsJb3Bjb2RlID0gKihzdHJ1Y3Qgb3Bjb2RlICopYnBfaW50M19vcGNvZGU7DQo+ICsNCj4gKwlz
d2l0Y2ggKG9wY29kZS5pbnNuKSB7DQo+ICsJY2FzZSAweEU4OiAvKiBDQUxMICovDQo+ICsJCWlu
dDNfZW11bGF0ZV9jYWxsKHJlZ3MsIGlwICsgb3Bjb2RlLnJlbCk7DQo+ICsJCWJyZWFrOw0KPiAr
DQo+ICsJY2FzZSAweEU5OiAvKiBKTVAgKi8NCj4gKwkJaW50M19lbXVsYXRlX2ptcChyZWdzLCBp
cCArIG9wY29kZS5yZWwpOw0KPiArCQlicmVhazsNCg0KQ29uc2lkZXIgdXNpbmcgUkVMQVRJVkVD
QUxMX09QQ09ERSBhbmQgUkVMQVRJVkVKVU1QX09QQ09ERSBpbnN0ZWFkIG9mIHRoZQ0KY29uc3Rh
bnRzICgweEU4LCAweEU5KSwganVzdCBhcyB5b3UgZG8gbGF0ZXIgaW4gdGhlIHBhdGNoLg0KDQo=
