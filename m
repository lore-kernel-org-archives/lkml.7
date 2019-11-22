Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9267EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF1820708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QUPYlak4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfKVJqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:46:18 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:24318 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727118AbfKVJqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:46:04 -0500
X-UUID: b67fe2021e644565b7f2fb626ad3a460-20191122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2ejSPwYplNKFDxLWJEW8hsrMYzKNBiloV5tEi9RI1Ag=;
        b=QUPYlak4FGynWG7yjOJa/3hANi8HiwO8bQdZa7VDoXtygZWieT4qbxvzcSl4CV+L6sIuiFoSs7qnE0aWQeWTSIzfei1VCY6Bna+SqXBfE6BC0W5MfTRec76oYphJkrzHfybHXtWoGKor9QqA54EIG8G8efh79h+q/HbTxUTLpkY=;
X-UUID: b67fe2021e644565b7f2fb626ad3a460-20191122
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 516072111; Fri, 22 Nov 2019 17:46:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 22 Nov 2019 17:45:53 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 22 Nov 2019 17:45:51 +0800
Message-ID: <1574415960.19450.23.camel@mtksdaap41>
Subject: Re: [PATCH v1 10/12] soc: mediatek: cmdq: add loop function
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 22 Nov 2019 17:46:00 +0800
In-Reply-To: <1574327552-11806-11-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574327552-11806-11-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gVGh1LCAyMDE5LTExLTIxIGF0IDE3OjEyICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCBmaW5hbGl6ZSBsb29wIGZ1bmN0aW9uIGluIGNtZHEgaGVs
cGVyIGZ1bmN0aW9ucyB3aGljaCBsb29wIHdob2xlIHBrdA0KPiBpbiBnY2UgaGFyZHdhcmUgdGhy
ZWFkIHdpdGhvdXQgY3B1IG9wZXJhdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZ
QyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8ICAgNDEgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgg
IHwgICAgOCArKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBi
L2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGluZGV4IDQyMzVjZjgu
LjNiMTAyNDEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+
IEBAIC0zODUsMTIgKzM4NSwyNyBAQCBpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBjbWRxX3Br
dCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKQ0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTChj
bWRxX3BrdF9hc3NpZ24pOw0KPiAgDQo+ICtzdGF0aWMgYm9vbCBjbWRxX3BrdF9maW5hbGl6ZWQo
c3RydWN0IGNtZHFfcGt0ICpwa3QpDQo+ICt7DQo+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24g
Kmluc3Q7DQo+ICsNCj4gKwlpZiAocGt0LT5jbWRfYnVmX3NpemUgPCAyICogQ01EUV9JTlNUX1NJ
WkUpDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKw0KPiArCWluc3QgPSBwa3QtPnZhX2Jhc2UgKyBw
a3QtPmNtZF9idWZfc2l6ZSAtIDIgKiBDTURRX0lOU1RfU0laRTsNCj4gKwlyZXR1cm4gaW5zdC0+
b3AgPT0gQ01EUV9DT0RFX0VPQzsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBjbWRxX3BrdF9m
aW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCkNCj4gIHsNCj4gIAlzdHJ1Y3QgY21kcV9jbGll
bnQgKmNsID0gcGt0LT5jbDsNCj4gIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7
MH0gfTsNCj4gIAlpbnQgZXJyOw0KPiAgDQo+ICsJLyogZG8gbm90IGZpbmFsaXplIHR3aWNlICov
DQo+ICsJaWYgKGNtZHFfcGt0X2ZpbmFsaXplZChwa3QpKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0K
PiAgCS8qIGluc2VydCBFT0MgYW5kIGdlbmVyYXRlIElSUSBmb3IgZWFjaCBjb21tYW5kIGl0ZXJh
dGlvbiAqLw0KPiAgCWluc3Qub3AgPSBDTURRX0NPREVfRU9DOw0KPiAgCWluc3QudmFsdWUgPSBD
TURRX0VPQ19JUlFfRU47DQo+IEBAIC00MDYsNiArNDIxLDMyIEBAIHN0YXRpYyBpbnQgY21kcV9w
a3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQo+ICAJcmV0dXJuIGVycjsNCj4gIH0N
Cj4gIA0KPiAraW50IGNtZHFfcGt0X2ZpbmFsaXplX2xvb3Aoc3RydWN0IGNtZHFfcGt0ICpwa3Qp
DQo+ICt7DQo+ICsJc3RydWN0IGNtZHFfY2xpZW50ICpjbCA9IHBrdC0+Y2w7DQo+ICsJc3RydWN0
IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ICsJaW50IGVycjsNCj4gKw0KPiAr
CS8qIGRvIG5vdCBmaW5hbGl6ZSB0d2ljZSAqLw0KPiArCWlmIChjbWRxX3BrdF9maW5hbGl6ZWQo
cGt0KSkNCj4gKwkJcmV0dXJuIDA7DQoNCldoeSBub3QganVzdCBleHBvcnQgY21kcV9wa3RfZmlu
YWxpemUoKSBmb3IgdXNlciBhbmQgZG8gbm90IGNhbGwNCmNtZHFfcGt0X2ZpbmFsaXplKCkgaW4g
Y21kcV9wa3RfZmx1c2hfYXN5bmMoKSwgc28geW91IGRvbid0IG5lZWQgdG8NCmNoZWNrIHRoaXMu
DQoNCkkgd291bGQgYmUgbW9yZSBsaWtlIHRvIGV4cG9ydCBBUEkgc3VjaCBhcyBjbWRxX3BrdF9l
b2MoKSwNCmNtZHFfcGt0X2p1bXAoKSwgdGhpcyB3b3VsZCBwcm92aWRlIG1vcmUgZmxleGliaWxp
dHkgZm9yIHVzZXIgdG8NCmFzc2VtYmxlIHRoZSBjb21tYW5kIGl0IHdhbnQuDQoNClJlZ2FyZHMs
DQpDSw0KDQo+ICsNCj4gKwkvKiBpbnNlcnQgRU9DIGFuZCBnZW5lcmF0ZSBJUlEgZm9yIGVhY2gg
Y29tbWFuZCBpdGVyYXRpb24gKi8NCj4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX0VPQzsNCj4gKwll
cnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiArCWlmIChlcnIgPCAw
KQ0KPiArCQlyZXR1cm4gZXJyOw0KPiArDQo+ICsJLyogSlVNUCBhYmFvbHV0ZSB0byBiZWdpbiAq
Lw0KPiArCWluc3Qub3AgPSBDTURRX0NPREVfSlVNUDsNCj4gKwlpbnN0Lm9mZnNldCA9IDE7DQo+
ICsJaW5zdC52YWx1ZSA9IHBrdC0+cGFfYmFzZSA+PiBjbWRxX21ib3hfc2hpZnQoY2wtPmNoYW4p
Ow0KPiArCWVyciA9IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ICsNCj4g
KwlyZXR1cm4gZXJyOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9maW5hbGl6ZV9s
b29wKTsNCj4gKw0KPiAgc3RhdGljIHZvaWQgY21kcV9wa3RfZmx1c2hfYXN5bmNfY2Ioc3RydWN0
IGNtZHFfY2JfZGF0YSBkYXRhKQ0KPiAgew0KPiAgCXN0cnVjdCBjbWRxX3BrdCAqcGt0ID0gKHN0
cnVjdCBjbWRxX3BrdCAqKWRhdGEuZGF0YTsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
c29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGst
Y21kcS5oDQo+IGluZGV4IGIzNDc0ZjIuLjc3ZTg5NDQgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBAQCAtMjAzLDYgKzIwMywxNCBAQCBpbnQgY21kcV9wa3Rf
cG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ICBpbnQgY21kcV9w
a3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKTsN
Cj4gIA0KPiAgLyoqDQo+ICsgKiBjbWRxX3BrdF9maW5hbGl6ZV9sb29wKCkgLSBBcHBlbmQgRU9D
IGFuZCBqdW1wIGNvbW1hbmQgdG8gbG9vcCBwa3QuDQo+ICsgKiBAcGt0Ogl0aGUgQ01EUSBwYWNr
ZXQNCj4gKyAqDQo+ICsgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNv
ZGUgaXMgcmV0dXJuZWQNCj4gKyAqLw0KPiAraW50IGNtZHFfcGt0X2ZpbmFsaXplX2xvb3Aoc3Ry
dWN0IGNtZHFfcGt0ICpwa3QpOw0KPiArDQo+ICsvKioNCj4gICAqIGNtZHFfcGt0X2ZsdXNoX2Fz
eW5jKCkgLSB0cmlnZ2VyIENNRFEgdG8gYXN5bmNocm9ub3VzbHkgZXhlY3V0ZSB0aGUgQ01EUQ0K
PiAgICogICAgICAgICAgICAgICAgICAgICAgICAgIHBhY2tldCBhbmQgY2FsbCBiYWNrIGF0IHRo
ZSBlbmQgb2YgZG9uZSBwYWNrZXQNCj4gICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KDQo=

