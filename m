Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF37CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF842208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="a4hhT977"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKUJOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:14:03 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50193 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726881AbfKUJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:13:34 -0500
X-UUID: 326f79aba20e44c0ad01e0380af5943f-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sl45dCqyFBghX7iI92Q7u2tkimKd2NiTQVbQ2SfVmoo=;
        b=a4hhT977xgAq4oNGhjgK8g5s/bHR1vuPG1qNvSG9zdcRUvl3gbF98MSGWKRGOBlFVZ71rheeESQbR+toQR7L76y6EPMw7sxM7177zqg4+gxX1LTehnPf4WGUc/CH8xdLcSADmLWFOiWfK7uRwD7A/pTdS6TgXl6S2rwOnhCGkZg=;
X-UUID: 326f79aba20e44c0ad01e0380af5943f-20191121
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 926452641; Thu, 21 Nov 2019 17:13:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 17:13:10 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 17:13:30 +0800
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
Subject: [PATCH v1 10/12] soc: mediatek: cmdq: add loop function
Date:   Thu, 21 Nov 2019 17:12:30 +0800
Message-ID: <1574327552-11806-11-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2C673BA1539CA06C501A936EC27C5308E05B7F846F01518540D3F38435ED2A452000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGZpbmFsaXplIGxvb3AgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNo
IGxvb3Agd2hvbGUgcGt0DQppbiBnY2UgaGFyZHdhcmUgdGhyZWFkIHdpdGhvdXQgY3B1IG9wZXJh
dGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhA
bWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgfCAgIDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51
eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgfCAgICA4ICsrKysrKysNCiAyIGZpbGVzIGNoYW5n
ZWQsIDQ5IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCmluZGV4IDQyMzVjZjguLjNiMTAyNDEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEtaGVscGVyLmMNCkBAIC0zODUsMTIgKzM4NSwyNyBAQCBpbnQgY21kcV9wa3RfYXNzaWduKHN0
cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKQ0KIH0NCiBFWFBPUlRf
U1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQogDQorc3RhdGljIGJvb2wgY21kcV9wa3RfZmluYWxp
emVkKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KK3sNCisJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24g
Kmluc3Q7DQorDQorCWlmIChwa3QtPmNtZF9idWZfc2l6ZSA8IDIgKiBDTURRX0lOU1RfU0laRSkN
CisJCXJldHVybiBmYWxzZTsNCisNCisJaW5zdCA9IHBrdC0+dmFfYmFzZSArIHBrdC0+Y21kX2J1
Zl9zaXplIC0gMiAqIENNRFFfSU5TVF9TSVpFOw0KKwlyZXR1cm4gaW5zdC0+b3AgPT0gQ01EUV9D
T0RFX0VPQzsNCit9DQorDQogc3RhdGljIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21k
cV9wa3QgKnBrdCkNCiB7DQogCXN0cnVjdCBjbWRxX2NsaWVudCAqY2wgPSBwa3QtPmNsOw0KIAlz
dHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCiAJaW50IGVycjsNCiANCisJ
LyogZG8gbm90IGZpbmFsaXplIHR3aWNlICovDQorCWlmIChjbWRxX3BrdF9maW5hbGl6ZWQocGt0
KSkNCisJCXJldHVybiAwOw0KKw0KIAkvKiBpbnNlcnQgRU9DIGFuZCBnZW5lcmF0ZSBJUlEgZm9y
IGVhY2ggY29tbWFuZCBpdGVyYXRpb24gKi8NCiAJaW5zdC5vcCA9IENNRFFfQ09ERV9FT0M7DQog
CWluc3QudmFsdWUgPSBDTURRX0VPQ19JUlFfRU47DQpAQCAtNDA2LDYgKzQyMSwzMiBAQCBzdGF0
aWMgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KIAlyZXR1cm4g
ZXJyOw0KIH0NCiANCitpbnQgY21kcV9wa3RfZmluYWxpemVfbG9vcChzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCkNCit7DQorCXN0cnVjdCBjbWRxX2NsaWVudCAqY2wgPSBwa3QtPmNsOw0KKwlzdHJ1Y3Qg
Y21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCisJaW50IGVycjsNCisNCisJLyogZG8g
bm90IGZpbmFsaXplIHR3aWNlICovDQorCWlmIChjbWRxX3BrdF9maW5hbGl6ZWQocGt0KSkNCisJ
CXJldHVybiAwOw0KKw0KKwkvKiBpbnNlcnQgRU9DIGFuZCBnZW5lcmF0ZSBJUlEgZm9yIGVhY2gg
Y29tbWFuZCBpdGVyYXRpb24gKi8NCisJaW5zdC5vcCA9IENNRFFfQ09ERV9FT0M7DQorCWVyciA9
IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQorCWlmIChlcnIgPCAwKQ0KKwkJ
cmV0dXJuIGVycjsNCisNCisJLyogSlVNUCBhYmFvbHV0ZSB0byBiZWdpbiAqLw0KKwlpbnN0Lm9w
ID0gQ01EUV9DT0RFX0pVTVA7DQorCWluc3Qub2Zmc2V0ID0gMTsNCisJaW5zdC52YWx1ZSA9IHBr
dC0+cGFfYmFzZSA+PiBjbWRxX21ib3hfc2hpZnQoY2wtPmNoYW4pOw0KKwllcnIgPSBjbWRxX3Br
dF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KKw0KKwlyZXR1cm4gZXJyOw0KK30NCitFWFBP
UlRfU1lNQk9MKGNtZHFfcGt0X2ZpbmFsaXplX2xvb3ApOw0KKw0KIHN0YXRpYyB2b2lkIGNtZHFf
cGt0X2ZsdXNoX2FzeW5jX2NiKHN0cnVjdCBjbWRxX2NiX2RhdGEgZGF0YSkNCiB7DQogCXN0cnVj
dCBjbWRxX3BrdCAqcGt0ID0gKHN0cnVjdCBjbWRxX3BrdCAqKWRhdGEuZGF0YTsNCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51
eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggYjM0NzRmMi4uNzdlODk0NCAxMDA2NDQN
Ci0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisrKyBiL2luY2x1
ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0yMDMsNiArMjAzLDE0IEBAIGlu
dCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCiBp
bnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMy
IHZhbHVlKTsNCiANCiAvKioNCisgKiBjbWRxX3BrdF9maW5hbGl6ZV9sb29wKCkgLSBBcHBlbmQg
RU9DIGFuZCBqdW1wIGNvbW1hbmQgdG8gbG9vcCBwa3QuDQorICogQHBrdDoJdGhlIENNRFEgcGFj
a2V0DQorICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUg
aXMgcmV0dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3RfZmluYWxpemVfbG9vcChzdHJ1Y3QgY21k
cV9wa3QgKnBrdCk7DQorDQorLyoqDQogICogY21kcV9wa3RfZmx1c2hfYXN5bmMoKSAtIHRyaWdn
ZXIgQ01EUSB0byBhc3luY2hyb25vdXNseSBleGVjdXRlIHRoZSBDTURRDQogICogICAgICAgICAg
ICAgICAgICAgICAgICAgIHBhY2tldCBhbmQgY2FsbCBiYWNrIGF0IHRoZSBlbmQgb2YgZG9uZSBw
YWNrZXQNCiAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCi0tIA0KMS43LjkuNQ0K

