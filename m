Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1D32084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="kvtpVgrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfCKSqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:46:37 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:3504
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbfCKSqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHTbbiUfasIIGzDRzp5warRyIfmk+oGqPRaYsfAtPgw=;
 b=kvtpVgrsrvFD6EVrS7l6Tjt5nMbJ5tkj+S6bDC73RsjdyO9W5VLD7RPFreSNRNw+lcN8fNZYm5ERcSVor3g7pEneaujvpQoIhs6sn7b5eapiXkjujo7eUu9fFRWBioUF3Wus2woBh6FQJpSrBNdKVxeZc3LQEedp18W7RXDYDtg=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB5978.eurprd05.prod.outlook.com (20.179.9.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19; Mon, 11 Mar 2019 18:46:31 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 18:46:31 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "kjlu@umn.edu" <kjlu@umn.edu>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pakki001@umn.edu" <pakki001@umn.edu>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mlx5: fix a potential NULL pointer dereference
Thread-Topic: [PATCH] net: mlx5: fix a potential NULL pointer dereference
Thread-Index: AQHU19RsRnFR7ixZ6kW8dezUSYpBEaYGxdGA
Date:   Mon, 11 Mar 2019 18:46:31 +0000
Message-ID: <8cac48f6d213302c63355d40c0fba36b9e966127.camel@mellanox.com>
References: <20190311063343.20188-1-kjlu@umn.edu>
In-Reply-To: <20190311063343.20188-1-kjlu@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f22eaec-5d1d-4e2a-fc85-08d6a651e0f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB8PR05MB5978;
x-ms-traffictypediagnostic: DB8PR05MB5978:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjhQUjA1TUI1OTc4OzIzOldSUGpUNnhXL29kdWIvM1hkcUJnR2dJK01a?=
 =?utf-8?B?Q2l2cXBlQjcwTGV2ZFo3dng0eVM3V2RrM2p2NzNRSzRkR2xLTmxxdG1Zcm1U?=
 =?utf-8?B?TDRJT3ZUTFJHUmN2TGxaOEZURURBVFhwcUlVREdGWHNVWkZVSWNBSTB3Ukla?=
 =?utf-8?B?NUdXdU16SVVWb2ZOZnJzdGJRZ3M4anJXZHNoR0wxdTd0cmVDSGkxZHBPcXZh?=
 =?utf-8?B?ZFRXSm5UYkR4byt6TTc4cDlsNXJJY0xIZWdta0dtNnlyU2lsTHNMNjlMQ05y?=
 =?utf-8?B?cVkrVnhQRUJOTlY5VHRZZUlqcm8rc2tkZmVDdklURGw2ZUt2a2JvUjZUNVBj?=
 =?utf-8?B?RDBkSkJ4eVdhWkQyZW9YSVlQbnVFeVE4akJUUTRnak12b2sxWjRkdWVHQ2ZL?=
 =?utf-8?B?TkpBbGZmZzRKbXl6ZlArQ0ZzQWZGTXd3TVduRERPT3pCelJpVUQ1eDhhaDNS?=
 =?utf-8?B?UDhYM293b29hL1VsWlkrNGdFV05CenhvamYzbEtEQ1VGL1UzdTZVc2JPV2tn?=
 =?utf-8?B?WjJrWTdvQWdvOEhhdlZkaUhNY1pIQkR1bVdrczQvY3hqRDBOTlBZL2thK2tl?=
 =?utf-8?B?bTMyaEMzWk5WTERGQzFDQXlSR2NNOS9wWGlHcW8xQUREVDVTRnYwSHc4L25W?=
 =?utf-8?B?U3RHRnlSL3N1bTNMeWxlcHhrelo0MGNGVmpBV1JCaXpudFh4WlF0TTN0YmIv?=
 =?utf-8?B?MisxMTJ2Q3lDVS8ra250QUxDeUNtVXNVRGxQcUMzMGV0TXc0VWs4WG94TE5h?=
 =?utf-8?B?c0ttbGxDcEN4Nm9uKzEzbDY0NWpLRGJLa3lSSEM4VDd3emF5V0xsWW5ZNC9h?=
 =?utf-8?B?b1RzMVhmc0tycnZ2WnBOYkh3aXkybmROTDdLV2pQb2xWSE9ld1ZHTFJGbk1E?=
 =?utf-8?B?WjJGY1dWaGN1UC8wR0FDQWRjVTZaZC84T3VWSTM4S3drMmlWd0M5NXhYVzh2?=
 =?utf-8?B?bXFJSjlyZkxFMUNRN0ZMUVJVUUpvdVN2eHo5RC9ZdEdxUWI2MFIyZFZWV25s?=
 =?utf-8?B?ZHQzYjJLMWJnYzFvYW1aaGFoTVhHdGREaFM0UmpaaU9ST1lzNlFHMXFCUzd4?=
 =?utf-8?B?NlNoeWtqMDUweXI0Y2E4SzNpSTZWbG9OV3pNNmxDOStqUEpqbW1STDJ0S3k4?=
 =?utf-8?B?a2YyZVZyL3l3bXNFVGhvMzFYd0ZaVDRXc2tDTUczQ1hHS2x6d2ltS1FoSWhG?=
 =?utf-8?B?a3Z5cloyZk5HdG5ucG9IMXBid29SQVhZQ1BlM2ZkeHQ1QzNRMy9LdzJDM2d6?=
 =?utf-8?B?ZkFVT09FRjRoNUx1bVlLVDBQZmYrOURnbnQreGc4QmVTa0ZhaUdHR2ZlYnlM?=
 =?utf-8?B?ZmpZcW9Ec2laWkg2eFY2S284RFZqOHdJM05NTUhTVHJuNXB1WnhYRGYrbCtu?=
 =?utf-8?B?OEIvekViYUJUS0kxZ2tCNmRKeVZtQlRBKzJNUHpBTjNyZFI1a21rTXZUZmRO?=
 =?utf-8?B?eFRNZlVSdjF1dnptSnVMeDhCNVFHM0Z6elZkQ1UyaStCb1NwRTlCUGdBeWpi?=
 =?utf-8?B?TGpILzE4VEFEbU1wMEpqN0oyZkJCMXhMLzVJa3BHdUZIb2gybktQTFYvbUM1?=
 =?utf-8?B?bnpsY3A4amhCcFNaL29QNWc1MkdXbHBJTzBuaU8wMTFjd2o1amV1RFYyRWRt?=
 =?utf-8?B?aUhxbGRmQjVMQWw4YTZZUEVtdEs1QVBXdllEOWlSdW5uZXV3aXRsZnROaW5I?=
 =?utf-8?B?SHBOYk5wMGlqUDZIMnVibnRsQzBlVE5JMVNFUHZRQi82aU5HQWozQmFiQkJR?=
 =?utf-8?B?QUhNT2xaMGpXczU3c0xvanV1WXNLK04zczJiQW15VFRoOWdBSUpkQ0NNYUZN?=
 =?utf-8?B?S2xJazJtblVWdWNmOHd6UkUyU0hNRjFuQnBxdENOSzd4bS9obVlKOE91UGwv?=
 =?utf-8?B?bmtvQjkwRGQ5YTd2dHVPb1p1Nnl3Z1Q2aERMWU5OQUJlWHU3N2dxazRzMUNF?=
 =?utf-8?Q?KZa+F/5Wjg5GOAAnR8suPm5ib2NQbQ=3D?=
x-microsoft-antispam-prvs: <DB8PR05MB5978193B51C15D8E0CA84E84BE480@DB8PR05MB5978.eurprd05.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(376002)(396003)(346002)(39860400002)(136003)(199004)(189003)(26005)(54906003)(7736002)(186003)(8936002)(6436002)(2501003)(6116002)(6486002)(105586002)(3846002)(6916009)(2351001)(5660300002)(97736004)(2906002)(106356001)(2616005)(476003)(11346002)(25786009)(229853002)(99286004)(486006)(446003)(1730700003)(4326008)(81156014)(81166006)(8676002)(6506007)(76176011)(2171002)(118296001)(102836004)(6246003)(53936002)(478600001)(86362001)(71190400001)(6512007)(71200400001)(14444005)(14454004)(305945005)(66066001)(5640700003)(58126008)(68736007)(36756003)(256004)(316002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB5978;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6u04UqaYxfSo4KoBrayHvhUi2Ay5AqGtzxhZahBZ/x6z3Yg0hGrXJ/iq9a+NrLPo7Cjn17MEP8IeZ/NFiS+SyUkG0ZNuwUtaTRnOijnwwzKyoEoCHu8Is08cjs/IUwQEkDKxBn8A0Mgpec8IDtgp+UWKSuJMBQGdjpx/H0MTfgI+ZSjZSNjmUzhAwbhyVC3yqgnJiSobJ3Vkms9cZM1PwhGqVrGfCiqjn8cpqRqomjvNv0HVMG88Z0pEdP/Y5F8KJiYDCxDsN+UPi5IpgDwrHsa+70zDTXnwbhw7gvcVY2khYZyBckRzMmZkXifETZXe2saCx95oJH4jnRmdtgon56ibmLAyUe6lytd3nxP/c+p4pr08Im01CK4jVFrZPNadHWIApR21SBnoTAMeNxsqFn4uGJ1V+KK3jHiw2j5g4nY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4A77BDA2C0F984B84B18CD0FADCD5E2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f22eaec-5d1d-4e2a-fc85-08d6a651e0f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 18:46:31.5011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB5978
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAzLTExIGF0IDAxOjMzIC0wNTAwLCBLYW5namllIEx1IHdyb3RlOg0KPiBJ
biBjYXNlIHNrYl9oZWFkZXJfcG9pbnRlciBmYWlscywgdGhlIGZpeCBpc3N1ZXMgYSB3YXJuaW5n
Lg0KPiANCg0KVGhpcyBjYXNlIGlzIGltcG9zc2libGU6IG1seDUgZHJpdmVyIGJ1aWxkcyB0aGlz
IHNrYiBpdHNlbGYgc28gd2UgYXJlDQpzdXJlIHNrYl9oZWFkZXJfcG9pbnRlciBuZXZlciBmYWls
cy4NCg0KV2hhdCBpcyB0aGUgbW90aXZhdGlvbiBiZWhpbmQgdGhpcyBmaXg/IHN0YXRpYyBjaGVj
a2VyIG9yIGFjdHVhbCBpc3N1ZQ0KPw0KDQo+IEEgYmV0dGVyIGZpeCByZXF1aXJlcyBtb2RpZnlp
bmcgdGhlIHNpZ25hdHVyZSBvZiBtbHg1ZV9nZXRfZmNzIHRvDQo+IHBhc3MgYW4gZXJyb3IgY29k
ZSB1cHN0cmVhbS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEthbmdqaWUgTHUgPGtqbHVAdW1uLmVk
dT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5f
cnguYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fcngu
Yw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbl9yeC5jDQo+
IGluZGV4IGJlMzk2ZTVlNGUzOS4uNmVjMWMxMTBlNGJlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fcnguYw0KPiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fcnguYw0KPiBAQCAtNzE5LDYgKzcx
OSw4IEBAIHN0YXRpYyB1MzIgbWx4NWVfZ2V0X2Zjcyhjb25zdCBzdHJ1Y3Qgc2tfYnVmZg0KPiAq
c2tiKQ0KPiAgDQo+ICAJZmNzX2J5dGVzID0gc2tiX2hlYWRlcl9wb2ludGVyKHNrYiwgc2tiLT5s
ZW4gLSBFVEhfRkNTX0xFTiwNCj4gIAkJCQkgICAgICAgRVRIX0ZDU19MRU4sICZfZmNzX2J5dGVz
KTsNCj4gKwlpZiAodW5saWtlbHkoIWZjc19ieXRlcykpDQo+ICsJCXByX3dhcm5fb25jZSgic2ti
X2hlYWRlcl9wb2ludGVyIHJldHVybnMgTlVMTFxuIik7DQo+ICANCj4gIAlyZXR1cm4gX19nZXRf
dW5hbGlnbmVkX2NwdTMyKGZjc19ieXRlcyk7DQo+ICB9DQo=
