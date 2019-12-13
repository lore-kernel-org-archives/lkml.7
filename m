Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9BFC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E7C206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="g8UefY2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLMIJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:09:54 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:37615 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725980AbfLMIJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:09:54 -0500
X-UUID: 5094750f1ed44e73a785cb32d4d15499-20191213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=XJhy5g+NHFwDI5f0gUqZjPngJbGRrCHM6x7omxpoGFE=;
        b=g8UefY2Re5OdU14Qhf+YcoxakJaAws8LfCr2CQkQyIL69QLqcKisebsyij0qXPqbbLk2zwVAwAOJ4bpq2ahH2Aqqty+n8NQIMMUzw2dxp50etsDpGAN4DBt+sg2SlqpO5MN5GdBE7aYxBoMCst1/r8jA5Ogq8KXUdqrJ3Im/xCE=;
X-UUID: 5094750f1ed44e73a785cb32d4d15499-20191213
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 981649545; Fri, 13 Dec 2019 16:09:37 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Dec 2019 16:09:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Dec 2019 16:09:34 +0800
Message-ID: <1576224575.13335.1.camel@mtksdaap41>
Subject: Re: [PATCH v2, 1/2] drm/mediatek: Fix gamma correction issue
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 13 Dec 2019 16:09:35 +0800
In-Reply-To: <1576224191.31822.2.camel@mhfsdcap03>
References: <1576222132-31586-1-git-send-email-yongqiang.niu@mediatek.com>
         <1576222132-31586-2-git-send-email-yongqiang.niu@mediatek.com>
         <1576223336.9817.3.camel@mtksdaap41> <1576224191.31822.2.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E0C81D5B10B64C1A208C0F2484C5E394387DD294A1723E0D5353D5CFEA9397FD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gRnJpLCAyMDE5LTEyLTEzIGF0IDE2OjAzICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBPbiBGcmksIDIwMTktMTItMTMgYXQgMTU6NDggKzA4MDAsIENL
IEh1IHdyb3RlOg0KPiA+IEhpLCBZb25ncWlhbmc6DQo+ID4gDQo+ID4gVGhlIHRpdGxlIGlzIHRv
byByb3VnaC4gQW55IGJ1ZyBvZiBnYW1tYSB3b3VsZCBiZSB0aGlzIHRpdGxlLiBJIHdvdWxkDQo+
ID4gbGlrZSB0aGUgdGl0bGUgc2hvdyBleHBsaWNpdGx5IHdoYXQgaXQgZG9lcy4NCj4gPiANCj4g
PiBPbiBGcmksIDIwMTktMTItMTMgYXQgMTU6MjggKzA4MDAsIFlvbmdxaWFuZyBOaXUgd3JvdGU6
DQo+ID4gPiBpZiB0aGVyZSBpcyBubyBnYW1tYSBmdW5jdGlvbiBpbiB0aGUgY3J0Yw0KPiA+ID4g
ZGlzcGxheSBwYXRoLCBkb24ndCBhZGQgZ2FtbWEgcHJvcGVydHkNCj4gPiA+IGZvciBjcnRjDQo+
ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVA
bWVkaWF0ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fY3J0Yy5jIHwgMTAgKysrKysrKystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiA+IGluZGV4IGNhNGZjNDcuLjlhOGUxZDQg
MTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRj
LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0K
PiA+ID4gQEAgLTczNCw2ICs3MzQsNyBAQCBpbnQgbXRrX2RybV9jcnRjX2NyZWF0ZShzdHJ1Y3Qg
ZHJtX2RldmljZSAqZHJtX2RldiwNCj4gPiA+ICAJaW50IHBpcGUgPSBwcml2LT5udW1fcGlwZXM7
DQo+ID4gPiAgCWludCByZXQ7DQo+ID4gPiAgCWludCBpOw0KPiA+ID4gKwl1aW50IGdhbW1hX2x1
dF9zaXplID0gMDsNCj4gPiA+ICANCj4gPiA+ICAJaWYgKCFwYXRoKQ0KPiA+ID4gIAkJcmV0dXJu
IDA7DQo+ID4gPiBAQCAtNzg1LDYgKzc4Niw5IEBAIGludCBtdGtfZHJtX2NydGNfY3JlYXRlKHN0
cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2LA0KPiA+ID4gIAkJfQ0KPiA+ID4gIA0KPiA+ID4gIAkJ
bXRrX2NydGMtPmRkcF9jb21wW2ldID0gY29tcDsNCj4gPiA+ICsNCj4gPiA+ICsJCWlmIChjb21w
LT5mdW5jcy0+Z2FtbWFfc2V0KQ0KPiA+ID4gKwkJCWdhbW1hX2x1dF9zaXplID0gTVRLX0xVVF9T
SVpFOw0KPiA+ID4gIAl9DQo+ID4gPiAgDQo+ID4gPiAgCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0
Yy0+ZGRwX2NvbXBfbnI7IGkrKykNCj4gPiA+IEBAIC04MDUsOCArODA5LDEwIEBAIGludCBtdGtf
ZHJtX2NydGNfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2LA0KPiA+ID4gIAkJCQlO
VUxMLCBwaXBlKTsNCj4gPiA+ICAJaWYgKHJldCA8IDApDQo+ID4gPiAgCQlyZXR1cm4gcmV0Ow0K
PiA+ID4gLQlkcm1fbW9kZV9jcnRjX3NldF9nYW1tYV9zaXplKCZtdGtfY3J0Yy0+YmFzZSwgTVRL
X0xVVF9TSVpFKTsNCj4gPiA+IC0JZHJtX2NydGNfZW5hYmxlX2NvbG9yX21nbXQoJm10a19jcnRj
LT5iYXNlLCAwLCBmYWxzZSwgTVRLX0xVVF9TSVpFKTsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKGdh
bW1hX2x1dF9zaXplKQ0KPiA+ID4gKwkJZHJtX21vZGVfY3J0Y19zZXRfZ2FtbWFfc2l6ZSgmbXRr
X2NydGMtPmJhc2UsIGdhbW1hX2x1dF9zaXplKTsNCj4gPiA+ICsJZHJtX2NydGNfZW5hYmxlX2Nv
bG9yX21nbXQoJm10a19jcnRjLT5iYXNlLCAwLCBmYWxzZSwgZ2FtbWFfbHV0X3NpemUpOw0KPiA+
IA0KPiA+IElmIHRoZXJlIGlzIG5vIGdhbW1hLCBzaGFsbCB3ZSBlbmFibGUgY29sb3IgbWFuYWdl
bWVudD8NCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IENLDQo+IA0KPiBkcm1fY3J0Y19lbmFibGVf
Y29sb3JfbWdtdCB3aWxsIGNoZWNrIHRoZSBnYW1tYV9sdXRfc2l6ZSBwYXJhbWV0ZXIsDQo+IGlm
IG5vIGdhbW1hLCBnYW1tYV9sdXRfc2l6ZSB3aWxsIGJlIDAsIGFuZCBnYW1tYV9sdXRfc2l6ZSB3
aWxsIG5vdCBhdHRjaA0KPiBnYW1tYSBwcm9wZXJ0eSBmb3IgdGhlIGNydGMNCg0KT0ssIHlvdSdy
ZSByaWdodC4gU28NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoN
CmFuZCB3aGF0IHRpdGxlIHdvdWxkIHlvdSBsaWtlPw0KSSBjb3VsZCBtb2RpZnkgaXQgd2hlbiBJ
IGFwcGx5IHRoaXMgcGF0Y2guDQoNClJlZ2FyZHMsDQpDSw0KDQo+ID4gDQo+ID4gPiAgCXByaXYt
Pm51bV9waXBlcysrOw0KPiA+ID4gIAltdXRleF9pbml0KCZtdGtfY3J0Yy0+aHdfbG9jayk7DQo+
ID4gPiAgDQo+ID4gDQo+ID4gDQo+IA0KPiANCg0K

