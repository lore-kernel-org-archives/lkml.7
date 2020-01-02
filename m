Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A3C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABCF20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="o3jzMvp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgABECf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:02:35 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:22585 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727686AbgABECb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:02:31 -0500
X-UUID: 1bd8b0d9da7748a3b90a729d83c0162f-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IiiRHn3R6Js4Pvfh8uoHNNErfFDcDFJoVtSH9d23T4Y=;
        b=o3jzMvp86ezHPjkQT3ialNLQ97VPsiPiGH0a/i0i+UFjUEZd+NyKhMgtzz23z01vGKyRx/k3g+XCkSULEVlha/a06SdzAegmxxQgKW894G6dEXzgPDvqgy2oQ6JXu4ysG6Bbq8OGP5G7HSRO9XALRHjc0WBhLgKk5Yb1fNQcOnk=;
X-UUID: 1bd8b0d9da7748a3b90a729d83c0162f-20200102
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 490112433; Thu, 02 Jan 2020 12:02:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 12:01:56 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 12:01:40 +0800
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
Subject: [PATCH v6, 09/14] drm/mediatek: add connection from OVL_2L0 to RDMA0
Date:   Thu, 2 Jan 2020 12:00:19 +0800
Message-ID: <1577937624-14313-10-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dGhpcyBwYXRjaCBhZGQgYWRkIGNvbm5lY3Rpb24gZnJvbSBPVkxfMkwwIHRvIFJETUEwDQoNClNp
Z25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0K
UmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYyB8IDE0ICsrKysrKysrKysrKysrDQogMSBmaWxl
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwLmMNCmluZGV4IGJiNDE1OTQuLmE2ZmVkN2IgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZGRwLmMNCkBAIC0zMyw2ICszMywxMiBAQA0KICNkZWZpbmUgRElTUF9SRUdf
Q09ORklHX0RTSV9TRUwJCQkweDA1MA0KICNkZWZpbmUgRElTUF9SRUdfQ09ORklHX0RQSV9TRUwJ
CQkweDA2NA0KIA0KKyNkZWZpbmUgTVQ4MTgzX0RJU1BfT1ZMMF8yTF9NT1VUX0VOCQkweGYwNA0K
KyNkZWZpbmUgTVQ4MTgzX0RJU1BfUEFUSDBfU0VMX0lOCQkweGYyNA0KKw0KKyNkZWZpbmUgT1ZM
MF8yTF9NT1VUX0VOX0RJU1BfUEFUSDAJCQlCSVQoMCkNCisjZGVmaW5lIERJU1BfUEFUSDBfU0VM
X0lOX09WTDBfMkwJCQkweDENCisNCiAjZGVmaW5lIE1UMjcwMV9ESVNQX01VVEVYMF9NT0QwCQkJ
MHgyYw0KICNkZWZpbmUgTVQyNzAxX0RJU1BfTVVURVgwX1NPRjAJCQkweDMwDQogDQpAQCAtMzA4
LDYgKzMxNCwxMCBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG10a19kZHBfbW91dF9lbihjb25zdCBz
dHJ1Y3QgbXRrX21tc3lzX3JlZ19kYXRhICpkYXRhLA0KIAl9IGVsc2UgaWYgKGN1ciA9PSBERFBf
Q09NUE9ORU5UX09WTDAgJiYgbmV4dCA9PSBERFBfQ09NUE9ORU5UX09WTF8yTDApIHsNCiAJCSph
ZGRyID0gZGF0YS0+b3ZsMF9tb3V0X2VuOw0KIAkJdmFsdWUgPSBPVkwwX01PVVRfRU5fT1ZMMF8y
TDsNCisJfSBlbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVOVF9PVkxfMkwwICYmDQorCQkgICBu
ZXh0ID09IEREUF9DT01QT05FTlRfUkRNQTApIHsNCisJCSphZGRyID0gTVQ4MTgzX0RJU1BfT1ZM
MF8yTF9NT1VUX0VOOw0KKwkJdmFsdWUgPSBPVkwwXzJMX01PVVRfRU5fRElTUF9QQVRIMDsNCiAJ
fSBlbHNlIHsNCiAJCXZhbHVlID0gMDsNCiAJfQ0KQEAgLTM3Myw2ICszODMsMTAgQEAgc3RhdGlj
IHVuc2lnbmVkIGludCBtdGtfZGRwX3NlbF9pbihjb25zdCBzdHJ1Y3QgbXRrX21tc3lzX3JlZ19k
YXRhICpkYXRhLA0KIAl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyAmJiBuZXh0
ID09IEREUF9DT01QT05FTlRfRFBJMCkgew0KIAkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfRFBJ
X1NFTDsNCiAJCXZhbHVlID0gRFBJX1NFTF9JTl9CTFM7DQorCX0gZWxzZSBpZiAoY3VyID09IERE
UF9DT01QT05FTlRfT1ZMXzJMMCAmJg0KKwkJICAgICBuZXh0ID09IEREUF9DT01QT05FTlRfUkRN
QTApIHsNCisJCSphZGRyID0gTVQ4MTgzX0RJU1BfUEFUSDBfU0VMX0lOOw0KKwkJdmFsdWUgPSBE
SVNQX1BBVEgwX1NFTF9JTl9PVkwwXzJMOw0KIAl9IGVsc2Ugew0KIAkJdmFsdWUgPSAwOw0KIAl9
DQotLSANCjEuOC4xLjEuZGlydHkNCg==

