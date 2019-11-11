Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE6BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6FC206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pTHWaONq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKKKMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:12:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:7827 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726768AbfKKKMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:12:37 -0500
X-UUID: 70df4b08df754a48a14c29be91d7b985-20191111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=toF+FrGCVhoFJVjUfttIEjB8V6geaXrgJXG1BEMe0Ac=;
        b=pTHWaONq7n5hFbK5fjWsuaxJ39Pnv3+J8zLuUiVSHYEI2zHezLjueSX7J4XudA0OiMiyKoJ4Fx0kjEHpEe3HHJTZes7pXT6O1L+Yo8Il+vyy5AuP6CZvfBj9mfxWjqxwW5HBkdkJfhPxII7M9g4g8LB9SsMiRwvSd2dmqwy1nug=;
X-UUID: 70df4b08df754a48a14c29be91d7b985-20191111
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 346899562; Mon, 11 Nov 2019 18:12:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Nov 2019 18:12:28 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Nov 2019 18:12:27 +0800
Message-ID: <1573467150.20611.57.camel@mtksdccf07>
Subject: Re: [PATCH v3 1/2] kasan: detect negative size in memory operation
 function
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
CC:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Mon, 11 Nov 2019 18:12:30 +0800
In-Reply-To: <757f0296-7fa0-0e5e-8490-3eca52da41ad@virtuozzo.com>
References: <20191104020519.27988-1-walter-zh.wu@mediatek.com>
         <34bf9c08-d2f2-a6c6-1dbe-29b1456d8284@virtuozzo.com>
         <1573456464.20611.45.camel@mtksdccf07>
         <757f0296-7fa0-0e5e-8490-3eca52da41ad@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTExLTExIGF0IDEyOjI5ICswMzAwLCBBbmRyZXkgUnlhYmluaW4gd3JvdGU6
DQo+IA0KPiBPbiAxMS8xMS8xOSAxMDoxNCBBTSwgV2FsdGVyIFd1IHdyb3RlOg0KPiA+IE9uIFNh
dCwgMjAxOS0xMS0wOSBhdCAwMTozMSArMDMwMCwgQW5kcmV5IFJ5YWJpbmluIHdyb3RlOg0KPiA+
Pg0KPiA+PiBPbiAxMS80LzE5IDU6MDUgQU0sIFdhbHRlciBXdSB3cm90ZToNCj4gPj4NCj4gPj4+
DQo+ID4+PiBkaWZmIC0tZ2l0IGEvbW0va2FzYW4vY29tbW9uLmMgYi9tbS9rYXNhbi9jb21tb24u
Yw0KPiA+Pj4gaW5kZXggNjgxNGQ2ZDZhMDIzLi40ZmY2N2UyZmQyZGIgMTAwNjQ0DQo+ID4+PiAt
LS0gYS9tbS9rYXNhbi9jb21tb24uYw0KPiA+Pj4gKysrIGIvbW0va2FzYW4vY29tbW9uLmMNCj4g
Pj4+IEBAIC05OSwxMCArOTksMTQgQEAgYm9vbCBfX2thc2FuX2NoZWNrX3dyaXRlKGNvbnN0IHZv
bGF0aWxlIHZvaWQgKnAsIHVuc2lnbmVkIGludCBzaXplKQ0KPiA+Pj4gIH0NCj4gPj4+ICBFWFBP
UlRfU1lNQk9MKF9fa2FzYW5fY2hlY2tfd3JpdGUpOw0KPiA+Pj4gIA0KPiA+Pj4gK2V4dGVybiBi
b29sIHJlcG9ydF9lbmFibGVkKHZvaWQpOw0KPiA+Pj4gKw0KPiA+Pj4gICN1bmRlZiBtZW1zZXQN
Cj4gPj4+ICB2b2lkICptZW1zZXQodm9pZCAqYWRkciwgaW50IGMsIHNpemVfdCBsZW4pDQo+ID4+
PiAgew0KPiA+Pj4gLQljaGVja19tZW1vcnlfcmVnaW9uKCh1bnNpZ25lZCBsb25nKWFkZHIsIGxl
biwgdHJ1ZSwgX1JFVF9JUF8pOw0KPiA+Pj4gKwlpZiAocmVwb3J0X2VuYWJsZWQoKSAmJg0KPiA+
Pj4gKwkgICAgIWNoZWNrX21lbW9yeV9yZWdpb24oKHVuc2lnbmVkIGxvbmcpYWRkciwgbGVuLCB0
cnVlLCBfUkVUX0lQXykpDQo+ID4+PiArCQlyZXR1cm4gTlVMTDsNCj4gPj4+ICANCj4gPj4+ICAJ
cmV0dXJuIF9fbWVtc2V0KGFkZHIsIGMsIGxlbik7DQo+ID4+PiAgfQ0KPiA+Pj4gQEAgLTExMCw4
ICsxMTQsMTAgQEAgdm9pZCAqbWVtc2V0KHZvaWQgKmFkZHIsIGludCBjLCBzaXplX3QgbGVuKQ0K
PiA+Pj4gICN1bmRlZiBtZW1tb3ZlDQo+ID4+PiAgdm9pZCAqbWVtbW92ZSh2b2lkICpkZXN0LCBj
b25zdCB2b2lkICpzcmMsIHNpemVfdCBsZW4pDQo+ID4+PiAgew0KPiA+Pj4gLQljaGVja19tZW1v
cnlfcmVnaW9uKCh1bnNpZ25lZCBsb25nKXNyYywgbGVuLCBmYWxzZSwgX1JFVF9JUF8pOw0KPiA+
Pj4gLQljaGVja19tZW1vcnlfcmVnaW9uKCh1bnNpZ25lZCBsb25nKWRlc3QsIGxlbiwgdHJ1ZSwg
X1JFVF9JUF8pOw0KPiA+Pj4gKwlpZiAocmVwb3J0X2VuYWJsZWQoKSAmJg0KPiA+Pj4gKwkgICAo
IWNoZWNrX21lbW9yeV9yZWdpb24oKHVuc2lnbmVkIGxvbmcpc3JjLCBsZW4sIGZhbHNlLCBfUkVU
X0lQXykgfHwNCj4gPj4+ICsJICAgICFjaGVja19tZW1vcnlfcmVnaW9uKCh1bnNpZ25lZCBsb25n
KWRlc3QsIGxlbiwgdHJ1ZSwgX1JFVF9JUF8pKSkNCj4gPj4+ICsJCXJldHVybiBOVUxMOw0KPiA+
Pj4gIA0KPiA+Pj4gIAlyZXR1cm4gX19tZW1tb3ZlKGRlc3QsIHNyYywgbGVuKTsNCj4gPj4+ICB9
DQo+ID4+PiBAQCAtMTE5LDggKzEyNSwxMCBAQCB2b2lkICptZW1tb3ZlKHZvaWQgKmRlc3QsIGNv
bnN0IHZvaWQgKnNyYywgc2l6ZV90IGxlbikNCj4gPj4+ICAjdW5kZWYgbWVtY3B5DQo+ID4+PiAg
dm9pZCAqbWVtY3B5KHZvaWQgKmRlc3QsIGNvbnN0IHZvaWQgKnNyYywgc2l6ZV90IGxlbikNCj4g
Pj4+ICB7DQo+ID4+PiAtCWNoZWNrX21lbW9yeV9yZWdpb24oKHVuc2lnbmVkIGxvbmcpc3JjLCBs
ZW4sIGZhbHNlLCBfUkVUX0lQXyk7DQo+ID4+PiAtCWNoZWNrX21lbW9yeV9yZWdpb24oKHVuc2ln
bmVkIGxvbmcpZGVzdCwgbGVuLCB0cnVlLCBfUkVUX0lQXyk7DQo+ID4+PiArCWlmIChyZXBvcnRf
ZW5hYmxlZCgpICYmDQo+ID4+DQo+ID4+ICAgICAgICAgICAgIHJlcG9ydF9lbmFibGVkKCkgY2hl
Y2tzIHNlZW1zIHRvIGJlIHVzZWxlc3MuDQo+ID4+DQo+ID4gDQo+ID4gSGkgQW5kcmV5LA0KPiA+
IA0KPiA+IElmIGl0IGRvZXNuJ3QgaGF2ZSByZXBvcnRfZW5hYmxlKCksIHRoZW4gaXQgd2lsbCBo
YXZlIGJlbG93IHRoZSBlcnJvci4NCj4gPiBXZSB0aGluayBpdCBzaG91bGQgYmUgeDg2IHNoYWRv
dyBtZW1vcnkgaXMgaW52YWxpZCB2YWx1ZSBiZWZvcmUgS0FTQU4NCj4gPiBpbml0aWFsaXplZCwg
aXQgd2lsbCBoYXZlIHNvbWUgbWlzanVkZ21lbnRzIHRvIGRvIGRpcmVjdGx5IHJldHVybiB3aGVu
DQo+ID4gaXQgZGV0ZWN0cyBpbnZhbGlkIHNoYWRvdyB2YWx1ZSBpbiBtZW1zZXQoKS9tZW1jcHko
KS9tZW1tb3ZlKCkuIFNvIHdlDQo+ID4gYWRkIHJlcG9ydF9lbmFibGUoKSB0byBhdm9pZCB0aGlz
IGhhcHBlbmluZy4gYnV0IHdlIHNob3VsZCBvbmx5IHVzZSB0aGUNCj4gPiBjb25kaXRpb24gImN1
cnJlbnQtPmthc2FuX2RlcHRoID09IDAiIHRvIGRldGVybWluZSBpZiBLQVNBTiBpcw0KPiA+IGlu
aXRpYWxpemVkLiBBbmQgd2UgdHJ5IGl0IGlzIHBhc3MgYXQgeDg2Lg0KPiA+IA0KPiANCj4gT2ss
IEkgc2VlLiBJdCBqdXN0IG1lYW5zIHRoYXQgY2hlY2tfbWVtb3J5X3JlZ2lvbigpIHJldHVybiBp
bmNvcnJlY3QgcmVzdWx0IGluIGVhcmx5IHN0YWdlcyBvZiBib290Lg0KPiBTbywgdGhlIHJpZ2h0
IHdheSB0byBkZWFsIHdpdGggdGhpcyB3b3VsZCBiZSBtYWtpbmcga2FzYW5fcmVwb3J0KCkgdG8g
cmV0dXJuIGJvb2wgKCJmYWxzZSIgaWYgbm8gcmVwb3J0IGFuZCAidHJ1ZSIgaWYgcmVwb3J0ZWQp
DQo+IGFuZCBwcm9wYWdhdGUgdGhpcyByZXR1cm4gdmFsdWUgdXAgdG8gY2hlY2tfbWVtb3J5X3Jl
Z2lvbigpLg0KPiANClRoaXMgY2hhbmdlcyBpbiB2NC4NCg0KPiANCj4gPj4+IGRpZmYgLS1naXQg
YS9tbS9rYXNhbi9nZW5lcmljX3JlcG9ydC5jIGIvbW0va2FzYW4vZ2VuZXJpY19yZXBvcnQuYw0K
PiA+Pj4gaW5kZXggMzZjNjQ1OTM5YmM5Li41MmE5MmM3ZGI2OTcgMTAwNjQ0DQo+ID4+PiAtLS0g
YS9tbS9rYXNhbi9nZW5lcmljX3JlcG9ydC5jDQo+ID4+PiArKysgYi9tbS9rYXNhbi9nZW5lcmlj
X3JlcG9ydC5jDQo+ID4+PiBAQCAtMTA3LDYgKzEwNywyNCBAQCBzdGF0aWMgY29uc3QgY2hhciAq
Z2V0X3dpbGRfYnVnX3R5cGUoc3RydWN0IGthc2FuX2FjY2Vzc19pbmZvICppbmZvKQ0KPiA+Pj4g
IA0KPiA+Pj4gIGNvbnN0IGNoYXIgKmdldF9idWdfdHlwZShzdHJ1Y3Qga2FzYW5fYWNjZXNzX2lu
Zm8gKmluZm8pDQo+ID4+PiAgew0KPiA+Pj4gKwkvKg0KPiA+Pj4gKwkgKiBJZiBhY2Nlc3Nfc2l6
ZSBpcyBuZWdhdGl2ZSBudW1iZXJzLCB0aGVuIGl0IGhhcyB0aHJlZSByZWFzb25zDQo+ID4+PiAr
CSAqIHRvIGJlIGRlZmluZWQgYXMgaGVhcC1vdXQtb2YtYm91bmRzIGJ1ZyB0eXBlLg0KPiA+Pj4g
KwkgKiAxKSBDYXN0aW5nIG5lZ2F0aXZlIG51bWJlcnMgdG8gc2l6ZV90IHdvdWxkIGluZGVlZCB0
dXJuIHVwIGFzDQo+ID4+PiArCSAqICAgIGEgbGFyZ2Ugc2l6ZV90IGFuZCBpdHMgdmFsdWUgd2ls
bCBiZSBsYXJnZXIgdGhhbiBVTE9OR19NQVgvMiwNCj4gPj4+ICsJICogICAgc28gdGhhdCB0aGlz
IGNhbiBxdWFsaWZ5IGFzIG91dC1vZi1ib3VuZHMuDQo+ID4+PiArCSAqIDIpIElmIEtBU0FOIGhh
cyBuZXcgYnVnIHR5cGUgYW5kIHVzZXItc3BhY2UgcGFzc2VzIG5lZ2F0aXZlIHNpemUsDQo+ID4+
PiArCSAqICAgIHRoZW4gdGhlcmUgYXJlIGR1cGxpY2F0ZSByZXBvcnRzLiBTbyBkb24ndCBwcm9k
dWNlIG5ldyBidWcgdHlwZQ0KPiA+Pj4gKwkgKiAgICBpbiBvcmRlciB0byBwcmV2ZW50IGR1cGxp
Y2F0ZSByZXBvcnRzIGJ5IHNvbWUgc3lzdGVtcw0KPiA+Pj4gKwkgKiAgICAoZS5nLiBzeXpib3Qp
IHRvIHJlcG9ydCB0aGUgc2FtZSBidWcgdHdpY2UuDQo+ID4+PiArCSAqIDMpIFdoZW4gc2l6ZSBp
cyBuZWdhdGl2ZSBudW1iZXJzLCBpdCBtYXkgYmUgcGFzc2VkIGZyb20gdXNlci1zcGFjZS4NCj4g
Pj4+ICsJICogICAgU28gd2UgYWx3YXlzIHByaW50IGhlYXAtb3V0LW9mLWJvdW5kcyBpbiBvcmRl
ciB0byBwcmV2ZW50IHRoYXQNCj4gPj4+ICsJICogICAga2VybmVsLXNwYWNlIGFuZCB1c2VyLXNw
YWNlIGhhdmUgdGhlIHNhbWUgYnVnIGJ1dCBoYXZlIGR1cGxpY2F0ZQ0KPiA+Pj4gKwkgKiAgICBy
ZXBvcnRzLg0KPiA+Pj4gKwkgKi8NCj4gPj4gIA0KPiA+PiBDb21wbGV0ZWx5IGZhaWwgdG8gdW5k
ZXJzdGFuZCAyKSBhbmQgMykuIDIpIHRhbGtzIHNvbWV0aGluZyBhYm91dCAqTk9UKiBwcm9kdWNp
bmcgbmV3IGJ1Zw0KPiA+PiB0eXBlLCBidXQgYXQgdGhlIHNhbWUgdGltZSB5b3UgY29kZSBhY3R1
YWxseSBkb2VzIHRoYXQuDQo+ID4+IDMpIHNheXMgc29tZXRoaW5nIGFib3V0IHVzZXItc3BhY2Ug
d2hpY2ggaGF2ZSBub3RoaW5nIHRvIGRvIHdpdGgga2FzYW4uDQo+ID4+DQo+ID4gYWJvdXQgMikN
Cj4gPiBXZSBvcmlnaW5hbGx5IHRoaW5rIHRoZSBoZWFwLW91dC1vZi1ib3VuZHMgaXMgc2ltaWxh
ciB0bw0KPiA+IGhlYXAtYnVmZmVyLW92ZXJmbG93LCBtYXliZSB3ZSBzaG91bGQgY2hhbmdlIHRo
ZSBidWcgdHlwZSB0bw0KPiA+IGhlYXAtYnVmZmVyLW92ZXJmbG93Lg0KPiANCj4gVGhlcmUgaXMg
bm8gImhlYXAtYnVmZmVyLW92ZXJmbG93Ii4NCj4gDQpJZiBJIHJlbWVtYmVyIGNvcnJlY3RseSwg
ImhlYXAtYnVmZmVyLW92ZXJmbG93IiBpcyBvbmUgb2YgZXhpc3RpbmcgYnVnDQp0eXBlIGluIHVz
ZXItc3BhY2U/IE9yIHlvdSB3YW50IHRvIGV4cGVjdCB0byBzZWUgYW4gZXhpc3RpbmcgYnVnIHR5
cGUgaW4NCmtlcm5lbCBzcGFjZT8NCg0KPiA+IA0KPiA+IGFib3V0IDMpDQo+ID4gT3VyIGlkZWEg
aXMganVzdCB0byBhbHdheXMgcHJpbnQgImhlYXAtb3V0LW9mLWJvdW5kcyIgYW5kIGRvbid0DQo+
ID4gZGlmZmVyZW50aWF0ZSBpZiB0aGUgc2l6ZSBjb21lIGZyb20gdXNlci1zcGFjZSBvciBub3Qu
DQo+IA0KPiBTdGlsbCBkb2Vzbid0IG1ha2Ugc2VuY2UgdG8gbWUuIEtBU0FOIGRvZXNuJ3QgZGlm
ZmVyZW50aWF0ZSBpZiB0aGUgc2l6ZSBjb21pbmcgZnJvbSB1c2VyLXNwYWNlDQo+IG9yIG5vdC4g
SXQgc2ltcGx5IGRvZXNuJ3QgaGF2ZSBhbnkgd2F5IG9mIGtub3dpbmcgZnJvbSB3aGVyZSBpcyB0
aGUgc2l6ZSBjb21pbmcgZnJvbS4NCg0KWWVzLCBpdCBkb24ndCBrbm93IHdoZXJlIGlzIGNvbWlu
ZyBmcm9tLiBzbyB3ZSBvcmlnaW5hbGx5IGFsd2F5cyBwcmludA0KdGhlIGV4aXN0aW5nIGJ1ZyB0
eXBlIHRvIGluZGljYXRlIG5lZ2F0aXZlIHNpemUsIG9yIHdlIGNhbiByZW1vdmUgMyk/DQo=

