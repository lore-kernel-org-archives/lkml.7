Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454DCC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CB2206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbfHAK77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 06:59:59 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:39612 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfHAK76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:59:58 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 46F8867A8D5;
        Thu,  1 Aug 2019 12:59:55 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 1 Aug 2019
 12:59:54 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Thu, 1 Aug 2019 12:59:54 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] serial: imx: Avoid probe failure in case of missing
 gpiolib
Thread-Topic: [PATCH] serial: imx: Avoid probe failure in case of missing
 gpiolib
Thread-Index: AQHVSEGkENWr6+HjfEGe5le+et6Jcabl2bqAgAALMwCAAAeIgIAAEf6A
Date:   Thu, 1 Aug 2019 10:59:54 +0000
Message-ID: <0174be55-5e40-8cc7-82c7-54f9de46f711@kontron.de>
References: <20190801081524.22577-1-frieder.schrempf@kontron.de>
 <20190801084827.m42ci3amo37hmesi@pengutronix.de>
 <0674d68b-99fa-3408-1dd1-22dc84144b43@kontron.de>
 <20190801095529.dm3pvgts6cy6mbiq@pengutronix.de>
In-Reply-To: <20190801095529.dm3pvgts6cy6mbiq@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <0628AA5336195744A936E2B9B571403C@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 46F8867A8D5.A1B07
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: festevam@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEuMDguMTkgMTE6NTUsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBPbiBUaHUsIEF1
ZyAwMSwgMjAxOSBhdCAwOToyODozM0FNICswMDAwLCBTY2hyZW1wZiBGcmllZGVyIHdyb3RlOg0K
Pj4gSGkgVXdlLA0KPj4NCj4+IE9uIDAxLjA4LjE5IDEwOjQ4LCBVd2UgS2xlaW5lLUvDtm5pZyB3
cm90ZToNCj4+PiBPbiBUaHUsIEF1ZyAwMSwgMjAxOSBhdCAwODoxODowNUFNICswMDAwLCBTY2hy
ZW1wZiBGcmllZGVyIHdyb3RlOg0KPj4+PiBGcm9tOiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVy
LnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+Pj4+DQo+Pj4+IElmIENPTkZJR19HUElPTElCIGlzIG5v
dCBlbmFibGVkLCBtY3RybF9ncGlvX2luaXQoKSB3aWxsIHJldHVybg0KPj4+PiAtRU5PU1lTIGFu
ZCBjYXVzZSB0aGUgcHJvYmluZyBvZiB0aGUgaW14IFVBUlQgdG8gZmFpbC4gQXMgdGhlDQo+Pj4+
IEdQSU9zIGFyZSBvcHRpb25hbCwgd2Ugc2hvdWxkIGNvbnRpbnVlIHByb2JpbmcgaW4gdGhpcyBj
YXNlLg0KPj4+DQo+Pj4gSXMgdGhpcyByZWFsbHkgc3RpbGwgdGhlIGNhc2U/IE9uIHdoaWNoIHZl
cnNpb24gZGlkIHlvdSBoaXQgdGhpcw0KPj4+IHByb2JsZW0/DQo+Pg0KPj4gWWVzLCBJIHRoaW5r
IGl0IGlzLiBJIHVzZWQgdjUuMi41LCB0aGF0IGFscmVhZHkgaGFzIGQ5OTQ4MjY3M2Y5NS4NCj4+
DQo+Pj4NCj4+PiBJIHdvdWxkIGV4cGVjdCB0aGF0IGlzIGdvbmUgd2l0aA0KPj4+IGQ5OTQ4MjY3
M2Y5NTA4MTdiMzBjYWYzZmNkZmIzMTE3OWIwNTBjZTEgaWYgbm90IGVhcmxpZXIuDQo+Pg0KPj4g
SSB0aGluayB0aGlzIGlzIGEgZGlmZmVyZW50IHByb2JsZW0uIElmIENPTkZJR19HUElPTElCIGlz
IGRpc2FibGVkLA0KPj4gbWN0cmxfZ3Bpb19pbml0KCkgcmV0dXJucyAtRU5PU1lTIHVuY29uZGl0
aW9uYWxseSBoZXJlOiBbMV0uIFRoZQ0KPj4gZXhpc3RpbmcgcGF0Y2ggKGQ5OTQ4MjY3M2Y5NSkg
c2VlbXMgdG8gaGFuZGxlIHRoZSBjYXNlIHdoZW4NCj4+IENPTkZJR19HUElPTElCIGlzIGVuYWJs
ZWQsIGJ1dCBubyBvciBub3QgYWxsIEdQSU9zIGFyZSBnaXZlbiBpbiB0aGUgZHRiLg0KPiANCj4g
QWgsIEkgc2VlLg0KPiANCj4gSSBkb24ndCB0aGluayB3ZSBzaG91bGQgaGFuZGxlIHRoaXMgb24g
YSBwZXItZHJpdmVyIGJhc2lzLiBTbyBteQ0KPiBzdWdnZXN0aW9uIGlzIHRvIGRyb3AgdGhlIGR1
bW15IGltcGxlbWVudGF0aW9uIGZvciBtY3RybF9ncGlvIGlmIEdQSU9MSUINCj4gaXMgZGlzYWJs
ZWQuIFRoZW4gdGhlIGJlaGF2aW91ciBzaG91bGQgYmUgY29uc2lzdGFudCB3aXRoIHRoZSBncGlv
IHN0dWZmDQo+IHJldHVybmluZyBOVUxMIGluIHRoaXMgY2FzZS4gKE9yIGFsdGVybmF0aXZlbHkg
YWRhcHQgdGhlIGR1bW15DQo+IGltcGxlbWVudGF0aW9uIHRvIHNob3J0Y3V0IGFuZCBiZWhhdmUg
aWRlbnRpY2FsbHkuKQ0KDQpJIGdldCB5b3VyIHBvaW50LCBidXQgaXQgc2VlbXMgYSBiaXQgc3Ry
YW5nZSB0byBnbyBkb3duIGFsbCB0aGUgd2F5IGZyb20gDQp0aGUgZHJpdmVyIHRvIG1jdHJsX2dw
aW9faW5pdF9ub2F1dG8oKSBhbmQgaW50byB0aGUgbG9vcCBqdXN0IHRvIHJldHVybiANCmFuIGVt
cHR5IHN0cnVjdCBtY3RybF9ncGlvcyB0byB0aGUgZHJpdmVyIHRoYXQgd2lsbCBiZSBsb29wZWQg
b3ZlciBhZ2FpbiANCm9uIGVhY2ggY2FsbCBvZiBtY3RybF9ncGlvXyooKS4NCg0KU28gSSB3b3Vs
ZCByYXRoZXIgZ28gd2l0aCBhIHZhcmlhdGlvbiBvZiB5b3VyIHNlY29uZCBwcm9wb3NhbCBhbmQg
a2VlcCANCnRoZSBkdW1teSBpbXBsZW1lbnRhdGlvbiwgYnV0IGxldCBpdCByZXR1cm4gTlVMTCBp
bnN0ZWFkIG9mIGFuIGVycm9yIA0KcG9pbnRlciwgYXMgYWxsIHRoZSBtY3RybF9ncGlvXyooKSBm
dW5jdGlvbnMgYWxyZWFkeSBzZWVtIHRvIGhhdmUgYSANCmNoZWNrIGZvciBncGlvcyA9PSBOVUxM
Lg0KDQpXaGF0IGRvIHlvdSB0aGluaz8NCg0KPiANCj4gKEhhdmluZyBzYWlkIHRoYXQgSSBkb24n
dCBsaWtlIGdwaW9saWIncyBiZWhhdmlvdXIgb2YgcmV0dXJuaW5nIE5VTEwgZm9yDQo+IHRoZSBv
cHRpb25hbCBjYWxscyBpZiBpdCdzIGRpc2FibGVkLCBidXQgaGF2aW5nIG1jdHJsX2dwaW8gYmVo
YXZlDQo+IGRpZmZlcmVudGx5IGlzIHdvcnNlLikNCj4gDQo+PiBUaGUgc2gtc2NpLmMgZHJpdmVy
IGhhcyBhIHNpbWlsYXIgY2hlY2sgdG8gc2tpcCB0aGlzIGNhc2U6IFsyXS4NCj4gDQo+IFRoaXMg
c2hvdWxkIHRoYW4gYmUgZHJvcHBlZCwgdG9vLg0KPiANCj4gQmVzdCByZWdhcmRzDQo+IFV3ZQ0K
PiANCj4+IFsxXQ0KPj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9t
Y3RybF9ncGlvLmgjbjEyMQ0KPj4gWzJdDQo+PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL3R0eS9z
ZXJpYWwvc2gtc2NpLmMjbjMyOTANCj4g
