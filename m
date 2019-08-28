Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD302C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB6D208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfH1Svb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:51:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:20397 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfH1Svb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:51:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 11:51:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="175014339"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2019 11:51:30 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 28 Aug 2019 11:51:30 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 FMSMSX157.amr.corp.intel.com ([169.254.14.57]) with mapi id 14.03.0439.000;
 Wed, 28 Aug 2019 11:51:29 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH] libnvdimm, region: Use struct_size() in kzalloc()
Thread-Topic: [PATCH] libnvdimm, region: Use struct_size() in kzalloc()
Thread-Index: AQHVH9BpuhzKadnSBkOkhqdJ05WiaacR2OoA
Date:   Wed, 28 Aug 2019 18:51:28 +0000
Message-ID: <3e80b36c86942278ee66aebdd5ea2632f104083a.camel@intel.com>
References: <20190610210613.GA21989@embeddedor>
In-Reply-To: <20190610210613.GA21989@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1589446AC767F47B8FEFD059DCEA60D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA2LTEwIGF0IDE2OjA2IC0wNTAwLCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdy
b3RlOg0KPiBPbmUgb2YgdGhlIG1vcmUgY29tbW9uIGNhc2VzIG9mIGFsbG9jYXRpb24gc2l6ZSBj
YWxjdWxhdGlvbnMgaXMNCj4gZmluZGluZw0KPiB0aGUgc2l6ZSBvZiBhIHN0cnVjdHVyZSB0aGF0
IGhhcyBhIHplcm8tc2l6ZWQgYXJyYXkgYXQgdGhlIGVuZCwgYWxvbmcNCj4gd2l0aCBtZW1vcnkg
Zm9yIHNvbWUgbnVtYmVyIG9mIGVsZW1lbnRzIGZvciB0aGF0IGFycmF5LiBGb3IgZXhhbXBsZToN
Cj4gDQo+IHN0cnVjdCBuZF9yZWdpb24gew0KPiAJLi4uDQo+ICAgICAgICAgc3RydWN0IG5kX21h
cHBpbmcgbWFwcGluZ1swXTsNCj4gfTsNCj4gDQo+IGluc3RhbmNlID0ga3phbGxvYyhzaXplb2Yo
c3RydWN0IG5kX3JlZ2lvbikgKyBzaXplb2Yoc3RydWN0DQo+IG5kX21hcHBpbmcpICoNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb3VudCwgR0ZQX0tFUk5FTCk7DQo+IA0KPiBJbnN0ZWFk
IG9mIGxlYXZpbmcgdGhlc2Ugb3Blbi1jb2RlZCBhbmQgcHJvbmUgdG8gdHlwZSBtaXN0YWtlcywg
d2UgY2FuDQo+IG5vdyB1c2UgdGhlIG5ldyBzdHJ1Y3Rfc2l6ZSgpIGhlbHBlcjoNCj4gDQo+IGlu
c3RhbmNlID0ga3phbGxvYyhzdHJ1Y3Rfc2l6ZShpbnN0YW5jZSwgbWFwcGluZywgY291bnQpLCBH
RlBfS0VSTkVMKTsNCj4gDQo+IFRoaXMgY29kZSB3YXMgZGV0ZWN0ZWQgd2l0aCB0aGUgaGVscCBv
ZiBDb2NjaW5lbGxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2YSA8
Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL252ZGltbS9yZWdpb25f
ZGV2cy5jIHwgNyArKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL3JlZ2lvbl9k
ZXZzLmMNCj4gYi9kcml2ZXJzL252ZGltbS9yZWdpb25fZGV2cy5jDQo+IGluZGV4IGI0ZWY3ZDlm
ZjIyZS4uODhiZWNjODdlMjM0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252ZGltbS9yZWdpb25f
ZGV2cy5jDQo+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL3JlZ2lvbl9kZXZzLmMNCj4gQEAgLTEwMjcs
MTAgKzEwMjcsOSBAQCBzdGF0aWMgc3RydWN0IG5kX3JlZ2lvbg0KPiAqbmRfcmVnaW9uX2NyZWF0
ZShzdHJ1Y3QgbnZkaW1tX2J1cyAqbnZkaW1tX2J1cywNCj4gIAkJfQ0KPiAgCQlyZWdpb25fYnVm
ID0gbmRicjsNCj4gIAl9IGVsc2Ugew0KPiAtCQluZF9yZWdpb24gPSBremFsbG9jKHNpemVvZihz
dHJ1Y3QgbmRfcmVnaW9uKQ0KPiAtCQkJCSsgc2l6ZW9mKHN0cnVjdCBuZF9tYXBwaW5nKQ0KPiAt
CQkJCSogbmRyX2Rlc2MtPm51bV9tYXBwaW5ncywNCj4gLQkJCQlHRlBfS0VSTkVMKTsNCj4gKwkJ
bmRfcmVnaW9uID0ga3phbGxvYyhzdHJ1Y3Rfc2l6ZShuZF9yZWdpb24sIG1hcHBpbmcsDQo+ICsJ
CQkJCQluZHJfZGVzYy0+bnVtX21hcHBpbmdzKSwNCj4gKwkJCQkgICAgR0ZQX0tFUk5FTCk7DQo+
ICAJCXJlZ2lvbl9idWYgPSBuZF9yZWdpb247DQo+ICAJfQ0KPiAgDQoNCkhpIEd1c3Rhdm8sDQoN
ClRoZSBwYXRjaCBsb29rcyBnb29kIHRvIG1lLCBob3dldmVyIGl0IGxvb2tzIGxpa2UgaXQgbWln
aHQndmUgbWlzc2VkDQpzb21lIGluc3RhbmNlcyB3aGVyZSB0aGlzIHJlcGxhY2VtZW50IGNhbiBi
ZSBwZXJmb3JtZWQ/DQoNCk9uZSBpcyBqdXN0IGEgZmV3IGxpbmVzIGJlbG93IGZyb20gdGhlIGFi
b3ZlLCBpbiB0aGUgJ2Vsc2UnIGJsb2NrWzFdLg0KQWRkaXRpb25hbGx5LCBtYXliZSB0aGUgQ29j
Y2luZWxsZSBzY3JpcHQgY2FuIGJlIGF1Z21lbnRlZCB0byBjYXRjaA0KZGV2bV9remFsbG9jIGlu
c3RhbmNlcyBhcyB3ZWxsIC0gdGhlcmUgaXMgb25lIG9mIHRob3NlIGluIHRoaXMgZmlsZVsyXS4N
Cg0KVGhhbmtzLA0KCS1WaXNoYWwNCg0KWzFdOiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9udmRpbW0vbnZkaW1tLmdpdC90cmVlL2RyaXZlcnMvbnZkaW1t
L3JlZ2lvbl9kZXZzLmMjbjEwMzANClsyXTogaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvbnZkaW1tL252ZGltbS5naXQvdHJlZS9kcml2ZXJzL252ZGltbS9y
ZWdpb25fZGV2cy5jI245Ng0KDQoNCg0K
