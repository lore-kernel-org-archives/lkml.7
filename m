Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADFBC3276F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6434222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NFBocSl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgACDNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:13:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:24834 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727400AbgACDMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:46 -0500
X-UUID: 5d5fe0730d9840d1b936663316c08f5c-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=80Nbmr3xohHu1sbyZ9GY7LSVrpaKDxARTqzXy8B3cZE=;
        b=NFBocSl04BHo2A7ARre6WRnser38kwfaVuBHPikdvY2OscNyNOzZryepQKEnQJ3M2UKciqbcgDuKmThg+QrK9Vy5k6yD+whW2+x2AK7BGM5ahNUvj3fE89h486KWm6i2fZ0undBFGKs4z99RAZAF/jjFeBNQZjkc7WFBcHh392s=;
X-UUID: 5d5fe0730d9840d1b936663316c08f5c-20200103
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1621327258; Fri, 03 Jan 2020 11:12:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:08 +0800
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
Subject: [RESEND PATCH v6 06/17] drm/mediatek: add private data for rdma1 to dpi0 connection
Date:   Fri, 3 Jan 2020 11:12:17 +0800
Message-ID: <1578021148-32413-7-git-send-email-yongqiang.niu@mediatek.com>
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

dGhlIHJlZ2lzdGVyIG9mZnNldCBhbmQgdmFsdWUgd2lsbCBiZSBkaWZmZXJlbnQgaW4gZnV0dXJl
IFNPQywNCmFkZCBwcml2YXRlIGRhdGEgZm9yIHJkbWExLT5kcGkwIHVzZSBjYXNlLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCi0t
LQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jIHwgMTYgKysrKysrKysr
KysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KaW5kZXggYjI3OTIwNC4u
MDAxNWIzNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KQEAgLTE3
MCw2ICsxNzAsMTAgQEAgc3RydWN0IG10a19kZHAgew0KIA0KIHN0cnVjdCBtdGtfbW1zeXNfcmVn
X2RhdGEgew0KIAl1MzIgb3ZsMF9tb3V0X2VuOw0KKwl1MzIgcmRtYTFfc291dF9zZWxfaW47DQor
CXUzMiByZG1hMV9zb3V0X2RwaTA7DQorCXUzMiBkcGkwX3NlbF9pbjsNCisJdTMyIGRwaTBfc2Vs
X2luX3JkbWExOw0KIH07DQogDQogc3RhdGljIGNvbnN0IHVuc2lnbmVkIGludCBtdDI3MDFfbXV0
ZXhfbW9kW0REUF9DT01QT05FTlRfSURfTUFYXSA9IHsNCkBAIC0yNTYsNiArMjYwLDEwIEBAIHN0
cnVjdCBtdGtfbW1zeXNfcmVnX2RhdGEgew0KIA0KIGNvbnN0IHN0cnVjdCBtdGtfbW1zeXNfcmVn
X2RhdGEgbXQ4MTczX21tc3lzX3JlZ19kYXRhID0gew0KIAkub3ZsMF9tb3V0X2VuID0gRElTUF9S
RUdfQ09ORklHX0RJU1BfT1ZMMF9NT1VUX0VOLA0KKwkucmRtYTFfc291dF9zZWxfaW4gPSBESVNQ
X1JFR19DT05GSUdfRElTUF9SRE1BMV9TT1VUX0VOLA0KKwkucmRtYTFfc291dF9kcGkwID0gUkRN
QTFfU09VVF9EUEkwLA0KKwkuZHBpMF9zZWxfaW4gPSBESVNQX1JFR19DT05GSUdfRFBJX1NFTF9J
TiwNCisJLmRwaTBfc2VsX2luX3JkbWExID0gRFBJMF9TRUxfSU5fUkRNQTEsDQogfTsNCiANCiBz
dGF0aWMgdW5zaWduZWQgaW50IG10a19kZHBfbW91dF9lbihjb25zdCBzdHJ1Y3QgbXRrX21tc3lz
X3JlZ19kYXRhICpkYXRhLA0KQEAgLTMxMSw4ICszMTksOCBAQCBzdGF0aWMgdW5zaWduZWQgaW50
IG10a19kZHBfbW91dF9lbihjb25zdCBzdHJ1Y3QgbXRrX21tc3lzX3JlZ19kYXRhICpkYXRhLA0K
IAkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfRElTUF9SRE1BMV9TT1VUX0VOOw0KIAkJdmFsdWUg
PSBSRE1BMV9TT1VUX0RTSTM7DQogCX0gZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfUkRN
QTEgJiYgbmV4dCA9PSBERFBfQ09NUE9ORU5UX0RQSTApIHsNCi0JCSphZGRyID0gRElTUF9SRUdf
Q09ORklHX0RJU1BfUkRNQTFfU09VVF9FTjsNCi0JCXZhbHVlID0gUkRNQTFfU09VVF9EUEkwOw0K
KwkJKmFkZHIgPSBkYXRhLT5yZG1hMV9zb3V0X3NlbF9pbjsNCisJCXZhbHVlID1kYXRhLT5yZG1h
MV9zb3V0X2RwaTA7DQogCX0gZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfUkRNQTEgJiYg
bmV4dCA9PSBERFBfQ09NUE9ORU5UX0RQSTEpIHsNCiAJCSphZGRyID0gRElTUF9SRUdfQ09ORklH
X0RJU1BfUkRNQTFfU09VVF9FTjsNCiAJCXZhbHVlID0gUkRNQTFfU09VVF9EUEkxOw0KQEAgLTM0
OSw4ICszNTcsOCBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG10a19kZHBfc2VsX2luKGNvbnN0IHN0
cnVjdCBtdGtfbW1zeXNfcmVnX2RhdGEgKmRhdGEsDQogCQkqYWRkciA9IERJU1BfUkVHX0NPTkZJ
R19ESVNQX0NPTE9SMF9TRUxfSU47DQogCQl2YWx1ZSA9IENPTE9SMF9TRUxfSU5fT1ZMMDsNCiAJ
fSBlbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVOVF9SRE1BMSAmJiBuZXh0ID09IEREUF9DT01Q
T05FTlRfRFBJMCkgew0KLQkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfRFBJX1NFTF9JTjsNCi0J
CXZhbHVlID0gRFBJMF9TRUxfSU5fUkRNQTE7DQorCQkqYWRkciA9IGRhdGEtPmRwaTBfc2VsX2lu
Ow0KKwkJdmFsdWUgPSBkYXRhLT5kcGkwX3NlbF9pbl9yZG1hMTsNCiAJfSBlbHNlIGlmIChjdXIg
PT0gRERQX0NPTVBPTkVOVF9SRE1BMSAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfRFBJMSkgew0K
IAkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfRFBJX1NFTF9JTjsNCiAJCXZhbHVlID0gRFBJMV9T
RUxfSU5fUkRNQTE7DQotLSANCjEuOC4xLjEuZGlydHkNCg==

