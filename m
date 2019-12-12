Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98246C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C35522B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f5bMNPM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfLLEut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 23:50:49 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:32514 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726689AbfLLEus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 23:50:48 -0500
X-UUID: 0350d3d39d8d4823bb50c2421b97151f-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=61QzL2uAhif1inmfHk4F3GpOWbSMt53a76nKAzVwLMU=;
        b=f5bMNPM5X3vpibe0RnOnQWIHHLjNcUhruZoyv2kTE7kQMw2sq6n8oCiqECQvYoXylolEXoxlHHdzYCtPjixo5Mk4wplOpBb8wMOEzckUSh89XQ0ukV3N+v41y+IA9vePsWjQrTSMqTJAM1tHOscJaSAx8PQJYXxGxJA+hQ4XHSw=;
X-UUID: 0350d3d39d8d4823bb50c2421b97151f-20191212
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1765757622; Thu, 12 Dec 2019 12:49:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 12:49:45 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 12:49:53 +0800
Message-ID: <1576126197.29693.3.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: Fix can't get component for external
 display plane.
From:   CK Hu <ck.hu@mediatek.com>
To:     Pi-Hsun Shih <pihsun@chromium.org>
CC:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS FOR MEDIATEK" 
        <dri-devel@lists.freedesktop.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Paul <seanpaul@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 12 Dec 2019 12:49:57 +0800
In-Reply-To: <1575264270.16063.0.camel@mtksdaap41>
References: <20191127100419.130300-1-pihsun@chromium.org>
         <1575264270.16063.0.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A33FA4A393275F96C1D67CACE7875D97147C4BC54960F0F3AB9A8D502DF8916C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBpLUhzdW46DQoNCk9uIE1vbiwgMjAxOS0xMi0wMiBhdCAxMzoyNCArMDgwMCwgQ0sgSHUg
d3JvdGU6DQo+IEhpLCBQaS1Ic3VuOg0KPiANCj4gDQo+IE9uIFdlZCwgMjAxOS0xMS0yNyBhdCAx
ODowNCArMDgwMCwgUGktSHN1biBTaGloIHdyb3RlOg0KPiA+IEZyb206IFlvbmdxaWFuZyBOaXUg
PHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IFRoZSBvcmlnaW5hbCBsb2dp
YyBpcyBvayBmb3IgcHJpbWFyeSBkaXNwbGF5LCBidXQgd2lsbCBub3QgZmluZCBvdXQNCj4gPiBj
b21wb25lbnQgZm9yIGV4dGVybmFsIGRpc3BsYXkuDQo+ID4gDQo+ID4gRm9yIGV4YW1wbGUsIHBs
YW5lLT5pbmRleCBpcyA2IGZvciBleHRlcm5hbCBkaXNwbGF5LCBidXQgdGhlcmUgYXJlIG9ubHkN
Cj4gPiAyIGxheWVyIG5yIGluIGV4dGVybmFsIGRpc3BsYXksIGFuZCB0aGlzIGNvbmRpdGlvbiB3
aWxsIG5ldmVyIGhhcHBlbjoNCj4gPiBpZiAocGxhbmUtPmluZGV4IDwgKGNvdW50ICsgbXRrX2Rk
cF9jb21wX2xheWVyX25yKGNvbXApKSkNCj4gPiANCj4gPiBGaXggdGhpcyBieSB1c2luZyB0aGUg
b2Zmc2V0IG9mIHRoZSBwbGFuZSB0byBtdGtfY3J0Yy0+cGxhbmVzIGFzIGluZGV4LA0KPiA+IGlu
c3RlYWQgb2YgcGxhbmUtPmluZGV4Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBt
ZWRpYXRlay5jb20+DQo+IA0KDQpBcHBsaWVkIHRvIG1lZGlhdGVrLWRybS1maXhlcy01LjUgWzFd
LCB0aGFua3MuDQoNClsxXQ0KaHR0cHM6Ly9naXRodWIuY29tL2NraHUtbWVkaWF0ZWsvbGludXgu
Z2l0LXRhZ3MvY29tbWl0cy9tZWRpYXRlay1kcm0tZml4ZXMtNS41DQoNCg0KUmVnYXJkcywNCkNL
DQoNCj4gUmVnYXJkcywNCj4gQ0sNCj4gDQo+ID4gDQo+ID4gRml4ZXM6IGQ2YjUzZjY4MzU2ZiAo
ImRybS9tZWRpYXRlazogQWRkIGhlbHBlciB0byBnZXQgY29tcG9uZW50IGZvciBhIHBsYW5lIikN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVr
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaS1Ic3VuIFNoaWggPHBpaHN1bkBjaHJvbWl1bS5v
cmc+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMu
YyB8IDUgKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5j
DQo+ID4gaW5kZXggZjgwYThiYTc1OTc3Li5iMzRlN2Q3MDcwMmEgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gQEAgLTIxNSwxMSArMjE1LDEy
IEBAIHN0cnVjdCBtdGtfZGRwX2NvbXAgKm10a19kcm1fZGRwX2NvbXBfZm9yX3BsYW5lKHN0cnVj
dCBkcm1fY3J0YyAqY3J0YywNCj4gPiAgCXN0cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRjID0g
dG9fbXRrX2NydGMoY3J0Yyk7DQo+ID4gIAlzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wOw0KPiA+
ICAJaW50IGksIGNvdW50ID0gMDsNCj4gPiArCXVuc2lnbmVkIGludCBsb2NhbF9pbmRleCA9IHBs
YW5lIC0gbXRrX2NydGMtPnBsYW5lczsNCj4gPiAgDQo+ID4gIAlmb3IgKGkgPSAwOyBpIDwgbXRr
X2NydGMtPmRkcF9jb21wX25yOyBpKyspIHsNCj4gPiAgCQljb21wID0gbXRrX2NydGMtPmRkcF9j
b21wW2ldOw0KPiA+IC0JCWlmIChwbGFuZS0+aW5kZXggPCAoY291bnQgKyBtdGtfZGRwX2NvbXBf
bGF5ZXJfbnIoY29tcCkpKSB7DQo+ID4gLQkJCSpsb2NhbF9sYXllciA9IHBsYW5lLT5pbmRleCAt
IGNvdW50Ow0KPiA+ICsJCWlmIChsb2NhbF9pbmRleCA8IChjb3VudCArIG10a19kZHBfY29tcF9s
YXllcl9ucihjb21wKSkpIHsNCj4gPiArCQkJKmxvY2FsX2xheWVyID0gbG9jYWxfaW5kZXggLSBj
b3VudDsNCj4gPiAgCQkJcmV0dXJuIGNvbXA7DQo+ID4gIAkJfQ0KPiA+ICAJCWNvdW50ICs9IG10
a19kZHBfY29tcF9sYXllcl9ucihjb21wKTsNCj4gPiANCj4gPiBiYXNlLWNvbW1pdDogMTg3NWZm
MzIwZjE0YWZlMjE3MzFhNmU0YzdiNDZkZDMzZTQ1ZGZhYQ0KPiANCg0K

