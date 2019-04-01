Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F35C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2863720883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="fXmSbt5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfDASPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:15:09 -0400
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]:39309
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728638AbfDASPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpSTat3OX4QnC0Jr3A0auVOWXGrN3wQWqaypO8tHtnA=;
 b=fXmSbt5exSRY+s5E7c6JLovrIbvA9uDeW10AGQtA/lApWz9yt1OpqZ/5qiw6Q8NPUtDr7zal9OQB0AH+90bWD5pmy6JXF1nvAz4CoJ+7DFzd8UzevVpiJH+F24weSWzQRlUD/tcvH+EoH5VNfWPUvKLkgkdk0XXuX7wxVb9MUAk=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB6121.eurprd05.prod.outlook.com (20.179.11.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 18:15:05 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::85d8:bf39:8cc9:16c3]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::85d8:bf39:8cc9:16c3%3]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 18:15:05 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Huy Nguyen <huyn@mellanox.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Thread-Topic: linux-next: manual merge of the net-next tree with the net tree
Thread-Index: AQHU6A6zXmGcQD4qj0WPj0QOcr3Cd6YnnYgA
Date:   Mon, 1 Apr 2019 18:15:04 +0000
Message-ID: <d42fbd530cebe3c5e6f380d5241adf03ce6c4ea6.camel@mellanox.com>
References: <20190401091119.3ac313e8@canb.auug.org.au>
In-Reply-To: <20190401091119.3ac313e8@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b2c0082-d67d-4419-926a-08d6b6cdf725
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR05MB6121;
x-ms-traffictypediagnostic: DB8PR05MB6121:
x-microsoft-antispam-prvs: <DB8PR05MB6121AE2C47F97FC1564D7253BE550@DB8PR05MB6121.eurprd05.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(366004)(346002)(53754006)(199004)(189003)(66066001)(68736007)(486006)(71190400001)(14454004)(71200400001)(58126008)(6436002)(110136005)(6486002)(2906002)(105586002)(316002)(5660300002)(54906003)(446003)(99286004)(4744005)(2501003)(2616005)(476003)(26005)(97736004)(76176011)(3846002)(6116002)(186003)(6506007)(6512007)(14444005)(8936002)(256004)(2201001)(229853002)(8676002)(102836004)(81166006)(6246003)(36756003)(53936002)(86362001)(305945005)(118296001)(11346002)(478600001)(7736002)(106356001)(25786009)(81156014)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB6121;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JnchJx4tFg8222MREdHjr4i8E8c2kvKogJw2RrcyESj0d3pRr9vzel8ZAf4MBBYiaW/S64wbI0dZ5GV2BElXOpJFkY/Buban9oRp83b8d+95bFBssvODmsXbWsSmYG99AkILOP9zxhSEanWVDmCBpUsb0sORx6IQUSOM3YcHmEFu+qVTV1Szmqz4yiSwofA4ippaj/lA9rcyfb+yBAVevsPP9U4Rzz5vzmGKDayoqRzwotN6jRbLmYDwMdhep/5Mpsbs1zHwrSjmI9AsS3QsOxHYd2kOqLAlqrXuCAeqj9RLTgQcZFRNsbBSx8NSrRFUGVlmaDsJ6zhIprgBB32CIh/PQ9yUWiqxY+sQRNHrjytYygvZknaQ3DEZamNxSOrgBRDYdQfcqIfnwjvYublpd8O/oQXV8fY10Iu7oCDJXOo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <926B2EA0CAEF3646B40D744C094768CC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2c0082-d67d-4419-926a-08d6b6cdf725
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 18:15:04.8798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA0LTAxIGF0IDA5OjExICsxMTAwLCBTdGVwaGVuIFJvdGh3ZWxsIHdyb3Rl
Og0KPiBIaSBhbGwsDQo+IA0KPiBUb2RheSdzIGxpbnV4LW5leHQgbWVyZ2Ugb2YgdGhlIG5ldC1u
ZXh0IHRyZWUgZ290IGEgY29uZmxpY3QgaW46DQo+IA0KPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0
L21lbGxhbm94L21seDUvY29yZS9lbi9wb3J0X2J1ZmZlci5jDQo+IA0KPiBiZXR3ZWVuIGNvbW1p
dDoNCj4gDQo+ICAgZTI4NDA4ZTk4YmNlICgibmV0L21seDVlOiBVcGRhdGUgeG9uIGZvcm11bGEi
KQ0KPiANCj4gZnJvbSB0aGUgbmV0IHRyZWUgYW5kIGNvbW1pdDoNCj4gDQo+ICAgZDM2NjljYTlm
ZjMzICgibmV0L21seDVlOiBGaXggcG9ydCBidWZmZXIgZnVuY3Rpb24gZG9jdW1lbnRhdGlvbg0K
PiBmb3JtYXQiKQ0KPiANCj4gZnJvbSB0aGUgbmV0LW5leHQgdHJlZS4NCj4gDQo+IEkgZml4ZWQg
aXQgdXAgKHNlZSBiZWxvdykgYW5kIGNhbiBjYXJyeSB0aGUgZml4IGFzIG5lY2Vzc2FyeS4gVGhp
cw0KPiBpcyBub3cgZml4ZWQgYXMgZmFyIGFzIGxpbnV4LW5leHQgaXMgY29uY2VybmVkLCBidXQg
YW55IG5vbiB0cml2aWFsDQo+IGNvbmZsaWN0cyBzaG91bGQgYmUgbWVudGlvbmVkIHRvIHlvdXIg
dXBzdHJlYW0gbWFpbnRhaW5lciB3aGVuIHlvdXINCj4gdHJlZQ0KPiBpcyBzdWJtaXR0ZWQgZm9y
IG1lcmdpbmcuICBZb3UgbWF5IGFsc28gd2FudCB0byBjb25zaWRlciBjb29wZXJhdGluZw0KPiB3
aXRoIHRoZSBtYWludGFpbmVyIG9mIHRoZSBjb25mbGljdGluZyB0cmVlIHRvIG1pbmltaXNlIGFu
eQ0KPiBwYXJ0aWN1bGFybHkNCj4gY29tcGxleCBjb25mbGljdHMuDQo+IA0KDQpUaGFua3MgU3Rl
cGhlbiwgdGhlIHJlc29sdXRpb24gbG9va3MgZ29vZCwNCkRhdmUgd2FzIGFscmVhZHkgbm90aWZp
ZWQgYWJvdXQgdGhpcy4NCg0K
