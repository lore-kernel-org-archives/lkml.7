Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF19C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C118C214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pXz5FsZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfLMHtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:49:05 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:34443 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725497AbfLMHtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:49:05 -0500
X-UUID: 02007113592242d1a16f3286fb5986ac-20191213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=BtXET+1NElrPbMJwRKiAbYUNzkYHcN515L3qrDyBFRk=;
        b=pXz5FsZsYlJz8svVObFaMi64OE1cx8Rnw1TMrx2oaYO4tfHCeHkuFuKT92R4c8anxQ9QgbTYOcWfiXROrlsyKDVLB45tJfAFVaIGaBddIJw8CDBRjjD7RmiROjnRDf9XK+2BO2JA47xzH8v7LRAmEFIeC55E+rAbNftWJhlGDGo=;
X-UUID: 02007113592242d1a16f3286fb5986ac-20191213
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 561960265; Fri, 13 Dec 2019 15:48:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Dec 2019 15:48:39 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Dec 2019 15:48:46 +0800
Message-ID: <1576223336.9817.3.camel@mtksdaap41>
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
Date:   Fri, 13 Dec 2019 15:48:56 +0800
In-Reply-To: <1576222132-31586-2-git-send-email-yongqiang.niu@mediatek.com>
References: <1576222132-31586-1-git-send-email-yongqiang.niu@mediatek.com>
         <1576222132-31586-2-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B2D976F46AAC6B6E1746EF1ECE6AC29281FF83D79D292527E390BA3DF3F8755E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KVGhlIHRpdGxlIGlzIHRvbyByb3VnaC4gQW55IGJ1ZyBvZiBnYW1t
YSB3b3VsZCBiZSB0aGlzIHRpdGxlLiBJIHdvdWxkDQpsaWtlIHRoZSB0aXRsZSBzaG93IGV4cGxp
Y2l0bHkgd2hhdCBpdCBkb2VzLg0KDQpPbiBGcmksIDIwMTktMTItMTMgYXQgMTU6MjggKzA4MDAs
IFlvbmdxaWFuZyBOaXUgd3JvdGU6DQo+IGlmIHRoZXJlIGlzIG5vIGdhbW1hIGZ1bmN0aW9uIGlu
IHRoZSBjcnRjDQo+IGRpc3BsYXkgcGF0aCwgZG9uJ3QgYWRkIGdhbW1hIHByb3BlcnR5DQo+IGZv
ciBjcnRjDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1
QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9jcnRjLmMgfCAxMCArKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2NydGMuYw0KPiBpbmRleCBjYTRmYzQ3Li45YThlMWQ0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IEBAIC03MzQsNiArNzM0LDcgQEAgaW50IG10a19k
cm1fY3J0Y19jcmVhdGUoc3RydWN0IGRybV9kZXZpY2UgKmRybV9kZXYsDQo+ICAJaW50IHBpcGUg
PSBwcml2LT5udW1fcGlwZXM7DQo+ICAJaW50IHJldDsNCj4gIAlpbnQgaTsNCj4gKwl1aW50IGdh
bW1hX2x1dF9zaXplID0gMDsNCj4gIA0KPiAgCWlmICghcGF0aCkNCj4gIAkJcmV0dXJuIDA7DQo+
IEBAIC03ODUsNiArNzg2LDkgQEAgaW50IG10a19kcm1fY3J0Y19jcmVhdGUoc3RydWN0IGRybV9k
ZXZpY2UgKmRybV9kZXYsDQo+ICAJCX0NCj4gIA0KPiAgCQltdGtfY3J0Yy0+ZGRwX2NvbXBbaV0g
PSBjb21wOw0KPiArDQo+ICsJCWlmIChjb21wLT5mdW5jcy0+Z2FtbWFfc2V0KQ0KPiArCQkJZ2Ft
bWFfbHV0X3NpemUgPSBNVEtfTFVUX1NJWkU7DQo+ICAJfQ0KPiAgDQo+ICAJZm9yIChpID0gMDsg
aSA8IG10a19jcnRjLT5kZHBfY29tcF9ucjsgaSsrKQ0KPiBAQCAtODA1LDggKzgwOSwxMCBAQCBp
bnQgbXRrX2RybV9jcnRjX2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZHJtX2RldiwNCj4gIAkJ
CQlOVUxMLCBwaXBlKTsNCj4gIAlpZiAocmV0IDwgMCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gLQlk
cm1fbW9kZV9jcnRjX3NldF9nYW1tYV9zaXplKCZtdGtfY3J0Yy0+YmFzZSwgTVRLX0xVVF9TSVpF
KTsNCj4gLQlkcm1fY3J0Y19lbmFibGVfY29sb3JfbWdtdCgmbXRrX2NydGMtPmJhc2UsIDAsIGZh
bHNlLCBNVEtfTFVUX1NJWkUpOw0KPiArDQo+ICsJaWYgKGdhbW1hX2x1dF9zaXplKQ0KPiArCQlk
cm1fbW9kZV9jcnRjX3NldF9nYW1tYV9zaXplKCZtdGtfY3J0Yy0+YmFzZSwgZ2FtbWFfbHV0X3Np
emUpOw0KPiArCWRybV9jcnRjX2VuYWJsZV9jb2xvcl9tZ210KCZtdGtfY3J0Yy0+YmFzZSwgMCwg
ZmFsc2UsIGdhbW1hX2x1dF9zaXplKTsNCg0KSWYgdGhlcmUgaXMgbm8gZ2FtbWEsIHNoYWxsIHdl
IGVuYWJsZSBjb2xvciBtYW5hZ2VtZW50Pw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAgCXByaXYtPm51
bV9waXBlcysrOw0KPiAgCW11dGV4X2luaXQoJm10a19jcnRjLT5od19sb2NrKTsNCj4gIA0KDQo=

