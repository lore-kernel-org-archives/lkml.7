Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D67AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4D420708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nmy+/pn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKVIgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:36:14 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56471 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725999AbfKVIgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:36:14 -0500
X-UUID: d7c65cbccdee414eb642822e6c65f83a-20191122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5mcuvR7GVuvvJAZoBk6XztMBMMQ0zvdSu1TFanJSLNk=;
        b=nmy+/pn8l4Kcfhd8RYp6JthjhdETMQcgQNCJIZVwMPGQu/NafVeKF0vsPK6ItQ7B4HBA7Z3Opeiw+bXmnj3CSYIzMpf+kgbOCeQbkHTIbVt3C/guCAQfZK6AR8CTUYXnBRE4SmOFHHSb+MDhoHOh38e4nk7Z1XsER3iHaI06m1M=;
X-UUID: d7c65cbccdee414eb642822e6c65f83a-20191122
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1045903202; Fri, 22 Nov 2019 16:36:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 22 Nov 2019 16:36:04 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 22 Nov 2019 16:35:42 +0800
Message-ID: <1574411769.19450.7.camel@mtksdaap41>
Subject: Re: [PATCH v17 4/6] soc: mediatek: cmdq: add polling function
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
Date:   Fri, 22 Nov 2019 16:36:09 +0800
In-Reply-To: <20191121015410.18852-5-bibby.hsieh@mediatek.com>
References: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
         <20191121015410.18852-5-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBUaHUsIDIwMTktMTEtMjEgYXQgMDk6NTQgKzA4MDAsIEJpYmJ5IEhz
aWVoIHdyb3RlOg0KPiBhZGQgcG9sbGluZyBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlv
bnMNCj4gDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IFNp
Z25lZC1vZmYtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8IDM2ICsrKysr
KysrKysrKysrKysrKysrKysrKw0KPiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guaCB8ICAxICsNCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgg
ICAgfCAzMiArKysrKysrKysrKysrKysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNjkgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1j
bWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4g
aW5kZXggMTFiZmNjMTUwZWJkLi45MDk0ZmRhNWE4ZmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
c29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jDQo+IEBAIC0xMCw2ICsxMCw3IEBADQo+ICAjaW5jbHVkZSA8
bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmg+DQo+ICANCj4gICNkZWZpbmUgQ01EUV9XUklU
RV9FTkFCTEVfTUFTSwlCSVQoMCkNCj4gKyNkZWZpbmUgQ01EUV9QT0xMX0VOQUJMRV9NQVNLCUJJ
VCgwKQ0KPiAgI2RlZmluZSBDTURRX0VPQ19JUlFfRU4JCUJJVCgwKQ0KPiAgI2RlZmluZSBDTURR
X0VPQ19DTUQJCSgodTY0KSgoQ01EUV9DT0RFX0VPQyA8PCBDTURRX09QX0NPREVfU0hJRlQpKSBc
DQo+ICAJCQkJPDwgMzIgfCBDTURRX0VPQ19JUlFfRU4pDQo+IEBAIC0yMTQsNiArMjE1LDQxIEBA
IGludCBjbWRxX3BrdF9jbGVhcl9ldmVudChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50
KQ0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9jbGVhcl9ldmVudCk7DQo+ICANCj4g
K2ludCBjbWRxX3BrdF9wb2xsKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ICsJ
CSAgdTE2IG9mZnNldCwgdTMyIHZhbHVlKQ0KPiArew0KPiArCXN0cnVjdCBjbWRxX2luc3RydWN0
aW9uIGluc3QgPSB7IHswfSB9Ow0KPiArCWludCBlcnI7DQo+ICsNCj4gKwlpbnN0Lm9wID0gQ01E
UV9DT0RFX1BPTEw7DQo+ICsJaW5zdC52YWx1ZSA9IHZhbHVlOw0KPiArCWluc3Qub2Zmc2V0ID0g
b2Zmc2V0Ow0KPiArCWluc3Quc3Vic3lzID0gc3Vic3lzOw0KPiArCWVyciA9IGNtZHFfcGt0X2Fw
cGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ICsNCj4gKwlyZXR1cm4gZXJyOw0KPiArfQ0KPiAr
RVhQT1JUX1NZTUJPTChjbWRxX3BrdF9wb2xsKTsNCj4gKw0KPiAraW50IGNtZHFfcGt0X3BvbGxf
bWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiArCQkgICAgICAgdTE2IG9m
ZnNldCwgdTMyIHZhbHVlLCB1MzIgbWFzaykNCj4gK3sNCj4gKwlzdHJ1Y3QgY21kcV9pbnN0cnVj
dGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gKwlpbnQgZXJyOw0KPiArDQo+ICsJaW5zdC5vcCA9IENN
RFFfQ09ERV9NQVNLOw0KPiArCWluc3QubWFzayA9IH5tYXNrOw0KPiArCWVyciA9IGNtZHFfcGt0
X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ICsJaWYgKGVyciA8IDApDQo+ICsJCXJldHVy
biBlcnI7DQo+ICsNCj4gKwlvZmZzZXQgPSBvZmZzZXQgfCBDTURRX1BPTExfRU5BQkxFX01BU0s7
DQo+ICsJZXJyID0gY21kcV9wa3RfcG9sbChwa3QsIHN1YnN5cywgb2Zmc2V0LCB2YWx1ZSk7DQo+
ICsNCj4gKwlyZXR1cm4gZXJyOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9wb2xs
X21hc2spOw0KPiArDQo+ICBzdGF0aWMgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRx
X3BrdCAqcGt0KQ0KPiAgew0KPiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHsw
fSB9Ow0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gaW5kZXgg
Njc4NzYwNTQ4NzkxLi5hNGRjNDVmYmVjMGEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgv
bWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94
L210ay1jbWRxLW1haWxib3guaA0KPiBAQCAtNTUsNiArNTUsNyBAQA0KPiAgZW51bSBjbWRxX2Nv
ZGUgew0KPiAgCUNNRFFfQ09ERV9NQVNLID0gMHgwMiwNCj4gIAlDTURRX0NPREVfV1JJVEUgPSAw
eDA0LA0KPiArCUNNRFFfQ09ERV9QT0xMID0gMHgwOCwNCj4gIAlDTURRX0NPREVfSlVNUCA9IDB4
MTAsDQo+ICAJQ01EUV9DT0RFX1dGRSA9IDB4MjAsDQo+ICAJQ01EUV9DT0RFX0VPQyA9IDB4NDAs
DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBpbmRleCA5NjE4ZGViYjlj
ZWIuLjkyYmQ1YjVjNjM0MSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21k
cS5oDQo+IEBAIC05OSw2ICs5OSwzOCBAQCBpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3Br
dCAqcGt0LCB1MTYgZXZlbnQpOw0KPiAgICovDQo+ICBpbnQgY21kcV9wa3RfY2xlYXJfZXZlbnQo
c3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCk7DQo+ICANCj4gKy8qKg0KPiArICogY21k
cV9wa3RfcG9sbCgpIC0gQXBwZW5kIHBvbGxpbmcgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQs
IGFzayBHQ0UgdG8NCj4gKyAqCQkgICAgIGV4ZWN1dGUgYW4gaW5zdHJ1Y3Rpb24gdGhhdCB3YWl0
IGZvciBhIHNwZWNpZmllZA0KPiArICoJCSAgICAgaGFyZHdhcmUgcmVnaXN0ZXIgdG8gY2hlY2sg
Zm9yIHRoZSB2YWx1ZSB3L28gbWFzay4NCj4gKyAqCQkgICAgIEFsbCBHQ0UgaGFyZHdhcmUgdGhy
ZWFkcyB3aWxsIGJlIGJsb2NrZWQgYnkgdGhpcw0KPiArICoJCSAgICAgaW5zdHJ1Y3Rpb24uDQo+
ICsgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCj4gKyAqIEBzdWJzeXM6CXRoZSBDTURRIHN1YiBz
eXN0ZW0gY29kZQ0KPiArICogQG9mZnNldDoJcmVnaXN0ZXIgb2Zmc2V0IGZyb20gQ01EUSBzdWIg
c3lzdGVtDQo+ICsgKiBAdmFsdWU6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IHJlZ2lzdGVyIHZhbHVl
DQo+ICsgKg0KPiArICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2Rl
IGlzIHJldHVybmVkDQo+ICsgKi8NCj4gK2ludCBjbWRxX3BrdF9wb2xsKHN0cnVjdCBjbWRxX3Br
dCAqcGt0LCB1OCBzdWJzeXMsDQo+ICsJCSAgdTE2IG9mZnNldCwgdTMyIHZhbHVlKTsNCj4gKw0K
PiArLyoqDQo+ICsgKiBjbWRxX3BrdF9wb2xsX21hc2soKSAtIEFwcGVuZCBwb2xsaW5nIGNvbW1h
bmQgdG8gdGhlIENNRFEgcGFja2V0LCBhc2sgR0NFIHRvDQo+ICsgKgkJICAgICAgICAgIGV4ZWN1
dGUgYW4gaW5zdHJ1Y3Rpb24gdGhhdCB3YWl0IGZvciBhIHNwZWNpZmllZA0KPiArICoJCSAgICAg
ICAgICBoYXJkd2FyZSByZWdpc3RlciB0byBjaGVjayBmb3IgdGhlIHZhbHVlIHcvIG1hc2suDQo+
ICsgKgkJICAgICAgICAgIEFsbCBHQ0UgaGFyZHdhcmUgdGhyZWFkcyB3aWxsIGJlIGJsb2NrZWQg
YnkgdGhpcw0KPiArICoJCSAgICAgICAgICBpbnN0cnVjdGlvbi4NCj4gKyAqIEBwa3Q6CXRoZSBD
TURRIHBhY2tldA0KPiArICogQHN1YnN5czoJdGhlIENNRFEgc3ViIHN5c3RlbSBjb2RlDQo+ICsg
KiBAb2Zmc2V0OglyZWdpc3RlciBvZmZzZXQgZnJvbSBDTURRIHN1YiBzeXN0ZW0NCj4gKyAqIEB2
YWx1ZToJdGhlIHNwZWNpZmllZCB0YXJnZXQgcmVnaXN0ZXIgdmFsdWUNCj4gKyAqIEBtYXNrOgl0
aGUgc3BlY2lmaWVkIHRhcmdldCByZWdpc3RlciBtYXNrDQo+ICsgKg0KPiArICogUmV0dXJuOiAw
IGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ICsgKi8NCj4g
K2ludCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywN
Cj4gKwkJICAgICAgIHUxNiBvZmZzZXQsIHUzMiB2YWx1ZSwgdTMyIG1hc2spOw0KPiAgLyoqDQo+
ICAgKiBjbWRxX3BrdF9mbHVzaF9hc3luYygpIC0gdHJpZ2dlciBDTURRIHRvIGFzeW5jaHJvbm91
c2x5IGV4ZWN1dGUgdGhlIENNRFENCj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICBwYWNr
ZXQgYW5kIGNhbGwgYmFjayBhdCB0aGUgZW5kIG9mIGRvbmUgcGFja2V0DQoNCg==

