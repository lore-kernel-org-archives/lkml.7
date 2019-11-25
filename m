Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BDFC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 01:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A4D207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 01:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u9zngwTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfKYBfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 20:35:10 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56859 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727072AbfKYBfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 20:35:10 -0500
X-UUID: 109875d1632a427ba820bc611fca374b-20191125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=00LGHORmokkPoPcNjJ+Zddp+9DEjWWvNVgNl7wIE5SU=;
        b=u9zngwTiGqJDzn9Jqh1cHN4GjJi2HkH+KJ7qebZcuLj/yLdIocL381vBiZkadMpKGg3oPbs+63qcw7oMNG/aObspgd/15YhurVLq5AktrI8Q3VKQBdMXc6eswaJJf2da8ujndfdk+TXTgX6/5q3CCqSwdSsBUXh/pKifEFHIAVU=;
X-UUID: 109875d1632a427ba820bc611fca374b-20191125
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1326527061; Mon, 25 Nov 2019 09:35:04 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 25 Nov 2019 09:34:55 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Nov 2019 09:35:30 +0800
Message-ID: <1574645703.4712.7.camel@mtksdaap41>
Subject: Re: [PATCH v1 10/12] soc: mediatek: cmdq: add loop function
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 25 Nov 2019 09:35:03 +0800
In-Reply-To: <1574418540.11977.19.camel@mtkswgap22>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574327552-11806-11-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574415960.19450.23.camel@mtksdaap41>
         <1574418540.11977.19.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gRnJpLCAyMDE5LTExLTIyIGF0IDE4OjI5ICswODAwLCBEZW5uaXMt
WUMgSHNpZWggd3JvdGU6DQo+IEhpIENLLA0KPiANCj4gT24gRnJpLCAyMDE5LTExLTIyIGF0IDE3
OjQ2ICswODAwLCBDSyBIdSB3cm90ZToNCj4gPiBIaSwgRGVubmlzOg0KPiA+IA0KPiA+IE9uIFRo
dSwgMjAxOS0xMS0yMSBhdCAxNzoxMiArMDgwMCwgRGVubmlzIFlDIEhzaWVoIHdyb3RlOg0KPiA+
ID4gQWRkIGZpbmFsaXplIGxvb3AgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdo
aWNoIGxvb3Agd2hvbGUgcGt0DQo+ID4gPiBpbiBnY2UgaGFyZHdhcmUgdGhyZWFkIHdpdGhvdXQg
Y3B1IG9wZXJhdGlvbi4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhz
aWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgfCAgIDQxICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gPiAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaCAgfCAgICA4ICsrKysrKysNCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQ5IGluc2Vy
dGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCj4gPiA+IGluZGV4IDQyMzVjZjguLjNiMTAyNDEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiA+IEBAIC0zODUsMTIgKzM4NSwyNyBA
QCBpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwg
dTMyIHZhbHVlKQ0KPiA+ID4gIH0NCj4gPiA+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2ln
bik7DQo+ID4gPiAgDQo+ID4gPiArc3RhdGljIGJvb2wgY21kcV9wa3RfZmluYWxpemVkKHN0cnVj
dCBjbWRxX3BrdCAqcGt0KQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rp
b24gKmluc3Q7DQo+ID4gPiArDQo+ID4gPiArCWlmIChwa3QtPmNtZF9idWZfc2l6ZSA8IDIgKiBD
TURRX0lOU1RfU0laRSkNCj4gPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiA+ICsNCj4gPiA+ICsJ
aW5zdCA9IHBrdC0+dmFfYmFzZSArIHBrdC0+Y21kX2J1Zl9zaXplIC0gMiAqIENNRFFfSU5TVF9T
SVpFOw0KPiA+ID4gKwlyZXR1cm4gaW5zdC0+b3AgPT0gQ01EUV9DT0RFX0VPQzsNCj4gPiA+ICt9
DQo+ID4gPiArDQo+ID4gPiAgc3RhdGljIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21k
cV9wa3QgKnBrdCkNCj4gPiA+ICB7DQo+ID4gPiAgCXN0cnVjdCBjbWRxX2NsaWVudCAqY2wgPSBw
a3QtPmNsOw0KPiA+ID4gIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsN
Cj4gPiA+ICAJaW50IGVycjsNCj4gPiA+ICANCj4gPiA+ICsJLyogZG8gbm90IGZpbmFsaXplIHR3
aWNlICovDQo+ID4gPiArCWlmIChjbWRxX3BrdF9maW5hbGl6ZWQocGt0KSkNCj4gPiA+ICsJCXJl
dHVybiAwOw0KPiA+ID4gKw0KPiA+ID4gIAkvKiBpbnNlcnQgRU9DIGFuZCBnZW5lcmF0ZSBJUlEg
Zm9yIGVhY2ggY29tbWFuZCBpdGVyYXRpb24gKi8NCj4gPiA+ICAJaW5zdC5vcCA9IENNRFFfQ09E
RV9FT0M7DQo+ID4gPiAgCWluc3QudmFsdWUgPSBDTURRX0VPQ19JUlFfRU47DQo+ID4gPiBAQCAt
NDA2LDYgKzQyMSwzMiBAQCBzdGF0aWMgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRx
X3BrdCAqcGt0KQ0KPiA+ID4gIAlyZXR1cm4gZXJyOw0KPiA+ID4gIH0NCj4gPiA+ICANCj4gPiA+
ICtpbnQgY21kcV9wa3RfZmluYWxpemVfbG9vcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCkNCj4gPiA+
ICt7DQo+ID4gPiArCXN0cnVjdCBjbWRxX2NsaWVudCAqY2wgPSBwa3QtPmNsOw0KPiA+ID4gKwlz
dHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiA+ICsJaW50IGVycjsN
Cj4gPiA+ICsNCj4gPiA+ICsJLyogZG8gbm90IGZpbmFsaXplIHR3aWNlICovDQo+ID4gPiArCWlm
IChjbWRxX3BrdF9maW5hbGl6ZWQocGt0KSkNCj4gPiA+ICsJCXJldHVybiAwOw0KPiA+IA0KPiA+
IFdoeSBub3QganVzdCBleHBvcnQgY21kcV9wa3RfZmluYWxpemUoKSBmb3IgdXNlciBhbmQgZG8g
bm90IGNhbGwNCj4gPiBjbWRxX3BrdF9maW5hbGl6ZSgpIGluIGNtZHFfcGt0X2ZsdXNoX2FzeW5j
KCksIHNvIHlvdSBkb24ndCBuZWVkIHRvDQo+ID4gY2hlY2sgdGhpcy4NCj4gPiANCj4gPiBJIHdv
dWxkIGJlIG1vcmUgbGlrZSB0byBleHBvcnQgQVBJIHN1Y2ggYXMgY21kcV9wa3RfZW9jKCksDQo+
ID4gY21kcV9wa3RfanVtcCgpLCB0aGlzIHdvdWxkIHByb3ZpZGUgbW9yZSBmbGV4aWJpbGl0eSBm
b3IgdXNlciB0bw0KPiA+IGFzc2VtYmxlIHRoZSBjb21tYW5kIGl0IHdhbnQuDQo+ID4gDQo+ID4g
UmVnYXJkcywNCj4gPiBDSw0KPiANCj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuDQo+IA0KPiBT
aG91bGQgd2UgYmFja3dhcmQgY29tcGF0aWJsZSB3aXRoIGV4aXN0aW5nIGNsaWVudHM/IFJlbW92
ZSBmaW5hbGl6ZSBpbg0KPiBmbHVzaCB3aWxsIGNhdXNlIGV4aXN0aW5nIGNsaWVudCBmbHVzaCB3
aXRob3V0IElSUS4NCg0KVGhlIGxhdGVzdCBrZXJuZWwgKHY1LjQtcmM4KSBzdGlsbCBoYXMgbm8g
Y2xpZW50cyB3aGljaCB1c2UgY21kcSBsYW5kZWQNCm9uIHVwc3RyZWFtLCBhbmQgd2UgZG9uJ3Qg
bmVlZCB0byBjb25zaWRlciBiYWNrd2FyZCBjb21wYXRpYmxlLiBbMV0gaXMNCnRoZSBleGFtcGxl
IHRoYXQgaW9tbXUgd291bGQgcmVwbGFjZSB0aGUgcHJvcHJpZXRhcnkgaW50ZXJmYWNlIHdpdGgN
CnN0YW5kYXJkIGludGVyZmFjZSwgc28gaXQgd291bGQgbW9kaWZ5IGFsbCBjbGllbnRzIHdoaWNo
IHVzZSB0aGUNCnByb3ByaWV0YXJ5IGludGVyZmFjZS4gU28gd2hhdCB5b3Ugc2hvdWxkIGRvIGlz
IHRvIG1vZGlmeSBjbGllbnQgYXMNCndlbGwuDQoNClsxXQ0KaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0xNjg4MDENCg0KUmVn
YXJkcywNCkNLDQoNCj4gDQo+IA0KPiBSZWdhcmRzLA0KPiBEZW5uaXMNCj4gDQo+ID4gDQo+ID4g
PiArDQo+ID4gPiArCS8qIGluc2VydCBFT0MgYW5kIGdlbmVyYXRlIElSUSBmb3IgZWFjaCBjb21t
YW5kIGl0ZXJhdGlvbiAqLw0KPiA+ID4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX0VPQzsNCj4gPiA+
ICsJZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiA+ICsJaWYg
KGVyciA8IDApDQo+ID4gPiArCQlyZXR1cm4gZXJyOw0KPiA+ID4gKw0KPiA+ID4gKwkvKiBKVU1Q
IGFiYW9sdXRlIHRvIGJlZ2luICovDQo+ID4gPiArCWluc3Qub3AgPSBDTURRX0NPREVfSlVNUDsN
Cj4gPiA+ICsJaW5zdC5vZmZzZXQgPSAxOw0KPiA+ID4gKwlpbnN0LnZhbHVlID0gcGt0LT5wYV9i
YXNlID4+IGNtZHFfbWJveF9zaGlmdChjbC0+Y2hhbik7DQo+ID4gPiArCWVyciA9IGNtZHFfcGt0
X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiBlcnI7
DQo+ID4gPiArfQ0KPiA+ID4gK0VYUE9SVF9TWU1CT0woY21kcV9wa3RfZmluYWxpemVfbG9vcCk7
DQo+ID4gPiArDQo+ID4gPiAgc3RhdGljIHZvaWQgY21kcV9wa3RfZmx1c2hfYXN5bmNfY2Ioc3Ry
dWN0IGNtZHFfY2JfZGF0YSBkYXRhKQ0KPiA+ID4gIHsNCj4gPiA+ICAJc3RydWN0IGNtZHFfcGt0
ICpwa3QgPSAoc3RydWN0IGNtZHFfcGt0ICopZGF0YS5kYXRhOw0KPiA+ID4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gPiBpbmRleCBiMzQ3NGYyLi43N2U4OTQ0IDEwMDY0
NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+
ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+ID4gQEAg
LTIwMyw2ICsyMDMsMTQgQEAgaW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCwgdTggc3Vic3lzLA0KPiA+ID4gIGludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpOw0KPiA+ID4gIA0KPiA+ID4gIC8qKg0K
PiA+ID4gKyAqIGNtZHFfcGt0X2ZpbmFsaXplX2xvb3AoKSAtIEFwcGVuZCBFT0MgYW5kIGp1bXAg
Y29tbWFuZCB0byBsb29wIHBrdC4NCj4gPiA+ICsgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCj4g
PiA+ICsgKg0KPiA+ID4gKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3Ig
Y29kZSBpcyByZXR1cm5lZA0KPiA+ID4gKyAqLw0KPiA+ID4gK2ludCBjbWRxX3BrdF9maW5hbGl6
ZV9sb29wKHN0cnVjdCBjbWRxX3BrdCAqcGt0KTsNCj4gPiA+ICsNCj4gPiA+ICsvKioNCj4gPiA+
ICAgKiBjbWRxX3BrdF9mbHVzaF9hc3luYygpIC0gdHJpZ2dlciBDTURRIHRvIGFzeW5jaHJvbm91
c2x5IGV4ZWN1dGUgdGhlIENNRFENCj4gPiA+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAg
cGFja2V0IGFuZCBjYWxsIGJhY2sgYXQgdGhlIGVuZCBvZiBkb25lIHBhY2tldA0KPiA+ID4gICAq
IEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiA+IA0KPiA+IA0KPiANCj4gDQoNCg==

