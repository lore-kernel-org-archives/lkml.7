Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6C4C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CCB20675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IHe09vLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDZPL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:11:26 -0400
Received: from mail-eopbgr780082.outbound.protection.outlook.com ([40.107.78.82]:5920
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbfDZPLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S750Z47lvmXdfSvULRL7yr0N8PpKDgpgnBSrTbECUII=;
 b=IHe09vLhAFDjFO2GOcpue9FNue88vpZR779QbYuvieATbkE4Cjd6pLgyah8S3Z1vyU8Pqdl2sf6ukv04UJ+kLqo/V8Pd6/HbZ6fdZGsR5cb/RFkaSE1F01M7rNtKYRIZ3R/I5F9r7wJMwqsr2yY45vK+ZfcS0Elb2hvwu95tBqo=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) by
 DM5PR12MB1212.namprd12.prod.outlook.com (10.168.237.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 15:11:18 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::11db:1b41:d1e6:c6dc]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::11db:1b41:d1e6:c6dc%11]) with mapi id 15.20.1835.010; Fri, 26 Apr
 2019 15:11:18 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Thread-Topic: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Thread-Index: AQHU6yS/AQVIYa78D0OsnFnDJRviWKYsd26AgAWzsICAAFczgIAAHL8AgAAHagCAHAfRgA==
Date:   Fri, 26 Apr 2019 15:11:17 +0000
Message-ID: <b0ee2570-c9ba-2a7c-2a8b-0dfa46685e62@amd.com>
References: <155440965936.6194.3202659723198724589.stgit@sosrh7.amd.com>
 <alpine.DEB.2.21.1904042237020.1802@nanos.tec.linutronix.de>
 <5dfcb133-0a0e-9e07-3774-313e30814e79@amd.com>
 <20190408165835.GJ15689@zn.tnic>
 <8a14050e-2516-5c0f-195d-611c6959b94b@amd.com>
 <20190408190800.GL15689@zn.tnic>
In-Reply-To: <20190408190800.GL15689@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0013.prod.exchangelabs.com (2603:10b6:804:2::23)
 To DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6923b1a-632d-4004-ebd2-08d6ca596e82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1212;
x-ms-traffictypediagnostic: DM5PR12MB1212:
x-microsoft-antispam-prvs: <DM5PR12MB121258AE0ECD044B5CA9C08DFD3E0@DM5PR12MB1212.namprd12.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(396003)(136003)(376002)(199004)(189003)(25786009)(256004)(2906002)(386003)(186003)(68736007)(26005)(229853002)(6506007)(6116002)(6486002)(53936002)(36756003)(31696002)(4326008)(102836004)(71200400001)(6512007)(93886005)(14444005)(5660300002)(3846002)(71190400001)(6246003)(478600001)(7736002)(2616005)(66066001)(446003)(72206003)(305945005)(6916009)(11346002)(14454004)(476003)(6436002)(81156014)(81166006)(8676002)(76176011)(486006)(54906003)(64756008)(66476007)(66556008)(66446008)(73956011)(52116002)(99286004)(316002)(66946007)(8936002)(31686004)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1212;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UaDDTsGlNr1u4WrFUnE2rK6fxZ2odrrZiHmNdNOXmY+knL0c1FCsTir5A8psuQVppevz3iK5mCDl16UIp1X/k8tmpX9KCNX1OUfv/mAlRcYqZiGFXLZklFirfgmeS2WB6BnmQGNxN9FI6q5lUt0gmJREvpfz91J0OyMHFUZDn1H5gXbvfby1DNkvtNxUZrIR8N3Oiql2a8jAK/8LVd7nXI4p5vwXfw2qnIIuFVsIj+mYudP3bh/Iojdi6wPvMe/dm+MewwJaSPfl/OO8SQDZoVmYgwZfmDLWdAFEKS9QeqyYnchOTog3Qjy4uN3ZlJY/QvyND4VWOuTnB9H96TszX/kzsczJLVEpMOGZBWtB7KErqnxknfd8Q79/bh6Pv5b1mpdG9uPgWUySQSem3/d7g7J/jEn/gxtKKl8O/91PPZA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F9B2C6C09636D45A08737885BCBAED0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6923b1a-632d-4004-ebd2-08d6ca596e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 15:11:18.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC84LzE5IDI6MDggUE0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZTpPbiA1LzgvMTkgMjowOCBQ
TSwgQm9yaXNsYXYgDQpQZXRrb3Ygd3JvdGU6PiBPbiBNb24sIEFwciAwOCwgMjAxOSBhdCAwNjo0
MTozMFBNICswMDAwLCBHYXJ5IFIgSG9vayANCndyb3RlOg0KID4+IEFnYWluLCBub3QgYXJndWlu
Zy4gSSBjb21wbGV0ZWx5IHVuZGVyc3RhbmQuIEhvd2V2ZXIsIHRvIGJlIGZhaXIsIA0KdGhpcw0K
ID4+IGlzbid0IGFib3V0IFNNRSBoYXZpbmcgdHJvdWJsZSB3aXRoIHRob3NlIGZhY2lsaXRpZXMs
IHRoaXMgaXMgYWJvdXQgDQoNCiA+PiB1c2luZyBjZXJ0YWluIGZlYXR1cmVzIChlLmcuIGNvbW1h
bmQgbGluZSBvcHRpb24gcHJvY2Vzc2luZykgZWFybHkgDQppbg0KID4+IHRoZSBib290LiBBbnkg
Y29tcGxleCBmZWF0dXJlIGNvdWxkIGhhdmUgaGFkIHRoYXQgcmVxdWlyZW1lbnQsIGRvbid0IA0K
eW91DQogPj4gdGhpbms/IA0KDQogPg0KID4gU3VyZSwgYnV0IHRoZW4gd2h5IGRvIHdlIG5lZWQg
dGhhdCBwYXRjaCBhdCBhbGwgdGhlbj8gV2h5IGRvIHdlIG5lZWQgdG8NCiA+IGRpc2FibGUgaW5z
dHJ1bWVudGF0aW9uIGZvciBTTUUgZWFybHkgY29kZSBhbmQgbm90IGZvciBvdGhlciBlYXJseSBj
b2RlPw0KID4NCiA+IEkgbWVhbiwgaWYgeW91IGdyZXAgYXJvdW5kIHRoZSB0cmVlIHlvdSBjYW4g
c2VlIGEgYnVuY2ggb2YNCiA+IEtBU0FOX1NBTklUSVpFIGJ1dCBpbiBsaWIvIHdlIG9ubHkgaGF2
ZQ0KID4NCiA+IGxpYi9NYWtlZmlsZToyMTA6S0FTQU5fU0FOSVRJWkVfc3RhY2tkZXBvdC5vIDo9
IG4NCiA+DQogPiB3aGljaCBpcyBzcGVjaWFsLiBCdXQgdGhlIHJlc3Qgb2YgdGhlIGdlbmVyaWMg
Y29kZSBpbiBsaWIvIG9yDQogPiBhcmNoL3g4Ni9saWIvIGlzbid0Lg0KID4NCiA+IE5vdywgdGhl
cmUncyB0aGlzOg0KID4NCiA+IGFyY2gveDg2L2Jvb3QvTWFrZWZpbGU6MTI6S0FTQU5fU0FOSVRJ
WkUgICAgICAgICAgICAgICAgICAgICAgICA6PSBuDQogPiBhcmNoL3g4Ni9ib290L2NvbXByZXNz
ZWQvTWFrZWZpbGU6MjA6S0FTQU5fU0FOSVRJWkUgDQogICA6PSBuDQogPg0KID4gd2hpY2ggZGlz
YWJsZXMgS0FTQU4gZm9yIGFsbCBib290IGNvZGUuDQogPg0KID4gQW5kIHRoaXMgaXMgd2hhdCB5
b3UgbWVhbiAtIGFsbCBlYXJseSBib290IGNvZGUgc2hvdWxkIG5vdCBiZSBzYW5pdGl6ZWQuDQog
Pg0KID4gV2hpY2ggYWxzbyBnaXZlcyB0aGUgcmlnaHQgc29sdXRpb24sIElNTzoNCiA+DQogPiBj
bWRsaW5lLm8gc2hvdWxkIG5vdCBiZSBzYW5pdGl6ZWQgb25seSB3aGVuIHVzZWQgaW4gdGhlIGJv
b3QgY29kZS4gQnV0DQogPiB0aGF0IGlzIGFscmVhZHkgdGhlIGNhc2UuDQogPg0KID4gU28gd2h5
IGRvIHlvdSBuZWVkIHRvIGRpc2FibGUgS0FTQU4gZm9yIGFyY2gveDg2L2xpYi9jbWRsaW5lLmM/
DQogPg0KID4gQmVjYXVzZSBmb3IgdGhvc2UgdHdvOg0KID4NCiA+IGFyY2gveDg2L2Jvb3QvY21k
bGluZS5jDQogPiBhcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvY21kbGluZS5jDQogPg0KID4gdGhh
dCBzaG91bGQgYWxyZWFkeSBiZSB0aGUgY2FzZSBkdWUgdG8gdGhlIE1ha2VmaWxlIGRlZmluZXMg
YWJvdmUuDQoNCkV4Y2VwdCB0aGF0IHdlJ3JlIG5vdCB0YWxraW5nIGFib3V0IHRoYXQgY29kZS4N
Cg0KDQpJIHByb2JhYmx5IHNob3VsZCBoYXZlIGRlZmluZWQgdGVybXMsIHNvIHBsZWFzZSBhbGxv
dyBtZSB0byBiYWNrIHVwLiANCldoZW4gSSBzYXkgImVhcmx5IGJvb3QiIEkgbWVhbnQgd2hhdCBo
YXBwZW5zIC1hZnRlci0gZGVjb21wcmVzc2lvbiwgd2hlbiANCnRoZSBrZXJuZWwgcHJvcGVyIGhh
cyBiZWVuIGxhaWQgb3V0IGluIG1lbW9yeSBhbmQgc3RhcnRzIHRvIHJ1bi4gIFRoaXMgDQppcyAt
YWZ0ZXItIHRoZSBib290IGNvZGUgaGFzIGJlZW4gZXhlY3V0ZWQsIHdoaWNoIG1lYW5zIHRoYXQg
dGhlIA0KY21kbGluZS5jIHRvIHdoaWNoIHlvdSByZWZlciBhYm92ZSBpcyBubyBsb25nZXIgZXh0
YW50IGluIG1lbW9yeS4NCg0KSWYgbXkgdXNhZ2Ugb2YgdGhlIHRlcm0gImVhcmx5IGJvb3QiIGlz
IGEgbWlzbm9tZXIsIEkgY2FuIG9ubHkgDQphcG9sb2dpemUuICBBbmQgYXNrIHdoYXQgdGVybSBp
cyBpbiBjb21tb24gdXNlIHRvIGRlc2NyaWJlIHdoYXQgaXMgDQpoYXBwZW5pbmcgYXQgdGhhdCBw
b2ludCBpbiB0aW1lLg0KDQpTaW5jZSwgZm9yIHRoaXMgZGlzY3Vzc2lvbiwgd2UncmUgYWxyZWFk
eSBpbiBzdGFydF9rZXJuZWwoKSwgdGhlIG9ubHkgDQpjbWRsaW5lLmMgYXZhaWxhYmxlIGlzIHRo
ZSBvbmUgaW4gYXJjaC94ODYvbGliLiBUaGF0J3MgdGhhdCBvbmUgdGhhdCBpcyANCmluc3RydW1l
bnRlZCBieSBLQVNBTiwgYW5kIHRoZSBvbmUgdGhhdCBpcyBjYXVzaW5nIHByb2JsZW1zIGluIHRo
aXMgDQpzY2VuYXJpby4gVGhlIHN0cm5jbXAoKSwgdG9vLg0KDQogPj4gUmlnaHQuIE15IGdvYWwg
d2FzIHRvIGdldCBhIGNvbnZlcnNhdGlvbiBzdGFydGVkLCBiZWNhdXNlIGZvbGtzIGFyZQ0KID4+
IHJ1bm5pbmcgaW50byB0aGlzIHByb2JsZW0gd2hlbiBLQVNBTiBpcyBlbmFibGVkLg0KID4NCiA+
IFlvdSBzYXkgS0FTQU4uIFdoeSBpcyB0aGVyZSBLQ09WX0lOU1RSVU1FTlRfY21kbGluZS5vIHRv
bz8NCg0KSSBkb24ndCBjYXJlIGlmIEtDT1ZfSU5TVFJVTUVOVCBpcyBlbmFibGVkIG9yIG5vdCwg
YnV0IGl0J3MgZGlzYWJsZWQgZm9yIA0KYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfaWRlbnRpdHku
Yywgc28gaXQgc2VlbXMgcmVhc29uYWJsZSB0aGF0IGl0IA0Kc2hvdWxkIGJlIGRpc2FibGUgZm9y
IHRoaXMgZmlsZSwgdG9vLCBpbiB0aGUgY29udGV4dCBvZiByZXNvbHZpbmcgdGhpcyANCnByb2Js
ZW0uDQoNClRvIGJlIG1vcmUgcHJlY2lzZSwgdGhlIGNoYW5nZSBpcyBmb3IgImluc3RydW1lbnRh
dGlvbiIsIGluIGdlbmVyYWwuDQoNCg0KID4+IE4uQi4gSGVyZSdzIGFub3RoZXIgZmFjZXQgb2Yg
dGhpcyBwcm9ibGVtOiBjbWRsaW5lLmMgZG9lc24ndCAodG9kYXkpDQogPj4gY29udGFpbiBhbnl0
aGluZyB0aGF0IHdvdWxkIHRyaWdnZXIgdGhlIHN0YWNrIHByb3RlY3Rvci4gSG93ZXZlciwgaXQn
cw0KID4+IHBvc3NpYmxlIHRvIGVuYWJsZSB0aGUgc3RhY2sgcHJvdGVjdG9yIGdsb2JhbGx5IHdo
ZW4gYnVpbGRpbmcsIHJpZ2h0PyBJbg0KID4+IHdoaWNoIGNhc2UsIGEgYm9vdCB3b3VsZCBmYWls
LCBzbyB3ZSBoYXZlIHRoZSBzYW1lIGlzc3VlOiBlYXJseSBib290DQogPj4gY29kZSBoYXMgc3Bl
Y2lhbCByZXF1aXJlbWVudHMgLyByZXN0cmljdGlvbnMuDQogPg0KID4gSG93IHNvPw0KDQo8c2lk
ZWJhcj4NCk1ha2VmaWxlIGNvbnRhaW5zDQoNCiAgICAgc3RhY2twLWZsYWdzLSQoQ09ORklHX1NU
QUNLUFJPVEVDVE9SKSAgICAgICAgICAgICA6PSAtZnN0YWNrLXByb3RlY3Rvcg0KICAgICBzdGFj
a3AtZmxhZ3MtJChDT05GSUdfU1RBQ0tQUk9URUNUT1JfU1RST05HKSAgICAgIDo9IA0KLWZzdGFj
ay1wcm90ZWN0b3Itc3Ryb25nDQoNClRoaXMgbWVhbnMgdGhhdCAoYXMgSSB1bmRlcnN0YW5kIGl0
KSBzdGFjayBwcm90ZWN0aW9uIGlzIGRlY2lkZWQgYnkgdGhlIA0KY29tcGlsZXIsIGFuZCBpcyBi
YXNlZCBvbiBjZXJ0YWluIGNvbmRpdGlvbnMgaW4gdGhlIGNvZGUuIFRoaXMgaW1wbGllcyANCnRo
YXQgbm90IGV2ZXJ5IGZ1bmN0aW9uIHdpbGwgbmVjZXNzYXJpbHkgYmUgaW5zdHJ1bWVudGVkLg0K
DQpIb3dldmVyLCBpZiB5b3UgZGVjaWRlIHRvIGZvcmNlIHRoZSBpc3N1ZSB3aXRoIHNvbWV0aGlu
ZyBsaWtlDQoNCiAgICAgc3RhY2twLWZsYWdzLSQoQ09ORklHX1NUQUNLUFJPVEVDVE9SKSAgICAg
ICAgICAgICA6PSANCi1mc3RhY2stcHJvdGVjdG9yLWZ1bGwNCiAgICAgc3RhY2twLWZsYWdzLSQo
Q09ORklHX1NUQUNLUFJPVEVDVE9SX1NUUk9ORykgICAgICA6PSANCi1mc3RhY2stcHJvdGVjdG9y
LWFsbA0KDQpVbmxlc3Mgb3RoZXJ3aXNlIGRpc2FibGVkLCBJIGJlbGlldmUgdGhpcyBjYXVzZXMg
ZXZlcnl0aGluZyB0byBiZSANCmluc3RydW1lbnRlZC4gIFdoaWNoIHJlc3VsdHMgaW4gYSBib290
IGZhaWx1cmUuIChBY3R1YWxseSwgaW4gbXkgdGVzdHMgDQp0aGUgc3lzdGVtIHJlc3RhcnRzIGFm
dGVyIHRoZSBkZWNvbXByZXNzaW9uLikgTm90ZSB0aGF0IGludHJ1bWVudGF0aW9uIA0Kc3VjaCBh
cyBLQVNBTiBpc24ndCBpbnZvbHZlZCBoZXJlLiBBbmQgSSBmaWd1cmUgdGhhdCBkb2luZyB0aGlz
IGlzIA0KdW5zdXBwb3J0ZWQuIEl0IHdhcyBqdXN0IGFuIGludGVyZXN0aW5nIGRpc2NvdmVyeS4N
Cjwvc2lkZWJhcj4NCg0KSG93ZXZlciwgbm90IHJlbGV2YW50IHRvIHRoZSBLQVNBTiBpbnN0cnVt
ZW50YXRpb24gcHJvYmxlbS4NCg0KUmVjYXA6DQoNCm1lbV9lbmNyeXB0X2lkZW50aXR5LmMgdXNl
cyB0d28gY29tbW9uIGZ1bmN0aW9ucy4gVGhlIGNvZGUgaW4gDQptZW1fZW5jcnlwdF9pZGVudGl0
eS5jIHJ1bnMgc29vbiBhZnRlciBzdGFydF9rZXJuZWwoKSBpcyBpbnZva2VkLiBUaGUgDQpTTUUg
ZmVhdHVyZSBjb21tYW5kIGxpbmUgcGFyYW1ldGVyIGlzIHNlYXJjaGVkIGZvciwgYW5kIHVzZXMg
dGhvc2UgdHdvIA0KY29tbW9uIGZ1bmN0aW9ucy4NCg0KSWYgaW5zdHJ1bWVudGF0aW9uIGlzIGVu
YWJsZWQsIGl0IGlzIGFwcGxpZWQgdG8gdGhvc2UgdG8gY29tbW9uIA0KZnVuY3Rpb25zIChidXQg
bm90IG1lbV9lbmNyeXB0X2lkZW50aXR5LmMpLiBCdXQgaWYgc3VwcG9ydCANCmluZnJhc3RydWN0
dXJlIGZvciBpbnN0cnVtZW50YXRpb24gaXMgbm90IGluaXRpYWxpemVkIGJlZm9yZSB0aGUgY29k
ZSBpbiANCm1lbV9lbmNyeXB0X2lkZW50aXR5IGlzIGludm9rZWQsIHRoZSBrZXJuZWwgZmFpbHMg
dG8gYm9vdC4NCg0KQWZ0ZXIgZGlzY3Vzc2lvbiBvdmVyIHNldmVyYWwgd2Vla3MsIHdlIHNlZSB0
aGUgZm9sbG93aW5nIG9wdGlvbnMgZm9yIGEgDQpzb2x1dGlvbjoNCg0KMSkgQ3JlYXRlIGEgbG9j
YWwgc3RhdGljIGNvcHkgb2Ygc3RybmNtcCBpbiBtZW1fZW5jcnlwdF9pZGVudGl0eS5jDQoNCjIp
IFR1cm4gb2ZmIGluc3RydW1lbnRhdGlvbiBmb3IgbGliL2NtZGxpbmUuYy4gVGhlIHJpc2sgaXMg
dGhhdCBhbnkNCiAgICBjaGFuZ2VzIHRvIGl0cyBjb2RlIHdvdWxkIG5vdCBlbmpveSB0aGUgYmVu
ZWZpdHMgb2YgS0FTQU4vZXRjIHRlc3RpbmcNCiAgICAoaWYgZW5hYmxlZCkuDQoNCjMpIE1ha2Ug
YSBsb2NhbCBzdGF0aWMgY29weSBvZiBjbWRsaW5lX2ZpbmRfb3B0aW9uKCkgaW5zaWRlIG9mDQog
ICAgbWVtX2VuY3J5cHRfaWRlbnRpdHkuYy4NCg0KNCkgVXNlICNkZWZpbmVzIGFuZCAjaW5jbHVk
ZSB0byBoYXZlIGNtZGxpbmUuYyBpbmNsdWRlZCB3aXRoaW4NCiAgICBtZW1fZW5jcnlwdF9pZGVu
dGl0eS5jLiBUaGlzIG1haW50YWlucyBhIHNpbmdsZSBzb3VyY2UgZmlsZSBhbmQNCiAgICBjb250
aW51ZXMgdG8gYWxsb3cgdGhlIGZ1bmN0aW9uIHRvIGJlIGluc3RydW1lbnRlZCBmb3IgdXNlIGV2
ZXJ5d2hlcmUNCiAgICBlbHNld2hlcmUgaW4gdGhlIGtlcm5lbC4NCg0KV2UgYmVsaWV2ZSAoMSkg
aXMgYSBzaW1wbGUgYW5kIGVmZmVjdGl2ZSBjaG9pY2UsIHNpbWlsYXIgdG8gaW5saW5pbmcuDQoN
CklmIGEgc2luZ2xlIHNvdXJjZSBmaWxlIChmb3IgY21kbGluZS5jKSBpcyBwcmVmZXJyZWQsIG9w
dGlvbiAoNCkgDQptYWludGFpbnMgdGhhdCBwYXJhZGlnbSBidXQgZ2V0cyB0aGUgam9iIGRvbmUg
ZmFpcmx5IGNsZWFubHkuIEkgDQp1bmRlcnN0YW5kIGlmIHRoZXJlIGlzIHJldGljaWVuY2UgYWJv
dXQgaW5jbHVkZSBzb3VyY2UgZmlsZXMsIGJ1dCBpdCdzIA0Kbm90IElNTyBhbiBhYmhvcnJlbnQg
cHJhY3RpY2UuIFRoaXMgYWxzbyBwb2ludHMgdG8gYSBzaW5nbGUgZmlsZSBhcyB0aGUgDQpvcmln
aW4gb2YgdGhlIHJlcXVpcmVkIGZ1bmN0aW9uLCBzbyBubyBjb25mdXNpb24gZW5zdWVzLg0KDQpJ
IGJlbGlldmUgVEdMWCByYWlzZWQgdGhlIGlzc3VlIG9mICJ3aGF0IGhhcHBlbnMgaWYgd2UgZmlu
ZCBhIGJ1ZyBpbiANCmNtZGxpbmVfZmluZF9vcHRpb24oKT8iIERlc3BpdGUgdGhlIGZhY3QgdGhh
dCB0aGUgZmlsZSBoYXMgYmVlbiBjaGFuZ2VkIA0Kb25seSBvbmNlIGluIDQgeWVhcnMgKGJ5IFRo
b21hcykgaXQncyBhbiBpbXBvcnRhbnQgY29uc2lkZXJhdGlvbi4gDQpBbm90aGVyIHJlYXNvbiBJ
IGxlYW4gdG93YXJkcyAoNCksIGFib3ZlLg0KDQpJJ20gLWhvcGluZy0gdGhpcyBpcyBtb3JlIGNs
ZWFyIGFuZCBzdWNjaW5jdC4gSG93IHNoYWxsIHdlIHByb2NlZWQ/DQo=
