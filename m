Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64477C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150DA20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ND2TlrQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbfC0KXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:23:10 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:11682
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbfC0KXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8K4HeceQik9K8YSVrRBz7aa9RLH+0fG2HBu2DyuPH0=;
 b=ND2TlrQsVDtB1BxvP9pSCkzh4jv/whyVfXPjr7oWL6gMGcvKr9ow4wknP9FtY2qOY02Av9yaRL8H6TMjTe8GWaFdbrRNvZbc0bJWBAgfAPa7iPlEtViLdrVI2pkKZgffpr9BtxzvuRSrHjKmq4W9gYlHih6AF0iqIvVUUb7hq60=
Received: from AM4PR0802MB2211.eurprd08.prod.outlook.com (10.172.217.137) by
 AM4PR0802MB2211.eurprd08.prod.outlook.com (10.172.217.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 10:23:06 +0000
Received: from AM4PR0802MB2211.eurprd08.prod.outlook.com
 ([fe80::b7:11d9:4d0e:995e]) by AM4PR0802MB2211.eurprd08.prod.outlook.com
 ([fe80::b7:11d9:4d0e:995e%4]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 10:23:06 +0000
From:   Ben Gainey <Ben.Gainey@arm.com>
To:     "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>, nd <nd@arm.com>,
        "acme@redhat.com" <acme@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        Will Deacon <Will.Deacon@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: BUG in "perf: Suppress AUX/OVERWRITE records"?
Thread-Topic: BUG in "perf: Suppress AUX/OVERWRITE records"?
Thread-Index: AQHU4w12v5Mi06394Eazgqc3Su3it6YdfbIAgAAi+wCAAZUVgIAAEkSA
Date:   Wed, 27 Mar 2019 10:23:06 +0000
Message-ID: <1f645e7cacc20cc82249c7dd2db8361f1dd1726e.camel@arm.com>
References: <ca9bbbdfada4c02eacb5064fce5d187d0f13f4f0.camel@arm.com>
         <87k1gm86en.fsf@ashishki-desk.ger.corp.intel.com>
         <3f04004a48a4b5bece9d277d5c51661f4eca7e97.camel@arm.com>
         <87wokk7k20.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87wokk7k20.fsf@ashishki-desk.ger.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.0 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Gainey@arm.com; 
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e6c1e69-7724-498b-25a6-08d6b29e33d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0802MB2211;
x-ms-traffictypediagnostic: AM4PR0802MB2211:
x-microsoft-antispam-prvs: <AM4PR0802MB22113E785B7756F85B7FF1A591580@AM4PR0802MB2211.eurprd08.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(366004)(40434004)(199004)(189003)(97736004)(5660300002)(81166006)(68736007)(8676002)(76176011)(6246003)(8936002)(81156014)(25786009)(118296001)(66066001)(6436002)(256004)(14444005)(53546011)(53936002)(6512007)(2201001)(86362001)(5024004)(446003)(229853002)(478600001)(305945005)(26005)(476003)(3846002)(11346002)(4326008)(105586002)(99286004)(6636002)(110136005)(36756003)(6486002)(2616005)(58126008)(2906002)(7736002)(14454004)(71190400001)(486006)(2501003)(102836004)(186003)(6506007)(93886005)(54906003)(72206003)(106356001)(71200400001)(316002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2211;H:AM4PR0802MB2211.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j55Z1ZE6bQYZnj/rO+ut6sbIS5v8ayWugxX23+nRZbFC+4jzlsMfW416EQfg9S6KKVwDn23jNb8fT7ZzUUYNREro/Y/IF6m8IC6ef54xIKqMYRUtsZxaAmO0+tUXK9+rTnRG1pKVIqwL54be047LIeMtA0cqNWSVBuRtQtvz5KMLJgHceIUZNGM1dkS7KPwKoCIcBXAQaxavKff6Jhsb7hqjzxyTPqVAVp82ROX7O3sZ4CVzjnelGPUFDWbmCKFimK+vwg8hEzaAmepgGo43d5g4v9rzf5ZuJff8Bzz3qz8p2u96BH70ENgvztVSTuAYIYYSVGirW2Phm5zitEnXLtSOwuxGD65o1Q54XjfwWA7Oj5FcOo86XbZZCj7vN9AhbuG+ii4WYvqWTB9A6RtJ8BJ8UQ7h61pOqcXoOlP5zrI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78F7AB4596E60F4EA30A9F1EDA1E0DA9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6c1e69-7724-498b-25a6-08d6b29e33d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 10:23:06.2517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAzLTI3IGF0IDExOjE3ICswMjAwLCBBbGV4YW5kZXIgU2hpc2hraW4gd3Jv
dGU6DQo+IEJlbiBHYWluZXkgPEJlbi5HYWluZXlAYXJtLmNvbT4gd3JpdGVzOg0KPg0KPiA+ID4g
SXQgd2FzIGFuIHVuaW50ZW50aW9uYWwgc2lkZSBlZmZlY3QgdGhhdCBpdCBhbHNvDQo+ID4gPiBo
YXBwZW5lZCB0byBjb2luY2lkZSB3aXRoIGNvbnRleHQgc3dpdGNoZXMgaW4gdGhlIG92ZXJ3cml0
ZSBtb2RlLg0KPiA+DQo+ID4gSSdtIG5vdCB1c2luZyBvdmVyd3JpdGUgbW9kZSwgSSdtIG9wZW5p
bmcgdGhlIG1tYXAgd2l0aCBQUk9UX1dSSVRFDQo+ID4gKGkuZS4gaW4gdHJ1bmNhdGUgbW9kZSku
DQo+DQo+IE5vdyBJIGdldCBpdC4gRG9lcyB0aGUgYmVsb3cgZml4IHRoZSBwcm9ibGVtIGZvciB5
b3U/DQoNClllcyBJIGd1ZXNzIEkgc2hvdWxkIGhhdmUgbWVudGlvbmVkIHRoYXQgaW4gdGhlIGZp
cnN0IHBsYWNlLg0KVGVzdGVkLCB3b3JraW5nIG5vdyBhcyBleHBlY3RlZDsgSSBzZWUgcmVndWxh
ciBQRVJGX1JFQ09SRF9BVVgsIHRoYXQNCmNvaW5jaWRlIHdpdGggdGhlIGNvbnRleHQgc3dpdGNo
Lg0KDQpUaGFua3MhDQpCZW4NCg0KPg0KPiBGcm9tIGJmNTIzMjBjY2UwZTc0YTJjMGQ5ODdkYjdi
ZDU3MWY3Njg3YjRmNGYgTW9uIFNlcCAxNyAwMDowMDowMA0KPiAyMDAxDQo+IEZyb206IEFsZXhh
bmRlciBTaGlzaGtpbiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT4NCj4gRGF0
ZTogV2VkLCAyNyBNYXIgMjAxOSAxMTowNTo1MyArMDIwMA0KPiBTdWJqZWN0OiBbUEFUQ0hdIHBl
cmY6IEZpeCBBVVggcmVjb3JkIHN1cHByZXNzaW9uDQo+DQo+IENvbW1pdCAxNjI3MzE0ZmI1NGEz
M2UgKCJwZXJmOiBTdXBwcmVzcyBBVVgvT1ZFUldSSVRFIHJlY29yZHMiKSBoYXMNCj4gYW4NCj4g
dW5pbnRlbmRlZCBzaWRlLWVmZmVjdCBvZiBhbHNvIHN1cHByZXNzaW5nIGFsbCBBVVggcmVjb3Jk
cyB3aXRoIG5vDQo+IGZsYWdzDQo+IGFuZCBub24temVybyBzaXplLCBzbyBhbGwgdGhlIHJlZ3Vs
YXIgcmVjb3JkcyBpbiB0aGUgZnVsbCB0cmFjZSBtb2RlLg0KPiBUaGlzIGJyZWFrcyBzb21lIHVz
ZSBjYXNlcyBmb3IgcGVvcGxlLg0KPg0KPiBGaXggdGhpcyBieSByZXN0b3JpbmcgInJlZ3VsYXIi
IEFVWCByZWNvcmRzIHRvIHRoZWlyIGZvcm1lciBnbG9yeS4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
QWxleGFuZGVyIFNoaXNoa2luIDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tDQo+
ID4NCj4gRml4ZXM6IDE2MjczMTRmYjU0YTMzZSAoInBlcmY6IFN1cHByZXNzIEFVWC9PVkVSV1JJ
VEUgcmVjb3JkcyIpDQo+IFJlcG9ydGVkLWJ5OiBCZW4gR2FpbmV5IDxCZW4uR2FpbmV5QGFybS5j
b20+DQo+IENDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjQuMjArDQo+IC0tLQ0KPiAga2Vy
bmVsL2V2ZW50cy9yaW5nX2J1ZmZlci5jIHwgMzMgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25z
KC0pDQo+DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvZXZlbnRzL3JpbmdfYnVmZmVyLmMNCj4gYi9r
ZXJuZWwvZXZlbnRzL3JpbmdfYnVmZmVyLmMNCj4gaW5kZXggNjc4Y2NlYzYwZDhmLi42MjYyNTZk
YzI2YzEgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9ldmVudHMvcmluZ19idWZmZXIuYw0KPiArKysg
Yi9rZXJuZWwvZXZlbnRzL3JpbmdfYnVmZmVyLmMNCj4gQEAgLTQ1NSwyNCArNDU1LDIxIEBAIHZv
aWQgcGVyZl9hdXhfb3V0cHV0X2VuZChzdHJ1Y3QNCj4gcGVyZl9vdXRwdXRfaGFuZGxlICpoYW5k
bGUsIHVuc2lnbmVkIGxvbmcgc2l6ZSkNCj4gIHJiLT5hdXhfaGVhZCArPSBzaXplOw0KPiAgfQ0K
Pg0KPiAtaWYgKHNpemUgfHwgaGFuZGxlLT5hdXhfZmxhZ3MpIHsNCj4gLS8qDQo+IC0gKiBPbmx5
IHNlbmQgUkVDT1JEX0FVWCBpZiB3ZSBoYXZlIHNvbWV0aGluZyB1c2VmdWwgdG8NCj4gY29tbXVu
aWNhdGUNCj4gLSAqDQo+IC0gKiBOb3RlOiB0aGUgT1ZFUldSSVRFIHJlY29yZHMgYnkgdGhlbXNl
bHZlcyBhcmUgbm90DQo+IGNvbnNpZGVyZWQNCj4gLSAqIHVzZWZ1bCwgYXMgdGhleSBkb24ndCBj
b21tdW5pY2F0ZSBhbnkgKm5ldyoNCj4gaW5mb3JtYXRpb24sDQo+IC0gKiBhc2lkZSBmcm9tIHRo
ZSBzaG9ydC1saXZlZCBvZmZzZXQsIHRoYXQgYmVjb21lcw0KPiBoaXN0b3J5IGF0DQo+IC0gKiB0
aGUgbmV4dCBldmVudCBzY2hlZC1pbiBhbmQgdGhlcmVmb3JlIGlzbid0IHVzZWZ1bC4NCj4gLSAq
IFRoZSB1c2Vyc3BhY2UgdGhhdCBuZWVkcyB0byBjb3B5IG91dCBBVVggZGF0YSBpbg0KPiBvdmVy
d3JpdGUNCj4gLSAqIG1vZGUgc2hvdWxkIGtub3cgdG8gdXNlIHVzZXJfcGFnZTo6YXV4X2hlYWQg
Zm9yIHRoZQ0KPiBhY3R1YWwNCj4gLSAqIG9mZnNldC4gU28sIGZyb20gbm93IG9uIHdlIGRvbid0
IG91dHB1dCBBVVggcmVjb3Jkcw0KPiB0aGF0DQo+IC0gKiBoYXZlICpvbmx5KiBPVkVSV1JJVEUg
ZmxhZyBzZXQuDQo+IC0gKi8NCj4gLQ0KPiAtaWYgKGhhbmRsZS0+YXV4X2ZsYWdzICYgfih1NjQp
UEVSRl9BVVhfRkxBR19PVkVSV1JJVEUpDQo+IC1wZXJmX2V2ZW50X2F1eF9ldmVudChoYW5kbGUt
PmV2ZW50LCBhdXhfaGVhZCwNCj4gc2l6ZSwNCj4gLSAgICAgICAgICAgICAgICAgICAgIGhhbmRs
ZS0+YXV4X2ZsYWdzKTsNCj4gLX0NCj4gKy8qDQo+ICsgKiBPbmx5IHNlbmQgUkVDT1JEX0FVWCBp
ZiB3ZSBoYXZlIHNvbWV0aGluZyB1c2VmdWwgdG8NCj4gY29tbXVuaWNhdGUNCj4gKyAqDQo+ICsg
KiBOb3RlOiB0aGUgT1ZFUldSSVRFIHJlY29yZHMgYnkgdGhlbXNlbHZlcyBhcmUgbm90IGNvbnNp
ZGVyZWQNCj4gKyAqIHVzZWZ1bCwgYXMgdGhleSBkb24ndCBjb21tdW5pY2F0ZSBhbnkgKm5ldyog
aW5mb3JtYXRpb24sDQo+ICsgKiBhc2lkZSBmcm9tIHRoZSBzaG9ydC1saXZlZCBvZmZzZXQsIHRo
YXQgYmVjb21lcyBoaXN0b3J5IGF0DQo+ICsgKiB0aGUgbmV4dCBldmVudCBzY2hlZC1pbiBhbmQg
dGhlcmVmb3JlIGlzbid0IHVzZWZ1bC4NCj4gKyAqIFRoZSB1c2Vyc3BhY2UgdGhhdCBuZWVkcyB0
byBjb3B5IG91dCBBVVggZGF0YSBpbiBvdmVyd3JpdGUNCj4gKyAqIG1vZGUgc2hvdWxkIGtub3cg
dG8gdXNlIHVzZXJfcGFnZTo6YXV4X2hlYWQgZm9yIHRoZSBhY3R1YWwNCj4gKyAqIG9mZnNldC4g
U28sIGZyb20gbm93IG9uIHdlIGRvbid0IG91dHB1dCBBVVggcmVjb3JkcyB0aGF0DQo+ICsgKiBo
YXZlICpvbmx5KiBPVkVSV1JJVEUgZmxhZyBzZXQuDQo+ICsgKi8NCj4gK2lmIChzaXplIHx8ICho
YW5kbGUtPmF1eF9mbGFncyAmDQo+IH4odTY0KVBFUkZfQVVYX0ZMQUdfT1ZFUldSSVRFKSkNCj4g
K3BlcmZfZXZlbnRfYXV4X2V2ZW50KGhhbmRsZS0+ZXZlbnQsIGF1eF9oZWFkLCBzaXplLA0KPiAr
ICAgICBoYW5kbGUtPmF1eF9mbGFncyk7DQo+DQo+ICByYi0+dXNlcl9wYWdlLT5hdXhfaGVhZCA9
IHJiLT5hdXhfaGVhZDsNCj4gIGlmIChyYl9uZWVkX2F1eF93YWtldXAocmIpKQ0KSU1QT1JUQU5U
IE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBh
cmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5v
dCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRp
YXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNv
biwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRp
b24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
