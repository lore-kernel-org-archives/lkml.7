Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF3AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88C12177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ElE0lRnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfCSO7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:59:40 -0400
Received: from mail-eopbgr680074.outbound.protection.outlook.com ([40.107.68.74]:13383
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727145AbfCSO7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+t7+ulKuEfpr9ofi/fwlN+isVDlgpFXn7IUDnZsrD0=;
 b=ElE0lRnkoGg73wNR+Zsn9KjazRyVqv/5nS9yqIMWolsMUn4Ti/ZWdNpXt7opE186n5MQ8JCgYrZId2QzF/j0IXfuKrR45O1TF9AyGg4RNMapoltU+AHPMtMbGRLxwJLdC5cHHVM4kPr2aKs+Knzo4nBmjxYcKBmryojmyozgSrE=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB5635.namprd02.prod.outlook.com (20.177.241.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 14:59:34 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::dc07:4b0:4a82:392a]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::dc07:4b0:4a82:392a%6]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 14:59:34 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     gregkh <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Thread-Topic: [PATCH 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Thread-Index: AQHU3kvx8x3F3XN98kC51fP21to83qYS76+AgAAPpVA=
Date:   Tue, 19 Mar 2019 14:59:34 +0000
Message-ID: <BL0PR02MB5681AEB47A24279266831D1BCB400@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
 <1552997064-432700-5-git-send-email-dragan.cvetic@xilinx.com>
 <CAK8P3a3uKOVW5HcQD9LLKfoeOkTnhE8M2rHsZuwjNUQv18=J_g@mail.gmail.com>
In-Reply-To: <CAK8P3a3uKOVW5HcQD9LLKfoeOkTnhE8M2rHsZuwjNUQv18=J_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c602ef86-2be4-454c-451c-08d6ac7b7fdf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB5635;
x-ms-traffictypediagnostic: BL0PR02MB5635:
x-microsoft-antispam-prvs: <BL0PR02MB5635BE11800559AC33F08EF1CB400@BL0PR02MB5635.namprd02.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39850400004)(136003)(346002)(376002)(189003)(199004)(13464003)(81166006)(81156014)(71200400001)(8676002)(99286004)(7696005)(6116002)(76176011)(53546011)(86362001)(6916009)(102836004)(6506007)(186003)(52536014)(6246003)(26005)(3846002)(14454004)(14444005)(68736007)(256004)(71190400001)(5660300002)(6436002)(478600001)(97736004)(33656002)(105586002)(305945005)(486006)(66066001)(106356001)(7736002)(476003)(316002)(53936002)(8936002)(9686003)(2906002)(54906003)(4326008)(229853002)(11346002)(446003)(25786009)(74316002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB5635;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rjSvWeXCVhRS3f5JEzbi98YgP47QefuK1GeBFZwa9WgDVfC0/uqUjp+JrtnesUIG/Uh1/KVJJiCuJwdLByzKiUNLJBiZWusun8ZZtUV5Bc/R1bZSr1sySMqyFWQfeZrn14qgtyUyWK1TLLgEZin/6B4Ii1hCOEYtonXYDBYdrmIzEUfA8GMwXC34uP9R3g4z3F7yrub+H6uavOxlvEnE72O/dkmeAnLfkSwIK51HocS53bKYjLZ8lQXhWEfTnOPnRKFNuFYjER938spN2v3k4qXBttyDk62erViR7NmuWz0f20To6BVBkjoXKD5eymsXcKQXSdaefvJJLk8rkLnWACK1LLPiLwnpfWkvZOuVUS+w0cDXOmymF9S0Crqh/kBe5hGRegXhlOBlxK4AA5O6tYLvaaHxUrN/kvd6Ew1PzcA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c602ef86-2be4-454c-451c-08d6ac7b7fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 14:59:34.4676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5635
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiBb
bWFpbHRvOmFybmRAYXJuZGIuZGVdDQo+IFNlbnQ6IFR1ZXNkYXkgMTkgTWFyY2ggMjAxOSAxMzox
OA0KPiBUbzogRHJhZ2FuIEN2ZXRpYyA8ZHJhZ2FuY0B4aWxpbnguY29tPg0KPiBDYzogZ3JlZ2to
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxp
bnguY29tPjsgTGludXggQVJNIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+
Ow0KPiBEZXJlayBLaWVybmFuIDxka2llcm5hbkB4aWxpbnguY29tPjsgTGludXggS2VybmVsIE1h
aWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAwNC8xMl0gbWlzYzogeGlsaW54X3NkZmVjOiBBZGQgb3BlbiwgY2xvc2UgYW5kIGlv
Y3RsDQo+IA0KPiBPbiBUdWUsIE1hciAxOSwgMjAxOSBhdCAxOjA1IFBNIERyYWdhbiBDdmV0aWMg
PGRyYWdhbi5jdmV0aWNAeGlsaW54LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBZGQgY2hhciBkZXZp
Y2UgaW50ZXJmYWNlIHBlciBEVCBub2RlIHByZXNlbnQgYW5kIHN1cHBvcnQNCj4gPiBmaWxlIG9w
ZXJhdGlvbnM6DQo+ID4gLSBvcGVuKCksIHdoaWNoIGtlZXBzIG9ubHkgb25lIG9wZW4gcGVyIGRl
dmljZSBhdCBhIHRpbWUsDQo+ID4gLSBjbG9zZSgpLCB3aGljaCByZWxlYXNlIHRoZSBvcGVuIGZv
ciB0aGlzIGRldmljZSwNCj4gPiAtIGlvY3RsKCksIHdoaWNoIHByb3ZpZGVzIGluZnJhc3RydWN0
dXJlIGZvciBhIHNwZWNpZmljIGRyaXZlcg0KPiA+IGNvbnRyb2wuDQo+IA0KPiA+ICBkcml2ZXJz
L21pc2MveGlsaW54X3NkZmVjLmMgICAgICB8IDc5ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS91YXBpL21pc2MveGlsaW54X3NkZmVjLmggfCAg
NCArKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDgzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21pc2MveGlsaW54X3NkZmVjLmMgYi9kcml2ZXJzL21pc2MveGls
aW54X3NkZmVjLmMNCj4gPiBpbmRleCBhNTJhNWM2Li4zNDA3ZGU0IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbWlzYy94aWxpbnhfc2RmZWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWlzYy94aWxp
bnhfc2RmZWMuYw0KPiA+IEBAIC04MSw4ICs4MSw4NyBAQCBzdHJ1Y3QgeHNkZmVjX2RldiB7DQo+
ID4gICAgICAgICBzdHJ1Y3QgeHNkZmVjX2Nsa3MgY2xrczsNCj4gPiAgfTsNCj4gPg0KPiA+ICtz
dGF0aWMgaW50IHhzZGZlY19kZXZfb3BlbihzdHJ1Y3QgaW5vZGUgKmlwdHIsIHN0cnVjdCBmaWxl
ICpmcHRyKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgeHNkZmVjX2RldiAqeHNkZmVjOw0K
PiA+ICsNCj4gPiArICAgICAgIHhzZGZlYyA9IGNvbnRhaW5lcl9vZihpcHRyLT5pX2NkZXYsIHN0
cnVjdCB4c2RmZWNfZGV2LCB4c2RmZWNfY2Rldik7DQo+ID4gKyAgICAgICBpZiAoIXhzZGZlYykN
Cj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FQUdBSU47DQo+IA0KPiBUaGUgcmVzdWx0IG9m
IGNvbnRhaW5lcl9vZigpIHdpbGwgbm90IGJlIE5VTEwgaGVyZS4NCj4gRGlkIHlvdSBtZWFuIHRv
IGNoZWNrIGlfY2Rldj8gVGhhdCBwcm9iYWJseSBhbHNvIHdvbid0DQo+IGJlIE5VTEwsIGJ1dCB0
aGF0IGNoZWNrIHdvdWxkIGJlIG1vcmUgcmVhc29uYWJsZS4NCg0KDQpXaWxsIGJlIGVpdGhlciBy
ZW1vdmVkIGZ1bGx5IG9yIGNoYW5nZWQgd2l0aCBpX2NkZXYgY2hlY2sNCg0KPiANCj4gPiArICAg
ICAgIC8qIE9ubHkgb25lIG9wZW4gcGVyIGRldmljZSBhdCBhIHRpbWUgKi8NCj4gPiArICAgICAg
IGlmICghYXRvbWljX2RlY19hbmRfdGVzdCgmeHNkZmVjLT5vcGVuX2NvdW50KSkgew0KPiA+ICsg
ICAgICAgICAgICAgICBhdG9taWNfaW5jKCZ4c2RmZWMtPm9wZW5fY291bnQpOw0KPiA+ICsgICAg
ICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiA+ICsgICAgICAgfQ0KPiANCj4gV2hhdCBpcyB0
aGF0IGxpbWl0YXRpb24gZm9yPyBJcyBpdCB3b3JzZSB0byBvcGVuIGl0IHR3aWNlIHRoYW4NCj4g
dG8gZHVwKCkgb3IgZm9yaygpPw0KPg0KVGhlIGRldmljZSBjYW4gYmUgb3BlbmVkIG9ubHkgb25j
ZS4NCiANCj4gTm90ZSB0aGF0IHRoZSB0ZXN0IGlzIG5vdCByZWFsbHkgYXRvbWljIGVpdGhlcjog
aWYgdGhyZWUgcHJvY2Vzc2VzDQo+IHRyeSB0byBvcGVuIHRoZSBmaWxlIGF0IHRoZSBzYW1lIHRp
bWUsIGl0IGdldHMgZGVjcmVtZW50ZWQgZnJvbQ0KPiAxIHRvIC0yLCBzbyBvbmx5IHRoZSBzZWNv
bmQgb25lIHNlZXMgMCBhbmQgaW5jcmVtZW50cyBpdCBiYWNrDQo+IHRvIC0xIGFmdGVyd2FyZHMu
Li4NCg0KSXQgbG9va3MgeW91IGFyZSByaWdodC4gV2lsbCBmaXggdGhpcy4gVGhhbmsgeW91IGZv
ciB0aGUgY2F0Y2guDQoNCj4gDQo+ID4gK3N0YXRpYyBsb25nIHhzZGZlY19kZXZfaW9jdGwoc3Ry
dWN0IGZpbGUgKmZwdHIsIHVuc2lnbmVkIGludCBjbWQsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1bnNpZ25lZCBsb25nIGRhdGEpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVj
dCB4c2RmZWNfZGV2ICp4c2RmZWMgPSBmcHRyLT5wcml2YXRlX2RhdGE7DQo+ID4gKyAgICAgICB2
b2lkIF9fdXNlciAqYXJnID0gTlVMTDsNCj4gPiArICAgICAgIGludCBydmFsID0gLUVJTlZBTDsN
Cj4gPiArICAgICAgIGludCBlcnIgPSAwOw0KPiA+ICsNCj4gPiArICAgICAgIGlmICgheHNkZmVj
KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcnZhbDsNCj4gPiArDQo+ID4gKyAgICAgICBp
ZiAoX0lPQ19UWVBFKGNtZCkgIT0gWFNERkVDX01BR0lDKSB7DQo+ID4gKyAgICAgICAgICAgICAg
IGRldl9lcnIoeHNkZmVjLT5kZXYsICJOb3QgYSB4aWxpbnggc2RmZWMgaW9jdGwiKTsNCj4gPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9UVFk7DQo+ID4gKyAgICAgICB9DQo+IA0KPiByZW1v
dmUgdGhlIGVycm9yIG1lc3NhZ2VzIGhlcmUgYXMgd2VsbC4NCj4gDQo+ID4gKyAgICAgICAvKiBB
Y2Nlc3MgY2hlY2sgb2YgdGhlIGFyZ3VtZW50IGlmIHByZXNlbnQgKi8NCj4gPiArICAgICAgIGlm
IChfSU9DX0RJUihjbWQpICYgX0lPQ19SRUFEKQ0KPiA+ICsgICAgICAgICAgICAgICBlcnIgPSAh
YWNjZXNzX29rKCh2b2lkICopYXJnLCBfSU9DX1NJWkUoY21kKSk7DQo+ID4gKyAgICAgICBlbHNl
IGlmIChfSU9DX0RJUihjbWQpICYgX0lPQ19XUklURSkNCj4gPiArICAgICAgICAgICAgICAgZXJy
ID0gIWFjY2Vzc19vaygodm9pZCAqKWFyZywgX0lPQ19TSVpFKGNtZCkpOw0KPiANCj4gVGhpcyBz
ZWVtcyBvZGQuIFdoeSB0d28gc2VwYXJhdGUgY2hlY2tzLCBhbmQgd2h5IHRoZSBhY2Nlc3Nfb2so
KQ0KPiBjaGVjayB3aGVuIHlvdSBkbyBhIGNvcHlfZnJvbV91c2VyKCkgdGhhdCBjb250YWlucyB0
aGUgc2FtZSBjaGVjaw0KPiBsYXRlcj8NCg0KQWNjZXB0ZWQsIHdpbGwgcmVtb3ZlIGl0LiANCg0K
PiANCj4gSWYgeW91IHdhbnQgdG8gZ2V0IGZhbmN5IGhlcmUsIHlvdSBjb3VsZCBqdXN0IGNvcHkg
dGhlIGRhdGEgaW4gdGhlIG1haW4NCj4gaW9jdGwgaGFuZGxlciBiYXNlZCBvbiBfSU9DX1NJWkUs
IGFuZCBwYXNzIGFyb3VuZCBub3JtYWwga2VybmVsDQo+IHBvaW50ZXJzIGZyb20gdGhlcmUuDQoN
Cg0KV2lsbCBub3QgYmUgZmFuY3kuIFRoYW5rIHlvdSBmb3IgdGhlIGFkdmljZS4NCg0KPiANCj4g
PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgeHNkZmVjX2ZvcHMgPSB7DQo+
ID4gICAgICAgICAub3duZXIgPSBUSElTX01PRFVMRSwNCj4gPiArICAgICAgIC5vcGVuID0geHNk
ZmVjX2Rldl9vcGVuLA0KPiA+ICsgICAgICAgLnJlbGVhc2UgPSB4c2RmZWNfZGV2X3JlbGVhc2Us
DQo+ID4gKyAgICAgICAudW5sb2NrZWRfaW9jdGwgPSB4c2RmZWNfZGV2X2lvY3RsLA0KPiA+ICB9
Ow0KPiANCj4gVGhpcyBsYWNrcyBhIC5jb21wYXRfaW9jdGwgcG9pbnRlci4NCg0KVGhpcyBpcyBu
ZXcgZm9yIG1lLCBJIGhhdmUgdG8gaW52ZXN0aWdhdGUgbW9yZSBhbmQgcHJvcG9zZSBhIHNvbHV0
aW9uLg0KVGhhbmsgeW91IGZvciBzdWdnZXN0aW9uLg0KDQo+IA0KPiAgICAgICAgQXJuZA0K
