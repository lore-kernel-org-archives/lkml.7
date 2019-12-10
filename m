Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C456EC2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860EF206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qyd8Ajmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfLJFSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 00:18:32 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60003 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725962AbfLJFSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 00:18:32 -0500
X-UUID: 1a45ddfda67644daa0b60742d67ad7c5-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=U5dn9iiS6Lkny5IY/aF5ZMW3uyg18odEyEQls0K5nvY=;
        b=qyd8AjmdbjWrwWMz26LJC1Y0teT8iupvnBZhwcdqezVOyapKuZ6JuPGHwB5lJ6OCUd0ND2MzXmjqO1/6kcSU3SRRJ6PcUlVmsYdtA9CaZw8+Te+6SFz7r7vCKWlNTVGA+RerLfZYQ9QrGmO727OeofMwRSW3msB5i1qnXiESX+U=;
X-UUID: 1a45ddfda67644daa0b60742d67ad7c5-20191210
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2041595387; Tue, 10 Dec 2019 13:18:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 13:17:28 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 13:18:28 +0800
Message-ID: <1575955103.31262.10.camel@mtksdaap41>
Subject: Re: [PATCH v2 08/14] soc: mediatek: cmdq: add write_s function
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
Date:   Tue, 10 Dec 2019 13:18:23 +0800
In-Reply-To: <1574819937-6246-10-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-10-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 19114C2D8273052152C91583BBC66896FDADFDC8BD073E8DD6DB629FEDD384B22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gV2VkLCAyMDE5LTExLTI3IGF0IDA5OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IGFkZCB3cml0ZV9zIGZ1bmN0aW9uIGluIGNtZHEgaGVscGVyIGZ1
bmN0aW9ucyB3aGljaA0KPiB3cml0ZXMgdmFsdWUgY29udGFpbnMgaW4gaW50ZXJuYWwgcmVnaXN0
ZXIgdG8gYWRkcmVzcw0KPiB3aXRoIGxhcmdlIGRtYSBhY2Nlc3Mgc3VwcG9ydC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNv
bT4NCj4gLS0tDQo+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwg
NDAgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5oIHwgIDIgKysNCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
ay1jbWRxLmggICAgfCAxMiArKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGluZGV4
IDljYzIzNGYwOGVjNS4uMmVkYmMwOTU0ZDk3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstY21kcS1oZWxwZXIuYw0KPiBAQCAtMTUsMTEgKzE1LDE4IEBADQo+ICAjZGVmaW5lIENNRFFf
RU9DX0NNRAkJKCh1NjQpKChDTURRX0NPREVfRU9DIDw8IENNRFFfT1BfQ09ERV9TSElGVCkpIFwN
Cj4gIAkJCQk8PCAzMiB8IENNRFFfRU9DX0lSUV9FTikNCj4gICNkZWZpbmUgQ01EUV9SRUdfVFlQ
RQkJMQ0KPiArI2RlZmluZSBDTURRX0FERFJfSElHSChhZGRyKQkoKHUzMikoKChhZGRyKSA+PiAx
NikgJiBHRU5NQVNLKDMxLCAwKSkpDQo+ICsjZGVmaW5lIENNRFFfQUREUl9MT1dfQklUCUJJVCgx
KQ0KPiArI2RlZmluZSBDTURRX0FERFJfTE9XKGFkZHIpCSgodTE2KShhZGRyKSB8IENNRFFfQURE
Ul9MT1dfQklUKQ0KPiAgDQo+ICBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQo+ICAJdW5pb24g
ew0KPiAgCQl1MzIgdmFsdWU7DQo+ICAJCXUzMiBtYXNrOw0KPiArCQlzdHJ1Y3Qgew0KPiArCQkJ
dTE2IGFyZ19jOw0KPiArCQkJdTE2IGFyZ19iOw0KPiArCQl9Ow0KPiAgCX07DQo+ICAJdW5pb24g
ew0KPiAgCQl1MTYgb2Zmc2V0Ow0KPiBAQCAtMjI0LDYgKzIzMSwzOSBAQCBpbnQgY21kcV9wa3Rf
d3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiAgfQ0KPiAgRVhQ
T1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9tYXNrKTsNCj4gIA0KPiAraW50IGNtZHFfcGt0X3dy
aXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHBoeXNfYWRkcl90IGFkZHIsIHUxNiByZWdfaWR4
LA0KPiArCQkgICAgIHUzMiBtYXNrKQ0KPiArew0KPiArCXN0cnVjdCBjbWRxX2luc3RydWN0aW9u
IGluc3QgPSB7IHswfSB9Ow0KPiArCWNvbnN0IHUxNiBkc3RfcmVnX2lkeCA9IENNRFFfU1BSX1RF
TVA7DQo+ICsJaW50IGVycjsNCj4gKw0KPiArCWlmIChtYXNrICE9IFUzMl9NQVgpIHsNCj4gKwkJ
aW5zdC5vcCA9IENNRFFfQ09ERV9NQVNLOw0KPiArCQlpbnN0Lm1hc2sgPSB+bWFzazsNCj4gKwkJ
ZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gKwkJaWYgKGVyciA8
IDApDQo+ICsJCQlyZXR1cm4gZXJyOw0KPiArDQo+ICsJCWluc3QubWFzayA9IDA7DQo+ICsJCWlu
c3Qub3AgPSBDTURRX0NPREVfV1JJVEVfU19NQVNLOw0KPiArCX0gZWxzZSB7DQo+ICsJCWluc3Qu
b3AgPSBDTURRX0NPREVfV1JJVEVfUzsNCj4gKwl9DQo+ICsNCj4gKwllcnIgPSBjbWRxX3BrdF9h
c3NpZ24ocGt0LCBkc3RfcmVnX2lkeCwgQ01EUV9BRERSX0hJR0goYWRkcikpOw0KDQpZb3UgY29t
YmluZSBhc3NpZ24gYW5kIHdyaXRlX3MgaW4gdGhpcyBmdW5jdGlvbiwgc28geW91IGFsd2F5cyBv
Y2N1cHkNCnJlZ2lzdGVyIENNRFFfU1BSX1RFTVAgZm9yIHRoaXMgcHVycG9zZSwgY2xpZW50IGNv
dWxkIG5vdCB1c2UNCkNNRFFfU1BSX1RFTVAgZm9yIG90aGVyIHB1cnBvc2UuIFNvIEkgd291bGQg
bGlrZSB5b3UganVzdCBkbyB3cml0ZV9zIGluDQp0aGlzIGZ1bmN0aW9uLiBTbyB0aGUgY29kZSBp
biBjbGllbnQgd291bGQgYmU6DQoNCmNtZHFfcGt0X2Fzc2lnbihwa3QsIGhpZ2hfYWRkcl9yZWdf
aWR4LCBDTURRX0FERFJfSElHSChhZGRyKSk7DQpjbWRxX3BrdF93cml0ZV9zKHBrdCwgaGlnaF9h
ZGRyX3JlZ19pZHgsIENNRFFfQUREUl9MT1coYWRkciksDQpzcmNfcmVnX2lkeCwgbWFzayk7DQoN
CkxldCBjbGllbnQgdG8gZGVjaWRlIHdoaWNoIHJlZ2lzdGVyIGZvciBoaWdoIGFkZHJlc3MuDQoN
CkFub3RoZXIgYmVuZWZpdCBvZiBub3QgY29tYmluaW5nIGluc3RydWN0aW9uIGlzIHRoYXQgY2xp
ZW50IGRyaXZlciBvd25lcg0Kd291bGQgYmUgbW9yZSBjbGVhciBhYm91dCB3aGljaCBjb21tYW5k
IGlzIGluIGNvbW1hbmQgYnVmZmVyIGFuZCBpdCdzDQplYXNpZXIgZm9yIHRoZW0gdG8gZGVidWcu
DQoNCj4gKwlpZiAoZXJyIDwgMCkNCj4gKwkJcmV0dXJuIGVycjsNCj4gKw0KPiArCWluc3QuYXJn
X2JfdCA9IENNRFFfUkVHX1RZUEU7DQo+ICsJaW5zdC5zb3AgPSBkc3RfcmVnX2lkeDsNCj4gKwlp
bnN0Lm9mZnNldCA9IENNRFFfQUREUl9MT1coYWRkcik7DQo+ICsJaW5zdC5hcmdfYiA9IHJlZ19p
ZHg7DQoNCkkgc2VlbXMgYXJnX2IgaGFzIGEgbWVhbmluZ2Z1bCBuYW1lLg0KDQpSZWdhcmRzLA0K
Q0sNCg0KPiArDQo+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7
DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3MpOw0KPiArDQo+ICBpbnQg
Y21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQo+ICB7DQo+ICAJ
c3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIGIvaW5jbHVkZS9saW51eC9t
YWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiBpbmRleCAxMjFjM2JiNmQzZGUuLjhlZjg3ZTFi
ZDAzYiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+
IEBAIC01OSw2ICs1OSw4IEBAIGVudW0gY21kcV9jb2RlIHsNCj4gIAlDTURRX0NPREVfSlVNUCA9
IDB4MTAsDQo+ICAJQ01EUV9DT0RFX1dGRSA9IDB4MjAsDQo+ICAJQ01EUV9DT0RFX0VPQyA9IDB4
NDAsDQo+ICsJQ01EUV9DT0RFX1dSSVRFX1MgPSAweDkwLA0KPiArCUNNRFFfQ09ERV9XUklURV9T
X01BU0sgPSAweDkxLA0KPiAgCUNNRFFfQ09ERV9MT0dJQyA9IDB4YTAsDQo+ICB9Ow0KPiAgDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBpbmRleCBjNjZiM2EwZGEyYTIu
LjU2ZmYxOTcwMTk3YyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
DQo+IEBAIC0xMDYsNiArMTA2LDE4IEBAIGludCBjbWRxX3BrdF93cml0ZShzdHJ1Y3QgY21kcV9w
a3QgKnBrdCwgdTggc3Vic3lzLCB1MTYgb2Zmc2V0LCB1MzIgdmFsdWUpOw0KPiAgaW50IGNtZHFf
cGt0X3dyaXRlX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gIAkJCXUx
NiBvZmZzZXQsIHUzMiB2YWx1ZSwgdTMyIG1hc2spOw0KPiAgDQo+ICsvKioNCj4gKyAqIGNtZHFf
cGt0X3dyaXRlX3NfbWFzaygpIC0gYXBwZW5kIHdyaXRlX3MgY29tbWFuZCB0byB0aGUgQ01EUSBw
YWNrZXQNCj4gKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiArICogQGFkZHI6CXRoZSBwaHlz
aWNhbCBhZGRyZXNzIG9mIHJlZ2lzdGVyIG9yIGRtYQ0KPiArICogQHJlZ19pZHg6CXRoZSBDTURR
IGludGVybmFsIHJlZ2lzdGVyIElEIHdoaWNoIGNhY2hlIHNvdXJjZSB2YWx1ZQ0KPiArICogQG1h
c2s6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IHJlZ2lzdGVyIG1hc2sNCj4gKyAqDQo+ICsgKiBSZXR1
cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCj4gKyAq
Lw0KPiAraW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHBoeXNfYWRk
cl90IGFkZHIsIHUxNiByZWdfaWR4LA0KPiArCQkgICAgIHUzMiBtYXNrKTsNCj4gKw0KPiAgLyoq
DQo+ICAgKiBjbWRxX3BrdF93ZmUoKSAtIGFwcGVuZCB3YWl0IGZvciBldmVudCBjb21tYW5kIHRv
IHRoZSBDTURRIHBhY2tldA0KPiAgICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQoNCg==

