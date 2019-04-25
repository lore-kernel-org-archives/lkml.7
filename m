Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCBAC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C06720717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="W8zVsXTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbfDYSOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:14:00 -0400
Received: from mail-eopbgr780040.outbound.protection.outlook.com ([40.107.78.40]:65152
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728158AbfDYSN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qm+GWHw+nakUcGT7VrMhTdRt1qq6NHYKTIs5Vyv4C98=;
 b=W8zVsXTU9wOAcqrOLf6CiNIj/pOug09vt66iuBlqKsmNwwn5QsYNjx+oR8isb6SkzJD3Y+RmcZBwEtwbBk+mZxVw+jL7qS161H/Mzj3n6FK+4V3leJ5SuA2pbfWgp58IiOjB+LpJUBAxmbiRRdLsFEP8mdu1VJZ7fStsBTpUNwg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6312.namprd05.prod.outlook.com (20.178.51.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.10; Thu, 25 Apr 2019 18:13:40 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094%3]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 18:13:40 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/mm/tlb: Remove flush_tlb_info from the stack
Thread-Topic: [PATCH] x86/mm/tlb: Remove flush_tlb_info from the stack
Thread-Index: AQHU+aHFH4sDsaCumUS5u9AqMzrCzaZJ9iEAgAABtYCAAAeEgIADMpmA
Date:   Thu, 25 Apr 2019 18:13:40 +0000
Message-ID: <07CCD48D-8B81-4801-BA07-2AECED8174EF@vmware.com>
References: <20190423065706.15430-1-namit@vmware.com>
 <CALCETrUohp2rMr9EcoAYm2M=Ktu4Bg2sPfUWMy5JqM-GXsDOBQ@mail.gmail.com>
 <44A66873-0834-4794-81A5-3B2131314AA4@vmware.com>
 <CALCETrXLjL4vMwQP1tweWvk_+dBvZFdE85ckt8TZSVw2XyW_yQ@mail.gmail.com>
In-Reply-To: <CALCETrXLjL4vMwQP1tweWvk_+dBvZFdE85ckt8TZSVw2XyW_yQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 617c9a45-961a-4b78-e836-08d6c9a9bebe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB6312;
x-ms-traffictypediagnostic: BYAPR05MB6312:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR05MB6312D0D36FAAA60EA8799934D03D0@BYAPR05MB6312.namprd05.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(136003)(39860400002)(396003)(199004)(189003)(3846002)(6506007)(966005)(446003)(76176011)(45080400002)(8936002)(81156014)(8676002)(81166006)(68736007)(229853002)(6486002)(53546011)(26005)(102836004)(99286004)(36756003)(6436002)(5660300002)(316002)(4326008)(6116002)(14454004)(486006)(66446008)(6246003)(83716004)(66946007)(82746002)(64756008)(25786009)(66556008)(11346002)(186003)(71200400001)(305945005)(71190400001)(66476007)(76116006)(73956011)(2616005)(6512007)(93886005)(478600001)(66066001)(476003)(7736002)(33656002)(97736004)(53936002)(2906002)(6916009)(6306002)(256004)(54906003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6312;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EmS/RAcQO34LN/sSlAkyNJ8mr5TaJ5qo6MEJhxEFvPbhdBoSW0Yo44ul377VelfRnuKYS5HSp+bHcyGEKzvYSfNar+FKherVaIKAsMC4plcp2crudzwRU3wxHEw1bx2ag+wkwJkozcgz5Su45I5fMh9kPfTMcX4GS5ABCzsOiGsQkvJYomyKmdn6O0t211eFnWcDZnt/clpOKqOsAPZdOnfy2O+ESz0O1D63k/Kto+g/cTCyVrzX6fEbyC8skLMcZ42IzWBZmq5e7ZjN5G5wXaM38An5B5iRDBfU2WL+66eGMkN9xJAMioIKEXvL1U9t9IqAoE09eDQsRUkxQLHM6Tw1yVp+j8jINZUmw3JFBq9XxDhtd3lZ80sf95X2oioydH6HKOXXAm947UCesEj3/L1KE1MZYOLCJ6spmzNmQwo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF3C1425EE7D4B4F82820D49B9084DB9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617c9a45-961a-4b78-e836-08d6c9a9bebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 18:13:40.4843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6312
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBBcHIgMjMsIDIwMTksIGF0IDEwOjIzIEFNLCBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIEFwciAyMywgMjAxOSBhdCA5OjU2IEFNIE5h
ZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+IE9uIEFwciAyMywgMjAxOSwg
YXQgOTo1MCBBTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
IA0KPj4+IE9uIFR1ZSwgQXByIDIzLCAyMDE5IGF0IDEyOjEyIEFNIE5hZGF2IEFtaXQgPG5hbWl0
QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4gaHR0cHM6Ly9uYW0wNC5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0Lmtlcm5lbC5vcmclMkZwdWIlMkZz
Y20lMkZsaW51eCUyRmtlcm5lbCUyRmdpdCUyRmx1dG8lMkZsaW51eC5naXQlMkZsb2clMkYlM0Zo
JTNEeDg2JTJGZml4ZXMmYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3Q2Iw
YmExM2EwNTliNTRhYmNiMWMwMDhkNmM4MTA3YTU0JTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgz
ZDlkZDYyZjAlN0MwJTdDMCU3QzYzNjkxNjM3MDQ0MjA3MDM0OSZhbXA7c2RhdGE9NXVYWDk1Q0Ql
MkZBSTVaU0pPTiUyQmpDQUtRODhzQXdaZ21lNkF6MFpIcEVHWm8lM0QmYW1wO3Jlc2VydmVkPTAg
Pj4gUmVtb3ZlIGZsdXNoX3RsYl9pbmZvIHZhcmlhYmxlcyBmcm9tIHRoZSBzdGFjay4gVGhpcyBh
bGxvd3MgdG8gYWxpZ24NCj4+Pj4gZmx1c2hfdGxiX2luZm8gdG8gY2FjaGUtbGluZSBhbmQgYXZv
aWQgcG90ZW50aWFsbHkgdW5uZWNlc3NhcnkgY2FjaGUNCj4+Pj4gbGluZSBtb3ZlbWVudHMuIEl0
IGFsc28gYWxsb3dzIHRvIGhhdmUgYSBmaXhlZCB2aXJ0dWFsLXRvLXBoeXNpY2FsDQo+Pj4+IHRy
YW5zbGF0aW9uIG9mIHRoZSB2YXJpYWJsZXMsIHdoaWNoIHJlZHVjZXMgVExCIG1pc3Nlcy4NCj4+
Pj4gDQo+Pj4+IFVzZSBwZXItQ1BVIHN0cnVjdCBmb3IgZmx1c2hfdGxiX21tX3JhbmdlKCkgYW5k
DQo+Pj4+IGZsdXNoX3RsYl9rZXJuZWxfcmFuZ2UoKS4gQWRkIGRlYnVnIGFzc2VydGlvbnMgdG8g
ZW5zdXJlIHRoZXJlIGFyZQ0KPj4+PiBubyBuZXN0ZWQgVExCIGZsdXNoZXMgdGhhdCBtaWdodCBv
dmVyd3JpdGUgdGhlIHBlci1DUFUgZGF0YS4gRm9yDQo+Pj4+IGFyY2hfdGxiYmF0Y2hfZmx1c2go
KSwgdXNlIGEgY29uc3Qgc3RydWN0Lg0KPj4+PiANCj4+Pj4gUmVzdWx0cyB3aGVuIHJ1bm5pbmcg
YSBtaWNyb2JlbmNobWFya3MgdGhhdCBwZXJmb3JtcyAxMF42IE1BRFZfRE9OVEVFRA0KPj4+PiBv
cGVyYXRpb25zIGFuZCB0b3VjaGluZyBhIHBhZ2UsIGluIHdoaWNoIDMgYWRkaXRpb25hbCB0aHJl
YWRzIHJ1biBhDQo+Pj4+IGJ1c3ktd2FpdCBsb29wICg1IHJ1bnMpOg0KPj4+IA0KPj4+IENhbiB5
b3UgYWRkIGEgbWVtc2V0KCwsLC4gMCwgc2l6ZW9mKHN0cnVjdCBmbHVzaF90bGJfaW5mbykpIGV2
ZXJ5d2hlcmUNCj4+PiB5b3UgZ3JhYiBpdD8gIE9yLCBldmVuIGJldHRlciwgcGVyaGFwcyBkbyBz
b21ldGhpbmcgbGlrZToNCj4+PiANCj4+PiBzdGF0aWMgaW5saW5lIHN0cnVjdCBmbHVzaF90bGJf
aW5mbyAqZ2V0X2ZsdXNoX3RsYl9pbmZvKHZvaWQpDQo+Pj4gew0KPj4+IC8qIGNoZWNrIHJlZW50
cmFuY3ksIG1ha2Ugc3VyZSB0aGF0IHdlIHVzZSBzbXBfcHJvY2Vzc29yX2lkKCkgb3INCj4+PiBv
dGhlcndpc2UgYXNzZXJ0IHRoYXQgd2UncmUgYm91bmQgdG8gYSBzaW5nbGUgQ1BVLiAqLw0KPj4+
IHN0cnVjdCBmbHVzaF90bGJfaW5mbyAqcHRyID0gdGhpc19jcHVfcHRyKC4uLik7DQo+Pj4gbWVt
c2V0KHB0ciwgMCwgc2l6ZW9mKCpwdHIpKTsNCj4+PiByZXR1cm4gcHRyOw0KPj4+IH0NCj4+PiAN
Cj4+PiBzdGF0aWMgaW5saW5lIHZvaWQgcHV0X2ZsdXNoX3RsYl9pbmZvKHZvaWQpDQo+Pj4gew0K
Pj4+IC8qIGZpbmlzaCBjaGVja2luZyByZWVudHJhbmN5LiAqLw0KPj4+IH0NCj4+IA0KPj4gSeKA
mWxsIGNoZWNrIGlmIHRoZSBjb21waWxlciBpcyBzbWFydCBlbm91Z2ggdG8gYXZvaWQgcmVkdW5k
YW50IGFzc2lnbm1lbnRzLA0KPj4gYW5kIGlmIGl0IGlzIG5vdCwgSeKAmWxsIGp1c3QgZ2l2ZSBh
bGwgdGhlIHN0cnVjdCBhcmd1bWVudHMgdG8NCj4+IGdldF9mbHVzaF90bGJfaW5mbygpIGluc3Rl
YWQgb2YgbWVtc2V0KCkgaWYgeW91IGRvbuKAmXQgbWluZC4NCj4gDQo+IFNvdW5kcyBnb29kLg0K
PiANCj4+IEkgYWxzbyB3YW50IHRvIGdpdmUgYSB0cnkgZm9yIHBhcmFsbGVsaXppbmcgdGhlIHJl
bW90ZSBhbmQgbG9jYWwNCj4+IGludm9jYXRpb25zLCB3aGljaCByZWFsbHkgYW5ub3lzIG1lIGV2
ZXJ5IHRpbWUgSSBsb29rIGF0IHRoZSBjb2RlLg0KPiANCj4gWWVzIHBsZWFzZSENCg0KSSBoYXZl
IHdyaXR0ZW4gc29tZSBwYXRjaGVzIGFuZCB0aGV5IGRvIHByb3ZpZGUgYSBjb25zaWRlcmFibGUg
cGVyZm9ybWFuY2UNCmltcHJvdmVtZW50IG9mICg+MTAlKSBmb3IgcmVtb3RlIFRMQiBmbHVzaGVz
LiBUaGVyZSBhcmUgc3RpbGwgc29tZSBpc3N1ZXMNCnRoYXQgbmVlZCB0byBiZSByZXNvbHZlZCwg
c3BlY2lmaWNhbGx5IGEgc21hbGwgc2xvd2Rvd24gZm9yIGxvY2FsIFRMQg0KZmx1c2hlcyAofjE1
bnMpLg0KDQpBbnlob3csIGJhc2VkIG9uIG15IHBhc3QgZXhwZXJpZW5jZSwgSSB3aWxsIGRvIHRo
aXMgY2hhbmdlIGluIGEgc2VwYXJhdGUNCnBhdGNoLXNldCBhZnRlciB0aGUgZmx1c2hfdGxiX2lu
Zm8gb2ZmLXN0YWNrIHBhdGNoIG1ha2VzIGl0IHRocm91Z2guDQoNCg==
