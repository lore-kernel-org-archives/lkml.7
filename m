Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636F9C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F75E208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Zo5ksowD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfLLBcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:32:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56734 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727409AbfLLBcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:32:05 -0500
X-UUID: 4668d23a93624f75a55c9da384b7b2b0-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=nK2R9M4vgOMADfue/0FK/jrldLeO7zeckYA8kNQqoWM=;
        b=Zo5ksowDXa/rz9ggFN02MMM6FWU4+Q82Nx7N53yJzQpK6zdsYT4G1QEllbXno70fW9S5FnktnNVk1FBa3AeCWCtfuyqL5uoAS+OMqC7olxA6gbDqPEjfopAdoyq8RAQ1NuHtD3lhqUIhp/dXM3ZuMZrJOOqzDKBMGMbpQt0tdTk=;
X-UUID: 4668d23a93624f75a55c9da384b7b2b0-20191212
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2075683752; Thu, 12 Dec 2019 09:32:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 09:31:40 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 09:31:55 +0800
Message-ID: <1576114319.17653.10.camel@mtkswgap22>
Subject: Re: [PATCH v2 08/14] soc: mediatek: cmdq: add write_s function
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 12 Dec 2019 09:31:59 +0800
In-Reply-To: <1575963305.31101.0.camel@mtksdaap41>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-10-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1575963305.31101.0.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmliYnksDQoNCnRoYW5rcyBmb3IgeW91ciBjb21tZW50DQoNCk9uIFR1ZSwgMjAxOS0xMi0x
MCBhdCAxNTozNSArMDgwMCwgQmliYnkgSHNpZWggd3JvdGU6DQo+IE9uIFdlZCwgMjAxOS0xMS0y
NyBhdCAwOTo1OCArMDgwMCwgRGVubmlzIFlDIEhzaWVoIHdyb3RlOg0KPiA+IGFkZCB3cml0ZV9z
IGZ1bmN0aW9uIGluIGNtZHEgaGVscGVyIGZ1bmN0aW9ucyB3aGljaA0KPiA+IHdyaXRlcyB2YWx1
ZSBjb250YWlucyBpbiBpbnRlcm5hbCByZWdpc3RlciB0byBhZGRyZXNzDQo+ID4gd2l0aCBsYXJn
ZSBkbWEgYWNjZXNzIHN1cHBvcnQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRGVubmlzIFlD
IEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwgNDAgKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94Lmgg
fCAgMiArKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwg
MTIgKysrKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKykNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMg
Yi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IGluZGV4IDljYzIz
NGYwOGVjNS4uMmVkYmMwOTU0ZDk3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEtaGVscGVyLmMNCj4gPiBAQCAtMTUsMTEgKzE1LDE4IEBADQo+ID4gICNkZWZpbmUgQ01E
UV9FT0NfQ01ECQkoKHU2NCkoKENNRFFfQ09ERV9FT0MgPDwgQ01EUV9PUF9DT0RFX1NISUZUKSkg
XA0KPiA+ICAJCQkJPDwgMzIgfCBDTURRX0VPQ19JUlFfRU4pDQo+ID4gICNkZWZpbmUgQ01EUV9S
RUdfVFlQRQkJMQ0KPiA+ICsjZGVmaW5lIENNRFFfQUREUl9ISUdIKGFkZHIpCSgodTMyKSgoKGFk
ZHIpID4+IDE2KSAmIEdFTk1BU0soMzEsIDApKSkNCj4gPiArI2RlZmluZSBDTURRX0FERFJfTE9X
X0JJVAlCSVQoMSkNCj4gPiArI2RlZmluZSBDTURRX0FERFJfTE9XKGFkZHIpCSgodTE2KShhZGRy
KSB8IENNRFFfQUREUl9MT1dfQklUKQ0KPiA+ICANCj4gPiAgc3RydWN0IGNtZHFfaW5zdHJ1Y3Rp
b24gew0KPiA+ICAJdW5pb24gew0KPiA+ICAJCXUzMiB2YWx1ZTsNCj4gPiAgCQl1MzIgbWFzazsN
Cj4gPiArCQlzdHJ1Y3Qgew0KPiA+ICsJCQl1MTYgYXJnX2M7DQo+ID4gKwkJCXUxNiBhcmdfYjsN
Cj4gPiArCQl9Ow0KPiA+ICAJfTsNCj4gPiAgCXVuaW9uIHsNCj4gPiAgCQl1MTYgb2Zmc2V0Ow0K
PiA+IEBAIC0yMjQsNiArMjMxLDM5IEBAIGludCBjbWRxX3BrdF93cml0ZV9tYXNrKHN0cnVjdCBj
bWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTChjbWRx
X3BrdF93cml0ZV9tYXNrKTsNCj4gPiAgDQo+ID4gK2ludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVj
dCBjbWRxX3BrdCAqcGt0LCBwaHlzX2FkZHJfdCBhZGRyLCB1MTYgcmVnX2lkeCwNCj4gPiArCQkg
ICAgIHUzMiBtYXNrKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0
ID0geyB7MH0gfTsNCj4gPiArCWNvbnN0IHUxNiBkc3RfcmVnX2lkeCA9IENNRFFfU1BSX1RFTVA7
DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCWlmIChtYXNrICE9IFUzMl9NQVgpIHsNCj4g
PiArCQlpbnN0Lm9wID0gQ01EUV9DT0RFX01BU0s7DQo+ID4gKwkJaW5zdC5tYXNrID0gfm1hc2s7
DQo+ID4gKwkJZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiAr
CQlpZiAoZXJyIDwgMCkNCj4gPiArCQkJcmV0dXJuIGVycjsNCj4gPiArDQo+ID4gKwkJaW5zdC5t
YXNrID0gMDsNCj4gPiArCQlpbnN0Lm9wID0gQ01EUV9DT0RFX1dSSVRFX1NfTUFTSzsNCj4gPiAr
CX0gZWxzZSB7DQo+ID4gKwkJaW5zdC5vcCA9IENNRFFfQ09ERV9XUklURV9TOw0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiArCWVyciA9IGNtZHFfcGt0X2Fzc2lnbihwa3QsIGRzdF9yZWdfaWR4LCBDTURR
X0FERFJfSElHSChhZGRyKSk7DQo+ID4gKwlpZiAoZXJyIDwgMCkNCj4gPiArCQlyZXR1cm4gZXJy
Ow0KPiA+ICsNCj4gPiArCWluc3QuYXJnX2JfdCA9IENNRFFfUkVHX1RZUEU7DQo+ID4gKwlpbnN0
LnNvcCA9IGRzdF9yZWdfaWR4Ow0KPiA+ICsJaW5zdC5vZmZzZXQgPSBDTURRX0FERFJfTE9XKGFk
ZHIpOw0KPiA+ICsJaW5zdC5hcmdfYiA9IHJlZ19pZHg7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGNt
ZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZ
TUJPTChjbWRxX3BrdF93cml0ZV9zKTsNCj4gPiArDQo+ID4gIGludCBjbWRxX3BrdF93ZmUoc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCj4gPiAgew0KPiA+ICAJc3RydWN0IGNtZHFf
aW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5oDQo+ID4gaW5kZXggMTIxYzNiYjZkM2RlLi44ZWY4N2UxYmQwM2IgMTAw
NjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0K
PiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gPiBA
QCAtNTksNiArNTksOCBAQCBlbnVtIGNtZHFfY29kZSB7DQo+ID4gIAlDTURRX0NPREVfSlVNUCA9
IDB4MTAsDQo+ID4gIAlDTURRX0NPREVfV0ZFID0gMHgyMCwNCj4gPiAgCUNNRFFfQ09ERV9FT0Mg
PSAweDQwLA0KPiA+ICsJQ01EUV9DT0RFX1dSSVRFX1MgPSAweDkwLA0KPiA+ICsJQ01EUV9DT0RF
X1dSSVRFX1NfTUFTSyA9IDB4OTEsDQo+ID4gIAlDTURRX0NPREVfTE9HSUMgPSAweGEwLA0KPiA+
ICB9Ow0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBp
bmRleCBjNjZiM2EwZGEyYTIuLjU2ZmYxOTcwMTk3YyAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IEBAIC0xMDYsNiArMTA2LDE4IEBAIGludCBjbWRx
X3BrdF93cml0ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLCB1MTYgb2Zmc2V0LCB1
MzIgdmFsdWUpOw0KPiA+ICBpbnQgY21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCwgdTggc3Vic3lzLA0KPiA+ICAJCQl1MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNr
KTsNCj4gPiAgDQo+ID4gKy8qKg0KPiA+ICsgKiBjbWRxX3BrdF93cml0ZV9zX21hc2soKSAtIGFw
cGVuZCB3cml0ZV9zIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQo+IEkgdGhpbmsgd2UgbmVl
ZCBhZGQgbW9yZSBkZXNjcmlwdGlvbnMgYWJvdXQgZGlmZmVyZW5jZSBiZXR3ZWVuIHdyaXRlLg0K
PiANCj4gQmliYnkNCg0Kb2ssIHdpbGwgY2hhbmdlDQoNCg0KUmVnYXJkcywNCkRlbm5pcw0KDQo+
ID4gKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiA+ICsgKiBAYWRkcjoJdGhlIHBoeXNpY2Fs
IGFkZHJlc3Mgb2YgcmVnaXN0ZXIgb3IgZG1hDQo+ID4gKyAqIEByZWdfaWR4Ogl0aGUgQ01EUSBp
bnRlcm5hbCByZWdpc3RlciBJRCB3aGljaCBjYWNoZSBzb3VyY2UgdmFsdWUNCj4gPiArICogQG1h
c2s6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IHJlZ2lzdGVyIG1hc2sNCj4gPiArICoNCj4gPiArICog
UmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+
ID4gKyAqLw0KPiA+ICtpbnQgY21kcV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
cGh5c19hZGRyX3QgYWRkciwgdTE2IHJlZ19pZHgsDQo+ID4gKwkJICAgICB1MzIgbWFzayk7DQo+
ID4gKw0KPiA+ICAvKioNCj4gPiAgICogY21kcV9wa3Rfd2ZlKCkgLSBhcHBlbmQgd2FpdCBmb3Ig
ZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gPiAgICogQHBrdDoJdGhlIENNRFEg
cGFja2V0DQo+IA0KPiANCg0K

