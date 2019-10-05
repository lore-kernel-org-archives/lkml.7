Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F203AC4360C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 02:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60D7222BE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 02:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Cybi0cU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfJECLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 22:11:01 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:51677 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfJECLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 22:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570241459; x=1601777459;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=zrvR2JTZ+Ln78IRzoO+VVFXXk4+VB5nYEPpbM4aFRU8=;
  b=Cybi0cU8R+yUlBMshjh+p4aEwO5IskYcKgXp7b/fmkKdFv5hULAMNqzh
   7Ty1L1WulFCc5TLa9M+orTVwATXlD1Tx/2wSkviV8MKGaX6watHI166DC
   lR/B9xQqZTWNz4uEQMwQuB5tMevl6FLZFb8/K4WbL36cGfAsX6AsaUBul
   k=;
X-IronPort-AV: E=Sophos;i="5.67,258,1566864000"; 
   d="scan'208";a="839393317"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Oct 2019 02:07:49 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 6AAB2A23B3;
        Sat,  5 Oct 2019 02:07:21 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sat, 5 Oct 2019 02:07:20 +0000
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sat, 5 Oct 2019 02:07:20 +0000
Received: from EX13D01UWB003.ant.amazon.com ([10.43.161.94]) by
 EX13d01UWB003.ant.amazon.com ([10.43.161.94]) with mapi id 15.00.1367.000;
 Sat, 5 Oct 2019 02:07:20 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "tyaramer@gmail.com" <tyaramer@gmail.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: Shutdown when removing dead controller
Thread-Topic: [PATCH] nvme-pci: Shutdown when removing dead controller
Thread-Index: AQHVeyGeGhwUwA6X9kWpqedn8pc+zg==
Date:   Sat, 5 Oct 2019 02:07:19 +0000
Message-ID: <e0edf48eb84fe038c2912328b28e931900684de2.camel@amazon.com>
References: <20191003191354.GA4481@Serenity>
         <CAKcoMVC2LdcmUx6j5JzuT-TsFGz=mwQ0MsprrKR2qeXoTmQ-TQ@mail.gmail.com>
In-Reply-To: <CAKcoMVC2LdcmUx6j5JzuT-TsFGz=mwQ0MsprrKR2qeXoTmQ-TQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.228]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B991183222A3AC43AEEFB59E60CD63E2@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTEwLTA0IGF0IDExOjM2IC0wNDAwLCBUeWxlciBSYW1lciB3cm90ZToNCj4g
SGVyZSdzIGEgZmFpbHVyZSB3ZSBoYWQgd2hpY2ggcmVwcmVzZW50cyB0aGUgaXNzdWUgdGhlIHBh
dGNoIGlzDQo+IGludGVuZGVkIHRvIHNvbHZlOg0KPiANCj4gQXVnIDI2IDE1OjAwOjU2IHRlc3Ro
b3N0IGtlcm5lbDogbnZtZSBudm1lNDogYXN5bmMgZXZlbnQgcmVzdWx0IDAwMDEwMzAwDQo+IEF1
ZyAyNiAxNTowMToyNyB0ZXN0aG9zdCBrZXJuZWw6IG52bWUgbnZtZTQ6IGNvbnRyb2xsZXIgaXMg
ZG93bjsgd2lsbA0KPiByZXNldDogQ1NUUz0weDMsIFBDSV9TVEFUVVM9MHgxMA0KPiBBdWcgMjYg
MTU6MDI6MTAgdGVzdGhvc3Qga2VybmVsOiBudm1lIG52bWU0OiBEZXZpY2Ugbm90IHJlYWR5OyBh
Ym9ydGluZw0KPiByZXNldA0KPiBBdWcgMjYgMTU6MDI6MTAgdGVzdGhvc3Qga2VybmVsOiBudm1l
IG52bWU0OiBSZW1vdmluZyBhZnRlciBwcm9iZQ0KPiBmYWlsdXJlIHN0YXR1czogLTE5DQo+IA0K
PiBUaGUgQ1NUUyB3YXJuaW5ncyBjb21lcyBmcm9tIG52bWVfdGltZW91dCwgYW5kIGlzIHByaW50
ZWQgYnkNCj4gbnZtZV93YXJuX3Jlc2V0LiBBIHJlc2V0IHRoZW4gb2NjdXJzDQo+IENvbnRyb2xs
ZXIgc3RhdGUgc2hvdWxkIGJlIE5WTUVfQ1RSTF9SRVNFVFRJTkcNCj4gDQo+IE5vdywgaW4gbnZt
ZV9yZXNldF93b3JrLCBjb250cm9sbGVyIGlzIG5ldmVyIG1hcmtlZCAiQ09OTkVDVElORyIgIGF0
Og0KPiANCj4gICAgICBpZiAoIW52bWVfY2hhbmdlX2N0cmxfc3RhdGUoJmRldi0+Y3RybCwgTlZN
RV9DVFJMX0NPTk5FQ1RJTkcpKQ0KPiANCj4gYmVjYXVzZSBzZXZlcmFsIGxpbmVzIGFib3ZlLCB3
ZSBjYW4gZGV0ZXJtaW5lIHRoYXQNCj4gbnZtZV9wY2lfY29uZmlndXJlX2FkbWluX3F1ZXVlcyBy
ZXR1cm5zDQo+IGEgYmFkIHJlc3VsdCwgd2hpY2ggdHJpZ2dlcnMgYSBnb3RvIG91dF91bmxvY2sg
YW5kIHByaW50cyAicmVtb3ZpbmcNCj4gYWZ0ZXIgcHJvYmUgZmFpbHVyZSBzdGF0dXM6IC0xOSIN
Cj4gDQo+IEJlY2F1c2Ugc3RhdGUgaXMgbmV2ZXIgY2hhbmdlZCB0byBOVk1FX0NUUkxfQ09OTkVD
VElORyBvcg0KPiBOVk1FX0NUUkxfREVMRVRJTkcsIHRoZQ0KPiBsb2dpYyBhZGRlZCBpbiANCj4g
aHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2NvbW1pdC8yMDM2ZjcyNjNkNzBlNjdk
NzBhNjc4OTlhNDY4NTg4Y2I3MzU2YmM5DQo+IHNob3VsZCBub3QgYXBwbHkuIFdlIGNhbiBmdXJ0
aGVyIHZhbGlkYXRlIHRoYXQgZGV2LT5jdHJsLnN0YXRlID09DQo+IE5WTUVfQ1RSTF9SRVNFVFRJ
TkcgdGhhbmtzIHRvDQo+IHRoZSBXQVJOX09OIGluIG52bWVfcmVzZXRfd29yay4NCj4gDQo+IA0K
PiANCj4gDQo+IA0KPiANCj4gT24gVGh1LCBPY3QgMywgMjAxOSBhdCAzOjEzIFBNIFR5bGVyIFJh
bWVyIDx0eWFyYW1lckBnbWFpbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEFsd2F5cyBzaHV0ZG93
biB0aGUgY29udHJvbGxlciB3aGVuIG52bWVfcmVtb3ZlX2RlYWRfY29udHJvbGxlciBpcw0KPiA+
IHJlYWNoZWQuDQo+ID4gDQo+ID4gSXQncyBwb3NzaWJsZSBmb3IgbnZtZV9yZW1vdmVfZGVhZF9j
b250cm9sbGVyIHRvIGJlIGNhbGxlZCBhcyBwYXJ0IG9mIGENCj4gPiBmYWlsZWQgcmVzZXQsIHdo
ZW4gdGhlcmUgaXMgYSBiYWQgTlZNRV9DU1RTLiBUaGUgY29udHJvbGxlciB3b24ndA0KPiA+IGJl
IGNvbW1pbmcgYmFjayBvbmxpbmUsIHNvIHdlIHNob3VsZCBzaHV0IGl0IGRvd24gcmF0aGVyIHRo
YW4ganVzdA0KPiA+IGRpc2FibGluZy4NCj4gPiANCg0KV2hhdCBpcyB0aGUgYmFkIENTVFMgYml0
PyBDU1RTLlJEWT8gVGhlIGVudGlyZSByZXNldC9kaXNhYmxlIHJhY2UgaXMgcXVpdGUNCnRyaWNr
eSBpbiBnZW5lcmFsLCBpdCB3YXMgbWFkZSBiZXR0ZXIgd2l0aCB0aGUgc2h1dGRvd25fbG9jaywg
YnV0IGlmIHRoZQ0KdGltZW91dCB2YWx1ZSBpcyBzbWFsbCwgc2V2ZXJhbCBvZiB0aGVtIGNhbiBv
Y2N1ciBpbiB0aGUgbWlkZGxlIG9mIGEgcmVzZXQuDQoNCkZvciB0aGlzIHBhdGNoDQoNCkFja2Vk
LWJ5OiBCYWxiaXIgU2luZ2ggPHNibGJpckBhbXpuLmNvbT4NCg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFR5bGVyIFJhbWVyIDx0eWFyYW1lckBnbWFpbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
bnZtZS9ob3N0L3BjaS5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hv
c3QvcGNpLmMgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KPiA+IGluZGV4IGMwODA4ZjllYjhh
Yi4uYzNmNWJhMjJjNjI1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5j
DQo+ID4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMNCj4gPiBAQCAtMjUwOSw3ICsyNTA5
LDcgQEAgc3RhdGljIHZvaWQgbnZtZV9wY2lfZnJlZV9jdHJsKHN0cnVjdCBudm1lX2N0cmwNCj4g
PiAqY3RybCkNCj4gPiAgc3RhdGljIHZvaWQgbnZtZV9yZW1vdmVfZGVhZF9jdHJsKHN0cnVjdCBu
dm1lX2RldiAqZGV2KQ0KPiA+ICB7DQo+ID4gICAgICAgICBudm1lX2dldF9jdHJsKCZkZXYtPmN0
cmwpOw0KPiA+IC0gICAgICAgbnZtZV9kZXZfZGlzYWJsZShkZXYsIGZhbHNlKTsNCj4gPiArICAg
ICAgIG52bWVfZGV2X2Rpc2FibGUoZGV2LCB0cnVlKTsNCg0KDQoNCg0KPiA+ICAgICAgICAgbnZt
ZV9raWxsX3F1ZXVlcygmZGV2LT5jdHJsKTsNCj4gPiAgICAgICAgIGlmICghcXVldWVfd29yayhu
dm1lX3dxLCAmZGV2LT5yZW1vdmVfd29yaykpDQo+ID4gICAgICAgICAgICAgICAgIG52bWVfcHV0
X2N0cmwoJmRldi0+Y3RybCk7DQo+ID4gLS0NCj4gPiAyLjIzLjANCj4gPiANCj4gDQo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4LW52bWUg
bWFpbGluZyBsaXN0DQo+IExpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUNCg==
