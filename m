Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D6EC2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1B220652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j0tv+qYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLJFFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 00:05:34 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:26161 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726085AbfLJFFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 00:05:34 -0500
X-UUID: d27c65d71fce4663865810f00bb512fa-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ely1YZpvhNjk+dbvsntQPD0NZpTuLQm46xCTloZtkzc=;
        b=j0tv+qYBPFqlSoT1oPOlJa55agEFNxbAkZHJlgeR2yawZ5yDImSaMzm/s95EpJjclPkRIV9jn6zKY/ssetF9n9i47Sfl+QXbEymlpZa6s5rqdOivYjgA8OEVe+KzjhesyUWErF5iQ7aGwTMXNS117Gc3JS2Ej199xXXxOf66Plo=;
X-UUID: d27c65d71fce4663865810f00bb512fa-20191210
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1233116922; Tue, 10 Dec 2019 13:05:29 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 13:05:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 13:05:21 +0800
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
Subject: [PATCH v5 0/7] drm/mediatek: fix cursor issue and apply CMDQ in MTK DRM
Date:   Tue, 10 Dec 2019 13:05:19 +0800
Message-ID: <20191210050526.4437-1-bibby.hsieh@mediatek.com>
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
Lm9yZy9jb3Zlci8xMTI1NTE0Ny8pDQpkcm0vbWVkaWF0ZWs6IENoZWNrIHJldHVybiB2YWx1ZSBv
ZiBtdGtfZHJtX2RkcF9jb21wX2Zvcl9wbGFuZQ0KKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Bh
dGNod29yay9wYXRjaC8xMTU0NTE3LykNCg0KQ2hhbmdlcyBzaW5jZSB2NDoNCiAtIHJlYmFzZSB0
byBMaW51eCA1LjUtcmMxDQogLSBhZGQgZml4ZXMgdGFnDQoNCkNoYW5nZXMgc2luY2UgdjM6DQog
LSByZW1vdmUgcmVkdW5kYW50IGNvZGUgYW5kIHZhcmlhYmxlDQoNCkNoYW5nZXMgc2luY2UgdjI6
DQogLSBtb3ZlIHNvbWUgY2hhbmdlcyB0byBhbm90aGVyIHBhdGNoDQogLSBkaXNhYmxlIGxheWVy
IGluIGF0b21pY19kaXNhYmxlKCkNCg0KQ2hhbmdlcyBzaW5jZSB2MToNCiAtIHJlbW92ZSByZWR1
bmRhbnQgY29kZQ0KIC0gbWVyZ2UgdGhlIGR1cGxpY2F0ZSBjb2RlDQogLSB1c2UgYXN5bmMgaW5z
dGVhZCBvZiBjdXJzb3INCg0KQ2hhbmdlcyBzaW5jZSB2MDoNCiAtIHJlbW92ZSByZWR1bmRhbnQg
Y29kZQ0KIC0gcmVtb3ZlIHBhdGNoDQogICAiZHJtL21lZGlhdGVrOiBmaXggYXRvbWljX3N0YXRl
IHJlZmVyZW5jZSBjb3VudGluZyINCiAgIEFmdGVyIHJlbW92ZSB0aGlzIHBhdGNoLCB0aGUgaXNz
dWUgd2UgbWV0IGJlZm9yZSBpcyBnb25lLg0KICAgU28gSSBkbyBub3QgYWRkIGFueSBleHRyYSBj
b2RlIHRvIGRvIHNvbWV0aGluZy4NCg0KQmliYnkgSHNpZWggKDcpOg0KICBkcm0vbWVkaWF0ZWs6
IHVzZSBEUk0gY29yZSdzIGF0b21pYyBjb21taXQgaGVscGVyDQogIGRybS9tZWRpYXRlazogaGFu
ZGxlIGV2ZW50cyB3aGVuIGVuYWJsaW5nL2Rpc2FibGluZyBjcnRjDQogIGRybS9tZWRpYXRlazog
dXBkYXRlIGN1cnNvcnMgYnkgdXNpbmcgYXN5bmMgYXRvbWljIHVwZGF0ZQ0KICBkcm0vbWVkaWF0
ZWs6IGRpc2FibGUgYWxsIHRoZSBwbGFuZXMgaW4gYXRvbWljX2Rpc2FibGUNCiAgZHJtL21lZGlh
dGVrOiByZW1vdmUgdW51c2VkIGV4dGVybmFsIGZ1bmN0aW9uDQogIGRybS9tZWRpYXRlazogc3Vw
cG9ydCBDTURRIGludGVyZmFjZSBpbiBkZHAgY29tcG9uZW50DQogIGRybS9tZWRpYXRlazogYXBw
bHkgQ01EUSBjb250cm9sIGZsb3cNCg0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9jb2xvci5jICAgfCAgIDcgKy0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
b3ZsLmMgICAgIHwgIDY3ICsrKystLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX3JkbWEuYyAgICB8ICA0MyArKy0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2NydGMuYyAgICAgfCAxNjUgKysrKysrKysrKysrKysrKy0tLS0NCiBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmggICAgIHwgICAyICsNCiBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIHwgMTMxICsrKysrKysrKysrKy0tLS0NCiBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oIHwgIDQ3ICsrKy0tLQ0KIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jICAgICAgfCAgODYgKy0tLS0tLS0t
LQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5oICAgICAgfCAgIDcgLQ0K
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMgICAgfCAgNDcgKysrKysr
DQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuaCAgICB8ICAgMiArDQog
MTEgZmlsZXMgY2hhbmdlZCwgMzgwIGluc2VydGlvbnMoKyksIDIyNCBkZWxldGlvbnMoLSkNCg0K
LS0gDQoyLjE4LjANCg==

