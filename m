Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF1CC2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D1620637
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IaiGs6c/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfLDJor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:44:47 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55470 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726166AbfLDJoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:44:46 -0500
X-UUID: 45b07bbb5c8f467d84a4d6058623ffde-20191204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9c+0u2uq+nknwNcqDuJh0AzVEuM8VtGPxvy/e0XpUMc=;
        b=IaiGs6c/JAPiiAMmQpc9h6PCnaSSZT6kFGXY38PuHS96pA3HEdFU/DRd8uI6qDXTKJT68LpV2hBH3hW2xDlBTnYRdRgIJLlYYWCx0v9vQzX03HO2krjUEvVIu4lK7cWXFyfcJl/2ctwniu4Zc7GCCWqcjCYTz21FNTH1GPVCVrs=;
X-UUID: 45b07bbb5c8f467d84a4d6058623ffde-20191204
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1504589868; Wed, 04 Dec 2019 17:44:43 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Dec 2019 17:44:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Dec 2019 17:43:48 +0800
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
Subject: [PATCH v3 0/6] drm/mediatek: fix cursor issue and apply CMDQ in MTK DRM
Date:   Wed, 4 Dec 2019 17:44:35 +0800
Message-ID: <20191204094441.5116-1-bibby.hsieh@mediatek.com>
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
aHdvcmsvcGF0Y2gvMTE1NDUxNy8pDQoNCkNoYW5nZXMgc2luY2UgdjI6DQogLSBtb3ZlIHNvbWUg
Y2hhbmdlcyB0byBhbm90aGVyIHBhdGNoDQogLSBkaXNhYmxlIGxheWVyIGluIGF0b21pY19kaXNh
YmxlKCkNCg0KQ2hhbmdlcyBzaW5jZSB2MToNCiAtIHJlbW92ZSByZWR1bmRhbnQgY29kZQ0KIC0g
bWVyZ2UgdGhlIGR1cGxpY2F0ZSBjb2RlDQogLSB1c2UgYXN5bmMgaW5zdGVhZCBvZiBjdXJzb3IN
Cg0KQ2hhbmdlcyBzaW5jZSB2MDoNCiAtIHJlbW92ZSByZWR1bmRhbnQgY29kZQ0KIC0gcmVtb3Zl
IHBhdGNoDQogICAiZHJtL21lZGlhdGVrOiBmaXggYXRvbWljX3N0YXRlIHJlZmVyZW5jZSBjb3Vu
dGluZyINCiAgIEFmdGVyIHJlbW92ZSB0aGlzIHBhdGNoLCB0aGUgaXNzdWUgd2UgbWV0IGJlZm9y
ZSBpcyBnb25lLg0KICAgU28gSSBkbyBub3QgYWRkIGFueSBleHRyYSBjb2RlIHRvIGRvIHNvbWV0
aGluZy4NCg0KQmliYnkgSHNpZWggKDYpOg0KICBkcm0vbWVkaWF0ZWs6IHVzZSBEUk0gY29yZSdz
IGF0b21pYyBjb21taXQgaGVscGVyDQogIGRybS9tZWRpYXRlazogaGFuZGxlIGV2ZW50cyB3aGVu
IGVuYWJsaW5nL2Rpc2FibGluZyBjcnRjDQogIGRybS9tZWRpYXRlazogdXBkYXRlIGN1cnNvcnMg
YnkgdXNpbmcgYXN5bmMgYXRvbWljIHVwZGF0ZQ0KICBkcm0vbWVkaWF0ZWs6IHJlbW92ZSB1bnVz
ZWQgZXh0ZXJuYWwgZnVuY3Rpb24NCiAgZHJtL21lZGlhdGVrOiBzdXBwb3J0IENNRFEgaW50ZXJm
YWNlIGluIGRkcCBjb21wb25lbnQNCiAgZHJtL21lZGlhdGVrOiBhcHBseSBDTURRIGNvbnRyb2wg
Zmxvdw0KDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2NvbG9yLmMgICB8ICAg
NyArLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAgICAgfCAgNjcg
KysrKy0tLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jICAgIHwg
IDQzICsrLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICAgICB8
IDE2OSArKysrKysrKysrKysrKysrLS0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2NydGMuaCAgICAgfCAgIDIgKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2RkcF9jb21wLmMgfCAxMzYgKysrKysrKysrKysrLS0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCAgNDcgKysrLS0tDQogZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZHJ2LmMgICAgICB8ICA4NiArLS0tLS0tLS0tDQogZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmggICAgICB8ICAgNyAtDQogZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fcGxhbmUuYyAgICB8ICA1MCArKysrKysNCiBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5oICAgIHwgICAyICsNCiAxMSBmaWxlcyBjaGFuZ2Vk
LCAzOTQgaW5zZXJ0aW9ucygrKSwgMjIyIGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMTguMA0K

