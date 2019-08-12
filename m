Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23DDC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B3C20820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="uHoxQaDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfHLIvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:51:02 -0400
Received: from mail-eopbgr30096.outbound.protection.outlook.com ([40.107.3.96]:38373
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727017AbfHLIvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:51:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku/J0ds0a4PyLckG6FFPVp4WtQ7KG7XoAjGROln4WP4Y5FdpwSLykxl7U/uEvvxOK6klzK8O78AatS8Jx3URNhzzd2dCsspMUEAkhI2LXwOVGsLOZI4twuo8gRS+LB9P1AQTefRYYEACcmkO663JpzUBKORYPn1meza/4T/WAgvpCTI4Ek8yvALSQgjRrzh1iH48FM0gNV2abWu1ZG2CTbZhmwgESiyTwmmat+v6qMPSqHSPzUdgORp43ZpZWvnVNwdBB5Az0ERLhukH54jU44wksgAamEkOYZDhqEZCYbd9JAaIcbUz5ErbqJhoxan2eqY59M062orXviAHy4S4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOhibu6xEanOtkoR1moDXTu7acU984OLeVavohygIhw=;
 b=FwMX49XMfnUH0zOhD019u0qV1xvN/4OghtSL8228Nvty+XaUvUOkJPO8bStUEVEn6RunKu6vDyLymwdT9UoHflbi5d4NAUQOdo0kecmkeN0wRgXEYrSTv01+RCUjQ1I0y52n+/QJ6BZwOMhvjJZEsuHdnUO7/meSDM3Xy3REQcX6c9az1uKX5yb95fXsEKM5nfwOdGtz90ZgrljudpaCsaaGppiW1nq7B8E2OCCQi/CciEWlbMnA4qYCvDdIm1hQyiSHg1qLcltfWN6z+Pk942tqefcAsuh6FIHgmc4ed5beCbNIW2RmcLtDapDQGk3JTNzGNYf9k/q9vZhjfhysIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOhibu6xEanOtkoR1moDXTu7acU984OLeVavohygIhw=;
 b=uHoxQaDZcyZ0cv+mkSWnYR+q2ZXqA0eXvAWrQavTZznRUn0KRfTFwtD2fgtgcdI26+m+bQ7AQN58SzvH4phWS1Cd1hdcg0QkrOgS5qbCj8wq+PXqoNFRnfKPtO86/lfltISeIepLJxRVeVeJH6OwxP4bBpOAUccy/0Vr0ckKco8=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2879.eurprd05.prod.outlook.com (10.172.255.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Mon, 12 Aug 2019 08:50:17 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 08:50:17 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "git@andred.net" <git@andred.net>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx7d: sbc-iot-imx7: add recovery for i2c3/4
Thread-Topic: [PATCH] ARM: dts: imx7d: sbc-iot-imx7: add recovery for i2c3/4
Thread-Index: AQHVT8bJ2A+rECE7DUKJu1AKyiMjFqb3Nl4A
Date:   Mon, 12 Aug 2019 08:50:17 +0000
Message-ID: <5b59f3c2b78eaf717885fa005158a0e8a6c51591.camel@toradex.com>
References: <20190807082556.5013-6-philippe.schenker@toradex.com>
         <20190810215817.5118-1-git@andred.net>
In-Reply-To: <20190810215817.5118-1-git@andred.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4089134b-10dd-48e3-f4a3-08d71f02199b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0502MB2879;
x-ms-traffictypediagnostic: VI1PR0502MB2879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2879EB0E514377482F714BFDF4D30@VI1PR0502MB2879.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39840400004)(366004)(376002)(346002)(189003)(199004)(5660300002)(446003)(6506007)(14444005)(66066001)(6916009)(6512007)(6486002)(478600001)(6436002)(4326008)(256004)(66476007)(66556008)(64756008)(66446008)(7416002)(486006)(25786009)(14454004)(2351001)(11346002)(76116006)(476003)(44832011)(91956017)(66946007)(36756003)(316002)(2616005)(53936002)(71200400001)(71190400001)(118296001)(305945005)(7736002)(76176011)(186003)(54906003)(81166006)(81156014)(2501003)(99286004)(1730700003)(8676002)(102836004)(8936002)(229853002)(26005)(6246003)(6116002)(3846002)(2906002)(5640700003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2879;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LS4PssZoDsuXTlnkySFKCWVVSLTqGpZLYh1Y49+b6RfbELMTvjwAYJsshvlaMvYsViExvfmOIb2PIuWkRnkAY/ZyhMPeYV/+hT91v6eJ42xnjpmKvTlwtH51S5dxBMze/xrVBCpe8PY5dtwN6BV2MvjieNZpXu4hkoiEWXprcqObYVpyADUhBoPJ35CwGLNJf6+1in2SYA3TR1G18B/bEheuxLK1vILOWaZFDP8rJRJcdaK4vEiXrzCRvvpcPDQn5ItKTH3pITfM0aOWhs7C6hhZEbjdfFGIfmNIyJRiaTx+iDLHkVSycCfHlC5jsn/C/Y9adwN0+oCWKNJpCEh0S/n8CNgEfq9R2cmdq3cPVvYv2A727ZPOkktO6E8M7NWHjfaNFeAMsxrVctRoBRTf7GqMh3+zraS5S5uaVaTruDw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4650A38930A7543B5311F4BB78928C8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4089134b-10dd-48e3-f4a3-08d71f02199b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 08:50:17.3462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LMJSDV/AqGeJ7IOJRUnpvpJ0jULBO/To2NC9RPFf6nmQ5VN6xYH9f4braxnqu3We8xgJHLErKKuUqlFNRi7uEd2Iiv3XgovNvQWWN4avyWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDE5LTA4LTEwIGF0IDIyOjU4ICswMTAwLCBBbmRyw6kgRHJhc3ppayB3cm90ZToN
Cj4gT24gV2VkLCAwNyBBdWcgMjAxOSAwODoyNjoxNSArMDAwMCwgUGhpbGlwcGUgU2NoZW5rZXIg
d3JvdGU6DQo+ID4gRnJvbTogT2xla3NhbmRyIFN1dm9yb3YgPG9sZWtzYW5kci5zdXZvcm92QHRv
cmFkZXguY29tPg0KPiA+IA0KPiA+IC0gYWRkIHJlY292ZXJ5IG1vZGUgZm9yIGFwcGxpY2FibGUg
aTJjIGJ1c2VzIGZvcg0KPiA+ICAgQ29saWJyaSBpTVg3IG1vZHVsZS4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBPbGVrc2FuZHIgU3V2b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVu
a2VyQHRvcmFkZXguY29tPg0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjM6IE5vbmUN
Cj4gPiBDaGFuZ2VzIGluIHYyOiBOb25lDQo+ID4gDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lt
eDctY29saWJyaS5kdHNpIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kNCj4gPiBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpDQo+ID4gaW5kZXggYThkOTkyZjNlODk3
Li4yNDgwNjIzYzkyZmYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1j
b2xpYnJpLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRz
aQ0KPiA+IEBAIC0xNDAsOCArMTQwLDEyIEBADQo+ID4gDQo+ID4gICZpMmMxIHsNCj4gPiAgCWNs
b2NrLWZyZXF1ZW5jeSA9IDwxMDAwMDA+Ow0KPiA+IC0JcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0
IjsNCj4gPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJncGlvIjsNCj4gPiAgCXBpbmN0
cmwtMCA9IDwmcGluY3RybF9pMmMxICZwaW5jdHJsX2kyYzFfaW50PjsNCj4gPiArCXBpbmN0cmwt
MSA9IDwmcGluY3RybF9pMmMxX3JlY292ZXJ5ICZwaW5jdHJsX2kyYzFfaW50PjsNCj4gPiArCXNj
bC1ncGlvcyA9IDwmZ3BpbzEgNCBHUElPX0FDVElWRV9ISUdIPjsNCj4gDQo+IHNjbC1ncGlvcyBz
aG91bGQgYmUgKEdQSU9fQUNUSVZFX0hJR0ggfCBHUElPX09QRU5fRFJBSU4pIHNpbmNlDQo+IGNv
bW1pdCBkMmQwYWQyYWVjNGEgKCJpMmM6IGlteDogdXNlIG9wZW4gZHJhaW4gZm9yIHJlY292ZXJ5
IEdQSU8iKQ0KPiANCj4gT3RoZXJ3aXNlIHlvdSdsbCBnZXQgYSBib290LXRpbWUgd2FybmluZzoN
Cj4gICAgZW5mb3JjZWQgb3BlbiBkcmFpbiBwbGVhc2UgZmxhZyBpdCBwcm9wZXJseSBpbiBEVC9B
Q1BJIERTRFQvYm9hcmQNCj4gZmlsZQ0KDQpUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0LCBJ
IGFkZGVkIHRoaXMgZm9yIHY0Lg0KDQpQaGlsaXBwZQ0KPiANCj4gPiArCXNkYS1ncGlvcyA9IDwm
Z3BpbzEgNSBHUElPX0FDVElWRV9ISUdIPjsNCj4gPiArDQo+ID4gIAlzdGF0dXMgPSAib2theSI7
DQo+ID4gDQo+ID4gIAljb2RlYzogc2d0bDUwMDBAYSB7DQo+ID4gQEAgLTI0Miw4ICsyNDYsMTEg
QEANCj4gPiANCj4gPiAgJmkyYzQgew0KPiA+ICAJY2xvY2stZnJlcXVlbmN5ID0gPDEwMDAwMD47
DQo+ID4gLQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICsJcGluY3RybC1uYW1lcyA9
ICJkZWZhdWx0IiwgImdwaW8iOw0KPiA+ICAJcGluY3RybC0wID0gPCZwaW5jdHJsX2kyYzQ+Ow0K
PiA+ICsJcGluY3RybC0xID0gPCZwaW5jdHJsX2kyYzRfcmVjb3Zlcnk+Ow0KPiA+ICsJc2NsLWdw
aW9zID0gPCZncGlvNyA4IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiANCj4gYW5kIGhlcmUsIHRvby4N
Cj4gDQo+IENoZWVycywNCj4gQW5kcsOpDQo=
