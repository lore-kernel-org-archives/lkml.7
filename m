Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C3C2D0BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F35B214B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TV6cS9vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfLEChf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:37:35 -0500
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:31143
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728098AbfLEChe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:37:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWyVj1p80447oATQHepwNepjTPnH2c1mMJL0Qgp/vZ+bpGKiuqKLI78QQiM2aOuFSvfnrlUPuSytIRRgbZpSKDvR7KTohd7b0+KytzxmL22BvvfdhRC8bFRyoDC2ZZCQmNO2/7rpIJWXTdAGDgF6/K4iKptxcNQYdDZSEeGjUQba9Y2FlcR1RSrXVmdTtbMFYhr8CM5NCDPhtyM5Fy5Q7AAJXnNc4G13tDa3Qpx3Ubw1qbUmYUNMGCb8thGubofZxboLdhwg5P7ta89iqbq7oJxsg+n7FaJzSjg030h9IknC1qHTPOEYhLawJxmbjl+QQAfORH+f9soY4g/3aV0d4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpKhSaa/qXs+tFYpihHhaa5sxrwoh5BB73Cx7QI5DFA=;
 b=UspszFCA5h/AiQp6irDa27YI76QVKEfuomfbuhfbNcQOsPzv1Ke8l/qi6NRdChhvJsOJ77WG6svPqcSVwF74/N8ZWhm0+VQStYvKYCBEOWa+zwyjtDa8jg2Dvy6MIkkV1ziJU1z8LzT2KOq6MfPKTiETsxIzWC/hJ3aUmpW64TSqsZ4TTQxzzgGtphfp9Tnd/u9K2Ut6PG+HinZEyPbfdWou66fgsyRAmWi2yrsFTFn5inidywjMrE6GYO8Lw7HBrx9lrdaMyN8miS/aVZiehoQGojYh5lo+FPtgEgZVQ9jTbgAchOxFvf3IxQN/DoFUi3fcqTaaA4m+EMzDquQvPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpKhSaa/qXs+tFYpihHhaa5sxrwoh5BB73Cx7QI5DFA=;
 b=TV6cS9vvk1mPNt7Np59WsJEtriaahFuYs60Keb9/6c4PEZLL8zdbJ7EUl6sNaHaRIa4jisMBxGAaeZh3OHGtsWe+wkWfRG41/2Qui0RDgxvZRxdhfLnDSVHCyCxP+94OtoWf/FDUqHDxjDdJ0limUEJYi/IL17Es8zLltbkk8KU=
Received: from DB7PR04MB5178.eurprd04.prod.outlook.com (20.176.234.92) by
 DB7PR04MB4235.eurprd04.prod.outlook.com (52.135.128.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Thu, 5 Dec 2019 02:37:29 +0000
Received: from DB7PR04MB5178.eurprd04.prod.outlook.com
 ([fe80::1551:2aea:3229:156c]) by DB7PR04MB5178.eurprd04.prod.outlook.com
 ([fe80::1551:2aea:3229:156c%4]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 02:37:29 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Adam Ford <aford173@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/7] arm64: dts: imx8mm: add GPC power domains
Thread-Topic: [PATCH 5/7] arm64: dts: imx8mm: add GPC power domains
Thread-Index: AQHVqxJ64ajh+bjI6kC62XtCagiaw6eq0rVw
Date:   Thu, 5 Dec 2019 02:37:29 +0000
Message-ID: <DB7PR04MB517877B39D4659568F69B813875C0@DB7PR04MB5178.eurprd04.prod.outlook.com>
References: <20191205021924.25188-1-aford173@gmail.com>
 <20191205021924.25188-6-aford173@gmail.com>
In-Reply-To: <20191205021924.25188-6-aford173@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68b68bda-775b-4a51-a8b8-08d7792c128b
x-ms-traffictypediagnostic: DB7PR04MB4235:|DB7PR04MB4235:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4235E8D69B14E4A273A3D582875C0@DB7PR04MB4235.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(13464003)(199004)(189003)(54906003)(6116002)(81156014)(3846002)(8936002)(7416002)(99286004)(25786009)(11346002)(81166006)(110136005)(8676002)(5660300002)(4326008)(64756008)(2906002)(55016002)(66556008)(26005)(316002)(7696005)(6246003)(14444005)(33656002)(71200400001)(52536014)(66446008)(74316002)(66946007)(76116006)(71190400001)(66476007)(305945005)(14454004)(7736002)(76176011)(6436002)(9686003)(186003)(86362001)(102836004)(6506007)(53546011)(2501003)(478600001)(229853002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4235;H:DB7PR04MB5178.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bjiUSysDlfQwG86FD7F0/53lbbKeHxFIRoc73BVNGWeRTjLNS1amsjzAlkhuR8uA6Kqc8tZMUPyTlTyrLj+eRYfQegefU99pRxiD+Yb3hlA28RKOGEzeEyXR00bo73Wx3oL7+2v7HZZSYMZ5sAiomGlzH3Stj0va4pnormIeePWbkpmm1pUsqOSfdUIYapo6Z15RivJt9zkPlgQUL7ml8isujIyzeo09r70iU3lydAz4VsHQ2EC4u/znjf1m4IixoNd6KIScxK6y00+VBiydCd2w6pPNJ1zAcQ/GwKFdo6vF8laz6Q2/5raDWHiOwde4rDgDYan3EcL2pW6Odr4n2jdgTGzsS9Mt+wUksGjU9OVTvJxY+DFnzUALADHsGspIQX6SGST3Fh20manQNJbgPdZgHIEml/ayB1wjJAEhbI256Vw4xajSy64mkpFCHHHOXL/7OTnVu4L+6OcExe8PPeErEhCHsAeiMBWtYQNfYba6gLtFSgDP39wZcFg8oH30
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b68bda-775b-4a51-a8b8-08d7792c128b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 02:37:29.1809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZv08IU4UHnSXT2ZpYgIdfScsidwJZxSIB7eeFUh30dPN1Crbl5qZCUuguTgBWhvzZjWHEbDVPZk8+MBQ/I9JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZGFtIEZvcmQgPGFmb3JkMTcz
QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDUsIDIwMTkgMTA6MTkgQU0N
Cj4gVG86IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogQWRhbSBG
b3JkIDxhZm9yZDE3M0BnbWFpbC5jb20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3Jn
PjsNCj4gTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IFNoYXduIEd1bw0KPiA8
c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5k
ZT47DQo+IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBG
YWJpbyBFc3RldmFtDQo+IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIDUvN10gYXJtNjQ6IGR0czogaW14
OG1tOiBhZGQgR1BDIHBvd2VyIGRvbWFpbnMNCj4gDQo+IFRoZXJlIGlzIGEgcG93ZXIgZG9tYWlu
IGNvbnRyb2xsZXIgb24gdGhlIGkuWE04TSBNaW5pIHVzZWQgZm9yIGhhbmRsaW5nDQo+IGludGVy
cnVwdHMgYW5kIGNvbnRyb2xsaW5nIGNlcnRhaW4gcGVyaXBoZXJhbHMgbGlrZSBVU0IgT1RHIGFu
ZCBQQ0llLCB3aGljaA0KPiBhcmUgY3VycmVudGx5IHVuYXZhaWxhYmxlLg0KPiANCj4gVGhpcyBw
YXRjaCBlbmFibGVzIHN1cHBvcnQgdGhlIGNvbnRyb2xsZXIgaXRzZWxmIHRvIHRoZSBoZWxwIGZh
Y2lsaXRhdGUgZW5hYmxpbmcNCj4gYWRkaXRpb25hbCBwZXJpcGhlcmFscy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEFkYW0gRm9yZCA8YWZvcmQxNzNAZ21haWwuY29tPg0KPiAtLS0NCj4gIGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpIHwgODINCj4gKysrKysrKysrKysr
KysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1tLmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRz
aQ0KPiBpbmRleCAyM2M4ZmFkNzkzMmIuLmQwNWM1YjYxN2E0ZCAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gQEAgLTQsNiArNCw3IEBADQo+ICAg
Ki8NCj4gDQo+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svaW14OG1tLWNsb2NrLmg+DQo+
ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvaW14OG0tcG93ZXIuaD4NCj4gICNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4NCj4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnB1
dC9pbnB1dC5oPg0KPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVy
L2FybS1naWMuaD4NCj4gQEAgLTEzLDcgKzE0LDcgQEANCj4gDQo+ICAvIHsNCj4gIAljb21wYXRp
YmxlID0gImZzbCxpbXg4bW0iOw0KPiAtCWludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+ICsJ
aW50ZXJydXB0LXBhcmVudCA9IDwmZ3BjPjsNCg0KTkFDSywgZm9yIGlteDhtbSwgaW14OG1uICYg
ZnV0dXJlIGkuTVg4TSBTT0MsIHdlIGRvbid0IHRyZWF0IEdQQyBhcyBpbnRlcnJ1cHQgY29udHJv
bGxlciBpbiBsaW51eCBhbnltb3JlLg0KQWJvdmUgY2hhbmdlIHdpbGwgYnJlYWsgdGhlIGxvdyBw
b3dlciBtb2RlIHN1cHBvcnQoc3VzcGVuZC9yZXN1bWUpDQoNCkJSDQpKYWNreSBCYWkNCg0KPiAg
CSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiAgCSNzaXplLWNlbGxzID0gPDI+Ow0KPiANCj4gQEAg
LTQ5NSw2ICs0OTYsODUgQEANCj4gIAkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODkgSVJRX1RZ
UEVfTEVWRUxfSElHSD47DQo+ICAJCQkJI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiAgCQkJfTsNCj4g
Kw0KPiArCQkJZ3BjOiBncGNAMzAzYTAwMDAgew0KPiArCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlt
eDhtbS1ncGMiOw0KPiArCQkJCXJlZyA9IDwweDMwM2EwMDAwIDB4MTAwMDA+Ow0KPiArCQkJCWlu
dGVycnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+ICsJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDg3
IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArCQkJCWludGVycnVwdC1jb250cm9sbGVyOw0KPiAr
CQkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8Mz47DQo+ICsNCj4gKwkJCQlwZ2Mgew0KPiArCQkJCQkj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJCQkJI3NpemUtY2VsbHMgPSA8MD47DQo+ICsNCj4g
KwkJCQkJcGdjX21pcGk6IHBvd2VyLWRvbWFpbkAwIHsNCj4gKwkJCQkJCSNwb3dlci1kb21haW4t
Y2VsbHMgPSA8MD47DQo+ICsJCQkJCQlyZWcgPSA8SU1YOE1NX1BPV0VSX0RPTUFJTl9NSVBJPjsN
Cj4gKwkJCQkJfTsNCj4gKw0KPiArCQkJCQlwZ2NfcGNpZTogcG93ZXItZG9tYWluQDEgew0KPiAr
CQkJCQkJI3Bvd2VyLWRvbWFpbi1jZWxscyA9IDwwPjsNCj4gKwkJCQkJCXJlZyA9IDxJTVg4TU1f
UE9XRVJfRE9NQUlOX1BDSUU+Ow0KPiArCQkJCQl9Ow0KPiArDQo+ICsJCQkJCXBnY19vdGcxOiBw
b3dlci1kb21haW5AMiB7DQo+ICsJCQkJCQkjcG93ZXItZG9tYWluLWNlbGxzID0gPDA+Ow0KPiAr
CQkJCQkJcmVnID0NCj4gPElNWDhNTV9QT1dFUl9ET01BSU5fVVNCX09URzE+Ow0KPiArCQkJCQl9
Ow0KPiArDQo+ICsJCQkJCXBnY19vdGcyOiBwb3dlci1kb21haW5AMyB7DQo+ICsJCQkJCQkjcG93
ZXItZG9tYWluLWNlbGxzID0gPDA+Ow0KPiArCQkJCQkJcmVnID0NCj4gPElNWDhNTV9QT1dFUl9E
T01BSU5fVVNCX09URzI+Ow0KPiArCQkJCQl9Ow0KPiArDQo+ICsJCQkJCXBnY19kZHIxOiBwb3dl
ci1kb21haW5ANCB7DQo+ICsJCQkJCQkjcG93ZXItZG9tYWluLWNlbGxzID0gPDA+Ow0KPiArCQkJ
CQkJcmVnID0gPElNWDhNTV9QT1dFUl9ET01BSU5fRERSMT47DQo+ICsJCQkJCX07DQo+ICsNCj4g
KwkJCQkJcGdjX2dwdTJkOiBwb3dlci1kb21haW5ANSB7DQo+ICsJCQkJCQkjcG93ZXItZG9tYWlu
LWNlbGxzID0gPDA+Ow0KPiArCQkJCQkJcmVnID0gPElNWDhNTV9QT1dFUl9ET01BSU5fR1BVMkQ+
Ow0KPiArCQkJCQl9Ow0KPiArDQo+ICsJCQkJCXBnY19ncHU6IHBvd2VyLWRvbWFpbkA2IHsNCj4g
KwkJCQkJCSNwb3dlci1kb21haW4tY2VsbHMgPSA8MD47DQo+ICsJCQkJCQlyZWcgPSA8SU1YOE1N
X1BPV0VSX0RPTUFJTl9HUFU+Ow0KPiArCQkJCQl9Ow0KPiArDQo+ICsJCQkJCXBnY192cHU6IHBv
d2VyLWRvbWFpbkA3IHsNCj4gKwkJCQkJCSNwb3dlci1kb21haW4tY2VsbHMgPSA8MD47DQo+ICsJ
CQkJCQlyZWcgPSA8SU1YOE1NX1BPV0VSX0RPTUFJTl9WUFU+Ow0KPiArCQkJCQl9Ow0KPiArDQo+
ICsJCQkJCXBnY19ncHUzZDogcG93ZXItZG9tYWluQDggew0KPiArCQkJCQkJI3Bvd2VyLWRvbWFp
bi1jZWxscyA9IDwwPjsNCj4gKwkJCQkJCXJlZyA9IDxJTVg4TU1fUE9XRVJfRE9NQUlOX0dQVTNE
PjsNCj4gKwkJCQkJfTsNCj4gKw0KPiArCQkJCQlwZ2NfZGlzcDogcG93ZXItZG9tYWluQDkgew0K
PiArCQkJCQkJI3Bvd2VyLWRvbWFpbi1jZWxscyA9IDwwPjsNCj4gKwkJCQkJCXJlZyA9IDxJTVg4
TU1fUE9XRVJfRE9NQUlOX0RJU1A+Ow0KPiArCQkJCQl9Ow0KPiArDQo+ICsJCQkJCXBnY192cHVf
ZzE6IHBvd2VyLWRvbWFpbkBhIHsNCj4gKwkJCQkJCSNwb3dlci1kb21haW4tY2VsbHMgPSA8MD47
DQo+ICsJCQkJCQlyZWcgPSA8SU1YOE1NX1BPV0VSX1ZQVV9HMT47DQo+ICsJCQkJCX07DQo+ICsN
Cj4gKwkJCQkJcGdjX3ZwdV9nMjogcG93ZXItZG9tYWluQGIgew0KPiArCQkJCQkJI3Bvd2VyLWRv
bWFpbi1jZWxscyA9IDwwPjsNCj4gKwkJCQkJCXJlZyA9IDxJTVg4TU1fUE9XRVJfVlBVX0cyPjsN
Cj4gKwkJCQkJfTsNCj4gKw0KPiArCQkJCQlwZ2NfdnB1X2gxOiBwb3dlci1kb21haW5AYyB7DQo+
ICsJCQkJCQkjcG93ZXItZG9tYWluLWNlbGxzID0gPDA+Ow0KPiArCQkJCQkJcmVnID0gPElNWDhN
TV9QT1dFUl9WUFVfSDE+Ow0KPiArCQkJCQl9Ow0KPiArCQkJCX07DQo+ICsJCQl9Ow0KPiAgCQl9
Ow0KPiANCj4gIAkJYWlwczI6IGJ1c0AzMDQwMDAwMCB7DQo+IC0tDQo+IDIuMjAuMQ0KDQo=
