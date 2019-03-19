Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20E0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6C920854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="PnCTSyJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCSWh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:37:57 -0400
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:15428
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbfCSWhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnxEItvYFluVPaOcHToSEKKfQqY25SvwZtNbV+qE1uk=;
 b=PnCTSyJa1K080UhVVvVDQAtNmsLySIaphodLFwVRAYYPD6QCu0qsd1wa4xWKXJ4rDBQKxCCy5NYegY8LiJYNUiVIN1GquyXMyfe+LOvju6AfSw4cd94jSamchvCTc444qUQ8i+L++r9NrRDqhiKXgVAx+Res0L62hCThFSCF9og=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB5913.eurprd05.prod.outlook.com (20.179.9.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 22:37:47 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660%2]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 22:37:47 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "pakki001@umn.edu" <pakki001@umn.edu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Boris Pismenny <borisp@mellanox.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v4] net: mlx5: Add a missing check on idr_find, free buf
Thread-Topic: [PATCH v4] net: mlx5: Add a missing check on idr_find, free buf
Thread-Index: AQHU3py0/Q+8rPAh+0G/hpfTLlAQ7KYTi4SA
Date:   Tue, 19 Mar 2019 22:37:46 +0000
Message-ID: <03f5d2ac3d4e312cffcbc7e61cc10815c28dfeb7.camel@mellanox.com>
References: <20190319214244.20212-1-pakki001@umn.edu>
In-Reply-To: <20190319214244.20212-1-pakki001@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36f37595-a381-4ff9-6272-08d6acbb82b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB8PR05MB5913;
x-ms-traffictypediagnostic: DB8PR05MB5913:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-microsoft-antispam-prvs: <DB8PR05MB5913E97CC12A3946BBF18FD5BE400@DB8PR05MB5913.eurprd05.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(366004)(199004)(189003)(14444005)(446003)(6916009)(11346002)(14454004)(486006)(3846002)(36756003)(2616005)(6116002)(106356001)(478600001)(2906002)(5640700003)(66066001)(6512007)(6486002)(76176011)(229853002)(2501003)(6436002)(102836004)(105586002)(6506007)(316002)(118296001)(99286004)(25786009)(68736007)(8936002)(71190400001)(71200400001)(26005)(256004)(97736004)(305945005)(476003)(53936002)(8676002)(81156014)(81166006)(86362001)(5660300002)(4744005)(2351001)(2171002)(4326008)(7736002)(6246003)(186003)(54906003)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB5913;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ua+skLIya5U1HA7DU8is3t0pkAkK0RqV7jEpIZ3Hm4Tr83L7AicLMEDJyO9rDTMxblkgfQ56SpXNoEvLVBFgcs4ATx+JEW0r8zYMLf7Eyoiu6L4eyvpQKRdKeTl7GGE206OWeSaen7X4dDXpyTAgdH5+lHyE4elPlN2NyUk4Sg9koO039cRV7fWaEBKW0l+89lZ1QU6o+HZaSpV/TigojQMVXDkkWlTXa2dIockVoHYhu7tJykLyKUOk2z4eW8pbSR0eH9VRftrzftC5+46GdJG93VuEUQEEhzH3qR91nsgHoi/+1GyX9zCyMY5sJ4/fz/+68sxqIAcq6rgkrFLoajYYXVzb/9hqr8e+tozLnkYoTVKw7ExF3Aq+7z6CceGojAzSjgHZtPoqdjqtzIQtg3GnYSgoY0aPqypuw0ryw00=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6311568127E32E48B038A028A924A08B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f37595-a381-4ff9-6272-08d6acbb82b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 22:37:46.9232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB5913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAzLTE5IGF0IDE2OjQyIC0wNTAwLCBBZGl0eWEgUGFra2kgd3JvdGU6DQo+
IGlkcl9maW5kKCkgY2FuIHJldHVybiBhIE5VTEwgdmFsdWUgdG8gJ2Zsb3cnIHdoaWNoIGlzIHVz
ZWQgd2l0aG91dCBhDQo+IGNoZWNrLiBUaGUgcGF0Y2ggYWRkcyBhIGNoZWNrIHRvIGF2b2lkIHBv
dGVudGlhbCBOVUxMIHBvaW50ZXINCj4gZGVyZWZlcmVuY2UuDQo+IA0KPiBJbiBjYXNlIG9mIG1s
eDVfZnBnYV9zYnVfY29ubl9zZW5kbXNnKCkgZmFpbHVyZSwgZnJlZSBidWYgYWxsb2NhdGVkDQo+
IHVzaW5nIGt6YWxsb2MuDQo+IA0KPiBGaXhlczogYWI0MTJlMWRkN2RiICgibmV0L21seDU6IEFj
Y2VsLCBhZGQgVExTIHJ4IG9mZmxvYWQgcm91dGluZXMiKQ0KPiAtLS0NCj4gdjM6IFJlb3JkZXIg
YnVmIGFsbG9jYXRpb25zIGFuZCBmbG93IGNoZWNrLg0KPiB2MjogZmFpbHVyZSB0byByZXR1cm4g
aW4gY2FzZSBvZiBmbG93IGZhaWx1cmUuDQo+IHYxOiBGYWlsZWQgdG8gZnJlZSBidWYgaW4gY2Fz
ZSBvZiBmbG93IGZhaWx1cmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBZGl0eWEgUGFra2kgPHBh
a2tpMDAxQHVtbi5lZHU+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gv
bWx4NS9jb3JlL2ZwZ2EvdGxzLmMgfCAxNCArKysrKysrKysrKy0NCj4gLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCg0KQXBwbGllZCB0
byBuZXQtbWx4NSwgd2lsbCBiZSBzZW50IHVwc3RyZWFtIHNob3J0bHksDQoNCllvdSBtZXNzZWQg
dXAgdGhlIFNpZ25lZC1vZmYgdGFnLCBpdCBhbHNvIHNob3VsZCBoYXZlIGJlZW4gcGFydCBvZiB0
aGUNCmNvbW1pdCBtZXNzYWdlLCBidXQgZG9uJ3Qgd29ycnksIGkgZml4ZWQgaXQgdXAgYW5kIGFk
ZGVkIFl1dmFsJ3MNClJldmlld2VkLWJ5Lg0KDQpUaGFua3MgQWRlaXR5YSBmb3IgaGFuZGxpbmcg
YWxsIG9mIHRoZSBjb21tZW50cy4NClNhZWVkLg0KDQo=
