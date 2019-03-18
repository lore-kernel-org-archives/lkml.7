Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC51C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3508020863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c7EHo+5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfCRQUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:20:24 -0400
Received: from mail-eopbgr760054.outbound.protection.outlook.com ([40.107.76.54]:30678
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbfCRQUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfwHR/Ws2oa7MwfBtsC3RRRpWmzCI7me652l+fI2Ieg=;
 b=c7EHo+5BFwq24U/AfFy4I+UPQRIYAeRqVb07FaxHC8M+XhFvAxVa/k35DNFsumNKzHcLpB7zIZ/G0WyYNcb0GcjYLB6a/xSpSuR0eam8t+D1T22SXX/1DpDSKBiHBLfjaYpodB1hsKPEAJBXbKVBoRtIfBPzEemu/lZV4sBVPII=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2650.namprd12.prod.outlook.com (20.176.116.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 16:20:20 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 16:20:20 +0000
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
Subject: Re: [RFC PATCH v2 1/2] x86/perf/amd: Resolve race condition when
 disabling PMC
Thread-Topic: [RFC PATCH v2 1/2] x86/perf/amd: Resolve race condition when
 disabling PMC
Thread-Index: AQHU229hNGOz+xaASEKkiW7L8jN5IKYRJYSAgABwj4A=
Date:   Mon, 18 Mar 2019 16:20:20 +0000
Message-ID: <3d176556-2424-39d1-1923-f0964ebf4e2d@amd.com>
References: <155268244291.14761.3432013617741218607.stgit@tlendack-t1.amdoffice.net>
 <155268245032.14761.7748666703519081877.stgit@tlendack-t1.amdoffice.net>
 <20190318093725.GJ6058@hirez.programming.kicks-ass.net>
In-Reply-To: <20190318093725.GJ6058@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0037.prod.exchangelabs.com (2603:10b6:804:2::47)
 To DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c1160a0-fdd7-4520-0866-08d6abbd9d7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2650;
x-ms-traffictypediagnostic: DM6PR12MB2650:
x-microsoft-antispam-prvs: <DM6PR12MB265032854F5BE7BFF229596FEC470@DM6PR12MB2650.namprd12.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(396003)(346002)(189003)(199004)(4326008)(25786009)(5660300002)(71200400001)(71190400001)(6116002)(3846002)(316002)(36756003)(229853002)(54906003)(6486002)(256004)(486006)(66066001)(2616005)(476003)(11346002)(446003)(6512007)(26005)(7416002)(99286004)(14454004)(2906002)(8676002)(52116002)(53546011)(53936002)(6246003)(6916009)(186003)(76176011)(6506007)(386003)(478600001)(102836004)(305945005)(81166006)(31686004)(81156014)(106356001)(7736002)(8936002)(72206003)(105586002)(6436002)(31696002)(68736007)(86362001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2650;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SVm14FQZZC3NStY2w1lqP5P7UaniCY7x8BN79EcYbGZAMPpXhdLslhm/LJpb+vKLfTlsk9VSZh+IooIUOfwYB9076csPWgdu2pvbfVktxLpmAyQzjGLSqqliMcEh4XM7mqIKEabMzQ88l0O3bmUig5SAjJcwqR2Ltdq9POta8Os2RDCfS44c49wlyku8IXv87LpkCDBK83hRmy6k2V2Ah5gdfqL2kjXvyWVQNb9Hu4ylHe2qCP7l28boUryd+XFQkwbHj3nx+DDvzVHMdSAhTC3H5LyxYV6s1Z6g1pVjdYVqBFiP3J5HF1Dgn78Lb6s1cReHzghag/VUuHivWwW6TL6hSg5bMNrmQSt4+2YEfzmTV70xp6W9pbPxP3vW+6XpeNpLAHqNFQ/TLIN3QsBCXol6n2tRolZK1it7B5B5wBE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76AC3778F04E874696632EDED77BE337@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1160a0-fdd7-4520-0866-08d6abbd9d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 16:20:20.3637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2650
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xOC8xOSA0OjM3IEFNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gRnJpLCBNYXIg
MTUsIDIwMTkgYXQgMDg6NDA6NTNQTSArMDAwMCwgTGVuZGFja3ksIFRob21hcyB3cm90ZToNCj4+
ICt2b2lkIGFtZF9wbXVfZGlzYWJsZV9hbGwodm9pZCkNCj4+ICt7DQo+PiArCXVuc2lnbmVkIGxv
bmcgb3ZlcmZsb3dfY2hlY2tbQklUU19UT19MT05HUyhYODZfUE1DX0lEWF9NQVgpXTsNCj4+ICsJ
c3RydWN0IGNwdV9od19ldmVudHMgKmNwdWMgPSB0aGlzX2NwdV9wdHIoJmNwdV9od19ldmVudHMp
Ow0KPj4gKwlpbnQgaWR4Ow0KPj4gKw0KPj4gKwliaXRtYXBfemVybyhvdmVyZmxvd19jaGVjaywg
WDg2X1BNQ19JRFhfTUFYKTsNCj4+ICsNCj4+ICsJZm9yIChpZHggPSAwOyBpZHggPCB4ODZfcG11
Lm51bV9jb3VudGVyczsgaWR4KyspIHsNCj4+ICsJCXU2NCB2YWw7DQo+PiArDQo+PiArCQlpZiAo
IXRlc3RfYml0KGlkeCwgY3B1Yy0+YWN0aXZlX21hc2spKQ0KPj4gKwkJCWNvbnRpbnVlOw0KPj4g
Kw0KPj4gKwkJcmRtc3JsKHg4Nl9wbXVfY29uZmlnX2FkZHIoaWR4KSwgdmFsKTsNCj4+ICsJCWlm
ICghKHZhbCAmIEFSQ0hfUEVSRk1PTl9FVkVOVFNFTF9FTkFCTEUpKQ0KPj4gKwkJCWNvbnRpbnVl
Ow0KPj4gKw0KPj4gKwkJdmFsICY9IH5BUkNIX1BFUkZNT05fRVZFTlRTRUxfRU5BQkxFOw0KPj4g
KwkJd3Jtc3JsKHg4Nl9wbXVfY29uZmlnX2FkZHIoaWR4KSwgdmFsKTsNCj4+ICsNCj4+ICsJCS8q
DQo+PiArCQkgKiBJZiB0aGUgaW50ZXJydXB0IGlzIGVuYWJsZWQsIHRoaXMgY291bnRlciBtdXN0
IGJlIGNoZWNrZWQNCj4+ICsJCSAqIGZvciBhbiBvdmVyZmxvdyBjb25kaXRpb24gdG8gYXZvaWQg
cG9zc2libHkgY2hhbmdpbmcgdGhlDQo+PiArCQkgKiBjb3VudGVyIHZhbHVlIGJlZm9yZSB0aGUg
Tk1JIGhhbmRsZXIgcnVucy4NCj4+ICsJCSAqLw0KPj4gKwkJaWYgKHZhbCAmIEFSQ0hfUEVSRk1P
Tl9FVkVOVFNFTF9JTlQpDQo+PiArCQkJX19zZXRfYml0KGlkeCwgb3ZlcmZsb3dfY2hlY2spOw0K
Pj4gKwl9DQo+IA0KPiBJIHRoaW5rIHlvdSBjYW4gZGl0Y2ggb3ZlcmZsb3dfY2hlY2sgYW5kIGRp
cmVjdGx5IGNhbGwNCj4geDg2X3BtdV9kaXNhYmxlX2FsbCgpIGhlcmUuDQo+IA0KPj4gKw0KPj4g
KwkvKg0KPj4gKwkgKiBUaGlzIHNob3VsZG4ndCBiZSBjYWxsZWQgZnJvbSBOTUkgY29udGV4dCwg
YnV0IGFkZCBhIHNhZmVndWFyZCBoZXJlDQo+PiArCSAqIHRvIHJldHVybiwgc2luY2UgaWYgd2Un
cmUgaW4gTk1JIGNvbnRleHQgd2UgY2FuJ3Qgd2FpdCBmb3IgYW4gTk1JDQo+PiArCSAqIHRvIHJl
c2V0IGFuIG92ZXJmbG93ZWQgY291bnRlciB2YWx1ZS4NCj4+ICsJICovDQo+PiArCWlmIChpbl9u
bWkoKSkNCj4+ICsJCXJldHVybjsNCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogQ2hlY2sgZWFjaCBj
b3VudGVyIGZvciBvdmVyZmxvdyBhbmQgd2FpdCBmb3IgaXQgdG8gYmUgcmVzZXQgYnkgdGhlDQo+
PiArCSAqIE5NSSBpZiBpdCBoYXMgb3ZlcmZsb3dlZC4NCj4+ICsJICovDQo+PiArCWZvciAoaWR4
ID0gMDsgaWR4IDwgeDg2X3BtdS5udW1fY291bnRlcnM7IGlkeCsrKSB7DQo+PiArCQlpZiAoIXRl
c3RfYml0KGlkeCwgb3ZlcmZsb3dfY2hlY2spKQ0KPiANCj4gQW5kIHNpbXBseSBpdGVyYXRlIGNw
dWMtPmFjdGl2ZV9tYXNrIGFnYWluIGhlcmUuDQo+IA0KPj4gKwkJCWNvbnRpbnVlOw0KPj4gKw0K
Pj4gKwkJYW1kX3BtdV93YWl0X29uX292ZXJmbG93KGlkeCk7DQo+PiArCX0NCj4+ICt9DQo+IA0K
PiBCZWNhdXNlLCBwZXIgeDg2X3BtdV9od19jb25maWcoKSB3ZSBfYWx3YXlzXyBoYXZlIEVWRU5U
U0VMX0lOVCBzZXQsIGV2ZW4NCj4gZm9yICFzYW1wbGluZyBldmVudHMgLS0gc3VjaCB0aGF0IHdl
IGNhbiBkZWFsIHdpdGggb3ZlcmZsb3csIGFuZCB3ZQ0KPiBzaG91bGQgJ2Fsd2F5cycgaGF2ZSBF
VkVOVFNFTF9FTkFCTEUgc2V0IHdoZW4gJ2FjdGl2ZScsIHNlZQ0KPiB4ODZfcG11X2VuYWJsZV9h
bGwoKS4NCg0KVGhhdCB3b3VsZCBtYWtlIGl0IG11Y2ggc2ltcGxlci4gSSB3aWxsIGhhdmUgdG8g
cmVseSBvbiB0aG9zZSBhc3N1bXB0aW9ucywNCnRob3VnaCwgd2hpY2ggSSdtIGZpbmUgd2l0aC4N
Cg0KSSdtIHRyYXZlbGluZyB0aGlzIHdlZWsgc28gaXQgbWlnaHQgYmUgYSBmZXcgZGF5cyBiZWZv
cmUgSSBjYW4gZ2V0IHRoZQ0KbmV4dCB2ZXJzaW9uIG91dC4NCg0KVGhhbmtzLA0KVG9tDQoNCj4g
DQo+IA0K
