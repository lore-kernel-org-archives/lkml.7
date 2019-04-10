Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E925C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A562084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jB5pmGKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfDJG1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:27:45 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:65241
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfDJG1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7is9vmTGd/tk4tz9IIKWPM+UxOPPhDpcvsB8+KZWq4=;
 b=jB5pmGKN67Gb0lSrlcv5dUvEDQSvhqq26Vte5eZchUfvYT6hveSLSvUSXfbat6xz/GJF+9ag25slvB3j0abRaWsWzcKvIGAL6Kh/aWhkjH8NzB/4BCgdOqtYqkNUUIh7JjbEz47RbrNBIJIbBpBnrQnyOiyGgjziCKp9AhIneg8=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5977.eurprd04.prod.outlook.com (20.178.107.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Wed, 10 Apr 2019 06:27:37 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25%3]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 06:27:37 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] can: dev: clean up CAN ctrlmode when close CAN device
Thread-Topic: [PATCH] can: dev: clean up CAN ctrlmode when close CAN device
Thread-Index: AQHU72Z9hNDj4CvO1EGET8+N4jv3IA==
Date:   Wed, 10 Apr 2019 06:27:37 +0000
Message-ID: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:4:91::23) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea96b831-ea3b-440a-29ef-08d6bd7d9ffa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB5977;
x-ms-traffictypediagnostic: DB7PR04MB5977:
x-microsoft-antispam-prvs: <DB7PR04MB597774E474D404BD0132FC26E62E0@DB7PR04MB5977.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(186003)(50226002)(86362001)(6512007)(71200400001)(71190400001)(1076003)(256004)(305945005)(7736002)(2201001)(26005)(99286004)(2501003)(102836004)(14444005)(2906002)(36756003)(8936002)(97736004)(2616005)(486006)(476003)(52116002)(66066001)(386003)(6506007)(81166006)(81156014)(54906003)(106356001)(105586002)(68736007)(316002)(6436002)(110136005)(6116002)(5660300002)(478600001)(8676002)(3846002)(6486002)(14454004)(4326008)(25786009)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5977;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8l9R5DC/z/D3d+kwwUBQyNf6D8Up9VUnrYy6i0cJkMT4yVondFQ0qLWc3NQLUGHqcBGVREeg47bI9GuzxivQI5p+TwF9+eMkBquJzEWXSG5XyNECagmxp7iIl0U4Hw5+ZcNB1Qd2PZ80QszxiwBKKVe8gXlwtqCtYU6e6PT9DOfMBInbQlIn3U/IHT3Z54j3ThdwZiw86bbzAQhAwhqs69VbW7MBWJ/Fkx61GhoaayVsJt+oLq79aMDA4IH4VKgawaRR6nMqc/qnqm+7aNOg/I0sfdP406C3vTyZ54k0LYgpblNZyM5R3hM761kH+tK3kI0jt9RzW+T4g1Lsh4Q7/y9o8M+56Yy9XQgB2fcprBpV960UOBQ+nEbVT04w92aq1tvr6Lom0ICtyaRIa7aVfOaPew05CSyYqRFiPZSKBLo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea96b831-ea3b-440a-29ef-08d6bd7d9ffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 06:27:37.7711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5977
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q0FOIGRyaXZlciBhbHdheXMgd3JpdGVzIHJlZ2lzdGVycyBhY2NvcmRpbmcgdG8gImN0cmxtb2Rl
IiwgYW5kIG5vdyBDQU4NCmZyYW1ld29yayB3aWxsIGtlZXAgQ0FOIGN0cmxtb2RlIGFmdGVyIGRl
dmljZSBjbG9zZWQuDQoNCmUuZy4gd2l0aCBmb2xsb3dpbmcgc2VxdWVuY2VzOg0KMSlpcCBsaW5r
IHNldCBjYW4wIHR5cGUgY2FuIGJpdHJhdGUgMTAwMDAwMCBsb29wYmFjayBvbg0KMilpcCBsaW5r
IHNldCBjYW4wIHVwDQozKWlwIGxpbmsgc2V0IGNhbjAgZG93bg0KNClpcCBsaW5rIHNldCBjYW4w
IHR5cGUgY2FuIGJpdHJhdGUgMTAwMDAwMA0KNSlpcCBsaW5rIHNldCBjYW4wIHVwDQoNCkFmdGVy
IHRoaXMgc2VxdWVuY2UsIHdlIG1heSB3YW50IHRvIHRlc3QgbG9vcGJhY2sgZm9yIHRoZSBmaXJz
dCB0aW1lIGFuZA0Kbm90IHRvIHRlc3QgbG9vcGJhY2sgc2Vjb25kIHRpbWUuIEhvd2V2ZXIsIENB
TiBkZXZpY2Ugc3RpbGwga2VlcA0KImN0cmxtb2RlIiBhcyBsb29wYmFjayBvbi4NCg0KVGhpcyBw
YXRjaCBpbnRlbmRzIHRvIGNsZWFuIHVwIENBTiBjdHJsbW9kZSB3aGVuIGNsb3NlIENBTiBkZXZp
Y2UuIFdlDQpjYW4gc2V0IHdoaWNoIGN0cmxtb2RlIHdlIG5lZWQgd2hlbiBvcGVuIENBTiBkZXZp
Y2UgYWdhaW4uDQoNClNpZ25lZC1vZmYtYnk6IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5n
QG54cC5jb20+DQotLS0NCiBkcml2ZXJzL25ldC9jYW4vZGV2LmMgfCAxICsNCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9kZXYu
YyBiL2RyaXZlcnMvbmV0L2Nhbi9kZXYuYw0KaW5kZXggYzA1ZTRkNTBkNDNkLi40ZjY5YThmMTZi
YTMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9jYW4vZGV2LmMNCisrKyBiL2RyaXZlcnMvbmV0
L2Nhbi9kZXYuYw0KQEAgLTg3MCw2ICs4NzAsNyBAQCB2b2lkIGNsb3NlX2NhbmRldihzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2KQ0KIAlzdHJ1Y3QgY2FuX3ByaXYgKnByaXYgPSBuZXRkZXZfcHJpdihk
ZXYpOw0KIA0KIAljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnByaXYtPnJlc3RhcnRfd29yayk7
DQorCXByaXYtPmN0cmxtb2RlID0gMDsNCiAJY2FuX2ZsdXNoX2VjaG9fc2tiKGRldik7DQogfQ0K
IEVYUE9SVF9TWU1CT0xfR1BMKGNsb3NlX2NhbmRldik7DQotLSANCjIuMTcuMQ0KDQo=
