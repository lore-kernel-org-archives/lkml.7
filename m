Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE31C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2002068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MtW8448U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfK0B71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:59:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:8751 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727208AbfK0B7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:22 -0500
X-UUID: 89f9e712458143d5b34a774dfcbfa630-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IWV6i4XvbNsjDusAu0aWVFucdSP8lwDUrIG+cdBLhtE=;
        b=MtW8448UlV2blWcGciVPdas11KprBwumXkZe0LGS3pxz29MlToVIM+WAluHO8RLX7AgPmRPqpoFPfEhrlKpkZATfSl/sLMtO7UzD6vDVBoXuXID3NKtHhBrqx3xF/GbUn6HT/ryMURn0SlW2cssNAw+GzTLV4jLjvfPB1Vt7zr0=;
X-UUID: 89f9e712458143d5b34a774dfcbfa630-20191127
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 589041665; Wed, 27 Nov 2019 09:59:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:58:45 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Nov 2019 09:58:20 +0800
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
Subject: [PATCH v2 14/14] soc: mediatek: cmdq: add set event function
Date:   Wed, 27 Nov 2019 09:58:57 +0800
Message-ID: <1574819937-6246-16-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C035F1AD24EF99F5DCAC69C08201CE2B3B8D6D4B7766512DE3B8DB859AFF436D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHNldCBldmVudCBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgdG8gc2V0IHNw
ZWNpZmljIGV2ZW50Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15
Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYyAgIHwgMTUgKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9tYWlsYm94
L210ay1jbWRxLW1haWxib3guaCB8ICAxICsNCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9t
dGstY21kcS5oICAgIHwgIDkgKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRleCA2ZjI3
MGZhZGZiNTAuLjA3YzZlY2M3NWJkZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYw0KQEAgLTM2MCw2ICszNjAsMjEgQEAgaW50IGNtZHFfcGt0X2NsZWFyX2V2ZW50KHN0
cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQogfQ0KIEVYUE9SVF9TWU1CT0woY21kcV9w
a3RfY2xlYXJfZXZlbnQpOw0KIA0KK2ludCBjbWRxX3BrdF9zZXRfZXZlbnQoc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHUxNiBldmVudCkNCit7DQorCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3Qg
PSB7IHswfSB9Ow0KKw0KKwlpZiAoZXZlbnQgPj0gQ01EUV9NQVhfRVZFTlQpDQorCQlyZXR1cm4g
LUVJTlZBTDsNCisNCisJaW5zdC5vcCA9IENNRFFfQ09ERV9XRkU7DQorCWluc3QudmFsdWUgPSBD
TURRX1dGRV9VUERBVEUgfCBDTURRX1dGRV9VUERBVEVfVkFMVUU7DQorCWluc3QuZXZlbnQgPSBl
dmVudDsNCisNCisJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQor
fQ0KK0VYUE9SVF9TWU1CT0woY21kcV9wa3Rfc2V0X2V2ZW50KTsNCisNCiBpbnQgY21kcV9wa3Rf
cG9sbChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KIAkJICB1MTYgb2Zmc2V0LCB1
MzIgdmFsdWUpDQogew0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQpp
bmRleCAzZjZiYzBkZmQ1ZGEuLmRiZWRkYTZjZmE5MSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGlu
dXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCisrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJv
eC9tdGstY21kcS1tYWlsYm94LmgNCkBAIC0xNyw2ICsxNyw3IEBADQogI2RlZmluZSBDTURRX0pV
TVBfUEFTUwkJCUNNRFFfSU5TVF9TSVpFDQogDQogI2RlZmluZSBDTURRX1dGRV9VUERBVEUJCQlC
SVQoMzEpDQorI2RlZmluZSBDTURRX1dGRV9VUERBVEVfVkFMVUUJCUJJVCgxNikNCiAjZGVmaW5l
IENNRFFfV0ZFX1dBSVQJCQlCSVQoMTUpDQogI2RlZmluZSBDTURRX1dGRV9XQUlUX1ZBTFVFCQkw
eDENCiANCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
IGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggNDBiYzYxYWQ4
ZDMxLi5mMTE0NGZhYWI1ODIgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRl
ay9tdGstY21kcS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
DQpAQCAtMTY4LDYgKzE2OCwxNSBAQCBpbnQgY21kcV9wa3Rfd2FpdF9ub19jbGVhcihzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KTsNCiAgKi8NCiBpbnQgY21kcV9wa3RfY2xlYXJfZXZl
bnQoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCk7DQogDQorLyoqDQorICogY21kcV9w
a3Rfc2V0X2V2ZW50KCkgLSBhcHBlbmQgc2V0IGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFj
a2V0DQorICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQorICogQGV2ZW50Ogl0aGUgZGVzaXJlZCBl
dmVudCB0byBiZSBzZXQNCisgKg0KKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUg
ZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KKyAqLw0KK2ludCBjbWRxX3BrdF9zZXRfZXZlbnQoc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCk7DQorDQogLyoqDQogICogY21kcV9wa3RfcG9s
bCgpIC0gQXBwZW5kIHBvbGxpbmcgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQsIGFzayBHQ0Ug
dG8NCiAgKgkJICAgICBleGVjdXRlIGFuIGluc3RydWN0aW9uIHRoYXQgd2FpdCBmb3IgYSBzcGVj
aWZpZWQNCi0tIA0KMi4xOC4wDQo=

