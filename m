Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E103C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DAE214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="K9a3arv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfGYTLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:11:01 -0400
Received: from mail-eopbgr790041.outbound.protection.outlook.com ([40.107.79.41]:61851
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfGYTLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:11:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWThg9FbEVmNw+AJP+xnngH8uEpNx1f87m7J0MEfPUg4T5cBRa/LwFQ9wTPIoLtajCWKoz6hnOQF9OjI/rg2wV1wqoHbUefDbwQQhbGFPa2gSHor3oQpHoDg75/FnUF2juSC6yWynAguagOacaJYSQsWxXDXPbTvArFmXuFZbIRj/+h1Y6l3++zghImrVKsYkaH9CG0AjIUVZfgy4qC453hXG5jV8fc2BuPulEmTsSV/Otffm7PSJdnCgxsgvYCYVBG3rV2AHGyk9hKMBfinV48UiRnyZlgtA+3+jifstCdJdmtYjF9QANfIY602hDGAStGcgcyzB2SEN2INE44rgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUkiHRJRmS4Tk3fSFA6Z6zq0syAE2HV86AWoiE4UfiM=;
 b=CXsTgbhIqGpGTIohN58wqfnCxYY1K1p0j76JHIF9FaMOiQabOonAja8K+i3A4MyH9bR6HkXQYTXyiOt0X48gTodAD/BVb5cDs7JeXZ8EMHgVvVBvygSrkpHtZHPgP9VDS24EiyW8nrH6m5he8NrsmDQx9zo2X3qo2g2T1q88tLRFihF9RY6GSg+g4/5cbMm5Dle4XGTAFGBHGKPqL/irrwJOB3gHPAUzF4zEZQtyTkvJHl9L47EwaQcTWeCZ96QxTO48aUbF2DeUFpRz5cwYUOP1uI3l5zwRQIrsvicFFj89VkqPbuzaaXk1lAwWLmYY3gsttRXa+qCAEEholFdUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUkiHRJRmS4Tk3fSFA6Z6zq0syAE2HV86AWoiE4UfiM=;
 b=K9a3arv4CsQjQeVqPD0KPfB7b1u70fXeseIjLRKVrojs5u3PFYjzU4UVeQNi5lq3Qv96mDyB1GnUakXNN0PKHvLrhiTfOJaMmHUSuszvnCbWJrP7Xw6Brydwpzqn/EK6lao/uaKO1DKBZvqlB9bS9JWDoGs1L89S8keAhXEa4w0=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5717.namprd05.prod.outlook.com (20.177.187.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.4; Thu, 25 Jul 2019 19:10:58 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 19:10:58 +0000
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
Thread-Index: AQHVPc0owCZu4w44l0OVUg4r6D6Gu6bW+RmAgAAESICAAADSgIAAA0eAgAAC9oCABEsOgIAAbkeA
Date:   Thu, 25 Jul 2019 19:10:57 +0000
Message-ID: <ABD10CF3-0FD9-47E8-BC80-9A3733DADC52@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-2-namit@vmware.com>
 <20190722182159.GB6698@worktop.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907222033200.1659@nanos.tec.linutronix.de>
 <91940019-826C-4F33-904B-0767D95A5E21@vmware.com>
 <alpine.DEB.2.21.1907222045101.1659@nanos.tec.linutronix.de>
 <93A98E8B-764F-4E9F-B0B6-FDAABE822B2D@vmware.com>
 <alpine.DEB.2.21.1907251404060.1791@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907251404060.1791@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1c9f4ad-daf7-4e13-502a-08d71133d32b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5717;
x-ms-traffictypediagnostic: BYAPR05MB5717:
x-microsoft-antispam-prvs: <BYAPR05MB57176806335BF5076D1E0B2CD0C10@BYAPR05MB5717.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(33656002)(66946007)(6512007)(14454004)(5660300002)(6486002)(7736002)(25786009)(446003)(6116002)(3846002)(316002)(66446008)(76116006)(71190400001)(71200400001)(54906003)(11346002)(476003)(8936002)(81166006)(186003)(305945005)(66476007)(36756003)(66066001)(6246003)(6436002)(8676002)(4326008)(26005)(6916009)(86362001)(53936002)(2616005)(486006)(102836004)(6506007)(256004)(99286004)(2906002)(64756008)(81156014)(66556008)(53546011)(76176011)(229853002)(478600001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5717;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OfPwXsW6fcjymajOpitQDiiMqZgmvkDcdjjqhr3AEBbirK9SapnNWa3pyU95h4olVfstS4Qj64iZDf1lYEPs1fO2KogUZJQkOb7QJADSz4e/Y7hytDY0x9Vo7ADIlJZJyWqoJII5HlnpDepyjBaNE4K9SLEvJg+z/M76Mg+1+Wn4YJAf37UwEctiQ8hd0JBLjEN9soLoqxfNm5CgRiuH0dEI5zBF+O5Si79cVCJUjYSFEQJZwS0///FI/hX3vHxNyr5f7AvxgDJisfNfWGj8708Gc7d1zzHpKiQuY3h7q5xELnIgjSashVS6RKve3VzV49gkl1YcP6YAHyBFjEXq6opMX1588lMWpj4s4zopA1SOS8pg7tUSJbgod0YW35MPKURkk0LfxfFWdIx5bGIKVDWLrhFF45pyC2Hx66LjW+Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAC5EEA1477F7447A1A291EF96DF554B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c9f4ad-daf7-4e13-502a-08d71133d32b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 19:10:57.8201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5717
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMjUsIDIwMTksIGF0IDU6MzYgQU0sIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51
dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgMjIgSnVsIDIwMTksIE5hZGF2IEFtaXQg
d3JvdGU6DQo+Pj4gT24gSnVsIDIyLCAyMDE5LCBhdCAxMTo1MSBBTSwgVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPj4+IHZvaWQgb25fZWFjaF9jcHUodm9pZCAo
KmZ1bmMpICh2b2lkICppbmZvKSwgdm9pZCAqaW5mbywgaW50IHdhaXQpDQo+Pj4gew0KPj4+ICAg
ICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+Pj4gDQo+Pj4gICAgICAgcHJlZW1wdF9kaXNhYmxl
KCk7DQo+Pj4gCXNtcF9jYWxsX2Z1bmN0aW9uKGZ1bmMsIGluZm8sIHdhaXQpOw0KPj4+IA0KPj4+
IHNtcF9jYWxsX2Z1bmN0aW9uKCkgaGFzIGFub3RoZXIgcHJlZW1wdF9kaXNhYmxlIGFzIGl0IGNh
biBiZSBjYWxsZWQNCj4+PiBzZXBhcmF0ZWx5IGFuZCBpdCBkb2VzOg0KPj4+IA0KPj4+ICAgICAg
IHByZWVtcHRfZGlzYWJsZSgpOw0KPj4+ICAgICAgIHNtcF9jYWxsX2Z1bmN0aW9uX21hbnkoY3B1
X29ubGluZV9tYXNrLCBmdW5jLCBpbmZvLCB3YWl0KTsNCj4+PiANCj4+PiBZb3VyIG5ldyBvbl9l
YWNoX2NwdSgpIGltcGxlbWVudGF0aW9uIGRvZXMgbm90LiBTbyB0aGVyZSBpcyBhDQo+Pj4gZGlm
ZmVyZW5jZS4gV2hldGhlciBpdCBtYXR0ZXJzIG9yIG5vdCBpcyBhIGRpZmZlcmVudCBxdWVzdGlv
biwgYnV0IHRoYXQNCj4+PiBuZWVkcyB0byBiZSBleHBsYWluZWQgYW5kIGRvY3VtZW50ZWQuDQo+
PiANCj4+IFRoYW5rcyBmb3IgZXhwbGFpbmluZyAtIHNvIHlvdXIgY29uY2VybiBpcyBmb3IgQ1BV
cyBiZWluZyBvZmZsaW5lZC4NCj4+IA0KPj4gQnV0IHVubGVzcyBJIGFtIG1pc3Npbmcgc29tZXRo
aW5nOiBvbl9lYWNoX2NwdSgpIGNhbGxzIF9fb25fZWFjaF9jcHVfbWFzaygpLA0KPj4gd2hpY2gg
ZGlzYWJsZXMgcHJlZW1wdGlvbiBhbmQgY2FsbHMgX19zbXBfY2FsbF9mdW5jdGlvbl9tYW55KCku
DQo+PiANCj4+IFRoZW4gIF9fc21wX2NhbGxfZnVuY3Rpb25fbWFueSgpIHJ1bnM6DQo+PiANCj4+
IAljcHVtYXNrX2FuZChjZmQtPmNwdW1hc2ssIG1hc2ssIGNwdV9vbmxpbmVfbWFzayk7DQo+PiAN
Cj4+IOKApiBiZWZvcmUgY2hvb3Npbmcgd2hpY2ggcmVtb3RlIENQVXMgc2hvdWxkIHJ1biB0aGUg
ZnVuY3Rpb24uIFNvIHRoZSBvbmx5DQo+PiBjYXNlIHRoYXQgSSB3YXMgbWlzc2luZyBpcyBpZiB0
aGUgY3VycmVudCBDUFUgZ29lcyBhd2F5IGFuZCB0aGUgZnVuY3Rpb24gaXMNCj4+IGNhbGxlZCBs
b2NhbGx5Lg0KPj4gDQo+PiBDYW4gaXQgaGFwcGVuPyBJIGNhbiBhZGQgZG9jdW1lbnRhdGlvbiBh
bmQgYSBkZWJ1ZyBhc3NlcnRpb24gZm9yIHRoaXMgY2FzZS4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsg
aXQgY2FuIGhhcHBlbjoNCj4gDQo+ICBvbl9lYWNoX2NwdSgpDQo+ICAgIG9uX2VhY2hfY3B1X21h
c2soLi4uLikNCj4gICAgICBwcmVlbXB0X2Rpc2FibGUoKQ0KPiAgICAgICAgX19zbXBfY2FsbF9m
dW5jdGlvbl9tYW55KCkNCj4gDQo+IFNvIGlmIGEgQ1BVIGdvZXMgb2ZmbGluZSBiZXR3ZWVuIG9u
X2VhY2hfY3B1KCkgYW5kIHByZWVtcHRfZGlzYWJsZSgpIHRoZW4NCj4gdGhlcmUgaXMgbm8gZGFt
YWdlLiBBZnRlciB0aGUgcHJlZW1wdF9kaXNhYmxlKCkgaXQgY2FuJ3QgZ28gYXdheSBhbnltb3Jl
DQo+IGFuZCB0aGUgdGFzayBleGVjdXRpbmcgdGhpcyBjYW5ub3QgYmUgbWlncmF0ZWQgZWl0aGVy
Lg0KPiANCj4gU28geWVzLCBpdCdzIHNhZmUsIGJ1dCBwbGVhc2UgYWRkIGEgYmlnIGZhdCBjb21t
ZW50IHNvIGZ1dHVyZSByZWFkZXJzIHdvbid0DQo+IGJlIHB1enpsZWQuDQoNCkkgd2lsbCBkby4g
SSB3aWxsIG5lZWQgc29tZSBtb3JlIHRpbWUgdG8gcmVzcGluIHRoZSBuZXh0IHZlcnNpb24uIEkg
c2VlIHRoYXQNCndoYXQgSSBidWlsZCBvbiB0b3Agb2YgaXQgbWlnaHQgcmVxdWlyZSBzb21lIGNo
YW5nZXMsIGFuZCBJIHdhbnQgdG8gbWluaW1pemUNCnRoZW0uDQoNCg==
