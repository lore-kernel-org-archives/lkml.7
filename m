Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76148C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42379208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="EI7MkdMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407201AbfHIPAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:00:01 -0400
Received: from mail-eopbgr70131.outbound.protection.outlook.com ([40.107.7.131]:35780
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfHIPAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:00:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQcVRCkLSAuFQLbaHM6snOZegqWD+nddodcDdi6Pg5hX06e1QKm0cFXg2x5n0jFuhT/yK4vUc1IeTUgzARnsTiokV1mqzgCkPHX4HTgYdOL4K8WZjqvXX0uRZ+38o5FsTBj3zSpYzxynll+8EyZoDs3ZT91bK07Kg7Oz5cr9Wehr2pBqRPc80zYO5C0fYuxImkwjy28KKs37uXT2HdoqZ1fmn9KwbjHQvwyXgA6ZlJmpwiwvfq8Box8czP35cnL5gmW9sq5Cuzbu44EYJC3qwAnJYc8p2kAYBUc/4duaT03v67Ph6JkYgDPhHV6MaQyX8suWuPU2YPSyUD8F58In0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+b6PMlKnRVisR1vKPa8SKNWw0FeTK/r7KD9A+V2r1k=;
 b=En6LMLzr78IalpQw07bCBf4TQaMWjGTZ7SfPsKDtAmmPer4YvJrnCVMrXQOeTso9dQxKhw60liL6GUK8x5tgGyRgFODd3fYYyLpiiy9r1FMK9yPjHNrT9zzXzkY7o99/DaTiKHauE/FDUpBx5ewlvAEMBYtLHSBJRklGcx6RE1v6qED82gvJzVpuiqXP7monkNQjVhAlgBHfIoFvcok4PEBI1HTMHcOOqHZJB0Psaah1Fl/N2R+6EDgy9ckViK2Ob/oAjMVoBT4v99N2o2AvzyVotuIJmILYRPaiWQOpOqC8ae4Dks6MKUVQRi7hUeRkHR93p4wzDlN6YLwQ2MjhOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+b6PMlKnRVisR1vKPa8SKNWw0FeTK/r7KD9A+V2r1k=;
 b=EI7MkdMe6X9ZHtoDFM9V3jcYQS8LtrjGL0tXWi1sqq090pg59ytelCea3TgAIvJsI8GI5R1mie3Y6gyiXfls8+apGS/PfxGhG98JyA7Nrda1pM529kWEj3nWuea7ZrajmwXYoEri7dg8LIhZvICAH0bw/hRy8fT9RbG2af5xOwk=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB5647.eurprd05.prod.outlook.com (20.178.120.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Fri, 9 Aug 2019 14:59:55 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:59:55 +0000
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
Subject: Re: [PATCH v3 09/21] ARM: dts: imx6qdl-colibri: add phy to fec
Thread-Topic: [PATCH v3 09/21] ARM: dts: imx6qdl-colibri: add phy to fec
Thread-Index: AQHVTPnNvl5o8iwvx0yd87LjaXSUiqby7EAA
Date:   Fri, 9 Aug 2019 14:59:55 +0000
Message-ID: <061b910d01704f736654d8521be431c8aeb946e4.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-10-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-10-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f829bf70-c4fd-492e-f0e1-08d71cda3d67
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB5647;
x-ms-traffictypediagnostic: VI1PR05MB5647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5647B4B5BB7E615394D1881BFBD60@VI1PR05MB5647.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(189003)(199004)(53936002)(316002)(66946007)(6246003)(6436002)(86362001)(81166006)(81156014)(8676002)(4326008)(71190400001)(66446008)(229853002)(64756008)(7736002)(66476007)(305945005)(2201001)(91956017)(76116006)(36756003)(66556008)(6506007)(6486002)(102836004)(186003)(118296001)(110136005)(8936002)(76176011)(2616005)(71200400001)(11346002)(446003)(486006)(44832011)(476003)(14454004)(46003)(2501003)(54906003)(5660300002)(7416002)(6512007)(256004)(25786009)(2906002)(99286004)(478600001)(6116002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5647;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TxEKHtCJ1QTyWqWXsZ7SnPq2EakKc/gmDeTgMhEeS2Hft5SInOOk//suqR3Aasjpv1dg9UuPqHasON0Syb2k2hVYKdwLz3D6vyvd2wzkc1wmY5GrFscIISRUGD2NjH/FvhXJEdqN4MN9aUOUKFC3p/2wvU4OcRrxPWojMqNYh1CkjHyWRGGlzxFL/zgLmHJoY1MgmSTWw9vwDmCoICyz5YzZzjqXXYxIi+ryj00mZ2vfpdpENzqmwuFZtzmKjWhAF4Y7CvgT66ZRSbu3syaFk/Bxye1/nAMJW/9QsuT+dyVm7foIhLX3x+mBQtbkQsVBRQ4eBOT5vYQHFZUaC/fvIUgVu30tZs0gaoKbdRjLz7QvvmcSW8GmczGJdRgUB+CsFtZs6TvUjTQBpE7mG0uHKhIANhT7M+ZYKBWHGq2iV3M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <540785E97C23C84BA88E39C16542BC91@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f829bf70-c4fd-492e-f0e1-08d71cda3d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:59:55.3395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIOVn8BGUt3GXeTR7+JcXS7wsZaLztd3rnzBYK+vYW4QmQFuiwbGSnhLCc/VCIwO80WLkydISTdD0+hZ+ERfcDBCnLeOWehR6lQlAhOnds0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gQWRkIHRoZSBwaHktbm9kZSBhbmQgbWRpbyBidXMgdG8gdGhlIGZlYy1ub2RlLCByZXBy
ZXNlbnRlZCBhcyBpcyBvbg0KPiBoYXJkd2FyZS4NCj4gVGhpcyBjb21taXQgaW5jbHVkZXMgbWlj
cmVsLGxlZC1tb2RlIHRoYXQgaXMgc2V0IHRvIHRoZSBkZWZhdWx0DQo+IHZhbHVlLCBwcmVwYXJl
ZCBmb3Igc29tZW9uZSB3aG8gd2FudHMgdG8gY2hhbmdlIHRoaXMuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQoN
CkFja2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4N
Cg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgaW4gdjM6IE5vbmUNCj4gQ2hhbmdlcyBpbiB2MjogTm9u
ZQ0KPiANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNpIHwgMTEgKysr
KysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1jb2xpYnJpLmR0c2kNCj4gYi9hcmNo
L2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRzaQ0KPiBpbmRleCAxYmVhYzIyMjY2ZWQu
LjAxOWRkYTZiODhhZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1j
b2xpYnJpLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1jb2xpYnJpLmR0
c2kNCj4gQEAgLTE0MCw3ICsxNDAsMTggQEANCj4gIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQi
Ow0KPiAgCXBpbmN0cmwtMCA9IDwmcGluY3RybF9lbmV0PjsNCj4gIAlwaHktbW9kZSA9ICJybWlp
IjsNCj4gKwlwaHktaGFuZGxlID0gPCZldGhwaHk+Ow0KPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4g
Kw0KPiArCW1kaW8gew0KPiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJI3NpemUtY2Vs
bHMgPSA8MD47DQo+ICsNCj4gKwkJZXRocGh5OiBldGhlcm5ldC1waHlAMCB7DQo+ICsJCQlyZWcg
PSA8MD47DQo+ICsJCQltaWNyZWwsbGVkLW1vZGUgPSA8MD47DQo+ICsJCX07DQo+ICsJfTsNCj4g
IH07DQo+ICANCj4gICZoZG1pIHsNCg==
