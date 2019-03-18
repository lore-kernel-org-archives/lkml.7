Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10716C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0802133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="MqKO26Kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfCRTQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:16:38 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:38323 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfCRTQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1552936595; x=1584472595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=kB1mX/6Gq68kyLeOq9pSvSJ1lTgAISxgTiUqIV33hBE=;
  b=MqKO26KjLSSbHT4yO5J7R/nTIANw/z8NpXp1Mhjt6AkGhasZJ2PNklFa
   Zqpp2VZsE/06ThG7XsVoftTUuMIV40N1hbL85SKptfYt09XmlxSUsmoQa
   4656aUldn96/qXkcYTTb1EhdfR04EQyxz1x1ywC8y/zbItnJI1+yPZYXy
   k=;
X-IronPort-AV: E=Sophos;i="5.58,494,1544486400"; 
   d="scan'208";a="789302189"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Mar 2019 19:16:33 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x2IJGTr4085965
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 18 Mar 2019 19:16:33 GMT
Received: from EX13D01EUB002.ant.amazon.com (10.43.166.113) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 18 Mar 2019 19:16:32 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB002.ant.amazon.com (10.43.166.113) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 18 Mar 2019 19:16:29 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Mon, 18 Mar 2019 19:16:28 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 00/14] KVM/X86: Introduce a new guest mapping interface
Thread-Topic: [PATCH v6 00/14] KVM/X86: Introduce a new guest mapping
 interface
Thread-Index: AQHUuaNMnLqWVoHh50O6cIKJ2z/ex6YRpJ4AgAAUJwCAAFIfgA==
Date:   Mon, 18 Mar 2019 19:16:28 +0000
Message-ID: <1552936587.8242.22.camel@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
         <1552914624.8242.1.camel@amazon.de>
         <20190318142232.GC16697@char.us.oracle.com>
In-Reply-To: <20190318142232.GC16697@char.us.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.38]
Content-Type: text/plain; charset="utf-8"
Content-ID: <57BF290C0DD7054A956F65C5300B83E7@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAzLTE4IGF0IDEwOjIyIC0wNDAwLCBLb25yYWQgUnplc3p1dGVrIFdpbGsg
d3JvdGU6DQo+IE9uIE1vbiwgTWFyIDE4LCAyMDE5IGF0IDAxOjEwOjI0UE0gKzAwMDAsIFJhc2xh
biwgS2FyaW1BbGxhaCB3cm90ZToNCj4gPiANCj4gPiBJIGd1ZXNzIHRoaXMgcGF0Y2ggc2VyaWVz
IG1pc3NlZCB0aGUgNS4xIG1lcmdlIHdpbmRvdz8gOikNCj4gDQo+IFdlcmUgdGhlcmUgYW55IG91
dHN0YW5kaW5nIGZpeGVzIHRoYXQgaGFkIHRvIGJlIGFkZHJlc3NlZD8NCg0KTm90IGFzIGZhciBh
cyBJIGNhbiByZW1lbWJlci4gVGhpcyB2ZXJzaW9uIGFkZHJlc3NlZCBhbGwgcmVxdWVzdHMgcmFp
c2VkIGluwqANCid2NScuDQoNCj4gDQo+ID4gDQo+ID4gDQo+ID4gT24gVGh1LCAyMDE5LTAxLTMx
IGF0IDIxOjI0ICswMTAwLCBLYXJpbUFsbGFoIEFobWVkIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBH
dWVzdCBtZW1vcnkgY2FuIGVpdGhlciBiZSBkaXJlY3RseSBtYW5hZ2VkIGJ5IHRoZSBrZXJuZWwg
KGkuZS4gaGF2ZSBhICJzdHJ1Y3QNCj4gPiA+IHBhZ2UiKSBvciB0aGV5IGNhbiBzaW1wbHkgbGl2
ZSBvdXRzaWRlIGtlcm5lbCBjb250cm9sIChpLmUuIGRvIG5vdCBoYXZlIGENCj4gPiA+ICJzdHJ1
Y3QgcGFnZSIpLiBLVk0gbW9zdGx5IHN1cHBvcnQgdGhlc2UgdHdvIG1vZGVzLCBleGNlcHQgaW4g
YSBmZXcgcGxhY2VzDQo+ID4gPiB3aGVyZSB0aGUgY29kZSBzZWVtcyB0byBhc3N1bWUgdGhhdCBn
dWVzdCBtZW1vcnkgbXVzdCBoYXZlIGEgInN0cnVjdCBwYWdlIi4NCj4gPiA+IA0KPiA+ID4gVGhp
cyBwYXRjaHNldCBpbnRyb2R1Y2VzIGEgbmV3IG1hcHBpbmcgaW50ZXJmYWNlIHRvIG1hcCBndWVz
dCBtZW1vcnkgaW50byBob3N0DQo+ID4gPiBrZXJuZWwgbWVtb3J5IHdoaWNoIGFsc28gc3VwcG9y
dHMgUEZOLWJhc2VkIG1lbW9yeSAoaS5lLiBtZW1vcnkgd2l0aG91dCAnc3RydWN0DQo+ID4gPiBw
YWdlJykuIEl0IGFsc28gY29udmVydHMgYWxsIG9mZmVuZGluZyBjb2RlIHRvIHRoaXMgaW50ZXJm
YWNlIG9yIHNpbXBseQ0KPiA+ID4gcmVhZC93cml0ZSBkaXJlY3RseSBmcm9tIGd1ZXN0IG1lbW9y
eS4gUGF0Y2ggMiBpcyBhZGRpdGlvbmFsbHkgZml4aW5nIGFuDQo+ID4gPiBpbmNvcnJlY3QgcGFn
ZSByZWxlYXNlIGFuZCBtYXJraW5nIHRoZSBwYWdlIGFzIGRpcnR5IChpLmUuIGFzIGEgc2lkZS1l
ZmZlY3Qgb2YNCj4gPiA+IHVzaW5nIHRoZSBoZWxwZXIgZnVuY3Rpb24gdG8gd3JpdGUpLg0KPiA+
ID4gDQo+ID4gPiBBcyBmYXIgYXMgSSBjYW4gc2VlIGFsbCBvZmZlbmRpbmcgY29kZSBpcyBub3cg
Zml4ZWQgZXhjZXB0IHRoZSBBUElDLWFjY2VzcyBwYWdlDQo+ID4gPiB3aGljaCBJIHdpbGwgaGFu
ZGxlIGluIGEgc2VwZXJhdGUgc2VyaWVzIGFsb25nIHdpdGggZHJvcHBpbmcNCj4gPiA+IGt2bV92
Y3B1X2dmbl90b19wYWdlIGFuZCBrdm1fdmNwdV9ncGFfdG9fcGFnZSBmcm9tIHRoZSBpbnRlcm5h
bCBLVk0gQVBJLg0KPiA+ID4gDQo+ID4gPiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBvZiB0
aGUgbmV3IEFQSSB1c2VzIG1lbXJlbWFwIHRvIG1hcCBtZW1vcnkgdGhhdCBkb2VzDQo+ID4gPiBu
b3QgaGF2ZSBhICJzdHJ1Y3QgcGFnZSIuIFRoaXMgcHJvdmVzIHRvIGJlIHZlcnkgc2xvdyBmb3Ig
aGlnaCBmcmVxdWVuY3kNCj4gPiA+IG1hcHBpbmdzLiBTaW5jZSB0aGlzIGRvZXMgbm90IGFmZmVj
dCB0aGUgbm9ybWFsIHVzZS1jYXNlIHdoZXJlIGEgInN0cnVjdCBwYWdlIg0KPiA+ID4gaXMgYXZh
aWxhYmxlLCB0aGUgcGVyZm9ybWFuY2Ugb2YgdGhpcyBBUEkgd2lsbCBiZSBoYW5kbGVkIGJ5IGEg
c2VwZXJhdGUgcGF0Y2gNCj4gPiA+IHNlcmllcy4NCj4gPiA+IA0KPiA+ID4gU28gdGhlIHNpbXBs
ZSB3YXkgdG8gdXNlIG1lbW9yeSBvdXRzaWRlIGtlcm5lbCBjb250cm9sIGlzOg0KPiA+ID4gDQo+
ID4gPiAxLSBQYXNzICdtZW09JyBpbiB0aGUga2VybmVsIGNvbW1hbmQtbGluZSB0byBsaW1pdCB0
aGUgYW1vdW50IG9mIG1lbW9yeSBtYW5hZ2VkIA0KPiA+ID4gICAgYnkgdGhlIGtlcm5lbC4NCj4g
PiA+IDItIE1hcCB0aGlzIHBoeXNpY2FsIG1lbW9yeSB5b3Ugd2FudCB0byBnaXZlIHRvIHRoZSBn
dWVzdCB3aXRoOg0KPiA+ID4gICAgbW1hcCgiL2Rldi9tZW0iLCBwaHlzaWNhbF9hZGRyZXNzX29m
ZnNldCwgLi4pDQo+ID4gPiAzLSBVc2UgdGhlIHVzZXItc3BhY2UgdmlydHVhbCBhZGRyZXNzIGFz
IHRoZSAidXNlcnNwYWNlX2FkZHIiIGZpZWxkIGluDQo+ID4gPiAgICBLVk1fU0VUX1VTRVJfTUVN
T1JZX1JFR0lPTiBpb2N0bC4NCj4gPiA+IA0KPiA+ID4gdjUgLT4gdjY6DQo+ID4gPiAtIEFkZGVk
IG9uZSBleHRyYSBwYXRjaCB0byBlbnN1cmUgdGhhdCBzdXBwb3J0IGZvciB0aGlzIG1lbT0gY2Fz
ZSBpcyBjb21wbGV0ZQ0KPiA+ID4gICBmb3IgeDg2Lg0KPiA+ID4gLSBBZGRlZCBhIGhlbHBlciBm
dW5jdGlvbiB0byBjaGVjayBpZiB0aGUgbWFwcGluZyBpcyBtYXBwZWQgb3Igbm90Lg0KPiA+ID4g
LSBBZGRlZCBtb3JlIGNvbW1lbnRzIG9uIHRoZSBzdHJ1Y3QuDQo+ID4gPiAtIFNldHRpbmcgLT5w
YWdlIHRvIE5VTEwgb24gdW5tYXAgYW5kIHRvIGEgcG9pc29uIHB0ciBpZiB1bnVzZWQgZHVyaW5n
IG1hcA0KPiA+ID4gLSBDaGVja2luZyBmb3IgbWFwIHB0ciBiZWZvcmUgdXNpbmcgaXQuDQo+ID4g
PiAtIENoYW5nZSBrdm1fdmNwdV91bm1hcCB0byBhbHNvIG1hcmsgcGFnZSBkaXJ0eSBmb3IgTE0u
IFRoYXQgcmVxdWlyZXMNCj4gPiA+ICAgcGFzc2luZyB0aGUgdkNQVSBwb2ludGVyIGFnYWluIHRv
IHRoaXMgZnVuY3Rpb24uDQo+ID4gPiANCj4gPiA+IHY0IC0+IHY1Og0KPiA+ID4gLSBJbnRyb2R1
Y2UgYSBuZXcgcGFyYW1ldGVyICdkaXJ0eScgaW50byBrdm1fdmNwdV91bm1hcA0KPiA+ID4gLSBB
IGhvcnJpYmxlIHJlYmFzZSBkdWUgdG8gbmVzdGVkLmMgOikNCj4gPiA+IC0gRHJvcHBlZCBhIGNv
dXBsZSBvZiBoeXBlcnYgcGF0Y2hlcyBhcyB0aGUgY29kZSB3YXMgZml4ZWQgYWxyZWFkeSBhcyBh
DQo+ID4gPiAgIHNpZGUtZWZmZWN0IG9mIGFub3RoZXIgcGF0Y2guDQo+ID4gPiAtIEFkZGVkIGEg
bmV3IHRyaXZpYWwgY2xlYW51cCBwYXRjaC4NCj4gPiA+IA0KPiA+ID4gdjMgLT4gdjQ6DQo+ID4g
PiAtIFJlYmFzZQ0KPiA+ID4gLSBBZGQgYSBuZXcgcGF0Y2ggdG8gYWxzbyBmaXggdGhlIG5ld2x5
IGludHJvZHVjZWQgZW5saWdodG5lZCBWTUNTLg0KPiA+ID4gDQo+ID4gPiB2MiAtPiB2MzoNCj4g
PiA+IC0gUmViYXNlDQo+ID4gPiAtIEFkZCBhIG5ldyBwYXRjaCB0byBhbHNvIGZpeCB0aGUgbmV3
bHkgaW50cm9kdWNlZCBzaGFkb3cgVk1DUy4NCj4gPiA+IA0KPiA+ID4gRmlsaXBwbyBTaXJvbmkg
KDEpOg0KPiA+ID4gICBYODYvS1ZNOiBIYW5kbGUgUEZOcyBvdXRzaWRlIG9mIGtlcm5lbCByZWFj
aCB3aGVuIHRvdWNoaW5nIEdQVEVzDQo+ID4gPiANCj4gPiA+IEthcmltQWxsYWggQWhtZWQgKDEz
KToNCj4gPiA+ICAgWDg2L25WTVg6IGhhbmRsZV92bW9uOiBSZWFkIDQgYnl0ZXMgZnJvbSBndWVz
dCBtZW1vcnkNCj4gPiA+ICAgWDg2L25WTVg6IFVwZGF0ZSB0aGUgUE1MIHRhYmxlIHdpdGhvdXQg
bWFwcGluZyBhbmQgdW5tYXBwaW5nIHRoZSBwYWdlDQo+ID4gPiAgIEtWTTogSW50cm9kdWNlIGEg
bmV3IGd1ZXN0IG1hcHBpbmcgQVBJDQo+ID4gPiAgIFg4Ni9uVk1YOiBoYW5kbGVfdm1wdHJsZDog
VXNlIGt2bV92Y3B1X21hcCB3aGVuIGNvcHlpbmcgVk1DUzEyIGZyb20NCj4gPiA+ICAgICBndWVz
dCBtZW1vcnkNCj4gPiA+ICAgS1ZNL25WTVg6IFVzZSBrdm1fdmNwdV9tYXAgd2hlbiBtYXBwaW5n
IHRoZSBMMSBNU1IgYml0bWFwDQo+ID4gPiAgIEtWTS9uVk1YOiBVc2Uga3ZtX3ZjcHVfbWFwIHdo
ZW4gbWFwcGluZyB0aGUgdmlydHVhbCBBUElDIHBhZ2UNCj4gPiA+ICAgS1ZNL25WTVg6IFVzZSBr
dm1fdmNwdV9tYXAgd2hlbiBtYXBwaW5nIHRoZSBwb3N0ZWQgaW50ZXJydXB0DQo+ID4gPiAgICAg
ZGVzY3JpcHRvciB0YWJsZQ0KPiA+ID4gICBLVk0vWDg2OiBVc2Uga3ZtX3ZjcHVfbWFwIGluIGVt
dWxhdG9yX2NtcHhjaGdfZW11bGF0ZWQNCj4gPiA+ICAgS1ZNL25TVk06IFVzZSB0aGUgbmV3IG1h
cHBpbmcgQVBJIGZvciBtYXBwaW5nIGd1ZXN0IG1lbW9yeQ0KPiA+ID4gICBLVk0vblZNWDogVXNl
IGt2bV92Y3B1X21hcCBmb3IgYWNjZXNzaW5nIHRoZSBzaGFkb3cgVk1DUw0KPiA+ID4gICBLVk0v
blZNWDogVXNlIGt2bV92Y3B1X21hcCBmb3IgYWNjZXNzaW5nIHRoZSBlbmxpZ2h0ZW5lZCBWTUNT
DQo+ID4gPiAgIEtWTS9uVk1YOiBVc2UgcGFnZV9hZGRyZXNzX3ZhbGlkIGluIGEgZmV3IG1vcmUg
bG9jYXRpb25zDQo+ID4gPiAgIGt2bSwgeDg2OiBQcm9wZXJseSBjaGVjayB3aGV0aGVyIGEgcGZu
IGlzIGFuIE1NSU8gb3Igbm90DQo+ID4gPiANCj4gPiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9l
ODIwL2FwaS5oIHwgICAxICsNCj4gPiA+ICBhcmNoL3g4Ni9rZXJuZWwvZTgyMC5jICAgICAgICAg
IHwgIDE4ICsrKystDQo+ID4gPiAgYXJjaC94ODYva3ZtL21tdS5jICAgICAgICAgICAgICB8ICAg
NSArLQ0KPiA+ID4gIGFyY2gveDg2L2t2bS9wYWdpbmdfdG1wbC5oICAgICAgfCAgMzggKysrKysr
Ky0tLQ0KPiA+ID4gIGFyY2gveDg2L2t2bS9zdm0uYyAgICAgICAgICAgICAgfCAgOTcgKysrKysr
KysrKysrLS0tLS0tLS0tLS0tDQo+ID4gPiAgYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYyAgICAg
ICB8IDE2MCArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAg
YXJjaC94ODYva3ZtL3ZteC92bXguYyAgICAgICAgICB8ICAxOSArKy0tLQ0KPiA+ID4gIGFyY2gv
eDg2L2t2bS92bXgvdm14LmggICAgICAgICAgfCAgIDkgKystDQo+ID4gPiAgYXJjaC94ODYva3Zt
L3g4Ni5jICAgICAgICAgICAgICB8ICAxNCArKy0tDQo+ID4gPiAgaW5jbHVkZS9saW51eC9rdm1f
aG9zdC5oICAgICAgICB8ICAyOCArKysrKysrDQo+ID4gPiAgdmlydC9rdm0va3ZtX21haW4uYyAg
ICAgICAgICAgICB8ICA2NCArKysrKysrKysrKysrKysrDQo+ID4gPiAgMTEgZmlsZXMgY2hhbmdl
ZCwgMjY3IGluc2VydGlvbnMoKyksIDE4NiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+IA0KPiA+
IA0KPiA+IA0KPiA+IEFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJIDQo+ID4g
S3JhdXNlbnN0ci4gMzgNCj4gPiAxMDExNyBCZXJsaW4NCj4gPiBHZXNjaGFlZnRzZnVlaHJlcjog
Q2hyaXN0aWFuIFNjaGxhZWdlciwgUmFsZiBIZXJicmljaA0KPiA+IFVzdC1JRDogREUgMjg5IDIz
NyA4NzkNCj4gPiBFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyBIUkIg
MTQ5MTczIEINCj4gPiANCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJI
CktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJlcjogQ2hyaXN0aWFu
IFNjaGxhZWdlciwgUmFsZiBIZXJicmljaApVc3QtSUQ6IERFIDI4OSAyMzcgODc5CkVpbmdldHJh
Z2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIEhSQiAxNDkxNzMgQgoK

