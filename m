Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7A2C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCC520859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Ssxbekto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfE0S7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:59:05 -0400
Received: from mail-eopbgr750059.outbound.protection.outlook.com ([40.107.75.59]:2535
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbfE0S7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWLC2FYPtvCHcLh8twJv2iYkoyftVCTb9ozHzdsHMEo=;
 b=SsxbektoIdkEp5FMbR+jPfMz69+ZfugqV/mfMY0/EtNg26ycP21kPh56kl9tMoURNmn9MOnmk+TEZ4uelj7uyoAFi1CyWURkI8UesGZaEvJ9ChfglY/MKNCkgPNnFTR3kwppBpxfK+kcbngzRPDgKN3ofjO8dF6DtZATzoC9ZlQ=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5192.namprd05.prod.outlook.com (20.177.231.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.14; Mon, 27 May 2019 18:59:01 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::2cb6:a3d1:f675:ced8%3]) with mapi id 15.20.1943.007; Mon, 27 May 2019
 18:59:01 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH 4/6] x86/mm/tlb: Refactor common code into
 flush_tlb_on_cpus()
Thread-Topic: [RFC PATCH 4/6] x86/mm/tlb: Refactor common code into
 flush_tlb_on_cpus()
Thread-Index: AQHVEtL2po/8BdVr106IVsPwtVikSqZ+tlgAgACgfgA=
Date:   Mon, 27 May 2019 18:59:01 +0000
Message-ID: <9BE478F9-C700-46C5-80BC-B905FD0AAB17@vmware.com>
References: <20190525082203.6531-1-namit@vmware.com>
 <20190525082203.6531-5-namit@vmware.com>
 <20190527092434.GT2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190527092434.GT2623@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e2f17b3-ec4b-4255-9b6f-08d6e2d5619b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR05MB5192;
x-ms-traffictypediagnostic: BYAPR05MB5192:
x-microsoft-antispam-prvs: <BYAPR05MB5192F172F96E191D55EB9D3DD01D0@BYAPR05MB5192.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(396003)(366004)(376002)(39860400002)(136003)(199004)(189003)(53936002)(66066001)(99286004)(73956011)(36756003)(4326008)(6916009)(3846002)(81166006)(81156014)(476003)(8676002)(6116002)(86362001)(486006)(66476007)(66446008)(66556008)(64756008)(66946007)(68736007)(14454004)(76116006)(8936002)(6246003)(6436002)(14444005)(186003)(256004)(446003)(2616005)(71190400001)(71200400001)(33656002)(11346002)(316002)(53546011)(6506007)(102836004)(6486002)(76176011)(2906002)(305945005)(54906003)(6512007)(25786009)(7736002)(229853002)(82746002)(83716004)(478600001)(26005)(5660300002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5192;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u26AeWEgDjMwDG/qXODsxz0AmWRs86wQloV6LU62ML63ILWBm4/gmwBdIM4NIuqTOSVFvRflbli1dOIz8vXOEIZU4zunEMgEaD9bdZ/5uZ+M+nuSd6K1d8qyom6Wl4CVC9YKgZhB5ksJ+KgPQmJ4iSbNywlaXp1ptIazm2Ph2nEPl0tCEAYeYyGYKO5XO65d4DywZ5GMUXE9Y+XSRoDXSs4DMvpfY2hAoks1hh6h0s685jSwd6gC4WmuXk+efoeSqzZTtvNYi5atkmJI1K0lLqc/8+C5b4WSyP3q86fH2Ff/e+syMcJQmijSxmbx/2Auvy9R48NFQFNATMKepLif2xuL0x5gzqqUPGcfeJ0rbypUTMLUxOEmzsmVVRC1kVA4b0RCL3tpbajKKQg89wHWcSgBidx5TN5f6E9k4+2a9KE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21D22761F01C36439EE15CE57B735EB8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2f17b3-ec4b-4255-9b6f-08d6e2d5619b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 18:59:01.1683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNYXkgMjcsIDIwMTksIGF0IDI6MjQgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIE1heSAyNSwgMjAxOSBhdCAwMToyMjow
MUFNIC0wNzAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPiANCj4+IFRoZXJlIGlzIG9uZSBmdW5jdGlv
bmFsIGNoYW5nZSwgd2hpY2ggc2hvdWxkIG5vdCBhZmZlY3QgY29ycmVjdG5lc3M6DQo+PiBmbHVz
aF90bGJfbW1fcmFuZ2UgY29tcGFyZWQgbG9hZGVkX21tIGFuZCB0aGUgbW0gdG8gZmlndXJlIG91
dCBpZiBsb2NhbA0KPj4gZmx1c2ggaXMgbmVlZGVkLiBJbnN0ZWFkLCB0aGUgY29tbW9uIGNvZGUg
d291bGQgbG9vayBhdCB0aGUgbW1fY3B1bWFzaygpDQo+PiB3aGljaCBzaG91bGQgZ2l2ZSB0aGUg
c2FtZSByZXN1bHQuDQo+IA0KPj4gQEAgLTc4NiwxOCArODA0LDkgQEAgdm9pZCBmbHVzaF90bGJf
bW1fcmFuZ2Uoc3RydWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcgc3RhcnQsDQo+PiAJ
aW5mbyA9IGdldF9mbHVzaF90bGJfaW5mbyhtbSwgc3RhcnQsIGVuZCwgc3RyaWRlX3NoaWZ0LCBm
cmVlZF90YWJsZXMsDQo+PiAJCQkJICBuZXdfdGxiX2dlbik7DQo+PiANCj4+IC0JaWYgKG1tID09
IHRoaXNfY3B1X3JlYWQoY3B1X3RsYnN0YXRlLmxvYWRlZF9tbSkpIHsNCj4+IC0JCWxvY2tkZXBf
YXNzZXJ0X2lycXNfZW5hYmxlZCgpOw0KPj4gLQkJbG9jYWxfaXJxX2Rpc2FibGUoKTsNCj4+IC0J
CWZsdXNoX3RsYl9mdW5jX2xvY2FsKGluZm8sIFRMQl9MT0NBTF9NTV9TSE9PVERPV04pOw0KPj4g
LQkJbG9jYWxfaXJxX2VuYWJsZSgpOw0KPj4gLQl9DQo+PiAtDQo+PiAtCWlmIChjcHVtYXNrX2Fu
eV9idXQobW1fY3B1bWFzayhtbSksIGNwdSkgPCBucl9jcHVfaWRzKQ0KPj4gLQkJZmx1c2hfdGxi
X290aGVycyhtbV9jcHVtYXNrKG1tKSwgaW5mbyk7DQo+IA0KPiBTbyBpZiB3ZSB3YW50IHRvIGRv
dWJsZSBjaGVjayB0aGF0OyB3ZSdkIGFkZDoNCj4gDQo+IAlXQVJOX09OX09OQ0UoY3B1bWFza190
ZXN0X2NwdShzbXBfcHJvY2Vzc29yX2lkKCksIG1tX2NwdW1hc2sobW0pKSA9PQ0KPiAJCSAgICAg
KG1tID09IHRoaXNfY3B1X3JlYWQoY3B1X3RsYnN0YXRlLmxvYWRlZF9tbSkpKTsNCj4gDQo+IHJp
Z2h0Pw0KDQpZZXMsIGV4Y2VwdCB0aGUgY29uZGl0aW9uIHNob3VsZCBiZSBpbnZlcnRlZCAo4oCc
IT3igJwgaW5zdGVhZCBvZiDigJw9PeKAnCksIGFuZCBJDQp3b3VsZCBwcmVmZXIgdG8gdXNlIFZN
X1dBUk5fT05fT05DRSgpLg0KDQpVbmZvcnR1bmF0ZWx5LCB0aGlzIGNvbmRpdGlvbiBkb2VzIGZp
cmUgd2hlbiBjb3B5X2luaXRfbW0oKSBjYWxscyBkdXBfbW0oKS4NCkkgZG9u4oCZdCB0aGluayB0
aGVyZSBpcyBhIGNvcnJlY3RuZXNzIGlzc3VlLCBhbmQgSSBhbSB0ZW1wdGVkIGp1c3QgY2hlY2ss
DQpiZWZvcmUgd2FybmluZywgdGhhdCAobW0gIT0gaW5pdF9tbSkgLg0KDQpXaGF0IGRvIHlvdSBz
YXk/
