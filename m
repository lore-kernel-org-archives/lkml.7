Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B3BC33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A78207FD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MITXeOuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgAEKrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:47:25 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:30582 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727146AbgAEKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:47:23 -0500
X-UUID: 86d7b78ae4e544b3ad684d7baaf68ab6-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=19qaQnoV6yRHuMfo5UJqrDyTeI5nPaBleiGqUf3+VGg=;
        b=MITXeOuZAI+sK6fOr2Dos2HEu6uAKDc6YB/rIraiCkq0PhqTVjA+dpjbxJQM5fbD1CtKmmey/l6UftLqntup5rDjuyToxv003iQrvuKJ8BzFdA7QmzTI0tqE7GlF2IY02bSqcNpOlSOH49osjsOUGuptUA6OKIUO2rj5Cmdud1c=;
X-UUID: 86d7b78ae4e544b3ad684d7baaf68ab6-20200105
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 971568944; Sun, 05 Jan 2020 18:47:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:49 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:47 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>,
        Cui Zhang <zhang.cui@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Anan Sun <anan.sun@mediatek.com>
Subject: [PATCH v2 17/19] iommu/mediatek: Add iova reserved function
Date:   Sun, 5 Jan 2020 18:45:21 +0800
Message-ID: <20200105104523.31006-18-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200105104523.31006-1-chao.hao@mediatek.com>
References: <20200105104523.31006-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIG11bHRpcGxlIGlvbW11X2RvbWFpbnMsIHdlIG5lZWQgdG8gcmVzZXJ2ZSBzb21lIGlvdmEN
CnJlZ2lvbnMsIHNvIHdlIHdpbGwgYWRkIG10a19pb21tdV9yZXN2X2lvdmFfcmVnaW9uIHN0cnVj
dHVyZS4NCkl0IGluY2x1ZGVzIHRoZSBzdGFydCBhZGRyZXNzIGFuZCBzaXplIG9mIGlvdmEgYW5k
IGlvbW11X3Jlc3ZfdHlwZS4NCkJhc2VkIG9uIHRoZSBmdW5jdGlvbiwgd2Ugd2lsbCByZWFsaXpl
IG11bHRpcGxlIG10a19pb21tdV9kb21haW5zDQoNClNpZ25lZC1vZmYtYnk6IEFuYW4gU3VuIDxh
bmFuLnN1bkBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaGFvIEhhbyA8Y2hhby5oYW9A
bWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDQ3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmggfCAxMiArKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCsp
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYw0KaW5kZXggOWE3ZjJhMzg4ZTNlLi5hYzY1OGZhMTYxMzYgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQpAQCAtNjkxLDYgKzY5MSw1MSBAQCBzdGF0aWMgaW50IG10a19pb21tdV9vZl94bGF0
ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmFyZ3MpDQogCXJl
dHVybiBpb21tdV9md3NwZWNfYWRkX2lkcyhkZXYsIGFyZ3MtPmFyZ3MsIDEpOw0KIH0NCiANCisv
KiByZXNlcnZlL2Rpci1tYXAgaW92YSByZWdpb24gKi8NCitzdGF0aWMgdm9pZCBtdGtfaW9tbXVf
Z2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQorCQkJCSAgICAgICBzdHJ1Y3Qg
bGlzdF9oZWFkICpoZWFkKQ0KK3sNCisJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhID0gZGV2
X2lvbW11X2Z3c3BlY19nZXQoZGV2KS0+aW9tbXVfcHJpdjsNCisJdW5zaWduZWQgaW50IGksIHRv
dGFsX2NudCA9IGRhdGEtPnBsYXRfZGF0YS0+cmVzdl9jbnQ7DQorCWNvbnN0IHN0cnVjdCBtdGtf
aW9tbXVfcmVzdl9pb3ZhX3JlZ2lvbiAqcmVzdl9kYXRhOw0KKwlzdHJ1Y3QgaW9tbXVfcmVzdl9y
ZWdpb24gKnJlZ2lvbjsNCisJdW5zaWduZWQgbG9uZyBiYXNlID0gMDsNCisJc2l6ZV90IHNpemUg
PSAwOw0KKwlpbnQgcHJvdCA9IElPTU1VX1dSSVRFIHwgSU9NTVVfUkVBRDsNCisNCisJcmVzdl9k
YXRhID0gZGF0YS0+cGxhdF9kYXRhLT5yZXN2X3JlZ2lvbjsNCisNCisJZm9yIChpID0gMDsgaSA8
IHRvdGFsX2NudDsgaSsrKSB7DQorCQlzaXplID0gMDsNCisJCWlmIChyZXN2X2RhdGFbaV0uaW92
YV9zaXplKSB7DQorCQkJYmFzZSA9ICh1bnNpZ25lZCBsb25nKXJlc3ZfZGF0YVtpXS5pb3ZhX2Jh
c2U7DQorCQkJc2l6ZSA9IHJlc3ZfZGF0YVtpXS5pb3ZhX3NpemU7DQorCQl9DQorCQlpZiAoIXNp
emUpDQorCQkJY29udGludWU7DQorDQorCQlyZWdpb24gPSBpb21tdV9hbGxvY19yZXN2X3JlZ2lv
bihiYXNlLCBzaXplLCBwcm90LA0KKwkJCQkJCSByZXN2X2RhdGFbaV0udHlwZSk7DQorCQlpZiAo
IXJlZ2lvbikNCisJCQlyZXR1cm47DQorDQorCQlsaXN0X2FkZF90YWlsKCZyZWdpb24tPmxpc3Qs
IGhlYWQpOw0KKw0KKwkJZGV2X2RiZyhkYXRhLT5kZXYsICIlcyBpb3ZhIDB4JXggfiAweCV4XG4i
LA0KKwkJCShyZXN2X2RhdGFbaV0udHlwZSA9PSBJT01NVV9SRVNWX0RJUkVDVCkgPyAiZG0iIDog
InJzdiIsDQorCQkJKHVuc2lnbmVkIGludCliYXNlLCAodW5zaWduZWQgaW50KShiYXNlICsgc2l6
ZSAtIDEpKTsNCisJfQ0KK30NCisNCitzdGF0aWMgdm9pZCBtdGtfaW9tbXVfcHV0X3Jlc3ZfcmVn
aW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQorCQkJCSAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICpo
ZWFkKQ0KK3sNCisJc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uICplbnRyeSwgKm5leHQ7DQorDQor
CWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShlbnRyeSwgbmV4dCwgaGVhZCwgbGlzdCkNCisJCWtm
cmVlKGVudHJ5KTsNCit9DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgbXRrX2lv
bW11X29wcyA9IHsNCiAJLmRvbWFpbl9hbGxvYwk9IG10a19pb21tdV9kb21haW5fYWxsb2MsDQog
CS5kb21haW5fZnJlZQk9IG10a19pb21tdV9kb21haW5fZnJlZSwNCkBAIC03MDUsNiArNzUwLDgg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgbXRrX2lvbW11X29wcyA9IHsNCiAJLnJl
bW92ZV9kZXZpY2UJPSBtdGtfaW9tbXVfcmVtb3ZlX2RldmljZSwNCiAJLmRldmljZV9ncm91cAk9
IG10a19pb21tdV9kZXZpY2VfZ3JvdXAsDQogCS5vZl94bGF0ZQk9IG10a19pb21tdV9vZl94bGF0
ZSwNCisJLmdldF9yZXN2X3JlZ2lvbnMgPSBtdGtfaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucywNCisJ
LnB1dF9yZXN2X3JlZ2lvbnMgPSBtdGtfaW9tbXVfcHV0X3Jlc3ZfcmVnaW9ucywNCiAJLnBnc2l6
ZV9iaXRtYXAJPSBTWl80SyB8IFNaXzY0SyB8IFNaXzFNIHwgU1pfMTZNLA0KIH07DQogDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmgNCmluZGV4IGEzOGIyNjAxOGFiZS4uN2Y0ZDQ5OGVjNWY2IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuaA0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0K
QEAgLTM2LDYgKzM2LDEyIEBAIGVudW0gbXRrX2lvbW11X3BsYXQgew0KIAlNNFVfTVQ4MTgzLA0K
IH07DQogDQorc3RydWN0IG10a19pb21tdV9yZXN2X2lvdmFfcmVnaW9uIHsNCisJZG1hX2FkZHJf
dAkJaW92YV9iYXNlOw0KKwlzaXplX3QJCQlpb3ZhX3NpemU7DQorCWVudW0gaW9tbXVfcmVzdl90
eXBlCXR5cGU7DQorfTsNCisNCiAvKg0KICAqIHJlc2VydmVkIElPVkEgRG9tYWluIGZvciBJT01N
VSB1c2VycyBvZiBIVyBsaW1pdGF0aW9uLg0KICAqLw0KQEAgLTY4LDYgKzc0LDEyIEBAIHN0cnVj
dCBtdGtfaW9tbXVfcGxhdF9kYXRhIHsNCiAJdTMyICAgICAgICAgICAgICAgICBpbnZfc2VsX3Jl
ZzsNCiAJdW5zaWduZWQgY2hhciAgICAgICBsYXJiaWRfcmVtYXBbMl1bTVRLX0xBUkJfTlJfTUFY
XTsNCiAJY29uc3Qgc3RydWN0IG10a19kb21haW5fZGF0YQkqZG9tX2RhdGE7DQorCS8qDQorCSAq
IHJlc2VydmUvZGlyLW1hcHBpbmcgaW92YSByZWdpb24gZGF0YQ0KKwkgKiB0b2RvOiBmb3IgZGlm
ZmVyZW50IHJlc2VydmUgbmVlZHMgb24gbXVsdGlwbGUgaW9tbXUgZG9tYWlucw0KKwkgKi8NCisJ
Y29uc3QgdW5zaWduZWQgaW50ICByZXN2X2NudDsNCisJY29uc3Qgc3RydWN0IG10a19pb21tdV9y
ZXN2X2lvdmFfcmVnaW9uICpyZXN2X3JlZ2lvbjsNCiB9Ow0KIA0KIHN0cnVjdCBtdGtfaW9tbXVf
ZG9tYWluOw0KLS0gDQoyLjE4LjANCg==

