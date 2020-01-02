Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F23FC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715B021835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VN+s8mGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgABEDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:03:12 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:21283 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727649AbgABECY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:02:24 -0500
X-UUID: 8fef84aaf38941f682fe84d6f3178c46-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kXHf8iYj4C6hK/qT77hE59xGuvjlPsSzu09F9rK4n0E=;
        b=VN+s8mGv5PHAFVX8ErXDrx9BeUCuPwNa0FtJWd/SzGPXLGilxzP/TMkozul3I0/A18ZcaYKYgNRyKk0sT6Nd6cj88Cddt/Wyh/adFZev7bDcybwe9kwjABK9d/a2X2efkTUMksxHD+F/DJzwehbQgp/EPfjl4baJB0YtUuP4tmE=;
X-UUID: 8fef84aaf38941f682fe84d6f3178c46-20200102
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 949068539; Thu, 02 Jan 2020 12:02:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 12:01:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 12:01:38 +0800
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
Subject: [PATCH v6, 07/14] drm/mediatek: add connection from RDMA0 to COLOR0
Date:   Thu, 2 Jan 2020 12:00:17 +0800
Message-ID: <1577937624-14313-8-git-send-email-yongqiang.niu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGQgY29ubmVjdGlvbiBmcm9tIFJETUEwIHRvIENPTE9SMA0KDQpTaWduZWQt
b2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NClJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwLmMgfCA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KaW5kZXgg
NGY3MTgyZS4uMzFhMDY1MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAu
Yw0KQEAgLTE3Miw2ICsxNzIsOCBAQCBzdHJ1Y3QgbXRrX2RkcCB7DQogDQogc3RydWN0IG10a19t
bXN5c19yZWdfZGF0YSB7DQogCXUzMiBvdmwwX21vdXRfZW47DQorCXUzMiByZG1hMF9zb3V0X3Nl
bF9pbjsNCisJdTMyIHJkbWEwX3NvdXRfY29sb3IwOw0KIAl1MzIgcmRtYTFfc291dF9zZWxfaW47
DQogCXUzMiByZG1hMV9zb3V0X2RwaTA7DQogCXUzMiBkcGkwX3NlbF9pbjsNCkBAIC00MzUsNiAr
NDM3LDkgQEAgc3RhdGljIHVuc2lnbmVkIGludCBtdGtfZGRwX3NvdXRfc2VsKGNvbnN0IHN0cnVj
dCBtdGtfbW1zeXNfcmVnX2RhdGEgKmRhdGEsDQogCX0gZWxzZSBpZiAoY3VyID09IEREUF9DT01Q
T05FTlRfUkRNQTIgJiYgbmV4dCA9PSBERFBfQ09NUE9ORU5UX0RTSTMpIHsNCiAJCSphZGRyID0g
RElTUF9SRUdfQ09ORklHX0RJU1BfUkRNQTJfU09VVDsNCiAJCXZhbHVlID0gUkRNQTJfU09VVF9E
U0kzOw0KKwl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX1JETUEwICYmIG5leHQgPT0g
RERQX0NPTVBPTkVOVF9DT0xPUjApIHsNCisJCSphZGRyID0gZGF0YS0+cmRtYTBfc291dF9zZWxf
aW47DQorCQl2YWx1ZSA9IGRhdGEtPnJkbWEwX3NvdXRfY29sb3IwOw0KIAl9IGVsc2Ugew0KIAkJ
dmFsdWUgPSAwOw0KIAl9DQotLSANCjEuOC4xLjEuZGlydHkNCg==

