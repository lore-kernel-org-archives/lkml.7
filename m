Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE66C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B7520830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbfILMkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 08:40:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:59123 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731490AbfILMkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:40:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 05:40:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="197217283"
Received: from irsmsx105.ger.corp.intel.com ([163.33.3.28])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2019 05:40:13 -0700
Received: from irsmsx112.ger.corp.intel.com ([169.254.1.33]) by
 irsmsx105.ger.corp.intel.com ([169.254.7.164]) with mapi id 14.03.0439.000;
 Thu, 12 Sep 2019 13:40:12 +0100
From:   "Bradford, Robert" <robert.bradford@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "riel@surriel.com" <riel@surriel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jian-hong@endlessm.com" <jian-hong@endlessm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] x86/reboot: Avoid EFI reboot when not running on EFI
Thread-Topic: [PATCH] x86/reboot: Avoid EFI reboot when not running on EFI
Thread-Index: AQHVXlIk9mI2ksshWUO3RxmbfzmajacR+keAgAAmIgCAFeCegA==
Date:   Thu, 12 Sep 2019 12:40:11 +0000
Message-ID: <14e9cec8478d00d6aef413508d93b1066fb79b9c.camel@intel.com>
References: <20190829101119.7345-1-robert.bradford@intel.com>
         <alpine.DEB.2.21.1908291416560.1938@nanos.tec.linutronix.de>
         <caa320fa61d619a85d6237076f5ec8ed134d11b7.camel@intel.com>
In-Reply-To: <caa320fa61d619a85d6237076f5ec8ed134d11b7.camel@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.7.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFFA80AE3E6C6646829859DA65A7F897@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTI5IGF0IDE1OjM0ICswMTAwLCBCcmFkZm9yZCwgUm9iZXJ0IHdyb3Rl
Og0KPiBPbiBUaHUsIDIwMTktMDgtMjkgYXQgMTQ6MTggKzAyMDAsIFRob21hcyBHbGVpeG5lciB3
cm90ZToNCj4gPiBPbiBUaHUsIDI5IEF1ZyAyMDE5LCBSb2IgQnJhZGZvcmQgd3JvdGU6DQo+ID4g
DQo+ID4gQ0MrIEFyZA0KPiA+IA0KPiA+ID4gUmVwbGFjZSB0aGUgY2hlY2sgdXNpbmcgZWZpX3J1
bnRpbWVfZGlzYWJsZWQoKSB3aGljaCBvbmx5IGNoZWNrcw0KPiA+ID4gaWYNCj4gPiA+IEVGSQ0K
PiA+ID4gcnVudGltZSB3YXMgZGlzYWJsZWQgb24gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUgd2l0
aCBhIGNhbGwgdG8NCj4gPiA+IGVmaV9lbmFibGVkKEVGSV9SVU5USU1FX1NFUlZJQ0VTKSB0byBj
aGVjayBpZiBFRkkgcnVudGltZQ0KPiA+ID4gc2VydmljZXMNCj4gPiA+IGFyZQ0KPiA+ID4gYXZh
aWxhYmxlLg0KPiA+ID4gDQo+ID4gPiBJbiB0aGUgc2l0dWF0aW9uIHdoZXJlIHRoZSBrZXJuZWwg
d2FzIGJvb3RlZCB3aXRob3V0IGFuIEVGSQ0KPiA+ID4gZW52aXJvbm1lbnQNCj4gPiA+IHRoZW4g
b25seSBlZmlfZW5hYmxlZChFRklfUlVOVElNRV9TRVJWSUNFUykgY29ycmVjdGx5IHJlcHJlc2Vu
dHMNCj4gPiA+IHRoYXQgbm8NCj4gPiA+IEVGSSBpcyBhdmFpbGFibGUuIFNldHRpbmcgIm5vZWZp
IiBvciAiZWZpPW5vcnVudGltZSIgb24gdGhlDQo+ID4gPiBjb21tYW5kbGluZQ0KPiA+ID4gY29u
dGludWUgdG8gaGF2ZSB0aGUgc2FtZSBlZmZlY3QgYXMNCj4gPiA+IGVmaV9lbmFibGVkKEVGSV9S
VU5USU1FX1NFUlZJQ0VTKQ0KPiA+ID4gd2lsbCByZXR1cm4gZmFsc2UuDQo+ID4gPiANCj4gPiA+
IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUm9iIEJyYWRmb3JkIDxyb2JlcnQuYnJhZGZvcmRAaW50
ZWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgYXJjaC94ODYva2VybmVsL3JlYm9vdC5jIHwgMiAr
LQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3JlYm9vdC5jIGIvYXJj
aC94ODYva2VybmVsL3JlYm9vdC5jDQo+ID4gPiBpbmRleCAwOWQ2YmRlZDNjMWUuLjBiMGE3ZmNj
ZGIwMCAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9yZWJvb3QuYw0KPiA+ID4g
KysrIGIvYXJjaC94ODYva2VybmVsL3JlYm9vdC5jDQo+ID4gPiBAQCAtNTAwLDcgKzUwMCw3IEBA
IHN0YXRpYyBpbnQgX19pbml0IHJlYm9vdF9pbml0KHZvaWQpDQo+ID4gPiAgCSAqLw0KPiA+ID4g
IAlydiA9IGRtaV9jaGVja19zeXN0ZW0ocmVib290X2RtaV90YWJsZSk7DQo+ID4gPiAgDQo+ID4g
PiAtCWlmICghcnYgJiYgZWZpX3JlYm9vdF9yZXF1aXJlZCgpICYmICFlZmlfcnVudGltZV9kaXNh
YmxlZCgpKQ0KPiA+ID4gKwlpZiAoIXJ2ICYmIGVmaV9yZWJvb3RfcmVxdWlyZWQoKSAmJg0KPiA+
ID4gZWZpX2VuYWJsZWQoRUZJX1JVTlRJTUVfU0VSVklDRVMpKQ0KPiA+IA0KPiA+IFdoeSBpcyBl
ZmlfcmVib290X3JlcXVpcmVkKCkgc2V0IGF0IGFsbCBpbiB0aGF0IHNpdHVhdGlvbj8NCj4gPiAN
Cj4gSGkgVGhvbWFzLA0KPiANCj4gVGhpcyBwbGF0Zm9ybSB1c2VzIEhXIFJlZHVjZWQgQUNQSSAo
DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9jbG91ZC1oeXBlcnZpc29yKSBidXQgYWxzbyBz
dXBwb3J0cyBkaXJlY3QNCj4ga2VybmVsIGJvb3Qgd2l0aG91dCBFRkkuDQo+IA0KPiAvKg0KPiAg
KiBGb3IgbW9zdCBtb2Rlcm4gcGxhdGZvcm1zIHRoZSBwcmVmZXJyZWQgbWV0aG9kIG9mIHBvd2Vy
aW5nIG9mZiBpcw0KPiB2aWENCj4gICogQUNQSS4gSG93ZXZlciwgdGhlcmUgYXJlIHNvbWUgdGhh
dCBhcmUga25vd24gdG8gcmVxdWlyZSB0aGUgdXNlIG9mDQo+ICAqIEVGSSBydW50aW1lIHNlcnZp
Y2VzIGFuZCBmb3Igd2hpY2ggQUNQSSBkb2VzIG5vdCB3b3JrIGF0IGFsbC4NCj4gICoNCj4gICog
VXNpbmcgRUZJIGlzIGEgbGFzdCByZXNvcnQsIHRvIGJlIHVzZWQgb25seSBpZiBubyBvdGhlciBv
cHRpb24NCj4gICogZXhpc3RzLg0KPiAgKi8NCj4gYm9vbCBlZmlfcmVib290X3JlcXVpcmVkKHZv
aWQpDQo+IHsNCj4gCWlmICghYWNwaV9nYmxfcmVkdWNlZF9oYXJkd2FyZSkNCj4gCQlyZXR1cm4g
ZmFsc2U7DQo+IA0KPiAJZWZpX3JlYm9vdF9xdWlya19tb2RlID0gRUZJX1JFU0VUX1dBUk07DQo+
IAlyZXR1cm4gdHJ1ZTsNCj4gfQ0KPiANCj4gVGhpcyBpcyBhIGhhcmR3YXJlIHdvcmthcm91bmQg
dGhhdCBhc3N1bWVzIHRoYXQgYWxsIEFDUEkgSFcgcmVkdWNlZA0KPiBwbGF0Zm9ybXMgZG8gbm90
IHN1cHBvcnQgQUNQSSByZXNldDoNCj4gDQo+IGNvbW1pdCA0NGJlMjhlOWRkOTg4MGRjYTNlMmNi
ZjdhODQ0ZjIxMTRlNjdmMmNiDQo+IEF1dGhvcjogTWF0dCBGbGVtaW5nIDxtYXR0LmZsZW1pbmdA
aW50ZWwuY29tPg0KPiBEYXRlOiAgIEZyaSBKdW4gMTMgMTI6Mzk6NTUgMjAxNCArMDEwMA0KPiAN
Cj4gICAgIHg4Ni9yZWJvb3Q6IEFkZCBFRkkgcmVib290IHF1aXJrIGZvciBBQ1BJIEhhcmR3YXJl
IFJlZHVjZWQgZmxhZw0KPiAgICAgDQo+ICAgICBJdCBhcHBlYXJzIHRoYXQgdGhlIEJheVRyYWls
LVQgY2xhc3Mgb2YgaGFyZHdhcmUgcmVxdWlyZXMgRUZJIGluDQo+IG9yZGVyDQo+ICAgICB0byBw
b3dlcmRvd24gYW5kIHJlYm9vdCBhbmQgbm8gb3RoZXIgcmVsaWFibGUgbWV0aG9kIGV4aXN0cy4N
Cj4gICAgIA0KPiAgICAgVGhpcyBxdWlyayBpcyBnZW5lcmFsbHkgYXBwbGljYWJsZSB0byBhbGwg
aGFyZHdhcmUgdGhhdCBoYXMgdGhlDQo+IEFDUEkNCj4gICAgIEhhcmR3YXJlIFJlZHVjZWQgYml0
IHNldCwgc2luY2UgdXN1YWxseSBBQ1BJIHdvdWxkIGJlIHRoZQ0KPiBwcmVmZXJyZWQNCj4gICAg
IG1ldGhvZC4NCj4gICAgIA0KPiAgICAgQ2M6IExlbiBCcm93biA8bGVuLmJyb3duQGludGVsLmNv
bT4NCj4gICAgIENjOiBNYXJrIFNhbHRlciA8bXNhbHRlckByZWRoYXQuY29tPg0KPiAgICAgQ2M6
ICJSYWZhZWwgSi4gV3lzb2NraSIgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiAgICAg
U2lnbmVkLW9mZi1ieTogTWF0dCBGbGVtaW5nIDxtYXR0LmZsZW1pbmdAaW50ZWwuY29tPg0KPiAN
Cj4gSSdtIHJlbHVjdGFudCB0byBjaGFuZ2UgdGhlIGJlaGF2aW91ciBvZiBlZmlfcmVib290X3Jl
cXVpcmVkKCkgYXMgaXQNCj4gbWlnaHQgYnJlYWsgb2xkZXIgaGFyZHdhcmUgd2hlcmVhcyBjaGVj
a2luZyBpZiB3ZSBoYXZlIGFuIEVGSSBydW50aW1lDQo+IGlzIHNhZmVyLg0KPiANCg0KSGkgVGhv
bWFzLA0KDQpBbnkgdXBkYXRlIG9uIHlvdXIgdGhvdWdodHMgb24gdGhpcyBwYXRjaD8NCg0KUm9i
DQo=
