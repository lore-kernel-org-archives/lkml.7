Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0C3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9AF20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NS6qaaEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfDPUaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:30:13 -0400
Received: from mail-eopbgr690048.outbound.protection.outlook.com ([40.107.69.48]:7653
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbfDPUaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pElGM2RIOcsvbeU9mPIFXnYMp5HKG5dqCF+hRsn+MKo=;
 b=NS6qaaEoUvkPCSanl/HI1wiFd1mCuthBRBEkOJB2+pr1OvJTT3RhXwB8uoUbV1qKEW/3l1gUr2cmOerFX0BvZ55BbUwrKl6XxDkt98IZSJBBNmdnyfQ3PeknGnpfAU/0OjnkMrpjkh05G+dWu1lH9yzOLZevYxdB+rovhT2hBFg=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3481.namprd12.prod.outlook.com (20.178.199.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 16 Apr 2019 20:30:10 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::9d54:69c5:d057:80de]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::9d54:69c5:d057:80de%3]) with mapi id 15.20.1792.018; Tue, 16 Apr 2019
 20:30:10 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH v2] x86: mm: Do not use set_{pud,pmd}_safe when splitting
 the large page
Thread-Topic: [PATCH v2] x86: mm: Do not use set_{pud,pmd}_safe when splitting
 the large page
Thread-Index: AQHU85tDyVgm7zhkk0iOKwSo2aeXvqY9YQcAgAAEPwCAAdnfgA==
Date:   Tue, 16 Apr 2019 20:30:10 +0000
Message-ID: <bb68f941-c962-ebb9-68b6-905ff2189bb2@amd.com>
References: <20190415145515.13559-1-brijesh.singh@amd.com>
 <1aec4241-09c0-5295-7bb7-235e9a494d2c@intel.com>
 <20190415161404.GL4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190415161404.GL4038@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:805:106::31) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1c09843-c80e-47a3-212f-08d6c2aa5251
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3481;
x-ms-traffictypediagnostic: DM6PR12MB3481:
x-microsoft-antispam-prvs: <DM6PR12MB3481F75E59FBC9826C2D7902E5240@DM6PR12MB3481.namprd12.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(39860400002)(366004)(346002)(54534003)(189003)(199004)(52116002)(102836004)(76176011)(316002)(110136005)(54906003)(53546011)(99286004)(6506007)(386003)(36756003)(53936002)(6512007)(6246003)(68736007)(5660300002)(4326008)(71190400001)(25786009)(71200400001)(476003)(31696002)(446003)(97736004)(81156014)(11346002)(81166006)(8936002)(8676002)(86362001)(486006)(2616005)(186003)(26005)(14444005)(256004)(6436002)(6486002)(14454004)(6116002)(478600001)(31686004)(7416002)(2906002)(305945005)(7736002)(561944003)(3846002)(66066001)(105586002)(106356001)(229853002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3481;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dQLCz7uHfGYC6+v2q/1muOVnare/JvpJt/uZgVgh1peJLF1m5NL40//FlZxutMKg8mNuqnnzfBCFIboYS6saUDE/Jxj3v2fkuddtMPi155dw6GtITX30IbVXvLC6e5dc0WN2wNWAd1moADrsKo+PTtxEYGlfj7ppfakOfdioNwYYc0GfXpEuFxTUot/3KvrBayxojW0RlMyt+hzOkVX1AHJo6FIeOnflZPVJp9mkTo8eKbhv6u4gVaFiKqaDjnab3Ww/Rjp0ZPy3BZCxrPpI2c8gfpDPmwZdQzUbb+FVmjJu8hPXeTenObn+AtZrkisHGUl1BsvpXCZQVEzCHKl3wRqrTW6RPidVUq+9ajuB2j78byphEPL1qhdvAneaE32cPS1reSfMbB/vjUMgY4jJ5SK/PXRXjMAbfrZcmWNoGEc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18092EEC5A2DDF4685752FAA2E7C1B11@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c09843-c80e-47a3-212f-08d6c2aa5251
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 20:30:10.4093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3481
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMTUvMTkgMTE6MTQgQU0sIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBNb24s
IEFwciAxNSwgMjAxOSBhdCAwODo1ODo1MkFNIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4+
IE9uIDQvMTUvMTkgNzo1NSBBTSwgU2luZ2gsIEJyaWplc2ggd3JvdGU6DQo+Pj4gICBzdGF0aWMg
dW5zaWduZWQgbG9uZyBfX21lbWluaXQNCj4+PiAgIHBoeXNfcHRlX2luaXQocHRlX3QgKnB0ZV9w
YWdlLCB1bnNpZ25lZCBsb25nIHBhZGRyLCB1bnNpZ25lZCBsb25nIHBhZGRyX2VuZCwNCj4+PiAt
CSAgICAgIHBncHJvdF90IHByb3QpDQo+Pj4gKwkgICAgICBwZ3Byb3RfdCBwcm90LCBib29sIHNh
ZmUpDQo+Pj4gICB7DQo+Pj4gICAJdW5zaWduZWQgbG9uZyBwYWdlcyA9IDAsIHBhZGRyX25leHQ7
DQo+Pj4gICAJdW5zaWduZWQgbG9uZyBwYWRkcl9sYXN0ID0gcGFkZHJfZW5kOw0KPj4+IEBAIC00
MzIsNyArNDYzLDcgQEAgcGh5c19wdGVfaW5pdChwdGVfdCAqcHRlX3BhZ2UsIHVuc2lnbmVkIGxv
bmcgcGFkZHIsIHVuc2lnbmVkIGxvbmcgcGFkZHJfZW5kLA0KPj4+ICAgCQkJCQkgICAgIEU4MjBf
VFlQRV9SQU0pICYmDQo+Pj4gICAJCQkgICAgIWU4MjBfX21hcHBlZF9hbnkocGFkZHIgJiBQQUdF
X01BU0ssIHBhZGRyX25leHQsDQo+Pj4gICAJCQkJCSAgICAgRTgyMF9UWVBFX1JFU0VSVkVEX0tF
Uk4pKQ0KPj4+IC0JCQkJc2V0X3B0ZV9zYWZlKHB0ZSwgX19wdGUoMCkpOw0KPj4+ICsJCQkJX19z
ZXRfcHRlKHB0ZSwgX19wdGUoMCksIHNhZmUpOw0KPj4+ICAgCQkJY29udGludWU7DQo+Pj4gICAJ
CX0NCj4+DQo+PiBUaGUgY2hhbmdlbG9nIGlzIGdyZWF0LCBidHcuDQo+Pg0KPj4gQnV0LCBJJ20g
bm90IGEgYmlnIGZhbiBvZiBwcm9wYWdhdGluZyB0aGUgJ3NhZmUnIG5vbWVuY2xhdHVyZS4gIENv
dWxkDQo+PiB3ZSwgYXQgbGVhc3QsIGNhbGwgaXQgJ292ZXJ3cml0ZV9zYWZlJyBvciBzb21ldGhp
bmcgaWYgd2UncmUgZ29pbmcgdG8NCj4+IGhhdmUgYSB2YXJpYWJsZSBuYW1lPyAgT3IgZXZlbiwg
J25ld19lbnRyaWVzX29ubHknIG9yIHNvbWV0aGluZyB0aGF0DQo+PiBhY3R1YWxseSBjb252ZXlz
IG1lYW5pbmc/DQo+Pg0KPj4gQmVjYXVzZSwganVzdCByZWFkaW5nIGl0LCBJIGFsd2F5cyB3b25k
ZXIgIndoeSBkbyB3ZSBoYXZlIGFuIHVuc2FmZQ0KPj4gdmFyaWFudCwgdGhhdCdzIHN0dXBpZCIg
ZXZlcnkgdGltZS4gOikNCj4gDQo+IHMvc2FmZS9pbml0LyBvbiB0aGUgd2hvbGUgdGhpbmc/DQo+
IA0KDQpJIHdpbGwgdXBkYXRlIHRoZSB2YXJpYWJsZSBuYW1lIGluIHYzLg0KDQo+IEFuZCBtYXli
ZSBldmVuIGJhY2sgb24gdGhlIGluaXRpYWwgX3NhZmUgZnVuY3Rpb25zPyBCZWNhdXNlIGFsbCBv
ZiB0aGlzDQo+IGlzIGFib3V0IGluaXRpYWxpemluZyBwYWdlLXRhYmxlcywgd2hpY2ggaXMgYSBU
TEIgKnNhZmUqIG9wZXJhdGlvbiBJDQo+IHN1cHBvc2UgOi0pDQo+IA0KDQpTaW5jZSB0aGlzIHBh
cnRpY3VsYXIgcGF0Y2ggbmVlZCB0byBwdWxsZWQgaW50byBzdGFibGUgaGVuY2UgSSBhbQ0KbGVh
bmluZyB0b3dhcmRzIG1ha2luZyB0aGUgX3NhZmUgZnVuY3Rpb24gcmVuYW1lIGFmdGVyIHRoaXMg
cGF0Y2guDQoNCj4+PiArI2RlZmluZSBERUZJTkVfRU5UUlkodHlwZTEsIHR5cGUyLCBzYWZlKQkJ
CVwNCj4+PiArc3RhdGljIGlubGluZSB2b2lkIF9fc2V0XyMjdHlwZTEodHlwZTEjI190ICphcmcx
LAkJXA0KPj4+ICsJCQl0eXBlMiMjX3QgYXJnMiwgYm9vbCBzYWZlKQkJXA0KPj4+ICt7CQkJCQkJ
CQlcDQo+Pj4gKwlpZiAoc2FmZSkJCQkJCQlcDQo+Pj4gKwkJc2V0XyMjdHlwZTEjI19zYWZlKGFy
ZzEsIGFyZzIpOwkJCVwNCj4+PiArCWVsc2UJCQkJCQkJXA0KPj4+ICsJCXNldF8jI3R5cGUxKGFy
ZzEsIGFyZzIpOwkJCVwNCj4+PiArfQ0KPj4NCj4+IFdoaWxlIEkgYXBwcmVjaWF0ZSB0aGUgYnJl
dml0eSB0aGF0IHRoZXNlIG1hY3JvcyBhbGxvdywgSSBkZXRlc3QgdGhlaXINCj4+IGFiaWxpdHkg
dG8gdGh3YXJ0IGNzY29wZSBhbmQgZ3JlcC4gIEkgZ3Vlc3MgaXQncyBqdXN0IG9uZSBmaWxlLCBi
dXQgaXQNCj4+IGRvZXMgbWFrZSBtZSBncnVtYmxlIGEgYml0Lg0KPiANCj4gVGhlcmUgaXMgc2Ny
aXB0cy90YWdzLnNoIHdoZXJlIHlvdSBjYW4gYWRkIHRvIHJlZ2V4X2MgdG8gdGVhY2gNCj4gY3Nj
b3BlL2N0YWdzIGFib3V0IG1hZ2ljIG1hY3Jvcy4NCj4gDQo+PiBBbHNvLCBjYW4gd2UgZG8gYmV0
dGVyIHRoYW4gIl9fIj8gIEFyZW4ndCB0aGVzZSBzcGVjaWZpYyB0bw0KPj4gaW5pdGlhbGl6YXRp
b24sIGFuZCBvbmx5IGZvciB0aGUga2VybmVsPyAgTWF5YmUgd2Ugc2hvdWxkIGNhbGwgdGhlbQ0K
Pj4gbWVtaW5pdF9zZXRfcHRlKCkgb3Iga2Vybl9zZXRfcHRlKCkgb3Igc29tZXRoaW5nIHNvIG1h
a2UgaXQgdG90YWxseQ0KPj4gY2xlYXIgdG8gdGhlIHJlYWRlciB0aGF0IHRoZXkncmUgbmV3Lg0K
PiANCj4gc2V0XypfaW5pdCgpIGFuZCBzZXRfKigpIEkgc3VwcG9zZS4NCj4gDQoNCldpbGwgZG8N
Cg0KPj4NCj4+PiAtCQlrZXJuZWxfcGh5c2ljYWxfbWFwcGluZ19pbml0KF9fcGEodmFkZHIgJiBw
bWFzayksDQo+Pj4gLQkJCQkJICAgICBfX3BhKCh2YWRkcl9lbmQgJiBwbWFzaykgKyBwc2l6ZSks
DQo+Pj4gLQkJCQkJICAgICBzcGxpdF9wYWdlX3NpemVfbWFzayk7DQo+Pj4gKwkJa2VybmVsX3Bo
eXNpY2FsX21hcHBpbmdfY2hhbmdlKF9fcGEodmFkZHIgJiBwbWFzayksDQo+Pj4gKwkJCQkJICAg
ICAgIF9fcGEoKHZhZGRyX2VuZCAmIHBtYXNrKSArIHBzaXplKSwNCj4+PiArCQkJCQkgICAgICAg
c3BsaXRfcGFnZV9zaXplX21hc2spOw0KPj4NCj4+IEJUVywgdGhpcyBodW5rIGlzIHJlYWxseSBu
aWNlIHRoZSB3YXkgdGhhdCB0aGUgbmV3IG5hbWluZyBtYWtlcyBpdCBtb3JlDQo+PiBpbnR1aXRp
dmUgd2hhdCdzIGdvaW5nIG9uLiAgTXkgb25seSBuaXQgdzl1bGQgYmUgdGhhdCB3ZSBub3cgaGF2
ZSB0d28NCj4+IHZlcnkgc2ltaWxhcmx5LW5hbWVkIGZ1bmN0aW9ucyB3aXRoIGRpZmZlcmVudCBU
TEItZmx1c2hpbmcgcmVxdWlyZW1lbnRzLg0KPj4NCj4+IENvdWxkIHdlIHBsZWFzZSBpbmNsdWRl
IGEgY29tbWVudCBhdCB0aGlzIHNpdGUgdGhhdCByZW1pbmRzIHVzIHRoYXQgd2UNCj4+IG93ZSBh
IFRMQiBmbHVzaCBhZnRlciB0aGlzPw0KPiANCj4gUmlnaHQsIGEgY29tbWVudCB3b3VsZCBiZSBn
b29kLiBJIHRoaW5rIG15IGluaXRpYWwgcHJvcG9zYWwgaGFkIHRoZSBUTEINCj4gZmx1c2hpbmcg
aW5zaWRlLCBidXQgSSBzZWUgdGhlIHVzYWdlIGlzIGluIGEgbG9vcCwgc28gSSBhcHByZWNpYXRl
IHRoZQ0KPiBkZXNpcmUgdG8ga2VlcCB0aGUgVExCIGZsdXNoaW5nIG91dHNpZGUuDQo+IA0KDQpJ
J3ZlIGFkZCBjb21tZW50IGluIGtlcm5lbF9waHlzaWNhbF9tYXBwaW5nX2NoYW5nZSgpIGRlZmlu
aXRpb24uIEkgd2lsbA0KYWRkIHNvbWV0aGluZyBhbG9uZyB0aGF0IGxpbmUgaGVyZSBhcyB3ZWxs
Lg0KDQp0aGFua3MNCg==
