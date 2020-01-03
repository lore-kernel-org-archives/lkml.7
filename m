Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E06C3276F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7F821D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CeqT6/Xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgACDNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:13:06 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34938 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727500AbgACDMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:55 -0500
X-UUID: 0d69059bce6d47148b7628365166c633-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=haMIoQv3Fp81fRM2lGB+BthEtcEWx1ir/TaiNIRHiVs=;
        b=CeqT6/XcV9FdoWPX34Krb8Cg9PnbdXDw5YeKS4ZQn3XOb3AFuF0zW+L9o9k4tLn0dYAw5d1agMqqobkGJ4ozuSn8gob6mbIggEA5DnQWBB/85ndCpIbHCvEg0nQkooboqxCYV2IAb1BD74u7xhuGVZmhmi2X5qiGtREfU2YA4mE=;
X-UUID: 0d69059bce6d47148b7628365166c633-20200103
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1114866993; Fri, 03 Jan 2020 11:12:51 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:17 +0800
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
Subject: [RESEND PATCH v6 15/17] drm/mediatek: add connection from RDMA0 to DSI0
Date:   Fri, 3 Jan 2020 11:12:26 +0800
Message-ID: <1578021148-32413-16-git-send-email-yongqiang.niu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGQgY29ubmVjdGlvbiBmcm9tIFJETUEwIHRvIERTSTANCg0KU2lnbmVkLW9m
Zi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQpSZXZpZXdl
ZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2RkcC5jIHwgNCArKysrDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KaW5kZXggODFk
OTFmNS4uMzMwOGI2MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0K
QEAgLTQyLDYgKzQyLDcgQEANCiAjZGVmaW5lIE9WTDFfMkxfTU9VVF9FTl9SRE1BMQkJCQlCSVQo
NCkNCiAjZGVmaW5lIERJVEhFUjBfTU9VVF9JTl9EU0kwCQkJCUJJVCgwKQ0KICNkZWZpbmUgRElT
UF9QQVRIMF9TRUxfSU5fT1ZMMF8yTAkJCTB4MQ0KKyNkZWZpbmUgRFNJMF9TRUxfSU5fUkRNQTAJ
CQkJMHgxDQogDQogI2RlZmluZSBNVDI3MDFfRElTUF9NVVRFWDBfTU9EMAkJCTB4MmMNCiAjZGVm
aW5lIE1UMjcwMV9ESVNQX01VVEVYMF9TT0YwCQkJMHgzMA0KQEAgLTM5NSw2ICszOTYsOSBAQCBz
dGF0aWMgdW5zaWduZWQgaW50IG10a19kZHBfc2VsX2luKGNvbnN0IHN0cnVjdCBtdGtfbW1zeXNf
cmVnX2RhdGEgKmRhdGEsDQogCQkgICBuZXh0ID09IEREUF9DT01QT05FTlRfUkRNQTApIHsNCiAJ
CSphZGRyID0gTVQ4MTgzX0RJU1BfUEFUSDBfU0VMX0lOOw0KIAkJdmFsdWUgPSBESVNQX1BBVEgw
X1NFTF9JTl9PVkwwXzJMOw0KKwl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX1JETUEw
ICYmIG5leHQgPT0gRERQX0NPTVBPTkVOVF9EU0kwKSB7DQorCQkqYWRkciA9IGRhdGEtPmRzaTBf
c2VsX2luOw0KKwkJdmFsdWUgPSBEU0kwX1NFTF9JTl9SRE1BMDsNCiAJfSBlbHNlIHsNCiAJCXZh
bHVlID0gMDsNCiAJfQ0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

