Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B86DC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2FA26F85
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Y5RkT77v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfEaWHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 18:07:52 -0400
Received: from mail-eopbgr710078.outbound.protection.outlook.com ([40.107.71.78]:57178
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfEaWHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 18:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Um6hG2H8FOsQLxaq9oAIdjJSb5X2JHYFkNkkq5+7A0=;
 b=Y5RkT77vEKveNSv1BdZr004c+Y0n28UJMXGHQhb/UpnJ+8gZfuuzGad4ukQVvWdKR7VJurpKzjL258FgmTHcILXYLUsiVuHkdOeJnQtDXqX2esJn94K6TpbE7g6sBGe/WC8qSZLULiPjsGtLYDoJR1L8/C34zZg1oAuQAibHm/k=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4231.namprd05.prod.outlook.com (52.135.200.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.13; Fri, 31 May 2019 22:07:46 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 22:07:46 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
Thread-Topic: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
Thread-Index: AQHVF3tKnfrC/xKd0kyiVp6wMVDUEqaFvMuAgAAFIICAAAPtAIAABb2A
Date:   Fri, 31 May 2019 22:07:46 +0000
Message-ID: <67BFA611-F69E-4AE4-A03F-2EF546DC291A@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
 <20190531063645.4697-12-namit@vmware.com>
 <CALCETrU0=BpGy5OQezQ7or33n-EFgBVDNe5g8prSUjL2SoRAwA@mail.gmail.com>
 <5F153080-D7A7-4054-AB4A-AEDD5F82E0B9@vmware.com>
 <48CECB5C-CA5B-4AD0-9DA5-6759E8FEDED7@amacapital.net>
In-Reply-To: <48CECB5C-CA5B-4AD0-9DA5-6759E8FEDED7@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c83ed37c-9c52-403b-3281-08d6e6146998
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR05MB4231;
x-ms-traffictypediagnostic: BYAPR05MB4231:
x-microsoft-antispam-prvs: <BYAPR05MB4231891959D4E723CB978CBBD0190@BYAPR05MB4231.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(478600001)(102836004)(82746002)(8676002)(8936002)(53546011)(81156014)(6506007)(6246003)(14454004)(36756003)(66476007)(91956017)(73956011)(64756008)(66446008)(76116006)(66556008)(66946007)(53936002)(76176011)(6916009)(305945005)(81166006)(2616005)(476003)(486006)(99286004)(83716004)(186003)(11346002)(66066001)(7736002)(71200400001)(71190400001)(446003)(68736007)(3846002)(86362001)(6116002)(2906002)(6512007)(7416002)(14444005)(229853002)(54906003)(6486002)(6436002)(25786009)(26005)(33656002)(256004)(4326008)(5660300002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4231;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FMISpb0fZ3bE58IPlqjmCEm3Oyb3Mlh33Qa3x++QwojCT8znWi3Ur5HF+uVhMinVwbkSlYN2SYObu1uKuyqwCODmjioBp7QdmfojLIHrn/iJEd7E6rWksj+jiUTZx/Ah71EcTEwpWbuV+qYFClkIcGEpvaaGjy31L+Tu3m0bBu6GdrMGHYCpE8dVLQTzowK9f3Q7yDXOIAOFtW0Roi7CevovfyfZaex6Nx4UdajhzbFX8AoVx1MF2VrwS4kTVzS85JjvtimHpqseodx5xO/cn4CAUC3aZlhCujkLrQEaQ5qx4xPNcnoHbULd1lB4p2swb8axDAh2Nre9dBP2IZjNRKWxPoIoKvKKQ7rncMDVyIdY5szgSltAunr/xi+olLbaadI3SQAhbhOXzYVLgS/R6OumXN87dIl6GgxTQh+NSs0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EDFCCCF4A94F74589B706F93DD2CFB6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83ed37c-9c52-403b-3281-08d6e6146998
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 22:07:46.3850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXkgMzEsIDIwMTksIGF0IDI6NDcgUE0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BhbWFj
YXBpdGFsLm5ldD4gd3JvdGU6DQo+IA0KPiANCj4gT24gTWF5IDMxLCAyMDE5LCBhdCAyOjMzIFBN
LCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4gDQo+Pj4gT24gTWF5IDMx
LCAyMDE5LCBhdCAyOjE0IFBNLCBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4gd3Jv
dGU6DQo+Pj4gDQo+Pj4+IE9uIFRodSwgTWF5IDMwLCAyMDE5IGF0IDExOjM3IFBNIE5hZGF2IEFt
aXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+PiBXaGVuIHdlIGZsdXNoIHVzZXJzcGFj
ZSBtYXBwaW5ncywgd2UgY2FuIGRlZmVyIHRoZSBUTEIgZmx1c2hlcywgYXMgbG9uZw0KPj4+PiB0
aGUgZm9sbG93aW5nIGNvbmRpdGlvbnMgYXJlIG1ldDoNCj4+Pj4gDQo+Pj4+IDEuIE5vIHRhYmxl
cyBhcmUgZnJlZWQsIHNpbmNlIG90aGVyd2lzZSBzcGVjdWxhdGl2ZSBwYWdlIHdhbGtzIG1pZ2h0
DQo+Pj4+IGNhdXNlIG1hY2hpbmUtY2hlY2tzLg0KPj4+PiANCj4+Pj4gMi4gTm8gb25lIHdvdWxk
IGFjY2VzcyB1c2Vyc3BhY2UgYmVmb3JlIGZsdXNoIHRha2VzIHBsYWNlLiBTcGVjaWZpY2FsbHks
DQo+Pj4+IE5NSSBoYW5kbGVycyBhbmQga3Byb2JlcyB3b3VsZCBhdm9pZCBhY2Nlc3NpbmcgdXNl
cnNwYWNlLg0KPj4+IA0KPj4+IEkgdGhpbmsgSSBuZWVkIHRvIGFzayB0aGUgYmlnIHBpY3R1cmUg
cXVlc3Rpb24uICBXaGVuIHNvbWVvbmUgY2FsbHMNCj4+PiBmbHVzaF90bGJfbW1fcmFuZ2UoKSAo
b3IgdGhlIG90aGVyIGVudHJ5IHBvaW50cyksIGlmIG5vIHBhZ2UgdGFibGVzDQo+Pj4gd2VyZSBm
cmVlZCwgdGhleSB3YW50IHRoZSBndWFyYW50ZWUgdGhhdCBmdXR1cmUgYWNjZXNzZXMgKGluaXRp
YXRlZA0KPj4+IG9ic2VydmFibHkgYWZ0ZXIgdGhlIGZsdXNoIHJldHVybnMpIHdpbGwgbm90IHVz
ZSBwYWdpbmcgZW50cmllcyB0aGF0DQo+Pj4gd2VyZSByZXBsYWNlZCBieSBzdG9yZXMgb3JkZXJl
ZCBiZWZvcmUgZmx1c2hfdGxiX21tX3JhbmdlKCkuICBXZSBhbHNvDQo+Pj4gbmVlZCB0aGUgZ3Vh
cmFudGVlIHRoYXQgYW55IGVmZmVjdHMgZnJvbSBhbnkgbWVtb3J5IGFjY2VzcyB1c2luZyB0aGUN
Cj4+PiBvbGQgcGFnaW5nIGVudHJpZXMgd2lsbCBiZWNvbWUgZ2xvYmFsbHkgdmlzaWJsZSBiZWZv
cmUNCj4+PiBmbHVzaF90bGJfbW1fcmFuZ2UoKS4NCj4+PiANCj4+PiBJJ20gd29uZGVyaW5nIGlm
IHJlY2VpcHQgb2YgYW4gSVBJIGlzIGVub3VnaCB0byBndWFyYW50ZWUgYW55IG9mIHRoaXMuDQo+
Pj4gSWYgQ1BVIDEgc2V0cyBhIGRpcnR5IGJpdCBhbmQgQ1BVIDIgd3JpdGVzIHRvIHRoZSBBUElD
IHRvIHNlbmQgYW4gSVBJDQo+Pj4gdG8gQ1BVIDEsIGF0IHdoYXQgcG9pbnQgaXMgQ1BVIDIgZ3Vh
cmFudGVlZCB0byBiZSBhYmxlIHRvIG9ic2VydmUgdGhlDQo+Pj4gZGlydHkgYml0PyAgQW4gaW50
ZXJydXB0IGVudHJ5IHRvZGF5IGlzIGZ1bGx5IHNlcmlhbGl6aW5nIGJ5IHRoZSB0aW1lDQo+Pj4g
aXQgZmluaXNoZXMsIGJ1dCBpbnRlcnJ1cHQgZW50cmllcyBhcmUgZXBpY2x5IHNsb3csIGFuZCBJ
IGRvbid0IGtub3cNCj4+PiBpZiB0aGUgQVBJQyB3YWl0cyBsb25nIGVub3VnaC4gIEhlY2ssIHdo
YXQgaWYgSVJRcyBhcmUgb2ZmIG9uIHRoZQ0KPj4+IHJlbW90ZSBDUFU/ICBUaGVyZSBhcmUgYSBo
YW5kZnVsIG9mIHBsYWNlcyB3aGVyZSB3ZSB0b3VjaCB1c2VyIG1lbW9yeQ0KPj4+IHdpdGggSVJR
cyBvZmYsIGFuZCBpdCdzIChzYWRseSkgcG9zc2libGUgZm9yIHVzZXIgY29kZSB0byB0dXJuIG9m
Zg0KPj4+IElSUXMgd2l0aCBpb3BsKCkuDQo+Pj4gDQo+Pj4gSSAqdGhpbmsqIHRoYXQgSW50ZWwg
aGFzIHN0YXRlZCByZWNlbnRseSB0aGF0IFNNVCBzaWJsaW5ncyBhcmUNCj4+PiBndWFyYW50ZWVk
IHRvIHN0b3Agc3BlY3VsYXRpbmcgd2hlbiB5b3Ugd3JpdGUgdG8gdGhlIEFQSUMgSUNSIHRvIHBv
a2UNCj4+PiB0aGVtLCBidXQgU01UIGlzIHZlcnkgc3BlY2lhbC4NCj4+PiANCj4+PiBNeSBnZW5l
cmFsIGNvbmNsdXNpb24gaXMgdGhhdCBJIHRoaW5rIHRoZSBjb2RlIG5lZWRzIHRvIGRvY3VtZW50
IHdoYXQNCj4+PiBpcyBndWFyYW50ZWVkIGFuZCB3aHkuDQo+PiANCj4+IEkgdGhpbmsgSSBtaWdo
dCBoYXZlIG1hbmFnZWQgdG8gY29uZnVzZSB5b3Ugd2l0aCBhIGJ1ZyBJIG1hZGUgKGxhc3QgbWlu
dXRlDQo+PiBidWcgd2hlbiBJIHdhcyBkb2luZyBzb21lIGNsZWFudXApLiBUaGlzIGJ1ZyBkb2Vz
IG5vdCBhZmZlY3QgdGhlIHBlcmZvcm1hbmNlDQo+PiBtdWNoLCBidXQgaXQgbWlnaHQgbGVkIHlv
dSB0byB0aGluayB0aGF0IEkgdXNlIHRoZSBBUElDIHNlbmRpbmcgYXMNCj4+IHN5bmNocm9uaXph
dGlvbi4NCj4+IA0KPj4gVGhlIGlkZWEgaXMgbm90IGZvciB1cyB0byByZWx5IG9uIHdyaXRlIHRv
IElDUiBhcyBzb21ldGhpbmcgc2VyaWFsaXppbmcuIFRoZQ0KPj4gZmxvdyBzaG91bGQgYmUgYXMg
Zm9sbG93czoNCj4+IA0KPj4gDQo+PiAgIENQVTAgICAgICAgICAgICAgICAgICAgIENQVTENCj4+
IA0KPj4gZmx1c2hfdGxiX21tX3JhbmdlKCkNCj4+IF9fc21wX2NhbGxfZnVuY3Rpb25fbWFueSgp
DQo+PiBbIHByZXBhcmUgY2FsbF9zaW5nbGVfZGF0YSAoY3NkKSBdDQo+PiBbIGxvY2sgY3NkIF0g
DQo+PiBbIHNlbmQgSVBJIF0NCj4+ICAgKCopDQo+PiBbIHdhaXQgZm9yIGNzZCB0byBiZSB1bmxv
Y2tlZCBdDQo+PiAgICAgICAgICAgICAgICAgICBbIGludGVycnVwdCBdDQo+PiAgICAgICAgICAg
ICAgICAgICBbIGNvcHkgY3NkIGluZm8gdG8gc3RhY2sgXQ0KPj4gICAgICAgICAgICAgICAgICAg
WyBjc2QgdW5sb2NrIF0NCj4+IFsgZmluZCBjc2QgaXMgdW5sb2NrZWQgXQ0KPj4gWyBjb250aW51
ZSAoKiopIF0NCj4+ICAgICAgICAgICAgICAgICAgIFsgZmx1c2ggVExCIF0NCj4+IA0KPj4gDQo+
PiBBdCAoKiopIHRoZSBwYWdlcyBtaWdodCBiZSByZWN5Y2xlZCwgd3JpdHRlbi1iYWNrIHRvIGRp
c2ssIGV0Yy4gTm90ZSB0aGF0DQo+PiBkdXJpbmcgKCopLCBDUFUwIG1pZ2h0IGRvIHNvbWUgbG9j
YWwgVExCIGZsdXNoZXMsIG1ha2luZyBpdCB2ZXJ5IGxpa2VseSB0aGF0DQo+PiBDU0Qgd2lsbCBi
ZSB1bmxvY2tlZCBieSB0aGUgdGltZSBpdCBnZXRzIHRoZXJlLg0KPj4gDQo+PiBBcyB5b3UgY2Fu
IHNlZSwgSSBkb27igJl0IHJlbHkgb24gYW55IHNwZWNpYWwgbWljcm8tYXJjaGl0ZWN0dXJhbCBi
ZWhhdmlvci4NCj4+IFRoZSBzeW5jaHJvbml6YXRpb24gaXMgZG9uZSBwdXJlbHkgaW4gc29mdHdh
cmUuDQo+PiANCj4+IERvZXMgaXQgbWFrZSBtb3JlIHNlbnNlIG5vdz8NCj4gDQo+IFllcy4gIEhh
dmUgeW91IGJlbmNobWFya2VkIHRoaXM/DQoNClBhcnRpYWxseS4gTnVtYmVycyBhcmUgaW5kZWVk
IHdvcnNlLiBIZXJlIGFyZSBwcmVsaW1pbmFyeSByZXN1bHRzLCBjb21wYXJpbmcNCnRvIHYxIChj
b25jdXJyZW50KToNCg0KCW5fdGhyZWFkcwliZWZvcmUJCWNvbmN1cnJlbnQJK2FzeW5jDQoJLS0t
LS0tLS0tCS0tLS0tLQkJLS0tLS0tLS0tLSAJLS0tLS0tDQoJMQkJNjYxCQk2NjMJCTY2Mw0KCTIJ
CTE0MzYJCTEyMjUgKC0xNCUpCTExMTUgKC0yMiUpDQoJNAkJMTU3MQkJMTQyMSAoLTEwJSkJMTI4
OSAoLTE4JSkNCg0KTm90ZSB0aGF0IHRoZSBiZW5lZml0IG9mIOKAnGFzeW5jIiB3b3VsZCBiZSBn
cmVhdGVyIGlmIHRoZSBpbml0aWF0b3IgZG9lcyBub3QNCmZsdXNoIHRoZSBUTEIgYXQgYWxsLiBU
aGlzIG1pZ2h0IGhhcHBlbiBpbiB0aGUgY2FzZSBvZiBrc3dhcGQsIGZvciBleGFtcGxlLg0KTGV0
IG1lIHRyeSBzb21lIG1pY3JvLW9wdGltaXphdGlvbnMgZmlyc3QsIHJ1biBtb3JlIGJlbmNobWFy
a3MgYW5kIGdldCBiYWNrDQp0byB5b3UuDQoNCg==
