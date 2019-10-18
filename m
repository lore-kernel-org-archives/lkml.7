Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6144CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFD321852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632938AbfJRIrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:47:46 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:36034 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbfJRIrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:47:46 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9I8lSho028617
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Oct 2019 17:47:28 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9I8lStp003906;
        Fri, 18 Oct 2019 17:47:28 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9I8l4aE002929;
        Fri, 18 Oct 2019 17:47:28 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-9643500; Fri, 18 Oct 2019 17:46:04 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0439.000; Fri,
 18 Oct 2019 17:46:04 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Qian Cai <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: memory offline infinite loop after soft offline
Thread-Topic: memory offline infinite loop after soft offline
Thread-Index: AQHVgHtyUduz67i7AUWqxWZ+Pu+7vadZPeAAgATGWACAAAeGAIAAh9KAgAAFzYCAAIOhAIAAP4+AgAAHNACAABD9AIAAFF4A
Date:   Fri, 18 Oct 2019 08:46:04 +0000
Message-ID: <20191018084603.GA5821@hori.linux.bs1.fc.nec.co.jp>
References: <1570829564.5937.36.camel@lca.pw>
 <20191014083914.GA317@dhcp22.suse.cz>
 <20191017093410.GA19973@hori.linux.bs1.fc.nec.co.jp>
 <20191017100106.GF24485@dhcp22.suse.cz> <1571335633.5937.69.camel@lca.pw>
 <20191017182759.GN24485@dhcp22.suse.cz>
 <20191018021906.GA24978@hori.linux.bs1.fc.nec.co.jp>
 <20191018060635.GA5017@dhcp22.suse.cz>
 <20191018063222.GA15406@hori.linux.bs1.fc.nec.co.jp>
 <20191018073310.GB5017@dhcp22.suse.cz>
In-Reply-To: <20191018073310.GB5017@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF33C9B5D9D42A4387CEC5653B21960F@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBPY3QgMTgsIDIwMTkgYXQgMDk6MzM6MTBBTSArMDIwMCwgTWljaGFsIEhvY2tvIHdy
b3RlOg0KPiBPbiBGcmkgMTgtMTAtMTkgMDY6MzI6MjIsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToN
Cj4gPiBPbiBGcmksIE9jdCAxOCwgMjAxOSBhdCAwODowNjozNUFNICswMjAwLCBNaWNoYWwgSG9j
a28gd3JvdGU6DQo+ID4gPiBPbiBGcmkgMTgtMTAtMTkgMDI6MTk6MDYsIE5hb3lhIEhvcmlndWNo
aSB3cm90ZToNCj4gPiA+ID4gT24gVGh1LCBPY3QgMTcsIDIwMTkgYXQgMDg6Mjc6NTlQTSArMDIw
MCwgTWljaGFsIEhvY2tvIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFRodSAxNy0xMC0xOSAxNDowNzox
MywgUWlhbiBDYWkgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBUaHUsIDIwMTktMTAtMTcgYXQgMTI6
MDEgKzAyMDAsIE1pY2hhbCBIb2NrbyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gT24gVGh1IDE3LTEw
LTE5IDA5OjM0OjEwLCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gT24g
TW9uLCBPY3QgMTQsIDIwMTkgYXQgMTA6Mzk6MTRBTSArMDIwMCwgTWljaGFsIEhvY2tvIHdyb3Rl
Og0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gWy4uLl0NCj4gPiA+ID4gPiA+ID4gPiA+
IGRpZmYgLS1naXQgYS9tbS9wYWdlX2lzb2xhdGlvbi5jIGIvbW0vcGFnZV9pc29sYXRpb24uYw0K
PiA+ID4gPiA+ID4gPiA+ID4gaW5kZXggODljMTljMGZlYWRiLi41ZmIzZmVlMTZmZGUgMTAwNjQ0
DQo+ID4gPiA+ID4gPiA+ID4gPiAtLS0gYS9tbS9wYWdlX2lzb2xhdGlvbi5jDQo+ID4gPiA+ID4g
PiA+ID4gPiArKysgYi9tbS9wYWdlX2lzb2xhdGlvbi5jDQo+ID4gPiA+ID4gPiA+ID4gPiBAQCAt
Mjc0LDcgKzI3NCw3IEBAIF9fdGVzdF9wYWdlX2lzb2xhdGVkX2luX3BhZ2VibG9jayh1bnNpZ25l
ZCBsb25nIHBmbiwgdW5zaWduZWQgbG9uZyBlbmRfcGZuLA0KPiA+ID4gPiA+ID4gPiA+ID4gIAkJ
CSAqIHNpbXBsZSB3YXkgdG8gdmVyaWZ5IHRoYXQgYXMgVk1fQlVHX09OKCksIHRob3VnaC4NCj4g
PiA+ID4gPiA+ID4gPiA+ICAJCQkgKi8NCj4gPiA+ID4gPiA+ID4gPiA+ICAJCQlwZm4gKz0gMSA8
PCBwYWdlX29yZGVyKHBhZ2UpOw0KPiA+ID4gPiA+ID4gPiA+ID4gLQkJZWxzZSBpZiAoc2tpcF9o
d3BvaXNvbmVkX3BhZ2VzICYmIFBhZ2VIV1BvaXNvbihwYWdlKSkNCj4gPiA+ID4gPiA+ID4gPiA+
ICsJCWVsc2UgaWYgKHNraXBfaHdwb2lzb25lZF9wYWdlcyAmJiBQYWdlSFdQb2lzb24oY29tcG91
bmRfaGVhZChwYWdlKSkpDQo+ID4gPiA+ID4gPiA+ID4gPiAgCQkJLyogQSBIV1BvaXNvbmVkIHBh
Z2UgY2Fubm90IGJlIGFsc28gUGFnZUJ1ZGR5ICovDQo+ID4gPiA+ID4gPiA+ID4gPiAgCQkJcGZu
Kys7DQo+ID4gPiA+ID4gPiA+ID4gPiAgCQllbHNlDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiA+ID4gVGhpcyBmaXggbG9va3MgZ29vZCB0byBtZS4gVGhlIG9yaWdpbmFsIGNvZGUgb25s
eSBhZGRyZXNzZXMgaHdwb2lzb25lZCA0a0ItcGFnZSwNCj4gPiA+ID4gPiA+ID4gPiB3ZSBzZWVt
IHRvIGhhdmUgdGhpcyBpc3N1ZSBzaW5jZSB0aGUgZm9sbG93aW5nIGNvbW1pdCwNCj4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+IFRoYW5rcyBhIGxvdCBmb3IgZG91YmxlIGNoZWNraW5nIE5h
b3lhIQ0KPiA+ID4gPiA+ID4gPiAgDQo+ID4gPiA+ID4gPiA+ID4gICBjb21taXQgYjAyM2Y0Njgx
M2NkZTZlM2I4YThjMjRmNDMyZmY5YzFmZDhlOWE2NA0KPiA+ID4gPiA+ID4gPiA+ICAgQXV0aG9y
OiBXZW4gQ29uZ3lhbmcgPHdlbmN5QGNuLmZ1aml0c3UuY29tPg0KPiA+ID4gPiA+ID4gPiA+ICAg
RGF0ZTogICBUdWUgRGVjIDExIDE2OjAwOjQ1IDIwMTIgLTA4MDANCj4gPiA+ID4gPiA+ID4gPiAg
IA0KPiA+ID4gPiA+ID4gPiA+ICAgICAgIG1lbW9yeS1ob3RwbHVnOiBza2lwIEhXUG9pc29uZWQg
cGFnZSB3aGVuIG9mZmxpbmluZyBwYWdlcw0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiA+IGFuZCBleHRlbnNpb24gb2YgTFRQIGNvdmVyYWdlIGZpbmFsbHkgZGlzY292ZXJlZCB0aGlz
Lg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gUWlhbiwgY291bGQgeW91IGdpdmUgdGhl
IHBhdGNoIHNvbWUgdGVzdGluZz8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVW5mb3J0dW5h
dGVseSwgdGhpcyBkb2VzIG5vdCBzb2x2ZSB0aGUgcHJvYmxlbS7CoEl0IGxvb2tzIHRvIG1lIHRo
YXQgaW4NCj4gPiA+ID4gPiA+IHNvZnRfb2ZmbGluZV9odWdlX3BhZ2UoKSwgc2V0X2h3cG9pc29u
X2ZyZWVfYnVkZHlfcGFnZSgpIHdpbGwgb25seSBzZXQNCj4gPiA+ID4gPiA+IFBHX2h3cG9pc29u
IGZvciBidWRkeSBwYWdlcywgc28gdGhlIGV2ZW4gdGhlIGNvbXBvdW5kX2hlYWQoKSBoYXMgbm8g
UEdfaHdwb2lzb24NCj4gPiA+ID4gPiA+IHNldC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
CQlpZiAoUGFnZUJ1ZGR5KHBhZ2VfaGVhZCkgJiYgcGFnZV9vcmRlcihwYWdlX2hlYWQpID49IG9y
ZGVyKSB7DQo+ID4gPiA+ID4gPiAJCQlpZiAoIVRlc3RTZXRQYWdlSFdQb2lzb24ocGFnZSkpDQo+
ID4gPiA+ID4gPiAJCQkJaHdwb2lzb25lZCA9IHRydWU7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
VGhpcyBpcyBtb3JlIHRoYW4gdW5leHBlY3RlZC4gSG93IGFyZSB3ZSBzdXBwb3NlZCB0byBmaW5k
IG91dCB0aGF0IHRoZQ0KPiA+ID4gPiA+IHBhZ2UgaXMgcG9pc29uZWQ/IEFueSBpZGVhIE5hb3lh
Pw0KPiA+ID4gPiANCj4gPiA+ID4gIyBzb3JyeSBmb3IgbXkgcG9vciByZXZpZXcuLi4NCj4gPiA+
ID4gDQo+ID4gPiA+IFdlIHNldCBQR19od3BvaXNvbiBiaXQgb25seSBvbiB0aGUgaGVhZCBwYWdl
IGZvciBodWdldGxiLCB0aGF0J3MgYmVjYXVzZQ0KPiA+ID4gPiB3ZSBoYW5kbGUgbXVsdGlwbGUg
cGFnZXMgYXMgYSBzaW5nbGUgb25lIGZvciBodWdldGxiLiBTbyBpdCdzIGVub3VnaA0KPiA+ID4g
PiB0byBjaGVjayBpc29sYXRpb24gb25seSBvbiB0aGUgaGVhZCBwYWdlLiAgU2ltcGx5IHNraXBw
aW5nIHBmbiBjdXJzb3IgdG8NCj4gPiA+ID4gdGhlIHBhZ2UgYWZ0ZXIgdGhlIGh1Z2VwYWdlIHNo
b3VsZCBhdm9pZCB0aGUgaW5maW5pdGUgbG9vcDoNCj4gPiA+IA0KPiA+ID4gQnV0IHRoZSBwYWdl
IGR1bXAgUWlhbiBwcm92aWRlZCBzaG93cyB0aGF0IHRoZSBoZWFkIHBhZ2UgZG9lc24ndCBoYXZl
DQo+ID4gPiBIV1BvaXNvbiBiaXQgZWl0aGVyLiBJZiBpdCBoYWQgdGhlbiBnb2luZyBwZm4gYXQg
YSB0aW1lIHNob3VsZCBqdXN0IHdvcmsNCj4gPiA+IGJlY2F1c2UgYWxsIHRhaWwgcGFnZXMgd291
bGQgYmUgc2tpcHBlZC4gT3IgZG8gSSBtaXNzIHNvbWV0aGluZz8NCj4gPiANCj4gPiBZb3UncmUg
cmlnaHQsIHRoZW4gSSBkb24ndCBzZWUgaG93IHRoaXMgaGFwcGVucy4NCj4gDQo+IE9LLCB0aGlz
IGlzIGEgYml0IHJlbGlldmluZy4gSSB0aG91Z2h0IHRoYXQgdGhlcmUgYXJlIGxlZ2l0aW1hdGUg
Y2FzZXMNCj4gd2hlbiBub25lIG9mIHRoZSBodWdldGxiIGdldHMgdGhlIEhXUG9pc29uIGJpdCAo
ZS5nLiB3aGVuIHRoZSBwYWdlIGhhcyAwDQo+IHJlZmVyZW5jZSBjb3VudCB3aGljaCBpcyB0aGUg
Y2FzZSBoZXJlKS4gVGhhdCB3b3VsZCBiZSB1dHRlcmx5IGJyb2tlbg0KPiBiZWNhdXNlIHdlIHdv
dWxkIGhhdmUgbm8gd2F5IHRvIHRlbGwgdGhlIHBhZ2UgaXMgaHdwb2lzb25lZC4NCj4gDQo+IEFu
eXdheSwgZG8geW91IHRoaW5rIHRoZSBwYXRjaCBhcyBJJ3ZlIHBvc3RlZCBtYWtlcyBzZW5zZSBy
ZWdhcmRsZXNzDQo+IGFub3RoZXIgcG90ZW50aWFsIHByb2JsZW0/IE9yIHdvdWxkIHlvdSBsaWtl
IHRvIHJlc2VuZCB5b3VycyB3aGljaCBza2lwcw0KPiBvdmVyIHRhaWwgcGFnZXMgYXQgb25jZT8N
Cg0KSSB0aGluayB0aGUgcGF0Y2ggZG9lcyBubyBoYXJtIGJ1dCB3ZSBtYXkgcHV0IHRoaXMgcGVu
ZGluZyB1bnRpbCB3ZQ0KdW5kZXJzdGFuZCB0aGUgbWVjaGFuaXNtIG9mIHRoZSBidWcuIEknbGwg
ZGlnIHRoaXMgbW9yZSBuZXh0IHdlZWsuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ==

