Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D85C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC572133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="LHTNbbhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfFNHTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:19:13 -0400
Received: from mail-eopbgr750057.outbound.protection.outlook.com ([40.107.75.57]:25478
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfFNHTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQVIwQhFUQA5pGO+FPP6uNE0tc490PMkA2ca8P30ucc=;
 b=LHTNbbhVzhqyFLr4xe5qQDcngKnvOD1nKdUCjt1blzhU4UFolO18u+Y0zorB4UfQP4jbpPdlhkn+LintnXuWHYR/RK54OCXeLG4Y11jOPP9b7YzzkooocfavwMivw9tHUuS9r8+uast6bbpFNZhzOzJm8ZqGq8uehUIrmTmvrNI=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
 BN8PR10MB3716.namprd10.prod.outlook.com (20.179.97.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 14 Jun 2019 07:18:58 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::a460:e299:c4c:4ba8]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::a460:e299:c4c:4ba8%6]) with mapi id 15.20.1987.010; Fri, 14 Jun 2019
 07:18:57 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "richard@nod.at" <richard@nod.at>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Chris.Packham@alliedtelesis.co.nz" 
        <Chris.Packham@alliedtelesis.co.nz>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sr@denx.de" <sr@denx.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] mtd: cfi_cmdset_0002: dynamically determine the max
 sectors
Thread-Topic: [PATCH] mtd: cfi_cmdset_0002: dynamically determine the max
 sectors
Thread-Index: AQHVEDJMcvGkuqihiUCZNx77fHSEkKaa4nYA
Date:   Fri, 14 Jun 2019 07:18:57 +0000
Message-ID: <4913398a9317f240235e45f5d1ad886dd8c7e259.camel@infinera.com>
References: <20190522000628.13073-1-chris.packham@alliedtelesis.co.nz>
         <8e80d911f0dd4759b3edc72fb76530d6@svr-chch-ex1.atlnz.lc>
In-Reply-To: <8e80d911f0dd4759b3edc72fb76530d6@svr-chch-ex1.atlnz.lc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37aa4188-a705-49c5-64e6-08d6f0989114
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR10MB3716;
x-ms-traffictypediagnostic: BN8PR10MB3716:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN8PR10MB37161D32471AD757737BEA39F4EE0@BN8PR10MB3716.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(53754006)(5660300002)(256004)(14444005)(25786009)(186003)(102836004)(26005)(53546011)(6506007)(2501003)(6246003)(118296001)(53936002)(36756003)(7416002)(316002)(4326008)(71200400001)(71190400001)(68736007)(86362001)(110136005)(54906003)(2201001)(6512007)(6306002)(64756008)(6436002)(72206003)(229853002)(966005)(478600001)(14454004)(8676002)(8936002)(6486002)(91956017)(73956011)(66556008)(76116006)(66946007)(66446008)(2906002)(66476007)(486006)(11346002)(446003)(76176011)(476003)(2616005)(6116002)(45080400002)(305945005)(81156014)(66066001)(81166006)(7736002)(99286004)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR10MB3716;H:BN8PR10MB3540.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: brdxTNBu+xzwu/I1mY/Qe4NZ3JN9L+vgBbixeBwAfJru3OWRmW6GT3ByBxyUrNT8xmU9MD9jPD4PRR06nmuLyZuExInbPaEZkzJqhlMRoI1/YMC23ejhcipyHImObOVNXNSsSkoPMKwh+pS8w3iya4HU0FUoOBSMzDBT3RAO2akunKirjDeR6j47i0m279eBi49P+vt3DNMJ7p8Dlr4avloAwNfPoZnq1jqxxIBxZMw94pEeK95ClQbNOdmvA4WP7UMqH/mHc7oqhb3Ia2jgQ24sny9csVOsOAKi9qGxRwViQc3YZhgQeVvrJ3ayvWf2DPoJnp3yXjzIFnueokXhAV1vCyxMp9uSecqy6mjI9ZPr5kAdajiDkKN00v/45Hfb3EgU4RDYLuaV277ZsHFs2SkLITY2M2PjrUmXqCvzDZI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B11CE69052FDB4595E5025F7A013816@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aa4188-a705-49c5-64e6-08d6f0989114
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 07:18:57.8912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jocke@infinera.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA2LTE0IGF0IDAzOjIzICswMDAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0K
PiANCj4gDQo+IEhpIEFsbCwNCj4gDQo+IEkgdGhpbmsgdGhpcyBtYXkgaGF2ZSBnb3QgbG9zdCBp
biB0aGUgY2hhbmdlIG9mIG1haW50YWluZXIgZm9yIG10ZC4NCg0KV2UgbmVlZCB0aGlzIHRvbywg
QVRNIHdlIGhhdmUgYSBsb2NhbCBoYWNrIHRoYXQganVzdCBjaGFuZ2VzICBNQVhfU0VDVE9SUyB0
byAxMDI0DQoNCj4gDQo+IE9uIDIyLzA1LzE5IDEyOjA2IFBNLCBDaHJpcyBQYWNraGFtIHdyb3Rl
Og0KPiA+IEJlY2F1c2UgUFBCIHVubG9ja2luZyB1bmxvY2tzIHRoZSB3aG9sZSBjaGlwIGNmaV9w
cGJfdW5sb2NrKCkgbmVlZHMgdG8NCj4gPiByZW1lbWJlciB0aGUgbG9ja2VkIHN0YXR1cyBmb3Ig
ZWFjaCBzZWN0b3Igc28gaXQgY2FuIHJlLWxvY2sgdGhlDQo+ID4gdW5hZGRyZXNzZWQgc2VjdG9y
cy4gRHluYW1pY2FsbHkgY2FsY3VsYXRlIHRoZSBtYXhpbXVtIG51bWJlciBvZiBzZWN0b3JzDQo+
ID4gcmF0aGVyIHRoYW4gdXNpbmcgYSBoYXJkY29kZWQgdmFsdWUgdGhhdCBpcyB0b28gc21hbGwg
Zm9yIGxhcmdlciBjaGlwcy4NCj4gPiANCj4gPiBUZXN0ZWQgd2l0aCBTcGFuc2lvbiBTMjlHTDAx
R1MxMVRGSSBmbGFzaCBkZXZpY2UuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFj
a2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiA+IC0tLQ0KPiA+ICAg
ZHJpdmVycy9tdGQvY2hpcHMvY2ZpX2NtZHNldF8wMDAyLmMgfCAxMyArKysrKysrKy0tLS0tDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9jaGlwcy9jZmlfY21kc2V0XzAwMDIuYyBi
L2RyaXZlcnMvbXRkL2NoaXBzL2NmaV9jbWRzZXRfMDAwMi5jDQo+ID4gaW5kZXggYzhmYTU5MDZi
ZGY5Li5hMWE3ZDMzNGFhODIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tdGQvY2hpcHMvY2Zp
X2NtZHNldF8wMDAyLmMNCj4gPiArKysgYi9kcml2ZXJzL210ZC9jaGlwcy9jZmlfY21kc2V0XzAw
MDIuYw0KPiA+IEBAIC0yNTMzLDggKzI1MzMsNiBAQCBzdHJ1Y3QgcHBiX2xvY2sgew0KPiA+ICAg
ICAgIGludCBsb2NrZWQ7DQo+ID4gICB9Ow0KPiA+IA0KPiA+IC0jZGVmaW5lIE1BWF9TRUNUT1JT
ICAgICAgICAgICAgICAgICAgNTEyDQo+ID4gLQ0KPiA+ICAgI2RlZmluZSBET19YWExPQ0tfT05F
QkxPQ0tfTE9DSyAgICAgICAgICAgICAoKHZvaWQgKikxKQ0KPiA+ICAgI2RlZmluZSBET19YWExP
Q0tfT05FQkxPQ0tfVU5MT0NLICAgKCh2b2lkICopMikNCj4gPiAgICNkZWZpbmUgRE9fWFhMT0NL
X09ORUJMT0NLX0dFVExPQ0sgICgodm9pZCAqKTMpDQo+ID4gQEAgLTI2MzMsNiArMjYzMSw3IEBA
IHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgY2ZpX3BwYl91bmxvY2soc3RydWN0IG10ZF9pbmZv
ICptdGQsIGxvZmZfdCBvZnMsDQo+ID4gICAgICAgaW50IGk7DQo+ID4gICAgICAgaW50IHNlY3Rv
cnM7DQo+ID4gICAgICAgaW50IHJldDsNCj4gPiArICAgICBpbnQgbWF4X3NlY3RvcnM7DQo+ID4g
DQo+ID4gICAgICAgLyoNCj4gPiAgICAgICAgKiBQUEIgdW5sb2NraW5nIGFsd2F5cyB1bmxvY2tz
IGFsbCBzZWN0b3JzIG9mIHRoZSBmbGFzaCBjaGlwLg0KPiA+IEBAIC0yNjQwLDcgKzI2MzksMTEg
QEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBjZmlfcHBiX3VubG9jayhzdHJ1Y3QgbXRkX2lu
Zm8gKm10ZCwgbG9mZl90IG9mcywNCj4gPiAgICAgICAgKiBmaXJzdCBjaGVjayB0aGUgbG9ja2lu
ZyBzdGF0dXMgb2YgYWxsIHNlY3RvcnMgYW5kIHNhdmUNCj4gPiAgICAgICAgKiBpdCBmb3IgZnV0
dXJlIHVzZS4NCj4gPiAgICAgICAgKi8NCj4gPiAtICAgICBzZWN0ID0ga2NhbGxvYyhNQVhfU0VD
VE9SUywgc2l6ZW9mKHN0cnVjdCBwcGJfbG9jayksIEdGUF9LRVJORUwpOw0KPiA+ICsgICAgIG1h
eF9zZWN0b3JzID0gMDsNCj4gPiArICAgICBmb3IgKGkgPSAwOyBpIDwgbXRkLT5udW1lcmFzZXJl
Z2lvbnM7IGkrKykNCj4gPiArICAgICAgICAgICAgIG1heF9zZWN0b3JzICs9IHJlZ2lvbnNbaV0u
bnVtYmxvY2tzOw0KPiA+ICsNCj4gPiArICAgICBzZWN0ID0ga2NhbGxvYyhtYXhfc2VjdG9ycywg
c2l6ZW9mKHN0cnVjdCBwcGJfbG9jayksIEdGUF9LRVJORUwpOw0KPiA+ICAgICAgIGlmICghc2Vj
dCkNCj4gPiAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+IA0KPiA+IEBAIC0yNjg5
LDkgKzI2OTIsOSBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGNmaV9wcGJfdW5sb2NrKHN0
cnVjdCBtdGRfaW5mbyAqbXRkLCBsb2ZmX3Qgb2ZzLA0KPiA+ICAgICAgICAgICAgICAgfQ0KPiA+
IA0KPiA+ICAgICAgICAgICAgICAgc2VjdG9ycysrOw0KPiA+IC0gICAgICAgICAgICAgaWYgKHNl
Y3RvcnMgPj0gTUFYX1NFQ1RPUlMpIHsNCj4gPiArICAgICAgICAgICAgIGlmIChzZWN0b3JzID49
IG1heF9zZWN0b3JzKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHByaW50ayhLRVJOX0VS
UiAiT25seSAlZCBzZWN0b3JzIGZvciBQUEIgbG9ja2luZyBzdXBwb3J0ZWQhXG4iLA0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgTUFYX1NFQ1RPUlMpOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbWF4X3NlY3RvcnMpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICBrZnJlZShzZWN0KTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7
DQo+ID4gICAgICAgICAgICAgICB9DQo+ID4gDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGludXggTVREIGRpc2N1c3Npb24g
bWFpbGluZyBsaXN0DQo+IGh0dHBzOi8vbmFtMDMuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwJTNBJTJGJTJGbGlzdHMuaW5mcmFkZWFkLm9yZyUyRm1haWxtYW4lMkZs
aXN0aW5mbyUyRmxpbnV4LW10ZCUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDam9ha2ltLnRqZXJubHVu
ZCU0MGluZmluZXJhLmNvbSU3QzMyNzQyZmEzYTcxMzRlNzdmMjE5MDhkNmYwNzhlNjdiJTdDMjg1
NjQzZGU1ZjViNGIwM2ExNTMwYWUyZGM4YWFmNzclN0MxJTdDMCU3QzYzNjk2MDc5OTQwODM4NDE0
NCZhbXA7c2RhdGE9SmlkTU5HdVc3R2RRTyUyRkElMkJCczhRMG1ucXQlMkJXbERVbmpzYkNSSklE
a0R2VSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQo=
