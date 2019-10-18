Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEC9CA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C6021D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504291AbfJRGTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:19:53 -0400
Received: from tyo185.gate.nec.co.jp ([114.179.232.185]:51073 "EHLO
        tyo185.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504151AbfJRGTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:19:53 -0400
X-Greylist: delayed 854 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Oct 2019 02:19:52 EDT
Received: from tyo161.gate.nec.co.jp (tyo161.gate.nec.co.jp [114.179.232.161])
        by tyo185.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9I2KetU024767
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:20:40 +0900
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9I2KN3O018239
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Oct 2019 11:20:23 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9I2KNEF011422;
        Fri, 18 Oct 2019 11:20:23 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9I2HWGm017083;
        Fri, 18 Oct 2019 11:20:23 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-9619683; Fri, 18 Oct 2019 11:19:08 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0439.000; Fri,
 18 Oct 2019 11:19:07 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: memory offline infinite loop after soft offline
Thread-Topic: memory offline infinite loop after soft offline
Thread-Index: AQHVgHtyUduz67i7AUWqxWZ+Pu+7vadZPeAAgATGWACAAAeGAIAAh9KAgAAFzYCAAIOhAA==
Date:   Fri, 18 Oct 2019 02:19:06 +0000
Message-ID: <20191018021906.GA24978@hori.linux.bs1.fc.nec.co.jp>
References: <1570829564.5937.36.camel@lca.pw>
 <20191014083914.GA317@dhcp22.suse.cz>
 <20191017093410.GA19973@hori.linux.bs1.fc.nec.co.jp>
 <20191017100106.GF24485@dhcp22.suse.cz> <1571335633.5937.69.camel@lca.pw>
 <20191017182759.GN24485@dhcp22.suse.cz>
In-Reply-To: <20191017182759.GN24485@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC510FC488A40B42B7307CB672E6C538@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBPY3QgMTcsIDIwMTkgYXQgMDg6Mjc6NTlQTSArMDIwMCwgTWljaGFsIEhvY2tvIHdy
b3RlOg0KPiBPbiBUaHUgMTctMTAtMTkgMTQ6MDc6MTMsIFFpYW4gQ2FpIHdyb3RlOg0KPiA+IE9u
IFRodSwgMjAxOS0xMC0xNyBhdCAxMjowMSArMDIwMCwgTWljaGFsIEhvY2tvIHdyb3RlOg0KPiA+
ID4gT24gVGh1IDE3LTEwLTE5IDA5OjM0OjEwLCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4g
PiA+IE9uIE1vbiwgT2N0IDE0LCAyMDE5IGF0IDEwOjM5OjE0QU0gKzAyMDAsIE1pY2hhbCBIb2Nr
byB3cm90ZToNCj4gPiA+IA0KPiA+ID4gWy4uLl0NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbW0v
cGFnZV9pc29sYXRpb24uYyBiL21tL3BhZ2VfaXNvbGF0aW9uLmMNCj4gPiA+ID4gPiBpbmRleCA4
OWMxOWMwZmVhZGIuLjVmYjNmZWUxNmZkZSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9tbS9wYWdl
X2lzb2xhdGlvbi5jDQo+ID4gPiA+ID4gKysrIGIvbW0vcGFnZV9pc29sYXRpb24uYw0KPiA+ID4g
PiA+IEBAIC0yNzQsNyArMjc0LDcgQEAgX190ZXN0X3BhZ2VfaXNvbGF0ZWRfaW5fcGFnZWJsb2Nr
KHVuc2lnbmVkIGxvbmcgcGZuLCB1bnNpZ25lZCBsb25nIGVuZF9wZm4sDQo+ID4gPiA+ID4gIAkJ
CSAqIHNpbXBsZSB3YXkgdG8gdmVyaWZ5IHRoYXQgYXMgVk1fQlVHX09OKCksIHRob3VnaC4NCj4g
PiA+ID4gPiAgCQkJICovDQo+ID4gPiA+ID4gIAkJCXBmbiArPSAxIDw8IHBhZ2Vfb3JkZXIocGFn
ZSk7DQo+ID4gPiA+ID4gLQkJZWxzZSBpZiAoc2tpcF9od3BvaXNvbmVkX3BhZ2VzICYmIFBhZ2VI
V1BvaXNvbihwYWdlKSkNCj4gPiA+ID4gPiArCQllbHNlIGlmIChza2lwX2h3cG9pc29uZWRfcGFn
ZXMgJiYgUGFnZUhXUG9pc29uKGNvbXBvdW5kX2hlYWQocGFnZSkpKQ0KPiA+ID4gPiA+ICAJCQkv
KiBBIEhXUG9pc29uZWQgcGFnZSBjYW5ub3QgYmUgYWxzbyBQYWdlQnVkZHkgKi8NCj4gPiA+ID4g
PiAgCQkJcGZuKys7DQo+ID4gPiA+ID4gIAkJZWxzZQ0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBm
aXggbG9va3MgZ29vZCB0byBtZS4gVGhlIG9yaWdpbmFsIGNvZGUgb25seSBhZGRyZXNzZXMgaHdw
b2lzb25lZCA0a0ItcGFnZSwNCj4gPiA+ID4gd2Ugc2VlbSB0byBoYXZlIHRoaXMgaXNzdWUgc2lu
Y2UgdGhlIGZvbGxvd2luZyBjb21taXQsDQo+ID4gPiANCj4gPiA+IFRoYW5rcyBhIGxvdCBmb3Ig
ZG91YmxlIGNoZWNraW5nIE5hb3lhIQ0KPiA+ID4gIA0KPiA+ID4gPiAgIGNvbW1pdCBiMDIzZjQ2
ODEzY2RlNmUzYjhhOGMyNGY0MzJmZjljMWZkOGU5YTY0DQo+ID4gPiA+ICAgQXV0aG9yOiBXZW4g
Q29uZ3lhbmcgPHdlbmN5QGNuLmZ1aml0c3UuY29tPg0KPiA+ID4gPiAgIERhdGU6ICAgVHVlIERl
YyAxMSAxNjowMDo0NSAyMDEyIC0wODAwDQo+ID4gPiA+ICAgDQo+ID4gPiA+ICAgICAgIG1lbW9y
eS1ob3RwbHVnOiBza2lwIEhXUG9pc29uZWQgcGFnZSB3aGVuIG9mZmxpbmluZyBwYWdlcw0KPiA+
ID4gPiANCj4gPiA+ID4gYW5kIGV4dGVuc2lvbiBvZiBMVFAgY292ZXJhZ2UgZmluYWxseSBkaXNj
b3ZlcmVkIHRoaXMuDQo+ID4gPiANCj4gPiA+IFFpYW4sIGNvdWxkIHlvdSBnaXZlIHRoZSBwYXRj
aCBzb21lIHRlc3Rpbmc/DQo+ID4gDQo+ID4gVW5mb3J0dW5hdGVseSwgdGhpcyBkb2VzIG5vdCBz
b2x2ZSB0aGUgcHJvYmxlbS7CoEl0IGxvb2tzIHRvIG1lIHRoYXQgaW4NCj4gPiBzb2Z0X29mZmxp
bmVfaHVnZV9wYWdlKCksIHNldF9od3BvaXNvbl9mcmVlX2J1ZGR5X3BhZ2UoKSB3aWxsIG9ubHkg
c2V0DQo+ID4gUEdfaHdwb2lzb24gZm9yIGJ1ZGR5IHBhZ2VzLCBzbyB0aGUgZXZlbiB0aGUgY29t
cG91bmRfaGVhZCgpIGhhcyBubyBQR19od3BvaXNvbg0KPiA+IHNldC4NCj4gPiANCj4gPiAJCWlm
IChQYWdlQnVkZHkocGFnZV9oZWFkKSAmJiBwYWdlX29yZGVyKHBhZ2VfaGVhZCkgPj0gb3JkZXIp
IHsNCj4gPiAJCQlpZiAoIVRlc3RTZXRQYWdlSFdQb2lzb24ocGFnZSkpDQo+ID4gCQkJCWh3cG9p
c29uZWQgPSB0cnVlOw0KPiANCj4gVGhpcyBpcyBtb3JlIHRoYW4gdW5leHBlY3RlZC4gSG93IGFy
ZSB3ZSBzdXBwb3NlZCB0byBmaW5kIG91dCB0aGF0IHRoZQ0KPiBwYWdlIGlzIHBvaXNvbmVkPyBB
bnkgaWRlYSBOYW95YT8NCg0KIyBzb3JyeSBmb3IgbXkgcG9vciByZXZpZXcuLi4NCg0KV2Ugc2V0
IFBHX2h3cG9pc29uIGJpdCBvbmx5IG9uIHRoZSBoZWFkIHBhZ2UgZm9yIGh1Z2V0bGIsIHRoYXQn
cyBiZWNhdXNlDQp3ZSBoYW5kbGUgbXVsdGlwbGUgcGFnZXMgYXMgYSBzaW5nbGUgb25lIGZvciBo
dWdldGxiLiBTbyBpdCdzIGVub3VnaA0KdG8gY2hlY2sgaXNvbGF0aW9uIG9ubHkgb24gdGhlIGhl
YWQgcGFnZS4gIFNpbXBseSBza2lwcGluZyBwZm4gY3Vyc29yIHRvDQp0aGUgcGFnZSBhZnRlciB0
aGUgaHVnZXBhZ2Ugc2hvdWxkIGF2b2lkIHRoZSBpbmZpbml0ZSBsb29wOg0KDQogIEBAIC0yNzQs
OSArMjc0LDEzIEBAIF9fdGVzdF9wYWdlX2lzb2xhdGVkX2luX3BhZ2VibG9jayh1bnNpZ25lZCBs
b25nIHBmbiwgdW5zaWduZWQgbG9uZyBlbmRfcGZuLA0KICAgCQkJICogc2ltcGxlIHdheSB0byB2
ZXJpZnkgdGhhdCBhcyBWTV9CVUdfT04oKSwgdGhvdWdoLg0KICAgCQkJICovDQogICAJCQlwZm4g
Kz0gMSA8PCBwYWdlX29yZGVyKHBhZ2UpOw0KICAtCQllbHNlIGlmIChza2lwX2h3cG9pc29uZWRf
cGFnZXMgJiYgUGFnZUhXUG9pc29uKHBhZ2UpKQ0KICAtCQkJLyogQSBIV1BvaXNvbmVkIHBhZ2Ug
Y2Fubm90IGJlIGFsc28gUGFnZUJ1ZGR5ICovDQogIC0JCQlwZm4rKzsNCiAgKwkJZWxzZSBpZiAo
c2tpcF9od3BvaXNvbmVkX3BhZ2VzICYmIFBhZ2VIV1BvaXNvbihjb21wb3VuZF9oZWFkKHBhZ2Up
KSkNCiAgKwkJCS8qDQogICsJCQkgKiBBIEhXUG9pc29uZWQgcGFnZSBjYW5ub3QgYmUgYWxzbyBQ
YWdlQnVkZHkuDQogICsJCQkgKiBQR19od3BvaXNvbiBjb3VsZCBiZSBzZXQgb25seSBvbiB0aGUg
aGVhZCBwYWdlIGluDQogICsJCQkgKiBodWdldGxiIGNhc2UsIHNvIG5vIG5lZWQgdG8gY2hlY2sg
dGFpbCBwYWdlcy4NCiAgKwkJCSAqLw0KICArCQkJcGZuICs9IDEgPDwgY29tcG91bmRfb3JkZXIo
cGFnZSk7DQogICAJCWVsc2UNCiAgIAkJCWJyZWFrOw0KICAgCX0NCg0KUWlhbiwgY291bGQgeW91
IHBsZWFzZSB0cnkgdGhpcz8NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp

