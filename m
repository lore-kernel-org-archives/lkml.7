Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD745C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECA1263C6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfEaEg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 00:36:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:62066 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaEg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 00:36:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 21:36:26 -0700
X-ExtLoop1: 1
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga006.jf.intel.com with ESMTP; 30 May 2019 21:36:26 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.79]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.7]) with mapi id 14.03.0415.000;
 Thu, 30 May 2019 21:36:26 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mroos@linux.ee" <mroos@linux.ee>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "ard.biesheuvel@arm.com" <ard.biesheuvel@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "namit@vmware.com" <namit@vmware.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH] vmalloc: Don't use flush flag when no exec perm
Thread-Topic: [PATCH] vmalloc: Don't use flush flag when no exec perm
Thread-Index: AQHVFeKXsxy+QkOKqU23zfNpAWli4aaDgIiAgABAJ4CAAV2zgA==
Date:   Fri, 31 May 2019 04:36:25 +0000
Message-ID: <120f658d6f34c99a72e82c993ec380109f7aef2c.camel@intel.com>
References: <20190529055104.6822-1-rick.p.edgecombe@intel.com>
         <89d6dee949e4418f0cca4cc6c4c9b526c1a5c497.camel@intel.com>
         <67241836-621c-6933-1278-f04aedcefcb3@linux.ee>
In-Reply-To: <67241836-621c-6933-1278-f04aedcefcb3@linux.ee>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
x-originating-ip: [10.252.134.167]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1A8C0F763855B4D836A965D3C862A13@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA1LTMwIGF0IDEwOjQ0ICswMzAwLCBNZWVsaXMgUm9vcyB3cm90ZToNCj4g
PiA+IFRoZSBhZGRpdGlvbiBvZiBWTV9GTFVTSF9SRVNFVF9QRVJNUyBmb3IgQlBGIEpJVCBhbGxv
Y2F0aW9ucyB3YXMNCj4gPiA+IGJpc2VjdGVkIHRvIHByZXZlbnQgYm9vdCBvbiBhbiBVbHRyYVNw
YXJjIElJSSBtYWNoaW5lLiBJdCB3YXMNCj4gPiA+IGZvdW5kDQo+ID4gPiB0aGF0DQo+ID4gPiBz
b21ldGltZSBzaG9ydGx5IGFmdGVyIHRoZSBUTEIgZmx1c2ggdGhpcyBmbGFnIGRvZXMgb24gdmZy
ZWUgb2YNCj4gPiA+IHRoZQ0KPiA+ID4gQlBGDQo+ID4gPiBwcm9ncmFtLCB0aGUgbWFjaGluZSBo
dW5nLiBGdXJ0aGVyIGludmVzdGlnYXRpb24gc2hvd2VkIHRoYXQNCj4gPiA+IGJlZm9yZQ0KPiA+
ID4gYW55IG9mDQo+ID4gPiB0aGUgY2hhbmdlcyBmb3IgdGhpcyBmbGFnIHdlcmUgaW50cm9kdWNl
ZCwgd2l0aA0KPiA+ID4gQ09ORklHX0RFQlVHX1BBR0VBTExPQw0KPiA+ID4gY29uZmlndXJlZCAo
d2hpY2ggZG9lcyBhIHNpbWlsYXIgVExCIGZsdXNoIG9mIHRoZSB2bWFsbG9jIHJhbmdlDQo+ID4g
PiBvbg0KPiA+ID4gZXZlcnkgdmZyZWUpLCB0aGlzIG1hY2hpbmUgYWxzbyBodW5nIHNob3J0bHkg
YWZ0ZXIgdGhlIGZpcnN0DQo+ID4gPiB2bWFsbG9jDQo+ID4gPiB1bm1hcC9mcmVlLg0KPiA+ID4g
DQo+ID4gPiBTbyB0aGUgZXZpZGVuY2UgcG9pbnRzIHRvIHRoZXJlIGJlaW5nIHNvbWUgZXhpc3Rp
bmcgaXNzdWUgd2l0aA0KPiA+ID4gdGhlDQo+ID4gPiB2bWFsbG9jIFRMQiBmbHVzaGVzLCBidXQg
aXQncyBzdGlsbCB1bmtub3duIGV4YWN0bHkgd2h5IHRoZXNlDQo+ID4gPiBoYW5ncw0KPiA+ID4g
YXJlDQo+ID4gPiBoYXBwZW5pbmcgb24gc3BhcmMuIEl0IGlzIGFsc28gdW5rbm93biB3aGVuIHNv
bWVvbmUgd2l0aCB0aGlzDQo+ID4gPiBoYXJkd2FyZQ0KPiA+ID4gY291bGQgcmVzb2x2ZSB0aGlz
LCBhbmQgaW4gdGhlIG1lYW50aW1lIHVzaW5nIHRoaXMgZmxhZyBvbiBpdA0KPiA+ID4gdHVybnMg
YQ0KPiA+ID4gbHVya2luZyBiZWhhdmlvciBpbnRvIHNvbWV0aGluZyB0aGF0IHByZXZlbnRzIGJv
b3QuDQo+ID4gDQo+ID4gVGhlIHNwYXJjIFRMQiBmbHVzaCBpc3N1ZSBoYXMgYmVlbiBiaXNlY3Rl
ZCBhbmQgaXMgYmVpbmcgd29ya2VkIG9uDQo+ID4gbm93LA0KPiA+IHNvIGhvcGVmdWxseSB3ZSB3
b24ndCBuZWVkIHRoaXMgcGF0Y2g6DQo+ID4gaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtc3Bh
cmMmbT0xNTU5MTU2OTQzMDQxMTgmdz0yDQo+IA0KPiBBbmQgdGhlIHNwYXJjNjQgcGF0Y2ggdGhh
dCBmaXhlcyBDT05GSUdfREVCVUdfUEFHRUFMTE9DIGFsc28gZml4ZXMNCj4gYm9vdGluZw0KPiBv
ZiB0aGUgbGF0ZXN0IGdpdCBrZXJuZWwgb24gU3VuIFY0NDUgd2hlcmUgbXkgcHJvYmxlbSBpbml0
aWFsbHkNCj4gaGFwcGVuZWQuDQo+IA0KVGhhbmtzIE1lZWxpcy4gU28gdGhlIFRMQiBmbHVzaCBv
biB0aGlzIHBsYXRmb3JtIHdpbGwgYmUgZml4ZWQgYW5kIHdlDQp3b24ndCBuZWVkIHRoaXMgcGF0
Y2guDQo=
