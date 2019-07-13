Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A2FC742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 13:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09AA2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 13:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="X/rasMJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfGMNxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 09:53:35 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:52434 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfGMNxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 09:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1563026014; x=1594562014;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=Oq1JDzuzw72gaVJ3N+aVYoxBMtRhT49QZunKSm9NVAA=;
  b=X/rasMJRLfdLC5i1FYYu3G4eAfQoNaSclM02jZd27gJ5VWhb6Bgl/3p1
   2qhrVC5qKoglazQ3IM+5f2MLEjZio9vJpTOInZgQ2MIIw0rGWWTHVXmsF
   qQtHagF0EPArV2wMhXA4ZdEjqrHG3gRBGXBETuItiJw7nFPV0vlhqOaps
   Y=;
X-IronPort-AV: E=Sophos;i="5.62,486,1554768000"; 
   d="scan'208";a="741626702"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 13 Jul 2019 13:53:32 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 065D6A1868;
        Sat, 13 Jul 2019 13:53:27 +0000 (UTC)
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sat, 13 Jul 2019 13:53:27 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB003.ant.amazon.com (10.43.166.248) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sat, 13 Jul 2019 13:53:26 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Sat, 13 Jul 2019 13:53:25 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cai@lca.pw" <cai@lca.pw>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>
Subject: Re: [PATCH] mm: sparse: Skip no-map regions in memblocks_present
Thread-Topic: [PATCH] mm: sparse: Skip no-map regions in memblocks_present
Thread-Index: AQHVOI8IlRiU8rBOJUewLnGIizLEO6bHnIWAgAD3C4A=
Date:   Sat, 13 Jul 2019 13:53:25 +0000
Message-ID: <1563026005.19043.12.camel@amazon.de>
References: <1562921491-23899-1-git-send-email-karahmed@amazon.de>
         <20190712230913.l35zpdiqcqa4o32f@master>
In-Reply-To: <20190712230913.l35zpdiqcqa4o32f@master>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.55]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFDECDBACA6C2447A4E251886434636E@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA3LTEyIGF0IDIzOjA5ICswMDAwLCBXZWkgWWFuZyB3cm90ZToNCj4gT24g
RnJpLCBKdWwgMTIsIDIwMTkgYXQgMTA6NTE6MzFBTSArMDIwMCwgS2FyaW1BbGxhaCBBaG1lZCB3
cm90ZToNCj4gPiANCj4gPiBEbyBub3QgbWFyayByZWdpb25zIHRoYXQgYXJlIG1hcmtlZCB3aXRo
IG5vbWFwIHRvIGJlIHByZXNlbnQsIG90aGVyd2lzZQ0KPiA+IHRoZXNlIG1lbWJsb2NrIGNhdXNl
IHVubmVjZXNzYXJpbHkgYWxsb2NhdGlvbiBvZiBtZXRhZGF0YS4NCj4gPiANCj4gPiBDYzogQW5k
cmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gPiBDYzogUGF2ZWwgVGF0
YXNoaW4gPHBhc2hhLnRhdGFzaGluQG9yYWNsZS5jb20+DQo+ID4gQ2M6IE9zY2FyIFNhbHZhZG9y
IDxvc2FsdmFkb3JAc3VzZS5kZT4NCj4gPiBDYzogTWljaGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5j
b20+DQo+ID4gQ2M6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4NCj4gPiBDYzog
QmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+DQo+ID4gQ2M6IFFpYW4gQ2FpIDxjYWlAbGNhLnB3
Pg0KPiA+IENjOiBXZWkgWWFuZyA8cmljaGFyZC53ZWl5YW5nQGdtYWlsLmNvbT4NCj4gPiBDYzog
TG9nYW4gR3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPg0KPiA+IENjOiBsaW51eC1tbUBr
dmFjay5vcmcNCj4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEthcmltQWxsYWggQWhtZWQgPGthcmFobWVkQGFtYXpvbi5kZT4NCj4gPiAtLS0N
Cj4gPiBtbS9zcGFyc2UuYyB8IDQgKysrKw0KPiA+IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbW0vc3BhcnNlLmMgYi9tbS9zcGFyc2UuYw0K
PiA+IGluZGV4IGZkMTMxNjYuLjMzODEwYjYgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vc3BhcnNlLmMN
Cj4gPiArKysgYi9tbS9zcGFyc2UuYw0KPiA+IEBAIC0yNTYsNiArMjU2LDEwIEBAIHZvaWQgX19p
bml0IG1lbWJsb2Nrc19wcmVzZW50KHZvaWQpDQo+ID4gCXN0cnVjdCBtZW1ibG9ja19yZWdpb24g
KnJlZzsNCj4gPiANCj4gPiAJZm9yX2VhY2hfbWVtYmxvY2sobWVtb3J5LCByZWcpIHsNCj4gPiAr
DQo+ID4gKwkJaWYgKG1lbWJsb2NrX2lzX25vbWFwKHJlZykpDQo+ID4gKwkJCWNvbnRpbnVlOw0K
PiA+ICsNCj4gPiAJCW1lbW9yeV9wcmVzZW50KG1lbWJsb2NrX2dldF9yZWdpb25fbm9kZShyZWcp
LA0KPiA+IAkJCSAgICAgICBtZW1ibG9ja19yZWdpb25fbWVtb3J5X2Jhc2VfcGZuKHJlZyksDQo+
ID4gCQkJICAgICAgIG1lbWJsb2NrX3JlZ2lvbl9tZW1vcnlfZW5kX3BmbihyZWcpKTsNCj4gDQo+
IA0KPiBUaGUgbG9naWMgbG9va3MgZ29vZCwgd2hpbGUgSSBhbSBub3Qgc3VyZSB0aGlzIHdvdWxk
IHRha2UgZWZmZWN0LiBTaW5jZSB0aGUNCj4gbWV0YWRhdGEgaXMgU0VDVElPTiBzaXplIGFsaWdu
ZWQgd2hpbGUgbWVtYmxvY2sgaXMgbm90Lg0KPiANCj4gSWYgSSBhbSBjb3JyZWN0LCBvbiBhcm02
NCwgd2UgbWFyayBub21hcCBtZW1ibG9jayBpbiBtYXBfbWVtKCkNCj4gDQo+ICAgICBtZW1ibG9j
a19tYXJrX25vbWFwKGtlcm5lbF9zdGFydCwga2VybmVsX2VuZCAtIGtlcm5lbF9zdGFydCk7DQoN
ClRoZSBub21hcCBpcyBhbHNvIGRvbmUgYnkgRUZJIGNvZGUgaW4gJHtzcmN9L2RyaXZlcnMvZmly
bXdhcmUvZWZpL2FybS1pbml0LmMNCg0KLi4gYW5kIGhvcGVmdWxseSBpbiB0aGUgZnV0dXJlIGJ5
IHRoaXM6DQpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS83LzEyLzEyNg0KDQpTbyBpdCBpcyBu
b3QgcmVhbGx5IHN0cmljbHR5IGFzc29jaWF0ZWQgd2l0aCB0aGUgbWFwX21lbSgpLg0KDQpTbyBp
dCBpcyBleHRyZW1lbHkgZGVwZW5kZW50IG9uIHRoZSBwbGF0Zm9ybSBob3cgbXVjaCBtZW1vcnkg
d2lsbCBlbmQgdXAgbWFwcGVkwqANCmFzIG5vbWFwLg0KDQo+IA0KPiBBbmQga2VybmVsIHRleHQg
YXJlYSBpcyBsZXNzIHRoYW4gNDBNLCBpZiBJIGFtIHJpZ2h0LiBUaGlzIG1lYW5zDQo+IG1lbWJs
b2Nrc19wcmVzZW50IHdvdWxkIHN0aWxsIG1hcmsgdGhlIHNlY3Rpb24gcHJlc2VudC4gDQo+IA0K
PiBXb3VsZCB5b3UgbWluZCBzaG93aW5nIGhvdyBtdWNoIG1lbW9yeSByYW5nZSBpdCBpcyBtYXJr
ZWQgbm9tYXA/DQoNCldlIGFjdHVhbGx5IGhhdmUgc29tZSBkb3duc3RyZWFtIHBhdGNoZXMgdGhh
dCBhcmUgdXNpbmcgdGhpcyBub21hcCBmbGFnIGZvcg0KbW9yZSB0aGFuIHRoZSB1c2UtY2FzZXMg
SSBkZXNjcmliZWQgYWJvdmUgd2hpY2ggd291bGQgZW5mbGF0ZSB0aGUgbm9tYXAgcmVnaW9uc8Kg
DQphIGJpdCA6KQ0KDQo+IA0KPiA+IA0KPiA+IC0tIA0KPiA+IDIuNy40DQo+IA0KCgoKQW1hem9u
IERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVy
bGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgUmFsZiBIZXJicmlj
aApFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5
MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

