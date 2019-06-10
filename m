Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2708C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA70220859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="DkC8d8/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfFJSdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:33:31 -0400
Received: from mail-eopbgr760082.outbound.protection.outlook.com ([40.107.76.82]:31810
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfFJSdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4349Ag5TwFjMal1qdK6vBfS133VwfRuv8LCUFKhZac=;
 b=DkC8d8/NMTOPWJCIZyhxufKgawZ0jJzRZ5enXQnlowCtu6SwOvH1AZF34GMtEIOSXYMaoI/cRC0SklgXlJ5xvWQ5VEMuM3qJV9Ei6P+8LNG00qe8c4ioahz6UxclvdYQM1mpfwJsyFUtsn7LMj74tFtQR2VWan3F/hMZtW9yk4c=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4856.namprd05.prod.outlook.com (52.135.235.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.9; Mon, 10 Jun 2019 18:33:26 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::134:af66:bedb:ead9]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::134:af66:bedb:ead9%3]) with mapi id 15.20.1987.008; Mon, 10 Jun 2019
 18:33:26 +0000
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
Subject: Re: [PATCH 11/15] static_call: Add inline static call infrastructure
Thread-Topic: [PATCH 11/15] static_call: Add inline static call infrastructure
Thread-Index: AQHVG6HczY7CfFoeek66Q905fEQkc6aPNeMAgACrdACABUi3gIAAFKkA
Date:   Mon, 10 Jun 2019 18:33:26 +0000
Message-ID: <757720BF-5DC6-44E7-A549-E542096BC077@vmware.com>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.193241464@infradead.org>
 <37CFAEC1-6D36-4A6D-8C44-F85FCFA053AA@vmware.com>
 <20190607083756.GW3419@hirez.programming.kicks-ass.net>
 <20190610171929.3xemvsykvkswcvya@treble>
In-Reply-To: <20190610171929.3xemvsykvkswcvya@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0f5548f-923a-45a9-7553-08d6edd220d2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4856;
x-ms-traffictypediagnostic: BYAPR05MB4856:
x-microsoft-antispam-prvs: <BYAPR05MB4856D6120C19A8043616935CD0130@BYAPR05MB4856.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(366004)(39860400002)(199004)(189003)(51444003)(6512007)(64756008)(66556008)(53936002)(8936002)(71200400001)(478600001)(6436002)(81156014)(6916009)(33656002)(82746002)(256004)(14444005)(76176011)(76116006)(36756003)(66446008)(83716004)(86362001)(66946007)(71190400001)(73956011)(66476007)(26005)(68736007)(446003)(7416002)(5660300002)(81166006)(2616005)(11346002)(476003)(486006)(99286004)(102836004)(6506007)(53546011)(186003)(316002)(2906002)(14454004)(54906003)(3846002)(4326008)(8676002)(305945005)(6486002)(6116002)(229853002)(7736002)(25786009)(66066001)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4856;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g1wDvdqIWm9YPBSQAzrQkA/BBXHqBFdyH0AA7tQTNEqFEI9oSH4Sa4GweiA9sSOfqiT4jyxABp30tnf6G6XV6+qSj3RRx3+e7PAth/lN+ajAEez1+gSoYCVTtNWg+Q1Q1e7h/oa9IFcJbH7ont/vv/I6EwG3Fkes5BcSqkGxEHqWBUVRZdQr5Nkxh8ALxFvNCKJ8MGbzbHAeZiKoJPQ6r9rqTC5+R1AbwlqdYINgOwDNVzrf8tOCaPIhE/TGNPJ3hhmrf/HFLFKcCL4skq4hHj6TJTTCSlOQGvGZRRy4WMKJ47MZkS5U38Xorywc8aGBrNbMzDmNcvgzxEXd7V4gcHo4F955p25tKvZKSfD/OJzHhS3sBzdEcVAAIwIfp5q0c905oRLxd5QLA1mWEvB40T3SgJDCik9qy+0a2m1o5Vc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4752DF78654944E8E1D9768AAA63455@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f5548f-923a-45a9-7553-08d6edd220d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 18:33:26.7293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gMTAsIDIwMTksIGF0IDEwOjE5IEFNLCBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIEp1biAwNywgMjAxOSBhdCAxMDozNzo1
NkFNICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiAr
c3RhdGljIGludCBzdGF0aWNfY2FsbF9tb2R1bGVfbm90aWZ5KHN0cnVjdCBub3RpZmllcl9ibG9j
ayAqbmIsDQo+Pj4+ICsJCQkJICAgICB1bnNpZ25lZCBsb25nIHZhbCwgdm9pZCAqZGF0YSkNCj4+
Pj4gK3sNCj4+Pj4gKwlzdHJ1Y3QgbW9kdWxlICptb2QgPSBkYXRhOw0KPj4+PiArCWludCByZXQg
PSAwOw0KPj4+PiArDQo+Pj4+ICsJY3B1c19yZWFkX2xvY2soKTsNCj4+Pj4gKwlzdGF0aWNfY2Fs
bF9sb2NrKCk7DQo+Pj4+ICsNCj4+Pj4gKwlzd2l0Y2ggKHZhbCkgew0KPj4+PiArCWNhc2UgTU9E
VUxFX1NUQVRFX0NPTUlORzoNCj4+Pj4gKwkJbW9kdWxlX2Rpc2FibGVfcm8obW9kKTsNCj4+Pj4g
KwkJcmV0ID0gc3RhdGljX2NhbGxfYWRkX21vZHVsZShtb2QpOw0KPj4+PiArCQltb2R1bGVfZW5h
YmxlX3JvKG1vZCwgZmFsc2UpOw0KPj4+IA0KPj4+IERvZXNu4oCZdCBpdCBjYXVzZSBzb21lIHBh
Z2VzIHRvIGJlIFcrWCA/DQo+IA0KPiBIb3cgc28/DQo+IA0KPj4+IENhbiBpdCBiZSBhdm9pZGVk
Pw0KPj4gDQo+PiBJIGRvbid0IGtub3cgd2h5IGl0IGRvZXMgdGhpcywganVtcF9sYWJlbHMgZG9l
c24ndCBzZWVtIHRvIG5lZWQgdGhpcywNCj4+IGFuZCBJJ20gbm90IHNlZWluZyB3aGF0IHN0YXRp
Y19jYWxsIG5lZWRzIGRpZmZlcmVudGx5Lg0KPiANCj4gSSBmb3Jnb3Qgd2h5IEkgZGlkIHRoaXMs
IGJ1dCBpdCdzIHByb2JhYmx5IGZvciB0aGUgY2FzZSB3aGVyZSB0aGVyZSdzIGENCj4gc3RhdGlj
IGNhbGwgc2l0ZSBpbiBtb2R1bGUgaW5pdCBjb2RlLiAgSXQgZGVzZXJ2ZXMgYSBjb21tZW50Lg0K
PiANCj4gVGhlb3JldGljYWxseSwganVtcCBsYWJlbHMgbmVlZCB0aGlzIHRvLg0KPiANCj4gQlRX
LCB0aGVyZSdzIGEgY2hhbmdlIGNvbWluZyB0aGF0IHdpbGwgcmVxdWlyZSB0aGUgdGV4dF9tdXRl
eCBiZWZvcmUNCj4gY2FsbGluZyBtb2R1bGVfe2Rpc2FibGUsZW5hYmxlfV9ybygpLg0KDQpJIHRo
aW5rIHRoYXQgZXZlbnR1YWxseSwgdGhlIG1vc3Qgc2VjdXJlIGZsb3cgaXMgZm9yIHRoZSBtb2R1
bGUgZXhlY3V0YWJsZQ0KdG8gYmUgd3JpdGUtcHJvdGVjdGVkIGltbWVkaWF0ZWx5IGFmdGVyIHRo
ZSBtb2R1bGUgc2lnbmF0dXJlIGlzIGNoZWNrZWQgYW5kDQp0aGVuIHVzZSB0ZXh0X3Bva2UoKSB0
byBjaGFuZ2UgdGhlIGNvZGUgd2l0aG91dCByZW1vdmluZyB0aGUNCndyaXRlLXByb3RlY3Rpb24g
aW4gc3VjaCBtYW5uZXIuDQoNCklkZWFsbHksIHRoZXNlIHBpZWNlcyBvZiBjb2RlIChtb2R1bGUg
c2lnbmF0dXJlIGNoZWNrIGFuZCBzdGF0aWMta2V5L2NhbGwNCm1lY2hhbmlzbXMpIHdvdWxkIHNv
bWVob3cgYmUgaXNvbGF0ZWQuDQoNCkkgd29uZGVyIHdoZXRoZXIgc3RhdGljLWNhbGxzIGluIGlu
aXQtY29kZSBjYW5ub3QganVzdCBiZSBhdm9pZGVkLiBUaGV5DQp3b3VsZCBtb3N0IGxpa2VseSBp
bnRyb2R1Y2UgbW9yZSBvdmVyaGVhZCBpbiBwYXRjaGluZyB0aGFuIHRoZXkgd291bGQgc2F2ZQ0K
aW4gZXhlY3V0aW9uIHRpbWUuDQoNCg==
