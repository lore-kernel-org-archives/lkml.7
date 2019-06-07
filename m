Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2313C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D66D208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="NpumLAeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfFGGOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:14:02 -0400
Received: from mail-eopbgr770077.outbound.protection.outlook.com ([40.107.77.77]:12675
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfFGGOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWvgP5AESmhX/PNPKmPaWLcwbenW9LRcU8gReLDi4Zc=;
 b=NpumLAegde9AGPvI7VuREtxXTxzzUtWKER8mFWhhGqOiYMhqETFQ3J5vc08aOzoJaZ3Bb6DgMmhc071PzGn/3J8H/kciM0NrFwJX87m71qxPhZ6JXc60JjGyPMWoqrMEIATZCZcjDUV6ZdtnqSiMu+6cki+A3Ew14naRjXeKXvM=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB4932.namprd05.prod.outlook.com (52.132.15.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 06:13:58 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886%6]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 06:13:58 +0000
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
Subject: Re: [PATCH 12/15] x86/static_call: Add out-of-line static call
 implementation
Thread-Topic: [PATCH 12/15] x86/static_call: Add out-of-line static call
 implementation
Thread-Index: AQHVG6HYgGSM897CxUKW5lJ1ubCdw6aPuR2A
Date:   Fri, 7 Jun 2019 06:13:58 +0000
Message-ID: <37C2FB32-3437-48CB-954D-05F683B7D80B@vmware.com>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.254721704@infradead.org>
In-Reply-To: <20190605131945.254721704@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d52ecaa-8a78-4b9b-d45b-08d6eb0f541e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR05MB4932;
x-ms-traffictypediagnostic: BL0PR05MB4932:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR05MB49320B076FA640521A4F8FB8D0100@BL0PR05MB4932.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(189003)(199004)(66476007)(66066001)(76116006)(66946007)(73956011)(256004)(14444005)(66446008)(66556008)(64756008)(4326008)(25786009)(6506007)(53546011)(26005)(102836004)(6246003)(229853002)(81166006)(8676002)(81156014)(478600001)(8936002)(7736002)(14454004)(966005)(305945005)(45080400002)(82746002)(53936002)(6486002)(99286004)(6436002)(76176011)(6306002)(6512007)(33656002)(6916009)(316002)(68736007)(54906003)(36756003)(7416002)(5660300002)(486006)(6116002)(3846002)(446003)(71190400001)(71200400001)(83716004)(86362001)(2906002)(476003)(186003)(11346002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB4932;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UdwjdCoANiF+Z6h2FJ3mc6IzOKV3zMIa6hWmhpffpuBy/S2lnGZqgGEQNKA1PBvJxjSV205hVxxEv3iA/taRa+5Ofdz8JDPlrQxlY40MIvYCOPWxc3ruOOyqlf7ROyB/yhIUg4oznHnCdWs/Rkf2ktlz0+qJwzNrMY/L6B3gguj6ddKzcd+dZZIkZewAhzb+0/eEnPpm/agXDzarAdk5KKncJxOkPWN7AZMhpX7KbGnGBJOgRModxVAwBxLXMtERmdMkz0bbOgbBWD3VBhe//i8ttlx2X9KjVffiPyKkTCt1l6w7ZL7S6Nq8IUlTuz5aoB1SRPCDvq4DyVbKJWKB5FPKC9jar+xfstf3mACdp8eheYkASyl+Z1qUTVG3gRnFgBFKG2wsMzg32FMfQBgjRCDX/Mmk0jHMxrYV70Gb3T4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <693ABE744B8EAA4BBA5750920BE31F3C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d52ecaa-8a78-4b9b-d45b-08d6eb0f541e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 06:13:58.4559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gNSwgMjAxOSwgYXQgNjowOCBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IEZyb206IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBy
ZWRoYXQuY29tPg0KPiANCj4gQWRkIHRoZSB4ODYgb3V0LW9mLWxpbmUgc3RhdGljIGNhbGwgaW1w
bGVtZW50YXRpb24uICBGb3IgZWFjaCBrZXksIGENCj4gcGVybWFuZW50IHRyYW1wb2xpbmUgaXMg
Y3JlYXRlZCB3aGljaCBpcyB0aGUgZGVzdGluYXRpb24gZm9yIGFsbCBzdGF0aWMNCj4gY2FsbHMg
Zm9yIHRoZSBnaXZlbiBrZXkuICBUaGUgdHJhbXBvbGluZSBoYXMgYSBkaXJlY3QganVtcCB3aGlj
aCBnZXRzDQo+IHBhdGNoZWQgYnkgc3RhdGljX2NhbGxfdXBkYXRlKCkgd2hlbiB0aGUgZGVzdGlu
YXRpb24gZnVuY3Rpb24gY2hhbmdlcy4NCj4gDQo+IENjOiB4ODZAa2VybmVsLm9yZw0KPiBDYzog
U3RldmVuIFJvc3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+DQo+IENjOiBKdWxpYSBDYXJ0d3Jp
Z2h0IDxqdWxpYUBuaS5jb20+DQo+IENjOiBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz4N
Cj4gQ2M6IEFyZCBCaWVzaGV1dmVsIDxhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnPg0KPiBDYzog
SmFzb24gQmFyb24gPGpiYXJvbkBha2FtYWkuY29tPg0KPiBDYzogTGludXMgVG9ydmFsZHMgPHRv
cnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBDYzogSmlyaSBLb3NpbmEgPGprb3NpbmFA
c3VzZS5jej4NCj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBD
YzogTWFzYW1pIEhpcmFtYXRzdSA8bWhpcmFtYXRAa2VybmVsLm9yZz4NCj4gQ2M6IEJvcmlzbGF2
IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiBDYzogRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRA
QUNVTEFCLkNPTT4NCj4gQ2M6IEplc3NpY2EgWXUgPGpleXVAa2VybmVsLm9yZz4NCj4gQ2M6IEFu
ZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPg0KPiBDYzogIkguIFBldGVyIEFudmluIiA8
aHBhQHp5dG9yLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9l
QHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBl
dGVyekBpbmZyYWRlYWQub3JnPg0KPiBMaW5rOiBodHRwczovL25hbTA0LnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsa21sLmtlcm5lbC5vcmclMkZy
JTJGMDBiMDhmMjE5NGU4MDI0MWRlY2JmMjA2NjI0YjY1ODBiOWI4ODU1Yi4xNTQzMjAwODQxLmdp
dC5qcG9pbWJvZSU0MHJlZGhhdC5jb20mYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJl
LmNvbSU3QzEzYmMwMzM4MTkzMDQ2NGEwMThlMDhkNmU5YjhmOTBlJTdDYjM5MTM4Y2EzY2VlNGI0
YWE0ZDZjZDgzZDlkZDYyZjAlN0MwJTdDMCU3QzYzNjk1MzM3ODAwNzgxMDAzMCZhbXA7c2RhdGE9
VW5IRVVZRVlWM0ZCU1pqNjY3bFpZekdLUm92JTJCMVBkQWpBbk0lMkJxT3ozTnMlM0QmYW1wO3Jl
c2VydmVkPTANCj4gLS0tDQo+IGFyY2gveDg2L0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAg
ICAxIA0KPiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zdGF0aWNfY2FsbC5oIHwgICAyOCArKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gYXJjaC94ODYva2VybmVsL01ha2VmaWxlICAgICAgICAg
ICB8ICAgIDEgDQo+IGFyY2gveDg2L2tlcm5lbC9zdGF0aWNfY2FsbC5jICAgICAgfCAgIDM4ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gNCBmaWxlcyBjaGFuZ2VkLCA2
OCBpbnNlcnRpb25zKCspDQo+IGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9zdGF0aWNfY2FsbC5oDQo+IGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3g4Ni9rZXJuZWwvc3Rh
dGljX2NhbGwuYw0KPiANCj4gLS0tIGEvYXJjaC94ODYvS2NvbmZpZw0KPiArKysgYi9hcmNoL3g4
Ni9LY29uZmlnDQo+IEBAIC0xOTgsNiArMTk4LDcgQEAgY29uZmlnIFg4Ng0KPiAJc2VsZWN0IEhB
VkVfRlVOQ1RJT05fQVJHX0FDQ0VTU19BUEkNCj4gCXNlbGVjdCBIQVZFX1NUQUNLUFJPVEVDVE9S
CQlpZiBDQ19IQVNfU0FORV9TVEFDS1BST1RFQ1RPUg0KPiAJc2VsZWN0IEhBVkVfU1RBQ0tfVkFM
SURBVElPTgkJaWYgWDg2XzY0DQo+ICsJc2VsZWN0IEhBVkVfU1RBVElDX0NBTEwNCj4gCXNlbGVj
dCBIQVZFX1JTRVENCj4gCXNlbGVjdCBIQVZFX1NZU0NBTExfVFJBQ0VQT0lOVFMNCj4gCXNlbGVj
dCBIQVZFX1VOU1RBQkxFX1NDSEVEX0NMT0NLDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJj
aC94ODYvaW5jbHVkZS9hc20vc3RhdGljX2NhbGwuaA0KPiBAQCAtMCwwICsxLDI4IEBADQo+ICsv
KiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiArI2lmbmRlZiBfQVNNX1NU
QVRJQ19DQUxMX0gNCj4gKyNkZWZpbmUgX0FTTV9TVEFUSUNfQ0FMTF9IDQo+ICsNCj4gKy8qDQo+
ICsgKiBNYW51YWxseSBjb25zdHJ1Y3QgYSA1LWJ5dGUgZGlyZWN0IEpNUCB0byBwcmV2ZW50IHRo
ZSBhc3NlbWJsZXIgZnJvbQ0KPiArICogb3B0aW1pemluZyBpdCBpbnRvIGEgMi1ieXRlIEpNUC4N
Cj4gKyAqLw0KPiArI2RlZmluZSBfX0FSQ0hfU1RBVElDX0NBTExfSk1QX0xBQkVMKGtleSkgIi5M
IiBfX3N0cmluZ2lmeShrZXkgIyMgX2FmdGVyX2ptcCkNCj4gKyNkZWZpbmUgX19BUkNIX1NUQVRJ
Q19DQUxMX1RSQU1QX0pNUChrZXksIGZ1bmMpCQkJCVwNCj4gKwkiLmJ5dGUgMHhlOQkJCQkJCVxu
IglcDQo+ICsJIi5sb25nICIgI2Z1bmMgIiAtICIgX19BUkNIX1NUQVRJQ19DQUxMX0pNUF9MQUJF
TChrZXkpICJcbiIJXA0KPiArCV9fQVJDSF9TVEFUSUNfQ0FMTF9KTVBfTEFCRUwoa2V5KSAiOiIN
Cj4gKw0KPiArLyoNCj4gKyAqIFRoaXMgaXMgYSBwZXJtYW5lbnQgdHJhbXBvbGluZSB3aGljaCBk
b2VzIGEgZGlyZWN0IGp1bXAgdG8gdGhlIGZ1bmN0aW9uLg0KPiArICogVGhlIGRpcmVjdCBqdW1w
IGdldCBwYXRjaGVkIGJ5IHN0YXRpY19jYWxsX3VwZGF0ZSgpLg0KPiArICovDQo+ICsjZGVmaW5l
IEFSQ0hfREVGSU5FX1NUQVRJQ19DQUxMX1RSQU1QKGtleSwgZnVuYykJCQlcDQo+ICsJYXNtKCIu
cHVzaHNlY3Rpb24gLnRleHQsIFwiYXhcIgkJCQlcbiIJXA0KPiArCSAgICAiLmFsaWduIDQJCQkJ
CQlcbiIJXA0KPiArCSAgICAiLmdsb2JsICIgU1RBVElDX0NBTExfVFJBTVBfU1RSKGtleSkgIgkJ
XG4iCVwNCj4gKwkgICAgIi50eXBlICIgU1RBVElDX0NBTExfVFJBTVBfU1RSKGtleSkgIiwgQGZ1
bmN0aW9uCVxuIglcDQo+ICsJICAgIFNUQVRJQ19DQUxMX1RSQU1QX1NUUihrZXkpICI6CQkJXG4i
CVwNCj4gKwkgICAgX19BUkNIX1NUQVRJQ19DQUxMX1RSQU1QX0pNUChrZXksIGZ1bmMpICIgICAg
ICAgICAgIFxuIglcDQo+ICsJICAgICIucG9wc2VjdGlvbgkJCQkJXG4iKQ0KPiArDQo+ICsjZW5k
aWYgLyogX0FTTV9TVEFUSUNfQ0FMTF9IICovDQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9NYWtl
ZmlsZQ0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvTWFrZWZpbGUNCj4gQEAgLTYzLDYgKzYzLDcg
QEAgb2JqLXkJCQkrPSB0c2MubyB0c2NfbXNyLm8gaW9fZGVsYXkubyBydA0KPiBvYmoteQkJCSs9
IHBjaS1pb21tdV90YWJsZS5vDQo+IG9iai15CQkJKz0gcmVzb3VyY2Uubw0KPiBvYmoteQkJCSs9
IGlycWZsYWdzLm8NCj4gK29iai15CQkJKz0gc3RhdGljX2NhbGwubw0KPiANCj4gb2JqLXkJCQkJ
Kz0gcHJvY2Vzcy5vDQo+IG9iai15CQkJCSs9IGZwdS8NCj4gLS0tIC9kZXYvbnVsbA0KPiArKysg
Yi9hcmNoL3g4Ni9rZXJuZWwvc3RhdGljX2NhbGwuYw0KPiBAQCAtMCwwICsxLDM4IEBADQo+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArI2luY2x1ZGUgPGxpbnV4L3N0
YXRpY19jYWxsLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvbWVtb3J5Lmg+DQo+ICsjaW5jbHVkZSA8
bGludXgvYnVnLmg+DQo+ICsjaW5jbHVkZSA8YXNtL3RleHQtcGF0Y2hpbmcuaD4NCj4gKyNpbmNs
dWRlIDxhc20vbm9zcGVjLWJyYW5jaC5oPg0KPiArDQo+ICsjZGVmaW5lIENBTExfSU5TTl9TSVpF
IDUNCj4gKw0KPiArdm9pZCBhcmNoX3N0YXRpY19jYWxsX3RyYW5zZm9ybSh2b2lkICpzaXRlLCB2
b2lkICp0cmFtcCwgdm9pZCAqZnVuYykNCj4gK3sNCj4gKwl1bnNpZ25lZCBjaGFyIG9wY29kZXNb
Q0FMTF9JTlNOX1NJWkVdOw0KPiArCXVuc2lnbmVkIGNoYXIgaW5zbl9vcGNvZGU7DQo+ICsJdW5z
aWduZWQgbG9uZyBpbnNuOw0KPiArCXMzMiBkZXN0X3JlbGF0aXZlOw0KPiArDQo+ICsJbXV0ZXhf
bG9jaygmdGV4dF9tdXRleCk7DQo+ICsNCj4gKwlpbnNuID0gKHVuc2lnbmVkIGxvbmcpdHJhbXA7
DQo+ICsNCj4gKwlpbnNuX29wY29kZSA9ICoodW5zaWduZWQgY2hhciAqKWluc247DQo+ICsJaWYg
KGluc25fb3Bjb2RlICE9IDB4RTkpIHsNCj4gKwkJV0FSTl9PTkNFKDEsICJ1bmV4cGVjdGVkIHN0
YXRpYyBjYWxsIGluc24gb3Bjb2RlIDB4JXggYXQgJXBTIiwNCj4gKwkJCSAgaW5zbl9vcGNvZGUs
ICh2b2lkICopaW5zbik7DQo+ICsJCWdvdG8gdW5sb2NrOw0KDQpUaGlzIG1pZ2h0IGhhcHBlbiBp
ZiBhIGtwcm9iZSBpcyBpbnN0YWxsZWQgb24gdGhlIGNhbGwsIG5vPw0KDQpJIGRvbuKAmXQga25v
dyBpZiB5b3Ugd2FudCB0byBiZSBtb3JlIGdlbnRsZSBoYW5kbGluZyBvZiB0aGlzIGNhc2UgKG9y
IHBlcmhhcHMNCm1vZGlmeSBjYW5fcHJvYmUoKSB0byBwcmV2ZW50IHN1Y2ggYSBjYXNlKS4NCg0K
