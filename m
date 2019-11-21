Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B634FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E4A20731
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="K8JOzSEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKUNJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:09:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58363 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726358AbfKUNJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:09:21 -0500
X-UUID: 68b52b8743034574967e8b319804cedc-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GKRpbk2ZaobBcrGmB5jVBprxNIO5Hbu7SfyTwGSrIKk=;
        b=K8JOzSEHkHL3MO8oyOwdXAKMIDqQpcxBEwEqlODopZEl7MFXIVymzFGDLqKxfOdWdz+LHf5P3vSb6Ev8xRUjc3ht/ru5qp7u3wwEn62wMugngeCHGIBNxYKJrFS3DSsAjRBqZ9xW9UcDmEt38gUd8ubGNI3FuTjP7915/GxBVws=;
X-UUID: 68b52b8743034574967e8b319804cedc-20191121
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1392207874; Thu, 21 Nov 2019 21:09:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 21:09:07 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 21:09:08 +0800
Message-ID: <1574341753.8338.7.camel@mtksdccf07>
Subject: Re: [PATCH v4 1/2] kasan: detect negative size in memory operation
 function
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
CC:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 21 Nov 2019 21:09:13 +0800
In-Reply-To: <217bd537-e6b7-3acc-b6bb-ac9c5d94da89@virtuozzo.com>
References: <20191112065302.7015-1-walter-zh.wu@mediatek.com>
         <040479c3-6f96-91c6-1b1a-9f3e947dac06@virtuozzo.com>
         <1574341376.8338.4.camel@mtksdccf07>
         <217bd537-e6b7-3acc-b6bb-ac9c5d94da89@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTIxIGF0IDE2OjAzICswMzAwLCBBbmRyZXkgUnlhYmluaW4gd3JvdGU6
DQo+IA0KPiBPbiAxMS8yMS8xOSA0OjAyIFBNLCBXYWx0ZXIgV3Ugd3JvdGU6DQo+ID4gT24gVGh1
LCAyMDE5LTExLTIxIGF0IDE1OjI2ICswMzAwLCBBbmRyZXkgUnlhYmluaW4gd3JvdGU6DQo+ID4+
DQo+ID4+IE9uIDExLzEyLzE5IDk6NTMgQU0sIFdhbHRlciBXdSB3cm90ZToNCj4gPj4NCj4gPj4+
IGRpZmYgLS1naXQgYS9tbS9rYXNhbi9jb21tb24uYyBiL21tL2thc2FuL2NvbW1vbi5jDQo+ID4+
PiBpbmRleCA2ODE0ZDZkNmEwMjMuLjRiZmNlMGFmODgxZiAxMDA2NDQNCj4gPj4+IC0tLSBhL21t
L2thc2FuL2NvbW1vbi5jDQo+ID4+PiArKysgYi9tbS9rYXNhbi9jb21tb24uYw0KPiA+Pj4gQEAg
LTEwMiw3ICsxMDIsOCBAQCBFWFBPUlRfU1lNQk9MKF9fa2FzYW5fY2hlY2tfd3JpdGUpOw0KPiA+
Pj4gICN1bmRlZiBtZW1zZXQNCj4gPj4+ICB2b2lkICptZW1zZXQodm9pZCAqYWRkciwgaW50IGMs
IHNpemVfdCBsZW4pDQo+ID4+PiAgew0KPiA+Pj4gLQljaGVja19tZW1vcnlfcmVnaW9uKCh1bnNp
Z25lZCBsb25nKWFkZHIsIGxlbiwgdHJ1ZSwgX1JFVF9JUF8pOw0KPiA+Pj4gKwlpZiAoIWNoZWNr
X21lbW9yeV9yZWdpb24oKHVuc2lnbmVkIGxvbmcpYWRkciwgbGVuLCB0cnVlLCBfUkVUX0lQXykp
DQo+ID4+PiArCQlyZXR1cm4gTlVMTDsNCj4gPj4+ICANCj4gPj4+ICAJcmV0dXJuIF9fbWVtc2V0
KGFkZHIsIGMsIGxlbik7DQo+ID4+PiAgfQ0KPiA+Pj4gQEAgLTExMCw4ICsxMTEsOSBAQCB2b2lk
ICptZW1zZXQodm9pZCAqYWRkciwgaW50IGMsIHNpemVfdCBsZW4pDQo+ID4+PiAgI3VuZGVmIG1l
bW1vdmUNCj4gPj4+ICB2b2lkICptZW1tb3ZlKHZvaWQgKmRlc3QsIGNvbnN0IHZvaWQgKnNyYywg
c2l6ZV90IGxlbikNCj4gPj4+ICB7DQo+ID4+PiAtCWNoZWNrX21lbW9yeV9yZWdpb24oKHVuc2ln
bmVkIGxvbmcpc3JjLCBsZW4sIGZhbHNlLCBfUkVUX0lQXyk7DQo+ID4+PiAtCWNoZWNrX21lbW9y
eV9yZWdpb24oKHVuc2lnbmVkIGxvbmcpZGVzdCwgbGVuLCB0cnVlLCBfUkVUX0lQXyk7DQo+ID4+
PiArCWlmICghY2hlY2tfbWVtb3J5X3JlZ2lvbigodW5zaWduZWQgbG9uZylzcmMsIGxlbiwgZmFs
c2UsIF9SRVRfSVBfKSB8fA0KPiA+Pj4gKwkgICAgIWNoZWNrX21lbW9yeV9yZWdpb24oKHVuc2ln
bmVkIGxvbmcpZGVzdCwgbGVuLCB0cnVlLCBfUkVUX0lQXykpDQo+ID4+PiArCQlyZXR1cm4gTlVM
TDsNCj4gPj4+ICANCj4gPj4+ICAJcmV0dXJuIF9fbWVtbW92ZShkZXN0LCBzcmMsIGxlbik7DQo+
ID4+PiAgfQ0KPiA+Pj4gQEAgLTExOSw4ICsxMjEsOSBAQCB2b2lkICptZW1tb3ZlKHZvaWQgKmRl
c3QsIGNvbnN0IHZvaWQgKnNyYywgc2l6ZV90IGxlbikNCj4gPj4+ICAjdW5kZWYgbWVtY3B5DQo+
ID4+PiAgdm9pZCAqbWVtY3B5KHZvaWQgKmRlc3QsIGNvbnN0IHZvaWQgKnNyYywgc2l6ZV90IGxl
bikNCj4gPj4+ICB7DQo+ID4+PiAtCWNoZWNrX21lbW9yeV9yZWdpb24oKHVuc2lnbmVkIGxvbmcp
c3JjLCBsZW4sIGZhbHNlLCBfUkVUX0lQXyk7DQo+ID4+PiAtCWNoZWNrX21lbW9yeV9yZWdpb24o
KHVuc2lnbmVkIGxvbmcpZGVzdCwgbGVuLCB0cnVlLCBfUkVUX0lQXyk7DQo+ID4+PiArCWlmICgh
Y2hlY2tfbWVtb3J5X3JlZ2lvbigodW5zaWduZWQgbG9uZylzcmMsIGxlbiwgZmFsc2UsIF9SRVRf
SVBfKSB8fA0KPiA+Pj4gKwkgICAgIWNoZWNrX21lbW9yeV9yZWdpb24oKHVuc2lnbmVkIGxvbmcp
ZGVzdCwgbGVuLCB0cnVlLCBfUkVUX0lQXykpDQo+ID4+PiArCQlyZXR1cm4gTlVMTDsNCj4gPj4+
ICANCj4gPj4NCj4gPj4gSSByZWFsaXplZCB0aGF0IHdlIGFyZSBnb2luZyBhIHdyb25nIGRpcmVj
dGlvbiBoZXJlLiBFbnRpcmVseSBza2lwcGluZyBtZW0qKCkgb3BlcmF0aW9uIG9uIGFueQ0KPiA+
PiBwb2lzb25lZCBzaGFkb3cgdmFsdWUgbWlnaHQgb25seSBtYWtlIHRoaW5ncyB3b3JzZS4gU29t
ZSBidWdzIGp1c3QgZG9uJ3QgaGF2ZSBhbnkgc2VyaW91cyBjb25zZXF1ZW5jZXMsDQo+ID4+IGJ1
dCBza2lwcGluZyB0aGUgbWVtKigpIG9wcyBlbnRpcmVseSBtaWdodCBpbnRyb2R1Y2Ugc3VjaCBj
b25zZXF1ZW5jZXMsIHdoaWNoIHdvdWxkbid0IGhhcHBlbiBvdGhlcndpc2UuDQo+ID4+DQo+ID4+
IFNvIGxldCdzIGtlZXAgdGhpcyBjb2RlIGFzIHRoaXMsIG5vIG5lZWQgdG8gY2hlY2sgdGhlIHJl
c3VsdCBvZiBjaGVja19tZW1vcnlfcmVnaW9uKCkuDQo+ID4+DQo+ID4+DQo+ID4gT2ssIHdlIGp1
c3QgbmVlZCB0byBkZXRlcm1pbmUgd2hldGhlciBzaXplIGlzIG5lZ2F0aXZlIG51bWJlci4gSWYg
eWVzDQo+ID4gdGhlbiBLQVNBTiBwcm9kdWNlIHJlcG9ydCBhbmQgY29udGludWUgdG8gZXhlY3V0
ZSBtZW0qKCkuIHJpZ2h0Pw0KPiA+IA0KPiANCj4gWWVzLg0KDQpUaGFua3MgZm9yIHlvdXIgc3Vn
Z2VzdGlvbi4NCkkgd2lsbCBzZW5kIGEgbmV3IHY1IHBhdGNoIHRvbW9ycm93Lg0KDQpXYWx0ZXIN
Cg0K

