Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1151FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77C02082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="qJCqNx3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfC0NjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:39:08 -0400
Received: from mail-eopbgr100129.outbound.protection.outlook.com ([40.107.10.129]:18016
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfC0NjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi+JXVDJxT883aEjkbt6YKCMeNdGqv0trCpR/udwwFk=;
 b=qJCqNx3vb3C5LoUxV7akM2Pyn21w8kwwBFxHVymARQs4oHQorEO6LnVDoTpcbIA8hdomYQY/tvS7qmPgl/nGvkc0fNvJVSN58K33qvhIjkpcyGCNtqqG6JuXkna3qatX6fzL/NqfS/tvwWtsHvdHA1d6n+DkmsTiS77Qg/CzLis=
Received: from LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM (20.176.139.20) by
 LO2P265MB1295.GBRP265.PROD.OUTLOOK.COM (20.176.144.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 13:38:25 +0000
Received: from LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ed34:1290:4306:3157]) by LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ed34:1290:4306:3157%3]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 13:38:24 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Anup Patel <anup@brainfault.org>
CC:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Implement ASID allocator
Thread-Topic: [PATCH] RISC-V: Implement ASID allocator
Thread-Index: AQHU5IQth95RRmVyw0y1O3lxWJG/36YfVxgAgAAEHICAACB1gA==
Date:   Wed, 27 Mar 2019 13:38:24 +0000
Message-ID: <49628dc9-c56d-6b60-9520-e4eb0e3b3424@garyguo.net>
References: <20190327100201.32220-1-anup.patel@wdc.com>
 <7edf91f1-1df5-5513-d372-d84edd12edf3@garyguo.net>
 <CAAhSdy1+rc9ge02uqNvse5Z6XmDxsRH0G=5GnMsh+6m1LMLFYg@mail.gmail.com>
In-Reply-To: <CAAhSdy1+rc9ge02uqNvse5Z6XmDxsRH0G=5GnMsh+6m1LMLFYg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::30) To LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8c::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:630:212:238:3697:f6ff:fe55:55b1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16bfaf41-2a6a-4180-94f9-08d6b2b97c4f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:LO2P265MB1295;
x-ms-traffictypediagnostic: LO2P265MB1295:
x-ms-exchange-purlcount: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gary@garyguo.net; 
x-microsoft-antispam-prvs: <LO2P265MB129509F303F3D010CBB789A7D6580@LO2P265MB1295.GBRP265.PROD.OUTLOOK.COM>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39830400003)(396003)(136003)(199004)(189003)(97736004)(4326008)(316002)(71190400001)(54906003)(2906002)(14454004)(5660300002)(25786009)(7736002)(966005)(86362001)(6916009)(8936002)(508600001)(14444005)(71200400001)(256004)(7416002)(68736007)(31696002)(31686004)(186003)(446003)(6436002)(52116002)(6512007)(6306002)(486006)(2616005)(105586002)(6506007)(53546011)(229853002)(53936002)(386003)(476003)(99286004)(6116002)(6486002)(46003)(76176011)(305945005)(8676002)(36756003)(11346002)(102836004)(106356001)(6246003)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:LO2P265MB1295;H:LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: garyguo.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3E0s3cnfBVH2FLmIIG04JFM6TK1sbzbIy1bG4+PPhwjXIdy+iAgs7WdlDTjgedp99N/6UsBB9uzZApHdqNPF+91FLGBBkILRb4lu+FGn6ChM2mFjh/GJuJrpSHpVtqS0hGQCduPGULrsXMXZCJNeqATVikHmYuz9EXUUsRSceN3HlQO+n0bD3jvMwi9L9FBHw6Eai7+rdTvJnr8PjREf+QIiIOD5S1UC3iZYY2rPoc8sjBFPz9L0YUgnVQVIlvdCpEsyiJUCMhxjc6TtsZJyyOt2aZdZ0FG/iX/ZD+C825e2h7VNg0Yk6qBJRRNsVpdUpw7VwXBOwh+SYIZxc59kgtq+18qXgWIzQicxqS/QdnlnfUGqmE1UNPvpXpuVnXrpjONg/xq45Bb1Xl3DRzsxXW0cfEGrwePsMrtXCfcLQWo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79B6C6F9D82FFD43AE28F57D76E58B59@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bfaf41-2a6a-4180-94f9-08d6b2b97c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 13:38:24.7810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB1295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDMvMjAxOSAxMTo0MiwgQW51cCBQYXRlbCB3cm90ZToNCj4gT24gV2VkLCBNYXIgMjcs
IDIwMTkgYXQgNDo1NyBQTSBHYXJ5IEd1byA8Z2FyeUBnYXJ5Z3VvLm5ldD4gd3JvdGU6DQo+Pg0K
Pj4gSGkgQW51cCwNCj4+DQo+PiBUaGlzIHdvbid0IHdvcmsgaW4gYW4gYWN0dWFsIGhhcmR3YXJl
IHdpdGggQVNJRCBzdXBwb3J0LiBUaGVyZSdyZSBtb3JlDQo+IA0KPiBDYW4geW91IGVsYWJvcmF0
ZSB3aHkgPg0KPiANCj4gVGhpcyBpbXBsZW1lbnRhdGlvbiBpcyBiYXNlZCBvbiBMaW51eCBBUk02
NCBBU0lEIGFsbG9jYXRvciB3aGljaCBpcw0KPiB0ZXN0ZWQgZm9yIGxhcmdlIG51bWJlciBvZiBD
UFVzIG9uIHJlYWwgSFcuDQo+IA0KPj4gaW50ZXJhY3Rpb25zIHdpdGggVExCIGZsdXNoZXMgdGhh
dCBuZWVkIHRvIGJlIGNvbnNpZGVyZWQuIFlvdSB3b24ndCBzZWUNCj4gDQo+IFlhcCwgYWxyZWFk
eSBjb25zaWRlcmVkLiBQbGVhc2UgcG9pbnQgbWUgdG8gdW5oYW5kbGVkIGNhc2UuDQo+IA0KV2hl
biBtZW1vcnkgbWFwcGluZyBpcyBjaGFuZ2VkLCB5b3UgbmVlZCB0byBmbHVzaCBpdCBmcm9tIGFs
bCBjb3JlcyB0aGF0IA0KcHJldmlvdXNseSBoYXZlIHRoYXQgcHJvY2VzcyBleGVjdXRlZCwgZXRj
LiBPdXIgcGF0Y2hlcyBib3RoIHRha2UgDQppbnNwaXJhdGlvbiBmcm9tIEFSTSdzIGNvZGUsIGJ1
dCB0aGUgbWFqb3IgZGlmZmVyZW5jZSBiZXR3ZWVuIG15IGNvZGUgaXMgDQpoYW5kbGluZyBvZiBj
YWNoZSBpbnZhbGlkYXRpb25zLCBzZWUgbXkgY29kZSdzIGNhY2hlX21hc2ssIGV0Yy4gVGhpcyBp
cyANCmFjdHVhbGx5IHRoZSBtb3N0IGVycm9yLXByb25lIHBhcnQsIGFuZCBJIHNwZW50IG1vcmUg
dGltZSB0cnlpbmcgdG8gZmluZCANCmFuIG9wdGltYWwgc29sdXRpb24gZm9yIHRoaXMgdGhhbiBw
b3J0aW5nIHRoZSBBU0lEIGFsbG9jYXRvci4gVGhlIG1ham9yIA0KZGlmZmVyZW5jZSBpcyB0aGF0
IEFSTSBoYXMgYSBtdWNoIG1vcmUgZXhwcmVzc2l2ZSBzZXRzIG9mIFRMQiBmbHVzaCANCmluc3Ry
dWN0aW9ucyBjb21wYXJlZCB0byBSSVNDLVYuDQogPg0KPj4gdGhpcyBvbiBib3RoIFFFTVUgYW5k
IFNpRml2ZSBib2FyZCwgYXMgUUVNVSBkb2VzIG5vdCBoYXZlIEFTSUQsIHNvIGl0DQo+PiBwcmV0
ZW5kcyB0aGF0IEFTSUQgaXMgc3VwcG9ydGVkIGJ5IGp1c3QgZmx1c2hpbmcgaXRzIFRMQiBldmVy
eXRpbWUgeW91DQo+IA0KPiBOb3BlLCBpdCBkb2VzIG5vdC4gSXQgZGV0ZWN0cyB3aGV0aGVyIEFT
SUQgaXMgc3VwcG9ydGVkIG9yIG5vdC4gSWYgc3VwcG9ydGVkDQo+IGl0IHdpbGwgYWxzbyBmaWd1
cmUtb3V0IG51bWJlciBvZiBBU0lEIGJpdHMgc3VwcG9ydGVkIGJ5IEhXLg0KPiANCkV4Y2VwdCB0
aGF0IHlvdSBjYW4gZGV0ZWN0IHRoYXQgUUVNVSBzdXBwb3J0cyBBU0lELCBidXQgYWN0dWFsbHkg
aXQgZG9lcyANCm5vdC4gSG93ZXZlciBRRU1VIGlzIHN0aWxsIGNvcnJlY3QgYmVjYXVzZSBpdCBh
bHdheXMgZmx1c2ggVExCIHdoZW4geW91IA0Kc2V0IFNBVFAvU1BUQlIuIFlvdSB3b24ndCBiZSBh
YmxlIHRvIGZpbmQgb3V0IGJ1Z3MgaW4geW91ciBjb2RlIGJ5IGp1c3QgDQp0ZXN0aW5nIG9uIFFF
TVUuDQoNCj4gU2lGaXZlIGJvYXJkIGRvZXMgbm90IGhhdmUgQVNJRCBiaXRzIHNvIHRoaXMgaW1w
bGVtZW50YXRpb24gc3VjY2Vzc2Z1bGx5DQo+IGRldGVjdHMgdGhhdCBudW1iZXIgb2YgQVNJRCBi
aXRzIGFyZSAwIGFuZCBmYWxsYmFja3MgdG8gb3JpZ2luYWwgd2F5IG9mDQo+IGxvY2FsIFRMQiBm
bHVzaGVzLiA+DQo+PiBjaGFuZ2Ugc3B0YnIuIEkgc3VzcGVjdCB0aGUgcGVyZm9ybWFuY2UgZ2Fp
biB5b3Ugc2VlIGlzIGp1c3QgZHVlIHRvDQo+PiBzYXZlZCBUTEIgZmx1c2ggYXMgVExCIGZsdXNo
IGlzIHN1cGVyIGV4cGVuc2l2ZSBpbiBRRU1VIChhbGwgdHJhbnNsYXRpb24NCj4+IGJsb2NrIGp1
bXBzIG5lZWQgdG8gYmUgY2xlYXJlZCkuDQo+IA0KPiBZZXMsIHBlcmZvcm1hbmNlIGdhaW4gaXMg
ZHVlIHRvIHNhdmVkIFRMQiBmbHVzaGVzLg0KPiANCj4gT24gSFcgd2hpY2ggc3VwcG9ydHMgQVNJ
RCBiaXRzLCB3ZSB3aWxsIHNlZSBtb3JlIHBlcmZvcm1hbmNlDQo+IGltcHJvdmVtZW50cy4gPg0K
QSBoYXJkd2FyZSBUTEIgZmx1c2ggaXMgY2hlYXBlciB0aGFuIFFFTVUnIFRMQiBmbHVzaC4gQXMg
bm8gaGFyZHdhcmUgDQpzdXBwb3J0cyBBU0lEIGF0IHRoZSBtb21lbnQgdGhlIHBlcmZvcm1hbmNl
IGdhaW4gaXMgbWluaW1hbC4NCj4+DQo+PiBJIGhhdmUgbXkgdmVyc2lvbiBoZXJlIGh0dHBzOi8v
Z2l0aHViLmNvbS9uYmRkMDEyMS9saW51eC90cmVlL2FzaWQuIEkNCj4+IGhhdmVuJ3QgZG9uZSBj
b2RlIGNsZWFudXBzIHlldCwgYnV0IHRoaXMgdmVyc2lvbiBoYXMgY29ycmVjdG5lc3Mgb2YgaXRz
DQo+PiBBU0lEIGNvZGUgdGVzdGVkIG9uIG91ciBUTEIgc2ltdWxhdG9yIHRvb2wgKHdoaWNoIHVu
Zm9ydHVuYXRlbHkgSSBjYW4ndA0KPj4gc2hhcmUgcmlnaHQgbm93IGFzIGl0IGludm9sdmVzIHdp
dGggdW5wdWJsaXNoZWQgd29ya3MpLg0KPiANCj4gRXhjZXB0IGZldyBtaW5vciBkaWZmZXJlbmNl
cy4gWW91IHZlcnNpb24gb2YgQVNJRCBhbGxvY2F0b3IgaXMgc2FtZSBhcw0KPiBtaW5lLiBJbiBm
YWN0IHRoZXJlIGFyZSBsb3Qgb2Ygc2ltaWxhciBjb2RlIGZyYW1nZW1lbnRzIGluIHlvdXIgdmVy
c2lvbg0KPiBjb21wYXJlZCB0byBMaW51eCBBUk02NCBhcyB3ZWxsLiBJIGFtIHN1cmUgdGhpcyBw
YXRjaCB3aWxsIHdvcmsgZm9yIHlvdS4NCj4gPj4NCj4+IEluIGZhY3QgbXkgc3VibWl0IG15IHBy
ZXZpb3VzIHBhdGNoIHNlcmllcyBleGFjdGx5IGFzIHRoZSBiYXNpcyBvZiB0aGlzDQo+PiBwYXRj
aC4NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgYmFzZWQgeW91ciBwYXRjaCBzZXJpZXMgc28gSSBzdWdn
ZXN0IHlvdSB0YWtlIHRoaXMgcGF0Y2gNCj4gYW5kIHRyeSBpdCBvbiB5b3VyIHNpbXVsYXRvci4N
Cj4gDQpJJ3ZlIHRlc3RlZCwgYW5kIGl0IGRvZXMgbm90IGJvb3QuDQo=
