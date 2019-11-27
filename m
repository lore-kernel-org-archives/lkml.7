Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A050CC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776392068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XpnmDLdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfK0B7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:59:21 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:27971 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbfK0B7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:18 -0500
X-UUID: 253b34aa4c9b4b578e3e128092e9d71f-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zPGMC5v6t5MUoD7pzD6uczn23q0QRwnhRiBaw9woapI=;
        b=XpnmDLdpB5OTSqunNXKxr7gGWFDnFfXbPmN8kUxU3J2HXawwkk4l051YQAFky7LGM8m1vKW8CufgywixJ3ihujuhS8XF1WqIJixXSgUALLj/ZhGLudYhMghXqqrMQoLQYOcl5tIiYzhiox12SbhPyDwLaHSSz+KOnswjIZbPe2g=;
X-UUID: 253b34aa4c9b4b578e3e128092e9d71f-20191127
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 36497751; Wed, 27 Nov 2019 09:59:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:58:31 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Nov 2019 09:58:19 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v2 08/14] soc: mediatek: cmdq: add write_s function
Date:   Wed, 27 Nov 2019 09:58:51 +0800
Message-ID: <1574819937-6246-10-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHdyaXRlX3MgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoDQp3cml0
ZXMgdmFsdWUgY29udGFpbnMgaW4gaW50ZXJuYWwgcmVnaXN0ZXIgdG8gYWRkcmVzcw0Kd2l0aCBs
YXJnZSBkbWEgYWNjZXNzIHN1cHBvcnQuDQoNClNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2ll
aCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jICAgfCA0MCArKysrKysrKysrKysrKysrKysrKysrKysNCiBp
bmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgIDIgKysNCiBpbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwgMTIgKysrKysrKw0KIDMgZmlsZXMg
Y2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYw0KaW5kZXggOWNjMjM0ZjA4ZWM1Li4yZWRiYzA5NTRkOTcgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBAIC0xNSwxMSArMTUsMTggQEANCiAjZGVmaW5l
IENNRFFfRU9DX0NNRAkJKCh1NjQpKChDTURRX0NPREVfRU9DIDw8IENNRFFfT1BfQ09ERV9TSElG
VCkpIFwNCiAJCQkJPDwgMzIgfCBDTURRX0VPQ19JUlFfRU4pDQogI2RlZmluZSBDTURRX1JFR19U
WVBFCQkxDQorI2RlZmluZSBDTURRX0FERFJfSElHSChhZGRyKQkoKHUzMikoKChhZGRyKSA+PiAx
NikgJiBHRU5NQVNLKDMxLCAwKSkpDQorI2RlZmluZSBDTURRX0FERFJfTE9XX0JJVAlCSVQoMSkN
CisjZGVmaW5lIENNRFFfQUREUl9MT1coYWRkcikJKCh1MTYpKGFkZHIpIHwgQ01EUV9BRERSX0xP
V19CSVQpDQogDQogc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gew0KIAl1bmlvbiB7DQogCQl1MzIg
dmFsdWU7DQogCQl1MzIgbWFzazsNCisJCXN0cnVjdCB7DQorCQkJdTE2IGFyZ19jOw0KKwkJCXUx
NiBhcmdfYjsNCisJCX07DQogCX07DQogCXVuaW9uIHsNCiAJCXUxNiBvZmZzZXQ7DQpAQCAtMjI0
LDYgKzIzMSwzOSBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBr
dCwgdTggc3Vic3lzLA0KIH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX21hc2spOw0K
IA0KK2ludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBwaHlzX2FkZHJf
dCBhZGRyLCB1MTYgcmVnX2lkeCwNCisJCSAgICAgdTMyIG1hc2spDQorew0KKwlzdHJ1Y3QgY21k
cV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCisJY29uc3QgdTE2IGRzdF9yZWdfaWR4ID0g
Q01EUV9TUFJfVEVNUDsNCisJaW50IGVycjsNCisNCisJaWYgKG1hc2sgIT0gVTMyX01BWCkgew0K
KwkJaW5zdC5vcCA9IENNRFFfQ09ERV9NQVNLOw0KKwkJaW5zdC5tYXNrID0gfm1hc2s7DQorCQll
cnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KKwkJaWYgKGVyciA8IDAp
DQorCQkJcmV0dXJuIGVycjsNCisNCisJCWluc3QubWFzayA9IDA7DQorCQlpbnN0Lm9wID0gQ01E
UV9DT0RFX1dSSVRFX1NfTUFTSzsNCisJfSBlbHNlIHsNCisJCWluc3Qub3AgPSBDTURRX0NPREVf
V1JJVEVfUzsNCisJfQ0KKw0KKwllcnIgPSBjbWRxX3BrdF9hc3NpZ24ocGt0LCBkc3RfcmVnX2lk
eCwgQ01EUV9BRERSX0hJR0goYWRkcikpOw0KKwlpZiAoZXJyIDwgMCkNCisJCXJldHVybiBlcnI7
DQorDQorCWluc3QuYXJnX2JfdCA9IENNRFFfUkVHX1RZUEU7DQorCWluc3Quc29wID0gZHN0X3Jl
Z19pZHg7DQorCWluc3Qub2Zmc2V0ID0gQ01EUV9BRERSX0xPVyhhZGRyKTsNCisJaW5zdC5hcmdf
YiA9IHJlZ19pZHg7DQorDQorCXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGlu
c3QpOw0KK30NCitFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3MpOw0KKw0KIGludCBjbWRx
X3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCiB7DQogCXN0cnVjdCBj
bWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5oDQppbmRleCAxMjFjM2JiNmQzZGUuLjhlZjg3ZTFiZDAzYiAxMDA2NDQN
Ci0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCisrKyBiL2lu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCkBAIC01OSw2ICs1OSw4IEBA
IGVudW0gY21kcV9jb2RlIHsNCiAJQ01EUV9DT0RFX0pVTVAgPSAweDEwLA0KIAlDTURRX0NPREVf
V0ZFID0gMHgyMCwNCiAJQ01EUV9DT0RFX0VPQyA9IDB4NDAsDQorCUNNRFFfQ09ERV9XUklURV9T
ID0gMHg5MCwNCisJQ01EUV9DT0RFX1dSSVRFX1NfTUFTSyA9IDB4OTEsDQogCUNNRFFfQ09ERV9M
T0dJQyA9IDB4YTAsDQogfTsNCiANCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0K
aW5kZXggYzY2YjNhMGRhMmEyLi41NmZmMTk3MDE5N2MgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xp
bnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oDQpAQCAtMTA2LDYgKzEwNiwxOCBAQCBpbnQgY21kcV9wa3Rfd3JpdGUo
c3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywgdTE2IG9mZnNldCwgdTMyIHZhbHVlKTsN
CiBpbnQgY21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lz
LA0KIAkJCXUxNiBvZmZzZXQsIHUzMiB2YWx1ZSwgdTMyIG1hc2spOw0KIA0KKy8qKg0KKyAqIGNt
ZHFfcGt0X3dyaXRlX3NfbWFzaygpIC0gYXBwZW5kIHdyaXRlX3MgY29tbWFuZCB0byB0aGUgQ01E
USBwYWNrZXQNCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCisgKiBAYWRkcjoJdGhlIHBoeXNp
Y2FsIGFkZHJlc3Mgb2YgcmVnaXN0ZXIgb3IgZG1hDQorICogQHJlZ19pZHg6CXRoZSBDTURRIGlu
dGVybmFsIHJlZ2lzdGVyIElEIHdoaWNoIGNhY2hlIHNvdXJjZSB2YWx1ZQ0KKyAqIEBtYXNrOgl0
aGUgc3BlY2lmaWVkIHRhcmdldCByZWdpc3RlciBtYXNrDQorICoNCisgKiBSZXR1cm46IDAgZm9y
IHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCisgKi8NCitpbnQgY21k
cV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgcGh5c19hZGRyX3QgYWRkciwgdTE2
IHJlZ19pZHgsDQorCQkgICAgIHUzMiBtYXNrKTsNCisNCiAvKioNCiAgKiBjbWRxX3BrdF93ZmUo
KSAtIGFwcGVuZCB3YWl0IGZvciBldmVudCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0KICAq
IEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KLS0gDQoyLjE4LjANCg==

