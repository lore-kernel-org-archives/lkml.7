Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C32C2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 06:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99410222C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 06:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CKwzmNAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfL3Go0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 01:44:26 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52005 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727136AbfL3Go0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 01:44:26 -0500
X-UUID: c1c4b10a17914d3e9de8771be33c59d6-20191230
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2JEQv42DFUUU456BpXiLJVg53m301BGWjGWt9M3Fzlk=;
        b=CKwzmNAP1rTKSzbkV2j7fTUsbsmVECe4+IZdSxgi86YLM8WBxSkQrAYldL3zQCCIDZtckDOYMGMIgQy03Lk6IOWpG7W4rWB2tdS6Z4GyCNzhPl7wFCNp6/nRaTo37Vj0Qe7ZkJ8s3WPSG8f/g5GHKkFusVrYIO6cRKvYEqwSSII=;
X-UUID: c1c4b10a17914d3e9de8771be33c59d6-20191230
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1251939889; Mon, 30 Dec 2019 14:44:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 30 Dec 2019 14:43:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 30 Dec 2019 14:44:36 +0800
Message-ID: <1577688253.17931.11.camel@mtksdaap41>
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
Date:   Mon, 30 Dec 2019 14:44:13 +0800
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

SGksIEJpYmJ5Og0KDQpPbiBUaHUsIDIwMTktMTEtMjEgYXQgMTU6MjkgKzA4MDAsIEJpYmJ5IEhz
aWVoIHdyb3RlOg0KPiBJZiBjbWRxIGNsaWVudCBpcyBtdWx0aSB0aHJlYWQgdXNlciwgcmFjaW5n
IHdpbGwgb2NjdXIgd2l0aG91dCBtdXRleA0KPiBwcm90ZWN0aW9uLiBJdCB3aWxsIG1ha2UgdGhl
IEMgbWVzc2FnZSBxdWV1ZWQgaW4gbWFpbGJveCdzIHF1ZXVlDQo+IGFsd2F5cyBuZWVkIEQgbWVz
c2FnZSdzIHRyaWdnZXJpbmcuDQo+IA0KPiBUaHJlYWQgQQkJVGhyZWFkIEIJCSAgVGhyZWFkIEMJ
CVRocmVhZCBELi4uDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IG1ib3hfc2VuZF9t
ZXNzYWdlKCkNCj4gCXNlbmRfZGF0YSgpDQo+IAkJCW1ib3hfc2VuZF9tZXNzYWdlKCkNCj4gCQkJ
CSpleGl0DQo+IAkJCQkJCW1ib3hfc2VuZF9tZXNzYWdlKCkNCj4gCQkJCQkJCSpleGl0DQo+IG1i
b3hfY2xpZW50X3R4ZG9uZSgpDQo+IAl0eF90aWNrKCkNCj4gCQkJbWJveF9jbGllbnRfdHhkb25l
KCkNCj4gCQkJCXR4X3RpY2soKQ0KPiAJCQkJCQltYm94X2NsaWVudF90eGRvbmUoKQ0KPiAJCQkJ
CQkJdHhfdGljaygpDQo+IG1zZ19zdWJtaXQoKQ0KPiAJc2VuZF9kYXRhKCkNCj4gCQkJbXNnX3N1
Ym1pdCgpDQo+IAkJCQkqZXhpdA0KPiAJCQkJCQltc2dfc3VibWl0KCkNCj4gCQkJCQkJCSpleGl0
DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaWJi
eSBIc2llaCA8YmliYnkuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMyArKysNCj4gIGluY2x1ZGUvbGludXgvc29j
L21lZGlhdGVrL210ay1jbWRxLmggIHwgMSArDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gaW5k
ZXggOWFkZDBmZDVmYTZjLi45ZTM1ZTBiZWZmYWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jDQo+IEBAIC04MSw2ICs4MSw3IEBAIHN0cnVjdCBjbWRxX2NsaWVu
dCAqY21kcV9tYm94X2NyZWF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBpbmRleCwgdTMyIHRp
bWVvdXQpDQo+ICAJY2xpZW50LT5jbGllbnQuZGV2ID0gZGV2Ow0KPiAgCWNsaWVudC0+Y2xpZW50
LnR4X2Jsb2NrID0gZmFsc2U7DQo+ICAJY2xpZW50LT5jaGFuID0gbWJveF9yZXF1ZXN0X2NoYW5u
ZWwoJmNsaWVudC0+Y2xpZW50LCBpbmRleCk7DQo+ICsJbXV0ZXhfaW5pdCgmY2xpZW50LT5tdXRl
eCk7DQo+ICANCj4gIAlpZiAoSVNfRVJSKGNsaWVudC0+Y2hhbikpIHsNCj4gIAkJbG9uZyBlcnI7
DQo+IEBAIC0zNTIsOSArMzUzLDExIEBAIGludCBjbWRxX3BrdF9mbHVzaF9hc3luYyhzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCwgY21kcV9hc3luY19mbHVzaF9jYiBjYiwNCj4gIAkJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmY2xpZW50LT5sb2NrLCBmbGFncyk7DQo+ICAJfQ0KPiAgDQo+ICsJbXV0ZXhf
bG9jaygmY2xpZW50LT5tdXRleCk7DQo+ICAJbWJveF9zZW5kX21lc3NhZ2UoY2xpZW50LT5jaGFu
LCBwa3QpOw0KPiAgCS8qIFdlIGNhbiBzZW5kIG5leHQgcGFja2V0IGltbWVkaWF0ZWx5LCBzbyBq
dXN0IGNhbGwgdHhkb25lLiAqLw0KPiAgCW1ib3hfY2xpZW50X3R4ZG9uZShjbGllbnQtPmNoYW4s
IDApOw0KPiArCW11dGV4X3VubG9jaygmY2xpZW50LT5tdXRleCk7DQoNCg0KSW4gWzFdLCBNZWRp
YXRlayBEUk0gaXMgdGhlIGZpcnN0IGNsaWVudCB0byB1c2UgY21kcSBhbmQgaXQgYWxyZWFkeSBo
YXMNCml0cyBvd24gbXV0ZXggdG8gcHJvdGVjdCB0aGlzLiBJIHRoaW5rIGhlbHBlciBpcyBzb21l
dGhpbmcgaGVscCBtYW55DQp1c2VyIGJ1dCBub3cgSSBqdXN0IHNlZSBNZWRpYXRlayBNRFAgWzJd
IG5lZWQgdGhpcy4gRm9yIERSTSwgdGhlcmUgYXJlDQpzbyBtYW55IHVzZWxlc3MgY29kZSBpbiBj
bWRxX3BrdF9mbHVzaF9hc3luYygpLiBEUk0gZG9lcyBub3QgbmVlZCB0aGUNCnRpbWVyIHRvIGNo
ZWNrIHRpbWVvdXQuIERSTSBjb3VsZCBkbyBkbWFfc3luY19zaW5nbGVfZm9yX2NwdSgpIGluIGl0
cw0KY2FsbGJhY2sgYW5kIG5lZWQgbm90IHRvIGNyZWF0ZSBhIGludGVybWVkaWF0ZSBjYWxsYmFj
ayB0byBkbyB0aGlzLiBJDQp3b3VsZCBhZ3JlZSB0aGlzIHBhdGNoIG9ubHkgd2hlbiBJIHNlZSB0
d28gb3IgbW9yZSB1c2VyIG5lZWQgdGhpcy4NCg0KDQpbMV0NCmh0dHBzOi8vZ2l0aHViLmNvbS9j
a2h1LW1lZGlhdGVrL2xpbnV4LmdpdC10YWdzL2NvbW1pdC80ZGYxMmVkMTg2NmQxMTA0ZjYzMWUw
NjIxOGJkMTVmZGU1MTJhNzllDQpbMl0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRj
aC8xMDk0NTYwOS8NCg0KUmVnYXJkcywNCkNLDQoNCj4gIA0KPiAgCXJldHVybiAwOw0KPiAgfQ0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2lu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gaW5kZXggYTc0YzFkNWFjZGYz
Li4wZjkwNzFjZDFiYzcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVr
L210ay1jbWRxLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEu
aA0KPiBAQCAtMjgsNiArMjgsNyBAQCBzdHJ1Y3QgY21kcV9jbGllbnQgew0KPiAgCXN0cnVjdCBt
Ym94X2NoYW4gKmNoYW47DQo+ICAJc3RydWN0IHRpbWVyX2xpc3QgdGltZXI7DQo+ICAJdTMyIHRp
bWVvdXRfbXM7IC8qIGluIHVuaXQgb2YgbWljcm9zZWNvbmQgKi8NCj4gKwlzdHJ1Y3QgbXV0ZXgg
bXV0ZXg7DQo+ICB9Ow0KPiAgDQo+ICAvKioNCg0K

