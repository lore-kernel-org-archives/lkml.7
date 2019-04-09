Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98582C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE8F213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R6E1gpon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfDIDd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:33:56 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:19355
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbfDIDdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D3CrzBAnbr8OKOdEI+2MbKD0OwjMdpRSQu3i4kZPBQ=;
 b=R6E1gpon07VrqcGsQfnj1cqR5TMzgn90QQPrvZyo5qsnA0E865M9rmd8wpkCPDHWl84v2/x0wqJzgz22DEwR6Re0cltVSdm7C95iqVVoAQehwHBAztr0l9cx5TWvbnIseryufmWO5PFWCFA/gMytr800E5CqNor6pnyDPH98fmM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Tue, 9 Apr 2019 03:33:50 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 03:33:50 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 4/4] rtc: imx-sc: add rtc alarm support
Thread-Topic: [PATCH V6 4/4] rtc: imx-sc: add rtc alarm support
Thread-Index: AQHU7n4EdgguyHsDvUib9vTZjNBAXKYzKrAAgAACNUA=
Date:   Tue, 9 Apr 2019 03:33:50 +0000
Message-ID: <DB3PR0402MB3916E7D387D5FA74CFB719C6F52D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554777487-31075-1-git-send-email-Anson.Huang@nxp.com>
 <1554777487-31075-4-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4211CEA77AB034B5DCF71FE2802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211CEA77AB034B5DCF71FE2802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e614487c-2ae9-4cf4-3c3f-08d6bc9c2e9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3738;
x-ms-traffictypediagnostic: DB3PR0402MB3738:
x-microsoft-antispam-prvs: <DB3PR0402MB37384A2035B4A9C4E1EB9670F52D0@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(376002)(136003)(189003)(13464003)(199004)(2906002)(6436002)(76176011)(81156014)(102836004)(25786009)(316002)(8676002)(2201001)(3846002)(14444005)(7736002)(71200400001)(6246003)(6116002)(74316002)(26005)(256004)(8936002)(4326008)(68736007)(229853002)(110136005)(86362001)(53546011)(305945005)(33656002)(6506007)(81166006)(71190400001)(5660300002)(2501003)(99286004)(478600001)(55016002)(97736004)(105586002)(44832011)(9686003)(186003)(106356001)(7416002)(7696005)(66066001)(52536014)(446003)(11346002)(476003)(486006)(53936002)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4GCrlj86ruzelXUtI5Zr7HJQj/r82OPc3tk+iNy92OuOyvPoBQ9vIEOhyRN7OoENhPsyYk7ezpGIyoM81qKfr0mh7X2+McKXLIGtpvaNGB1xFHEzypNK75h5lkTS5t/U2hTZKvPDDxodLOAPxY3hJJbeQVC908ArHT2F203/1cUJbWeBSjkkYTaDH+JGjwO9zYbvHyZmAJZpIGaeyB8FpsioRiLaA+r7hJ67Fd5ysthY5YA1FvhSwqRpbFcCrBDRtt3sJn1GM2pQrUYpQ/4omIpsvEwv8mBQB/vNcWu/nBGk05FK/yFuwr28smpQZ/cDzVprAE2ediFcztT2pLucy6RQPTs56FQVqbQdg20Rbe8a+U0uZzuVWHRh+ZM25d2hyMfDExp+fvziShAFpTgYOG3AFLLdJbKdUrBDbEB0i1w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e614487c-2ae9-4cf4-3c3f-08d6bc9c2e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 03:33:50.0924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogQWlzaGVuZyBEb25nDQo+IFNlbnQ6IDIwMTnlubQ05pyIOeaXpSAxMToy
NQ0KPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyByb2JoK2R0QGtlcm5l
bC5vcmc7DQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhh
dWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdt
YWlsLmNvbTsgYS56dW1tb0B0b3dlcnRlY2guaXQ7DQo+IGFsZXhhbmRyZS5iZWxsb25pQGJvb3Rs
aW4uY29tOyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBzYm95ZEBrZXJuZWwub3JnOw0KPiBQZW5n
IEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhw
LmNvbT47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC1ydGNAdmdlci5rZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFY2IDQvNF0gcnRjOiBpbXgtc2M6IGFkZCBydGMg
YWxhcm0gc3VwcG9ydA0KPiANCj4gPiBGcm9tOiBBbnNvbiBIdWFuZw0KPiA+IFNlbnQ6IFR1ZXNk
YXksIEFwcmlsIDksIDIwMTkgMTA6NDQgQU0NCj4gPiBTdWJqZWN0OiBbUEFUQ0ggVjYgNC80XSBy
dGM6IGlteC1zYzogYWRkIHJ0YyBhbGFybSBzdXBwb3J0DQo+ID4NCj4gPiBBZGQgaS5NWCBzeXN0
ZW0gY29udHJvbGxlciBSVEMgYWxhcm0gc3VwcG9ydCwgdGhlIFJUQyBhbGFybSBpcw0KPiA+IGlt
cGxlbWVudGVkIHZpYSBTSVAoc2lsaWNvbiBwcm92aWRlcikgcnVudGltZSBzZXJ2aWNlIGNhbGwg
YW5kDQo+ID4gQVJNLVRydXN0ZWQtRmlybXdhcmUgd2lsbCBjb21tdW5pY2F0ZSB3aXRoIHN5c3Rl
bSBjb250cm9sbGVyIHZpYQ0KPiA+IE1VKG1lc3NhZ2UgdW5pdCkgSVBDIHRvIHNldCBSVEMgYWxh
cm0uIFdoZW4gUlRDIGFsYXJtIGZpcmVzLCBzeXN0ZW0NCj4gPiBjb250cm9sbGVyIHdpbGwgZ2Vu
ZXJhdGUgYSBjb21tb24gTVUgaXJxIGV2ZW50IGFuZCBub3RpZnkgc3lzdGVtDQo+IGNvbnRyb2xs
ZXIgUlRDIGRyaXZlciB0byBoYW5kbGUgdGhlIGlycSBldmVudC4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IENo
YW5nZXMgc2luY2UgVjU6DQo+ID4gCS0gbW92ZSB0aGUgaXJxIGFsYXJtIGVuYWJsZSBSUEMgdG8g
aW14LXNjdS1pcnEgZHJpdmVyLCBhbmQgcnRjIGRyaXZlcg0KPiA+IGp1c3QgY2FsbCB0aGUNCj4g
PiAJICBBUEkgdG8gZW5hYmxlL2Rpc2FibGUgYWxhcm0uDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
cnRjL3J0Yy1pbXgtc2MuYyB8IDg0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRjLWlteC1zYy5jIGIvZHJpdmVy
cy9ydGMvcnRjLWlteC1zYy5jIGluZGV4DQo+ID4gMTk2NDJiZi4uM2ViNGRiMCAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL3J0Yy9ydGMtaW14LXNjLmMNCj4gPiArKysgYi9kcml2ZXJzL3J0Yy9y
dGMtaW14LXNjLmMNCj4gPiBAQCAtMyw2ICszLDcgQEANCj4gPiAgICogQ29weXJpZ2h0IDIwMTgg
TlhQLg0KPiA+ICAgKi8NCj4gPg0KPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZmlybXdhcmUv
aW14L3JzcmMuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2FybS1zbWNjYy5oPg0KPiA+ICAjaW5j
bHVkZSA8bGludXgvZmlybXdhcmUvaW14L3NjaS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbW9k
dWxlLmg+DQo+ID4gQEAgLTExLDExICsxMiwxNSBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvcnRj
Lmg+DQo+ID4NCj4gPiAgI2RlZmluZSBJTVhfU0NfVElNRVJfRlVOQ19HRVRfUlRDX1NFQzE5NzAJ
OQ0KPiA+ICsjZGVmaW5lIElNWF9TQ19USU1FUl9GVU5DX1NFVF9SVENfQUxBUk0JCTgNCj4gPiAg
I2RlZmluZSBJTVhfU0NfVElNRVJfRlVOQ19TRVRfUlRDX1RJTUUJCTYNCj4gPg0KPiA+ICAjZGVm
aW5lIElNWF9TSVBfU1JUQwkJCTB4QzIwMDAwMDINCj4gPiAgI2RlZmluZSBJTVhfU0lQX1NSVENf
U0VUX1RJTUUJCTB4MA0KPiA+DQo+ID4gKyNkZWZpbmUgU0NfSVJRX0dST1VQX1JUQyAgICAyDQo+
ID4gKyNkZWZpbmUgU0NfSVJRX1JUQyAgICAgICAgICAxDQo+ID4gKw0KPiA+ICBzdGF0aWMgc3Ry
dWN0IGlteF9zY19pcGMgKnJ0Y19pcGNfaGFuZGxlOyAgc3RhdGljIHN0cnVjdCBydGNfZGV2aWNl
DQo+ID4gKmlteF9zY19ydGM7DQo+ID4NCj4gPiBAQCAtMjQsNiArMjksMTYgQEAgc3RydWN0IGlt
eF9zY19tc2dfdGltZXJfZ2V0X3J0Y190aW1lIHsNCj4gPiAgCXUzMiB0aW1lOw0KPiA+ICB9IF9f
cGFja2VkOw0KPiA+DQo+ID4gK3N0cnVjdCBpbXhfc2NfbXNnX3RpbWVyX3J0Y19zZXRfYWxhcm0g
ew0KPiA+ICsJc3RydWN0IGlteF9zY19ycGNfbXNnIGhkcjsNCj4gPiArCXUxNiB5ZWFyOw0KPiA+
ICsJdTggbW9uOw0KPiA+ICsJdTggZGF5Ow0KPiA+ICsJdTggaG91cjsNCj4gPiArCXU4IG1pbjsN
Cj4gPiArCXU4IHNlYzsNCj4gPiArfSBfX3BhY2tlZDsNCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQg
aW14X3NjX3J0Y19yZWFkX3RpbWUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcnRjX3RpbWUg
KnRtKSAgew0KPiA+ICAJc3RydWN0IGlteF9zY19tc2dfdGltZXJfZ2V0X3J0Y190aW1lIG1zZzsg
QEAgLTYwLDkgKzc1LDc0IEBADQo+IHN0YXRpYw0KPiA+IGludCBpbXhfc2NfcnRjX3NldF90aW1l
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHJ0Y190aW1lICp0bSkNCj4gPiAgCXJldHVybiBy
ZXMuYTA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IGlteF9zY19ydGNfYWxhcm1faXJx
X2VuYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkDQo+ID4gK2ludA0KPiA+ICtlbmFi
bGUpIHsNCj4gPiArCWlteF9zY3VfaXJxX2VuYWJsZShTQ19JUlFfR1JPVVBfUlRDLCBTQ19JUlFf
UlRDLCBlbmFibGUpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+
ICtzdGF0aWMgaW50IGlteF9zY19ydGNfcmVhZF9hbGFybShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdA0KPiA+ICtydGNfd2thbHJtDQo+ID4gKyphbHJtKSB7DQo+IA0KPiBJIHN0aWxsIHRoaW5r
IGhlcmUgbmVlZHMgYSBkb2MgZXhwbGFpbiB3aHkgbmVlZHMgdGhpcyBhbmQgd2h5IGl0J3Mgc2Fm
ZSB0byBkbw0KPiB0aGF0Lg0KDQpJIHdpbGwgYWRkIGEgY29tbWVudCBoZXJlLCBmb3IgdGhlIGRv
YywgaXQgc2hvdWxkIGJlIGFub3RoZXIgdG9waWMgb2YgUlRDIGZyYW1ld29yaywNCndlIGNhbiBk
byBpdCBsYXRlci4NCg0KQW5zb24uDQoNCj4gT3RoZXJ3aXNlOg0KPiBSZXZpZXdlZC1ieTogRG9u
ZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gDQo+ID4gKwlyZXR1cm4gMDsNCj4g
PiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBpbXhfc2NfcnRjX3NldF9hbGFybShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdCBydGNfd2thbHJtDQo+ID4gKyphbHJtKSB7DQo+ID4gKwlzdHJ1
Y3QgaW14X3NjX21zZ190aW1lcl9ydGNfc2V0X2FsYXJtIG1zZzsNCj4gPiArCXN0cnVjdCBpbXhf
c2NfcnBjX21zZyAqaGRyID0gJm1zZy5oZHI7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsJc3RydWN0
IHJ0Y190aW1lICphbHJtX3RtID0gJmFscm0tPnRpbWU7DQo+ID4gKw0KPiA+ICsJaGRyLT52ZXIg
PSBJTVhfU0NfUlBDX1ZFUlNJT047DQo+ID4gKwloZHItPnN2YyA9IElNWF9TQ19SUENfU1ZDX1RJ
TUVSOw0KPiA+ICsJaGRyLT5mdW5jID0gSU1YX1NDX1RJTUVSX0ZVTkNfU0VUX1JUQ19BTEFSTTsN
Cj4gPiArCWhkci0+c2l6ZSA9IDM7DQo+ID4gKw0KPiA+ICsJbXNnLnllYXIgPSBhbHJtX3RtLT50
bV95ZWFyICsgMTkwMDsNCj4gPiArCW1zZy5tb24gPSBhbHJtX3RtLT50bV9tb24gKyAxOw0KPiA+
ICsJbXNnLmRheSA9IGFscm1fdG0tPnRtX21kYXk7DQo+ID4gKwltc2cuaG91ciA9IGFscm1fdG0t
PnRtX2hvdXI7DQo+ID4gKwltc2cubWluID0gYWxybV90bS0+dG1fbWluOw0KPiA+ICsJbXNnLnNl
YyA9IGFscm1fdG0tPnRtX3NlYzsNCj4gPiArDQo+ID4gKwlyZXQgPSBpbXhfc2N1X2NhbGxfcnBj
KHJ0Y19pcGNfaGFuZGxlLCAmbXNnLCB0cnVlKTsNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlk
ZXZfZXJyKGRldiwgInNldCBydGMgYWxhcm0gZmFpbGVkLCByZXQgJWRcbiIsIHJldCk7DQo+ID4g
KwkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXQgPSBpbXhfc2NfcnRjX2Fs
YXJtX2lycV9lbmFibGUoZGV2LCBhbHJtLT5lbmFibGVkKTsNCj4gPiArCWlmIChyZXQpIHsNCj4g
PiArCQlkZXZfZXJyKGRldiwgImVuYWJsZSBydGMgYWxhcm0gZmFpbGVkLCByZXQgJWRcbiIsIHJl
dCk7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBydGNfY2xhc3Nfb3BzIGlt
eF9zY19ydGNfb3BzID0gew0KPiA+ICAJLnJlYWRfdGltZSA9IGlteF9zY19ydGNfcmVhZF90aW1l
LA0KPiA+ICAJLnNldF90aW1lID0gaW14X3NjX3J0Y19zZXRfdGltZSwNCj4gPiArCS5yZWFkX2Fs
YXJtID0gaW14X3NjX3J0Y19yZWFkX2FsYXJtLA0KPiA+ICsJLnNldF9hbGFybSA9IGlteF9zY19y
dGNfc2V0X2FsYXJtLA0KPiA+ICsJLmFsYXJtX2lycV9lbmFibGUgPSBpbXhfc2NfcnRjX2FsYXJt
X2lycV9lbmFibGUsIH07DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGlteF9zY19ydGNfYWxhcm1f
c2Nfbm90aWZ5KHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsDQo+ID4gKwkJCQkJdW5zaWduZWQg
bG9uZyBldmVudCwgdm9pZCAqZ3JvdXApDQo+IA0KPiBOb3QgbmVjZXNzYXJ5IHRvIGhhdmUgc3Vj
aCBhIGxvbmcgZnVuY3Rpb24gbmFtZS4NCj4gSW14X3NjX3J0Y19hbGFybV9ub3RpZnkoKSBzaG91
bGQgYmUgb2sNCj4gDQo+IFJlZ2FyZHMNCj4gRG9uZyBBaXNoZW5nDQo+IA0KPiA+ICt7DQo+ID4g
KwkvKiBpZ25vcmUgbm9uLXJ0YyBpcnEgKi8NCj4gPiArCWlmICghKChldmVudCAmIFNDX0lSUV9S
VEMpICYmICgqKHU4ICopZ3JvdXAgPT0NCj4gU0NfSVJRX0dST1VQX1JUQykpKQ0KPiA+ICsJCXJl
dHVybiAwOw0KPiA+ICsNCj4gPiArCXJ0Y191cGRhdGVfaXJxKGlteF9zY19ydGMsIDEsIFJUQ19J
UlFGIHwgUlRDX0FGKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArc3RhdGljIHN0cnVjdCBub3RpZmllcl9ibG9jayBpbXhfc2NfcnRjX2FsYXJtX3NjX25vdGlm
aWVyID0gew0KPiA+ICsJLm5vdGlmaWVyX2NhbGwgPSBpbXhfc2NfcnRjX2FsYXJtX3NjX25vdGlm
eSwNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgaW50IGlteF9zY19ydGNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikgQEAgLTczLDYNCj4gPiArMTUzLDggQEAgc3RhdGljIGlu
dCBpbXhfc2NfcnRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAlp
ZiAocmV0KQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4NCj4gPiArCWRldmljZV9pbml0X3dha2V1
cCgmcGRldi0+ZGV2LCB0cnVlKTsNCj4gPiArDQo+ID4gIAlpbXhfc2NfcnRjID0gZGV2bV9ydGNf
YWxsb2NhdGVfZGV2aWNlKCZwZGV2LT5kZXYpOw0KPiA+ICAJaWYgKElTX0VSUihpbXhfc2NfcnRj
KSkNCj4gPiAgCQlyZXR1cm4gUFRSX0VSUihpbXhfc2NfcnRjKTsNCj4gPiBAQCAtODcsNiArMTY5
LDggQEAgc3RhdGljIGludCBpbXhfc2NfcnRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UN
Cj4gPiAqcGRldikNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+DQo+ID4gKwlpbXhf
c2N1X2lycV9yZWdpc3Rlcl9ub3RpZmllcigmaW14X3NjX3J0Y19hbGFybV9zY19ub3RpZmllcik7
DQo+ID4gKw0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+IC0tDQo+ID4gMi43LjQN
Cg0K
