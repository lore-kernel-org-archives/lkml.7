Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63770C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B1424680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s2UOmCDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLTI2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:28:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:25378 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725941AbfLTI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:28:24 -0500
X-UUID: c65f143ada1c46afac0f06d2010f4ee7-20191220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2fvqpXZ4f+f8Am+74fysA+SXl4Y8KX7VvKLUjOFoqG0=;
        b=s2UOmCDxarzcVbKJicgl9WQddBKO1XD3I5dKz8Kv/gCpn685W0zCUWxqUj9ZQ3sV6mRrW1pWyZ6PMDgf5xr34SbJWyXbMnK/nzqQ7ERlXNd5SgU+cbl6ZdGNYcI87+5EfKcWoMoNfc6eIkTVtV1t9XyGkTMIx1pZbgMMwMlo440=;
X-UUID: c65f143ada1c46afac0f06d2010f4ee7-20191220
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1412223534; Fri, 20 Dec 2019 16:28:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Dec 2019 16:28:24 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Dec 2019 16:28:14 +0800
Message-ID: <1576830496.22904.1.camel@mtksdaap41>
Subject: Re: [PATCH v5 0/7] drm/mediatek: fix cursor issue and apply CMDQ in
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
Date:   Fri, 20 Dec 2019 16:28:16 +0800
In-Reply-To: <20191210050526.4437-1-bibby.hsieh@mediatek.com>
References: <20191210050526.4437-1-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpGb3IgdGhpcyBzZXJpZXMsIGFwcGxpZWQgdG8gbWVkaWF0ZWstZHJtLW5l
eHQtNS42IFsxXSwgdGhhbmtzLg0KDQpbMV0NCmh0dHBzOi8vZ2l0aHViLmNvbS9ja2h1LW1lZGlh
dGVrL2xpbnV4LmdpdC10YWdzL2NvbW1pdHMvbWVkaWF0ZWstZHJtLW5leHQtNS42DQoNClJlZ2Fy
ZHMsDQpDSw0KDQpPbiBUdWUsIDIwMTktMTItMTAgYXQgMTM6MDUgKzA4MDAsIEJpYmJ5IEhzaWVo
IHdyb3RlOg0KPiBUaGUgQ01EUSAoQ29tbWFuZCBRdWV1ZSkgaW4gTVQ4MTgzIGlzIHVzZWQgdG8g
aGVscCB1cGRhdGUgYWxsDQo+IHJlbGV2YW50IGRpc3BsYXkgY29udHJvbGxlciByZWdpc3RlcnMg
d2l0aCBjcml0aWNhbCB0aW1lIGxpbWF0aW9uLg0KPiBUaGlzIHBhdGNoIGFkZCBjbWRxIGludGVy
ZmFjZSBpbiBkZHBfY29tcCBpbnRlcmZhY2UsIGxldCBhbGwNCj4gZGRwX2NvbXAgaW50ZXJmYWNl
IGNhbiBzdXBwb3J0IGNwdS9jbWRxIGZ1bmN0aW9uIGF0IHRoZSBzYW1lIHRpbWUuDQo+IA0KPiBU
aGVzZSBwYXRjaGVzIGFsc28gY2FuIGZpeHVwIGN1cnNvciBtb3ZpbmcgaXMgbm90IHNtb290aA0K
PiB3aGVuIGhlYXZ5IGxvYWQgaW4gd2ViZ2wuDQo+IA0KPiBUaGlzIHBhdGNoIGRlcGVuZHMgb24g
cHRhY2g6DQo+IGFkZCBkcm0gc3VwcG9ydCBmb3IgTVQ4MTgzDQo+IChodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL2NvdmVyLzExMTIxNTE5LykNCj4gc3VwcG9ydCBnY2Ugb24gbXQ4MTgzIHBs
YXRmb3JtDQo+IChodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMjU1MTQ3LykN
Cj4gZHJtL21lZGlhdGVrOiBDaGVjayByZXR1cm4gdmFsdWUgb2YgbXRrX2RybV9kZHBfY29tcF9m
b3JfcGxhbmUNCj4gKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMTU0
NTE3LykNCj4gDQo+IENoYW5nZXMgc2luY2UgdjQ6DQo+ICAtIHJlYmFzZSB0byBMaW51eCA1LjUt
cmMxDQo+ICAtIGFkZCBmaXhlcyB0YWcNCj4gDQo+IENoYW5nZXMgc2luY2UgdjM6DQo+ICAtIHJl
bW92ZSByZWR1bmRhbnQgY29kZSBhbmQgdmFyaWFibGUNCj4gDQo+IENoYW5nZXMgc2luY2UgdjI6
DQo+ICAtIG1vdmUgc29tZSBjaGFuZ2VzIHRvIGFub3RoZXIgcGF0Y2gNCj4gIC0gZGlzYWJsZSBs
YXllciBpbiBhdG9taWNfZGlzYWJsZSgpDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAgLSBy
ZW1vdmUgcmVkdW5kYW50IGNvZGUNCj4gIC0gbWVyZ2UgdGhlIGR1cGxpY2F0ZSBjb2RlDQo+ICAt
IHVzZSBhc3luYyBpbnN0ZWFkIG9mIGN1cnNvcg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MDoNCj4g
IC0gcmVtb3ZlIHJlZHVuZGFudCBjb2RlDQo+ICAtIHJlbW92ZSBwYXRjaA0KPiAgICAiZHJtL21l
ZGlhdGVrOiBmaXggYXRvbWljX3N0YXRlIHJlZmVyZW5jZSBjb3VudGluZyINCj4gICAgQWZ0ZXIg
cmVtb3ZlIHRoaXMgcGF0Y2gsIHRoZSBpc3N1ZSB3ZSBtZXQgYmVmb3JlIGlzIGdvbmUuDQo+ICAg
IFNvIEkgZG8gbm90IGFkZCBhbnkgZXh0cmEgY29kZSB0byBkbyBzb21ldGhpbmcuDQo+IA0KPiBC
aWJieSBIc2llaCAoNyk6DQo+ICAgZHJtL21lZGlhdGVrOiB1c2UgRFJNIGNvcmUncyBhdG9taWMg
Y29tbWl0IGhlbHBlcg0KPiAgIGRybS9tZWRpYXRlazogaGFuZGxlIGV2ZW50cyB3aGVuIGVuYWJs
aW5nL2Rpc2FibGluZyBjcnRjDQo+ICAgZHJtL21lZGlhdGVrOiB1cGRhdGUgY3Vyc29ycyBieSB1
c2luZyBhc3luYyBhdG9taWMgdXBkYXRlDQo+ICAgZHJtL21lZGlhdGVrOiBkaXNhYmxlIGFsbCB0
aGUgcGxhbmVzIGluIGF0b21pY19kaXNhYmxlDQo+ICAgZHJtL21lZGlhdGVrOiByZW1vdmUgdW51
c2VkIGV4dGVybmFsIGZ1bmN0aW9uDQo+ICAgZHJtL21lZGlhdGVrOiBzdXBwb3J0IENNRFEgaW50
ZXJmYWNlIGluIGRkcCBjb21wb25lbnQNCj4gICBkcm0vbWVkaWF0ZWs6IGFwcGx5IENNRFEgY29u
dHJvbCBmbG93DQo+IA0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2NvbG9y
LmMgICB8ICAgNyArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5j
ICAgICB8ICA2NyArKysrLS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNw
X3JkbWEuYyAgICB8ICA0MyArKy0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fY3J0Yy5jICAgICB8IDE2NSArKysrKysrKysrKysrKysrLS0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5oICAgICB8ICAgMiArDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIHwgMTMxICsrKysrKysrKysrKy0tLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCAgNDcgKysrLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICAgIHwgIDg2ICst
LS0tLS0tLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5oICAgICAg
fCAgIDcgLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYyAgICB8
ICA0NyArKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmgg
ICAgfCAgIDIgKw0KPiAgMTEgZmlsZXMgY2hhbmdlZCwgMzgwIGluc2VydGlvbnMoKyksIDIyNCBk
ZWxldGlvbnMoLSkNCj4gDQoNCg==

