Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C488BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AD52083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="h9olOcSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfDJJ1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:27:12 -0400
Received: from mail-eopbgr40090.outbound.protection.outlook.com ([40.107.4.90]:63552
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727964AbfDJJ1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80zHO96gzHuUVA+cYqkx70/ofJ/x3Ze56Ve2kh0t1wI=;
 b=h9olOcSxh7WbA6Q5+rrH/7Zj9ud3ufDipIn6OQU5/7AE7fdVPwRDyMjMqvqzP/r7eJHj9gmuTeIMnEMhoTCOG3kcvlu4hVJUtjay2XYCKGEZ2kNm7OtN0xaabqVimblNH/nkTAil8tY/l9yztfXZFRQPrNRL/GHYzxviDgpUfmE=
Received: from HE1PR0701MB2652.eurprd07.prod.outlook.com (10.168.188.7) by
 HE1PR0701MB2667.eurprd07.prod.outlook.com (10.168.188.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.11; Wed, 10 Apr 2019 09:27:07 +0000
Received: from HE1PR0701MB2652.eurprd07.prod.outlook.com
 ([fe80::1449:d020:a36f:a8a3]) by HE1PR0701MB2652.eurprd07.prod.outlook.com
 ([fe80::1449:d020:a36f:a8a3%6]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 09:27:07 +0000
From:   "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH] modpost: make KBUILD_MODPOST_WARN also configurable for
 external modules
Thread-Topic: [PATCH] modpost: make KBUILD_MODPOST_WARN also configurable for
 external modules
Thread-Index: AdTjuez0lIeTgqS2RiGNuzvA7YdwJAJZwhOAADAfPAAANE+HgAAzN64A
Date:   Wed, 10 Apr 2019 09:27:07 +0000
Message-ID: <82f5a922-1dd8-50b5-551c-33aa6d9e1192@nokia.com>
References: <HE1PR0701MB2652FC3F5D8E46EA93AF033AFA5F0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
 <CAK7LNAQEQyEyj_ozkARj8xjDf7EncHeBv0GY8xoP8e_Fn-qaag@mail.gmail.com>
 <77e11884-f520-d983-3d33-ccc3043ba604@nokia.com>
 <CAK7LNAR_Py_4_pPEcxd7_ZpicoD6rnjb-iyq=_h893m=7q7kug@mail.gmail.com>
In-Reply-To: <CAK7LNAR_Py_4_pPEcxd7_ZpicoD6rnjb-iyq=_h893m=7q7kug@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-clientproxiedby: HE1PR0402CA0048.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::37) To HE1PR0701MB2652.eurprd07.prod.outlook.com
 (2603:10a6:3:98::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wladislav.wiebe@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c58565b-38aa-4c2d-b594-08d6bd96b319
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR0701MB2667;
x-ms-traffictypediagnostic: HE1PR0701MB2667:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <HE1PR0701MB2667AC7F1A2D63FC5281C4F9FA2E0@HE1PR0701MB2667.eurprd07.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(346002)(376002)(189003)(199004)(229853002)(186003)(6116002)(54906003)(6916009)(26005)(316002)(31686004)(305945005)(105586002)(58126008)(7736002)(106356001)(65826007)(81166006)(102836004)(486006)(2616005)(446003)(11346002)(8676002)(3846002)(6246003)(81156014)(476003)(36756003)(64126003)(14454004)(2906002)(5660300002)(71200400001)(66066001)(6512007)(76176011)(53936002)(93886005)(25786009)(99286004)(68736007)(52116002)(14444005)(65806001)(65956001)(97736004)(256004)(6306002)(6486002)(8936002)(478600001)(53546011)(6436002)(6506007)(86362001)(31696002)(386003)(966005)(71190400001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2667;H:HE1PR0701MB2652.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ch9TOApAHD67ohLiuuQbRsJU0GsEGqkdSTni0GCP+UxYqqMHFac9Po02EiZMOu5yg3vlCOg731uQUTR+/Ng9M5jSsCoh89LF6QDRfNr9PBawYERLUCwTlUEECyFoXVbcTX9ix3J/bPZ89KqSAGMdrCFzAr3Pk3fnh9PoVgom4YdVwDLKf7AlENkEbGUnA7ddUXw6GyBClG+ezqgvfaAdK8Bfw7qXVKuhKYF7jMWNW5h1MzvEcGTpL0HAll4FaT7carTdjZklF+3dgkhyeLAtqQY+mn8kx9zol6urb51Os4jxDugcsWgd6BTSKIJqSOZnsj1ZeQfzlepgTzSz1PxbNCn8FED1L2PWVv6jRzQgl/RW1uJ27j1s5fZvtFWZ1+Fwhhk0Yp6PcOlqLFry+TkjEl/TN7P2b6s8K3Kmu2bi768=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D75E4441EB95044A9CF1071AF6884FBC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c58565b-38aa-4c2d-b594-08d6bd96b319
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 09:27:07.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2667
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDA5LjA0LjIwMTkgMTE6MDAsIE1hc2FoaXJvIFlhbWFkYSB3cm90ZToNCj4gSGku
DQo+IA0KPiBPbiBNb24sIEFwciA4LCAyMDE5IGF0IDU6MDMgUE0gV2llYmUsIFdsYWRpc2xhdiAo
Tm9raWEgLSBERS9VbG0pDQo+IDx3bGFkaXNsYXYud2llYmVAbm9raWEuY29tPiB3cm90ZToNCj4+
DQo+PiBIaSENCj4+DQo+PiBPbiAwNy4wNC4yMDE5IDExOjA0LCBNYXNhaGlybyBZYW1hZGEgd3Jv
dGU6DQo+Pj4gKCtDQyBKb25hcyBHb3Jza2kpDQo+Pj4NCj4+Pg0KPj4+IE9uIFR1ZSwgTWFyIDI2
LCAyMDE5IGF0IDY6NTggUE0gV2llYmUsIFdsYWRpc2xhdiAoTm9raWEgLSBERS9VbG0pDQo+Pj4g
PHdsYWRpc2xhdi53aWViZUBub2tpYS5jb20+IHdyb3RlOg0KPj4+Pg0KPj4+PiBDb21taXQgZWE4
MzdmMWMwNTAzICgia2J1aWxkOiBtYWtlIG1vZHBvc3QgcHJvY2Vzc2luZyBjb25maWd1cmFibGUi
KQ0KPj4+PiB3YXMgaW50ZW5kZWQgdG8gZ2l2ZSBLQlVJTERfTU9EUE9TVF9XQVJOIGZsZXhpYmls
aXR5IHRvIGJlIGNvbmZpZ3VyYWJsZS4NCj4+Pj4gUmlnaHQgbm93IEtCVUlMRF9NT0RQT1NUX1dB
Uk4gZ2V0cyBqdXN0IGlnbm9yZWQgd2hlbiBLQlVJTERfRVhUTU9EIGlzDQo+Pj4+IHNldCB3aGlj
aCBoYXBwZW5zIHBlciBkZWZhdWx0IHdoZW4gYnVpbGRpbmcgbW9kdWxlcyBvdXQgb2YgdGhlIHRy
ZWUuDQo+Pj4+DQo+Pj4+IFRoaXMgY2hhbmdlIGdpdmVzIHRoZSBvcHBvcnR1bml0eSB0byBkZWZp
bmUgbW9kdWxlIGJ1aWxkIGJlaGF2aW5nIGFsc28NCj4+Pj4gaW4gY2FzZSBvZiBvdXQgb2YgdHJl
ZSBidWlsZHMgYW5kIGRlZmF1bHQgd2lsbCBiZWNvbWUgZXhpdCBvbiBlcnJvci4NCj4+Pj4gRXJy
b3JzIHdoaWNoIGNhbiBiZSBkZXRlY3RlZCBieSB0aGUgYnVpbGQgc2hvdWxkIGJlIHRyYXBwZWQg
b3V0IG9mIHRoZSBib3gNCj4+Pj4gdGhlcmUsIHVubGVzcyBzb21lYm9keSB3YW50cyB0byBub3Rp
Y2UgYnJva2VuIHN0dWZmIGxhdGVyIGF0IHJ1bnRpbWUuDQo+Pj4NCj4+PiBJZiBhbiBleHRlcm5h
bCBtb2R1bGUgcmVmZXJzIHRvIGEgc3ltYm9sDQo+Pj4gcHJvdmlkZWQgYnkgYW5vdGhlciBleHRl
cm5hbCBtb2R1bGUsDQo+Pj4gdGhpcyBwYXRjaCB3aWxsIHR1cm4gdGhlIHdhcm5pbmcgaW50byB0
aGUgZXJyb3IgYnkgZGVmYXVsdCwNCj4+PiB3aGljaCBpcyBwcm9iYWJseSBhIGJhZCBpZGVhLg0K
Pj4NCj4+IEluZGVlZCwgZXhhY3RseSB0aGlzIHNob3VsZCBoYXBwZW4uIFlvdSBzaG91bGQgZml4
IHlvdXIgZXh0ZXJuYWwgbW9kdWxlDQo+PiBkZXBlbmRlbmNpZXMgYnkgcHJvdmlkaW5nIHRoZWly
IHN5bWJvbHMuIFBsZWFzZSB1c2UgZS5nLg0KPj4gS0JVSUxEX0VYVFJBX1NZTUJPTFMgaW5zdGVh
ZCBvZiBjb252ZXJ0aW5nIGVycm9ycyB0byB3YXJuaW5nIGFuZCBob3BpbmcNCj4+IHRoYXQgdGhp
bmdzIHdpbGwgd29yay4NCj4gDQo+IEkga25vdyB0aGlzIG9wdGlvbi4NCj4gV2hhdCBJIHdhbnQg
dG8gc2F5IGlzLCB0aGlzIHBhdGNoIGNoYW5nZXMgdGhlIGJlaGF2aW9yLCBhbmQNCj4gbWF5IGFu
bm95IHNvbWUgcGVvcGxlLg0KPiANCj4+IE9yIGhvdyBkbyB5b3Ugd2FudCB0byBtYWtlIHN1cmUg
bW9kdWxlIEEgc3RpbGwNCj4+IGRlbGl2ZXJzIGFsbCBzeW1ib2xzIG5lZWRlZCBieSBtb2R1bGUg
QiBhZnRlciBhbiB1cGRhdGUvY2hhbmdlcz8NCj4+IE1hbnVhbGx5IGNvbXBhcmluZyB0aGUgbG9n
cyBhZnRlciBhbiB1cGRhdGUgb3Igd2FpdGluZyB1bnRpbCBpdCB0dXJucw0KPj4gb3V0IGJyb2tl
biBkdXJpbmcgcnVuLXRpbWU/IEkgd291bGRuJ3Qgc2F5IHRoaXMgaXMgYSBnb29kIGlkZWEgOi0p
DQo+IA0KPiBPSywgc28gdGhlIGNvbW1pdCBsb2cgc2hvdWxkIHJlY29yZCBib3RoIHRoZSBiZWhh
dmlvciBjaGFuZ2UNCj4gYW5kIHdvcmthcm91bmRzLg0KPiANCj4gLSBJZiBhbiBleHRlcm5hbCBt
b2R1bGUgYmVpbmcgYnVpbHQgcmVmZXJzIHRvIHN5bWJvbHMNCj4gICAgaW4gYW5vdGhlciBleHRl
cm5hbCBtb2R1bGUsIEtidWlsZCBwcmV2aW91c2x5IHNob3dlZCBhIHdhcm5pbmcsDQo+ICAgIGJ1
dCBnb2luZyBmb3J3YXJkIGl0IHdpbGwgdHVybiBpdCBpbnRvIGFuIGVycm9yLg0KPiANCj4gLSBU
byB3b3JrIGFyb3VuZCB0aGlzLCB5b3Ugc2hvdWxkIHBhc3MgYSBzeW1ib2wgdGFibGUgdmlhIEtC
VUlMRF9FWFRSQV9TWU1CT0xTLA0KPiAgICBvciBLQlVJTERfRVhUUkFfU1lNQk9MUz0xIHRvIHR1
cm4gdGhlIGVycm9yIGludG8gYSB3YXJuaW5nLg0KDQoNCk9rLCBJJ3ZlIHBvc3RlZCB2MjoNCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMDU5OTg1Lw0KDQoNClRoYW5r
cyENCg0KLSBXbGFkaXNsYXYNCg0KDQoNCj4gVGhhbmtzLg0KPiANCj4+DQo+Pj4gSSBzdWdnZXN0
ZWQgYSBkZXNpcmVkIGNoYW5nZSBpbiB0aGUgZm9sbG93aW5nLg0KPj4+IGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcGF0Y2gvOTk4MDY5MS8NCj4+Pg0KPj4+IEkgYW0gcG9raW5nIEpvbmFz
IEdvcnNraQ0KPj4+IGlmIGhlIHBsYW5zIHRvIHNlbmQgdjIuDQo+Pg0KPj4gSSB3b3VsZG4ndCB2
b3RlIGZvciB2MiBiYXNlZCBvbiBleHBsYW5hdGlvbiBhYm92ZS4NCj4+DQo+PiAtIFdsYWRpc2xh
dg0KPj4NCj4+Pg0KPj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFdsYWRpc2xhdiBXaWViZSA8d2xh
ZGlzbGF2LndpZWJlQG5va2lhLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIHNjcmlwdHMvTWFrZWZp
bGUubW9kcG9zdCB8IDIgKy0NCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9zY3JpcHRzL01ha2VmaWxl
Lm1vZHBvc3QgYi9zY3JpcHRzL01ha2VmaWxlLm1vZHBvc3QNCj4+Pj4gaW5kZXggNmI3ZjM1NGYx
ODlhLi5mZWM2ZWMyZmZhNDcgMTAwNjQ0DQo+Pj4+IC0tLSBhL3NjcmlwdHMvTWFrZWZpbGUubW9k
cG9zdA0KPj4+PiArKysgYi9zY3JpcHRzL01ha2VmaWxlLm1vZHBvc3QNCj4+Pj4gQEAgLTc4LDcg
Kzc4LDcgQEAgbW9kcG9zdCA9IHNjcmlwdHMvbW9kL21vZHBvc3QgICAgICAgICAgICAgICAgICAg
IFwNCj4+Pj4gICAgICQoaWYgJChLQlVJTERfRVhUUkFfU1lNQk9MUyksICQocGF0c3Vic3QgJSwg
LWUgJSwkKEtCVUlMRF9FWFRSQV9TWU1CT0xTKSkpIFwNCj4+Pj4gICAgICQoaWYgJChLQlVJTERf
RVhUTU9EKSwtbyAkKG1vZHVsZXN5bWZpbGUpKSAgICAgIFwNCj4+Pj4gICAgICQoaWYgJChDT05G
SUdfU0VDVElPTl9NSVNNQVRDSF9XQVJOX09OTFkpLCwtRSkgIFwNCj4+Pj4gLSAkKGlmICQoS0JV
SUxEX0VYVE1PRCkkKEtCVUlMRF9NT0RQT1NUX1dBUk4pLC13KQ0KPj4+PiArICQoaWYgJChLQlVJ
TERfTU9EUE9TVF9XQVJOKSwtdykNCj4+Pj4NCj4+Pj4gICAgTU9EUE9TVF9PUFQ9JChzdWJzdCAt
aSwtbiwkKGZpbHRlciAtaSwkKE1BS0VGTEFHUykpKQ0KPj4+Pg0KPj4+PiAtLQ0KPj4+PiAyLjE5
LjINCj4+Pg0KPj4+DQo+Pj4NCj4gDQo+IA0KPiAtLQ0KPiBCZXN0IFJlZ2FyZHMNCj4gTWFzYWhp
cm8gWWFtYWRhDQo+IA0K
