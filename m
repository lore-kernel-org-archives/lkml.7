Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB57AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6D52075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="w98mG47Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfCSOCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:02:18 -0400
Received: from mail-eopbgr800083.outbound.protection.outlook.com ([40.107.80.83]:13332
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726935AbfCSOCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1LnOqfUsxY8LbcVF+6OQhU9p3cYpEMi+ZV7T3TVSBk=;
 b=w98mG47Q7AWA+IUjjHyhlBJ81qdyH9jpuqmkEbHAjwzDMQbvjyIzQez3CSNMS697WHLjHjim3MS7lxFUCbQ7mCOPc1sf3RY2OHhPjRxfwRuPEp/lXyT0kUM+uuP9m+8Z3QrDG5643IFfXQK+X0BlCLLc12Gv2tz1hm+LzyS2e6A=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB3761.namprd02.prod.outlook.com (52.132.8.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 14:02:13 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::dc07:4b0:4a82:392a]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::dc07:4b0:4a82:392a%6]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 14:02:13 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     gregkh <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: RE: [PATCH 08/12] misc: xilinx_sdfec: Add ability to get/set config
Thread-Topic: [PATCH 08/12] misc: xilinx_sdfec: Add ability to get/set config
Thread-Index: AQHU3kvwaLYIrJ5fl0ia+cFuErscN6YS7FOAgAALFOA=
Date:   Tue, 19 Mar 2019 14:02:12 +0000
Message-ID: <BL0PR02MB568116E14DE884145B641504CB400@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
 <1552997064-432700-9-git-send-email-dragan.cvetic@xilinx.com>
 <CAK8P3a0E_eZb1rSb9suv65n8WUnz-cXhk24aGoR8eNKcHVPtFw@mail.gmail.com>
In-Reply-To: <CAK8P3a0E_eZb1rSb9suv65n8WUnz-cXhk24aGoR8eNKcHVPtFw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3067047c-b5da-4d4c-0b5e-08d6ac737ca1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB3761;
x-ms-traffictypediagnostic: BL0PR02MB3761:
x-microsoft-antispam-prvs: <BL0PR02MB37616ADD6F7269F67655FE89CB400@BL0PR02MB3761.namprd02.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(13464003)(66066001)(4326008)(105586002)(86362001)(6916009)(5660300002)(54906003)(25786009)(106356001)(6116002)(3846002)(97736004)(71200400001)(71190400001)(7696005)(2906002)(316002)(14444005)(256004)(99286004)(8936002)(229853002)(102836004)(186003)(81166006)(81156014)(76176011)(7736002)(6506007)(74316002)(68736007)(305945005)(9686003)(55016002)(52536014)(14454004)(478600001)(8676002)(486006)(26005)(107886003)(6246003)(53936002)(446003)(11346002)(53546011)(6436002)(33656002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3761;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wn/nY7V3HYyZZ+VV4kWB/TRpztmwAChT/3K9wZQFcwgwKCaxl6sO668Z6F6fyiZYDjNTH9QzU1x4kAorx1hkSl+EP2k5JKRzU9/C5Gb0YfP5ulsoj+NBqw6t5eAfz3LdiUaTvREjl6caTtPspoNmh0+10WWJPJABmYhf16j/MkIQX8j1HfMQbZOw2BMvpmLpttV7tAsTP8Wacu9WqQKsnGWvm72Izen/GZvm7S+kQBMBpdbcSdXTkai649768ZbnmjYpI0rTVNA3gIFK1LdeM5+zeDHSbMhzfHrwM+oF7Lhu57FL1SlZTp95QTdVZdM/XhJxxLvC7PSzz6VEW/qUkgXPdmy5GeE8V1RwIA+XOC6K+IHQFdC06AdEHD6aHMXkYoQBtfX1L1w4qhO3vBlC0igR9fu51PnEtEM/70ZFIlU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3067047c-b5da-4d4c-0b5e-08d6ac737ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 14:02:12.9407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3761
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiBb
bWFpbHRvOmFybmRAYXJuZGIuZGVdDQo+IFNlbnQ6IFR1ZXNkYXkgMTkgTWFyY2ggMjAxOSAxMzow
Ng0KPiBUbzogRHJhZ2FuIEN2ZXRpYyA8ZHJhZ2FuY0B4aWxpbnguY29tPg0KPiBDYzogZ3JlZ2to
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxp
bnguY29tPjsgTGludXggQVJNIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+
Ow0KPiBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnPjsgRGVyZWsgS2llcm5hbiA8ZGtpZXJuYW5AeGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAwOC8xMl0gbWlzYzogeGlsaW54X3NkZmVjOiBBZGQgYWJpbGl0eSB0byBnZXQvc2V0
IGNvbmZpZw0KPiANCj4gT24gVHVlLCBNYXIgMTksIDIwMTkgYXQgMTowNiBQTSBEcmFnYW4gQ3Zl
dGljIDxkcmFnYW4uY3ZldGljQHhpbGlueC5jb20+IHdyb3RlOg0KPiA+IC0gQWRkIGNhcGFiaWxp
dHkgdG8gZ2V0IFNELUZFQyBjb25maWcgZGF0YSB1c2luZyBpb2N0bA0KPiA+IFhTREZFQ19HRVRf
Q09ORklHLg0KPiA+DQo+ID4gLSBBZGQgY2FwYWJpbGl0eSB0byBzZXQgU0QtRkVDIGRhdGEgb3Jk
ZXIgdXNpbmcgaW9jdGwNCj4gPiBTREZFQ19TRVRfT1JERVIuIFRoZSBvcmRlciBvZiBkYXRhIGJs
b2NrcyBjYW4gY2hhbmdlDQo+ID4gZnJvbSBpbnB1dCB0byBvdXRwdXQgb3IgdG8gYmUgbWFpbnRh
aW5lZC4NCj4gDQo+IENvbW1lbnRpbmcgaGVyZSBvbmx5IG9uIHRoZSBBQkksIG5vdCB0aGUgYWN0
dWFsIGJlaGF2aW9yIG9mIHRoZSBkcml2ZXI6DQoNCldpbGwgYmUgcmVtb3ZlZC4NCg0KPiANCj4g
PiArc3RhdGljIGludCB4c2RmZWNfZ2V0X2NvbmZpZyhzdHJ1Y3QgeHNkZmVjX2RldiAqeHNkZmVj
LCB2b2lkIF9fdXNlciAqYXJnKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBpbnQgZXJyOw0KPiA+ICsN
Cj4gPiArICAgICAgIGVyciA9IGNvcHlfdG9fdXNlcihhcmcsICZ4c2RmZWMtPmNvbmZpZywgc2l6
ZW9mKHhzZGZlYy0+Y29uZmlnKSk7DQo+ID4gKyAgICAgICBpZiAoZXJyKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgIGRldl9lcnIoeHNkZmVjLT5kZXYsICIlcyBmYWlsZWQgZm9yIFNERkVDJWQiLCBf
X2Z1bmNfXywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB4c2RmZWMtPmNvbmZpZy5mZWNf
aWQpOw0KPiA+ICsgICAgICAgICAgICAgICBlcnIgPSAtRUZBVUxUOw0KPiA+ICsgICAgICAgfQ0K
PiANCj4gVHJ5IHRvIGF2b2lkIHByaW50aW5nIGVycm9yIG1lc3NhZ2VzIGZvciB0aGluZ3MgdGhh
dCBjYW4gYmUgdHJpZ2dlcmVkIGZyb20NCj4gdXNlciBzcGFjZS4NCg0KV2lsbCBiZSByZW1vdmVk
Lg0KDQo+IA0KPiA+ICBzdGF0aWMgaW50IHhzZGZlY19zZXRfdHVyYm8oc3RydWN0IHhzZGZlY19k
ZXYgKnhzZGZlYywgdm9pZCBfX3VzZXIgKmFyZykNCj4gPiAgew0KPiA+ICAgICAgICAgc3RydWN0
IHhzZGZlY190dXJibyB0dXJibzsNCj4gPiBAQCAtNjcwLDYgKzY4Myw2NyBAQCBzdGF0aWMgaW50
IHhzZGZlY19hZGRfbGRwYyhzdHJ1Y3QgeHNkZmVjX2RldiAqeHNkZmVjLCB2b2lkIF9fdXNlciAq
YXJnKQ0KPiA+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBp
bnQgeHNkZmVjX3NldF9vcmRlcihzdHJ1Y3QgeHNkZmVjX2RldiAqeHNkZmVjLCB2b2lkIF9fdXNl
ciAqYXJnKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBib29sIG9yZGVyX2ludmFsaWQ7DQo+ID4gKyAg
ICAgICBlbnVtIHhzZGZlY19vcmRlciBvcmRlciA9ICooKGVudW0geHNkZmVjX29yZGVyICopYXJn
KTsNCj4gDQo+IEdlbmVyYWxseSBzcGVha2luZywgeW91IHNob3VsZCBuZXZlciBjYXN0IGJldHdl
ZW4gX191c2VyIHBvaW50ZXJzDQo+IGFuZCBrZXJuZWwgcG9pbnRlcnMuIEl0IGxvb2tzIGxpa2Ug
dGhpcyB3aWxsIGFjdHVhbGx5IGRlcmVmZXJlbmNlIGENCj4gX191c2VyIHBvaW50ZXIsIHdoaWNo
IGlzIGEgc2VjdXJpdHkgaXNzdWUuDQo+IA0KPiBBbm90aGVyIHByb2JsZW0gaXMgdGhhdCB0aGUg
Y29tbWFuZCBpcyBkZWZpbmVkIGFzDQo+IA0KPiAjZGVmaW5lIFhTREZFQ19TRVRfT1JERVIgX0lP
VyhYU0RGRUNfTUFHSUMsIDgsIHVuc2lnbmVkIGxvbmcgKikNCj4gDQo+IHdoaWNoIHdvdWxkIGlu
ZGljYXRlIGFuIGFyZ3VtZW50IG9mIHR5cGUgJ3Vuc2lnbmVkIGxvbmcgX191c2VyICogX191c2Vy
IConLA0KPiB3aGljaCBpcyBpbmNvbXBhdGlibGUgd2l0aCAnZW51bSB4c2RmZWNfb3JkZXIgX191
c2VyIConLiBCb3RoIGVudW0NCj4gYW5kIHBvaW50ZXIgdHlwZXMgYXJlIHZhcmlhYmxlIGxlbmd0
aCBhbmQgc2hvdWxkIGJlIGF2b2lkZWQgaW4NCj4gaW9jdGwgY29tbWFuZHMuIEJlc3QgbWFrZSB0
aGlzIGEgJ19fdTY0IF9fdXNlciAqJyBvciAnX191MzIgX191c2VyIConLg0KDQpXaWxsIGJlIHVw
ZGF0ZWQgYXMgcHJvcG9zZWQuDQoNCj4gDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5lIFhTREZFQ19H
RVRfQ09ORklHIF9JT1IoWFNERkVDX01BR0lDLCA2LCBzdHJ1Y3QgeHNkZmVjX2NvbmZpZyAqKQ0K
PiA+ICsvKioNCj4gPiAgICogRE9DOiBYU0RGRUNfR0VUX1RVUkJPDQo+ID4gICAqIEBQYXJhbWV0
ZXJzDQo+ID4gICAqDQo+ID4gQEAgLTMyMiw0ICszMzUsNDggQEAgeHNkZmVjX2NhbGN1bGF0ZV9z
aGFyZWRfbGRwY190YWJsZV9lbnRyeV9zaXplKHN0cnVjdCB4c2RmZWNfbGRwY19wYXJhbXMgKmxk
cGMsDQo+ID4gICAqIGlvY3RsIHRoYXQgcmV0dXJucyBTRC1GRUMgdHVyYm8gcGFyYW0gdmFsdWVz
DQo+ID4gICAqLw0KPiA+ICAjZGVmaW5lIFhTREZFQ19HRVRfVFVSQk8gX0lPUihYU0RGRUNfTUFH
SUMsIDcsIHN0cnVjdCB4c2RmZWNfdHVyYm8gKikNCj4gDQo+IEFsc28gd3JvbmcgdHlwZSwgdGhl
IGZ1bmN0aW9uIHRha2VzIGEgJ3N0cnVjdCB4c2RmZWNfdHVyYm8gX191c2VyIConLCBub3QgYQ0K
PiAnc3RydWN0IHhzZGZlY190dXJibyBfX3VzZXIgKiBfX3VzZXIgKicsDQoNCldpbGwgYmUgdXBk
YXRlZCBhcyBwcm9wb3NlZA0KDQo+IA0KPiAgICAgICAgIEFybmQNCg0KVGhhbmsgeW91DQpEcmFn
YW4NCg==
