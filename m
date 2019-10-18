Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F50CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F328D20820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504433AbfJRGfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:35:32 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:40131 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392014AbfJRGfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:35:32 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9I6ZEPZ029434
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Oct 2019 15:35:14 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9I6ZEgU019791;
        Fri, 18 Oct 2019 15:35:14 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9I6ZBJ6019699;
        Fri, 18 Oct 2019 15:35:14 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-9647360; Fri, 18 Oct 2019 15:32:24 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0439.000; Fri,
 18 Oct 2019 15:32:23 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Qian Cai <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: memory offline infinite loop after soft offline
Thread-Topic: memory offline infinite loop after soft offline
Thread-Index: AQHVgHtyUduz67i7AUWqxWZ+Pu+7vadZPeAAgATGWACAAAeGAIAAh9KAgAAFzYCAAIOhAIAAP4+AgAAHNAA=
Date:   Fri, 18 Oct 2019 06:32:22 +0000
Message-ID: <20191018063222.GA15406@hori.linux.bs1.fc.nec.co.jp>
References: <1570829564.5937.36.camel@lca.pw>
 <20191014083914.GA317@dhcp22.suse.cz>
 <20191017093410.GA19973@hori.linux.bs1.fc.nec.co.jp>
 <20191017100106.GF24485@dhcp22.suse.cz> <1571335633.5937.69.camel@lca.pw>
 <20191017182759.GN24485@dhcp22.suse.cz>
 <20191018021906.GA24978@hori.linux.bs1.fc.nec.co.jp>
 <20191018060635.GA5017@dhcp22.suse.cz>
In-Reply-To: <20191018060635.GA5017@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF03EEFA4DDD594CB5E16E760A1E42A9@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBPY3QgMTgsIDIwMTkgYXQgMDg6MDY6MzVBTSArMDIwMCwgTWljaGFsIEhvY2tvIHdy
b3RlOg0KPiBPbiBGcmkgMTgtMTAtMTkgMDI6MTk6MDYsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToN
Cj4gPiBPbiBUaHUsIE9jdCAxNywgMjAxOSBhdCAwODoyNzo1OVBNICswMjAwLCBNaWNoYWwgSG9j
a28gd3JvdGU6DQo+ID4gPiBPbiBUaHUgMTctMTAtMTkgMTQ6MDc6MTMsIFFpYW4gQ2FpIHdyb3Rl
Og0KPiA+ID4gPiBPbiBUaHUsIDIwMTktMTAtMTcgYXQgMTI6MDEgKzAyMDAsIE1pY2hhbCBIb2Nr
byB3cm90ZToNCj4gPiA+ID4gPiBPbiBUaHUgMTctMTAtMTkgMDk6MzQ6MTAsIE5hb3lhIEhvcmln
dWNoaSB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIE1vbiwgT2N0IDE0LCAyMDE5IGF0IDEwOjM5OjE0
QU0gKzAyMDAsIE1pY2hhbCBIb2NrbyB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBbLi4u
XQ0KPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbW0vcGFnZV9pc29sYXRpb24uYyBiL21tL3Bh
Z2VfaXNvbGF0aW9uLmMNCj4gPiA+ID4gPiA+ID4gaW5kZXggODljMTljMGZlYWRiLi41ZmIzZmVl
MTZmZGUgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+IC0tLSBhL21tL3BhZ2VfaXNvbGF0aW9uLmMNCj4g
PiA+ID4gPiA+ID4gKysrIGIvbW0vcGFnZV9pc29sYXRpb24uYw0KPiA+ID4gPiA+ID4gPiBAQCAt
Mjc0LDcgKzI3NCw3IEBAIF9fdGVzdF9wYWdlX2lzb2xhdGVkX2luX3BhZ2VibG9jayh1bnNpZ25l
ZCBsb25nIHBmbiwgdW5zaWduZWQgbG9uZyBlbmRfcGZuLA0KPiA+ID4gPiA+ID4gPiAgCQkJICog
c2ltcGxlIHdheSB0byB2ZXJpZnkgdGhhdCBhcyBWTV9CVUdfT04oKSwgdGhvdWdoLg0KPiA+ID4g
PiA+ID4gPiAgCQkJICovDQo+ID4gPiA+ID4gPiA+ICAJCQlwZm4gKz0gMSA8PCBwYWdlX29yZGVy
KHBhZ2UpOw0KPiA+ID4gPiA+ID4gPiAtCQllbHNlIGlmIChza2lwX2h3cG9pc29uZWRfcGFnZXMg
JiYgUGFnZUhXUG9pc29uKHBhZ2UpKQ0KPiA+ID4gPiA+ID4gPiArCQllbHNlIGlmIChza2lwX2h3
cG9pc29uZWRfcGFnZXMgJiYgUGFnZUhXUG9pc29uKGNvbXBvdW5kX2hlYWQocGFnZSkpKQ0KPiA+
ID4gPiA+ID4gPiAgCQkJLyogQSBIV1BvaXNvbmVkIHBhZ2UgY2Fubm90IGJlIGFsc28gUGFnZUJ1
ZGR5ICovDQo+ID4gPiA+ID4gPiA+ICAJCQlwZm4rKzsNCj4gPiA+ID4gPiA+ID4gIAkJZWxzZQ0K
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGlzIGZpeCBsb29rcyBnb29kIHRvIG1lLiBUaGUg
b3JpZ2luYWwgY29kZSBvbmx5IGFkZHJlc3NlcyBod3BvaXNvbmVkIDRrQi1wYWdlLA0KPiA+ID4g
PiA+ID4gd2Ugc2VlbSB0byBoYXZlIHRoaXMgaXNzdWUgc2luY2UgdGhlIGZvbGxvd2luZyBjb21t
aXQsDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhhbmtzIGEgbG90IGZvciBkb3VibGUgY2hlY2tp
bmcgTmFveWEhDQo+ID4gPiA+ID4gIA0KPiA+ID4gPiA+ID4gICBjb21taXQgYjAyM2Y0NjgxM2Nk
ZTZlM2I4YThjMjRmNDMyZmY5YzFmZDhlOWE2NA0KPiA+ID4gPiA+ID4gICBBdXRob3I6IFdlbiBD
b25neWFuZyA8d2VuY3lAY24uZnVqaXRzdS5jb20+DQo+ID4gPiA+ID4gPiAgIERhdGU6ICAgVHVl
IERlYyAxMSAxNjowMDo0NSAyMDEyIC0wODAwDQo+ID4gPiA+ID4gPiAgIA0KPiA+ID4gPiA+ID4g
ICAgICAgbWVtb3J5LWhvdHBsdWc6IHNraXAgSFdQb2lzb25lZCBwYWdlIHdoZW4gb2ZmbGluaW5n
IHBhZ2VzDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGFuZCBleHRlbnNpb24gb2YgTFRQIGNv
dmVyYWdlIGZpbmFsbHkgZGlzY292ZXJlZCB0aGlzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFFp
YW4sIGNvdWxkIHlvdSBnaXZlIHRoZSBwYXRjaCBzb21lIHRlc3Rpbmc/DQo+ID4gPiA+IA0KPiA+
ID4gPiBVbmZvcnR1bmF0ZWx5LCB0aGlzIGRvZXMgbm90IHNvbHZlIHRoZSBwcm9ibGVtLsKgSXQg
bG9va3MgdG8gbWUgdGhhdCBpbg0KPiA+ID4gPiBzb2Z0X29mZmxpbmVfaHVnZV9wYWdlKCksIHNl
dF9od3BvaXNvbl9mcmVlX2J1ZGR5X3BhZ2UoKSB3aWxsIG9ubHkgc2V0DQo+ID4gPiA+IFBHX2h3
cG9pc29uIGZvciBidWRkeSBwYWdlcywgc28gdGhlIGV2ZW4gdGhlIGNvbXBvdW5kX2hlYWQoKSBo
YXMgbm8gUEdfaHdwb2lzb24NCj4gPiA+ID4gc2V0Lg0KPiA+ID4gPiANCj4gPiA+ID4gCQlpZiAo
UGFnZUJ1ZGR5KHBhZ2VfaGVhZCkgJiYgcGFnZV9vcmRlcihwYWdlX2hlYWQpID49IG9yZGVyKSB7
DQo+ID4gPiA+IAkJCWlmICghVGVzdFNldFBhZ2VIV1BvaXNvbihwYWdlKSkNCj4gPiA+ID4gCQkJ
CWh3cG9pc29uZWQgPSB0cnVlOw0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIG1vcmUgdGhhbiB1bmV4
cGVjdGVkLiBIb3cgYXJlIHdlIHN1cHBvc2VkIHRvIGZpbmQgb3V0IHRoYXQgdGhlDQo+ID4gPiBw
YWdlIGlzIHBvaXNvbmVkPyBBbnkgaWRlYSBOYW95YT8NCj4gPiANCj4gPiAjIHNvcnJ5IGZvciBt
eSBwb29yIHJldmlldy4uLg0KPiA+IA0KPiA+IFdlIHNldCBQR19od3BvaXNvbiBiaXQgb25seSBv
biB0aGUgaGVhZCBwYWdlIGZvciBodWdldGxiLCB0aGF0J3MgYmVjYXVzZQ0KPiA+IHdlIGhhbmRs
ZSBtdWx0aXBsZSBwYWdlcyBhcyBhIHNpbmdsZSBvbmUgZm9yIGh1Z2V0bGIuIFNvIGl0J3MgZW5v
dWdoDQo+ID4gdG8gY2hlY2sgaXNvbGF0aW9uIG9ubHkgb24gdGhlIGhlYWQgcGFnZS4gIFNpbXBs
eSBza2lwcGluZyBwZm4gY3Vyc29yIHRvDQo+ID4gdGhlIHBhZ2UgYWZ0ZXIgdGhlIGh1Z2VwYWdl
IHNob3VsZCBhdm9pZCB0aGUgaW5maW5pdGUgbG9vcDoNCj4gDQo+IEJ1dCB0aGUgcGFnZSBkdW1w
IFFpYW4gcHJvdmlkZWQgc2hvd3MgdGhhdCB0aGUgaGVhZCBwYWdlIGRvZXNuJ3QgaGF2ZQ0KPiBI
V1BvaXNvbiBiaXQgZWl0aGVyLiBJZiBpdCBoYWQgdGhlbiBnb2luZyBwZm4gYXQgYSB0aW1lIHNo
b3VsZCBqdXN0IHdvcmsNCj4gYmVjYXVzZSBhbGwgdGFpbCBwYWdlcyB3b3VsZCBiZSBza2lwcGVk
LiBPciBkbyBJIG1pc3Mgc29tZXRoaW5nPw0KDQpZb3UncmUgcmlnaHQsIHRoZW4gSSBkb24ndCBz
ZWUgaG93IHRoaXMgaGFwcGVucy4gSWYgdGhlIGVycm9yIGh1Z2VwYWdlIHdhcw0KaXNvbGF0ZWQg
d2l0aG91dCBoYXZpbmcgUEdfaHdwb2lzb24gc2V0LCBpdCdzIHVuZXhwZWN0ZWQgYW5kIHByb2Js
ZW1hdGljLg0KSSdtIHRlc3RpbmcgbXlzZWxmIHdpdGggdjUuNC1yYzIgKHNpbXBseSByYW4gbW92
ZV9wYWdlczEyIGFuZCBkaWQgaG90cmVtb3ZlL2hvdGFkZCkNCmJ1dCBkb24ndCByZXByb2R1Y2Ug
dGhlIGlzc3VlIHlldC4gIERvIHdlIG5lZWQgc3BlY2lmaWMga2VybmVsIHZlcnNpb24vY29uZmln
DQp0byB0cmlnZ2VyIHRoaXM/DQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQo+ICANCj4g
PiAgIEBAIC0yNzQsOSArMjc0LDEzIEBAIF9fdGVzdF9wYWdlX2lzb2xhdGVkX2luX3BhZ2VibG9j
ayh1bnNpZ25lZCBsb25nIHBmbiwgdW5zaWduZWQgbG9uZyBlbmRfcGZuLA0KPiA+ICAgIAkJCSAq
IHNpbXBsZSB3YXkgdG8gdmVyaWZ5IHRoYXQgYXMgVk1fQlVHX09OKCksIHRob3VnaC4NCj4gPiAg
ICAJCQkgKi8NCj4gPiAgICAJCQlwZm4gKz0gMSA8PCBwYWdlX29yZGVyKHBhZ2UpOw0KPiA+ICAg
LQkJZWxzZSBpZiAoc2tpcF9od3BvaXNvbmVkX3BhZ2VzICYmIFBhZ2VIV1BvaXNvbihwYWdlKSkN
Cj4gPiAgIC0JCQkvKiBBIEhXUG9pc29uZWQgcGFnZSBjYW5ub3QgYmUgYWxzbyBQYWdlQnVkZHkg
Ki8NCj4gPiAgIC0JCQlwZm4rKzsNCj4gPiAgICsJCWVsc2UgaWYgKHNraXBfaHdwb2lzb25lZF9w
YWdlcyAmJiBQYWdlSFdQb2lzb24oY29tcG91bmRfaGVhZChwYWdlKSkpDQo+ID4gICArCQkJLyoN
Cj4gPiAgICsJCQkgKiBBIEhXUG9pc29uZWQgcGFnZSBjYW5ub3QgYmUgYWxzbyBQYWdlQnVkZHku
DQo+ID4gICArCQkJICogUEdfaHdwb2lzb24gY291bGQgYmUgc2V0IG9ubHkgb24gdGhlIGhlYWQg
cGFnZSBpbg0KPiA+ICAgKwkJCSAqIGh1Z2V0bGIgY2FzZSwgc28gbm8gbmVlZCB0byBjaGVjayB0
YWlsIHBhZ2VzLg0KPiA+ICAgKwkJCSAqLw0KPiA+ICAgKwkJCXBmbiArPSAxIDw8IGNvbXBvdW5k
X29yZGVyKHBhZ2UpOw0KPiA+ICAgIAkJZWxzZQ0KPiA+ICAgIAkJCWJyZWFrOw0KPiA+ICAgIAl9
DQo+ID4gDQo+ID4gUWlhbiwgY291bGQgeW91IHBsZWFzZSB0cnkgdGhpcz8NCj4gPiANCj4gPiBU
aGFua3MsDQo+ID4gTmFveWEgSG9yaWd1Y2hpDQo+IA0KPiAtLSANCj4gTWljaGFsIEhvY2tvDQo+
IFNVU0UgTGFicw0KPiA=

