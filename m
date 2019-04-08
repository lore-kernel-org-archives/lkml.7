Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99BAC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0F320880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YHYL0Jvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfDHQqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:46:38 -0400
Received: from mail-eopbgr700050.outbound.protection.outlook.com ([40.107.70.50]:39040
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbfDHQqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6Kt/m7S8S7DhP8G3asfPNIM1z3Pii7byo93KP3JdyU=;
 b=YHYL0JvgY99JGFGanweQrpDcm4S9sGAqafWAmog1+ERR1SOFvuFJ2QCPuvN0fXl6BGAlAxdekfo+YERVHZgavui2jfS+WWbYy/J/hx41qa8y2NUrdQCvKU6s5KuxgJIh2o/lnxEDBSkVjBJy+teKc3mnPQ2F1kT40gOcwLlFgYU=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.38.138) by
 DM5PR12MB1177.namprd12.prod.outlook.com (10.168.236.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Mon, 8 Apr 2019 16:46:32 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::b847:c18d:397a:5ea7]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::b847:c18d:397a:5ea7%5]) with mapi id 15.20.1771.021; Mon, 8 Apr 2019
 16:46:32 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Hook, Gary" <Gary.Hook@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Thread-Topic: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Thread-Index: AQHU6yS/AQVIYa78D0OsnFnDJRviWKYsd26AgAYHgoA=
Date:   Mon, 8 Apr 2019 16:46:31 +0000
Message-ID: <5dfcb133-0a0e-9e07-3774-313e30814e79@amd.com>
References: <155440965936.6194.3202659723198724589.stgit@sosrh7.amd.com>
 <alpine.DEB.2.21.1904042237020.1802@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904042237020.1802@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR01CA0008.prod.exchangelabs.com (2603:10b6:805:b6::21)
 To DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 995c0a5c-453f-4a8d-ea54-08d6bc41c0f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1177;
x-ms-traffictypediagnostic: DM5PR12MB1177:
x-microsoft-antispam-prvs: <DM5PR12MB1177C8C0F14490264A7C0CE8FD2C0@DM5PR12MB1177.namprd12.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(55674003)(54906003)(14444005)(6246003)(478600001)(14454004)(52116002)(31696002)(76176011)(99286004)(4326008)(71190400001)(36756003)(446003)(66066001)(97736004)(11346002)(2616005)(106356001)(105586002)(71200400001)(256004)(26005)(486006)(476003)(25786009)(110136005)(6436002)(316002)(68736007)(6486002)(6116002)(7736002)(305945005)(229853002)(3846002)(31686004)(53936002)(81156014)(386003)(6506007)(6636002)(102836004)(6512007)(186003)(8936002)(5660300002)(72206003)(2906002)(8676002)(53546011)(81166006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1177;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IBkTd31Z87AJPsDNxnAp7rraZLjPItjOlr9Uo50juLHlSk448ZjYDpLYHT8xzAXMn1i0+BtIUkdObg/2WS1QV1zRBSGkGe38+HwKh9X//6avB5zi04yhDxzuFkfwaSM7Ip8B/34gSO8DbzTLc57mvI1AY0JaOFFDMSbmyOGd09hyoZ/0DkSfYpmO2qRtBkFb9kFm/dkAF97F8AlH+yBCmA+l3lBJAv2WmSdI0z59yi8zhWxAe66vfnY1bi56qgZGsWHjMyTJEWZWeKrA/RbtdONsZZPNrjVK/+9UdMh1VC6NOz29KynpH5j1KlcVuDtZ0+ZpPaXuNYtkTEjAOsYv9xA/r4/lHJFE0XE6uneW7a/U1VEw08HkOGrFJRR0xpEyPpqFcjE8HhPxrHZqWDwRCpCAXeyPCuA6r6KYpSHRIPU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <494D6F2F1375174CBFE2606299415E62@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995c0a5c-453f-4a8d-ea54-08d6bc41c0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 16:46:31.9462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC80LzE5IDM6NDIgUE0sIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gT24gVGh1LCA0IEFw
ciAyMDE5LCBIb29rLCBHYXJ5IHdyb3RlOg0KPiANCj4+IEVuYWJsZW1lbnQgb2YgQU1EJ3MgU2Vj
dXJlIE1lbW9yeSBFbmNyeXB0aW9uIGZlYXR1cmUgaXMgZGV0ZXJtaW5lZA0KPj4gdmVyeSBlYXJs
eSBpbiB0aGUgYm9vdCBjeWNsZS4gUGFydCBvZiB0aGlzIHByb2NlZHVyZSBpbnZvbHZlcyBzY2Fu
bmluZw0KPj4gdGhlIGNvbW1hbmQgbGluZSBmb3IgdGhlIHBhcmFtYXRlciAnbWVtX2VuY3J5cHQn
Lg0KPj4NCj4+IFRvIGRldGVybWluZSBpbnRlbmRlZCBzdGF0ZSwgdGhlIGZ1bmN0aW9uIHNtZV9l
bmFibGUoKSB1c2VzIGxpYnJhcnkNCj4+IGZ1bmN0aW9ucyBjbWRsaW5lX2ZpbmRfb3B0aW9uKCkg
YW5kIHN0cm5jbXAoKS4gIFRoZWlyIHVzZSBvY2N1cnMgZWFybHkNCj4+IGVub3VnaCBzdWNoIHRo
YXQgd2UgY2FuJ3QgYXNzdW1lIHRoYXQgYW55IGluc3RydW1lbnRhdGlvbiBzdWJzeXN0ZW0gaXMN
Cj4+IGluaXRpYWxpemVkLiBGb3IgZXhhbXBsZSwgbWFraW5nIGNhbGxzIHRvIGEgS0FTQU4taW5z
dHJ1bWVudGVkDQo+PiBmdW5jdGlvbiBiZWZvcmUgS0FTQU4gaXMgc2V0IHVwIHdpbGwgbGlrZWx5
IHJlc3VsdCBpbiB0aGUgdXNlIG9mDQo+PiB1bmluaXRpYWxpemVkIG1lbW9yeSBhbmQgYSBib290
IGZhaWx1cmUuDQo+Pg0KPj4gQXZvaWQgaW5zdHJ1bWVudGluZyB0aGVzZSBkZXBlbmRlbnQgZnVu
Y3Rpb25zIGJ5Og0KPj4NCj4+IDEpIE1ha2luZyBhIGxvY2FsLCBzdGF0aWMsIHJlbmFtZWQgY29w
eSBvZiBzdHJuY3B5KCkgZm9yIHVzZSBzb2xlbHkgaW4NCj4+IG1lbV9lbmNyeXB0X2lkZW50aXR5
LmMuIEluIHRoaXMgZmlsZSB3ZSBhcmUgYWJsZSB0byB2ZXQgaXRzIGZldyB1c2VzDQo+PiBhbmQg
YXZvaWQgZXhwb3NpbmcgdGhlIHJlc3Qgb2YgdGhlIGtlcm5lbCB0byBhIHViaXF1aXRvdXNseSB1
c2VkIGJ1dA0KPj4gdW4taW5zdHJ1bWVudGVkIGZ1bmN0aW9uLg0KPj4NCj4+IDIpIERpc2FibGUg
aW5zdHJ1bWVudGlvbiBvZiBhcmNoL3g4Ni9saWIvY21kbGluZS5jIGJhc2VkIG9uIHRoZQ0KPj4g
YXNzdW1wdGlvbiB0aGF0IHRoZSBuZWVkZWQgZnVuY3Rpb24gKGNtZGxpbmVfZmluZF9vcHRpb24o
KSkgaXMgdmV0dGVkDQo+PiB0aHJvdWdoIGl0cyB1c2UgdG8gZGF0ZSwgYW5kIGNvbnRhaW5zIG5v
IGx1cmtpbmcgZmxhd3MgdGhhdCBoYXZlIG5vdA0KPj4geWV0IGJlZW4gZm91bmQgdGhyb3VnaCBp
bnN0cnVtZW50YXRpb24gc3VjaCBhcyBLQVNBTi4NCj4gDQo+IE5vdCBoYXBweSBhYm91dCB0aGF0
IDopDQoNCk15IHJlYXNvbmluZyAobm90IGFyZ3VpbmcpOiB0aGUgZmlsZSBoYXMgYmVlbiB0b3Vj
aGVkIGV4YWN0bHkgb25lIHRpbWUgDQppbiA0IHllYXJzLCBieSBUaG9tYXMuIERvZXNuJ3QgYXBw
ZWFyIHRvIGJlIGEgY2FuZGlkYXRlIGZvciBjb25zdGFudCANCm1vZGlmaWNhdGlvbiwgc28gdGhp
cyBhcHByb2FjaCBkb2Vzbid0IHNlZW0gcmlza3kgdG8gbWUuIEkgY291bGQgYmUgd3JvbmcuDQoN
Cj4+ICsjIFNNRSBlYXJseSBib290IGNvZGUgY2hlY2tzIHRoZSBjbWRsaW5lLCBzbyBkb24ndCBp
bnN0cnVtZW50DQo+PiArS0NPVl9JTlNUUlVNRU5UX2NtZGxpbmUubyAgICAgICAgICAgICAgOj0g
bg0KPj4gKw0KPj4gK0tBU0FOX1NBTklUSVpFX2NtZGxpbmUubyAgICAgICAgICAgICAgIDo9IG4N
Cj4gDQo+IElmIHdlIGNhbid0IGNvbWUgdXAgd2l0aCBhIGJldHRlciBzb2x1dGlvbiB0aGVuIHRo
aXMgbmVlZHMgdG8gZGVwZW5kIG9uDQo+IENPTkZJR19NRU1fRU5DUllQVCBzbyB3ZSBzdGlsbCBj
YW4gcnVuIEtBU0FOIG9uIGNtZGxpbmUuYyB0byBjYXRjaCBjcmFwDQo+IHdoZW4gdGhlIGNvZGUg
aXMgbW9kaWZpZWQgaW4gdGhlIGZ1dHVyZS4NCg0KV2UgaGF2ZSBjb25zaWRlcmVkIHRoaXMgcHJv
YmxlbSwgYW5kIHNlZSBubyBhbHRlcm5hdGl2ZSBzb2x1dGlvbi4gQnV0IEkgDQp3b3VsZCBsb3Zl
IHRvIGNvbWUgdXAgd2l0aCBvbmUuDQoNCkluIHRoZSBtZWFudGltZSwgSSd2ZSBhbHJlYWR5IGNy
ZWF0ZWQgYSB2MiBwYXRjaCB0aGF0IGZ1bGZpbGxzIHlvdXIgDQpyZXF1ZXN0LiBJJ2xsIHdhaXQg
YSBmZXcgbW9yZSBkYXlzIGZvciBjb21tZW50cyBiZWZvcmUgcG9zdGluZy4NCg==
