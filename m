Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7436C3276F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECC8222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iiYkmAtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgACDM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:12:58 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:14219 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727465AbgACDMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:52 -0500
X-UUID: 12fe592314fa4e2b964da5794766b67e-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XusF8Ts9LN5UhbHZ+74X0JmLoWRa5qIY53E/4dHFrN4=;
        b=iiYkmAtxvAgi8PTPyl3FabgyJSuG5BweAp3v4oBXSWKdkHGsJDwH9C3AT5jWvmHsDXeSzKoQC2GajgB5wH/YfAClHspIO9eW7RtNGZs2m9YDqV4SLZJ7+Ft79VlTcetQvyfiYlJ1mTWQEWYsvhVvQEr/iSm6LOmC3rMQeHeMZcQ=;
X-UUID: 12fe592314fa4e2b964da5794766b67e-20200103
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1321566217; Fri, 03 Jan 2020 11:12:45 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:11 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [RESEND PATCH v6 09/17] drm/mediatek: add connection from OVL0 to OVL_2L0
Date:   Fri, 3 Jan 2020 11:12:20 +0800
Message-ID: <1578021148-32413-10-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgY29ubmVjdGlvbiBmcm9tIE9WTDAgdG8gT1ZMXzJMMA0KDQpTaWduZWQt
b2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NClJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwLmMgfCA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KaW5kZXgg
MjA1YzYyYS4uM2ExYWE5YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAu
Yw0KQEAgLTEzNyw2ICsxMzcsOCBAQA0KICNkZWZpbmUgRFBJX1NFTF9JTl9CTFMJCQkweDANCiAj
ZGVmaW5lIERTSV9TRUxfSU5fUkRNQQkJCTB4MQ0KIA0KKyNkZWZpbmUgT1ZMMF9NT1VUX0VOX09W
TDBfMkwJCUJJVCg0KQ0KKw0KIHN0cnVjdCBtdGtfZGlzcF9tdXRleCB7DQogCWludCBpZDsNCiAJ
Ym9vbCBjbGFpbWVkOw0KQEAgLTMwMCw2ICszMDIsOSBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG10
a19kZHBfbW91dF9lbihjb25zdCBzdHJ1Y3QgbXRrX21tc3lzX3JlZ19kYXRhICpkYXRhLA0KIAl9
IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX09EMSAmJiBuZXh0ID09IEREUF9DT01QT05F
TlRfUkRNQTEpIHsNCiAJCSphZGRyID0gRElTUF9SRUdfQ09ORklHX0RJU1BfT0RfTU9VVF9FTjsN
CiAJCXZhbHVlID0gT0QxX01PVVRfRU5fUkRNQTE7DQorCX0gZWxzZSBpZiAoY3VyID09IEREUF9D
T01QT05FTlRfT1ZMMCAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfT1ZMXzJMMCkgew0KKwkJKmFk
ZHIgPSBkYXRhLT5vdmwwX21vdXRfZW47DQorCQl2YWx1ZSA9IE9WTDBfTU9VVF9FTl9PVkwwXzJM
Ow0KIAl9IGVsc2Ugew0KIAkJdmFsdWUgPSAwOw0KIAl9DQotLSANCjEuOC4xLjEuZGlydHkNCg==

