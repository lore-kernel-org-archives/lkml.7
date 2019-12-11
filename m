Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8620FC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576C72077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J/FSAdTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfLKBsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:48:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:25487 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726417AbfLKBsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:48:31 -0500
X-UUID: 8b5177e1fe0449ba9ecefa0631edfa49-20191211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sqQ1DVfAQShEvzPrqHNKDy4tI0jEIAeICULZI5AfwMw=;
        b=J/FSAdTOdRqXo7TTzVE34BYBc4wdpei3wrEjp4ZrZ4tWUmyLj3hfU2WD5XeFQ3BjnGLV9iU7wqen75AIcpgCTPb1y1En+WaetQ0Wx69XyOzA1PPfkA+TaSRI+Pln38xVpl/ktdKMPQI/+2UMy35SdwQZhEOO56SyMyMvJY9G9fM=;
X-UUID: 8b5177e1fe0449ba9ecefa0631edfa49-20191211
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1426890370; Wed, 11 Dec 2019 09:48:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Dec 2019 09:47:21 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Dec 2019 09:48:14 +0800
Message-ID: <1576028899.19653.5.camel@mtksdaap41>
Subject: Re: [PATCH v2 12/14] soc: mediatek: cmdq: add loop function
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 11 Dec 2019 09:48:19 +0800
In-Reply-To: <1574819937-6246-14-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-14-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A5230DE48B16A267340064E1455F9D274E3E4DE6A9287E6E0E4EC648793AA9F82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gV2VkLCAyMDE5LTExLTI3IGF0IDA5OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCBmaW5hbGl6ZSBsb29wIGZ1bmN0aW9uIGluIGNtZHEgaGVs
cGVyIGZ1bmN0aW9ucyB3aGljaCBsb29wIHdob2xlIHBrdA0KPiBpbiBnY2UgaGFyZHdhcmUgdGhy
ZWFkIHdpdGhvdXQgY3B1IG9wZXJhdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZ
QyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDIyICsrKysrKysrKysrKysrKysrKysr
KysNCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgIDggKysrKysr
KysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gaW5kZXggMzhlMGMxM2UxOTIyLi4xMGE5YjQ0
ODFlNTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IEBA
IC00MTQsNiArNDE0LDI4IEBAIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCkNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0woY21kcV9wa3RfZmluYWxpemUpOw0KPiAgDQo+
ICtpbnQgY21kcV9wa3RfZmluYWxpemVfbG9vcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCkNCj4gK3sN
Cj4gKwlzdHJ1Y3QgY21kcV9jbGllbnQgKmNsID0gcGt0LT5jbDsNCj4gKwlzdHJ1Y3QgY21kcV9p
bnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gKwlpbnQgZXJyOw0KPiArDQo+ICsJLyogaW5z
ZXJ0IEVPQyBhbmQgZ2VuZXJhdGUgSVJRIGZvciBlYWNoIGNvbW1hbmQgaXRlcmF0aW9uICovDQo+
ICsJaW5zdC5vcCA9IENNRFFfQ09ERV9FT0M7DQo+ICsJZXJyID0gY21kcV9wa3RfYXBwZW5kX2Nv
bW1hbmQocGt0LCBpbnN0KTsNCj4gKwlpZiAoZXJyIDwgMCkNCj4gKwkJcmV0dXJuIGVycjsNCg0K
SXQgbG9va3MgbGlrZSB5b3Ugd2FudCBhIHBrdCBleGVjdXRlIGNvbW1hbmQgcmVwZWF0ZWRseSwg
YnV0IHdoeSBkbyB5b3UNCnJlcGVhdGVkbHkgdHJpZ2dlciBJUlE/IFRoaXMgSVJRIHdvdWxkIGRv
IG5vdGhpbmcgYmVjYXVzZSB0aGlzIHBrdCB3b3VsZA0KbmV2ZXIgZmluaXNoLg0KDQo+ICsNCj4g
KwkvKiBKVU1QIGFiYW9sdXRlIHRvIGJlZ2luICovDQo+ICsJaW5zdC5vcCA9IENNRFFfQ09ERV9K
VU1QOw0KPiArCWluc3Qub2Zmc2V0ID0gMTsNCj4gKwlpbnN0LnZhbHVlID0gcGt0LT5wYV9iYXNl
ID4+IGNtZHFfbWJveF9zaGlmdChjbC0+Y2hhbik7DQo+ICsJZXJyID0gY21kcV9wa3RfYXBwZW5k
X2NvbW1hbmQocGt0LCBpbnN0KTsNCg0KV2h5IG5vdCBqdXN0IGV4cG9ydCB0aGlzIGZ1bmN0aW9u
IGFzIGNtZHFfcGt0X2p1bXAoKT8gTGV0IGNsaWVudCBkZWNpZGUNCndoZXJlIHRvIGp1bXAgd291
bGQgYmUgbW9yZSBmbGV4aWJsZS4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKw0KPiArCXJldHVybiBl
cnI7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2ZpbmFsaXplX2xvb3ApOw0KPiAr
DQo+ICBzdGF0aWMgdm9pZCBjbWRxX3BrdF9mbHVzaF9hc3luY19jYihzdHJ1Y3QgY21kcV9jYl9k
YXRhIGRhdGEpDQo+ICB7DQo+ICAJc3RydWN0IGNtZHFfcGt0ICpwa3QgPSAoc3RydWN0IGNtZHFf
cGt0ICopZGF0YS5kYXRhOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4g
aW5kZXggOTk4YmM5MGY5ZGE5Li5kMTVkOGM5NDE5OTIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBAQCAtMjEyLDYgKzIxMiwxNCBAQCBpbnQgY21kcV9wa3Rf
YXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKTsNCj4g
ICAqLw0KPiAgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KTsNCj4g
IA0KPiArLyoqDQo+ICsgKiBjbWRxX3BrdF9maW5hbGl6ZV9sb29wKCkgLSBBcHBlbmQgRU9DIGFu
ZCBqdW1wIGNvbW1hbmQgdG8gbG9vcCBwa3QuDQo+ICsgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQN
Cj4gKyAqDQo+ICsgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUg
aXMgcmV0dXJuZWQNCj4gKyAqLw0KPiAraW50IGNtZHFfcGt0X2ZpbmFsaXplX2xvb3Aoc3RydWN0
IGNtZHFfcGt0ICpwa3QpOw0KPiArDQo+ICAvKioNCj4gICAqIGNtZHFfcGt0X2ZsdXNoX2FzeW5j
KCkgLSB0cmlnZ2VyIENNRFEgdG8gYXN5bmNocm9ub3VzbHkgZXhlY3V0ZSB0aGUgQ01EUQ0KPiAg
ICogICAgICAgICAgICAgICAgICAgICAgICAgIHBhY2tldCBhbmQgY2FsbCBiYWNrIGF0IHRoZSBl
bmQgb2YgZG9uZSBwYWNrZXQNCg0K

