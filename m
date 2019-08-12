Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12552C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7F4214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="f0hkdDpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfHLMxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:53:35 -0400
Received: from mail-eopbgr10094.outbound.protection.outlook.com ([40.107.1.94]:15930
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726582AbfHLMxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:53:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TECit3S8Av7NAhgCOQ3hxlga81QIkQHgz5weRyjnH7e61JozRIC+AFdZEgdnLU0u6tGArenzh7bZpWO3ztsxxLrras47yYAzsVHTBhYWGL7qOadRgRPcKQ2jn/Orkv+eCi6NRcY/AxXC6hptDdaNW2IbuZPIuFF+1SPlbRIY+E1I+Tjn/I+7edZDAd6rvxTcDwk+kimGX/zsrt0GIGAH2M/N9Lq17EdGiF+TRTseHrHb26AXjoaNY++RpG0LUSdr6NasLB5YUeVhZNjSFI9Wpw7H+SKYvInu7iRWj0zGa6yGsdoJ4SvObAFAfWyvwdmAHxGCz9kQ7mvRBmoUE+XB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i611ArID7UCiLd1fAoPehTbTVdHX+iMBapqY/7+2E1I=;
 b=Gj2RBzT42OEhA4mKnjiwWQyXysn3po2Fk97OdvZJdnRTlYep7wZ6p8hWGiXdAav9f5kHpF1RP22hnCYJDHNbla9Ge3Yk3FtXyeJqzpl6zApidvOYlDtyr6DFzf/f8b9Cae2NpqfjDNzPUYePPnUSRk3RYPEBsepxjiXoSFdeDx5mu7VAcGNlUXpL0zTSnQ1iTAuJ/E9vpcRxHmXSXy6Ws154gMuRO1Tl4KjRQFhTljq3MrzfAXqwMq88PA++lVRUDEzbf4/kXqOtLdaKHjaujiQ+3DRKYuVbef1SSPx5TBAdjQ0jdnAK2n/+SUbDy6W6RCctEyWXsNjHHoXA/hKDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i611ArID7UCiLd1fAoPehTbTVdHX+iMBapqY/7+2E1I=;
 b=f0hkdDpI54ENKzXpEUzAsxX1TQKrDQJKXlcHpDbxAue1c7Hk23DxC7goWgG2Lnfa8w5t/Ahj/fP60jbjT48DjvHtq8f4cSL2lYta6f0zIfM9FjqX3b5SnntDw1xIpcbToRbkyrWaEE09o5FKQavfYeteiRXl0jKZyRx0+v9ohAU=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2896.eurprd05.prod.outlook.com (10.175.25.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Mon, 12 Aug 2019 12:53:28 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 12:53:28 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 19/21] ARM: dts: imx6/7-colibri: switch dr_mode to otg
Thread-Topic: [PATCH v3 19/21] ARM: dts: imx6/7-colibri: switch dr_mode to otg
Thread-Index: AQHVTPnYpzmKFIEQakCY1BjdKzKruKby+m0AgASFfgA=
Date:   Mon, 12 Aug 2019 12:53:28 +0000
Message-ID: <e9a6dea440a646d19c18f3487427bc0f754a7da0.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-20-philippe.schenker@toradex.com>
         <6fdbd56b71c1192c67b2e28accd611ced92de555.camel@toradex.com>
In-Reply-To: <6fdbd56b71c1192c67b2e28accd611ced92de555.camel@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 449e3220-0811-4b5e-33dc-08d71f2412b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2896;
x-ms-traffictypediagnostic: VI1PR0502MB2896:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB28966A2FB17EB6D77144B3BDF4D30@VI1PR0502MB2896.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39850400004)(346002)(366004)(136003)(376002)(199004)(189003)(7416002)(25786009)(54906003)(446003)(2906002)(2616005)(476003)(11346002)(8676002)(76176011)(53936002)(36756003)(2501003)(6246003)(6116002)(3846002)(186003)(6512007)(81156014)(99286004)(4326008)(86362001)(102836004)(6506007)(256004)(14444005)(81166006)(26005)(66476007)(66446008)(64756008)(66556008)(66946007)(5660300002)(6486002)(14454004)(118296001)(76116006)(91956017)(8936002)(229853002)(71190400001)(71200400001)(66066001)(7736002)(6436002)(305945005)(2201001)(316002)(110136005)(44832011)(486006)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2896;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1wU/I4v5kR1MT0UCluGl6Ws0+7BDlzCM5u/XebsgM8rEP1FPVe6LoQf47aS7c7F1N9oaAJHu9NqNQHTjw+BKHISO1yjj9K1w7+h8L6r+eiCHExujqEdisL8XPKfmj5PPGdcUljTMexneTDyG8qe1HVyOUOgKXjmCaQ2fXeZjlK7jRd5oU+H7g3O+WfI4I+TY1jCyA4ewM7szbT3Zll5OQ7JoCy3Ze14tJAekKg5fj2RqFADoe/wdEAgrgAPKe0mpdF9ZOf7kMJphl8/qWyxiTJM/cjA51vz9ehb+3v+5tqr/+Uq47faUs/6fe6WV8FJ/W2QU93pLMaX1dIz1tLuAS3IaSm4xEYNIghmNEDZDgoAhYOPTRrbta2Gr1D8tDmMs0XAdexRVMfO+tKC9GbV7cnclulc9DQwRgPY8wzbSLdc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7103F6984D8B004C9D2AA8AA0A4D7D7A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449e3220-0811-4b5e-33dc-08d71f2412b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 12:53:28.7478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGPX10hUgT8PQuwoUg5Bko1FNCD3sxDkLecWi037QWF0bZTQDt0MioZ9OD2V5owR2YAocBqhs0v2Dq+7uZhSe4kpxi14TDQjQQAwKygeoNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2896
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA4LTA5IGF0IDE1OjUwICswMDAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6
DQo+IEhpIFBoaWxpcHBlDQo+IA0KPiBPbiBXZWQsIDIwMTktMDgtMDcgYXQgMDg6MjYgKzAwMDAs
IFBoaWxpcHBlIFNjaGVua2VyIHdyb3RlOg0KPiA+IEluIG9yZGVyIGZvciB0aGUgb3RnIHBvcnRz
LCB0aGF0IHRoZXNlIG1vZHVsZXMgc3VwcG9ydCwgaXQgaXMgbmVlZGVkDQo+ID4gdGhhdCBkcl9t
b2RlIGlzIG9uIG90Zy4gU3dpdGNoIHRvIHVzZSB0aGF0IGZlYXR1cmUuDQo+IA0KPiBJc24ndCBm
dXJ0aGVyIGV4dGNvbiBpbnRlZ3JhdGlvbiByZXF1aXJlZCBmb3IgdGhpcyB0byB0cnVseSB3b3Jr
Pw0KDQpZZXMsIEkgd2Fzbid0IGF3YXJlIG9mIHRoYXQuIEkgd2lsbCBkcm9wIHRoaXMgcGF0Y2gg
YXMgdGhpcyBpcyBhIHdob2xlDQpuZXcgdG9waWMgYW5kIHdpbGwgaG9wZWZ1bGx5IGJlIGEgd2hv
bGUgbmV3IHBhdGNoc2V0IHNvb24uDQoNClBoaWxpcHBlDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4NCj4gPiAt
LS0NCj4gPiANCj4gPiBDaGFuZ2VzIGluIHYzOiBOb25lDQo+ID4gQ2hhbmdlcyBpbiB2MjogTm9u
ZQ0KPiA+IA0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRzaSB8IDIg
Ky0NCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kgICAgfCAyICstDQo+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRz
aQ0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1jb2xpYnJpLmR0c2kNCj4gPiBpbmRl
eCA5YTYzZGViYWIwYjUuLjY2NzQxOTgzNDZkMiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9i
b290L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZxZGwtY29saWJyaS5kdHNpDQo+ID4gQEAgLTM4OCw3ICszODgsNyBAQA0KPiA+ICAmdXNi
b3RnIHsNCj4gPiAgCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gIAlkaXNhYmxlLW92
ZXItY3VycmVudDsNCj4gPiAtCWRyX21vZGUgPSAicGVyaXBoZXJhbCI7DQo+ID4gKwlkcl9tb2Rl
ID0gIm90ZyI7DQo+ID4gIAlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICB9Ow0KPiA+ICANCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kNCj4gPiBi
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpDQo+ID4gaW5kZXggNjdmNWUwYzg3
ZmRjLi40MjQ3OGYxYWExNDYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14
Ny1jb2xpYnJpLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmku
ZHRzaQ0KPiA+IEBAIC0zMjAsNyArMzIwLDcgQEANCj4gPiAgfTsNCj4gPiAgDQo+ID4gICZ1c2Jv
dGcxIHsNCj4gPiAtCWRyX21vZGUgPSAiaG9zdCI7DQo+ID4gKwlkcl9tb2RlID0gIm90ZyI7DQo+
ID4gIH07DQo+ID4gIA0KPiA+ICAmdXNkaGMxIHsNCj4gDQo+IENoZWVycw0KPiANCj4gTWFyY2Vs
DQo=
