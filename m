Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B01FC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C86C2465A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E0OJZXP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLMIWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:22:48 -0500
Received: from mailgw02.mediatek.com ([216.200.240.185]:60221 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfLMIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:22:47 -0500
X-UUID: 02c8eb1eb31443d59c20f316aad7c71e-20191213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=3iGzWvQ973vDVy2jTOS5BARL9ANWb/8ieSVfodrTkr4=;
        b=E0OJZXP7CFIIiOND7EZdxZ/6RSDw+BPQGnB2xYPTcp27ez2h0wA5iduHuekmT7ygbheSIjLwb1mXEZXyyf4Wd4ODg1++1KNEoiA7HLxuJJWNo4AqjNU7s4UDqjE2epMKL3nWHQBgnPrHlW7zJMAPge2J2RdTVbHEoeNlDYvTXlc=;
X-UUID: 02c8eb1eb31443d59c20f316aad7c71e-20191213
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1009231870; Fri, 13 Dec 2019 00:22:45 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n2.mediatek.inc
 (172.21.101.140) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 13 Dec
 2019 16:02:52 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Dec 2019 16:03:11 +0800
Message-ID: <1576224191.31822.2.camel@mhfsdcap03>
Subject: Re: [PATCH v2, 1/2] drm/mediatek: Fix gamma correction issue
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 13 Dec 2019 16:03:11 +0800
In-Reply-To: <1576223336.9817.3.camel@mtksdaap41>
References: <1576222132-31586-1-git-send-email-yongqiang.niu@mediatek.com>
         <1576222132-31586-2-git-send-email-yongqiang.niu@mediatek.com>
         <1576223336.9817.3.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTEyLTEzIGF0IDE1OjQ4ICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIFlv
bmdxaWFuZzoNCj4gDQo+IFRoZSB0aXRsZSBpcyB0b28gcm91Z2guIEFueSBidWcgb2YgZ2FtbWEg
d291bGQgYmUgdGhpcyB0aXRsZS4gSSB3b3VsZA0KPiBsaWtlIHRoZSB0aXRsZSBzaG93IGV4cGxp
Y2l0bHkgd2hhdCBpdCBkb2VzLg0KPiANCj4gT24gRnJpLCAyMDE5LTEyLTEzIGF0IDE1OjI4ICsw
ODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0KPiA+IGlmIHRoZXJlIGlzIG5vIGdhbW1hIGZ1bmN0
aW9uIGluIHRoZSBjcnRjDQo+ID4gZGlzcGxheSBwYXRoLCBkb24ndCBhZGQgZ2FtbWEgcHJvcGVy
dHkNCj4gPiBmb3IgY3J0Yw0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUg
PHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgfCAxMCArKysrKysrKy0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+IGluZGV4IGNhNGZjNDcuLjlhOGUx
ZDQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+
ID4gQEAgLTczNCw2ICs3MzQsNyBAQCBpbnQgbXRrX2RybV9jcnRjX2NyZWF0ZShzdHJ1Y3QgZHJt
X2RldmljZSAqZHJtX2RldiwNCj4gPiAgCWludCBwaXBlID0gcHJpdi0+bnVtX3BpcGVzOw0KPiA+
ICAJaW50IHJldDsNCj4gPiAgCWludCBpOw0KPiA+ICsJdWludCBnYW1tYV9sdXRfc2l6ZSA9IDA7
DQo+ID4gIA0KPiA+ICAJaWYgKCFwYXRoKQ0KPiA+ICAJCXJldHVybiAwOw0KPiA+IEBAIC03ODUs
NiArNzg2LDkgQEAgaW50IG10a19kcm1fY3J0Y19jcmVhdGUoc3RydWN0IGRybV9kZXZpY2UgKmRy
bV9kZXYsDQo+ID4gIAkJfQ0KPiA+ICANCj4gPiAgCQltdGtfY3J0Yy0+ZGRwX2NvbXBbaV0gPSBj
b21wOw0KPiA+ICsNCj4gPiArCQlpZiAoY29tcC0+ZnVuY3MtPmdhbW1hX3NldCkNCj4gPiArCQkJ
Z2FtbWFfbHV0X3NpemUgPSBNVEtfTFVUX1NJWkU7DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICAJZm9y
IChpID0gMDsgaSA8IG10a19jcnRjLT5kZHBfY29tcF9ucjsgaSsrKQ0KPiA+IEBAIC04MDUsOCAr
ODA5LDEwIEBAIGludCBtdGtfZHJtX2NydGNfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkcm1f
ZGV2LA0KPiA+ICAJCQkJTlVMTCwgcGlwZSk7DQo+ID4gIAlpZiAocmV0IDwgMCkNCj4gPiAgCQly
ZXR1cm4gcmV0Ow0KPiA+IC0JZHJtX21vZGVfY3J0Y19zZXRfZ2FtbWFfc2l6ZSgmbXRrX2NydGMt
PmJhc2UsIE1US19MVVRfU0laRSk7DQo+ID4gLQlkcm1fY3J0Y19lbmFibGVfY29sb3JfbWdtdCgm
bXRrX2NydGMtPmJhc2UsIDAsIGZhbHNlLCBNVEtfTFVUX1NJWkUpOw0KPiA+ICsNCj4gPiArCWlm
IChnYW1tYV9sdXRfc2l6ZSkNCj4gPiArCQlkcm1fbW9kZV9jcnRjX3NldF9nYW1tYV9zaXplKCZt
dGtfY3J0Yy0+YmFzZSwgZ2FtbWFfbHV0X3NpemUpOw0KPiA+ICsJZHJtX2NydGNfZW5hYmxlX2Nv
bG9yX21nbXQoJm10a19jcnRjLT5iYXNlLCAwLCBmYWxzZSwgZ2FtbWFfbHV0X3NpemUpOw0KPiAN
Cj4gSWYgdGhlcmUgaXMgbm8gZ2FtbWEsIHNoYWxsIHdlIGVuYWJsZSBjb2xvciBtYW5hZ2VtZW50
Pw0KPiANCj4gUmVnYXJkcywNCj4gQ0sNCg0KZHJtX2NydGNfZW5hYmxlX2NvbG9yX21nbXQgd2ls
bCBjaGVjayB0aGUgZ2FtbWFfbHV0X3NpemUgcGFyYW1ldGVyLA0KaWYgbm8gZ2FtbWEsIGdhbW1h
X2x1dF9zaXplIHdpbGwgYmUgMCwgYW5kIGdhbW1hX2x1dF9zaXplIHdpbGwgbm90IGF0dGNoDQpn
YW1tYSBwcm9wZXJ0eSBmb3IgdGhlIGNydGMNCj4gDQo+ID4gIAlwcml2LT5udW1fcGlwZXMrKzsN
Cj4gPiAgCW11dGV4X2luaXQoJm10a19jcnRjLT5od19sb2NrKTsNCj4gPiAgDQo+IA0KPiANCg0K

