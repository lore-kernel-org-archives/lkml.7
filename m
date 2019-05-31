Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531A7C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC3426E5D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="dFbcnBLJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfEaTbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:31:55 -0400
Received: from mail-eopbgr720051.outbound.protection.outlook.com ([40.107.72.51]:63744
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbfEaTby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDhLtdzdRKerx/TxvY63Zee33x0ifUIufDlO7cdXwjA=;
 b=dFbcnBLJVLX//kDxefmLruIVkEBTKwlzf2+AfSWpqUvbL1QyJ9gV88XiIeCH0r38WPQrsaJXSogkPuWA1Kbv6ftKkamwV/zro/FkMFN6j7sYX37T+DT5/ovvK6AaYdMscrULD5MY0YpGzvVyUgIVZedD7QJGmARMV0FqGg2iijo=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6663.namprd05.prod.outlook.com (20.178.235.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.10; Fri, 31 May 2019 19:31:10 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 19:31:10 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
Thread-Topic: [RFC PATCH v2 11/12] x86/mm/tlb: Use async and inline messages
 for flushing
Thread-Index: AQHVF3tKnfrC/xKd0kyiVp6wMVDUEqaFEHMAgACCTICAAA0WgA==
Date:   Fri, 31 May 2019 19:31:10 +0000
Message-ID: <82DB7035-D7BE-4D79-BBC0-B271FB4BF740@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
 <20190531063645.4697-12-namit@vmware.com>
 <20190531105758.GO2623@hirez.programming.kicks-ass.net>
 <16D8E001-98A0-4ABC-AFE8-0F230B869027@amacapital.net>
In-Reply-To: <16D8E001-98A0-4ABC-AFE8-0F230B869027@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 643a44d0-8bf8-4b81-0c17-08d6e5fe894b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6663;
x-ms-traffictypediagnostic: BYAPR05MB6663:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR05MB66633CFA8ABAE9778769A8FDD0190@BYAPR05MB6663.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(14454004)(186003)(54906003)(478600001)(53936002)(81156014)(6506007)(25786009)(2906002)(4326008)(966005)(53546011)(76176011)(99286004)(6916009)(7416002)(36756003)(3846002)(6116002)(102836004)(26005)(5660300002)(476003)(2616005)(446003)(6246003)(11346002)(6512007)(6306002)(486006)(6436002)(68736007)(71200400001)(66066001)(86362001)(8936002)(8676002)(83716004)(33656002)(81166006)(256004)(76116006)(82746002)(7736002)(66946007)(6486002)(71190400001)(14444005)(316002)(66446008)(66476007)(305945005)(73956011)(229853002)(64756008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6663;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5iBb4VTiO2EEcKWAZlK/7lKzqmP20CaMh3cmCP7VfZJWBn4FjZoMWplKaHUmeP+k3i/3eB2J/kUklgprMjRc8up+pO/3owZDNJ57athvzTBHIwB3dx+yzwe6BUHmhGn0rRoQg+cdAylTtCkM4KyF6rnMKlDkmWOWI7gXd/8YP5CAZFI/+76fmMnk9PUq1QOElqhBX49j9xhV9fRWHKwaj/cCpIyRUIwMZn1nRkNLkXx6w5EIkQkszxdi7c4By169FG1kUhc9Zd5YwFncb7koIieFayAY/s+8VCsNo/bB7eP8vcr9C0hyR+3UrOkuNA6j8FdwprVy1mbhbWtia9x7i7vqkfSI1L7B9c1P5eh4AHzO0dxH8VXpZuakce5vA+G74ZdUXwKEDys/YPQaEI8s0yzl/ZksDYSAi0XegpN3pog=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88894959EEBDA94BA187EEF3CDBBFC6E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643a44d0-8bf8-4b81-0c17-08d6e5fe894b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 19:31:10.5825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6663
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXkgMzEsIDIwMTksIGF0IDExOjQ0IEFNLCBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1h
Y2FwaXRhbC5uZXQ+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gTWF5IDMxLCAyMDE5LCBhdCAz
OjU3IEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPj4g
DQo+Pj4gT24gVGh1LCBNYXkgMzAsIDIwMTkgYXQgMTE6MzY6NDRQTSAtMDcwMCwgTmFkYXYgQW1p
dCB3cm90ZToNCj4+PiBXaGVuIHdlIGZsdXNoIHVzZXJzcGFjZSBtYXBwaW5ncywgd2UgY2FuIGRl
ZmVyIHRoZSBUTEIgZmx1c2hlcywgYXMgbG9uZw0KPj4+IHRoZSBmb2xsb3dpbmcgY29uZGl0aW9u
cyBhcmUgbWV0Og0KPj4+IA0KPj4+IDEuIE5vIHRhYmxlcyBhcmUgZnJlZWQsIHNpbmNlIG90aGVy
d2lzZSBzcGVjdWxhdGl2ZSBwYWdlIHdhbGtzIG1pZ2h0DQo+Pj4gIGNhdXNlIG1hY2hpbmUtY2hl
Y2tzLg0KPj4+IA0KPj4+IDIuIE5vIG9uZSB3b3VsZCBhY2Nlc3MgdXNlcnNwYWNlIGJlZm9yZSBm
bHVzaCB0YWtlcyBwbGFjZS4gU3BlY2lmaWNhbGx5LA0KPj4+ICBOTUkgaGFuZGxlcnMgYW5kIGtw
cm9iZXMgd291bGQgYXZvaWQgYWNjZXNzaW5nIHVzZXJzcGFjZS4NCj4+PiANCj4+PiBVc2UgdGhl
IG5ldyBTTVAgc3VwcG9ydCB0byBleGVjdXRlIHJlbW90ZSBmdW5jdGlvbiBjYWxscyB3aXRoIGlu
bGluZWQNCj4+PiBkYXRhIGZvciB0aGUgbWF0dGVyLiBUaGUgZnVuY3Rpb24gcmVtb3RlIFRMQiBm
bHVzaGluZyBmdW5jdGlvbiB3b3VsZCBiZQ0KPj4+IGV4ZWN1dGVkIGFzeW5jaHJvbm91c2x5IGFu
ZCB0aGUgbG9jYWwgQ1BVIHdvdWxkIGNvbnRpbnVlIGV4ZWN1dGlvbiBhcw0KPj4+IHNvb24gYXMg
dGhlIElQSSB3YXMgZGVsaXZlcmVkLCBiZWZvcmUgdGhlIGZ1bmN0aW9uIHdhcyBhY3R1YWxseQ0K
Pj4+IGV4ZWN1dGVkLiBTaW5jZSB0bGJfZmx1c2hfaW5mbyBpcyBjb3BpZWQsIHRoZXJlIGlzIG5v
IHJpc2sgaXQgd291bGQNCj4+PiBjaGFuZ2UgYmVmb3JlIHRoZSBUTEIgZmx1c2ggaXMgYWN0dWFs
bHkgZXhlY3V0ZWQuDQo+Pj4gDQo+Pj4gQ2hhbmdlIG5taV91YWNjZXNzX29rYXkoKSB0byBjaGVj
ayB3aGV0aGVyIGEgcmVtb3RlIFRMQiBmbHVzaCBpcw0KPj4+IGN1cnJlbnRseSBpbiBwcm9ncmVz
cyBvbiB0aGlzIENQVSBieSBjaGVja2luZyB3aGV0aGVyIHRoZSBhc3luY2hyb25vdXNseQ0KPj4+
IGNhbGxlZCBmdW5jdGlvbiBpcyB0aGUgcmVtb3RlIFRMQiBmbHVzaGluZyBmdW5jdGlvbi4gVGhl
IGN1cnJlbnQNCj4+PiBpbXBsZW1lbnRhdGlvbiBkaXNhbGxvd3MgYWNjZXNzIGluIHN1Y2ggY2Fz
ZXMsIGJ1dCBpdCBpcyBhbHNvIHBvc3NpYmxlDQo+Pj4gdG8gZmx1c2ggdGhlIGVudGlyZSBUTEIg
aW4gc3VjaCBjYXNlIGFuZCBhbGxvdyBhY2Nlc3MuDQo+PiANCj4+IEFSR0dILCBicmFpbiBodXJ0
LiBJJ20gbm90IHN1cmUgSSBmdWxseSB1bmRlcnN0YW5kIHRoaXMgb25lLiBIb3cgaXMgaXQNCj4+
IGRpZmZlcmVudCBmcm9tIHRvZGF5LCB3aGVyZSB0aGUgTk1JIGNhbiBoaXQgaW4gdGhlIG1pZGRs
ZSBvZiB0aGUgVExCDQo+PiBpbnZhbGlkYXRpb24/DQo+PiANCj4+IEFsc287IHNpbmNlIHdlJ3Jl
IG5vdCB3YWl0aW5nIG9uIHRoZSBJUEksIHdoYXQgcHJldmVudHMgdXMgZnJvbSBmcmVlaW5nDQo+
PiB0aGUgdXNlciBwYWdlcyBiZWZvcmUgdGhlIHJlbW90ZSBDUFUgaXMgJ2RvbmUnIHdpdGggdGhl
bT8gQ3VycmVudGx5IHRoZQ0KPj4gc3luY2hyb25vdXMgSVBJIGlzIGxpa2UgYSBzeW5jIHBvaW50
IHdoZXJlIHdlICprbm93KiB0aGUgcmVtb3RlIENQVSBpcw0KPj4gY29tcGxldGVseSBkb25lIGFj
Y2Vzc2luZyB0aGUgcGFnZS4NCj4+IA0KPj4gV2hlcmUgZ2V0dGluZyBhbiBJUEkgc3RvcHMgc3Bl
Y3VsYXRpb24sIHNwZWN1bGF0aW9uIGFnYWluIHJlc3RhcnRzDQo+PiBpbnNpZGUgdGhlIGludGVy
cnVwdCBoYW5kbGVyLCBhbmQgdW50aWwgd2UndmUgcGFzc2VkIHRoZSBJTlZMUEcvTU9WIENSMywN
Cj4+IHNwZWN1bGF0aW9uIGNhbiBoYXBwZW4gb24gdGhhdCBUTEIgZW50cnksIGV2ZW4gdGhvdWdo
IHdlJ3ZlIGFscmVhZHkNCj4+IGZyZWVkIGFuZCByZS11c2VkIHRoZSB1c2VyLXBhZ2UuDQo+PiAN
Cj4+IEFsc28sIHdoYXQgaGFwcGVucyBpZiB0aGUgVExCIGludmFsaWRhdGlvbiBJUEkgaXMgc3R1
Y2sgYmVoaW5kIGFub3RoZXINCj4+IHNtcF9mdW5jdGlvbl9jYWxsIElQSSB0aGF0IGlzIGRvaW5n
IHVzZXItYWNjZXNzPw0KPj4gDQo+PiBBcyBzYWlkLC4uIGJyYWluIGh1cnRzLg0KPiANCj4gU3Bl
Y3VsYXRpb24gYXNpZGUsIGFueSBjb2RlIGRvaW5nIGRpcnR5IHRyYWNraW5nIG5lZWRzIHRoZSBm
bHVzaCB0byBoYXBwZW4NCj4gZm9yIHJlYWwgYmVmb3JlIGl0IHJlYWRzIHRoZSBkaXJ0eSBiaXQu
DQo+IA0KPiBIb3cgZG9lcyB0aGlzIHBhdGNoIGd1YXJhbnRlZSB0aGF0IHRoZSBmbHVzaCBpcyBy
ZWFsbHkgZG9uZSBiZWZvcmUgc29tZW9uZQ0KPiBkZXBlbmRzIG9uIGl0Pw0KDQpJIHdhcyBhbHdh
eXMgdW5kZXIgdGhlIGltcHJlc3Npb24gdGhhdCB0aGUgZGlydHktYml0IGlzIHBhc3MtdGhyb3Vn
aCAtIHRoZQ0KQS9ELWFzc2lzdCB3YWxrcyB0aGUgdGFibGVzIGFuZCBzZXRzIHRoZSBkaXJ0eSBi
aXQgdXBvbiBhY2Nlc3MuIE90aGVyd2lzZSwNCndoYXQgaGFwcGVucyB3aGVuIHlvdSBpbnZhbGlk
YXRlIHRoZSBQVEUsIGFuZCBoYXZlIGFscmVhZHkgbWFya2VkIHRoZSBQVEUgYXMNCm5vbi1wcmVz
ZW50PyBXb3VsZCB0aGUgQ1BVIHNldCB0aGUgZGlydHktYml0IGF0IHRoaXMgcG9pbnQ/DQoNCklu
IHRoaXMgcmVnYXJkLCBJIHJlbWVtYmVyIHRoaXMgdGhyZWFkIG9mIERhdmUgSGFuc2VuIFsxXSwg
d2hpY2ggYWxzbyBzZWVtcw0KdG8gbWUgYXMgc3VwcG9ydGluZyB0aGUgbm90aW9uIHRoZSBkaXJ0
eS1iaXQgaXMgc2V0IG9uIHdyaXRlIGFuZCBub3Qgb24NCklOVkxQRy4NCg0KTG9va2luZyBhdCB0
aGUgU0RNIG9uICJWaXJ0dWFsIFRMQiBTY2hlbWXigJ0sIGFsc28gc2VlbXMgdG8gc3VwcG9ydCB0
aGlzDQpjbGFpbS4gVGhlIGd1ZXN0IGRpcnR5IGJpdCBpcyBzZXQgaW4gc2VjdGlvbiAzMi4zLjUu
MiAiUmVzcG9uc2UgdG8gUGFnZQ0KRmF1bHRz4oCdLCBhbmQgbm90IGluIHNlY3Rpb24gMzIuMy41
LiAiUmVzcG9uc2UgdG8gVXNlcyBvZiBJTlZMUEfigJ0uDQoNCkFtIEkgd3Jvbmc/DQoNCg0KWzFd
IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZm9ydW0vIyF0b3BpYy9saW51eC5rZXJuZWwvSEJn
aDB1VDI0SzgNCg0K
