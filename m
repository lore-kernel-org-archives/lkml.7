Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904EAC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B49E2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="hY555IVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfEPSxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:53:13 -0400
Received: from mail-eopbgr760074.outbound.protection.outlook.com ([40.107.76.74]:6980
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbfEPSxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5oHWj4eVF0JsjnHgBWRrzVY9o4vmCD5KrFtU4wLzK0=;
 b=hY555IVLWQuSHyH9AXC48+Er0MI+ZdmrZuyRx+KkLLC3to3vwgwrQZym/Bmwl25Guy5HifjDwbvE/qXyRju9178I3NqgFZBMkf4p2IARg+f2PmETYl+3hGnNx9sIkPaiik1FU9iBc30bFIFVmH6KHyfkC6NTbxkisgcMiTXNcRc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5736.namprd05.prod.outlook.com (20.178.48.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.14; Thu, 16 May 2019 18:53:05 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b057:917a:f098:6098]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b057:917a:f098:6098%7]) with mapi id 15.20.1922.002; Thu, 16 May 2019
 18:53:05 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Paul Turner <pjt@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirsky <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC] x86: Speculative execution warnings
Thread-Topic: [RFC] x86: Speculative execution warnings
Thread-Index: AQHVB6OPUMBr82jCAUuVKHrFo1P0gaZqRu6AgACW3oCAAAQlgIADP/WA
Date:   Thu, 16 May 2019 18:53:05 +0000
Message-ID: <2C85DF08-0AA0-45CF-BD97-1149EF00C8B4@vmware.com>
References: <20190510192514.19301-1-namit@vmware.com>
 <CAPM31RJ_vQsLp3nK5nhq0U8J+x_9w=aV+TtPGj7vdtiOKPpw8g@mail.gmail.com>
 <EB9EEC92-A513-44B4-9377-56691916BF5D@vmware.com>
 <3944C0B1-D0C4-4D2F-B055-69313CFD73F2@amacapital.net>
In-Reply-To: <3944C0B1-D0C4-4D2F-B055-69313CFD73F2@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [50.204.120.225]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e6f3b19-11bd-4125-0b60-08d6da2fbaee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB5736;
x-ms-traffictypediagnostic: BYAPR05MB5736:
x-microsoft-antispam-prvs: <BYAPR05MB5736BAA5AD8564D97168C32FD00A0@BYAPR05MB5736.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(376002)(39860400002)(189003)(199004)(73956011)(53546011)(6506007)(76116006)(64756008)(446003)(7416002)(82746002)(99286004)(11346002)(66446008)(66476007)(66556008)(66066001)(102836004)(26005)(91956017)(66946007)(71190400001)(86362001)(71200400001)(186003)(53936002)(7736002)(305945005)(316002)(6246003)(83716004)(6916009)(14454004)(4326008)(25786009)(76176011)(2906002)(3846002)(256004)(14444005)(6116002)(8676002)(36756003)(6436002)(33656002)(8936002)(5660300002)(54906003)(476003)(486006)(6512007)(2616005)(478600001)(6486002)(229853002)(81156014)(68736007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5736;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w7O9dFEIKrtB6nISoMEpLYkUg4esmXJ1IEHPTkCjk8Kd1wsnXXhfWTVZv6YjaRb3r0MABuJsKFN5rxKWiX0oDLQ3q+d4hHHEiaBq1sAa0NqgD5JAiRb32fZ3zFTNYncAicyiKvMCW0wZvhIU5VmjbwIZ5A7DlDEniYbROhQtZ8xWnnuQewueZO0uuP3qcQVS8DYzYhrcrYckvPHVO71YI/Azewdag22LfZZOVnqXAWJLrNgPTrWxPszio5p1RhTFea5GeGMg51YMxV1cMsWxaXSV93C+rL+qOiXbKx3wCmOs9l4gGYfbwu7t/R0r/GuqJe5k64a93cwi+v1sH2tPysU0R7QCqz9hFrHnptGVNOP7I/MVxf7od3upbu9NuDHHKcPOjIJ8lEHaKpG/LEKaOGxj+5vsTvHH5nBJ+FkfoO4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3763B27A63E6964B8E437AD71E5C606A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6f3b19-11bd-4125-0b60-08d6da2fbaee
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 18:53:05.2495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXkgMTQsIDIwMTksIGF0IDEwOjE1IEFNLCBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1h
Y2FwaXRhbC5uZXQ+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiBPbiBNYXkgMTQsIDIwMTksIGF0IDEw
OjAwIEFNLCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4gDQo+Pj4gT24g
TWF5IDE0LCAyMDE5LCBhdCAxOjAwIEFNLCBQYXVsIFR1cm5lciA8cGp0QGdvb2dsZS5jb20+IHdy
b3RlOg0KPj4+IA0KPj4+IEZyb206IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+DQo+Pj4g
RGF0ZTogRnJpLCBNYXkgMTAsIDIwMTkgYXQgNzo0NSBQTQ0KPj4+IFRvOiA8eDg2QGtlcm5lbC5v
cmc+DQo+Pj4gQ2M6IEJvcmlzbGF2IFBldGtvdiwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+LCBOYWRhdiBBbWl0LCBBbmR5DQo+Pj4gTHV0b21pcnNreSwgSW5nbyBNb2xuYXIsIFBldGVy
IFppamxzdHJhLCBUaG9tYXMgR2xlaXhuZXIsIEphbm4gSG9ybg0KPj4+IA0KPj4+PiBJdCBtYXkg
YmUgdXNlZnVsIHRvIGNoZWNrIGluIHJ1bnRpbWUgd2hldGhlciBjZXJ0YWluIGFzc2VydGlvbnMg
YXJlDQo+Pj4+IHZpb2xhdGVkIGV2ZW4gZHVyaW5nIHNwZWN1bGF0aXZlIGV4ZWN1dGlvbi4gVGhp
cyBjYW4gYWxsb3cgdG8gYXZvaWQNCj4+Pj4gYWRkaW5nIHVubmVjZXNzYXJ5IG1lbW9yeSBmZW5j
ZXMgYW5kIGF0IHRoZSBzYW1lIHRpbWUgY2hlY2sgdGhhdCBubyBkYXRhDQo+Pj4+IGxlYWsgY2hh
bm5lbHMgZXhpc3QuDQo+Pj4+IA0KPj4+PiBGb3IgZXhhbXBsZSwgYWRkaW5nIHN1Y2ggY2hlY2tz
IGNhbiBzaG93IHRoYXQgYWxsb2NhdGluZyB6ZXJvZWQgcGFnZXMNCj4+Pj4gY2FuIHJldHVybiBz
cGVjdWxhdGl2ZWx5IG5vbi16ZXJvZWQgcGFnZXMgKHRoZSBmaXJzdCBxd29yZCBpcyBub3QNCj4+
Pj4gemVybykuICBbVGhpcyBtaWdodCBiZSBhIHByb2JsZW0gd2hlbiB0aGUgcGFnZS1mYXVsdCBo
YW5kbGVyIHBlcmZvcm1zDQo+Pj4+IHNvZnR3YXJlIHBhZ2Utd2FsaywgZm9yIGV4YW1wbGUuXQ0K
Pj4+PiANCj4+Pj4gSW50cm9kdWNlIFNQRUNfV0FSTl9PTigpLCB3aGljaCBjaGVja3MgaW4gcnVu
dGltZSB3aGV0aGVyIGEgY2VydGFpbg0KPj4+PiBjb25kaXRpb24gaXMgdmlvbGF0ZWQgZHVyaW5n
IHNwZWN1bGF0aXZlIGV4ZWN1dGlvbi4gVGhlIGNvbmRpdGlvbiBzaG91bGQNCj4+Pj4gYmUgY29t
cHV0ZWQgd2l0aG91dCBicmFuY2hlcywgZS5nLiwgdXNpbmcgYml0d2lzZSBvcGVyYXRvcnMuIFRo
ZSBjaGVjaw0KPj4+PiB3aWxsIHdhaXQgZm9yIHRoZSBjb25kaXRpb24gdG8gYmUgcmVhbGl6ZWQg
KGkuZS4sIG5vdCBzcGVjdWxhdGVkKSwgYW5kDQo+Pj4+IGlmIHRoZSBhc3NlcnRpb24gaXMgdmlv
bGF0ZWQsIGEgd2FybmluZyB3aWxsIGJlIHRocm93bi4NCj4+Pj4gDQo+Pj4+IFdhcm5pbmdzIGNh
biBiZSBwcm92aWRlZCBpbiBvbmUgb2YgdHdvIG1vZGVzOiBwcmVjaXNlIGFuZCBpbXByZWNpc2Uu
DQo+Pj4+IEJvdGggbW9kZSBhcmUgbm90IHBlcmZlY3QuIFRoZSBwcmVjaXNlIG1vZGUgZG9lcyBu
b3QgYWx3YXlzIG1ha2UgaXQgZWFzeQ0KPj4+PiB0byB1bmRlcnN0YW5kIHdoaWNoIGFzc2VydGlv
biB3YXMgYnJva2VuLCBidXQgaW5zdGVhZCBwb2ludHMgdG8gYSBwb2ludA0KPj4+PiBpbiB0aGUg
ZXhlY3V0aW9uIHNvbWV3aGVyZSBhcm91bmQgdGhlIHBvaW50IGluIHdoaWNoIHRoZSBhc3NlcnRp
b24gd2FzDQo+Pj4+IHZpb2xhdGVkLiAgSW4gYWRkaXRpb24sIGl0IHByaW50cyBhIHdhcm5pbmcg
Zm9yIGVhY2ggdmlvbGF0aW9uICh1bmxpa2UNCj4+Pj4gV0FSTl9PTkNFKCkgbGlrZSBiZWhhdmlv
cikuDQo+Pj4+IA0KPj4+PiBUaGUgaW1wcmVjaXNlIG1vZGUsIG9uIHRoZSBvdGhlciBoYW5kLCBj
YW4gc29tZXRpbWVzIHRocm93IHRoZSB3cm9uZw0KPj4+PiBpbmRpY2F0aW9uLCBzcGVjaWZpY2Fs
bHkgaWYgdGhlIGNvbnRyb2wgZmxvdyBoYXMgY2hhbmdlZCBiZXR3ZWVuIHRoZQ0KPj4+PiBzcGVj
dWxhdGl2ZSBleGVjdXRpb24gYW5kIHRoZSBhY3R1YWwgb25lLiBOb3RlIHRoYXQgaXQgaXMgbm90
IGENCj4+Pj4gZmFsc2UtcG9zaXRpdmUsIGl0IGp1c3QgbWVhbnMgdGhhdCB0aGUgb3V0cHV0IHdv
dWxkIG1pc2xlYWQgdGhlIHVzZXIgdG8NCj4+Pj4gdGhpbmsgdGhlIHdyb25nIGFzc2VydGlvbiB3
YXMgYnJva2VuLg0KPj4+PiANCj4+Pj4gVGhlcmUgYXJlIHNvbWUgbW9yZSBsaW1pdGF0aW9ucy4g
U2luY2UgdGhlIG1lY2hhbmlzbSByZXF1aXJlcyBhbg0KPj4+PiBpbmRpcmVjdCBicmFuY2gsIGl0
IHNob3VsZCBub3QgYmUgdXNlZCBpbiBwcm9kdWN0aW9uIHN5c3RlbXMgdGhhdCBhcmUNCj4+Pj4g
c3VzY2VwdGlibGUgZm9yIFNwZWN0cmUgdjIuIFRoZSBtZWNoYW5pc20gcmVxdWlyZXMgVFNYIGFu
ZCBwZXJmb3JtYW5jZQ0KPj4+PiBjb3VudGVycyB0aGF0IGFyZSBvbmx5IGF2YWlsYWJsZSBpbiBz
a3lsYWtlKy4gVGhlcmUgaXMgYSBoaWRkZW4NCj4+Pj4gYXNzdW1wdGlvbiB0aGF0IFRTWCBpcyBu
b3QgdXNlZCBpbiB0aGUga2VybmVsIGZvciBhbnl0aGluZyBlbHNlLCBvdGhlcg0KPj4+PiB0aGFu
IHRoaXMgbWVjaGFuaXNtLg0KPj4+IA0KPj4+IE5pY2UgdHJpY2shDQo+PiANCj4+IOKAnElsbHVz
aW9uLiIgWyBpZ25vcmUgaWYgeW91IGRvbuKAmXQga25vdyB0aGUgcmVmZXJlbmNlIF0NCj4+IA0K
Pj4+IENhbiB5b3UgZWxpbWluYXRlIHRoZSBpbmRpcmVjdCBjYWxsIGJ5IGZvcmNpbmcgYW4gYWNj
ZXNzIGZhdWx0IHRvDQo+Pj4gYWJvcnQgdGhlIHRyYW5zYWN0aW9uIGluc3RlYWQsIGUuZy4gImNt
b3ZlIDAsICQx4oCdPw0KPj4+IA0KPj4+IChJZiB0aGlzIHdvcmtzLCBpdCBtYXkgYWxzbyBhbGxv
dyBzdXBwb3J0IG9uIG9sZGVyIGFyY2hpdGVjdHVyZXMgYXMNCj4+PiB0aGUgUlRNX1JFVElSRUQu
QUJPUlQqIGV2ZW50cyBnbyBiYWNrIGZ1cnRoZXIgSSBiZWxpZXZlPykNCj4+IA0KPj4gSSBkb27i
gJl0IHRoaW5rIGl0IHdvdWxkIHdvcmsuIFRoZSB3aG9sZSBwcm9ibGVtIGlzIHRoYXQgd2UgbmVl
ZCBhIGNvdW50ZXINCj4+IHRoYXQgaXMgdXBkYXRlZCBkdXJpbmcgZXhlY3V0aW9uIGFuZCBub3Qg
cmV0aXJlbWVudC4gSSB0cmllZCBzZXZlcmFsDQo+PiBjb3VudGVycyBhbmQgY291bGQgbm90IGZp
bmQgb3RoZXIgYXBwcm9wcmlhdGUgb25lcy4NCj4+IA0KPj4gVGhlIGlkZWEgYmVoaW5kIHRoZSBp
bXBsZW1lbnRhdGlvbiBpcyB0byBhZmZlY3QgdGhlIGNvbnRyb2wgZmxvdyB0aHJvdWdoDQo+PiBk
YXRhIGRlcGVuZGVuY3kuIEkgbWF5IGJlIGFibGUgdG8gZG8gc29tZXRoaW5nIHNpbWlsYXIgd2l0
aG91dCBhbiBpbmRpcmVjdA0KPj4gYnJhbmNoLiBJ4oCZbGwgdGFrZSBhIHBhZ2UsIHB1dCB0aGUg
WEFCT1JUIG9uIHRoZSBwYWdlIGFuZCBtYWtlIHRoZSBwYWdlIE5YLg0KPj4gVGhlbiwgYSBkaXJl
Y3QganVtcCB3b3VsZCBnbyB0byB0aGlzIHBhZ2UuIFRoZSBjb25kaXRpb25hbC1tb3Ygd291bGQg
Y2hhbmdlDQo+PiB0aGUgUFRFIHRvIFggaWYgdGhlIGFzc2VydGlvbiBpcyB2aW9sYXRlZC4gVGhl
cmUgc2hvdWxkIGJlIGEgcGFnZS13YWxrIGV2ZW4NCj4+IGlmIHRoZSBDUFUgZmluZHMgdGhlIGVu
dHJ5IGluIHRoZSBUTEIsIHNpbmNlIHRoaXMgZW50cnkgaXMgTlguDQo+IA0KPiBJIHRoaW5rIHlv
dSBvbmx5IGdldCBhIHBhZ2Ugd2FsayBpZiB0aGUgVExCIGVudHJ5IGlzIG5vdC1wcmVzZW50LiBJ
4oCZZCBiZSBhDQo+IGJpdCBzdXJwcmlzZWQgaWYgdGhlIENQVSBpcyB3aWxsaW5nIHRvIGV4ZWN1
dGUsIGV2ZW4gc3BlY3VsYXRpdmVseSwgZnJvbQ0KPiBzcGVjdWxhdGl2ZWx5IHdyaXR0ZW4gZGF0
YS4gR29vZCBsdWNrIQ0KDQpJIGd1ZXNzIHlvdSBhcmUgcmlnaHQgKGFsdGhvdWdoIEkgZGlkbuKA
mXQgdHJ5KS4gSUlSQywgSmFubiBIb3JuIG9uY2UNCmV4cGxhaW5lZCB0byBtZSB0aGF0IGlmIENQ
VXMgdXNlZCBQVEVzIHRoYXQgd2VyZSB3cml0dGVuIHNwZWN1bGF0aXZlbHksIHRoaXMNCndvdWxk
IGhhdmUgYmVlbiBhIGNvcnJlY3RuZXNzIGlzc3VlLCBzaW5jZSB0aGUgUFRFIG5lZWRzIHRvIGdl
dCB0byB0aGUgVExCDQpiZWZvcmUgaXQgaXMgdXNlZC4NCg0KSeKAmWxsIHRyeSBhIGRpZmZlcmVu
dCBwYXRoIChub3QgY29uY3JldGUgaWRlYSB3aGljaCksIGFzc3VtaW5nIHRoZXJlIGlzIGFuDQpp
bnRlcmVzdC4NCg0K
