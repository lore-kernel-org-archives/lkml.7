Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DFCC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1C42054F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbfHFICQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:02:16 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:50128 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHFICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:02:15 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id BCCFC626313;
        Tue,  6 Aug 2019 10:02:04 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 6 Aug 2019
 10:02:04 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Tue, 6 Aug 2019 10:02:04 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/4] serial: mctrl_gpio: Add a NULL check to
 mctrl_gpio_to_gpiod()
Thread-Topic: [PATCH v3 2/4] serial: mctrl_gpio: Add a NULL check to
 mctrl_gpio_to_gpiod()
Thread-Index: AQHVSRmhj6XM1Buz9UqFmvYk2hHNCKbno2OAgASBqgCAAX0UAIAABJuA
Date:   Tue, 6 Aug 2019 08:02:04 +0000
Message-ID: <3672939d-183d-f844-c44c-c70a77931c72@kontron.de>
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
 <20190802100349.8659-2-frieder.schrempf@kontron.de>
 <20190802121231.wk6yg5mkyivs3rni@pengutronix.de>
 <f866213b-fd3b-8602-6c11-56cb65a1ea05@kontron.de>
 <20190806074534.5w773nltywxyiljz@pengutronix.de>
In-Reply-To: <20190806074534.5w773nltywxyiljz@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <44F6FF28ECA0604BAC78178DAA15EB46@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: BCCFC626313.A0B69
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

T24gMDYuMDguMTkgMDk6NDUsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBIZWxsbyBGcmll
ZGVyLA0KPiANCj4gT24gTW9uLCBBdWcgMDUsIDIwMTkgYXQgMDk6MDE6MzlBTSArMDAwMCwgU2No
cmVtcGYgRnJpZWRlciB3cm90ZToNCj4+IE9uIDAyLjA4LjE5IDE0OjEyLCBVd2UgS2xlaW5lLUvD
tm5pZyB3cm90ZToNCj4+PiBPbiBGcmksIEF1ZyAwMiwgMjAxOSBhdCAxMDowNDoxMEFNICswMDAw
LCBTY2hyZW1wZiBGcmllZGVyIHdyb3RlOg0KPj4+PiBGcm9tOiBGcmllZGVyIFNjaHJlbXBmIDxm
cmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+Pj4+DQo+Pj4+IEFzIGl0IGlzIGFsbG93ZWQg
dG8gdXNlIHRoZSBtY3RybF9ncGlvXyogZnVuY3Rpb25zIGJlZm9yZQ0KPj4+PiBpbml0aWFsaXph
dGlvbiAoYXMgdGhlIDgyNTAgZHJpdmVyIGRvZXMgYWNjb3JkaW5nIHRvIDQzNGJlMGFlN2FhNyks
DQo+Pj4NCj4+PiBBY3R1YWxseSBJIHdhcyBzdXJwcmlzZWQgc29tZSB0aW1lIGFnbyB0aGF0IDgy
NTAgdXNlZCBzZXJpYWxfbWN0cmwNCj4+PiB3aXRob3V0IGZpcnN0IGluaXRpYWxpemluZyBpdCBh
bmQgZXhwZWN0aW5nIGl0IHRvIHdvcmsuIEkgZGlkbid0IGxvb2sgaW4NCj4+PiBkZXRhaWwsIGJ1
dCBJIHdvdWxkbid0IGdvIHNvIGZhciB0byBjYWxsIHRoaXMgImFsbG93ZWQiLiBUaGUgY29tbWl0
DQo+Pj4gaXRzZWxmIGNhbGxzIGl0ICJ3b3JrYXJvdW5kIiB3aGljaCBzZWVtcyBhIGJldHRlciBt
YXRjaC4NCj4+DQo+PiBPaywgYnV0IGlmIHRoaXMgaXMgY29uc2lkZXJlZCB0byBiZSBhIHdvcmth
cm91bmQgYW5kIGFzIHRoZSA4MjUwIGRyaXZlcg0KPj4gZG9lcyBub3QgdXNlIG1jdHJsX2dwaW9f
dG9fZ3Bpb2QoKSwgd2Ugc2hvdWxkIG1heWJlIGp1c3QgZHJvcCB0aGlzIHBhdGNoDQo+PiBpbnN0
ZWFkIG9mIGVuY291cmFnaW5nIG90aGVycyB0byB1c2UgbWN0cmxfZ3BpbyBiZWZvcmUgaW5pdGlh
bGl6YXRpb24uDQo+Pg0KPj4gSSdtIHJlYWxseSBub3Qgc3VyZSB3aGF0J3MgYmVzdCwgc28gZGVw
ZW5kaW5nIG9uIHdoYXQgeW91IHdpbGwgcHJvcG9zZSwNCj4+IEknbGwgc2VuZCBhIG5ldyB2ZXJz
aW9uIG9mIHRoaXMgcGF0Y2ggd2l0aCBhZGp1c3RlZCBjb21taXQgbWVzc2FnZSBvciBub3QuDQo+
IA0KPiBJIHdvdWxkbid0IGVuY291cmFnZSB1c2FnZSBvZiBtY3RybC1ncGlvIGJlZm9yZSBpdCdz
IGluaXRpYWxpemVkLiBTbyBJDQo+IHN1Z2dlc3QgdG8gZHJvcCB0aGlzIHBhdGNoLg0KDQpPaywg
dGhhbmtzLg==
