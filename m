Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E89C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2227214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X3BPNePR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKKK2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:28:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:50370 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726810AbfKKK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:28:41 -0500
X-UUID: 5a058e0fb6104c5ca2f49ce08d323b88-20191111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Uo09G+Mt+uFPoRjbYnLMUPPU/rQnCSKkFsV6CT6/YM4=;
        b=X3BPNePRXGKJ657K5HiUcPOU82BEKqVSrq7Hu6msvac7UrlfTeNedap83FY7Avn4sYInMms1z0KpPSkyQd46wIuj96LQMYlFVIJKZeJOzXq2w4NFiU38RWCXnMccoBMHcK8n+coiCVGHXjjurFzGa//0EnlnHO4I3sAatmGmUf0=;
X-UUID: 5a058e0fb6104c5ca2f49ce08d323b88-20191111
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 905569529; Mon, 11 Nov 2019 18:28:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Nov 2019 18:28:31 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Nov 2019 18:28:30 +0800
Message-ID: <1573468113.20611.61.camel@mtksdccf07>
Subject: Re: [PATCH v3 1/2] kasan: detect negative size in memory operation
 function
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Mon, 11 Nov 2019 18:28:33 +0800
In-Reply-To: <CACT4Y+bxWCF0WCkVxi+Qq3pztAXf2g-eBG5oexmQsQ65xrmiRw@mail.gmail.com>
References: <20191104020519.27988-1-walter-zh.wu@mediatek.com>
         <34bf9c08-d2f2-a6c6-1dbe-29b1456d8284@virtuozzo.com>
         <1573456464.20611.45.camel@mtksdccf07>
         <757f0296-7fa0-0e5e-8490-3eca52da41ad@virtuozzo.com>
         <1573467150.20611.57.camel@mtksdccf07>
         <CACT4Y+bxWCF0WCkVxi+Qq3pztAXf2g-eBG5oexmQsQ65xrmiRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTExLTExIGF0IDExOjE3ICswMTAwLCBEbWl0cnkgVnl1a292IHdyb3RlOg0K
PiBPbiBNb24sIE5vdiAxMSwgMjAxOSBhdCAxMToxMiBBTSBXYWx0ZXIgV3UgPHdhbHRlci16aC53
dUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4gT24gMTEvMTEvMTkgMTA6MTQgQU0sIFdhbHRl
ciBXdSB3cm90ZToNCj4gPiA+ID4gT24gU2F0LCAyMDE5LTExLTA5IGF0IDAxOjMxICswMzAwLCBB
bmRyZXkgUnlhYmluaW4gd3JvdGU6DQo+ID4gPiA+Pg0KPiA+ID4gPj4gT24gMTEvNC8xOSA1OjA1
IEFNLCBXYWx0ZXIgV3Ugd3JvdGU6DQo+ID4gPiA+Pg0KPiA+ID4gPj4+DQo+ID4gPiA+Pj4gZGlm
ZiAtLWdpdCBhL21tL2thc2FuL2NvbW1vbi5jIGIvbW0va2FzYW4vY29tbW9uLmMNCj4gPiA+ID4+
PiBpbmRleCA2ODE0ZDZkNmEwMjMuLjRmZjY3ZTJmZDJkYiAxMDA2NDQNCj4gPiA+ID4+PiAtLS0g
YS9tbS9rYXNhbi9jb21tb24uYw0KPiA+ID4gPj4+ICsrKyBiL21tL2thc2FuL2NvbW1vbi5jDQo+
ID4gPiA+Pj4gQEAgLTk5LDEwICs5OSwxNCBAQCBib29sIF9fa2FzYW5fY2hlY2tfd3JpdGUoY29u
c3Qgdm9sYXRpbGUgdm9pZCAqcCwgdW5zaWduZWQgaW50IHNpemUpDQo+ID4gPiA+Pj4gIH0NCj4g
PiA+ID4+PiAgRVhQT1JUX1NZTUJPTChfX2thc2FuX2NoZWNrX3dyaXRlKTsNCj4gPiA+ID4+Pg0K
PiA+ID4gPj4+ICtleHRlcm4gYm9vbCByZXBvcnRfZW5hYmxlZCh2b2lkKTsNCj4gPiA+ID4+PiAr
DQo+ID4gPiA+Pj4gICN1bmRlZiBtZW1zZXQNCj4gPiA+ID4+PiAgdm9pZCAqbWVtc2V0KHZvaWQg
KmFkZHIsIGludCBjLCBzaXplX3QgbGVuKQ0KPiA+ID4gPj4+ICB7DQo+ID4gPiA+Pj4gLSBjaGVj
a19tZW1vcnlfcmVnaW9uKCh1bnNpZ25lZCBsb25nKWFkZHIsIGxlbiwgdHJ1ZSwgX1JFVF9JUF8p
Ow0KPiA+ID4gPj4+ICsgaWYgKHJlcG9ydF9lbmFibGVkKCkgJiYNCj4gPiA+ID4+PiArICAgICAh
Y2hlY2tfbWVtb3J5X3JlZ2lvbigodW5zaWduZWQgbG9uZylhZGRyLCBsZW4sIHRydWUsIF9SRVRf
SVBfKSkNCj4gPiA+ID4+PiArICAgICAgICAgcmV0dXJuIE5VTEw7DQo+ID4gPiA+Pj4NCj4gPiA+
ID4+PiAgIHJldHVybiBfX21lbXNldChhZGRyLCBjLCBsZW4pOw0KPiA+ID4gPj4+ICB9DQo+ID4g
PiA+Pj4gQEAgLTExMCw4ICsxMTQsMTAgQEAgdm9pZCAqbWVtc2V0KHZvaWQgKmFkZHIsIGludCBj
LCBzaXplX3QgbGVuKQ0KPiA+ID4gPj4+ICAjdW5kZWYgbWVtbW92ZQ0KPiA+ID4gPj4+ICB2b2lk
ICptZW1tb3ZlKHZvaWQgKmRlc3QsIGNvbnN0IHZvaWQgKnNyYywgc2l6ZV90IGxlbikNCj4gPiA+
ID4+PiAgew0KPiA+ID4gPj4+IC0gY2hlY2tfbWVtb3J5X3JlZ2lvbigodW5zaWduZWQgbG9uZylz
cmMsIGxlbiwgZmFsc2UsIF9SRVRfSVBfKTsNCj4gPiA+ID4+PiAtIGNoZWNrX21lbW9yeV9yZWdp
b24oKHVuc2lnbmVkIGxvbmcpZGVzdCwgbGVuLCB0cnVlLCBfUkVUX0lQXyk7DQo+ID4gPiA+Pj4g
KyBpZiAocmVwb3J0X2VuYWJsZWQoKSAmJg0KPiA+ID4gPj4+ICsgICAgKCFjaGVja19tZW1vcnlf
cmVnaW9uKCh1bnNpZ25lZCBsb25nKXNyYywgbGVuLCBmYWxzZSwgX1JFVF9JUF8pIHx8DQo+ID4g
PiA+Pj4gKyAgICAgIWNoZWNrX21lbW9yeV9yZWdpb24oKHVuc2lnbmVkIGxvbmcpZGVzdCwgbGVu
LCB0cnVlLCBfUkVUX0lQXykpKQ0KPiA+ID4gPj4+ICsgICAgICAgICByZXR1cm4gTlVMTDsNCj4g
PiA+ID4+Pg0KPiA+ID4gPj4+ICAgcmV0dXJuIF9fbWVtbW92ZShkZXN0LCBzcmMsIGxlbik7DQo+
ID4gPiA+Pj4gIH0NCj4gPiA+ID4+PiBAQCAtMTE5LDggKzEyNSwxMCBAQCB2b2lkICptZW1tb3Zl
KHZvaWQgKmRlc3QsIGNvbnN0IHZvaWQgKnNyYywgc2l6ZV90IGxlbikNCj4gPiA+ID4+PiAgI3Vu
ZGVmIG1lbWNweQ0KPiA+ID4gPj4+ICB2b2lkICptZW1jcHkodm9pZCAqZGVzdCwgY29uc3Qgdm9p
ZCAqc3JjLCBzaXplX3QgbGVuKQ0KPiA+ID4gPj4+ICB7DQo+ID4gPiA+Pj4gLSBjaGVja19tZW1v
cnlfcmVnaW9uKCh1bnNpZ25lZCBsb25nKXNyYywgbGVuLCBmYWxzZSwgX1JFVF9JUF8pOw0KPiA+
ID4gPj4+IC0gY2hlY2tfbWVtb3J5X3JlZ2lvbigodW5zaWduZWQgbG9uZylkZXN0LCBsZW4sIHRy
dWUsIF9SRVRfSVBfKTsNCj4gPiA+ID4+PiArIGlmIChyZXBvcnRfZW5hYmxlZCgpICYmDQo+ID4g
PiA+Pg0KPiA+ID4gPj4gICAgICAgICAgICAgcmVwb3J0X2VuYWJsZWQoKSBjaGVja3Mgc2VlbXMg
dG8gYmUgdXNlbGVzcy4NCj4gPiA+ID4+DQo+ID4gPiA+DQo+ID4gPiA+IEhpIEFuZHJleSwNCj4g
PiA+ID4NCj4gPiA+ID4gSWYgaXQgZG9lc24ndCBoYXZlIHJlcG9ydF9lbmFibGUoKSwgdGhlbiBp
dCB3aWxsIGhhdmUgYmVsb3cgdGhlIGVycm9yLg0KPiA+ID4gPiBXZSB0aGluayBpdCBzaG91bGQg
YmUgeDg2IHNoYWRvdyBtZW1vcnkgaXMgaW52YWxpZCB2YWx1ZSBiZWZvcmUgS0FTQU4NCj4gPiA+
ID4gaW5pdGlhbGl6ZWQsIGl0IHdpbGwgaGF2ZSBzb21lIG1pc2p1ZGdtZW50cyB0byBkbyBkaXJl
Y3RseSByZXR1cm4gd2hlbg0KPiA+ID4gPiBpdCBkZXRlY3RzIGludmFsaWQgc2hhZG93IHZhbHVl
IGluIG1lbXNldCgpL21lbWNweSgpL21lbW1vdmUoKS4gU28gd2UNCj4gPiA+ID4gYWRkIHJlcG9y
dF9lbmFibGUoKSB0byBhdm9pZCB0aGlzIGhhcHBlbmluZy4gYnV0IHdlIHNob3VsZCBvbmx5IHVz
ZSB0aGUNCj4gPiA+ID4gY29uZGl0aW9uICJjdXJyZW50LT5rYXNhbl9kZXB0aCA9PSAwIiB0byBk
ZXRlcm1pbmUgaWYgS0FTQU4gaXMNCj4gPiA+ID4gaW5pdGlhbGl6ZWQuIEFuZCB3ZSB0cnkgaXQg
aXMgcGFzcyBhdCB4ODYuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gT2ssIEkgc2VlLiBJdCBqdXN0
IG1lYW5zIHRoYXQgY2hlY2tfbWVtb3J5X3JlZ2lvbigpIHJldHVybiBpbmNvcnJlY3QgcmVzdWx0
IGluIGVhcmx5IHN0YWdlcyBvZiBib290Lg0KPiA+ID4gU28sIHRoZSByaWdodCB3YXkgdG8gZGVh
bCB3aXRoIHRoaXMgd291bGQgYmUgbWFraW5nIGthc2FuX3JlcG9ydCgpIHRvIHJldHVybiBib29s
ICgiZmFsc2UiIGlmIG5vIHJlcG9ydCBhbmQgInRydWUiIGlmIHJlcG9ydGVkKQ0KPiA+ID4gYW5k
IHByb3BhZ2F0ZSB0aGlzIHJldHVybiB2YWx1ZSB1cCB0byBjaGVja19tZW1vcnlfcmVnaW9uKCku
DQo+ID4gPg0KPiA+IFRoaXMgY2hhbmdlcyBpbiB2NC4NCj4gPg0KPiA+ID4NCj4gPiA+ID4+PiBk
aWZmIC0tZ2l0IGEvbW0va2FzYW4vZ2VuZXJpY19yZXBvcnQuYyBiL21tL2thc2FuL2dlbmVyaWNf
cmVwb3J0LmMNCj4gPiA+ID4+PiBpbmRleCAzNmM2NDU5MzliYzkuLjUyYTkyYzdkYjY5NyAxMDA2
NDQNCj4gPiA+ID4+PiAtLS0gYS9tbS9rYXNhbi9nZW5lcmljX3JlcG9ydC5jDQo+ID4gPiA+Pj4g
KysrIGIvbW0va2FzYW4vZ2VuZXJpY19yZXBvcnQuYw0KPiA+ID4gPj4+IEBAIC0xMDcsNiArMTA3
LDI0IEBAIHN0YXRpYyBjb25zdCBjaGFyICpnZXRfd2lsZF9idWdfdHlwZShzdHJ1Y3Qga2FzYW5f
YWNjZXNzX2luZm8gKmluZm8pDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiAgY29uc3QgY2hhciAqZ2V0
X2J1Z190eXBlKHN0cnVjdCBrYXNhbl9hY2Nlc3NfaW5mbyAqaW5mbykNCj4gPiA+ID4+PiAgew0K
PiA+ID4gPj4+ICsgLyoNCj4gPiA+ID4+PiArICAqIElmIGFjY2Vzc19zaXplIGlzIG5lZ2F0aXZl
IG51bWJlcnMsIHRoZW4gaXQgaGFzIHRocmVlIHJlYXNvbnMNCj4gPiA+ID4+PiArICAqIHRvIGJl
IGRlZmluZWQgYXMgaGVhcC1vdXQtb2YtYm91bmRzIGJ1ZyB0eXBlLg0KPiA+ID4gPj4+ICsgICog
MSkgQ2FzdGluZyBuZWdhdGl2ZSBudW1iZXJzIHRvIHNpemVfdCB3b3VsZCBpbmRlZWQgdHVybiB1
cCBhcw0KPiA+ID4gPj4+ICsgICogICAgYSBsYXJnZSBzaXplX3QgYW5kIGl0cyB2YWx1ZSB3aWxs
IGJlIGxhcmdlciB0aGFuIFVMT05HX01BWC8yLA0KPiA+ID4gPj4+ICsgICogICAgc28gdGhhdCB0
aGlzIGNhbiBxdWFsaWZ5IGFzIG91dC1vZi1ib3VuZHMuDQo+ID4gPiA+Pj4gKyAgKiAyKSBJZiBL
QVNBTiBoYXMgbmV3IGJ1ZyB0eXBlIGFuZCB1c2VyLXNwYWNlIHBhc3NlcyBuZWdhdGl2ZSBzaXpl
LA0KPiA+ID4gPj4+ICsgICogICAgdGhlbiB0aGVyZSBhcmUgZHVwbGljYXRlIHJlcG9ydHMuIFNv
IGRvbid0IHByb2R1Y2UgbmV3IGJ1ZyB0eXBlDQo+ID4gPiA+Pj4gKyAgKiAgICBpbiBvcmRlciB0
byBwcmV2ZW50IGR1cGxpY2F0ZSByZXBvcnRzIGJ5IHNvbWUgc3lzdGVtcw0KPiA+ID4gPj4+ICsg
ICogICAgKGUuZy4gc3l6Ym90KSB0byByZXBvcnQgdGhlIHNhbWUgYnVnIHR3aWNlLg0KPiA+ID4g
Pj4+ICsgICogMykgV2hlbiBzaXplIGlzIG5lZ2F0aXZlIG51bWJlcnMsIGl0IG1heSBiZSBwYXNz
ZWQgZnJvbSB1c2VyLXNwYWNlLg0KPiA+ID4gPj4+ICsgICogICAgU28gd2UgYWx3YXlzIHByaW50
IGhlYXAtb3V0LW9mLWJvdW5kcyBpbiBvcmRlciB0byBwcmV2ZW50IHRoYXQNCj4gPiA+ID4+PiAr
ICAqICAgIGtlcm5lbC1zcGFjZSBhbmQgdXNlci1zcGFjZSBoYXZlIHRoZSBzYW1lIGJ1ZyBidXQg
aGF2ZSBkdXBsaWNhdGUNCj4gPiA+ID4+PiArICAqICAgIHJlcG9ydHMuDQo+ID4gPiA+Pj4gKyAg
Ki8NCj4gPiA+ID4+DQo+ID4gPiA+PiBDb21wbGV0ZWx5IGZhaWwgdG8gdW5kZXJzdGFuZCAyKSBh
bmQgMykuIDIpIHRhbGtzIHNvbWV0aGluZyBhYm91dCAqTk9UKiBwcm9kdWNpbmcgbmV3IGJ1Zw0K
PiA+ID4gPj4gdHlwZSwgYnV0IGF0IHRoZSBzYW1lIHRpbWUgeW91IGNvZGUgYWN0dWFsbHkgZG9l
cyB0aGF0Lg0KPiA+ID4gPj4gMykgc2F5cyBzb21ldGhpbmcgYWJvdXQgdXNlci1zcGFjZSB3aGlj
aCBoYXZlIG5vdGhpbmcgdG8gZG8gd2l0aCBrYXNhbi4NCj4gPiA+ID4+DQo+ID4gPiA+IGFib3V0
IDIpDQo+ID4gPiA+IFdlIG9yaWdpbmFsbHkgdGhpbmsgdGhlIGhlYXAtb3V0LW9mLWJvdW5kcyBp
cyBzaW1pbGFyIHRvDQo+ID4gPiA+IGhlYXAtYnVmZmVyLW92ZXJmbG93LCBtYXliZSB3ZSBzaG91
bGQgY2hhbmdlIHRoZSBidWcgdHlwZSB0bw0KPiA+ID4gPiBoZWFwLWJ1ZmZlci1vdmVyZmxvdy4N
Cj4gPiA+DQo+ID4gPiBUaGVyZSBpcyBubyAiaGVhcC1idWZmZXItb3ZlcmZsb3ciLg0KPiA+ID4N
Cj4gPiBJZiBJIHJlbWVtYmVyIGNvcnJlY3RseSwgImhlYXAtYnVmZmVyLW92ZXJmbG93IiBpcyBv
bmUgb2YgZXhpc3RpbmcgYnVnDQo+ID4gdHlwZSBpbiB1c2VyLXNwYWNlPyBPciB5b3Ugd2FudCB0
byBleHBlY3QgdG8gc2VlIGFuIGV4aXN0aW5nIGJ1ZyB0eXBlIGluDQo+ID4ga2VybmVsIHNwYWNl
Pw0KPiANCj4gRXhpc3RpbmcgYnVnIGluIEtBU0FOLg0KPiBLQVNBTiBhbmQgQVNBTiBidWdzIHdp
bGwgbmV2ZXIgbWF0Y2ggcmVnYXJkbGVzcyBvZiB3aGF0IHdlIGRvLiBUaGV5DQo+IGFyZSBzaW1w
bHkgaW4gY29tcGxldGVseSBkaWZmZXJlbnQgY29kZS4gU28gYWxpZ25pbmcgdGl0bGVzIGJldHdl
ZW4NCj4ga2VybmVsIGFuZCB1c2Vyc3BhY2Ugd2lsbCBub3QgbGVhZCB0byBhbnkgYmV0dGVyIGRl
ZHVwbGljYXRpb24uDQoNCk9rLCBpdCBzZWVtcyBsaWtlIHRvIHByaW50ICJvdXQtb2YtYm91bmRz
Ii4gU2ltcGxlIGFuZCBlYXN5IHRvIGtub3cgaXQuDQpUaGFua3MgRG1pdHJ5Lg0K

