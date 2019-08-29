Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8205C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9725D2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfH2Oex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:34:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:27775 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbfH2Oew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:34:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 07:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="210560005"
Received: from irsmsx107.ger.corp.intel.com ([163.33.3.99])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2019 07:34:50 -0700
Received: from irsmsx112.ger.corp.intel.com ([169.254.1.71]) by
 IRSMSX107.ger.corp.intel.com ([169.254.10.55]) with mapi id 14.03.0439.000;
 Thu, 29 Aug 2019 15:34:49 +0100
From:   "Bradford, Robert" <robert.bradford@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "jgross@suse.com" <jgross@suse.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jian-hong@endlessm.com" <jian-hong@endlessm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] x86/reboot: Avoid EFI reboot when not running on EFI
Thread-Topic: [PATCH] x86/reboot: Avoid EFI reboot when not running on EFI
Thread-Index: AQHVXlIk9mI2ksshWUO3RxmbfzmajacR+keAgAAmIgA=
Date:   Thu, 29 Aug 2019 14:34:48 +0000
Message-ID: <caa320fa61d619a85d6237076f5ec8ed134d11b7.camel@intel.com>
References: <20190829101119.7345-1-robert.bradford@intel.com>
         <alpine.DEB.2.21.1908291416560.1938@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908291416560.1938@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.5.248]
Content-Type: text/plain; charset="utf-8"
Content-ID: <391867AEC980C542B9DB66A857D9EE37@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTI5IGF0IDE0OjE4ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFRodSwgMjkgQXVnIDIwMTksIFJvYiBCcmFkZm9yZCB3cm90ZToNCj4gDQo+IENDKyBB
cmQNCj4gDQo+ID4gUmVwbGFjZSB0aGUgY2hlY2sgdXNpbmcgZWZpX3J1bnRpbWVfZGlzYWJsZWQo
KSB3aGljaCBvbmx5IGNoZWNrcyBpZg0KPiA+IEVGSQ0KPiA+IHJ1bnRpbWUgd2FzIGRpc2FibGVk
IG9uIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lIHdpdGggYSBjYWxsIHRvDQo+ID4gZWZpX2VuYWJs
ZWQoRUZJX1JVTlRJTUVfU0VSVklDRVMpIHRvIGNoZWNrIGlmIEVGSSBydW50aW1lIHNlcnZpY2Vz
DQo+ID4gYXJlDQo+ID4gYXZhaWxhYmxlLg0KPiA+IA0KPiA+IEluIHRoZSBzaXR1YXRpb24gd2hl
cmUgdGhlIGtlcm5lbCB3YXMgYm9vdGVkIHdpdGhvdXQgYW4gRUZJDQo+ID4gZW52aXJvbm1lbnQN
Cj4gPiB0aGVuIG9ubHkgZWZpX2VuYWJsZWQoRUZJX1JVTlRJTUVfU0VSVklDRVMpIGNvcnJlY3Rs
eSByZXByZXNlbnRzDQo+ID4gdGhhdCBubw0KPiA+IEVGSSBpcyBhdmFpbGFibGUuIFNldHRpbmcg
Im5vZWZpIiBvciAiZWZpPW5vcnVudGltZSIgb24gdGhlDQo+ID4gY29tbWFuZGxpbmUNCj4gPiBj
b250aW51ZSB0byBoYXZlIHRoZSBzYW1lIGVmZmVjdCBhcw0KPiA+IGVmaV9lbmFibGVkKEVGSV9S
VU5USU1FX1NFUlZJQ0VTKQ0KPiA+IHdpbGwgcmV0dXJuIGZhbHNlLg0KPiA+IA0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IFJvYiBCcmFkZm9yZCA8cm9iZXJ0LmJyYWRmb3JkQGludGVsLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgYXJjaC94ODYva2VybmVsL3JlYm9vdC5jIHwgMiArLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3JlYm9vdC5jIGIvYXJjaC94ODYva2VybmVsL3JlYm9v
dC5jDQo+ID4gaW5kZXggMDlkNmJkZWQzYzFlLi4wYjBhN2ZjY2RiMDAgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC94ODYva2VybmVsL3JlYm9vdC5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL3Jl
Ym9vdC5jDQo+ID4gQEAgLTUwMCw3ICs1MDAsNyBAQCBzdGF0aWMgaW50IF9faW5pdCByZWJvb3Rf
aW5pdCh2b2lkKQ0KPiA+ICAJICovDQo+ID4gIAlydiA9IGRtaV9jaGVja19zeXN0ZW0ocmVib290
X2RtaV90YWJsZSk7DQo+ID4gIA0KPiA+IC0JaWYgKCFydiAmJiBlZmlfcmVib290X3JlcXVpcmVk
KCkgJiYgIWVmaV9ydW50aW1lX2Rpc2FibGVkKCkpDQo+ID4gKwlpZiAoIXJ2ICYmIGVmaV9yZWJv
b3RfcmVxdWlyZWQoKSAmJg0KPiA+IGVmaV9lbmFibGVkKEVGSV9SVU5USU1FX1NFUlZJQ0VTKSkN
Cj4gDQo+IFdoeSBpcyBlZmlfcmVib290X3JlcXVpcmVkKCkgc2V0IGF0IGFsbCBpbiB0aGF0IHNp
dHVhdGlvbj8NCj4gDQpIaSBUaG9tYXMsDQoNClRoaXMgcGxhdGZvcm0gdXNlcyBIVyBSZWR1Y2Vk
IEFDUEkgKA0KaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2Nsb3VkLWh5cGVydmlzb3IpIGJ1dCBh
bHNvIHN1cHBvcnRzIGRpcmVjdA0Ka2VybmVsIGJvb3Qgd2l0aG91dCBFRkkuDQoNCi8qDQogKiBG
b3IgbW9zdCBtb2Rlcm4gcGxhdGZvcm1zIHRoZSBwcmVmZXJyZWQgbWV0aG9kIG9mIHBvd2VyaW5n
IG9mZiBpcw0KdmlhDQogKiBBQ1BJLiBIb3dldmVyLCB0aGVyZSBhcmUgc29tZSB0aGF0IGFyZSBr
bm93biB0byByZXF1aXJlIHRoZSB1c2Ugb2YNCiAqIEVGSSBydW50aW1lIHNlcnZpY2VzIGFuZCBm
b3Igd2hpY2ggQUNQSSBkb2VzIG5vdCB3b3JrIGF0IGFsbC4NCiAqDQogKiBVc2luZyBFRkkgaXMg
YSBsYXN0IHJlc29ydCwgdG8gYmUgdXNlZCBvbmx5IGlmIG5vIG90aGVyIG9wdGlvbg0KICogZXhp
c3RzLg0KICovDQpib29sIGVmaV9yZWJvb3RfcmVxdWlyZWQodm9pZCkNCnsNCglpZiAoIWFjcGlf
Z2JsX3JlZHVjZWRfaGFyZHdhcmUpDQoJCXJldHVybiBmYWxzZTsNCg0KCWVmaV9yZWJvb3RfcXVp
cmtfbW9kZSA9IEVGSV9SRVNFVF9XQVJNOw0KCXJldHVybiB0cnVlOw0KfQ0KDQpUaGlzIGlzIGEg
aGFyZHdhcmUgd29ya2Fyb3VuZCB0aGF0IGFzc3VtZXMgdGhhdCBhbGwgQUNQSSBIVyByZWR1Y2Vk
DQpwbGF0Zm9ybXMgZG8gbm90IHN1cHBvcnQgQUNQSSByZXNldDoNCg0KY29tbWl0IDQ0YmUyOGU5
ZGQ5ODgwZGNhM2UyY2JmN2E4NDRmMjExNGU2N2YyY2INCkF1dGhvcjogTWF0dCBGbGVtaW5nIDxt
YXR0LmZsZW1pbmdAaW50ZWwuY29tPg0KRGF0ZTogICBGcmkgSnVuIDEzIDEyOjM5OjU1IDIwMTQg
KzAxMDANCg0KICAgIHg4Ni9yZWJvb3Q6IEFkZCBFRkkgcmVib290IHF1aXJrIGZvciBBQ1BJIEhh
cmR3YXJlIFJlZHVjZWQgZmxhZw0KICAgIA0KICAgIEl0IGFwcGVhcnMgdGhhdCB0aGUgQmF5VHJh
aWwtVCBjbGFzcyBvZiBoYXJkd2FyZSByZXF1aXJlcyBFRkkgaW4NCm9yZGVyDQogICAgdG8gcG93
ZXJkb3duIGFuZCByZWJvb3QgYW5kIG5vIG90aGVyIHJlbGlhYmxlIG1ldGhvZCBleGlzdHMuDQog
ICAgDQogICAgVGhpcyBxdWlyayBpcyBnZW5lcmFsbHkgYXBwbGljYWJsZSB0byBhbGwgaGFyZHdh
cmUgdGhhdCBoYXMgdGhlDQpBQ1BJDQogICAgSGFyZHdhcmUgUmVkdWNlZCBiaXQgc2V0LCBzaW5j
ZSB1c3VhbGx5IEFDUEkgd291bGQgYmUgdGhlIHByZWZlcnJlZA0KICAgIG1ldGhvZC4NCiAgICAN
CiAgICBDYzogTGVuIEJyb3duIDxsZW4uYnJvd25AaW50ZWwuY29tPg0KICAgIENjOiBNYXJrIFNh
bHRlciA8bXNhbHRlckByZWRoYXQuY29tPg0KICAgIENjOiAiUmFmYWVsIEouIFd5c29ja2kiIDxy
YWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCiAgICBTaWduZWQtb2ZmLWJ5OiBNYXR0IEZsZW1p
bmcgPG1hdHQuZmxlbWluZ0BpbnRlbC5jb20+DQoNCkknbSByZWx1Y3RhbnQgdG8gY2hhbmdlIHRo
ZSBiZWhhdmlvdXIgb2YgZWZpX3JlYm9vdF9yZXF1aXJlZCgpIGFzIGl0DQptaWdodCBicmVhayBv
bGRlciBoYXJkd2FyZSB3aGVyZWFzIGNoZWNraW5nIGlmIHdlIGhhdmUgYW4gRUZJIHJ1bnRpbWUN
CmlzIHNhZmVyLg0KDQpSb2INCg==
