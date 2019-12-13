Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BA8C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E172253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hjPLIC1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLMH5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:57:41 -0500
Received: from mailgw01.mediatek.com ([216.200.240.184]:44399 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfLMH5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:57:41 -0500
X-UUID: 111a7bdbbc05466e9b8d0b1ccc455ba0-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=G9xP57LuRrds9HJm7/htVK7BRBr/hZcnDeiAioMGxyc=;
        b=hjPLIC1kvltiT+tSCJG3TUMxD1fPnWBD5uCFPFIfYaGfuVBORMBQonlUpoRzsjezQyaWn0T3U3bnu6i7emxepieWQbj2zUMjZTDUAeL4eWcBC+9IwVRy3e9WS0O8R/s3VRtjpUXm+X9Fb6+7xZN9kuPp/p0mQuvSTzxU1nhPY8E=;
X-UUID: 111a7bdbbc05466e9b8d0b1ccc455ba0-20191212
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 792802576; Thu, 12 Dec 2019 23:57:37 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Dec 2019 15:28:37 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Dec 2019 15:28:24 +0800
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
Subject: [PATCH v2, 1/2] drm/mediatek: Fix gamma correction issue
Date:   Fri, 13 Dec 2019 15:28:51 +0800
Message-ID: <1576222132-31586-2-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1576222132-31586-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1576222132-31586-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aWYgdGhlcmUgaXMgbm8gZ2FtbWEgZnVuY3Rpb24gaW4gdGhlIGNydGMNCmRpc3BsYXkgcGF0aCwg
ZG9uJ3QgYWRkIGdhbW1hIHByb3BlcnR5DQpmb3IgY3J0Yw0KDQpTaWduZWQtb2ZmLWJ5OiBZb25n
cWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8IDEwICsrKysrKysrLS0NCiAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5jDQppbmRleCBjYTRmYzQ3Li45YThlMWQ0IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQorKysgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCkBAIC03MzQsNiArNzM0LDcgQEAgaW50
IG10a19kcm1fY3J0Y19jcmVhdGUoc3RydWN0IGRybV9kZXZpY2UgKmRybV9kZXYsDQogCWludCBw
aXBlID0gcHJpdi0+bnVtX3BpcGVzOw0KIAlpbnQgcmV0Ow0KIAlpbnQgaTsNCisJdWludCBnYW1t
YV9sdXRfc2l6ZSA9IDA7DQogDQogCWlmICghcGF0aCkNCiAJCXJldHVybiAwOw0KQEAgLTc4NSw2
ICs3ODYsOSBAQCBpbnQgbXRrX2RybV9jcnRjX2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZHJt
X2RldiwNCiAJCX0NCiANCiAJCW10a19jcnRjLT5kZHBfY29tcFtpXSA9IGNvbXA7DQorDQorCQlp
ZiAoY29tcC0+ZnVuY3MtPmdhbW1hX3NldCkNCisJCQlnYW1tYV9sdXRfc2l6ZSA9IE1US19MVVRf
U0laRTsNCiAJfQ0KIA0KIAlmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMtPmRkcF9jb21wX25yOyBp
KyspDQpAQCAtODA1LDggKzgwOSwxMCBAQCBpbnQgbXRrX2RybV9jcnRjX2NyZWF0ZShzdHJ1Y3Qg
ZHJtX2RldmljZSAqZHJtX2RldiwNCiAJCQkJTlVMTCwgcGlwZSk7DQogCWlmIChyZXQgPCAwKQ0K
IAkJcmV0dXJuIHJldDsNCi0JZHJtX21vZGVfY3J0Y19zZXRfZ2FtbWFfc2l6ZSgmbXRrX2NydGMt
PmJhc2UsIE1US19MVVRfU0laRSk7DQotCWRybV9jcnRjX2VuYWJsZV9jb2xvcl9tZ210KCZtdGtf
Y3J0Yy0+YmFzZSwgMCwgZmFsc2UsIE1US19MVVRfU0laRSk7DQorDQorCWlmIChnYW1tYV9sdXRf
c2l6ZSkNCisJCWRybV9tb2RlX2NydGNfc2V0X2dhbW1hX3NpemUoJm10a19jcnRjLT5iYXNlLCBn
YW1tYV9sdXRfc2l6ZSk7DQorCWRybV9jcnRjX2VuYWJsZV9jb2xvcl9tZ210KCZtdGtfY3J0Yy0+
YmFzZSwgMCwgZmFsc2UsIGdhbW1hX2x1dF9zaXplKTsNCiAJcHJpdi0+bnVtX3BpcGVzKys7DQog
CW11dGV4X2luaXQoJm10a19jcnRjLT5od19sb2NrKTsNCiANCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

