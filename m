Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA06C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EF6206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OfzLetq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLJHfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:35:12 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49039 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727004AbfLJHfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:35:12 -0500
X-UUID: 69c6bb708b764bc3890d296e244412b5-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=QWIkdb1t9y7Z5PmgxzFRNPEmfCRlFO7By6gkPdVB3po=;
        b=OfzLetq3yriMCLm6rZNRBhT+HA92GNylrthtR/dY+0y6n0zNPRngZ2hh7626svLKMl9zlNnJ8n+5umaP/MdzbBeqshcKc03ThJZvGM5ximpNdSjnxpre2Bx2Ecd2lYY/RKB/Lk4a0bc5owQdumOR5BY2guIgMNCQ22e4APt99Ig=;
X-UUID: 69c6bb708b764bc3890d296e244412b5-20191210
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1397588667; Tue, 10 Dec 2019 15:35:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 15:34:43 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 15:34:46 +0800
Message-ID: <1575963305.31101.0.camel@mtksdaap41>
Subject: Re: [PATCH v2 08/14] soc: mediatek: cmdq: add write_s function
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 10 Dec 2019 15:35:05 +0800
In-Reply-To: <1574819937-6246-10-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-10-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTExLTI3IGF0IDA5OjU4ICswODAwLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6
DQo+IGFkZCB3cml0ZV9zIGZ1bmN0aW9uIGluIGNtZHEgaGVscGVyIGZ1bmN0aW9ucyB3aGljaA0K
PiB3cml0ZXMgdmFsdWUgY29udGFpbnMgaW4gaW50ZXJuYWwgcmVnaXN0ZXIgdG8gYWRkcmVzcw0K
PiB3aXRoIGxhcmdlIGRtYSBhY2Nlc3Mgc3VwcG9ydC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERl
bm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwgNDAgKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5o
IHwgIDIgKysNCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCAx
MiArKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGluZGV4IDljYzIzNGYwOGVjNS4u
MmVkYmMwOTU0ZDk3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
Yw0KPiBAQCAtMTUsMTEgKzE1LDE4IEBADQo+ICAjZGVmaW5lIENNRFFfRU9DX0NNRAkJKCh1NjQp
KChDTURRX0NPREVfRU9DIDw8IENNRFFfT1BfQ09ERV9TSElGVCkpIFwNCj4gIAkJCQk8PCAzMiB8
IENNRFFfRU9DX0lSUV9FTikNCj4gICNkZWZpbmUgQ01EUV9SRUdfVFlQRQkJMQ0KPiArI2RlZmlu
ZSBDTURRX0FERFJfSElHSChhZGRyKQkoKHUzMikoKChhZGRyKSA+PiAxNikgJiBHRU5NQVNLKDMx
LCAwKSkpDQo+ICsjZGVmaW5lIENNRFFfQUREUl9MT1dfQklUCUJJVCgxKQ0KPiArI2RlZmluZSBD
TURRX0FERFJfTE9XKGFkZHIpCSgodTE2KShhZGRyKSB8IENNRFFfQUREUl9MT1dfQklUKQ0KPiAg
DQo+ICBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQo+ICAJdW5pb24gew0KPiAgCQl1MzIgdmFs
dWU7DQo+ICAJCXUzMiBtYXNrOw0KPiArCQlzdHJ1Y3Qgew0KPiArCQkJdTE2IGFyZ19jOw0KPiAr
CQkJdTE2IGFyZ19iOw0KPiArCQl9Ow0KPiAgCX07DQo+ICAJdW5pb24gew0KPiAgCQl1MTYgb2Zm
c2V0Ow0KPiBAQCAtMjI0LDYgKzIzMSwzOSBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1
Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTChjbWRx
X3BrdF93cml0ZV9tYXNrKTsNCj4gIA0KPiAraW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHBoeXNfYWRkcl90IGFkZHIsIHUxNiByZWdfaWR4LA0KPiArCQkgICAgIHUz
MiBtYXNrKQ0KPiArew0KPiArCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9
Ow0KPiArCWNvbnN0IHUxNiBkc3RfcmVnX2lkeCA9IENNRFFfU1BSX1RFTVA7DQo+ICsJaW50IGVy
cjsNCj4gKw0KPiArCWlmIChtYXNrICE9IFUzMl9NQVgpIHsNCj4gKwkJaW5zdC5vcCA9IENNRFFf
Q09ERV9NQVNLOw0KPiArCQlpbnN0Lm1hc2sgPSB+bWFzazsNCj4gKwkJZXJyID0gY21kcV9wa3Rf
YXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gKwkJaWYgKGVyciA8IDApDQo+ICsJCQlyZXR1
cm4gZXJyOw0KPiArDQo+ICsJCWluc3QubWFzayA9IDA7DQo+ICsJCWluc3Qub3AgPSBDTURRX0NP
REVfV1JJVEVfU19NQVNLOw0KPiArCX0gZWxzZSB7DQo+ICsJCWluc3Qub3AgPSBDTURRX0NPREVf
V1JJVEVfUzsNCj4gKwl9DQo+ICsNCj4gKwllcnIgPSBjbWRxX3BrdF9hc3NpZ24ocGt0LCBkc3Rf
cmVnX2lkeCwgQ01EUV9BRERSX0hJR0goYWRkcikpOw0KPiArCWlmIChlcnIgPCAwKQ0KPiArCQly
ZXR1cm4gZXJyOw0KPiArDQo+ICsJaW5zdC5hcmdfYl90ID0gQ01EUV9SRUdfVFlQRTsNCj4gKwlp
bnN0LnNvcCA9IGRzdF9yZWdfaWR4Ow0KPiArCWluc3Qub2Zmc2V0ID0gQ01EUV9BRERSX0xPVyhh
ZGRyKTsNCj4gKwlpbnN0LmFyZ19iID0gcmVnX2lkeDsNCj4gKw0KPiArCXJldHVybiBjbWRxX3Br
dF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTChjbWRx
X3BrdF93cml0ZV9zKTsNCj4gKw0KPiAgaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCwgdTE2IGV2ZW50KQ0KPiAgew0KPiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3Qg
PSB7IHswfSB9Ow0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRx
LW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4g
aW5kZXggMTIxYzNiYjZkM2RlLi44ZWY4N2UxYmQwM2IgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
bGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9t
YWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiBAQCAtNTksNiArNTksOCBAQCBlbnVtIGNtZHFf
Y29kZSB7DQo+ICAJQ01EUV9DT0RFX0pVTVAgPSAweDEwLA0KPiAgCUNNRFFfQ09ERV9XRkUgPSAw
eDIwLA0KPiAgCUNNRFFfQ09ERV9FT0MgPSAweDQwLA0KPiArCUNNRFFfQ09ERV9XUklURV9TID0g
MHg5MCwNCj4gKwlDTURRX0NPREVfV1JJVEVfU19NQVNLID0gMHg5MSwNCj4gIAlDTURRX0NPREVf
TE9HSUMgPSAweGEwLA0KPiAgfTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmgNCj4gaW5kZXggYzY2YjNhMGRhMmEyLi41NmZmMTk3MDE5N2MgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gKysrIGIvaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBAQCAtMTA2LDYgKzEwNiwxOCBAQCBpbnQg
Y21kcV9wa3Rfd3JpdGUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywgdTE2IG9mZnNl
dCwgdTMyIHZhbHVlKTsNCj4gIGludCBjbWRxX3BrdF93cml0ZV9tYXNrKHN0cnVjdCBjbWRxX3Br
dCAqcGt0LCB1OCBzdWJzeXMsDQo+ICAJCQl1MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNr
KTsNCj4gIA0KPiArLyoqDQo+ICsgKiBjbWRxX3BrdF93cml0ZV9zX21hc2soKSAtIGFwcGVuZCB3
cml0ZV9zIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQpJIHRoaW5rIHdlIG5lZWQgYWRkIG1v
cmUgZGVzY3JpcHRpb25zIGFib3V0IGRpZmZlcmVuY2UgYmV0d2VlbiB3cml0ZS4NCg0KQmliYnkN
Cj4gKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiArICogQGFkZHI6CXRoZSBwaHlzaWNhbCBh
ZGRyZXNzIG9mIHJlZ2lzdGVyIG9yIGRtYQ0KPiArICogQHJlZ19pZHg6CXRoZSBDTURRIGludGVy
bmFsIHJlZ2lzdGVyIElEIHdoaWNoIGNhY2hlIHNvdXJjZSB2YWx1ZQ0KPiArICogQG1hc2s6CXRo
ZSBzcGVjaWZpZWQgdGFyZ2V0IHJlZ2lzdGVyIG1hc2sNCj4gKyAqDQo+ICsgKiBSZXR1cm46IDAg
Zm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCj4gKyAqLw0KPiAr
aW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHBoeXNfYWRkcl90IGFk
ZHIsIHUxNiByZWdfaWR4LA0KPiArCQkgICAgIHUzMiBtYXNrKTsNCj4gKw0KPiAgLyoqDQo+ICAg
KiBjbWRxX3BrdF93ZmUoKSAtIGFwcGVuZCB3YWl0IGZvciBldmVudCBjb21tYW5kIHRvIHRoZSBD
TURRIHBhY2tldA0KPiAgICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQoNCg==

