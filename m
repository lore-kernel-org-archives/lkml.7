Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A90FC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFA7208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="XTfDr7+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436811AbfHIPnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:43:19 -0400
Received: from mail-eopbgr30133.outbound.protection.outlook.com ([40.107.3.133]:56387
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436646AbfHIPnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:43:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLLVC7nmStCxQTjdNrdGQ8UfwMzx8OAjpMHeDTqUMcwYgXvd0Qo112b+OoBu+XzH8+BCfljhyMXkx9bp5xpJIf6UBlQ3J/nm36RW8KDL8crIgMh7Liqb1Aew8QJDestS0ljodWxnGz/p+K4JxyEZ9ckjaNoB0eBnkZhHUvVIkKB5fDeab+Cw+EVyUSfhnG3fFOK1NGnL+tQJZd94/iOVCraQLL2L1jJkcZYWNIdTdVW40SrRlHT2kij0M3NEciH+OWYf6KHpj0gNTWnDDg/jErGkYgRxFDzM29JXVNGxGMnPdraSR0Voc46XX8noMJ+9Uh/smdX6v+OexLsw2ayQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4y1JdZ9/yl0cE7140GCL8o8T5/ImPXruaQp1egAGZQ=;
 b=N2Fu+sW7467UaFvdB94YYGvSOAOc8yByVej4BUY4ao8qZF8LY/LUq3Z2fZUfMQWqrfPNVWYGGh94nXbgHxTjqLxlx70Imnp335i6FYQs7jMjEWF/Cpu14w56IHiy6Y6NIVjITCm6bLkHBpfAHOH2aRKOcj8dC/QOe6T+lKykncrr+yeCR4QOPknounduCAiHWS4DktDAOx3IzsPjCES/sD/hQ3/DKqqq162fHBx+boUz0GHYPEFlHOqadRx6DxV9NtSRkM4wbPQUfU4M5hAXVvnsTpTESMJ+CZH+fo4kCmBIxcHR0YyFNABzV7ldbz8CSB091OlKL8emuBJB0rqZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4y1JdZ9/yl0cE7140GCL8o8T5/ImPXruaQp1egAGZQ=;
 b=XTfDr7+JxZ0iVbrljub9x+UutPNJcl8vh661E9+UVwcM1eaCwvR+R7/AEimLvW3RGjUBylD18/EaR5jMulFQ2rZABn8Onfz+rl3Ov3RwmQDdSZwib7T2OSJCHC0hxGT1Ri/fEAQMN9BZ1SUWkWLY41XjzWxdbm7wCxBMjqMjzqo=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB5823.eurprd05.prod.outlook.com (20.178.122.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Fri, 9 Aug 2019 15:43:13 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 15:43:13 +0000
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
Subject: Re: [PATCH v3 16/21] ARM: dts: imx6ull-colibri: Add watchdog
Thread-Topic: [PATCH v3 16/21] ARM: dts: imx6ull-colibri: Add watchdog
Thread-Index: AQHVTPnV79tSXC+1fEesojD6I0AgYaby+FkA
Date:   Fri, 9 Aug 2019 15:43:13 +0000
Message-ID: <1012c9f70373cb4f87f75d8c636029f0871e55c9.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-17-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-17-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6558519a-f369-4161-6e61-08d71ce049d5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB5823;
x-ms-traffictypediagnostic: VI1PR05MB5823:
x-microsoft-antispam-prvs: <VI1PR05MB58237FA01D0BD9842349ED8EFBD60@VI1PR05MB5823.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(478600001)(66446008)(2201001)(81156014)(36756003)(46003)(2501003)(446003)(86362001)(7416002)(14454004)(25786009)(8676002)(118296001)(6246003)(99286004)(6116002)(8936002)(81166006)(66556008)(66946007)(76176011)(66476007)(64756008)(6506007)(229853002)(71190400001)(305945005)(110136005)(76116006)(102836004)(53936002)(6486002)(6512007)(91956017)(2906002)(6436002)(11346002)(486006)(476003)(44832011)(4326008)(256004)(71200400001)(54906003)(5660300002)(2616005)(7736002)(186003)(316002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5823;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qhSPlkvEBFZLCmenbUFLM7zdKVG5fH6f90mC0m6bhePP1SwWXd/6Z4W/9gDRbZEZBib+RDBh+S4TLCqIaAJ1EC8Ymul6Ioq4lbNCIJU9xdBYbHurHUz1ddoFlfOlbhFVm90lz7+J6Te4VDfkmsI/Iyc0Oja8E4cZP7j5moaB+SqFYFMhWcFhfw8i5HXwfRXcaNkD3T5OQu6bB7DEzGayxuh4Sr2DKWn0jldg9RNQUthnJQczqZI+F2AHVOYl+NICnxWla4L57g1rC7GQP2Uq6WnGCAU/+V3aXTDyjxL2cIcr563uX8SEMP2NMaUqkH50efyUpTZU4gGo6DKN6H/Khhme6vitnFy+VKzNRYMU7ZA2eYy8ExjNaynycQI7SB/vHEO2dmWzYMS0VmbDpfQ4KDHjxApz3s8rKRZSF9YOF7s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EEF78776F113A40AA7D891B9AAA5C6C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6558519a-f369-4161-6e61-08d71ce049d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 15:43:13.2201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VWYWJXtxSSsaiB2lnaORjIAY2pdTTR//YDKYrHmZngsGlAK4A2sOTngC7grtKK5PihpFztsb9/+xGJ8/tSjLeveceE2VXwBtEldoroq4Tes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gVGhpcyBwYXRjaCBhZGRzIHRoZSB3YXRjaGRvZyB0byB0aGUgaW14NnVsbC1jb2xpYnJp
IGRldmljZXRyZWUNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGls
aXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4NCg0KQWNrZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8
bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KDQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2
MzogTm9uZQ0KPiBDaGFuZ2VzIGluIHYyOiBOb25lDQo+IA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnVsbC1jb2xpYnJpLmR0c2kgfCAxMiArKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGli
cmkuZHRzaQ0KPiBpbmRleCAxZjExMmVjNTVlNWMuLmUzMjIwMjk4ZGQ2ZiAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gKysrIGIvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gQEAgLTE5OSw2ICsxOTksMTIgQEAN
Cj4gIAlhc3NpZ25lZC1jbG9jay1yYXRlcyA9IDwwPiwgPDE5ODAwMDAwMD47DQo+ICB9Ow0KPiAg
DQo+ICsmd2RvZzEgew0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJcGluY3Ry
bC0wID0gPCZwaW5jdHJsX3dkb2c+Ow0KPiArCWZzbCxleHQtcmVzZXQtb3V0cHV0Ow0KPiArfTsN
Cj4gKw0KPiAgJmlvbXV4YyB7DQo+ICAJcGluY3RybF9jYW5faW50OiBjYW5pbnQtZ3JwIHsNCj4g
IAkJZnNsLHBpbnMgPSA8DQo+IEBAIC01MDYsNiArNTEyLDEyIEBADQo+ICAJCQlNWDZVTF9QQURf
R1BJTzFfSU8wM19fT1NDMzJLXzMyS19PVVQJMHgxNA0KPiAgCQk+Ow0KPiAgCX07DQo+ICsNCj4g
KwlwaW5jdHJsX3dkb2c6IHdkb2ctZ3JwIHsNCj4gKwkJZnNsLHBpbnMgPSA8DQo+ICsJCQlNWDZV
TF9QQURfTENEX1JFU0VUX19XRE9HMV9XRE9HX0FOWSAgICAweDMwYjANCj4gKwkJPjsNCj4gKwl9
Ow0KPiAgfTsNCj4gIA0KPiAgJmlvbXV4Y19zbnZzIHsNCg==
