Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4487DC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9A320820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="TsTK7lUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbfFJSqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:46:00 -0400
Received: from mail-eopbgr750044.outbound.protection.outlook.com ([40.107.75.44]:16033
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387643AbfFJSp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7UoZtI4cOmaUIZpi90EYVLT7+4P18Hw37/tcKZEN9o=;
 b=TsTK7lUjcxWUshBhc+kMj9iUajBttsf9f1FrPuQJEEtJNE+IptZdP/fRDzZvwNgur8disExjsRGp4Shbf5BQvqs6IX4QJzFZZUxFX8qjpUOVixgXzuAdzB0cPxXqKeV6VJzfKmclQBOP5bwsb0tRmGNy1CdIaj3XaN4lJRpnQW4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6389.namprd05.prod.outlook.com (20.178.232.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.7; Mon, 10 Jun 2019 18:45:53 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::134:af66:bedb:ead9]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::134:af66:bedb:ead9%3]) with mapi id 15.20.1987.008; Mon, 10 Jun 2019
 18:45:52 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 13/15] x86/static_call: Add inline static call
 implementation for x86-64
Thread-Topic: [PATCH 13/15] x86/static_call: Add inline static call
 implementation for x86-64
Thread-Index: AQHVG6HbUZEsVsjdrUOVxRZQdAn/WKaVPtyAgAADVIA=
Date:   Mon, 10 Jun 2019 18:45:52 +0000
Message-ID: <40096B8A-C063-4219-89FC-A8E42981BF28@vmware.com>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.313688119@infradead.org>
 <20190610183357.zj6rwdpgw36anpfc@treble>
In-Reply-To: <20190610183357.zj6rwdpgw36anpfc@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d0dbba8-dd68-444e-dda0-08d6edd3dd83
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6389;
x-ms-traffictypediagnostic: BYAPR05MB6389:
x-microsoft-antispam-prvs: <BYAPR05MB6389AF282291FD1F4FFCC31AD0130@BYAPR05MB6389.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(54094003)(189003)(6436002)(25786009)(5660300002)(86362001)(83716004)(71190400001)(71200400001)(3846002)(6116002)(53936002)(6246003)(4326008)(229853002)(33656002)(256004)(316002)(82746002)(6486002)(6512007)(54906003)(81166006)(186003)(486006)(2616005)(11346002)(305945005)(446003)(8676002)(66066001)(7736002)(81156014)(7416002)(8936002)(76116006)(2906002)(476003)(66556008)(66476007)(64756008)(68736007)(66946007)(66446008)(76176011)(99286004)(36756003)(6916009)(73956011)(102836004)(26005)(478600001)(6506007)(14454004)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6389;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nd+YuBq3TtzmF0vO7+XogWeH1kNs5a3Pl4jz91Kuxuufh58Cr6+UGMm3kUmRVBvCMJLLoRwUpvBG8ESRwuVzV1VPQkEm13UlB3tRjWN5+WLMnJBWvsCjVJA7vwn9wT5QNQM5m82bM5zE0nvXjpJpzcQg37GfALuSEfhdmoeSe1V1qAYtNusCt9vC3ab027bFF8UBsAsiVrqokNix7sKUJ5awyp0tf6pZMF9wIGDpYcTSmcxsquNKr7dYN0kp+/uR8X7NaSJtAi+CJCXtoLy+P0ckU2IlkPAQmoagrLETvCFCL+2E16XGW4gudS6KMsgUfA6gRXpsIDf4PnnThfKZLv5WcL1GeneNGPs1yApC6vHBJ37srqzc4etbSKo4f1Bp6RNytUUUAoFd3RIhJeJ7wYgPY8O5qXrsuyKfNe/1jUo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED5D4475B15428419DB0B4DF2C368EA9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0dbba8-dd68-444e-dda0-08d6edd3dd83
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 18:45:52.7824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6389
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gMTAsIDIwMTksIGF0IDExOjMzIEFNLCBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEp1biAwNSwgMjAxOSBhdCAwMzowODow
NlBNICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+IC0tLSBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3N0YXRpY19jYWxsLmgNCj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3N0YXRp
Y19jYWxsLmgNCj4+IEBAIC0yLDYgKzIsMjAgQEANCj4+ICNpZm5kZWYgX0FTTV9TVEFUSUNfQ0FM
TF9IDQo+PiAjZGVmaW5lIF9BU01fU1RBVElDX0NBTExfSA0KPj4gDQo+PiArI2luY2x1ZGUgPGFz
bS9hc20tb2Zmc2V0cy5oPg0KPj4gKw0KPj4gKyNpZmRlZiBDT05GSUdfSEFWRV9TVEFUSUNfQ0FM
TF9JTkxJTkUNCj4+ICsNCj4+ICsvKg0KPj4gKyAqIFRoaXMgdHJhbXBvbGluZSBpcyBvbmx5IHVz
ZWQgZHVyaW5nIGJvb3QgLyBtb2R1bGUgaW5pdCwgc28gaXQncyBzYWZlIHRvIHVzZQ0KPj4gKyAq
IHRoZSBpbmRpcmVjdCBicmFuY2ggd2l0aG91dCBhIHJldHBvbGluZS4NCj4+ICsgKi8NCj4+ICsj
ZGVmaW5lIF9fQVJDSF9TVEFUSUNfQ0FMTF9UUkFNUF9KTVAoa2V5LCBmdW5jKQkJCQlcDQo+PiAr
CUFOTk9UQVRFX1JFVFBPTElORV9TQUZFCQkJCQkJXA0KPj4gKwkiam1wcSAqIiBfX3N0cmluZ2lm
eShrZXkpICIrIiBfX3N0cmluZ2lmeShTQ19LRVlfZnVuYykgIiglcmlwKSBcbiINCj4+ICsNCj4+
ICsjZWxzZSAvKiAhQ09ORklHX0hBVkVfU1RBVElDX0NBTExfSU5MSU5FICovDQo+IA0KPiBJIHdv
bmRlciBpZiB3ZSBjYW4gc2ltcGxpZnkgdGhpcyAoYW5kIGRyb3AgdGhlIGluZGlyZWN0IGJyYW5j
aCkgYnkNCj4gZ2V0dGluZyByaWQgb2YgdGhlIGFib3ZlIGNydWZ0LCBhbmQgaW5zdGVhZCBqdXN0
IHVzZSB0aGUgb3V0LW9mLWxpbmUNCj4gdHJhbXBvbGluZSBhcyB0aGUgZGVmYXVsdCBmb3IgaW5s
aW5lIGFzIHdlbGwuDQo+IA0KPiBUaGVuIHRoZSBpbmxpbmUgY2FzZSBjb3VsZCBmYWxsIGJhY2sg
dG8gdGhlIG91dC1vZi1saW5lIGltcGxlbWVudGF0aW9uDQo+IChieSBwYXRjaGluZyB0aGUgdHJh
bXBvbGluZSdzIGptcCBkZXN0KSBiZWZvcmUgc3RhdGljX2NhbGxfaW5pdGlhbGl6ZWQNCj4gaXMg
c2V0Lg0KDQpJIG11c3QgYmUgbWlzc2luZyBzb21lIGNvbnRleHQgLSBidXQgd2hhdCBndWFyYW50
ZWVzIHRoYXQgdGhpcyBpbmRpcmVjdA0KYnJhbmNoIHdvdWxkIGJlIGV4YWN0bHkgNSBieXRlcyBs
b25nPyBJc27igJl0IHRoZXJlIGFuIGFzc3VtcHRpb24gdGhhdCB0aGlzDQp3b3VsZCBiZSB0aGUg
Y2FzZT8gU2hvdWxkbuKAmXQgdGhlcmUgYmUgc29tZSBoYW5kbGluZyBvZiB0aGUgcGFkZGluZz8N
Cg0K
