Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75A5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D962189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfH1UYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:24:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:28046 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfH1UYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:24:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 13:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="171666831"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2019 13:24:36 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 FMSMSX103.amr.corp.intel.com ([169.254.2.141]) with mapi id 14.03.0439.000;
 Wed, 28 Aug 2019 13:24:36 -0700
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
Thread-Index: AQHVH9BpuhzKadnSBkOkhqdJ05WiaacR2OoAgAAMuICAAA1MgA==
Date:   Wed, 28 Aug 2019 20:24:35 +0000
Message-ID: <7980d0c0b43bc6f377e0daad4a066f7ab37c2258.camel@intel.com>
References: <20190610210613.GA21989@embeddedor>
         <3e80b36c86942278ee66aebdd5ea2632f104083a.camel@intel.com>
         <d940183a-c00d-3a96-37bb-9553583f160a@embeddedor.com>
In-Reply-To: <d940183a-c00d-3a96-37bb-9553583f160a@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3847512B969EEA4C94940FD1F358BBD7@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTI4IGF0IDE0OjM2IC0wNTAwLCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdy
b3RlOg0KDQo+IHN0cnVjdF9zaXplKCkgZG9lcyBub3QgYXBwbHkgdG8gdGhvc2Ugc2NlbmFyaW9z
LiBTZWUgYmVsb3cuLi4NCj4gDQo+ID4gWzFdOiANCj4gPiBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9udmRpbW0vbnZkaW1tLmdpdC90cmVlL2RyaXZlcnMv
bnZkaW1tL3JlZ2lvbl9kZXZzLmMjbjEwMzANCj4gDQo+IHN0cnVjdF9zaXplKCkgb25seSBhcHBs
aWVzIHRvIHN0cnVjdHVyZXMgb2YgdGhlIGZvbGxvd2luZyBraW5kOg0KPiANCj4gc3RydWN0IGZv
byB7DQo+ICAgIGludCBzdHVmZjsNCj4gICAgc3RydWN0IGJvbyBlbnRyeVtdOw0KPiB9Ow0KPiAN
Cj4gYW5kIHRoaXMgc2NlbmFyaW8gaW5jbHVkZXMgdHdvIGRpZmZlcmVudCBzdHJ1Y3R1cmVzOg0K
PiANCj4gc3RydWN0IG5kX3JlZ2lvbiB7DQo+IAkuLi4NCj4gICAgICAgICBzdHJ1Y3QgbmRfbWFw
cGluZyBtYXBwaW5nWzBdOw0KPiB9Ow0KPiANCj4gc3RydWN0IG5kX2Jsa19yZWdpb24gew0KPiAJ
Li4uDQo+ICAgICAgICAgc3RydWN0IG5kX3JlZ2lvbiBuZF9yZWdpb247DQo+IH07DQoNClllcCAt
IEkgbmVnbGVjdGVkIHRvIGFjdHVhbGx5IGxvb2sgYXQgdGhlIHN0cnVjdHVyZXMgaW52b2x2ZWQg
LSB5b3UncmUNCnJpZ2h0LCBpdCBkb2Vzbid0IGFwcGx5IGhlcmUuDQoNCj4gDQo+ID4gWzJdOiAN
Cj4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9udmRp
bW0vbnZkaW1tLmdpdC90cmVlL2RyaXZlcnMvbnZkaW1tL3JlZ2lvbl9kZXZzLmMjbjk2DQo+ID4g
DQo+IA0KPiBJbiB0aGlzIHNjZW5hcmlvIHN0cnVjdF9zaXplKCkgZG9lcyBub3QgYXBwbHkgZGly
ZWN0bHkgYmVjYXVzZSBvZiB0aGUNCj4gZm9sbG93aW5nDQo+IGxvZ2ljIGJlZm9yZSB0aGUgY2Fs
bCB0byBkZXZtX2t6YWxsb2MoKToNCg0KQWdyZWVkLCBJIG1pc3NlZCB0aGF0IHRoZSBjYWxjdWxh
dGlvbiB3YXMgbW9yZSBpbnZvbHZlZCBoZXJlLg0KDQpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0
aW9ucywgeW91IGNhbiBhZGQ6DQpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52
ZXJtYUBpbnRlbC5jb20+DQoNCg==
