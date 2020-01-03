Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CBFC3276F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A912A222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qSNn8hPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbgACDNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:13:38 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:24834 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727447AbgACDMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:47 -0500
X-UUID: b4a1266f9c484b61902f67d249bd6165-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eP/N/Xqnko8q3f2AyJvUXJXqc2tPHfSjF4NcXhV48RI=;
        b=qSNn8hPn6LoapphOXcGYFTaMn8Bu6qhmzWOa6RB2IPhGfaBCVti3CEOyv8GpUIbxVmOEK0B571mu3+pAN1Fu45tPPPxiEy9HPJJl7CA+Gj+guKK0Wz1cH1xisNP1SVr4A+OS0FdBY/vqiKmabHIwXJYXMcsKFT8eJG3HjFdZObY=;
X-UUID: b4a1266f9c484b61902f67d249bd6165-20200103
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 329950506; Fri, 03 Jan 2020 11:12:43 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:09 +0800
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
Subject: [RESEND PATCH v6 07/17] drm/mediatek: add private data for rdma1 to dsi0 connection
Date:   Fri, 3 Jan 2020 11:12:18 +0800
Message-ID: <1578021148-32413-8-git-send-email-yongqiang.niu@mediatek.com>
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
IFNPQywNCmFkZCBwcml2YXRlIGRhdGEgZm9yIHJkbWExLT5kc2kwIHVzZSBjYXNlLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCi0t
LQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jIHwgMTAgKysrKysrKyst
LQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jDQppbmRleCAwMDE1YjM1Li4yOTZiMTU3
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMNCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jDQpAQCAtMTc0LDYgKzE3
NCw4IEBAIHN0cnVjdCBtdGtfbW1zeXNfcmVnX2RhdGEgew0KIAl1MzIgcmRtYTFfc291dF9kcGkw
Ow0KIAl1MzIgZHBpMF9zZWxfaW47DQogCXUzMiBkcGkwX3NlbF9pbl9yZG1hMTsNCisJdTMyIGRz
aTBfc2VsX2luOw0KKwl1MzIgZHNpMF9zZWxfaW5fcmRtYTE7DQogfTsNCiANCiBzdGF0aWMgY29u
c3QgdW5zaWduZWQgaW50IG10MjcwMV9tdXRleF9tb2RbRERQX0NPTVBPTkVOVF9JRF9NQVhdID0g
ew0KQEAgLTI1Niw2ICsyNTgsOCBAQCBzdHJ1Y3QgbXRrX21tc3lzX3JlZ19kYXRhIHsNCiANCiBj
b25zdCBzdHJ1Y3QgbXRrX21tc3lzX3JlZ19kYXRhIG10MjcwMV9tbXN5c19yZWdfZGF0YSA9IHsN
CiAJLm92bDBfbW91dF9lbiA9IERJU1BfUkVHX0NPTkZJR19ESVNQX09WTF9NT1VUX0VOLA0KKwku
ZHNpMF9zZWxfaW4gPSBESVNQX1JFR19DT05GSUdfRFNJX1NFTCwNCisJLmRzaTBfc2VsX2luX3Jk
bWExID0gRFNJX1NFTF9JTl9SRE1BLA0KIH07DQogDQogY29uc3Qgc3RydWN0IG10a19tbXN5c19y
ZWdfZGF0YSBtdDgxNzNfbW1zeXNfcmVnX2RhdGEgPSB7DQpAQCAtMjY0LDYgKzI2OCw4IEBAIHN0
cnVjdCBtdGtfbW1zeXNfcmVnX2RhdGEgew0KIAkucmRtYTFfc291dF9kcGkwID0gUkRNQTFfU09V
VF9EUEkwLA0KIAkuZHBpMF9zZWxfaW4gPSBESVNQX1JFR19DT05GSUdfRFBJX1NFTF9JTiwNCiAJ
LmRwaTBfc2VsX2luX3JkbWExID0gRFBJMF9TRUxfSU5fUkRNQTEsDQorCS5kc2kwX3NlbF9pbiA9
IERJU1BfUkVHX0NPTkZJR19EU0lFX1NFTF9JTiwNCisJLmRzaTBfc2VsX2luX3JkbWExID0gRFNJ
MF9TRUxfSU5fUkRNQTEsDQogfTsNCiANCiBzdGF0aWMgdW5zaWduZWQgaW50IG10a19kZHBfbW91
dF9lbihjb25zdCBzdHJ1Y3QgbXRrX21tc3lzX3JlZ19kYXRhICpkYXRhLA0KQEAgLTM2Myw4ICsz
NjksOCBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG10a19kZHBfc2VsX2luKGNvbnN0IHN0cnVjdCBt
dGtfbW1zeXNfcmVnX2RhdGEgKmRhdGEsDQogCQkqYWRkciA9IERJU1BfUkVHX0NPTkZJR19EUElf
U0VMX0lOOw0KIAkJdmFsdWUgPSBEUEkxX1NFTF9JTl9SRE1BMTsNCiAJfSBlbHNlIGlmIChjdXIg
PT0gRERQX0NPTVBPTkVOVF9SRE1BMSAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfRFNJMCkgew0K
LQkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfRFNJRV9TRUxfSU47DQotCQl2YWx1ZSA9IERTSTBf
U0VMX0lOX1JETUExOw0KKwkJKmFkZHIgPSBkYXRhLT5kc2kwX3NlbF9pbjsNCisJCXZhbHVlID0g
ZGF0YS0+ZHNpMF9zZWxfaW5fcmRtYTE7DQogCX0gZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05F
TlRfUkRNQTEgJiYgbmV4dCA9PSBERFBfQ09NUE9ORU5UX0RTSTEpIHsNCiAJCSphZGRyID0gRElT
UF9SRUdfQ09ORklHX0RTSU9fU0VMX0lOOw0KIAkJdmFsdWUgPSBEU0kxX1NFTF9JTl9SRE1BMTsN
Ci0tIA0KMS44LjEuMS5kaXJ0eQ0K

