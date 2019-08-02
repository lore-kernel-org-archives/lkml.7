Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C488AC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E5A20449
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390579AbfHBH45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 03:56:57 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:52600 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733079AbfHBH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:56:57 -0400
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 903086274D3;
        Fri,  2 Aug 2019 09:56:54 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 2 Aug 2019
 09:56:54 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Fri, 2 Aug 2019 09:56:54 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] serial: mctrl_gpio: Avoid probe failures in case
 of missing gpiolib
Thread-Topic: [PATCH v2 1/3] serial: mctrl_gpio: Avoid probe failures in case
 of missing gpiolib
Thread-Index: AQHVSJlF+cJCIhOOZEmFG6rcowK4DKbmnfgAgAC/AIA=
Date:   Fri, 2 Aug 2019 07:56:54 +0000
Message-ID: <011ac0ac-571e-b898-2b2d-89b9a771b0c1@kontron.de>
References: <20190801184505.17239-1-frieder.schrempf@kontron.de>
 <20190801203316.7ntlv6hequmddfxu@pengutronix.de>
In-Reply-To: <20190801203316.7ntlv6hequmddfxu@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <A210968F3B3FF3419F4E28B9062075B3@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 903086274D3.ACEE6
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: festevam@gmail.com, geert+renesas@glider.be,
        gregkh@linuxfoundation.org, jslaby@suse.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEuMDguMTkgMjI6MzMsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBPbiBUaHUsIEF1
ZyAwMSwgMjAxOSBhdCAwNjo0NToyMVBNICswMDAwLCBTY2hyZW1wZiBGcmllZGVyIHdyb3RlOg0K
Pj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0K
Pj4NCj4+IElmIENPTkZJR19HUElPTElCIGlzIG5vdCBlbmFibGVkLCBtY3RybF9ncGlvX2luaXQo
KSBhbmQNCj4+IG1jdHJsX2dwaW9faW5pdF9ub2F1dG8oKSB3aWxsIGN1cnJlbnRseSByZXR1cm4g
YW4gZXJyb3IgcG9pbnRlciB3aXRoDQo+PiAtRU5PU1lTLiBBcyB0aGUgbWN0cmwgR1BJT3MgYXJl
IHVzdWFsbHkgb3B0aW9uYWwsIGRyaXZlcnMgbmVlZCB0bw0KPj4gY2hlY2sgZm9yIHRoaXMgY29u
ZGl0aW9uIHRvIGFsbG93IGNvbnRpbnVlIHByb2JpbmcuDQo+Pg0KPj4gVG8gYXZvaWQgdGhlIG5l
ZWQgZm9yIHRoaXMgY2hlY2sgaW4gZWFjaCBkcml2ZXIsIHdlIHJldHVybiBOVUxMDQo+PiBpbnN0
ZWFkLCBhcyBhbGwgdGhlIG1jdHJsX2dwaW9fKigpIGZ1bmN0aW9ucyBhcmUgc2tpcHBlZCBhbnl3
YXkuDQo+PiBXZSBhbHNvIGFkYXB0IG1jdHJsX2dwaW9fdG9fZ3Bpb2QoKSB0byBiZSBpbiBsaW5l
IHdpdGggdGhpcyBjaGFuZ2UuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRnJpZWRlciBTY2hyZW1w
ZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0KPj4gUmV2aWV3ZWQtYnk6IEZhYmlvIEVz
dGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gDQo+IG5pdHBpY2s6IHB1dCB5b3VyIFMtby1i
IGxhc3QuDQoNCk9rLg0KDQo+PiAtLS0NCj4+IENoYW5nZXMgaW4gdjINCj4+ID09PT09PT09PT09
PT0NCj4+ICogTW92ZSB0aGUgc2hfc2NpIGNoYW5nZXMgdG8gYSBzZXBhcmF0ZSBwYXRjaA0KPj4g
KiBBZGQgYSBwYXRjaCBmb3IgdGhlIDgyNTAgZHJpdmVyDQo+PiAqIEFkZCBGYWJpbydzIFItYiB0
YWcNCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX21jdHJsX2dwaW8uYyB8
IDMgKysrDQo+PiAgIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfbWN0cmxfZ3Bpby5oIHwgNiAr
KystLS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfbWN0cmxf
Z3Bpby5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9tY3RybF9ncGlvLmMNCj4+IGluZGV4
IDJiNDAwMTg5YmU5MS4uNTRjNDNlMDJlMzc1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy90dHkv
c2VyaWFsL3NlcmlhbF9tY3RybF9ncGlvLmMNCj4+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9z
ZXJpYWxfbWN0cmxfZ3Bpby5jDQo+PiBAQCAtNjEsNiArNjEsOSBAQCBFWFBPUlRfU1lNQk9MX0dQ
TChtY3RybF9ncGlvX3NldCk7DQo+PiAgIHN0cnVjdCBncGlvX2Rlc2MgKm1jdHJsX2dwaW9fdG9f
Z3Bpb2Qoc3RydWN0IG1jdHJsX2dwaW9zICpncGlvcywNCj4+ICAgCQkJCSAgICAgIGVudW0gbWN0
cmxfZ3Bpb19pZHggZ2lkeCkNCj4+ICAgew0KPj4gKwlpZiAoZ3Bpb3MgPT0gTlVMTCkNCj4+ICsJ
CXJldHVybiBOVUxMOw0KPj4gKw0KPiANCj4gSSB3b25kZXIgd2h5IHlvdSBuZWVkIHRoaXMuIElm
IEdQSU9MSUIgaXMgb2ZmIHRoaXMgY29kZSBpc24ndCBhY3RpdmUgYW5kDQo+IHdpdGggR1BJT0xJ
QiBjYWxsaW5nIG1jdHJsX2dwaW9fdG9fZ3Bpb2Qgd2l0aCBhIGdwaW9zID09IE5VTEwgaXMgYSBi
dWcNCj4gdGhhdCBJTUhPIHNob3VsZCBub3QgYmUgc2lsZW50bHkgaWdub3JlZC4NCj4gDQo+IEFt
IEkgbWlzc2luZyBzb21ldGhpbmcgKGFnYWluKT8NCg0KTm8sIHlvdSdyZSByaWdodC4gTXkgdGhv
dWdodHMgd2VyZSwgdGhhdCBpZiB0aGUgbWN0cmxfZ3BpbyBmdW5jdGlvbnMgYXJlIA0KYWxsb3dl
ZCB0byBiZSBwYXNzZWQgYSBOVUxMIHBvaW50ZXIgaW4gZ2VuZXJhbCwgdGhleSBhbGwgc2hvdWxk
IGhhdmUgYSANCk5VTEwgY2hlY2ssIGV2ZW4gaWYgaW4gdGhlIGN1cnJlbnQgY29udGV4dCAoR1BJ
T0xJQiBkaXNhYmxlZCkgdGhpcyBjb2RlIA0KaXMgbm90IGFjdGl2ZS4gQXBwYXJlbnRseSB0aGVy
ZSBhcmUgb3RoZXIgY2FzZXMgd2hlbiBhIE5VTEwgcG9pbnRlciBpcyANCnBhc3NlZCwgc2VlIFsx
XS4gU28geW91IGNhbid0IHJlYWxseSBjb25zaWRlciBncGlvcyA9PSBOVUxMIHRvIGJlIGEgYnVn
IA0KYXMgdGhpcyBzZWVtcyB0byBiZSBhbGxvd2VkIGluIGdlbmVyYWwuDQoNClsxXSANCmh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC9jb21taXQ/aWQ9NDM0YmUwYWU3YWE3NDZmNDgxYzNhMjIxMzllNDcyZGJjM2Y0ZjgxNw0K
DQo+IA0KPj4gICAJcmV0dXJuIGdwaW9zLT5ncGlvW2dpZHhdOw0KPj4gICB9DQo+IA0KPiBCZXN0
IHJlZ2FyZHMNCj4gVXdlDQo+IA==
