Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47FBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884EC2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PmXBc/r5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfC0Nn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:43:28 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:58341
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728324AbfC0Nn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA1vj5bKWGJq3ekz/gKYY8pCRCdIzsvnkGT0nkaq4tc=;
 b=PmXBc/r5htt6AHaYNzxPI87nnucWXF5VbwyVcHcADmaUNFfoow02B/tqaoywGgL6FZ+iI9+fWq367UYvz03QegP0Up0iGJHmjEY3oYJo7UqccJkkZohOTJk7SoMqErwg1lMKMXFH3froW4SAy0zTRoMlIleTSj/juoosE1/cmd4=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1SPR8PMB24.eurprd04.prod.outlook.com (10.166.44.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 13:43:17 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::80a9:797d:58c0:1295]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::80a9:797d:58c0:1295%3]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 13:43:17 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Steven Price <steven.price@arm.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Ying Zhang <ying.zhang22455@nxp.com>
CC:     "upstream-release@linux.nxdi.nxp.com" 
        <upstream-release@linux.nxdi.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND] i2c: imx: defer probing on dma channel request
Thread-Topic: [RESEND] i2c: imx: defer probing on dma channel request
Thread-Index: AQHU4x+p/rwFVSG6cE2tH9IQ48eyYqYclZ+AgALqMQA=
Date:   Wed, 27 Mar 2019 13:43:17 +0000
Message-ID: <1f3a370e-1c47-2fcb-6816-2b136713c68d@nxp.com>
References: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
 <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com>
In-Reply-To: <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b64a14f0-b357-458d-8693-08d6b2ba2b26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1SPR8PMB24;
x-ms-traffictypediagnostic: VI1SPR8PMB24:
x-microsoft-antispam-prvs: <VI1SPR8PMB2490C13954D782B935AA1BEC580@VI1SPR8PMB24.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(39860400002)(376002)(51234002)(189003)(199004)(54906003)(229853002)(110136005)(31686004)(8676002)(99286004)(6636002)(8936002)(71190400001)(71200400001)(31696002)(316002)(478600001)(6486002)(6436002)(14454004)(2501003)(97736004)(45080400002)(68736007)(53936002)(6512007)(44832011)(105586002)(186003)(305945005)(102836004)(25786009)(6116002)(4326008)(6246003)(3846002)(106356001)(2616005)(26005)(53546011)(476003)(2906002)(5660300002)(14444005)(66066001)(486006)(6506007)(86362001)(81156014)(81166006)(446003)(36756003)(7736002)(11346002)(256004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR8PMB24;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y86aVpWyl639BsFK6/TjfJ6JHXQVvApYuuKl6Adud4ApGd1c7mLT1ViHtIGtCPPb5Mom7kD//n//w+TfJqVp+Bts1Zm6rCOVfNmVvMNsR2qEGQCncOXN80cy+P6mEJxc651W/J/7w8lgBB6jpEGPrjnOSeM+pMKCKdc7hlkVN1ThbuG0y/r/63HVcim/EVA/CIV0yc9mKTZyC6zOX3Rk+bXK1pOYZ0qXyY8l9JPYX4ov2wqThQ3JOeYehypQJAPjYwsq+HoVMZIYvS5m6XEl2DsMqlNXOCDjhCXfxl+HpnkwH27BkI1mry3rghfwvrhyri0acig05Yu6Rm0mVQaWICKPsydVB7eDRrK6P9gbzzm+hLwEx3cBZdlbeKbHAkJ20Pwoq0HDcYUAlG2k2FXijbjcBF6Q+T22QfsOs2Fuvk8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBD239C3274503438825854AB3A0E7EE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64a14f0-b357-458d-8693-08d6b2ba2b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 13:43:17.5719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR8PMB24
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCkp1c3QgRllJLCBJJ20gc3RpbGwgc2VlaW5nIGlzc3VlcyB3aXRoIHRoZSBkbWEg
ZHJpdmVyIGNvbXBpbGVkIF9vdXRfLCANCnRyeWluZyB0byB0ZXN0IGkyYyB3aXRob3V0IGRtYSBz
dXBwb3J0LiBJIGdldCB0aGUgY3Jhc2ggYmVsb3cgaW4gZ2VuZXJpYyANCmRyaXZlciBjb2RlIGxh
dGVyIGluIHRoZSBib290IHByb2Nlc3MsIGRlYnVnIGlzIGluIHByb2dyZXNzLg0KDQpQLlMuIFRo
aXMgaXMgc2VlbiBvbiBhbiBOWFAgTFMxMDQzQSBjaGlwLg0KDQpbICAgIDUuMTUyNjk3XSBVbmFi
bGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgDQp2aXJ0dWFs
IGFkZHJlc3MgMDAwMDAwMDAwMDAwMDAxMA0KWyAgICA1LjE2MTQ4M10gTWVtIGFib3J0IGluZm86
DQpbICAgIDUuMTY0MzExXSAgIEVTUiA9IDB4OTYwMDAwMDQNClsgICAgNS4xNjc0MDddICAgRXhj
ZXB0aW9uIGNsYXNzID0gREFCVCAoY3VycmVudCBFTCksIElMID0gMzIgYml0cw0KWyAgICA1LjE3
MzM5MV0gZGV2aWNlX2luaXRpYWxpemU6IGRldiA9IGZmZmY4MDAwMjc3NTY4MDgNClsgICAgNS4x
Nzg0NDZdIHVzYiA0LTE6IG5ldyBTdXBlclNwZWVkIEdlbiAxIFVTQiBkZXZpY2UgbnVtYmVyIDIg
dXNpbmcgDQp4aGNpLWhjZA0KWyAgICA1LjE4NTQ4OV0gICBTRVQgPSAwLCBGblYgPSAwDQpbICAg
IDUuMTg4NTMyXSAgIEVBID0gMCwgUzFQVFcgPSAwDQpbICAgIDUuMTkxNjc2XSBEYXRhIGFib3J0
IGluZm86DQpbICAgIDUuMTk0NTk5XSAgIElTViA9IDAsIElTUyA9IDB4MDAwMDAwMDQNClsgICAg
NS4xOTg0NzZdICAgQ00gPSAwLCBXblIgPSAwDQpbICAgIDUuMjAxNDg1XSBbMDAwMDAwMDAwMDAw
MDAxMF0gdXNlciBhZGRyZXNzIGJ1dCBhY3RpdmVfbW0gaXMgc3dhcHBlcg0KWyAgICA1LjIwNzg5
NF0gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDk2MDAwMDA0IFsjMV0gUFJFRU1QVCBTTVANClsgICAg
NS4yMTM0NTVdIE1vZHVsZXMgbGlua2VkIGluOg0KWyAgICA1LjIxNjUwMl0gQ1BVOiAwIFBJRDog
MTggQ29tbToga3dvcmtlci8wOjEgTm90IHRhaW50ZWQgDQo1LjEuMC1yYzItbmV4dC0yMDE5MDMy
Ny0wMDAyMS1nN2IxYTRjMDc1MzgxLWRpcnR5ICMxNQ0KWyAgICA1LjIyNjQ4OV0gSGFyZHdhcmUg
bmFtZTogTFMxMDQzQSBSREIgQm9hcmQgKERUKQ0KWyAgICA1LjIzMTE4OV0gV29ya3F1ZXVlOiBl
dmVudHMgZGVmZXJyZWRfcHJvYmVfd29ya19mdW5jDQpbICAgIDUuMjM2MzE3XSBwc3RhdGU6IGEw
MDAwMDA1IChOekN2IGRhaWYgLVBBTiAtVUFPKQ0KWyAgICA1LjI0MTA5OF0gcGMgOiBkZXZpY2Vf
cmVvcmRlcl90b190YWlsKzB4MTNjLzB4MWI4DQpbICAgIDUuMjQ1OTY1XSBsciA6IGRldmljZV9y
ZW9yZGVyX3RvX3RhaWwrMHhkOC8weDFiOA0KWyAgICA1LjI1MDc0M10gc3AgOiBmZmZmMDAwMDEx
ODIzYzcwDQpbICAgIDUuMjU0MDQ2XSB4Mjk6IGZmZmYwMDAwMTE4MjNjNzAgeDI4OiAwMDAwMDAw
MDAwMDAwMDAwDQpbICAgIDUuMjU5MzQ3XSB4Mjc6IGZmZmYwMDAwMTE3YWJjZDggeDI2OiBmZmZm
MDAwMDExMjkzYTIwDQpbICAgIDUuMjY0NjQ5XSB4MjU6IGZmZmYwMDAwMTEwMmEwMDAgeDI0OiBm
ZmZmMDAwMDExMDJhNzA4DQpbICAgIDUuMjY5OTUwXSB4MjM6IGZmZmYwMDAwMTEwMmE3MDAgeDIy
OiBmZmZmMDAwMDEwZDI4MDAwDQpbICAgIDUuMjc1MjUxXSB4MjE6IGZmZmY4MDAwNzM5M2I5YTAg
eDIwOiBmZmZmZmZmZmZmZmZmZmY4DQpbICAgIDUuMjgwNTUyXSB4MTk6IGZmZmY4MDAwNzM5M2I4
ZjAgeDE4OiBmZmZmZmZmZmZmZmZmZmZmDQpbICAgIDUuMjg1ODUzXSB4MTc6IDAwMDAwMDAwMDAw
MDAwMDIgeDE2OiAwMDAwMDAwMDAwMDAwMDAwDQpbICAgIDUuMjkxMTU0XSB4MTU6IGZmZmYwMDAw
MTEyN2Q2YzggeDE0OiAwMDAwMDAwMDAwMDAwMTdlDQpbICAgIDUuMjk2NDU0XSB4MTM6IDAwMDAw
MDAwMDAwMDAwMDEgeDEyOiAwMDAwMDAwMDAwMDAwMDAwDQpbICAgIDUuMzAxNzU1XSB4MTE6IDAw
MDAwMDAwMDAwMDAwMDAgeDEwOiAwMDAwMDAwMDAwMDAwOTgwDQpbICAgIDUuMzA3MDU1XSB4OSA6
IGZmZmYwMDAwMTE4MjM4YzAgeDggOiBmZmZmODAwMDczODcyNTYwDQpbICAgIDUuMzEyMzU2XSB4
NyA6IGZmZmY4MDAwNzM4NzFkMDAgeDYgOiAwMDAwMDAwMDAwMDAwMDU4DQpbICAgIDUuMzE3NjU2
XSB4NSA6IDAwMDAwMDAwMDAwMDAwMGYgeDQgOiAwMDAwMDAwMDAwMDAwMTAwDQpbICAgIDUuMzIy
OTU3XSB4MyA6IDAwMDA4MDAwNmEzNTEwMDAgeDIgOiAwOTkxZWMwNWI3NTM0MjAwDQpbICAgIDUu
MzI4MjU3XSB4MSA6IGZmZmZmZmZmZmZmZmZmZjggeDAgOiAwMDAwMDAwMDAwMDAwMDAwDQpbICAg
IDUuMzMzNTYwXSBQcm9jZXNzIGt3b3JrZXIvMDoxIChwaWQ6IDE4LCBzdGFjayBsaW1pdCA9IA0K
MHgoX19fX3B0cnZhbF9fX18pKQ0KWyAgICA1LjM0MDUwOV0gQ2FsbCB0cmFjZToNClsgICAgNS4z
NDI5NDVdICBkZXZpY2VfcmVvcmRlcl90b190YWlsKzB4MTNjLzB4MWI4DQpbICAgIDUuMzQ3NDY2
XSAgZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKzB4NTAvMHhhOA0KWyAgICA1LjM1MTcyNV0gIGRldmlj
ZV9yZW9yZGVyX3RvX3RhaWwrMHhjNC8weDFiOA0KWyAgICA1LjM1NjE1N10gIGRldmljZV9wbV9t
b3ZlX3RvX3RhaWwrMHgzNC8weDUwDQpbICAgIDUuMzYwNTAyXSAgZGVmZXJyZWRfcHJvYmVfd29y
a19mdW5jKzB4NjQvMHhhMA0KWyAgICA1LjM2NTAyM10gIHByb2Nlc3Nfb25lX3dvcmsrMHgxYzgv
MHgzMjANClsgICAgNS4zNjkwMjFdICB3b3JrZXJfdGhyZWFkKzB4MjM0LzB4NDI4DQpbICAgIDUu
MzcyNzYxXSAga3RocmVhZCsweGY0LzB4MTIwDQpbICAgIDUuMzc1ODkyXSAgcmV0X2Zyb21fZm9y
aysweDEwLzB4MTgNClsgICAgNS4zNzk0NThdIENvZGU6IDkxMWMyMzE4IDkxMWMwMmY3IGQwMDA0
ZTE5IGI0MDAwMjc0IChmOTQwMGU4NCkNClsgICAgNS4zODU1NDFdIC0tLVsgZW5kIHRyYWNlIGFi
NGIxNTFkMzQ2YThkNDEgXS0tLQ0KDQotLS0NCkJlc3QgUmVnYXJkcywgTGF1cmVudGl1DQoNCk9u
IDI1LjAzLjIwMTkgMTk6MTIsIFN0ZXZlbiBQcmljZSB3cm90ZToNCj4gT24gMjUvMDMvMjAxOSAx
NTozMCwgbGF1cmVudGl1LnR1ZG9yQG54cC5jb20gd3JvdGU6DQo+PiBGcm9tOiBMYXVyZW50aXUg
VHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0KPj4NCj4+IElmIHRoZSBkbWEgY29udHJv
bGxlciBpcyBub3QgeWV0IHByb2JlZCwgZGVmZXIgaTJjIHByb2JlLg0KPj4gVGhlIGVycm9yIHBh
dGggaW4gcHJvYmUgd2FzIHNsaWdodGx5IG1vZGlmaWVkIChubyBmdW5jdGlvbmFsIGNoYW5nZSkN
Cj4gDQo+IFRoZXJlIGlzIGEgZnVuY3Rpb25hbCBjaGFuZ2UgZm9yIGNhc2VzIGxpa2U6DQo+IA0K
Pj4gCXJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoJnBkZXYtPmRldik7DQo+PiAJaWYgKHJldCA8
IDApDQo+PiAJCWdvdG8gcnBtX2Rpc2FibGU7DQo+IA0KPiAuLi5hcyBycG1fZGlzYWJsZSB3aWxs
IG5vIGxvbmdlciBmYWxsIHRocm91Z2ggdG8gdGhlIGNhbGwgb2YNCj4gY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKCkuDQo+IA0KPj4gdG8gYXZvaWQgdHJpZ2dlcmluZyB0aGlzIFdBUk5fT04oKToNCj4+
ICJjZy1wbGwwLWRpdjEgYWxyZWFkeSBkaXNhYmxlZA0KPj4gV0FSTklORzogQ1BVOiAxIFBJRDog
MSBhdCBkcml2ZXJzL2Nsay9jbGsuYzo4MjggY2xrX2NvcmVfZGlzYWJsZSsweGE4LzB4YjAiDQo+
IA0KPiBJJ20gYWxzbyBub3Qgc3VyZSBob3cgdGhpcyBXQVJOX09OIHdhcyBoaXQuIGkyY19pbXhf
cHJvYmUoKSBjYWxscw0KPiBjbGtfcHJlcGFyZV9lbmFibGUoKSB3aGljaCBzaG91bGQgaW5jcmVt
ZW50IHRoZSByZWZlcmVuY2UgY291bnQuIFNvIGl0DQo+IHNob3VsZCBhbHdheXMgYmUgcG9zc2li
bGUgdG8gZGVjcmVtZW10IHRoZSBlbmFibGVfY291bnQuIFdoYXQgYW0gSSBtaXNzaW5nPw0KPiAN
Cj4+IFNpZ25lZC1vZmYtYnk6IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5j
b20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXguYyB8IDIxICsrKysr
KysrKysrKystLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwg
OCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2ky
Yy1pbXguYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMNCj4+IGluZGV4IDQyZmVkNDAx
OThhMC4uNGUzNGIxNTcyNzU2IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2ky
Yy1pbXguYw0KPj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXguYw0KPj4gQEAgLTEx
MTEsNyArMTExMSw4IEBAIHN0YXRpYyBpbnQgaTJjX2lteF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPj4gICAJCQkJcGRldi0+bmFtZSwgaTJjX2lteCk7DQo+PiAgIAlpZiAo
cmV0KSB7DQo+PiAgIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiY2FuJ3QgY2xhaW0gaXJxICVkXG4i
LCBpcnEpOw0KPj4gLQkJZ290byBjbGtfZGlzYWJsZTsNCj4+ICsJCWNsa19kaXNhYmxlX3VucHJl
cGFyZShpMmNfaW14LT5jbGspOw0KPj4gKwkJcmV0dXJuIHJldDsNCj4+ICAgCX0NCj4+ICAgDQo+
PiAgIAkvKiBJbml0IHF1ZXVlICovDQo+PiBAQCAtMTE2MSwxOSArMTE2MiwyNSBAQCBzdGF0aWMg
aW50IGkyY19pbXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAgCXBt
X3J1bnRpbWVfbWFya19sYXN0X2J1c3koJnBkZXYtPmRldik7DQo+PiAgIAlwbV9ydW50aW1lX3B1
dF9hdXRvc3VzcGVuZCgmcGRldi0+ZGV2KTsNCj4+ICAgDQo+PiArCS8qIEluaXQgRE1BIGNvbmZp
ZyBpZiBzdXBwb3J0ZWQgKi8NCj4+ICsJcmV0ID0gaTJjX2lteF9kbWFfcmVxdWVzdChpMmNfaW14
LCBwaHlfYWRkcik7DQo+PiArCWlmIChyZXQpIHsNCj4+ICsJCWlmIChyZXQgIT0gLUVQUk9CRV9E
RUZFUikNCj4+ICsJCQlkZXZfaW5mbygmcGRldi0+ZGV2LCAiY2FuJ3QgdXNlIERNQSwgdXNpbmcg
UElPIGluc3RlYWQuXG4iKTsNCj4+ICsJCWVsc2UNCj4+ICsJCQlnb3RvIGRlbF9hZGFwdGVyOw0K
Pj4gKwl9DQo+PiArDQo+IA0KPiBUaGlzIGNhbiBiZSBzaW1wbGlmaWVkIGJ5IHJldmVyc2luZyB0
aGUgY29uZGl0aW9uOg0KPiANCj4gCWlmIChyZXQpIHsNCj4gCQlpZiAocmV0ID09IC1FUFJPQkVf
REVGRVIpDQo+IAkJCWdvdG8gZGVsX2FkYXB0ZXI7DQo+IAkJZGV2X2luZm8oKTsNCj4gCX0NCj4g
DQo+IG9yIGV2ZW46DQo+IA0KPiAJaWYgKHJldCA9PSAtRVBST0JFX0RFRkVSKQ0KPiAJCWdvdG8g
ZGVsX2FkYXB0ZXI7DQo+IAllbHNlIGlmIChyZXQpDQo+IAkJZGV2X2luZm8oKTsNCj4gDQo+PiAg
IAlkZXZfZGJnKCZpMmNfaW14LT5hZGFwdGVyLmRldiwgImNsYWltZWQgaXJxICVkXG4iLCBpcnEp
Ow0KPj4gICAJZGV2X2RiZygmaTJjX2lteC0+YWRhcHRlci5kZXYsICJkZXZpY2UgcmVzb3VyY2Vz
OiAlcFJcbiIsIHJlcyk7DQo+PiAgIAlkZXZfZGJnKCZpMmNfaW14LT5hZGFwdGVyLmRldiwgImFk
YXB0ZXIgbmFtZTogXCIlc1wiXG4iLA0KPj4gICAJCWkyY19pbXgtPmFkYXB0ZXIubmFtZSk7DQo+
PiAgIA0KPj4gLQkvKiBJbml0IERNQSBjb25maWcgaWYgc3VwcG9ydGVkICovDQo+PiAtCXJldCA9
IGkyY19pbXhfZG1hX3JlcXVlc3QoaTJjX2lteCwgcGh5X2FkZHIpOw0KPj4gLQlpZiAocmV0IDwg
MCkNCj4+IC0JCWdvdG8gY2xrX25vdGlmaWVyX3VucmVnaXN0ZXI7DQo+PiAtDQo+PiAgIAlkZXZf
aW5mbygmaTJjX2lteC0+YWRhcHRlci5kZXYsICJJTVggSTJDIGFkYXB0ZXIgcmVnaXN0ZXJlZFxu
Iik7DQo+PiAgIAlyZXR1cm4gMDsgICAvKiBSZXR1cm4gT0sgKi8NCj4+ICAgDQo+PiArZGVsX2Fk
YXB0ZXI6DQo+PiArCWkyY19kZWxfYWRhcHRlcigmaTJjX2lteC0+YWRhcHRlcik7DQo+IA0KPiBU
aGlzIGxvb2tzIGxpa2UgYSBzZXBhcmF0ZSBmaXggKHByZXZpb3VzbHkgdGhlIGNhbGwgdG8NCj4g
aTJjX2FkZF9udW1iZXJlZF9hZGFwdGVyKCkgd2FzIG5vdCB1bmRvbmUgaW4gY2FzZSBvZiBsYXRl
ciBlcnJvcnMpLiBJdA0KPiB3b3J0aCBzcGVsbGluZyB0aGlzIG91dCBpbiB0aGUgY29tbWl0IG1l
c3NhZ2UuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBTdGV2ZQ0KPiANCj4+ICAgY2xrX25vdGlmaWVy
X3VucmVnaXN0ZXI6DQo+PiAgIAljbGtfbm90aWZpZXJfdW5yZWdpc3RlcihpMmNfaW14LT5jbGss
ICZpMmNfaW14LT5jbGtfY2hhbmdlX25iKTsNCj4+ICAgcnBtX2Rpc2FibGU6DQo+PiBAQCAtMTE4
Miw4ICsxMTg5LDYgQEAgc3RhdGljIGludCBpMmNfaW14X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+PiAgIAlwbV9ydW50aW1lX3NldF9zdXNwZW5kZWQoJnBkZXYtPmRldik7
DQo+PiAgIAlwbV9ydW50aW1lX2RvbnRfdXNlX2F1dG9zdXNwZW5kKCZwZGV2LT5kZXYpOw0KPj4g
ICANCj4+IC1jbGtfZGlzYWJsZToNCj4+IC0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGkyY19pbXgt
PmNsayk7DQo+PiAgIAlyZXR1cm4gcmV0Ow0KPj4gICB9DQo+PiAgIA0KPj4NCj4g
