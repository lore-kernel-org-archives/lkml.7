Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56475C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C14621734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L58rDrAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgABECs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:02:48 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:23623 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727666AbgABEC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:02:28 -0500
X-UUID: 39ae738e339142678703c3ed0a951c40-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9nkkuYTfa+66MBIYSh5utyJH1bn2eVvXmMxu08xA0J0=;
        b=L58rDrAkMmpesJ/7k+FPiXUcdDjFYjIL75qiKOtQyWQt+IWBMrjeF3lBun40A/j/ynoA9ws8s2G3fHOYjKoiaLAzYiVp938F41vDbQZrcLYm7ueC9mQN4HzndVO7OIlXwbnE/qnalznq3IA8EfXu2OVSr9SPCXX2gtoKaqyI+Fs=;
X-UUID: 39ae738e339142678703c3ed0a951c40-20200102
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 101910972; Thu, 02 Jan 2020 12:02:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 12:01:50 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 12:01:39 +0800
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
Subject: [PATCH v6, 08/14] drm/mediatek: add connection from RDMA1 to DSI0
Date:   Thu, 2 Jan 2020 12:00:18 +0800
Message-ID: <1577937624-14313-9-git-send-email-yongqiang.niu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGQgY29ubmVjdGlvbiBmcm9tIFJETUExIHRvIERTSTANCg0KU2lnbmVkLW9m
Zi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQpSZXZpZXdl
ZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2RkcC5jIHwgNCArKysrDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KaW5kZXggMzFh
MDY1MC4uYmI0MTU5NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0K
QEAgLTE3Niw2ICsxNzYsNyBAQCBzdHJ1Y3QgbXRrX21tc3lzX3JlZ19kYXRhIHsNCiAJdTMyIHJk
bWEwX3NvdXRfY29sb3IwOw0KIAl1MzIgcmRtYTFfc291dF9zZWxfaW47DQogCXUzMiByZG1hMV9z
b3V0X2RwaTA7DQorCXUzMiByZG1hMV9zb3V0X2RzaTA7DQogCXUzMiBkcGkwX3NlbF9pbjsNCiAJ
dTMyIGRwaTBfc2VsX2luX3JkbWExOw0KIAl1MzIgZHNpMF9zZWxfaW47DQpAQCAtNDQwLDYgKzQ0
MSw5IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXRrX2RkcF9zb3V0X3NlbChjb25zdCBzdHJ1Y3Qg
bXRrX21tc3lzX3JlZ19kYXRhICpkYXRhLA0KIAl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9O
RU5UX1JETUEwICYmIG5leHQgPT0gRERQX0NPTVBPTkVOVF9DT0xPUjApIHsNCiAJCSphZGRyID0g
ZGF0YS0+cmRtYTBfc291dF9zZWxfaW47DQogCQl2YWx1ZSA9IGRhdGEtPnJkbWEwX3NvdXRfY29s
b3IwOw0KKwl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX1JETUExICYmIG5leHQgPT0g
RERQX0NPTVBPTkVOVF9EU0kwKSB7DQorCQkqYWRkciA9IGRhdGEtPnJkbWExX3NvdXRfc2VsX2lu
Ow0KKwkJdmFsdWUgPSBkYXRhLT5yZG1hMV9zb3V0X2RzaTA7DQogCX0gZWxzZSB7DQogCQl2YWx1
ZSA9IDA7DQogCX0NCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

