Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C62AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B8E218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ewlxq0Z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfCOOoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:44:39 -0400
Received: from mail-eopbgr680054.outbound.protection.outlook.com ([40.107.68.54]:3043
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727358AbfCOOoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 10:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxNtmQUxabNIouVgSIlnfkeZrkzVLAEldWTkQ9eeNS8=;
 b=Ewlxq0Z4RGVtoJLfTE1/pL5e5rj5CfH7Xb/meIO4z3tKtx+Sm6GOifKqIIFN7Ey91yjss8lpXxRxtrSGoXMmwHu3nLFwAqLcHWhALu4YI6YVW9h76BiZkg4Tp3QE8y2k7ShR/9Q/N2CC7aUwOny+kbh8nrPtgDRlzBFh12uNk/M=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2874.namprd12.prod.outlook.com (20.179.71.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 14:44:32 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 14:44:32 +0000
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
Thread-Index: AQHU2CpOuC8N+vFHqESTwWx3yJMr4aYMncqAgAAtDoA=
Date:   Fri, 15 Mar 2019 14:44:32 +0000
Message-ID: <ef7fb4f8-29a8-16e6-5a8c-18da2eaf4243@amd.com>
References: <155232291547.21417.2499429555505085131.stgit@tlendack-t1.amdoffice.net>
 <155232292961.21417.3665243457569518550.stgit@tlendack-t1.amdoffice.net>
 <20190315120311.GX5996@hirez.programming.kicks-ass.net>
In-Reply-To: <20190315120311.GX5996@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR16CA0067.namprd16.prod.outlook.com
 (2603:10b6:805:ca::44) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a77abb1-e356-4d90-1ece-08d6a954bc64
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2874;
x-ms-traffictypediagnostic: DM6PR12MB2874:
x-microsoft-antispam-prvs: <DM6PR12MB287410BA385132CCD23BBCEEEC440@DM6PR12MB2874.namprd12.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(136003)(376002)(54094003)(52314003)(189003)(199004)(97736004)(72206003)(31686004)(76176011)(53936002)(316002)(53546011)(6506007)(54906003)(52116002)(26005)(3846002)(25786009)(14454004)(386003)(5660300002)(66066001)(6116002)(229853002)(6512007)(2906002)(6246003)(105586002)(7736002)(106356001)(446003)(71190400001)(6436002)(99286004)(102836004)(2616005)(71200400001)(476003)(68736007)(7416002)(6916009)(36756003)(8676002)(14444005)(6486002)(11346002)(81166006)(305945005)(478600001)(8936002)(486006)(186003)(86362001)(81156014)(31696002)(4326008)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2874;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lNXEvFSzaJhXlvkHKOJIHiF1RTJjY7cXAkf8F9KiNSzWlClo6X8jIN7g1TEk9ZKJ/purXWZNfpr5NPf+Pf0mysGA9rbntQgD2gRtTzPswFcGAF5+/xErzJzQqU5y9nDbuH32qX65eWG1h4L7LlICkzGSXhqJB2KPnJ4c9x+r0MMFk2lrbgtlDNNGGk2sEJQ+jKOkN+Gn4ExSJwxsT2Na7jYrPsHf9Bqar/4Ny4yb4VpLkZ7vpR7DTKIV+Pq1wVLA44i3CQty5ZpfwzIQw5lZ/IMHlHiWQ9cX3vtXHp5e/H/6p1F57BQLJT+KEw9akgcQuf4XUEHOBWltgKA10VY5e5HLwv/UBiaK+3Rk1Ros2KThC+CHOraaSN2JWAO0tHtP+lHH0OknhsC7AcF8TkK04EcDncD5fRG7Php7a8X0GMY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13C23369F4253E41B96AFA20D2ED8325@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a77abb1-e356-4d90-1ece-08d6a954bc64
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 14:44:32.8143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2874
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNS8xOSA3OjAzIEFNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gTW9uLCBNYXIg
MTEsIDIwMTkgYXQgMDQ6NDg6NTFQTSArMDAwMCwgTGVuZGFja3ksIFRob21hcyB3cm90ZToNCj4+
IEBAIC00NjcsNiArNDcwLDQ1IEBAIHN0YXRpYyB2b2lkIGFtZF9wbXVfd2FpdF9vbl9vdmVyZmxv
dyhpbnQgaWR4LCB1NjQgY29uZmlnKQ0KPj4gICAJfQ0KPj4gICB9DQo+PiAgIA0KPj4gKy8qDQo+
PiArICogQmVjYXVzZSBvZiBOTUkgbGF0ZW5jeSwgaWYgbXVsdGlwbGUgUE1DIGNvdW50ZXJzIGFy
ZSBhY3RpdmUgd2UgbmVlZCB0byB0YWtlDQo+PiArICogaW50byBhY2NvdW50IHRoYXQgbXVsdGlw
bGUgUE1DIG92ZXJmbG93cyBjYW4gZ2VuZXJhdGUgbXVsdGlwbGUgTk1JcyBidXQgYmUNCj4+ICsg
KiBoYW5kbGVkIGJ5IGEgc2luZ2xlIGludm9jYXRpb24gb2YgdGhlIE5NSSBoYW5kbGVyICh0aGlu
ayBQTUMgb3ZlcmZsb3cgd2hpbGUNCj4+ICsgKiBpbiB0aGUgTk1JIGhhbmRsZXIpLiBUaGlzIGNv
dWxkIHJlc3VsdCBpbiBzdWJzZXF1ZW50IHVua25vd24gTk1JIG1lc3NhZ2VzDQo+PiArICogYmVp
bmcgaXNzdWVkLg0KPj4gKyAqDQo+PiArICogQXR0ZW1wdCB0byBtaXRpZ2F0ZSB0aGlzIGJ5IHVz
aW5nIHRoZSBudW1iZXIgb2YgYWN0aXZlIFBNQ3MgdG8gZGV0ZXJtaW5lDQo+PiArICogd2hldGhl
ciB0byByZXR1cm4gTk1JX0hBTkRMRUQgaWYgdGhlIHBlcmYgTk1JIGhhbmRsZXIgZGlkIG5vdCBo
YW5kbGUvcmVzZXQNCj4+ICsgKiBhbnkgUE1Dcy4gVGhlIHBlci1DUFUgcGVyZl9ubWlfY291bnRl
ciB2YXJpYWJsZSBpcyBzZXQgdG8gYSBtaW5pbXVtIG9mIG9uZQ0KPj4gKyAqIGxlc3MgdGhhbiB0
aGUgbnVtYmVyIG9mIGFjdGl2ZSBQTUNzIG9yIDIuIFRoZSB2YWx1ZSBvZiAyIGlzIHVzZWQgaW4g
Y2FzZSB0aGUNCj4+ICsgKiBOTUkgZG9lcyBub3QgYXJyaXZlIGF0IHRoZSBBUElDIGluIHRpbWUg
dG8gYmUgY29sbGFwc2VkIGludG8gYW4gYWxyZWFkeQ0KPj4gKyAqIHBlbmRpbmcgTk1JLg0KPiAN
Cj4gTEFQSUMgSSByZWFsbHkgZG8gaG9wZT8hDQoNClllcywgTEFQSUMuDQoNCj4gDQo+PiArICov
DQo+PiArc3RhdGljIGludCBhbWRfcG11X21pdGlnYXRlX25taV9sYXRlbmN5KHVuc2lnbmVkIGlu
dCBhY3RpdmUsIGludCBoYW5kbGVkKQ0KPj4gK3sNCj4+ICsJLyogSWYgbXVsdGlwbGUgY291bnRl
cnMgYXJlIG5vdCBhY3RpdmUgcmV0dXJuIG9yaWdpbmFsIGhhbmRsZWQgY291bnQgKi8NCj4+ICsJ
aWYgKGFjdGl2ZSA8PSAxKQ0KPj4gKwkJcmV0dXJuIGhhbmRsZWQ7DQo+IA0KPiBTaG91bGQgd2Ug
bm90IHJlc2V0IHBlcmZfbm1pX2NvdW50ZXIgaW4gdGhpcyBjYXNlPw0KDQpZZXMsIHdlIHNob3Vs
ZC4gIEknbGwgbWFrZSB0aGF0IGNoYW5nZS4NCg0KPiANCj4+ICsNCj4+ICsJLyoNCj4+ICsJICog
SWYgYSBjb3VudGVyIHdhcyBoYW5kbGVkLCByZWNvcmQgdGhlIG51bWJlciBvZiBwb3NzaWJsZSBy
ZW1haW5pbmcNCj4+ICsJICogTk1JcyB0aGF0IGNhbiBvY2N1ci4NCj4+ICsJICovDQo+PiArCWlm
IChoYW5kbGVkKSB7DQo+PiArCQl0aGlzX2NwdV93cml0ZShwZXJmX25taV9jb3VudGVyLA0KPj4g
KwkJCSAgICAgICBtaW5fdCh1bnNpZ25lZCBpbnQsIDIsIGFjdGl2ZSAtIDEpKTsNCj4+ICsNCj4+
ICsJCXJldHVybiBoYW5kbGVkOw0KPj4gKwl9DQo+PiArDQo+PiArCWlmICghdGhpc19jcHVfcmVh
ZChwZXJmX25taV9jb3VudGVyKSkNCj4+ICsJCXJldHVybiBOTUlfRE9ORTsNCj4+ICsNCj4+ICsJ
dGhpc19jcHVfZGVjKHBlcmZfbm1pX2NvdW50ZXIpOw0KPj4gKw0KPj4gKwlyZXR1cm4gTk1JX0hB
TkRMRUQ7DQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgc3RydWN0IGV2ZW50X2NvbnN0cmFpbnQg
Kg0KPj4gICBhbWRfZ2V0X2V2ZW50X2NvbnN0cmFpbnRzKHN0cnVjdCBjcHVfaHdfZXZlbnRzICpj
cHVjLCBpbnQgaWR4LA0KPj4gICAJCQkgIHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCkNCj4+IEBA
IC02ODksNiArNzMxLDcgQEAgc3RhdGljIF9faW5pdGNvbnN0IGNvbnN0IHN0cnVjdCB4ODZfcG11
IGFtZF9wbXUgPSB7DQo+PiAgIA0KPj4gICAJLmFtZF9uYl9jb25zdHJhaW50cwk9IDEsDQo+PiAg
IAkud2FpdF9vbl9vdmVyZmxvdwk9IGFtZF9wbXVfd2FpdF9vbl9vdmVyZmxvdywNCj4+ICsJLm1p
dGlnYXRlX25taV9sYXRlbmN5CT0gYW1kX3BtdV9taXRpZ2F0ZV9ubWlfbGF0ZW5jeSwNCj4+ICAg
fTsNCj4gDQo+IEFnYWluLCB5b3UgY291bGQganVzdCBkbyBhbWRfcG11X2hhbmRsZV9pcnEoKSBh
bmQgYXZvaWQgYW4gZXh0cmENCj4gY2FsbGJhY2suDQoNClRoaXMgaXMgd2hlcmUgdGhlcmUgd291
bGQgYmUgYSBidW5jaCBvZiBjb2RlIGR1cGxpY2F0aW9uIHdoZXJlIEkgdGhvdWdodA0KYWRkaW5n
IHRoZSBjYWxsYmFjayBhdCB0aGUgZW5kIHdvdWxkIGJlIGJldHRlci4gQnV0IGlmIGl0J3MgYmVz
dCB0byBhZGQNCmFuIEFNRCBoYW5kbGVfaXJxIGNhbGxiYWNrIEkgY2FuIGRvIHRoYXQuIEknbSBl
YXN5LCBsZXQgbWUga25vdyBpZiB5b3UnZA0KcHJlZmVyIHRoYXQuDQoNCj4gDQo+IEFueXdheSwg
d2UgYWxyZWFkeSBoYWQgY29kZSB0byBkZWFsIHdpdGggc3B1cmlvdXMgTk1JcyBmcm9tIEFNRDsg
c2VlDQo+IGNvbW1pdDoNCj4gDQo+ICAgIDYzZTZiZTZkOThlMSAoInBlcmYsIHg4NjogQ2F0Y2gg
c3B1cmlvdXMgaW50ZXJydXB0cyBhZnRlciBkaXNhYmxpbmcgY291bnRlcnMiKQ0KPiANCj4gQW5k
IHRoYXQgbG9va3MgdG8gYmUgZG9pbmcgc29tZXRoaW5nIHZlcnkgbXVjaCB0aGUgc2FtZS4gV2h5
IHRoZW4gZG8geW91DQo+IHN0aWxsIG5lZWQgdGhpcyBvbiB0b3A/DQoNClRoaXMgY2FuIGhhcHBl
biB3aGlsZSBwZXJmIGlzIGhhbmRsaW5nIG5vcm1hbCBjb3VudGVyIG92ZXJmbG93IGFzIG9wcG9z
ZWQNCnRvIGNvdmVyaW5nIHRoZSBkaXNhYmxpbmcgb2YgdGhlIGNvdW50ZXIgY2FzZS4gV2hlbiBt
dWx0aXBsZSBjb3VudGVycw0Kb3ZlcmZsb3cgYXQgcm91Z2hseSB0aGUgc2FtZSB0aW1lLCBidXQg
dGhlIE5NSSBkb2Vzbid0IGFycml2ZSBpbiB0aW1lIHRvDQpnZXQgY29sbGFwc2VkIGludG8gYSBw
ZW5kaW5nIE5NSSwgdGhlIGJhY2stdG8tYmFjayBzdXBwb3J0IGluDQpkb19kZWZhdWx0X25taSgp
IGRvZXNuJ3Qga2ljayBpbi4NCg0KSG1tbS4uLiBJIHdvbmRlciBpZiB0aGUgd2FpdCBvbiBvdmVy
ZmxvdyBpbiB0aGUgZGlzYWJsZV9hbGwoKSBmdW5jdGlvbg0Kd291bGQgZWxpbWluYXRlIHRoZSBu
ZWVkIGZvciA2M2U2YmU2ZDk4ZTEuIFRoYXQgd291bGQgdGFrZSBhIG1vcmUgdGVzdGluZw0Kb24g
c29tZSBvbGRlciBoYXJkd2FyZSB0byB2ZXJpZnkuIFRoYXQncyBzb21ldGhpbmcgSSBjYW4gbG9v
ayBpbnRvDQpzZXBhcmF0ZSBmcm9tIHRoaXMgc2VyaWVzLg0KDQpUaGFua3MsDQpUb20NCg0KPiAN
Cj4gDQo=
