Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F361C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0688520833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L0jjDRmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfDHSlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:41:35 -0400
Received: from mail-eopbgr760078.outbound.protection.outlook.com ([40.107.76.78]:57582
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbfDHSlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhwGeUqJGCUnUSpitlHRftEqOGRTfFQTmnrlZmVgst0=;
 b=L0jjDRmgE2VTWMjecYSDwtEy4FEHBj8dDho03mo/nXGPrOrmJ8kxsszgxIGJXFTNvqzFlNn7tScMp1vrmU/H8tuPhThds7at+oad1gl75+YFraakAbS6sk98h1KX9UqvlhsVqaQ5+pB5+jBCQrc4IjTbvABg5pEBDqolXXvzAUI=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.38.138) by
 DM5PR12MB1210.namprd12.prod.outlook.com (10.168.237.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 18:41:31 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::b847:c18d:397a:5ea7]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::b847:c18d:397a:5ea7%5]) with mapi id 15.20.1771.021; Mon, 8 Apr 2019
 18:41:31 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Thread-Topic: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Thread-Index: AQHU6yS/AQVIYa78D0OsnFnDJRviWKYsd26AgAWzsICAAFczgIAAHL8A
Date:   Mon, 8 Apr 2019 18:41:30 +0000
Message-ID: <8a14050e-2516-5c0f-195d-611c6959b94b@amd.com>
References: <155440965936.6194.3202659723198724589.stgit@sosrh7.amd.com>
 <alpine.DEB.2.21.1904042237020.1802@nanos.tec.linutronix.de>
 <5dfcb133-0a0e-9e07-3774-313e30814e79@amd.com>
 <20190408165835.GJ15689@zn.tnic>
In-Reply-To: <20190408165835.GJ15689@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0019.prod.exchangelabs.com (2603:10b6:804:2::29)
 To DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7354661-35e0-45db-de94-08d6bc51d107
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1210;
x-ms-traffictypediagnostic: DM5PR12MB1210:
x-microsoft-antispam-prvs: <DM5PR12MB1210B36DFD11DA2D31A8BFC7FD2C0@DM5PR12MB1210.namprd12.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(189003)(199004)(6512007)(305945005)(6116002)(81166006)(6436002)(5660300002)(81156014)(14454004)(3846002)(66066001)(8676002)(8936002)(7736002)(68736007)(31696002)(36756003)(6486002)(93886005)(2906002)(478600001)(6246003)(229853002)(53546011)(76176011)(14444005)(4326008)(99286004)(486006)(72206003)(256004)(316002)(386003)(2616005)(106356001)(6916009)(102836004)(446003)(52116002)(476003)(6506007)(11346002)(97736004)(31686004)(71190400001)(71200400001)(53936002)(25786009)(105586002)(186003)(26005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1210;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xQ1DyKjISW0o1TFpw7VNz+eNKjQpJfAcnwLbHm1XLpzc3QiDIGz3ZMMnOIkjI0OksdKML6dFtNTqdNIjvNLYjGjTqol/LKAZ2dN55C2odj14o7Izux/8bqWuetFnhOCMEB2TQJGo2s/M8tJH1FAgkOnLheqRgby6+XNnoqHpS8ENawS92JMxJTbkvYPdcez84X7A0kzpd2tz7JMsfgg1YTLdm/Pr1KMAAadF6NnFV1K1rR5La/KF+2OTQ7iAfcwFeqA2MWJymlejY4aInqapGt2SLyQPgUwijuhA7sWKpTAQhFZV4LuRCQ+O3ZJnbvlrQDm1Xkqkx2c8YqOOlGfIiwW+o9wkXwF+/19+O5nRPZgmtppBK12y9Kf1i0AWX3AXmSDtIAKrqYOZbFgRv53+qX/slWmJpozU4NJxYiC7iok=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F800B5340FBCE41AC1A9C5CE33C19CF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7354661-35e0-45db-de94-08d6bc51d107
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 18:41:30.8813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC84LzE5IDExOjU4IEFNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIE1vbiwgQXBy
IDA4LCAyMDE5IGF0IDA0OjQ2OjMxUE0gKzAwMDAsIEdhcnkgUiBIb29rIHdyb3RlOg0KPj4gTXkg
cmVhc29uaW5nIChub3QgYXJndWluZyk6IHRoZSBmaWxlIGhhcyBiZWVuIHRvdWNoZWQgZXhhY3Rs
eSBvbmUgdGltZQ0KPj4gaW4gNCB5ZWFycywgYnkgVGhvbWFzLiBEb2Vzbid0IGFwcGVhciB0byBi
ZSBhIGNhbmRpZGF0ZSBmb3IgY29uc3RhbnQNCj4+IG1vZGlmaWNhdGlvbiwgc28gdGhpcyBhcHBy
b2FjaCBkb2Vzbid0IHNlZW0gcmlza3kgdG8gbWUuIEkgY291bGQgYmUgd3JvbmcuDQo+IA0KPiBU
aGUgcHJvYmxlbSwgbGlrZSB3ZSBkaXNjdXNzZWQgaXQgd2l0aCBUb20gb2ZmbGlzdCwgaXMgdGhh
dCB5b3Ugc2ltcGx5DQo+IGNhbm5vdCB0dXJuIG9mZiBpbnN0cnVtZW50YXRpb24gZm9yIHRob3Nl
IGdlbmVyaWMgZmlsZXMganVzdCBiZWNhdXNlIFNNRQ0KPiBoYXMgdHJvdWJsZSB3aXRoIHRoZW0s
IGFuZCB0aGF0IGxhc3QgdGhpbmcgY2FuIGJlIGFueSB2ZW5kb3Itc3BlY2lmaWMNCj4gZmVhdHVy
ZS4NCg0KQWdhaW4sIG5vdCBhcmd1aW5nLiBJIGNvbXBsZXRlbHkgdW5kZXJzdGFuZC4gSG93ZXZl
ciwgdG8gYmUgZmFpciwgdGhpcyANCmlzbid0IGFib3V0IFNNRSBoYXZpbmcgdHJvdWJsZSB3aXRo
IHRob3NlIGZhY2lsaXRpZXMsIHRoaXMgaXMgYWJvdXQgDQp1c2luZyBjZXJ0YWluIGZlYXR1cmVz
IChlLmcuIGNvbW1hbmQgbGluZSBvcHRpb24gcHJvY2Vzc2luZykgZWFybHkgaW4gDQp0aGUgYm9v
dC4gQW55IGNvbXBsZXggZmVhdHVyZSBjb3VsZCBoYXZlIGhhZCB0aGF0IHJlcXVpcmVtZW50LCBk
b24ndCB5b3UgDQp0aGluaz8NCg0KPiBFdmVuIGlmIHRoZSBmdW5jdGlvbnMgdGhlcmUgYXJlICJ0
cml2aWFsIiBub3cgKGRvZXNuJ3QgbWVhbiBuZXcgc3R1ZmYNCj4gd29uJ3QgYmUgYWRkZWQgdGhl
cmUgaW4gdGhlIGZ1dHVyZSBhbmQgd2UgZm9yZ2V0IGFib3V0IHRoZSBkaXNhYmxlZA0KPiBpbnN0
cnVtZW50YXRpb24gaGVyZS4pDQoNCkFic29sdXRlbHkgYWdyZWUuIFJlY29nbml6aW5nIHRoYXQg
dGhpbmdzIGNhbiBiZSBmb3Jnb3R0ZW4gaGFzIHdlaWdoZWQgDQpoZWF2aWx5IG9uIG1lIGluIGxp
Z2h0IG9mIHRoaXMuIEkgZG9uJ3QgbGlrZSB0aGF0IHBvc3NpYmlsaXR5IGF0IGFsbC4NCg0KPiBX
ZSBzaW1wbHkgY2Fubm90IGNvbnN0cmFpbiBnZW5lcmljIGNvbXBpbGF0aW9uIHVuaXRzIGxpa2Ug
dGhhdC4gU28gdGhlDQo+IGZ1bmN0aW9ucyB0aGVyZSBlaXRoZXIgbmVlZCB0byBiZSBjb3BpZWQg
b3IgaWZkZWZmZWQuIEF0IHRoZSB0aW1lIFNNRQ0KPiB3YXMgZ29pbmcgaW4sIHRoZSBpbnRlbnRp
b24gd2FzIHRvIHJldXNlIGNvZGUgc28gdGhhdCB0aGVyZSBpcyBsZXNzDQo+IGR1cGxpY2F0aW9u
LiBCdXQgaWYgdGhlcmUncyB0cm91YmxlIGRvaW5nIHRoYXQgc2hhcmluZywgdGhlbiB3ZSBuZWVk
IHRvDQo+ICJ1bnNoYXJlIiBpdCBhZ2Fpbi4gT3IgY29tZSB1cCB3aXRoIHNvbWV0aGluZyBlbHNl
IHNsaWNrIGFuZCBjbGVhbi4NCg0KUmlnaHQuIE15IGdvYWwgd2FzIHRvIGdldCBhIGNvbnZlcnNh
dGlvbiBzdGFydGVkLCBiZWNhdXNlIGZvbGtzIGFyZSANCnJ1bm5pbmcgaW50byB0aGlzIHByb2Js
ZW0gd2hlbiBLQVNBTiBpcyBlbmFibGVkLg0KDQpOLkIuIEhlcmUncyBhbm90aGVyIGZhY2V0IG9m
IHRoaXMgcHJvYmxlbTogY21kbGluZS5jIGRvZXNuJ3QgKHRvZGF5KSANCmNvbnRhaW4gYW55dGhp
bmcgdGhhdCB3b3VsZCB0cmlnZ2VyIHRoZSBzdGFjayBwcm90ZWN0b3IuIEhvd2V2ZXIsIGl0J3Mg
DQpwb3NzaWJsZSB0byBlbmFibGUgdGhlIHN0YWNrIHByb3RlY3RvciBnbG9iYWxseSB3aGVuIGJ1
aWxkaW5nLCByaWdodD8gSW4gDQp3aGljaCBjYXNlLCBhIGJvb3Qgd291bGQgZmFpbCwgc28gd2Ug
aGF2ZSB0aGUgc2FtZSBpc3N1ZTogZWFybHkgYm9vdCANCmNvZGUgaGFzIHNwZWNpYWwgcmVxdWly
ZW1lbnRzIC8gcmVzdHJpY3Rpb25zLg0KDQpJJ20gbm90IHN1cmUgd2hhdCB0aGUgInJpZ2h0IiBz
b2x1dGlvbiBpcywgYnV0IEkgYXBwcmVjaWF0ZSB5b3VyIHRpbWUgDQphbmQgZXhwZXJ0aXNlIHRv
IGRpc2N1c3MuIEFuZCBub3cgSSBoYXZlIGFub3RoZXIgaWRlYSBJJ20gZ29pbmcgdG8gZ28gDQp0
cnkgb3V0Lg0KDQpncmgNCg==
