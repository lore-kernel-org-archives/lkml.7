Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF1BC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CD1208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ts0fga/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbfHFNjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:39:02 -0400
Received: from mail-eopbgr810058.outbound.protection.outlook.com ([40.107.81.58]:10608
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732103AbfHFNjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:39:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTEg16ry3vhRbnRUP+y0x/hsW202Tgro/MRoT6MMSYR4AmH0IXxjw71lKXsuOtwSeXLoflxFAqCE0/e0QbDKN9ABBGLrXOpoV4+c57odQw54nWU0bmCCqBMz2j4O+X4uc8FGKN6P85rmNSG4RlSWwcdmoCFRarUnOb1fWFP0NG2z6FXjQPOIzcDJaOQAR7em/JcJpmtXYtD7Iv2KO5vWhuddTuK5TOvKRgWvTcbWiok8eQu5ykNW5t6QB74WIwaRU8mOduIMixd9golEmOzWppATCEXUYh6MmKKlMq6PKZ/VyA9FQFPgvO0D6gTdU4karC5+YKLiN//ZO3pVUDpW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwW/esXYhGhEUeROiIJOESnT7VKUfz7DmoZrXsEo3Xk=;
 b=VIVeLUQZAM/ESzpC8dMfBJnHZdrvT30st5kefSeXorEkHLAdss82WQ5/XSKX6oX3buqqFDRMgzm9vEYamBiXA6CDaAde0c/DEKYCZM6da2Zw+OAJafIPdtGdWIyKQjdu1Kd+q8uB4vKuEpu+1WDG55pvIGbEz8hSHG7xYo7ikKz7NKVXj0TEbwA7zp3zcyUPUMTnkAIOe5LUQgCcfBDYhsQNe5xVrPaXdeU9WH+a9LaBp4yKQCQ9JBpkC0HiglGtAbp19zmxbXKQOr31vgfd7MBMGn23/hQ0BxL3JHnOPEfXde/GBj6t7Aepn09m8Ojycqs7nim3I89mC/Qy6T3LFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwW/esXYhGhEUeROiIJOESnT7VKUfz7DmoZrXsEo3Xk=;
 b=ts0fga/QAhMYtCjlyJH5bE3tlBgiqYFFjgxV8f7Fut/D1RBfZ8Jtt07fVba+uf8aPvd9OnbqglUFoQS24YW/W1DP12E5+9bgu3qcFcVOwdYD2p1GjSmyRqS4aQhzVDnHvx57SMzJ04dt9hs7Bts4mDEMZWLEVJmps0fRXiaKWkE=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3594.namprd12.prod.outlook.com (20.178.199.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Tue, 6 Aug 2019 13:38:57 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 13:38:57 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Christoph Hellwig <hch@lst.de>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
Thread-Topic: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
Thread-Index: AQHVTDc5jxhkF6eBGE2vQ7mpw/Pby6bt/Q4AgAAjGIA=
Date:   Tue, 6 Aug 2019 13:38:57 +0000
Message-ID: <41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com>
References: <1565082809.2323.24.camel@pengutronix.de>
 <20190806113318.GA20215@lst.de>
In-Reply-To: <20190806113318.GA20215@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:805:8e::33) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 125b6e18-9dcb-4d2d-73e5-08d71a736e44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3594;
x-ms-traffictypediagnostic: DM6PR12MB3594:
x-microsoft-antispam-prvs: <DM6PR12MB3594379105268ED358EB6AE7ECD50@DM6PR12MB3594.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(6116002)(6246003)(31696002)(256004)(31686004)(3846002)(36756003)(81166006)(86362001)(305945005)(26005)(81156014)(6486002)(478600001)(6512007)(25786009)(8936002)(54906003)(71190400001)(71200400001)(316002)(52116002)(7736002)(2906002)(110136005)(53936002)(64756008)(66556008)(66476007)(102836004)(14454004)(476003)(8676002)(99286004)(66446008)(486006)(5660300002)(76176011)(6436002)(4326008)(11346002)(53546011)(66066001)(229853002)(66946007)(446003)(6506007)(186003)(68736007)(2616005)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3594;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q+K75nkx9QaGUrW40RiqEbKpYNEaqcEVlKAtTLJLVL4RMXsDra36njh6iP5+gYlJz71ejwMSgWgvc03LM3qXjejMGhissrCKJccUIIeTVZAsUpZygyzXeFV87r7WRRJVOe9kQOchhewyCICvb57sye8Z7yeUHJ0+2I/KuKXYJgrOq7YoLnc7aZulWGcTYJGGOZvX22yLSRr4IezbtqDm3p1PgnWlQg64JLpi/o6Cavr1SIk5aFPR2g17eTd+XWED1npxCPvESkL4seUG5cmRXMgUApTorTOJ9Hv13//BMbmR5627TaWYbdWy+NYhCBUOWwEdPKxzAaBR57ZeeilDYnT5PwaWaLtLqekRyjJnsBZu4ZXuPS8g4qVV/E8haiX55goz+aZy5GlwtBYLwzAm8z6Mn8LuFg+qy7GQTA+SwuY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8065952E1A506246A136908F61BC426D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125b6e18-9dcb-4d2d-73e5-08d71a736e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 13:38:57.1444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC82LzE5IDY6MzMgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUdWUsIEF1
ZyAwNiwgMjAxOSBhdCAxMToxMzoyOUFNICswMjAwLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4+IEhp
IENocmlzdG9waCwNCj4+DQo+PiBJIGp1c3QgZm91bmQgYSByZWdyZXNzaW9uIHdoZXJlIG15IE5W
TWUgZGV2aWNlIGlzIG5vIGxvbmdlciBhYmxlIHRvIHNldA0KPj4gdXAgaXRzIEhNQi4NCj4+DQo+
PiBBZnRlciBzdWJqZWN0IGNvbW1pdCBkbWFfZGlyZWN0X2FsbG9jX3BhZ2VzKCkgaXMgbm8gbG9u
Z2VyIGluaXRpYWxpemluZw0KPj4gZG1hX2hhbmRsZSBwcm9wZXJseSB3aGVuIERNQV9BVFRSX05P
X0tFUk5FTF9NQVBQSU5HIGlzIHNldCwgYXMgdGhlDQo+PiBmdW5jdGlvbiBpcyBub3cgcmV0dXJu
aW5nIHRvbyBlYXJseS4NCj4+DQo+PiBOb3cgdGhpcyBjb3VsZCBlYXNpbHkgYmUgZml4ZWQgYnkg
YWRkaW5nIHRoZSBwaHlfdG9fZG1hIHRyYW5zbGF0aW9uIHRvDQo+PiB0aGUgTk9fS0VSTkVMX01B
UFBJTkcgY29kZSBwYXRoLCBidXQgSSdtIG5vdCBzdXJlIGhvdyB0aGlzIHN0dWZmDQo+PiBpbnRl
cmFjdHMgd2l0aCB0aGUgbWVtb3J5IGVuY3J5cHRpb24gc3R1ZmYgc2V0IHVwIGxhdGVyIGluIHRo
ZQ0KPj4gZnVuY3Rpb24sIHNvIEkgZ3Vlc3MgdGhpcyBzaG91bGQgYmUgbG9va2VkIGF0IGJ5IHNv
bWVvbmUgd2l0aCBtb3JlDQo+PiBleHBlcmllbmNlIHdpdGggdGhpcyBjb2RlIHRoYW4gbWUuDQo+
IA0KPiBUaGVyZSBpcyBub3QgbXVjaCB3ZSBjYW4gZG8gYWJvdXQgdGhlIG1lbW9yeSBlbmNyeXB0
aW9uIGNhc2UgaGVyZSwNCj4gYXMgdGhhdCByZXF1aXJlcyBhIGtlcm5lbCBhZGRyZXNzIHRvIG1h
cmsgdGhlIG1lbW9yeSBhcyB1bmVuY3J5cHRlZC4NCj4gDQo+IFNvIHRoZSBvYnZpb3VzIHRyaXZp
YWwgZml4IGlzIHByb2JhYmx5IHRoZSByaWdodCBvbmU6DQoNClRoaXMgd2lsbCBwcmVzZW50IHBy
b2JsZW1zIHVuZGVyIFNFViAocHJvYmFibHkgbm90IFNNRSB1bmxlc3MgdGhlIERNQQ0KbWFzayBk
b2Vzbid0IHN1cHBvcnQgNDgtYml0IERNQSkgd2hlbiBhbiBOVk1lIGRldmljZSBpcyBwYXNzZWQg
dGhyb3VnaC4NClRoZSBEb2N1bWVudGF0aW9uIHN0YXRlcyB0aGF0IERNQV9BVFRSX05PX0tFUk5F
TF9NQVBQSU5HIGlzIHRvIGF2b2lkDQpjcmVhdGluZyB0aGUgbWFwcGluZyBiZWNhdXNlIG9mIHRp
bWUgYW5kIHJlc291cmNlcyB0aGF0IG1heSBiZSBpbnZvbHZlZA0Kb24gc29tZSBhcmNocy4gV291
bGQgaXQgbWFrZSBzZW5zZSB0byBjaGVjayBmb3IgbWVtb3J5IGVuY3J5cHRpb24gdXNpbmcNCmZv
cmNlX2RtYV91bmVuY3J5cHRlZCgpIGFuZCBvdmVycmlkZSB0aGUgZmxhZyBpbiB0aG9zZSBjYXNl
cz8gRG9lcyB4ODYNCmhhdmUgaXNzdWVzIHdoZXJlIHRoaXMgZmxhZyBpcyBuZWVkZWQ/IEl0IGNv
dWxkIGJlIHNldCB0aGF0IHRoZSBtYXBwaW5nDQppcyBvbmx5IGdlbmVyYXRlZCBpZiB5b3UgaGF2
ZSB0byBmb3JjZSBhbiB1bmVuY3J5cHRlZCBETUEuIFRoZSBjb2RlIGlzbid0DQphcyBjbGVhbiBh
bmQgeW91IHdvdWxkIGhhdmUgdG8gaGl0IHRoZSBkbWFfZGlyZWN0X2ZyZWVfcGFnZXMoKSBwYXRo
LCBhbHNvLg0KDQpJIHN1c3BlY3QgUG93ZXIgYW5kIHMzOTAgbWF5IGhhdmUgdGhlIHNhbWUgY29u
Y2VybnMgaGVyZSAoYWRkaW5nIHRoZW0gb24NCkNjOiBqdXN0IGluIGNhc2UpLg0KDQpUaGFua3Ms
DQpUb20NCg0KPiANCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL2RpcmVjdC5jIGIva2Vy
bmVsL2RtYS9kaXJlY3QuYw0KPiBpbmRleCA1OWJkY2VlYTM3MzcuLmM0OTEyMDE5MzMwOSAxMDA2
NDQNCj4gLS0tIGEva2VybmVsL2RtYS9kaXJlY3QuYw0KPiArKysgYi9rZXJuZWwvZG1hL2RpcmVj
dC5jDQo+IEBAIC0xMzUsNiArMTM1LDcgQEAgdm9pZCAqZG1hX2RpcmVjdF9hbGxvY19wYWdlcyhz
dHJ1Y3QgZGV2aWNlICpkZXYsIHNpemVfdCBzaXplLA0KPiAgCQlpZiAoIVBhZ2VIaWdoTWVtKHBh
Z2UpKQ0KPiAgCQkJYXJjaF9kbWFfcHJlcF9jb2hlcmVudChwYWdlLCBzaXplKTsNCj4gIAkJLyog
cmV0dXJuIHRoZSBwYWdlIHBvaW50ZXIgYXMgdGhlIG9wYXF1ZSBjb29raWUgKi8NCj4gKwkJKmRt
YV9oYW5kbGUgPSBwaHlzX3RvX2RtYShkZXYsIHBhZ2VfdG9fcGh5cyhwYWdlKSk7DQo+ICAJCXJl
dHVybiBwYWdlOw0KPiAgCX0NCj4gIA0KPiANCg==
