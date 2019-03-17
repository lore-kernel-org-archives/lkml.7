Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC80AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DFA21738
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="VYO2k1c9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfCQOui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 10:50:38 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:39388 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfCQOui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 10:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1552834237; x=1584370237;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=KjFOqSqhR5K+aHwZ+x5zBGJx24fzKJJiwHJ1/YVyFww=;
  b=VYO2k1c9wNcuHnO0mi9h9A+ZtsBEIlQ+iZAmRqGcXg+zH4R1oKS7irVb
   dYL3AQryfmVtbpTONp9Bk1nll73+bo+fICQj5nGP7MgpjQsMPz3kHWMJl
   x/U4wwZ0JSl6/bgKUnvcwOs1j6n7kna5jvvOgKxzpOy6BndhKCFBycgi0
   0=;
X-IronPort-AV: E=Sophos;i="5.58,489,1544486400"; 
   d="scan'208";a="763501066"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Mar 2019 14:50:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x2HEoTge130041
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 17 Mar 2019 14:50:30 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 17 Mar 2019 14:50:28 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 17 Mar 2019 14:50:27 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Sun, 17 Mar 2019 14:50:27 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
        "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>
Subject: Re: [RFC PATCH] KVM: arm/arm64: Enable direct irqfd MSI injection
Thread-Topic: [RFC PATCH] KVM: arm/arm64: Enable direct irqfd MSI injection
Thread-Index: AQHU3M+t8YXFjAcHek6Le9ZF2V154qYP5+MA
Date:   Sun, 17 Mar 2019 14:50:26 +0000
Message-ID: <1552834226.19343.1.camel@amazon.de>
References: <1552833373-19828-1-git-send-email-yuzenghui@huawei.com>
In-Reply-To: <1552833373-19828-1-git-send-email-yuzenghui@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.215]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4C6E606D93F984399786467A9281A74@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE5LTAzLTE3IGF0IDE0OjM2ICswMDAwLCBaZW5naHVpIFl1IHdyb3RlOg0KPiBD
dXJyZW50bHksIElSUUZEIG9uIGFybSBzdGlsbCB1c2VzIHRoZSBkZWZlcnJlZCB3b3JrcXVldWUg
bWVjaGFuaXNtDQo+IHRvIGluamVjdCBpbnRlcnJ1cHRzIGludG8gZ3Vlc3QsIHdoaWNoIHdpbGwg
bGlrZWx5IGxlYWQgdG8gYSBidXN5DQo+IGNvbnRleHQtc3dpdGNoaW5nIGZyb20vdG8gdGhlIGt3
b3JrZXIgdGhyZWFkLiBUaGlzIG92ZXJoZWFkIGlzIGZvcg0KPiBubyBwdXJwb3NlIChvbmx5IGlu
IG15IHZpZXcgLi4uKSBhbmQgd2lsbCByZXN1bHQgaW4gYW4gaW50ZXJydXB0DQo+IHBlcmZvcm1h
bmNlIGRlZ3JhZGF0aW9uLg0KPiANCj4gSW1wbGVtZW50IGt2bV9hcmNoX3NldF9pcnFfaW5hdG9t
aWMoKSBmb3IgYXJtL2FybTY0IHRvIHN1cHBvcnQgZGlyZWN0DQo+IGlycWZkIE1TSSBpbmplY3Rp
b24sIGJ5IHdoaWNoIHdlIGNhbiBnZXQgcmlkIG9mIHRoZSBhbm5veWluZyBsYXRlbmN5Lg0KPiBB
cyBhIHJlc3VsdCwgaXJxZmQgTVNJIGludGVuc2l2ZSBzY2VuYXJpb3MgKGUuZy4sIERQREsgd2l0
aCBoaWdoIHBhY2tldA0KPiBwcm9jZXNzaW5nIHdvcmtsb2Fkcykgd2lsbCBiZW5lZml0IGZyb20g
aXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaZW5naHVpIFl1IDx5dXplbmdodWlAaHVhd2VpLmNv
bT4NCj4gLS0tDQo+IA0KPiBJdCBzZWVtcyB0aGF0IG9ubHkgTVNJIHdpbGwgZm9sbG93IHRoZSBJ
UlFGRCBwYXRoLCBkaWQgSSBtaXNzIHNvbWV0aGluZz8NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgc3Rp
bGwgdW5kZXIgdGVzdCBhbmQgc2VudCBvdXQgZm9yIGVhcmx5IGZlZWRiYWNrLiBJZiBJIGhhdmUN
Cj4gYW55IG1pcy11bmRlcnN0YW5kaW5nLCBwbGVhc2UgZml4IG1lIHVwIGFuZCBsZXQgbWUga25v
dy4gVGhhbmtzIQ0KPiANCj4gLS0tDQo+ICB2aXJ0L2t2bS9hcm0vdmdpYy90cmFjZS5oICAgICAg
fCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+ICB2aXJ0L2t2bS9hcm0vdmdpYy92Z2ljLWly
cWZkLmMgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNDMg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3ZpcnQva3ZtL2FybS92Z2ljL3RyYWNl
LmggYi92aXJ0L2t2bS9hcm0vdmdpYy90cmFjZS5oDQo+IGluZGV4IDU1ZmVkNzcuLmJjMWY0ZGIg
MTAwNjQ0DQo+IC0tLSBhL3ZpcnQva3ZtL2FybS92Z2ljL3RyYWNlLmgNCj4gKysrIGIvdmlydC9r
dm0vYXJtL3ZnaWMvdHJhY2UuaA0KPiBAQCAtMjcsNiArMjcsMjggQEANCj4gIAkJICBfX2VudHJ5
LT52Y3B1X2lkLCBfX2VudHJ5LT5pcnEsIF9fZW50cnktPmxldmVsKQ0KPiAgKTsNCj4gIA0KPiAr
VFJBQ0VfRVZFTlQoa3ZtX2FyY2hfc2V0X2lycV9pbmF0b21pYywNCj4gKwlUUF9QUk9UTyh1MzIg
Z3NpLCB1MzIgdHlwZSwgaW50IGxldmVsLCBpbnQgaXJxX3NvdXJjZV9pZCksDQo+ICsJVFBfQVJH
Uyhnc2ksIHR5cGUsIGxldmVsLCBpcnFfc291cmNlX2lkKSwNCj4gKw0KPiArCVRQX1NUUlVDVF9f
ZW50cnkoDQo+ICsJCV9fZmllbGQoCXUzMiwJZ3NpCQkpDQo+ICsJCV9fZmllbGQoCXUzMiwJdHlw
ZQkJKQ0KPiArCQlfX2ZpZWxkKAlpbnQsCWxldmVsCQkpDQo+ICsJCV9fZmllbGQoCWludCwJaXJx
X3NvdXJjZV9pZAkpDQo+ICsJKSwNCj4gKw0KPiArCVRQX2Zhc3RfYXNzaWduKA0KPiArCQlfX2Vu
dHJ5LT5nc2kJCT0gZ3NpOw0KPiArCQlfX2VudHJ5LT50eXBlCQk9IHR5cGU7DQo+ICsJCV9fZW50
cnktPmxldmVsCQk9IGxldmVsOw0KPiArCQlfX2VudHJ5LT5pcnFfc291cmNlX2lkCT0gaXJxX3Nv
dXJjZV9pZDsNCj4gKwkpLA0KPiArDQo+ICsJVFBfcHJpbnRrKCJnc2kgJXUgdHlwZSAldSBsZXZl
bCAlZCBzb3VyY2UgJWQiLCBfX2VudHJ5LT5nc2ksDQo+ICsJCSAgX19lbnRyeS0+dHlwZSwgX19l
bnRyeS0+bGV2ZWwsIF9fZW50cnktPmlycV9zb3VyY2VfaWQpDQo+ICspOw0KPiArDQo+ICAjZW5k
aWYgLyogX1RSQUNFX1ZHSUNfSCAqLw0KPiAgDQo+ICAjdW5kZWYgVFJBQ0VfSU5DTFVERV9QQVRI
DQo+IGRpZmYgLS1naXQgYS92aXJ0L2t2bS9hcm0vdmdpYy92Z2ljLWlycWZkLmMgYi92aXJ0L2t2
bS9hcm0vdmdpYy92Z2ljLWlycWZkLmMNCj4gaW5kZXggOTllMDI2ZC4uNGNmYzNmNCAxMDA2NDQN
Cj4gLS0tIGEvdmlydC9rdm0vYXJtL3ZnaWMvdmdpYy1pcnFmZC5jDQo+ICsrKyBiL3ZpcnQva3Zt
L2FybS92Z2ljL3ZnaWMtaXJxZmQuYw0KPiBAQCAtMTksNiArMTksNyBAQA0KPiAgI2luY2x1ZGUg
PHRyYWNlL2V2ZW50cy9rdm0uaD4NCj4gICNpbmNsdWRlIDxrdm0vYXJtX3ZnaWMuaD4NCj4gICNp
bmNsdWRlICJ2Z2ljLmgiDQo+ICsjaW5jbHVkZSAidHJhY2UuaCINCj4gIA0KPiAgLyoqDQo+ICAg
KiB2Z2ljX2lycWZkX3NldF9pcnE6IGluamVjdCB0aGUgSVJRIGNvcnJlc3BvbmRpbmcgdG8gdGhl
DQo+IEBAIC0xMDUsNiArMTA2LDI2IEBAIGludCBrdm1fc2V0X21zaShzdHJ1Y3Qga3ZtX2tlcm5l
bF9pcnFfcm91dGluZ19lbnRyeSAqZSwNCj4gIAlyZXR1cm4gdmdpY19pdHNfaW5qZWN0X21zaShr
dm0sICZtc2kpOw0KPiAgfQ0KPiAgDQo+ICsvKioNCj4gKyAqIGt2bV9hcmNoX3NldF9pcnFfaW5h
dG9taWM6IGZhc3QtcGF0aCBmb3IgaXJxZmQgaW5qZWN0aW9uDQo+ICsgKg0KPiArICogQ3VycmVu
dGx5IG9ubHkgZGlyZWN0IE1TSSBpbmplY3RvbiBpcyBzdXBwb3J0ZWQuDQo+ICsgKi8NCj4gK2lu
dCBrdm1fYXJjaF9zZXRfaXJxX2luYXRvbWljKHN0cnVjdCBrdm1fa2VybmVsX2lycV9yb3V0aW5n
X2VudHJ5ICplLA0KPiArCQkJICAgICAgc3RydWN0IGt2bSAqa3ZtLCBpbnQgaXJxX3NvdXJjZV9p
ZCwgaW50IGxldmVsLA0KPiArCQkJICAgICAgYm9vbCBsaW5lX3N0YXR1cykNCj4gK3sNCj4gKwlp
bnQgcmV0Ow0KPiArDQo+ICsJdHJhY2Vfa3ZtX2FyY2hfc2V0X2lycV9pbmF0b21pYyhlLT5nc2ks
IGUtPnR5cGUsIGxldmVsLCBpcnFfc291cmNlX2lkKTsNCj4gKw0KPiArCWlmICh1bmxpa2VseShl
LT50eXBlICE9IEtWTV9JUlFfUk9VVElOR19NU0kpKQ0KPiArCQlyZXR1cm4gLUVXT1VMREJMT0NL
Ow0KPiArDQo+ICsJcmV0ID0ga3ZtX3NldF9tc2koZSwga3ZtLCBpcnFfc291cmNlX2lkLCBsZXZl
bCwgbGluZV9zdGF0dXMpOw0KDQpUaGUgaW1wbGVtZW50YXRpb24gb2bCoGt2bV9zZXRfbXNpIGlz
IG5vdCBhdG9taWMuIFRoZXJlIGlzIGEgbXV0ZXggaGVsZCBpbiBvbmUNCm9mIHRoZSBleGVjdXRp
b24gcGF0aHMuIFRoYXQgaXMgd2h5IGl0IGNhbiBub3QgYmUgdXNlZCBkaXJlY3RseSBpbiB0aGlz
IGF0b21pY8KgDQpjb250ZXh0Lg0KDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgaW50
IGt2bV92Z2ljX3NldHVwX2RlZmF1bHRfaXJxX3JvdXRpbmcoc3RydWN0IGt2bSAqa3ZtKQ0KPiAg
ew0KPiAgCXN0cnVjdCBrdm1faXJxX3JvdXRpbmdfZW50cnkgKmVudHJpZXM7DQoKCgpBbWF6b24g
RGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJs
aW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IENocmlzdGlhbiBTY2hsYWVnZXIsIFJhbGYgSGVyYnJpY2gK
VXN0LUlEOiBERSAyODkgMjM3IDg3OQpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90
dGVuYnVyZyBIUkIgMTQ5MTczIEIKCg==

