Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2ACC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 05:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD7620674
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 05:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XzUfiHpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKYFf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 00:35:28 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:10542 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725497AbfKYFf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 00:35:27 -0500
X-UUID: ad322afed21944719a577c32324ae135-20191125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=R/fHdMtlVUsGDVLO9pKCFuPa6QvJ5ONRYikmv2XpPww=;
        b=XzUfiHpV04o09GdqLnmCJmT+yP5tPEeToOXYsAKgjgDNapu9L+5BebnaxQypXZ95CgGR4lLFn98Gm6ExXJJJ109V8HzJagvGpQWlMfeBDWj98QsVlFq9Mx7jLKyFYvMQsPp4G1RFBCzm3Ty6hEfdJyhd/zhrL2eviOE9fPF/+YE=;
X-UUID: ad322afed21944719a577c32324ae135-20191125
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1258170309; Mon, 25 Nov 2019 13:35:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 25 Nov 2019 13:34:49 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Nov 2019 13:34:40 +0800
Message-ID: <1574660121.26500.1.camel@mtksdaap41>
Subject: Re: [PATCH v1 06/12] soc: mediatek: cmdq: add assign function
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
Date:   Mon, 25 Nov 2019 13:35:21 +0800
In-Reply-To: <1574327552-11806-7-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574327552-11806-7-git-send-email-dennis-yc.hsieh@mediatek.com>
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
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCBhc3NpZ24gZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgd2hp
Y2ggYXNzaWduIGNvbnN0YW50IHZhbHVlIGludG8NCj4gaW50ZXJuYWwgcmVnaXN0ZXIgYnkgaW5k
ZXguDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2ll
aEBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEt
aGVscGVyLmMgICB8ICAgMjQgKysrKysrKysrKysrKysrKysrKysrKystDQo+ICBpbmNsdWRlL2xp
bnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgICAgMSArDQo+ICBpbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwgICAxNCArKysrKysrKysrKysrKw0KPiAgMyBm
aWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiBpbmRleCAyNzRmNmYzLi5kNDE5ZTk5
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0K
PiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiBAQCAtMTQs
NiArMTQsNyBAQA0KPiAgI2RlZmluZSBDTURRX0VPQ19JUlFfRU4JCUJJVCgwKQ0KPiAgI2RlZmlu
ZSBDTURRX0VPQ19DTUQJCSgodTY0KSgoQ01EUV9DT0RFX0VPQyA8PCBDTURRX09QX0NPREVfU0hJ
RlQpKSBcDQo+ICAJCQkJPDwgMzIgfCBDTURRX0VPQ19JUlFfRU4pDQo+ICsjZGVmaW5lIENNRFFf
UkVHX1RZUEUJCTENCj4gIA0KPiAgc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gew0KPiAgCXVuaW9u
IHsNCj4gQEAgLTIzLDggKzI0LDE3IEBAIHN0cnVjdCBjbWRxX2luc3RydWN0aW9uIHsNCj4gIAl1
bmlvbiB7DQo+ICAJCXUxNiBvZmZzZXQ7DQo+ICAJCXUxNiBldmVudDsNCj4gKwkJdTE2IHJlZ19k
c3Q7DQo+ICsJfTsNCj4gKwl1bmlvbiB7DQo+ICsJCXU4IHN1YnN5czsNCj4gKwkJc3RydWN0IHsN
Cj4gKwkJCXU4IHNvcDo1Ow0KPiArCQkJdTggYXJnX2NfdDoxOw0KPiArCQkJdTggYXJnX2JfdDox
Ow0KPiArCQkJdTggYXJnX2FfdDoxOw0KPiArCQl9Ow0KPiAgCX07DQo+IC0JdTggc3Vic3lzOw0K
PiAgCXU4IG9wOw0KPiAgfTsNCj4gIA0KPiBAQCAtMjc5LDYgKzI4OSwxOCBAQCBpbnQgY21kcV9w
a3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ICB9DQo+ICBF
WFBPUlRfU1lNQk9MKGNtZHFfcGt0X3BvbGxfbWFzayk7DQo+ICANCj4gK2ludCBjbWRxX3BrdF9h
c3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpDQo+ICt7
DQo+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ICsNCj4gKwlp
bnN0Lm9wID0gQ01EUV9DT0RFX0xPR0lDOw0KPiArCWluc3QuYXJnX2FfdCA9IENNRFFfUkVHX1RZ
UEU7DQoNCkl0IGxvb2tzIGxpa2UgdGhhdCBhcmdfYV90IGNvdWxkIGhhdmUgYSBtZWFuaW5nZnVs
IG5hbWUuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJaW5zdC5yZWdfZHN0ID0gcmVnX2lkeDsNCj4g
KwlpbnN0LnZhbHVlID0gdmFsdWU7DQo+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5k
KHBrdCwgaW5zdCk7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQo+
ICsNCj4gIHN0YXRpYyBpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3Qp
DQo+ICB7DQo+ICAJc3RydWN0IGNtZHFfY2xpZW50ICpjbCA9IHBrdC0+Y2w7DQo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIGIvaW5jbHVkZS9s
aW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiBpbmRleCBkZmU1YjJlLi4xMjFjM2Ji
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5o
DQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gQEAg
LTU5LDYgKzU5LDcgQEAgZW51bSBjbWRxX2NvZGUgew0KPiAgCUNNRFFfQ09ERV9KVU1QID0gMHgx
MCwNCj4gIAlDTURRX0NPREVfV0ZFID0gMHgyMCwNCj4gIAlDTURRX0NPREVfRU9DID0gMHg0MCwN
Cj4gKwlDTURRX0NPREVfTE9HSUMgPSAweGEwLA0KPiAgfTsNCj4gIA0KPiAgZW51bSBjbWRxX2Ni
X3N0YXR1cyB7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGst
Y21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBpbmRleCBh
NzRjMWQ1Li44MzM0MDIxIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRl
ay9tdGstY21kcS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRx
LmgNCj4gQEAgLTE1Miw2ICsxNTIsMjAgQEAgaW50IGNtZHFfcGt0X3BvbGwoc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gICAqLw0KPiAgaW50IGNtZHFfcGt0X3BvbGxfbWFzayhz
dHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiAgCQkgICAgICAgdTE2IG9mZnNldCwg
dTMyIHZhbHVlLCB1MzIgbWFzayk7DQo+ICsNCj4gKy8qKg0KPiArICogY21kcV9wa3RfYXNzaWdu
KCkgLSBBcHBlbmQgbG9naWMgYXNzaWduIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0LCBhc2sg
R0NFDQo+ICsgKgkJICAgICAgIHRvIGV4ZWN1dGUgYW4gaW5zdHJ1Y3Rpb24gdGhhdCBzZXQgYSBj
b25zdGFudCB2YWx1ZSBpbnRvDQo+ICsgKgkJICAgICAgIGludGVybmFsIHJlZ2lzdGVyIGFuZCB1
c2UgYXMgdmFsdWUsIG1hc2sgb3IgYWRkcmVzcyBpbg0KPiArICoJCSAgICAgICByZWFkL3dyaXRl
IGluc3RydWN0aW9uLg0KPiArICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+ICsgKiBAcmVnX2lk
eDoJdGhlIENNRFEgaW50ZXJuYWwgcmVnaXN0ZXIgSUQNCj4gKyAqIEB2YWx1ZToJdGhlIHNwZWNp
ZmllZCB2YWx1ZQ0KPiArICoNCj4gKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUg
ZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KPiArICovDQo+ICtpbnQgY21kcV9wa3RfYXNzaWduKHN0
cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKTsNCj4gKw0KPiAgLyoq
DQo+ICAgKiBjbWRxX3BrdF9mbHVzaF9hc3luYygpIC0gdHJpZ2dlciBDTURRIHRvIGFzeW5jaHJv
bm91c2x5IGV4ZWN1dGUgdGhlIENNRFENCj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICBw
YWNrZXQgYW5kIGNhbGwgYmFjayBhdCB0aGUgZW5kIG9mIGRvbmUgcGFja2V0DQoNCg==

