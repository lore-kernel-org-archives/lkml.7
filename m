Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2739BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF0420833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="KChuzRkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfDHSr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:47:56 -0400
Received: from mail-eopbgr820058.outbound.protection.outlook.com ([40.107.82.58]:25365
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbfDHSr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIdNsSLVH2hh5zGk/ICxSFOHgDl30IbEJy3O8LbL9Aw=;
 b=KChuzRkE1Nz02tnvaugxkWDJJC5zBSjcPcDYEgV3n1haQUwNWI4mGRPAJ/r0Ds3CsFQIhd8GLNnx0zGE10GRih9Ppp/z94jEIQnfOhhQPBELYl8B8yI7U7A/mhsprk6t8fqwiuntHtiJRjZLu4KRkn3ObTC62yEQtseIpk8azxk=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6605.namprd05.prod.outlook.com (20.178.248.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.8; Mon, 8 Apr 2019 18:47:52 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1792.009; Mon, 8 Apr 2019
 18:47:52 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hch@lst.de" <hch@lst.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Deepak Singh Rawat <drawat@vmware.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: revert dma direct internals abuse
Thread-Topic: revert dma direct internals abuse
Thread-Index: AQHU7fmi7IV/x30l7UexE5gP02MWCKYymy+A
Date:   Mon, 8 Apr 2019 18:47:52 +0000
Message-ID: <7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
In-Reply-To: <20190408105525.5493-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 704abf75-30df-4f09-4ef6-08d6bc52b4e7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6605;
x-ms-traffictypediagnostic: MN2PR05MB6605:
x-microsoft-antispam-prvs: <MN2PR05MB6605FFAE3F7300D1244B1A19A12C0@MN2PR05MB6605.namprd05.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(36756003)(446003)(3846002)(81166006)(81156014)(5660300002)(2616005)(97736004)(486006)(476003)(11346002)(99286004)(316002)(14444005)(6116002)(256004)(2501003)(68736007)(71190400001)(71200400001)(118296001)(86362001)(106356001)(7736002)(305945005)(105586002)(8676002)(110136005)(6246003)(6512007)(54906003)(2906002)(4326008)(14454004)(6506007)(478600001)(6436002)(8936002)(26005)(229853002)(76176011)(6486002)(25786009)(102836004)(186003)(53936002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6605;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5huBmpd/OcXofqbOxzjcEaSUZegvOHyppkTdudErT5BLfehl6f/3Sjcx6ziVvNa5MCOz5DZJ12qT+mgK7NJVGsOPBBIJ/J9RvNXu1Sc3xz5OJ9wMTLKwwgcNYUt/aBaTM8DKwk2Ox8pZ0uWBFJbWYjEv9gHMIrJLkbFydiPwiLL9QiPqfVaQdI5vC0uPPC7ugry6CjeS3zZhqK2THlrnMbDsmJt8aWe6St0JCYuuFEEHO6wW/39asueYFg6dpQlNXpII/A04slc5ULpHHzil0X1ci84a6uHkZXj78jSzPBBEPrzbJaSeKJewQRIoXf1o2X2tzuDAt+/VhTGGq3mlxNaJ3rhDeerdWVpVSEVqrnUxvaehvPMfymzPhxh7yJ9ofj0jUvufhgplcdKwNfZxQglNh34C3ihP7//Lh+Fn8lQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4C855632C5C4A4A994C7890F5A162D2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704abf75-30df-4f09-4ef6-08d6bc52b4e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 18:47:52.6270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hyaXN0b3BoLA0KDQoNCk9uIE1vbiwgMjAxOS0wNC0wOCBhdCAxMjo1NSArMDIwMCwgQ2hyaXN0
b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEhpIExpbnVzLA0KPiANCj4gdW5mb3J0dW5hdGVseSBpdCB0
b29rIGxlc3MgdGhhbiBhIG1lcmdlIHdpbmRvdyBmb3IgdGhlOg0KPiANCj4gLyoNCj4gICogQWxs
IHRoZSBkbWFfZGlyZWN0XyogZGVjbGFyYXRpb25zIGFyZSBoZXJlIGp1c3QgZm9yIHRoZSBpbmRp
cmVjdA0KPiBjYWxsIGJ5cGFzcywNCj4gICogYW5kIG11c3Qgbm90IGJlIHVzZWQgZGlyZWN0bHkg
ZHJpdmVycyENCj4gICovDQo+IA0KPiB3YXJuaW5nIGluIGRtYS1tYXBwaW5nLmggdG8gYmUgaWdu
b3JlZC4gIFRoaXMgc2VyaWVzIHJldmVydHMgdGhlDQo+IG9mZmVuZGVyDQo+IHRvIGtlZXAgb3Vy
IEFQSSBjbGVhbi4NCj4gDQo+IFRob21hczogcGxlYXNlIHRhbGsgbWUgZmlyc3QgYWJvdXQgeW91
ciBuZWVkcyBhbmQgSSdsbCBiZSBoYXBweSB0bw0KPiBmaWd1cmUgb3V0DQo+IGEgcHJvcGVyIEFQ
SSBmb3Igd2hhdCB5b3Ugd2FudCB0byBkby4NCg0KV2UgSEFWRSBkaXNjdXNzZWQgb3VyIG5lZWRz
LCBhbHRob3VnaCBhZG1pdHRlZGx5IHNvbWUgb2YgbXkgZW1haWxzDQplbmRlZCB1cCB1bmFuc3dl
cmVkLg0KDQpXZSd2ZSBhcyB5b3UncmUgd2VsbCBhd2FyZSBvZiBoYWQgYSBkaXNjdXNzaW9uIHdp
dGggdGhlIG90aGVyDQpzdWJzeXN0ZW1zIGRvaW5nIHVzZXItc3BhY2UgRE1BLWJ1ZmZlcnMgd2Fu
dGluZyB0aGlzIGZ1bmN0aW9uYWxpdHkgZnJvbQ0KdGhlIGRtYSBhcGkgKEFNRCBncmFwaGljcyBh
bmQgUkRNQSBwZW9wbGUgSUlSQykuIHRoYXQgaXMgYSBib29sIHRoYXQNCnRlbGxzIHVzIHdoZXRo
ZXIgc3RyZWFtaW5nIGRtYSBtYXBwaW5ncyBhcmUgY29oZXJlbnQsIGFuZCBJIGRlc2NyaWJlZA0K
aW4gZGV0YWlsIHdoeSB3ZSBjb3VsZG4ndCB1c2UgdGhlIGRtYV9zeW5jXyogQVBJIGFuZA0KZG1h
X2FsbG9jX2NvaGVyZW50KCkuDQoNClRoZSBvdGhlciBvcHRpb24gd2UgaGF2ZSBpcyB0byBqdXN0
IGZhaWwgbWlzZXJhYmx5IHdpdGhvdXQgbWVzc2FnZXMgaWYNCnN0cmVhbWluZyBETUEgaXMgbm90
IGNvaGVyZW50LCB3aGljaCBJIHRoaW5rIHRoZSBvdGhlciBkcml2ZXJzIG1pZ2h0DQpkby4uLiBU
aGF0J3MgYWxsIEknbSB0cnlpbmcgdG8gYXZvaWQgaGVyZS4gSSdkIG11Y2ggcHJlZmVyIHRvIGhh
dmUgdGhlDQpkbWEgQVBJIGV4cG9ydCB0aGlzIGJvb2wuDQoNCi9UaG9tYXMNCg0KDQoNCg0KDQoN
Cg==
