Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7901DC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBCF2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RXbdUEEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfK0B73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:59:29 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:27971 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727216AbfK0B7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:22 -0500
X-UUID: 7dd966711d3b4b239c5a638e0d140065-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kJr1tYxUm9FEjj59tyh/ULs/d6PnYtyzEkO0hVZWx6k=;
        b=RXbdUEEEea+iP+NST8seEbuh1O/iExe7Wu0luvDnRLOhWbatH2aBFgMm2nEpfyLlxSc9fufuJtsK56DDFGUwW5dENlbPofzrPxNMLHL9b6Z9MtJiIxQNpBsiEyJQDHsxEMUXf9CtSRq0XJ1Si3TbIiSW24RgTFyN3mZwf7sUd5c=;
X-UUID: 7dd966711d3b4b239c5a638e0d140065-20191127
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 569835648; Wed, 27 Nov 2019 09:59:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:58:44 +0800
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
Subject: [PATCH v2 07/14] soc: mediatek: cmdq: add assign function
Date:   Wed, 27 Nov 2019 09:58:50 +0800
Message-ID: <1574819937-6246-9-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9A844EC81A743F2CA1E69B93A0BB46A6E1DB1FA77D1DAF6789F55C8F1B9B89AE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGFzc2lnbiBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciB3aGljaCBhc3NpZ24gY29uc3RhbnQg
dmFsdWUgaW50bw0KaW50ZXJuYWwgcmVnaXN0ZXIgYnkgaW5kZXguDQoNClNpZ25lZC1vZmYtYnk6
IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAyNCArKysrKysrKysrKysr
KysrKysrKysrKy0NCiBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwg
IDEgKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCAxOCArKysr
KysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IDg0
MjFiNDA5MDMwNC4uOWNjMjM0ZjA4ZWM1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jDQpAQCAtMTQsNiArMTQsNyBAQA0KICNkZWZpbmUgQ01EUV9FT0NfSVJRX0VOCQlC
SVQoMCkNCiAjZGVmaW5lIENNRFFfRU9DX0NNRAkJKCh1NjQpKChDTURRX0NPREVfRU9DIDw8IENN
RFFfT1BfQ09ERV9TSElGVCkpIFwNCiAJCQkJPDwgMzIgfCBDTURRX0VPQ19JUlFfRU4pDQorI2Rl
ZmluZSBDTURRX1JFR19UWVBFCQkxDQogDQogc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gew0KIAl1
bmlvbiB7DQpAQCAtMjMsOCArMjQsMTcgQEAgc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gew0KIAl1
bmlvbiB7DQogCQl1MTYgb2Zmc2V0Ow0KIAkJdTE2IGV2ZW50Ow0KKwkJdTE2IHJlZ19kc3Q7DQor
CX07DQorCXVuaW9uIHsNCisJCXU4IHN1YnN5czsNCisJCXN0cnVjdCB7DQorCQkJdTggc29wOjU7
DQorCQkJdTggYXJnX2NfdDoxOw0KKwkJCXU4IGFyZ19iX3Q6MTsNCisJCQl1OCBkc3RfdDoxOw0K
KwkJfTsNCiAJfTsNCi0JdTggc3Vic3lzOw0KIAl1OCBvcDsNCiB9Ow0KIA0KQEAgLTI3OSw2ICsy
ODksMTggQEAgaW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTgg
c3Vic3lzLA0KIH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3BvbGxfbWFzayk7DQogDQoraW50
IGNtZHFfcGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgsIHUzMiB2
YWx1ZSkNCit7DQorCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKw0K
KwlpbnN0Lm9wID0gQ01EUV9DT0RFX0xPR0lDOw0KKwlpbnN0LmRzdF90ID0gQ01EUV9SRUdfVFlQ
RTsNCisJaW5zdC5yZWdfZHN0ID0gcmVnX2lkeDsNCisJaW5zdC52YWx1ZSA9IHZhbHVlOw0KKwly
ZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCit9DQorRVhQT1JUX1NZ
TUJPTChjbWRxX3BrdF9hc3NpZ24pOw0KKw0KIHN0YXRpYyBpbnQgY21kcV9wa3RfZmluYWxpemUo
c3RydWN0IGNtZHFfcGt0ICpwa3QpDQogew0KIAlzdHJ1Y3QgY21kcV9jbGllbnQgKmNsID0gcGt0
LT5jbDsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5oIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KaW5kZXggZGZl
NWIyZWI4NWNjLi4xMjFjM2JiNmQzZGUgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5oDQpAQCAtNTksNiArNTksNyBAQCBlbnVtIGNtZHFfY29kZSB7DQogCUNNRFFf
Q09ERV9KVU1QID0gMHgxMCwNCiAJQ01EUV9DT0RFX1dGRSA9IDB4MjAsDQogCUNNRFFfQ09ERV9F
T0MgPSAweDQwLA0KKwlDTURRX0NPREVfTE9HSUMgPSAweGEwLA0KIH07DQogDQogZW51bSBjbWRx
X2NiX3N0YXR1cyB7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCmluZGV4IGE3
NGMxZDVhY2RmMy4uYzY2YjNhMGRhMmEyIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaA0KQEAgLTEyLDYgKzEyLDEwIEBADQogI2luY2x1ZGUgPGxpbnV4L3RpbWVyLmg+DQog
DQogI2RlZmluZSBDTURRX05PX1RJTUVPVVQJCTB4ZmZmZmZmZmZ1DQorI2RlZmluZSBDTURRX1NQ
Ul9URU1QCQkwDQorI2RlZmluZSBDTURRX1NQUjEJCTENCisjZGVmaW5lIENNRFFfU1BSMgkJMg0K
KyNkZWZpbmUgQ01EUV9TUFIzCQkzDQogDQogc3RydWN0IGNtZHFfcGt0Ow0KIA0KQEAgLTE1Miw2
ICsxNTYsMjAgQEAgaW50IGNtZHFfcGt0X3BvbGwoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1
YnN5cywNCiAgKi8NCiBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCB1OCBzdWJzeXMsDQogCQkgICAgICAgdTE2IG9mZnNldCwgdTMyIHZhbHVlLCB1MzIgbWFzayk7
DQorDQorLyoqDQorICogY21kcV9wa3RfYXNzaWduKCkgLSBBcHBlbmQgbG9naWMgYXNzaWduIGNv
bW1hbmQgdG8gdGhlIENNRFEgcGFja2V0LCBhc2sgR0NFDQorICoJCSAgICAgICB0byBleGVjdXRl
IGFuIGluc3RydWN0aW9uIHRoYXQgc2V0IGEgY29uc3RhbnQgdmFsdWUgaW50bw0KKyAqCQkgICAg
ICAgaW50ZXJuYWwgcmVnaXN0ZXIgYW5kIHVzZSBhcyB2YWx1ZSwgbWFzayBvciBhZGRyZXNzIGlu
DQorICoJCSAgICAgICByZWFkL3dyaXRlIGluc3RydWN0aW9uLg0KKyAqIEBwa3Q6CXRoZSBDTURR
IHBhY2tldA0KKyAqIEByZWdfaWR4Ogl0aGUgQ01EUSBpbnRlcm5hbCByZWdpc3RlciBJRA0KKyAq
IEB2YWx1ZToJdGhlIHNwZWNpZmllZCB2YWx1ZQ0KKyAqDQorICogUmV0dXJuOiAwIGZvciBzdWNj
ZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQorICovDQoraW50IGNtZHFfcGt0
X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgsIHUzMiB2YWx1ZSk7DQor
DQogLyoqDQogICogY21kcV9wa3RfZmx1c2hfYXN5bmMoKSAtIHRyaWdnZXIgQ01EUSB0byBhc3lu
Y2hyb25vdXNseSBleGVjdXRlIHRoZSBDTURRDQogICogICAgICAgICAgICAgICAgICAgICAgICAg
IHBhY2tldCBhbmQgY2FsbCBiYWNrIGF0IHRoZSBlbmQgb2YgZG9uZSBwYWNrZXQNCi0tIA0KMi4x
OC4wDQo=

