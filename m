Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A4C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6CF20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hD9LEz3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgABECa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:02:30 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58755 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727687AbgABEC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:02:28 -0500
X-UUID: 219a72f602de4359abe277093b6dde27-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PYaTFFw2ybgvUAuwySHyxEemm+FHFyn2YYrb6zt2Of0=;
        b=hD9LEz3MDSKZED6YeAH2KgpfQVXx+zeEAkOeVm3xhLt9jwJNA5hJgZ0HgkZf2YRhzkuqFh8L0arxlKhZX49xo3tTlxQZ/C/gKlXumzE7wIucoPrlkQzPMWfg5CDPtqEacPcfEdJ62+M7TalBBmyeFdwBAPpIEesytHQgEawUKsw=;
X-UUID: 219a72f602de4359abe277093b6dde27-20200102
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 123472746; Thu, 02 Jan 2020 12:02:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 12:01:52 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 12:01:41 +0800
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
Subject: [PATCH v6, 10/14] drm/mediatek: add connection from OVL_2L1 to RDMA1
Date:   Thu, 2 Jan 2020 12:00:20 +0800
Message-ID: <1577937624-14313-11-git-send-email-yongqiang.niu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGQgY29ubmVjdGlvbiBmcm9tIE9WTF8yTDEgdG8gUkRNQTENCg0KU2lnbmVk
LW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQpSZXZp
ZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jIHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9kZHAuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jDQppbmRl
eCBhNmZlZDdiLi4yYjEwZDJkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZGRwLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cC5jDQpAQCAtMzQsOSArMzQsMTEgQEANCiAjZGVmaW5lIERJU1BfUkVHX0NPTkZJR19EUElfU0VM
CQkJMHgwNjQNCiANCiAjZGVmaW5lIE1UODE4M19ESVNQX09WTDBfMkxfTU9VVF9FTgkJMHhmMDQN
CisjZGVmaW5lIE1UODE4M19ESVNQX09WTDFfMkxfTU9VVF9FTgkJMHhmMDgNCiAjZGVmaW5lIE1U
ODE4M19ESVNQX1BBVEgwX1NFTF9JTgkJMHhmMjQNCiANCiAjZGVmaW5lIE9WTDBfMkxfTU9VVF9F
Tl9ESVNQX1BBVEgwCQkJQklUKDApDQorI2RlZmluZSBPVkwxXzJMX01PVVRfRU5fUkRNQTEJCQkJ
QklUKDQpDQogI2RlZmluZSBESVNQX1BBVEgwX1NFTF9JTl9PVkwwXzJMCQkJMHgxDQogDQogI2Rl
ZmluZSBNVDI3MDFfRElTUF9NVVRFWDBfTU9EMAkJCTB4MmMNCkBAIC0zMTgsNiArMzIwLDEwIEBA
IHN0YXRpYyB1bnNpZ25lZCBpbnQgbXRrX2RkcF9tb3V0X2VuKGNvbnN0IHN0cnVjdCBtdGtfbW1z
eXNfcmVnX2RhdGEgKmRhdGEsDQogCQkgICBuZXh0ID09IEREUF9DT01QT05FTlRfUkRNQTApIHsN
CiAJCSphZGRyID0gTVQ4MTgzX0RJU1BfT1ZMMF8yTF9NT1VUX0VOOw0KIAkJdmFsdWUgPSBPVkww
XzJMX01PVVRfRU5fRElTUF9QQVRIMDsNCisJfSBlbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVO
VF9PVkxfMkwxICYmDQorCQkgICBuZXh0ID09IEREUF9DT01QT05FTlRfUkRNQTEpIHsNCisJCSph
ZGRyID0gTVQ4MTgzX0RJU1BfT1ZMMV8yTF9NT1VUX0VOOw0KKwkJdmFsdWUgPSBPVkwxXzJMX01P
VVRfRU5fUkRNQTE7DQogCX0gZWxzZSB7DQogCQl2YWx1ZSA9IDA7DQogCX0NCi0tIA0KMS44LjEu
MS5kaXJ0eQ0K

