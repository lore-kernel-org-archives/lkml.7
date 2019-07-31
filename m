Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B338BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACCB206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Qn9EdJlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfGaLNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:13:12 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com ([40.107.2.115]:17890
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727856AbfGaLNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHnLoXOQU3t0/xeXQ16e8KTAz4/v6gTxSrJZfXAo8JQSp9bUxC3JDYhfiE9/aTxnZ7mOg5REKaiutarZSQTOh110Spq1adK89hNtNmz3a9lIfNaaW80U7lIA6ZiPXQmLx3lB3RrSAOrJyfbiLlniCrodPF+ijU3Pj3M7z7TXV4vV1De10dATOOLgxdPWjUehIzpkKZls+MAmWZjuqeRN+9VOtbH7PMYnM9LrtELZwf14102Wh2eRQrecHJYQjo8sIoig7iLclqE9jzvkNJCzOm+L9ReR4tpYvrbzt9ZAcYv3RoZ6P61oaoywf76ys08QiH9odaeuCRyMUUdub1CviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCPQJTLSo1ApS65uG/LskZMgdGpToKLn+FJGPOK2/JA=;
 b=QwOm6Jv/ShtKwAgiN+gelkvXqF0uZgHzsW8mYYOHU5K3SUj5CUDCOrRkzeSh6BHGjoWpGzXOxD9xFSNsHfOgoDnRnWl+Som17ayd9NBG53gmQ51xnzAYW57XpWYQPKVwNYo9KM4n5wJX8ZWA9AlfRl3ouIrD8IgS48j67JdMW7aAnJ++HNNWYKdDyCwuQCk9bl6VgHwTzkODTtndYkJkPWcKwCxhPQCVPDrN6BfLmrZzbcc7gFaXspDwMbPelPMpiHTukLptQ4+O1PwHshdIqcN2B4VzaI/ns+AOiltYLnfNaeP8ICbZZ7wfFuHDZsh9WovRlfdoxgJdN5p0oDXcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCPQJTLSo1ApS65uG/LskZMgdGpToKLn+FJGPOK2/JA=;
 b=Qn9EdJlpsuJ25oCoa6AYCqXKR39Wr/ukhN5gAwTmsrhtxEvwgl3SZrRmLDkxaqYF3dpbbVPBooBxqChKhuqlpBzyDcs3yPu0nj8XAiagLtGkRFHliEsSvIFNTNJll1GHdXGRDKUM+EStTzrmpR0kN5ZitYxI/keqnumkcUBViEI=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3744.eurprd05.prod.outlook.com (52.134.8.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 11:13:04 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 11:13:04 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH 11/22] ARM: dts: imx6: Add sleep state to can interfaces
Thread-Topic: [PATCH 11/22] ARM: dts: imx6: Add sleep state to can interfaces
Thread-Index: AQHVRucouAIsWgAkb02kfnBGIK5U5abkUUwAgABCvIA=
Date:   Wed, 31 Jul 2019 11:13:04 +0000
Message-ID: <ed7645a47983a2bd28a9611fe779b6ac0ade7fe6.camel@toradex.com>
References: <20190730144649.19022-1-dev@pschenker.ch>
         <20190730144649.19022-12-dev@pschenker.ch>
         <86f1e50b-97d6-5bdb-7cc2-e7dc162d147a@ysoft.com>
In-Reply-To: <86f1e50b-97d6-5bdb-7cc2-e7dc162d147a@ysoft.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68b0bfcf-9520-4b33-e7f4-08d715a80f04
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3744;
x-ms-traffictypediagnostic: VI1PR0502MB3744:
x-microsoft-antispam-prvs: <VI1PR0502MB3744D7C8F0594A3E3C95AACFF4DF0@VI1PR0502MB3744.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(136003)(39850400004)(396003)(346002)(189003)(199004)(6506007)(86362001)(118296001)(5660300002)(486006)(2906002)(6436002)(76116006)(54906003)(110136005)(6512007)(7736002)(68736007)(476003)(446003)(66556008)(44832011)(2616005)(316002)(3846002)(6116002)(64756008)(66476007)(11346002)(66446008)(7416002)(8936002)(53936002)(8676002)(81156014)(2201001)(66946007)(256004)(71200400001)(36756003)(14444005)(2501003)(25786009)(229853002)(99286004)(91956017)(305945005)(6486002)(478600001)(81166006)(71190400001)(14454004)(102836004)(6246003)(26005)(186003)(4326008)(66066001)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3744;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 80+wFXuwIY8jGu+9iBE7hZM6Fjkv2eLMT2joUSeawnL7d46D5b9s3JVhZ75SpqpLy7/R69GQB6Hq7n1wFsZ61DBbRK3CSEe8ltV4azFsascJPkDc34DxgB7Q6rSdmvgEGEV7ZY2zCUDi6gB13i7h8YN5dN/j3k0fchT9Ln6oPoPESWNsFIYGtv2RGa2BXbCIDJEWjqkvlZSIg9IovkoF8PtBeEeyocciJAdA/nxQbjoo196Ao52iwDd1D+0Mbc2uzE1kxjp+OgC00Jh0E6KFdAmyO39iisJBW1BrDJ3PN8+TkNCejwhxEdJJNK3tqVEvbslwvgyNfFvGYXkQhAfVV5Ty1XX2D1wSm/F1VXfBgM4qlySNNbKpYU/4ARz3fiBZKcZI8O7Z593wsY9IMJc0VWwSkhkba9mB8bsMu8xw0fA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56A7282D5FEE4A4CA33B26753D1BE5EE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b0bfcf-9520-4b33-e7f4-08d715a80f04
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 11:13:04.5813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTMxIGF0IDA5OjE0ICswMjAwLCBNaWNoYWwgVm9rw6HEjSB3cm90ZToN
Cj4gT24gMzAuIDA3LiAxOSAxNjo0NiwgUGhpbGlwcGUgU2NoZW5rZXIgd3JvdGU6DQo+ID4gRnJv
bTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KPiA+
IA0KPiA+IFRoaXMgcGF0Y2ggcHJlcGFyZXMgdGhlIGRldmljZXRyZWUgZm9yIHRoZSBuZXcgSXhv
cmEgVjEuMiB3aGVyZSB3ZSBhcmUNCj4gPiBhYmxlIHRvIHR1cm4gb2ZmIHRoZSBzdXBwbHkgb2Yg
dGhlIGNhbiB0cmFuc2NlaXZlci4gVGhpcyBpbXBsaWVzIHRvIHVzZQ0KPiA+IGEgc2xlZXAgc3Rh
dGUgb24gdHJhbnNtaXNzaW9uIHBpbnMgaW4gb3JkZXIgdG8gcHJldmVudCBiYWNrZmVlZGluZy4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2No
ZW5rZXJAdG9yYWRleC5jb20+DQo+ID4gLS0tDQo+IA0KPiBXaGF0IGFib3V0ICJBUk06IGR0czog
aW14NnFkbC1hcGFsaXM6ICIgZm9yIHRoZSBzdWJqZWN0Pw0KPiBUbyBiZSBjbGVhciB0aGF0IHRo
aXMgaXMgbm90IHJlbGF0ZWQgdG8gdGhlIGlteDYgU29DIGl0c2VsZi4NCg0KVGhhbmtzIGZvciB5
b3VyIGNvbW1lbnRzIE1pY2hhbCEgV2lsbCB0YWt0ZSB0aG9zZSBpbnRvIGFjY291bnQgZm9yIHYy
Lg0KDQo+IA0KPiA+ICAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1hcGFsaXMuZHRzaSB8IDI3
ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIxIGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDZxZGwtYXBhbGlzLmR0c2kNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZxZGwtYXBhbGlzLmR0c2kNCj4gPiBpbmRleCA3YzRhZDU0MWMzZjUuLjU5ZWQyZTRhMWZk
MSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWFwYWxpcy5kdHNp
DQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1hcGFsaXMuZHRzaQ0KPiA+IEBA
IC0xNDgsMTQgKzE0OCwxNiBAQA0KPiA+ICAgfTsNCj4gPiAgIA0KPiA+ICAgJmNhbjEgew0KPiA+
IC0JcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiAtCXBpbmN0cmwtMCA9IDwmcGluY3Ry
bF9mbGV4Y2FuMT47DQo+ID4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAic2xlZXAiOw0K
PiA+ICsJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZsZXhjYW4xX2RlZmF1bHQ+Ow0KPiA+ICsJcGlu
Y3RybC0xID0gPCZwaW5jdHJsX2ZsZXhjYW4xX3NsZWVwPjsNCj4gPiAgIAlzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KPiA+ICAgfTsNCj4gPiAgIA0KPiA+ICAgJmNhbjIgew0KPiA+IC0JcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IjsNCj4gPiAtCXBpbmN0cmwtMCA9IDwmcGluY3RybF9mbGV4Y2FuMj47
DQo+ID4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAic2xlZXAiOw0KPiA+ICsJcGluY3Ry
bC0wID0gPCZwaW5jdHJsX2ZsZXhjYW4yX2RlZmF1bHQ+Ow0KPiA+ICsJcGluY3RybC0xID0gPCZw
aW5jdHJsX2ZsZXhjYW4yX3NsZWVwPjsNCj4gPiAgIAlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+
ICAgfTsNCj4gPiAgIA0KPiA+IEBAIC01OTksMTkgKzYwMSwzMiBAQA0KPiA+ICAgCQk+Ow0KPiA+
ICAgCX07DQo+ID4gICANCj4gPiAtCXBpbmN0cmxfZmxleGNhbjE6IGZsZXhjYW4xZ3JwIHsNCj4g
PiArCXBpbmN0cmxfZmxleGNhbjFfZGVmYXVsdDogZmxleGNhbjFkZWZncnAgew0KPiA+ICAgCQlm
c2wscGlucyA9IDwNCj4gPiAgIAkJCU1YNlFETF9QQURfR1BJT183X19GTEVYQ0FOMV9UWCAweDFi
MGIwDQo+ID4gICAJCQlNWDZRRExfUEFEX0dQSU9fOF9fRkxFWENBTjFfUlggMHgxYjBiMA0KPiA+
ICAgCQk+Ow0KPiA+ICAgCX07DQo+ID4gICANCj4gPiAtCXBpbmN0cmxfZmxleGNhbjI6IGZsZXhj
YW4yZ3JwIHsNCj4gPiArCXBpbmN0cmxfZmxleGNhbjFfc2xlZXA6IGZsZXhjYW4xc2xwZ3JwIHsN
Cj4gPiArCQlmc2wscGlucyA9IDwNCj4gPiArCQkJTVg2UURMX1BBRF9HUElPXzdfX0dQSU8xX0lP
MDcgMHgwDQo+ID4gKwkJCU1YNlFETF9QQURfR1BJT184X19HUElPMV9JTzA4IDB4MA0KPiA+ICsJ
CT47DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiArCXBpbmN0cmxfZmxleGNhbjJfZGVmYXVsdDogZmxl
eGNhbjJkZWZncnAgew0KPiA+ICAgCQlmc2wscGlucyA9IDwNCj4gPiAgIAkJCU1YNlFETF9QQURf
S0VZX0NPTDRfX0ZMRVhDQU4yX1RYIDB4MWIwYjANCj4gPiAgIAkJCU1YNlFETF9QQURfS0VZX1JP
VzRfX0ZMRVhDQU4yX1JYIDB4MWIwYjANCj4gPiAgIAkJPjsNCj4gPiAgIAl9Ow0KPiA+ICsJcGlu
Y3RybF9mbGV4Y2FuMl9zbGVlcDogZmxleGNhbjJzbHBncnAgew0KPiA+ICsJCWZzbCxwaW5zID0g
PA0KPiA+ICsJCQlNWDZRRExfUEFEX0tFWV9DT0w0X19HUElPNF9JTzE0IDB4MA0KPiA+ICsJCQlN
WDZRRExfUEFEX0tFWV9ST1c0X19HUElPNF9JTzE1IDB4MA0KPiA+ICsJCT47DQo+ID4gKwl9Ow0K
PiA+ICAgDQo+ID4gICAJcGluY3RybF9ncGlvX2JsX29uOiBncGlvYmxvbiB7DQo+ID4gICAJCWZz
bCxwaW5zID0gPA0KPiA+IA0K
