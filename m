Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7DAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447DF20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bfnjg0IR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfDBNJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:09:21 -0400
Received: from mail-eopbgr820048.outbound.protection.outlook.com ([40.107.82.48]:9672
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730133AbfDBNJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDfm9FJB4yJ+Vc5ef1aA6MHEmQ8lkpZmNV3VIwvTgsw=;
 b=bfnjg0IR5ueDVgJ3xAnkR5A+ESpUhNF5qYjmaxgBliKE9iWcmN1axXmpDz2cN9bvyjXubtfSeEscUL93YK06GtSX71H5Wn3UfMTYeqAUYebeBEUOs2cFDpYzw8+Gq+Z3t4+134rjNififswovGJRw9r+ytw0TGFI0I7P9J1f9cE=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2954.namprd12.prod.outlook.com (20.179.104.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Tue, 2 Apr 2019 13:09:17 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b%5]) with mapi id 15.20.1750.014; Tue, 2 Apr 2019
 13:09:17 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        Vince Weaver <vince@deater.net>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH v3 0/3] x86/perf/amd: AMD PMC counters and NMI latency
Thread-Topic: [RFC PATCH v3 0/3] x86/perf/amd: AMD PMC counters and NMI
 latency
Thread-Index: AQHU6NRfaGoIezVhSE2WaOPaqkz+laYo1yUAgAABuQA=
Date:   Tue, 2 Apr 2019 13:09:17 +0000
Message-ID: <fc746a38-89c6-a1c4-8b92-7f228b17d3ba@amd.com>
References: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
 <20190402130302.GL12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190402130302.GL12232@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0067.namprd05.prod.outlook.com
 (2603:10b6:803:41::44) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a40a20f-61da-43dd-3b1f-08d6b76c68fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB2954;
x-ms-traffictypediagnostic: DM6PR12MB2954:
x-microsoft-antispam-prvs: <DM6PR12MB295410DF0AFD39ED6E8F4DD1EC560@DM6PR12MB2954.namprd12.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(366004)(136003)(189003)(199004)(52314003)(478694002)(2906002)(6512007)(81166006)(97736004)(86362001)(105586002)(446003)(11346002)(305945005)(3846002)(26005)(476003)(31696002)(68736007)(6116002)(7736002)(36756003)(106356001)(8936002)(256004)(14444005)(7416002)(76176011)(186003)(53546011)(386003)(31686004)(53936002)(102836004)(6506007)(52116002)(66066001)(486006)(6246003)(316002)(229853002)(8676002)(478600001)(25786009)(4326008)(6916009)(6486002)(81156014)(72206003)(54906003)(99286004)(71200400001)(71190400001)(5660300002)(6436002)(14454004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2954;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pt3l34tsELBQdHd+Obuy5PsAywElVpLJwjAg9xTwgIX/ct1EMrFnEqacjlbfwVJWl/vQqkBCQ5FymZNiLwIWnMAqm0HLAH/9bm5lz1Tk0xoP5TLNVwqiJW40RJmNbyybJvqoO8O+E4SogA47d3YP7sli4GosHU+1av98dQbHuhTqSF7NYanzxko6dKzZngDSCXw8jA1icVjbQNB3XxfhSIxD696hgbLc5MLjSVbqKn0xmD3hNe69V2HlV2CmAbD4zx0cRFAQ8JlSNu+q9bwKoS1Bc2vDt7JNADHsGw2o3acIx79uNRXKQPHKbuI9dOFbUkw8oiAdOEGxDAmSkhthwdn7s5BQSfV6/NEi2R5ywQhe7BU7ofvyJHOMWyF2agRKgIJRI0/aCGXcBxN5dM4CiHtG7PiK8kVmzKTVN7bRnSc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05C6A372E1B7FD47AE3D6916F8C23106@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a40a20f-61da-43dd-3b1f-08d6b76c68fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 13:09:17.2710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yLzE5IDg6MDMgQU0sIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBNb24sIEFwciAw
MSwgMjAxOSBhdCAwOTo0NjozM1BNICswMDAwLCBMZW5kYWNreSwgVGhvbWFzIHdyb3RlOg0KPj4g
VGhpcyBwYXRjaCBzZXJpZXMgYWRkcmVzc2VzIGlzc3VlcyB3aXRoIGluY3JlYXNlZCBOTUkgbGF0
ZW5jeSBpbiBuZXdlcg0KPj4gQU1EIHByb2Nlc3NvcnMgdGhhdCBjYW4gcmVzdWx0IGluIHVua25v
d24gTk1JIG1lc3NhZ2VzIHdoZW4gUE1DIGNvdW50ZXJzDQo+PiBhcmUgYWN0aXZlLg0KPj4NCj4+
IFRoZSBmb2xsb3dpbmcgZml4ZXMgYXJlIGluY2x1ZGVkIGluIHRoaXMgc2VyaWVzOg0KPj4NCj4+
IC0gUmVzb2x2ZSBhIHJhY2UgY29uZGl0aW9uIHdoZW4gZGlzYWJsaW5nIGFuIG92ZXJmbG93ZWQg
UE1DIGNvdW50ZXIsDQo+PiAgICBzcGVjaWZpY2FsbHkgd2hlbiB1cGRhdGluZyB0aGUgUE1DIGNv
dW50ZXIgd2l0aCBhIG5ldyB2YWx1ZS4NCj4+IC0gUmVzb2x2ZSBoYW5kbGluZyBvZiBhY3RpdmUg
UE1DIGNvdW50ZXIgb3ZlcmZsb3dzIGluIHRoZSBwZXJmIE5NSQ0KPj4gICAgaGFuZGxlciBhbmQg
d2hlbiB0byByZXBvcnQgdGhhdCB0aGUgTk1JIGlzIG5vdCByZWxhdGVkIHRvIGEgUE1DLg0KPj4g
LSBSZW1vdmUgZWFybGllciB3b3JrYXJvdW5kIGZvciBzcHVyaW91cyBOTUlzIGJ5IHJlLW9yZGVy
aW5nIHRoZQ0KPj4gICAgUE1DIHN0b3Agc2VxdWVuY2UgdG8gZGlzYWJsZSB0aGUgUE1DIGZpcnN0
IGFuZCB0aGVuIHJlbW92ZSB0aGUgUE1DDQo+PiAgICBiaXQgZnJvbSB0aGUgYWN0aXZlX21hc2sg
Yml0bWFwLiBBcyBwYXJ0IG9mIGRpc2FibGluZyB0aGUgUE1DLCB0aGUNCj4+ICAgIGNvZGUgd2ls
bCB3YWl0IGZvciBhbiBvdmVyZmxvdyB0byBiZSByZXNldC4NCj4+DQo+PiBUaGUgbGFzdCBwYXRj
aCByZS13b3JrcyB0aGUgb3JkZXIgb2Ygd2hlbiB0aGUgUE1DIGlzIHJlbW92ZWQgZnJvbSB0aGUN
Cj4+IGFjdGl2ZV9tYXNrLiBUaGVyZSB3YXMgYSBjb21tZW50IGZyb20gYSBsb25nIHRpbWUgYWdv
IGFib3V0IGhhdmluZw0KPj4gdG8gY2xlYXIgdGhlIGJpdCBpbiBhY3RpdmVfbWFzayBiZWZvcmUg
ZGlzYWJsaW5nIHRoZSBjb3VudGVyIGJlY2F1c2UNCj4+IHRoZSBwZXJmIE5NSSBoYW5kbGVyIGNv
dWxkIHJlLWVuYWJsZSB0aGUgUE1DIGFnYWluLiBMb29raW5nIGF0IHRoZQ0KPj4gaGFuZGxlciB0
b2RheSwgSSBkb24ndCBzZWUgdGhhdCBhcyBwb3NzaWJsZSwgaGVuY2UgdGhlIHJlb3JkZXJpbmcu
IFRoZQ0KPj4gcXVlc3Rpb24gd2lsbCBiZSB3aGV0aGVyIHRoZSBJbnRlbCBQTUMgc3VwcG9ydCB3
aWxsIG5vdyBoYXZlIGlzc3Vlcy4NCj4+IFRoZXJlIGlzIHN0aWxsIHN1cHBvcnQgZm9yIHVzaW5n
IHg4Nl9wbXVfaGFuZGxlX2lycSgpIGluIHRoZSBJbnRlbA0KPj4gY29yZS5jIGZpbGUuIERpZCBJ
bnRlbCBoYXZlIGFueSBpc3N1ZXMgd2l0aCBzcHVyaW91cyBOTUlzIGluIHRoZSBwYXN0Pw0KPj4g
UGV0ZXIgWiwgYW55IHRob3VnaHRzIG9uIHRoaXM/DQo+IA0KPiBJIGNhbid0IHJlbWVtYmVyIDov
IEkgc3VwcG9zZSB3ZSdsbCBzZWUgaWYgYW55dGhpbmcgcG9wcyB1cCBhZnRlciB0aGVzZQ0KPiBo
ZXJlIHBhdGNoZXMuIEF0IGxlYXN0IHRoZW4gd2UgZ2V0IGEgY2hhbmNlIHRvIHByb3Blcmx5IGRv
Y3VtZW50IHRoaW5ncy4NCj4gDQo+PiBBbHNvLCBJIGNvdWxkbid0IGNvbXBsZXRlbHkgZ2V0IHJp
ZCBvZiB0aGUgInJ1bm5pbmciIGJpdCBiZWNhdXNlIGl0DQo+PiBpcyB1c2VkIGJ5IGFyY2gveDg2
L2V2ZW50cy9pbnRlbC9wNC5jLiBBbiBvbGQgY29tbWl0IGNvbW1lbnQgdGhhdA0KPj4gc2VlbXMg
dG8gaW5kaWNhdGUgdGhlIHA0IGNvZGUgc3VmZmVyZWQgdGhlIHNwdXJpb3VzIGludGVycnVwdHM6
DQo+PiAwM2UyMjE5OGQyMzcgKCJwZXJmLCB4ODY6IEhhbmRsZSBpbiBmbGlnaHQgTk1JcyBvbiBQ
NCBwbGF0Zm9ybSIpLg0KPj4gU28gbWF5YmUgdGhhdCBwYXJ0aWFsbHkgYW5zd2VycyBteSBwcmV2
aW91cyBxdWVzdGlvbi4uLg0KPiANCj4gWWVhaCwgdGhlIFA0IGNvZGUgaXMgbWFnaWMsIGFuZCBJ
IGRvbid0IGhhdmUgYW55IHN1Y2ggbWFjaGluZXMgbGVmdCwgbm9yDQo+IGRvIEkgdGhpbmsgZG9l
cyBDeXJpbGwgd2hvIHdyb3RlIG11Y2ggb2YgdGhhdC4NCj4gDQo+IEkgaGF2ZSB2YWd1ZSBtZW1v
cmllcyBvZiB0aGUgUDQgdGhpbmcgY3Jhc2hpbmcgd2l0aCBWaW5jZSdzIHBlcmZfZnV6emVyLA0K
PiBidXQgbWF5YmUgSSdtIHdyb25nLg0KPiANCj4gSWRlYWxseSB3ZSdkIGZpbmQgYSB3aWxsaW5n
IHZpY3RpbSB0byBtYWludGFpbiB0aGF0IHRoaW5nLCBvciBwb3NzaWJseQ0KPiBqdXN0IGRlbGV0
ZSBpdCwgZHVubm8gaWYgYW55Ym9keSBzdGlsbCBjYXJlcy4NCj4gDQo+IA0KPiBBbnl3YXksIEkg
bGlrZSB0aGVzZSBwYXRjaGVzLCBidXQgSSBjYW5ub3QgYXBwbHkgc2luY2UgeW91IHNlbmQgdGhl
bQ0KPiBiYXNlNjQgZW5jb2RlZCBhbmQgbXkgc2NyaXB0IGNob2tlcyBvbiB0aGF0Lg0KDQpIbW1t
LCBJJ20gdXNpbmcgc3RnaXQgYW5kIGl0J3MgZWl0aGVyIHRoYXQgb3Igb3VyIG1haWwgc3lzdGVt
IHRoYXQgaXMNCmNhdXNpbmcgdGhlIGJhc2U2NCBlbmNvZGluZy4gSXQgaGFwcGVuZWQgb25jZSBi
ZWZvcmUsIGxldCBtZSByZS1zZW5kIHVzaW5nDQpzdHJhaWdodCBnaXQuIEknbGwgcmVtb3ZlIHRo
ZSBSRkMgb24gdGhlIHJlLXNlbmQsIHRvby4NCg0KVGhhbmtzLA0KVG9tDQo+IA0K
