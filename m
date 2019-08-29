Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7EAC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604FF2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="H0dh2Gp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfH2RYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:24:02 -0400
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:59397
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfH2RYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:24:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUHoq7abjHj/bm9LDue7I+ZqXH6z6mJkUDBGIKBGBbIQFVgI1IFccf5gsDjfZqQj2L8+18PU8iUQoRRrKExfUTTvNgEqcBtbLZwza78xq7zdpatCHcZ8hLe20MxmDQdtnCCZ5ocIPI6BWUu9M6TOszKa3BHxTvpGyOHu/Nl6qI7W4kJJxAqrwCa2y/4XBlr7G1L7Vu5G8VbSllzxcMO3DDlzc1xCLEJMNj5DCVmkMCDQnNJ8P/y+WnFYDJrLPaMRSF+AMG5lgNe6b+0EKcqYYuFb2ug/A36AgTptIZXWX63Mt/owk+eAkktghaRFJDfnAnb+4I/6CFkA/SII1il1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuTmygIflsjKDcNUMaKzUt6cO60A0tu8hQBmUxLwffQ=;
 b=YqTABu0hwcnd9YWpXBPBhpQ9YbJjfP12JB7W0uSHqf9XHsliiyCCQx0eBMMfIRZC3x+S1m0Vm5LhvGP1t1GcNpnFRgTCflH3QQwlsjKQCCZg5B5cS14+F2or43CQA+IPvymbAN2FQplYgoiTP2jAbrlSdyoVZ96eykyZiPho/RWCXdvKTfjFtZS6QB+ik0mGvNXYNpkuA+HaVOL1XfmioVZ3H7Fs23BSx1ppBNLnVG7ufwRyWPQ2DVssKSVwQ3zldoukhh60wFjVHHrcZeIL/6BtMhFuXrrzDt5W4t+aFZKfkfWvBx0NgQZ81usDw3ST6K3C4TfD3fj39Lgj2RKWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuTmygIflsjKDcNUMaKzUt6cO60A0tu8hQBmUxLwffQ=;
 b=H0dh2Gp0amtW602uV5mrMISpkPD7HGwypxBt5GyaYLrdZ/gWBoRKxPejYyfFW77vBULzi8aY04t4+oOZu6V4v0VWPUCXGNtek7xOcmSlvtAEFHzatD2ATenSbfXzDaHPgvftiZaTn9KpgqEJlTweGwmU9Y6w6Otcp0tF5C5A3/A=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6165.namprd05.prod.outlook.com (20.178.55.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.14; Thu, 29 Aug 2019 17:23:58 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d%3]) with mapi id 15.20.2220.013; Thu, 29 Aug 2019
 17:23:58 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH 0/3] x86/mm/tlb: Defer TLB flushes with PTI
Thread-Topic: [RFC PATCH 0/3] x86/mm/tlb: Defer TLB flushes with PTI
Thread-Index: AQHVWkIzB+rt1FAQ7UGGXVX7777Ek6cPpvuAgAAJjwCAAApmgIACrZ+A
Date:   Thu, 29 Aug 2019 17:23:58 +0000
Message-ID: <A960DD27-C10F-4332-971B-2339A27728C3@vmware.com>
References: <20190823224635.15387-1-namit@vmware.com>
 <CALCETrX+h7FeyY290kvYRHAjMVDrmHivc55g+o0hnXrmm-wZRw@mail.gmail.com>
 <3989CBFF-F1C1-4F64-B8C4-DBFF80997857@vmware.com>
 <CALCETrWsbay9YRuTXuAW9HD+GjXr7jVN367afG2VKRCZ-TtJ+Q@mail.gmail.com>
In-Reply-To: <CALCETrWsbay9YRuTXuAW9HD+GjXr7jVN367afG2VKRCZ-TtJ+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7f7bea1-a9a8-48c0-7de9-08d72ca5ad23
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR05MB6165;
x-ms-traffictypediagnostic: BYAPR05MB6165:
x-microsoft-antispam-prvs: <BYAPR05MB61657DE7102E3A5D3E193CC7D0A20@BYAPR05MB6165.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(6246003)(71200400001)(6512007)(186003)(86362001)(54906003)(36756003)(5660300002)(229853002)(53936002)(25786009)(76176011)(2906002)(4326008)(3846002)(26005)(6116002)(6436002)(6486002)(66066001)(8936002)(478600001)(81166006)(486006)(8676002)(81156014)(2616005)(64756008)(66446008)(66556008)(76116006)(476003)(11346002)(66476007)(66946007)(6916009)(99286004)(446003)(53546011)(305945005)(6506007)(14444005)(33656002)(7736002)(256004)(316002)(14454004)(102836004)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6165;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AfryhoAM9qYSsjEdFq2aWRhxDEgPLzlXpdLFpfCXQX94afK7dB6mJBuVepxOXFXoXEY/Y04mWC3KhpEBPUY1dQ9H8rz/7Q3BIQJkel/ByLbHXZnoGvwptpYo0oDB2MQNE7XsM16SSSB26cdPtn7eMYc5YVBOR3ln9ISjAtwcTO4oRdtBmVDMJ8o9UMQJlKU1FuFrijoX2279QeYTJ3LEkpLXA1BI1j46p5nKzYlSfX1szXn7KjZpuvQ/cQ264PH4W9zVkW4jUmiZg6GyEfPiXZ0eVn/iJfhfk81OUVLyIJTRxRXWuz+XJogRSpUVRdMxpgFbqg3MfjNbBkZAkEIoHJ4RgqbBFzQMQZUUXxvwE5mu9RmGrCUHoRFRGFWL2HBfLbPN939K1n1iThmYOH12rgWm4UUx3HblC5f9MVTEjOY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B0F78253E8FDD429A9429DA50655085@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f7bea1-a9a8-48c0-7de9-08d72ca5ad23
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 17:23:58.0196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8x15/6XdVQDDvRvAI3Af8qH/v+uwdWOhJ/at4G6vAEbNGFunL6Kk1t7b8PIP4T2rAcuX3FWS/08Scs0bool2rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBBdWcgMjcsIDIwMTksIGF0IDU6MzAgUE0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgQXVnIDI3LCAyMDE5IGF0IDQ6NTIgUE0gTmFk
YXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+Pj4gT24gQXVnIDI3LCAyMDE5LCBh
dCA0OjE4IFBNLCBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4g
DQo+Pj4gT24gRnJpLCBBdWcgMjMsIDIwMTkgYXQgMTE6MDcgUE0gTmFkYXYgQW1pdCA8bmFtaXRA
dm13YXJlLmNvbT4gd3JvdGU6DQo+Pj4+IElOVlBDSUQgaXMgY29uc2lkZXJhYmx5IHNsb3dlciB0
aGFuIElOVkxQRyBvZiBhIHNpbmdsZSBQVEUsIGJ1dCBpdCBpcw0KPj4+PiBjdXJyZW50bHkgdXNl
ZCB0byBmbHVzaCBQVEVzIGluIHRoZSB1c2VyIHBhZ2UtdGFibGUgd2hlbiBQVEkgaXMgdXNlZC4N
Cj4+Pj4gDQo+Pj4+IEluc3RlYWQsIGl0IGlzIHBvc3NpYmxlIHRvIGRlZmVyIFRMQiBmbHVzaGVz
IHVudGlsIGFmdGVyIHRoZSB1c2VyDQo+Pj4+IHBhZ2UtdGFibGVzIGFyZSBsb2FkZWQuIFByZXZl
bnRpbmcgc3BlY3VsYXRpb24gb3ZlciB0aGUgVExCIGZsdXNoZXMNCj4+Pj4gc2hvdWxkIGtlZXAg
dGhlIHdob2xlIHRoaW5nIHNhZmUuIEluIHNvbWUgY2FzZXMsIGRlZmVycmluZyBUTEIgZmx1c2hl
cw0KPj4+PiBpbiBzdWNoIGEgd2F5IGNhbiByZXN1bHQgaW4gbW9yZSBmdWxsIFRMQiBmbHVzaGVz
LCBidXQgYXJndWFibHkgdGhpcw0KPj4+PiBiZWhhdmlvciBpcyBvZnRlbnRpbWVzIGJlbmVmaWNp
YWwuDQo+Pj4gDQo+Pj4gSSBoYXZlIGEgc29tZXdoYXQgaG9ycmlibGUgc3VnZ2VzdGlvbi4NCj4+
PiANCj4+PiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIHJlZmFjdG9yIHRoaXMgc28gdGhhdCBpdCB3
b3JrcyBmb3IgdXNlciAqYW5kKg0KPj4+IGtlcm5lbCB0YWJsZXM/ICBJbiBwYXJ0aWN1bGFyLCBp
ZiB3ZSBmbHVzaCBhICprZXJuZWwqIG1hcHBpbmcgKHZmcmVlLA0KPj4+IHZ1bm1hcCwgc2V0X21l
bW9yeV9ybywgZXRjKSwgd2Ugc2hvdWxkbid0IG5lZWQgdG8gc2VuZCBhbiBJUEkgdG8gYQ0KPj4+
IHRhc2sgdGhhdCBpcyBydW5uaW5nIHVzZXIgY29kZSB0byBmbHVzaCBtb3N0IGtlcm5lbCBtYXBw
aW5ncyBvciBldmVuDQo+Pj4gdG8gZnJlZSBrZXJuZWwgcGFnZXRhYmxlcy4gIFRoZSBzYW1lIHRy
aWNrIGNvdWxkIGJlIGRvbmUgaWYgd2UgdHJlYXQNCj4+PiBpZGxlIGxpa2UgdXNlciBtb2RlIGZv
ciB0aGlzIHB1cnBvc2UuDQo+Pj4gDQo+Pj4gSW4gY29kZSwgdGhpcyBjb3VsZCBtb3N0bHkgY29u
c2lzdCBvZiBjaGFuZ2luZyBhbGwgdGhlICJ1c2VyIiBkYXRhDQo+Pj4gc3RydWN0dXJlcyBpbnZv
bHZlZCB0byBzb21ldGhpbmcgbGlrZSBzdHJ1Y3QgZGVmZXJyZWRfZmx1c2hfaW5mbyBhbmQNCj4+
PiBoYXZpbmcgb25lIGZvciB1c2VyIGFuZCBvbmUgZm9yIGtlcm5lbC4NCj4+PiANCj4+PiBJIHRo
aW5rIHRoaXMgaXMgaG9ycmlibGUgYmVjYXVzZSBpdCB3aWxsIGVuYWJsZSBjZXJ0YWluIHdvcmts
b2FkcyB0bw0KPj4+IHdvcmsgY29uc2lkZXJhYmx5IGZhc3RlciB3aXRoIFBUSSBvbiB0aGFuIHdp
dGggUFRJIG9mZiwgYW5kIHRoYXQgd291bGQNCj4+PiBiZSBhIGJhcmVseSBleGN1c2FibGUgbW9y
YWwgZmFpbGluZy4gOi1wDQo+Pj4gDQo+Pj4gRm9yIHdoYXQgaXQncyB3b3J0aCwgb3RoZXIgdGhh
biByZWdpc3RlciBjbG9iYmVyIGlzc3VlcywgdGhlIHdob2xlDQo+Pj4gInN3aXRjaCBDUjMgZm9y
IFBUSSIgbG9naWMgb3VnaHQgdG8gYmUgZG9hYmxlIGluIEMuICBJIGRvbid0IGtub3cgYQ0KPj4+
IHByaW9yaSB3aGV0aGVyIHRoYXQgd291bGQgZW5kIHVwIGJlaW5nIGFuIGltcHJvdmVtZW50Lg0K
Pj4gDQo+PiBJIGltcGxlbWVudGVkIChhbmQgaGF2ZSBub3QgeWV0IHNlbnQpIGFub3RoZXIgVExC
IGRlZmVycmluZyBtZWNoYW5pc20uIEl0IGlzDQo+PiBpbnRlbmRlZCBmb3IgdXNlciBtYXBwaW5n
cyBhbmQgbm90IGtlcm5lbCBvbmUsIGJ1dCBJIHRoaW5rIHlvdXIgc3VnZ2VzdGlvbg0KPj4gc2hh
cmVzIHNvbWUgc2ltaWxhciB1bmRlcmx5aW5nIHJhdGlvbmFsZSwgYW5kIHRoZXJlZm9yZSBjaGFs
bGVuZ2VzIGFuZA0KPj4gc29sdXRpb25zLiBMZXQgbWUgcmVwaHJhc2Ugd2hhdCB5b3Ugc2F5IHRv
IGVuc3VyZSB3ZSBhcmUgb24gdGhlIHNhbWUgcGFnZS4NCj4+IA0KPj4gVGhlIGJhc2ljIGlkZWEg
aXMgY29udGV4dC10cmFja2luZyB0byBjaGVjayB3aGV0aGVyIGVhY2ggQ1BVIGlzIGluIGtlcm5l
bCBvcg0KPj4gdXNlciBtb2RlLiBBY2NvcmRpbmdseSwgVExCIGZsdXNoZXMgY2FuIGJlIGRlZmVy
cmVkLCBidXQgSSBkb27igJl0IHNlZSB0aGF0DQo+PiB0aGlzIHNvbHV0aW9uIGlzIGxpbWl0ZWQg
dG8gUFRJLiBUaGVyZSBhcmUgMiBwb3NzaWJsZSByZWFzb25zLCBhY2NvcmRpbmcgdG8NCj4+IG15
IHVuZGVyc3RhbmRpbmcsIHRoYXQgeW91IGxpbWl0IHRoZSBkaXNjdXNzaW9uIHRvIFBUSToNCj4+
IA0KPj4gMS4gUFRJIHByb3ZpZGVzIGNsZWFyIGJvdW5kYXJpZXMgd2hlbiB1c2VyIGFuZCBrZXJu
ZWwgbWFwcGluZ3MgYXJlIHVzZWQuIEkNCj4+IGFtIG5vdCBzdXJlIHRoYXQgcHJpdmlsZWdlLWxl
dmVscyAoYW5kIFNNQVApIGRvIG5vdCBkbyB0aGUgc2FtZS4NCj4+IA0KPj4gMi4gQ1IzIHN3aXRj
aGluZyBhbHJlYWR5IGltcG9zZXMgYSBtZW1vcnkgYmFycmllciwgd2hpY2ggZWxpbWluYXRlcyBt
b3N0IG9mDQo+PiB0aGUgY29zdCBvZiBpbXBsZW1lbnRpbmcgc3VjaCBzY2hlbWUgd2hpY2ggcmVx
dWlyZXMgc29tZXRoaW5nIHdoaWNoIGlzDQo+PiBzaW1pbGFyIHRvOg0KPj4gDQo+PiAgICAgICAg
d3JpdGUgbmV3IGNvbnRleHQgKGtlcm5lbC91c2VyKQ0KPj4gICAgICAgIG1iKCk7DQo+PiAgICAg
ICAgaWYgKG5lZWRfZmx1c2gpIGZsdXNoOw0KPj4gDQo+PiBJIGRvIGFncmVlIHRoYXQgUFRJIGFk
ZHJlc3NlcyAoMiksIGJ1dCB0aGVyZSBpcyBhbm90aGVyIHByb2JsZW0uIEENCj4+IHJlYXNvbmFi
bGUgaW1wbGVtZW50YXRpb24gd291bGQgc3RvcmUgaW4gYSBwZXItY3B1IHN0YXRlIHdoZXRoZXIg
ZWFjaCBDUFUgaXMNCj4+IGluIHVzZXIva2VybmVsLCBhbmQgdGhlIFRMQiBzaG9vdGRvd24gaW5p
dGlhdG9yIENQVSB3b3VsZCBjaGVjayB0aGUgc3RhdGUgdG8NCj4+IGRlY2lkZSB3aGV0aGVyIGFu
IElQSSBpcyBuZWVkZWQuIFRoaXMgbWVhbnMgdGhhdCBwcmV0dHkgbXVjaCBldmVyeSBUTEINCj4+
IHNodXRkb3duIHdvdWxkIGluY3VyIGEgY2FjaGUtbWlzcyBwZXItdGFyZ2V0IENQVS4gVGhpcyBt
aWdodCBjYXVzZQ0KPj4gcGVyZm9ybWFuY2UgcmVncmVzc2lvbnMsIGF0IGxlYXN0IGluIHNvbWUg
Y2FzZXMuDQo+IA0KPiBXZSBhbHJlYWR5IG1vcmUgb3IgbGVzcyBkbyB0aGlzOiB3ZSBoYXZlIG1t
X2NwdW1hc2soKSwgd2hpY2ggaXMNCj4gcGFydGljdWxhcmx5IGF3ZnVsIHNpbmNlIGl0IHdyaXRl
cyB0byBhIGZhbHNlbHktc2hhcmVkIGxpbmUgZm9yIGVhY2gNCj4gY29udGV4dCBzd2l0Y2guDQoN
Cj4gRm9yIHdoYXQgaXQncyB3b3J0aCwgaW4gc29tZSBzZW5zZSwgeW91ciBwYXRjaCBzZXJpZXMg
aXMgcmVpbnZlbnRpbmcNCj4gdGhlIHRyYWNraW5nIHRoYXQgaXMgYWxyZWFkeSBpbiBjcHVfdGxi
c3RhdGUgLS0gd2hlbiB3ZSBkbyBhIGZsdXNoIG9uDQo+IG9uZSBtbSBhbmQgc29tZSBjcHUgaXMg
cnVubmluZyBhbm90aGVyIG1tLCB3ZSBkb24ndCBkbyBhbiBJUEkNCj4gc2hvb3Rkb3duIC0tIGlu
c3RlYWQgd2Ugc2V0IGZsYWdzIHNvIHRoYXQgaXQgd2lsbCBiZSBmbHVzaGVkIHRoZSBuZXh0DQo+
IHRpbWUgaXQncyB1c2VkLiAgTWF5YmUgd2UgY291bGQgYWN0dWFsbHkgcmVmYWN0b3IgdGhpcyBz
byB3ZSBvbmx5IGhhdmUNCj4gb25lIGNvcHkgb2YgdGhpcyBjb2RlIHRoYXQgaGFuZGxlcyBhbGwg
dGhlIHZhcmlvdXMgZGVmZXJyZWQgZmx1c2gNCj4gdmFyaWFudHMuICBQZXJoYXBzIGVhY2ggdHJh
Y2tlZCBtbSBjb250ZXh0IGNvdWxkIGhhdmUgYSB1c2VyDQo+IHRsYl9nZW5faWQgYW5kIGEga2Vy
bmVsIHRsYl9nZW5faWQuICBJIGd1ZXNzIG9uZSB0aGluZyB0aGF0IG1ha2VzIHRoaXMNCj4gbmFz
dHkgaXMgdGhhdCB3ZSBuZWVkIHRvIGZsdXNoIHRoZSBrZXJuZWwgUENJRCBmb3Iga2VybmVsICph
bmQqIHVzZXINCj4gaW52YWxpZGF0aW9ucy4gIFNpZ2guDQoNClNvcnJ5IGZvciB0aGUgbGF0ZSBy
ZXNwb25zZSAtIEkgd2FzIGZlZWxpbmcgdW5kZXIgdGhlIHdlYXRoZXIuDQoNClRoZXJlIGlzIGEg
dHJhZGVvZmYgYmV0d2VlbiBob3cgb2Z0ZW4gdGhlIHN0YXRlIGNoYW5nZXMgYW5kIGhvdyBvZnRl
biBpdCBpcw0KYmVpbmcgY2hlY2tlZC4gU28gYWN0dWFsbHksIHdpdGggdGhpcyBwYXRjaC1zZXQs
IHdlIGhhdmUgdGhyZWUgaW5kaWNhdGlvbnMNCm9mIGRlZmVycmVkIFRMQiBmbHVzaGVzOg0KDQox
LiBtbV9jcHVtYXNrKCksIHNpbmNlIG1tIGNoYW5nZXMgaW5mcmVxdWVudGx5DQoNCjIuIOKAnGlz
X2xhenkiLCB3aGljaCBjaGFuZ2VzIGZyZXF1ZW50bHksIG1ha2luZyBwZXItY3B1IGNhY2hlbGlu
ZSBjaGVja3MgbW9yZQ0KZWZmaWNpZW50IHRoYW4gKDEpLg0KDQozLiBEZWZlcnJlZC1QVEksIHdo
aWNoIGlzIG9ubHkgdXBkYXRlZCBsb2NhbGx5LiANCg0KVGhpcyBwYXRjaC1zZXQgb25seSBpbnRy
b2R1Y2VzICgzKS4gWW91ciBzdWdnZXN0aW9uLCBJSVVDLCBpcyB0byBzb21laG93DQpjb21iaW5l
ICgxKSBhbmQgKDIpLCB3aGljaCBJIHN1c3BlY3QgbWlnaHQgaW50cm9kdWNlIHNvbWUgcGVyZm9y
bWFuY2UNCnJlZ3Jlc3Npb25zLiBDaGFuZ2luZyBhIGNwdW1hc2ssIG9yIGV2ZW4gd3JpdGluZyB0
byBhIGNhY2hlbGluZSBvbiAqZXZlcnkqDQprZXJuZWwgZW50cnkvZXhpdCBjYW4gaW5kdWNlIG92
ZXJoZWFkcyAoaW4gdGhlIGxhdHRlciBjYXNlLCB3aGVuIHRoZQ0Kc2hvb3Rkb3duIGluaXRpYXRv
ciBjaGVja3Mgd2hldGhlciB0aGUgZmx1c2ggY2FuIGJlIGRlZmVycmVkKS4NCg0KSU9XLCBkZWZl
cnJpbmcgcmVtb3RlIFRMQiBzaG9vdGRvd25zIGlzIGhhcmQgc2luY2UgaXQgY2FuIGluZHVjZSBz
b21lDQpvdmVyaGVhZHMuIERlZmVycmluZyBsb2NhbCBUTEIgZmx1c2hlcyAob3IgdGhvc2UgdGhh
dCBpbml0aWF0ZWQgYnkgYSByZW1vdGUNCkNQVSwgYWZ0ZXIgdGhlIElQSSB3YXMgcmVjZWl2ZWQp
IGlzIGVhc3kuIEkgZGVmZXJyZWQgb25seSB0aGUgdXNlcg0KcGFnZS10YWJsZSBmbHVzaGVzLiBJ
ZiB5b3Ugd2FudCwgSSBjYW4gdHJ5IHRvIGV4dGVuZCBpdCB0byBhbGwgdXNlciBmbHVzaGVzLg0K
VGhpcyB3b3VsZCBpbnRyb2R1Y2Ugc29tZSBzbWFsbCBvdmVyaGVhZHMgKGNoZWNrIGJlZm9yZSBl
YWNoIHVhY2Nlc3MpIGFuZA0Kc21hbGwgZ2FpbnMuIERlZmVycmluZyBsb2NhbCBUTEIgZmx1c2hl
cyBpcyBpbmFwcGxpY2FibGUgZm9yIGtlcm5lbCBUTEINCmZsdXNoZXMsIG9mIGNvdXJzZS4NCg0K
TGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsuDQoNCg==
