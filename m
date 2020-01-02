Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D192AC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A813F20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Mho9ETVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgABECd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:02:33 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:23623 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727702AbgABECa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:02:30 -0500
X-UUID: f4ee4422570048928cb8cbdb3b504102-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9DYCbTrem5/AkJY7I3DAUVJg+oiJpqgHNPhBGcMeelc=;
        b=Mho9ETVTDsXc6QRqawp7ckYG/1HiSuCHKpPQTiugvhJVnR+F2UMutkrzKmyraQfkPbcESOSCwaMolgBPWz+uIfcnsPcXaU/1UHQtKvbHVTFcmbawCsK4b8QKXTH/LqGlUKcGcxbjaNZ5xY1VFoVOh2i6ufFsiSlDQtan2zCW0Ns=;
X-UUID: f4ee4422570048928cb8cbdb3b504102-20200102
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1248995143; Thu, 02 Jan 2020 12:02:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 12:01:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 12:01:43 +0800
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
Subject: [PATCH v6, 12/14] drm/mediatek: add connection from RDMA0 to DSI0
Date:   Thu, 2 Jan 2020 12:00:22 +0800
Message-ID: <1577937624-14313-13-git-send-email-yongqiang.niu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGQgY29ubmVjdGlvbiBmcm9tIFJETUEwIHRvIERTSTANCg0KU2lnbmVkLW9m
Zi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQpSZXZpZXdl
ZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2RkcC5jIHwgNCArKysrDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KaW5kZXggNGNj
NDMyZC4uNjhkYzA2MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0K
QEAgLTQyLDYgKzQyLDcgQEANCiAjZGVmaW5lIE9WTDFfMkxfTU9VVF9FTl9SRE1BMQkJCQlCSVQo
NCkNCiAjZGVmaW5lIERJVEhFUjBfTU9VVF9JTl9EU0kwCQkJCUJJVCgwKQ0KICNkZWZpbmUgRElT
UF9QQVRIMF9TRUxfSU5fT1ZMMF8yTAkJCTB4MQ0KKyNkZWZpbmUgRFNJMF9TRUxfSU5fUkRNQTAJ
CQkJMHgxDQogDQogI2RlZmluZSBNVDI3MDFfRElTUF9NVVRFWDBfTU9EMAkJCTB4MmMNCiAjZGVm
aW5lIE1UMjcwMV9ESVNQX01VVEVYMF9TT0YwCQkJMHgzMA0KQEAgLTM5OCw2ICszOTksOSBAQCBz
dGF0aWMgdW5zaWduZWQgaW50IG10a19kZHBfc2VsX2luKGNvbnN0IHN0cnVjdCBtdGtfbW1zeXNf
cmVnX2RhdGEgKmRhdGEsDQogCQkgICAgIG5leHQgPT0gRERQX0NPTVBPTkVOVF9SRE1BMCkgew0K
IAkJKmFkZHIgPSBNVDgxODNfRElTUF9QQVRIMF9TRUxfSU47DQogCQl2YWx1ZSA9IERJU1BfUEFU
SDBfU0VMX0lOX09WTDBfMkw7DQorCX0gZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfUkRN
QTAgJiYgbmV4dCA9PSBERFBfQ09NUE9ORU5UX0RTSTApIHsNCisJCSphZGRyID0gZGF0YS0+ZHNp
MF9zZWxfaW47DQorCQl2YWx1ZSA9IERTSTBfU0VMX0lOX1JETUEwOw0KIAl9IGVsc2Ugew0KIAkJ
dmFsdWUgPSAwOw0KIAl9DQotLSANCjEuOC4xLjEuZGlydHkNCg==

