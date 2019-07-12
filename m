Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E862C742CA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B96206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="iiavQVDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfGLP6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:58:31 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:61294 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLP6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1562947109; x=1594483109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=Xv6oMdRCDU5+Rbt92DK7ZqXDl23JyeTh31Mje6oJEeA=;
  b=iiavQVDXsfKYvtjb7AVbbq5zd8PPT9jaocdsU3LJ8SOBHOaD2IePIVpA
   inGN1kXir/lbAYBBE9D4HHVhaCfpcDp1Zu8jseGM/dF2RaQ2qWfja9Cz5
   cAvfkVllJ2cwW3qHFn9nn0otncWPgB8UBakvanPXLS6+OzR4DBqZZ7i6B
   s=;
X-IronPort-AV: E=Sophos;i="5.62,483,1554768000"; 
   d="scan'208";a="810893324"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Jul 2019 15:58:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 819EEA2452;
        Fri, 12 Jul 2019 15:58:25 +0000 (UTC)
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 12 Jul 2019 15:58:24 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB003.ant.amazon.com (10.43.166.248) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 12 Jul 2019 15:58:24 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Fri, 12 Jul 2019 15:58:24 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>
Subject: Re: [PATCH] KVM: arm/arm64: Properly check for MMIO regions
Thread-Topic: [PATCH] KVM: arm/arm64: Properly check for MMIO regions
Thread-Index: AQHVOIsEiyNRFKEvKk+KpgFJVWRN7KbHJC2A
Date:   Fri, 12 Jul 2019 15:58:23 +0000
Message-ID: <1562947103.19043.1.camel@amazon.de>
References: <1562919728-642-1-git-send-email-karahmed@amazon.de>
In-Reply-To: <1562919728-642-1-git-send-email-karahmed@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.54]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D2353EA90095E4081DA8A6D66A19A79@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA3LTEyIGF0IDEwOjIyICswMjAwLCBLYXJpbUFsbGFoIEFobWVkIHdyb3Rl
Og0KPiBWYWxpZCBSQU0gY2FuIGxpdmUgb3V0c2lkZSBrZXJuZWwgY29udHJvbCAoZS5nLiB1c2lu
ZyAibWVtPSIgY29tbWFuZC1saW5lDQo+IHBhcmFtZXRlcikuIFRoaXMgbWVtb3J5IGNhbiBzdGls
bCBiZSB1c2VkIGFzIHZhbGlkIGd1ZXN0IG1lbW9yeSBmb3IgS1ZNLiBTbw0KPiBlbnN1cmUgdGhh
dCB3ZSB2YWxpZGF0ZSB0aGF0IHRoaXMgbWVtb3J5IGlzIGRlZmluaXRlbHkgbm90ICJSQU0iIGJl
Zm9yZQ0KPiBhc3N1bWluZyB0aGF0IGl0IGlzIGFuIE1NSU8gcmVnaW9uLg0KDQpUaGlzIHBhdGNo
IGFjdHVhbGx5IHN1ZmZlcnMgZnJvbSB0aGUgc2FtZSBwcm9ibGVtIHBvaW50ZWQgb3V0IGhlcmU6
DQpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS83LzEyLzc2MA0KDQouLiBzbyBJIHdpbGwgbmVl
ZCB0byByZXdvcmsgdGhlbSB0b2dldGhlci4NCg0KPiANCj4gT25lIHdheSB0byB1c2UgbWVtb3J5
IG91dHNpZGUga2VybmVsIGNvbnRyb2wgaXM6DQo+IA0KPiAxLSBQYXNzICdtZW09JyBpbiB0aGUg
a2VybmVsIGNvbW1hbmQtbGluZSB0byBsaW1pdCB0aGUgYW1vdW50IG9mIG1lbW9yeSBtYW5hZ2Vk
DQo+ICAgIGJ5IHRoZSBrZXJuZWwuDQo+IDItIE1hcCB0aGlzIHBoeXNpY2FsIG1lbW9yeSB5b3Ug
d2FudCB0byBnaXZlIHRvIHRoZSBndWVzdCB3aXRoOg0KPiAgICBtbWFwKCIvZGV2L21lbSIsIHBo
eXNpY2FsX2FkZHJlc3Nfb2Zmc2V0LCAuLikNCj4gMy0gVXNlIHRoZSB1c2VyLXNwYWNlIHZpcnR1
YWwgYWRkcmVzcyBhcyB0aGUgInVzZXJzcGFjZV9hZGRyIiBmaWVsZCBpbg0KPiAgICBLVk1fU0VU
X1VTRVJfTUVNT1JZX1JFR0lPTiBpb2N0bC4NCj4gDQo+IE9uZSBvZiB0aGUgbGltaXRhdGlvbnMg
b2YgdGhlIGN1cnJlbnQgL2Rldi9tZW0gZm9yIEFSTSBpcyB0aGF0IGl0IHdvdWxkIG1hcA0KPiB0
aGlzIG1lbW9yeSBhcyB1bmNhY2hlZCB3aXRob3V0IHRoaXMgcGF0Y2g6DQo+IGh0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDE5LzcvMTEvNjg0DQo+IA0KPiBUaGlzIHdvcmsgaXMgc2ltaWxhciB0byB0
aGUgd29yayBkb25lIG9uIHg4NiBoZXJlOg0KPiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS8x
LzMxLzkzMw0KPiANCj4gQ2M6IE1hcmMgWnluZ2llciA8bWFyYy56eW5naWVyQGFybS5jb20+DQo+
IENjOiBKYW1lcyBNb3JzZSA8amFtZXMubW9yc2VAYXJtLmNvbT4NCj4gQ2M6IEp1bGllbiBUaGll
cnJ5IDxqdWxpZW4udGhpZXJyeUBhcm0uY29tPg0KPiBDYzogU3V6dWtpIEsgUG91bG96ZSA8c3V6
dWtpLnBvdWxvc2VAYXJtLmNvbT4NCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPiBDYzoga3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQ0KPiBDYzogbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBLYXJpbUFsbGFoIEFobWVk
IDxrYXJhaG1lZEBhbWF6b24uZGU+DQo+IC0tLQ0KPiAgdmlydC9rdm0vYXJtL21tdS5jIHwgMTgg
KysrKysrKysrKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS92aXJ0L2t2bS9hcm0vbW11LmMgYi92
aXJ0L2t2bS9hcm0vbW11LmMNCj4gaW5kZXggMDYxODBjOS4uMjEwNTEzNCAxMDA2NDQNCj4gLS0t
IGEvdmlydC9rdm0vYXJtL21tdS5jDQo+ICsrKyBiL3ZpcnQva3ZtL2FybS9tbXUuYw0KPiBAQCAt
OCw2ICs4LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9rdm1faG9zdC5oPg0KPiAgI2luY2x1ZGUg
PGxpbnV4L2lvLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaHVnZXRsYi5oPg0KPiArI2luY2x1ZGUg
PGxpbnV4L21lbWJsb2NrLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc2NoZWQvc2lnbmFsLmg+DQo+
ICAjaW5jbHVkZSA8dHJhY2UvZXZlbnRzL2t2bS5oPg0KPiAgI2luY2x1ZGUgPGFzbS9wZ2FsbG9j
Lmg+DQo+IEBAIC04OSw3ICs5MCw3IEBAIHN0YXRpYyB2b2lkIGt2bV9mbHVzaF9kY2FjaGVfcHVk
KHN0cnVjdCBrdm0gKmt2bSwNCj4gIA0KPiAgc3RhdGljIGJvb2wga3ZtX2lzX2RldmljZV9wZm4o
dW5zaWduZWQgbG9uZyBwZm4pDQo+ICB7DQo+IC0JcmV0dXJuICFwZm5fdmFsaWQocGZuKTsNCj4g
KwlyZXR1cm4gIW1lbWJsb2NrX2lzX21lbW9yeShfX3Bmbl90b19waHlzKHBmbikpOw0KPiAgfQ0K
PiAgDQo+ICAvKioNCj4gQEAgLTk0OSw2ICs5NTAsNyBAQCBzdGF0aWMgdm9pZCBzdGFnZTJfdW5t
YXBfbWVtc2xvdChzdHJ1Y3Qga3ZtICprdm0sDQo+ICAJZG8gew0KPiAgCQlzdHJ1Y3Qgdm1fYXJl
YV9zdHJ1Y3QgKnZtYSA9IGZpbmRfdm1hKGN1cnJlbnQtPm1tLCBodmEpOw0KPiAgCQlodmFfdCB2
bV9zdGFydCwgdm1fZW5kOw0KPiArCQlncGFfdCBncGE7DQo+ICANCj4gIAkJaWYgKCF2bWEgfHwg
dm1hLT52bV9zdGFydCA+PSByZWdfZW5kKQ0KPiAgCQkJYnJlYWs7DQo+IEBAIC05NTksMTEgKzk2
MSwxNCBAQCBzdGF0aWMgdm9pZCBzdGFnZTJfdW5tYXBfbWVtc2xvdChzdHJ1Y3Qga3ZtICprdm0s
DQo+ICAJCXZtX3N0YXJ0ID0gbWF4KGh2YSwgdm1hLT52bV9zdGFydCk7DQo+ICAJCXZtX2VuZCA9
IG1pbihyZWdfZW5kLCB2bWEtPnZtX2VuZCk7DQo+ICANCj4gLQkJaWYgKCEodm1hLT52bV9mbGFn
cyAmIFZNX1BGTk1BUCkpIHsNCj4gLQkJCWdwYV90IGdwYSA9IGFkZHIgKyAodm1fc3RhcnQgLSBt
ZW1zbG90LT51c2Vyc3BhY2VfYWRkcik7DQo+IC0JCQl1bm1hcF9zdGFnZTJfcmFuZ2Uoa3ZtLCBn
cGEsIHZtX2VuZCAtIHZtX3N0YXJ0KTsNCj4gLQkJfQ0KPiAgCQlodmEgPSB2bV9lbmQ7DQo+ICsN
Cj4gKwkJaWYgKCh2bWEtPnZtX2ZsYWdzICYgVk1fUEZOTUFQKSAmJg0KPiArCQkgICAgIW1lbWJs
b2NrX2lzX21lbW9yeShfX3Bmbl90b19waHlzKHZtYS0+dm1fcGdvZmYpKSkNCj4gKwkJCWNvbnRp
bnVlOw0KPiArDQo+ICsJCWdwYSA9IGFkZHIgKyAodm1fc3RhcnQgLSBtZW1zbG90LT51c2Vyc3Bh
Y2VfYWRkcik7DQo+ICsJCXVubWFwX3N0YWdlMl9yYW5nZShrdm0sIGdwYSwgdm1fZW5kIC0gdm1f
c3RhcnQpOw0KPiAgCX0gd2hpbGUgKGh2YSA8IHJlZ19lbmQpOw0KPiAgfQ0KPiAgDQo+IEBAIC0y
MzI5LDcgKzIzMzQsOCBAQCBpbnQga3ZtX2FyY2hfcHJlcGFyZV9tZW1vcnlfcmVnaW9uKHN0cnVj
dCBrdm0gKmt2bSwNCj4gIAkJdm1fc3RhcnQgPSBtYXgoaHZhLCB2bWEtPnZtX3N0YXJ0KTsNCj4g
IAkJdm1fZW5kID0gbWluKHJlZ19lbmQsIHZtYS0+dm1fZW5kKTsNCj4gIA0KPiAtCQlpZiAodm1h
LT52bV9mbGFncyAmIFZNX1BGTk1BUCkgew0KPiArCQlpZiAoKHZtYS0+dm1fZmxhZ3MgJiBWTV9Q
Rk5NQVApICYmDQo+ICsJCSAgICAhbWVtYmxvY2tfaXNfbWVtb3J5KF9fcGZuX3RvX3BoeXModm1h
LT52bV9wZ29mZikpKSB7DQo+ICAJCQlncGFfdCBncGEgPSBtZW0tPmd1ZXN0X3BoeXNfYWRkciAr
DQo+ICAJCQkJICAgICh2bV9zdGFydCAtIG1lbS0+dXNlcnNwYWNlX2FkZHIpOw0KPiAgCQkJcGh5
c19hZGRyX3QgcGE7DQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApL
cmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4g
U2NobGFlZ2VyLCBSYWxmIEhlcmJyaWNoCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJs
b3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkg
MjM3IDg3OQoKCg==

