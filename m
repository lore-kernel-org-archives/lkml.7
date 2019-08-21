Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C45C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C194B22CF4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="WbPrY1/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfHUMvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:51:38 -0400
Received: from mail-eopbgr50094.outbound.protection.outlook.com ([40.107.5.94]:41441
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbfHUMvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:51:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lietjQ6QkXWwm9VfkVxzhbkwKZNcuTl13gtgNM4au/M86u7optBHj5QilwGBva44hTHZNVmAbkItMFnBoUXwzwrHYrmxNsJj4aGMsIBvTBXjZ+XMRM77pvRLaYAjdW6WbrYix6rpXtTu2efIobwdzjodL7C6KJYNsMN/7wHMZk/ktz6k9EsVtFm9kaAWcCAUUbPeN6BY/E+RFAAGzhRRpQqSYi0J7ghsQQDuxq2yHLV2JQQvQ/T9L7ExwOYnG17sVJ2j0j5XOXjYifbNygUwEMHyDv0/HRQfBoUr11Ieyy97vx5Fd/1ohuHEBbxUPi+KzhrCj5H/AtCYDtKyynOzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iEmejef1lwgsM6s0ixvegliTpwo5Av4bZ7c0U0SmfY=;
 b=mgqXkJt1GgwrZgXZ+yCTddq7Ed/m0KvMEfJ+l+JVd+Vg+LChefs3IQY+iPOvW+3qJoqCMxE4RkmLH61/851nO0eqDdC2pWrklwG8rDSiveQhouAy2Khwz/auzFhOotRmLfsze/Ik5cgggqwIeaxHdhn08FaLdT+lNkHmvP8uA3fJIoaBFW8ilRW2p4VT4ZmqdxRxrmttJOhOSLdEWlP6DT/WWrE+eq21t9D7Vs5BHXZdtPpZa5f926gi3W+wpNG/CxDthnbjpBKLEaPSm1Q/MstfL5yxaodJ09tXXjjEcB+pyVs4JfNsMSfxGj+3V7HQmbIx3y705vnzTo9A1BY4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iEmejef1lwgsM6s0ixvegliTpwo5Av4bZ7c0U0SmfY=;
 b=WbPrY1/0b+7Gb2FiOhwP+kdgoWgfSehsWshzmpQJP6061PdCJ6H2TquermqpfRmr1+6TlGGuj2C04hxukpghuVXQziYCXAbMfIjChPUtDKHVxwRXr8zdh2fgFusMkfaRTRn9TZ7xq8/lAldUjLVWDbXhK4pJkqtOA0VgBegOFr8=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3949.eurprd05.prod.outlook.com (52.134.17.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 12:51:30 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 12:51:30 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v4 08/21] ARM: dts: imx7-colibri: Add touch controllers
Thread-Topic: [PATCH v4 08/21] ARM: dts: imx7-colibri: Add touch controllers
Thread-Index: AQHVURk6y2j9GnmWB0SSfLkk7hRFMqcCXkcAgAM904A=
Date:   Wed, 21 Aug 2019 12:51:30 +0000
Message-ID: <155f9dc45253baca7766e52c89bba614d57ad807.camel@toradex.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
         <20190812142105.1995-9-philippe.schenker@toradex.com>
         <20190819112124.GR5999@X250>
In-Reply-To: <20190819112124.GR5999@X250>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8beb0d3c-c2f7-41fc-8f01-08d7263649c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3949;
x-ms-traffictypediagnostic: VI1PR0502MB3949:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB39491C4DE1AFD5E66868E9E0F4AA0@VI1PR0502MB3949.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39840400004)(136003)(396003)(346002)(376002)(199004)(189003)(14454004)(66946007)(229853002)(6916009)(64756008)(36756003)(91956017)(66556008)(102836004)(6486002)(118296001)(6512007)(66446008)(66066001)(11346002)(486006)(2616005)(44832011)(71200400001)(6506007)(26005)(76116006)(5660300002)(66476007)(256004)(5640700003)(8936002)(186003)(14444005)(6436002)(81166006)(81156014)(1730700003)(476003)(446003)(478600001)(7416002)(6246003)(316002)(76176011)(2351001)(71190400001)(8676002)(2906002)(4326008)(305945005)(2501003)(7736002)(86362001)(6116002)(3846002)(25786009)(54906003)(99286004)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3949;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SxzsM+M8R1yIEl/Ab5L+XO4Aq+G5/iYNDAGMGD6wcmOHURsA3kfWVesn0246mAPJzNa931ypW9X10sOf9DnP4E8CbGT/096M/yW8KFiN6R4eb+13+/eAj9nJMugAz54GJlrsx6LT5MWSgr4DS3TH2+5z0/CZ3KapFUqeQi7xyy9xmZc5j7qUhG8foFaNWQp/dlupQAVMpwLg/osib/dOlVpPFA2gcXDfod6asifbX2MkM1oI4cR+J+/I0xgnMHtXfxo+uTvODQW5owDfahCDhN6YYouNW2kSw4jteCbTQKKOFXpoeJ2CLzjOTc5+YlcvecSjk0VYoS/m3bp0b+VOQUgl2QWj27YW7wyXK+VfKl3zESF7rZNvQODwEMWge9ePY1YDHcuqdGoGG7ohMQPTdrp7k0Lt61qPBIDXySTcpXg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EF4FACBA402A34093C425C4AA031E37@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8beb0d3c-c2f7-41fc-8f01-08d7263649c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 12:51:30.2787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5maRVu7r6hHoqO8cZpMR+xNSnFpjCyA/UnYa1yjm8EJ47dFL475D8k5ZvKB3r8i7j5Vr8SAI2KoYEWCzT5mk5KtcVnw0/u8HdxW/TPU5KZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3949
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTE5IGF0IDEzOjIxICswMjAwLCBTaGF3biBHdW8gd3JvdGU6DQo+IE9u
IE1vbiwgQXVnIDEyLCAyMDE5IGF0IDAyOjIxOjI2UE0gKzAwMDAsIFBoaWxpcHBlIFNjaGVua2Vy
IHdyb3RlOg0KPiA+IEFkZCB0b3VjaCBjb250cm9sbGVyIHRoYXQgaXMgY29ubmVjdGVkIG92ZXIg
YW4gSTJDIGJ1cy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8
cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQo+ID4gQWNrZWQtYnk6IE1hcmNlbCBaaXN3
aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+IA0KPiA+IC0tLQ0KPiA+IA0K
PiA+IENoYW5nZXMgaW4gdjQ6DQo+ID4gLSBBZGQgTWFyY2VsIFppc3dpbGVyJ3MgQWNrDQo+ID4g
DQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiAtIEZpeCBjb21taXQgbWVzc2FnZQ0KPiA+IA0KPiA+
IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBEZWxldGVkIHRvdWNocmV2b2x1dGlvbiBkb3duc3RyZWFt
IHN0dWZmDQo+ID4gLSBVc2UgZ2VuZXJpYyBub2RlIG5hbWUNCj4gPiAtIEJldHRlciBjb21tZW50
DQo+ID4gDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0c2kg
fCAyNA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjQg
aW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9p
bXg3LWNvbGlicmktZXZhbC12My5kdHNpDQo+ID4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNv
bGlicmktZXZhbC12My5kdHNpDQo+ID4gaW5kZXggZDRkYmM0ZmMxYWRmLi41NzZkZWM5ZmY4MWMg
MTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMu
ZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0
c2kNCj4gPiBAQCAtMTQ1LDYgKzE0NSwyMSBAQA0KPiA+ICAmaTJjNCB7DQo+ID4gIAlzdGF0dXMg
PSAib2theSI7DQo+ID4gIA0KPiA+ICsJLyoNCj4gPiArCSAqIFRvdWNoc2NyZWVuIGlzIHVzaW5n
IFNPRElNTSAyOC8zMCwgYWxzbyB1c2VkIGZvciBQV008Qj4sDQo+ID4gUFdNPEM+LA0KPiA+ICsJ
ICogYWthIHB3bTIsIHB3bTMuIHNvIGlmIHlvdSBlbmFibGUgdG91Y2hzY3JlZW4sIGRpc2FibGUg
dGhlDQo+ID4gcHdtcw0KPiA+ICsJICovDQo+ID4gKwl0b3VjaHNjcmVlbkA0YSB7DQo+ID4gKwkJ
Y29tcGF0aWJsZSA9ICJhdG1lbCxtYXh0b3VjaCI7DQo+ID4gKwkJcGluY3RybC1uYW1lcyA9ICJk
ZWZhdWx0IjsNCj4gPiArCQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZ3Bpb3RvdWNoPjsNCj4gPiAr
CQlyZWcgPSA8MHg0YT47DQo+ID4gKwkJaW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzE+Ow0KPiA+
ICsJCWludGVycnVwdHMgPSA8OSBJUlFfVFlQRV9FREdFX0ZBTExJTkc+OwkJLyoNCj4gPiBTT0RJ
TU0gMjggKi8NCj4gPiArCQlyZXNldC1ncGlvcyA9IDwmZ3BpbzEgMTAgR1BJT19BQ1RJVkVfSElH
SD47CS8qIFNPRElNTSAzMA0KPiA+ICovDQo+ID4gKwkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4g
DQo+IFdoeSBkaXNhYmxlZD8NCj4gDQo+IFNoYXduDQoNCkFsc28gaGVyZSwgdGhpcyBpcyBtZWFu
dCBhcyBhbiBleGFtcGxlIHRvIGdldCBvdXIgdG91Y2hzY3JlZW4gZmFzdGVyDQpydW5uaW5nLiBC
dXQgdGhvc2UgcGlucyBhcmUgcHJpbWFyaWx5IHVzZWQgYXMgUFdNJ3MgYW5kIHRoZXkgc2hvdWxk
IGJ5DQpkZWZhdWx0IG11eGVkIGZvciBQV00ncy4NCklmIGEgY3VzdG9tZXIgd2FudCdzIHRvIGFk
ZCB0aGF0IHRvdWNoc2NyZWVuIGhlIGp1c3QgaGF2ZSB0byBzd2l0Y2ggdGhlDQpzdGF0dXMgb2Yg
dGhpcyBhbmQgUFdNLi4uDQoNClBoaWxpcHBlDQoNCj4gDQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiAg
CS8qIE00MVQwTTYgcmVhbCB0aW1lIGNsb2NrIG9uIGNhcnJpZXIgYm9hcmQgKi8NCj4gPiAgCXJ0
YzogbTQxdDBtNkA2OCB7DQo+ID4gIAkJY29tcGF0aWJsZSA9ICJzdCxtNDF0MCI7DQo+ID4gQEAg
LTIwMCwzICsyMTUsMTIgQEANCj4gPiAgCXZtbWMtc3VwcGx5ID0gPCZyZWdfM3YzPjsNCj4gPiAg
CXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgfTsNCj4gPiArDQo+ID4gKyZpb211eGMgew0KPiA+ICsJ
cGluY3RybF9ncGlvdG91Y2g6IHRvdWNoZ3Bpb3Mgew0KPiA+ICsJCWZzbCxwaW5zID0gPA0KPiA+
ICsJCQlNWDdEX1BBRF9HUElPMV9JTzA5X19HUElPMV9JTzkJCTB4NzQNCj4gPiArCQkJTVg3RF9Q
QURfR1BJTzFfSU8xMF9fR1BJTzFfSU8xMAkJMHgxNA0KPiA+ICsJCT47DQo+ID4gKwl9Ow0KPiA+
ICt9Ow0KPiA+IC0tIA0KPiA+IDIuMjIuMA0KPiA+IA0K
