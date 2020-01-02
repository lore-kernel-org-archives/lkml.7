Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19322C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FAE20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OF+6jTOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgABECU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:02:20 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:31821 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727509AbgABECU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:02:20 -0500
X-UUID: 0d51fe1358bb42918202e6427289dd1e-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7wLu6VmQu6UVnJpXdVr9q3D+QkDfPwKQ1g0hCwiH1Ys=;
        b=OF+6jTOYqwUOPpGkuq6ORXT6gs8ikO70KJiIOI+FD1Ln9wHuEwZEHXvE7mwPhmGM3XBnk23xLUXuS0rPvCrSpCyeD4b0NoBBGFFNCZ86ok5xbBYt5oju6Nknuy0hUUi2YPQ3EHFIMxrtx5e46lzsWVLaPaHALbi8bjpjNl4RGBo=;
X-UUID: 0d51fe1358bb42918202e6427289dd1e-20200102
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1752573210; Thu, 02 Jan 2020 12:02:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 12:01:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 12:01:32 +0800
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
Subject: [PATCH v6, 00/14] add drm support for MT8183
Date:   Thu, 2 Jan 2020 12:00:10 +0800
Message-ID: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgYXJlIGJhc2VkIG9uIDUuNS1yYzEgYW5kIHByb3ZpZCAxNCBwYXRjaA0KdG8g
c3VwcG9ydCBtZWRpYXRlayBTT0MgTVQ4MTgzDQoNCkNoYW5nZSBzaW5jZSB2NQ0KLSBmaXggcmV2
aWV3ZWQgaXNzdWUgaW4gdjUNCg0KQ2hhbmdlIHNpbmNlIHY0DQotIGZpeCByZXZpZXdlZCBpc3N1
ZSBpbiB2NA0KDQpDaGFuZ2Ugc2luY2UgdjMNCi0gZml4IHJldmlld2VkIGlzc3VlIGluIHYzDQot
IGZpeCB0eXBlIGVycm9yIGluIHYzDQotIGZpeCBjb25mbGljdCB3aXRoIGlvbW11IHBhdGNoDQoN
CkNoYW5nZSBzaW5jZSB2Mg0KLSBmaXggcmV2aWV3ZWQgaXNzdWUgaW4gdjINCi0gYWRkIG11dGV4
IG5vZGUgaW50byBkdHMgZmlsZQ0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0KLSBmaXggcmV2aWV3ZWQg
aXNzdWUgaW4gdjENCi0gYWRkIGR0cyBmb3IgbXQ4MTgzIGRpc3BsYXkgbm9kZXMNCi0gYWRqdXN0
IGRpc3BsYXkgY2xvY2sgY29udHJvbCBmbG93IGluIHBhdGNoIDIyDQotIGFkZCB2bWFwIHN1cHBv
cnQgZm9yIG1lZGlhdGVrIGRybSBpbiBwYXRjaCAyMw0KLSBmaXggcGFnZSBvZmZzZXQgaXNzdWUg
Zm9yIG1tYXAgZnVuY3Rpb24gaW4gcGF0Y2ggMjQNCi0gZW5hYmxlIGFsbG93X2ZiX21vZGlmaWVy
cyBmb3IgbWVkaWF0ZWsgZHJtIGluIHBhdGNoIDI1DQoNCllvbmdxaWFuZyBOaXUgKDE0KToNCiAg
YXJtNjQ6IGR0czogYWRkIGRpc3BsYXkgbm9kZXMgZm9yIG10ODE4Mw0KICBkcm0vbWVkaWF0ZWs6
IG1vdmUgZHNpL2RwaSBzZWxlY3QgaW5wdXQgaW50byBtdGtfZGRwX3NlbF9pbg0KICBkcm0vbWVk
aWF0ZWs6IG1ha2Ugc291dCBzZWxlY3QgZnVuY3Rpb24gIGZvcm1hdCBzYW1lIHdpdGggc2VsZWN0
IGlucHV0DQogIGRybS9tZWRpYXRlazogYWRkIG1tc3lzIHByaXZhdGUgZGF0YSBmb3IgZGRwIHBh
dGggY29uZmlnDQogIGRybS9tZWRpYXRlazogbW92ZSByZG1hIHNvdXQgZnJvbSBtdGtfZGRwX21v
dXRfZW4gaW50bw0KICAgIG10a19kZHBfc291dF9zZWwNCiAgZHJtL21lZGlhdGVrOiBhZGQgY29u
bmVjdGlvbiBmcm9tIE9WTDAgdG8gT1ZMXzJMMA0KICBkcm0vbWVkaWF0ZWs6IGFkZCBjb25uZWN0
aW9uIGZyb20gUkRNQTAgdG8gQ09MT1IwDQogIGRybS9tZWRpYXRlazogYWRkIGNvbm5lY3Rpb24g
ZnJvbSBSRE1BMSB0byBEU0kwDQogIGRybS9tZWRpYXRlazogYWRkIGNvbm5lY3Rpb24gZnJvbSBP
VkxfMkwwIHRvIFJETUEwDQogIGRybS9tZWRpYXRlazogYWRkIGNvbm5lY3Rpb24gZnJvbSBPVkxf
MkwxIHRvIFJETUExDQogIGRybS9tZWRpYXRlazogYWRkIGNvbm5lY3Rpb24gZnJvbSBESVRIRVIw
IHRvIERTSTANCiAgZHJtL21lZGlhdGVrOiBhZGQgY29ubmVjdGlvbiBmcm9tIFJETUEwIHRvIERT
STANCiAgZHJtL21lZGlhdGVrOiBhZGQgZmlmb19zaXplIGludG8gcmRtYSBwcml2YXRlIGRhdGEN
CiAgZHJtL21lZGlhdGVrOiBhZGQgc3VwcG9ydCBmb3IgbWVkaWF0ZWsgU09DIE1UODE4Mw0KDQog
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDEwMyArKysrKysrKysr
Kw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAgfCAgMTggKysNCiBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jIHwgIDI3ICsrLQ0KIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgfCAgIDQgKw0KIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jICAgfCAyOTEgKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5oICAgfCAg
IDcgKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jICAgfCAgNTEgKysr
KysrDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmggICB8ICAgMyArDQog
OCBmaWxlcyBjaGFuZ2VkLCA0MzQgaW5zZXJ0aW9ucygrKSwgNzAgZGVsZXRpb25zKC0pDQoNCi0t
IA0KMS44LjEuMS5kaXJ0eQ0K

