Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B8FC004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFF52087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ma15hjR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfECM6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 08:58:22 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:7773
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfECM6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mg7GM0tG7402hk8+TaitDHvfpBTzkD/Xxv57IGm71VA=;
 b=ma15hjR7aZLkDGX1JzKRF4gz7B5RmvySXRKvS3PNcn1nc4M2+y+pANFCaOqJYNH7ymms+cOwsOHPF8Gi1+7gXSkSWTfj9GUypMZhsRJeqxDzQ5WD83Gu881q8EWfGl4QUdmepk97FU+EwYkjq+S6vGBkEq2I8+UHiNlYjt8xAe0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3772.eurprd04.prod.outlook.com (52.134.71.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Fri, 3 May 2019 12:58:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Fri, 3 May 2019
 12:58:16 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: clk-pllv3: mark expected switch fall-throughs
Thread-Topic: [PATCH] clk: imx: clk-pllv3: mark expected switch fall-throughs
Thread-Index: AQHU/2F/dL/aKPHv6kKxTNsCbW884aZZYKyA
Date:   Fri, 3 May 2019 12:58:16 +0000
Message-ID: <DB3PR0402MB3916B107469C908CB456CEDAF5350@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190430143206.GA4035@embeddedor>
In-Reply-To: <20190430143206.GA4035@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00e5b020-a19e-48bc-8309-08d6cfc70252
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3772;
x-ms-traffictypediagnostic: DB3PR0402MB3772:
x-microsoft-antispam-prvs: <DB3PR0402MB3772DD76EC20BE5198EA9C76F5350@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(366004)(13464003)(189003)(199004)(229853002)(8676002)(81156014)(6636002)(7416002)(110136005)(6436002)(2906002)(7736002)(14454004)(25786009)(478600001)(53936002)(6246003)(73956011)(4326008)(14444005)(316002)(6116002)(3846002)(64756008)(66446008)(66556008)(66476007)(66946007)(66066001)(76116006)(74316002)(68736007)(305945005)(256004)(26005)(446003)(11346002)(99286004)(81166006)(7696005)(44832011)(76176011)(54906003)(55016002)(9686003)(186003)(86362001)(33656002)(486006)(52536014)(71190400001)(71200400001)(8936002)(6506007)(53546011)(476003)(5660300002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3772;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9TsJgYGEIH5fYwixr9+mp5JXLvzvHHY9DWmribnvBvWDGvpm8N24b+TiynGt1fyLwbX0f2OJ5tVJ22BAwesrcHPb9qZY6WjO2Z8jG/9GZ9Y/aCnkJRP0jK4cN0l8Pvd5KhH4S1COwRQGuvnO5ngpm0IduoHpDTvVHpSrn1G0Qdia1ng6zyw1lF09Kdq6Ii7PeXw4PwB2cKkNvFt/+IxgfY2bnQmBNmie4dZj079SO/RM1ALcDhiC3bB3XFYPwYrLaIh/Z3UX2dputrQM3g8JYNOmscN6u50ZMxxpTFFN2+Iz/2SXNPXh/5sgKzDCQa3AYwOEJstFgzsD4LiHxV6AbIIA5s2GX43cAc1WwYiLsN5zYOWJRnqxxAM7CWysf9aTWfWsMezbmZQbQgCuZLOmG6LYRyOyRfFzc9E3b3oZL04=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e5b020-a19e-48bc-8309-08d6cfc70252
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 12:58:16.2206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VzdGF2byBBLiBSLiBT
aWx2YSBbbWFpbHRvOmd1c3Rhdm9AZW1iZWRkZWRvci5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEFw
cmlsIDMwLCAyMDE5IDEwOjMyIFBNDQo+IFRvOiBNaWNoYWVsIFR1cnF1ZXR0ZSA8bXR1cnF1ZXR0
ZUBiYXlsaWJyZS5jb20+OyBTdGVwaGVuIEJveWQNCj4gPHNib3lkQGtlcm5lbC5vcmc+OyBTaGF3
biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU+OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbQ0KPiA8a2VybmVsQHBlbmd1dHJv
bml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtbGludXgtDQo+
IGlteCA8bGludXgtaW14QG54cC5jb20+DQo+IENjOiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3Iu
Y29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGNsazogaW14OiBjbGstcGxsdjM6IG1hcmsgZXhwZWN0
ZWQgc3dpdGNoIGZhbGwtdGhyb3VnaHMNCj4gDQo+IEluIHByZXBhcmF0aW9uIHRvIGVuYWJsaW5n
IC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsgc3dpdGNoIGNhc2VzIHdoZXJlDQo+IHdlIGFy
ZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdoLg0KPiANCj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUg
Zm9sbG93aW5nIHdhcm5pbmdzOg0KPiANCj4gZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2My5jOiBJ
biBmdW5jdGlvbiDigJhpbXhfY2xrX3BsbHYz4oCZOg0KPiBkcml2ZXJzL2Nsay9pbXgvY2xrLXBs
bHYzLmM6NDQ2OjE4OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFst
DQo+IFdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dDQo+ICAgIHBsbC0+ZGl2X3NoaWZ0ID0gMTsNCj4g
ICAgfn5+fn5+fn5+fn5+fn5+Xn5+DQo+IGRyaXZlcnMvY2xrL2lteC9jbGstcGxsdjMuYzo0NDc6
Mjogbm90ZTogaGVyZQ0KPiAgIGNhc2UgSU1YX1BMTFYzX1VTQjoNCj4gICBefn5+DQo+IGRyaXZl
cnMvY2xrL2lteC9jbGstcGxsdjMuYzo0NTM6MjE6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1h
eSBmYWxsIHRocm91Z2ggWy0NCj4gV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4gICAgcGxsLT5k
ZW5vbV9vZmZzZXQgPSBQTExfSU1YN19ERU5PTV9PRkZTRVQ7DQo+ICAgICAgICAgICAgICAgICAg
ICAgIF4NCj4gZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2My5jOjQ1NDoyOiBub3RlOiBoZXJlDQo+
ICAgY2FzZSBJTVhfUExMVjNfQVY6DQo+ICAgXn5+fg0KPiANCj4gV2FybmluZyBsZXZlbCAzIHdh
cyB1c2VkOiAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTMNCj4gDQo+IFRoaXMgcGF0Y2ggaXMgcGFy
dCBvZiB0aGUgb25nb2luZyBlZmZvcnRzIHRvIGVuYWJsZSAtV2ltcGxpY2l0LWZhbGx0aHJvdWdo
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJl
ZGRlZG9yLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLXBsbHYzLmMgfCAyICsr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2My5jIGIvZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2My5j
IGluZGV4DQo+IGU4OTJiOWE4MzZlNS4uNDExMGU3MTNkMjU5IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2Nsay9pbXgvY2xrLXBsbHYzLmMNCj4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2
My5jDQo+IEBAIC00NDQsNiArNDQ0LDcgQEAgc3RydWN0IGNsayAqaW14X2Nsa19wbGx2MyhlbnVt
IGlteF9wbGx2M190eXBlIHR5cGUsDQo+IGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAJCWJyZWFrOw0K
PiAgCWNhc2UgSU1YX1BMTFYzX1VTQl9WRjYxMDoNCj4gIAkJcGxsLT5kaXZfc2hpZnQgPSAxOw0K
PiArCQkvKiBmYWxsIHRocm91Z2ggKi8NCj4gIAljYXNlIElNWF9QTExWM19VU0I6DQo+ICAJCW9w
cyA9ICZjbGtfcGxsdjNfb3BzOw0KPiAgCQlwbGwtPnBvd2VydXBfc2V0ID0gdHJ1ZTsNCj4gQEAg
LTQ1MSw2ICs0NTIsNyBAQCBzdHJ1Y3QgY2xrICppbXhfY2xrX3BsbHYzKGVudW0gaW14X3BsbHYz
X3R5cGUgdHlwZSwNCj4gY29uc3QgY2hhciAqbmFtZSwNCj4gIAljYXNlIElNWF9QTExWM19BVl9J
TVg3Og0KPiAgCQlwbGwtPm51bV9vZmZzZXQgPSBQTExfSU1YN19OVU1fT0ZGU0VUOw0KPiAgCQlw
bGwtPmRlbm9tX29mZnNldCA9IFBMTF9JTVg3X0RFTk9NX09GRlNFVDsNCj4gKwkJLyogZmFsbCB0
aHJvdWdoICovDQoNCg0KUmV2aWV3ZWQtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KDQo+ICAJY2FzZSBJTVhfUExMVjNfQVY6DQo+ICAJCW9wcyA9ICZjbGtfcGxsdjNfYXZf
b3BzOw0KPiAgCQlicmVhazsNCj4gLS0NCj4gMi4yMS4wDQoNCg==
