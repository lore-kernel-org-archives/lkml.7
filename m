Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45F1C32770
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9CF22314
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EW8Rl9vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgACDMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:12:51 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:17761 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727225AbgACDMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:42 -0500
X-UUID: 482bc68ae7d34efa9f2bcae5fa403352-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Y87Ghi2q7lqLcNdble/73yvTJNLbvfLPEvasR6g7eVc=;
        b=EW8Rl9vk/EApmqzpqI3onAZp9idC8+8Zw9KY9QUlNY9Jvv6FbxhmcZSxVoPHvddObjEBEg2bwQDfAUpIApmpf5uRrUVwigDT+hXgBqfSLUYgUKSrmkFYZhZWx/aUCWSlTWptciGtZVJO+YIQzRISCoGZVJt3Oy6BhEXvNjk+L5A=;
X-UUID: 482bc68ae7d34efa9f2bcae5fa403352-20200103
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 863220953; Fri, 03 Jan 2020 11:12:37 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:03 +0800
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
Subject: [RESEND PATCH v6 00/17] add drm support for MT8183
Date:   Fri, 3 Jan 2020 11:12:11 +0800
Message-ID: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgYXJlIGJhc2VkIG9uIDUuNS1yYzEgYW5kIHByb3ZpZCAxNyBwYXRjaA0KdG8g
c3VwcG9ydCBtZWRpYXRlayBTT0MgTVQ4MTgzDQoNCkNoYW5nZSBzaW5jZSB2NQ0KLSBmaXggcmV2
aWV3ZWQgaXNzdWUgaW4gdjUNCmJhc2UgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0yMTMyMTkNCg0KQ2hhbmdlIHNpbmNlIHY0
DQotIGZpeCByZXZpZXdlZCBpc3N1ZSBpbiB2NA0KDQpDaGFuZ2Ugc2luY2UgdjMNCi0gZml4IHJl
dmlld2VkIGlzc3VlIGluIHYzDQotIGZpeCB0eXBlIGVycm9yIGluIHYzDQotIGZpeCBjb25mbGlj
dCB3aXRoIGlvbW11IHBhdGNoDQoNCkNoYW5nZSBzaW5jZSB2Mg0KLSBmaXggcmV2aWV3ZWQgaXNz
dWUgaW4gdjINCi0gYWRkIG11dGV4IG5vZGUgaW50byBkdHMgZmlsZQ0KDQpDaGFuZ2VzIHNpbmNl
IHYxOg0KLSBmaXggcmV2aWV3ZWQgaXNzdWUgaW4gdjENCi0gYWRkIGR0cyBmb3IgbXQ4MTgzIGRp
c3BsYXkgbm9kZXMNCi0gYWRqdXN0IGRpc3BsYXkgY2xvY2sgY29udHJvbCBmbG93IGluIHBhdGNo
IDIyDQotIGFkZCB2bWFwIHN1cHBvcnQgZm9yIG1lZGlhdGVrIGRybSBpbiBwYXRjaCAyMw0KLSBm
aXggcGFnZSBvZmZzZXQgaXNzdWUgZm9yIG1tYXAgZnVuY3Rpb24gaW4gcGF0Y2ggMjQNCi0gZW5h
YmxlIGFsbG93X2ZiX21vZGlmaWVycyBmb3IgbWVkaWF0ZWsgZHJtIGluIHBhdGNoIDI1DQoNCllv
bmdxaWFuZyBOaXUgKDE3KToNCiAgZHQtYmluZGluZ3M6IG1lZGlhdGVrOiBhZGQgcmRtYV9maWZv
X3NpemUgZGVzY3JpcHRpb24gZm9yIG10ODE4Mw0KICAgIGRpc3BsYXkNCiAgYXJtNjQ6IGR0czog
YWRkIGRpc3BsYXkgbm9kZXMgZm9yIG10ODE4Mw0KICBkcm0vbWVkaWF0ZWs6IG1vdmUgZHNpL2Rw
aSBzZWxlY3QgaW5wdXQgaW50byBtdGtfZGRwX3NlbF9pbg0KICBkcm0vbWVkaWF0ZWs6IG1ha2Ug
c291dCBzZWxlY3QgZnVuY3Rpb24gZm9ybWF0IHNhbWUgd2l0aCBzZWxlY3QgaW5wdXQNCiAgZHJt
L21lZGlhdGVrOiBhZGQgbW1zeXMgcHJpdmF0ZSBkYXRhIGZvciBkZHAgcGF0aCBjb25maWcNCiAg
ZHJtL21lZGlhdGVrOiBhZGQgcHJpdmF0ZSBkYXRhIGZvciByZG1hMSB0byBkcGkwIGNvbm5lY3Rp
b24NCiAgZHJtL21lZGlhdGVrOiBhZGQgcHJpdmF0ZSBkYXRhIGZvciByZG1hMSB0byBkc2kwIGNv
bm5lY3Rpb24NCiAgZHJtL21lZGlhdGVrOiBtb3ZlIHJkbWEgc291dCBmcm9tIG10a19kZHBfbW91
dF9lbiBpbnRvDQogICAgbXRrX2RkcF9zb3V0X3NlbA0KICBkcm0vbWVkaWF0ZWs6IGFkZCBjb25u
ZWN0aW9uIGZyb20gT1ZMMCB0byBPVkxfMkwwDQogIGRybS9tZWRpYXRlazogYWRkIGNvbm5lY3Rp
b24gZnJvbSBSRE1BMCB0byBDT0xPUjANCiAgZHJtL21lZGlhdGVrOiBhZGQgY29ubmVjdGlvbiBm
cm9tIFJETUExIHRvIERTSTANCiAgZHJtL21lZGlhdGVrOiBhZGQgY29ubmVjdGlvbiBmcm9tIE9W
TF8yTDAgdG8gUkRNQTANCiAgZHJtL21lZGlhdGVrOiBhZGQgY29ubmVjdGlvbiBmcm9tIE9WTF8y
TDEgdG8gUkRNQTENCiAgZHJtL21lZGlhdGVrOiBhZGQgY29ubmVjdGlvbiBmcm9tIERJVEhFUjAg
dG8gRFNJMA0KICBkcm0vbWVkaWF0ZWs6IGFkZCBjb25uZWN0aW9uIGZyb20gUkRNQTAgdG8gRFNJ
MA0KICBkcm0vbWVkaWF0ZWs6IGFkZCBmaWZvX3NpemUgaW50byByZG1hIHByaXZhdGUgZGF0YQ0K
ICBkcm0vbWVkaWF0ZWs6IGFkZCBzdXBwb3J0IGZvciBtZWRpYXRlayBTT0MgTVQ4MTgzDQoNCiAu
Li4vYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkaXNwLnR4dCAgICB8ICAxMyAr
DQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSAgICAgICAgICAgfCAg
OTggKysrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAgICAg
ICAgICAgIHwgIDE4ICsrDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEu
YyAgICAgICAgICAgfCAgMjUgKy0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9j
cnRjLmMgICAgICAgICAgICB8ICAgNCArDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwLmMgICAgICAgICAgICAgfCAyODggKysrKysrKysrKysrKysrKy0tLS0tDQogZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmggICAgICAgICAgICAgfCAgIDcgKw0KIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jICAgICAgICAgICAgIHwgIDQ5ICsr
KysNCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuaCAgICAgICAgICAgICB8
ICAgMyArDQogOSBmaWxlcyBjaGFuZ2VkLCA0MzUgaW5zZXJ0aW9ucygrKSwgNzAgZGVsZXRpb25z
KC0pDQoNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

