Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74178C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491FB20828
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JYIGkWeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLXCye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 21:54:34 -0500
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:30947
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfLXCye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:54:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMODeEH84dcdFiCNi0WudFAm0teo0XE8BPs2OZqbVMpAjqUlRP4+U4g1ql0uWS+OoOyK9d3W0+K+S1pW6mjr+3jRVVln+o3tXpqKgYu4giQBttog5Uyxs4MfD3ByFNsGNJaBZACTBWdW+bMcM6n6Z7f187Td86YjOBsykyUcQR5h7eVAh/eQeEXaxtrUNidpthRCOxZL72B5+hLCKiTDXBqmRTQ6tZdhfDVnKvZEbAsgIAEOH8s5/dCZQcs4wtiaC1c4PpPOx0FRiw6qaq4vVoSrW+vYgwKtbX7pL9wb5ew4Zm428ehsdBXi8tzqTVx3Hz3pl1ApLcyMcooJHzB5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDRIxuTm2dHZQS6zVqG/M2Cc5y6PwnbuBQ7Wa/kZjI4=;
 b=LsOnV9L75lZl/whSbj3abCX/j7RsdTKz7SnjHUWuJxIcqiaGY8L6HyLGM1KuWLP3gxXvwPERVUh4gzGKeN+KLFnFCdYwBDPGMuCYAc7m81b+6eChAZsMeZFowUeIh4FgXMdUMNAihiKOQThQVGHGOmnZ23d1FhbS5A5yUagVO4krb2RRNe8gweXHqJl6SvQtV6b30D0HLqqcpnTTMFnlbIdwWjZylg82ORsyQ65GuMM5foAm5AAquFtLtIbcTM30zzTLV+2Zeh6Ez7VJohJmXY5WYlD2uyojiEb+1iRZ4Ed6Z7TczLl57HfMIDIR9UkOBZkwiMebaGQKH6xwciyILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDRIxuTm2dHZQS6zVqG/M2Cc5y6PwnbuBQ7Wa/kZjI4=;
 b=JYIGkWeSfoQPmkHKzSuAqJjcieUHEN9YO9e04hoxR8Zq93Uin0sKJ26c/w7bN8NxMx3H5gWljotUAhlkNriIyyvml+4L+plPJdYZpfKxpxBe/xZ6PmQdQZy3GVldy6xlBHipg2fOWIcLF4HXR7ZD6Sz6X4qoph4HvVR2wp3hAHg=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.228.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 02:54:24 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e%6]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 02:54:24 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Geis <pgwipeout@gmail.com>
Subject: RE: [PATCH v2 10/10] usb: chipidea: tegra: Add USB_TEGRA_PHY module
 to driver's dependencies
Thread-Topic: [PATCH v2 10/10] usb: chipidea: tegra: Add USB_TEGRA_PHY module
 to driver's dependencies
Thread-Index: AQHVttiri4OdXKSsD0CMcioiiuKO06fCZVIAgAAJlQCABNr+AIAAs9kAgACbdAA=
Date:   Tue, 24 Dec 2019 02:54:24 +0000
Message-ID: <VI1PR04MB5327ADFDE053ACA5ABAA85708B290@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20191220015238.9228-1-digetx@gmail.com>
 <20191220015238.9228-11-digetx@gmail.com>
 <20191220035650.GC19921@b29397-desktop>
 <fb7dee6e-e645-fe45-126c-c5f1e280bc26@gmail.com>
 <20191223063958.GD19921@b29397-desktop>
 <1d2e3ea0-a7ff-3e83-57d1-05ffddb0da07@gmail.com>
In-Reply-To: <1d2e3ea0-a7ff-3e83-57d1-05ffddb0da07@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ae87072-a649-4235-3d8c-08d7881c9577
x-ms-traffictypediagnostic: VI1PR04MB3247:
x-microsoft-antispam-prvs: <VI1PR04MB32475185BA7D971B586F31688B290@VI1PR04MB3247.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(316002)(86362001)(8676002)(44832011)(6916009)(186003)(52536014)(5660300002)(26005)(7696005)(71200400001)(9686003)(2906002)(478600001)(81156014)(66946007)(76116006)(966005)(66446008)(7416002)(81166006)(66476007)(53546011)(66556008)(45080400002)(55016002)(54906003)(8936002)(6506007)(64756008)(33656002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3247;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8XQ9gpSfD/akb39r5B4o0G9JefesxQYTax0s8JdLsobVIiJlRWvQHu7IrqfZ2vrlUvtD+2T/FLwr+IVn+jo4CQZxymYZj34gZrkc0Jl5VAvvK/vT19K3B8+UlfczUwMHxjz7N8CxNrq96R/NSRJM1mbSEkBUxSFf6oWXMSp8bf9cmHajCo2gsoiU7CLQ5HR+QnpXK09/TvRJA+VxHwBY+16qtvXI9QR7vHcUfKdCPQrhv2f6+CcnU05bxc4J7L4cdf538GdqIgvPNm5C8jHVjp3yQwxilpWV5bGULc3SAz/w2sspVQRSea/ULkZTTAS6vo0T55AAYMtBkn/EJcMKMq/iqUT2Dm0DzvQ6B25ExmIGoV4xsaQW2d0feMjS0Rg1xFi2FudKViCmcBq4i2GQ9A15LdqUFWIhidIEBpHoFamFXGON3BdvjSbcTbZeNiH4rm9niZgOgBi5bvGBOlvXxP0dU0GmoDgnX1Q07R+ZhFs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae87072-a649-4235-3d8c-08d7881c9577
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 02:54:24.3216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9um0r6ZNCsQlPjqylByd3YnCaSQEClDdxLA7PSwogkvSDLkb2HGHHmNvhcM1U1xGEPUPkM5A2SHSaYTyHPq0zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiANCj4gMjMuMTIuMjAxOSAwOTo0MCwgUGV0ZXIgQ2hlbiDQv9C40YjQtdGCOg0KPiA+IE9u
IDE5LTEyLTIwIDA3OjMxOjA4LCBEbWl0cnkgT3NpcGVua28gd3JvdGU6DQo+ID4+IDIwLjEyLjIw
MTkgMDY6NTYsIFBldGVyIENoZW4g0L/QuNGI0LXRgjoNCj4gPj4+IE9uIDE5LTEyLTIwIDA0OjUy
OjM4LCBEbWl0cnkgT3NpcGVua28gd3JvdGU6DQo+ID4+Pj4gTm93LCB3aGVuIGNpX2hkcmNfdGVn
cmEga2VybmVsIG1vZHVsZSBpcyBsb2FkZWQsIHRoZSBwaHlfdGVncmFfdXNiDQo+ID4+Pj4gbW9k
dWxlIGlzIGxvYWRlZCB0b28gcmVnYXJkbGVzcyBvZiBrZXJuZWwncyBjb25maWd1cmF0aW9uLg0K
PiA+Pj4+IFByZXZpb3VzbHkgdGhpcyBwcm9ibGVtIHdhcyBtYXNrZWQgYmVjYXVzZSBUZWdyYSdz
IEVIQ0kgZHJpdmVyIGlzDQo+ID4+Pj4gdXN1YWxseSBlbmFibGVkIGluIGtlcm5lbCdzIGNvbmZp
ZyBhbmQgdGh1cyBQSFkgZHJpdmVyIHdhcyBnZXR0aW5nDQo+ID4+Pj4gbG9hZGVkIGJlY2F1c2Ug
b2YgaXQsIGJ1dCBub3cgSSB3YXMgbWFraW5nIHNvbWUgbW9yZSB0aG9yb3VnaA0KPiA+Pj4+IHRl
c3RpbmcgYW5kIG5vdGljZWQgdGhhdCBQSFkncyBtb2R1bGUgaXNuJ3QgZ2V0dGluZyBhdXRvLWxv
YWRlZCB3aXRob3V0IHRoZQ0KPiBob3N0IGRyaXZlci4NCj4gPj4+Pg0KPiA+Pj4+IE5vdGUgdGhh
dCBDaGlwSWRlYSdzIGRyaXZlciBkb2Vzbid0IHVzZSBhbnkgb2YgdGhlIGV4cG9ydGVkDQo+ID4+
Pj4gZnVuY3Rpb25zIG9mIHBoeV90ZWdyYV91c2IgbW9kdWxlIGFuZCB0aHVzIHRoZSBtb2R1bGUg
bmVlZHMgdG8gYmUNCj4gcmVxdWVzdGVkIGV4cGxpY2l0bHkuDQo+ID4+Pj4NCj4gPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFpbC5jb20+DQo+ID4+Pj4gLS0t
DQo+ID4+Pj4gIGRyaXZlcnMvdXNiL2NoaXBpZGVhL0tjb25maWcgICAgICAgICB8IDEgKw0KPiA+
Pj4+ICBkcml2ZXJzL3VzYi9jaGlwaWRlYS9jaV9oZHJjX3RlZ3JhLmMgfCA2ICsrKysrKw0KPiA+
Pj4+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4+DQo+ID4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NoaXBpZGVhL0tjb25maWcNCj4gPj4+PiBiL2RyaXZlcnMv
dXNiL2NoaXBpZGVhL0tjb25maWcgaW5kZXggYWU4NTBiM2ZkZGYyLi5kNTNkYjUyMGUyMDkNCj4g
Pj4+PiAxMDA2NDQNCj4gPj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9jaGlwaWRlYS9LY29uZmlnDQo+
ID4+Pj4gKysrIGIvZHJpdmVycy91c2IvY2hpcGlkZWEvS2NvbmZpZw0KPiA+Pj4+IEBAIC03LDYg
KzcsNyBAQCBjb25maWcgVVNCX0NISVBJREVBDQo+ID4+Pj4gIAlzZWxlY3QgUkVTRVRfQ09OVFJP
TExFUg0KPiA+Pj4+ICAJc2VsZWN0IFVTQl9VTFBJX0JVUw0KPiA+Pj4+ICAJc2VsZWN0IFVTQl9S
T0xFX1NXSVRDSA0KPiA+Pj4+ICsJc2VsZWN0IFVTQl9URUdSQV9QSFkgaWYgQVJDSF9URUdSQQ0K
PiA+Pj4+ICAJaGVscA0KPiA+Pj4+ICAJICBTYXkgWSBoZXJlIGlmIHlvdXIgc3lzdGVtIGhhcyBh
IGR1YWwgcm9sZSBoaWdoIHNwZWVkIFVTQg0KPiA+Pj4+ICAJICBjb250cm9sbGVyIGJhc2VkIG9u
IENoaXBJZGVhIHNpbGljb24gSVAuIEl0IHN1cHBvcnRzOg0KPiA+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9jaGlwaWRlYS9jaV9oZHJjX3RlZ3JhLmMNCj4gPj4+PiBiL2RyaXZlcnMvdXNi
L2NoaXBpZGVhL2NpX2hkcmNfdGVncmEuYw0KPiA+Pj4+IGluZGV4IDc0NTVkZjBlZGU0OS4uOGJj
MTExMDAyNDVkIDEwMDY0NA0KPiA+Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL2NoaXBpZGVhL2NpX2hk
cmNfdGVncmEuYw0KPiA+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2NoaXBpZGVhL2NpX2hkcmNfdGVn
cmEuYw0KPiA+Pj4+IEBAIC01Myw2ICs1MywxMiBAQCBzdGF0aWMgaW50IHRlZ3JhX3VkY19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+Pj4+ICAJc3RydWN0IHRlZ3Jh
X3VkYyAqdWRjOw0KPiA+Pj4+ICAJaW50IGVycjsNCj4gPj4+Pg0KPiA+Pj4+ICsJaWYgKElTX01P
RFVMRShDT05GSUdfVVNCX1RFR1JBX1BIWSkpIHsNCj4gPj4+PiArCQllcnIgPSByZXF1ZXN0X21v
ZHVsZSgicGh5X3RlZ3JhX3VzYiIpOw0KPiA+Pj4+ICsJCWlmIChlcnIpDQo+ID4+Pj4gKwkJCXJl
dHVybiBlcnI7DQo+ID4+Pj4gKwl9DQo+ID4+Pj4gKw0KPiA+Pj4NCj4gPj4+IFdoeSB5b3UgZG8g
dGhpcyBkZXBlbmRlbmN5LCBpZiB0aGlzIGNvbnRyb2xsZXIgZHJpdmVyIGNhbid0IGdldCBVU0IN
Cj4gPj4+IFBIWSwgaXQgc2hvdWxkIHJldHVybiBlcnJvci4gV2hhdCdzIHRoZSByZXR1cm4gdmFs
dWUgYWZ0ZXIgY2FsbGluZw0KPiA+Pj4gYmVsb3c6DQo+ID4+Pg0KPiA+Pj4gCXVkYy0+cGh5ID0g
ZGV2bV91c2JfZ2V0X3BoeV9ieV9waGFuZGxlKCZwZGV2LT5kZXYsICJudmlkaWEscGh5IiwNCj4g
Pj4+IDApOw0KPiA+Pg0KPiA+PiBJdCByZXR1cm5zIC1FUFJPQkVfREVGRVIgd2hlbiBwaHlfdGVn
cmFfdXNiIGlzbid0IGxvYWRlZC4NCj4gPj4NCj4gPj4gU28gaWYgeW91J2xsIGRvOg0KPiA+Pg0K
PiA+PiAjIHJtbW9kIGNpX2hkcmNfdGVncmE7IHJtbW9kIGNpX2hkcmM7IHJtbW9kIHBoeV90ZWdy
YV91c2I7ICMgbW9kcHJvYmUNCj4gPj4gY2lfaGRyY190ZWdyYSAjIGxzbW9kDQo+ID4+IE1vZHVs
ZSAgICAgICAgICAgICAgICAgIFNpemUgIFVzZWQgYnkNCj4gPj4gY2lfaGRyY190ZWdyYSAgICAg
ICAgICAxNjM4NCAgMA0KPiA+PiBjaV9oZHJjICAgICAgICAgICAgICAgIDQ1MDU2ICAxIGNpX2hk
cmNfdGVncmENCj4gPj4NCj4gPj4gQWZ0ZXIgdGhpcyBwYXRjaDoNCj4gPj4NCj4gPj4gIyBybW1v
ZCBjaV9oZHJjX3RlZ3JhOyBybW1vZCBjaV9oZHJjOyBybW1vZCBwaHlfdGVncmFfdXNiOyAjIG1v
ZHByb2JlDQo+ID4+IGNpX2hkcmNfdGVncmEgIyBsc21vZA0KPiA+PiBNb2R1bGUgICAgICAgICAg
ICAgICAgICBTaXplICBVc2VkIGJ5DQo+ID4+IE1vZHVsZSAgICAgICAgICAgICAgICAgIFNpemUg
IFVzZWQgYnkNCj4gPj4gcGh5X3RlZ3JhX3VzYiAgICAgICAgICAyMDQ4MCAgMQ0KPiA+PiBjaV9o
ZHJjX3RlZ3JhICAgICAgICAgIDE2Mzg0ICAwDQo+ID4+IGNpX2hkcmMgICAgICAgICAgICAgICAg
NDUwNTYgIDEgY2lfaGRyY190ZWdyYQ0KPiA+DQo+ID4gSSB3b25kZXIgd2h5IHRoZSBkcml2ZXIg
bmVlZHMgc3VjaCBkZXBlbmRlbmN5PyBJZiB0aGVyZSBhcmUgdHdvIHBoeQ0KPiA+IGRyaXZlcnMg
Y291bGQgd29yayB3aXRoIHRoaXMgY29udHJvbGxlciBkcml2ZXIsIHlvdSBtYXkgcmVxdWVzdCB0
d28NCj4gPiBtb2R1bGVzLg0KPiANCj4gV2VsbCwgaWYgc29tZWJvZHkgd2FudHMgdG8gdXNlIHNv
bWUgUEhZIGRyaXZlciBvdGhlciB0aGFuIHRoZSB1cHN0cmVhbSdzDQo+IHN0YW5kYXJkIG9uZSwg
dGhlbiB0aGF0IHBlcnNvbiBjb3VsZCBzaW1wbHkgbG9hZCB0aGUgY3VzdG9tIGRyaXZlciBtb2R1
bGUgZmlyc3QsDQo+IHN1Y2ggdGhhdCBpdCB3aWxsIGJpbmQgdG8gdGhlIFBIWSdzIGRldmljZSBm
aXJzdC4NCj4gDQo+IEl0IGlzIGFsc28gcG9zc2libGUgdG8gbWFudWFsbHkgdW5iaW5kIHRoZSBz
dGFuZGFyZCBkcml2ZXIgZnJvbSBQSFkncyBkZXZpY2UgYW5kDQo+IHRoZW4gYmluZCB3aGF0ZXZl
ciBkcml2ZXIgeW91IHdhbnQuDQo+IA0KPiA+IERvZXNuJ3Qgc3VjaCBkZXBlbmRlbmN5IHNob3Vs
ZCBiZSBkb25lIGJ5IHRoZSBib2FyZCBsZXZlbCBzY3JpcHQ/DQo+IA0KPiBUaGlzIHBhdGNoIG9u
bHkgaW1wcm92ZXMgdGhlIGRlZmF1bHQgYmVoYXZpb3VyIHRoYXQgaXMgY29tbW9uIGZvciBhbGwg
TlZJRElBIFRlZ3JhDQo+IGJvYXJkcywgaXQgZG9lc24ndCBwcmV2ZW50IGZyb20gZG9pbmcgYW55
IHNwZWNpYWwgY3VzdG9taXphdGlvbnMuDQo+IA0KPiBQZXJoYXBzIHRoZSBLY29uZmlnIGNoYW5n
ZSBjb3VsZCBiZSBkcm9wcGVkIGZyb20gdGhpcyBwYXRjaCBpbiBvcmRlciB0byBwcm92aWRlIGEN
Cj4gYml0IG1vcmUgZmxleGliaWxpdHkgaW4gcmVnYXJkcyB0byBrZXJuZWwncyBjb25maWd1cmF0
aW9uLCBidXQgSSdtIHZlcnkgZG91YnRmdWwgdGhhdA0KPiByZWFsaXN0aWNhbGx5IGFueW9uZSB3
b3VsZCB3YW50IHRvIHJlcGxhY2UgdGhlIGRlZmF1bHQgZHJpdmVyIHdpdGggYW55dGhpbmcgZWxz
ZSBvbg0KPiBUZWdyYS4gVGhlIEtjb25maWcgY2hhbmdlIGFsc28gcHV0cyBDaGlwSWRlYSdzIFVE
QyBkcml2ZXIgaW4gbGluZSB3aXRoIHRoZSBUZWdyYSdzDQo+IEVIQ0kgZHJpdmVyIHRoYXQgc2Vs
ZWN0cyBVU0JfVEVHUkFfUEhZLCBwbGVhc2Ugc2VlIGRyaXZlcnMvdXNiL2hvc3QvS2NvbmZpZy4N
Cj4gDQo+ID4gRG8geW91IGtub3cgYXJlIHRoZXJlIGFueSBvdGhlciBkcml2ZXJzIGRvIHN1Y2gg
dGhpbmdzPw0KPiANCj4gSSBkb24ndCB0aGluayB0aGF0IGFueSBvZiB0aGUgVVNCIGhvc3QgZHJp
dmVycyBhcmUgY3VycmVudGx5IGRvaW5nIHN1Y2ggdGhpbmdzLCBidXQgaW4NCj4gZ2VuZXJhbCB0
aGVyZSBhcmUgcXVpdGUgYSBsb3Qgb2YgZHJpdmVycyBpbiBrZXJuZWwgdGhhdCBhcmUgdXNpbmcg
cmVxdWVzdF9tb2R1bGUgWzFdLg0KPiANCj4gWzFdDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmVsaXhpci5ib290bGlu
LmMNCj4gb20lMkZsaW51eCUyRmxhdGVzdCUyRmlkZW50JTJGcmVxdWVzdF9tb2R1bGUmYW1wO2Rh
dGE9MDIlN0MwMSU3Q3BldGUNCj4gci5jaGVuJTQwbnhwLmNvbSU3Q2ExNTNiOWU0ZDgxMDQ0Y2Rl
M2MxMDhkNzg3Y2NkY2I5JTdDNjg2ZWExZDNiYzJiDQo+IDRjNmZhOTJjZDk5YzVjMzAxNjM1JTdD
MCU3QzAlN0M2MzcxMjcxODYyNTc2MTIyNjkmYW1wO3NkYXRhPXhPVm5uDQo+IGJWR1JWaHlwYmlN
V3B0Mk1VZmNZYXlBbDR5d3BDYTd4T0FRMXZrJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBQbGVh
c2Ugbm90ZSB0aGF0IGRyaXZlcnMvdXNiL2hvc3QvZWhjaS10ZWdyYS5jIHVzZXMgZXhwb3J0ZWQg
c3ltYm9scyBmcm9tDQo+IHVzYi9waHkvcGh5LXRlZ3JhLXVzYi5jIGFuZCB0aGF0IGlzIHdoeSB0
aGUgRUhDSSBkcml2ZXIgZG9lc24ndCBuZWVkIHRvIGV4cGxpY2l0bHkNCj4gbG9hZCB0aGUgcGh5
X3RlZ3JhX3VzYiBtb2R1bGUsIHRoZSBsb2FkIGhhcHBlbnMgYXV0b21hdGljYWxseSBiZWNhdXNl
IG9mIHRoZQ0KPiBtaXNzaW5nIHN5bWJvbHMuDQo+IA0KPiBBbHNvLCBwbGVhc2Ugbm90ZSB0aGF0
IGl0IGlzIHBvc3NpYmxlIHRvIHNxdWFzaCB0aGUgVGVncmEgRUhDSSBkcml2ZXIgaW50bw0KPiBj
aV9oZHJjX3RlZ3JhLmMgYW5kIHRoZW4gdGhlIGV4cGxpY2l0IGRlcGVuZGVuY3kgb24gdGhlIHBo
eV90ZWdyYV91c2Igd29uJ3QgYmUNCj4gbmVlZGVkIGFueW1vcmUgc2luY2UgaXQgd2lsbCBiZSBy
ZXBsYWNlZCB3aXRoIGFuIGltcGxpY2l0IGRlcGVuZGVuY3kuIFdlIChtZSBhbmQNCj4gUGV0ZXIg
R2VpcykgYWxyZWFkeSBoYWQgc29tZSBleHBlcmltZW50YWwgcGF0Y2hlcyB0aGF0IGRvIHRoZSBz
dWNjZXNzZnVsDQo+IHNxdWFzaGluZyBvZiB0aGUgZHJpdmVycywgYnV0IGxvb2tzIGxpa2UgUGV0
ZXIgZ290IHNpZGV0cmFja2VkIGZvciBhIG1vcmUgaW1wb3J0YW50DQo+IHRoaW5ncyBmb3Igbm93
LCB3ZSdsbCBwcm9iYWJseSByZXR1cm4gdG8gdGhhdCB3b3JrIGxhdGVyIG9uLg0KDQpIaSBEbWl0
cnksDQoNClRoYW5rcyBmb3IgZXhwbGFpbmluZyBpdC4gIEluIGZhY3QsIHlvdXIgY2FzZSBpcyB2
ZXJ5IGNvbW1vbiBmb3IgVVNCIHNpbmNlIFBIWSBkcml2ZXINCmFuZCBjb250cm9sbGVyIGRyaXZl
ciBhcmUgdHdvIGluZGVwZW5kZW50IGRyaXZlcnMuICBJZiB5b3UgaGF2ZSBubyBvdGhlciB3YXlz
DQp0byBmaXggdGhpcyBkZXBlbmRlbmN5IGlzc3VlLCBpdCBpcyBvayB0byBhZGQgaXQgYXQgZHJp
dmVyLg0KDQpQZXRlcg0K
