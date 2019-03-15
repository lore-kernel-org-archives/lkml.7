Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04924C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DBA218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FUUgQZiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfCORrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:47:37 -0400
Received: from mail-eopbgr750074.outbound.protection.outlook.com ([40.107.75.74]:38530
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbfCORre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdIoXcfXbKYENjFGXP36CvwcywO/KZFEYQKE/qoI1XI=;
 b=FUUgQZiGAi317I9Grhm+rvssQetYeL+D6CIX+AirGckXatvO6WYYRSsnCODf+49UN2atUQglEKZJFL10CSMzs/VMoHFd6J9blxUtjNhY+OGQ5GLPZ2zkrW9/Qwi1AKpZaq+TgfeGVifz9VUQnGSVlP+GPKZdx6luqjWIs75oIR0=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2603.namprd12.prod.outlook.com (20.176.116.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 17:47:31 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 17:47:31 +0000
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
Thread-Index: AQHU2CpOuC8N+vFHqESTwWx3yJMr4aYMncqAgAAtDoCAAAd0gIAACteAgAAg1QA=
Date:   Fri, 15 Mar 2019 17:47:31 +0000
Message-ID: <42852d76-b178-8df8-e1ab-8daf6dc31de6@amd.com>
References: <155232291547.21417.2499429555505085131.stgit@tlendack-t1.amdoffice.net>
 <155232292961.21417.3665243457569518550.stgit@tlendack-t1.amdoffice.net>
 <20190315120311.GX5996@hirez.programming.kicks-ass.net>
 <ef7fb4f8-29a8-16e6-5a8c-18da2eaf4243@amd.com>
 <20190315151107.GG6058@hirez.programming.kicks-ass.net>
 <40b3c397-0d21-b8e2-c80f-14e3fe850cb2@amd.com>
In-Reply-To: <40b3c397-0d21-b8e2-c80f-14e3fe850cb2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0075.namprd05.prod.outlook.com
 (2603:10b6:803:22::13) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29e8f697-9552-43ea-189f-08d6a96e4c11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2603;
x-ms-traffictypediagnostic: DM6PR12MB2603:
x-microsoft-antispam-prvs: <DM6PR12MB260346EF5FEE516B8B736CDDEC440@DM6PR12MB2603.namprd12.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(346002)(39860400002)(366004)(376002)(136003)(54094003)(52314003)(189003)(199004)(486006)(106356001)(316002)(31686004)(53936002)(6246003)(6486002)(186003)(26005)(71190400001)(6436002)(5660300002)(229853002)(99286004)(6512007)(71200400001)(6506007)(102836004)(2906002)(4326008)(53546011)(25786009)(54906003)(93886005)(478600001)(14454004)(72206003)(97736004)(52116002)(386003)(76176011)(2616005)(36756003)(446003)(14444005)(6116002)(3846002)(7736002)(8676002)(305945005)(66066001)(68736007)(7416002)(256004)(105586002)(81166006)(81156014)(476003)(86362001)(8936002)(6916009)(31696002)(11346002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2603;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M9JDvYY5Gi49/yz2AbfG+TQzqNggJyRqyFcP2QQkHr08w+h7Lf5qRYd1wf0WzvUTVoWr8fzCS+Aa5qNIiq9EjWhiPjaHli7HE8g5Mt1YshkMxx+lBR4u9Cddkxo7cPgpyEVq3scpLtJ0Kf13SCHLDy+ng97zn8ECFxa/BaPb+xAvylTrSuQ/JbqG/Hs8b/nPJoxDHRnRg3Y9ez6zkRoxkVDH5eqZrkIDiq65H4MbdSNvF5MeZwS8HmEIeB457fqfVsTb7R4b9kQuRBo2Zz4EaOPzJcf50INEMoldAbk1rNBDMIED836JRla9s8bAGVxoWjJ+Fwnzh0AHmVQHTKQp6TjJvYirkFgq7we0RCkpreCZRKkdZkLbjp6uwqSrNt8fR+Fgg0zilpj5wxVWwJL5cgXaRhq9D1eVx6VOkBh4pPk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <042F1A38B5EF834A9D2601B9FD1E0932@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e8f697-9552-43ea-189f-08d6a96e4c11
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 17:47:31.2873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNS8xOSAxMDo0OSBBTSwgVG9tIExlbmRhY2t5IHdyb3RlOg0KPiBPbiAzLzE1LzE5IDEw
OjExIEFNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+IE9uIEZyaSwgTWFyIDE1LCAyMDE5IGF0
IDAyOjQ0OjMyUE0gKzAwMDAsIExlbmRhY2t5LCBUaG9tYXMgd3JvdGU6DQo+Pg0KPj4+Pj4gQEAg
LTY4OSw2ICs3MzEsNyBAQCBzdGF0aWMgX19pbml0Y29uc3QgY29uc3Qgc3RydWN0IHg4Nl9wbXUg
YW1kX3BtdSA9IHsNCj4+Pj4+IMKgwqDCoMKgwqDCoCAuYW1kX25iX2NvbnN0cmFpbnRzwqDCoMKg
ID0gMSwNCj4+Pj4+IMKgwqDCoMKgwqDCoCAud2FpdF9vbl9vdmVyZmxvd8KgwqDCoCA9IGFtZF9w
bXVfd2FpdF9vbl9vdmVyZmxvdywNCj4+Pj4+ICvCoMKgwqAgLm1pdGlnYXRlX25taV9sYXRlbmN5
wqDCoMKgID0gYW1kX3BtdV9taXRpZ2F0ZV9ubWlfbGF0ZW5jeSwNCj4+Pj4+IMKgwqAgfTsNCj4+
Pj4NCj4+Pj4gQWdhaW4sIHlvdSBjb3VsZCBqdXN0IGRvIGFtZF9wbXVfaGFuZGxlX2lycSgpIGFu
ZCBhdm9pZCBhbiBleHRyYQ0KPj4+PiBjYWxsYmFjay4NCj4+Pg0KPj4+IFRoaXMgaXMgd2hlcmUg
dGhlcmUgd291bGQgYmUgYSBidW5jaCBvZiBjb2RlIGR1cGxpY2F0aW9uIHdoZXJlIEkgdGhvdWdo
dA0KPj4+IGFkZGluZyB0aGUgY2FsbGJhY2sgYXQgdGhlIGVuZCB3b3VsZCBiZSBiZXR0ZXIuIEJ1
dCBpZiBpdCdzIGJlc3QgdG8gYWRkDQo+Pj4gYW4gQU1EIGhhbmRsZV9pcnEgY2FsbGJhY2sgSSBj
YW4gZG8gdGhhdC4gSSdtIGVhc3ksIGxldCBtZSBrbm93IGlmIHlvdSdkDQo+Pj4gcHJlZmVyIHRo
YXQuDQo+Pg0KPj4gSG1tLCB0aGUgdGhpbmcgdGhhdCBhdm9pZHMgeW91IGRpcmVjdGx5IHVzaW5n
IHg4Nl9wbXVfaGFuZGxlX2lycSgpIGlzDQo+PiB0aGF0IGFkZGVkIGFjdGl2ZSBjb3VudCwgYnV0
IGlzIHRoYXQgbm90IHRoZSBzYW1lIGFzIHRoZSBQT1BDTlQgb2YNCj4+IGNwdWMtPmFjdGl2ZV9t
YXNrPw0KPj4NCj4+IElzIHRoZSBsYXRlbmN5IG9mIFBPUENOVCBzbyBiYWQgdGhhdCB3ZSBuZWVk
IGF2b2lkIGl0Pw0KPj4NCj4+IFRoYXQgaXMsIEkgd2FzIHRoaW5raW5nIG9mIHNvbWV0aGluZyBs
aWtlOg0KPj4NCj4+IGludCBhbWRfcG11X2hhbmRsZV9pcnEoc3RydWN0IHB0X3JlZ3MgKnJlZ3Mp
DQo+PiB7DQo+PiDCoMKgwqDCoHN0cnVjdCBjcHVfaHdfZXZlbnRzICpjcHVjID0gdGhpc19jcHVf
cHRyKCZjcHVfaHdfZXZlbnRzKTsNCj4+IMKgwqDCoMKgaW50IGFjdGl2ZSA9IGh3ZWlnaHRfbG9u
ZyhjcHVjLT5hY3RpdmVfbWFzayk7DQo+PiDCoMKgwqDCoGludCBoYW5kbGVkID0geDg2X3BtdV9o
YW5kbGVfaXJxKHJlZ3MpOw0KPiANCj4gWXVwLCBJIGhhZCBhIHRvdGFsIGJyYWluIGxhcHNlIHRo
ZXJlIG9mIGp1c3QgY2FsbGluZyB4ODZfcG11X2hhbmRsZV9pcnEoKQ0KPiBmcm9tIHRoZSBuZXcg
cm91dGluZS4NCj4gDQo+Pg0KPj4gK8KgwqDCoMKgwqDCoCBpZiAoYWN0aXZlIDw9IDEpIHsNCg0K
QW5kIEkgd2Fzbid0IHRha2luZyBpbnRvIGFjY291bnQgb3RoZXIgc291cmNlcyBvZiBOTUlzIHRy
aWdnZXJpbmcgdGhlDQpydW5uaW5nIG9mIHRoZSBoYW5kbGVyIHdoaWxlIHBlcmYgaXMgcnVubmlu
Zy4gSSB3YXMgb25seSB0aGlua2luZyBpbiB0ZXJtcw0Kb2YgTk1JcyBjb21pbmcgZnJvbSB0aGUg
UE1Dcy4gU28gdGhpcyByZWFsbHkgbmVlZHMgdG8gYmUgYSAhYWN0aXZlIGNoZWNrDQphbmQgdGhl
IHNldHRpbmcgb2YgdGhlIHBlcmZfbm1pX2NvdW50ZXIgYmVsb3cgbmVlZHMgdG8gYmUgdGhlIG1p
biBvZiAyIG9yDQphY3RpdmUuDQoNClRoYW5rcywNClRvbQ0KDQo+PiDCoMKgwqDCoMKgwqDCoCB0
aGlzX2NwdV93cml0ZShwZXJmX25taV9jb3VudGVyLCAwKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBoYW5kbGVkOw0KPj4gwqDCoMKgwqB9DQo+PiArDQo+PiArwqDC
oMKgwqDCoMKgIC8qDQo+PiArwqDCoMKgwqDCoMKgwqAgKiBJZiBhIGNvdW50ZXIgd2FzIGhhbmRs
ZWQsIHJlY29yZCB0aGUgbnVtYmVyIG9mIHBvc3NpYmxlIA0KPj4gcmVtYWluaW5nDQo+PiArwqDC
oMKgwqDCoMKgwqAgKiBOTUlzIHRoYXQgY2FuIG9jY3VyLg0KPj4gK8KgwqDCoMKgwqDCoMKgICov
DQo+PiArwqDCoMKgwqDCoMKgIGlmIChoYW5kbGVkKSB7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB0aGlzX2NwdV93cml0ZShwZXJmX25taV9jb3VudGVyLA0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWluX3Qo
dW5zaWduZWQgaW50LCAyLCBhY3RpdmUgLSAxKSk7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gaGFuZGxlZDsNCj4+ICvCoMKgwqDCoMKgwqAgfQ0KPj4gKw0K
Pj4gK8KgwqDCoMKgwqDCoCBpZiAoIXRoaXNfY3B1X3JlYWQocGVyZl9ubWlfY291bnRlcikpDQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTk1JX0RPTkU7DQo+PiArDQo+
PiArwqDCoMKgwqDCoMKgIHRoaXNfY3B1X2RlYyhwZXJmX25taV9jb3VudGVyKTsNCj4+ICsNCj4+
ICvCoMKgwqDCoMKgwqAgcmV0dXJuIE5NSV9IQU5ETEVEOw0KPj4gfQ0KPj4NCj4+Pj4gQW55d2F5
LCB3ZSBhbHJlYWR5IGhhZCBjb2RlIHRvIGRlYWwgd2l0aCBzcHVyaW91cyBOTUlzIGZyb20gQU1E
OyBzZWUNCj4+Pj4gY29tbWl0Og0KPj4+Pg0KPj4+PiDCoMKgwqAgNjNlNmJlNmQ5OGUxICgicGVy
ZiwgeDg2OiBDYXRjaCBzcHVyaW91cyBpbnRlcnJ1cHRzIGFmdGVyIA0KPj4+PiBkaXNhYmxpbmcg
Y291bnRlcnMiKQ0KPj4+Pg0KPj4+PiBBbmQgdGhhdCBsb29rcyB0byBiZSBkb2luZyBzb21ldGhp
bmcgdmVyeSBtdWNoIHRoZSBzYW1lLiBXaHkgdGhlbiBkbyB5b3UNCj4+Pj4gc3RpbGwgbmVlZCB0
aGlzIG9uIHRvcD8NCj4+Pg0KPj4+IFRoaXMgY2FuIGhhcHBlbiB3aGlsZSBwZXJmIGlzIGhhbmRs
aW5nIG5vcm1hbCBjb3VudGVyIG92ZXJmbG93IGFzIG9wcG9zZWQNCj4+PiB0byBjb3ZlcmluZyB0
aGUgZGlzYWJsaW5nIG9mIHRoZSBjb3VudGVyIGNhc2UuIFdoZW4gbXVsdGlwbGUgY291bnRlcnMN
Cj4+PiBvdmVyZmxvdyBhdCByb3VnaGx5IHRoZSBzYW1lIHRpbWUsIGJ1dCB0aGUgTk1JIGRvZXNu
J3QgYXJyaXZlIGluIHRpbWUgdG8NCj4+PiBnZXQgY29sbGFwc2VkIGludG8gYSBwZW5kaW5nIE5N
SSwgdGhlIGJhY2stdG8tYmFjayBzdXBwb3J0IGluDQo+Pj4gZG9fZGVmYXVsdF9ubWkoKSBkb2Vz
bid0IGtpY2sgaW4uDQo+Pj4NCj4+PiBIbW1tLi4uIEkgd29uZGVyIGlmIHRoZSB3YWl0IG9uIG92
ZXJmbG93IGluIHRoZSBkaXNhYmxlX2FsbCgpIGZ1bmN0aW9uDQo+Pj4gd291bGQgZWxpbWluYXRl
IHRoZSBuZWVkIGZvciA2M2U2YmU2ZDk4ZTEuIFRoYXQgd291bGQgdGFrZSBhIG1vcmUgdGVzdGlu
Zw0KPj4+IG9uIHNvbWUgb2xkZXIgaGFyZHdhcmUgdG8gdmVyaWZ5LiBUaGF0J3Mgc29tZXRoaW5n
IEkgY2FuIGxvb2sgaW50bw0KPj4+IHNlcGFyYXRlIGZyb20gdGhpcyBzZXJpZXMuDQo+Pg0KPj4g
WWVzIHBsZWFzZSwgb3IgYXQgbGVhc3QgYmV0dGVyIGRvY3VtZW50IHRoZSByZWFzb24gZm9yIHRo
ZWlyIHNlcGFyYXRlDQo+PiBleGlzdGVuY2UuIEl0J3MgYWxsIHR1cm5pbmcgaW50byBhIGJpdCBv
ZiBtYWdpYyBpdCBzZWVtcy4NCj4gDQo+IE9rLCBJJ2xsIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3Nh
Z2Ugd2l0aCBhIGJpdCBtb3JlIGluZm8gYW5kIGFkZCB0byB0aGUNCj4gY29tbWVudCBvZiB0aGUg
bmV3IEFNRCBoYW5kbGVfaXJxIGZ1bmN0aW9uLg0KPiANCj4gVGhhbmtzLA0KPiBUb20NCj4gDQo+
Pg0K
