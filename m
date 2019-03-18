Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805FBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471C220854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yVNcMTaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfCRQky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:40:54 -0400
Received: from mail-eopbgr690049.outbound.protection.outlook.com ([40.107.69.49]:40398
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726806AbfCRQkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRkQ1WlTUcCzubi5oqsiSJ+R90JvRunTXivgil+iXJY=;
 b=yVNcMTaK84d/gwmLPcniRe2Xg3TS86KRiIKgq3l+GfHmxOn0+ttQFwFbz9pouOFLWyZkV37aSp8QBPn/Rz+ZeHYgxXTwio627+CGq9DWMmQly0PuYy9yxRCMvoDHojDzSOEpanTeHZP2XfT7TQvfWNxihz0XzEFixBTW0Qssj9s=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2907.namprd12.prod.outlook.com (20.179.71.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 16:40:09 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 16:40:09 +0000
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
Subject: Re: [RFC PATCH v2 2/2] x86/perf/amd: Resolve NMI latency issues when
 multiple PMCs are active
Thread-Topic: [RFC PATCH v2 2/2] x86/perf/amd: Resolve NMI latency issues when
 multiple PMCs are active
Thread-Index: AQHU229mIvha5pwXckCqUIpBYzaKP6YRNwuAgABkkgA=
Date:   Mon, 18 Mar 2019 16:40:09 +0000
Message-ID: <37b024a1-5b6b-9302-5fd8-3735980f933c@amd.com>
References: <155268244291.14761.3432013617741218607.stgit@tlendack-t1.amdoffice.net>
 <155268245818.14761.10443012194152751116.stgit@tlendack-t1.amdoffice.net>
 <20190318104009.GK6058@hirez.programming.kicks-ass.net>
In-Reply-To: <20190318104009.GK6058@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0006.namprd06.prod.outlook.com
 (2603:10b6:803:2f::16) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96a42b8f-8f80-46cc-f08c-08d6abc06248
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2907;
x-ms-traffictypediagnostic: DM6PR12MB2907:
x-microsoft-antispam-prvs: <DM6PR12MB2907BCD13D4EB03A6084196CEC470@DM6PR12MB2907.namprd12.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(7416002)(6436002)(2906002)(71200400001)(86362001)(6486002)(66066001)(8676002)(25786009)(229853002)(26005)(71190400001)(14444005)(76176011)(52116002)(102836004)(31696002)(31686004)(53546011)(386003)(36756003)(316002)(6506007)(256004)(446003)(6246003)(4326008)(6916009)(8936002)(54906003)(3846002)(6116002)(6512007)(478600001)(72206003)(14454004)(97736004)(5660300002)(11346002)(486006)(99286004)(186003)(68736007)(81156014)(106356001)(105586002)(53936002)(81166006)(7736002)(305945005)(2616005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2907;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YpibiVPFNPUVzFBuwqbJgtyn9XK/gQMZZ8NRmrw7KIWepAbEh+pQsbo8NqGBoxrXH14NrN+K1oM6fseaFP640POTQvbhXcD26pK2O1HgfOknReruSXkfI2+KV094ou+PtSQtEul5yU3vzElmjlnV3SOcHWo5lWzKDwcFRGd9NL/7dA1S/XheXp2S36fyIR/qPLOUiYzUOk1oLY+Jlh+YxzG/VCWTuiM0o2XoHiUvUPEo798ZU7JiIM9ibGXq0Id4V5DG119kamBM8QafAZlLrOxtHTmc0+uT2ns/h8bHieCRqRIWfpW2YPCe5if5tZLvRmXhyEIvuyGa8CTm9bRBJJ45w+cyyqWlBk0e1yTlg0FIlDGzqfJ6z8qIK1NeKCOna6lf350YP16DDmTuO3TxEjqD2QAfwGcf8ZcEyfgVxic=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C44CD18CA6BC0B48B577BDDB45C3A8E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a42b8f-8f80-46cc-f08c-08d6abc06248
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 16:40:09.8487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xOC8xOSA1OjQwIEFNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gRnJpLCBNYXIg
MTUsIDIwMTkgYXQgMDg6NDE6MDBQTSArMDAwMCwgTGVuZGFja3ksIFRob21hcyB3cm90ZToNCj4+
IFRoaXMgaXNzdWUgaXMgZGlmZmVyZW50IGZyb20gYSBwcmV2aW91cyBpc3N1ZSByZWxhdGVkIHRv
IHBlcmYgTk1JcyB0aGF0DQo+PiB3YXMgZml4ZWQgaW4gY29tbWl0Og0KPj4gICA2M2U2YmU2ZDk4
ZTEgKCJwZXJmLCB4ODY6IENhdGNoIHNwdXJpb3VzIGludGVycnVwdHMgYWZ0ZXIgZGlzYWJsaW5n
IGNvdW50ZXJzIikNCj4+DQo+PiBUaGUgZGlmZmVyZW5jZSBoZXJlIGlzIHRoYXQgdGhlIE5NSSBs
YXRlbmN5IGNhbiBjb250cmlidXRlIHRvIHdoYXQgYXBwZWFyDQo+PiB0byBiZSBzcHVyaW91cyBO
TUlzIGR1cmluZyB0aGUgaGFuZGxpbmcgb2YgUE1DIGNvdW50ZXIgb3ZlcmZsb3cgd2hpbGUgdGhl
DQo+PiBjb3VudGVyIGlzIGFjdGl2ZSBhcyBvcHBvc2VkIHRvIHdoZW4gdGhlIGNvdW50ZXIgaXMg
YmVpbmcgZGlzYWJsZWQuDQo+IA0KPiBCdXQgY291bGQgd2Ugbm90IHNvbWVob3cgbWVyZ2UgdGhl
c2UgdHdvIGNhc2VzPyBUaGUgY2F1c2UgaXMgc2ltaWxhcg0KPiBJSVVDLiBUaGUgUE1JIGdldHMg
dHJpZ2dlcmVkLCBidXQgdGhlbjoNCj4gDQo+ICAgLSBhIHByZXZpb3VzIFBNSSBoYW5kbGVyIGhh
bmRsZWQgb3VyIG92ZXJmbG93LCBvcg0KPiAgIC0gb3VyIGV2ZW50IGdldHMgZGlzYWJsZWQuDQo+
IA0KPiBhbmQgd2hlbiBvdXIgUE1JIHRyaWdnZXJzIGl0IGZpbmRzIG5vdGhpbmcgdG8gZG8uDQoN
ClllcywgbGV0IG1lIGxvb2sgaW50byB3aGF0IHdlIGNhbiBkbyBoZXJlLg0KDQo+IA0KPj4gKy8q
DQo+PiArICogQmVjYXVzZSBvZiBOTUkgbGF0ZW5jeSwgaWYgbXVsdGlwbGUgUE1DIGNvdW50ZXJz
IGFyZSBhY3RpdmUgb3Igb3RoZXIgc291cmNlcw0KPj4gKyAqIG9mIE5NSXMgYXJlIHJlY2VpdmVk
LCB0aGUgcGVyZiBOTUkgaGFuZGxlciBjYW4gaGFuZGxlIG9uZSBvciBtb3JlIG92ZXJmbG93ZWQN
Cj4+ICsgKiBQTUMgY291bnRlcnMgb3V0c2lkZSBvZiB0aGUgTk1JIGFzc29jaWF0ZWQgd2l0aCB0
aGUgUE1DIG92ZXJmbG93LiBJZiB0aGUgTk1JDQo+PiArICogZG9lc24ndCBhcnJpdmUgYXQgdGhl
IExBUElDIGluIHRpbWUgdG8gYmVjb21lIGEgcGVuZGluZyBOTUksIHRoZW4gdGhlIGtlcm5lbA0K
Pj4gKyAqIGJhY2stdG8tYmFjayBOTUkgc3VwcG9ydCB3b24ndCBiZSBhY3RpdmUuIFRoaXMgUE1D
IGhhbmRsZXIgbmVlZHMgdG8gdGFrZSBpbnRvDQo+PiArICogYWNjb3VudCB0aGF0IHRoaXMgY2Fu
IG9jY3VyLCBvdGhlcndpc2UgdGhpcyBjb3VsZCByZXN1bHQgaW4gdW5rbm93biBOTUkNCj4+ICsg
KiBtZXNzYWdlcyBiZWluZyBpc3N1ZWQuIEV4YW1wbGVzIG9mIHRoaXMgaXMgUE1DIG92ZXJmbG93
IHdoaWxlIGluIHRoZSBOTUkNCj4+ICsgKiBoYW5kbGVyIHdoZW4gbXVsdGlwbGUgUE1DcyBhcmUg
YWN0aXZlIG9yIFBNQyBvdmVyZmxvdyB3aGlsZSBoYW5kbGluZyBzb21lDQo+PiArICogb3RoZXIg
c291cmNlIG9mIGFuIE5NSS4NCj4+ICsgKg0KPj4gKyAqIEF0dGVtcHQgdG8gbWl0aWdhdGUgdGhp
cyBieSB1c2luZyB0aGUgbnVtYmVyIG9mIGFjdGl2ZSBQTUNzIHRvIGRldGVybWluZQ0KPj4gKyAq
IHdoZXRoZXIgdG8gcmV0dXJuIE5NSV9IQU5ETEVEIGlmIHRoZSBwZXJmIE5NSSBoYW5kbGVyIGRp
ZCBub3QgaGFuZGxlL3Jlc2V0DQo+PiArICogYW55IFBNQ3MuIFRoZSBwZXItQ1BVIHBlcmZfbm1p
X2NvdW50ZXIgdmFyaWFibGUgaXMgc2V0IHRvIGEgbWluaW11bSBvZiB0aGUNCj4+ICsgKiBudW1i
ZXIgb2YgYWN0aXZlIFBNQ3Mgb3IgMi4gVGhlIHZhbHVlIG9mIDIgaXMgdXNlZCBpbiBjYXNlIGFu
IE5NSSBkb2VzIG5vdA0KPj4gKyAqIGFycml2ZSBhdCB0aGUgTEFQSUMgaW4gdGltZSB0byBiZSBj
b2xsYXBzZWQgaW50byBhbiBhbHJlYWR5IHBlbmRpbmcgTk1JLg0KPj4gKyAqLw0KPj4gK3N0YXRp
YyBpbnQgYW1kX3BtdV9oYW5kbGVfaXJxKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPj4gK3sNCj4+
ICsJc3RydWN0IGNwdV9od19ldmVudHMgKmNwdWMgPSB0aGlzX2NwdV9wdHIoJmNwdV9od19ldmVu
dHMpOw0KPj4gKwlpbnQgYWN0aXZlLCBoYW5kbGVkOw0KPj4gKw0KPj4gKwlhY3RpdmUgPSBfX2Jp
dG1hcF93ZWlnaHQoY3B1Yy0+YWN0aXZlX21hc2ssIFg4Nl9QTUNfSURYX01BWCk7DQo+PiArCWhh
bmRsZWQgPSB4ODZfcG11X2hhbmRsZV9pcnEocmVncyk7DQo+PiArDQo+PiArCS8qDQo+PiArCSAq
IElmIG5vIGNvdW50ZXJzIGFyZSBhY3RpdmUsIHJlc2V0IHBlcmZfbm1pX2NvdW50ZXIgYW5kIHJl
dHVybg0KPj4gKwkgKiBOTUlfRE9ORQ0KPj4gKwkgKi8NCj4+ICsJaWYgKCFhY3RpdmUpIHsNCj4+
ICsJCXRoaXNfY3B1X3dyaXRlKHBlcmZfbm1pX2NvdW50ZXIsIDApOw0KPj4gKwkJcmV0dXJuIE5N
SV9ET05FOw0KPj4gKwl9DQo+IA0KPiBUaGlzIHdpbGwgYWN0aXZlbHkgcmVuZGVyIDYzZTZiZTZk
OThlMSB2b2lkIEkgdGhpbmsuIEJlY2F1c2UgdGhhdCBjYW4NCj4gcmV0dXJuICEwIHdoaWxlICFh
Y3RpdmUgLS0gdGhhdCdzIHJhdGhlciB0aGUgd2hvbGUgcG9pbnQgb2YgaXQuDQoNCll1cCwgSSBk
aWRuJ3QgdGFrZSB0aGF0IGludG8gYWNjb3VudCB3aGVuIEkgY2hhbmdlZCB0aGF0LiBMZXQgbWUg
dGFrZSBhDQpjbG9zZXIgbG9vayBhdCBhbGwgdGhpcyBhbG9uZyB3aXRoIHlvdXIgc3VnZ2VzdGlv
biBmcm9tIHRoZSBvdGhlciBlbWFpbC4NCg0KSSdtIHRyYXZlbGluZyB0aGlzIHdlZWssIHNvIGl0
IG1pZ2h0IGJlIGEgZmV3IGRheXMuDQoNClRoYW5rcywNClRvbQ0KDQo+IA0KPj4gKwkvKg0KPj4g
KwkgKiBJZiBhIGNvdW50ZXIgd2FzIGhhbmRsZWQsIHJlY29yZCB0aGUgbnVtYmVyIG9mIHBvc3Np
YmxlIHJlbWFpbmluZw0KPj4gKwkgKiBOTUlzIHRoYXQgY2FuIG9jY3VyLg0KPj4gKwkgKi8NCj4+
ICsJaWYgKGhhbmRsZWQpIHsNCj4+ICsJCXRoaXNfY3B1X3dyaXRlKHBlcmZfbm1pX2NvdW50ZXIs
DQo+PiArCQkJICAgICAgIG1pbl90KHVuc2lnbmVkIGludCwgMiwgYWN0aXZlKSk7DQo+PiArDQo+
PiArCQlyZXR1cm4gaGFuZGxlZDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlpZiAoIXRoaXNfY3B1X3Jl
YWQocGVyZl9ubWlfY291bnRlcikpDQo+PiArCQlyZXR1cm4gTk1JX0RPTkU7DQo+PiArDQo+PiAr
CXRoaXNfY3B1X2RlYyhwZXJmX25taV9jb3VudGVyKTsNCj4+ICsNCj4+ICsJcmV0dXJuIE5NSV9I
QU5ETEVEOw0KPj4gK30NCj4gDQo+IA0K
