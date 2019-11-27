Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6CAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93822084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rLwomFl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfK0B7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:59:47 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:15799 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727192AbfK0B7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:21 -0500
X-UUID: 19253cbffc3348779d6e5eda30005743-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3bmvDHDyrJS/9qz2LSdf3v6P9HJ6pP8KayJjB11i2U8=;
        b=rLwomFl6H1LsHDRgH0F2TMta54Wel1dsE29m2WvDOv33B4pLURCSz7BUESh5fswrUW2HLQEij2nlAjQ81li/EH678EyDyq1E/C8FI7+MAZ4eb524xL5C4tjtfP7OzhiL5NizR/feFPz6vE+L5BwXz2VCljn9AV9d95rx4gcLT+k=;
X-UUID: 19253cbffc3348779d6e5eda30005743-20191127
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 403712291; Wed, 27 Nov 2019 09:59:11 +0800
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
Subject: [PATCH v2 12/14] soc: mediatek: cmdq: add loop function
Date:   Wed, 27 Nov 2019 09:58:55 +0800
Message-ID: <1574819937-6246-14-git-send-email-dennis-yc.hsieh@mediatek.com>
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

QWRkIGZpbmFsaXplIGxvb3AgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNo
IGxvb3Agd2hvbGUgcGt0DQppbiBnY2UgaGFyZHdhcmUgdGhyZWFkIHdpdGhvdXQgY3B1IG9wZXJh
dGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhA
bWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaCAgfCAgOCArKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVs
cGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXggMzhl
MGMxM2UxOTIyLi4xMGE5YjQ0ODFlNTggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEt
aGVscGVyLmMNCkBAIC00MTQsNiArNDE0LDI4IEBAIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1
Y3QgY21kcV9wa3QgKnBrdCkNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9maW5hbGl6ZSk7
DQogDQoraW50IGNtZHFfcGt0X2ZpbmFsaXplX2xvb3Aoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQor
ew0KKwlzdHJ1Y3QgY21kcV9jbGllbnQgKmNsID0gcGt0LT5jbDsNCisJc3RydWN0IGNtZHFfaW5z
dHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQorCWludCBlcnI7DQorDQorCS8qIGluc2VydCBFT0Mg
YW5kIGdlbmVyYXRlIElSUSBmb3IgZWFjaCBjb21tYW5kIGl0ZXJhdGlvbiAqLw0KKwlpbnN0Lm9w
ID0gQ01EUV9DT0RFX0VPQzsNCisJZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBp
bnN0KTsNCisJaWYgKGVyciA8IDApDQorCQlyZXR1cm4gZXJyOw0KKw0KKwkvKiBKVU1QIGFiYW9s
dXRlIHRvIGJlZ2luICovDQorCWluc3Qub3AgPSBDTURRX0NPREVfSlVNUDsNCisJaW5zdC5vZmZz
ZXQgPSAxOw0KKwlpbnN0LnZhbHVlID0gcGt0LT5wYV9iYXNlID4+IGNtZHFfbWJveF9zaGlmdChj
bC0+Y2hhbik7DQorCWVyciA9IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQor
DQorCXJldHVybiBlcnI7DQorfQ0KK0VYUE9SVF9TWU1CT0woY21kcV9wa3RfZmluYWxpemVfbG9v
cCk7DQorDQogc3RhdGljIHZvaWQgY21kcV9wa3RfZmx1c2hfYXN5bmNfY2Ioc3RydWN0IGNtZHFf
Y2JfZGF0YSBkYXRhKQ0KIHsNCiAJc3RydWN0IGNtZHFfcGt0ICpwa3QgPSAoc3RydWN0IGNtZHFf
cGt0ICopZGF0YS5kYXRhOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVr
L210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRl
eCA5OThiYzkwZjlkYTkuLmQxNWQ4Yzk0MTk5MiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgv
c29jL21lZGlhdGVrL210ay1jbWRxLmgNCisrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVr
L210ay1jbWRxLmgNCkBAIC0yMTIsNiArMjEyLDE0IEBAIGludCBjbWRxX3BrdF9hc3NpZ24oc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpOw0KICAqLw0KIGludCBj
bWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCk7DQogDQorLyoqDQorICogY21k
cV9wa3RfZmluYWxpemVfbG9vcCgpIC0gQXBwZW5kIEVPQyBhbmQganVtcCBjb21tYW5kIHRvIGxv
b3AgcGt0Lg0KKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KKyAqDQorICogUmV0dXJuOiAwIGZv
ciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQorICovDQoraW50IGNt
ZHFfcGt0X2ZpbmFsaXplX2xvb3Aoc3RydWN0IGNtZHFfcGt0ICpwa3QpOw0KKw0KIC8qKg0KICAq
IGNtZHFfcGt0X2ZsdXNoX2FzeW5jKCkgLSB0cmlnZ2VyIENNRFEgdG8gYXN5bmNocm9ub3VzbHkg
ZXhlY3V0ZSB0aGUgQ01EUQ0KICAqICAgICAgICAgICAgICAgICAgICAgICAgICBwYWNrZXQgYW5k
IGNhbGwgYmFjayBhdCB0aGUgZW5kIG9mIGRvbmUgcGFja2V0DQotLSANCjIuMTguMA0K

