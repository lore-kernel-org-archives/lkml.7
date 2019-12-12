Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A2FC2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0196D2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TwGczfOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfLLBhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:37:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35071 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727473AbfLLBhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:37:40 -0500
X-UUID: 844b7efeed284b5a8e5fc471bae98c14-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PipsN9f6SWadwcwIrVs3U74QlgXQz8aVan1+C+FVNtA=;
        b=TwGczfOt/sn2BvfIAJGPx0gzPpkXhck7/79SNxXautFLDURVlPDA85L38tAdur/DzjQjPtRQ2m/SnNHhx0H+ErsCyZd/gqWwDeTpGZbqNJlX51IC30sP8Je4AFlbbd51N3Jis56mgwfE1BU6kKXIZOYJSNazyOs8F+vf43DkqAU=;
X-UUID: 844b7efeed284b5a8e5fc471bae98c14-20191212
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 497109503; Thu, 12 Dec 2019 09:37:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 09:37:17 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 09:37:28 +0800
Message-ID: <1576114652.17653.13.camel@mtkswgap22>
Subject: Re: [PATCH v2 12/14] soc: mediatek: cmdq: add loop function
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 12 Dec 2019 09:37:32 +0800
In-Reply-To: <1576028899.19653.5.camel@mtksdaap41>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-14-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1576028899.19653.5.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFdlZCwgMjAxOS0xMi0xMSBhdCAwOTo0OCArMDgwMCwgQ0sgSHUgd3JvdGU6
DQo+IEhpLCBEZW5uaXM6DQo+IA0KPiBPbiBXZWQsIDIwMTktMTEtMjcgYXQgMDk6NTggKzA4MDAs
IERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBBZGQgZmluYWxpemUgbG9vcCBmdW5jdGlvbiBp
biBjbWRxIGhlbHBlciBmdW5jdGlvbnMgd2hpY2ggbG9vcCB3aG9sZSBwa3QNCj4gPiBpbiBnY2Ug
aGFyZHdhcmUgdGhyZWFkIHdpdGhvdXQgY3B1IG9wZXJhdGlvbi4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMjIg
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9t
dGstY21kcS5oICB8ICA4ICsrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0
aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+
ID4gaW5kZXggMzhlMGMxM2UxOTIyLi4xMGE5YjQ0ODFlNTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IEBAIC00MTQsNiArNDE0LDI4IEBAIGlu
dCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCkNCj4gPiAgfQ0KPiA+ICBF
WFBPUlRfU1lNQk9MKGNtZHFfcGt0X2ZpbmFsaXplKTsNCj4gPiAgDQo+ID4gK2ludCBjbWRxX3Br
dF9maW5hbGl6ZV9sb29wKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1
Y3QgY21kcV9jbGllbnQgKmNsID0gcGt0LT5jbDsNCj4gPiArCXN0cnVjdCBjbWRxX2luc3RydWN0
aW9uIGluc3QgPSB7IHswfSB9Ow0KPiA+ICsJaW50IGVycjsNCj4gPiArDQo+ID4gKwkvKiBpbnNl
cnQgRU9DIGFuZCBnZW5lcmF0ZSBJUlEgZm9yIGVhY2ggY29tbWFuZCBpdGVyYXRpb24gKi8NCj4g
PiArCWluc3Qub3AgPSBDTURRX0NPREVfRU9DOw0KPiA+ICsJZXJyID0gY21kcV9wa3RfYXBwZW5k
X2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiArCWlmIChlcnIgPCAwKQ0KPiA+ICsJCXJldHVybiBl
cnI7DQo+IA0KPiBJdCBsb29rcyBsaWtlIHlvdSB3YW50IGEgcGt0IGV4ZWN1dGUgY29tbWFuZCBy
ZXBlYXRlZGx5LCBidXQgd2h5IGRvIHlvdQ0KPiByZXBlYXRlZGx5IHRyaWdnZXIgSVJRPyBUaGlz
IElSUSB3b3VsZCBkbyBub3RoaW5nIGJlY2F1c2UgdGhpcyBwa3Qgd291bGQNCj4gbmV2ZXIgZmlu
aXNoLg0KPiANCg0Kc2VlIGZvbGxvd2luZyBzZWN0aW9uDQoNCj4gPiArDQo+ID4gKwkvKiBKVU1Q
IGFiYW9sdXRlIHRvIGJlZ2luICovDQo+ID4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX0pVTVA7DQo+
ID4gKwlpbnN0Lm9mZnNldCA9IDE7DQo+ID4gKwlpbnN0LnZhbHVlID0gcGt0LT5wYV9iYXNlID4+
IGNtZHFfbWJveF9zaGlmdChjbC0+Y2hhbik7DQo+ID4gKwllcnIgPSBjbWRxX3BrdF9hcHBlbmRf
Y29tbWFuZChwa3QsIGluc3QpOw0KPiANCj4gV2h5IG5vdCBqdXN0IGV4cG9ydCB0aGlzIGZ1bmN0
aW9uIGFzIGNtZHFfcGt0X2p1bXAoKT8gTGV0IGNsaWVudCBkZWNpZGUNCj4gd2hlcmUgdG8ganVt
cCB3b3VsZCBiZSBtb3JlIGZsZXhpYmxlLg0KPiANCj4gUmVnYXJkcywNCj4gQ0sNCj4gDQoNCm9r
LCBJIHdpbGwgcmVtb3ZlIHRoaXMgcGFydCBhbmQgZXhwb3NlIGNtZHFfcGt0X2p1bXAoKQ0KDQoN
ClJlZ2FyZHMsDQpEZW5uaXMNCg0KPiA+ICsNCj4gPiArCXJldHVybiBlcnI7DQo+ID4gK30NCj4g
PiArRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9maW5hbGl6ZV9sb29wKTsNCj4gPiArDQo+ID4gIHN0
YXRpYyB2b2lkIGNtZHFfcGt0X2ZsdXNoX2FzeW5jX2NiKHN0cnVjdCBjbWRxX2NiX2RhdGEgZGF0
YSkNCj4gPiAgew0KPiA+ICAJc3RydWN0IGNtZHFfcGt0ICpwa3QgPSAoc3RydWN0IGNtZHFfcGt0
ICopZGF0YS5kYXRhOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRl
ay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+
IGluZGV4IDk5OGJjOTBmOWRhOS4uZDE1ZDhjOTQxOTkyIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1
ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gQEAgLTIxMiw2ICsyMTIsMTQgQEAgaW50IGNt
ZHFfcGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgsIHUzMiB2YWx1
ZSk7DQo+ID4gICAqLw0KPiA+ICBpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0
ICpwa3QpOw0KPiA+ICANCj4gPiArLyoqDQo+ID4gKyAqIGNtZHFfcGt0X2ZpbmFsaXplX2xvb3Ao
KSAtIEFwcGVuZCBFT0MgYW5kIGp1bXAgY29tbWFuZCB0byBsb29wIHBrdC4NCj4gPiArICogQHBr
dDoJdGhlIENNRFEgcGFja2V0DQo+ID4gKyAqDQo+ID4gKyAqIFJldHVybjogMCBmb3Igc3VjY2Vz
czsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KPiA+ICsgKi8NCj4gPiAraW50IGNt
ZHFfcGt0X2ZpbmFsaXplX2xvb3Aoc3RydWN0IGNtZHFfcGt0ICpwa3QpOw0KPiA+ICsNCj4gPiAg
LyoqDQo+ID4gICAqIGNtZHFfcGt0X2ZsdXNoX2FzeW5jKCkgLSB0cmlnZ2VyIENNRFEgdG8gYXN5
bmNocm9ub3VzbHkgZXhlY3V0ZSB0aGUgQ01EUQ0KPiA+ICAgKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgcGFja2V0IGFuZCBjYWxsIGJhY2sgYXQgdGhlIGVuZCBvZiBkb25lIHBhY2tldA0KPiAN
Cj4gDQoNCg==

