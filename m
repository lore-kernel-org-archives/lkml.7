Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDC7C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF2020637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="glfGCYkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfLIEs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 23:48:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33323 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726826AbfLIEs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:48:57 -0500
X-UUID: 7db8f50916fd4b488594c5170206f671-20191209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=YcgZtnqzg5VT3Hj1syPa/xCvJ6RF8xt8gpVFl7qpqMI=;
        b=glfGCYkYNOGN2BY8rePw6TlmD+rXhi9x84TLt5gd7g8twW+mDutlcXvD5XlXPH08bgfg2ODPnpB19AtwcksCXZVQF0cTPMErgDUM14//VvalbDh2WG+t+wLFqFUFXUNNSm3Gk09ffGTyGVRCt37DfFas2+16hPUfP3jR/iH8dVc=;
X-UUID: 7db8f50916fd4b488594c5170206f671-20191209
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 75638292; Mon, 09 Dec 2019 12:48:41 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 9 Dec 2019 12:47:46 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 9 Dec 2019 12:48:31 +0800
Message-ID: <1575866920.32541.4.camel@mtksdaap41>
Subject: Re: [PATCH v4 0/7] drm/mediatek: fix cursor issue and apply CMDQ in
 MTK DRM
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Mon, 9 Dec 2019 12:48:40 +0800
In-Reply-To: <20191205092749.4021-1-bibby.hsieh@mediatek.com>
References: <20191205092749.4021-1-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 55801605C57CA610921F609EFECE446D43442399BAEEDB01006B5353DB3550B02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpJJ3ZlIHRyaWVkIHRvIGFwcGx5IHRoaXMgc2VyaWVzIHRvIDUuNS1yYzEs
IGJ1dCB0aGVyZSBhcmUgbWFueQ0KY29uZmxpY3RzLiBQbGVhc2UgcmVzZW5kIHRoaXMgc2VyaWVz
IGJhc2VkIG9uIDUuNS1yYzEuDQoNCkFuZCBJJ3ZlIGZvdW5kIHRoYXQgaWYgSSBjb25maWcgQ09O
RklHX01US19DTURRPW0sIHRoZSBjb2RlIGluc2lkZQ0KJyNpZmRlZiBDT05GSUdfTVRLX0NNRFEn
IHdvdWxkIG5vdCBiZSBidWlsdC4gSSB0aGluayB5b3Ugc2hvdWxkIGNoYW5nZQ0KdGhpcyB0byAn
I2lmIElTX0VOQUJMRUQoQ09ORklHX01US19DTURRKScuDQoNClJlZ2FyZHMsDQpDSw0KDQpPbiBU
aHUsIDIwMTktMTItMDUgYXQgMTc6MjcgKzA4MDAsIEJpYmJ5IEhzaWVoIHdyb3RlOg0KPiBUaGUg
Q01EUSAoQ29tbWFuZCBRdWV1ZSkgaW4gTVQ4MTgzIGlzIHVzZWQgdG8gaGVscCB1cGRhdGUgYWxs
DQo+IHJlbGV2YW50IGRpc3BsYXkgY29udHJvbGxlciByZWdpc3RlcnMgd2l0aCBjcml0aWNhbCB0
aW1lIGxpbWF0aW9uLg0KPiBUaGlzIHBhdGNoIGFkZCBjbWRxIGludGVyZmFjZSBpbiBkZHBfY29t
cCBpbnRlcmZhY2UsIGxldCBhbGwNCj4gZGRwX2NvbXAgaW50ZXJmYWNlIGNhbiBzdXBwb3J0IGNw
dS9jbWRxIGZ1bmN0aW9uIGF0IHRoZSBzYW1lIHRpbWUuDQo+IA0KPiBUaGVzZSBwYXRjaGVzIGFs
c28gY2FuIGZpeHVwIGN1cnNvciBtb3ZpbmcgaXMgbm90IHNtb290aA0KPiB3aGVuIGhlYXZ5IGxv
YWQgaW4gd2ViZ2wuDQo+IA0KPiBUaGlzIHBhdGNoIGRlcGVuZHMgb24gcHRhY2g6DQo+IGFkZCBk
cm0gc3VwcG9ydCBmb3IgTVQ4MTgzDQo+IChodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2Nv
dmVyLzExMTIxNTE5LykNCj4gc3VwcG9ydCBnY2Ugb24gbXQ4MTgzIHBsYXRmb3JtDQo+IChodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMjU1MTQ3KQ0KPiBkcm0vbWVkaWF0ZWs6
IFJlZmFjdG9yIHBsYW5lIGluaXQvY2hlY2sgYW5kIHN1cHBvcnQgcm90YXRpb24NCj4gKGh0dHBz
Oi8vcHctZW1lcmlsLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvNjkwMTUvKQ0KPiBkcm0vbWVkaWF0
ZWs6IENoZWNrIHJldHVybiB2YWx1ZSBvZiBtdGtfZHJtX2RkcF9jb21wX2Zvcl9wbGFuZQ0KPiAo
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzExNTQ1MTcvKQ0KPiANCj4g
Q2hhbmdlcyBzaW5jZSB2MzoNCj4gIC0gcmVtb3ZlIHJlZHVuZGFudCBjb2RlIGFuZCB2YXJpYWJs
ZQ0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gIC0gbW92ZSBzb21lIGNoYW5nZXMgdG8gYW5v
dGhlciBwYXRjaA0KPiAgLSBkaXNhYmxlIGxheWVyIGluIGF0b21pY19kaXNhYmxlKCkNCj4gDQo+
IENoYW5nZXMgc2luY2UgdjE6DQo+ICAtIHJlbW92ZSByZWR1bmRhbnQgY29kZQ0KPiAgLSBtZXJn
ZSB0aGUgZHVwbGljYXRlIGNvZGUNCj4gIC0gdXNlIGFzeW5jIGluc3RlYWQgb2YgY3Vyc29yDQo+
IA0KPiBDaGFuZ2VzIHNpbmNlIHYwOg0KPiAgLSByZW1vdmUgcmVkdW5kYW50IGNvZGUNCj4gIC0g
cmVtb3ZlIHBhdGNoDQo+ICAgICJkcm0vbWVkaWF0ZWs6IGZpeCBhdG9taWNfc3RhdGUgcmVmZXJl
bmNlIGNvdW50aW5nIg0KPiAgICBBZnRlciByZW1vdmUgdGhpcyBwYXRjaCwgdGhlIGlzc3VlIHdl
IG1ldCBiZWZvcmUgaXMgZ29uZS4NCj4gICAgU28gSSBkbyBub3QgYWRkIGFueSBleHRyYSBjb2Rl
IHRvIGRvIHNvbWV0aGluZy4NCj4gDQo+IEJpYmJ5IEhzaWVoICg3KToNCj4gICBkcm0vbWVkaWF0
ZWs6IHVzZSBEUk0gY29yZSdzIGF0b21pYyBjb21taXQgaGVscGVyDQo+ICAgZHJtL21lZGlhdGVr
OiBoYW5kbGUgZXZlbnRzIHdoZW4gZW5hYmxpbmcvZGlzYWJsaW5nIGNydGMNCj4gICBkcm0vbWVk
aWF0ZWs6IHVwZGF0ZSBjdXJzb3JzIGJ5IHVzaW5nIGFzeW5jIGF0b21pYyB1cGRhdGUNCj4gICBk
cm0vbWVkaWF0ZWs6IGRpc2FibGUgYWxsIHRoZSBwbGFuZXMgaW4gYXRvbWljX2Rpc2FibGUNCj4g
ICBkcm0vbWVkaWF0ZWs6IHJlbW92ZSB1bnVzZWQgZXh0ZXJuYWwgZnVuY3Rpb24NCj4gICBkcm0v
bWVkaWF0ZWs6IHN1cHBvcnQgQ01EUSBpbnRlcmZhY2UgaW4gZGRwIGNvbXBvbmVudA0KPiAgIGRy
bS9tZWRpYXRlazogYXBwbHkgQ01EUSBjb250cm9sIGZsb3cNCj4gDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY29sb3IuYyAgIHwgICA3ICstDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgICAgIHwgIDY3ICsrKystLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jICAgIHwgIDQzICsrLS0tDQo+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgICAgIHwgMTY1ICsrKysrKysrKysr
KysrKystLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmggICAg
IHwgICAyICsNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMg
fCAxMzIgKysrKysrKysrKysrLS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwX2NvbXAuaCB8ICA0NyArKystLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2Rydi5jICAgICAgfCAgODYgKy0tLS0tLS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZHJ2LmggICAgICB8ICAgNyAtDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9wbGFuZS5jICAgIHwgIDQ3ICsrKysrKw0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fcGxhbmUuaCAgICB8ICAgMiArDQo+ICAxMSBmaWxlcyBjaGFuZ2Vk
LCAzODEgaW5zZXJ0aW9ucygrKSwgMjI0IGRlbGV0aW9ucygtKQ0KPiANCg0K

