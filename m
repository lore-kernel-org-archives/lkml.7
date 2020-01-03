Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDD6C3276F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0EA21D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b1eN/Xpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgACDM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:12:59 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34938 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727477AbgACDMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:52 -0500
X-UUID: dbe2dbcce0bb44c296b354889e4f9d06-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w/UNojmvQeoqj5ssGa9RuxeKs7Wh0EGoWwzhQTkdINo=;
        b=b1eN/XpgbGvPvF4HX1oyVOYUZB1ylD3XBmFk2njp027gOVV+4oCs7GFnUVkNvRc118Yo68oc0cHh8+MGS01RWf3dTF2qVwAwcxAwUiv57e1iTTml4QkioXFhCm/osc6EYuRZleL7yqk4edzUneNAVJFoczZgFDmPlZzE11rEhBs=;
X-UUID: dbe2dbcce0bb44c296b354889e4f9d06-20200103
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1791811769; Fri, 03 Jan 2020 11:12:46 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:12 +0800
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
Subject: [RESEND PATCH v6 10/17] drm/mediatek: add connection from RDMA0 to COLOR0
Date:   Fri, 3 Jan 2020 11:12:21 +0800
Message-ID: <1578021148-32413-11-git-send-email-yongqiang.niu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGQgY29ubmVjdGlvbiBmcm9tIFJETUEwIHRvIENPTE9SMA0KDQpTaWduZWQt
b2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NClJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwLmMgfCA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KaW5kZXgg
M2ExYWE5YS4uYjZiODY2MDAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kZHAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRw
LmMNCkBAIC0xNzIsNiArMTcyLDggQEAgc3RydWN0IG10a19kZHAgew0KIA0KIHN0cnVjdCBtdGtf
bW1zeXNfcmVnX2RhdGEgew0KIAl1MzIgb3ZsMF9tb3V0X2VuOw0KKwl1MzIgcmRtYTBfc291dF9z
ZWxfaW47DQorCXUzMiByZG1hMF9zb3V0X2NvbG9yMDsNCiAJdTMyIHJkbWExX3NvdXRfc2VsX2lu
Ow0KIAl1MzIgcmRtYTFfc291dF9kcGkwOw0KIAl1MzIgZHBpMF9zZWxfaW47DQpAQCAtNDMyLDYg
KzQzNCw5IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXRrX2RkcF9zb3V0X3NlbChjb25zdCBzdHJ1
Y3QgbXRrX21tc3lzX3JlZ19kYXRhICpkYXRhLA0KIAl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09N
UE9ORU5UX1JETUEyICYmIG5leHQgPT0gRERQX0NPTVBPTkVOVF9EU0kzKSB7DQogCQkqYWRkciA9
IERJU1BfUkVHX0NPTkZJR19ESVNQX1JETUEyX1NPVVQ7DQogCQl2YWx1ZSA9IFJETUEyX1NPVVRf
RFNJMzsNCisJfSBlbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVOVF9SRE1BMCAmJiBuZXh0ID09
IEREUF9DT01QT05FTlRfQ09MT1IwKSB7DQorCQkqYWRkciA9IGRhdGEtPnJkbWEwX3NvdXRfc2Vs
X2luOw0KKwkJdmFsdWUgPSBkYXRhLT5yZG1hMF9zb3V0X2NvbG9yMDsNCiAJfSBlbHNlIHsNCiAJ
CXZhbHVlID0gMDsNCiAJfQ0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

