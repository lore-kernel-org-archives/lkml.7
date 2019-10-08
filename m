Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78795C47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 03:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C8821479
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 03:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F7OKbdsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfJHDXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 23:23:47 -0400
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:14307
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729860AbfJHDXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 23:23:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=La3KmvjrrjhnnuMf9z72gA4ZAwBfdHApmpqStM59l2usVQIqigzKSkgeMKp4lUu3OU7+hLbchVe5kT8IiSSFlqtzZ5u8NoAG7nuMRCC1y5xU9hCxR22AUwYuu7zNVpXxYcjis5TL30nTRcTo+o2oyKsEJUmJeedfFYDuOmKeEK9QH8/Lh5e6o4YIMNI/rfi8WAxcNwjWhyyaWUs/SoFe0gyPACkC5yOVp4pZV01PzveMkseoYbj6lXfLvTiof7ELT9icB+RX/3oHFU3a8cKbRVf2z8yQa3tlwvhD8v/lK+b7Ib2zhhSw4M9CRiSVY7jspkk9Ue3l6q+UQDyBJrdLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWSTuOAbkkNOq6AyFHxJ7BeV/uJUBLbv/yUTS5LeAL4=;
 b=Ff4iTShEF6MuvyQdothyXvK/97ELhrs0pHwSA/gwHZBgOJaMVxLKw3uv7wjmURdlSUFJ+LI1Ma4QJ1DC13ipe2ISwMt3o4nGcZlSZ6rqHctRKzr2X1b1zRSNi6GFaa7b2SOQYrODpbgawsdGddOlge5tUGtpYTTBSIMXsSxOmpxMP13QQ2ciHGVXvrj2hJ5/+5P61zPSLHCnYl/gsOCtZbuW7oS32DajDlFd48NBHwKSmUBmhqdU3mfQtXoJmVohUlI0848qV6JtKlMvqv4A7rza6RROFxC05EahMOCUZa7ocPd3FSplucEDrJj8FBaJflrRUPvRMhUumAMoZvgIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWSTuOAbkkNOq6AyFHxJ7BeV/uJUBLbv/yUTS5LeAL4=;
 b=F7OKbdsJdkOD4dhrw0q+PjtbFx83Hmby5PH4BLlkqJ0RmoLLETo4/BFBTYN8jT6xbmeCoV6FsUgrY3mHhFIgoqQ7dInoW9hE2UEhdiubWEXgt0BRGOku5qSfYmm8oJUjgDKFF7IwSzP9Rww02xDRco0RYt05bE5P1dKXlkjdUdU=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB5421.eurprd04.prod.outlook.com (20.178.121.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 03:23:42 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0%3]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 03:23:42 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Jun Li <jun.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 2/3] usb: chipidea: set mode for usb phy driver
Thread-Topic: [RFC PATCH v1 2/3] usb: chipidea: set mode for usb phy driver
Thread-Index: AQHVfQ1mRrnDi/j7/Eu0gw20cQv9+adQFWMA
Date:   Tue, 8 Oct 2019 03:23:42 +0000
Message-ID: <20191008032326.GB5670@b29397-desktop>
References: <20191007124607.20618-1-igor.opaniuk@gmail.com>
 <20191007124607.20618-2-igor.opaniuk@gmail.com>
In-Reply-To: <20191007124607.20618-2-igor.opaniuk@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbc52929-46d8-4d79-8222-08d74b9eebc3
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB5421:|VI1PR04MB5421:|VI1PR04MB5421:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB542123215897307EF95AA0728B9A0@VI1PR04MB5421.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(33656002)(4326008)(6512007)(9686003)(33716001)(305945005)(478600001)(53546011)(6916009)(102836004)(1076003)(76176011)(99286004)(86362001)(6506007)(5660300002)(54906003)(476003)(11346002)(446003)(26005)(7736002)(71190400001)(186003)(71200400001)(66556008)(64756008)(66476007)(66446008)(66946007)(8936002)(76116006)(6486002)(91956017)(486006)(44832011)(66066001)(8676002)(6436002)(6246003)(7416002)(2906002)(14454004)(229853002)(81166006)(6116002)(3846002)(81156014)(256004)(25786009)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5421;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JqbIiEmIRwpH50fL5t3YDC5+giTdiCe6SLsUijLdUPfI1uEzBaE84pBQ5F5Smn3OykEBKoJM3V/pjk+hnarVf961xO9I9ZwQ3snA8Jmw81QljTH8KQadsyKdCDtvlrlZRLlR7xNv3K9l7Gb/kAG8RakOPdj8M6vTE1lIOIMR1062IHbGW1mROiqslekO2fDZWF03o9y7q94JlKXoMvq8Ke8L5/I67UoH4XxIbknkJdKGFMWPHDwOmZM9+QyZPqOeTbCLeeyTh2bQtbLTYEnNbvKJvII2sxGJeCcR5kd4Fkn0ngu0a5lXafRphgXIJMRK06w1QiI2REGI7rD+Z88K16Sq7+c12d2MMigW9W9Yhh0WxhqNZ0BK+EPLzWNs4m8W5Da+G9A6yKflHCWe6iB+AUZdepMYGePM4SLF+SdJD4w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C5C98D460BE394B9CAC2C0A011FFDCB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc52929-46d8-4d79-8222-08d74b9eebc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 03:23:42.6800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zP3syzGOoyf6NgVaJT0PXn6xffsBnVNOYF2vK82yRu5e0BVSw3IvIQ36gOt32JFKP2dnSXRNJnWmL0skXdqegg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTktMTAtMDcgMTU6NDY6MDYsIElnb3IgT3Bhbml1ayB3cm90ZToNCj4gRnJvbTogSWdvciBP
cGFuaXVrIDxpZ29yLm9wYW5pdWtAdG9yYWRleC5jb20+DQo+IA0KPiBBZnRlciBlbnRlcnMgb25l
IHNwZWNpZmljIHJvbGUsIG5vdGlmeSB1c2IgcGh5IGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IExpIEp1biA8anVuLmxpQG54cC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IElnb3IgT3Bhbml1
ayA8aWdvci5vcGFuaXVrQHRvcmFkZXguY29tPg0KPiAtLS0NCj4gDQo+ICBkcml2ZXJzL3VzYi9j
aGlwaWRlYS9jaS5oIHwgMjEgKysrKysrKysrKysrKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMTggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9jaGlwaWRlYS9jaS5oIGIvZHJpdmVycy91c2IvY2hpcGlkZWEvY2kuaA0KPiBp
bmRleCA2OTExYWVmNTAwZTkuLmExMWQyMzkxMGIxMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91
c2IvY2hpcGlkZWEvY2kuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9jaGlwaWRlYS9jaS5oDQo+IEBA
IC0yNzUsOSArMjc1LDIxIEBAIHN0YXRpYyBpbmxpbmUgaW50IGNpX3JvbGVfc3RhcnQoc3RydWN0
IGNpX2hkcmMgKmNpLCBlbnVtIGNpX3JvbGUgcm9sZSkNCj4gIAkJcmV0dXJuIC1FTlhJTzsNCj4g
IA0KPiAgCXJldCA9IGNpLT5yb2xlc1tyb2xlXS0+c3RhcnQoY2kpOw0KPiAtCWlmICghcmV0KQ0K
PiAtCQljaS0+cm9sZSA9IHJvbGU7DQo+IC0JcmV0dXJuIHJldDsNCj4gKwlpZiAocmV0KQ0KPiAr
CQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJY2ktPnJvbGUgPSByb2xlOw0KPiArDQo+ICsJaWYgKGNp
LT51c2JfcGh5KSB7DQo+ICsJCWlmIChyb2xlID09IENJX1JPTEVfSE9TVCkNCj4gKwkJCXVzYl9w
aHlfc2V0X21vZGUoY2ktPnVzYl9waHksDQo+ICsJCQkJCVVTQl9NT0RFX0hPU1QpOw0KPiArCQll
bHNlDQo+ICsJCQl1c2JfcGh5X3NldF9tb2RlKGNpLT51c2JfcGh5LA0KPiArCQkJCQlVU0JfTU9E
RV9ERVZJQ0UpOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICBzdGF0
aWMgaW5saW5lIHZvaWQgY2lfcm9sZV9zdG9wKHN0cnVjdCBjaV9oZHJjICpjaSkNCj4gQEAgLTI5
MCw2ICszMDIsOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY2lfcm9sZV9zdG9wKHN0cnVjdCBjaV9o
ZHJjICpjaSkNCj4gIAljaS0+cm9sZSA9IENJX1JPTEVfRU5EOw0KPiAgDQo+ICAJY2ktPnJvbGVz
W3JvbGVdLT5zdG9wKGNpKTsNCj4gKw0KPiArCWlmIChjaS0+dXNiX3BoeSkNCj4gKwkJdXNiX3Bo
eV9zZXRfbW9kZShjaS0+dXNiX3BoeSwgVVNCX01PREVfTk9ORSk7DQo+ICB9DQo+ICANCj4gIHN0
YXRpYyBpbmxpbmUgZW51bSB1c2Jfcm9sZSBjaV9yb2xlX3RvX3VzYl9yb2xlKHN0cnVjdCBjaV9o
ZHJjICpjaSkNCj4gLS0gDQoNCkhpIElnb3IsDQoNClRoYW5rcyBmb3IgZG9pbmcgdGhhdC4NCg0K
V2UganVzdCBmaW5kIHRoaXMgc2VyaWVzIHBhdGNoIHdpbGwgYnJlYWsgQVJNMzIgbXVsdGlfdjdf
ZGVmY29uZmlnDQpidWlsZC4gWW91IG1heSBuZWVkIHRvIGZpeCBpdCBhdCBuZXh0IHJldmlzaW9u
LCBzZWUgYmVsb3cuDQoNCiAgQ0MgW01dICBkcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9udmttL3N1
YmRldi9mYi9nbTIwMC5vDQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL2hvbWUvYjI5Mzk3L3dvcmsv
cHJvamVjdHMvdXNiL2RyaXZlcnMvcGh5L3RpL3BoeS1vbWFwLXVzYjIuYzoyMDowOg0KL2hvbWUv
YjI5Mzk3L3dvcmsvcHJvamVjdHMvdXNiL2luY2x1ZGUvbGludXgvcGh5L29tYXBfY29udHJvbF9w
aHkuaDozNjoyOiBlcnJvcjogcmVkZWNsYXJhdGlvbiBvZiBlbnVtZXJhdG9yIOKAmFVTQl9NT0RF
X0hPU1TigJkNCiAgVVNCX01PREVfSE9TVCwNCiAgXn5+fn5+fn5+fn5+fg0KSW4gZmlsZSBpbmNs
dWRlZCBmcm9tIC9ob21lL2IyOTM5Ny93b3JrL3Byb2plY3RzL3VzYi9pbmNsdWRlL2xpbnV4L3Vz
Yi9vdGcuaDoxNDowLA0KICAgICAgICAgICAgICAgICBmcm9tIC9ob21lL2IyOTM5Ny93b3JrL3By
b2plY3RzL3VzYi9pbmNsdWRlL2xpbnV4L3BoeS9vbWFwX3VzYi5oOjEzLA0KICAgICAgICAgICAg
ICAgICBmcm9tIC9ob21lL2IyOTM5Ny93b3JrL3Byb2plY3RzL3VzYi9kcml2ZXJzL3BoeS90aS9w
aHktb21hcC11c2IyLmM6MTQ6DQovaG9tZS9iMjkzOTcvd29yay9wcm9qZWN0cy91c2IvaW5jbHVk
ZS9saW51eC91c2IvcGh5Lmg6Njk6Mjogbm90ZTogcHJldmlvdXMgZGVmaW5pdGlvbiBvZiDigJhV
U0JfTU9ERV9IT1NU4oCZIHdhcyBoZXJlDQogIFVTQl9NT0RFX0hPU1QsDQogIF5+fn5+fn5+fn5+
fn4NCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvaG9tZS9iMjkzOTcvd29yay9wcm9qZWN0cy91c2Iv
ZHJpdmVycy9waHkvdGkvcGh5LW9tYXAtdXNiMi5jOjIwOjA6DQovaG9tZS9iMjkzOTcvd29yay9w
cm9qZWN0cy91c2IvaW5jbHVkZS9saW51eC9waHkvb21hcF9jb250cm9sX3BoeS5oOjM3OjI6IGVy
cm9yOiByZWRlY2xhcmF0aW9uIG9mIGVudW1lcmF0b3Ig4oCYVVNCX01PREVfREVWSUNF4oCZDQog
IFVTQl9NT0RFX0RFVklDRSwNCiAgXn5+fn5+fn5+fn5+fn5+DQpJbiBmaWxlIGluY2x1ZGVkIGZy
b20gL2hvbWUvYjI5Mzk3L3dvcmsvcHJvamVjdHMvdXNiL2luY2x1ZGUvbGludXgvdXNiL290Zy5o
OjE0OjAsDQogICAgICAgICAgICAgICAgIGZyb20gL2hvbWUvYjI5Mzk3L3dvcmsvcHJvamVjdHMv
dXNiL2luY2x1ZGUvbGludXgvcGh5L29tYXBfdXNiLmg6MTMsDQogICAgICAgICAgICAgICAgIGZy
b20gL2hvbWUvYjI5Mzk3L3dvcmsvcHJvamVjdHMvdXNiL2RyaXZlcnMvcGh5L3RpL3BoeS1vbWFw
LXVzYjIuYzoxNDoNCi9ob21lL2IyOTM5Ny93b3JrL3Byb2plY3RzL3VzYi9pbmNsdWRlL2xpbnV4
L3VzYi9waHkuaDo3MDoyOiBub3RlOiBwcmV2aW91cyBkZWZpbml0aW9uIG9mIOKAmFVTQl9NT0RF
X0RFVklDReKAmSB3YXMgaGVyZQ0KICBVU0JfTU9ERV9ERVZJQ0UsDQogIF5+fn5+fn5+fn5+fn5+
fg0KL2hvbWUvYjI5Mzk3L3dvcmsvcHJvamVjdHMvdXNiL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6
MjgwOiByZWNpcGUgZm9yIHRhcmdldCAnZHJpdmVycy9waHkvdGkvcGh5LW9tYXAtdXNiMi5vJyBm
YWlsZWQNCm1ha2VbNF06ICoqKiBbZHJpdmVycy9waHkvdGkvcGh5LW9tYXAtdXNiMi5vXSBFcnJv
ciAxDQptYWtlWzRdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLg0KICBDQyAg
ICAgIGRyaXZlcnMvcGluY3RybC9xY29tL3BpbmN0cmwtc3NiaS1ncGlvLm8NCiAgQ0MgICAgICBk
cml2ZXJzL3JlZ3VsYXRvci9iY201OTB4eC1yZWd1bGF0b3Iubw0KICBDQyAgICAgIGRyaXZlcnMv
cGluY3RybC9xY29tL3BpbmN0cmwtc3BtaS1tcHAubw0KICBDQyAgICAgIGRyaXZlcnMvcGluY3Ry
bC9xY29tL3BpbmN0cmwtc3NiaS1tcHAubw0KICBDQyAgICAgIGRyaXZlcnMvcnBtc2cvaW14X3Jw
bXNnLm8NCiAgQ0MgW01dICBkcml2ZXJzL3JwbXNnL3JwbXNnX2NvcmUubw0KICBDQyAgICAgIGRy
aXZlcnMvcmVndWxhdG9yL2RhOTIxMC1yZWd1bGF0b3Iubw0KICBDQyAgICAgIGRyaXZlcnMvZ3B1
L2RybS9kcm1fY3J0Y19oZWxwZXIubw0KICBDQyAgICAgIGRyaXZlcnMvcGluY3RybC9zYW1zdW5n
L3BpbmN0cmwtZXh5bm9zLm8NCiAgQ0MgICAgICBkcml2ZXJzL2dwdS9kcm0vZHJtX2RwX2hlbHBl
ci5vDQovaG9tZS9iMjkzOTcvd29yay9wcm9qZWN0cy91c2Ivc2NyaXB0cy9NYWtlZmlsZS5idWls
ZDo0OTc6IHJlY2lwZSBmb3IgdGFyZ2V0ICdkcml2ZXJzL3BoeS90aScgZmFpbGVkDQptYWtlWzNd
OiAqKiogW2RyaXZlcnMvcGh5L3RpXSBFcnJvciAyDQoNCi0tIA0KDQpUaGFua3MsDQpQZXRlciBD
aGVu
