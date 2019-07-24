Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E162C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BB82173B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UP5AkOUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfGXStQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:49:16 -0400
Received: from mail-eopbgr770055.outbound.protection.outlook.com ([40.107.77.55]:43937
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725883AbfGXStP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:49:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqKLeaWBBH4k/rrYHn0mc6aPeEkv2fZ9AlZnpDm4zZ+lPTPA0T+TGRNJM4P2IqTkV5EHvpPD+yIuyP4HPi+SlgJkezB38AF9v8hdga6HajBLdqJkdoyuBx5F1MWfCOsDCp4l3/k8iWf8r5P3JdVk8BA7HnmR9uneWC3HZBEtYaZqcpUk3bOMrGQHdnqOLnIDc2VIaeECX2+kEjHpmBQc3nFRRI7aiq0XeFC6t1MkeBAJ4pzEQJEFmnbnACtp6k6IAr/YsX7sAMcktG1K04xmhuBWhPqO2HdLX4KOqzqgWhEiPJii+hkRJZEY+rfjOf0VI/QIdtH0elUfKmv+/WBOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grrlUXCjNXwy9On16Bs8VdVEGT/QhAX2Tyx7xJc6iLw=;
 b=PA2GTgjot0SVX3Uysf5o1xYLtlbNfSu1gBxgd9KFBUG9t3LXtyDnJqHCc8Q/TDxzjoQ265XD4ExuIHQ6hjYYP/0LQtjrBIwmH2vUV7MEEvynzleT5rhOU3EyKZ3oSORoazPAEr9jr5Yl9QP00M755PAUwvKrAXCwJUS5beG1PkE5d4JovotwPwPxfXXAkBmdA38Ck53m0uVniiVRvD2b6VBmm7oAos0U5myzvfltLXXEA3lbiHn04bFnNiTnie5r8COnIMfhNTClKlv+elyyfvoMY096BcQypHmiKyd5NHibvz9ZoAgFZxW7w/v4hPJP8m8kR7Jcrw//75j8xSbJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grrlUXCjNXwy9On16Bs8VdVEGT/QhAX2Tyx7xJc6iLw=;
 b=UP5AkOUHL2Vm55y9csprOq7/jij1C0b/1U7CuyO8T6Tj82ERo1mlA3lcAeTD5cbuqLVPGu2tm6Ap+1taDGOrHyG71XC8i0gWX58BDngR8EZoN7JwQNkHjGCTTnR7/jqYE1pCojwaHPsGE+J8q4VK8qHx8cKNmgnGAnhe9oHZvwE=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2603.namprd12.prod.outlook.com (20.176.116.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 24 Jul 2019 18:49:10 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2094.013; Wed, 24 Jul 2019
 18:49:10 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
 DMA masks
Thread-Topic: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
 DMA masks
Thread-Index: AQHVN1HbhkVejMp04kW0O/tJG/K57qbaAcwAgAANJYCAAAaagIAAB+IAgAAKaYD//7FlgIAAVpiAgAACe4A=
Date:   Wed, 24 Jul 2019 18:49:09 +0000
Message-ID: <f889017d-4bd9-8fa2-bbcb-1f836730fbcc@amd.com>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
 <20190724155530.hlingpcirjcf2ljg@box>
 <acee0a74-77fc-9c81-087b-ce55abf87bd4@amd.com>
 <a89e7574-096d-9105-45ff-34bbb74918a5@arm.com>
 <c4110c6b-686c-7e77-fedc-33782e5b3e50@amd.com>
 <20190724181139.yebja5yflzjgfxlx@box>
 <9f9bfd05-0010-9050-20f0-8c89b2f039ef@amd.com>
 <20190724184015.ye6gjoikowiyh63f@box>
In-Reply-To: <20190724184015.ye6gjoikowiyh63f@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0044.namprd02.prod.outlook.com
 (2603:10b6:803:2e::30) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9f1f122-609f-41a9-f5a9-08d710679cef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2603;
x-ms-traffictypediagnostic: DM6PR12MB2603:
x-microsoft-antispam-prvs: <DM6PR12MB26038CBAB368419C107C9120ECC60@DM6PR12MB2603.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(189003)(199004)(486006)(81166006)(66556008)(64756008)(11346002)(2616005)(6512007)(476003)(446003)(66946007)(66476007)(7736002)(66446008)(7416002)(6246003)(54906003)(102836004)(26005)(8676002)(305945005)(31696002)(2906002)(256004)(6506007)(86362001)(71200400001)(386003)(53546011)(68736007)(229853002)(99286004)(186003)(478600001)(71190400001)(76176011)(66066001)(36756003)(4326008)(6436002)(31686004)(52116002)(8936002)(53936002)(25786009)(6486002)(5660300002)(3846002)(6116002)(81156014)(14454004)(316002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2603;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yns1LfAahoBe1dv/IAdkPYXVEGJEm5Cj/LQIVMfLhGLUG+GQg126B8a80kQmy/rkQ2plV5Kfm3lzWi4nCouH6jZwGPP2GdCk54fLxP66v4L7Slxl4gbP0qXXrrG8PeFNVZNXIhfUchpJew2IKD37HnHOzObD9+29c2GXlGBquqJTX3yfzc7syUwxbhiCBvbxQSDOcyApsPq/+8dtcrzKvRX1bC2gOjx7Dc+vJlDI2qodhdvn7F3PyHhH2Ft4T53aAcdyWn2uv+JlNlKNKF9Yg6kt8RqI96Kon9Wha76Exe5bLbKP7J+lKb7hZraCN8ecTiDBOXET6aWl4+zoJ9B9Xn8pXyOJLY1xq/I5DY8evq3ALedNhydHJbMPuJ8Y0ZVBy9T7ORTJvLA285B8P5aqbdul5Yp3g445dN2d0jLgkNQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D5CE35306A1774E847CC23EDA6DF7C3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f1f122-609f-41a9-f5a9-08d710679cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 18:49:09.9570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yNC8xOSAxOjQwIFBNLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+IE9uIFdlZCwg
SnVsIDI0LCAyMDE5IGF0IDA2OjMwOjIxUE0gKzAwMDAsIExlbmRhY2t5LCBUaG9tYXMgd3JvdGU6
DQo+PiBPbiA3LzI0LzE5IDE6MTEgUE0sIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4+PiBP
biBXZWQsIEp1bCAyNCwgMjAxOSBhdCAwNTozNDoyNlBNICswMDAwLCBMZW5kYWNreSwgVGhvbWFz
IHdyb3RlOg0KPj4+PiBPbiA3LzI0LzE5IDEyOjA2IFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
Pj4+PiBPbiAyNC8wNy8yMDE5IDE3OjQyLCBMZW5kYWNreSwgVGhvbWFzIHdyb3RlOg0KPj4+Pj4+
IE9uIDcvMjQvMTkgMTA6NTUgQU0sIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4+Pj4+Pj4g
T24gV2VkLCBKdWwgMTAsIDIwMTkgYXQgMDc6MDE6MTlQTSArMDAwMCwgTGVuZGFja3ksIFRob21h
cyB3cm90ZToNCj4+Pj4+Pj4+IEBAIC0zNTEsNiArMzU1LDMyIEBAIGJvb2wgc2V2X2FjdGl2ZSh2
b2lkKQ0KPj4+Pj4+Pj4gwqAgfQ0KPj4+Pj4+Pj4gwqAgRVhQT1JUX1NZTUJPTChzZXZfYWN0aXZl
KTsNCj4+Pj4+Pj4+IMKgICsvKiBPdmVycmlkZSBmb3IgRE1BIGRpcmVjdCBhbGxvY2F0aW9uIGNo
ZWNrIC0NCj4+Pj4+Pj4+IEFSQ0hfSEFTX0ZPUkNFX0RNQV9VTkVOQ1JZUFRFRCAqLw0KPj4+Pj4+
Pj4gK2Jvb2wgZm9yY2VfZG1hX3VuZW5jcnlwdGVkKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+Pj4+
Pj4+ICt7DQo+Pj4+Pj4+PiArwqDCoMKgIC8qDQo+Pj4+Pj4+PiArwqDCoMKgwqAgKiBGb3IgU0VW
LCBhbGwgRE1BIG11c3QgYmUgdG8gdW5lbmNyeXB0ZWQgYWRkcmVzc2VzLg0KPj4+Pj4+Pj4gK8Kg
wqDCoMKgICovDQo+Pj4+Pj4+PiArwqDCoMKgIGlmIChzZXZfYWN0aXZlKCkpDQo+Pj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7DQo+Pj4+Pj4+PiArDQo+Pj4+Pj4+PiArwqDCoMKg
IC8qDQo+Pj4+Pj4+PiArwqDCoMKgwqAgKiBGb3IgU01FLCBhbGwgRE1BIG11c3QgYmUgdG8gdW5l
bmNyeXB0ZWQgYWRkcmVzc2VzIGlmIHRoZQ0KPj4+Pj4+Pj4gK8KgwqDCoMKgICogZGV2aWNlIGRv
ZXMgbm90IHN1cHBvcnQgRE1BIHRvIGFkZHJlc3NlcyB0aGF0IGluY2x1ZGUgdGhlDQo+Pj4+Pj4+
PiArwqDCoMKgwqAgKiBlbmNyeXB0aW9uIG1hc2suDQo+Pj4+Pj4+PiArwqDCoMKgwqAgKi8NCj4+
Pj4+Pj4+ICvCoMKgwqAgaWYgKHNtZV9hY3RpdmUoKSkgew0KPj4+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIHU2NCBkbWFfZW5jX21hc2sgPSBETUFfQklUX01BU0soX19mZnM2NChzbWVfbWVfbWFzaykp
Ow0KPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHU2NCBkbWFfZGV2X21hc2sgPSBtaW5fbm90X3pl
cm8oZGV2LT5jb2hlcmVudF9kbWFfbWFzaywNCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldi0+YnVzX2RtYV9tYXNrKTsNCj4+Pj4+Pj4+
ICsNCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZG1hX2Rldl9tYXNrIDw9IGRtYV9lbmNf
bWFzaykNCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPj4+
Pj4+Pg0KPj4+Pj4+PiBIbS4gV2hhdCBpcyB3cm9uZyB3aXRoIHRoZSBkZXYgbWFzayBiZWluZyBl
cXVhbCB0byBlbmMgbWFzaz8gSUlVQywgaXQNCj4+Pj4+Pj4gbWVhbnMgdGhhdCBkZXZpY2UgbWFz
ayBpcyB3aWRlIGVub3VnaCB0byBjb3ZlciBlbmNyeXB0aW9uIGJpdCwgZG9lc24ndCBpdD8NCj4+
Pj4+Pg0KPj4+Pj4+IE5vdCByZWFsbHkuLi7CoCBpdCdzIHRoZSB3YXkgRE1BX0JJVF9NQVNLIHdv
cmtzIHZzIGJpdCBudW1iZXJpbmcuIExldCdzIHNheQ0KPj4+Pj4+IHRoYXQgc21lX21lX21hc2sg
aGFzIGJpdCA0NyBzZXQuIF9fZmZzNjQgcmV0dXJucyA0NyBhbmQgRE1BX0JJVF9NQVNLKDQ3KQ0K
Pj4+Pj4+IHdpbGwgZ2VuZXJhdGUgYSBtYXNrIHdpdGhvdXQgYml0IDQ3IHNldCAoMHg3ZmZmZmZm
ZmZmZmYpLiBTbyB0aGUgY2hlY2sNCj4+Pj4+PiB3aWxsIGNhdGNoIGFueXRoaW5nIHRoYXQgZG9l
cyBub3Qgc3VwcG9ydCBhdCBsZWFzdCA0OC1iaXQgRE1BLg0KPj4+Pj4NCj4+Pj4+IENvdWxkbid0
IHRoYXQgYmUgZXhwcmVzc2VkIGFzIGp1c3Q6DQo+Pj4+Pg0KPj4+Pj4gwqDCoMKgwqBpZiAoc21l
X21lX21hc2sgJiBkbWFfZGV2X21hc2sgPT0gc21lX21lX21hc2spDQo+Pj4+DQo+Pj4+IEFjdHVh
bGx5ICE9LCBidXQgeWVzLCBpdCBjb3VsZCBoYXZlIGJlZW4gZG9uZSBsaWtlIHRoYXQsIEkganVz
dCBkaWRuJ3QNCj4+Pj4gdGhpbmsgb2YgaXQuDQo+Pj4NCj4+PiBJJ20gbG9va2luZyBpbnRvIGdl
bmVyYWxpemluZyB0aGUgY2hlY2sgdG8gY292ZXIgTUtUTUUuDQo+Pj4NCj4+PiBMZWF2aW5nCW9m
ZiB0aGUgS2NvbmZpZyBjaGFuZ2VzIGFuZCBtb3ZpbmcgdGhlIGNoZWNrIHRvIG90aGVyIGZpbGUs
IGRvZXN0DQo+Pj4gdGhlIGNoYW5nZSBiZWxvdyBsb29rIHJlYXNvbmFibGUgdG8geW91LiBJdCdz
IG9ubHkgYnVpbGQgdGVzdGVkIHNvIGZhci4NCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9tbS9tZW1fZW5jcnlwdC5jIGIvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHQuYw0KPj4+IGluZGV4
IGZlY2UzMGNhOGIwYy4uNmM4NmFkY2QwMmRhIDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gveDg2L21t
L21lbV9lbmNyeXB0LmMNCj4+PiArKysgYi9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdC5jDQo+Pj4g
QEAgLTM1NSw2ICszNTUsOCBAQCBFWFBPUlRfU1lNQk9MKHNldl9hY3RpdmUpOw0KPj4+ICAvKiBP
dmVycmlkZSBmb3IgRE1BIGRpcmVjdCBhbGxvY2F0aW9uIGNoZWNrIC0gQVJDSF9IQVNfRk9SQ0Vf
RE1BX1VORU5DUllQVEVEICovDQo+Pj4gIGJvb2wgZm9yY2VfZG1hX3VuZW5jcnlwdGVkKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4+PiAgew0KPj4+ICsJdTY0IGRtYV9lbmNfbWFzazsNCj4+PiArDQo+
Pj4gIAkvKg0KPj4+ICAJICogRm9yIFNFViwgYWxsIERNQSBtdXN0IGJlIHRvIHVuZW5jcnlwdGVk
IGFkZHJlc3Nlcy4NCj4+PiAgCSAqLw0KPj4+IEBAIC0zNjIsMTggKzM2NCwyMCBAQCBib29sIGZv
cmNlX2RtYV91bmVuY3J5cHRlZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+Pj4gIAkJcmV0dXJuIHRy
dWU7DQo+Pj4gIA0KPj4+ICAJLyoNCj4+PiAtCSAqIEZvciBTTUUsIGFsbCBETUEgbXVzdCBiZSB0
byB1bmVuY3J5cHRlZCBhZGRyZXNzZXMgaWYgdGhlDQo+Pj4gLQkgKiBkZXZpY2UgZG9lcyBub3Qg
c3VwcG9ydCBETUEgdG8gYWRkcmVzc2VzIHRoYXQgaW5jbHVkZSB0aGUNCj4+PiAtCSAqIGVuY3J5
cHRpb24gbWFzay4NCj4+PiArCSAqIEZvciBTTUUgYW5kIE1LVE1FLCBhbGwgRE1BIG11c3QgYmUg
dG8gdW5lbmNyeXB0ZWQgYWRkcmVzc2VzIGlmIHRoZQ0KPj4+ICsJICogZGV2aWNlIGRvZXMgbm90
IHN1cHBvcnQgRE1BIHRvIGFkZHJlc3NlcyB0aGF0IGluY2x1ZGUgdGhlIGVuY3J5cHRpb24NCj4+
PiArCSAqIG1hc2suDQo+Pj4gIAkgKi8NCj4+PiAtCWlmIChzbWVfYWN0aXZlKCkpIHsNCj4+PiAt
CQl1NjQgZG1hX2VuY19tYXNrID0gRE1BX0JJVF9NQVNLKF9fZmZzNjQoc21lX21lX21hc2spKTsN
Cj4+PiAtCQl1NjQgZG1hX2Rldl9tYXNrID0gbWluX25vdF96ZXJvKGRldi0+Y29oZXJlbnRfZG1h
X21hc2ssDQo+Pj4gLQkJCQkJCWRldi0+YnVzX2RtYV9tYXNrKTsNCj4+PiArCWlmICghc21lX2Fj
dGl2ZSgpICYmICFta3RtZV9lbmFibGVkKCkpDQo+Pj4gKwkJcmV0dXJuIGZhbHNlOw0KPj4+ICAN
Cj4+PiAtCQlpZiAoZG1hX2Rldl9tYXNrIDw9IGRtYV9lbmNfbWFzaykNCj4+PiAtCQkJcmV0dXJu
IHRydWU7DQo+Pj4gLQl9DQo+Pj4gKwlkbWFfZW5jX21hc2sgPSBzbWVfbWVfbWFzayB8IG1rdG1l
X2tleWlkX21hc2soKTsNCj4+PiArDQo+Pj4gKwlpZiAoZGV2LT5jb2hlcmVudF9kbWFfbWFzayAm
JiAoZGV2LT5jb2hlcmVudF9kbWFfbWFzayAmIGRtYV9lbmNfbWFzaykgIT0gZG1hX2VuY19tYXNr
KQ0KPj4+ICsJCXJldHVybiB0cnVlOw0KPj4+ICsNCj4+PiArCWlmIChkZXYtPmJ1c19kbWFfbWFz
ayAmJiAoZGV2LT5idXNfZG1hX21hc2sgJiBkbWFfZW5jX21hc2spICE9IGRtYV9lbmNfbWFzaykN
Cj4+PiArCQlyZXR1cm4gdHJ1ZTsNCj4+DQo+PiBEbyB5b3Ugd2FudCB0byBlcnIgb24gdGhlIHNp
ZGUgb2YgY2F1dGlvbiBhbmQgcmV0dXJuIHRydWUgaWYgYm90aCBtYXNrcw0KPj4gYXJlIHplcm8/
IFlvdSBjb3VsZCBkbyB0aGUgbWluX25vdF96ZXJvIHN0ZXAgYW5kIHRoZW4gcmV0dXJuIHRydWUg
aWYgdGhlDQo+PiByZXN1bHQgaXMgemVyby4gVGhlbiBqdXN0IG1ha2UgdGhlIG9uZSBjb21wYXJp
c29uIGFnYWluc3QgZG1hX2VuY19tYXNrLg0KPiANCj4gU29tZXRoaW5nIGxpa2UgdGhpcz8NCg0K
WXVwLCBsb29rcyBnb29kLg0KDQpUaGFua3MsDQpUb20NCg0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L21tL21lbV9lbmNyeXB0LmMgYi9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdC5jDQo+IGlu
ZGV4IGZlY2UzMGNhOGIwYy4uMTczZDY4YjA4YzU1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9t
bS9tZW1fZW5jcnlwdC5jDQo+ICsrKyBiL2FyY2gveDg2L21tL21lbV9lbmNyeXB0LmMNCj4gQEAg
LTM1NSw2ICszNTUsOCBAQCBFWFBPUlRfU1lNQk9MKHNldl9hY3RpdmUpOw0KPiAgLyogT3ZlcnJp
ZGUgZm9yIERNQSBkaXJlY3QgYWxsb2NhdGlvbiBjaGVjayAtIEFSQ0hfSEFTX0ZPUkNFX0RNQV9V
TkVOQ1JZUFRFRCAqLw0KPiAgYm9vbCBmb3JjZV9kbWFfdW5lbmNyeXB0ZWQoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KPiAgew0KPiArCXU2NCBkbWFfZW5jX21hc2ssIGRtYV9kZXZfbWFzazsNCj4gKw0K
PiAgCS8qDQo+ICAJICogRm9yIFNFViwgYWxsIERNQSBtdXN0IGJlIHRvIHVuZW5jcnlwdGVkIGFk
ZHJlc3Nlcy4NCj4gIAkgKi8NCj4gQEAgLTM2MiwyMCArMzY0LDE3IEBAIGJvb2wgZm9yY2VfZG1h
X3VuZW5jcnlwdGVkKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAkJcmV0dXJuIHRydWU7DQo+ICAN
Cj4gIAkvKg0KPiAtCSAqIEZvciBTTUUsIGFsbCBETUEgbXVzdCBiZSB0byB1bmVuY3J5cHRlZCBh
ZGRyZXNzZXMgaWYgdGhlDQo+IC0JICogZGV2aWNlIGRvZXMgbm90IHN1cHBvcnQgRE1BIHRvIGFk
ZHJlc3NlcyB0aGF0IGluY2x1ZGUgdGhlDQo+IC0JICogZW5jcnlwdGlvbiBtYXNrLg0KPiArCSAq
IEZvciBTTUUgYW5kIE1LVE1FLCBhbGwgRE1BIG11c3QgYmUgdG8gdW5lbmNyeXB0ZWQgYWRkcmVz
c2VzIGlmIHRoZQ0KPiArCSAqIGRldmljZSBkb2VzIG5vdCBzdXBwb3J0IERNQSB0byBhZGRyZXNz
ZXMgdGhhdCBpbmNsdWRlIHRoZSBlbmNyeXB0aW9uDQo+ICsJICogbWFzay4NCj4gIAkgKi8NCj4g
LQlpZiAoc21lX2FjdGl2ZSgpKSB7DQo+IC0JCXU2NCBkbWFfZW5jX21hc2sgPSBETUFfQklUX01B
U0soX19mZnM2NChzbWVfbWVfbWFzaykpOw0KPiAtCQl1NjQgZG1hX2Rldl9tYXNrID0gbWluX25v
dF96ZXJvKGRldi0+Y29oZXJlbnRfZG1hX21hc2ssDQo+IC0JCQkJCQlkZXYtPmJ1c19kbWFfbWFz
ayk7DQo+ICsJaWYgKCFzbWVfYWN0aXZlKCkgJiYgIW1rdG1lX2VuYWJsZWQoKSkNCj4gKwkJcmV0
dXJuIGZhbHNlOw0KPiAgDQo+IC0JCWlmIChkbWFfZGV2X21hc2sgPD0gZG1hX2VuY19tYXNrKQ0K
PiAtCQkJcmV0dXJuIHRydWU7DQo+IC0JfQ0KPiArCWRtYV9lbmNfbWFzayA9IHNtZV9tZV9tYXNr
IHwgbWt0bWVfa2V5aWRfbWFzaygpOw0KPiArCWRtYV9kZXZfbWFzayA9IG1pbl9ub3RfemVybyhk
ZXYtPmNvaGVyZW50X2RtYV9tYXNrLCBkZXYtPmJ1c19kbWFfbWFzayk7DQo+ICANCj4gLQlyZXR1
cm4gZmFsc2U7DQo+ICsJcmV0dXJuIChkbWFfZGV2X21hc2sgJiBkbWFfZW5jX21hc2spICE9IGRt
YV9lbmNfbWFzazsNCj4gIH0NCj4gIA0KPiAgLyogQXJjaGl0ZWN0dXJlIF9fd2VhayByZXBsYWNl
bWVudCBmdW5jdGlvbnMgKi8NCj4gDQo=
