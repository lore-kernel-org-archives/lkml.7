Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09285C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B6926F5D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="eVTetVEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEaVdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:33:15 -0400
Received: from mail-eopbgr760078.outbound.protection.outlook.com ([40.107.76.78]:44758
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfEaVdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utDhrvnXgvx79Z+B2UoIAK9AT87zeJcAjZ8KRF/DAtg=;
 b=eVTetVENKPmBOZ4ohfhUPVqGuIaqK0jj7dquo1PREQAtB7p8DDtqZIuj5GQiZVoRrum+yhLe2DI4WAVSv7IN/lE3X2rQNDfZ1ifvgGYdFDgaCKJ/JRRT6Zr2CMsiDUQfqpCrTbMCPcQ8/f46OVVK86WKH0WfGLjYEBPv6TWX42k=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5959.namprd05.prod.outlook.com (20.178.52.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.14; Fri, 31 May 2019 21:33:10 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 21:33:10 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
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
Thread-Index: AQHVF3tKnfrC/xKd0kyiVp6wMVDUEqaFvMuAgAAFIIA=
Date:   Fri, 31 May 2019 21:33:10 +0000
Message-ID: <5F153080-D7A7-4054-AB4A-AEDD5F82E0B9@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
 <20190531063645.4697-12-namit@vmware.com>
 <CALCETrU0=BpGy5OQezQ7or33n-EFgBVDNe5g8prSUjL2SoRAwA@mail.gmail.com>
In-Reply-To: <CALCETrU0=BpGy5OQezQ7or33n-EFgBVDNe5g8prSUjL2SoRAwA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebfb0991-b08b-4294-daf6-08d6e60f9439
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5959;
x-ms-traffictypediagnostic: BYAPR05MB5959:
x-microsoft-antispam-prvs: <BYAPR05MB5959322DE5F408CE43C279CDD0190@BYAPR05MB5959.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(396003)(376002)(136003)(189003)(199004)(6512007)(71190400001)(36756003)(305945005)(66066001)(7736002)(4326008)(25786009)(71200400001)(6246003)(83716004)(6116002)(53936002)(6916009)(3846002)(26005)(33656002)(256004)(6486002)(68736007)(2906002)(14444005)(6436002)(82746002)(66556008)(86362001)(229853002)(478600001)(102836004)(6506007)(53546011)(316002)(8936002)(186003)(66446008)(66946007)(486006)(476003)(76176011)(2616005)(99286004)(14454004)(81166006)(81156014)(8676002)(5660300002)(66476007)(64756008)(76116006)(73956011)(11346002)(446003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5959;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xwD1vWEOqzMLYnX4NaKUcFVZlLTDKYHi8TyKLMDs3ZrVgXkPV3yPpl8wfYPiq7C0BSFk3m+FIlMqrmIJEEuym2zLXmgJ5f+pkjHm749cj9lmEyXYwe/ea0ixhOogWBiJAUijmipwjpHasoNAH2ljYYAd1xcwTiUu79DOKwukkCmVZoLlnGF+iqtRhkzlvK7YA60/nBJKxopVfJl8Z6hmDJom6VIrC34IkvYIKqCvvLp2ktnNbaLKluI9QVvWVyO246dA8felKgyHKIu+6dCbkwjnnqndYrrtHoWjJ/13pqEpSCNRWHRP1fLqE+pdZatZgCVz0/zHbP72MHmIWo4wzYkITHEDorL5rtVmIoHVhE7R4SLBUq0vyn+U12C0dHuGXEwvAMtgYJ23GKCaZRM1SdxCuF/X6h0iwDjW837v3/8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB14BB80EE04FA4C86485B941058A245@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfb0991-b08b-4294-daf6-08d6e60f9439
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 21:33:10.3962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXkgMzEsIDIwMTksIGF0IDI6MTQgUE0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgTWF5IDMwLCAyMDE5IGF0IDExOjM3IFBNIE5h
ZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4gV2hlbiB3ZSBmbHVzaCB1c2Vy
c3BhY2UgbWFwcGluZ3MsIHdlIGNhbiBkZWZlciB0aGUgVExCIGZsdXNoZXMsIGFzIGxvbmcNCj4+
IHRoZSBmb2xsb3dpbmcgY29uZGl0aW9ucyBhcmUgbWV0Og0KPj4gDQo+PiAxLiBObyB0YWJsZXMg
YXJlIGZyZWVkLCBzaW5jZSBvdGhlcndpc2Ugc3BlY3VsYXRpdmUgcGFnZSB3YWxrcyBtaWdodA0K
Pj4gICBjYXVzZSBtYWNoaW5lLWNoZWNrcy4NCj4+IA0KPj4gMi4gTm8gb25lIHdvdWxkIGFjY2Vz
cyB1c2Vyc3BhY2UgYmVmb3JlIGZsdXNoIHRha2VzIHBsYWNlLiBTcGVjaWZpY2FsbHksDQo+PiAg
IE5NSSBoYW5kbGVycyBhbmQga3Byb2JlcyB3b3VsZCBhdm9pZCBhY2Nlc3NpbmcgdXNlcnNwYWNl
Lg0KPiANCj4gSSB0aGluayBJIG5lZWQgdG8gYXNrIHRoZSBiaWcgcGljdHVyZSBxdWVzdGlvbi4g
IFdoZW4gc29tZW9uZSBjYWxscw0KPiBmbHVzaF90bGJfbW1fcmFuZ2UoKSAob3IgdGhlIG90aGVy
IGVudHJ5IHBvaW50cyksIGlmIG5vIHBhZ2UgdGFibGVzDQo+IHdlcmUgZnJlZWQsIHRoZXkgd2Fu
dCB0aGUgZ3VhcmFudGVlIHRoYXQgZnV0dXJlIGFjY2Vzc2VzIChpbml0aWF0ZWQNCj4gb2JzZXJ2
YWJseSBhZnRlciB0aGUgZmx1c2ggcmV0dXJucykgd2lsbCBub3QgdXNlIHBhZ2luZyBlbnRyaWVz
IHRoYXQNCj4gd2VyZSByZXBsYWNlZCBieSBzdG9yZXMgb3JkZXJlZCBiZWZvcmUgZmx1c2hfdGxi
X21tX3JhbmdlKCkuICBXZSBhbHNvDQo+IG5lZWQgdGhlIGd1YXJhbnRlZSB0aGF0IGFueSBlZmZl
Y3RzIGZyb20gYW55IG1lbW9yeSBhY2Nlc3MgdXNpbmcgdGhlDQo+IG9sZCBwYWdpbmcgZW50cmll
cyB3aWxsIGJlY29tZSBnbG9iYWxseSB2aXNpYmxlIGJlZm9yZQ0KPiBmbHVzaF90bGJfbW1fcmFu
Z2UoKS4NCj4gDQo+IEknbSB3b25kZXJpbmcgaWYgcmVjZWlwdCBvZiBhbiBJUEkgaXMgZW5vdWdo
IHRvIGd1YXJhbnRlZSBhbnkgb2YgdGhpcy4NCj4gSWYgQ1BVIDEgc2V0cyBhIGRpcnR5IGJpdCBh
bmQgQ1BVIDIgd3JpdGVzIHRvIHRoZSBBUElDIHRvIHNlbmQgYW4gSVBJDQo+IHRvIENQVSAxLCBh
dCB3aGF0IHBvaW50IGlzIENQVSAyIGd1YXJhbnRlZWQgdG8gYmUgYWJsZSB0byBvYnNlcnZlIHRo
ZQ0KPiBkaXJ0eSBiaXQ/ICBBbiBpbnRlcnJ1cHQgZW50cnkgdG9kYXkgaXMgZnVsbHkgc2VyaWFs
aXppbmcgYnkgdGhlIHRpbWUNCj4gaXQgZmluaXNoZXMsIGJ1dCBpbnRlcnJ1cHQgZW50cmllcyBh
cmUgZXBpY2x5IHNsb3csIGFuZCBJIGRvbid0IGtub3cNCj4gaWYgdGhlIEFQSUMgd2FpdHMgbG9u
ZyBlbm91Z2guICBIZWNrLCB3aGF0IGlmIElSUXMgYXJlIG9mZiBvbiB0aGUNCj4gcmVtb3RlIENQ
VT8gIFRoZXJlIGFyZSBhIGhhbmRmdWwgb2YgcGxhY2VzIHdoZXJlIHdlIHRvdWNoIHVzZXIgbWVt
b3J5DQo+IHdpdGggSVJRcyBvZmYsIGFuZCBpdCdzIChzYWRseSkgcG9zc2libGUgZm9yIHVzZXIg
Y29kZSB0byB0dXJuIG9mZg0KPiBJUlFzIHdpdGggaW9wbCgpLg0KPiANCj4gSSAqdGhpbmsqIHRo
YXQgSW50ZWwgaGFzIHN0YXRlZCByZWNlbnRseSB0aGF0IFNNVCBzaWJsaW5ncyBhcmUNCj4gZ3Vh
cmFudGVlZCB0byBzdG9wIHNwZWN1bGF0aW5nIHdoZW4geW91IHdyaXRlIHRvIHRoZSBBUElDIElD
UiB0byBwb2tlDQo+IHRoZW0sIGJ1dCBTTVQgaXMgdmVyeSBzcGVjaWFsLg0KPiANCj4gTXkgZ2Vu
ZXJhbCBjb25jbHVzaW9uIGlzIHRoYXQgSSB0aGluayB0aGUgY29kZSBuZWVkcyB0byBkb2N1bWVu
dCB3aGF0DQo+IGlzIGd1YXJhbnRlZWQgYW5kIHdoeS4NCg0KSSB0aGluayBJIG1pZ2h0IGhhdmUg
bWFuYWdlZCB0byBjb25mdXNlIHlvdSB3aXRoIGEgYnVnIEkgbWFkZSAobGFzdCBtaW51dGUNCmJ1
ZyB3aGVuIEkgd2FzIGRvaW5nIHNvbWUgY2xlYW51cCkuIFRoaXMgYnVnIGRvZXMgbm90IGFmZmVj
dCB0aGUgcGVyZm9ybWFuY2UNCm11Y2gsIGJ1dCBpdCBtaWdodCBsZWQgeW91IHRvIHRoaW5rIHRo
YXQgSSB1c2UgdGhlIEFQSUMgc2VuZGluZyBhcw0Kc3luY2hyb25pemF0aW9uLg0KDQpUaGUgaWRl
YSBpcyBub3QgZm9yIHVzIHRvIHJlbHkgb24gd3JpdGUgdG8gSUNSIGFzIHNvbWV0aGluZyBzZXJp
YWxpemluZy4gVGhlDQpmbG93IHNob3VsZCBiZSBhcyBmb2xsb3dzOg0KDQoNCglDUFUwCQkJCQlD
UFUxDQoNCmZsdXNoX3RsYl9tbV9yYW5nZSgpDQogX19zbXBfY2FsbF9mdW5jdGlvbl9tYW55KCkN
CiAgWyBwcmVwYXJlIGNhbGxfc2luZ2xlX2RhdGEgKGNzZCkgXQ0KICBbIGxvY2sgY3NkIF0gDQog
IFsgc2VuZCBJUEkgXQ0KCSgqKQ0KICBbIHdhaXQgZm9yIGNzZCB0byBiZSB1bmxvY2tlZCBdDQoJ
CQkJCVsgaW50ZXJydXB0IF0NCgkJCQkJWyBjb3B5IGNzZCBpbmZvIHRvIHN0YWNrIF0NCgkJCQkJ
WyBjc2QgdW5sb2NrIF0NCiAgWyBmaW5kIGNzZCBpcyB1bmxvY2tlZCBdDQogIFsgY29udGludWUg
KCoqKSBdDQoJCQkJCVsgZmx1c2ggVExCIF0NCg0KDQpBdCAoKiopIHRoZSBwYWdlcyBtaWdodCBi
ZSByZWN5Y2xlZCwgd3JpdHRlbi1iYWNrIHRvIGRpc2ssIGV0Yy4gTm90ZSB0aGF0DQpkdXJpbmcg
KCopLCBDUFUwIG1pZ2h0IGRvIHNvbWUgbG9jYWwgVExCIGZsdXNoZXMsIG1ha2luZyBpdCB2ZXJ5
IGxpa2VseSB0aGF0DQpDU0Qgd2lsbCBiZSB1bmxvY2tlZCBieSB0aGUgdGltZSBpdCBnZXRzIHRo
ZXJlLg0KDQpBcyB5b3UgY2FuIHNlZSwgSSBkb27igJl0IHJlbHkgb24gYW55IHNwZWNpYWwgbWlj
cm8tYXJjaGl0ZWN0dXJhbCBiZWhhdmlvci4NClRoZSBzeW5jaHJvbml6YXRpb24gaXMgZG9uZSBw
dXJlbHkgaW4gc29mdHdhcmUuDQoNCkRvZXMgaXQgbWFrZSBtb3JlIHNlbnNlIG5vdz8NCg0K
