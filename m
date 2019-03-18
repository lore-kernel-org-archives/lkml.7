Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B43AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3E520850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="AZ8H/W1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfCRNKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:10:33 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:53733 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfCRNKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1552914630; x=1584450630;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding;
  bh=9HDGJnUQABYIdtmxNSLoq3p2ZXaPC3JysJzCyYxwu0M=;
  b=AZ8H/W1zq9HMjh5snhb/i8/oaEd2V6xnalFAE7iv5sMjl9eLfbyQqY4i
   W2w92W3xrRqghf+/Agbj83VEcbLLpAK/2gLCcv9mIIB2ORVOR3OAh5K4M
   3Uqh2pjJSsf/g5iUbrp/JAPMGBusiMndHzx4l9TZuCdacfdg1ZzqtG9yg
   M=;
IronPort-Data: A9a23:FUWKkaopHvW7BLEdRCzNhH1l6ZJeBgzWbkXrQCTDNTPst9OAQyUnAn
 AiqfojrTGpUPOfYHOFXcn8I5GBXTg4dztUW57fMT0ulpduahMQWY3NNomH3HgelFE5JTIJsM
 3Bqza+qABDWxyEQrlNjCSLA3cGMA21SXd57r8KHd2UI03vNy9uu0sH036ECxNLkHiIpBsw6N
 AdJXO0t+UC6buMaMysyASBlvBWLlGP7LvgyxRvo9Pv3vU6/q/GPyOikAliqLlDk8mI9gQjvr
 vXxNvpBXJkyeZArqjWGhOGtRQB68vKsaAjd9llbQHe9mjan6JId4zbNMaif1p3UPTRP4UnSH
 tzhBY/FRUJwroDR57k+Ak2rIEALb6oYOXBcniw3hPIlDLplxe/KGISdpS+uHqjrNRjFbepbX
 84wu8lctHAwZrU5RpyTZihFduxZ8CC4c7gI1a+iVDFHA0q9tR18nLqyTagOtY8f9iOZh2THo
 4rhJNDS874sKa4Vu21Zaa6cItvP0SPve01m6cYh46KW420hk/zlYeaPAH3xm4JgrVX9DwU2t
 Cqjowa/MfcStD5bXiDf979a7onIGjWf/bkRjwVHSu9qRnPfKe++2XjLXD0aQbgL0Lfn34Wp7
 4dIfMchZsoDKeNAAID2x0LB8szIW8mzjYsu1AmzmV3NHwBIUUEAZlkgjEbXhM13hy2XwjAOI
 tnCUUiBsDszBbqJ+Yk2JUZ7D78Xjs/ZTEAIO6FAQm23Jfdsd6OLFGQ19R8QjoJD82vh9Bm82
 ff1gfs3KQjJUFabIMHOjWZWZWlh7i3a69LjhO8WfpmU4ASDOY=
X-IronPort-AV: E=Sophos;i="5.58,493,1544486400"; 
   d="scan'208";a="722522852"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Mar 2019 13:10:27 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x2IDANZ0043742
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 18 Mar 2019 13:10:26 GMT
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 18 Mar 2019 13:10:26 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB003.ant.amazon.com (10.43.166.248) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 18 Mar 2019 13:10:25 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Mon, 18 Mar 2019 13:10:25 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 00/14] KVM/X86: Introduce a new guest mapping interface
Thread-Topic: [PATCH v6 00/14] KVM/X86: Introduce a new guest mapping
 interface
Thread-Index: AQHUuaNMnLqWVoHh50O6cIKJ2z/ex6YRpJ4A
Date:   Mon, 18 Mar 2019 13:10:24 +0000
Message-ID: <1552914624.8242.1.camel@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.210]
Content-Type: text/plain; charset="utf-8"
Content-ID: <523B7936ABDE9246BB5AD41332C965B1@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBndWVzcyB0aGlzIHBhdGNoIHNlcmllcyBtaXNzZWQgdGhlIDUuMSBtZXJnZSB3aW5kb3c/IDop
DQoNCk9uIFRodSwgMjAxOS0wMS0zMSBhdCAyMToyNCArMDEwMCwgS2FyaW1BbGxhaCBBaG1lZCB3
cm90ZToNCj4gR3Vlc3QgbWVtb3J5IGNhbiBlaXRoZXIgYmUgZGlyZWN0bHkgbWFuYWdlZCBieSB0
aGUga2VybmVsIChpLmUuIGhhdmUgYSAic3RydWN0DQo+IHBhZ2UiKSBvciB0aGV5IGNhbiBzaW1w
bHkgbGl2ZSBvdXRzaWRlIGtlcm5lbCBjb250cm9sIChpLmUuIGRvIG5vdCBoYXZlIGENCj4gInN0
cnVjdCBwYWdlIikuIEtWTSBtb3N0bHkgc3VwcG9ydCB0aGVzZSB0d28gbW9kZXMsIGV4Y2VwdCBp
biBhIGZldyBwbGFjZXMNCj4gd2hlcmUgdGhlIGNvZGUgc2VlbXMgdG8gYXNzdW1lIHRoYXQgZ3Vl
c3QgbWVtb3J5IG11c3QgaGF2ZSBhICJzdHJ1Y3QgcGFnZSIuDQo+IA0KPiBUaGlzIHBhdGNoc2V0
IGludHJvZHVjZXMgYSBuZXcgbWFwcGluZyBpbnRlcmZhY2UgdG8gbWFwIGd1ZXN0IG1lbW9yeSBp
bnRvIGhvc3QNCj4ga2VybmVsIG1lbW9yeSB3aGljaCBhbHNvIHN1cHBvcnRzIFBGTi1iYXNlZCBt
ZW1vcnkgKGkuZS4gbWVtb3J5IHdpdGhvdXQgJ3N0cnVjdA0KPiBwYWdlJykuIEl0IGFsc28gY29u
dmVydHMgYWxsIG9mZmVuZGluZyBjb2RlIHRvIHRoaXMgaW50ZXJmYWNlIG9yIHNpbXBseQ0KPiBy
ZWFkL3dyaXRlIGRpcmVjdGx5IGZyb20gZ3Vlc3QgbWVtb3J5LiBQYXRjaCAyIGlzIGFkZGl0aW9u
YWxseSBmaXhpbmcgYW4NCj4gaW5jb3JyZWN0IHBhZ2UgcmVsZWFzZSBhbmQgbWFya2luZyB0aGUg
cGFnZSBhcyBkaXJ0eSAoaS5lLiBhcyBhIHNpZGUtZWZmZWN0IG9mDQo+IHVzaW5nIHRoZSBoZWxw
ZXIgZnVuY3Rpb24gdG8gd3JpdGUpLg0KPiANCj4gQXMgZmFyIGFzIEkgY2FuIHNlZSBhbGwgb2Zm
ZW5kaW5nIGNvZGUgaXMgbm93IGZpeGVkIGV4Y2VwdCB0aGUgQVBJQy1hY2Nlc3MgcGFnZQ0KPiB3
aGljaCBJIHdpbGwgaGFuZGxlIGluIGEgc2VwZXJhdGUgc2VyaWVzIGFsb25nIHdpdGggZHJvcHBp
bmcNCj4ga3ZtX3ZjcHVfZ2ZuX3RvX3BhZ2UgYW5kIGt2bV92Y3B1X2dwYV90b19wYWdlIGZyb20g
dGhlIGludGVybmFsIEtWTSBBUEkuDQo+IA0KPiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBv
ZiB0aGUgbmV3IEFQSSB1c2VzIG1lbXJlbWFwIHRvIG1hcCBtZW1vcnkgdGhhdCBkb2VzDQo+IG5v
dCBoYXZlIGEgInN0cnVjdCBwYWdlIi4gVGhpcyBwcm92ZXMgdG8gYmUgdmVyeSBzbG93IGZvciBo
aWdoIGZyZXF1ZW5jeQ0KPiBtYXBwaW5ncy4gU2luY2UgdGhpcyBkb2VzIG5vdCBhZmZlY3QgdGhl
IG5vcm1hbCB1c2UtY2FzZSB3aGVyZSBhICJzdHJ1Y3QgcGFnZSINCj4gaXMgYXZhaWxhYmxlLCB0
aGUgcGVyZm9ybWFuY2Ugb2YgdGhpcyBBUEkgd2lsbCBiZSBoYW5kbGVkIGJ5IGEgc2VwZXJhdGUg
cGF0Y2gNCj4gc2VyaWVzLg0KPiANCj4gU28gdGhlIHNpbXBsZSB3YXkgdG8gdXNlIG1lbW9yeSBv
dXRzaWRlIGtlcm5lbCBjb250cm9sIGlzOg0KPiANCj4gMS0gUGFzcyAnbWVtPScgaW4gdGhlIGtl
cm5lbCBjb21tYW5kLWxpbmUgdG8gbGltaXQgdGhlIGFtb3VudCBvZiBtZW1vcnkgbWFuYWdlZCAN
Cj4gICAgYnkgdGhlIGtlcm5lbC4NCj4gMi0gTWFwIHRoaXMgcGh5c2ljYWwgbWVtb3J5IHlvdSB3
YW50IHRvIGdpdmUgdG8gdGhlIGd1ZXN0IHdpdGg6DQo+ICAgIG1tYXAoIi9kZXYvbWVtIiwgcGh5
c2ljYWxfYWRkcmVzc19vZmZzZXQsIC4uKQ0KPiAzLSBVc2UgdGhlIHVzZXItc3BhY2UgdmlydHVh
bCBhZGRyZXNzIGFzIHRoZSAidXNlcnNwYWNlX2FkZHIiIGZpZWxkIGluDQo+ICAgIEtWTV9TRVRf
VVNFUl9NRU1PUllfUkVHSU9OIGlvY3RsLg0KPiANCj4gdjUgLT4gdjY6DQo+IC0gQWRkZWQgb25l
IGV4dHJhIHBhdGNoIHRvIGVuc3VyZSB0aGF0IHN1cHBvcnQgZm9yIHRoaXMgbWVtPSBjYXNlIGlz
IGNvbXBsZXRlDQo+ICAgZm9yIHg4Ni4NCj4gLSBBZGRlZCBhIGhlbHBlciBmdW5jdGlvbiB0byBj
aGVjayBpZiB0aGUgbWFwcGluZyBpcyBtYXBwZWQgb3Igbm90Lg0KPiAtIEFkZGVkIG1vcmUgY29t
bWVudHMgb24gdGhlIHN0cnVjdC4NCj4gLSBTZXR0aW5nIC0+cGFnZSB0byBOVUxMIG9uIHVubWFw
IGFuZCB0byBhIHBvaXNvbiBwdHIgaWYgdW51c2VkIGR1cmluZyBtYXANCj4gLSBDaGVja2luZyBm
b3IgbWFwIHB0ciBiZWZvcmUgdXNpbmcgaXQuDQo+IC0gQ2hhbmdlIGt2bV92Y3B1X3VubWFwIHRv
IGFsc28gbWFyayBwYWdlIGRpcnR5IGZvciBMTS4gVGhhdCByZXF1aXJlcw0KPiAgIHBhc3Npbmcg
dGhlIHZDUFUgcG9pbnRlciBhZ2FpbiB0byB0aGlzIGZ1bmN0aW9uLg0KPiANCj4gdjQgLT4gdjU6
DQo+IC0gSW50cm9kdWNlIGEgbmV3IHBhcmFtZXRlciAnZGlydHknIGludG8ga3ZtX3ZjcHVfdW5t
YXANCj4gLSBBIGhvcnJpYmxlIHJlYmFzZSBkdWUgdG8gbmVzdGVkLmMgOikNCj4gLSBEcm9wcGVk
IGEgY291cGxlIG9mIGh5cGVydiBwYXRjaGVzIGFzIHRoZSBjb2RlIHdhcyBmaXhlZCBhbHJlYWR5
IGFzIGENCj4gICBzaWRlLWVmZmVjdCBvZiBhbm90aGVyIHBhdGNoLg0KPiAtIEFkZGVkIGEgbmV3
IHRyaXZpYWwgY2xlYW51cCBwYXRjaC4NCj4gDQo+IHYzIC0+IHY0Og0KPiAtIFJlYmFzZQ0KPiAt
IEFkZCBhIG5ldyBwYXRjaCB0byBhbHNvIGZpeCB0aGUgbmV3bHkgaW50cm9kdWNlZCBlbmxpZ2h0
bmVkIFZNQ1MuDQo+IA0KPiB2MiAtPiB2MzoNCj4gLSBSZWJhc2UNCj4gLSBBZGQgYSBuZXcgcGF0
Y2ggdG8gYWxzbyBmaXggdGhlIG5ld2x5IGludHJvZHVjZWQgc2hhZG93IFZNQ1MuDQo+IA0KPiBG
aWxpcHBvIFNpcm9uaSAoMSk6DQo+ICAgWDg2L0tWTTogSGFuZGxlIFBGTnMgb3V0c2lkZSBvZiBr
ZXJuZWwgcmVhY2ggd2hlbiB0b3VjaGluZyBHUFRFcw0KPiANCj4gS2FyaW1BbGxhaCBBaG1lZCAo
MTMpOg0KPiAgIFg4Ni9uVk1YOiBoYW5kbGVfdm1vbjogUmVhZCA0IGJ5dGVzIGZyb20gZ3Vlc3Qg
bWVtb3J5DQo+ICAgWDg2L25WTVg6IFVwZGF0ZSB0aGUgUE1MIHRhYmxlIHdpdGhvdXQgbWFwcGlu
ZyBhbmQgdW5tYXBwaW5nIHRoZSBwYWdlDQo+ICAgS1ZNOiBJbnRyb2R1Y2UgYSBuZXcgZ3Vlc3Qg
bWFwcGluZyBBUEkNCj4gICBYODYvblZNWDogaGFuZGxlX3ZtcHRybGQ6IFVzZSBrdm1fdmNwdV9t
YXAgd2hlbiBjb3B5aW5nIFZNQ1MxMiBmcm9tDQo+ICAgICBndWVzdCBtZW1vcnkNCj4gICBLVk0v
blZNWDogVXNlIGt2bV92Y3B1X21hcCB3aGVuIG1hcHBpbmcgdGhlIEwxIE1TUiBiaXRtYXANCj4g
ICBLVk0vblZNWDogVXNlIGt2bV92Y3B1X21hcCB3aGVuIG1hcHBpbmcgdGhlIHZpcnR1YWwgQVBJ
QyBwYWdlDQo+ICAgS1ZNL25WTVg6IFVzZSBrdm1fdmNwdV9tYXAgd2hlbiBtYXBwaW5nIHRoZSBw
b3N0ZWQgaW50ZXJydXB0DQo+ICAgICBkZXNjcmlwdG9yIHRhYmxlDQo+ICAgS1ZNL1g4NjogVXNl
IGt2bV92Y3B1X21hcCBpbiBlbXVsYXRvcl9jbXB4Y2hnX2VtdWxhdGVkDQo+ICAgS1ZNL25TVk06
IFVzZSB0aGUgbmV3IG1hcHBpbmcgQVBJIGZvciBtYXBwaW5nIGd1ZXN0IG1lbW9yeQ0KPiAgIEtW
TS9uVk1YOiBVc2Uga3ZtX3ZjcHVfbWFwIGZvciBhY2Nlc3NpbmcgdGhlIHNoYWRvdyBWTUNTDQo+
ICAgS1ZNL25WTVg6IFVzZSBrdm1fdmNwdV9tYXAgZm9yIGFjY2Vzc2luZyB0aGUgZW5saWdodGVu
ZWQgVk1DUw0KPiAgIEtWTS9uVk1YOiBVc2UgcGFnZV9hZGRyZXNzX3ZhbGlkIGluIGEgZmV3IG1v
cmUgbG9jYXRpb25zDQo+ICAga3ZtLCB4ODY6IFByb3Blcmx5IGNoZWNrIHdoZXRoZXIgYSBwZm4g
aXMgYW4gTU1JTyBvciBub3QNCj4gDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9lODIwL2FwaS5o
IHwgICAxICsNCj4gIGFyY2gveDg2L2tlcm5lbC9lODIwLmMgICAgICAgICAgfCAgMTggKysrKy0N
Cj4gIGFyY2gveDg2L2t2bS9tbXUuYyAgICAgICAgICAgICAgfCAgIDUgKy0NCj4gIGFyY2gveDg2
L2t2bS9wYWdpbmdfdG1wbC5oICAgICAgfCAgMzggKysrKysrKy0tLQ0KPiAgYXJjaC94ODYva3Zt
L3N2bS5jICAgICAgICAgICAgICB8ICA5NyArKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gIGFy
Y2gveDg2L2t2bS92bXgvbmVzdGVkLmMgICAgICAgfCAxNjAgKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgYXJjaC94ODYva3ZtL3ZteC92bXguYyAgICAgICAgICB8
ICAxOSArKy0tLQ0KPiAgYXJjaC94ODYva3ZtL3ZteC92bXguaCAgICAgICAgICB8ICAgOSArKy0N
Cj4gIGFyY2gveDg2L2t2bS94ODYuYyAgICAgICAgICAgICAgfCAgMTQgKystLQ0KPiAgaW5jbHVk
ZS9saW51eC9rdm1faG9zdC5oICAgICAgICB8ICAyOCArKysrKysrDQo+ICB2aXJ0L2t2bS9rdm1f
bWFpbi5jICAgICAgICAgICAgIHwgIDY0ICsrKysrKysrKysrKysrKysNCj4gIDExIGZpbGVzIGNo
YW5nZWQsIDI2NyBpbnNlcnRpb25zKCspLCAxODYgZGVsZXRpb25zKC0pDQo+IA0KCgoKQW1hem9u
IERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVy
bGluCkdlc2NoYWVmdHNmdWVocmVyOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBSYWxmIEhlcmJyaWNo
ClVzdC1JRDogREUgMjg5IDIzNyA4NzkKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgSFJCIDE0OTE3MyBCCgo=

