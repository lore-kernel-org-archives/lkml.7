Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1309C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0B821783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZQAtsK6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKLIhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:37:12 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25331 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726376AbfKLIhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:37:08 -0500
X-UUID: 86bb4872d62249ae8e0def68f9d742dd-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RsQiqgsAUfLcst7ciQiDaD1dpo7QN/ZjXBVtly8whLs=;
        b=ZQAtsK6iWEIxbyp12j+46lCiF/v/6+tAYL51WxbKefqw46NXhu+LIX5fZAwmRNGAeQ2iqK1q1f6itglaVeGRw3WkdyxZPL0+t/O8vxKde8Z639sLcafqCXywO3UeW1/iSsLkzx6YRvi4SUTD4IRgWWn9irdJoh/WSHmcgpc/h7g=;
X-UUID: 86bb4872d62249ae8e0def68f9d742dd-20191112
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 855150794; Tue, 12 Nov 2019 16:37:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 16:37:00 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 16:36:59 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 08/11] phy: phy-mtk-tphy: make the ref clock optional
Date:   Tue, 12 Nov 2019 16:36:33 +0800
Message-ID: <1573547796-29566-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1AF3FEB3F1588A3A21A53D073B05F23A3D7BA3AA5C07776638C456D41B09AE372000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZXRpbWVzIHRoZSByZWZlcmVuY2UgY2xvY2sgb2YgVVNCMyBQSFkgY29tZXMgZnJvbSBvc2Np
bGxhdG9yDQpkaXJlY3RseSwgYW5kIG5vIG5lZWQgcmVmZXIgdG8gYSBmaXhlZC1jbG9jayBpbiBE
VFMgYW55bW9yZQ0KaWYgbWFrZSBpdCBvcHRpb25hbC4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZl
bmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mn52NDogbm8gY2hhbmdl
cw0KLS0tDQogZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMgfCAyICstDQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYyBiL2RyaXZlcnMvcGh5L21lZGlh
dGVrL3BoeS1tdGstdHBoeS5jDQppbmRleCA0YTJkYzkyZjEwZjUuLjk2YzYyZTNhMzMwMCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQorKysgYi9kcml2
ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYw0KQEAgLTExODIsNyArMTE4Miw3IEBAIHN0
YXRpYyBpbnQgbXRrX3RwaHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJ
CWlmICh0cGh5LT51M3BoeWFfcmVmKQ0KIAkJCWNvbnRpbnVlOw0KIA0KLQkJaW5zdGFuY2UtPnJl
Zl9jbGsgPSBkZXZtX2Nsa19nZXQoJnBoeS0+ZGV2LCAicmVmIik7DQorCQlpbnN0YW5jZS0+cmVm
X2NsayA9IGRldm1fY2xrX2dldF9vcHRpb25hbCgmcGh5LT5kZXYsICJyZWYiKTsNCiAJCWlmIChJ
U19FUlIoaW5zdGFuY2UtPnJlZl9jbGspKSB7DQogCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8g
Z2V0IHJlZl9jbGsoaWQtJWQpXG4iLCBwb3J0KTsNCiAJCQlyZXR2YWwgPSBQVFJfRVJSKGluc3Rh
bmNlLT5yZWZfY2xrKTsNCi0tIA0KMi4yMy4wDQo=

