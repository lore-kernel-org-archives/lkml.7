Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58404C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEC62068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QOHYHgfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLDCWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 21:22:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:29015 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbfLDCWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:22:21 -0500
X-UUID: 68ec0c3ab67948ca9baeb7e60e3fa6c4-20191204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=gASy9TDuVsH5zwpxeW0BE8bxVb8mYW76DT6995xQhXA=;
        b=QOHYHgfvSFD8m0DDWMic4GaD7zRffTP057Ws/SsQ1lzOhPCh3ga0IqjcmI/q4SbsWBKQZETxYEECbKtQFrKxv++xGGl9RZ7/J8ZXJdIbkji55JlP82QR1jYNIWi1oqgTPlTwy1VxLGwLqfEtrtULsmD3/Cv4N6yU+hnZYI5ienI=;
X-UUID: 68ec0c3ab67948ca9baeb7e60e3fa6c4-20191204
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1382334364; Wed, 04 Dec 2019 10:22:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Dec 2019 10:22:03 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Dec 2019 10:21:56 +0800
Message-ID: <1575426135.31411.2.camel@mtksdaap41>
Subject: Re: [PATCH] soc: mediatek: cmdq: avoid racing condition with mutex
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Date:   Wed, 4 Dec 2019 10:22:15 +0800
In-Reply-To: <20191121072910.31665-1-bibby.hsieh@mediatek.com>
References: <20191121072910.31665-1-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc3NpOg0KDQpBcmUgbWJveF9zZW5kX21lc3NhZ2UoKSBhbmQgbWJveF9jbGllbnRfdHhk
b25lKCkgdGhyZWFkLXNhZmU/IElmIHRoZXNlDQp0d28gYXJlIHRocmVhZC1zYWZlLCB0aGlzIGJ1
ZyBzaG91bGQgYmUgZml4ZWQgaW4gbWFpbGJveCBjb3JlIG5vdA0KY2xpZW50Lg0KDQpSZWdhcmRz
LA0KQ0sNCg0KT24gVGh1LCAyMDE5LTExLTIxIGF0IDE1OjI5ICswODAwLCBCaWJieSBIc2llaCB3
cm90ZToNCj4gSWYgY21kcSBjbGllbnQgaXMgbXVsdGkgdGhyZWFkIHVzZXIsIHJhY2luZyB3aWxs
IG9jY3VyIHdpdGhvdXQgbXV0ZXgNCj4gcHJvdGVjdGlvbi4gSXQgd2lsbCBtYWtlIHRoZSBDIG1l
c3NhZ2UgcXVldWVkIGluIG1haWxib3gncyBxdWV1ZQ0KPiBhbHdheXMgbmVlZCBEIG1lc3NhZ2Un
cyB0cmlnZ2VyaW5nLg0KPiANCj4gVGhyZWFkIEEJCVRocmVhZCBCCQkgIFRocmVhZCBDCQlUaHJl
YWQgRC4uLg0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBtYm94X3NlbmRfbWVzc2Fn
ZSgpDQo+IAlzZW5kX2RhdGEoKQ0KPiAJCQltYm94X3NlbmRfbWVzc2FnZSgpDQo+IAkJCQkqZXhp
dA0KPiAJCQkJCQltYm94X3NlbmRfbWVzc2FnZSgpDQo+IAkJCQkJCQkqZXhpdA0KPiBtYm94X2Ns
aWVudF90eGRvbmUoKQ0KPiAJdHhfdGljaygpDQo+IAkJCW1ib3hfY2xpZW50X3R4ZG9uZSgpDQo+
IAkJCQl0eF90aWNrKCkNCj4gCQkJCQkJbWJveF9jbGllbnRfdHhkb25lKCkNCj4gCQkJCQkJCXR4
X3RpY2soKQ0KPiBtc2dfc3VibWl0KCkNCj4gCXNlbmRfZGF0YSgpDQo+IAkJCW1zZ19zdWJtaXQo
KQ0KPiAJCQkJKmV4aXQNCj4gCQkJCQkJbXNnX3N1Ym1pdCgpDQo+IAkJCQkJCQkqZXhpdA0KPiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmliYnkgSHNp
ZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDMgKysrDQo+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oICB8IDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGluZGV4IDlh
ZGQwZmQ1ZmE2Yy4uOWUzNWUwYmVmZmFhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYw0KPiBAQCAtODEsNiArODEsNyBAQCBzdHJ1Y3QgY21kcV9jbGllbnQgKmNt
ZHFfbWJveF9jcmVhdGUoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgaW5kZXgsIHUzMiB0aW1lb3V0
KQ0KPiAgCWNsaWVudC0+Y2xpZW50LmRldiA9IGRldjsNCj4gIAljbGllbnQtPmNsaWVudC50eF9i
bG9jayA9IGZhbHNlOw0KPiAgCWNsaWVudC0+Y2hhbiA9IG1ib3hfcmVxdWVzdF9jaGFubmVsKCZj
bGllbnQtPmNsaWVudCwgaW5kZXgpOw0KPiArCW11dGV4X2luaXQoJmNsaWVudC0+bXV0ZXgpOw0K
PiAgDQo+ICAJaWYgKElTX0VSUihjbGllbnQtPmNoYW4pKSB7DQo+ICAJCWxvbmcgZXJyOw0KPiBA
QCAtMzUyLDkgKzM1MywxMSBAQCBpbnQgY21kcV9wa3RfZmx1c2hfYXN5bmMoc3RydWN0IGNtZHFf
cGt0ICpwa3QsIGNtZHFfYXN5bmNfZmx1c2hfY2IgY2IsDQo+ICAJCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJmNsaWVudC0+bG9jaywgZmxhZ3MpOw0KPiAgCX0NCj4gIA0KPiArCW11dGV4X2xvY2so
JmNsaWVudC0+bXV0ZXgpOw0KPiAgCW1ib3hfc2VuZF9tZXNzYWdlKGNsaWVudC0+Y2hhbiwgcGt0
KTsNCj4gIAkvKiBXZSBjYW4gc2VuZCBuZXh0IHBhY2tldCBpbW1lZGlhdGVseSwgc28ganVzdCBj
YWxsIHR4ZG9uZS4gKi8NCj4gIAltYm94X2NsaWVudF90eGRvbmUoY2xpZW50LT5jaGFuLCAwKTsN
Cj4gKwltdXRleF91bmxvY2soJmNsaWVudC0+bXV0ZXgpOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+
ICB9DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
IGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBpbmRleCBhNzRjMWQ1
YWNkZjMuLjBmOTA3MWNkMWJjNyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGst
Y21kcS5oDQo+IEBAIC0yOCw2ICsyOCw3IEBAIHN0cnVjdCBjbWRxX2NsaWVudCB7DQo+ICAJc3Ry
dWN0IG1ib3hfY2hhbiAqY2hhbjsNCj4gIAlzdHJ1Y3QgdGltZXJfbGlzdCB0aW1lcjsNCj4gIAl1
MzIgdGltZW91dF9tczsgLyogaW4gdW5pdCBvZiBtaWNyb3NlY29uZCAqLw0KPiArCXN0cnVjdCBt
dXRleCBtdXRleDsNCj4gIH07DQo+ICANCj4gIC8qKg0KDQo=

