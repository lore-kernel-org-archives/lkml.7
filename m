Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27686C3276F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED99521D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sadc67p7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgACDND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:13:03 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60285 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727495AbgACDMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:53 -0500
X-UUID: fe9464f164a542acac37a3808f8bd524-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GpbdBwa6unuCxeavnd7Tl19kwW1RFmBFUAvKSaS/DVk=;
        b=sadc67p7lPKlrkNUmP5k+DvjJne+J8B6TiulI1VOJ0N5NS+PrjsoGs9pvx2Hr/uTYICgPvCKipAVEh1HucwWS/Qk08HXeTMmetp1dn5gmSMIbQ3NrKK0cYpoRHFb4GhK3KxxovAlxa8S/WxxI57ciA7YehloVy86XQF8JQfv/wk=;
X-UUID: fe9464f164a542acac37a3808f8bd524-20200103
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1296502620; Fri, 03 Jan 2020 11:12:48 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:14 +0800
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
Subject: [RESEND PATCH v6 12/17] drm/mediatek: add connection from OVL_2L0 to RDMA0
Date:   Fri, 3 Jan 2020 11:12:23 +0800
Message-ID: <1578021148-32413-13-git-send-email-yongqiang.niu@mediatek.com>
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

dGhpcyBwYXRjaCBhZGQgYWRkIGNvbm5lY3Rpb24gZnJvbSBPVkxfMkwwIHRvIFJETUEwDQoNClNp
Z25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0K
UmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYyB8IDE0ICsrKysrKysrKysrKysrDQogMSBmaWxl
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwLmMNCmluZGV4IDdiN2UzNjUuLjRhOTI2ZjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dw
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
fSBlbHNlIHsNCiAJCXZhbHVlID0gMDsNCiAJfQ0KQEAgLTM3MCw2ICszODAsMTAgQEAgc3RhdGlj
IHVuc2lnbmVkIGludCBtdGtfZGRwX3NlbF9pbihjb25zdCBzdHJ1Y3QgbXRrX21tc3lzX3JlZ19k
YXRhICpkYXRhLA0KIAl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyAmJiBuZXh0
ID09IEREUF9DT01QT05FTlRfRFBJMCkgew0KIAkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfRFNJ
X1NFTDsNCiAJCXZhbHVlID0gRFNJX1NFTF9JTl9SRE1BOw0KKwl9IGVsc2UgaWYgKGN1ciA9PSBE
RFBfQ09NUE9ORU5UX09WTF8yTDAgJiYNCisJCSAgIG5leHQgPT0gRERQX0NPTVBPTkVOVF9SRE1B
MCkgew0KKwkJKmFkZHIgPSBNVDgxODNfRElTUF9QQVRIMF9TRUxfSU47DQorCQl2YWx1ZSA9IERJ
U1BfUEFUSDBfU0VMX0lOX09WTDBfMkw7DQogCX0gZWxzZSB7DQogCQl2YWx1ZSA9IDA7DQogCX0N
Ci0tIA0KMS44LjEuMS5kaXJ0eQ0K

