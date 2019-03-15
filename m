Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A75D21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RhAc0MJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfCOPux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:50:53 -0400
Received: from mail-eopbgr810055.outbound.protection.outlook.com ([40.107.81.55]:18419
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbfCOPux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kOZ9zjymdiQ6OzSKNCr44jeY6C+Kn2aCf9rN7QiWps=;
 b=RhAc0MJgKfSQ0WemYYVbECtve4/FcIHl7ubCkm0xG6yEmk721WwH+olLYJWxmBNrNMuyPjfrMw3s3zGxmBnj5/Ht7ATCKYtl3zDNuB3SVZ5QX2Mu/wxeLXyEjrkPWbM1FKUr5H66kn7NV0XORFEvYl6LGPFL33R/+P7DX0UAEFg=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3290.namprd12.prod.outlook.com (20.179.106.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 15:50:00 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 15:50:00 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC PATCH 2/2] x86/perf/amd: Resolve NMI latency issues when
 multiple PMCs are active
Thread-Topic: [RFC PATCH 2/2] x86/perf/amd: Resolve NMI latency issues when
 multiple PMCs are active
Thread-Index: AQHU2CpOuC8N+vFHqESTwWx3yJMr4aYMncqAgAAtDoCAAAd0gIAACteA
Date:   Fri, 15 Mar 2019 15:50:00 +0000
Message-ID: <40b3c397-0d21-b8e2-c80f-14e3fe850cb2@amd.com>
References: <155232291547.21417.2499429555505085131.stgit@tlendack-t1.amdoffice.net>
 <155232292961.21417.3665243457569518550.stgit@tlendack-t1.amdoffice.net>
 <20190315120311.GX5996@hirez.programming.kicks-ass.net>
 <ef7fb4f8-29a8-16e6-5a8c-18da2eaf4243@amd.com>
 <20190315151107.GG6058@hirez.programming.kicks-ass.net>
In-Reply-To: <20190315151107.GG6058@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:805:16::22) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79ad5b41-3a4c-4daa-3207-08d6a95de1c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3290;
x-ms-traffictypediagnostic: DM6PR12MB3290:
x-microsoft-antispam-prvs: <DM6PR12MB3290CFA5468B845B2717EDF8EC440@DM6PR12MB3290.namprd12.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(54094003)(52314003)(199004)(189003)(6506007)(105586002)(186003)(102836004)(54906003)(386003)(36756003)(76176011)(8676002)(81166006)(2906002)(6916009)(93886005)(3846002)(6116002)(53546011)(81156014)(31686004)(106356001)(97736004)(52116002)(316002)(26005)(6512007)(229853002)(6486002)(6436002)(53936002)(6246003)(99286004)(68736007)(4326008)(14444005)(256004)(71200400001)(71190400001)(72206003)(7736002)(476003)(8936002)(5660300002)(7416002)(11346002)(14454004)(25786009)(2616005)(305945005)(66066001)(86362001)(31696002)(486006)(446003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3290;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2ZfJMeZos7RjuDPNju5BlEjXeeXfxRPXiAQzT4C9zDcIJIgWMSEWmRf3Ma3ScCPsOCQ3ONfto3pYlIlZIudJwJPzf1BddcOvRkngSIMINlXLhNn/3PQsNSGjzuQwVh8bj1Nhh96Dah3cyS4fbqstth/VZHgMaoYosR0g0eftMMaaY4VKNROmYB7yVXxxWqfKrpxk4v24tSFlgG3H7K4YUealTs2k6QrMdM88/I4RSJAEOthQhIjs6gobBwFruWK4v88LLRGsKkiU/2rUgBjwmoGA8Xm4kWEszo8ZkyW/KbsZ0MMRuJ6pmEmeGto5zODeMjezIhP89INXR9HrLIO4w3eoYdn6KtRMGKXiCaWOOlSYlpnN+aL+btldNMt1jih5dVi1TaR/Y7wGjtIK4ow3Yvqlkuk2YN5nyJulEVTN95U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <513F48CAA384A149A1FEA9CD5971FCD9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ad5b41-3a4c-4daa-3207-08d6a95de1c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 15:50:00.7900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNS8xOSAxMDoxMSBBTSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIEZyaSwgTWFy
IDE1LCAyMDE5IGF0IDAyOjQ0OjMyUE0gKzAwMDAsIExlbmRhY2t5LCBUaG9tYXMgd3JvdGU6DQo+
IA0KPj4+PiBAQCAtNjg5LDYgKzczMSw3IEBAIHN0YXRpYyBfX2luaXRjb25zdCBjb25zdCBzdHJ1
Y3QgeDg2X3BtdSBhbWRfcG11ID0gew0KPj4+PiAgICANCj4+Pj4gICAgCS5hbWRfbmJfY29uc3Ry
YWludHMJPSAxLA0KPj4+PiAgICAJLndhaXRfb25fb3ZlcmZsb3cJPSBhbWRfcG11X3dhaXRfb25f
b3ZlcmZsb3csDQo+Pj4+ICsJLm1pdGlnYXRlX25taV9sYXRlbmN5CT0gYW1kX3BtdV9taXRpZ2F0
ZV9ubWlfbGF0ZW5jeSwNCj4+Pj4gICAgfTsNCj4+Pg0KPj4+IEFnYWluLCB5b3UgY291bGQganVz
dCBkbyBhbWRfcG11X2hhbmRsZV9pcnEoKSBhbmQgYXZvaWQgYW4gZXh0cmENCj4+PiBjYWxsYmFj
ay4NCj4+DQo+PiBUaGlzIGlzIHdoZXJlIHRoZXJlIHdvdWxkIGJlIGEgYnVuY2ggb2YgY29kZSBk
dXBsaWNhdGlvbiB3aGVyZSBJIHRob3VnaHQNCj4+IGFkZGluZyB0aGUgY2FsbGJhY2sgYXQgdGhl
IGVuZCB3b3VsZCBiZSBiZXR0ZXIuIEJ1dCBpZiBpdCdzIGJlc3QgdG8gYWRkDQo+PiBhbiBBTUQg
aGFuZGxlX2lycSBjYWxsYmFjayBJIGNhbiBkbyB0aGF0LiBJJ20gZWFzeSwgbGV0IG1lIGtub3cg
aWYgeW91J2QNCj4+IHByZWZlciB0aGF0Lg0KPiANCj4gSG1tLCB0aGUgdGhpbmcgdGhhdCBhdm9p
ZHMgeW91IGRpcmVjdGx5IHVzaW5nIHg4Nl9wbXVfaGFuZGxlX2lycSgpIGlzDQo+IHRoYXQgYWRk
ZWQgYWN0aXZlIGNvdW50LCBidXQgaXMgdGhhdCBub3QgdGhlIHNhbWUgYXMgdGhlIFBPUENOVCBv
Zg0KPiBjcHVjLT5hY3RpdmVfbWFzaz8NCj4gDQo+IElzIHRoZSBsYXRlbmN5IG9mIFBPUENOVCBz
byBiYWQgdGhhdCB3ZSBuZWVkIGF2b2lkIGl0Pw0KPiANCj4gVGhhdCBpcywgSSB3YXMgdGhpbmtp
bmcgb2Ygc29tZXRoaW5nIGxpa2U6DQo+IA0KPiBpbnQgYW1kX3BtdV9oYW5kbGVfaXJxKHN0cnVj
dCBwdF9yZWdzICpyZWdzKQ0KPiB7DQo+IAlzdHJ1Y3QgY3B1X2h3X2V2ZW50cyAqY3B1YyA9IHRo
aXNfY3B1X3B0cigmY3B1X2h3X2V2ZW50cyk7DQo+IAlpbnQgYWN0aXZlID0gaHdlaWdodF9sb25n
KGNwdWMtPmFjdGl2ZV9tYXNrKTsNCj4gCWludCBoYW5kbGVkID0geDg2X3BtdV9oYW5kbGVfaXJx
KHJlZ3MpOw0KDQpZdXAsIEkgaGFkIGEgdG90YWwgYnJhaW4gbGFwc2UgdGhlcmUgb2YganVzdCBj
YWxsaW5nIHg4Nl9wbXVfaGFuZGxlX2lycSgpDQpmcm9tIHRoZSBuZXcgcm91dGluZS4NCg0KPiAN
Cj4gKyAgICAgICBpZiAoYWN0aXZlIDw9IDEpIHsNCj4gCQl0aGlzX2NwdV93cml0ZShwZXJmX25t
aV9jb3VudGVyLCAwKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBoYW5kbGVkOw0KPiAJfQ0K
PiArDQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBJZiBhIGNvdW50ZXIgd2FzIGhhbmRsZWQs
IHJlY29yZCB0aGUgbnVtYmVyIG9mIHBvc3NpYmxlIHJlbWFpbmluZw0KPiArICAgICAgICAqIE5N
SXMgdGhhdCBjYW4gb2NjdXIuDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgaWYgKGhhbmRsZWQp
IHsNCj4gKyAgICAgICAgICAgICAgIHRoaXNfY3B1X3dyaXRlKHBlcmZfbm1pX2NvdW50ZXIsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtaW5fdCh1bnNpZ25lZCBpbnQsIDIsIGFj
dGl2ZSAtIDEpKTsNCj4gKw0KPiArICAgICAgICAgICAgICAgcmV0dXJuIGhhbmRsZWQ7DQo+ICsg
ICAgICAgfQ0KPiArDQo+ICsgICAgICAgaWYgKCF0aGlzX2NwdV9yZWFkKHBlcmZfbm1pX2NvdW50
ZXIpKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIE5NSV9ET05FOw0KPiArDQo+ICsgICAgICAg
dGhpc19jcHVfZGVjKHBlcmZfbm1pX2NvdW50ZXIpOw0KPiArDQo+ICsgICAgICAgcmV0dXJuIE5N
SV9IQU5ETEVEOw0KPiB9DQo+IA0KPj4+IEFueXdheSwgd2UgYWxyZWFkeSBoYWQgY29kZSB0byBk
ZWFsIHdpdGggc3B1cmlvdXMgTk1JcyBmcm9tIEFNRDsgc2VlDQo+Pj4gY29tbWl0Og0KPj4+DQo+
Pj4gICAgIDYzZTZiZTZkOThlMSAoInBlcmYsIHg4NjogQ2F0Y2ggc3B1cmlvdXMgaW50ZXJydXB0
cyBhZnRlciBkaXNhYmxpbmcgY291bnRlcnMiKQ0KPj4+DQo+Pj4gQW5kIHRoYXQgbG9va3MgdG8g
YmUgZG9pbmcgc29tZXRoaW5nIHZlcnkgbXVjaCB0aGUgc2FtZS4gV2h5IHRoZW4gZG8geW91DQo+
Pj4gc3RpbGwgbmVlZCB0aGlzIG9uIHRvcD8NCj4+DQo+PiBUaGlzIGNhbiBoYXBwZW4gd2hpbGUg
cGVyZiBpcyBoYW5kbGluZyBub3JtYWwgY291bnRlciBvdmVyZmxvdyBhcyBvcHBvc2VkDQo+PiB0
byBjb3ZlcmluZyB0aGUgZGlzYWJsaW5nIG9mIHRoZSBjb3VudGVyIGNhc2UuIFdoZW4gbXVsdGlw
bGUgY291bnRlcnMNCj4+IG92ZXJmbG93IGF0IHJvdWdobHkgdGhlIHNhbWUgdGltZSwgYnV0IHRo
ZSBOTUkgZG9lc24ndCBhcnJpdmUgaW4gdGltZSB0bw0KPj4gZ2V0IGNvbGxhcHNlZCBpbnRvIGEg
cGVuZGluZyBOTUksIHRoZSBiYWNrLXRvLWJhY2sgc3VwcG9ydCBpbg0KPj4gZG9fZGVmYXVsdF9u
bWkoKSBkb2Vzbid0IGtpY2sgaW4uDQo+Pg0KPj4gSG1tbS4uLiBJIHdvbmRlciBpZiB0aGUgd2Fp
dCBvbiBvdmVyZmxvdyBpbiB0aGUgZGlzYWJsZV9hbGwoKSBmdW5jdGlvbg0KPj4gd291bGQgZWxp
bWluYXRlIHRoZSBuZWVkIGZvciA2M2U2YmU2ZDk4ZTEuIFRoYXQgd291bGQgdGFrZSBhIG1vcmUg
dGVzdGluZw0KPj4gb24gc29tZSBvbGRlciBoYXJkd2FyZSB0byB2ZXJpZnkuIFRoYXQncyBzb21l
dGhpbmcgSSBjYW4gbG9vayBpbnRvDQo+PiBzZXBhcmF0ZSBmcm9tIHRoaXMgc2VyaWVzLg0KPiAN
Cj4gWWVzIHBsZWFzZSwgb3IgYXQgbGVhc3QgYmV0dGVyIGRvY3VtZW50IHRoZSByZWFzb24gZm9y
IHRoZWlyIHNlcGFyYXRlDQo+IGV4aXN0ZW5jZS4gSXQncyBhbGwgdHVybmluZyBpbnRvIGEgYml0
IG9mIG1hZ2ljIGl0IHNlZW1zLg0KDQpPaywgSSdsbCB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdl
IHdpdGggYSBiaXQgbW9yZSBpbmZvIGFuZCBhZGQgdG8gdGhlDQpjb21tZW50IG9mIHRoZSBuZXcg
QU1EIGhhbmRsZV9pcnEgZnVuY3Rpb24uDQoNClRoYW5rcywNClRvbQ0KDQo+IA0K
