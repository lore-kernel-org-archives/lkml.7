Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6671C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5EB2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="UvBVcdmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436856AbfHIP4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:56:37 -0400
Received: from mail-eopbgr130108.outbound.protection.outlook.com ([40.107.13.108]:17569
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406394AbfHIP4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:56:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpS2M7XOdNqVXsgp0GlRnE0KfML1GroeJcj0+56i0BA9mLg3brD2ViXmxIjeo+Taks9aEm2jaS/F2uUFXzoKWJs+9DugFPBTAN/+5nhBO8zD9hMDrP23bqvd4eK+dihPf0e68w3QplwHESH4adx4vq43s1cwiarwt+NBNvcp9PWB2qG0ePoeqdG5Mwt1f6Nh7auKfdRHjqoJ2KWXIHwcc3ncL1Jxj7q8cV5JnmDJtz5lAF/aN1l/mmZkjGHc4vC7g0+P057vNbKGugI7UwRd7xmVX7D2mNXqNibXaCDUXelboXjneKpOFmFOemyhcHl+1RpPF+30dJDW9KrI1piELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GxijHg1RImng/GGNgVAKjxuEE7GYPKDx4BXqZba51o=;
 b=N1L8duGhI3fJ9XTopmOqd6ad/ChZX4CGlSPyTpmERiA7xMf72SIDsNyMYnmwSrhVBXPrOs42/sz8lUrxU1TM0N4kTa7zXrKrtRM7M4W79PCTtvmCKyDhYGzBz+O1hluqSTBdYoF90QQUBCsq996XfU3veFWsI1XbgyfGYYGEXe5NgM8l3TMk/BzWL37sCnsyPkOFcGw1G/RB6axfu8qFehqakfK6ZIFfrjBoabmX6HCipeIABs5vwc74E6L4k9e5Do+74hSuAzhQk5UN6Ne7+FmXFyjmh1nrw0+8keotKS9gdyWeBpeB8mChuWY8ushdEpk0LxocoRKGuEEigynOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GxijHg1RImng/GGNgVAKjxuEE7GYPKDx4BXqZba51o=;
 b=UvBVcdmzfQlm7SQrkW90BUzOiEBFDugIq4swCXzmdCRRD6Avsa4h1pdLoPTzQ7DdrnuIje/qv3M3srq9+/05BkmJEjDP0If9+E5VpPWi1DwXYAZaH1D27aTVVLAE4mpU7CAa2+T7TyBgPDatSBLhQLIY0P9mj/i4wgd1PNbQeRc=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB6752.eurprd05.prod.outlook.com (10.186.160.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Fri, 9 Aug 2019 15:56:33 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 15:56:33 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 21/21] ARM: dts: imx7-colibri: Add UHS support to eval
 board
Thread-Topic: [PATCH v3 21/21] ARM: dts: imx7-colibri: Add UHS support to eval
 board
Thread-Index: AQHVTPncmFS3dEmGc0GmkSQDT7oboKby/BMA
Date:   Fri, 9 Aug 2019 15:56:32 +0000
Message-ID: <8e910a22de1ac80f60209c2a4b2031f41c3412b2.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-22-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-22-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0aef483c-739a-4889-9823-08d71ce22688
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB6752;
x-ms-traffictypediagnostic: VI1PR05MB6752:
x-microsoft-antispam-prvs: <VI1PR05MB67526DEB9520A7D422AE40F3FBD60@VI1PR05MB6752.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39850400004)(366004)(346002)(136003)(396003)(189003)(199004)(99286004)(2906002)(478600001)(316002)(71190400001)(305945005)(2201001)(5660300002)(110136005)(118296001)(54906003)(7736002)(64756008)(66946007)(66556008)(66446008)(229853002)(6512007)(66476007)(6486002)(53936002)(6436002)(36756003)(256004)(14444005)(71200400001)(91956017)(76116006)(6506007)(186003)(86362001)(102836004)(4326008)(76176011)(2501003)(446003)(25786009)(6116002)(14454004)(6246003)(46003)(44832011)(11346002)(2616005)(476003)(486006)(7416002)(8936002)(81166006)(8676002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6752;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1lHMwmordATfUO8LOWe8zl8hk3NHNS6fbdy/q8vqRfqL3QiOTEGnvw7Bo881hZMxiHZ0QR1IuMyG0PkWhzNKVxWk/drQ6x+S4mqlx/dEZ/Z206sV4PGl3VorGh3MTcZ4hANd/rc+iXfgqHvcQV0uG4JjuLaj/shbw8ggp9ahI/6+biFnS4LzvXi5Z7YqKEnPbJtk+5FJWsEexnsEeX3OuLcJN5lpEKSNxwJgFHsE0XuCLj0xBFSDQtItGCVrT1vw9QfsV1Nr0UNQAC7tP7+BILisffmydI8/bdIHi1gijVnGk3rX8kdVmXtkzv0HKLwrI3wxU1brhzNbYqPMXfSq85cv4RoIU+OTfDNKozfaY0+dBfjJB4UQm8LnwuoZonpDKiZKKA8PH/e0Fo2JaNuhtJcHOhALlG2LytUG6YGhpMU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB385BDA23BF814FBB3A01FFBD7521FE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aef483c-739a-4889-9823-08d71ce22688
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 15:56:32.9458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBQV/NlohUqKIDrWAdZzd16PNtOBEYiW1ywM7yhrOkQcO6yXNKOqTYN6lb0YkXkD3HTQvM8tltNEsbl/wpMW079Ps4daK/vwCb/pO1BGnm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcGUNCg0KT24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBw
ZSBTY2hlbmtlciB3cm90ZToNCj4gVGhpcyBjb21taXQgYWRkcyBVSFMgY2FwYWJpbGl0eSB0byBU
b3JhZGV4IEV2YWwgQm9hcmRzDQoNCkhvdyBhYm91dCBhbnkgb3RoZXIgY2FycmllciBib2FyZD8N
Cg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJA
dG9yYWRleC5jb20+DQo+IA0KPiAtLS0NCj4gDQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gTmV3IHBh
dGNoIHRvIG1ha2UgdXNlIG9mIEFSTTogZHRzOiBpbXg3LWNvbGlicmk6IGZpeCAxLjhWL1VIUw0K
PiBzdXBwb3J0DQo+IA0KPiBDaGFuZ2VzIGluIHYyOiBOb25lDQo+IA0KPiAgYXJjaC9hcm0vYm9v
dC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaSB8IDExICsrKysrKysrKy0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0c2kNCj4gYi9h
cmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmktZXZhbC12My5kdHNpDQo+IGluZGV4IDU3NmRl
YzlmZjgxYy4uOTAxMjFmYmU1NjFmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9p
bXg3LWNvbGlicmktZXZhbC12My5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDct
Y29saWJyaS1ldmFsLXYzLmR0c2kNCj4gQEAgLTIxMCw5ICsyMTAsMTYgQEANCj4gIH07DQo+ICAN
Cj4gICZ1c2RoYzEgew0KPiAtCWtlZXAtcG93ZXItaW4tc3VzcGVuZDsNCj4gLQl3YWtldXAtc291
cmNlOw0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzdGF0ZV8xMDBtaHoiLCAic3Rh
dGVfMjAwbWh6IjsNCj4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfdXNkaGMxICZwaW5jdHJsX2Nk
X3VzZGhjMT47DQo+ICsJcGluY3RybC0xID0gPCZwaW5jdHJsX3VzZGhjMV8xMDBtaHogJnBpbmN0
cmxfY2RfdXNkaGMxPjsNCj4gKwlwaW5jdHJsLTIgPSA8JnBpbmN0cmxfdXNkaGMxXzIwMG1oeiAm
cGluY3RybF9jZF91c2RoYzE+Ow0KPiAgCXZtbWMtc3VwcGx5ID0gPCZyZWdfM3YzPjsNCj4gKwl2
cW1tYy1zdXBwbHkgPSA8JnJlZ19MRE8yPjsNCj4gKwljZC1ncGlvcyA9IDwmZ3BpbzEgMCBHUElP
X0FDVElWRV9MT1c+Ow0KPiArCWRpc2FibGUtd3A7DQo+ICsJZW5hYmxlLXNkaW8td2FrZXVwOw0K
PiArCWtlZXAtcG93ZXItaW4tc3VzcGVuZDsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICB9Ow0K
PiAgDQo+IC0tIA0KPiAyLjIyLjANCg0KQ2hlZXJzDQoNCk1hcmNlbA0K
