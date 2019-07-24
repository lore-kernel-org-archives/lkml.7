Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3168AC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE75321911
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MCKHO5SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfGXSa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:30:27 -0400
Received: from mail-eopbgr730076.outbound.protection.outlook.com ([40.107.73.76]:46299
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387668AbfGXSa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:30:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViO3LTAoff4sRxjI2wsuI0UfccEUAuD+ZuXLatOnrt4ubCFEy3EBE269HgFpGUUMPvnKp2PuGEvTOHD5XdXjbA0L4U5sMN6tQlgGF3Lno9zRI49R8sQoonVBQkce/MgCt5wCZaNrwoB9byeuPTRxtsyfYdAO1id/ZlQBGAhu8oG9mK78N7ObB0/xbF/MjBHwquv9+5k+b8+RTy02fnazucXmjbrtWTOxQFj70EKhzIbOYN9bgM524fVKltgtkaHdU+4CeT9HotkaouHjMT03N7npJvWKdI6Wnyab7dSH1w5OO21P215BCFfAcWRB97Zmh2yDAEE+f1pgdzXGbGRqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJjYGFa4uv+c0SPjGFCRoEA4tVq7L8w1kjZ94YRAzq0=;
 b=LMlOOsm3GBtdJMIOk2OHwai4WYtUAaatzWLytWzgPzqALD9zyGTO6Fh1oCdeFNUylEXKrNnoajluXTw9M4D8pvkK1ushit5+pp3cWjHf6R1v7pPmhAQ5nBn6YefvdEeAO1S8CkL+esMoZgtwxNfhb1Lk58XFZXRc/RCl3W9yz4QMe9F+/sLGmns/1CexPHhLij4B09sLU1aH7sOvBiIxIHzq53+xzUC//zPKQc3jKPWS81qKRTT26IfIrxtX0FklRB+6fpI+9VG/jnATtMBb+xEbZBU5mC8XbLuwnGZbudvzowE0CSbPMh4Xo3QujhIN21SEjvBfEpyD8AafdSdVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJjYGFa4uv+c0SPjGFCRoEA4tVq7L8w1kjZ94YRAzq0=;
 b=MCKHO5SI0mM+rxtq4rOCxeEWM+gXOado4h2KVYW+/0Ctx30lDXTRqdLci7b29TqixgoIkZa4Uw39kzYWeWIH+NzSSo1NMsNvBeQ/BieqJNDZuuBw46K+2Ymjw+1RtwGth11vIEkQ3woMq8DCSd+13hNRs7lkXbXrD1a2Hn93/10=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2633.namprd12.prod.outlook.com (20.176.116.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 24 Jul 2019 18:30:21 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2094.013; Wed, 24 Jul 2019
 18:30:21 +0000
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
Thread-Index: AQHVN1HbhkVejMp04kW0O/tJG/K57qbaAcwAgAANJYCAAAaagIAAB+IAgAAKaYCAAAU3gA==
Date:   Wed, 24 Jul 2019 18:30:21 +0000
Message-ID: <9f9bfd05-0010-9050-20f0-8c89b2f039ef@amd.com>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
 <20190724155530.hlingpcirjcf2ljg@box>
 <acee0a74-77fc-9c81-087b-ce55abf87bd4@amd.com>
 <a89e7574-096d-9105-45ff-34bbb74918a5@arm.com>
 <c4110c6b-686c-7e77-fedc-33782e5b3e50@amd.com>
 <20190724181139.yebja5yflzjgfxlx@box>
In-Reply-To: <20190724181139.yebja5yflzjgfxlx@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0031.namprd04.prod.outlook.com
 (2603:10b6:803:2a::17) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b0c5075-7f33-49bc-c248-08d71064fc4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2633;
x-ms-traffictypediagnostic: DM6PR12MB2633:
x-microsoft-antispam-prvs: <DM6PR12MB2633FF783D8073A8EAE3CF40ECC60@DM6PR12MB2633.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(189003)(199004)(102836004)(26005)(71190400001)(386003)(486006)(71200400001)(186003)(478600001)(3846002)(53936002)(68736007)(6506007)(36756003)(52116002)(8676002)(53546011)(76176011)(6116002)(66066001)(6246003)(6486002)(446003)(305945005)(11346002)(2616005)(476003)(31686004)(7736002)(6512007)(66476007)(6436002)(66556008)(14454004)(8936002)(66946007)(25786009)(81166006)(316002)(5660300002)(81156014)(64756008)(66446008)(86362001)(31696002)(54906003)(4326008)(2906002)(229853002)(99286004)(7416002)(6916009)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2633;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7ZlNCMICRuclaan2SoDLA8MBRQUVatZWpOJawVBoYMMCmWrT0PPWqq6SgLF9crRgCiK6wrYKhb+TuCIcE0gxCPXG/4h5y1zqYK7YNTYPkfetauq4qi3exSen6xdx0RXzQH7gWfveSxmMgTywiIWwUUc79aKkymPcUiJ2fDebNvHIXjhwYECqZoIaytl7vxkXac4qwb3HDXMTfwxEbPfHYT05hjKlW+oD7gfp0uLbsC5oMaXbOM41UFt+Mqdfgz41RxEzfUc2deI8Yl+vK2nXp6fqml0yc8PWUXDUXxBnUIwpzI1/BPJ6WEMsWpjr2D8nynllPnrmuQrt787wT8Tt5JqOHqZXqO1L7panL06QZRidN4fmJUuplFSmQNpW8Vr1tvLf3vRK5M7KXeDXjJPOoo+/q74dJyQyEdkVCd9Wdxk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D87444C6770634390A0D7D696E571B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0c5075-7f33-49bc-c248-08d71064fc4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 18:30:21.3212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2633
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yNC8xOSAxOjExIFBNLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+IE9uIFdlZCwg
SnVsIDI0LCAyMDE5IGF0IDA1OjM0OjI2UE0gKzAwMDAsIExlbmRhY2t5LCBUaG9tYXMgd3JvdGU6
DQo+PiBPbiA3LzI0LzE5IDEyOjA2IFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+Pj4gT24gMjQv
MDcvMjAxOSAxNzo0MiwgTGVuZGFja3ksIFRob21hcyB3cm90ZToNCj4+Pj4gT24gNy8yNC8xOSAx
MDo1NSBBTSwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPj4+Pj4gT24gV2VkLCBKdWwgMTAs
IDIwMTkgYXQgMDc6MDE6MTlQTSArMDAwMCwgTGVuZGFja3ksIFRob21hcyB3cm90ZToNCj4+Pj4+
PiBAQCAtMzUxLDYgKzM1NSwzMiBAQCBib29sIHNldl9hY3RpdmUodm9pZCkNCj4+Pj4+PiDCoCB9
DQo+Pj4+Pj4gwqAgRVhQT1JUX1NZTUJPTChzZXZfYWN0aXZlKTsNCj4+Pj4+PiDCoCArLyogT3Zl
cnJpZGUgZm9yIERNQSBkaXJlY3QgYWxsb2NhdGlvbiBjaGVjayAtDQo+Pj4+Pj4gQVJDSF9IQVNf
Rk9SQ0VfRE1BX1VORU5DUllQVEVEICovDQo+Pj4+Pj4gK2Jvb2wgZm9yY2VfZG1hX3VuZW5jcnlw
dGVkKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+Pj4+PiArew0KPj4+Pj4+ICvCoMKgwqAgLyoNCj4+
Pj4+PiArwqDCoMKgwqAgKiBGb3IgU0VWLCBhbGwgRE1BIG11c3QgYmUgdG8gdW5lbmNyeXB0ZWQg
YWRkcmVzc2VzLg0KPj4+Pj4+ICvCoMKgwqDCoCAqLw0KPj4+Pj4+ICvCoMKgwqAgaWYgKHNldl9h
Y3RpdmUoKSkNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7DQo+Pj4+Pj4gKw0K
Pj4+Pj4+ICvCoMKgwqAgLyoNCj4+Pj4+PiArwqDCoMKgwqAgKiBGb3IgU01FLCBhbGwgRE1BIG11
c3QgYmUgdG8gdW5lbmNyeXB0ZWQgYWRkcmVzc2VzIGlmIHRoZQ0KPj4+Pj4+ICvCoMKgwqDCoCAq
IGRldmljZSBkb2VzIG5vdCBzdXBwb3J0IERNQSB0byBhZGRyZXNzZXMgdGhhdCBpbmNsdWRlIHRo
ZQ0KPj4+Pj4+ICvCoMKgwqDCoCAqIGVuY3J5cHRpb24gbWFzay4NCj4+Pj4+PiArwqDCoMKgwqAg
Ki8NCj4+Pj4+PiArwqDCoMKgIGlmIChzbWVfYWN0aXZlKCkpIHsNCj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgdTY0IGRtYV9lbmNfbWFzayA9IERNQV9CSVRfTUFTSyhfX2ZmczY0KHNtZV9tZV9tYXNr
KSk7DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHU2NCBkbWFfZGV2X21hc2sgPSBtaW5fbm90X3pl
cm8oZGV2LT5jb2hlcmVudF9kbWFfbWFzaywNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXYtPmJ1c19kbWFfbWFzayk7DQo+Pj4+Pj4gKw0K
Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZG1hX2Rldl9tYXNrIDw9IGRtYV9lbmNfbWFzaykN
Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsNCj4+Pj4+DQo+Pj4+
PiBIbS4gV2hhdCBpcyB3cm9uZyB3aXRoIHRoZSBkZXYgbWFzayBiZWluZyBlcXVhbCB0byBlbmMg
bWFzaz8gSUlVQywgaXQNCj4+Pj4+IG1lYW5zIHRoYXQgZGV2aWNlIG1hc2sgaXMgd2lkZSBlbm91
Z2ggdG8gY292ZXIgZW5jcnlwdGlvbiBiaXQsIGRvZXNuJ3QgaXQ/DQo+Pj4+DQo+Pj4+IE5vdCBy
ZWFsbHkuLi7CoCBpdCdzIHRoZSB3YXkgRE1BX0JJVF9NQVNLIHdvcmtzIHZzIGJpdCBudW1iZXJp
bmcuIExldCdzIHNheQ0KPj4+PiB0aGF0IHNtZV9tZV9tYXNrIGhhcyBiaXQgNDcgc2V0LiBfX2Zm
czY0IHJldHVybnMgNDcgYW5kIERNQV9CSVRfTUFTSyg0NykNCj4+Pj4gd2lsbCBnZW5lcmF0ZSBh
IG1hc2sgd2l0aG91dCBiaXQgNDcgc2V0ICgweDdmZmZmZmZmZmZmZikuIFNvIHRoZSBjaGVjaw0K
Pj4+PiB3aWxsIGNhdGNoIGFueXRoaW5nIHRoYXQgZG9lcyBub3Qgc3VwcG9ydCBhdCBsZWFzdCA0
OC1iaXQgRE1BLg0KPj4+DQo+Pj4gQ291bGRuJ3QgdGhhdCBiZSBleHByZXNzZWQgYXMganVzdDoN
Cj4+Pg0KPj4+IMKgwqDCoMKgaWYgKHNtZV9tZV9tYXNrICYgZG1hX2Rldl9tYXNrID09IHNtZV9t
ZV9tYXNrKQ0KPj4NCj4+IEFjdHVhbGx5ICE9LCBidXQgeWVzLCBpdCBjb3VsZCBoYXZlIGJlZW4g
ZG9uZSBsaWtlIHRoYXQsIEkganVzdCBkaWRuJ3QNCj4+IHRoaW5rIG9mIGl0Lg0KPiANCj4gSSdt
IGxvb2tpbmcgaW50byBnZW5lcmFsaXppbmcgdGhlIGNoZWNrIHRvIGNvdmVyIE1LVE1FLg0KPiAN
Cj4gTGVhdmluZwlvZmYgdGhlIEtjb25maWcgY2hhbmdlcyBhbmQgbW92aW5nIHRoZSBjaGVjayB0
byBvdGhlciBmaWxlLCBkb2VzdA0KPiB0aGUgY2hhbmdlIGJlbG93IGxvb2sgcmVhc29uYWJsZSB0
byB5b3UuIEl0J3Mgb25seSBidWlsZCB0ZXN0ZWQgc28gZmFyLg0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L21tL21lbV9lbmNyeXB0LmMgYi9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdC5jDQo+
IGluZGV4IGZlY2UzMGNhOGIwYy4uNmM4NmFkY2QwMmRhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4
Ni9tbS9tZW1fZW5jcnlwdC5jDQo+ICsrKyBiL2FyY2gveDg2L21tL21lbV9lbmNyeXB0LmMNCj4g
QEAgLTM1NSw2ICszNTUsOCBAQCBFWFBPUlRfU1lNQk9MKHNldl9hY3RpdmUpOw0KPiAgLyogT3Zl
cnJpZGUgZm9yIERNQSBkaXJlY3QgYWxsb2NhdGlvbiBjaGVjayAtIEFSQ0hfSEFTX0ZPUkNFX0RN
QV9VTkVOQ1JZUFRFRCAqLw0KPiAgYm9vbCBmb3JjZV9kbWFfdW5lbmNyeXB0ZWQoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiAgew0KPiArCXU2NCBkbWFfZW5jX21hc2s7DQo+ICsNCj4gIAkvKg0KPiAg
CSAqIEZvciBTRVYsIGFsbCBETUEgbXVzdCBiZSB0byB1bmVuY3J5cHRlZCBhZGRyZXNzZXMuDQo+
ICAJICovDQo+IEBAIC0zNjIsMTggKzM2NCwyMCBAQCBib29sIGZvcmNlX2RtYV91bmVuY3J5cHRl
ZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJCXJldHVybiB0cnVlOw0KPiAgDQo+ICAJLyoNCj4g
LQkgKiBGb3IgU01FLCBhbGwgRE1BIG11c3QgYmUgdG8gdW5lbmNyeXB0ZWQgYWRkcmVzc2VzIGlm
IHRoZQ0KPiAtCSAqIGRldmljZSBkb2VzIG5vdCBzdXBwb3J0IERNQSB0byBhZGRyZXNzZXMgdGhh
dCBpbmNsdWRlIHRoZQ0KPiAtCSAqIGVuY3J5cHRpb24gbWFzay4NCj4gKwkgKiBGb3IgU01FIGFu
ZCBNS1RNRSwgYWxsIERNQSBtdXN0IGJlIHRvIHVuZW5jcnlwdGVkIGFkZHJlc3NlcyBpZiB0aGUN
Cj4gKwkgKiBkZXZpY2UgZG9lcyBub3Qgc3VwcG9ydCBETUEgdG8gYWRkcmVzc2VzIHRoYXQgaW5j
bHVkZSB0aGUgZW5jcnlwdGlvbg0KPiArCSAqIG1hc2suDQo+ICAJICovDQo+IC0JaWYgKHNtZV9h
Y3RpdmUoKSkgew0KPiAtCQl1NjQgZG1hX2VuY19tYXNrID0gRE1BX0JJVF9NQVNLKF9fZmZzNjQo
c21lX21lX21hc2spKTsNCj4gLQkJdTY0IGRtYV9kZXZfbWFzayA9IG1pbl9ub3RfemVybyhkZXYt
PmNvaGVyZW50X2RtYV9tYXNrLA0KPiAtCQkJCQkJZGV2LT5idXNfZG1hX21hc2spOw0KPiArCWlm
ICghc21lX2FjdGl2ZSgpICYmICFta3RtZV9lbmFibGVkKCkpDQo+ICsJCXJldHVybiBmYWxzZTsN
Cj4gIA0KPiAtCQlpZiAoZG1hX2Rldl9tYXNrIDw9IGRtYV9lbmNfbWFzaykNCj4gLQkJCXJldHVy
biB0cnVlOw0KPiAtCX0NCj4gKwlkbWFfZW5jX21hc2sgPSBzbWVfbWVfbWFzayB8IG1rdG1lX2tl
eWlkX21hc2soKTsNCj4gKw0KPiArCWlmIChkZXYtPmNvaGVyZW50X2RtYV9tYXNrICYmIChkZXYt
PmNvaGVyZW50X2RtYV9tYXNrICYgZG1hX2VuY19tYXNrKSAhPSBkbWFfZW5jX21hc2spDQo+ICsJ
CXJldHVybiB0cnVlOw0KPiArDQo+ICsJaWYgKGRldi0+YnVzX2RtYV9tYXNrICYmIChkZXYtPmJ1
c19kbWFfbWFzayAmIGRtYV9lbmNfbWFzaykgIT0gZG1hX2VuY19tYXNrKQ0KPiArCQlyZXR1cm4g
dHJ1ZTsNCg0KRG8geW91IHdhbnQgdG8gZXJyIG9uIHRoZSBzaWRlIG9mIGNhdXRpb24gYW5kIHJl
dHVybiB0cnVlIGlmIGJvdGggbWFza3MNCmFyZSB6ZXJvPyBZb3UgY291bGQgZG8gdGhlIG1pbl9u
b3RfemVybyBzdGVwIGFuZCB0aGVuIHJldHVybiB0cnVlIGlmIHRoZQ0KcmVzdWx0IGlzIHplcm8u
IFRoZW4ganVzdCBtYWtlIHRoZSBvbmUgY29tcGFyaXNvbiBhZ2FpbnN0IGRtYV9lbmNfbWFzay4N
Cg0KVGhhbmtzLA0KVG9tDQoNCj4gIA0KPiAgCXJldHVybiBmYWxzZTsNCj4gIH0NCj4gDQo=
