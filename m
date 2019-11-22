Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE98AC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CD120659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gHxeAf5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKVHSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 02:18:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48330 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbfKVHSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 02:18:43 -0500
X-UUID: a81b81e6f8804a6bb5c3d97cbf665b8d-20191122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Rn/XoDq5loIZaVO1pS6BYoAXB6sUp5RYn3/dfFUf7zc=;
        b=gHxeAf5sG9N4OAiGULAd/71WH48OQvo7+wOUdGKXM2iC2ywkuZliaijlJNPHaxe4vfanFehwD/cR/NrEdfz/w7LXThLmOjYgKO/D56KKcmAazYezqNX2IUYqe6ITylL2dbXPxpsJ3lvfVT+YOIg1oRMY6ejkzBXvBS/U+j+RC5M=;
X-UUID: a81b81e6f8804a6bb5c3d97cbf665b8d-20191122
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 295321122; Fri, 22 Nov 2019 15:18:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 22 Nov 2019 15:18:30 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 22 Nov 2019 15:18:28 +0800
Message-ID: <1574407116.8338.10.camel@mtksdccf07>
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
        <linux-mediatek@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 22 Nov 2019 15:18:36 +0800
In-Reply-To: <b2ba5228-dec0-9acf-49e9-d57f156814ef@virtuozzo.com>
References: <20191112065302.7015-1-walter-zh.wu@mediatek.com>
         <b2ba5228-dec0-9acf-49e9-d57f156814ef@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTExLTIyIGF0IDAxOjIwICswMzAwLCBBbmRyZXkgUnlhYmluaW4gd3JvdGU6
DQo+IA0KPiBPbiAxMS8xMi8xOSA5OjUzIEFNLCBXYWx0ZXIgV3Ugd3JvdGU6DQo+ID4gS0FTQU4g
bWlzc2VkIGRldGVjdGluZyBzaXplIGlzIGEgbmVnYXRpdmUgbnVtYmVyIGluIG1lbXNldCgpLCBt
ZW1jcHkoKSwNCj4gPiBhbmQgbWVtbW92ZSgpLCBpdCB3aWxsIGNhdXNlIG91dC1vZi1ib3VuZHMg
YnVnLiBTbyBuZWVkcyB0byBiZSBkZXRlY3RlZA0KPiA+IGJ5IEtBU0FOLg0KPiA+IA0KPiA+IElm
IHNpemUgaXMgYSBuZWdhdGl2ZSBudW1iZXIsIHRoZW4gaXQgaGFzIGEgcmVhc29uIHRvIGJlIGRl
ZmluZWQgYXMNCj4gPiBvdXQtb2YtYm91bmRzIGJ1ZyB0eXBlLg0KPiA+IENhc3RpbmcgbmVnYXRp
dmUgbnVtYmVycyB0byBzaXplX3Qgd291bGQgaW5kZWVkIHR1cm4gdXAgYXMNCj4gPiBhIGxhcmdl
IHNpemVfdCBhbmQgaXRzIHZhbHVlIHdpbGwgYmUgbGFyZ2VyIHRoYW4gVUxPTkdfTUFYLzIsDQo+
ID4gc28gdGhhdCB0aGlzIGNhbiBxdWFsaWZ5IGFzIG91dC1vZi1ib3VuZHMuDQo+ID4gDQo+ID4g
S0FTQU4gcmVwb3J0IGlzIHNob3duIGJlbG93Og0KPiA+IA0KPiA+ICBCVUc6IEtBU0FOOiBvdXQt
b2YtYm91bmRzIGluIGttYWxsb2NfbWVtbW92ZV9pbnZhbGlkX3NpemUrMHg3MC8weGEwDQo+ID4g
IFJlYWQgb2Ygc2l6ZSAxODQ0Njc0NDA3MzcwOTU1MTYwOCBhdCBhZGRyIGZmZmZmZjgwNjk2NjA5
MDQgYnkgdGFzayBjYXQvNzINCj4gPiANCj4gPiAgQ1BVOiAyIFBJRDogNzIgQ29tbTogY2F0IE5v
dCB0YWludGVkIDUuNC4wLXJjMS1uZXh0LTIwMTkxMDA0YWpiLTAwMDAxLWdkYjhhZjJmMzcyYjIt
ZGlydHkgIzENCj4gPiAgSGFyZHdhcmUgbmFtZTogbGludXgsZHVtbXktdmlydCAoRFQpDQo+ID4g
IENhbGwgdHJhY2U6DQo+ID4gICBkdW1wX2JhY2t0cmFjZSsweDAvMHgyODgNCj4gPiAgIHNob3df
c3RhY2srMHgxNC8weDIwDQo+ID4gICBkdW1wX3N0YWNrKzB4MTBjLzB4MTY0DQo+ID4gICBwcmlu
dF9hZGRyZXNzX2Rlc2NyaXB0aW9uLmlzcmEuOSsweDY4LzB4Mzc4DQo+ID4gICBfX2thc2FuX3Jl
cG9ydCsweDE2NC8weDFhMA0KPiA+ICAga2FzYW5fcmVwb3J0KzB4Yy8weDE4DQo+ID4gICBjaGVj
a19tZW1vcnlfcmVnaW9uKzB4MTc0LzB4MWQwDQo+ID4gICBtZW1tb3ZlKzB4MzQvMHg4OA0KPiA+
ICAga21hbGxvY19tZW1tb3ZlX2ludmFsaWRfc2l6ZSsweDcwLzB4YTANCj4gPiANCj4gPiBbMV0g
aHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0xOTkzNDENCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBXYWx0ZXIgV3UgPHdhbHRlci16aC53dUBtZWRpYXRlay5jb20+
DQo+ID4gUmVwb3J0ZWQtYnk6IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCj4g
PiBTdWdnZXN0ZWQtYnk6IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCj4gPiBS
ZXZpZXdlZC1ieTogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KPiA+IENjOiBB
bmRyZXkgUnlhYmluaW4gPGFyeWFiaW5pbkB2aXJ0dW96em8uY29tPg0KPiA+IENjOiBBbGV4YW5k
ZXIgUG90YXBlbmtvIDxnbGlkZXJAZ29vZ2xlLmNvbT4NCj4gPiBSZXBvcnRlZC1ieToga2VybmVs
IHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ID4gLS0tDQo+IA0KPiBSZXZpZXdlZC1ieTog
QW5kcmV5IFJ5YWJpbmluIDxhcnlhYmluaW5AdmlydHVvenpvLmNvbT4NCg0KSGkgQW5kcmV5LCBE
bWl0cnksDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQoNCldhbHRl
cg0K

