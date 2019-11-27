Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656B0C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34560207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="S+7mIb+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfK0CAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:00:14 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:15799 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725883AbfK0B7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:18 -0500
X-UUID: 2164318353b34eb88fb4b0aa0ffcad3c-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ksFxZva0yVyymup3TRMDbaiPXfXSkUQBZI0ZSgsXP+c=;
        b=S+7mIb+8h4Kfl6gMBg+GgRIhy2I/Yjun1rCG+TnowbpL5HafgIccFMaZu9rGrBGTAHz2Qodb9s+e7EKEtc30mXEe/4+XnpTlSNpbl1j/AQenz29OPeduC4AQO0RXzWm0i1oN+Fk2mFU3uIeSxCukXvx974mOkfOuPgDQ6uvm90s=;
X-UUID: 2164318353b34eb88fb4b0aa0ffcad3c-20191127
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 311223207; Wed, 27 Nov 2019 09:59:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:59:00 +0800
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
Subject: [PATCH v2 09/14] soc: mediatek: cmdq: add read_s function
Date:   Wed, 27 Nov 2019 09:58:52 +0800
Message-ID: <1574819937-6246-11-git-send-email-dennis-yc.hsieh@mediatek.com>
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

QWRkIHJlYWRfcyBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgd2hpY2ggc3VwcG9y
dCByZWFkIHZhbHVlIGZyb20NCnJlZ2lzdGVyIG9yIGRtYSBwaHlzaWNhbCBhZGRyZXNzIGludG8g
Z2NlIGludGVybmFsIHJlZ2lzdGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWgg
PGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYyAgIHwgMjAgKysrKysrKysrKysrKysrKysrKysNCiBpbmNsdWRl
L2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgIDEgKw0KIGluY2x1ZGUvbGludXgv
c29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCAxMCArKysrKysrKysrDQogMyBmaWxlcyBjaGFu
Z2VkLCAzMSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jDQppbmRleCAyZWRiYzA5NTRkOTcuLjJjZDY5M2UzNDk4MCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTIzMSw2ICsyMzEsMjYgQEAgaW50IGNtZHFfcGt0
X3dyaXRlX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCiB9DQogRVhQT1JU
X1NZTUJPTChjbWRxX3BrdF93cml0ZV9tYXNrKTsNCiANCitpbnQgY21kcV9wa3RfcmVhZF9zKHN0
cnVjdCBjbWRxX3BrdCAqcGt0LCBwaHlzX2FkZHJfdCBhZGRyLCB1MTYgcmVnX2lkeCkNCit7DQor
CXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKwlpbnQgZXJyOw0KKwlj
b25zdCB1MTYgc3JjX3JlZ19pZHggPSBDTURRX1NQUl9URU1QOw0KKw0KKwllcnIgPSBjbWRxX3Br
dF9hc3NpZ24ocGt0LCBzcmNfcmVnX2lkeCwgQ01EUV9BRERSX0hJR0goYWRkcikpOw0KKwlpZiAo
ZXJyIDwgMCkNCisJCXJldHVybiBlcnI7DQorDQorCWluc3Qub3AgPSBDTURRX0NPREVfUkVBRF9T
Ow0KKwlpbnN0LmRzdF90ID0gQ01EUV9SRUdfVFlQRTsNCisJaW5zdC5zb3AgPSBzcmNfcmVnX2lk
eDsNCisJaW5zdC5yZWdfZHN0ID0gcmVnX2lkeDsNCisJaW5zdC5hcmdfYiA9IENNRFFfQUREUl9M
T1coYWRkcik7DQorDQorCXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3Qp
Ow0KK30NCitFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3JlYWRfcyk7DQorDQogaW50IGNtZHFfcGt0
X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHBoeXNfYWRkcl90IGFkZHIsIHUxNiByZWdf
aWR4LA0KIAkJICAgICB1MzIgbWFzaykNCiB7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9t
YWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmgNCmluZGV4IDhlZjg3ZTFiZDAzYi4uM2Y2YmMwZGZkNWRhIDEwMDY0NA0KLS0t
IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KKysrIGIvaW5jbHVk
ZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KQEAgLTU5LDYgKzU5LDcgQEAgZW51
bSBjbWRxX2NvZGUgew0KIAlDTURRX0NPREVfSlVNUCA9IDB4MTAsDQogCUNNRFFfQ09ERV9XRkUg
PSAweDIwLA0KIAlDTURRX0NPREVfRU9DID0gMHg0MCwNCisJQ01EUV9DT0RFX1JFQURfUyA9IDB4
ODAsDQogCUNNRFFfQ09ERV9XUklURV9TID0gMHg5MCwNCiAJQ01EUV9DT0RFX1dSSVRFX1NfTUFT
SyA9IDB4OTEsDQogCUNNRFFfQ09ERV9MT0dJQyA9IDB4YTAsDQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL210ay1jbWRxLmgNCmluZGV4IDU2ZmYxOTcwMTk3Yy4uYmMyOGE0MWQ3NzgwIDEwMDY0NA0K
LS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KKysrIGIvaW5jbHVk
ZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KQEAgLTEwNiw2ICsxMDYsMTYgQEAgaW50
IGNtZHFfcGt0X3dyaXRlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsIHUxNiBvZmZz
ZXQsIHUzMiB2YWx1ZSk7DQogaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHU4IHN1YnN5cywNCiAJCQl1MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsN
CiANCisvKioNCisgKiBjbWRxX3BrdF9yZWFkX3MoKSAtIGFwcGVuZCByZWFkX3MgY29tbWFuZCB0
byB0aGUgQ01EUSBwYWNrZXQNCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCisgKiBAYWRkcjoJ
dGhlIHBoeXNpY2FsIGFkZHJlc3Mgb2YgcmVnaXN0ZXIgb3IgZG1hIHRvIHJlYWQNCisgKiBAcmVn
X2lkeDoJdGhlIENNRFEgaW50ZXJuYWwgcmVnaXN0ZXIgSUQgdG8gY2FjaGUgcmVhZCBkYXRhDQor
ICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0
dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3RfcmVhZF9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBw
aHlzX2FkZHJfdCBhZGRyLCB1MTYgcmVnX2lkeCk7DQorDQogLyoqDQogICogY21kcV9wa3Rfd3Jp
dGVfc19tYXNrKCkgLSBhcHBlbmQgd3JpdGVfcyBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0K
ICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KLS0gDQoyLjE4LjANCg==

