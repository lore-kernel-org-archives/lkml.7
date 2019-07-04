Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46E1C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB0F21882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZWzgh6D+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfGDJKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:10:03 -0400
Received: from mail-eopbgr140072.outbound.protection.outlook.com ([40.107.14.72]:8775
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727128AbfGDJKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/2yZwkIv7CYd/X9yEoqQ+rc3rIdjLTIZSTg2seZohY=;
 b=ZWzgh6D+LHpYzSPG9FEM7n3eXzMUXlvThlfOYIVwQHBkwCe0ZCzuGoG6dfcCM0SGUgcMPqfkfYLD1toqeyFD2vdgAeJ6Je2u23SRoUZ6c0MOSVuVsbtpISqPd1KGc2fK36yPpOuO8I0zIp0WMwcnAiHD1ChI5mz/1FfBbmUfpck=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 09:09:18 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 09:09:18 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] reset: imx7: Add support for i.MX8MM SoC
Thread-Topic: [PATCH 1/2] reset: imx7: Add support for i.MX8MM SoC
Thread-Index: AQHVL/IwVPL1AMH7TkeLenNRsyk/8aa6LCsAgAADXSA=
Date:   Thu, 4 Jul 2019 09:09:18 +0000
Message-ID: <DB3PR0402MB3916D53E9BD277C2152F7261F5FA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190701093944.5540-1-Anson.Huang@nxp.com>
 <1562230444.6641.2.camel@pengutronix.de>
In-Reply-To: <1562230444.6641.2.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51d9eb69-ba1f-4cd6-adee-08d7005f4b69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-antispam-prvs: <DB3PR0402MB37569D55908879227CE28A2DF5FA0@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(14444005)(6116002)(229853002)(11346002)(66446008)(66476007)(3846002)(66946007)(55016002)(256004)(66556008)(64756008)(76116006)(6436002)(476003)(486006)(446003)(44832011)(99286004)(26005)(6506007)(102836004)(7696005)(76176011)(110136005)(316002)(186003)(2501003)(73956011)(2201001)(33656002)(14454004)(86362001)(68736007)(52536014)(53936002)(5660300002)(74316002)(7416002)(9686003)(6246003)(2906002)(8676002)(8936002)(71200400001)(66066001)(305945005)(7736002)(81166006)(81156014)(25786009)(4326008)(71190400001)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aOWDjd+HV+zMi9R0LnQu9rMBXtLJXOhfwpB8x7iekLEksmlRPZW57Li5ot7zxnVNt1D8LfO6blIjCer9+sqZ45PSP76FYhJ8AUa6PXhIbSZqBbHsMJIZEagS9xSXNai12uDmEOEWJNLLI1vli5UYtP1dk1n5NTIAoaZJVU2aoG95sDXbTDEEEjOe1TNYghYk8Cp5lEzdDqjn5LlVsOoEiGcV6yKaRIPgAbXVZaiRj5uWtFK86yVuk3PTZSG2zrLnolTUFOy7V7jxz8fT9FaYEyRVOXLAqEv6wuOtRO0bGYFoDtT0yrqLQ3aKdwtF9zFrWIkYLT/g+G0q4iMJA0dNJ+CREQ7G90uC7BcvJsvavXg+YC4oulXF2qSK76vqxFOBu23H8CVQjfbyEkvthEv3lIX6aABj0dYiu3V2XBZRKYU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d9eb69-ba1f-4cd6-adee-08d7005f4b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 09:09:18.2754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBoaWxpcHANCg0KPiBPbiBNb24sIDIwMTktMDctMDEgYXQgMTc6MzkgKzA4MDAsIEFuc29u
Lkh1YW5nQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOE1NIFNvQyBoYXMgYSBzdWJzZXQgb2YgaS5NWDhNUSBJ
UCBibG9jayB2YXJpYW50LCBpdCBjYW4gcmV1c2UgdGhlDQo+ID4gaS5NWDhNUSByZXNldCBjb250
cm9sbGVyIGRyaXZlciBhbmQganVzdCBza2lwIHRob3NlIG5vbi1leGlzdGluZyBJUA0KPiA+IGJs
b2NrcywgYWRkIHN1cHBvcnQgZm9yIGkuTVg4TU0gU29DIHJlc2V0IGNvbnRyb2wuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9yZXNldC9yZXNldC1pbXg3LmMgfCAyMCArKysrKysrKysrKysrKysr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5jIGIvZHJpdmVycy9yZXNldC9yZXNl
dC1pbXg3LmMNCj4gPiBpbmRleCAzZWNkNzcwLi45NDExMzFmIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5jDQo+ID4gKysrIGIvZHJpdmVycy9yZXNldC9yZXNldC1p
bXg3LmMNCj4gPiBAQCAtMjA3LDYgKzIwNywyNiBAQCBzdGF0aWMgaW50IGlteDhtcV9yZXNldF9z
ZXQoc3RydWN0DQo+IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCj4gPiAgCWNvbnN0IHVu
c2lnbmVkIGludCBiaXQgPSBpbXg3c3JjLT5zaWduYWxzW2lkXS5iaXQ7DQo+ID4gIAl1bnNpZ25l
ZCBpbnQgdmFsdWUgPSBhc3NlcnQgPyBiaXQgOiAwOw0KPiA+DQo+ID4gKwlpZiAob2ZfbWFjaGlu
ZV9pc19jb21wYXRpYmxlKCJmc2wsaW14OG1tIikpIHsNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGNo
ZWNrZWQgb25jZSBkdXJpbmcgcHJvYmUsIG5vdCBpbiBldmVyeSByZXNldF9zZXQsIGlmIHRoaXMN
Cj4gY2hlY2sgaGFzIHRvIGJlIG1hZGUgYXQgYWxsLiBPbiBpLk1YOE1NIHRoZXNlIHVudXNlZCBy
ZXNldCBjb250cm9scyBhcmUNCj4gbm90IGdvaW5nIHRvIGJlIGhvb2tlZCB1cCB2aWEgcGhhbmRs
ZSwgc28gdGhpcyBmdW5jdGlvbiBzaG91bGQgbmV2ZXIgYmUNCj4gY2FsbGVkIHdpdGggdGhlIHZh
bHVlcyB0aGF0IGFyZSBmaWx0ZXJlZCBvdXQgaGVyZSBhbnl3YXkuDQo+IEFuZCBpbiBjYXNlIHNv
bWVib2R5IG1ha2VzIGFuIGVycm9yIGluIHRoZSBkZXZpY2UgdHJlZSwgZG9lcyB3cml0aW5nIDEg
dG8NCj4gdGhlIHJlc2VydmVkIGJpdHMgb24gaS5NWDhNTSBoYXZlIGFueSBuZWdhdGl2ZSBzaWRl
IGVmZmVjdHMgYXQgYWxsPw0KPiBPciBhcmUgdGhlc2UgYml0cyBqdXN0IG5vdCBob29rZWQgdXA/
IElmIHRoaXMgaXMgbm8gcHJvYmxlbSwgSSBhc3N1bWUgdGhpcw0KPiBwYXRjaCBpcyBub3QgbmVl
ZGVkIGF0IGFsbC4NCg0KSSBqdXN0IHRyaWVkIGl0IG9uIGkuTVg4TU0sIHJlYWQvd3JpdGUgdG8g
dGhlIHJlc2VydmVkIHJlZ2lzdGVycyBsb29rcyBsaWtlIE9LLA0Kc28gdGhpcyBwYXRjaCBjYW4g
YmUgaWdub3JlZCwgYWx0aG91Z2ggYWNjZXNzaW5nIHJlc2VydmVkIHJlZ2lzdGVycyBpcyBOT1Qg
Z29vZCwNCmJ1dCB0aGUgdXNlciBzaG91bGQgaGF2ZSBjb3JyZWN0IHNldHRpbmdzIGluIERULCB0
aGVyZSB3aWxsIGJlIG5vIGFjY2VzcyBmb3IgdGhlc2UNCnJlc2VydmVkIHJlZ2lzdGVycy4NCg0K
U28sIGxldCdzIGp1c3QgaWdub3JlIHRoaXMgcGF0Y2gsIGFkZGluZyB0aGUgZmFsbGJhY2sgY29t
cGF0aWJsZSBzaG91bGQgYmUgZ29vZCBmb3INCmkuTVg4TU0gdG8gcmV1c2UgdGhpcyBkcml2ZXIu
DQoNClRoYW5rcywNCkFuc29uIA0KDQo+IA0KPiBUaGUgY29ycmVjdCB3YXkgdG8gcHJvdGVjdCBh
Z2FpbnN0IERUIHdyaXRlcnMgaG9va2luZyB1cCB0aGUgbm9uLSBleGlzdGluZw0KPiByZXNldCBs
aW5lcyB3b3VsZCBiZSB0byByZXBsYWNlIHJjZGV2Lm9mX3hsYXRlIHdpdGggYSB2ZXJzaW9uIHRo
YXQgcmV0dXJucyAtDQo+IEVJTlZBTCBmb3IgdGhlbSBvbiBpLk1YOE1NLiBBbHNvIGluIHRoYXQg
Y2FzZSBJJ2QgY2hlY2sgdGhlIHJlc2V0LWNvbnRyb2xsZXINCj4gY29tcGF0aWJsZSwgbm90IHRo
ZSBtYWNoaW5lIGNvbXBhdGlibGUuDQo+IA0KPiA+ICsJCXN3aXRjaCAoaWQpIHsNCj4gPiArCQlj
YXNlIElNWDhNUV9SRVNFVF9IRE1JX1BIWV9BUEJfUkVTRVQ6DQo+ID4gKwkJY2FzZSBJTVg4TVFf
UkVTRVRfUENJRVBIWTI6IC8qIGZhbGx0aHJvdWdoICovDQo+ID4gKwkJY2FzZSBJTVg4TVFfUkVT
RVRfUENJRVBIWTJfUEVSU1Q6IC8qIGZhbGx0aHJvdWdoICovDQo+ID4gKwkJY2FzZSBJTVg4TVFf
UkVTRVRfUENJRTJfQ1RSTF9BUFBTX0VOOiAvKiBmYWxsdGhyb3VnaA0KPiAqLw0KPiA+ICsJCWNh
c2UgSU1YOE1RX1JFU0VUX1BDSUUyX0NUUkxfQVBQU19UVVJOT0ZGOiAvKg0KPiBmYWxsdGhyb3Vn
aCAqLw0KPiA+ICsJCWNhc2UgSU1YOE1RX1JFU0VUX01JUElfQ1NJMV9DT1JFX1JFU0VUOiAvKiBm
YWxsdGhyb3VnaA0KPiAqLw0KPiA+ICsJCWNhc2UgSU1YOE1RX1JFU0VUX01JUElfQ1NJMV9QSFlf
UkVGX1JFU0VUOiAvKg0KPiBmYWxsdGhyb3VnaCAqLw0KPiA+ICsJCWNhc2UgSU1YOE1RX1JFU0VU
X01JUElfQ1NJMV9FU0NfUkVTRVQ6IC8qIGZhbGx0aHJvdWdoDQo+ICovDQo+ID4gKwkJY2FzZSBJ
TVg4TVFfUkVTRVRfTUlQSV9DU0kyX0NPUkVfUkVTRVQ6IC8qIGZhbGx0aHJvdWdoDQo+ICovDQo+
ID4gKwkJY2FzZSBJTVg4TVFfUkVTRVRfTUlQSV9DU0kyX1BIWV9SRUZfUkVTRVQ6IC8qDQo+IGZh
bGx0aHJvdWdoICovDQo+ID4gKwkJY2FzZSBJTVg4TVFfUkVTRVRfTUlQSV9DU0kyX0VTQ19SRVNF
VDogLyogZmFsbHRocm91Z2gNCj4gKi8NCj4gPiArCQljYXNlIElNWDhNUV9SRVNFVF9ERFJDMl9Q
SFlfUkVTRVQ6IC8qIGZhbGx0aHJvdWdoICovDQo+ID4gKwkJY2FzZSBJTVg4TVFfUkVTRVRfRERS
QzJfQ09SRV9SRVNFVDogLyogZmFsbHRocm91Z2ggKi8NCj4gPiArCQljYXNlIElNWDhNUV9SRVNF
VF9ERFJDMl9QUlNUOiAvKiBmYWxsdGhyb3VnaCAqLw0KPiANCj4gSSB0aGluayBpdCB3b3VsZCBt
YWtlIHNlbnNlIHRvIGFkZCBJTVg4TU1fUkVTRVRfKiBkZWZpbmVzIGZvciBhbGwgYnV0DQo+IHRo
ZXNlLCB0byBhdm9pZCBjb25mdXNpb24gd2hlbiByZWFkaW5nIHRoZSBpbXg4bW0uZHRzaQ0KPiAN
Cj4gcmVnYXJkcw0KPiBQaGlsaXBwDQo=
