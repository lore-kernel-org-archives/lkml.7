Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F309FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C400E218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfCVXbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:31:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:40259 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfCVXbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 19:31:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 16:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="144456166"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2019 16:31:45 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 22 Mar 2019 16:31:44 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.56]) by
 FMSMSX155.amr.corp.intel.com ([169.254.5.16]) with mapi id 14.03.0415.000;
 Fri, 22 Mar 2019 16:31:44 -0700
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
Thread-Index: AQHU2KvP9fAOZmRsOECRxfaC1K1yNKYYxwKAgAACAgCAAAnLgA==
Date:   Fri, 22 Mar 2019 23:31:43 +0000
Message-ID: <a5240c40ca3353f3798e1a52d4ca663dd278f0aa.camel@intel.com>
References: <20190312081529.4889-1-kjlu@umn.edu>
         <eea1b50fe8c76d45fef0aaca1878c30fa8f2cbde.camel@intel.com>
         <4377c210798b000d60ebdc5150e015737d05565b.camel@intel.com>
In-Reply-To: <4377c210798b000d60ebdc5150e015737d05565b.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AD9C8742838CC4E96CFEB432B12CF70@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMTktMDMtMjIgYXQgMjI6NTYgKzAwMDAsIFZlcm1hLCBWaXNoYWwgTCB3cm90
ZToNCj4gT24gRnJpLCAyMDE5LTAzLTIyIGF0IDIyOjQ5ICswMDAwLCBWZXJtYSwgVmlzaGFsIEwg
d3JvdGU6DQo+ID4gT24gVHVlLCAyMDE5LTAzLTEyIGF0IDAzOjE1IC0wNTAwLCBLYW5namllIEx1
IHdyb3RlOg0KPiA+ID4gSW4gY2FzZSBrbWVtZHVwIGZhaWxzLCB0aGUgZml4IHJlbGVhc2VzIHJl
c291cmNlcyBhbmQgcmV0dXJucyB0bw0KPiA+ID4gYXZvaWQgdGhlIE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZS4NCj4gPiA+IEFsc28sIHRoZSBlcnJvciBwYXRocyBpbiB0aGUgZm9sbG93aW5nIGNv
ZGUgc2hvdWxkIHJlbGVhc2UNCj4gPiA+IHJlc291cmNlcyB0byBhdm9pZCBtZW1vcnkgbGVha3Mu
DQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEthbmdqaWUgTHUgPGtqbHVAdW1uLmVkdT4N
Cj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvbnZkaW1tL2J0dF9kZXZzLmMgfCA4ICsrKysrKyst
DQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+ID4gDQo+ID4gDQo+ID4gTG9va3MgZ29vZCwNCj4gPiBSZXZpZXdlZC1ieTogVmlzaGFsIFZl
cm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+IA0KPiBMb29raW5nIGFnYWluLCB0aGVy
ZSBpcyBhbm90aGVyIGttZW1kdXAoKSBjYWxsIGluIF9fbmRfYnR0X3Byb2JlIHdoaWNoDQo+IGlz
IGxhY2tpbmcgZXJyb3IgY2hlY2tpbmcuDQo+IEFuZCByZWZlcnJpbmcgdG8geW91ciBvdGhlciBy
ZWxhdGVkIHBhdGNoIHRvIG5hbWVzcGFjZV9kZXZzLCB0aGF0IGhhcw0KPiAvc2V2ZXJhbC8gaW5z
dGFuY2VzIG9mIHRoZSBzYW1lIHRoaW5nLg0KPiANCj4gSW5zdGVhZCBvZiBmaXhpbmcganVzdCBh
IGNvdXBsZSBvZiB0aGVzZSwgaXQgbWlnaHQgYmUgd29ydGh3aGlsZSB0byBzZW5kDQo+IGEgd2lk
ZXIgY2xlYW51cCBwYXRjaCB0byBjYXRjaCBhbGwgb2YgdGhlc2UsIGF0IGxlYXN0IHdpdGhpbg0K
PiBkcml2ZXJzL252ZGltbS8gZm9yIHN0YXJ0ZXJzLCBpbnN0ZWFkIG9mIGEgc2VsZWN0IGZldy4N
Cg0KSG0sIGlnbm9yZSB0aGlzIGNvbW1lbnQgLSB0aGVzZSBhcmUgdGhlIG9ubHkgdHdvIHVuY2hl
Y2tlZCBpbnN0YW5jZXMuDQo=
