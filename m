Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030FDC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7597207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iKzVmiHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfK0B7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:59:20 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:15799 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725916AbfK0B7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:17 -0500
X-UUID: 00728d1ab0794a33b986612d0a0fd555-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PYIwIuk2a4HwtorK3uB9aRFFhcSveovGL5ox0ges0WA=;
        b=iKzVmiHjVnuozZ5fQsTcU1aeykrpaQVyyW+YGfMQKyUCwDfEQDeasYvXN+L1zlP6C2cgBhBPAUruKaMzI7iruR1Ec6AugMmbWCu0fJT0e6y4D82slde0Lf2ueAPYR5AJkxyd7cun52cFyc/LIzmWkD+nsyzGkXs4r2SQm+vwozA=;
X-UUID: 00728d1ab0794a33b986612d0a0fd555-20191127
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1771918900; Wed, 27 Nov 2019 09:59:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:58:58 +0800
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
Subject: [PATCH v2 11/14] soc: mediatek: cmdq: export finalize function
Date:   Wed, 27 Nov 2019 09:58:54 +0800
Message-ID: <1574819937-6246-13-git-send-email-dennis-yc.hsieh@mediatek.com>
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

RXhwb3J0IGZpbmFsaXplIGZ1bmN0aW9uIHRvIGNsaWVudCB3aGljaCBoZWxwcyBhcHBlbmQgZW9j
IGFuZCBqdW1wDQpjb21tYW5kIHRvIHBrdC4NCg0KU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhz
aWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgfCA3ICsrLS0tLS0NCiBpbmNsdWRlL2xpbnV4L3NvYy9t
ZWRpYXRlay9tdGstY21kcS5oICB8IDggKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jDQppbmRleCAyNDRiODUyOGViMTYuLjM4ZTBjMTNlMTkyMiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTM5Miw3ICszOTIsNyBAQCBpbnQgY21k
cV9wa3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVl
KQ0KIH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQogDQotc3RhdGljIGludCBj
bWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCkNCitpbnQgY21kcV9wa3RfZmlu
YWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQogew0KIAlzdHJ1Y3QgY21kcV9jbGllbnQgKmNs
ID0gcGt0LT5jbDsNCiAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQpA
QCAtNDEyLDYgKzQxMiw3IEBAIHN0YXRpYyBpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNt
ZHFfcGt0ICpwa3QpDQogDQogCXJldHVybiBlcnI7DQogfQ0KK0VYUE9SVF9TWU1CT0woY21kcV9w
a3RfZmluYWxpemUpOw0KIA0KIHN0YXRpYyB2b2lkIGNtZHFfcGt0X2ZsdXNoX2FzeW5jX2NiKHN0
cnVjdCBjbWRxX2NiX2RhdGEgZGF0YSkNCiB7DQpAQCAtNDQ2LDEwICs0NDcsNiBAQCBpbnQgY21k
cV9wa3RfZmx1c2hfYXN5bmMoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGNtZHFfYXN5bmNfZmx1c2hf
Y2IgY2IsDQogCXVuc2lnbmVkIGxvbmcgZmxhZ3MgPSAwOw0KIAlzdHJ1Y3QgY21kcV9jbGllbnQg
KmNsaWVudCA9IChzdHJ1Y3QgY21kcV9jbGllbnQgKilwa3QtPmNsOw0KIA0KLQllcnIgPSBjbWRx
X3BrdF9maW5hbGl6ZShwa3QpOw0KLQlpZiAoZXJyIDwgMCkNCi0JCXJldHVybiBlcnI7DQotDQog
CXBrdC0+Y2IuY2IgPSBjYjsNCiAJcGt0LT5jYi5kYXRhID0gZGF0YTsNCiAJcGt0LT5hc3luY19j
Yi5jYiA9IGNtZHFfcGt0X2ZsdXNoX2FzeW5jX2NiOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9t
dGstY21kcS5oDQppbmRleCA0YmNlMjQwZGJiNTYuLjk5OGJjOTBmOWRhOSAxMDA2NDQNCi0tLSBh
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisrKyBiL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0yMDQsNiArMjA0LDE0IEBAIGludCBjbWRx
X3BrdF9wb2xsX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCiAgKi8NCiBp
bnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMy
IHZhbHVlKTsNCiANCisvKioNCisgKiBjbWRxX3BrdF9maW5hbGl6ZSgpIC0gQXBwZW5kIEVPQyBh
bmQganVtcCBjb21tYW5kIHRvIHBrdC4NCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCisgKg0K
KyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5l
ZA0KKyAqLw0KK2ludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCk7DQor
DQogLyoqDQogICogY21kcV9wa3RfZmx1c2hfYXN5bmMoKSAtIHRyaWdnZXIgQ01EUSB0byBhc3lu
Y2hyb25vdXNseSBleGVjdXRlIHRoZSBDTURRDQogICogICAgICAgICAgICAgICAgICAgICAgICAg
IHBhY2tldCBhbmQgY2FsbCBiYWNrIGF0IHRoZSBlbmQgb2YgZG9uZSBwYWNrZXQNCi0tIA0KMi4x
OC4wDQo=

