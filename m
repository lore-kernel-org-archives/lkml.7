Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033BEC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C396120652
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="tOvwGuhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfFQRHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:07:09 -0400
Received: from mail-eopbgr800079.outbound.protection.outlook.com ([40.107.80.79]:44960
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbfFQRHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdtBFsCyb1ODxBA3C9mlKHNQQQnXo4/sGCCtDX7iYIo=;
 b=tOvwGuhcMVbzTdrIfRz9ur1XQk8N+yudtxJ31+dxDgHM64jxO8GbZPCm8NJnKufzFF2sBfad5n1QxBo6jJsvAIhdLjQ4b0yjQLZVcfaxnpJNZ4g8U+THONBt8TL8oVOgLCO6i5HIQaEEHp/wl/6YU7RegkYJeMwwM8mLB3bqj90=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6488.namprd05.prod.outlook.com (20.178.233.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.12; Mon, 17 Jun 2019 17:06:26 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2008.007; Mon, 17 Jun 2019
 17:06:26 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Thread-Topic: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Thread-Index: AQHVG6Hh/1D55TFaG0m2GIoqEoQysaaQWUIAgAAd/ICAAAoFgIAFn62AgAB64ACAAAkkgIAB0jGAgAeHSoCAAChKgA==
Date:   Mon, 17 Jun 2019 17:06:26 +0000
Message-ID: <BDF83C06-31B9-42A9-8924-58C8317DB363@vmware.com>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <20190608004708.7646b287151cf613838ce05f@kernel.org>
 <20190607173427.GK3436@hirez.programming.kicks-ass.net>
 <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
 <20190611080307.GN3436@hirez.programming.kicks-ass.net>
 <20190611112254.576226fe@gandalf.local.home>
 <20190611155537.GB3436@hirez.programming.kicks-ass.net>
 <D9439F7B-3384-4BD5-B3BA-13EE52FEC15E@vmware.com>
 <20190617144213.GE3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190617144213.GE3436@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2829c803-2508-41bb-f4d3-08d6f3462215
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR05MB6488;
x-ms-traffictypediagnostic: BYAPR05MB6488:
x-microsoft-antispam-prvs: <BYAPR05MB6488F698E56771D5F53E3C71D0EB0@BYAPR05MB6488.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(6916009)(6436002)(6486002)(53936002)(6512007)(229853002)(25786009)(3846002)(14454004)(68736007)(81156014)(81166006)(8936002)(6116002)(478600001)(305945005)(8676002)(33656002)(4326008)(66446008)(66066001)(64756008)(76116006)(73956011)(66946007)(66476007)(66556008)(316002)(5660300002)(36756003)(86362001)(7736002)(2616005)(446003)(11346002)(476003)(99286004)(486006)(7416002)(76176011)(26005)(102836004)(186003)(2906002)(6506007)(53546011)(54906003)(6246003)(256004)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6488;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yrRZ0fYt2VHXTbZOEGCPZiXpDQdI6YF/H+W86ZxdrbCFnGyS9HEWWzoLl0zCDwKWPbKvbJy7GhOQdcPiqP/ZmJAr/3+LG7olN0eqxA7leRaqodmQ84wAKFv8mW0Bu7U0SB4Js9th/fsDIlqakpQjIOBz4i3Ylc6ZU+prrXOXGdHprQCia0PjRjFAWXAvw13tUKMJ1CXp6C70RT6KTmnTs3EU5Y5lnkGsBBPdsgJbbf7r2dPLKyAd43RQc3/5le6vv09dfwle56rFMFbps7lJoqkE81gw8n0JLiHUj8ktPnSM6kO7eYYVaOjVuC1CEbyp/fEgUq8ToD6yIbc83bGTTxReRaBqZgxOPJM7X0kl+613VVKlykjd56NiPQCX0t7TvZtK0I4oruCzpH9jS0+cQQjaloXA8CyBu6IvLmBw2RU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D967C3C3C437BD409B5437D7EAC8E73A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2829c803-2508-41bb-f4d3-08d6f3462215
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 17:06:26.3299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6488
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gMTcsIDIwMTksIGF0IDc6NDIgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEp1biAxMiwgMjAxOSBhdCAwNzo0NDox
MlBNICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPiANCj4+IEkgaGF2ZSBydW4gaW50byBzaW1p
bGFyIHByb2JsZW1zIGJlZm9yZS4NCj4+IA0KPj4gSSBoYWQgdHdvIHByb2JsZW1hdGljIHNjZW5h
cmlvcy4gSW4gdGhlIGZpcnN0IGNhc2UsIEkgaGFkIGEg4oCcY2FsbOKAnSBpbiB0aGUNCj4+IG1p
ZGRsZSBvZiB0aGUgcGF0Y2hlZCBjb2RlLWJsb2NrLCBidXQgdGhpcyBjYWxsIHdhcyBhbHdheXMg
Zm9sbG93ZWQgYnkgYQ0KPj4g4oCcanVtcOKAnSB0byB0aGUgZW5kIG9mIHRoZSBwb3RlbnRpYWxs
eSBwYXRjaGVkIGNvZGUtYmxvY2ssIHNvIEkgZGlkIG5vdCBoYXZlDQo+PiB0aGUgcHJvYmxlbS4N
Cj4+IA0KPj4gSW4gdGhlIHNlY29uZCBjYXNlLCBJIGhhZCBhbiBpbmRpcmVjdCBjYWxsICh3aGlj
aCBpcyBzaG9ydGVyIHRoYW4gYSBkaXJlY3QNCj4gDQo+IExvbmdlciwgNiBieXRlcyB2cyA1IGlm
IEknbSBub3QgbWlzdGFrZW4uDQoNClNob3J0ZXIgKDItMyBieXRlcyBJSVJDKSwgc2luY2UgdGhl
IHRhcmdldCB3YXMgaGVsZCBpbiBhIHJlZ2lzdGVyLg0KDQo+IA0KPj4gY2FsbCkgYmVpbmcgcGF0
Y2hlZCBpbnRvIGEgZGlyZWN0IGNhbGwuIEluIHRoaXMgY2FzZSwgSSBwcmVjZWRlZCB0aGUNCj4+
IGluZGlyZWN0IGNhbGwgd2l0aCBOT1BzIHNvIGluZGVlZCB0aGUgaW5kaXJlY3QgY2FsbCB3YXMg
YXQgdGhlIGVuZCBvZiB0aGUNCj4+IHBhdGNoZWQgYmxvY2suDQo+PiANCj4+IEluIGNlcnRhaW4g
Y2FzZXMsIGlmIGEgc2hvcnRlciBpbnN0cnVjdGlvbiBzaG91bGQgYmUgcG90ZW50aWFsbHkgcGF0
Y2hlZA0KPj4gaW50byBhIGxvbmdlciBvbmUsIHRoZSBzaG9ydGVyIG9uZSBjYW4gYmUgcHJlY2Vk
ZWQgYnkgc29tZSBwcmVmaXhlcy4gSWYNCj4+IHRoZXJlIGFyZSBtdWx0aXBsZSBSRVggcHJlZml4
ZXMsIGZvciBpbnN0YW5jZSwgdGhlIENQVSBvbmx5IHVzZXMgdGhlIGxhc3QNCj4+IG9uZSwgSUlS
Qy4gVGhpcyBjYW4gYWxsb3cgdG8gYXZvaWQgc3luY2hyb25pemVfc2NoZWQoKSB3aGVuIHBhdGNo
aW5nIGENCj4+IHNpbmdsZSBpbnN0cnVjdGlvbiBpbnRvIGFub3RoZXIgaW5zdHJ1Y3Rpb24gd2l0
aCBhIGRpZmZlcmVudCBsZW5ndGguDQo+PiANCj4+IE5vdCBzdXJlIGhvdyBoZWxwZnVsIHRoaXMg
aW5mb3JtYXRpb24gaXMsIGJ1dCBzaGFyaW5nIC0ganVzdCBpbiBjYXNlLg0KPiANCj4gSSB0aGlu
ayB3ZSBjYW4gcGF0Y2ggbXVsdGlwbGUgaW5zdHJ1Y3Rpb25zIHByb3ZpZGVkOg0KPiANCj4gLSBh
bGwgYnV0IG9uZSBpbnN0cnVjdGlvbiBhcmUgYSBOT1AsDQo+IC0gdGhlcmUgYXJlIG5vIGJyYW5j
aCB0YXJnZXRzIGluc2lkZSB0aGUgcmFuZ2UuDQo+IA0KPiBCeSBwb2tpbmcgSU5UMyBhdCBldmVy
eSBpbnN0cnVjdGlvbiBpbiB0aGUgcmFuZ2UgYW5kIHRoZW4gZG9pbmcgdGhlDQo+IG1hY2hpbmUg
d2lkZSBJUEkrU1lOQywgd2UnbGwgdHJhcCBldmVyeSBDUFUgdGhhdCBpcyBpbi1zaWRlIHRoZSBy
YW5nZS4NCj4gDQo+IEJlY2F1c2UgYWxsIGJ1dCBvbmUgaW5zdHJ1Y3Rpb24gYXJlIGEgTk9QLCB3
ZSBjYW4gZW11bGF0ZSBvbmx5IHRoZSBvbmUNCj4gaW5zdHJ1Y3Rpb24gKGFzc3VtaW5nIHRoZSBy
ZWFsIGluc3RydWN0aW9uIGlzIGFsd2F5cyBsYXN0KSwgb3RoZXJ3aXNlDQo+IE5PUCB3aGVuIHdl
J3JlIGJlaGluZCB0aGUgcmVhbCBpbnN0cnVjdGlvbi4NCj4gDQo+IFRoZW4gd2UgY2FuIHdyaXRl
IG5ldyBpbnN0cnVjdGlvbnMsIGxlYXZpbmcgdGhlIGluaXRpYWwgSU5UMyB1bnRpbCBsYXN0Lg0K
PiANCj4gU29tZXRoaW5nIGxpa2UgdGhpcyBtaWdodCBiZSB1c2VmdWwgaWYgd2Ugd2FudCB0byBz
dXBwb3J0IGltbWVkaWF0ZQ0KPiBpbnN0cnVjdGlvbnMgKGxpa2UgcGF0Y2hfZGF0YV8qIGluIHBh
cmF2aXJ0X3BhdGNoLmMpIGZvciBzdGF0aWNfY2FsbCgpLg0KDQpJIGRvbuKAmXQga25vdyB3aGF0
IHlvdSByZWdhcmQgd2hlbiB5b3Ugc2F5IFNZTkMsIGJ1dCBpZiB5b3UgcmVnYXJkIHNvbWV0aGlu
Zw0KbGlrZSBzeW5jX2NvcmUoKSAoaW4gY29udHJhc3QgdG8gc29tZXRoaW5nIGxpa2Ugc3luY2hy
b25pemVfc2NoZWQoKSApLCBJIGFtDQpub3Qgc3VyZSBpdCBpcyBzdWZmaWNpZW50Lg0KDQpVc2lu
ZyBJUEkrc3luY19jb3JlKCksIEkgdGhpbmssIHdvdWxkIG1ha2UgYW4gYXNzdW1wdGlvbiB0aGF0
IElSUXMgYXJlIG5ldmVyDQplbmFibGVkIGluc2lkZSBJUlEgYW5kIGV4Y2VwdGlvbiBoYW5kbGVy
cywgb3IgdGhhdCB0aGVzZSBoYW5kbGVycyB3b3VsZCBub3QNCmJlIGludm9rZWQgd2hpbGUgdGhl
IHBhdGNoZWQgY29kZSBpcyBleGVjdXRlZC4gT3RoZXJ3aXNlLCB0aGUgSVBJIG1pZ2h0IGJlDQpy
ZWNlaXZlZCBpbnNpZGUgdGhlIElSUS9leGNlcHRpb24gaGFuZGxlciwgYW5kIHRoZW4gcmV0dXJu
IGZyb20gdGhlIGhhbmRsZXINCndpbGwgYmUgaW50byB0aGUgbWlkZGxlIG9mIGEgcGF0Y2hlZCBp
bnN0cnVjdGlvbi4NCg0K
