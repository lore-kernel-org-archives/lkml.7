Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE826C28D1C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF2A207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="greChKMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfFFI3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:29:21 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:11774
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfFFI3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8mBRO1MCnwWDV4bRO5YVT6jPtY8VhZYF2vzfSkXDO4=;
 b=greChKMy5gxKIdziq0jWVypC3sGBp32G/b++51vqAJJncnLSaeYttrJd5PTfou8IMQSKs3SB2NC1qJjbe81bqxQ38tRxPXrbHC++TVUZtS18qQD3iTsfH8J2Q5qpYt1EdKQkDmLThJRu/83qJhP8wLFrvk8P/GQlVTqEBfmlkoY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3786.eurprd04.prod.outlook.com (52.134.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 08:29:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 08:29:13 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 1/4] dt-bindings: imx: Add clock binding doc for
 i.MX8MN
Thread-Topic: [PATCH V4 1/4] dt-bindings: imx: Add clock binding doc for
 i.MX8MN
Thread-Index: AQHVHAeguECfjY+e10iOlRyz227+CqaOPjIAgAAMMnA=
Date:   Thu, 6 Jun 2019 08:29:13 +0000
Message-ID: <DB3PR0402MB39160A7975F9D20EF77F6186F5170@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190606013323.3392-1-Anson.Huang@nxp.com>
 <20190606074036.vx2smtauiwxy6wzx@flea>
In-Reply-To: <20190606074036.vx2smtauiwxy6wzx@flea>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 405427fd-aef5-43bd-6c0c-08d6ea590e9c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3786;
x-ms-traffictypediagnostic: DB3PR0402MB3786:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DB3PR0402MB3786E57EC53809727D30CB5FF5170@DB3PR0402MB3786.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(366004)(13464003)(199004)(189003)(9686003)(7416002)(7736002)(478600001)(305945005)(25786009)(6916009)(186003)(4326008)(26005)(53936002)(66446008)(73956011)(5660300002)(81156014)(6246003)(81166006)(8936002)(8676002)(52536014)(68736007)(33656002)(316002)(53376002)(86362001)(74316002)(6506007)(99286004)(6436002)(229853002)(446003)(6306002)(66066001)(55016002)(486006)(11346002)(71190400001)(476003)(76116006)(54906003)(66946007)(966005)(66476007)(14454004)(2906002)(256004)(44832011)(102836004)(3846002)(6116002)(7696005)(71200400001)(76176011)(64756008)(53546011)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3786;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7DWiVbykOzdMKFrgORxPRThhzszJM089GvGvpFOQ8yW5REMxwhBf4QNFHkAttMCdnS9Rbga6ZFbFoM0qRWyT/duewO7HWagFlkKZmsknVnSkiFCPCb/uz2hvQRPUZz1j0WOsdkbo/xwmPoiEl97KcPwb7BOvc+jRqaRQ97vCtrdV6PphxqF+zbcfz46z0SzG5Gf+KfV21sVXoSZiWy/p5F9Upi6ZNwnjuW+pLU5NMt6C6mgST9pWDLYFbh8axGFba3zJHFOaeAsYY78WpBSkmtp7v2+HTyla676YrB8EpmKOfReG5OyVy4cc9tNCZuW/02852BJv03ROTYpwxCeBYP3i4T3uY2lxwEgI72mycTTa8bDQo3+m7McHj6JfH0t8UOSh42OpNfeoPNKQDtmYt255KmjGkH9sjsbb4O0eG9E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405427fd-aef5-43bd-6c0c-08d6ea590e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 08:29:13.6275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1heGltZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1heGlt
ZSBSaXBhcmQgPG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBK
dW5lIDYsIDIwMTkgMzo0MSBQTQ0KPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5j
b20+DQo+IENjOiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsgcm9i
aCtkdEBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVs
Lm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBm
ZXN0ZXZhbUBnbWFpbC5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxsLmRlYWNv
bkBhcm0uY29tOyBvbG9mQGxpeG9tLm5ldDsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+
IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1OyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsg
TGVvbmFyZCBDcmVzdGV6DQo+IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47IGRpbmd1eWVuQGtl
cm5lbC5vcmc7DQo+IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207IEFpc2hlbmcgRG9uZyA8
YWlzaGVuZy5kb25nQG54cC5jb20+Ow0KPiBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPjsg
SmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsNCj4gbC5zdGFjaEBwZW5ndXRyb25peC5kZTsg
UGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBsaW51eC0NCj4gY2xrQHZnZXIua2VybmVsLm9y
ZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlt
eA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjQgMS80XSBk
dC1iaW5kaW5nczogaW14OiBBZGQgY2xvY2sgYmluZGluZyBkb2MgZm9yDQo+IGkuTVg4TU4NCj4g
DQo+IEhpLA0KPiANCj4gT24gVGh1LCBKdW4gMDYsIDIwMTkgYXQgMDk6MzM6MjBBTSArMDgwMCwg
QW5zb24uSHVhbmdAbnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24u
SHVhbmdAbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCB0aGUgY2xvY2sgYmluZGluZyBkb2MgZm9yIGku
TVg4TU4uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdA
bnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIHNpbmNlIFYzOg0KPiA+IAktIHN3aXRjaCBi
aW5kaW5nIGRvYyBmcm9tIC50eHQgdG8gLnlhbWwuDQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Nsb2NrL2lteDhtbi1jbG9jay55YW1sICAgIHwgMTE1ICsrKysrKysrKysr
DQo+ID4gIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svaW14OG1uLWNsb2NrLmggICAgICAgICAg
IHwgMjE1DQo+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDMz
MCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg4bW4tY2xvY2sueWFtbA0KPiA+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9pbXg4bW4tY2xvY2suaA0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9j
bG9jay9pbXg4bW4tY2xvY2sueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Nsb2NrL2lteDhtbi1jbG9jay55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gPiBpbmRleCAwMDAwMDAwLi44Y2I4ZmNmDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg4bW4tY2xvY2sueWFt
bA0KPiA+IEBAIC0wLDAgKzEsMTE1IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjANCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9zY2hlbWFzL2JpbmRpbmdzL2Nsb2NrL2lteDhtbi1jbG9jay55YW1sIw0KPiA+
ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMN
Cj4gPiArDQo+ID4gK3RpdGxlOiBOWFAgaS5NWDhNIE5hbm8gQ2xvY2sgQ29udHJvbCBNb2R1bGUg
QmluZGluZw0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBBbnNvbiBIdWFuZyA8
QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAg
TlhQIGkuTVg4TSBOYW5vIGNsb2NrIGNvbnRyb2wgbW9kdWxlIGlzIGFuIGludGVncmF0ZWQgY2xv
Y2sNCj4gPiArY29udHJvbGxlciwgd2hpY2gNCj4gPiArICBnZW5lcmF0ZXMgYW5kIHN1cHBsaWVz
IHRvIGFsbCBtb2R1bGVzLg0KPiA+ICsNCj4gPiArICBUaGlzIGJpbmRpbmcgdXNlcyBjb21tb24g
Y2xvY2sgYmluZGluZ3MgIFsxXQ0KPiA+ICsgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2Nsb2NrL2Nsb2NrLWJpbmRpbmdzLnR4dA0KPiANCj4gV2hpY2ggcGFydCBleGFjdGx5IGFy
ZSB5b3UgdXNpbmc/DQo+IA0KPiBJJ20gbm90IHN1cmUgaXQncyB3b3J0aCByZWZlcnJpbmcgdG8u
IEFueSBwcm92aWRlciBwcm9wZXJ0eSBzaG91bGQgYmUgbGlzdGVkDQo+IGhlcmUsIGFuZCB0aGUg
Y29uc3VtZXIgcHJvcGVydGllcyBhcmUgYWxyZWFkeSBjaGVja2VkLg0KDQpBZ3JlZWQsIEkgd2ls
bCByZW1vdmUgdGhpcyByZWZlcmVuY2Ugc3RhdGVtZW50IGluIG5leHQgdmVyc2lvbi4NCg0KPiAN
Cj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgY29uc3Q6IGZz
bCxpbXg4bW4tY2NtDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+
ID4gKw0KPiA+ICsgIGNsb2NrczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2Ny
aXB0aW9uOiAzMmsgb3NjDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IDI0bSBvc2MNCj4gPiAr
ICAgICAgLSBkZXNjcmlwdGlvbjogZXh0MSBjbG9jayBpbnB1dA0KPiA+ICsgICAgICAtIGRlc2Ny
aXB0aW9uOiBleHQyIGNsb2NrIGlucHV0DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IGV4dDMg
Y2xvY2sgaW5wdXQNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogZXh0NCBjbG9jayBpbnB1dA0K
PiA+ICsNCj4gPiArICBjbG9jay1uYW1lczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAt
IGNvbnN0OiBvc2NfMzJrDQo+ID4gKyAgICAgIC0gY29uc3Q6IG9zY18yNG0NCj4gPiArICAgICAg
LSBjb25zdDogY2xrX2V4dDENCj4gPiArICAgICAgLSBjb25zdDogY2xrX2V4dDINCj4gPiArICAg
ICAgLSBjb25zdDogY2xrX2V4dDMNCj4gPiArICAgICAgLSBjb25zdDogY2xrX2V4dDQNCj4gPiAr
DQo+ID4gKyAgJyNjbG9jay1jZWxscyc6DQo+ID4gKyAgICBjb25zdDogMQ0KPiA+ICsNCj4gPiAr
cmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiArICAtIGNs
b2Nrcw0KPiA+ICsgIC0gY2xvY2stbmFtZXMNCj4gPiArICAtICcjY2xvY2stY2VsbHMnDQo+ID4g
Kw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAjIENsb2NrIENvbnRyb2wgTW9kdWxlIG5vZGU6DQo+
ID4gKyAgLSB8DQo+ID4gKyAgICBjbGs6IGNsb2NrLWNvbnRyb2xsZXJAMzAzODAwMDAgew0KPiA+
ICsgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDhtbi1jY20iOw0KPiA+ICsgICAgICAgIHJl
ZyA9IDwweDAgMHgzMDM4MDAwMCAweDAgMHgxMDAwMD47DQo+ID4gKyAgICAgICAgI2Nsb2NrLWNl
bGxzID0gPDE+Ow0KPiA+ICsgICAgICAgIGNsb2NrcyA9IDwmb3NjXzMyaz4sIDwmb3NjXzI0bT4s
IDwmY2xrX2V4dDE+LA0KPiA+ICsgICAgICAgICAgICAgICAgIDwmY2xrX2V4dDI+LCA8JmNsa19l
eHQzPiwgPCZjbGtfZXh0ND47DQo+ID4gKyAgICAgICAgY2xvY2stbmFtZXMgPSAib3NjXzMyayIs
ICJvc2NfMjRtIiwgImNsa19leHQxIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICJjbGtf
ZXh0MiIsICJjbGtfZXh0MyIsICJjbGtfZXh0NCI7DQo+ID4gKyAgICB9Ow0KPiA+ICsNCj4gPiAr
ICAjIFJlcXVpcmVkIGV4dGVybmFsIGNsb2NrcyBmb3IgQ2xvY2sgQ29udHJvbCBNb2R1bGUgbm9k
ZToNCj4gPiArICAtIHwNCj4gPiArICAgIG9zY18zMms6IGNsb2NrLW9zYy0zMmsgew0KPiA+ICsg
ICAgICAgIGNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KPiA+ICsgICAgICAgICNjbG9jay1j
ZWxscyA9IDwwPjsNCj4gPiArICAgICAgICBjbG9jay1mcmVxdWVuY3kgPSA8MzI3Njg+Ow0KPiA+
ICsJY2xvY2stb3V0cHV0LW5hbWVzID0gIm9zY18zMmsiOw0KPiA+ICsgICAgfTsNCj4gPiArDQo+
ID4gKyAgICBvc2NfMjRtOiBjbG9jay1vc2MtMjRtIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxl
ID0gImZpeGVkLWNsb2NrIjsNCj4gPiArICAgICAgICAjY2xvY2stY2VsbHMgPSA8MD47DQo+ID4g
KyAgICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDI0MDAwMDAwPjsNCj4gPiArICAgICAgICBjbG9j
ay1vdXRwdXQtbmFtZXMgPSAib3NjXzI0bSI7DQo+ID4gKyAgICB9Ow0KPiA+ICsNCj4gPiArICAg
IGNsa19leHQxOiBjbG9jay1leHQxIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gImZpeGVk
LWNsb2NrIjsNCj4gPiArICAgICAgICAjY2xvY2stY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgICAg
Y2xvY2stZnJlcXVlbmN5ID0gPDEzMzAwMDAwMD47DQo+ID4gKyAgICAgICAgY2xvY2stb3V0cHV0
LW5hbWVzID0gImNsa19leHQxIjsNCj4gPiArICAgIH07DQo+ID4gKw0KPiA+ICsgICAgY2xrX2V4
dDI6IGNsb2NrLWV4dDIgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2si
Ow0KPiA+ICsgICAgICAgICNjbG9jay1jZWxscyA9IDwwPjsNCj4gPiArICAgICAgICBjbG9jay1m
cmVxdWVuY3kgPSA8MTMzMDAwMDAwPjsNCj4gPiArICAgICAgICBjbG9jay1vdXRwdXQtbmFtZXMg
PSAiY2xrX2V4dDIiOw0KPiA+ICsgICAgfTsNCj4gPiArDQo+ID4gKyAgICBjbGtfZXh0MzogY2xv
Y2stZXh0MyB7DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQo+ID4g
KyAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDA+Ow0KPiA+ICsgICAgICAgIGNsb2NrLWZyZXF1ZW5j
eSA9IDwxMzMwMDAwMDA+Ow0KPiA+ICsgICAgICAgIGNsb2NrLW91dHB1dC1uYW1lcyA9ICJjbGtf
ZXh0MyI7DQo+ID4gKyAgICB9Ow0KPiA+ICsNCj4gPiArICAgIGNsa19leHQ0OiBjbG9jay1leHQ0
IHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsNCj4gPiArICAgICAg
ICAjY2xvY2stY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgICAgY2xvY2stZnJlcXVlbmN5PSA8MTMz
MDAwMDAwPjsNCj4gPiArICAgICAgICBjbG9jay1vdXRwdXQtbmFtZXMgPSAiY2xrX2V4dDQiOw0K
PiA+ICsgICAgfTsNCj4gPiArDQo+ID4gKyAgIyBUaGUgY2xvY2sgY29uc3VtZXIgc2hvdWxkIHNw
ZWNpZnkgdGhlIGRlc2lyZWQgY2xvY2sgYnkgaGF2aW5nIHRoZQ0KPiA+ICsgY2xvY2sgICMgSUQg
aW4gaXRzICJjbG9ja3MiIHBoYW5kbGUgY2VsbC4gU2VlDQo+ID4gKyBpbmNsdWRlL2R0LWJpbmRp
bmdzL2Nsb2NrL2lteDhtbi1jbG9jay5oDQo+ID4gKyAgIyBmb3IgdGhlIGZ1bGwgbGlzdCBvZiBp
Lk1YOE0gTmFubyBjbG9jayBJRHMuDQo+IA0KPiBJIGd1ZXNzIHRoaXMgY291bGQgYmUgcGFydCBv
ZiB0aGUgY2xvY2stY2VsbHMgZGVzY3JpcHRpb24uDQo+IA0KDQpPSy4NCg0KVGhhbmtzLA0KQW5z
b24uDQoNCj4gT25jZSBmaXhlZCwNCj4gUmV2aWV3ZWQtYnk6IE1heGltZSBSaXBhcmQgPG1heGlt
ZS5yaXBhcmRAYm9vdGxpbi5jb20+DQo+IA0KPiBNYXhpbWUNCj4gDQo+IC0tDQo+IE1heGltZSBS
aXBhcmQsIEJvb3RsaW4NCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZw0K
PiBodHRwczovL2Jvb3RsaW4uY29tDQo=
