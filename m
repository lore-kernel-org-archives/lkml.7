Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D6CC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D0A205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VY3oVp/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLKCEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 21:04:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:32077 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726364AbfLKCEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:04:55 -0500
X-UUID: c0e289d8c5a64e7384b49c4353133d96-20191211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=wg0RWtXnuazbnyWqaYUsInjXzTF5INnndGMTSvzSNXg=;
        b=VY3oVp/kL+4z2JOIh6bbMIsWlTardtrptRq8k9S4xbwlHMFQhmFX6w1QBYXwA4lPtmAOBafnMXubU2L5qZncv3+adK1yTBkxszBKyb7X1+KbwN9wdT+5UAnkAqyyIE7/RrSrkfKFhR1P8neRM0mH7qGyXWVTwSlhjrWfoAfzhFU=;
X-UUID: c0e289d8c5a64e7384b49c4353133d96-20191211
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 599611083; Wed, 11 Dec 2019 10:04:49 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Dec 2019 10:04:22 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Dec 2019 10:04:43 +0800
Message-ID: <1576029887.19653.17.camel@mtksdaap41>
Subject: Re: [PATCH v2 13/14] soc: mediatek: cmdq: add wait no clear event
 function
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
Date:   Wed, 11 Dec 2019 10:04:47 +0800
In-Reply-To: <1574819937-6246-15-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-15-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gV2VkLCAyMDE5LTExLTI3IGF0IDA5OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCB3YWl0IG5vIGNsZWFyIGV2ZW50IGZ1bmN0aW9uIGluIGNt
ZHEgaGVscGVyIGZ1bmN0aW9ucyB0byB3YWl0IHNwZWNpZmljDQo+IGV2ZW50IHdpdGhvdXQgY2xl
YXIgdG8gMCBhZnRlciByZWNlaXZlIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGVubmlzIFlD
IEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
c29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMTUgKysrKysrKysrKysrKysrDQo+ICBp
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICB8IDEwICsrKysrKysrKysNCj4g
IDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gaW5kZXggMTBhOWI0NDgxZTU4Li42ZjI3MGZhZGZiNTAg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+
ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IEBAIC0zMzAs
NiArMzMwLDIxIEBAIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBl
dmVudCkNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0woY21kcV9wa3Rfd2ZlKTsNCj4gIA0KPiAraW50
IGNtZHFfcGt0X3dhaXRfbm9fY2xlYXIoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCkN
Cj4gK3sNCj4gKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gKw0K
PiArCWlmIChldmVudCA+PSBDTURRX01BWF9FVkVOVCkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+
ICsNCj4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX1dGRTsNCj4gKwlpbnN0LnZhbHVlID0gQ01EUV9X
RkVfV0FJVCB8IENNRFFfV0ZFX1dBSVRfVkFMVUU7DQo+ICsJaW5zdC5ldmVudCA9IGV2ZW50Ow0K
PiArDQo+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ICt9
DQo+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dhaXRfbm9fY2xlYXIpOw0KDQpTbyB0aGUgd2Fp
dCBjb21tYW5kIGhhcyB0d28gdmVyc2lvbiwgb25lIGlzIHdhaXQgYW5kIHRoZW4gY2xlYXIgZXZl
bnQsDQphbm90aGVyIGlzIHdhaXQgYW5kIG5vdCBjbGVhciBldmVudC4gVGhlIG5hbWUgb2YgY21k
cV9wa3Rfd2ZlKCkgaXMgJ3dhaXQNCmZvciBldmVudCcsIHNvIGl0J3MgdHJpdmlhbCB0aGF0IHdl
IHRoaW5rIGl0IGRvZXMgbm90IGNsZWFyIGV2ZW50LiBJJ3ZlDQp0aHJlZSBzdWdnZXN0aW9uIGZv
ciB0aGlzOg0KDQoxLiBMZXQgY21kcV9wa3Rfd2ZlKCkgd2FpdCBhbmQgbm90IGNsZWFyIGV2ZW50
LCBhbmQNCmNtZHFfcGt0X3dmZV9jbGVhcl9ldmVudCgpIHdhaXQgYW5kIGNsZWFyIGV2ZW50Lg0K
DQpvciANCjIuIExldCBjbWRxX3BrdF93ZmUoKSBoYXMgYSBwYXJhbWV0ZXIgdG8gaW5kaWNhdGUg
dGhhdCBjbGVhciBldmVudCBvcg0Kbm90IGFmdGVyIHdhaXQuDQoNCm9yDQozLiBMZXQgY21kcV9w
a3Rfd2ZlKCkgd2FpdCBhbmQgbm90IGNsZWFyIGV2ZW50LCBhbmQgbm90IHByb3ZpZGUgd2FpdCBh
bmQNCmNsZWFyIGV2ZW50IHZlcnNpb24uIEZvciBEUk0gYW5kIE1EUCwgSSB0aGluayBib3RoIGp1
c3QgbmVlZCB3YWl0IGFuZA0Kbm90IGNsZWFyIGV2ZW50Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KDQo+
ICsNCj4gIGludCBjbWRxX3BrdF9jbGVhcl9ldmVudChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2
IGV2ZW50KQ0KPiAgew0KPiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9
Ow0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gaW5kZXggZDE1ZDhjOTQx
OTkyLi40MGJjNjFhZDhkMzEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL210ay1jbWRxLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEuaA0KPiBAQCAtMTQ5LDYgKzE0OSwxNiBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfc192YWx1ZShz
dHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyLA0KPiAgICovDQo+ICBpbnQgY21k
cV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpOw0KPiAgDQo+ICsvKioN
Cj4gKyAqIGNtZHFfcGt0X3dhaXRfbm9fY2xlYXIoKSAtIEFwcGVuZCB3YWl0IGZvciBldmVudCBj
b21tYW5kIHRvIHRoZSBDTURRIHBhY2tldCwNCj4gKyAqCQkJICAgICAgd2l0aG91dCB1cGRhdGUg
ZXZlbnQgdG8gMCBhZnRlciByZWNlaXZlIGl0Lg0KPiArICogQHBrdDoJdGhlIENNRFEgcGFja2V0
DQo+ICsgKiBAZXZlbnQ6CXRoZSBkZXNpcmVkIGV2ZW50IHR5cGUgdG8gd2FpdA0KPiArICoNCj4g
KyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5l
ZA0KPiArICovDQo+ICtpbnQgY21kcV9wa3Rfd2FpdF9ub19jbGVhcihzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCwgdTE2IGV2ZW50KTsNCj4gKw0KPiAgLyoqDQo+ICAgKiBjbWRxX3BrdF9jbGVhcl9ldmVu
dCgpIC0gYXBwZW5kIGNsZWFyIGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQo+ICAg
KiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCg0K

