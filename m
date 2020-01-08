Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B2DC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBA22075A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CA0vzw+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgAHBwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:52:42 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:22617 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726927AbgAHBwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:52:40 -0500
X-UUID: f129c5e7e8a94133bf305d372c2b95c5-20200108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3xb4WkBhecnQKR5JjDcpYU1lbbGwgJex7RLnR+U8A9U=;
        b=CA0vzw+XcmixkxCeSFA1b5JpW/pDpysjbrU/7RPFbYcvFcsIFisQdwWm/PIFKAT8rzcQmYgnejAB0CChkuOdoSeWfsqW/ZzYFq4pX5X0l5wyczNE0eT+j69hEAHIxoCmijDu1PbvCFAZuCORB1QzhIV3vuqxddePCNsiRzs7f5c=;
X-UUID: f129c5e7e8a94133bf305d372c2b95c5-20200108
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1855205996; Wed, 08 Jan 2020 09:52:32 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 Jan 2020 09:50:51 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 Jan 2020 09:53:04 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 08/11] phy: phy-mtk-tphy: make the ref clock optional
Date:   Wed, 8 Jan 2020 09:52:03 +0800
Message-ID: <1578448326-27455-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6C5AF912A9722F788ED3B441B0A6EFC0733C38F01E5414BF0AE4CE3B0AE44ADC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZXRpbWVzIHRoZSByZWZlcmVuY2UgY2xvY2sgb2YgVVNCMyBQSFkgY29tZXMgZnJvbSBvc2Np
bGxhdG9yDQpkaXJlY3RseSwgYW5kIG5vIG5lZWQgcmVmZXIgdG8gYSBmaXhlZC1jbG9jayBpbiBE
VFMgYW55bW9yZQ0KaWYgbWFrZSBpdCBvcHRpb25hbC4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZl
bmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mn52NTogbm8gY2hhbmdl
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
bmNlLT5yZWZfY2xrKTsNCi0tIA0KMi4yNC4wDQo=

