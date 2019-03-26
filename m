Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA677C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7759F2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbfCZRCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:02:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32915 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729440AbfCZRCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:02:38 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 9BC80AAA1A2CD47EC7FB;
        Tue, 26 Mar 2019 17:02:36 +0000 (GMT)
Received: from LHREML524-MBB.china.huawei.com ([169.254.3.25]) by
 LHREML711-CAH.china.huawei.com ([10.201.108.34]) with mapi id 14.03.0415.000;
 Tue, 26 Mar 2019 17:02:26 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "John Garry" <john.garry@huawei.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>
Subject: RE: [PATCH v7 2/4] perf/smmuv3: Add arm64 smmuv3 pmu driver
Thread-Topic: [PATCH v7 2/4] perf/smmuv3: Add arm64 smmuv3 pmu driver
Thread-Index: AQHU4+dvUJ3sjii9L0yKFZA+KetbbqYeIj4AgAAAe4A=
Date:   Tue, 26 Mar 2019 17:02:26 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8393296D1@lhreml524-mbb.china.huawei.com>
References: <20190326151753.19384-1-shameerali.kolothum.thodi@huawei.com>
 <20190326151753.19384-3-shameerali.kolothum.thodi@huawei.com>
 <fa89c332-d420-8fef-5034-518e60571bd9@arm.com>
In-Reply-To: <fa89c332-d420-8fef-5034-518e60571bd9@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4g
TXVycGh5IFttYWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDI2IE1hcmNoIDIw
MTkgMTY6NTgNCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29s
b3RodW0udGhvZGlAaHVhd2VpLmNvbT47DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20NCj4g
Q2M6IGFuZHJldy5tdXJyYXlAYXJtLmNvbTsgamVhbi1waGlsaXBwZS5icnVja2VyQGFybS5jb207
DQo+IHdpbGwuZGVhY29uQGFybS5jb207IG1hcmsucnV0bGFuZEBhcm0uY29tOyBHdW9oYW5qdW4g
KEhhbmp1biBHdW8pDQo+IDxndW9oYW5qdW5AaHVhd2VpLmNvbT47IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT47DQo+IHBhYmJhQGNvZGVhdXJvcmEub3JnOyB2a2lsYXJpQGNvZGVh
dXJvcmEub3JnOyBycnVpZ3Jva0Bjb2RlYXVyb3JhLm9yZzsNCj4gbGludXgtYWNwaUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+Ow0K
PiBuZWlsLm0ubGVlZGVyQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDIvNF0g
cGVyZi9zbW11djM6IEFkZCBhcm02NCBzbW11djMgcG11IGRyaXZlcg0KPiANCj4gSGkgU2hhbWVl
ciwNCj4gDQo+IE9uIDI2LzAzLzIwMTkgMTU6MTcsIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+
IFsuLi5dDQo+ID4gK3N0YXRpYyBpbnQgc21tdV9wbXVfYXBwbHlfZXZlbnRfZmlsdGVyKHN0cnVj
dCBzbW11X3BtdSAqc21tdV9wbXUsDQo+ID4gKwkJCQkgICAgICAgc3RydWN0IHBlcmZfZXZlbnQg
KmV2ZW50LCBpbnQgaWR4KQ0KPiA+ICt7DQo+ID4gKwl1MzIgc3Bhbiwgc2lkOw0KPiA+ICsJdW5z
aWduZWQgaW50IG51bV9jdHJzID0gc21tdV9wbXUtPm51bV9jb3VudGVyczsNCj4gPiArCWJvb2wg
ZmlsdGVyX2VuID0gISFnZXRfZmlsdGVyX2VuYWJsZShldmVudCk7DQo+ID4gKw0KPiA+ICsJc3Bh
biA9IGZpbHRlcl9lbiA/IGdldF9maWx0ZXJfc3BhbihldmVudCkgOg0KPiA+ICsJCQkgICBTTU1V
X1BNQ0dfREVGQVVMVF9GSUxURVJfU1BBTjsNCj4gPiArCXNpZCA9IGZpbHRlcl9lbiA/IGdldF9m
aWx0ZXJfc3RyZWFtX2lkKGV2ZW50KSA6DQo+ID4gKwkJCSAgIFNNTVVfUE1DR19ERUZBVUxUX0ZJ
TFRFUl9TSUQ7DQo+ID4gKw0KPiA+ICsJLyogU3VwcG9ydCBpbmRpdmlkdWFsIGZpbHRlciBzZXR0
aW5ncyAqLw0KPiA+ICsJaWYgKCFzbW11X3BtdS0+Z2xvYmFsX2ZpbHRlcikgew0KPiA+ICsJCXNt
bXVfcG11X3NldF9ldmVudF9maWx0ZXIoZXZlbnQsIGlkeCwgc3Bhbiwgc2lkKTsNCj4gPiArCQly
ZXR1cm4gMDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKiBSZXF1ZXN0ZWQgc2V0dGluZ3Mgc2Ft
ZSBhcyBjdXJyZW50IGdsb2JhbCBzZXR0aW5ncyovDQo+ID4gKwlpZiAoc3BhbiA9PSBzbW11X3Bt
dS0+Z2xvYmFsX2ZpbHRlcl9zcGFuICYmDQo+ID4gKwkgICAgc2lkID09IHNtbXVfcG11LT5nbG9i
YWxfZmlsdGVyX3NpZCkNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArDQo+ID4gKwlpZiAoIWJpdG1h
cF9lbXB0eShzbW11X3BtdS0+dXNlZF9jb3VudGVycywgbnVtX2N0cnMpKQ0KPiA+ICsJCXJldHVy
biAtRUFHQUlOOw0KPiA+ICsNCj4gPiArCWlmIChpZHggPT0gMCkgew0KPiA+ICsJCXNtbXVfcG11
X3NldF9ldmVudF9maWx0ZXIoZXZlbnQsIGlkeCwgc3Bhbiwgc2lkKTsNCj4gPiArCQlzbW11X3Bt
dS0+Z2xvYmFsX2ZpbHRlcl9zcGFuID0gc3BhbjsNCj4gPiArCQlzbW11X3BtdS0+Z2xvYmFsX2Zp
bHRlcl9zaWQgPSBzaWQ7DQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKwl9DQo+IA0KPiBXaGVuIEkg
c3VnZ2VzdGVkIGRyb3BwaW5nIHRoZSBjaGVjayBvZiBpZHgsIEkgZGlkIG1lYW4gcmVtb3Zpbmcg
aXQNCj4gZW50aXJlbHksIG5vdCBqdXN0IG1vdmluZyBpdCBmdXJ0aGVyIGRvd24gOykNCg0KQWgu
LkkgbXVzdCBjb25mZXNzIHRoYXQgSSB3YXMgc2xpZ2h0bHkgY29uZnVzZWQgYnkgdGhhdCBzdWdn
ZXN0aW9uIGFuZCANCnRob3VnaHQgdGhhdCB5b3UgYXJlIG1ha2luZyBhIGNhc2UgZm9yIGNvZGUg
YmVpbmcgbW9yZSBjbGVhciB0byByZWFkIDopDQogDQo+IE5vdGhpbmcgdG8gd29ycnkgYWJvdXQg
dGhvdWdoLCBJJ2xsIGp1c3QgbGVhdmUgdGhpcyBoZXJlIGZvciBXaWxsIHRvDQo+IGNvbnNpZGVy
IGFwcGx5aW5nIG9uIHRvcCBvciBzcXVhc2hpbmcuDQoNClRoYW5rcyBmb3IgdGhhdC4NCg0KQ2hl
ZXJzLA0KU2hhbWVlcg0KDQo+IFRoYW5rcywNCj4gUm9iaW4uDQo+IA0KPiAtLS0tLT44LS0tLS0N
Cj4gRnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU3ViamVjdDog
W1BBVENIXSBwZXJmL3NtbXV2MzogUmVsYXggZ2xvYmFsIGZpbHRlciBjb25zdHJhaW50IGEgbGl0
dGxlDQo+IA0KPiBBbHRob3VnaCB0aGUgY3VycmVudCBiZWhhdmlvdXIgb2Ygc21tdV9wbXVfZ2V0
X2V2ZW50X2lkeCgpIGVmZmVjdGl2ZWx5DQo+IGVuc3VyZXMgdGhhdCB0aGUgZmlyc3QtYWxsb2Nh
dGVkIGNvdW50ZXIgd2lsbCBiZSBjb3VudGVyIDAsIHRoZXJlJ3Mgbm8NCj4gbmVlZCB0byBzdHJp
Y3RseSBlbmZvcmNlIHRoYXQgaW4gc21tdV9wbXVfYXBwbHlfZXZlbnRfZmlsdGVyKCkuIEFsbCB0
aGF0DQo+IG1hdHRlcnMgaXMgdGhhdCB3ZSBvbmx5IGV2ZXIgdG91Y2ggdGhlIGdsb2JhbCBmaWx0
ZXIgc2V0dGluZ3MgaW4NCj4gU01NVV9QTUNHX1NNUjAgYW5kIFNNTVVfUE1DR19FVlRZUEVSMCB3
aGlsZSBubyBjb3VudGVycyBhcmUNCj4gYWN0aXZlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm9i
aW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9wZXJm
L2FybV9zbW11djNfcG11LmMgfCAxMSArKysrLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wZXJmL2FybV9zbW11djNfcG11LmMNCj4gYi9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUu
Yw0KPiBpbmRleCA2YjNjMGVkN2FkNzEuLjIzMDQ1ZWFkNmRlMSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9wZXJmL2FybV9zbW11djNfcG11LmMNCj4gKysrIGIvZHJpdmVycy9wZXJmL2FybV9zbW11
djNfcG11LmMNCj4gQEAgLTI4NiwxNCArMjg2LDExIEBAIHN0YXRpYyBpbnQgc21tdV9wbXVfYXBw
bHlfZXZlbnRfZmlsdGVyKHN0cnVjdA0KPiBzbW11X3BtdSAqc21tdV9wbXUsDQo+ICAgCWlmICgh
Yml0bWFwX2VtcHR5KHNtbXVfcG11LT51c2VkX2NvdW50ZXJzLCBudW1fY3RycykpDQo+ICAgCQly
ZXR1cm4gLUVBR0FJTjsNCj4gDQo+IC0JaWYgKGlkeCA9PSAwKSB7DQo+IC0JCXNtbXVfcG11X3Nl
dF9ldmVudF9maWx0ZXIoZXZlbnQsIGlkeCwgc3Bhbiwgc2lkKTsNCj4gLQkJc21tdV9wbXUtPmds
b2JhbF9maWx0ZXJfc3BhbiA9IHNwYW47DQo+IC0JCXNtbXVfcG11LT5nbG9iYWxfZmlsdGVyX3Np
ZCA9IHNpZDsNCj4gLQkJcmV0dXJuIDA7DQo+IC0JfQ0KPiArCXNtbXVfcG11X3NldF9ldmVudF9m
aWx0ZXIoZXZlbnQsIDAsIHNwYW4sIHNpZCk7DQo+ICsJc21tdV9wbXUtPmdsb2JhbF9maWx0ZXJf
c3BhbiA9IHNwYW47DQo+ICsJc21tdV9wbXUtPmdsb2JhbF9maWx0ZXJfc2lkID0gc2lkOw0KPiAN
Cj4gLQlyZXR1cm4gLUVBR0FJTjsNCj4gKwlyZXR1cm4gMDsNCj4gICB9DQo+IA0KPiAgIHN0YXRp
YyBpbnQgc21tdV9wbXVfZ2V0X2V2ZW50X2lkeChzdHJ1Y3Qgc21tdV9wbXUgKnNtbXVfcG11LA0K
PiAtLQ0KPiAyLjIwLjEuZGlydHkNCg==
