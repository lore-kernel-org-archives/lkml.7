Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D337C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0162187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3nFOxHmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfKGWoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:44:03 -0500
Received: from mail-eopbgr820054.outbound.protection.outlook.com ([40.107.82.54]:17692
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfKGWoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:44:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/e1ANGTBTS1qJhfFcVL2LLTStSPbSD5J359ENfMOVXynbGy7gM07I6VJrnLp9EBlyY2P7stpLoPPKkQvsUtvQw7rdgeRsCjxjn4eKfkvtIqdQmzgG7tU89lI2BETZCuuvLAo9AuIt2Vd+DlBh7L6d9b21vb8V690wYuEdlBI3Z6zyEiLe8MZqHs58UTeyiEQwTLVPhssBAKo4h+TYOgwDMxtjp9dVcwXZLhZpDK8BtSylqzCO3lcOj2mB3dQgvzQk0BD+Uukt40xI9xCpYw5zwjxHV5l1OuQDBRGzd6dPg9bDSZ9jdvKMbciqPQ/zrQeeAw2HjmvaqNtRq8jup3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb62Vy/faSokp0T320ArZnB9rF78SgShDuWoOYYWHw8=;
 b=dgntx5U1SViztoV9XQYgAfm+tu2bophvARn1QHPKzxiETsZLGdUywOEbspkbdEbKzcYw3zTU79Hu5uKyeHt5o8wtx4Rl7RGayhlP+m7sQIUHwXDjgu9W9Kqsr/qqfE8CnGXdmnHlwapb9mEXUdAU5exBj5w9w2ihRS08OesMHkUMRA6oiNOqJjyPAsd6yLSnrxvOG32mOnvMocv+X+ZN0icsH02rj/XeT/jpHIjoi3PcCOwzX4SlNJdnNLBkextg0cG+dPtE4kYCxy63A6dOA6hO7qtUBYDyeFc0fZslOfLo8NOKCXZj7yyPUbSvOi8eiiJ5PPAfdmDRWu/nITqXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb62Vy/faSokp0T320ArZnB9rF78SgShDuWoOYYWHw8=;
 b=3nFOxHmpLOd6RYYBtbJaBHDDWM2DhI+qTu5OQCbpSyzgJH/149GodEcQCcMU7bIM9QF1IotnEsPu/0ikoX01yEfZOpJPj76bm/Li0LYuNuRnPVv61MUOaZnxGcumlkrHyhgH6Kp2zPv+EXaJNep0e5AUmOXsYkrxbF4y3cwOnyc=
Received: from CY4PR12MB1813.namprd12.prod.outlook.com (10.175.80.21) by
 CY4PR12MB1624.namprd12.prod.outlook.com (10.172.69.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 7 Nov 2019 22:43:21 +0000
Received: from CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc]) by CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc%4]) with mapi id 15.20.2408.025; Thu, 7 Nov 2019
 22:43:21 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Frederick Lawler <fred@fredlawl.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] drm: replace magic nuumbers
Thread-Topic: [PATCH 0/2] drm: replace magic nuumbers
Thread-Index: AQHVlbmp0mAqJ9DIz02QItAkIGuxDaeATYQg
Date:   Thu, 7 Nov 2019 22:43:20 +0000
Message-ID: <CY4PR12MB1813997898E8B03859E5F457F7780@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191107222047.125496-1-helgaas@kernel.org>
In-Reply-To: <20191107222047.125496-1-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d6da0a3-65a6-4796-c0ec-08d763d3e430
x-ms-traffictypediagnostic: CY4PR12MB1624:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB162422E794599A2B66363D82F7780@CY4PR12MB1624.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(13464003)(189003)(199004)(25786009)(66946007)(66446008)(64756008)(316002)(110136005)(54906003)(66556008)(66476007)(2906002)(478600001)(966005)(256004)(4326008)(8676002)(8936002)(81166006)(81156014)(6436002)(33656002)(5660300002)(26005)(476003)(99286004)(6506007)(86362001)(6246003)(486006)(229853002)(11346002)(53546011)(102836004)(446003)(7696005)(52536014)(76176011)(9686003)(66066001)(6306002)(55016002)(7736002)(305945005)(6116002)(3846002)(186003)(76116006)(71190400001)(71200400001)(14454004)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1624;H:CY4PR12MB1813.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQnRaEQs4ysiLeJocYdw32TjtpitgUqWy27HpwFo4kcXHdh0rfaPNgf/mvRgNJ2FQJjzsIp1ZyCAZMfUEbukuXfV9oOY6oftN6QY/JuGmrIGW40mFTtYhwZCpBJYcxmoblg7QwdATNX/JsaJM6GxjIpbWnpnvBQPr8hN6U9W/uyv5yIxKG05K9a2j5mx959yw4nwkaM0hkqNGajNGPOJg/UKiq75sWqB1LAquiEC8KK1NI8BYyAAOcNoNNCVk0Gzizy785n7QHGpj7GtCnfIfs8vKyzlRCkFZY5oCse2dGzfQVowP6WNv1/YwS2Kkm+SuOW5z8BXg/Sakr1EZPSDrBFCKDS+L0lTKRsvJPFW8iPduynRgx8Bb8tqthKCoEIQezhGYX8xQq803HaNclWdtBJ10tYjwlFvf5+Iv2tvrBRDLEdiLhdzeTRa2SBIcuNNjAH0PTIEcL3HwP3WOjxRwIgB42Cxr79ea9ucPNt6SMA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6da0a3-65a6-4796-c0ec-08d763d3e430
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 22:43:20.8186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qg/PlKxoFNXb2vXr8t2MqTr66f/t5xZDK3Ldlucylrk+4Xf8l4BagvfvTYe5dRG/0gDwGhCtQxo+90dETKdfpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1624
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJv
dW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gQmpvcm4gSGVsZ2Fh
cw0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgNywgMjAxOSA1OjIxIFBNDQo+IFRvOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlz
dGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWmhvdSwgRGF2aWQoQ2h1bk1pbmcp
DQo+IDxEYXZpZDEuWmhvdUBhbWQuY29tPjsgRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4Lmll
PjsgRGFuaWVsIFZldHRlcg0KPiA8ZGFuaWVsQGZmd2xsLmNoPg0KPiBDYzogQmpvcm4gSGVsZ2Fh
cyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBGcmVkZXJpY2sgTGF3bGVyIDxmcmVk
QGZyZWRsYXdsLmNvbT47DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogW1BBVENIIDAvMl0gZHJtOiByZXBsYWNlIG1hZ2ljIG51dW1iZXJzDQo+IA0KPiBGcm9tOiBC
am9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiANCj4gYW1kZ3B1IGFuZCByYWRl
b24gZG8gYSBiaXQgb2YgbXVja2luZyB3aXRoIHRoZSBQQ0llIExpbmsgQ29udHJvbCAyIHJlZ2lz
dGVyLA0KPiBzb21lIG9mIGl0IHVzaW5nIGhhcmQtY29kZWQgbWFnaWMgbnVtYmVycy4gIFRoZSBp
ZGVhIGhlcmUgaXMgdG8gcmVwbGFjZQ0KPiB0aG9zZSB3aXRoICNkZWZpbmVzLg0KPiANCj4gSSBo
YXZlbid0IHNpZ25lZCBvZmYgb24gdGhlc2UgYmVjYXVzZSB0aGUgZmlyc3Qgb25lIGFjdHVhbGx5
IGNoYW5nZXMgdGhlIGJpdHMNCj4gaW52b2x2ZWQgYmVjYXVzZSB0aGUgZXhpc3RpbmcgY29kZSBs
b29rcyBsaWtlIGl0IG1pZ2h0IGhhdmUgYSB0eXBvLg0KPiBCdXQgSSBoYXZlIG5vIHdheSB0byBr
bm93IGZvciBzdXJlLg0KPiANCg0KSXQgaXMgYSB0eXBvLiAgWW91ciBwYXRjaGVzIGxvb2sgY29y
cmVjdCB0byBtZS4gIFRoZSBzZXJpZXMgaXM6DQpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQo+IEkgZG9uJ3QgaW50ZW5kIHRoZSBUYXJnZXQg
TGluayBTcGVlZCBwYXRjaCB0byBjaGFuZ2UgYW55dGhpbmcsIHNvIGl0IHNob3VsZCBiZQ0KPiBz
dHJhaWdodGZvcndhcmQgdG8gcmV2aWV3Lg0KPiANCj4gQmpvcm4gSGVsZ2FhcyAoMik6DQo+ICAg
ZHJtOiByZXBsYWNlIENvbXBsaWFuY2UvTWFyZ2luIG1hZ2ljIG51bWJlcnMgd2l0aCBQQ0lfRVhQ
X0xOS0NUTDINCj4gICAgIGRlZmluaXRpb25zDQo+ICAgZHJtOiByZXBsYWNlIFRhcmdldCBMaW5r
IFNwZWVkIG1hZ2ljIG51bWJlcnMgd2l0aCBQQ0lfRVhQX0xOS0NUTDINCj4gICAgIGRlZmluaXRp
b25zDQo+IA0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrLmMgfCAyMiArKysrKysr
KysrKysrKy0tLS0tLS0tDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpLmMgIHwgMTgg
KysrKysrKysrKystLS0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npay5jICAgICB8
IDIyICsrKysrKysrKysrKysrLS0tLS0tLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2ku
YyAgICAgIHwgMjIgKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAgaW5jbHVkZS91YXBpL2xpbnV4
L3BjaV9yZWdzLmggICAgfCAgMiArKw0KPiAgNSBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25z
KCspLCAzMSBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuMjQuMC5yYzEuMzYzLmdiMWJjY2Qz
ZTNkLWdvb2cNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA0K
