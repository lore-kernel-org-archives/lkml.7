Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3175C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D592071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZWYv6kFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfKUJOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:14:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50193 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726014AbfKUJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:13:33 -0500
X-UUID: 6b658eebf8f649ed86e2f93e1ec1d0af-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TiulLJ0CtTfh89Jbxy5etpVyClnVU8CeCrTJaGL4/Lg=;
        b=ZWYv6kFMSde4w2CByUDX9j2qG/brG36SdYdyDY5aKw+vDgDU8cdxwSCVD5engIlQ8XDgaRi/Q3Jn8MN9MfACLJNklv/vC85essitH5gJbSRI8Mn0rlLEAu+r/UszCJcQPeWQiEJCy27qY7QRi3FjN4OncX6WR7xLd9UtGNc5hm0=;
X-UUID: 6b658eebf8f649ed86e2f93e1ec1d0af-20191121
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1223675358; Thu, 21 Nov 2019 17:13:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 17:13:09 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 17:13:29 +0800
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
Subject: [PATCH v1 06/12] soc: mediatek: cmdq: add assign function
Date:   Thu, 21 Nov 2019 17:12:26 +0800
Message-ID: <1574327552-11806-7-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5D768AA7918F4A90667EC41CF496330081AE4CA3609A566C7AEB51E4926B3E432000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGFzc2lnbiBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciB3aGljaCBhc3NpZ24gY29uc3RhbnQg
dmFsdWUgaW50bw0KaW50ZXJuYWwgcmVnaXN0ZXIgYnkgaW5kZXguDQoNClNpZ25lZC1vZmYtYnk6
IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAgIDI0ICsrKysrKysrKysr
KysrKysrKysrKysrLQ0KIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94Lmgg
fCAgICAxICsNCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwgICAx
NCArKysrKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEt
aGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXgg
Mjc0ZjZmMy4uZDQxOWU5OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1j
bWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
Yw0KQEAgLTE0LDYgKzE0LDcgQEANCiAjZGVmaW5lIENNRFFfRU9DX0lSUV9FTgkJQklUKDApDQog
I2RlZmluZSBDTURRX0VPQ19DTUQJCSgodTY0KSgoQ01EUV9DT0RFX0VPQyA8PCBDTURRX09QX0NP
REVfU0hJRlQpKSBcDQogCQkJCTw8IDMyIHwgQ01EUV9FT0NfSVJRX0VOKQ0KKyNkZWZpbmUgQ01E
UV9SRUdfVFlQRQkJMQ0KIA0KIHN0cnVjdCBjbWRxX2luc3RydWN0aW9uIHsNCiAJdW5pb24gew0K
QEAgLTIzLDggKzI0LDE3IEBAIHN0cnVjdCBjbWRxX2luc3RydWN0aW9uIHsNCiAJdW5pb24gew0K
IAkJdTE2IG9mZnNldDsNCiAJCXUxNiBldmVudDsNCisJCXUxNiByZWdfZHN0Ow0KKwl9Ow0KKwl1
bmlvbiB7DQorCQl1OCBzdWJzeXM7DQorCQlzdHJ1Y3Qgew0KKwkJCXU4IHNvcDo1Ow0KKwkJCXU4
IGFyZ19jX3Q6MTsNCisJCQl1OCBhcmdfYl90OjE7DQorCQkJdTggYXJnX2FfdDoxOw0KKwkJfTsN
CiAJfTsNCi0JdTggc3Vic3lzOw0KIAl1OCBvcDsNCiB9Ow0KIA0KQEAgLTI3OSw2ICsyODksMTgg
QEAgaW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lz
LA0KIH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3BvbGxfbWFzayk7DQogDQoraW50IGNtZHFf
cGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgsIHUzMiB2YWx1ZSkN
Cit7DQorCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKw0KKwlpbnN0
Lm9wID0gQ01EUV9DT0RFX0xPR0lDOw0KKwlpbnN0LmFyZ19hX3QgPSBDTURRX1JFR19UWVBFOw0K
KwlpbnN0LnJlZ19kc3QgPSByZWdfaWR4Ow0KKwlpbnN0LnZhbHVlID0gdmFsdWU7DQorCXJldHVy
biBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KK30NCitFWFBPUlRfU1lNQk9M
KGNtZHFfcGt0X2Fzc2lnbik7DQorDQogc3RhdGljIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1
Y3QgY21kcV9wa3QgKnBrdCkNCiB7DQogCXN0cnVjdCBjbWRxX2NsaWVudCAqY2wgPSBwa3QtPmNs
Ow0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94Lmgg
Yi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQppbmRleCBkZmU1YjJl
Li4xMjFjM2JiIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guaA0KKysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0K
QEAgLTU5LDYgKzU5LDcgQEAgZW51bSBjbWRxX2NvZGUgew0KIAlDTURRX0NPREVfSlVNUCA9IDB4
MTAsDQogCUNNRFFfQ09ERV9XRkUgPSAweDIwLA0KIAlDTURRX0NPREVfRU9DID0gMHg0MCwNCisJ
Q01EUV9DT0RFX0xPR0lDID0gMHhhMCwNCiB9Ow0KIA0KIGVudW0gY21kcV9jYl9zdGF0dXMgew0K
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNs
dWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRleCBhNzRjMWQ1Li44MzM0MDIx
IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KKysr
IGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KQEAgLTE1Miw2ICsxNTIs
MjAgQEAgaW50IGNtZHFfcGt0X3BvbGwoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywN
CiAgKi8NCiBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBz
dWJzeXMsDQogCQkgICAgICAgdTE2IG9mZnNldCwgdTMyIHZhbHVlLCB1MzIgbWFzayk7DQorDQor
LyoqDQorICogY21kcV9wa3RfYXNzaWduKCkgLSBBcHBlbmQgbG9naWMgYXNzaWduIGNvbW1hbmQg
dG8gdGhlIENNRFEgcGFja2V0LCBhc2sgR0NFDQorICoJCSAgICAgICB0byBleGVjdXRlIGFuIGlu
c3RydWN0aW9uIHRoYXQgc2V0IGEgY29uc3RhbnQgdmFsdWUgaW50bw0KKyAqCQkgICAgICAgaW50
ZXJuYWwgcmVnaXN0ZXIgYW5kIHVzZSBhcyB2YWx1ZSwgbWFzayBvciBhZGRyZXNzIGluDQorICoJ
CSAgICAgICByZWFkL3dyaXRlIGluc3RydWN0aW9uLg0KKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tl
dA0KKyAqIEByZWdfaWR4Ogl0aGUgQ01EUSBpbnRlcm5hbCByZWdpc3RlciBJRA0KKyAqIEB2YWx1
ZToJdGhlIHNwZWNpZmllZCB2YWx1ZQ0KKyAqDQorICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBl
bHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQorICovDQoraW50IGNtZHFfcGt0X2Fzc2ln
bihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgsIHUzMiB2YWx1ZSk7DQorDQogLyoq
DQogICogY21kcV9wa3RfZmx1c2hfYXN5bmMoKSAtIHRyaWdnZXIgQ01EUSB0byBhc3luY2hyb25v
dXNseSBleGVjdXRlIHRoZSBDTURRDQogICogICAgICAgICAgICAgICAgICAgICAgICAgIHBhY2tl
dCBhbmQgY2FsbCBiYWNrIGF0IHRoZSBlbmQgb2YgZG9uZSBwYWNrZXQNCi0tIA0KMS43LjkuNQ0K

