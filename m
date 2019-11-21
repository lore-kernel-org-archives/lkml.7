Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B16C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB102071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dhRod/EA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfKUJNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:13:34 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:12471 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726573AbfKUJNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:13:32 -0500
X-UUID: 9bfd6595cadf4ebd8c76006e2d2b547c-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/DnUKTGlfXgN1plU76kTXYmxsWVL/QKj2+ubeYC6O/g=;
        b=dhRod/EABm5hQQHIzYvfPPztE9LG6Kwa/bSn1gVjT+icC2n1pLdxT2B++MS41rPLp8G15pKHfWbLxId5349WYgvvBUsfWLxQt67U0B0Izb1IJi3Qg3oo2Xb5fwtvkT6M1X0RDOr61bNebUTXLLElEgt1+28kLxNXTDnXZhTY23Y=;
X-UUID: 9bfd6595cadf4ebd8c76006e2d2b547c-20191121
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 750818648; Thu, 21 Nov 2019 17:13:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 17:13:18 +0800
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
Subject: [PATCH v1 07/12] soc: mediatek: cmdq: add write_s function
Date:   Thu, 21 Nov 2019 17:12:27 +0800
Message-ID: <1574327552-11806-8-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHdyaXRlX3MgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoDQpzdXBw
b3J0IGxhcmdlIGRtYSBhY2Nlc3MuDQoNClNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8
ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jICAgfCAgIDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggfCAgICAyICsrDQog
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8ICAgMTMgKysrKysrKysr
KysrDQogMyBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRleCBkNDE5ZTk5Li4xYjA3NGE5IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCisrKyBiL2RyaXZlcnMv
c29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpAQCAtMTUsNiArMTUsOSBAQA0KICNkZWZp
bmUgQ01EUV9FT0NfQ01ECQkoKHU2NCkoKENNRFFfQ09ERV9FT0MgPDwgQ01EUV9PUF9DT0RFX1NI
SUZUKSkgXA0KIAkJCQk8PCAzMiB8IENNRFFfRU9DX0lSUV9FTikNCiAjZGVmaW5lIENNRFFfUkVH
X1RZUEUJCTENCisjZGVmaW5lIENNRFFfQUREUl9ISUdIKGFkZHIpCSgodTMyKSgoKGFkZHIpID4+
IDE2KSAmIEdFTk1BU0soMzEsIDApKSkNCisjZGVmaW5lIENNRFFfQUREUl9MT1dfQklUCUJJVCgx
KQ0KKyNkZWZpbmUgQ01EUV9BRERSX0xPVyhhZGRyKQkoKHUxNikoYWRkcikgfCBDTURRX0FERFJf
TE9XX0JJVCkNCiANCiBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQogCXVuaW9uIHsNCkBAIC0y
MjQsNiArMjI3LDM3IEBAIGludCBjbWRxX3BrdF93cml0ZV9tYXNrKHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCB1OCBzdWJzeXMsDQogfQ0KIEVYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfbWFzayk7
DQogDQoraW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIGRtYV9hZGRy
X3QgYWRkciwNCisJCSAgICAgdTMyIHZhbHVlLCB1MzIgbWFzaykNCit7DQorCXN0cnVjdCBjbWRx
X2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKwlpbnQgZXJyOw0KKwljb25zdCB1MTYgZHN0
X3JlZ19pZHggPSBDTURRX1NQUl9URU1QOw0KKw0KKwllcnIgPSBjbWRxX3BrdF9hc3NpZ24ocGt0
LCBkc3RfcmVnX2lkeCwgQ01EUV9BRERSX0hJR0goYWRkcikpOw0KKwlpZiAoZXJyIDwgMCkNCisJ
CXJldHVybiBlcnI7DQorDQorCWlmIChtYXNrICE9IFUzMl9NQVgpIHsNCisJCWluc3Qub3AgPSBD
TURRX0NPREVfTUFTSzsNCisJCWluc3QubWFzayA9IH5tYXNrOw0KKwkJZXJyID0gY21kcV9wa3Rf
YXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCisJCWlmIChlcnIgPCAwKQ0KKwkJCXJldHVybiBl
cnI7DQorDQorCQlpbnN0Lm9wID0gQ01EUV9DT0RFX1dSSVRFX1NfTUFTSzsNCisJfSBlbHNlIHsN
CisJCWluc3Qub3AgPSBDTURRX0NPREVfV1JJVEVfUzsNCisJfQ0KKw0KKwlpbnN0LnNvcCA9IGRz
dF9yZWdfaWR4Ow0KKwlpbnN0Lm9mZnNldCA9IENNRFFfQUREUl9MT1coYWRkcik7DQorCWluc3Qu
dmFsdWUgPSB2YWx1ZTsNCisNCisJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwg
aW5zdCk7DQorfQ0KK0VYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfcyk7DQorDQogaW50IGNt
ZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KQ0KIHsNCiAJc3RydWN0
IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmgNCmluZGV4IDEyMWMzYmIuLjhlZjg3ZTEgMTAwNjQ0DQotLS0gYS9p
bmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQorKysgYi9pbmNsdWRlL2xp
bnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQpAQCAtNTksNiArNTksOCBAQCBlbnVtIGNt
ZHFfY29kZSB7DQogCUNNRFFfQ09ERV9KVU1QID0gMHgxMCwNCiAJQ01EUV9DT0RFX1dGRSA9IDB4
MjAsDQogCUNNRFFfQ09ERV9FT0MgPSAweDQwLA0KKwlDTURRX0NPREVfV1JJVEVfUyA9IDB4OTAs
DQorCUNNRFFfQ09ERV9XUklURV9TX01BU0sgPSAweDkxLA0KIAlDTURRX0NPREVfTE9HSUMgPSAw
eGEwLA0KIH07DQogDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCmluZGV4IDgz
MzQwMjEuLjhkYmQwNDYgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9t
dGstY21kcS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQpA
QCAtMTIsNiArMTIsNyBAQA0KICNpbmNsdWRlIDxsaW51eC90aW1lci5oPg0KIA0KICNkZWZpbmUg
Q01EUV9OT19USU1FT1VUCQkweGZmZmZmZmZmdQ0KKyNkZWZpbmUgQ01EUV9TUFJfVEVNUAkJMA0K
IA0KIHN0cnVjdCBjbWRxX3BrdDsNCiANCkBAIC0xMDMsNiArMTA0LDE4IEBAIGludCBjbWRxX3Br
dF93cml0ZV9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQogCQkJdTE2IG9m
ZnNldCwgdTMyIHZhbHVlLCB1MzIgbWFzayk7DQogDQogLyoqDQorICogY21kcV9wa3Rfd3JpdGVf
cygpIC0gYXBwZW5kIHdyaXRlX3MgY29tbWFuZCB3aXRoIG1hc2sgdG8gdGhlIENNRFEgcGFja2V0
DQorICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQorICogQGFkZHI6CXRoZSBwaHlzaWNhbCBhZGRy
ZXNzIG9mIHJlZ2lzdGVyIG9yIGRtYQ0KKyAqIEB2YWx1ZToJdGhlIHNwZWNpZmllZCB0YXJnZXQg
dmFsdWUNCisgKiBAbWFzazoJdGhlIHNwZWNpZmllZCB0YXJnZXQgbWFzaw0KKyAqDQorICogUmV0
dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQorICov
DQoraW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIGRtYV9hZGRyX3Qg
YWRkciwNCisJCSAgICAgdTMyIHZhbHVlLCB1MzIgbWFzayk7DQorDQorLyoqDQogICogY21kcV9w
a3Rfd2ZlKCkgLSBhcHBlbmQgd2FpdCBmb3IgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNr
ZXQNCiAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCiAgKiBAZXZlbnQ6CXRoZSBkZXNpcmVkIGV2
ZW50IHR5cGUgdG8gIndhaXQgYW5kIENMRUFSIg0KLS0gDQoxLjcuOS41DQo=

