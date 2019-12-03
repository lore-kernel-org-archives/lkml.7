Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDE5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C716D206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MvCeNJZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLCHKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:10:44 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:16605 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727349AbfLCHKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:10:44 -0500
X-UUID: fd8c583ac3894792ad25a7da05373773-20191203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RwR1gaBEERJeJ54o0Zn/3vUhZcwHLLvEJhQPdIaUvZQ=;
        b=MvCeNJZofVnOCX6BdEvU3YCvEriFTgWH2Q360g0PwXWb4szdXfke83RCr9ifP6BuVoKFWVv03gxrmR97dLoLWLcxolwOaU5wS590yv/Kvra9ynfRMk+fGtECYiMJELECL0SoPem+YOMpwjAUVAX47YD0hR0dyHm+GoXyeJZNZVg=;
X-UUID: fd8c583ac3894792ad25a7da05373773-20191203
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1119062967; Tue, 03 Dec 2019 15:10:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Dec 2019 15:10:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Dec 2019 15:10:19 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v2 0/6] drm/mediatek: fix cursor issue and apply CMDQ in MTK DRM
Date:   Tue, 3 Dec 2019 15:10:30 +0800
Message-ID: <20191203071036.14158-1-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIENNRFEgKENvbW1hbmQgUXVldWUpIGluIE1UODE4MyBpcyB1c2VkIHRvIGhlbHAgdXBkYXRl
IGFsbA0KcmVsZXZhbnQgZGlzcGxheSBjb250cm9sbGVyIHJlZ2lzdGVycyB3aXRoIGNyaXRpY2Fs
IHRpbWUgbGltYXRpb24uDQpUaGlzIHBhdGNoIGFkZCBjbWRxIGludGVyZmFjZSBpbiBkZHBfY29t
cCBpbnRlcmZhY2UsIGxldCBhbGwNCmRkcF9jb21wIGludGVyZmFjZSBjYW4gc3VwcG9ydCBjcHUv
Y21kcSBmdW5jdGlvbiBhdCB0aGUgc2FtZSB0aW1lLg0KDQpUaGVzZSBwYXRjaGVzIGFsc28gY2Fu
IGZpeHVwIGN1cnNvciBtb3ZpbmcgaXMgbm90IHNtb290aA0Kd2hlbiBoZWF2eSBsb2FkIGluIHdl
YmdsLg0KDQpUaGlzIHBhdGNoIGRlcGVuZHMgb24gcHRhY2g6DQphZGQgZHJtIHN1cHBvcnQgZm9y
IE1UODE4Mw0KKGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTExMjE1MTkvKQ0K
c3VwcG9ydCBnY2Ugb24gbXQ4MTgzIHBsYXRmb3JtDQooaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9jb3Zlci8xMTI1NTE0NykNCmRybS9tZWRpYXRlazogUmVmYWN0b3IgcGxhbmUgaW5pdC9j
aGVjayBhbmQgc3VwcG9ydCByb3RhdGlvbg0KKGh0dHBzOi8vcHctZW1lcmlsLmZyZWVkZXNrdG9w
Lm9yZy9zZXJpZXMvNjkwMTUvKQ0KZHJtL21lZGlhdGVrOiBDaGVjayByZXR1cm4gdmFsdWUgb2Yg
bXRrX2RybV9kZHBfY29tcF9mb3JfcGxhbmUNCihodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRj
aHdvcmsvcGF0Y2gvMTE1NDUxNy8pDQoNCkNoYW5nZXMgc2luY2UgdjE6DQogLSByZW1vdmUgcmVk
dW5kYW50IGNvZGUNCiAtIG1lcmdlIHRoZSBkdXBsaWNhdGUgY29kZQ0KIC0gdXNlIGFzeW5jIGlu
c3RlYWQgb2YgY3Vyc29yDQoNCkNoYW5nZXMgc2luY2UgdjA6DQogLSByZW1vdmUgcmVkdW5kYW50
IGNvZGUNCiAtIHJlbW92ZSBwYXRjaA0KICAgImRybS9tZWRpYXRlazogZml4IGF0b21pY19zdGF0
ZSByZWZlcmVuY2UgY291bnRpbmciDQogICBBZnRlciByZW1vdmUgdGhpcyBwYXRjaCwgdGhlIGlz
c3VlIHdlIG1ldCBiZWZvcmUgaXMgZ29uZS4NCiAgIFNvIEkgZG8gbm90IGFkZCBhbnkgZXh0cmEg
Y29kZSB0byBkbyBzb21ldGhpbmcuDQoNCg0KQmliYnkgSHNpZWggKDYpOg0KICBkcm0vbWVkaWF0
ZWs6IHVzZSBEUk0gY29yZSdzIGF0b21pYyBjb21taXQgaGVscGVyDQogIGRybS9tZWRpYXRlazog
aGFuZGxlIGV2ZW50cyB3aGVuIGVuYWJsaW5nL2Rpc2FibGluZyBjcnRjDQogIGRybS9tZWRpYXRl
azogdXBkYXRlIGN1cnNvcnMgYnkgdXNpbmcgYXN5bmMgYXRvbWljIHVwZGF0ZQ0KICBkcm0vbWVk
aWF0ZWs6IHJlbW92ZSB1bnVzZWQgZXh0ZXJuYWwgZnVuY3Rpb24NCiAgZHJtL21lZGlhdGVrOiBz
dXBwb3J0IENNRFEgaW50ZXJmYWNlIGluIGRkcCBjb21wb25lbnQNCiAgZHJtL21lZGlhdGVrOiBh
cHBseSBDTURRIGNvbnRyb2wgZmxvdw0KDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX2NvbG9yLmMgICB8ICAgNyArLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9vdmwuYyAgICAgfCAgNjcgKysrKy0tLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3BfcmRtYS5jICAgIHwgIDQzICsrLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fY3J0Yy5jICAgICB8IDE2OCArKysrKysrKysrKysrKysrLS0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuaCAgICAgfCAgIDIgKw0KIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgfCAxMzYgKysrKysrKysrKysrLS0tLQ0KIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCAgNDcgKysrLS0tDQog
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgICAgICB8ICA4NiArLS0tLS0t
LS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmggICAgICB8ICAgNyAt
DQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYyAgICB8ICA1MCArKysr
KysNCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5oICAgIHwgICAyICsN
CiAxMSBmaWxlcyBjaGFuZ2VkLCAzOTMgaW5zZXJ0aW9ucygrKSwgMjIyIGRlbGV0aW9ucygtKQ0K
DQotLSANCjIuMTguMA0K

