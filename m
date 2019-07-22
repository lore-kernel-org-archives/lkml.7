Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AC0C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B69820693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="1UWVr9IR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfGVTCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:02:40 -0400
Received: from mail-eopbgr700082.outbound.protection.outlook.com ([40.107.70.82]:48249
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbfGVTCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:02:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0K30EzwdROMY6JcSs6m3g3+2569amHc1yyu8VNBw1fzxQanCb0lgYDhxK6KdFGIWc2PNPi0eGrLM+Eprl92xMtgknzr+iE8Phnfujtc2UizG/sDF/v59YZ5nfG27mvllJ3uyBnTDTQfp1vyEhSkJbOlnEgl6wPEkN7/fF0n8H8lGzAaVL0vjwtyWkqVHQkIcqF7RrpUm4depwXpHn3U4YDFZ+F2KoOcqK2VOVjzq28n/3zTWfnkhVErR+2btNW/QRzrQg8X67+2OwE0jMwknjaWJQLiKYqTHc0RZtYR2/Va3WBV6ugwpHk/wF/3hcl07tlb/0LhvRyObl4pZwr5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpBgtTy6freDfrnsMnUx9Qc+wmtvifzLk5vC/r3muvU=;
 b=Ne3OGCoAd99Y5jMkW7iyK/t85oD5pL/6xiZOmLCurXqDBSRNUweiDQWUYAGMP9qLpSId4WrU8GYS2XgSqmvWBacX7Grw6/8HWyzGEXeshx4xdKdNfFk/OmQqSD+OA8phv4ScQUEHkrsYfcd4yHK9uUIfyNABhNOIMgfZ84DkX46qaT14gUsBQh9Bq/P6P6ylERZ+qXmsNkOjkAK7mqWifnPjvHIQY3lFLzR8NsP+0gcigtSnMz54k5YF6Q9Fw/h0RNf/DO4eGMPcbkzJ1BlZYFwGGYdnZO3IXXsTKnF09n0MCIrR76f420vI+qylbBHnHTIILSmqH6wc3SQwVQlsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpBgtTy6freDfrnsMnUx9Qc+wmtvifzLk5vC/r3muvU=;
 b=1UWVr9IRG4H5WnAjPDUIMygO02U/x6OsDzEwFfwcPWKpyuSQm+S/LzrF3gz4Lh9ASs1QTP2CQZ49TKWihwvdg5JGL2MkBDvd7ozFQKfs8TwBQD8/691CoAZsO5wKfOci9efBaHR0+ZF2DrYXyWnH5IUOMygFBC/26qRwONirAkg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6262.namprd05.prod.outlook.com (20.178.196.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Mon, 22 Jul 2019 19:02:36 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2115.005; Mon, 22 Jul 2019
 19:02:36 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/9] smp: Run functions concurrently in
 smp_call_function_many()
Thread-Topic: [PATCH v3 1/9] smp: Run functions concurrently in
 smp_call_function_many()
Thread-Index: AQHVPc0owCZu4w44l0OVUg4r6D6Gu6bW+RmAgAAESICAAADSgIAAA0eAgAAC9oA=
Date:   Mon, 22 Jul 2019 19:02:36 +0000
Message-ID: <93A98E8B-764F-4E9F-B0B6-FDAABE822B2D@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-2-namit@vmware.com>
 <20190722182159.GB6698@worktop.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907222033200.1659@nanos.tec.linutronix.de>
 <91940019-826C-4F33-904B-0767D95A5E21@vmware.com>
 <alpine.DEB.2.21.1907222045101.1659@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907222045101.1659@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b50acb2e-97c5-4790-d570-08d70ed7291b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR05MB6262;
x-ms-traffictypediagnostic: BYAPR05MB6262:
x-microsoft-antispam-prvs: <BYAPR05MB62620FC9BEC91F3F7494DEB3D0C40@BYAPR05MB6262.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(66556008)(66446008)(6246003)(64756008)(66476007)(76116006)(25786009)(6486002)(66946007)(5660300002)(229853002)(53546011)(76176011)(486006)(26005)(102836004)(6436002)(86362001)(81156014)(81166006)(4326008)(186003)(53936002)(6512007)(14444005)(8936002)(256004)(478600001)(33656002)(316002)(68736007)(8676002)(71200400001)(71190400001)(6116002)(3846002)(6916009)(36756003)(54906003)(2906002)(14454004)(66066001)(6506007)(2616005)(476003)(446003)(11346002)(7736002)(305945005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6262;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ULBFFOmMiXxjaNbpkgwON9ghkIhZdHc91qb9+fnhJ44PqCyJlmpmSCtae8DJn1TdoBzUNGk0snIITPqQAtJuadgEgXSB4VTIWizSDftr9FMZo0+SrUauV8TTEPBZFJdqUB8Ler7a06+ZpKhtn+V4BanLAhMyZFfbrgyKFw1WvUmyCRgaYpG7srDzQzpdUHUKJw1uNbTpNUXgyLlDTFCfeOkIVXzTDqaztyDKEzenclFezuywbkQqtBZ2yjc2I6WkYxL7ejC9AZ2SbR5LFivfnn/BpJgvmMnePGf0NJV9iQssmfjUq7SxtcNurZcqfuWslO8wIuKINbkTf26cJx1fuhPjTInnbw1OoelRIvjZ6OD+Pc2cJzDi4bzHbWCxFk9QBASxdnLvF3KzL0ozNTjUzEbB7kip6v7pkNYeXe0W1J0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6A49EF715AC244E897BD644EEB94EC3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50acb2e-97c5-4790-d570-08d70ed7291b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 19:02:36.5062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMjIsIDIwMTksIGF0IDExOjUxIEFNLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGlu
dXRyb25peC5kZT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIDIyIEp1bCAyMDE5LCBOYWRhdiBBbWl0
IHdyb3RlOg0KPj4+IE9uIEp1bCAyMiwgMjAxOSwgYXQgMTE6MzcgQU0sIFRob21hcyBHbGVpeG5l
ciA8dGdseEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4+PiANCj4+PiBPbiBNb24sIDIyIEp1bCAy
MDE5LCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+PiANCj4+Pj4gT24gVGh1LCBKdWwgMTgsIDIw
MTkgYXQgMDU6NTg6MjlQTSAtMDcwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+Pj4+ICsvKg0KPj4+
Pj4gKyAqIENhbGwgYSBmdW5jdGlvbiBvbiBhbGwgcHJvY2Vzc29ycy4gIE1heSBiZSB1c2VkIGR1
cmluZyBlYXJseSBib290IHdoaWxlDQo+Pj4+PiArICogZWFybHlfYm9vdF9pcnFzX2Rpc2FibGVk
IGlzIHNldC4NCj4+Pj4+ICsgKi8NCj4+Pj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgb25fZWFjaF9j
cHUoc21wX2NhbGxfZnVuY190IGZ1bmMsIHZvaWQgKmluZm8sIGludCB3YWl0KQ0KPj4+Pj4gK3sN
Cj4+Pj4+ICsJb25fZWFjaF9jcHVfbWFzayhjcHVfb25saW5lX21hc2ssIGZ1bmMsIGluZm8sIHdh
aXQpOw0KPj4+Pj4gK30NCj4+Pj4gDQo+Pj4+IEknbSB0aGlua2luZyB0aGF0IG9uZSBpZiBidWdn
eSwgbm90aGluZyBwcm90ZWN0cyBvbmxpbmUgbWFzayBoZXJlLg0KPj4+IA0KPj4+IFRoZSBjdXJy
ZW50IGltcGxlbWVudGF0aW9uIGhhcyBwcmVlbXB0aW9uIGRpc2FibGVkIGJlZm9yZSB0b3VjaGlu
Zw0KPj4+IGNwdV9vbmxpbmVfbWFzayB3aGljaCBhdCBsZWFzdCBwcm90ZWN0cyBhZ2FpbnN0IGEg
Q1BVIGdvaW5nIGF3YXkgYXMgdGhhdA0KPj4+IHByZXZlbnRzIHRoZSBzdG9tcCBtYWNoaW5lIHRo
cmVhZCBmcm9tIGdldHRpbmcgb24gdGhlIENQVS4gQnV0IGl0J3Mgbm90DQo+Pj4gcHJvdGVjdGVk
IGFnYWluc3QgYSBDUFUgY29taW5nIG9ubGluZSBjb25jdXJyZW50bHkuDQo+PiANCj4+IEkgc3Rp
bGwgZG9u4oCZdCB1bmRlcnN0YW5kLiBJZiB5b3UgY2FsbGVkIGNwdV9vbmxpbmVfbWFzaygpIGFu
ZCBkaWQgbm90DQo+PiBkaXNhYmxlIHByZWVtcHRpb24gYmVmb3JlIGNhbGxpbmcgaXQsIHlvdSBh
cmUgYWxyZWFkeSAodG9kYXkpIG5vdCBwcm90ZWN0ZWQNCj4+IGFnYWluc3QgYW5vdGhlciBDUFUg
Y29taW5nIG9ubGluZS4gRGlzYWJsaW5nIHByZWVtcHRpb24gaW4gb25fZWFjaF9jcHUoKQ0KPj4g
d2lsbCBub3Qgc29sdmUgaXQuDQo+IA0KPiBEaXNhYmxpbmcgcHJlZW1wdGlvbiBfY2Fubm90XyBw
cm90ZWN0IGFnYWluc3QgYSBDUFUgY29taW5nIG9ubGluZS4gSXQgb25seQ0KPiBjYW4gcHJvdGVj
dCBhZ2FpbnN0IGEgQ1BVIGJlaW5nIG9mZmxpbmVkLg0KPiANCj4gVGhlIGN1cnJlbnQgaW1wbGVt
ZW50YXRpb24gb2Ygb25fZWFjaF9jcHUoKSBkaXNhYmxlcyBwcmVlbXB0aW9uIF9iZWZvcmVfDQo+
IHRvdWNoaW5nIGNwdV9vbmxpbmVfbWFzay4NCj4gDQo+IHZvaWQgb25fZWFjaF9jcHUodm9pZCAo
KmZ1bmMpICh2b2lkICppbmZvKSwgdm9pZCAqaW5mbywgaW50IHdhaXQpDQo+IHsNCj4gICAgICAg
IHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+IA0KPiAgICAgICAgcHJlZW1wdF9kaXNhYmxlKCk7DQo+
IAlzbXBfY2FsbF9mdW5jdGlvbihmdW5jLCBpbmZvLCB3YWl0KTsNCj4gDQo+IHNtcF9jYWxsX2Z1
bmN0aW9uKCkgaGFzIGFub3RoZXIgcHJlZW1wdF9kaXNhYmxlIGFzIGl0IGNhbiBiZSBjYWxsZWQN
Cj4gc2VwYXJhdGVseSBhbmQgaXQgZG9lczoNCj4gDQo+ICAgICAgICBwcmVlbXB0X2Rpc2FibGUo
KTsNCj4gICAgICAgIHNtcF9jYWxsX2Z1bmN0aW9uX21hbnkoY3B1X29ubGluZV9tYXNrLCBmdW5j
LCBpbmZvLCB3YWl0KTsNCj4gDQo+IFlvdXIgbmV3IG9uX2VhY2hfY3B1KCkgaW1wbGVtZW50YXRp
b24gZG9lcyBub3QuIFNvIHRoZXJlIGlzIGENCj4gZGlmZmVyZW5jZS4gV2hldGhlciBpdCBtYXR0
ZXJzIG9yIG5vdCBpcyBhIGRpZmZlcmVudCBxdWVzdGlvbiwgYnV0IHRoYXQNCj4gbmVlZHMgdG8g
YmUgZXhwbGFpbmVkIGFuZCBkb2N1bWVudGVkLg0KDQpUaGFua3MgZm9yIGV4cGxhaW5pbmcgLSBz
byB5b3VyIGNvbmNlcm4gaXMgZm9yIENQVXMgYmVpbmcgb2ZmbGluZWQuDQoNCkJ1dCB1bmxlc3Mg
SSBhbSBtaXNzaW5nIHNvbWV0aGluZzogb25fZWFjaF9jcHUoKSBjYWxscyBfX29uX2VhY2hfY3B1
X21hc2soKSwNCndoaWNoIGRpc2FibGVzIHByZWVtcHRpb24gYW5kIGNhbGxzIF9fc21wX2NhbGxf
ZnVuY3Rpb25fbWFueSgpLg0KDQpUaGVuICBfX3NtcF9jYWxsX2Z1bmN0aW9uX21hbnkoKSBydW5z
Og0KDQoJY3B1bWFza19hbmQoY2ZkLT5jcHVtYXNrLCBtYXNrLCBjcHVfb25saW5lX21hc2spOw0K
DQrigKYgYmVmb3JlIGNob29zaW5nIHdoaWNoIHJlbW90ZSBDUFVzIHNob3VsZCBydW4gdGhlIGZ1
bmN0aW9uLiBTbyB0aGUgb25seQ0KY2FzZSB0aGF0IEkgd2FzIG1pc3NpbmcgaXMgaWYgdGhlIGN1
cnJlbnQgQ1BVIGdvZXMgYXdheSBhbmQgdGhlIGZ1bmN0aW9uIGlzDQpjYWxsZWQgbG9jYWxseS4N
Cg0KQ2FuIGl0IGhhcHBlbj8gSSBjYW4gYWRkIGRvY3VtZW50YXRpb24gYW5kIGEgZGVidWcgYXNz
ZXJ0aW9uIGZvciB0aGlzIGNhc2UuDQoNCg==
