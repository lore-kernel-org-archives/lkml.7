Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3B9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035A921841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfCVWtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:49:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:27013 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbfCVWtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:49:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 15:49:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="285114414"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga004.jf.intel.com with ESMTP; 22 Mar 2019 15:49:31 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.56]) by
 fmsmsx104.amr.corp.intel.com ([169.254.3.38]) with mapi id 14.03.0415.000;
 Fri, 22 Mar 2019 15:49:30 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "kjlu@umn.edu" <kjlu@umn.edu>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "pakki001@umn.edu" <pakki001@umn.edu>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>
Subject: Re: [PATCH] nvdimm: btt_devs: fix a NULL pointer dereference and a
 memory leak
Thread-Topic: [PATCH] nvdimm: btt_devs: fix a NULL pointer dereference and a
 memory leak
Thread-Index: AQHU2KvP9fAOZmRsOECRxfaC1K1yNKYYxwKA
Date:   Fri, 22 Mar 2019 22:49:29 +0000
Message-ID: <eea1b50fe8c76d45fef0aaca1878c30fa8f2cbde.camel@intel.com>
References: <20190312081529.4889-1-kjlu@umn.edu>
In-Reply-To: <20190312081529.4889-1-kjlu@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6878E8040DC78448B070CFD65C378F3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAzLTEyIGF0IDAzOjE1IC0wNTAwLCBLYW5namllIEx1IHdyb3RlOg0KPiBJ
biBjYXNlIGttZW1kdXAgZmFpbHMsIHRoZSBmaXggcmVsZWFzZXMgcmVzb3VyY2VzIGFuZCByZXR1
cm5zIHRvDQo+IGF2b2lkIHRoZSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UuDQo+IEFsc28sIHRo
ZSBlcnJvciBwYXRocyBpbiB0aGUgZm9sbG93aW5nIGNvZGUgc2hvdWxkIHJlbGVhc2UNCj4gcmVz
b3VyY2VzIHRvIGF2b2lkIG1lbW9yeSBsZWFrcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEthbmdq
aWUgTHUgPGtqbHVAdW1uLmVkdT4NCj4gLS0tDQo+ICBkcml2ZXJzL252ZGltbS9idHRfZGV2cy5j
IHwgOCArKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCg0KTG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZp
c2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udmRpbW0v
YnR0X2RldnMuYyBiL2RyaXZlcnMvbnZkaW1tL2J0dF9kZXZzLmMNCj4gaW5kZXggNzk1YWQ0ZmYz
NWNhLi41NjVlYTBiNmY3NjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZkaW1tL2J0dF9kZXZz
LmMNCj4gKysrIGIvZHJpdmVycy9udmRpbW0vYnR0X2RldnMuYw0KPiBAQCAtMTk2LDggKzE5Niwx
MyBAQCBzdGF0aWMgc3RydWN0IGRldmljZSAqX19uZF9idHRfY3JlYXRlKHN0cnVjdA0KPiBuZF9y
ZWdpb24gKm5kX3JlZ2lvbiwNCj4gIAl9DQo+ICANCj4gIAluZF9idHQtPmxiYXNpemUgPSBsYmFz
aXplOw0KPiAtCWlmICh1dWlkKQ0KPiArCWlmICh1dWlkKSB7DQo+ICAJCXV1aWQgPSBrbWVtZHVw
KHV1aWQsIDE2LCBHRlBfS0VSTkVMKTsNCj4gKwkJaWYgKCF1dWlkKSB7DQo+ICsJCQlrZnJlZShu
ZF9idHQpOw0KPiArCQkJcmV0dXJuIE5VTEw7DQo+ICsJCX0NCj4gKwl9DQo+ICAJbmRfYnR0LT51
dWlkID0gdXVpZDsNCj4gIAlkZXYgPSAmbmRfYnR0LT5kZXY7DQo+ICAJZGV2X3NldF9uYW1lKGRl
diwgImJ0dCVkLiVkIiwgbmRfcmVnaW9uLT5pZCwgbmRfYnR0LT5pZCk7DQo+IEBAIC0yMDksNiAr
MjE0LDcgQEAgc3RhdGljIHN0cnVjdCBkZXZpY2UgKl9fbmRfYnR0X2NyZWF0ZShzdHJ1Y3QNCj4g
bmRfcmVnaW9uICpuZF9yZWdpb24sDQo+ICAJCWRldl9kYmcoJm5kbnMtPmRldiwgImZhaWxlZCwg
YWxyZWFkeSBjbGFpbWVkIGJ5ICVzXG4iLA0KPiAgCQkJCWRldl9uYW1lKG5kbnMtPmNsYWltKSk7
DQo+ICAJCXB1dF9kZXZpY2UoZGV2KTsNCj4gKwkJa2ZyZWUodXVpZCk7DQo+ICAJCXJldHVybiBO
VUxMOw0KPiAgCX0NCj4gIAlyZXR1cm4gZGV2Ow0KDQo=
