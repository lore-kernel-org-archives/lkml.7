Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E75C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B366521744
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="VvaOODTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbfHOK7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 06:59:13 -0400
Received: from mail-eopbgr10094.outbound.protection.outlook.com ([40.107.1.94]:54688
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728128AbfHOK7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:59:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXvgTfVwDc639Wdfl2W6JIBzF1Ae4PHTWVlgkBz+/jhOKIp5NHB++vJzFpLUMWL3wIUzF1mcEOrwe0Ya+hbbjOMshiOXch/ER1x3RVddUrAm7Ngaqn0d55YO7k0WiU3DSPFdKnoBuvxWpF3D1D52bPx7yfseZZDcyfo8XvAzAKmYvMODxVdXvodLeOl8gL7RXXYK43YFJVwlsBW7Re0F4c3p5FeDW1N9laqULnlRM7fPDxCE5NAfot9/TQh0ZXScYQcmxYUtmIj3WatPzdPlrT1m1VI+9iOKknLFcJ3YBpVCljX2P9YIkcgtJNsw2txVqgDlFoAx8K5L+6P18eC5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRsitfbwK0K36D25sdakbwQbtkpudQhjDOvtF6V0ffo=;
 b=ZL0LTlH0ppa0Sf9Eq2PXxnjTWKzO9omHrOiqM17A6xwGmd+ZWpdgVVOyyYzjeeztA2eCXfUxcTLIEqbynw+uBj8bf0Ml+SWWgMkkapQSn83KOKNLAtav0yi6kpKdhN6x0CLPoQpWGUFYBV2Wd03M7OuZzDQZ49AuB+WCHxURON48GueBSEbTb80Zn4aQN7mPBXc8KhSVxDEFe+1tz3r7OOhoIkfT+Tx82E0k6OXBuyGeakBq2fJrlwQ1a7cXmUvwM6GlpVqLgWp/zjhYaITPcSP2QKT1fc4pMvEfSF4tFxjfXurRdO0bT78WcHCUIwH++MGR0Ra/kBruY2iCBLQ9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRsitfbwK0K36D25sdakbwQbtkpudQhjDOvtF6V0ffo=;
 b=VvaOODTBgB8CHyEsP8yhb1DYTYkM8lXVHvR0K4YszQ5pgrrv/FoZCC1sRzDxkLoKa2tirDiD5DymMtV2RhwBYsi9RHVEeH7Ilzf2Jjqtk2ddPQ0DrLHYx0+h6mI2Q/oHtGoM8fU6SOkjotQRDuwpXBputkwNOVN18cA+Lp7GyRk=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB6302.eurprd05.prod.outlook.com (20.179.24.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Thu, 15 Aug 2019 10:59:07 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9%4]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 10:59:08 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 08/21] ARM: dts: imx7-colibri: Add touch controllers
Thread-Topic: [PATCH v4 08/21] ARM: dts: imx7-colibri: Add touch controllers
Thread-Index: AQHVU1d6YDs6uEjrfUCEF/Tm2eBgmA==
Date:   Thu, 15 Aug 2019 10:59:08 +0000
Message-ID: <CAGgjyvEGqZ5qKeN9rOUQDWbb7X=LbeTAU4s01t18+B396Df_Lg@mail.gmail.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-9-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-9-philippe.schenker@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR05CA0010.eurprd05.prod.outlook.com
 (2603:10a6:208:55::23) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAW6UmNzEBbVbaNL1jEkksarigUOHOMgP8jd7MkUvjwBAGQeRBj4
        GIFcmA14TP5jikcNXO1ver8J317PNzzRR6d3LWI=
x-google-smtp-source: APXvYqxXU/DoVkHZl/unq6MdVzWMCMOBvcZfOeFbwI0z5dOks1Dbqwdq7qHumDr3cQb52horwaR08JClzPSVWCa3cU0=
x-received: by 2002:a17:906:9453:: with SMTP id
 z19mr3801902ejx.287.1565866337952; Thu, 15 Aug 2019 03:52:17 -0700 (PDT)
x-gmail-original-message-id: <CAGgjyvEGqZ5qKeN9rOUQDWbb7X=LbeTAU4s01t18+B396Df_Lg@mail.gmail.com>
x-originating-ip: [209.85.208.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b86532bb-83ec-46e4-50af-08d7216f98ab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB6302;
x-ms-traffictypediagnostic: VI1PR05MB6302:
x-microsoft-antispam-prvs: <VI1PR05MB630298421603EB166274EF36F9AC0@VI1PR05MB6302.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:308;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(7736002)(61266001)(14444005)(8676002)(6436002)(55446002)(53546011)(81166006)(446003)(256004)(53936002)(386003)(61726006)(476003)(107886003)(54906003)(81156014)(486006)(102836004)(9686003)(5660300002)(6512007)(6486002)(186003)(11346002)(498394004)(26005)(76176011)(52116002)(2906002)(229853002)(305945005)(6246003)(66476007)(478600001)(316002)(6862004)(66946007)(3846002)(6506007)(66446008)(66556008)(86362001)(8936002)(6116002)(64756008)(4326008)(14454004)(44832011)(99286004)(71200400001)(66066001)(71190400001)(95326003)(6636002)(25786009)(450100002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6302;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oJhHmcN98EAnp6JjL639UvYdITz8suSkPrAR0SERpre7t3JxFADCFY2MSFhYLqUtV4od8yNc0dZUFqpiowV89XTiYmZyZ6PM3MMCKtK3CXnt7crWmrggUccYXO6te3toixBl6E5V12QR2Xt6tyK/pv0sdR5Ta4vT//UA2Lrce926UvdKxFmjaaHe0NQW237BLzoEvpDIINhpRWjVwRTxTr5f08U5oi4NMUtRakUXsvCJd/PL8OLUGtpO/ICG3yU3D6EqQW5DKLuvYc1Cfa3FkpVoRkOeMQukByIT8xn7/vQygyJpfMMEa3jzM7gdhXRES1R/AhPJznmufrsPie7ESa6QaIw/u0DkoQXKhWKXuNtTZT3Au3JOqBHKmux8pLq6VADsAHm8Li9WenFAv/hv6xozS8M3PxkbUKUbSepAxh4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <393B1BC6C6CD904A94281B526D975330@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86532bb-83ec-46e4-50af-08d7216f98ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 10:59:08.4344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXxiPvd77EtQIF0sqISPCkh9oRc2fgtdAlZGhnFfu7xuGUF8U7pAGIDTULUayciOzrFdQ52QulfrrseGlrGyIFTWenVdY79NSZgwxRpfYvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMTIsIDIwMTkgYXQgNToyMyBQTSBQaGlsaXBwZSBTY2hlbmtlcg0KPHBoaWxp
cHBlLnNjaGVua2VyQHRvcmFkZXguY29tPiB3cm90ZToNCj4NCj4gQWRkIHRvdWNoIGNvbnRyb2xs
ZXIgdGhhdCBpcyBjb25uZWN0ZWQgb3ZlciBhbiBJMkMgYnVzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQo+IEFj
a2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IE9sZWtzYW5kciBTdXZvcm92IDxvbGVrc2FuZHIuc3V2b3JvdkB0b3JhZGV4
LmNvbT4NCg0KPg0KPiAtLS0NCj4NCj4gQ2hhbmdlcyBpbiB2NDoNCj4gLSBBZGQgTWFyY2VsIFpp
c3dpbGVyJ3MgQWNrDQo+DQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gRml4IGNvbW1pdCBtZXNzYWdl
DQo+DQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gRGVsZXRlZCB0b3VjaHJldm9sdXRpb24gZG93bnN0
cmVhbSBzdHVmZg0KPiAtIFVzZSBnZW5lcmljIG5vZGUgbmFtZQ0KPiAtIEJldHRlciBjb21tZW50
DQo+DQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmktZXZhbC12My5kdHNpIHwgMjQg
KysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygr
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwt
djMuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0c2kNCj4g
aW5kZXggZDRkYmM0ZmMxYWRmLi41NzZkZWM5ZmY4MWMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9v
dC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KPiBAQCAtMTQ1LDYgKzE0NSwyMSBAQA0K
PiAgJmkyYzQgew0KPiAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4NCj4gKyAgICAgICAvKg0K
PiArICAgICAgICAqIFRvdWNoc2NyZWVuIGlzIHVzaW5nIFNPRElNTSAyOC8zMCwgYWxzbyB1c2Vk
IGZvciBQV008Qj4sIFBXTTxDPiwNCj4gKyAgICAgICAgKiBha2EgcHdtMiwgcHdtMy4gc28gaWYg
eW91IGVuYWJsZSB0b3VjaHNjcmVlbiwgZGlzYWJsZSB0aGUgcHdtcw0KPiArICAgICAgICAqLw0K
PiArICAgICAgIHRvdWNoc2NyZWVuQDRhIHsNCj4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAiYXRtZWwsbWF4dG91Y2giOw0KPiArICAgICAgICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJk
ZWZhdWx0IjsNCj4gKyAgICAgICAgICAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF9ncGlvdG91
Y2g+Ow0KPiArICAgICAgICAgICAgICAgcmVnID0gPDB4NGE+Ow0KPiArICAgICAgICAgICAgICAg
aW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzE+Ow0KPiArICAgICAgICAgICAgICAgaW50ZXJydXB0
cyA9IDw5IElSUV9UWVBFX0VER0VfRkFMTElORz47ICAgICAgICAgLyogU09ESU1NIDI4ICovDQo+
ICsgICAgICAgICAgICAgICByZXNldC1ncGlvcyA9IDwmZ3BpbzEgMTAgR1BJT19BQ1RJVkVfSElH
SD47ICAgICAvKiBTT0RJTU0gMzAgKi8NCj4gKyAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNh
YmxlZCI7DQo+ICsgICAgICAgfTsNCj4gKw0KPiAgICAgICAgIC8qIE00MVQwTTYgcmVhbCB0aW1l
IGNsb2NrIG9uIGNhcnJpZXIgYm9hcmQgKi8NCj4gICAgICAgICBydGM6IG00MXQwbTZANjggew0K
PiAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzdCxtNDF0MCI7DQo+IEBAIC0yMDAsMyAr
MjE1LDEyIEBADQo+ICAgICAgICAgdm1tYy1zdXBwbHkgPSA8JnJlZ18zdjM+Ow0KPiAgICAgICAg
IHN0YXR1cyA9ICJva2F5IjsNCj4gIH07DQo+ICsNCj4gKyZpb211eGMgew0KPiArICAgICAgIHBp
bmN0cmxfZ3Bpb3RvdWNoOiB0b3VjaGdwaW9zIHsNCj4gKyAgICAgICAgICAgICAgIGZzbCxwaW5z
ID0gPA0KPiArICAgICAgICAgICAgICAgICAgICAgICBNWDdEX1BBRF9HUElPMV9JTzA5X19HUElP
MV9JTzkgICAgICAgICAgMHg3NA0KPiArICAgICAgICAgICAgICAgICAgICAgICBNWDdEX1BBRF9H
UElPMV9JTzEwX19HUElPMV9JTzEwICAgICAgICAgMHgxNA0KPiArICAgICAgICAgICAgICAgPjsN
Cj4gKyAgICAgICB9Ow0KPiArfTsNCj4gLS0NCj4gMi4yMi4wDQo+DQoNCg0KLS0gDQpCZXN0IHJl
Z2FyZHMNCk9sZWtzYW5kciBTdXZvcm92DQoNClRvcmFkZXggQUcNCkFsdHNhZ2Vuc3RyYXNzZSA1
IHwgNjA0OCBIb3J3L0x1emVybiB8IFN3aXR6ZXJsYW5kIHwgVDogKzQxIDQxIDUwMA0KNDgwMCAo
bWFpbiBsaW5lKQ0K
