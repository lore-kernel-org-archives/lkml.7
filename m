Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72376C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210DA2339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lCHB0hJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfHUHrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:47:52 -0400
Received: from mail-eopbgr730135.outbound.protection.outlook.com ([40.107.73.135]:64736
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbfHUHrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:47:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXU1tPWJXaWPSKEn0pmnG/DDvwx9QstW3INUSl5D1VPU4nZe3MmrE4SwXiX73/pwBBO47swdNGMj18TE8IC0al8b/ejtfTKgkn2hstpn+5GtmYLQ0gNj0+Gyh3Nyj12PaFTZq8Dp6iYIqzOK/URmPdA98P48x8HlnDILjNAg1NlkCuMUfd7EJBGq//IvEgKvR1oqdfTgz/29qBY+ToggjovSlHeBq0/t52vQGqkE0+jB1f03ZzuokxydcUxU2iZdj1NYqCzThTBOJcUmIAh/+PwcsJmaeBKYMfxfj1+OV5YcvUzeREhnS34IIUcUhSzguxVzIURz83xEmFs0mEe75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/gKpJH3VdkTzcxgpUR1+dKVB4Rs+LLwLKjxb+PzXAo=;
 b=QV6nB0vgbyWmQktuKVGcfPiUqyVdvuqATAjevn8t1h/sDBPWDoe5NdHvOyqZDYfqL4gbuNEl5UBvFmzQ8nHgMakY1T6Gypqew7MBePv5LCOI7U0GOVk5k3lJeMOWzpqAgD7JGD6GYOOIJbvJmaXD+ZDJeHDrFEaTKx+zceY7iEIl+8O1AgRTpiPz1Se//rxd5+hQ2N9NBhkloE06n+aMtQce/KL5uD3lI80qJSav3hW61UMSsrSTsmMiPfnJiv8GoTd8o95iitdnm0fCTfbCiWIYlH+yRtUUsSwF2XhFweG65yaexKfUg0wU+ANDfVfnGQ95YWDLejiu39r1cqp4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/gKpJH3VdkTzcxgpUR1+dKVB4Rs+LLwLKjxb+PzXAo=;
 b=lCHB0hJC77TKL5H1bHY6QnxRzMyqr34iWRCRgnzjWyVBj6tybaYPa8nsKn4FCskIGD6jkqFTRvTk3T8OFGUYx3vEDtr3DuCNXUMN+3cd7o21P5ZvgLBI/BYBwQlENLCiJQroYfaM5y1i4mXEltcMkLRboQOXK1Ah2jQM83tjcqs=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0758.namprd21.prod.outlook.com (10.173.192.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.2220.3; Wed, 21 Aug 2019 07:47:44 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d%11]) with mapi id 15.20.2220.000; Wed, 21 Aug
 2019 07:47:44 +0000
From:   Long Li <longli@microsoft.com>
To:     John Garry <john.garry@huawei.com>,
        Ming Lei <tom.leiming@gmail.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: RE: [PATCH 0/3] fix interrupt swamp in NVMe
Thread-Topic: [PATCH 0/3] fix interrupt swamp in NVMe
Thread-Index: AQHVVx6PT//gmViwZUu9hv4+3aJrE6cDs4qAgAAJYgCAAXaqoA==
Date:   Wed, 21 Aug 2019 07:47:44 +0000
Message-ID: <CY4PR21MB0741D1CD295AD572548E61D1CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <CACVXFVPCiTU0mtXKS0fyMccPXN6hAdZNHv6y-f8-tz=FE=BV=g@mail.gmail.com>
 <fd7d6101-37f4-2d34-f2f7-cfeade610278@huawei.com>
In-Reply-To: <fd7d6101-37f4-2d34-f2f7-cfeade610278@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:ede6:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63f63007-b390-4dbf-5db2-08d7260bda59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0758;
x-ms-traffictypediagnostic: CY4PR21MB0758:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR21MB0758939EB3EC9111587E62FACEAA0@CY4PR21MB0758.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(486006)(229853002)(22452003)(74316002)(71190400001)(2906002)(7416002)(14454004)(53936002)(316002)(110136005)(478600001)(305945005)(33656002)(5660300002)(76176011)(52536014)(186003)(4326008)(6116002)(9686003)(55016002)(66476007)(6246003)(25786009)(64756008)(66556008)(14444005)(6506007)(7736002)(446003)(66946007)(256004)(76116006)(53546011)(46003)(54906003)(10090500001)(81166006)(81156014)(6436002)(8990500004)(66446008)(8676002)(71200400001)(102836004)(86362001)(2501003)(10290500003)(7696005)(6306002)(8936002)(11346002)(99286004)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0758;H:CY4PR21MB0741.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xi2S+yOuj8hbTTQIH6e740ZPQfttOt/pGHuBFsPlcocUaz5svYetFBPHLzobgZv0+41N4zDZTGymXZ7MI6nkeslE7t1TtJIIQLQteRsRXhFduPHTp3SlmVJiqhqEcChcFoeP1LbswhzFP2mkDhOfqsbVZbNYesxJUhFH8ZeeelItY85MCSVrm469We1UQRZcvoU/WInSDfqwVJ1zIozZ+UpHfGXPsxT/rTaalB+BTRETUe/Cv+4na9Z2U7/95VrpVKiYlFxR/njcRu5SAGFmRnAOaIUV4OD31znd2N5YkPAtqEAhFU3/buLiUWEyf+X9KhNlEJDSTZr3ukqefYBww/3jq9NcBdh2FI8fLYdD1iKwp5Bs3DIJC6T78CeKEts45r92jzFdn+pVNlsAhmw6H55rwNvLVwPdVAGNDTqrHP8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f63007-b390-4dbf-5db2-08d7260bda59
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 07:47:44.4470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6Za4lqjhavOXWk45LbDyQ5kahj6RPDN8ZWJJ21zwh+f58WFviBCru/tChO/mhXK7eMB1HflR9Brc8iGGa43xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0758
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+U3ViamVjdDogUmU6IFtQQVRDSCAwLzNdIGZpeCBpbnRlcnJ1cHQgc3dhbXAgaW4gTlZNZQ0K
Pj4+DQo+Pj5PbiAyMC8wOC8yMDE5IDA5OjI1LCBNaW5nIExlaSB3cm90ZToNCj4+Pj4gT24gVHVl
LCBBdWcgMjAsIDIwMTkgYXQgMjoxNCBQTSA8bG9uZ2xpQGxpbnV4b25oeXBlcnYuY29tPiB3cm90
ZToNCj4+Pj4+DQo+Pj4+PiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4+
Pj4+DQo+Pj4+PiBUaGlzIHBhdGNoIHNldCB0cmllcyB0byBmaXggaW50ZXJydXB0IHN3YW1wIGlu
IE5WTWUgZGV2aWNlcy4NCj4+Pj4+DQo+Pj4+PiBPbiBsYXJnZSBzeXN0ZW1zIHdpdGggbWFueSBD
UFVzLCBhIG51bWJlciBvZiBDUFVzIG1heSBzaGFyZSBvbmUNCj4+Pk5WTWUNCj4+Pj4+IGhhcmR3
YXJlIHF1ZXVlLiBJdCBtYXkgaGF2ZSB0aGlzIHNpdHVhdGlvbiB3aGVyZSBzZXZlcmFsIENQVXMg
YXJlDQo+Pj4+PiBpc3N1aW5nIEkvT3MsIGFuZCBhbGwgdGhlIEkvT3MgYXJlIHJldHVybmVkIG9u
IHRoZSBDUFUgd2hlcmUgdGhlDQo+Pj5oYXJkd2FyZSBxdWV1ZSBpcyBib3VuZCB0by4NCj4+Pj4+
IFRoaXMgbWF5IHJlc3VsdCBpbiB0aGF0IENQVSBzd2FtcGVkIGJ5IGludGVycnVwdHMgYW5kIHN0
YXkgaW4NCj4+Pj4+IGludGVycnVwdCBtb2RlIGZvciBleHRlbmRlZCB0aW1lIHdoaWxlIG90aGVy
IENQVXMgY29udGludWUgdG8gaXNzdWUNCj4+Pj4+IEkvTy4gVGhpcyBjYW4gdHJpZ2dlciBXYXRj
aGRvZyBhbmQgUkNVIHRpbWVvdXQsIGFuZCBtYWtlIHRoZSBzeXN0ZW0NCj4+PnVucmVzcG9uc2l2
ZS4NCj4+Pj4+DQo+Pj4+PiBUaGlzIHBhdGNoIHNldCBhZGRyZXNzZXMgdGhpcyBieSBlbmZvcmNp
bmcgc2NoZWR1bGluZyBhbmQgdGhyb3R0bGluZw0KPj4+Pj4gSS9PIHdoZW4gQ1BVIGlzIHN0YXJ2
ZWQgaW4gdGhpcyBzaXR1YXRpb24uDQo+Pj4+Pg0KPj4+Pj4gTG9uZyBMaSAoMyk6DQo+Pj4+PiAg
IHNjaGVkOiBkZWZpbmUgYSBmdW5jdGlvbiB0byByZXBvcnQgdGhlIG51bWJlciBvZiBjb250ZXh0
IHN3aXRjaGVzIG9uIGENCj4+Pj4+ICAgICBDUFUNCj4+Pj4+ICAgc2NoZWQ6IGV4cG9ydCBpZGxl
X2NwdSgpDQo+Pj4+PiAgIG52bWU6IGNvbXBsZXRlIHJlcXVlc3QgaW4gd29yayBxdWV1ZSBvbiBD
UFUgd2l0aCBmbG9vZGVkIGludGVycnVwdHMNCj4+Pj4+DQo+Pj4+PiAgZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jIHwgNTcNCj4+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0NCj4+Pj4+ICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggfCAgMSArDQo+Pj4+PiAgaW5j
bHVkZS9saW51eC9zY2hlZC5oICAgIHwgIDIgKysNCj4+Pj4+ICBrZXJuZWwvc2NoZWQvY29yZS5j
ICAgICAgfCAgNyArKysrKw0KPj4+Pj4gIDQgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0KPj4+PiBBbm90aGVyIHNpbXBsZXIgc29sdXRpb24gbWF5
IGJlIHRvIGNvbXBsZXRlIHJlcXVlc3QgaW4gdGhyZWFkZWQNCj4+Pj4gaW50ZXJydXB0IGhhbmRs
ZXIgZm9yIHRoaXMgY2FzZS4gTWVhbnRpbWUgYWxsb3cgc2NoZWR1bGVyIHRvIHJ1biB0aGUNCj4+
Pj4gaW50ZXJydXB0IHRocmVhZCBoYW5kbGVyIG9uIENQVXMgc3BlY2lmaWVkIGJ5IHRoZSBpcnEg
YWZmaW5pdHkgbWFzaywNCj4+Pj4gd2hpY2ggd2FzIGRpc2N1c3NlZCBieSB0aGUgZm9sbG93aW5n
IGxpbms6DQo+Pj4+DQo+Pj4+DQo+Pj5odHRwczovL25hbTA2LnNhZmVsaW5rcy5wcm90ZWN0aW9u
Lm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3INCj4+PmUNCj4+Pj4gLmtlcm5lbC5v
cmclMkZsa21sJTJGZTBlOTQ3OGUtNjJhNS1jYTI0LTNiMTItDQo+Pj41OGY3ZDA1NjM4M2UlNDBo
dWF3ZWkuY29tDQo+Pj4+ICUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDbG9uZ2xpJTQwbWljcm9zb2Z0
LmNvbSU3Q2M3ZjQ2ZDNlMjczZjQ1DQo+Pj4xNzZkMWMwOA0KPj4+Pg0KPj4+ZDcyNTRjYzY5ZSU3
QzcyZjk4OGJmODZmMTQxYWY5MWFiMmQ3Y2QwMTFkYjQ3JTdDMSU3QzAlN0M2MzcwMTg4DQo+Pj44
NDAxNTg4DQo+Pj4+DQo+Pj45ODY2JmFtcDtzZGF0YT1oNWs2SG9Hb3lEeHVobURmdUtMWlV3Z213
MTdQVSUyQlQlMkZDYmF3ZnhWDQo+Pj5FcjNVJTNEJmFtcDsNCj4+Pj4gcmVzZXJ2ZWQ9MA0KPj4+
Pg0KPj4+PiBDb3VsZCB5b3UgdHJ5IHRoZSBhYm92ZSBzb2x1dGlvbiBhbmQgc2VlIGlmIHRoZSBs
b2NrdXAgY2FuIGJlIGF2b2lkZWQ/DQo+Pj4+IEpvaG4gR2FycnkNCj4+Pj4gc2hvdWxkIGhhdmUg
d29ya2FibGUgcGF0Y2guDQo+Pj4NCj4+PlllYWgsIHNvIHdlIGV4cGVyaW1lbnRlZCB3aXRoIGNo
YW5naW5nIHRoZSBpbnRlcnJ1cHQgaGFuZGxpbmcgaW4gdGhlIFNDU0kNCj4+PmRyaXZlciBJIG1h
aW50YWluIHRvIHVzZSBhIHRocmVhZGVkIGhhbmRsZXIgSVJRIGhhbmRsZXIgcGx1cyBwYXRjaCBi
ZWxvdywNCj4+PmFuZCBzYXcgYSBzaWduaWZpY2FudCB0aHJvdWdocHV0IGJvb3N0Og0KPj4+DQo+
Pj4tLS0+OA0KPj4+DQo+Pj5TdWJqZWN0OiBbUEFUQ0hdIGdlbmlycTogQWRkIHN1cHBvcnQgdG8g
YWxsb3cgdGhyZWFkIHRvIHVzZSBoYXJkIGlycSBhZmZpbml0eQ0KPj4+DQo+Pj5DdXJyZW50bHkg
dGhlIGNwdSBhbGxvd2VkIG1hc2sgZm9yIHRoZSB0aHJlYWRlZCBwYXJ0IG9mIGEgdGhyZWFkZWQg
aXJxDQo+Pj5oYW5kbGVyIHdpbGwgYmUgc2V0IHRvIHRoZSBlZmZlY3RpdmUgYWZmaW5pdHkgb2Yg
dGhlIGhhcmQgaXJxLg0KPj4+DQo+Pj5UeXBpY2FsbHkgdGhlIGVmZmVjdGl2ZSBhZmZpbml0eSBv
ZiB0aGUgaGFyZCBpcnEgd2lsbCBiZSBmb3IgYSBzaW5nbGUgY3B1LiBBcyBzdWNoLA0KPj4+dGhl
IHRocmVhZGVkIGhhbmRsZXIgd291bGQgYWx3YXlzIHJ1biBvbiB0aGUgc2FtZSBjcHUgYXMgdGhl
IGhhcmQgaXJxLg0KPj4+DQo+Pj5XZSBoYXZlIHNlZW4gc2NlbmFyaW9zIGluIGhpZ2ggZGF0YS1y
YXRlIHRocm91Z2hwdXQgdGVzdGluZyB0aGF0IHRoZSBjcHUNCj4+PmhhbmRsaW5nIHRoZSBpbnRl
cnJ1cHQgY2FuIGJlIHRvdGFsbHkgc2F0dXJhdGVkIGhhbmRsaW5nIGJvdGggdGhlIGhhcmQNCj4+
PmludGVycnVwdCBhbmQgdGhyZWFkZWQgaGFuZGxlciBwYXJ0cywgbGltaXRpbmcgdGhyb3VnaHB1
dC4NCj4+Pg0KPj4+QWRkIElSUUZfSVJRX0FGRklOSVRZIGZsYWcgdG8gYWxsb3cgdGhlIGRyaXZl
ciByZXF1ZXN0aW5nIHRoZSB0aHJlYWRlZA0KPj4+aW50ZXJydXB0IHRvIGRlY2lkZSBvbiB0aGUg
cG9saWN5IG9mIHdoaWNoIGNwdSB0aGUgdGhyZWFkZWQgaGFuZGxlciBtYXkgcnVuLg0KPj4+DQo+
Pj5TaWduZWQtb2ZmLWJ5OiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+DQoNClRo
YW5rcyBmb3IgcG9pbnRpbmcgbWUgdG8gdGhpcyBwYXRjaC4gVGhpcyBmaXhlZCB0aGUgaW50ZXJy
dXB0IHN3YW1wIGFuZCBtYWtlIHRoZSBzeXN0ZW0gc3RhYmxlLg0KDQpIb3dldmVyIEknbSBzZWVp
bmcgcmVkdWNlZCBwZXJmb3JtYW5jZSB3aGVuIHVzaW5nIHRocmVhZGVkIGludGVycnVwdHMuDQoN
CkhlcmUgYXJlIHRoZSB0ZXN0IHJlc3VsdHMgb24gYSBzeXN0ZW0gd2l0aCA4MCBDUFVzIGFuZCAx
MCBOVk1lIGRpc2tzICgzMiBoYXJkd2FyZSBxdWV1ZXMgZm9yIGVhY2ggZGlzaykNCkJlbmNobWFy
ayB0b29sIGlzIEZJTywgSS9PIHBhdHRlcm46IDRrIHJhbmRvbSByZWFkcyBvbiBhbGwgTlZNZSBk
aXNrcywgd2l0aCBxdWV1ZSBkZXB0aCA9IDY0LCBudW0gb2Ygam9icyA9IDgwLCBkaXJlY3Q9MQ0K
DQpXaXRoIHRocmVhZGVkIGludGVycnVwdHM6IDEzMjBrIElPUFMNCldpdGgganVzdCBpbnRlcnJ1
cHRzOiAzNzIwayBJT1BTDQpXaXRoIGp1c3QgaW50ZXJydXB0cyBhbmQgbXkgcGF0Y2g6IDM3MDBr
IElPUFMNCg0KQXQgdGhlIHBlYWsgSU9QUywgdGhlIG92ZXJhbGwgQ1BVIHVzYWdlIGlzIGF0IGFy
b3VuZCA5OC05OSUuIEkgdGhpbmsgdGhlIGNvc3Qgb2YgZG9pbmcgd2FrZSB1cCBhbmQgY29udGV4
dCBzd2l0Y2ggZm9yIE5WTWUgdGhyZWFkZWQgSVJRIGhhbmRsZXIgdGFrZXMgc29tZSBDUFUgYXdh
eS4NCg0KSW4gdGhpcyB0ZXN0LCBJIG1hZGUgdGhlIGZvbGxvd2luZyBjaGFuZ2UgdG8gbWFrZSB1
c2Ugb2YgSVJRRl9JUlFfQUZGSU5JVFkgZm9yIE5WTWU6DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9pcnEuYyBiL2RyaXZlcnMvcGNpL2lycS5jDQppbmRleCBhMWRlNTAxYTI3MjkuLjNmYjMw
ZDE2NDY0ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGNpL2lycS5jDQorKysgYi9kcml2ZXJzL3Bj
aS9pcnEuYw0KQEAgLTg2LDcgKzg2LDcgQEAgaW50IHBjaV9yZXF1ZXN0X2lycShzdHJ1Y3QgcGNp
X2RldiAqZGV2LCB1bnNpZ25lZCBpbnQgbnIsIGlycV9oYW5kbGVyX3QgaGFuZGxlciwNCiAgICAg
ICAgdmFfbGlzdCBhcDsNCiAgICAgICAgaW50IHJldDsNCiAgICAgICAgY2hhciAqZGV2bmFtZTsN
Ci0gICAgICAgdW5zaWduZWQgbG9uZyBpcnFmbGFncyA9IElSUUZfU0hBUkVEOw0KKyAgICAgICB1
bnNpZ25lZCBsb25nIGlycWZsYWdzID0gSVJRRl9TSEFSRUQgfCBJUlFGX0lSUV9BRkZJTklUWTsN
Cg0KICAgICAgICBpZiAoIWhhbmRsZXIpDQogICAgICAgICAgICAgICAgaXJxZmxhZ3MgfD0gSVJR
Rl9PTkVTSE9UOw0KDQpUaGFua3MNCg0KTG9uZw0KDQo+Pj4NCj4+PmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2ludGVycnVwdC5oIGIvaW5jbHVkZS9saW51eC9pbnRlcnJ1cHQuaCBpbmRleA0K
Pj4+NWI4MzI4YTk5YjJhLi40OGU4Yjk1NTk4OWEgMTAwNjQ0DQo+Pj4tLS0gYS9pbmNsdWRlL2xp
bnV4L2ludGVycnVwdC5oDQo+Pj4rKysgYi9pbmNsdWRlL2xpbnV4L2ludGVycnVwdC5oDQo+Pj5A
QCAtNjEsNiArNjEsOSBAQA0KPj4+ICAgKiAgICAgICAgICAgICAgICBpbnRlcnJ1cHQgaGFuZGxl
ciBhZnRlciBzdXNwZW5kaW5nIGludGVycnVwdHMuIEZvcg0KPj4+c3lzdGVtDQo+Pj4gICAqICAg
ICAgICAgICAgICAgIHdha2V1cCBkZXZpY2VzIHVzZXJzIG5lZWQgdG8gaW1wbGVtZW50IHdha2V1
cA0KPj4+ZGV0ZWN0aW9uIGluDQo+Pj4gICAqICAgICAgICAgICAgICAgIHRoZWlyIGludGVycnVw
dCBoYW5kbGVycy4NCj4+PisgKiBJUlFGX0lSUV9BRkZJTklUWSAtIFVzZSB0aGUgaGFyZCBpbnRl
cnJ1cHQgYWZmaW5pdHkgZm9yIHNldHRpbmcgdGhlIGNwdQ0KPj4+KyAqICAgICAgICAgICAgICAg
IGFsbG93ZWQgbWFzayBmb3IgdGhlIHRocmVhZGVkIGhhbmRsZXIgb2YgYSB0aHJlYWRlZA0KPj4+
aW50ZXJydXB0DQo+Pj4rICogICAgICAgICAgICAgICAgaGFuZGxlciwgcmF0aGVyIHRoYW4gdGhl
IGVmZmVjdGl2ZSBoYXJkIGlycSBhZmZpbml0eS4NCj4+PiAgICovDQo+Pj4gICNkZWZpbmUgSVJR
Rl9TSEFSRUQJCTB4MDAwMDAwODANCj4+PiAgI2RlZmluZSBJUlFGX1BST0JFX1NIQVJFRAkweDAw
MDAwMTAwDQo+Pj5AQCAtNzQsNiArNzcsNyBAQA0KPj4+ICAjZGVmaW5lIElSUUZfTk9fVEhSRUFE
CQkweDAwMDEwMDAwDQo+Pj4gICNkZWZpbmUgSVJRRl9FQVJMWV9SRVNVTUUJMHgwMDAyMDAwMA0K
Pj4+ICAjZGVmaW5lIElSUUZfQ09ORF9TVVNQRU5ECTB4MDAwNDAwMDANCj4+PisjZGVmaW5lIElS
UUZfSVJRX0FGRklOSVRZCTB4MDAwODAwMDANCj4+Pg0KPj4+ICAjZGVmaW5lIElSUUZfVElNRVIJ
CShfX0lSUUZfVElNRVIgfCBJUlFGX05PX1NVU1BFTkQgfA0KPj4+SVJRRl9OT19USFJFQUQpDQo+
Pj4NCj4+PmRpZmYgLS1naXQgYS9rZXJuZWwvaXJxL21hbmFnZS5jIGIva2VybmVsL2lycS9tYW5h
Z2UuYyBpbmRleA0KPj4+ZThmN2YxNzliZjc3Li5jYjQ4M2EwNTU1MTIgMTAwNjQ0DQo+Pj4tLS0g
YS9rZXJuZWwvaXJxL21hbmFnZS5jDQo+Pj4rKysgYi9rZXJuZWwvaXJxL21hbmFnZS5jDQo+Pj5A
QCAtOTY2LDkgKzk2NiwxMyBAQCBpcnFfdGhyZWFkX2NoZWNrX2FmZmluaXR5KHN0cnVjdCBpcnFf
ZGVzYyAqZGVzYywNCj4+PnN0cnVjdCBpcnFhY3Rpb24gKmFjdGlvbikNCj4+PiAgCSAqIG1hc2sg
cG9pbnRlci4gRm9yIENQVV9NQVNLX09GRlNUQUNLPW4gdGhpcyBpcyBvcHRpbWl6ZWQgb3V0Lg0K
Pj4+ICAJICovDQo+Pj4gIAlpZiAoY3B1bWFza19hdmFpbGFibGUoZGVzYy0+aXJxX2NvbW1vbl9k
YXRhLmFmZmluaXR5KSkgew0KPj4+KwkJc3RydWN0IGlycV9kYXRhICppcnFfZGF0YSA9ICZkZXNj
LT5pcnFfZGF0YTsNCj4+PiAgCQljb25zdCBzdHJ1Y3QgY3B1bWFzayAqbTsNCj4+Pg0KPj4+LQkJ
bSA9IGlycV9kYXRhX2dldF9lZmZlY3RpdmVfYWZmaW5pdHlfbWFzaygmZGVzYy0NCj4+Pj5pcnFf
ZGF0YSk7DQo+Pj4rCQlpZiAoYWN0aW9uLT5mbGFncyAmIElSUUZfSVJRX0FGRklOSVRZKQ0KPj4+
KwkJCW0gPSBkZXNjLT5pcnFfY29tbW9uX2RhdGEuYWZmaW5pdHk7DQo+Pj4rCQllbHNlDQo+Pj4r
CQkJbSA9IGlycV9kYXRhX2dldF9lZmZlY3RpdmVfYWZmaW5pdHlfbWFzayhpcnFfZGF0YSk7DQo+
Pj4gIAkJY3B1bWFza19jb3B5KG1hc2ssIG0pOw0KPj4+ICAJfSBlbHNlIHsNCj4+PiAgCQl2YWxp
ZCA9IGZhbHNlOw0KPj4+LS0NCj4+PjIuMTcuMQ0KPj4+DQo+Pj5BcyBNaW5nIG1lbnRpb25lZCBp
biB0aGF0IHNhbWUgdGhyZWFkLCB3ZSBjb3VsZCBldmVuIG1ha2UgdGhpcyBwb2xpY3kgZm9yDQo+
Pj5tYW5hZ2VkIGludGVycnVwdHMuDQo+Pj4NCj4+PkNoZWVycywNCj4+PkpvaG4NCj4+Pg0KPj4+
Pg0KPj4+PiBUaGFua3MsDQo+Pj4+IE1pbmcgTGVpDQo+Pj4+DQo+Pj4+IC4NCj4+Pj4NCj4+Pg0K
DQo=
