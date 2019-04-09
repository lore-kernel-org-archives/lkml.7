Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7072C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A237720818
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfDIFb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:31:56 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:58228 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfDIFbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:31:55 -0400
X-AuditID: c0a8fbf4-519ff700000014c1-4b-5cac2e499425
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id E1.60.05313.94E2CAC5; Tue,  9 Apr 2019 07:31:53 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Tue, 9 Apr 2019 07:31:50 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "jhugo@codeaurora.org" <jhugo@codeaurora.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>
Subject: Re: [PATCH v3 1/7] clkdev: Hold clocks_mutex while iterating clocks
 list
Thread-Topic: [PATCH v3 1/7] clkdev: Hold clocks_mutex while iterating
 clocks list
Thread-Index: AQHU6zDhsEv70ksLMUWTxM/SG851haYtACOAgADmtACABJvRRIAAOCYAgAB4WwA=
Date:   Tue, 9 Apr 2019 05:31:48 +0000
Message-ID: <4e63d42b27bc5bdf7d991c00f9105ba96a34dc8a.camel@fi.rohmeurope.com>
References: <20190404215344.6330-1-sboyd@kernel.org>
         <20190404215344.6330-2-sboyd@kernel.org>
         <b3a3052056b787bde94178ed371417359a941f2d.camel@fi.rohmeurope.com>
         <155449664462.20095.10904772826291270300@swboyd.mtv.corp.google.com>
         <20190408104941.GB17594@localhost.localdomain>
         <155474280295.20095.182612336816713159@swboyd.mtv.corp.google.com>
         <20190408222106.ect7nwjsklzhmdwj@shell.armlinux.org.uk>
In-Reply-To: <20190408222106.ect7nwjsklzhmdwj@shell.armlinux.org.uk>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD60D10BBB662F44AA0BDF694ED06F27@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsVyYMXvjbqeemtiDHrPcFm8eXSE2eLK43SL
        jz33WC0u75rDZnFo6l5Gi8Pt+1gtLp5ytfh3bSOLxc9D55kcOD0uX7vI7PH+Riu7x7w11R6X
        +3qZPDY8Ws3qsWlVJ5vH501yAexR3DZJiSVlwZnpefp2CdwZl46eYC94o1bxbMoDpgbGN6pd
        jJwcEgImEq8uXGfvYuTiEBK4xihx5sgcJgjnOKPEtikbgTIcHGwCNhJdN9lBGkQEYiTmndwM
        VsMs8JFJYuq8CYwgCWGBYIm7d14zQxSFSPzY/poRpFdEwE9i55dkkDCLgIrEu4s9YHN4gcK9
        66+xQuxayCyx/U0DE0iCU8BFYv/8V2wgNqOArERnwzuwOLOAuMSmZ99ZIa4WkFiy5zwzhC0q
        8fLxP6i4ksTenw9ZQPYyC2hKrN+lD9HqIHFo/Wc2CFtRYkr3Q6gbBCVOznzCMoFRbBaSDbMQ
        umch6Z6FpHsWku4FjKyrGCVyEzNz0hNLUg31ilJL9YryM3KBVHJ+7iZGSDR/2cH4/5DnIUYB
        DkYlHl4JjTUxQqyJZcWVuYcYJTmYlER5T7SujhHiS8pPqcxILM6ILyrNSS0+xCjBwawkwrtz
        6qoYId6UxMqq1KJ8mJQ0B4uSOG/58ikxQgIgm7NTUwtSi2CyMhwcShK8urpAewSLUtNTK9Iy
        c0oQ0kwcnCDDuaREilPzUlKLEktLMuJBqSW+GJhcQFI8QHv5QNp5iwsSc4GiEK2nGLU5Dix6
        OJeZ4+3B53OZhVjy8vNSpcR5XUFKBUBKM0rz4Ba9YhQH+leYVxYkywNM+XBzXgGtYAJaMUVn
        NciKkkSElFQDo9rqP7sCVzWkPhWW8K+UmRU4q6ik0DOWiSX91Fs38ws1abLbHzSFVRce2nBz
        Yf91uRJZPkejmo0tkz9e5jWcvNqma1r6lUZf4/BX7h15nU0+Z74Ks7eXZhRNnZW72VZAll/Z
        zlDWXC+R39asZd3eB83NcV2une4b7l0MD4zbpPfyXMLrs3ZKLMUZiYZazEXFiQCfJnRXtgMA
        AA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA0LTA4IGF0IDIzOjIxICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggYWRtaW4NCndyb3RlOg0KPiBPbiBNb24sIEFwciAwOCwgMjAxOSBhdCAxMDowMDowMkFNIC0w
NzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+ID4gUXVvdGluZyBNYXR0aSBWYWl0dGluZW4gKDIw
MTktMDQtMDggMDM6NDk6NDEpDQo+ID4gPiBPbiBGcmksIEFwciAwNSwgMjAxOSBhdCAwMTozNzoy
NFBNIC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+ID4gPiA+IFF1b3RpbmcgVmFpdHRpbmVu
LCBNYXR0aSAoMjAxOS0wNC0wNCAyMzo1MTo0MykNCj4gPiA+ID4gPiBPbiBUaHUsIDIwMTktMDQt
MDQgYXQgMTQ6NTMgLTA3MDAsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gPiA+ID4gPiA+IFdlIHJl
Y2VudGx5IGludHJvZHVjZWQgYSBjaGFuZ2UgdG8gc3VwcG9ydCBkZXZtIGNsaw0KPiA+ID4gPiA+
ID4gbG9va3Vwcy4gVGhhdA0KPiA+ID4gPiA+ID4gY2hhbmdlDQo+ID4gPiA+ID4gPiBpbnRyb2R1
Y2VkIGEgY29kZS1wYXRoIHRoYXQgdXNlZCBjbGtfZmluZCgpIHdpdGhvdXQgaG9sZGluZw0KPiA+
ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiAnY2xvY2tzX211dGV4Jy4gVW5mb3J0dW5hdGVseSwg
Y2xrX2ZpbmQoKSBpdGVyYXRlcyBvdmVyIHRoZQ0KPiA+ID4gPiA+ID4gJ2Nsb2NrcycNCj4gPiA+
ID4gPiA+IGxpc3QgYW5kIHNvIHdlIG5lZWQgdG8gcHJldmVudCB0aGUgbGlzdCBmcm9tIGJlaW5n
IG1vZGlmaWVkDQo+ID4gPiA+ID4gPiB3aGlsZQ0KPiA+ID4gPiA+ID4gaXRlcmF0aW5nIG92ZXIg
aXQgYnkgaG9sZGluZyB0aGUgbXV0ZXguIFNpbWlsYXJseSwgd2UgZG9uJ3QNCj4gPiA+ID4gPiA+
IG5lZWQgdG8NCj4gPiA+ID4gPiA+IGhvbGQNCj4gPiA+ID4gPiA+IHRoZSAnY2xvY2tzX211dGV4
JyBiZXNpZGVzIHdoZW4gd2UncmUgZGVyZWZlcmVuY2luZyB0aGUNCj4gPiA+ID4gPiA+IGNsa19s
b29rdXANCj4gPiA+ID4gPiA+IHBvaW50ZXINCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAvLy8gU25p
cA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gLW91dDoNCj4gPiA+ID4gPiA+ICtzdGF0aWMgc3Ry
dWN0IGNsa19sb29rdXAgKmNsa19maW5kKGNvbnN0IGNoYXIgKmRldl9pZCwNCj4gPiA+ID4gPiA+
IGNvbnN0IGNoYXINCj4gPiA+ID4gPiA+ICpjb25faWQpDQo+ID4gPiA+ID4gPiArew0KPiA+ID4g
PiA+ID4gKyAgICAgc3RydWN0IGNsa19sb29rdXAgKmNsOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4g
PiA+ID4gKyAgICAgbXV0ZXhfbG9jaygmY2xvY2tzX211dGV4KTsNCj4gPiA+ID4gPiA+ICsgICAg
IGNsID0gX19jbGtfZmluZChkZXZfaWQsIGNvbl9pZCk7DQo+ID4gPiA+ID4gPiAgICAgICBtdXRl
eF91bmxvY2soJmNsb2Nrc19tdXRleCk7DQo+ID4gPiA+ID4gPiAgDQo+ID4gPiA+ID4gPiAtICAg
ICByZXR1cm4gY2wgPyBjbGsgOiBFUlJfUFRSKC1FTk9FTlQpOw0KPiA+ID4gPiA+ID4gKyAgICAg
cmV0dXJuIGNsOw0KPiA+ID4gPiA+ID4gK30NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIGFtIG5v
dCBhbiBleHBlcnQgb24gdGhpcyBidXQgcmVhZGluZyBjb21taXQgbWVzc2FnZSBhYm93ZQ0KPiA+
ID4gPiA+IGFuZCBzZWVpbmcNCj4gPiA+ID4gPiB0aGUgY29kZSBmb3IgY2xrX2ZpbmQoKSBsb29r
cyBhIGJpdCBzY2FyeS4gSWYgSSB1bmRlcnN0YW5kIGl0DQo+ID4gPiA+ID4gY29ycmVjdGx5LCB0
aGUgY2xvY2tzX211dGV4IHNob3VsZCBiZSBoZWxkIHdoZW4gZGVyZWZlcmVuY2luZw0KPiA+ID4g
PiA+IHRoZQ0KPiA+ID4gPiA+IGNsa19sb29rdXAgcmV0dXJuZWQgYnkgY2xrX2ZpbmQuIFRoZSBj
bGtfZmluZCBpbXBsZW1lbnRhdGlvbg0KPiA+ID4gPiA+IGRyb3BzIHRoZQ0KPiA+ID4gPiA+IGxv
Y2sgYmVmb3JlIHJldHVybmluZyAtIHdoaWNoIG1ha2VzIG1lIHRoaW5rIEkgbWlzcyBzb21ldGhp
bmcNCj4gPiA+ID4gPiBoZXJlLiBIb3cNCj4gPiA+ID4gPiBjYW4gdGhlIGNhbGxlciBldmVyIHNh
ZmVseSBkZXJlZmVyZW5jZSByZXR1cm5lZCBjbGtfbG9va3VwDQo+ID4gPiA+ID4gcG9pbnRlcj8N
Cj4gPiA+ID4gPiBKdXN0IHJlYWRpbmcgYWJvd2UgbWFrZXMgbWUgdGhpbmsgdGhhdCBsb2NrIHNo
b3VsZCBiZSB0YWtlbg0KPiA+ID4gPiA+IGJ5IHdob2V2ZXINCj4gPiA+ID4gPiBpcyBjYWxsaW5n
IHRoZSBjbGtfZmluZCwgYW5kIGRyb3BwZWQgb25seSBhZnRlciBjYWxsZXIgaGFzDQo+ID4gPiA+
ID4gdXNlZCB0aGUNCj4gPiA+ID4gPiBmb3VuZCBjbGtfbG9va3VwIGZvciB3aGF0ZXZlciBjYWxs
ZXIgaW50ZW5kcyB0byB1c2UgaXQuIE1heWJlDQo+ID4gPiA+ID4gSSBhbQ0KPiA+ID4gPiA+IG1p
c3Npbmcgc29tZXRoaW5nPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIG9ubHkg
dXNlciBhZnRlciB0aGlzIHBhdGNoIChkZXZtKSBpcyBkb2luZyBhIHBvaW50ZXINCj4gPiA+ID4g
Y29tcGFyaXNvbiBzbw0KPiA+ID4gPiBpdCBsb29rcyBPSy4gQnV0IHllcywgaW4gZ2VuZXJhbCB0
aGVyZSBzaG91bGRuJ3QgYmUgdXNlcnMgb2YNCj4gPiA+ID4gY2xrX2ZpbmQoKQ0KPiA+ID4gPiB0
aGF0IGRlcmVmZXJlbmNlIHRoZSBwb2ludGVyIGJlY2F1c2UgdGhlcmUgaXNuJ3QgYW55IHByb3Rl
Y3Rpb24NCj4gPiA+ID4gYmVzaWRlcw0KPiA+ID4gPiB0aGUgbXV0ZXguDQo+ID4gPiANCj4gPiA+
IElmIHRoZSBvbmx5IChpbnRlbmRlZCkgdXNlciBmb3IgY2xrX2ZpbmQgaXMNCj4gPiA+IGRldm1f
Y2xrX3JlbGVhc2VfY2xrZGV2LA0KPiA+ID4gdGhlbiB3ZSBtaWdodCB3YW50IHRvIHdyaXRlIGl0
IGluIGRldm1fY2xrX3JlbGVhc2VfY2xrZGV2IC0ganVzdA0KPiA+ID4gdG8NCj4gPiA+IGF2b2lk
IHNpbWlsYXIgZXJyb3JzIChhcyBJIGRpZCB3aXRoIGRldm0pIGluIHRoZSBmdXR1cmU/IEkgbWln
aHQNCj4gPiA+IGV2ZW4NCj4gPiA+IGNvbnNpZGVyIHJlbmFtaW5nIF9fY2xrX2ZpbmQgdG8gY2xr
X2ZpbmQgb3IgdG8gY2xrX2ZpbmRfdW5zYWZlIC0NCj4gPiA+IGJ1dA0KPiA+ID4gdGhhdCdzIGFs
bCBqdXN0IG5pdHBpY2tpbmcgOikgR28gd2l0aCB3aGF0IHlvdSBsaWtlIHRvIG1haW50YWluDQo+
ID4gPiA6RA0KPiA+ID4gDQo+ID4gDQo+ID4gU3VyZS4gSSB3YXMgdGhpbmtpbmcgYWxvbmcgdGhl
IHNhbWUgbGluZXMgYWZ0ZXIgeW91IGFza2VkLg0KPiANCj4gVGhpcyBpcyBydWJiaXNoLiAgVGhl
IHJlYXNvbiBjbGtfZmluZCgpIGRvZXNuJ3QgdGFrZSB0aGUgbG9jayBpcyB0aGF0DQo+IHlvdSBf
bmVlZF8gdG8gaG9sZCB0aGUgbG9jayB3aGlsZSB5b3UgZGVyZWZlcmVuY2UgdGhlIGNsa19sb29r
dXANCj4gZGF0YS4NCg0KSSB0aGluayB3ZSBhbGwgYWdyZWVkIG9uIHRoaXMgYWxyZWFkeS4gU3Rl
cGhlbiBwb2ludGVkIG91dCB0aGF0IHRoZQ0KY3VycmVudCB1c2VyKHMpIG9mIGNsa19maW5kKCkg
ZG8gX25vdF8gZGVyZWZlcmVuY2UgdGhlIHBvaW50ZXIuDQoNCj4gVGhlIGxvY2sgaXNuJ3QgcHJv
dGVjdGluZyBqdXN0IHRoZSBsb29rdXAsIGl0IHByb3RlY3RzIHdoYXQgeW91IGRvDQo+IHdpdGgN
Cj4gdGhlIHJlc3VsdCBvZiB0aGUgbG9va3VwIGFzIHdlbGwuDQoNCkFuZCB3ZSBhZ3JlZWQgb24g
dGhpcyB0b28uDQoNCkJyLA0KCU1hdHRpIFZhaXR0aW5lbg0KDQoNCg==
