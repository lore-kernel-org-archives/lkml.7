Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194B6C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33A92133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfFGVE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:04:56 -0400
Received: from mail-edges23.fraunhofer.de ([153.97.7.23]:61655 "EHLO
        mail-edgeS23.fraunhofer.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730480AbfFGVEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:04:55 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 17:04:53 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EOAwCezvpc/xoBYJlmHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZYIRalMBHhIoCoQLiHuJeYINmh48CQEBAQEBAQEBAQgjDAEBAoQ+Ahe?=
 =?us-ascii?q?CVCM4EwEDAQEFAQEBAQQCAmkcDIJ0BE07MAEBAQEBAQEBAQEBAQEBARoCDWQ?=
 =?us-ascii?q?BBSMROhsCAQgYAgImAgICMBUQAgQBEoMjggkBD6gagTGEBQEBhigGgQwoi1u?=
 =?us-ascii?q?BWD6BEYMSPoJhAgIYgUeDCoI2IgSMBoIbmwMDBAICgTFdhkOMfhuCJIZ4g1i?=
 =?us-ascii?q?KHY0PhxOPS4FmIoFYcU+CbIV/hRSFCAE2PwEBMY8UgSEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2EOAwCezvpc/xoBYJlmHAEBAQQBAQcEAQGBZYIRalMBH?=
 =?us-ascii?q?hIoCoQLiHuJeYINmh48CQEBAQEBAQEBAQgjDAEBAoQ+AheCVCM4EwEDAQEFA?=
 =?us-ascii?q?QEBAQQCAmkcDIJ0BE07MAEBAQEBAQEBAQEBAQEBARoCDWQBBSMROhsCAQgYA?=
 =?us-ascii?q?gImAgICMBUQAgQBEoMjggkBD6gagTGEBQEBhigGgQwoi1uBWD6BEYMSPoJhA?=
 =?us-ascii?q?gIYgUeDCoI2IgSMBoIbmwMDBAICgTFdhkOMfhuCJIZ4g1iKHY0PhxOPS4FmI?=
 =?us-ascii?q?oFYcU+CbIV/hRSFCAE2PwEBMY8UgSEBAQ?=
X-IronPort-AV: E=Sophos;i="5.63,564,1557180000"; 
   d="scan'208";a="11337110"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeS23.fraunhofer.de with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 22:55:09 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CfAgCezvpcfRBhWMBmHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZYJ7UQEgEigKhAuIe4wGmloJAQMBAQEBAQgjDAEBhEACF4J2OBMBAwE?=
 =?us-ascii?q?BBAEBAgEEFAEBFjojDIVLAQIDIxE6GwIBCBgCAiYCAgIwFRACBAESgyOCCg+?=
 =?us-ascii?q?oGoExhAUBAYYoBoEMKI0zPoERgxI+gmECAhiBR4MKgjYiBIwGghubAwMEAgK?=
 =?us-ascii?q?BMV2GQ4x+G4IkhniDWIodjQ+HE49LgWYggVlxT4JshX+FFIUIATY/AQIwjxS?=
 =?us-ascii?q?BIQEB?=
X-IronPort-AV: E=Sophos;i="5.63,564,1557180000"; 
   d="scan'208";a="46147087"
Received: from fgdemucivp01ltm.xch.fraunhofer.de (HELO FGDEMUCIMP11EXC.ads.fraunhofer.de) ([192.88.97.16])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/AES256-SHA; 07 Jun 2019 22:55:08 +0200
Received: from FGDEMUCIMP01EXC.ads.fraunhofer.de ([10.80.232.40]) by
 FGDEMUCIMP11EXC.ads.fraunhofer.de ([10.80.232.42]) with mapi id
 14.03.0439.000; Fri, 7 Jun 2019 22:55:08 +0200
From:   "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "atish.patra@wdc.com" <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>
Subject: Re: [PATCH v3 0/5] arch: riscv: add board and SoC DT file support
Thread-Topic: [PATCH v3 0/5] arch: riscv: add board and SoC DT file support
Thread-Index: AQHVGRnoMEcuH+N8q0CBwbP0jHsqzqaNNtEAgAHw9wCAAScdgIAAEokAgAAxaoA=
Date:   Fri, 7 Jun 2019 20:55:07 +0000
Message-ID: <2edcc269fece4110d2629968c31867ff659e3285.camel@aisec.fraunhofer.de>
References: <20190602080500.31700-1-paul.walmsley@sifive.com>
         <7h36kogchx.fsf@baylibre.com>
         <05010310-baa2-c711-cb54-96a9138f582a@wdc.com>
         <7hftolcp90.fsf@baylibre.com>
         <cf846786-10ed-f0ee-8664-b831a72386da@wdc.com>
In-Reply-To: <cf846786-10ed-f0ee-8664-b831a72386da@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.80.233.51]
x-tm-as-product-ver: SMEX-11.0.0.4179-8.200.1013-24664.000
x-tm-as-result: No--23.108600-8.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="utf-8"
Content-ID: <FED1EFE8D074F4469A1DBA7F1F5EAD4D@xch.fraunhofer.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA2LTA3IGF0IDEwOjU4IC0wNzAwLCBBdGlzaCBQYXRyYSB3cm90ZToNCj4g
T24gNi83LzE5IDk6NTIgQU0sIEtldmluIEhpbG1hbiB3cm90ZToNCj4gPiBBdGlzaCBQYXRyYSA8
YXRpc2gucGF0cmFAd2RjLmNvbT4gd3JpdGVzOg0KPiA+IA0KPiA+ID4gT24gNi81LzE5IDEwOjM3
IEFNLCBLZXZpbiBIaWxtYW4gd3JvdGU6DQo+ID4gPiA+IEhpIFBhdWwsDQo+ID4gPiA+IA0KPiA+
ID4gPiBQYXVsIFdhbG1zbGV5IDxwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20+IHdyaXRlczoNCj4g
PiA+ID4gDQo+ID4gPiA+ID4gQWRkIHN1cHBvcnQgZm9yIGJ1aWxkaW5nIGZsYXR0ZW5lZCBEVCBm
aWxlcyBmcm9tIERUIHNvdXJjZSBmaWxlcyB1bmRlcg0KPiA+ID4gPiA+IGFyY2gvcmlzY3YvYm9v
dC9kdHMuICBGb2xsb3cgZXhpc3Rpbmcga2VybmVsIHByZWNlZGVudCBmcm9tIG90aGVyIFNvQw0K
PiA+ID4gPiA+IGFyY2hpdGVjdHVyZXMuICBTdGFydCBvdXIgYm9hcmQgc3VwcG9ydCBieSBhZGRp
bmcgaW5pdGlhbCBzdXBwb3J0IGZvcg0KPiA+ID4gPiA+IHRoZSBTaUZpdmUgRlU1NDAgU29DIGFu
ZCB0aGUgZmlyc3QgZGV2ZWxvcG1lbnQgYm9hcmQgdGhhdCB1c2VzIGl0LCB0aGUNCj4gPiA+ID4g
PiBTaUZpdmUgSGlGaXZlIFVubGVhc2hlZCBBMDAuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhp
cyB0aGlyZCB2ZXJzaW9uIG9mIHRoZSBwYXRjaCBzZXQgYWRkcyBJMkMgZGF0YSBmb3IgdGhlIGNo
aXAsDQo+ID4gPiA+ID4gaW5jb3Jwb3JhdGVzIGFsbCByZW1haW5pbmcgY2hhbmdlcyB0aGF0IHJp
c2N2LXBrIHdhcyBtYWtpbmcNCj4gPiA+ID4gPiBhdXRvbWF0aWNhbGx5LCBhbmQgYWRkcmVzc2Vz
IGEgY29tbWVudCBmcm9tIFJvYiBIZXJyaW5nDQo+ID4gPiA+ID4gPHJvYmhAa2VybmVsLm9yZz4u
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQm9vdC10ZXN0ZWQgb24gdjUuMi1yYzEgb24gYSBIaUZp
dmUgVW5sZWFzaGVkIEEwMCBib2FyZCwgdXNpbmcgdGhlDQo+ID4gPiA+ID4gQkJMIGFuZCBvcGVu
LXNvdXJjZSBGU0JMLCB3aXRoIG1vZGlmaWNhdGlvbnMgdG8gcGFzcyBpbiB0aGUgRFRCDQo+ID4g
PiA+ID4gZmlsZSBnZW5lcmF0ZWQgYnkgdGhlc2UgcGF0Y2hlcy4NCj4gPiA+ID4gDQo+ID4gPiA+
IFRlc3RlZCB0aGlzIHNlcmllcyBvbiB0b3Agb2YgdjUuMi1yYzMgb24gSGlGaXZlIFVubGVhc2hl
ZCBib2FyZCB1c2luZw0KPiA+ID4gPiBPcGVuU0JJICsgbWFpbmxpbmUgdS1ib290IChtYXN0ZXIg
YnJhbmNoIGFzIG9mIHRvZGF5KS4NCj4gPiA+ID4gDQo+ID4gPiA+IFRlc3RlZC1ieTogS2V2aW4g
SGlsbWFuIDxraGlsbWFuQGJheWxpYnJlLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+ID4gVGhpcyBw
YXRjaCBzZXJpZXMgY2FuIGJlIGZvdW5kLCBhbG9uZyB3aXRoIHRoZSBQUkNJIHBhdGNoIHNldA0K
PiA+ID4gPiA+IGFuZCB0aGUgRFQgbWFjcm8gcHJlcmVxdWlzaXRlIHBhdGNoLCBhdDoNCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBodHRwczovL2dpdGh1Yi5jb20vc2lmaXZlL3Jpc2N2LWxpbnV4L3Ry
ZWUvZGV2L3BhdWx3L2R0cy12NS4yLXJjMQ0KPiA+ID4gPiANCj4gPiA+ID4gbml0OiBJIG9ubHkg
c2VlIHRoaXMgc2VyaWVzIGluIHRoYXQgYnJhbmNoLCBub3QgYW55IG9mIHRoZSBwcmVyZXF1aXNp
dGUNCj4gPiA+ID4gcGF0Y2hlcyB5b3UgbWVudGlvbmVkLCB3aGljaCBtYWRlIG1lIGFzc3VtZSBJ
IGNvdWxkIHRoaXMgc2VyaWVzIGFsb25lIG9uDQo+ID4gPiA+IHRvcCBvZiB2NS4yLXJjMywgd2hp
Y2ggd29ya2VkIGp1c3QgZmluZS4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEkgdHJpZWQgb25s
eSB0aGlzIHNlcmllcyBvbiB0b3Agb2YgdjUuMi1yYzMuIEtlcm5lbCBib290cyBmaWxlIHdpdGgg
RFQNCj4gPiA+IHVwZGF0ZWQgdmlhIFUtQm9vdC4gQnV0IG5ldHdvcmtpbmcgZGlkbid0IGNvbWUg
dXAuDQo+ID4gPiANCj4gPiA+IERvIHlvdSBoYXZlIG5ldHdvcmtpbmcgdXAgYWZ0ZXIgdGhlIGJv
b3Q/IElmIHllcywgY2FuIHlvdSBwbGVhc2Ugc2hhcmUNCj4gPiA+IHRoZSBjb25maWcuDQo+ID4g
DQo+ID4gSSBkaWRuJ3QgdGVzdCBuZXR3b3JraW5nIGZyb20gdGhlIGtlcm5lbCBpbml0aWFsbHks
IGJ1dCBsb29raW5nIG5vdywgSQ0KPiA+IGRvIG5vdCBoYXZlIG5ldHdvcmtpbmcgY29tZSB1cCBp
biB0aGUga2VybmVsIGVpdGhlci4NCj4gPiANCj4gDQo+IG9rLiBJIGFtIG5vdCBhbG9uZSB0aGVu
IDopLg0KPiANCj4gQFBhdWw6IERvIHlvdSBnZXQgbmV0d29ya2luZyB1cCBpbiB5b3VyIEZTQkwg
KyBCQkwgKyBMaW51eCBib290IGZsb3cgDQo+IHdpdGggdGhlIERUIHBhdGNoIHNlcmllcyA/DQo+
IA0KDQpUaGVyZSBkb2VzIG5vdCBhcHBlYXIgdG8gYmUgYSBkZXZpY2UgdHJlZSBub2RlIGZvciB0
aGUgZXRoZXJuZXQNCmNvbnRyb2xsZXIsIHdoaWNoIHdvdWxkIGJlIHdoeSBuZXR3b3JraW5nIGlz
IG5vdCBjb21pbmcgdXAuIFUtQm9vdCBhbHNvDQpoYXMgdG8gYmUgdXBkYXRlZCB0byBtYXRjaCB0
aGUgbmV3IGRldmljZSBiaW5kaW5ncyBpbnRyb2R1Y2VkIGJ5IHRoZQ0KZXRoZXJuZXQgY29udHJv
bGxlciBwYXRjaGVzIGN1cnJlbnRseSBvbiB0aGUgbWFpbGluZyBsaXN0IFsxXS4NCg0KVGhhbmtz
LA0KTHVrYXMNCg0KWzFdOiANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9s
aW51eC1yaXNjdi9saXN0Lz9zZXJpZXM9MTIxNTc5DQo=
