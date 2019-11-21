Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83833C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46018208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FssLwQtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKUNDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:03:05 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:26611 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbfKUNDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:03:04 -0500
X-UUID: 1b33c3166c46481bb7e9762f99332aec-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NsE4689yAaWq1T5b/skLebYVU2kKGZUndAF8Pm3G/5k=;
        b=FssLwQtJ0KNeb9sizE3tAftLAkZ0tDyAgdj54n+V1McYT72q5bgXkUjmYn3XPEriUxNMQ94eGTYkKjOXPJxDMENJcDDHjaQ9c8G+5FOh+72A2LyFIC7oFT9MVzhyTmUOp210JMrny2Or2wTFfFY/Ny2ZB88tvanv/d3zGvATxuQ=;
X-UUID: 1b33c3166c46481bb7e9762f99332aec-20191121
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 302700734; Thu, 21 Nov 2019 21:02:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 21:02:54 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 21:02:51 +0800
Message-ID: <1574341376.8338.4.camel@mtksdccf07>
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
Date:   Thu, 21 Nov 2019 21:02:56 +0800
In-Reply-To: <040479c3-6f96-91c6-1b1a-9f3e947dac06@virtuozzo.com>
References: <20191112065302.7015-1-walter-zh.wu@mediatek.com>
         <040479c3-6f96-91c6-1b1a-9f3e947dac06@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTIxIGF0IDE1OjI2ICswMzAwLCBBbmRyZXkgUnlhYmluaW4gd3JvdGU6
DQo+IA0KPiBPbiAxMS8xMi8xOSA5OjUzIEFNLCBXYWx0ZXIgV3Ugd3JvdGU6DQo+IA0KPiA+IGRp
ZmYgLS1naXQgYS9tbS9rYXNhbi9jb21tb24uYyBiL21tL2thc2FuL2NvbW1vbi5jDQo+ID4gaW5k
ZXggNjgxNGQ2ZDZhMDIzLi40YmZjZTBhZjg4MWYgMTAwNjQ0DQo+ID4gLS0tIGEvbW0va2FzYW4v
Y29tbW9uLmMNCj4gPiArKysgYi9tbS9rYXNhbi9jb21tb24uYw0KPiA+IEBAIC0xMDIsNyArMTAy
LDggQEAgRVhQT1JUX1NZTUJPTChfX2thc2FuX2NoZWNrX3dyaXRlKTsNCj4gPiAgI3VuZGVmIG1l
bXNldA0KPiA+ICB2b2lkICptZW1zZXQodm9pZCAqYWRkciwgaW50IGMsIHNpemVfdCBsZW4pDQo+
ID4gIHsNCj4gPiAtCWNoZWNrX21lbW9yeV9yZWdpb24oKHVuc2lnbmVkIGxvbmcpYWRkciwgbGVu
LCB0cnVlLCBfUkVUX0lQXyk7DQo+ID4gKwlpZiAoIWNoZWNrX21lbW9yeV9yZWdpb24oKHVuc2ln
bmVkIGxvbmcpYWRkciwgbGVuLCB0cnVlLCBfUkVUX0lQXykpDQo+ID4gKwkJcmV0dXJuIE5VTEw7
DQo+ID4gIA0KPiA+ICAJcmV0dXJuIF9fbWVtc2V0KGFkZHIsIGMsIGxlbik7DQo+ID4gIH0NCj4g
PiBAQCAtMTEwLDggKzExMSw5IEBAIHZvaWQgKm1lbXNldCh2b2lkICphZGRyLCBpbnQgYywgc2l6
ZV90IGxlbikNCj4gPiAgI3VuZGVmIG1lbW1vdmUNCj4gPiAgdm9pZCAqbWVtbW92ZSh2b2lkICpk
ZXN0LCBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBsZW4pDQo+ID4gIHsNCj4gPiAtCWNoZWNrX21l
bW9yeV9yZWdpb24oKHVuc2lnbmVkIGxvbmcpc3JjLCBsZW4sIGZhbHNlLCBfUkVUX0lQXyk7DQo+
ID4gLQljaGVja19tZW1vcnlfcmVnaW9uKCh1bnNpZ25lZCBsb25nKWRlc3QsIGxlbiwgdHJ1ZSwg
X1JFVF9JUF8pOw0KPiA+ICsJaWYgKCFjaGVja19tZW1vcnlfcmVnaW9uKCh1bnNpZ25lZCBsb25n
KXNyYywgbGVuLCBmYWxzZSwgX1JFVF9JUF8pIHx8DQo+ID4gKwkgICAgIWNoZWNrX21lbW9yeV9y
ZWdpb24oKHVuc2lnbmVkIGxvbmcpZGVzdCwgbGVuLCB0cnVlLCBfUkVUX0lQXykpDQo+ID4gKwkJ
cmV0dXJuIE5VTEw7DQo+ID4gIA0KPiA+ICAJcmV0dXJuIF9fbWVtbW92ZShkZXN0LCBzcmMsIGxl
bik7DQo+ID4gIH0NCj4gPiBAQCAtMTE5LDggKzEyMSw5IEBAIHZvaWQgKm1lbW1vdmUodm9pZCAq
ZGVzdCwgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3QgbGVuKQ0KPiA+ICAjdW5kZWYgbWVtY3B5DQo+
ID4gIHZvaWQgKm1lbWNweSh2b2lkICpkZXN0LCBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBsZW4p
DQo+ID4gIHsNCj4gPiAtCWNoZWNrX21lbW9yeV9yZWdpb24oKHVuc2lnbmVkIGxvbmcpc3JjLCBs
ZW4sIGZhbHNlLCBfUkVUX0lQXyk7DQo+ID4gLQljaGVja19tZW1vcnlfcmVnaW9uKCh1bnNpZ25l
ZCBsb25nKWRlc3QsIGxlbiwgdHJ1ZSwgX1JFVF9JUF8pOw0KPiA+ICsJaWYgKCFjaGVja19tZW1v
cnlfcmVnaW9uKCh1bnNpZ25lZCBsb25nKXNyYywgbGVuLCBmYWxzZSwgX1JFVF9JUF8pIHx8DQo+
ID4gKwkgICAgIWNoZWNrX21lbW9yeV9yZWdpb24oKHVuc2lnbmVkIGxvbmcpZGVzdCwgbGVuLCB0
cnVlLCBfUkVUX0lQXykpDQo+ID4gKwkJcmV0dXJuIE5VTEw7DQo+ID4gIA0KPiANCj4gSSByZWFs
aXplZCB0aGF0IHdlIGFyZSBnb2luZyBhIHdyb25nIGRpcmVjdGlvbiBoZXJlLiBFbnRpcmVseSBz
a2lwcGluZyBtZW0qKCkgb3BlcmF0aW9uIG9uIGFueQ0KPiBwb2lzb25lZCBzaGFkb3cgdmFsdWUg
bWlnaHQgb25seSBtYWtlIHRoaW5ncyB3b3JzZS4gU29tZSBidWdzIGp1c3QgZG9uJ3QgaGF2ZSBh
bnkgc2VyaW91cyBjb25zZXF1ZW5jZXMsDQo+IGJ1dCBza2lwcGluZyB0aGUgbWVtKigpIG9wcyBl
bnRpcmVseSBtaWdodCBpbnRyb2R1Y2Ugc3VjaCBjb25zZXF1ZW5jZXMsIHdoaWNoIHdvdWxkbid0
IGhhcHBlbiBvdGhlcndpc2UuDQo+IA0KPiBTbyBsZXQncyBrZWVwIHRoaXMgY29kZSBhcyB0aGlz
LCBubyBuZWVkIHRvIGNoZWNrIHRoZSByZXN1bHQgb2YgY2hlY2tfbWVtb3J5X3JlZ2lvbigpLg0K
PiANCj4gDQpPaywgd2UganVzdCBuZWVkIHRvIGRldGVybWluZSB3aGV0aGVyIHNpemUgaXMgbmVn
YXRpdmUgbnVtYmVyLiBJZiB5ZXMNCnRoZW4gS0FTQU4gcHJvZHVjZSByZXBvcnQgYW5kIGNvbnRp
bnVlIHRvIGV4ZWN1dGUgbWVtKigpLiByaWdodD8NCg==

