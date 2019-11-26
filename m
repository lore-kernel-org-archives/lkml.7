Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB55C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC8F2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LLe3uvSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfKZG3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 01:29:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:42672 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725802AbfKZG3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 01:29:47 -0500
X-UUID: 1c1f798d87dc4cf38d4cc71396396bb9-20191126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=oJcXUCLZIxcF59qSTm2vQw2qkPkCytdOwN19qtc61zQ=;
        b=LLe3uvSis0vKvlWOxtqBDOJUV+XnCbwW/fe2QqakZzH6RrAmyJqfq9cgeU96V9Gat+exbqJK3opEXz2Y5j4yqbKa7dRbY9SVkbXMhA96WZycRP2MhgVli0j/8TX62sFM0uMnSEojPi4tKQHpT8SncqJ8EEwf+wuVF2V3p7L8TYA=;
X-UUID: 1c1f798d87dc4cf38d4cc71396396bb9-20191126
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1157315211; Tue, 26 Nov 2019 14:29:43 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Nov 2019 14:29:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Nov 2019 14:29:14 +0800
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
Subject: [PATCH 0/7] drm/mediatek: fix cursor issue and apply CMDQ in
Date:   Tue, 26 Nov 2019 14:29:25 +0800
Message-ID: <20191126062932.19773-1-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3886BE9112410BD4E984397ECA66E6660D117511F429C6329CE2E162650C9F092000:8
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
aHdvcmsvcGF0Y2gvMTE1NDUxNy8pDQoNCkJpYmJ5IEhzaWVoICg3KToNCiAgZHJtL21lZGlhdGVr
OiBmaXggYXRvbWljX3N0YXRlIHJlZmVyZW5jZSBjb3VudGluZw0KICBkcm0vbWVkaWF0ZWs6IHB1
dCAiZXZlbnQiIGluIGNyaXRpY2FsIHNlY3Rpb24NCiAgZHJtL21lZGlhdGVrOiB1c2UgRFJNIGNv
cmUncyBhdG9taWMgY29tbWl0IGhlbHBlcg0KICBkcm0vbWVkaWF0ZWs6IGhhbmRsZSBldmVudHMg
d2hlbiBlbmFibGluZy9kaXNhYmxpbmcgY3J0Yw0KICBkcm0vbWVkaWF0ZWs6IHVwZGF0ZSBjdXJz
b3JzIGJ5IHVzaW5nIGFzeW5jIGF0b21pYyB1cGRhdGUNCiAgZHJtL21lZGlhdGVrOiBzdXBwb3J0
IENNRFEgaW50ZXJmYWNlIGluIGRkcCBjb21wb25lbnQNCiAgZHJtL21lZGlhdGVrOiBhcHBseSBD
TURRIGNvbnRyb2wgZmxvdw0KDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Nv
bG9yLmMgICB8ICAgNyArLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwu
YyAgICAgfCAgNjUgKysrLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3Jk
bWEuYyAgICB8ICA0MyArKy0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jICAgICB8IDIyMyArKysrKysrKysrKysrKysrKystLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2NydGMuaCAgICAgfCAgIDQgKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2RkcF9jb21wLmMgfCAxNTEgKysrKysrKysrLS0tLQ0KIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCAgNTUgKysrLS0NCiBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICAgIHwgMTQzICsrKysrKystLS0tLS0NCiBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuaCAgICAgIHwgIDE3ICstDQogZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYyAgICB8ICA1NCArKysrKw0KIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmggICAgfCAgIDIgKw0KIDExIGZpbGVz
IGNoYW5nZWQsIDU3NSBpbnNlcnRpb25zKCspLCAxODkgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4x
OC4wDQo=

