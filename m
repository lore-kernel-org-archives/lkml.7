Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C70FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50862168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="U+gGoInr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406417AbfJPQml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:42:41 -0400
Received: from mail-eopbgr60111.outbound.protection.outlook.com ([40.107.6.111]:56998
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389763AbfJPQml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:42:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geEr/2NPVFG2/8yQ+tSRiEvB5gxd11ftjFyIejRirbgMthy55IirW7FSCevQfl3FV8WyuX+KpdVj4BiZBsDIKv/BZ4XLTTSB8kQRBFD4RuMyAetezMPXxtfckZLJjsi9OJmqm6wIMuw8I6KDPgdPUHSOwB/oe0eVng8k+3TGAO+c1Gz4UcmpF7CBfrU+LDW/ILiWZQnoqrXvYRVfjIwHd3qLVImPuNgeM877saZhq+HsTOpzslbg2M+/gDNKYZF+NXMBcdj4JWNRC9HpXcPto7RzM0UzzjVbaRrTjZ1HeRXDNIHhd+01omSJz2Pj68YJXAxDxv5slqLPKMWBebi0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIY+H5yg8w3AzpsLEfMLJDIhwKwlDbWaFkp7/rM930g=;
 b=OkdDI5CkkPBj7yP7DJft9ShpqrJvmJUw7hnumCfSOFNZvRejqJB6pGYImaB7Wk81cUaGZPcPf8IAXF0e2JshPgR7CmmAWMs/cflItys0Z72rfhOnGlMF9TgDqQrIgQBLCcVbGZlXu7TYlJkNL639uBBRCQJGega47AZIm6GWdhfyGZNWLSEccn7ucqn62pau6xCLrxJs5zg7fgpwrkjHGF/kKMQUBx6RnO1KPtPrhDO7bfyfxBCalJyc1JtiMnO0QGkkbqZXeKgamt78yt06Lu5JjCSgc1Bc8B5+VNoQ5S/YgEK1/ep/oNCvbSXltARIRqcrQ6TA9O28HOFYv0PXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIY+H5yg8w3AzpsLEfMLJDIhwKwlDbWaFkp7/rM930g=;
 b=U+gGoInrxuvNCoQ/2Nu5oLd0/C/TmNF63/XuvZv+dD4x9b3EFvMenw+8JrLi+ejUwUr6EJ1wFy2j9Se5YkLgvg4mFcphl3Aq6OJlIp/HGJc/LnZRgUyoo5RtqpjVlSDI8AYGO+t4+ctjUEVBp245L+S3iSMj6z5yHweKEQJHK0o=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB4016.eurprd05.prod.outlook.com (52.134.18.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 16:42:36 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 16:42:36 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Luka Pivk <luka.pivk@toradex.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v1 1/2] arm: dts: imx*(colibri|apalis): add missing
 recovery modes to i2c
Thread-Topic: [PATCH v1 1/2] arm: dts: imx*(colibri|apalis): add missing
 recovery modes to i2c
Thread-Index: AQHVhD7G2HgM23iAn0WcdFEjmyuWhqddePAA
Date:   Wed, 16 Oct 2019 16:42:36 +0000
Message-ID: <d75236512937052dfd532d228a6fbd84824a12ed.camel@toradex.com>
References: <20191016162833.1893-1-philippe.schenker@toradex.com>
In-Reply-To: <20191016162833.1893-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f409623-eb5d-46a0-4b18-08d75257d9de
x-ms-traffictypediagnostic: VI1PR0502MB4016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB4016B780CAE996D4E196DF39F4920@VI1PR0502MB4016.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(136003)(39850400004)(376002)(346002)(199004)(189003)(44832011)(86362001)(66066001)(91956017)(2616005)(6486002)(476003)(11346002)(5660300002)(446003)(486006)(76116006)(99286004)(76176011)(102836004)(26005)(229853002)(6506007)(6116002)(6246003)(186003)(8936002)(3846002)(478600001)(14454004)(7416002)(4326008)(2906002)(305945005)(7736002)(25786009)(6436002)(54906003)(110136005)(6512007)(81166006)(66446008)(8676002)(66556008)(4001150100001)(256004)(81156014)(316002)(71200400001)(71190400001)(64756008)(36756003)(2501003)(118296001)(66476007)(14444005)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB4016;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: abanKF2VBeOwKMllu33rawvoYvn7GE5AZikNuK0xslaOmUxy+f0PVV5UAHM2otlNkfUb1LBUkkPrOQ1BrDnvSZBRqOaqOlyZqjaaRxPB/ir3If6vR3E23959IrSr1g7JBmpx93cUhWpg2Np3BG8JKC9xdjG5YVyF+INvN4FLOKYvIQw/ErDhqNAsJbmYVbtomOVcTD995tF0303bp9OxN8Sb/YhoS6p9ZAki8s+avchyk/QbxHZRiMfC++cv00kiV8jOae8WH9uxsReJ0dPEAJzZPI6Vjr0yC7ndfxYj5bIhR2MaeO2sGRoO83zqOGjPHXEdQOG0cb2N/CrE2Yg20Y8SjbvRysiJIz8LVc+Tq+9dawRaSfQai6GdRsG9RfqC5yExxZP53tVahCLhcv6zE0hStrWpJlz62+eBnGyc5FE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1CF0BB0BE246A41995B3BBFD3E55C7E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f409623-eb5d-46a0-4b18-08d75257d9de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 16:42:36.6031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FE+dLOSJTGQGF6qPnH+AUozcXP3/2WfODJPgQD0nc0A8BpGz5mrGgTanNGeyXG1ZZKYaWBTxB12W82Jj4qKjKpTHi3ULgDgN4KY5JCCN8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTE2IGF0IDE2OjI4ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gVGhpcyBwYXRjaCBhZGRzIG1pc3NpbmcgaTJjIHJlY292ZXJ5IG1vZGVzIGFuZCBjb3Jy
ZWN0cyB3cm9uZ2x5IG5hbWVkDQo+IG9uZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBw
ZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQoNClRoYXQgd2VudCB0
b28gZmFzdC4uLiBXaWxsIHNlbmQgYSB2MiBzaG9ydGx5Lg0KDQo+IC0tLQ0KPiANCj4gIGFyY2gv
YXJtL2Jvb3QvZHRzL2lteDZxZGwtYXBhbGlzLmR0c2kgIHwgMjYgKysrKysrKysrKysrKysrKysr
KysrLS0NCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRzaSB8
ICA2ICsrKy0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtYXBh
bGlzLmR0c2kNCj4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWFwYWxpcy5kdHNpDQo+IGlu
ZGV4IDdjNGFkNTQxYzNmNS4uN2JhZjRhNmYwNGViIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9i
b290L2R0cy9pbXg2cWRsLWFwYWxpcy5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZxZGwtYXBhbGlzLmR0c2kNCj4gQEAgLTIwNSw4ICsyMDUsOSBAQA0KPiAgLyogSTJDMV9TREEv
U0NMIG9uIE1YTTMgMjA5LzIxMSAoZS5nLiBSVEMgb24gY2FycmllciBib2FyZCkgKi8NCj4gICZp
MmMxIHsNCj4gIAljbG9jay1mcmVxdWVuY3kgPSA8MTAwMDAwPjsNCj4gLQlwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJncGlvIjsNCj4g
IAlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfaTJjMT47DQo+ICsJcGluY3RybC0xID0gPCZwaW5jdHJs
X2kyYzFfZ3Bpbz47DQo+ICAJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gIH07DQo+ICANCj4gQEAg
LTIxNiw4ICsyMTcsOSBAQA0KPiAgICovDQo+ICAmaTJjMiB7DQo+ICAJY2xvY2stZnJlcXVlbmN5
ID0gPDEwMDAwMD47DQo+IC0JcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gKwlwaW5jdHJs
LW5hbWVzID0gImRlZmF1bHQiLCAiZ3BpbyI7DQo+ICAJcGluY3RybC0wID0gPCZwaW5jdHJsX2ky
YzI+Ow0KPiArCXBpbmN0cmwtMSA9IDwmcGluY3RybF9pMmMyX2dwaW8+Ow0KPiAgCXN0YXR1cyA9
ICJva2F5IjsNCj4gIA0KPiAgCXBtaWM6IHBmdXplMTAwQDggew0KPiBAQCAtMzcyLDkgKzM3NCw5
IEBADQo+ICAgKi8NCj4gICZpMmMzIHsNCj4gIAljbG9jay1mcmVxdWVuY3kgPSA8MTAwMDAwPjsN
Cj4gLQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAicmVjb3ZlcnkiOw0KPiArCXBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCIsICJncGlvIjsNCj4gIAlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfaTJj
Mz47DQo+IC0JcGluY3RybC0xID0gPCZwaW5jdHJsX2kyYzNfcmVjb3Zlcnk+Ow0KPiArCXBpbmN0
cmwtMSA9IDwmcGluY3RybF9pMmMzX2dwaW8+Ow0KPiAgCXNjbC1ncGlvcyA9IDwmZ3BpbzMgMTcg
KEdQSU9fQUNUSVZFX0hJR0ggfCBHUElPX09QRU5fRFJBSU4pPjsNCj4gIAlzZGEtZ3Bpb3MgPSA8
JmdwaW8zIDE4IChHUElPX0FDVElWRV9ISUdIIHwgR1BJT19PUEVOX0RSQUlOKT47DQo+ICAJc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gQEAgLTY0Niw2ICs2NDgsMTMgQEANCj4gIAkJPjsNCj4gIAl9
Ow0KPiAgDQo+ICsJcGluY3RybF9pMmMxX2dwaW86IGkyYzFncGlvZ3JwIHsNCj4gKwkJZnNsLHBp
bnMgPSA8DQo+ICsJCQlNWDZRRExfUEFEX0NTSTBfREFUOF9fR1BJTzVfSU8yNiAweDQwMDFiOGIx
DQo+ICsJCQlNWDZRRExfUEFEX0NTSTBfREFUOV9fR1BJTzVfSU8yNyAweDQwMDFiOGIxDQo+ICsJ
CT47DQo+ICsJfTsNCj4gKw0KPiAgCXBpbmN0cmxfaTJjMjogaTJjMmdycCB7DQo+ICAJCWZzbCxw
aW5zID0gPA0KPiAgCQkJTVg2UURMX1BBRF9LRVlfQ09MM19fSTJDMl9TQ0wgMHg0MDAxYjhiMQ0K
PiBAQCAtNjUzLDYgKzY2MiwxMyBAQA0KPiAgCQk+Ow0KPiAgCX07DQo+ICANCj4gKwlwaW5jdHJs
X2kyYzJfZ3BpbzogaTJjMmdwaW9ncnAgew0KPiArCQlmc2wscGlucyA9IDwNCj4gKwkJCU1YNlFE
TF9QQURfS0VZX0NPTDNfX0dQSU80X0lPMTIgMHg0MDAxYjhiMQ0KPiArCQkJTVg2UURMX1BBRF9L
RVlfUk9XM19fR1BJTzRfSU8xMyAweDQwMDFiOGIxDQo+ICsJCT47DQo+ICsJfTsNCj4gKw0KPiAg
CXBpbmN0cmxfaTJjMzogaTJjM2dycCB7DQo+ICAJCWZzbCxwaW5zID0gPA0KPiAgCQkJTVg2UURM
X1BBRF9FSU1fRDE3X19JMkMzX1NDTCAweDQwMDFiOGIxDQo+IEBAIC02NjAsNyArNjc2LDcgQEAN
Cj4gIAkJPjsNCj4gIAl9Ow0KPiAgDQo+IC0JcGluY3RybF9pMmMzX3JlY292ZXJ5OiBpMmMzcmVj
b3ZlcnlncnAgew0KPiArCXBpbmN0cmxfaTJjM19ncGlvOiBpMmMzZ3Bpb2dycCB7DQo+ICAJCWZz
bCxwaW5zID0gPA0KPiAgCQkJTVg2UURMX1BBRF9FSU1fRDE3X19HUElPM19JTzE3IDB4NDAwMWI4
YjENCj4gIAkJCU1YNlFETF9QQURfRUlNX0QxOF9fR1BJTzNfSU8xOCAweDQwMDFiOGIxDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRzaQ0KPiBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNpDQo+IGluZGV4IDAxOWRkYTZiODhh
ZC4uNGVkN2FlNTcwMzBkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRs
LWNvbGlicmkuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGlicmku
ZHRzaQ0KPiBAQCAtMzEyLDkgKzMxMiw5IEBADQo+ICAgKi8NCj4gICZpMmMzIHsNCj4gIAljbG9j
ay1mcmVxdWVuY3kgPSA8MTAwMDAwPjsNCj4gLQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAi
cmVjb3ZlcnkiOw0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJncGlvIjsNCj4gIAlw
aW5jdHJsLTAgPSA8JnBpbmN0cmxfaTJjMz47DQo+IC0JcGluY3RybC0xID0gPCZwaW5jdHJsX2ky
YzNfcmVjb3Zlcnk+Ow0KPiArCXBpbmN0cmwtMSA9IDwmcGluY3RybF9pMmMzX2dwaW8+Ow0KPiAg
CXNjbC1ncGlvcyA9IDwmZ3BpbzEgMyAoR1BJT19BQ1RJVkVfSElHSCB8IEdQSU9fT1BFTl9EUkFJ
Tik+Ow0KPiAgCXNkYS1ncGlvcyA9IDwmZ3BpbzEgNiAoR1BJT19BQ1RJVkVfSElHSCB8IEdQSU9f
T1BFTl9EUkFJTik+Ow0KPiAgCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+IEBAIC01MTYsNyArNTE2
LDcgQEANCj4gIAkJPjsNCj4gIAl9Ow0KPiAgDQo+IC0JcGluY3RybF9pMmMzX3JlY292ZXJ5OiBp
MmMzcmVjb3ZlcnlncnAgew0KPiArCXBpbmN0cmxfaTJjM19ncGlvOiBpMmMzZ3Bpb2dycCB7DQo+
ICAJCWZzbCxwaW5zID0gPA0KPiAgCQkJTVg2UURMX1BBRF9HUElPXzNfX0dQSU8xX0lPMDMgMHg0
MDAxYjhiMQ0KPiAgCQkJTVg2UURMX1BBRF9HUElPXzZfX0dQSU8xX0lPMDYgMHg0MDAxYjhiMQ0K
