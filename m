Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CA4C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8612077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="BJLyI6e6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfHPHJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:09:26 -0400
Received: from mail-eopbgr10113.outbound.protection.outlook.com ([40.107.1.113]:27522
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbfHPHJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:09:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhSvQA7guxXZYP9ivnQn4atf7+WnXUyPl/+D4avYEy9dAMKzmboRrT9kztGqAKTF5MYedtWHwIfNXxHizIGVIB5MT/gdNtubDxuZKEP35b2GdiAverR2rd42dmSUxTiQFJM08YVC+YxXqJR8oPGRgTSQONoV793pSkcncOASVOkbyuZH86H6LuSa0FOWiO7MK3s46heEWeujior6xrl1gtgG3IS98F8Yfxgy8ZzaXaT6ELt6bRaocNzGRSlr8dh7/P/a2yMuhhU7wf1BtsN0zvCYB3vVh/rV4zSmIEu0E/wYNpXfd0CNrTTtecQqCnA3gIIoCyyWRMHOi2jFi5EPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLopv+5YtNEuqcfOLgM6jvwCC8YeQ2bj143ACN4G8tw=;
 b=IfmdUI+G4NN7IyohzPi1KFEOwrI4HGfs+M/Hsm6rCNTrg1dFr/e0SsBpuZQjQQuL67voNWm0bENnVmEd8Lt0IewX5hDV8WU8yKI77a4A1vi8HGEXrq/PT/FknFJ9uafEx/V/zDIdLN+HDF9K9xZ9eKoa3bPuPagQovWuyklm4/tygAk5LjTtHSorHSScsH9OBdwGCyoOChm6tO1MZ+c0JWTu4a6J0CmcfqOKt8oMrN4eAQP0bXQw9bA//RRKOmohshXhqKH28JzMqqGlZhXL9/mGlQ0FtGX44FR+sJOtq1gvfLJQbKvVDQkmHJm18ME97ZLhFnr1VZoW0EWKROMcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLopv+5YtNEuqcfOLgM6jvwCC8YeQ2bj143ACN4G8tw=;
 b=BJLyI6e6lhFsCaFXmUh58vK60nkZs8qOhSH6tCF2pFL5IzAqNySzUe4rnc8+P/S+KnXFbjYoGX3eKsXIqfXO5ZIiJKr96dmBnUxynnYmYi1hY074qewVIogAi2M8XUVuoYoLXOs07sVWE9LUwWDfECbxufrsHMd4MbCs0eR3+zM=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB4445.eurprd05.prod.outlook.com (52.133.13.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 16 Aug 2019 07:09:21 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9%4]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 07:09:21 +0000
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
Subject: Re: [PATCH v4 14/21] ARM: dts: imx6ull-colibri: Add sleep mode to fec
Thread-Topic: [PATCH v4 14/21] ARM: dts: imx6ull-colibri: Add sleep mode to
 fec
Thread-Index: AQHVVAGG2BBV0pJUk0iRI1ivvE+e3Q==
Date:   Fri, 16 Aug 2019 07:09:20 +0000
Message-ID: <CAGgjyvHQt_Gp+Pm5VFabGHY5xGN4fU1Xv3inGRf9vmsRm3fQBQ@mail.gmail.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-15-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-15-philippe.schenker@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0141.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::46) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAVwXJX4Csp3HULZt4NYFHhSKWFB4WtmZRFDqMLdt3CyltYTAncc
        Ma6tRCM6NftChvKzmN144WkHPanp8/vC4vcCiFk=
x-google-smtp-source: APXvYqxDYNVnQFyOSiEWSjBvWNY3X26uXLGceSwB4VHrFvUgz42BXm1SECYlTknIrsNTkZvz3GWC3xeaA7I2ALcCCNY=
x-received: by 2002:a05:6402:789:: with SMTP id
 d9mr9154728edy.25.1565939359305; Fri, 16 Aug 2019 00:09:19 -0700 (PDT)
x-gmail-original-message-id: <CAGgjyvHQt_Gp+Pm5VFabGHY5xGN4fU1Xv3inGRf9vmsRm3fQBQ@mail.gmail.com>
x-originating-ip: [209.85.208.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d900bd6-bd4d-49ce-0df4-08d72218a885
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB4445;
x-ms-traffictypediagnostic: VI1PR05MB4445:
x-microsoft-antispam-prvs: <VI1PR05MB44451A7C17793C0521BA78A2F9AF0@VI1PR05MB4445.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(39840400004)(346002)(396003)(199004)(189003)(66066001)(305945005)(7736002)(6116002)(3846002)(5660300002)(2906002)(25786009)(61266001)(6246003)(107886003)(53936002)(229853002)(6636002)(86362001)(6862004)(450100002)(4326008)(55446002)(11346002)(446003)(498394004)(476003)(8936002)(61726006)(99286004)(95326003)(6436002)(81156014)(66946007)(9686003)(6512007)(81166006)(6486002)(14444005)(66476007)(256004)(14454004)(66446008)(66556008)(8676002)(64756008)(53546011)(26005)(186003)(6506007)(478600001)(386003)(102836004)(71190400001)(486006)(316002)(44832011)(54906003)(71200400001)(76176011)(52116002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4445;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OpqYVeyobIhHiNXvIwvvA7nuV8UFGViBUzgYHRH2IFVXEb3bWSDZtjo+R9+ro2QncNoKntI32BczFo9nVxBDThSFdnMOZyXSecmmP00hK94KAu/3u9M8BYU4YjUpjNE7CQ1CB16vKTL/dKHUQTkmdqldpmkNxa8MNKWKzofjjlheJhJAo6bgLqNa20rH5EF//n1Vsmn8O1m2KXl9ExXAlh6ND7Vi1lPfrni+Hmlso9gpgACIwFyenpRX3iOGEQZSFASlGVILfwlJSkGCDe9ViYH7gTejjKKlpw9p0r2UspsfDQ3HEKVHfovIbyTSYyflEF0iUIgH8zavopwJjJm+wReWjXcHieg6nsZSU5ibwMt8FDAkS6SR/fgsRw3zHfl6wEuBTvcC2/Dnfl9R3DE3unHi9Yi6eBvJNsGJOFLk5K0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <232A2A12B2265B46896FB815BEFBDFDC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d900bd6-bd4d-49ce-0df4-08d72218a885
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 07:09:20.0414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOxBWEYPkrHHiZHug2pwUxy4WVKLFyg74nZFsBmPva5lCvQOXOhNciTaWSPTCUABkXlfw6HuivHwd92yztGm5Ag77pFt8rAN1bwAZmK9YSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMTIsIDIwMTkgYXQgNToyMiBQTSBQaGlsaXBwZSBTY2hlbmtlcg0KPHBoaWxp
cHBlLnNjaGVua2VyQHRvcmFkZXguY29tPiB3cm90ZToNCj4NCj4gRG8gbm90IGNoYW5nZSB0aGUg
Y2xvY2sgYXMgdGhlIHBvd2VyIGZvciB0aGlzIHBoeSBpcyBzd2l0Y2hlZA0KPiB3aXRoIHRoYXQg
Y2xvY2suDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5z
Y2hlbmtlckB0b3JhZGV4LmNvbT4NCj4gQWNrZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2Vs
Lnppc3dpbGVyQHRvcmFkZXguY29tPg0KDQpSZXZpZXdlZC1ieTogT2xla3NhbmRyIFN1dm9yb3Yg
PG9sZWtzYW5kci5zdXZvcm92QHRvcmFkZXguY29tPg0KDQo+DQo+IC0tLQ0KPg0KPiBDaGFuZ2Vz
IGluIHY0Og0KPiAtIEFkZCBNYXJjZWwgWmlzd2lsZXIncyBBY2sNCj4NCj4gQ2hhbmdlcyBpbiB2
MzogTm9uZQ0KPiBDaGFuZ2VzIGluIHYyOiBOb25lDQo+DQo+ICBhcmNoL2FybS9ib290L2R0cy9p
bXg2dWxsLWNvbGlicmkuZHRzaSB8IDE4ICsrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpIGIvYXJjaC9hcm0vYm9vdC9k
dHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gaW5kZXggZDU2NzI4ZjAzYzM1Li4xMDE5Y2U2OWEy
NDIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNp
DQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpDQo+IEBAIC02
Miw4ICs2Miw5IEBADQo+ICB9Ow0KPg0KPiAgJmZlYzIgew0KPiAtICAgICAgIHBpbmN0cmwtbmFt
ZXMgPSAiZGVmYXVsdCI7DQo+ICsgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgInNs
ZWVwIjsNCj4gICAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZW5ldDI+Ow0KPiArICAgICAg
IHBpbmN0cmwtMSA9IDwmcGluY3RybF9lbmV0Ml9zbGVlcD47DQo+ICAgICAgICAgcGh5LW1vZGUg
PSAicm1paSI7DQo+ICAgICAgICAgcGh5LWhhbmRsZSA9IDwmZXRocGh5MT47DQo+ICAgICAgICAg
c3RhdHVzID0gIm9rYXkiOw0KPiBAQCAtMjIwLDYgKzIyMSwyMSBAQA0KPiAgICAgICAgICAgICAg
ICAgPjsNCj4gICAgICAgICB9Ow0KPg0KPiArICAgICAgIHBpbmN0cmxfZW5ldDJfc2xlZXA6IGVu
ZXQyc2xlZXBncnAgew0KPiArICAgICAgICAgICAgICAgZnNsLHBpbnMgPSA8DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIE1YNlVMX1BBRF9HUElPMV9JTzA2X19HUElPMV9JTzA2ICAgICAgICAw
eDANCj4gKyAgICAgICAgICAgICAgICAgICAgICAgTVg2VUxfUEFEX0dQSU8xX0lPMDdfX0dQSU8x
X0lPMDcgICAgICAgIDB4MA0KPiArICAgICAgICAgICAgICAgICAgICAgICBNWDZVTF9QQURfRU5F
VDJfUlhfREFUQTBfX0dQSU8yX0lPMDggICAgMHgwDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IE1YNlVMX1BBRF9FTkVUMl9SWF9EQVRBMV9fR1BJTzJfSU8wOSAgICAweDANCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgTVg2VUxfUEFEX0VORVQyX1JYX0VOX19HUElPMl9JTzEwICAgICAgIDB4
MA0KPiArICAgICAgICAgICAgICAgICAgICAgICBNWDZVTF9QQURfRU5FVDJfUlhfRVJfX0dQSU8y
X0lPMTUgICAgICAgMHgwDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIE1YNlVMX1BBRF9FTkVU
Ml9UWF9DTEtfX0VORVQyX1JFRl9DTEsyICAweDQwMDFiMDMxDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIE1YNlVMX1BBRF9FTkVUMl9UWF9EQVRBMF9fR1BJTzJfSU8xMSAgICAweDANCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgTVg2VUxfUEFEX0VORVQyX1RYX0RBVEExX19HUElPMl9JTzEy
ICAgIDB4MA0KPiArICAgICAgICAgICAgICAgICAgICAgICBNWDZVTF9QQURfRU5FVDJfVFhfRU5f
X0dQSU8yX0lPMTMgICAgICAgMHgwDQo+ICsgICAgICAgICAgICAgICA+Ow0KPiArICAgICAgIH07
DQo+ICsNCj4gICAgICAgICBwaW5jdHJsX2Vjc3BpMV9jczogZWNzcGkxLWNzLWdycCB7DQo+ICAg
ICAgICAgICAgICAgICBmc2wscGlucyA9IDwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgTVg2
VUxfUEFEX0xDRF9EQVRBMjFfX0dQSU8zX0lPMjYgICAgICAgIDB4MDAwYTANCj4gLS0NCj4gMi4y
Mi4wDQo+DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMNCk9sZWtzYW5kciBTdXZvcm92DQoNClRvcmFk
ZXggQUcNCkFsdHNhZ2Vuc3RyYXNzZSA1IHwgNjA0OCBIb3J3L0x1emVybiB8IFN3aXR6ZXJsYW5k
IHwgVDogKzQxIDQxIDUwMA0KNDgwMCAobWFpbiBsaW5lKQ0K
