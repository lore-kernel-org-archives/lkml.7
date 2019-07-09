Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFD0C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C297020844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Tch8c7cq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfGIVJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 17:09:18 -0400
Received: from mail-eopbgr700078.outbound.protection.outlook.com ([40.107.70.78]:22880
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726318AbfGIVJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:09:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNJgZZVfXfFl/CKVb1MGI4wi9tGt8bmnSKcgBqNqkjXW4CoJi+tb44kRnjqZ8o/lJaeiKG11QuJLOtoR0Mi+Gq1KSL5tMt36N4rBUimalo4pY7ceAfOFuX0htiwM0JmbtyyK1gTZ1Q9I14E021v/ycY+DMSTDn31k8JL4DJuB9oj5yuMgYcVbxfH1EmNSImUF/K2jMmxZ/1kLzevbLfYFLxBLFGF6VQQ5CguuIZbYEXTvvFWpCMLsiAxyK9dhb6c5TiLdZuk7lEGTmS3dJJfe+qcejhCDyXGaAG9tgxK8LGAzzHt5AEOuflp53mJ+D+kdATNHQiPuflTia4IWTF6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nWQgrb6P3c01GcdgOokhynhMubBwyBD+0ysm0SYgL4=;
 b=FjSZtZZ6XqR7+J4mOaswZhxeugzp2q6JcKbRGTJ6R7pazDo+XS6N3dzoj++cwzO7TQmOkXYsI7inqmpisPYl2t0fekLdXiyLfy1DiE5kfPOwH+k0YVCHl9W5mN6bhmnlfBtVHC+cGS/6fagBWclro/jtPUgKZieWBZtlBAP/cUDKsUHfYg4UV1qeXjegoiKUXuXqsxJwn3T9KXJtLqRLiHCYElBntelTRntn894eLViCYL1I+ed3RfO6eYd+ZQk1m0dXrpvl2geMYC0S9Px62H0Lh0yKpx140JlIX3D3DfkiOmWym1/42Nxcja1YRcyh+rOaJvkPZzvkC9jXsqyQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nWQgrb6P3c01GcdgOokhynhMubBwyBD+0ysm0SYgL4=;
 b=Tch8c7cqHOAJYpo5uMVHPF1QnUsP953QlSjs+mdkypWDSoTYFJy2jAgx1MYbNjre5G1K/qHZ22v0AxcCPjW9sHhU7Fypt5r8fq7zmFwd4QnBFQUC9PJs5b2/I46tUFjIoYKqWW9+36hXcMX+5eYHXbnmUObRRtgMr+LiXojJxAg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4903.namprd05.prod.outlook.com (52.135.235.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.8; Tue, 9 Jul 2019 21:09:13 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2073.008; Tue, 9 Jul 2019
 21:09:13 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Mike Travis <mike.travis@hpe.com>
CC:     Russ Anderson <rja@hpe.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>
Subject: Re: [PATCH v2 8/9] x86/mm/tlb: Remove UV special case
Thread-Topic: [PATCH v2 8/9] x86/mm/tlb: Remove UV special case
Thread-Index: AQHVMW7tVxgDsYZZ7Ee0f7SvqciMDKbCvD6AgAAFPwCAAAWSAIAACzAA
Date:   Tue, 9 Jul 2019 21:09:13 +0000
Message-ID: <3AA5020A-111F-48F4-A0E9-B3C09E5EC43E@vmware.com>
References: <20190702235151.4377-1-namit@vmware.com>
 <20190702235151.4377-9-namit@vmware.com>
 <alpine.DEB.2.21.1907092146570.1758@nanos.tec.linutronix.de>
 <20190709200914.fjvi3cy3qfc6fmis@hpe.com>
 <373adfb0-0047-eae2-46a5-041caddfca97@hpe.com>
In-Reply-To: <373adfb0-0047-eae2-46a5-041caddfca97@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [38.119.166.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba61a693-e7b3-468d-4c20-08d704b1b1d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4903;
x-ms-traffictypediagnostic: BYAPR05MB4903:
x-microsoft-antispam-prvs: <BYAPR05MB49034D0C82FEF01C930D90F0D0F10@BYAPR05MB4903.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(199004)(189003)(256004)(26005)(6116002)(229853002)(3846002)(86362001)(11346002)(7736002)(54906003)(6246003)(446003)(2616005)(476003)(486006)(14454004)(5660300002)(8936002)(6486002)(186003)(99286004)(6916009)(316002)(296002)(76116006)(305945005)(76176011)(2906002)(71200400001)(8676002)(66066001)(25786009)(478600001)(53546011)(36756003)(33656002)(6512007)(53936002)(66476007)(102836004)(4326008)(66556008)(68736007)(66946007)(6436002)(7416002)(66446008)(64756008)(71190400001)(81156014)(6506007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4903;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +EV+1o0Yl7rjRC6Ta9cvESXkKX7LlJDgWDADWTb0l9bHDiai+m8Vs4/HlXk/Hqy7CnGrSvzfStSysjpYmoct/zInnfGFAbDCFic3V/frV/Ay+8dT+B4Fcfqt1TFBHoP6VxZvdVlB0Ioro3BmLscRh5s7mEkDWueXXO4K8nixvEHbhX5njZYS+s5vX7OXcL4YXdZatOaR3gI9WBALm6e9Nh6cZETXWTpUkpiSBxqLjzWGwehNjk/Q9QM9C7RnVD89cwWm4AfVU9c+w0l0m0cQWf/RN2fDAWqmtFpp/ituaGJExuS9jP5KCc06nxKL7yaCwDMtmuatJVA+lO+lhLeIpFoi3O7EtkWY2oXU12wubhFQxJH88GI/9UcKOpue+YvyxUX/8B6Ipa0PqtC6AE2UQAB74FoEjT68EMyM5pe81so=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7C8FC00949CFE41BCCA74E6E8D814EC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba61a693-e7b3-468d-4c20-08d704b1b1d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 21:09:13.3844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgOSwgMjAxOSwgYXQgMToyOSBQTSwgTWlrZSBUcmF2aXMgPG1pa2UudHJhdmlzQGhw
ZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiBPbiA3LzkvMjAxOSAxOjA5IFBNLCBSdXNzIEFu
ZGVyc29uIHdyb3RlOg0KPj4gT24gVHVlLCBKdWwgMDksIDIwMTkgYXQgMDk6NTA6MjdQTSArMDIw
MCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4+IE9uIFR1ZSwgMiBKdWwgMjAxOSwgTmFkYXYg
QW1pdCB3cm90ZToNCj4+PiANCj4+Pj4gU0dJIFVWIHN1cHBvcnQgaXMgb3V0ZGF0ZWQgYW5kIG5v
dCBtYWludGFpbmVkLCBhbmQgaXQgaXMgbm90IGNsZWFyIGhvdw0KPj4+PiBpdCBwZXJmb3JtcyBy
ZWxhdGl2ZWx5IHRvIG5vbi1VVi4gUmVtb3ZlIHRoZSBjb2RlIHRvIHNpbXBsaWZ5IHRoZSBjb2Rl
Lg0KPj4+IA0KPj4+IFlvdSBzaG91bGQgYXQgbGVhc3QgQ2MgdGhlIFNHSS9IUCBmb2xrcyBvbiB0
aGF0LiBUaGV5IGFyZSBzdGlsbA0KPj4+IGFyb3VuZC4gRG9uZSBzby4NCj4+IFRoYW5rcyBUaG9t
YXMuICBUaGUgU0dJIFVWIGlzIG5vdyBIUEUgU3VwZXJkb21lIEZsZXggYW5kIGlzDQo+PiB2ZXJ5
IG11Y2ggc3RpbGwgc3VwcG9ydGVkLg0KPj4gVGhhbmtzLg0KPj4+PiBDYzogUGV0ZXIgWmlqbHN0
cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPj4+PiBDYzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFu
c2VuQGludGVsLmNvbT4NCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBBbmR5IEx1dG9taXJza2kgPGx1dG9A
a2VybmVsLm9yZz4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJl
LmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICBhcmNoL3g4Ni9tbS90bGIuYyB8IDI1IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBkZWxldGlvbnMoLSkNCj4+
Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS90bGIuYyBiL2FyY2gveDg2L21tL3Rs
Yi5jDQo+Pj4+IGluZGV4IGI0N2E3MTgyMGYzNS4uNjRhZmUxMjE1NDk1IDEwMDY0NA0KPj4+PiAt
LS0gYS9hcmNoL3g4Ni9tbS90bGIuYw0KPj4+PiArKysgYi9hcmNoL3g4Ni9tbS90bGIuYw0KPj4+
PiBAQCAtNjg5LDMxICs2ODksNiBAQCB2b2lkIG5hdGl2ZV9mbHVzaF90bGJfbXVsdGkoY29uc3Qg
c3RydWN0IGNwdW1hc2sgKmNwdW1hc2ssDQo+Pj4+ICAJCXRyYWNlX3RsYl9mbHVzaChUTEJfUkVN
T1RFX1NFTkRfSVBJLA0KPj4+PiAgCQkJCShpbmZvLT5lbmQgLSBpbmZvLT5zdGFydCkgPj4gUEFH
RV9TSElGVCk7DQo+Pj4+ICAtCWlmIChpc191dl9zeXN0ZW0oKSkgew0KPj4+PiAtCQkvKg0KPj4+
PiAtCQkgKiBUaGlzIHdob2xlIHNwZWNpYWwgY2FzZSBpcyBjb25mdXNlZC4gIFVWIGhhcyBhICJC
cm9hZGNhc3QNCj4+Pj4gLQkJICogQXNzaXN0IFVuaXQiLCB3aGljaCBzZWVtcyB0byBiZSBhIGZh
bmN5IHdheSB0byBzZW5kIElQSXMuDQo+Pj4+IC0JCSAqIEJhY2sgd2hlbiB4ODYgdXNlZCBhbiBl
eHBsaWNpdCBUTEIgZmx1c2ggSVBJLCBVViB3YXMNCj4+Pj4gLQkJICogb3B0aW1pemVkIHRvIHVz
ZSBpdHMgb3duIG1lY2hhbmlzbS4gIFRoZXNlIGRheXMsIHg4NiB1c2VzDQo+Pj4+IC0JCSAqIHNt
cF9jYWxsX2Z1bmN0aW9uX21hbnkoKSwgYnV0IFVWIHN0aWxsIHVzZXMgYSBtYW51YWwgSVBJLA0K
Pj4+PiAtCQkgKiBhbmQgdGhhdCBJUEkncyBhY3Rpb24gaXMgb3V0IG9mIGRhdGUgLS0gaXQgZG9l
cyBhIG1hbnVhbA0KPj4+PiAtCQkgKiBmbHVzaCBpbnN0ZWFkIG9mIGNhbGxpbmcgZmx1c2hfdGxi
X2Z1bmNfcmVtb3RlKCkuICBUaGlzDQo+Pj4+IC0JCSAqIG1lYW5zIHRoYXQgdGhlIHBlcmNwdSB0
bGJfZ2VuIHZhcmlhYmxlcyB3b24ndCBiZSB1cGRhdGVkDQo+Pj4+IC0JCSAqIGFuZCB3ZSdsbCBk
byBwb2ludGxlc3MgZmx1c2hlcyBvbiBmdXR1cmUgY29udGV4dCBzd2l0Y2hlcy4NCj4+Pj4gLQkJ
ICoNCj4+Pj4gLQkJICogUmF0aGVyIHRoYW4gaG9va2luZyBuYXRpdmVfZmx1c2hfdGxiX211bHRp
KCkgaGVyZSwgSSB0aGluaw0KPj4+PiAtCQkgKiB0aGF0IFVWIHNob3VsZCBiZSB1cGRhdGVkIHNv
IHRoYXQgc21wX2NhbGxfZnVuY3Rpb25fbWFueSgpLA0KPj4+PiAtCQkgKiBldGMsIGFyZSBvcHRp
bWFsIG9uIFVWLg0KPj4+PiAtCQkgKi8NCj4gDQo+IEkgdGhvdWdodCB0aGlzIGNoYW5nZSB3YXMg
YWxyZWFkeSBwcm9wb3NlZCBhIGJpdCBhZ28gYW5kIHdlIGFja2VkIGl0DQo+IGF3aGlsZSBiYWNr
LiBBbHNvIHRoZSByZXBsYWNlbWVudCBmdW5jdGlvbmFsaXR5IGlzIGJlaW5nIHdvcmtlZCBvbiBi
dXQgaXQNCj4gaXMgbW9yZSBjb21wbGV4LiBUaGUgc21wIGNhbGwgbWFueSBoYXMgdG8gc3VwcG9y
dCBhbGwgdGhlIHJlYXNvbnMgd2h5IGl04oCZcw0KPiBjYWxsZWQgYW5kIG5vdCBqdXN0IHRoZSB0
bGIgc2hvb3QgZG93bnMgYXMgaXMgdGhlIGN1cnJlbnQgQkFVIGNhc2UuDQoNClNvcnJ5IGZvciBu
b3QgY2PigJlpbmcgeW91IGJlZm9yZS4gSW4gdGhlIG1lYW53aGlsZSwgY2FuIHlvdSBnaXZlIGFu
IGV4cGxpY2l0DQphY2tlZC1ieT8gKEkgY291bGRu4oCZdCBmaW5kIHRoZSBwcmV2aW91cyBwYXRj
aCB5b3UgcmVnYXJkZWQuKQ0KDQpUaGFua3MsDQpOYWRhdg==
