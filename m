Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDECC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507122182B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="VUwdd8B5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfHEHTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:19:05 -0400
Received: from mail-eopbgr80104.outbound.protection.outlook.com ([40.107.8.104]:55360
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726394AbfHEHTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:19:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMRyjgJy1vzyAta/K/XbUmcdj0cc/o4+uz2GCknr4fmz1UVykpltSmlSjqzWn/wSlEptdSzPnK1aT6eNX+4aKaLGwBB0gWdKcCZz6zCWDxRvCsEn6nZ9aqcB8CccZ1MElPiBnZHVsLuqF0i3zJ6ys8gppSaYnPhWDhBfcISZNMBeIE+RW1nI7UmlaNLaFwTpI7evNPiICUZ/yZ3zLgBE2B+lgKERPOhn6RBTHQT2fhdOXAPQ1PSRc2uiZ8uvQULThObhy3pO0f7d7gI8yaB/I7Ij7yvGQVTCAA0Wr2ri9hd97DTSF+CIDea+LbymwtghC+XD9NxTsXHIM+XV1hrSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifzT0Rd2fgYCxbAlomcJsAOHjMab4VeLkWhU/H7j6xc=;
 b=aBFMzwscwR8jL+jAXmdZtFORTW279dhSZV/PUxZG6eFOJFmPWg/xaFpdKf2XhytuuM59ZMK5zLFQRDAoF2dXQDkAk64VPUyhzm9TITuygBlEO3AVYtdhN+Zi9Vnkto2Fc/o8qtoGKxKlOC1tkhE0nRPhy7yvCATmZa9M5Oi1kXw8B4G6stOHEv5gdVMy58C/L53hN/Ykma+GRK1Q3/lFsYyDFrQ0+7GFNq48+1ETDiMWKAKoFULhcsmXndvP7I1J7pVCFsNQce8igXi86RFgc55FP+2EwW/z7SWmHbL5Ej6iEs6E25mMhMbcdzWZjnjWJMPLKonCOZGXl7y66uSZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifzT0Rd2fgYCxbAlomcJsAOHjMab4VeLkWhU/H7j6xc=;
 b=VUwdd8B58qO2wTjlnSekBeTWz6CZDiUL4xSLPWOU8HaDD4hqe+pq9lafnC9DNgwi9ODxYSJ3iJJcnzRLC+ziiIjOoHpTVy3PRhJRX47CfZVCBgB8imOykfVwJr3kdpI1I2488b+uAQnuSnSnVg5OniT1XYBvhr/+kdAFokr3iQ8=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3053.eurprd05.prod.outlook.com (10.175.22.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:18:59 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:18:59 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 07/20] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Topic: [PATCH v2 07/20] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Index: AQHVR5zQtB0dzN8FYEudcspMVKQYmabkr2aAgAAgjgCAAr/AgIAEnSoA
Date:   Mon, 5 Aug 2019 07:18:59 +0000
Message-ID: <90509acd1da1aa85699952e012fa1034255f1a06.camel@toradex.com>
References: <20190731123750.25670-1-philippe.schenker@toradex.com>
         <20190731123750.25670-8-philippe.schenker@toradex.com>
         <CAOMZO5B5HnqpLrDjyGtqSQpVXmcoZuGLvCzKVUhwLb-_ZO_Xog@mail.gmail.com>
         <723f191c5893984c8fbe711163524dc7ebf09a5b.camel@toradex.com>
         <de6bec64012876c07267024cd4b2d2d5@agner.ch>
In-Reply-To: <de6bec64012876c07267024cd4b2d2d5@agner.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc248fa8-9b65-4054-774b-08d719752f85
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3053;
x-ms-traffictypediagnostic: VI1PR0502MB3053:
x-microsoft-antispam-prvs: <VI1PR0502MB3053ACE8542CC895AE0B936CF4DA0@VI1PR0502MB3053.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(376002)(136003)(39840400004)(346002)(199004)(189003)(3846002)(2906002)(229853002)(7416002)(6116002)(6436002)(54906003)(6486002)(8676002)(1730700003)(81156014)(86362001)(81166006)(99286004)(5640700003)(76176011)(186003)(486006)(102836004)(71200400001)(71190400001)(2501003)(2616005)(476003)(14444005)(316002)(8936002)(6506007)(53546011)(26005)(2351001)(44832011)(256004)(118296001)(478600001)(66476007)(64756008)(76116006)(91956017)(66946007)(446003)(11346002)(66066001)(6512007)(14454004)(6916009)(5660300002)(66446008)(66556008)(6246003)(36756003)(68736007)(7736002)(25786009)(53936002)(305945005)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3053;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tUGv+UQDWwYdzHzTF//jSapVHDWo9eEJ02EtG/us1cT5mvfr7f+5NfWovgZBYm17euZ3e3ev8sJRa3YPBn2UQBtornIBVvgObyB3oT0sgcvKapLxbxA1IKcTAAd/Jy5reoblnNjanAMJdFMPZgn3j0tJ8i7KhT94Cc9cULg1PmCKmJWFYbDr8SrU/itUMblstTbMq445S56oKiBJ6YCaELzAgvkUXRoe8xcdABiPZloeWUHbZDqAf4XNYiKXUw+3FWiJxvGWnJ4l4T/ZDxq2ClRAygiZO+jwvYdEVPAQPfLu419ap1Awg1vumkcshgxUiP6X8LR5rBHjOpSpAPdWOj5xQTEKLU6YpM4pXG5Qh9MeL2lJtYhSXdtJbJt7GUY3oLu3yueTxr4ecw83zUwfyvEDSInxYXjQ0e0aDirj9cE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D6770331469E54389A2882CE1F4A824@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc248fa8-9b65-4054-774b-08d719752f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:18:59.1720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA4LTAyIGF0IDEwOjUxICswMjAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IE9uIDIwMTktMDctMzEgMTY6NTIsIFBoaWxpcHBlIFNjaGVua2VyIHdyb3RlOg0KPiA+IE9uIFdl
ZCwgMjAxOS0wNy0zMSBhdCAwOTo1NiAtMDMwMCwgRmFiaW8gRXN0ZXZhbSB3cm90ZToNCj4gPiA+
IE9uIFdlZCwgSnVsIDMxLCAyMDE5IGF0IDk6MzggQU0gUGhpbGlwcGUgU2NoZW5rZXINCj4gPiA+
IDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4gd3JvdGU6DQo+ID4gPiA+IEZyb206IFN0
ZWZhbiBBZ25lciA8c3RlZmFuLmFnbmVyQHRvcmFkZXguY29tPg0KPiA+ID4gPiANCj4gPiA+ID4g
QWRkIHBpbm11eGluZyBhbmQgZG8gbm90IHNwZWNpZnkgdm9sdGFnZSByZXN0cmljdGlvbnMgaW4g
dGhlDQo+ID4gPiA+IG1vZHVsZSBsZXZlbCBkZXZpY2UgdHJlZS4NCj4gPiA+IA0KPiA+ID4gSXQg
d291bGQgYmUgbmljZSB0byBleHBsYWluIHRoZSByZWFzb24gZm9yIGRvaW5nIHRoaXMuDQo+ID4g
DQo+ID4gVGhpcyBjb21taXQgaXMgaW4gcHJlcGFyYXRpb24gb2YgYW5vdGhlciBwYXRjaCB0aGF0
IGRpZG4ndCBtYWRlIGludG8gdGhpcw0KPiA+IHBhdGNoc2V0IChkb3duc3RyZWFtIHN0dWZmIGlu
IHRoZXJlKS4gQnV0IEkgd2lsbCBkbyBhbm90aGVyIHBhdGNoIG9uIHRvcA0KPiA+IHRoYXQNCj4g
PiB3aWxsIHVzZSB0aGlzIHBhdGNoIGhlcmUuIFRoYXQgc2hvdWxkIGFueXdheSBiZSBpbiBtYWlu
bGluZS4NCj4gDQo+IEkgZ3Vlc3Mgd2hhdCBGYWJpbyBtZWFudCBoZXJlIGlzIGV4cGxhaW4gdGhp
cyBwYXRjaC4NCj4gDQo+IFRoZSBjb21taXQgbWVzc2FnZSByZWFsbHkgY291bGQgYmUgaW1wcm92
ZWQsIGUuZy46DQo+IA0KPiBBZGQgcGlubXV4aW5nIGFuZCBkbyBub3Qgc3BlY2lmeSB2b2x0YWdl
IHJlc3RyaWN0aW9ucyBmb3IgdGhlIHVzZGhjDQo+IGluc3RhbmNlDQo+IGF2YWlsYWJsZSBvbiB0
aGUgbW9kdWxlcyBlZGdlIGNvbm5lY3Rvci4gVGhpcyBhbGxvd3MgdG8gdXNlIFNELWNhcmRzDQo+
IHdpdGgNCj4gaGlnaGVyIHRyYW5zZmVyIG1vZGVzIGlmIHN1cHBvcnRlZCBieSB0aGUgY2Fycmll
ciBib2FyZC4NCj4gDQo+IC0tDQo+IFN0ZWZhbg0KDQpBaCwgc29ycnkgRmFiaW8uIEkgaW5kZWVk
IHVuZGVyc3Rvb2QgeW91IHdyb25nIGFuZCB0aGFua3MgU3RlZmFuIGZvciBjbGFyaWZ5aW5nLg0K
SSBoYXZlIHRoZSBuZXcgbWVzc2FnZSBpbiBmb3IgdjMuDQoNClBoaWxpcHBlDQoNCj4gDQo+ID4g
UGhpbGlwcGUNCj4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIEFnbmVyIDxzdGVm
YW4uYWduZXJAdG9yYWRleC5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNj
aGVua2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+IA0KPiA+ID4gPiBDaGFuZ2VzIGluIHYyOiBOb25lDQo+ID4gPiA+IA0KPiA+ID4gPiAgYXJj
aC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kgfCAyMyArKysrKysrKysrKysrKysrKysr
KysrLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9p
bXg3LWNvbGlicmkuZHRzaQ0KPiA+ID4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctDQo+ID4g
PiA+IGNvbGlicmkuZHRzaQ0KPiA+ID4gPiBpbmRleCAxNmQxYTFlZDFhZmYuLjY3ZjVlMGM4N2Zk
YyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0
c2kNCj4gPiA+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kNCj4g
PiA+ID4gQEAgLTMyNiw3ICszMjYsNiBAQA0KPiA+ID4gPiAgJnVzZGhjMSB7DQo+ID4gPiA+ICAg
ICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiA+ID4gICAgICAgICBwaW5jdHJs
LTAgPSA8JnBpbmN0cmxfdXNkaGMxICZwaW5jdHJsX2NkX3VzZGhjMT47DQo+ID4gPiA+IC0gICAg
ICAgbm8tMS04LXY7DQo+ID4gPiA+ICAgICAgICAgY2QtZ3Bpb3MgPSA8JmdwaW8xIDAgR1BJT19B
Q1RJVkVfTE9XPjsNCj4gPiA+ID4gICAgICAgICBkaXNhYmxlLXdwOw0KPiA+ID4gPiAgICAgICAg
IHZxbW1jLXN1cHBseSA9IDwmcmVnX0xETzI+Ow0KPiA+ID4gPiBAQCAtNjcxLDYgKzY3MCwyOCBA
QA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgPjsNCj4gPiA+ID4gICAgICAgICB9Ow0KPiA+ID4g
PiANCj4gPiA+ID4gKyAgICAgICBwaW5jdHJsX3VzZGhjMV8xMDBtaHo6IHVzZGhjMWdycF8xMDBt
aHogew0KPiA+ID4gPiArICAgICAgICAgICAgICAgZnNsLHBpbnMgPSA8DQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIE1YN0RfUEFEX1NEMV9DTURfX1NEMV9DTUQgICAgICAgMHg1YQ0K
PiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBNWDdEX1BBRF9TRDFfQ0xLX19TRDFfQ0xL
ICAgICAgIDB4MWENCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTVg3RF9QQURfU0Qx
X0RBVEEwX19TRDFfREFUQTAgICAweDVhDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IE1YN0RfUEFEX1NEMV9EQVRBMV9fU0QxX0RBVEExICAgMHg1YQ0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBNWDdEX1BBRF9TRDFfREFUQTJfX1NEMV9EQVRBMiAgIDB4NWENCj4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTVg3RF9QQURfU0QxX0RBVEEzX19TRDFfREFUQTMg
ICAweDVhDQo+ID4gPiA+ICsgICAgICAgICAgICAgICA+Ow0KPiA+ID4gPiArICAgICAgIH07DQo+
ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBwaW5jdHJsX3VzZGhjMV8yMDBtaHo6IHVzZGhjMWdy
cF8yMDBtaHogew0KPiA+ID4gPiArICAgICAgICAgICAgICAgZnNsLHBpbnMgPSA8DQo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIE1YN0RfUEFEX1NEMV9DTURfX1NEMV9DTUQgICAgICAg
MHg1Yg0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBNWDdEX1BBRF9TRDFfQ0xLX19T
RDFfQ0xLICAgICAgIDB4MWINCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTVg3RF9Q
QURfU0QxX0RBVEEwX19TRDFfREFUQTAgICAweDViDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIE1YN0RfUEFEX1NEMV9EQVRBMV9fU0QxX0RBVEExICAgMHg1Yg0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBNWDdEX1BBRF9TRDFfREFUQTJfX1NEMV9EQVRBMiAgIDB4NWIN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTVg3RF9QQURfU0QxX0RBVEEzX19TRDFf
REFUQTMgICAweDViDQo+ID4gPiA+ICsgICAgICAgICAgICAgICA+Ow0KPiA+ID4gPiArICAgICAg
IH07DQo+ID4gPiANCj4gPiA+IFlvdSBhZGQgdGhlIGVudHJpZXMgZm9yIDEwME1IeiBhbmQgMjAw
TUh6LCBidXQgSSBkb24ndCBzZWUgdGhlbSBiZWluZw0KPiA+ID4gcmVmZXJlbmNlZCBhbnl3aGVy
ZS4NCg==
