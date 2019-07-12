Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F42C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 02:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194E220863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 02:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="GgC1fvic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfGLC61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 22:58:27 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:10495 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbfGLC61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 22:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1562900304; x=1594436304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=iCD4e8hPuxHCnv157GFsiS4zayQ1yJlQokpYLe+tSbM=;
  b=GgC1fvicxqfn7Oxjs4j2ZlcrUItM01zn1aOrTLFDYnR7OxNrwauVPeaK
   YKjfb515LDIQ3Upv+laT0gJZ6kypEcTDftAvTRY+xio79NESWrqgPwa5+
   yVG1xYqThe1Q66h0oDN4eaj9x/6xnApDs6Y/jMO/HS8TY+eFbvoeQGqiP
   U=;
X-IronPort-AV: E=Sophos;i="5.62,480,1554768000"; 
   d="scan'208";a="774254445"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 12 Jul 2019 02:58:22 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id BB1CBA2837;
        Fri, 12 Jul 2019 02:58:20 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 12 Jul 2019 02:58:20 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 12 Jul 2019 02:58:19 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Fri, 12 Jul 2019 02:58:19 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>
CC:     "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "info@metux.net" <info@metux.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "anders.roxell@linaro.org" <anders.roxell@linaro.org>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH] arm: Extend the check for RAM in /dev/mem
Thread-Topic: [PATCH] arm: Extend the check for RAM in /dev/mem
Thread-Index: AQHVODcIGfDHKrKqiE2jyO8cjDhCoqbGRNqAgAAGCAA=
Date:   Fri, 12 Jul 2019 02:58:18 +0000
Message-ID: <1562900298.1345.12.camel@amazon.de>
References: <1562883681-18659-1-git-send-email-karahmed@amazon.de>
         <14f02e29-77b2-29d9-a9f4-7f89ad0194f6@arm.com>
In-Reply-To: <14f02e29-77b2-29d9-a9f4-7f89ad0194f6@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.98]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC9E4E50AFB62A48A1902AC30C85C401@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA3LTEyIGF0IDA4OjA2ICswNTMwLCBBbnNodW1hbiBLaGFuZHVhbCB3cm90
ZToNCj4gDQo+IE9uIDA3LzEyLzIwMTkgMDM6NTEgQU0sIEthcmltQWxsYWggQWhtZWQgd3JvdGU6
DQo+ID4gDQo+ID4gU29tZSB2YWxpZCBSQU0gY2FuIGxpdmUgb3V0c2lkZSBrZXJuZWwgY29udHJv
bCAoZS5nLiB1c2luZyBtZW09IGtlcm5lbA0KPiA+IGNvbW1hbmQtbGluZSkuIEZvciB0aGVzZSBy
ZWdpb25zLCBwZm5fdmFsaWQgd291bGQgcmV0dXJuICJmYWxzZSIgY2F1c2luZw0KPiA+IHN5c3Rl
bSBSQU0gdG8gYmUgbWFwcGVkIGFzIHVuY2FjaGVkLiBVc2UgbWVtYmxvY2sgaW5zdGVhZCB0byBp
ZGVudGlmeSBSQU0uDQo+IA0KPiBPbmNlIHRoZSByZW1haW5pbmcgbWVtb3J5IGlzIG91dHNpZGUg
b2YgdGhlIGtlcm5lbCAoYXMgdGhlIGFkbWluIHdvdWxkIGhhdmUNCj4gaW50ZW5kZWQgd2l0aCBt
ZW09IGNvbW1hbmQgbGluZSkgd2hhdCBpcyB0aGUgcGFydGljdWxhciBjb25jZXJuIHJlZ2FyZGlu
Zw0KPiB0aGUgd2F5IHRob3NlIGdldCBtYXBwZWQgKGNhY2hlZCBvciBub3QpID8gSXQgaXMgbm90
IHRvIGJlIHVzZWQgYW55IHdheS4NCg0KVGhleSBjYW4gYmUgdXNlZCBieSB1c2VyLXNwYWNlIHdo
aWNoIG1pZ2h0IGxlYWQgdG8gdGhlbSBiZWluZyB1c2VkIGJ5IHRoZcKgDQprZXJuZWwuIE9uZSB1
c2UtY2FzZSB3b3VsZCBiZSB1c2luZyB0aGVtIGFzIGd1ZXN0IG1lbW9yeSBmb3IgS1ZNIGFzIEkg
ZGV0YWlsZWTCoA0KaGVyZToNCg0KaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzc3ODI0MC8NCg0K
PiANCj4gPiANCj4gPiANCj4gPiBDYzogUnVzc2VsbCBLaW5nIDxsaW51eEBhcm1saW51eC5vcmcu
dWs+DQo+ID4gQ2M6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+
ID4gQ2M6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IE1pa2UgUmFwb3Bv
cnQgPHJwcHRAbGludXguaWJtLmNvbT4NCj4gPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51
eC1mb3VuZGF0aW9uLm9yZz4NCj4gPiBDYzogQW5kZXJzIFJveGVsbCA8YW5kZXJzLnJveGVsbEBs
aW5hcm8ub3JnPg0KPiA+IENjOiBFbnJpY28gV2VpZ2VsdCA8aW5mb0BtZXR1eC5uZXQ+DQo+ID4g
Q2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiA+IENjOiBLYXJpbUFs
bGFoIEFobWVkIDxrYXJhaG1lZEBhbWF6b24uZGU+DQo+ID4gQ2M6IE1hcmsgUnV0bGFuZCA8bWFy
ay5ydXRsYW5kQGFybS5jb20+DQo+ID4gQ2M6IEphbWVzIE1vcnNlIDxqYW1lcy5tb3JzZUBhcm0u
Y29tPg0KPiA+IENjOiBBbnNodW1hbiBLaGFuZHVhbCA8YW5zaHVtYW4ua2hhbmR1YWxAYXJtLmNv
bT4NCj4gPiBDYzogSnVuIFlhbyA8eWFvanVuODU1ODM2M0BnbWFpbC5jb20+DQo+ID4gQ2M6IFl1
IFpoYW8gPHl1emhhb0Bnb29nbGUuY29tPg0KPiA+IENjOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11
cnBoeUBhcm0uY29tPg0KPiA+IENjOiBBcmQgQmllc2hldXZlbCA8YXJkLmJpZXNoZXV2ZWxAbGlu
YXJvLm9yZz4NCj4gPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+
ID4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBL
YXJpbUFsbGFoIEFobWVkIDxrYXJhaG1lZEBhbWF6b24uZGU+DQo+ID4gLS0tDQo+ID4gIGFyY2gv
YXJtL21tL21tdS5jICAgfCAyICstDQo+ID4gIGFyY2gvYXJtNjQvbW0vbW11LmMgfCAyICstDQo+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tbS9tbXUuYyBiL2FyY2gvYXJtL21tL21tdS5j
DQo+ID4gaW5kZXggMWFhMjU4Ni4uNDkyNzc0YiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9t
bS9tbXUuYw0KPiA+ICsrKyBiL2FyY2gvYXJtL21tL21tdS5jDQo+ID4gQEAgLTcwNSw3ICs3MDUs
NyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgYnVpbGRfbWVtX3R5cGVfdGFibGUodm9pZCkNCj4gPiAg
cGdwcm90X3QgcGh5c19tZW1fYWNjZXNzX3Byb3Qoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVk
IGxvbmcgcGZuLA0KPiA+ICAJCQkgICAgICB1bnNpZ25lZCBsb25nIHNpemUsIHBncHJvdF90IHZt
YV9wcm90KQ0KPiA+ICB7DQo+ID4gLQlpZiAoIXBmbl92YWxpZChwZm4pKQ0KPiA+ICsJaWYgKCFt
ZW1ibG9ja19pc19tZW1vcnkoX19wZm5fdG9fcGh5cyhwZm4pKSkNCj4gPiAgCQlyZXR1cm4gcGdw
cm90X25vbmNhY2hlZCh2bWFfcHJvdCk7DQo+ID4gIAllbHNlIGlmIChmaWxlLT5mX2ZsYWdzICYg
T19TWU5DKQ0KPiA+ICAJCXJldHVybiBwZ3Byb3Rfd3JpdGVjb21iaW5lKHZtYV9wcm90KTsNCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9tbXUuYyBiL2FyY2gvYXJtNjQvbW0vbW11LmMN
Cj4gPiBpbmRleCAzNjQ1ZjI5Li5jZGMzZThlIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQv
bW0vbW11LmMNCj4gPiArKysgYi9hcmNoL2FybTY0L21tL21tdS5jDQo+ID4gQEAgLTc4LDcgKzc4
LDcgQEAgdm9pZCBzZXRfc3dhcHBlcl9wZ2QocGdkX3QgKnBnZHAsIHBnZF90IHBnZCkNCj4gPiAg
cGdwcm90X3QgcGh5c19tZW1fYWNjZXNzX3Byb3Qoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVk
IGxvbmcgcGZuLA0KPiA+ICAJCQkgICAgICB1bnNpZ25lZCBsb25nIHNpemUsIHBncHJvdF90IHZt
YV9wcm90KQ0KPiA+ICB7DQo+ID4gLQlpZiAoIXBmbl92YWxpZChwZm4pKQ0KPiA+ICsJaWYgKCFt
ZW1ibG9ja19pc19tZW1vcnkoX19wZm5fdG9fcGh5cyhwZm4pKSkNCj4gDQo+IHBmbl92YWxpZCgp
IG9uIGFybTY0IGNoZWNrcyBpZiB0aGUgbWVtYmxvY2sgcmVnaW9uIGlzIG1hcHBlZCBpLmUgZG9l
cyBpdCBoYXZlDQo+IGEgbGluZWFyIG1hcHBpbmcgb3Igbm90LiBJZiBhIHNlZ21lbnQgb2YgUkFN
IGlzIG91dHNpZGUgbGluZWFyIG1hcHBpbmcgZHVlIHRvDQo+IG1lbT0gZGlyZWN0aXZlIGFuZCBs
YWNrcyBhIGxpbmVhciBtYXBwaW5nIHRoZW4gd2h5IHNob3VsZCBpdCBiZSBtYXBwZWQgc2ltaWxh
cmx5DQo+IGxpa2Ugc3lzdGVtIFJBTSBvbiB0aGlzIHBhdGggPw0KDQpJIGFjdHVhbGx5IHN0cnVn
Z2xlZCBhIGJpdCBoZXJlIGJlY2F1c2UgdGhlcmUgaXMgcmVhbGx5IG5vICpleHBsaWNpdCrCoA0K
ZG9jdW1lbnRhdGlvbiBvZiB3aGF0IGlzIHRoZSBleHBlY3RlZCBiZWhhdmlvciBoZXJlLCBzbyBm
b3IgbWUgaXQgd2FzIG9wZW4gdG/CoA0KaW50ZXJwcmV0YXRpb24uDQoNCkl0IHNlZW1zIGxpa2Ug
Zm9yIHlvdSB0aGUgZGVjaWRpbmcgZmFjdG9yIGJldHdlZW4gY2FjaGVkIGFuZCB1bmNhY2hlZCBp
cyB0aGXCoA0KZXhpc3RlbmNlIG9mIGxpbmVhciBtYXBwaW5nLiBIb3dldmVyLCBmb3IgbWUgdGhl
IGRlY2lkaW5nIGZhY3RvciBpcyB3aGV0aGVyIGl0DQppcyBSQU0gb3Igbm90LiBJIGNob29zZSB0
aGlzIGludGVycHJldGF0aW9uIGJlY2F1c2UgaXQgaGVscHMgaW4gdGhlIEtWTQ0Kc2NlbmFyaW8g
dGhhdCBJIG1lbnRpb25lZCBhYm92ZSA6KQ0KDQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVy
IEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhy
dW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBSYWxmIEhlcmJyaWNoCkVpbmdldHJhZ2VuIGFtIEFt
dHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4K
VXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

