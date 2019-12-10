Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129C1C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC36A20836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QTLKkzN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfLJDYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:24:22 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:15293 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726619AbfLJDYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:24:21 -0500
X-UUID: 8216b702f0474a769ccc7fd844c488fe-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=N2521TvN7lGfbMtCwquz/uaxFLQnHeWy5RUtdl0dTwM=;
        b=QTLKkzN1s1QAbU82SxZhyEb1RMZB1gojbsBr3Ns6L9ViA560aiskVJcXvGpIOXE/1k6Pmg7ZcaBXCcxgE7mDjlMXObUMZgwisn3FIP47BT91bQomth+zaqfsacXgW17xfP84W+ld67EDpf7AJrO7vFDe2Ic64QQafFHoFiB+zjY=;
X-UUID: 8216b702f0474a769ccc7fd844c488fe-20191210
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 435904122; Tue, 10 Dec 2019 11:24:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 11:23:44 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 11:23:35 +0800
Message-ID: <1575948247.9195.0.camel@mtksdaap41>
Subject: Re: [PATCH v2 07/14] soc: mediatek: cmdq: add assign function
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
Date:   Tue, 10 Dec 2019 11:24:07 +0800
In-Reply-To: <1574819937-6246-9-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-9-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gV2VkLCAyMDE5LTExLTI3IGF0IDA5OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCBhc3NpZ24gZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgd2hp
Y2ggYXNzaWduIGNvbnN0YW50IHZhbHVlIGludG8NCj4gaW50ZXJuYWwgcmVnaXN0ZXIgYnkgaW5k
ZXguDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2ll
aEBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEt
aGVscGVyLmMgICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgaW5jbHVkZS9saW51
eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8ICAxICsNCj4gIGluY2x1ZGUvbGludXgvc29j
L21lZGlhdGVrL210ay1jbWRxLmggICAgfCAxOCArKysrKysrKysrKysrKysrKysNCj4gIDMgZmls
ZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gaW5kZXggODQyMWI0MDkwMzA0Li45Y2My
MzRmMDhlYzUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+
IEBAIC0xNCw2ICsxNCw3IEBADQo+ICAjZGVmaW5lIENNRFFfRU9DX0lSUV9FTgkJQklUKDApDQo+
ICAjZGVmaW5lIENNRFFfRU9DX0NNRAkJKCh1NjQpKChDTURRX0NPREVfRU9DIDw8IENNRFFfT1Bf
Q09ERV9TSElGVCkpIFwNCj4gIAkJCQk8PCAzMiB8IENNRFFfRU9DX0lSUV9FTikNCj4gKyNkZWZp
bmUgQ01EUV9SRUdfVFlQRQkJMQ0KPiAgDQo+ICBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQo+
ICAJdW5pb24gew0KPiBAQCAtMjMsOCArMjQsMTcgQEAgc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24g
ew0KPiAgCXVuaW9uIHsNCj4gIAkJdTE2IG9mZnNldDsNCj4gIAkJdTE2IGV2ZW50Ow0KPiArCQl1
MTYgcmVnX2RzdDsNCj4gKwl9Ow0KPiArCXVuaW9uIHsNCj4gKwkJdTggc3Vic3lzOw0KPiArCQlz
dHJ1Y3Qgew0KPiArCQkJdTggc29wOjU7DQo+ICsJCQl1OCBhcmdfY190OjE7DQo+ICsJCQl1OCBh
cmdfYl90OjE7DQo+ICsJCQl1OCBkc3RfdDoxOw0KPiArCQl9Ow0KPiAgCX07DQo+IC0JdTggc3Vi
c3lzOw0KPiAgCXU4IG9wOw0KPiAgfTsNCj4gIA0KPiBAQCAtMjc5LDYgKzI4OSwxOCBAQCBpbnQg
Y21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ICB9
DQo+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3BvbGxfbWFzayk7DQo+ICANCj4gK2ludCBjbWRx
X3BrdF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUp
DQo+ICt7DQo+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ICsN
Cj4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX0xPR0lDOw0KPiArCWluc3QuZHN0X3QgPSBDTURRX1JF
R19UWVBFOw0KPiArCWluc3QucmVnX2RzdCA9IHJlZ19pZHg7DQo+ICsJaW5zdC52YWx1ZSA9IHZh
bHVlOw0KPiArCXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiAr
fQ0KPiArRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9hc3NpZ24pOw0KPiArDQo+ICBzdGF0aWMgaW50
IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiAgew0KPiAgCXN0cnVj
dCBjbWRxX2NsaWVudCAqY2wgPSBwa3QtPmNsOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGst
Y21kcS1tYWlsYm94LmgNCj4gaW5kZXggZGZlNWIyZWI4NWNjLi4xMjFjM2JiNmQzZGUgMTAwNjQ0
DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gKysr
IGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiBAQCAtNTksNiAr
NTksNyBAQCBlbnVtIGNtZHFfY29kZSB7DQo+ICAJQ01EUV9DT0RFX0pVTVAgPSAweDEwLA0KPiAg
CUNNRFFfQ09ERV9XRkUgPSAweDIwLA0KPiAgCUNNRFFfQ09ERV9FT0MgPSAweDQwLA0KPiArCUNN
RFFfQ09ERV9MT0dJQyA9IDB4YTAsDQo+ICB9Ow0KPiAgDQo+ICBlbnVtIGNtZHFfY2Jfc3RhdHVz
IHsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgg
Yi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+IGluZGV4IGE3NGMxZDVh
Y2RmMy4uYzY2YjNhMGRhMmEyIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmgNCj4gQEAgLTEyLDYgKzEyLDEwIEBADQo+ICAjaW5jbHVkZSA8bGludXgvdGltZXIuaD4N
Cj4gIA0KPiAgI2RlZmluZSBDTURRX05PX1RJTUVPVVQJCTB4ZmZmZmZmZmZ1DQo+ICsjZGVmaW5l
IENNRFFfU1BSX1RFTVAJCTANCj4gKyNkZWZpbmUgQ01EUV9TUFIxCQkxDQo+ICsjZGVmaW5lIENN
RFFfU1BSMgkJMg0KPiArI2RlZmluZSBDTURRX1NQUjMJCTMNCg0KVGhlc2UgZG9lcyBub3QgcmVs
YXRlIHRvIGFzc2lnbiBmdW5jdGlvbiwgc28gcmVtb3ZlIHRoZW0uDQoNClJlZ2FyZHMsDQpDSw0K
DQo+ICANCj4gIHN0cnVjdCBjbWRxX3BrdDsNCj4gIA0KPiBAQCAtMTUyLDYgKzE1NiwyMCBAQCBp
bnQgY21kcV9wa3RfcG9sbChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiAgICov
DQo+ICBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJz
eXMsDQo+ICAJCSAgICAgICB1MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCj4gKw0K
PiArLyoqDQo+ICsgKiBjbWRxX3BrdF9hc3NpZ24oKSAtIEFwcGVuZCBsb2dpYyBhc3NpZ24gY29t
bWFuZCB0byB0aGUgQ01EUSBwYWNrZXQsIGFzayBHQ0UNCj4gKyAqCQkgICAgICAgdG8gZXhlY3V0
ZSBhbiBpbnN0cnVjdGlvbiB0aGF0IHNldCBhIGNvbnN0YW50IHZhbHVlIGludG8NCj4gKyAqCQkg
ICAgICAgaW50ZXJuYWwgcmVnaXN0ZXIgYW5kIHVzZSBhcyB2YWx1ZSwgbWFzayBvciBhZGRyZXNz
IGluDQo+ICsgKgkJICAgICAgIHJlYWQvd3JpdGUgaW5zdHJ1Y3Rpb24uDQo+ICsgKiBAcGt0Ogl0
aGUgQ01EUSBwYWNrZXQNCj4gKyAqIEByZWdfaWR4Ogl0aGUgQ01EUSBpbnRlcm5hbCByZWdpc3Rl
ciBJRA0KPiArICogQHZhbHVlOgl0aGUgc3BlY2lmaWVkIHZhbHVlDQo+ICsgKg0KPiArICogUmV0
dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ICsg
Ki8NCj4gK2ludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdf
aWR4LCB1MzIgdmFsdWUpOw0KPiArDQo+ICAvKioNCj4gICAqIGNtZHFfcGt0X2ZsdXNoX2FzeW5j
KCkgLSB0cmlnZ2VyIENNRFEgdG8gYXN5bmNocm9ub3VzbHkgZXhlY3V0ZSB0aGUgQ01EUQ0KPiAg
ICogICAgICAgICAgICAgICAgICAgICAgICAgIHBhY2tldCBhbmQgY2FsbCBiYWNrIGF0IHRoZSBl
bmQgb2YgZG9uZSBwYWNrZXQNCg0K

