Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDDAC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A775D20665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfIPLt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:49:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:58478 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730110AbfIPLt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:49:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-166-eM_ZKBYxM-CKIRdpMPgtuQ-1; Mon, 16 Sep 2019 12:49:23 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 16 Sep 2019 12:49:22 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 16 Sep 2019 12:49:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
CC:     Miles Chen <miles.chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: RE: [tip: sched/core] sched/psi: Correct overly pessimistic size
 calculation
Thread-Topic: [tip: sched/core] sched/psi: Correct overly pessimistic size
 calculation
Thread-Index: AQHVaoS2xzP/Zpoyw0CDGPLgyB3STacuM1dg
Date:   Mon, 16 Sep 2019 11:49:22 +0000
Message-ID: <ead094dabae64e6c978e94b617c8d08c@AcuMS.aculab.com>
References: <20190912103452.13281-1-miles.chen@mediatek.com>
 <156841460535.24167.6273030361884540421.tip-bot2@tip-bot2>
In-Reply-To: <156841460535.24167.6273030361884540421.tip-bot2@tip-bot2>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: eM_ZKBYxM-CKIRdpMPgtuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWlsZXMgQ2hlbg0KPiBTZW50OiAxMyBTZXB0ZW1iZXIgMjAxOSAyMzo0Mw0KPiBUaGUg
Zm9sbG93aW5nIGNvbW1pdCBoYXMgYmVlbiBtZXJnZWQgaW50byB0aGUgc2NoZWQvY29yZSBicmFu
Y2ggb2YgdGlwOg0KPiANCj4gQ29tbWl0LUlEOiAgICAgNGFkY2RjZWE3MTdjYjJkODQzNmJlZjAw
ZGQ2ODlhYTViYzc2ZjExYg0KPiBHaXR3ZWI6ICAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3RpcC80YWRjZGNlYTcxN2NiMmQ4NDM2YmVmMDBkZDY4OWFhNWJjNzZmMTFiDQo+IEF1dGhvcjog
ICAgICAgIE1pbGVzIENoZW4gPG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiBBdXRob3JEYXRl
OiAgICBUaHUsIDEyIFNlcCAyMDE5IDE4OjM0OjUyICswODowMA0KPiBDb21taXR0ZXI6ICAgICBJ
bmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz4NCj4gQ29tbWl0dGVyRGF0ZTogRnJpLCAxMyBT
ZXAgMjAxOSAwNzo0OToyOCArMDI6MDANCj4gDQo+IHNjaGVkL3BzaTogQ29ycmVjdCBvdmVybHkg
cGVzc2ltaXN0aWMgc2l6ZSBjYWxjdWxhdGlvbg0KPiANCj4gV2hlbiBwYXNzaW5nIGEgZXF1YWwg
b3IgbW9yZSB0aGVuIDMyIGJ5dGVzIGxvbmcgc3RyaW5nIHRvIHBzaV93cml0ZSgpLA0KPiBwc2lf
d3JpdGUoKSBjb3BpZXMgMzEgYnl0ZXMgdG8gaXRzIGJ1ZiBhbmQgb3ZlcndyaXRlcyBidWZbMzBd
DQo+IHdpdGggJ1wwJy4gV2hpY2ggbWFrZXMgdGhlIGlucHV0IHN0cmluZyAxIGJ5dGUgc2hvcnRl
ciB0aGFuDQo+IGl0IHNob3VsZCBiZS4NCj4gDQo+IEZpeCBpdCBieSBjb3B5aW5nIHNpemVvZihi
dWYpIGJ5dGVzIHdoZW4gbmJ5dGVzID49IHNpemVvZihidWYpLg0KPiANCj4gVGhpcyBkb2VzIG5v
dCBjYXVzZSBwcm9ibGVtcyBpbiBub3JtYWwgdXNlIGNhc2UgbGlrZToNCj4gInNvbWUgNTAwMDAw
IDEwMDAwMDAwIiBvciAiZnVsbCA1MDAwMDAgMTAwMDAwMDAiIGJlY2F1c2UgdGhleQ0KPiBhcmUg
bGVzcyB0aGFuIDMyIGJ5dGVzIGluIGxlbmd0aC4NCj4gDQo+IAkvKiBhc3N1bWluZyBuYnl0ZXMg
PT0gMzUgKi8NCj4gCWNoYXIgYnVmWzMyXTsNCj4gDQo+IAlidWZfc2l6ZSA9IG1pbihuYnl0ZXMs
IChzaXplb2YoYnVmKSAtIDEpKTsgLyogYnVmX3NpemUgPSAzMSAqLw0KPiAJaWYgKGNvcHlfZnJv
bV91c2VyKGJ1ZiwgdXNlcl9idWYsIGJ1Zl9zaXplKSkNCj4gCQlyZXR1cm4gLUVGQVVMVDsNCj4g
DQo+IAlidWZbYnVmX3NpemUgLSAxXSA9ICdcMCc7IC8qIGJ1ZlszMF0gPSAnXDAnICovDQoNCldv
dWxkbid0IGl0IGJlIGJldHRlciB0byBhbHNvIGFsbG93IHRoZSB1c2VyIHRvIHBhc3MNCmFuIHVu
dGVybWluYXRlZCBzdHJpbmc/DQpTbyBsZWF2ZSB0aGUgJy0xJyBvbiB0aGUgYXNzaWdubWVudCB0
byBidWZfc2l6ZSwgYnV0IHJlbW92ZQ0KaXQgZnJvbSB0aGUgbGFzdCBsaW5lLg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

