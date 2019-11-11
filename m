Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2368C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5279204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfKKBoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 20:44:01 -0500
Received: from 60-251-196-230.HINET-IP.hinet.net ([60.251.196.230]:58292 "EHLO
        ironport.ite.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfKKBoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 20:44:01 -0500
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 11 Nov 2019 09:43:58 +0800
Received: from csbcas.internal.ite.com.tw (csbmail1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id xAB1hsUl095256;
        Mon, 11 Nov 2019 09:43:54 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from CSBMAIL1.internal.ite.com.tw (192.168.65.58) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 11 Nov 2019 09:43:52 +0800
Received: from CSBMAIL1.internal.ite.com.tw ([fe80::2cba:f37c:ac09:f33f]) by
 CSBMAIL1.internal.ite.com.tw ([fe80::2cba:f37c:ac09:f33f%22]) with mapi id
 15.01.1713.004; Mon, 11 Nov 2019 09:43:52 +0800
From:   <allen.chen@ite.com.tw>
To:     <ville.syrjala@linux.intel.com>
CC:     <Jau-Chih.Tseng@ite.com.tw>, <maxime.ripard@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <airlied@linux.ie>, <pihsun@chromium.org>, <sean@poorly.run>
Subject: RE: [PATCH] drm/edid: fixup EDID 1.3 and 1.4 judge reduced-blanking
 timings logic
Thread-Topic: [PATCH] drm/edid: fixup EDID 1.3 and 1.4 judge reduced-blanking
 timings logic
Thread-Index: AQHVlYH318RIQ5a4V0OrztvUfQdNe6eA1+2g
Date:   Mon, 11 Nov 2019 01:43:52 +0000
Message-ID: <d942db3a0b3242c6910c3ec3a524d04a@ite.com.tw>
References: <1572856969-12115-1-git-send-email-allen.chen@ite.com.tw>
 <20191107154209.GC1208@intel.com>
In-Reply-To: <20191107154209.GC1208@intel.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.70.14]
x-tm-snts-smtp: 99ECDDDB5A6AA97F90B09849EFB514D590E85C5AABC2DE8F2A51738D463C48932000:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: mse.ite.com.tw xAB1hsUl095256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlsbGUgU3lyasOkbMOkDQoNClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uIGFuZCBJIGhh
dmUgcmVwbGllZCB0d28gY29tbWVudHMgYmVsb3cuDQoNCkZyb206IFZpbGxlIFN5cmrDpGzDpCBb
bWFpbHRvOnZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tXSANClNlbnQ6IFRodXJzZGF5LCBO
b3ZlbWJlciAwNywgMjAxOSAxMTo0MiBQTQ0KVG86IEFsbGVuIENoZW4gKOmZs+afj+WuhykNCkNj
OiBKYXUtQ2hpaCBUc2VuZyAo5pu+5pit5pm6KTsgTWF4aW1lIFJpcGFyZDsgb3BlbiBsaXN0OyBv
cGVuIGxpc3Q6RFJNIERSSVZFUlM7IERhdmlkIEFpcmxpZTsgUGktSHN1biBTaGloOyBTZWFuIFBh
dWwNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9lZGlkOiBmaXh1cCBFRElEIDEuMyBhbmQgMS40
IGp1ZGdlIHJlZHVjZWQtYmxhbmtpbmcgdGltaW5ncyBsb2dpYw0KDQpPbiBNb24sIE5vdiAwNCwg
MjAxOSBhdCAwNDo0Mjo0OVBNICswODAwLCBhbGxlbiB3cm90ZToNCj4gQWNjb3JkaW5nIHRvIFZF
U0EgRU5IQU5DRUQgRVhURU5ERUQgRElTUExBWSBJREVOVElGSUNBVElPTiBEQVRBIFNUQU5EQVJE
DQo+IChEZWZpbmVzIEVESUQgU3RydWN0dXJlIFZlcnNpb24gMSwgUmV2aXNpb24gNCkgcGFnZTog
MzkNCj4gSG93IHRvIGRldGVybWluZSB3aGV0aGVyIHRoZSBtb25pdG9yIHN1cHBvcnQgUkIgdGlt
aW5nIG9yIG5vdD8NCj4gRURJRCAxLjQNCj4gRmlyc3Q6ICByZWFkIGRldGFpbGVkIHRpbWluZyBk
ZXNjcmlwdG9yIGFuZCBtYWtlIHN1cmUgYnl0ZTAgPSAwLA0KPiAJYnl0ZTEgPSAwLCBieXRlMiA9
IDAgYW5kIGJ5dGUzID0gMHhGRA0KDQpUaGF0IHNob3VsZCBwcm9iYWJseSBiZSBzb21lIG5ldyBm
dW5jdGlvbjoNCmJvb2wgaXNfZGlzcGxheV9kZXNjcmlwdG9yKGNvbnN0IHU4ICpkZXNjLCB1OCB0
YWcpOw0KaXNfZGlzcGxheV9kZXNjcmlwdG9yKEVESURfREVUQUlMX01PTklUT1JfUkFOR0UpDQpv
ciBzb21ldGhpbmcgYWxvbmcgdGhvc2UgbGluZXMNCg0KV2UgZG9uJ3Qgc2VlbSB0byBjaGVjayB0
aGF0IGluIG1vc3QgcGxhY2VzIHNvIHNob3VsZCBiZSByb2xsZWQgb3V0IGFsbA0Kb3Zlci4gVGhl
IHVzYWdlIG9mIHN0cnVjdCBkZXRhaWxlZF90aW1pbmcgYWxsIG92ZXIgYWxzbyBtYWtlcyBldmVy
eXRoaW5nDQpyYXRoZXIgY29uZnVzaW5nLg0KDQo+IFNlY29uZDogcmVhZCBkZXRhaWxlZCB0aW1p
bmcgZGVzY3JpcHRvciBieXRlMTAgPSAweDA0IGFuZA0KPiAJRURJRCBieXRlMThoIGJpdDAgPSAx
DQoNCkluZGljYXRlcyBDVlQgc3VwcG9ydC4gU2hvdWxkIGdpdmUgdGhlc2UgdGhpbmdzIHJlYWwg
bmFtZXMgc28NCm9uZSB3b3VsZG4ndCBoYXZlIHRvIGRlY29kZSBieSBoYW5kLg0KDQo+IFRoaXJk
OiAgaWYgRURJRCBieXRlMThoIGJpdDAgPT0gMSAmJiBieXRlMTAgPT0gMHgwNCwNCj4gCXRoZW4g
d2UgY2FuIGNoZWNrIGJ5dGUxNSwgaWYgYnl0ZTE1IGJpdDQgPTEgaXMgc3VwcG9ydCBSQg0KPiAg
ICAgICAgIGlmIEVESUQgYnl0ZTE4aCBiaXQwICE9IDEgfHwgYnl0ZTEwICE9IDB4MDQsDQo+IAl0
aGVuIGJ5dGUxNSBjYW4gbm90IGJlIHVzZWQNCj4gDQo+IFRoZSBsaW51eCBjb2RlIGlzX3JiIGZ1
bmN0aW9uIG5vdCBmb2xsb3cgdGhlIFZFU0EncyBydWxlDQo+IA0KPiBFRElEIDEuMw0KPiBMQ0Ti
gIJmbGF04oCCcGFuZWxzIGRv4oCCbm904oCCcmVxdWlyZeKAgmxvbmfigIJibGFua2luZ+KAgmlu
dGVydmFsc+KAgmFz4oCCYeKAgnJldHJhY2UNCj4gcGVyaW9kIHNvIGRlZmF1bHQgc3VwcG9ydCBy
ZWR1Y2VkLWJsYW5raW5nIHRpbWluZ3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGxlbiBDaGVu
IDxhbGxlbi5jaGVuQGl0ZS5jb20udHc+DQo+IFJlcG9ydGVkLWJ5OiBrYnVpbGQgdGVzdCByb2Jv
dCA8bGtwQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vZHJtX2VkaWQuYyB8
IDI4ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9kcm1fZWRpZC5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9lZGlkLmMNCj4gaW5kZXgg
ZTVlN2U2NS4uOWI2N2I4MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9lZGlk
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9lZGlkLmMNCj4gQEAgLTkzLDYgKzkzLDEx
IEBAIHN0cnVjdCBkZXRhaWxlZF9tb2RlX2Nsb3N1cmUgew0KPiAgCWludCBtb2RlczsNCj4gIH07
DQo+ICANCj4gK3N0cnVjdCBlZGlkX3N1cHBvcnRfcmJfY2xvc3VyZSB7DQo+ICsJc3RydWN0IGVk
aWQgKmVkaWQ7DQo+ICsJczggc3VwcG9ydF9yYjsNCg0KYm9vbA0KDQo9PT4gSVRFOiAgSWYgdXNl
IGJvb2wsIHdlIGNvdWxkIG5vdCByZXR1cm4gRURJRDEuMyB3aGVuIEVESUQxLjQgbG9naWMgY2Fu
IG5vdCBiZSBhcHBsaWVkDQo+ICt9Ow0KPiArDQo+ICAjZGVmaW5lIExFVkVMX0RNVAkwDQo+ICAj
ZGVmaW5lIExFVkVMX0dURgkxDQo+ICAjZGVmaW5lIExFVkVMX0dURjIJMg0KPiBAQCAtMjAxOCwy
MiArMjAyMywzMSBAQCBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqZHJtX21vZGVfZmluZF9kbXQo
c3RydWN0IGRybV9kZXZpY2UgKmRldiwNCj4gIGlzX3JiKHN0cnVjdCBkZXRhaWxlZF90aW1pbmcg
KnQsIHZvaWQgKmRhdGEpDQo+ICB7DQo+ICAJdTggKnIgPSAodTggKil0Ow0KPiAtCWlmIChyWzNd
ID09IEVESURfREVUQUlMX01PTklUT1JfUkFOR0UpDQo+IC0JCWlmIChyWzE1XSAmIDB4MTApDQo+
IC0JCQkqKGJvb2wgKilkYXRhID0gdHJ1ZTsNCj4gKwlzdHJ1Y3QgZWRpZF9zdXBwb3J0X3JiX2Ns
b3N1cmUgKmNsb3N1cmUgPSBkYXRhOw0KPiArCXN0cnVjdCBlZGlkICplZGlkID0gY2xvc3VyZS0+
ZWRpZDsNCj4gKw0KPiArCWlmICghclswXSAmJiAhclsxXSAmJiAhclsyXSAmJiByWzNdID09IEVE
SURfREVUQUlMX01PTklUT1JfUkFOR0UpIHsNCj4gKwkJaWYgKGVkaWQtPmZlYXR1cmVzICYgQklU
KDApICYmIHJbMTBdID09IEJJVCgyKSkNCj4gKwkJCWNsb3N1cmUtPnN1cHBvcnRfcmIgPSAoclsx
NV0gJiAweDEwKSA/IDEgOiAwOw0KDQpXaXRoIHRoZSBib29sIHRoZSB0ZXJuYXJ5IG9wZXJhdG9y
IGlzIG5vdCBuZWVkZWQuIEFsc28gc2hvdWxkIG1heWJlIA0KYmUgfD0gaW4gY2FzZSB3ZSBoYXZl
IG11bHRpcGxlIHJhbmdlIGRlc2NyaXB0b3JzPyBOb3Qgc3VyZSB0aGF0IGlzDQpsZWdhbC4NCg0K
PiArCX0NCj4gIH0NCj4gIA0KPiAgLyogRURJRCAxLjQgZGVmaW5lcyB0aGlzIGV4cGxpY2l0bHku
ICBGb3IgRURJRCAxLjMsIHdlIGd1ZXNzLCBiYWRseS4gKi8NCj4gIHN0YXRpYyBib29sDQo+ICBk
cm1fbW9uaXRvcl9zdXBwb3J0c19yYihzdHJ1Y3QgZWRpZCAqZWRpZCkNCj4gIHsNCj4gKwlzdHJ1
Y3QgZWRpZF9zdXBwb3J0X3JiX2Nsb3N1cmUgY2xvc3VyZSA9IHsNCj4gKwkJLmVkaWQgPSBlZGlk
LA0KPiArCQkuc3VwcG9ydF9yYiA9IC0xLA0KPiArCX07DQo+ICsNCj4gIAlpZiAoZWRpZC0+cmV2
aXNpb24gPj0gNCkgew0KPiAtCQlib29sIHJldCA9IGZhbHNlOw0KPiAtCQlkcm1fZm9yX2VhY2hf
ZGV0YWlsZWRfYmxvY2soKHU4ICopZWRpZCwgaXNfcmIsICZyZXQpOw0KPiAtCQlyZXR1cm4gcmV0
Ow0KPiArCQlkcm1fZm9yX2VhY2hfZGV0YWlsZWRfYmxvY2soKHU4ICopZWRpZCwgaXNfcmIsICZj
bG9zdXJlKTsNCj4gKwkJaWYgKGNsb3N1cmUuc3VwcG9ydF9yYiA+PSAwKQ0KPiArCQkJcmV0dXJu
IGNsb3N1cmUuc3VwcG9ydF9yYjsNCj4gIAl9DQo+ICANCj4gLQlyZXR1cm4gKChlZGlkLT5pbnB1
dCAmIERSTV9FRElEX0lOUFVUX0RJR0lUQUwpICE9IDApOw0KPiArCXJldHVybiB0cnVlOw0KDQpX
aHkgYXJlIHdlIG5vdyBhc3N1bWluZyByYiBmb3IgYWxsIHByZSAxLjQgRURJRHM/DQoNCj09PiBJ
VEU6IFRvZGF5LCBtb3N0IG9mIHRoZSBtb25pdG9yIGFyZSBMQ0QgYW5kIExDRCBtb25pdG9yIGRv
IG5vdCByZXF1aXJlIGxvbmcgYmxhbmtpbmcgaW50ZXJ2YWxzIGFzIGEgcmV0cmFjZSBwZXJpb2Qg
c28gZGVmYXVsdCBzdXBwb3J0IHJlZHVjZWQtYmxhbmtpbmcgdGltaW5ncy4NCg0KPiAgfQ0KPiAg
DQo+ICBzdGF0aWMgdm9pZA0KPiAtLSANCj4gMS45LjENCj4gDQo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QN
Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA0KDQotLSANClZpbGxlIFN5cmrD
pGzDpA0KSW50ZWwNCg==
