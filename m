Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522F4C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187CF21721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="SbXR8SPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfFLTo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:44:29 -0400
Received: from mail-eopbgr710078.outbound.protection.outlook.com ([40.107.71.78]:28208
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727496AbfFLTo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFbtcByPCXyFKi1CjfAPhZqaj0+jnFnlih7fgZFDees=;
 b=SbXR8SPrTddBEtV5ETofDu+OOW00TGlqDoLLGas7V28H9nhXhi7QYsiQvzdULdkOnGwcTWPmIOjKTwpiF8CDDoqvndlZf8gjjp9CVJFXL0I3/pG9V1jQ/lGs84Y/vBspUlpIWGyJ2k+j1trbJGIkOfKes6SB8zl9A8CZPYqTYIM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB3991.namprd05.prod.outlook.com (52.135.199.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.9; Wed, 12 Jun 2019 19:44:12 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::134:af66:bedb:ead9]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::134:af66:bedb:ead9%3]) with mapi id 15.20.1987.008; Wed, 12 Jun 2019
 19:44:12 +0000
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
Thread-Index: AQHVG6Hh/1D55TFaG0m2GIoqEoQysaaQWUIAgAAd/ICAAAoFgIAFn62AgAB64ACAAAkkgIAB0jGA
Date:   Wed, 12 Jun 2019 19:44:12 +0000
Message-ID: <D9439F7B-3384-4BD5-B3BA-13EE52FEC15E@vmware.com>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <20190608004708.7646b287151cf613838ce05f@kernel.org>
 <20190607173427.GK3436@hirez.programming.kicks-ass.net>
 <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
 <20190611080307.GN3436@hirez.programming.kicks-ass.net>
 <20190611112254.576226fe@gandalf.local.home>
 <20190611155537.GB3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190611155537.GB3436@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf0622b0-0370-4696-7253-08d6ef6e5856
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB3991;
x-ms-traffictypediagnostic: BYAPR05MB3991:
x-microsoft-antispam-prvs: <BYAPR05MB3991D71A9FC0AE480C2AB9F0D0EC0@BYAPR05MB3991.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(366004)(52314003)(199004)(189003)(71200400001)(11346002)(26005)(478600001)(99286004)(8936002)(6436002)(486006)(36756003)(4326008)(446003)(2906002)(53936002)(3846002)(66066001)(6916009)(229853002)(256004)(476003)(6486002)(2616005)(6512007)(6246003)(186003)(6116002)(7416002)(68736007)(33656002)(8676002)(66946007)(66446008)(64756008)(66556008)(73956011)(305945005)(66476007)(14444005)(76176011)(54906003)(316002)(25786009)(81166006)(5660300002)(102836004)(81156014)(86362001)(76116006)(7736002)(53546011)(14454004)(71190400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3991;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dQkm2a3KXxuvBEnlyJJJ714kPyQsyVa2DXy2IQAdE1KeoX2l+Qlz53yS3/JL+843ASzKvuFLG8EuHtoNmsinSJF5FHhYYOjLyAI80TdzR5SGIYkQoRHCGu6qyF8mu2nLHuxhN5+V49gfN6B6k1Jz9o6RzFXHummis58mHQbIj2fZcMBdSG93uH2DjBLnt/3MHE8ZbyK8WG/hevLLcK33doYFE6YGnJspgvA7H4AmjEUVIg3V4XvzKTsP+jLD/UbYC+kiz3lfP3DKYFi6dkYLMvcmxkCkYBZNeFUnmCLIK/PldDlMD7V7Iu9jZ3wpk9lJsxGAdIzwiAKCCh2Hkkmtt/5/I/FlGN5wpxCJfMKBD3PtMpAs3z/WGYL0FM6xbhRo5X+9KmE11IH/o85N/J01y9RHHjakRbFFUHxUIAmohNg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DECF3EE529FF046B1C128E0ECBD793A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0622b0-0370-4696-7253-08d6ef6e5856
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 19:44:12.4376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3991
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gMTEsIDIwMTksIGF0IDg6NTUgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIEp1biAxMSwgMjAxOSBhdCAxMToyMjo1
NEFNIC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToNCj4+IE9uIFR1ZSwgMTEgSnVuIDIwMTkg
MTA6MDM6MDcgKzAyMDANCj4+IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4g
d3JvdGU6DQo+PiANCj4+IA0KPj4+IFNvIHdoYXQgaGFwcGVucyBpcyB0aGF0IGFyY2hfcHJlcGFy
ZV9vcHRpbWl6ZWRfa3Byb2JlKCkgPC0NCj4+PiBjb3B5X29wdGltaXplZF9pbnN0cnVjdGlvbnMo
KSBjb3BpZXMgaG93ZXZlciBtdWNoIG9mIHRoZSBpbnN0cnVjdGlvbg0KPj4+IHN0cmVhbSBpcyBy
ZXF1aXJlZCBzdWNoIHRoYXQgd2UgY2FuIG92ZXJ3cml0ZSB0aGUgaW5zdHJ1Y3Rpb24gYXQgQGFk
ZHINCj4+PiB3aXRoIGEgNSBieXRlIGp1bXAuDQo+Pj4gDQo+Pj4gYXJjaF9vcHRpbWl6ZV9rcHJv
YmUoKSB0aGVuIGRvZXMgdGhlIHRleHRfcG9rZV9icCgpIHRoYXQgcmVwbGFjZXMgdGhlDQo+Pj4g
aW5zdHJ1Y3Rpb24gQGFkZHIgd2l0aCBpbnQzLCBjb3BpZXMgdGhlIHJlbCBqdW1wIGFkZHJlc3Mg
YW5kIG92ZXJ3cml0ZXMNCj4+PiB0aGUgaW50MyB3aXRoIGptcC4NCj4+PiANCj4+PiBBbmQgSSdt
IHRoaW5raW5nIHRoZSBwcm9ibGVtIGlzIHdpdGggc29tZXRoaW5nIGxpa2U6DQo+Pj4gDQo+Pj4g
QGFkZHI6IG5vcCBub3Agbm9wIG5vcCBub3ANCj4+IA0KPj4gV2hhdCB3b3VsZCB3b3JrIHdvdWxk
IGJlIHRvOg0KPj4gDQo+PiAJYWRkIGJyZWFrcG9pbnQgdG8gZmlyc3Qgb3Bjb2RlLg0KPj4gDQo+
PiAJY2FsbCBzeW5jaHJvbml6ZV90YXNrcygpOw0KPj4gDQo+PiAJLyogQWxsIHRhc2tzIG5vdyBo
aXR0aW5nIGJyZWFrcG9pbnQgYW5kIGp1bXBpbmcgb3ZlciBhZmZlY3RlZA0KPj4gCWNvZGUgKi8N
Cj4+IA0KPj4gCXVwZGF0ZSB0aGUgcmVzdCBvZiB0aGUgaW5zdHJ1Y3Rpb25zLg0KPj4gDQo+PiAJ
cmVwbGFjZSBicmVha3BvaW50IHdpdGggam1wLg0KPj4gDQo+PiBPbmUgY2F2ZWF0IGlzIHRoYXQg
dGhlIHJlcGxhY2VkIGluc3RydWN0aW9ucyBtdXN0IG5vdCBiZSBhIGNhbGwNCj4+IGZ1bmN0aW9u
LiBBcyBpZiB0aGUgY2FsbCBmdW5jdGlvbiBjYWxscyBzY2hlZHVsZSB0aGVuIGl0IHdpbGwNCj4+
IGNpcmN1bXZlbnQgdGhlIHN5bmNocm9uaXplX3Rhc2tzKCkuIEl0IHdvdWxkIGJlIE9LIGlmIHRo
YXQgY2FsbCBpcyB0aGUNCj4+IGxhc3Qgb2YgdGhlIGluc3RydWN0aW9ucy4gQnV0IEkgZG91YnQg
d2UgbW9kaWZ5IGFueXRoaW5nIG1vcmUgdGhlbiBhDQo+PiBjYWxsIHNpemUgYW55d2F5LCBzbyB0
aGlzIHNob3VsZCBzdGlsbCB3b3JrIGZvciBhbGwgY3VycmVudCBpbnN0YW5jZXMuDQo+IA0KPiBS
aWdodCwgc29tZXRoaW5nIGxpa2UgdGhpcyBjb3VsZCB3b3JrIChhbHRob3VnaCBJIGNhbm5vdCBj
dXJyZW50bHkgZmluZA0KPiBzeW5jaHJvbml6ZV90YXNrcyksIGJ1dCBpdCB3b3VsZCBtYWtlIHRo
ZSBvcHRwcm9iZSBzdHVmZiBmYWlybHkgc2xvdw0KPiAoaWlyYyB0aGlzIHN5bmNfdGFza3MoKSB0
aGluZyBjb3VsZCBiZSBwcmV0dHkgaG9ycmlibGUpLg0KDQpJIGhhdmUgcnVuIGludG8gc2ltaWxh
ciBwcm9ibGVtcyBiZWZvcmUuDQoNCkkgaGFkIHR3byBwcm9ibGVtYXRpYyBzY2VuYXJpb3MuIElu
IHRoZSBmaXJzdCBjYXNlLCBJIGhhZCBhIOKAnGNhbGzigJ0gaW4gdGhlDQptaWRkbGUgb2YgdGhl
IHBhdGNoZWQgY29kZS1ibG9jaywgYnV0IHRoaXMgY2FsbCB3YXMgYWx3YXlzIGZvbGxvd2VkIGJ5
IGENCuKAnGp1bXDigJ0gdG8gdGhlIGVuZCBvZiB0aGUgcG90ZW50aWFsbHkgcGF0Y2hlZCBjb2Rl
LWJsb2NrLCBzbyBJIGRpZCBub3QgaGF2ZQ0KdGhlIHByb2JsZW0uDQoNCkluIHRoZSBzZWNvbmQg
Y2FzZSwgSSBoYWQgYW4gaW5kaXJlY3QgY2FsbCAod2hpY2ggaXMgc2hvcnRlciB0aGFuIGEgZGly
ZWN0DQpjYWxsKSBiZWluZyBwYXRjaGVkIGludG8gYSBkaXJlY3QgY2FsbC4gSW4gdGhpcyBjYXNl
LCBJIHByZWNlZGVkIHRoZQ0KaW5kaXJlY3QgY2FsbCB3aXRoIE5PUHMgc28gaW5kZWVkIHRoZSBp
bmRpcmVjdCBjYWxsIHdhcyBhdCB0aGUgZW5kIG9mIHRoZQ0KcGF0Y2hlZCBibG9jay4NCg0KSW4g
Y2VydGFpbiBjYXNlcywgaWYgYSBzaG9ydGVyIGluc3RydWN0aW9uIHNob3VsZCBiZSBwb3RlbnRp
YWxseSBwYXRjaGVkDQppbnRvIGEgbG9uZ2VyIG9uZSwgdGhlIHNob3J0ZXIgb25lIGNhbiBiZSBw
cmVjZWRlZCBieSBzb21lIHByZWZpeGVzLiBJZg0KdGhlcmUgYXJlIG11bHRpcGxlIFJFWCBwcmVm
aXhlcywgZm9yIGluc3RhbmNlLCB0aGUgQ1BVIG9ubHkgdXNlcyB0aGUgbGFzdA0Kb25lLCBJSVJD
LiBUaGlzIGNhbiBhbGxvdyB0byBhdm9pZCBzeW5jaHJvbml6ZV9zY2hlZCgpIHdoZW4gcGF0Y2hp
bmcgYQ0Kc2luZ2xlIGluc3RydWN0aW9uIGludG8gYW5vdGhlciBpbnN0cnVjdGlvbiB3aXRoIGEg
ZGlmZmVyZW50IGxlbmd0aC4NCg0KTm90IHN1cmUgaG93IGhlbHBmdWwgdGhpcyBpbmZvcm1hdGlv
biBpcywgYnV0IHNoYXJpbmcgLSBqdXN0IGluIGNhc2Uu
