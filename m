Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32D1C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 07:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A263720748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 07:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WXlMwGyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfKYHhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 02:37:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:3203 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725535AbfKYHhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 02:37:00 -0500
X-UUID: 897dbc15791b48948d58486a7b8ce34d-20191125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WUCRj6E2ADm4aPzrrZwA51bkluBOS7j5l65gPHqcbPc=;
        b=WXlMwGyEZmhVYq9KbvXMzU7gnWhKHy89exxnAf4kaG6HfjfnK2We+gz80+mROMbf9ARzIfBks79pANFvWLhvXe3EkEnlbCbbONLP9LoYg9HOrgoh8cSvXlSOlAKRTlaTvbxXMisf4oNpOqpc9nX5dVWbTqCY0QVscEBlkXc+0lA=;
X-UUID: 897dbc15791b48948d58486a7b8ce34d-20191125
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1842448119; Mon, 25 Nov 2019 15:36:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 25 Nov 2019 15:36:48 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Nov 2019 15:36:14 +0800
Message-ID: <1574667416.9851.1.camel@mtkswgap22>
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
Date:   Mon, 25 Nov 2019 15:36:56 +0800
In-Reply-To: <1574645703.4712.7.camel@mtksdaap41>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574327552-11806-11-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574415960.19450.23.camel@mtksdaap41>
         <1574418540.11977.19.camel@mtkswgap22> <1574645703.4712.7.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIE1vbiwgMjAxOS0xMS0yNSBhdCAwOTozNSArMDgwMCwgQ0sgSHUgd3JvdGU6
DQo+IEhpLCBEZW5uaXM6DQo+IA0KPiBPbiBGcmksIDIwMTktMTEtMjIgYXQgMTg6MjkgKzA4MDAs
IERlbm5pcy1ZQyBIc2llaCB3cm90ZToNCj4gPiBIaSBDSywNCj4gPiANCj4gPiBPbiBGcmksIDIw
MTktMTEtMjIgYXQgMTc6NDYgKzA4MDAsIENLIEh1IHdyb3RlOg0KPiA+ID4gSGksIERlbm5pczoN
Cj4gPiA+IA0KPiA+ID4gT24gVGh1LCAyMDE5LTExLTIxIGF0IDE3OjEyICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+ID4gPiA+IEFkZCBmaW5hbGl6ZSBsb29wIGZ1bmN0aW9uIGluIGNt
ZHEgaGVscGVyIGZ1bmN0aW9ucyB3aGljaCBsb29wIHdob2xlIHBrdA0KPiA+ID4gPiBpbiBnY2Ug
aGFyZHdhcmUgdGhyZWFkIHdpdGhvdXQgY3B1IG9wZXJhdGlvbi4NCj4gPiA+ID4gDQo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVr
LmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYyB8ICAgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+
ID4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgICAgOCArKysrKysr
DQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKykNCj4gPiA+ID4gDQo+
ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
YyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gPiA+IGluZGV4
IDQyMzVjZjguLjNiMTAyNDEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jDQo+ID4gPiA+IEBAIC0zODUsMTIgKzM4NSwyNyBAQCBpbnQgY21k
cV9wa3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVl
KQ0KPiA+ID4gPiAgfQ0KPiA+ID4gPiAgRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9hc3NpZ24pOw0K
PiA+ID4gPiAgDQo+ID4gPiA+ICtzdGF0aWMgYm9vbCBjbWRxX3BrdF9maW5hbGl6ZWQoc3RydWN0
IGNtZHFfcGt0ICpwa3QpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsJc3RydWN0IGNtZHFfaW5zdHJ1
Y3Rpb24gKmluc3Q7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlpZiAocGt0LT5jbWRfYnVmX3NpemUg
PCAyICogQ01EUV9JTlNUX1NJWkUpDQo+ID4gPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArCWluc3QgPSBwa3QtPnZhX2Jhc2UgKyBwa3QtPmNtZF9idWZfc2l6ZSAtIDIg
KiBDTURRX0lOU1RfU0laRTsNCj4gPiA+ID4gKwlyZXR1cm4gaW5zdC0+b3AgPT0gQ01EUV9DT0RF
X0VPQzsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiAgc3RhdGljIGludCBjbWRxX3Br
dF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCkNCj4gPiA+ID4gIHsNCj4gPiA+ID4gIAlz
dHJ1Y3QgY21kcV9jbGllbnQgKmNsID0gcGt0LT5jbDsNCj4gPiA+ID4gIAlzdHJ1Y3QgY21kcV9p
bnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiA+ID4gIAlpbnQgZXJyOw0KPiA+ID4gPiAg
DQo+ID4gPiA+ICsJLyogZG8gbm90IGZpbmFsaXplIHR3aWNlICovDQo+ID4gPiA+ICsJaWYgKGNt
ZHFfcGt0X2ZpbmFsaXplZChwa3QpKQ0KPiA+ID4gPiArCQlyZXR1cm4gMDsNCj4gPiA+ID4gKw0K
PiA+ID4gPiAgCS8qIGluc2VydCBFT0MgYW5kIGdlbmVyYXRlIElSUSBmb3IgZWFjaCBjb21tYW5k
IGl0ZXJhdGlvbiAqLw0KPiA+ID4gPiAgCWluc3Qub3AgPSBDTURRX0NPREVfRU9DOw0KPiA+ID4g
PiAgCWluc3QudmFsdWUgPSBDTURRX0VPQ19JUlFfRU47DQo+ID4gPiA+IEBAIC00MDYsNiArNDIx
LDMyIEBAIHN0YXRpYyBpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3Qp
DQo+ID4gPiA+ICAJcmV0dXJuIGVycjsNCj4gPiA+ID4gIH0NCj4gPiA+ID4gIA0KPiA+ID4gPiAr
aW50IGNtZHFfcGt0X2ZpbmFsaXplX2xvb3Aoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQo+ID4gPiA+
ICt7DQo+ID4gPiA+ICsJc3RydWN0IGNtZHFfY2xpZW50ICpjbCA9IHBrdC0+Y2w7DQo+ID4gPiA+
ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ID4gPiA+ICsJaW50
IGVycjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCS8qIGRvIG5vdCBmaW5hbGl6ZSB0d2ljZSAqLw0K
PiA+ID4gPiArCWlmIChjbWRxX3BrdF9maW5hbGl6ZWQocGt0KSkNCj4gPiA+ID4gKwkJcmV0dXJu
IDA7DQo+ID4gPiANCj4gPiA+IFdoeSBub3QganVzdCBleHBvcnQgY21kcV9wa3RfZmluYWxpemUo
KSBmb3IgdXNlciBhbmQgZG8gbm90IGNhbGwNCj4gPiA+IGNtZHFfcGt0X2ZpbmFsaXplKCkgaW4g
Y21kcV9wa3RfZmx1c2hfYXN5bmMoKSwgc28geW91IGRvbid0IG5lZWQgdG8NCj4gPiA+IGNoZWNr
IHRoaXMuDQo+ID4gPiANCj4gPiA+IEkgd291bGQgYmUgbW9yZSBsaWtlIHRvIGV4cG9ydCBBUEkg
c3VjaCBhcyBjbWRxX3BrdF9lb2MoKSwNCj4gPiA+IGNtZHFfcGt0X2p1bXAoKSwgdGhpcyB3b3Vs
ZCBwcm92aWRlIG1vcmUgZmxleGliaWxpdHkgZm9yIHVzZXIgdG8NCj4gPiA+IGFzc2VtYmxlIHRo
ZSBjb21tYW5kIGl0IHdhbnQuDQo+ID4gPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBDSw0KPiA+
IA0KPiA+IFRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KPiA+IA0KPiA+IFNob3VsZCB3ZSBiYWNr
d2FyZCBjb21wYXRpYmxlIHdpdGggZXhpc3RpbmcgY2xpZW50cz8gUmVtb3ZlIGZpbmFsaXplIGlu
DQo+ID4gZmx1c2ggd2lsbCBjYXVzZSBleGlzdGluZyBjbGllbnQgZmx1c2ggd2l0aG91dCBJUlEu
DQo+IA0KPiBUaGUgbGF0ZXN0IGtlcm5lbCAodjUuNC1yYzgpIHN0aWxsIGhhcyBubyBjbGllbnRz
IHdoaWNoIHVzZSBjbWRxIGxhbmRlZA0KPiBvbiB1cHN0cmVhbSwgYW5kIHdlIGRvbid0IG5lZWQg
dG8gY29uc2lkZXIgYmFja3dhcmQgY29tcGF0aWJsZS4gWzFdIGlzDQo+IHRoZSBleGFtcGxlIHRo
YXQgaW9tbXUgd291bGQgcmVwbGFjZSB0aGUgcHJvcHJpZXRhcnkgaW50ZXJmYWNlIHdpdGgNCj4g
c3RhbmRhcmQgaW50ZXJmYWNlLCBzbyBpdCB3b3VsZCBtb2RpZnkgYWxsIGNsaWVudHMgd2hpY2gg
dXNlIHRoZQ0KPiBwcm9wcmlldGFyeSBpbnRlcmZhY2UuIFNvIHdoYXQgeW91IHNob3VsZCBkbyBp
cyB0byBtb2RpZnkgY2xpZW50IGFzDQo+IHdlbGwuDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0xNjg4
MDENCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQoNCg0KT2ssIEknbGwgcmVtb3ZlIGFsbCBjaGVjayBj
b2RlLg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuDQoNCg0KUmVnYXJkcywNCkRlbm5pcw0KDQo+
ID4gDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBEZW5uaXMNCj4gPiANCj4gPiA+IA0KPiA+ID4g
PiArDQo+ID4gPiA+ICsJLyogaW5zZXJ0IEVPQyBhbmQgZ2VuZXJhdGUgSVJRIGZvciBlYWNoIGNv
bW1hbmQgaXRlcmF0aW9uICovDQo+ID4gPiA+ICsJaW5zdC5vcCA9IENNRFFfQ09ERV9FT0M7DQo+
ID4gPiA+ICsJZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiA+
ID4gKwlpZiAoZXJyIDwgMCkNCj4gPiA+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiA+ID4gKw0KPiA+
ID4gPiArCS8qIEpVTVAgYWJhb2x1dGUgdG8gYmVnaW4gKi8NCj4gPiA+ID4gKwlpbnN0Lm9wID0g
Q01EUV9DT0RFX0pVTVA7DQo+ID4gPiA+ICsJaW5zdC5vZmZzZXQgPSAxOw0KPiA+ID4gPiArCWlu
c3QudmFsdWUgPSBwa3QtPnBhX2Jhc2UgPj4gY21kcV9tYm94X3NoaWZ0KGNsLT5jaGFuKTsNCj4g
PiA+ID4gKwllcnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiA+ID4g
PiArDQo+ID4gPiA+ICsJcmV0dXJuIGVycjsNCj4gPiA+ID4gK30NCj4gPiA+ID4gK0VYUE9SVF9T
WU1CT0woY21kcV9wa3RfZmluYWxpemVfbG9vcCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gIHN0YXRp
YyB2b2lkIGNtZHFfcGt0X2ZsdXNoX2FzeW5jX2NiKHN0cnVjdCBjbWRxX2NiX2RhdGEgZGF0YSkN
Cj4gPiA+ID4gIHsNCj4gPiA+ID4gIAlzdHJ1Y3QgY21kcV9wa3QgKnBrdCA9IChzdHJ1Y3QgY21k
cV9wa3QgKilkYXRhLmRhdGE7DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEuaA0KPiA+ID4gPiBpbmRleCBiMzQ3NGYyLi43N2U4OTQ0IDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gPiA+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiA+ID4gQEAgLTIwMyw2ICsy
MDMsMTQgQEAgaW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTgg
c3Vic3lzLA0KPiA+ID4gPiAgaW50IGNtZHFfcGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBr
dCwgdTE2IHJlZ19pZHgsIHUzMiB2YWx1ZSk7DQo+ID4gPiA+ICANCj4gPiA+ID4gIC8qKg0KPiA+
ID4gPiArICogY21kcV9wa3RfZmluYWxpemVfbG9vcCgpIC0gQXBwZW5kIEVPQyBhbmQganVtcCBj
b21tYW5kIHRvIGxvb3AgcGt0Lg0KPiA+ID4gPiArICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+
ID4gPiA+ICsgKg0KPiA+ID4gPiArICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBl
cnJvciBjb2RlIGlzIHJldHVybmVkDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK2ludCBjbWRxX3Br
dF9maW5hbGl6ZV9sb29wKHN0cnVjdCBjbWRxX3BrdCAqcGt0KTsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArLyoqDQo+ID4gPiA+ICAgKiBjbWRxX3BrdF9mbHVzaF9hc3luYygpIC0gdHJpZ2dlciBDTURR
IHRvIGFzeW5jaHJvbm91c2x5IGV4ZWN1dGUgdGhlIENNRFENCj4gPiA+ID4gICAqICAgICAgICAg
ICAgICAgICAgICAgICAgICBwYWNrZXQgYW5kIGNhbGwgYmFjayBhdCB0aGUgZW5kIG9mIGRvbmUg
cGFja2V0DQo+ID4gPiA+ICAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCj4gPiA+IA0KPiA+ID4g
DQo+ID4gDQo+ID4gDQo+IA0KPiANCg0K

