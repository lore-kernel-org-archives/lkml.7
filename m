Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3994C282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A918F2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hriQpL7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfDVI1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:27:04 -0400
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]:46981
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbfDVI1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKcEW3uHPygRR8L7YJxzEE8OJRGPr1m1UDgYG+ZG6D4=;
 b=hriQpL7sM5bAF6ePVfij4vxQFM+KAfWgHMsaTC5UnyDM9G/dw+6OPdWyAjdESVndYlq7i9NulqpQ1j7+MoMJVot9GrOqI57lNu2r9gIEbFbDOT/SPJziB/Nurw5aTCM8jw2eiBo74SnwA1ilgC9OfDF/6xBkynLKK7WwsAeyoXY=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5583.eurprd04.prod.outlook.com (20.178.123.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 08:26:56 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822%4]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 08:26:56 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] scripts/gdb: Add hlist utilities
Thread-Topic: [PATCH 1/3] scripts/gdb: Add hlist utilities
Thread-Index: AQHU+OUlC64SkSXBmEOwbSCd/Y19Cw==
Date:   Mon, 22 Apr 2019 08:26:56 +0000
Message-ID: <aede2c05c333fd599252a74e67904ff7847b0dcf.1555921081.git.leonard.crestez@nxp.com>
References: <cover.1555921081.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1555921081.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.146.100.6]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VI1PR08CA0227.eurprd08.prod.outlook.com
 (2603:10a6:802:15::36) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c2508b7-efdd-4a25-0036-08d6c6fc4822
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5583;
x-ms-traffictypediagnostic: VI1PR04MB5583:
x-microsoft-antispam-prvs: <VI1PR04MB55837B72553562DB557CD563EE220@VI1PR04MB5583.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(68736007)(305945005)(99286004)(6512007)(2906002)(54906003)(316002)(110136005)(52116002)(76176011)(53936002)(7736002)(97736004)(36756003)(386003)(6506007)(102836004)(26005)(66446008)(64756008)(6116002)(8676002)(186003)(71190400001)(71200400001)(66476007)(81166006)(81156014)(86362001)(66556008)(2616005)(4326008)(486006)(66946007)(5660300002)(476003)(73956011)(11346002)(25786009)(44832011)(8936002)(50226002)(118296001)(3846002)(6486002)(256004)(6436002)(14454004)(478600001)(446003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5583;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SQ6Hnin/sBO69htGVVr8QUDtBMpGx9SQB10vqg676zgIePlIGy3v4XmAqIY/TTDYmlFhDduL9iI2wvQVJ9VJI9HjEb0iJ+8mz0vY3ecdGqz9YKlqfaPdWhtKc9BNrbLkkQC7A+dsP3zW4pa6i9SWyOspn6X5kTFNpyY5PRtLM38H405wfmlD5766J1EGC+5N753XWMTfHRsBQ6fEhzy5K00RB417lYt/hAAmSBhETdkPMWrAhbXwzGYmN8l9aICLYHWBReA4yzanF2xgZ0CXKXtr/2seVdxaj2nMTMP51vxyYZKGaI+oq13MaUZvgRlp67qzO/Z2IvjqxX/txboOGKg9I1KH8Nqvoj9QIUh+M5wSqYQNbIfqrBmTqGdnWNlD+xXRZhzQ+GNtAWC5NMqrMhjc3tme/42UguGN2SjoaOA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2508b7-efdd-4a25-0036-08d6c6fc4822
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 08:26:56.6451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBhbGxvd3MgZWFzaWx5IGV4YW1pbmluZyBrZXJuZWwgaGxpc3RzIGluIHB5dGhvbi4NCg0K
U2lnbmVkLW9mZi1ieTogTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4N
Ci0tLQ0KIHNjcmlwdHMvZ2RiL2xpbnV4L2xpc3RzLnB5IHwgMjMgKysrKysrKysrKysrKysrKysr
KysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
c2NyaXB0cy9nZGIvbGludXgvbGlzdHMucHkgYi9zY3JpcHRzL2dkYi9saW51eC9saXN0cy5weQ0K
aW5kZXggMTk4N2Q3NTZiMzZiLi41NTM1NmI2NmY4ZWEgMTAwNjQ0DQotLS0gYS9zY3JpcHRzL2dk
Yi9saW51eC9saXN0cy5weQ0KKysrIGIvc2NyaXB0cy9nZGIvbGludXgvbGlzdHMucHkNCkBAIC0x
NCwxMCArMTQsMTIgQEANCiBpbXBvcnQgZ2RiDQogDQogZnJvbSBsaW51eCBpbXBvcnQgdXRpbHMN
CiANCiBsaXN0X2hlYWQgPSB1dGlscy5DYWNoZWRUeXBlKCJzdHJ1Y3QgbGlzdF9oZWFkIikNCito
bGlzdF9oZWFkID0gdXRpbHMuQ2FjaGVkVHlwZSgic3RydWN0IGhsaXN0X2hlYWQiKQ0KK2hsaXN0
X25vZGUgPSB1dGlscy5DYWNoZWRUeXBlKCJzdHJ1Y3QgaGxpc3Rfbm9kZSIpDQogDQogDQogZGVm
IGxpc3RfZm9yX2VhY2goaGVhZCk6DQogICAgIGlmIGhlYWQudHlwZSA9PSBsaXN0X2hlYWQuZ2V0
X3R5cGUoKS5wb2ludGVyKCk6DQogICAgICAgICBoZWFkID0gaGVhZC5kZXJlZmVyZW5jZSgpDQpA
QCAtMzcsMTAgKzM5LDMxIEBAIGRlZiBsaXN0X2Zvcl9lYWNoX2VudHJ5KGhlYWQsIGdkYnR5cGUs
IG1lbWJlcik6DQogICAgICAgICAgICAgcmFpc2UgVHlwZUVycm9yKCJUeXBlIHt9IGZvdW5kLiBF
eHBlY3RlZCBzdHJ1Y3QgbGlzdF9oZWFkICouIg0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAuZm9ybWF0KG5vZGUudHlwZSkpDQogICAgICAgICB5aWVsZCB1dGlscy5jb250YWluZXJfb2Yo
bm9kZSwgZ2RidHlwZSwgbWVtYmVyKQ0KIA0KIA0KK2RlZiBobGlzdF9mb3JfZWFjaChoZWFkKToN
CisgICAgaWYgaGVhZC50eXBlID09IGhsaXN0X2hlYWQuZ2V0X3R5cGUoKS5wb2ludGVyKCk6DQor
ICAgICAgICBoZWFkID0gaGVhZC5kZXJlZmVyZW5jZSgpDQorICAgIGVsaWYgaGVhZC50eXBlICE9
IGhsaXN0X2hlYWQuZ2V0X3R5cGUoKToNCisgICAgICAgIHJhaXNlIGdkYi5HZGJFcnJvcigiTXVz
dCBiZSBzdHJ1Y3QgaGxpc3RfaGVhZCBub3Qge30iDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLmZvcm1hdChoZWFkLnR5cGUpKQ0KKw0KKyAgICBub2RlID0gaGVhZFsnZmlyc3QnXS5kZXJl
ZmVyZW5jZSgpDQorICAgIHdoaWxlIG5vZGUuYWRkcmVzczoNCisgICAgICAgIHlpZWxkIG5vZGUu
YWRkcmVzcw0KKyAgICAgICAgbm9kZSA9IG5vZGVbJ25leHQnXS5kZXJlZmVyZW5jZSgpDQorDQor
DQorZGVmIGhsaXN0X2Zvcl9lYWNoX2VudHJ5KGhlYWQsIGdkYnR5cGUsIG1lbWJlcik6DQorICAg
IGZvciBub2RlIGluIGhsaXN0X2Zvcl9lYWNoKGhlYWQpOg0KKyAgICAgICAgaWYgbm9kZS50eXBl
ICE9IGhsaXN0X25vZGUuZ2V0X3R5cGUoKS5wb2ludGVyKCk6DQorICAgICAgICAgICAgcmFpc2Ug
VHlwZUVycm9yKCJUeXBlIHt9IGZvdW5kLiBFeHBlY3RlZCBzdHJ1Y3QgaGxpc3RfaGVhZCAqLiIN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgLmZvcm1hdChub2RlLnR5cGUpKQ0KKyAgICAg
ICAgeWllbGQgdXRpbHMuY29udGFpbmVyX29mKG5vZGUsIGdkYnR5cGUsIG1lbWJlcikNCisNCisN
CiBkZWYgbGlzdF9jaGVjayhoZWFkKToNCiAgICAgbmIgPSAwDQogICAgIGlmIChoZWFkLnR5cGUg
PT0gbGlzdF9oZWFkLmdldF90eXBlKCkucG9pbnRlcigpKToNCiAgICAgICAgIGhlYWQgPSBoZWFk
LmRlcmVmZXJlbmNlKCkNCiAgICAgZWxpZiAoaGVhZC50eXBlICE9IGxpc3RfaGVhZC5nZXRfdHlw
ZSgpKToNCi0tIA0KMi4xNy4xDQoNCg==
