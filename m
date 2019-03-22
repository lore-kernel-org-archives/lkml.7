Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FF921925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfCVW4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:56:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:38775 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfCVW4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:56:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 15:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="309625013"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2019 15:56:41 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 22 Mar 2019 15:56:40 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.56]) by
 FMSMSX119.amr.corp.intel.com ([169.254.14.119]) with mapi id 14.03.0415.000;
 Fri, 22 Mar 2019 15:56:40 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "kjlu@umn.edu" <kjlu@umn.edu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "pakki001@umn.edu" <pakki001@umn.edu>,
        "zwisler@kernel.org" <zwisler@kernel.org>
Subject: Re: [PATCH] nvdimm: btt_devs: fix a NULL pointer dereference and a
 memory leak
Thread-Topic: [PATCH] nvdimm: btt_devs: fix a NULL pointer dereference and a
 memory leak
Thread-Index: AQHU2KvP9fAOZmRsOECRxfaC1K1yNKYYxwKAgAACAgA=
Date:   Fri, 22 Mar 2019 22:56:40 +0000
Message-ID: <4377c210798b000d60ebdc5150e015737d05565b.camel@intel.com>
References: <20190312081529.4889-1-kjlu@umn.edu>
         <eea1b50fe8c76d45fef0aaca1878c30fa8f2cbde.camel@intel.com>
In-Reply-To: <eea1b50fe8c76d45fef0aaca1878c30fa8f2cbde.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DA9F31267ADB746A1202655693A23A7@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMTktMDMtMjIgYXQgMjI6NDkgKzAwMDAsIFZlcm1hLCBWaXNoYWwgTCB3cm90
ZToNCj4gT24gVHVlLCAyMDE5LTAzLTEyIGF0IDAzOjE1IC0wNTAwLCBLYW5namllIEx1IHdyb3Rl
Og0KPiA+IEluIGNhc2Uga21lbWR1cCBmYWlscywgdGhlIGZpeCByZWxlYXNlcyByZXNvdXJjZXMg
YW5kIHJldHVybnMgdG8NCj4gPiBhdm9pZCB0aGUgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLg0K
PiA+IEFsc28sIHRoZSBlcnJvciBwYXRocyBpbiB0aGUgZm9sbG93aW5nIGNvZGUgc2hvdWxkIHJl
bGVhc2UNCj4gPiByZXNvdXJjZXMgdG8gYXZvaWQgbWVtb3J5IGxlYWtzLg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IEthbmdqaWUgTHUgPGtqbHVAdW1uLmVkdT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9udmRpbW0vYnR0X2RldnMuYyB8IDggKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiANCj4gTG9va3MgZ29vZCwN
Cj4gUmV2aWV3ZWQtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0K
DQpMb29raW5nIGFnYWluLCB0aGVyZSBpcyBhbm90aGVyIGttZW1kdXAoKSBjYWxsIGluIF9fbmRf
YnR0X3Byb2JlIHdoaWNoDQppcyBsYWNraW5nIGVycm9yIGNoZWNraW5nLg0KQW5kIHJlZmVycmlu
ZyB0byB5b3VyIG90aGVyIHJlbGF0ZWQgcGF0Y2ggdG8gbmFtZXNwYWNlX2RldnMsIHRoYXQgaGFz
DQovc2V2ZXJhbC8gaW5zdGFuY2VzIG9mIHRoZSBzYW1lIHRoaW5nLg0KDQpJbnN0ZWFkIG9mIGZp
eGluZyBqdXN0IGEgY291cGxlIG9mIHRoZXNlLCBpdCBtaWdodCBiZSB3b3J0aHdoaWxlIHRvIHNl
bmQNCmEgd2lkZXIgY2xlYW51cCBwYXRjaCB0byBjYXRjaCBhbGwgb2YgdGhlc2UsIGF0IGxlYXN0
IHdpdGhpbg0KZHJpdmVycy9udmRpbW0vIGZvciBzdGFydGVycywgaW5zdGVhZCBvZiBhIHNlbGVj
dCBmZXcuDQoNCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL2J0dF9kZXZzLmMg
Yi9kcml2ZXJzL252ZGltbS9idHRfZGV2cy5jDQo+ID4gaW5kZXggNzk1YWQ0ZmYzNWNhLi41NjVl
YTBiNmY3NjUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9udmRpbW0vYnR0X2RldnMuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvbnZkaW1tL2J0dF9kZXZzLmMNCj4gPiBAQCAtMTk2LDggKzE5NiwxMyBA
QCBzdGF0aWMgc3RydWN0IGRldmljZSAqX19uZF9idHRfY3JlYXRlKHN0cnVjdA0KPiA+IG5kX3Jl
Z2lvbiAqbmRfcmVnaW9uLA0KPiA+ICAJfQ0KPiA+ICANCj4gPiAgCW5kX2J0dC0+bGJhc2l6ZSA9
IGxiYXNpemU7DQo+ID4gLQlpZiAodXVpZCkNCj4gPiArCWlmICh1dWlkKSB7DQo+ID4gIAkJdXVp
ZCA9IGttZW1kdXAodXVpZCwgMTYsIEdGUF9LRVJORUwpOw0KPiA+ICsJCWlmICghdXVpZCkgew0K
PiA+ICsJCQlrZnJlZShuZF9idHQpOw0KPiA+ICsJCQlyZXR1cm4gTlVMTDsNCj4gPiArCQl9DQo+
ID4gKwl9DQo+ID4gIAluZF9idHQtPnV1aWQgPSB1dWlkOw0KPiA+ICAJZGV2ID0gJm5kX2J0dC0+
ZGV2Ow0KPiA+ICAJZGV2X3NldF9uYW1lKGRldiwgImJ0dCVkLiVkIiwgbmRfcmVnaW9uLT5pZCwg
bmRfYnR0LT5pZCk7DQo+ID4gQEAgLTIwOSw2ICsyMTQsNyBAQCBzdGF0aWMgc3RydWN0IGRldmlj
ZSAqX19uZF9idHRfY3JlYXRlKHN0cnVjdA0KPiA+IG5kX3JlZ2lvbiAqbmRfcmVnaW9uLA0KPiA+
ICAJCWRldl9kYmcoJm5kbnMtPmRldiwgImZhaWxlZCwgYWxyZWFkeSBjbGFpbWVkIGJ5ICVzXG4i
LA0KPiA+ICAJCQkJZGV2X25hbWUobmRucy0+Y2xhaW0pKTsNCj4gPiAgCQlwdXRfZGV2aWNlKGRl
dik7DQo+ID4gKwkJa2ZyZWUodXVpZCk7DQo+ID4gIAkJcmV0dXJuIE5VTEw7DQo+ID4gIAl9DQo+
ID4gIAlyZXR1cm4gZGV2Ow0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4gTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdA0KPiBMaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnDQo+IGh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtbnZkaW1tDQoNCg==
