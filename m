Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E92C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BF3229EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392151AbfGWVjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:39:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:27130 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731575AbfGWVjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:39:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 14:39:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,300,1559545200"; 
   d="scan'208";a="193208522"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2019 14:39:20 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jul 2019 14:39:20 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jul 2019 14:39:20 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.124]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.76]) with mapi id 14.03.0439.000;
 Tue, 23 Jul 2019 15:39:18 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [PATCH v2 1/3] mm: document zone device struct page field usage
Thread-Topic: [PATCH v2 1/3] mm: document zone device struct page field usage
Thread-Index: AQHVPmhqrWtcBDDhM0SqFmlAUI6ZYabVowsAgABn2YCAANhwgIACPs6A//+fIVA=
Date:   Tue, 23 Jul 2019 21:39:17 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E79E2E610@CRSMSX101.amr.corp.intel.com>
References: <20190719192955.30462-1-rcampbell@nvidia.com>
 <20190719192955.30462-2-rcampbell@nvidia.com>
 <20190721160204.GB363@bombadil.infradead.org>
 <20190722051345.GB6157@iweiny-DESK2.sc.intel.com>
 <20190722110825.GD363@bombadil.infradead.org>
 <80dbf7fc-5c13-f43f-7b87-8273126562e9@nvidia.com>
In-Reply-To: <80dbf7fc-5c13-f43f-7b87-8273126562e9@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTYwNWJiNTUtMWZkZC00OGYyLThhNTktMGQ0MTJiNGFiMzJlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiU0Irc3ZON2x4MWJQNUFZY1ZCcEh2SUxaRndzcFZBSnBkSHp0TGVyVWtQcllVXC9BUHU4dHBVdWFRU2ZTUlY0NG0ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gNy8yMi8xOSA0OjA4IEFNLCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gPiBPbiBT
dW4sIEp1bCAyMSwgMjAxOSBhdCAxMDoxMzo0NVBNIC0wNzAwLCBJcmEgV2Vpbnkgd3JvdGU6DQo+
ID4+IE9uIFN1biwgSnVsIDIxLCAyMDE5IGF0IDA5OjAyOjA0QU0gLTA3MDAsIE1hdHRoZXcgV2ls
Y294IHdyb3RlOg0KPiA+Pj4gT24gRnJpLCBKdWwgMTksIDIwMTkgYXQgMTI6Mjk6NTNQTSAtMDcw
MCwgUmFscGggQ2FtcGJlbGwgd3JvdGU6DQo+ID4+Pj4gU3RydWN0IHBhZ2UgZm9yIFpPTkVfREVW
SUNFIHByaXZhdGUgcGFnZXMgdXNlcyB0aGUgcGFnZS0+bWFwcGluZw0KPiA+Pj4+IGFuZCBhbmQg
cGFnZS0+aW5kZXggZmllbGRzIHdoaWxlIHRoZSBzb3VyY2UgYW5vbnltb3VzIHBhZ2VzIGFyZQ0K
PiA+Pj4+IG1pZ3JhdGVkIHRvIGRldmljZSBwcml2YXRlIG1lbW9yeS4gVGhpcyBpcyBzbyBybWFw
X3dhbGsoKSBjYW4gZmluZA0KPiA+Pj4+IHRoZSBwYWdlIHdoZW4gbWlncmF0aW5nIHRoZSBaT05F
X0RFVklDRSBwcml2YXRlIHBhZ2UgYmFjayB0byBzeXN0ZW0NCj4gbWVtb3J5Lg0KPiA+Pj4+IFpP
TkVfREVWSUNFIHBtZW0gYmFja2VkIGZzZGF4IHBhZ2VzIGFsc28gdXNlIHRoZSBwYWdlLT5tYXBw
aW5nDQo+IGFuZA0KPiA+Pj4+IHBhZ2UtPmluZGV4IGZpZWxkcyB3aGVuIGZpbGVzIGFyZSBtYXBw
ZWQgaW50byBhIHByb2Nlc3MgYWRkcmVzcyBzcGFjZS4NCj4gPj4+Pg0KPiA+Pj4+IFJlc3RydWN0
dXJlIHN0cnVjdCBwYWdlIGFuZCBhZGQgY29tbWVudHMgdG8gbWFrZSB0aGlzIG1vcmUgY2xlYXIu
DQo+ID4+Pg0KPiA+Pj4gTkFLLiAgSSBqdXN0IGdvdCByaWQgb2YgdGhpcyBraW5kIG9mIGZvb2xp
c2huZXNzIGZyb20gc3RydWN0IHBhZ2UsDQo+ID4+PiBhbmQgeW91J3JlIG1ha2luZyBpdCBoYXJk
ZXIgdG8gdW5kZXJzdGFuZCwgbm90IGVhc2llci4gIFRoZSBjb21tZW50cw0KPiA+Pj4gY291bGQg
YmUgaW1wcm92ZWQsIGJ1dCBkb24ndCBsYXkgaXQgb3V0IGxpa2UgdGhpcyBhZ2Fpbi4NCj4gPj4N
Cj4gPj4gV2FzIFYxIG9mIFJhbHBocyBwYXRjaCBvaz8gIEl0IHNlZW1lZCBvayB0byBtZS4NCj4g
Pg0KPiA+IFllcywgdjEgd2FzIGZpbmUuICBUaGlzIHNlZW1zIGxpa2UgYSByZWdyZXNzaW9uLg0K
PiA+DQo+IA0KPiBUaGlzIGlzIGFib3V0IHdoYXQgcGVvcGxlIGZpbmQgImVhc2llc3QgdG8gdW5k
ZXJzdGFuZCIgYW5kIHNvIEknbSBub3QNCj4gc3VycHJpc2VkIHRoYXQgb3BpbmlvbnMgZGlmZmVy
Lg0KPiBXaGF0IGlmIEkgcG9zdCBhIHYzIGJhc2VkIG9uIHYxIGJ1dCByZW1vdmUgdGhlIF96ZF9w
YWRfKiB2YXJpYWJsZXMgdGhhdA0KPiBDaHJpc3RvcGggZm91bmQgbWlzbGVhZGluZyBhbmQgYWRk
IHNvbWUgbW9yZSBjb21tZW50cyBhYm91dCBob3cgdGhlDQo+IGRpZmZlcmVudCBaT05FX0RFVklD
RSB0eXBlcyB1c2UgdGhlIDMgcmVtYWluaW5nIHdvcmRzIChiYXNpY2FsbHkgdGhlDQo+IGNvbW1l
bnQgZnJvbSB2Mik/DQoNCkknbSBvayB3aXRoIHRoYXQuLi4NCg0KSXJhDQoNCg==
