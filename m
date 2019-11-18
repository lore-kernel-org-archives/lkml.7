Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91C5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 03:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841D2206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 03:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfKRDOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 22:14:46 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2512 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbfKRDOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 22:14:46 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id E086DF8F92D8C36C08C6;
        Mon, 18 Nov 2019 11:14:43 +0800 (CST)
Received: from dggeme714-chm.china.huawei.com (10.1.199.110) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 Nov 2019 11:14:43 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme714-chm.china.huawei.com (10.1.199.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 18 Nov 2019 11:14:43 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Mon, 18 Nov 2019 11:14:43 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "jannh@google.com" <jannh@google.com>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "chenjianhong2@huawei.com" <chenjianhong2@huawei.com>,
        "walken@google.com" <walken@google.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: get rid of odd jump label in find_mergeable_anon_vma
Thread-Topic: [PATCH] mm: get rid of odd jump label in find_mergeable_anon_vma
Thread-Index: AdWdvXc82a+1sH3ISoaZ6JMVZNGdiw==
Date:   Mon, 18 Nov 2019 03:14:43 +0000
Message-ID: <41506f6d6af44a7e937b0e56642bd9e7@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.189.20]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDExLzE1LzE5IDQ6NTggQU0sIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4gT24g
MTUuMTEuMTkgMDc6MzYsIGxpbm1pYW9oZSB3cm90ZToNCj4+PiBGcm9tOiBNaWFvaGUgTGluIDxs
aW5taWFvaGVAaHVhd2VpLmNvbT4NCj4+IA0KPj4gSSdtIHBybyByZW1vdmluZyB1bm5lY2Vzc2Fy
eSBqdW1wIGxhYmVscy4NCj4NCj5UaGFuayB5b3UsIHNpbXBsZXIgY29kZSBpcyBnb29kLS1hbGwg
b3RoZXIgdGhpbmdzIGJlaW5nIGVxdWFsLiANCj5UaGUgIHRyYWRlb2ZmIGlzLCBhcyBRaWFuIHBv
aW50cyBvdXQ6IGNvZGUgY2h1cm4gYW5kIHJpc2sgaW4gY3JpdGljYWwgY29kZSBwYXRocy4NCj4N
Cj5JbiB0aGlzIGNhc2UsIEknZCBjbGFpbSBpdCdzIE9LIHRvIGltcHJvdmUgdGhpcyBvbmUsIGJl
Y2F1c2Ugd2UgY2FuIGxpa2VseSBnZXQgaXQgcmlnaHQgYnkgdmlzdWFsIGluc3BlY3Rpb24sIGFu
ZCB0aGUgcHJlLWV4aXN0aW5nIGNvZGUgaXMgcXVpdGUgcG9vci4gQW5kIGJlaW5nIGluIHRoZSBr
ZXJuZWwgZG9lcyBub3QgbmVjZXNzYXJpbHkgZ2l2ZSB3ZWFrIGNvZGUgYSBmcmVlIHBhc3MgdG8g
cmVtYWluIHRoZXJlIGFuZCBpbmN1ciBtYWludGVuYW5jZSBhbmQgYW5ub3lhbmNlIGNvc3RzIHVu
dGlsIHRoZSBlbmQgb2YgdGltZS4gOikNCj4NCj5Ib3dldmVyLCBwbGVhc2Ugc3BlbmQgZXF1YWwg
dGltZSB3aGVuIHlvdSB3cml0ZSB5b3VyIGNvbW1pdCBkZXNjcmlwdGlvbnMsIGJlY2F1c2UgdGhh
dCdzIGFsc28gdmVyeSBpbXBvcnRhbnQuIENvbW1pdCBsb2dzIHNob3VsZCBhbHNvIGJlIGNsZWFy
IQ0KPg0KPj4gDQo+PiBTdWJqZWN0OiAibW06IGdldCByaWQgb2YganVtcCBsYWJlbHMgaW4gZmlu
ZF9tZXJnZWFibGVfYW5vbl92bWEoKSINCj4+IA0KPj4+DQo+Pj4gVGhlIG9kZCBqdW1wIGxhYmVs
IHRyeV9wcmV2IGFuZCBub25lIGlzIG5vdCByZWFsbHkgbmVlZA0KPg0KPnMvbmVlZC9uZWVkZWQv
DQo+DQo+PiANCj4+IHMvb2RkIGp1bXAgbGFiZWwvanVtcCBsYWJlbHMvDQo+PiANCj4+IHMvaXMv
YXJlLw0KPj4gDQo+Pj4gaW4gZnVuYyBmaW5kX21lcmdlYWJsZV9hbm9uX3ZtYSwgZWxpbWluYXRl
IHRoZW0gdG8gaW1wcm92ZSANCj4+PiByZWFkYWJpbGl0eS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYt
Ynk6IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0KPj4+IC0tLQ0KPj4+ICBtbS9t
bWFwLmMgfCAxOCArKysrKysrLS0tLS0tLS0tLS0NCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvbW0vbW1h
cC5jIGIvbW0vbW1hcC5jDQo+Pj4gaW5kZXggNGQ0ZGI3NmEwN2RhLi5hYjk4MGQ0NjhhMTAgMTAw
NjQ0DQo+PiANCj4+IExldCBtZSBzdWdnZXN0IHRoZSBmb2xsb3dpbmcgaW5zdGVhZDoNCj4+IA0K
Pj4gLyogVHJ5IG5leHQgZmlyc3QgKi8NCj4+IG5lYXIgPSB2bWEtPnZtX25leHQ7DQo+PiBpZiAo
bmVhcikgew0KPj4gCWFub25fdm1hID0gcmV1c2FibGVfYW5vbl92bWEobmVhciwgdm1hLCBuZWFy
KTsNCj4+IAlpZiAoYW5vbl92bWEpDQo+PiAJCXJldHVybiBhbm9uX3ZtYTsNCj4+IH0NCj4+IC8q
IFRyeSBwcmV2IG5leHQgKi8NCj4+IG5lYXIgPSB2bWEtPnZtX3ByZXY7DQo+PiBpZiAobmVhcikg
ew0KPj4gCWFub25fdm1hID0gcmV1c2FibGVfYW5vbl92bWEobmVhciwgdm1hLCBuZWFyKTsNCj4+
IAlpZiAoYW5vbl92bWEpDQo+PiAJCXJldHVybiBhbm9uX3ZtYTsNCj4+IH0NCj4+IA0KPg0KPkFj
dHVhbGx5LCBpdCBjYW4gYmUgZnVydGhlciBzaW1wbGlmaWVkLCBiZWNhdXNlIHlvdSBkb24ndCBu
ZWVkIHRoYXQgbGFzdCAiaWYiIHN0YXRlbWVudCwgYmVjYXVzZSB5b3UncmUgcmV0dXJuaW5nIE5V
TEwgYWZ0ZXIgdGhpcy4NCj4NCj5TbyBqdXN0IHJldHVybiBhbm9uX3ZtYSB0aGVyZS4gKEFuZCBh
ZGp1c3QgdGhlIGNvbW1lbnQgYmxvY2sgYXQgdGhlIGVuZCwgc28gdGhhdCBpdCdzIGNsZWFyIHRo
YXQgYW5vbl92bWEgbWlnaHQgYmUgbnVsbC4pDQo+DQo+DQoNCk1hbnkgVGhhbmtzIGZvciBhbGwg
b2YgeW91ciBwcmVjaW91cyBhZHZpY2UuIEkgd2lsbCBmaXggbXkgcGF0Y2ggYW5kIHNlbmQgYSB2
MiBwYXRjaC4gVGhhbmtzIGFnYWluLg0KIA0K
