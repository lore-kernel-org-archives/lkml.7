Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3F8C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95E3205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BNKMjaJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfLEEu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 23:50:57 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:44330 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728132AbfLEEu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 23:50:57 -0500
X-UUID: 80e41ad940cc4919b21879b35da00e57-20191205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=s/Zob46rm/gB42OZlQiOKfWys+tar2a34P8ilcTgUYg=;
        b=BNKMjaJ/ksGMOaMMvXaZIuOcOcnl9BRlZnrv4Dt8JJKdEZFeDBZqroPPWOyTjNb6zXUTo06i27kaHtZN4MK2FNv+5187z3yCboj+lf6ko9DaOJHvNhLhNPsfwJlighrqHd545+ON3WzxdqYCLE0383JExiAezVRcB6507i27mGQ=;
X-UUID: 80e41ad940cc4919b21879b35da00e57-20191205
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2009789987; Thu, 05 Dec 2019 12:50:49 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Dec 2019 12:50:32 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Dec 2019 12:49:50 +0800
Message-ID: <1575521448.24783.11.camel@mtksdaap41>
Subject: Re: [PATCH v3 5/6] drm/mediatek: support CMDQ interface in ddp
 component
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
        <srv_heupstream@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Date:   Thu, 5 Dec 2019 12:50:48 +0800
In-Reply-To: <20191204094441.5116-6-bibby.hsieh@mediatek.com>
References: <20191204094441.5116-1-bibby.hsieh@mediatek.com>
         <20191204094441.5116-6-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBXZWQsIDIwMTktMTItMDQgYXQgMTc6NDQgKzA4MDAsIEJpYmJ5IEhz
aWVoIHdyb3RlOg0KPiBUaGUgQ01EUSAoQ29tbWFuZCBRdWV1ZSkgaW4gTVQ4MTgzIGlzIHVzZWQg
dG8gaGVscA0KPiB1cGRhdGUgYWxsIHJlbGV2YW50IGRpc3BsYXkgY29udHJvbGxlciByZWdpc3Rl
cnMNCj4gd2l0aCBjcml0aWNhbCB0aW1lIGxpbWF0aW9uLg0KPiBUaGlzIHBhdGNoIGFkZCBjbWRx
IGludGVyZmFjZSBpbiBkZHBfY29tcCBpbnRlcmZhY2UsDQo+IGxldCBhbGwgZGRwX2NvbXAgaW50
ZXJmYWNlIGNhbiBzdXBwb3J0IGNwdS9jbWRxIGZ1bmN0aW9uDQo+IGF0IHRoZSBzYW1lIHRpbWUu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZVCBTaGVuIDx5dC5zaGVuQG1lZGlhdGVrLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gU2lnbmVkLW9mZi1i
eTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2NvbG9yLmMgICB8ICAgNyArLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jICAgICB8ICA2NSArKysrKy0t
LS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jICAgIHwgIDQz
ICsrKystLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgICAg
fCAgIDggKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMg
fCAxMzYgKysrKysrKysrKysrKysrLS0tLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcF9jb21wLmggfCAgMzEgKysrLS0NCj4gIDYgZmlsZXMgY2hhbmdlZCwgMTk3IGlu
c2VydGlvbnMoKyksIDkzIGRlbGV0aW9ucygtKQ0KPiANCg0KW3NuaXBdDQoNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IGluZGV4IDM0MDdkMzhhZmY4
Zi4uZTkzZTQ2NzI2ZGU2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kZHBfY29tcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcF9jb21wLmMNCj4gQEAgLTEyLDcgKzEyLDggQEANCj4gICNpbmNsdWRlIDxsaW51eC9v
Zl9pcnEuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiAgI2luY2x1ZGUg
PGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAtDQo+ICsjaW5jbHVkZSA8ZHJtL2RybVAuaD4N
Cj4gKyNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaD4NCj4gICNpbmNsdWRl
ICJtdGtfZHJtX2Rydi5oIg0KPiAgI2luY2x1ZGUgIm10a19kcm1fcGxhbmUuaCINCj4gICNpbmNs
dWRlICJtdGtfZHJtX2RkcF9jb21wLmgiDQo+IEBAIC03NiwzNiArNzcsODIgQEANCj4gICNkZWZp
bmUgRElUSEVSX0FERF9MU0hJRlRfRyh4KQkJCSgoKHgpICYgMHg3KSA8PCA0KQ0KPiAgI2RlZmlu
ZSBESVRIRVJfQUREX1JTSElGVF9HKHgpCQkJKCgoeCkgJiAweDcpIDw8IDApDQo+ICANCj4gK3Zv
aWQgbXRrX2RkcF93cml0ZShzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0LCB1bnNpZ25lZCBpbnQg
dmFsdWUsDQo+ICsJCSAgIHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVkIGludCBv
ZmZzZXQpDQo+ICt7DQo+ICsJaWYgKGNtZHFfcGt0KQ0KPiArI2lmZGVmIENPTkZJR19NVEtfQ01E
UQ0KPiArCQljbWRxX3BrdF93cml0ZShjbWRxX3BrdCwgY29tcC0+c3Vic3lzLA0KPiArCQkJICAg
ICAgIGNvbXAtPnJlZ3NfcGEgKyBvZmZzZXQsIHZhbHVlKTsNCj4gKyNlbmRpZg0KPiArCWVsc2UN
Cj4gKwkJd3JpdGVsKHZhbHVlLCBjb21wLT5yZWdzICsgb2Zmc2V0KTsNCg0KSWYgQ09ORklHX01U
S19DTURRIGlzIG5vdCBkZWZpbmVkLCB0aGlzIGNvZGUgd291bGQgYmVjb21lDQoNCglpZiAoY21k
cV9wa3QpDQoNCgllbHNlDQoJCXdyaXRlbCh2YWx1ZSwgY29tcC0+cmVncyArIG9mZnNldCk7DQoN
Cj4gK30NCj4gKw0KPiArdm9pZCBtdGtfZGRwX3dyaXRlX3JlbGF4ZWQoc3RydWN0IGNtZHFfcGt0
ICpjbWRxX3BrdCwgdW5zaWduZWQgaW50IHZhbHVlLA0KPiArCQkJICAgc3RydWN0IG10a19kZHBf
Y29tcCAqY29tcCwNCj4gKwkJCSAgIHVuc2lnbmVkIGludCBvZmZzZXQpDQo+ICt7DQo+ICsJaWYg
KGNtZHFfcGt0KQ0KPiArI2lmZGVmIENPTkZJR19NVEtfQ01EUQ0KPiArCQljbWRxX3BrdF93cml0
ZShjbWRxX3BrdCwgY29tcC0+c3Vic3lzLA0KPiArCQkJICAgICAgIGNvbXAtPnJlZ3NfcGEgKyBv
ZmZzZXQsIHZhbHVlKTsNCj4gKyNlbmRpZg0KPiArCWVsc2UNCj4gKwkJd3JpdGVsX3JlbGF4ZWQo
dmFsdWUsIGNvbXAtPnJlZ3MgKyBvZmZzZXQpOw0KPiArfQ0KPiArDQo+ICt2b2lkIG10a19kZHBf
d3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0LA0KPiArCQkJdW5zaWduZWQgaW50
IHZhbHVlLA0KPiArCQkJc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwNCj4gKwkJCXVuc2lnbmVk
IGludCBvZmZzZXQsDQo+ICsJCQl1bnNpZ25lZCBpbnQgbWFzaykNCj4gK3sNCj4gKwlpZiAoY21k
cV9wa3QpIHsNCj4gKyNpZmRlZiBDT05GSUdfTVRLX0NNRFENCj4gKwkJY21kcV9wa3Rfd3JpdGVf
bWFzayhjbWRxX3BrdCwgY29tcC0+c3Vic3lzLA0KPiArCQkJCSAgICBjb21wLT5yZWdzX3BhICsg
b2Zmc2V0LCB2YWx1ZSwgbWFzayk7DQo+ICsjZW5kaWYNCj4gKwl9IGVsc2Ugew0KPiArCQl1MzIg
dG1wID0gcmVhZGwoY29tcC0+cmVncyArIG9mZnNldCk7DQo+ICsNCj4gKwkJdG1wID0gKHRtcCAm
IH5tYXNrKSB8ICh2YWx1ZSAmIG1hc2spOw0KPiArCQl3cml0ZWwodG1wLCBjb21wLT5yZWdzICsg
b2Zmc2V0KTsNCj4gKwl9DQo+ICt9DQo+ICsNCg0KW3NuaXBdDQoNCj4gIA0KPiAgc3RhdGljIHZv
aWQgbXRrX2dhbW1hX3N0YXJ0KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApDQo+IEBAIC0zMjQs
NiArMzcxLDkgQEAgaW50IG10a19kZHBfY29tcF9pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3Ry
dWN0IGRldmljZV9ub2RlICpub2RlLA0KPiAgCQkgICAgICBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9j
b21wX2Z1bmNzICpmdW5jcykNCj4gIHsNCj4gIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpjb21w
X3BkZXY7DQo+ICsJc3RydWN0IHJlc291cmNlIHJlczsNCj4gKwlzdHJ1Y3QgY21kcV9jbGllbnRf
cmVnICpjbWRxX3JlZzsNCg0KSSB0aGluayB5b3UgY291bGQgc2ltcGx5IGRlZmluZWQgYXMgYmVs
b3csIHNvIHlvdSBuZWVkIG5vdCB0byBhbGxvY2F0ZQ0KYW5kIGZyZWUuDQoNCnN0cnVjdCBjbWRx
X2NsaWVudF9yZWcgY21kcV9yZWc7DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJaW50IHJldCA9IDA7
DQo+ICANCj4gIAlpZiAoY29tcF9pZCA8IDAgfHwgY29tcF9pZCA+PSBERFBfQ09NUE9ORU5UX0lE
X01BWCkNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+IEBAIC0zNTgsNiArNDA4LDM0IEBAIGludCBt
dGtfZGRwX2NvbXBfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2Vfbm9kZSAq
bm9kZSwNCj4gIAl9DQo+ICAJY29tcC0+ZGV2ID0gJmNvbXBfcGRldi0+ZGV2Ow0KPiAgDQo+ICsj
aWZkZWYgQ09ORklHX01US19DTURRDQo+ICsJaWYgKG9mX2FkZHJlc3NfdG9fcmVzb3VyY2Uobm9k
ZSwgMCwgJnJlcykgIT0gMCkgew0KPiArCQlkZXZfZXJyKGRldiwgIk1pc3NpbmcgcmVnIGluICVz
IG5vZGVcbiIsDQo+ICsJCQlub2RlLT5mdWxsX25hbWUpOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gKwl9DQo+ICsJY29tcC0+cmVnc19wYSA9IHJlcy5zdGFydDsNCj4gKw0KPiArCWNvbXBfcGRl
diA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUobm9kZSk7DQo+ICsJaWYgKCFjb21wX3BkZXYpIHsN
Cj4gKwkJZGV2X3dhcm4oZGV2LCAiV2FpdGluZyBmb3IgY29tcG9uZW50IGRldmljZSAlc1xuIiwN
Cj4gKwkJCSBub2RlLT5mdWxsX25hbWUpOw0KPiArCQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsNCj4g
Kwl9DQo+ICsNCj4gKwljbWRxX3JlZyA9IGt6YWxsb2Moc2l6ZW9mKCpjbWRxX3JlZyksIEdGUF9L
RVJORUwpOw0KPiArCWlmICghY21kcV9yZWcpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+
ICsJcmV0ID0gY21kcV9kZXZfZ2V0X2NsaWVudF9yZWcoJmNvbXBfcGRldi0+ZGV2LCBjbWRxX3Jl
ZywgMCk7DQo+ICsJaWYgKHJldCAhPSAwKQ0KPiArCQlkZXZfZGJnKCZjb21wX3BkZXYtPmRldiwN
Cj4gKwkJCSJnZXQgbWVkaWF0ZWssZ2NlLWNsaWVudC1yZWcgZmFpbCFcbiIpOw0KPiArCWVsc2UN
Cj4gKwkJY29tcC0+c3Vic3lzID0gY21kcV9yZWctPnN1YnN5czsNCj4gKw0KPiArCWtmcmVlKGNt
ZHFfcmVnKTsNCj4gKyNlbmRpZg0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQoNCg0K

