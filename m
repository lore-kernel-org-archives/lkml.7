Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB2BC2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F85207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Q2umEATI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfL3CCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 21:02:45 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58322 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726343AbfL3CCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 21:02:45 -0500
X-UUID: 631568d282b346eea7c344ff6a4ca3f7-20191230
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zs3wqU0/rTaxSd+jOFQHg8yAjxKsG5qsZDhljNgTpew=;
        b=Q2umEATIEYiHqozWXZcwK0YOuRDfKw2mUSzZs4rA/HI7fGWtJhA/xeiNU7BDRolk8Cp8JwVIVE5Tmpo1MZ3P3OLVSxAO8qT7ossqzs8D0W0iLTreYRsorvTl8iCNEu7GHRzr4JUD5FLMx47En8ecJ7TssN9/wjdG89XbgB2ws9g=;
X-UUID: 631568d282b346eea7c344ff6a4ca3f7-20191230
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1006649543; Mon, 30 Dec 2019 10:02:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 30 Dec 2019 10:02:18 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 30 Dec 2019 10:03:03 +0800
Message-ID: <1577671361.8160.2.camel@mtksdaap41>
Subject: Re: [PATCH] soc: mediatek: cmdq: avoid racing condition with mutex
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Date:   Mon, 30 Dec 2019 10:02:41 +0800
In-Reply-To: <1575426135.31411.2.camel@mtksdaap41>
References: <20191121072910.31665-1-bibby.hsieh@mediatek.com>
         <1575426135.31411.2.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc3NpOg0KDQpQaW5nIGFnYWluLg0KDQpBcmUgbWJveF9zZW5kX21lc3NhZ2UoKSBhbmQg
bWJveF9jbGllbnRfdHhkb25lKCkgdGhyZWFkLXNhZmU/IElmIHRoZXNlDQp0d28gYXJlIHRocmVh
ZC1zYWZlLCB0aGlzIGJ1ZyBzaG91bGQgYmUgZml4ZWQgaW4gbWFpbGJveCBjb3JlIG5vdA0KY2xp
ZW50Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KT24gV2VkLCAyMDE5LTEyLTA0IGF0IDEwOjIyICswODAw
LCBDSyBIdSB3cm90ZToNCj4gSGksIEphc3NpOg0KPiANCj4gQXJlIG1ib3hfc2VuZF9tZXNzYWdl
KCkgYW5kIG1ib3hfY2xpZW50X3R4ZG9uZSgpIHRocmVhZC1zYWZlPyBJZiB0aGVzZQ0KPiB0d28g
YXJlIHRocmVhZC1zYWZlLCB0aGlzIGJ1ZyBzaG91bGQgYmUgZml4ZWQgaW4gbWFpbGJveCBjb3Jl
IG5vdA0KPiBjbGllbnQuDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCj4gT24gVGh1LCAyMDE5
LTExLTIxIGF0IDE1OjI5ICswODAwLCBCaWJieSBIc2llaCB3cm90ZToNCj4gPiBJZiBjbWRxIGNs
aWVudCBpcyBtdWx0aSB0aHJlYWQgdXNlciwgcmFjaW5nIHdpbGwgb2NjdXIgd2l0aG91dCBtdXRl
eA0KPiA+IHByb3RlY3Rpb24uIEl0IHdpbGwgbWFrZSB0aGUgQyBtZXNzYWdlIHF1ZXVlZCBpbiBt
YWlsYm94J3MgcXVldWUNCj4gPiBhbHdheXMgbmVlZCBEIG1lc3NhZ2UncyB0cmlnZ2VyaW5nLg0K
PiA+IA0KPiA+IFRocmVhZCBBCQlUaHJlYWQgQgkJICBUaHJlYWQgQwkJVGhyZWFkIEQuLi4NCj4g
PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IG1ib3hfc2VuZF9tZXNzYWdlKCkNCj4g
PiAJc2VuZF9kYXRhKCkNCj4gPiAJCQltYm94X3NlbmRfbWVzc2FnZSgpDQo+ID4gCQkJCSpleGl0
DQo+ID4gCQkJCQkJbWJveF9zZW5kX21lc3NhZ2UoKQ0KPiA+IAkJCQkJCQkqZXhpdA0KPiA+IG1i
b3hfY2xpZW50X3R4ZG9uZSgpDQo+ID4gCXR4X3RpY2soKQ0KPiA+IAkJCW1ib3hfY2xpZW50X3R4
ZG9uZSgpDQo+ID4gCQkJCXR4X3RpY2soKQ0KPiA+IAkJCQkJCW1ib3hfY2xpZW50X3R4ZG9uZSgp
DQo+ID4gCQkJCQkJCXR4X3RpY2soKQ0KPiA+IG1zZ19zdWJtaXQoKQ0KPiA+IAlzZW5kX2RhdGEo
KQ0KPiA+IAkJCW1zZ19zdWJtaXQoKQ0KPiA+IAkJCQkqZXhpdA0KPiA+IAkJCQkJCW1zZ19zdWJt
aXQoKQ0KPiA+IAkJCQkJCQkqZXhpdA0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgfCAzICsrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICB8
IDEgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gaW5kZXggOWFkZDBmZDVmYTZj
Li45ZTM1ZTBiZWZmYWEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEtaGVscGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYw0KPiA+IEBAIC04MSw2ICs4MSw3IEBAIHN0cnVjdCBjbWRxX2NsaWVudCAqY21kcV9t
Ym94X2NyZWF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBpbmRleCwgdTMyIHRpbWVvdXQpDQo+
ID4gIAljbGllbnQtPmNsaWVudC5kZXYgPSBkZXY7DQo+ID4gIAljbGllbnQtPmNsaWVudC50eF9i
bG9jayA9IGZhbHNlOw0KPiA+ICAJY2xpZW50LT5jaGFuID0gbWJveF9yZXF1ZXN0X2NoYW5uZWwo
JmNsaWVudC0+Y2xpZW50LCBpbmRleCk7DQo+ID4gKwltdXRleF9pbml0KCZjbGllbnQtPm11dGV4
KTsNCj4gPiAgDQo+ID4gIAlpZiAoSVNfRVJSKGNsaWVudC0+Y2hhbikpIHsNCj4gPiAgCQlsb25n
IGVycjsNCj4gPiBAQCAtMzUyLDkgKzM1MywxMSBAQCBpbnQgY21kcV9wa3RfZmx1c2hfYXN5bmMo
c3RydWN0IGNtZHFfcGt0ICpwa3QsIGNtZHFfYXN5bmNfZmx1c2hfY2IgY2IsDQo+ID4gIAkJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmY2xpZW50LT5sb2NrLCBmbGFncyk7DQo+ID4gIAl9DQo+ID4g
IA0KPiA+ICsJbXV0ZXhfbG9jaygmY2xpZW50LT5tdXRleCk7DQo+ID4gIAltYm94X3NlbmRfbWVz
c2FnZShjbGllbnQtPmNoYW4sIHBrdCk7DQo+ID4gIAkvKiBXZSBjYW4gc2VuZCBuZXh0IHBhY2tl
dCBpbW1lZGlhdGVseSwgc28ganVzdCBjYWxsIHR4ZG9uZS4gKi8NCj4gPiAgCW1ib3hfY2xpZW50
X3R4ZG9uZShjbGllbnQtPmNoYW4sIDApOw0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZjbGllbnQtPm11
dGV4KTsNCj4gPiAgDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IGluZGV4IGE3NGMxZDVhY2RmMy4uMGY5MDcxY2QxYmM3
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgN
Cj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gQEAg
LTI4LDYgKzI4LDcgQEAgc3RydWN0IGNtZHFfY2xpZW50IHsNCj4gPiAgCXN0cnVjdCBtYm94X2No
YW4gKmNoYW47DQo+ID4gIAlzdHJ1Y3QgdGltZXJfbGlzdCB0aW1lcjsNCj4gPiAgCXUzMiB0aW1l
b3V0X21zOyAvKiBpbiB1bml0IG9mIG1pY3Jvc2Vjb25kICovDQo+ID4gKwlzdHJ1Y3QgbXV0ZXgg
bXV0ZXg7DQo+ID4gIH07DQo+ID4gIA0KPiA+ICAvKioNCj4gDQoNCg==

