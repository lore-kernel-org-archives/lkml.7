Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E221CC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BBE20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LQfNUKYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKVK3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:29:10 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:64361 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726722AbfKVK3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:29:09 -0500
X-UUID: bd03a4824b2a405aa53f79f1e975962d-20191122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ofn5YL5zLXO06e+0l5pAe6Qs84VAqzgdrrkyFWlZp5s=;
        b=LQfNUKYHNBeXaej6wynzY9sIuVxeXH3y3sJY9xUw/w2ZjaIEJFSJ3m/Gf9mqm2AlRTjviM4RGsm3K7lSHV7ZfmRcFQzgzNtLglqXALTwBo3UnmagSW0IaEVhhV+IAUwfkgFGFTMMSFRALg8IBQUCfI+ASn6qFsjVXRdrmpKu+B0=;
X-UUID: bd03a4824b2a405aa53f79f1e975962d-20191122
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2144609166; Fri, 22 Nov 2019 18:29:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 22 Nov 2019 18:28:55 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 22 Nov 2019 18:29:23 +0800
Message-ID: <1574418540.11977.19.camel@mtkswgap22>
Subject: Re: [PATCH v1 10/12] soc: mediatek: cmdq: add loop function
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
Date:   Fri, 22 Nov 2019 18:29:00 +0800
In-Reply-To: <1574415960.19450.23.camel@mtksdaap41>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574327552-11806-11-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574415960.19450.23.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIEZyaSwgMjAxOS0xMS0yMiBhdCAxNzo0NiArMDgwMCwgQ0sgSHUgd3JvdGU6
DQo+IEhpLCBEZW5uaXM6DQo+IA0KPiBPbiBUaHUsIDIwMTktMTEtMjEgYXQgMTc6MTIgKzA4MDAs
IERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBBZGQgZmluYWxpemUgbG9vcCBmdW5jdGlvbiBp
biBjbWRxIGhlbHBlciBmdW5jdGlvbnMgd2hpY2ggbG9vcCB3aG9sZSBwa3QNCj4gPiBpbiBnY2Ug
aGFyZHdhcmUgdGhyZWFkIHdpdGhvdXQgY3B1IG9wZXJhdGlvbi4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgICA0
MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oICB8ICAgIDggKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDQ5IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYw0KPiA+IGluZGV4IDQyMzVjZjguLjNiMTAyNDEgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiArKysgYi9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IEBAIC0zODUsMTIgKzM4NSwyNyBA
QCBpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwg
dTMyIHZhbHVlKQ0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0woY21kcV9wa3RfYXNzaWduKTsN
Cj4gPiAgDQo+ID4gK3N0YXRpYyBib29sIGNtZHFfcGt0X2ZpbmFsaXplZChzdHJ1Y3QgY21kcV9w
a3QgKnBrdCkNCj4gPiArew0KPiA+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gKmluc3Q7DQo+
ID4gKw0KPiA+ICsJaWYgKHBrdC0+Y21kX2J1Zl9zaXplIDwgMiAqIENNRFFfSU5TVF9TSVpFKQ0K
PiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiArDQo+ID4gKwlpbnN0ID0gcGt0LT52YV9iYXNlICsg
cGt0LT5jbWRfYnVmX3NpemUgLSAyICogQ01EUV9JTlNUX1NJWkU7DQo+ID4gKwlyZXR1cm4gaW5z
dC0+b3AgPT0gQ01EUV9DT0RFX0VPQzsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBj
bWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCkNCj4gPiAgew0KPiA+ICAJc3Ry
dWN0IGNtZHFfY2xpZW50ICpjbCA9IHBrdC0+Y2w7DQo+ID4gIAlzdHJ1Y3QgY21kcV9pbnN0cnVj
dGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiAgCWludCBlcnI7DQo+ID4gIA0KPiA+ICsJLyogZG8g
bm90IGZpbmFsaXplIHR3aWNlICovDQo+ID4gKwlpZiAoY21kcV9wa3RfZmluYWxpemVkKHBrdCkp
DQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICAJLyogaW5zZXJ0IEVPQyBhbmQgZ2VuZXJh
dGUgSVJRIGZvciBlYWNoIGNvbW1hbmQgaXRlcmF0aW9uICovDQo+ID4gIAlpbnN0Lm9wID0gQ01E
UV9DT0RFX0VPQzsNCj4gPiAgCWluc3QudmFsdWUgPSBDTURRX0VPQ19JUlFfRU47DQo+ID4gQEAg
LTQwNiw2ICs0MjEsMzIgQEAgc3RhdGljIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21k
cV9wa3QgKnBrdCkNCj4gPiAgCXJldHVybiBlcnI7DQo+ID4gIH0NCj4gPiAgDQo+ID4gK2ludCBj
bWRxX3BrdF9maW5hbGl6ZV9sb29wKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiA+ICt7DQo+ID4g
KwlzdHJ1Y3QgY21kcV9jbGllbnQgKmNsID0gcGt0LT5jbDsNCj4gPiArCXN0cnVjdCBjbWRxX2lu
c3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiA+ICsJaW50IGVycjsNCj4gPiArDQo+ID4gKwkv
KiBkbyBub3QgZmluYWxpemUgdHdpY2UgKi8NCj4gPiArCWlmIChjbWRxX3BrdF9maW5hbGl6ZWQo
cGt0KSkNCj4gPiArCQlyZXR1cm4gMDsNCj4gDQo+IFdoeSBub3QganVzdCBleHBvcnQgY21kcV9w
a3RfZmluYWxpemUoKSBmb3IgdXNlciBhbmQgZG8gbm90IGNhbGwNCj4gY21kcV9wa3RfZmluYWxp
emUoKSBpbiBjbWRxX3BrdF9mbHVzaF9hc3luYygpLCBzbyB5b3UgZG9uJ3QgbmVlZCB0bw0KPiBj
aGVjayB0aGlzLg0KPiANCj4gSSB3b3VsZCBiZSBtb3JlIGxpa2UgdG8gZXhwb3J0IEFQSSBzdWNo
IGFzIGNtZHFfcGt0X2VvYygpLA0KPiBjbWRxX3BrdF9qdW1wKCksIHRoaXMgd291bGQgcHJvdmlk
ZSBtb3JlIGZsZXhpYmlsaXR5IGZvciB1c2VyIHRvDQo+IGFzc2VtYmxlIHRoZSBjb21tYW5kIGl0
IHdhbnQuDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudC4N
Cg0KU2hvdWxkIHdlIGJhY2t3YXJkIGNvbXBhdGlibGUgd2l0aCBleGlzdGluZyBjbGllbnRzPyBS
ZW1vdmUgZmluYWxpemUgaW4NCmZsdXNoIHdpbGwgY2F1c2UgZXhpc3RpbmcgY2xpZW50IGZsdXNo
IHdpdGhvdXQgSVJRLg0KDQoNClJlZ2FyZHMsDQpEZW5uaXMNCg0KPiANCj4gPiArDQo+ID4gKwkv
KiBpbnNlcnQgRU9DIGFuZCBnZW5lcmF0ZSBJUlEgZm9yIGVhY2ggY29tbWFuZCBpdGVyYXRpb24g
Ki8NCj4gPiArCWluc3Qub3AgPSBDTURRX0NPREVfRU9DOw0KPiA+ICsJZXJyID0gY21kcV9wa3Rf
YXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiArCWlmIChlcnIgPCAwKQ0KPiA+ICsJCXJl
dHVybiBlcnI7DQo+ID4gKw0KPiA+ICsJLyogSlVNUCBhYmFvbHV0ZSB0byBiZWdpbiAqLw0KPiA+
ICsJaW5zdC5vcCA9IENNRFFfQ09ERV9KVU1QOw0KPiA+ICsJaW5zdC5vZmZzZXQgPSAxOw0KPiA+
ICsJaW5zdC52YWx1ZSA9IHBrdC0+cGFfYmFzZSA+PiBjbWRxX21ib3hfc2hpZnQoY2wtPmNoYW4p
Ow0KPiA+ICsJZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiAr
DQo+ID4gKwlyZXR1cm4gZXJyOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0woY21kcV9wa3Rf
ZmluYWxpemVfbG9vcCk7DQo+ID4gKw0KPiA+ICBzdGF0aWMgdm9pZCBjbWRxX3BrdF9mbHVzaF9h
c3luY19jYihzdHJ1Y3QgY21kcV9jYl9kYXRhIGRhdGEpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBj
bWRxX3BrdCAqcGt0ID0gKHN0cnVjdCBjbWRxX3BrdCAqKWRhdGEuZGF0YTsNCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBpbmRleCBiMzQ3NGYyLi43N2U4OTQ0IDEw
MDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4g
PiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gQEAgLTIw
Myw2ICsyMDMsMTQgQEAgaW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBr
dCwgdTggc3Vic3lzLA0KPiA+ICBpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKTsNCj4gPiAgDQo+ID4gIC8qKg0KPiA+ICsgKiBj
bWRxX3BrdF9maW5hbGl6ZV9sb29wKCkgLSBBcHBlbmQgRU9DIGFuZCBqdW1wIGNvbW1hbmQgdG8g
bG9vcCBwa3QuDQo+ID4gKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiA+ICsgKg0KPiA+ICsg
KiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQN
Cj4gPiArICovDQo+ID4gK2ludCBjbWRxX3BrdF9maW5hbGl6ZV9sb29wKHN0cnVjdCBjbWRxX3Br
dCAqcGt0KTsNCj4gPiArDQo+ID4gKy8qKg0KPiA+ICAgKiBjbWRxX3BrdF9mbHVzaF9hc3luYygp
IC0gdHJpZ2dlciBDTURRIHRvIGFzeW5jaHJvbm91c2x5IGV4ZWN1dGUgdGhlIENNRFENCj4gPiAg
ICogICAgICAgICAgICAgICAgICAgICAgICAgIHBhY2tldCBhbmQgY2FsbCBiYWNrIGF0IHRoZSBl
bmQgb2YgZG9uZSBwYWNrZXQNCj4gPiAgICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+IA0KPiAN
Cg0K

