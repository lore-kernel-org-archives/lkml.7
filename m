Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178D6C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69072075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E/1Iuqpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKUByZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:54:25 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:23328 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726290AbfKUByU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:54:20 -0500
X-UUID: a87b17a0a79d4e4f838175ec44401ad8-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oLQft4h3WBvG+BaSzkNOmH2leq40fuDQjdsrrPk7Tt0=;
        b=E/1Iuqpv+K0Eu+a7G3fcMaKn08X8E/82cKbRQaJ4qZRV+3UTl960O0QFVUqfJNRkU+UW9cEHASjvMrT+6jYibgyVq4dYfycg+QJha0KXJ2/MpMJNg5wlqdRfKb3qiIN2i6Xn6BkIupzT3jTufFwSJ/7D+ZYSLwhmPghJp79B3+I=;
X-UUID: a87b17a0a79d4e4f838175ec44401ad8-20191121
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 941184459; Thu, 21 Nov 2019 09:54:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 09:54:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 09:54:17 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v17 4/6] soc: mediatek: cmdq: add polling function
Date:   Thu, 21 Nov 2019 09:54:08 +0800
Message-ID: <20191121015410.18852-5-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
References: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHBvbGxpbmcgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zDQoNClNpZ25lZC1v
ZmYtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwgMzYgKysrKysrKysrKysrKysr
KysrKysrKysrDQogaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8ICAx
ICsNCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwgMzIgKysrKysr
KysrKysrKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCA2OSBpbnNlcnRpb25zKCspDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRleCAxMWJmY2MxNTBlYmQuLjkw
OTRmZGE1YThmZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAg
LTEwLDYgKzEwLDcgQEANCiAjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmg+
DQogDQogI2RlZmluZSBDTURRX1dSSVRFX0VOQUJMRV9NQVNLCUJJVCgwKQ0KKyNkZWZpbmUgQ01E
UV9QT0xMX0VOQUJMRV9NQVNLCUJJVCgwKQ0KICNkZWZpbmUgQ01EUV9FT0NfSVJRX0VOCQlCSVQo
MCkNCiAjZGVmaW5lIENNRFFfRU9DX0NNRAkJKCh1NjQpKChDTURRX0NPREVfRU9DIDw8IENNRFFf
T1BfQ09ERV9TSElGVCkpIFwNCiAJCQkJPDwgMzIgfCBDTURRX0VPQ19JUlFfRU4pDQpAQCAtMjE0
LDYgKzIxNSw0MSBAQCBpbnQgY21kcV9wa3RfY2xlYXJfZXZlbnQoc3RydWN0IGNtZHFfcGt0ICpw
a3QsIHUxNiBldmVudCkNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9jbGVhcl9ldmVudCk7
DQogDQoraW50IGNtZHFfcGt0X3BvbGwoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywN
CisJCSAgdTE2IG9mZnNldCwgdTMyIHZhbHVlKQ0KK3sNCisJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rp
b24gaW5zdCA9IHsgezB9IH07DQorCWludCBlcnI7DQorDQorCWluc3Qub3AgPSBDTURRX0NPREVf
UE9MTDsNCisJaW5zdC52YWx1ZSA9IHZhbHVlOw0KKwlpbnN0Lm9mZnNldCA9IG9mZnNldDsNCisJ
aW5zdC5zdWJzeXMgPSBzdWJzeXM7DQorCWVyciA9IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBr
dCwgaW5zdCk7DQorDQorCXJldHVybiBlcnI7DQorfQ0KK0VYUE9SVF9TWU1CT0woY21kcV9wa3Rf
cG9sbCk7DQorDQoraW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
dTggc3Vic3lzLA0KKwkJICAgICAgIHUxNiBvZmZzZXQsIHUzMiB2YWx1ZSwgdTMyIG1hc2spDQor
ew0KKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCisJaW50IGVycjsN
CisNCisJaW5zdC5vcCA9IENNRFFfQ09ERV9NQVNLOw0KKwlpbnN0Lm1hc2sgPSB+bWFzazsNCisJ
ZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCisJaWYgKGVyciA8IDAp
DQorCQlyZXR1cm4gZXJyOw0KKw0KKwlvZmZzZXQgPSBvZmZzZXQgfCBDTURRX1BPTExfRU5BQkxF
X01BU0s7DQorCWVyciA9IGNtZHFfcGt0X3BvbGwocGt0LCBzdWJzeXMsIG9mZnNldCwgdmFsdWUp
Ow0KKw0KKwlyZXR1cm4gZXJyOw0KK30NCitFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3BvbGxfbWFz
ayk7DQorDQogc3RhdGljIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBr
dCkNCiB7DQogCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRl
L2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQppbmRleCA2Nzg3NjA1NDg3OTEuLmE0
ZGM0NWZiZWMwYSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1t
YWlsYm94LmgNCisrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgN
CkBAIC01NSw2ICs1NSw3IEBADQogZW51bSBjbWRxX2NvZGUgew0KIAlDTURRX0NPREVfTUFTSyA9
IDB4MDIsDQogCUNNRFFfQ09ERV9XUklURSA9IDB4MDQsDQorCUNNRFFfQ09ERV9QT0xMID0gMHgw
OCwNCiAJQ01EUV9DT0RFX0pVTVAgPSAweDEwLA0KIAlDTURRX0NPREVfV0ZFID0gMHgyMCwNCiAJ
Q01EUV9DT0RFX0VPQyA9IDB4NDAsDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgN
CmluZGV4IDk2MThkZWJiOWNlYi4uOTJiZDViNWM2MzQxIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEuaA0KQEAgLTk5LDYgKzk5LDM4IEBAIGludCBjbWRxX3BrdF93ZmUoc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCk7DQogICovDQogaW50IGNtZHFfcGt0X2NsZWFy
X2V2ZW50KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpOw0KIA0KKy8qKg0KKyAqIGNt
ZHFfcGt0X3BvbGwoKSAtIEFwcGVuZCBwb2xsaW5nIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0
LCBhc2sgR0NFIHRvDQorICoJCSAgICAgZXhlY3V0ZSBhbiBpbnN0cnVjdGlvbiB0aGF0IHdhaXQg
Zm9yIGEgc3BlY2lmaWVkDQorICoJCSAgICAgaGFyZHdhcmUgcmVnaXN0ZXIgdG8gY2hlY2sgZm9y
IHRoZSB2YWx1ZSB3L28gbWFzay4NCisgKgkJICAgICBBbGwgR0NFIGhhcmR3YXJlIHRocmVhZHMg
d2lsbCBiZSBibG9ja2VkIGJ5IHRoaXMNCisgKgkJICAgICBpbnN0cnVjdGlvbi4NCisgKiBAcGt0
Ogl0aGUgQ01EUSBwYWNrZXQNCisgKiBAc3Vic3lzOgl0aGUgQ01EUSBzdWIgc3lzdGVtIGNvZGUN
CisgKiBAb2Zmc2V0OglyZWdpc3RlciBvZmZzZXQgZnJvbSBDTURRIHN1YiBzeXN0ZW0NCisgKiBA
dmFsdWU6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IHJlZ2lzdGVyIHZhbHVlDQorICoNCisgKiBSZXR1
cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCisgKi8N
CitpbnQgY21kcV9wa3RfcG9sbChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KKwkJ
ICB1MTYgb2Zmc2V0LCB1MzIgdmFsdWUpOw0KKw0KKy8qKg0KKyAqIGNtZHFfcGt0X3BvbGxfbWFz
aygpIC0gQXBwZW5kIHBvbGxpbmcgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQsIGFzayBHQ0Ug
dG8NCisgKgkJICAgICAgICAgIGV4ZWN1dGUgYW4gaW5zdHJ1Y3Rpb24gdGhhdCB3YWl0IGZvciBh
IHNwZWNpZmllZA0KKyAqCQkgICAgICAgICAgaGFyZHdhcmUgcmVnaXN0ZXIgdG8gY2hlY2sgZm9y
IHRoZSB2YWx1ZSB3LyBtYXNrLg0KKyAqCQkgICAgICAgICAgQWxsIEdDRSBoYXJkd2FyZSB0aHJl
YWRzIHdpbGwgYmUgYmxvY2tlZCBieSB0aGlzDQorICoJCSAgICAgICAgICBpbnN0cnVjdGlvbi4N
CisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCisgKiBAc3Vic3lzOgl0aGUgQ01EUSBzdWIgc3lz
dGVtIGNvZGUNCisgKiBAb2Zmc2V0OglyZWdpc3RlciBvZmZzZXQgZnJvbSBDTURRIHN1YiBzeXN0
ZW0NCisgKiBAdmFsdWU6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IHJlZ2lzdGVyIHZhbHVlDQorICog
QG1hc2s6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IHJlZ2lzdGVyIG1hc2sNCisgKg0KKyAqIFJldHVy
bjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KKyAqLw0K
K2ludCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywN
CisJCSAgICAgICB1MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCiAvKioNCiAgKiBj
bWRxX3BrdF9mbHVzaF9hc3luYygpIC0gdHJpZ2dlciBDTURRIHRvIGFzeW5jaHJvbm91c2x5IGV4
ZWN1dGUgdGhlIENNRFENCiAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgcGFja2V0IGFuZCBj
YWxsIGJhY2sgYXQgdGhlIGVuZCBvZiBkb25lIHBhY2tldA0KLS0gDQoyLjE4LjANCg==

