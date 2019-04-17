Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23390C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB63217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HyAO54M7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfDQB7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 21:59:40 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:26155
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728032AbfDQB7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 21:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dor289mWnJBgnR7CjoOhvm6MkCbW7lBLeKal0S3i5DE=;
 b=HyAO54M7riILKQHKjROI41CmxB23zzDnYVqzPggBLSJwPH/GrIWKL71rEJFMgTltIbhQHEjCyw5dXDSa33yl8NX7INYk0qYnV6sf54Xw+Vm7PBt3xEyyQk9zTnSzzSXoNO/alPwonzo1WrnSimoqucMjHk+qNxoSCX+tM8tJMo0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3739.eurprd04.prod.outlook.com (52.134.67.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Wed, 17 Apr 2019 01:59:34 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1813.011; Wed, 17 Apr 2019
 01:59:34 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "eha@deif.com" <eha@deif.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "mojha@codeaurora.org" <mojha@codeaurora.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "peda@axentia.se" <peda@axentia.se>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] i2c: imx: correct the method of getting private data in
 notifier_call
Thread-Topic: [PATCH] i2c: imx: correct the method of getting private data in
 notifier_call
Thread-Index: AQHU9ME0meJbs59NTkCxa+Er7M94Gw==
Date:   Wed, 17 Apr 2019 01:59:34 +0000
Message-ID: <1555466064-27984-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0180.apcprd02.prod.outlook.com
 (2603:1096:201:21::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3d905a1-e681-4f26-aeba-08d6c2d85698
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3739;
x-ms-traffictypediagnostic: DB3PR0402MB3739:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3739B8F1C18BEEE320540117F5250@DB3PR0402MB3739.eurprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(39860400002)(376002)(51234002)(189003)(199004)(81156014)(256004)(486006)(6512007)(4326008)(6486002)(5660300002)(8936002)(8676002)(7416002)(99286004)(2616005)(6436002)(110136005)(316002)(14454004)(102836004)(476003)(186003)(386003)(26005)(6506007)(50226002)(7736002)(81166006)(305945005)(68736007)(6116002)(36756003)(478600001)(2201001)(106356001)(53936002)(66066001)(105586002)(3846002)(71200400001)(86362001)(71190400001)(2501003)(25786009)(2906002)(97736004)(52116002)(14444005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3739;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J4+sCAjqjluQR1ToRQxkCcmX+jQKnsq39+ltthxjtTZuOSQmQcqvEo/zcQ7ZC4Y4y/bUW9trAzkjjhwK/qKamS5uJIjU8k7FYZevh2TnZgMldR/vb7ogTy/sdGaIhqIeDECv/1H5ImD7S70t/nqASm8s8yQiOkZRK82xz9MEm1pIClOdCXn18tAbam2Hlm/lOMNA4Rqyn5CIqyhZ8/Xtz+RWEGGZJ/MSEE7W4iqGWsI8B17w2vLaIZyTnJjQtQzt8uyx+wtxQA6pxcmLqiaqHSX6v1kpnPw1gUehE15NlyDY2vOFp096BCKpCfNsehxgo65bS6I1RB6l/egkj+zmfPViWJVxsKS42tHcnhHba/1uV4SmnMsziv5DqeRO5S7RqF3Wv4L5YrS0Qd2cL6Z7Dvfe7HdO8wMeZmzgn4NlPLM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d905a1-e681-4f26-aeba-08d6c2d85698
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 01:59:34.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHdheSBvZiBnZXR0aW5nIHByaXZhdGUgaW14X2kyY19zdHJ1Y3QgaW4gaTJjX2lteF9jbGtf
bm90aWZpZXJfY2FsbCgpDQppcyBpbmNvcnJlY3QsIHNob3VsZCB1c2UgY2xrX2NoYW5nZV9uYiBl
bGVtZW50IHRvIGdldCBjb3JyZWN0IGFkZHJlc3MNCmFuZCBhdm9pZCBiZWxvdyBrZXJuZWwgZHVt
cCBkdXJpbmcgUE9TVF9SQVRFX0NIQU5HRSBub3RpZnkgYnkgY2xrDQpmcmFtZXdvcms6DQoNClVu
YWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyAw
M2VmMTQ4OA0KcGdkID0gKHB0cnZhbCkNClswM2VmMTQ4OF0gKnBnZD0wMDAwMDAwMA0KSW50ZXJu
YWwgZXJyb3I6IE9vcHM6IDUgWyMxXSBQUkVFTVBUIFNNUCBBUk0NCkhhcmR3YXJlIG5hbWU6IEZy
ZWVzY2FsZSBpLk1YNiBRdWFkL0R1YWxMaXRlIChEZXZpY2UgVHJlZSkNCldvcmtxdWV1ZTogZXZl
bnRzIHJlZHVjZV9idXNfZnJlcV9oYW5kbGVyDQpQQyBpcyBhdCBpMmNfaW14X3NldF9jbGsrMHgx
MC8weGI4DQpMUiBpcyBhdCBpMmNfaW14X2Nsa19ub3RpZmllcl9jYWxsKzB4MjAvMHgyOA0KcGMg
OiBbPDgwNmE4OTNjPl0gICAgbHIgOiBbPDgwNmE4YTA0Pl0gICAgcHNyOiBhMDA4MDAxMw0Kc3Ag
OiBiZjM5OWRkOCAgaXAgOiBiZjM0MzJhYyAgZnAgOiBiZjdjMWRjMA0KcjEwOiAwMDAwMDAwMiAg
cjkgOiAwMDAwMDAwMCAgcjggOiAwMDAwMDAwMA0KcjcgOiAwM2VmMTQ4MCAgcjYgOiBiZjM5OWU1
MCAgcjUgOiBmZmZmZmZmZiAgcjQgOiAwMDAwMDAwMA0KcjMgOiBiZjAyNTMwMCAgcjIgOiBiZjM5
OWU1MCAgcjEgOiAwMGI3MWIwMCAgcjAgOiBiZjM5OWJlOA0KRmxhZ3M6IE56Q3YgIElSUXMgb24g
IEZJUXMgb24gIE1vZGUgU1ZDXzMyICBJU0EgQVJNICBTZWdtZW50IG5vbmUNCkNvbnRyb2w6IDEw
YzUzODdkICBUYWJsZTogNGUwMzAwNGEgIERBQzogMDAwMDAwNTENClByb2Nlc3Mga3dvcmtlci8y
OjEgKHBpZDogMzgsIHN0YWNrIGxpbWl0ID0gMHgocHRydmFsKSkNClN0YWNrOiAoMHhiZjM5OWRk
OCB0byAweGJmMzlhMDAwKQ0KOWRjMDogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgODA2YTg5ZTQgMDAwMDAwMDANCjlkZTA6IGZmZmZmZmZmIGJm
Mzk5ZTUwIDAwMDAwMDAyIDgwNmE4YTA0IDgwNmE4OWU0IDgwMTQyOTAwIGZmZmZmZmZmIDAwMDAw
MDAwDQo5ZTAwOiBiZjM0ZWYxOCBiZjM0ZWYwNCAwMDAwMDAwMCBmZmZmZmZmZiBiZjM5OWU1MCA4
MDE0MmQ4NCAwMDAwMDAwMCBiZjM5OWU2Yw0KOWUyMDogYmYzNGVmMDAgODBmMjE0YzQgYmYwMjUz
MDAgMDAwMDAwMDIgODBmMDhkMDggYmYwMTc0ODAgMDAwMDAwMDAgODAxNDJkZjANCjllNDA6IDAw
MDAwMDAwIDgwMTY2ZWQ4IDgwYzI3NjM4IDgwNDVkZTU4IGJmMzUyMzQwIDAzZWYxNDgwIDAwYjcx
YjAwIDBmODJlMjQyDQo5ZTYwOiBiZjAyNTMwMCAwMDAwMDAwMiAwM2VmMTQ4MCA4MGY2MGU1YyAw
MDAwMDAwMSA4MDQ1ZWRmMCAwMDAwMDAwMiA4MDQ1ZWIwOA0KOWU4MDogYmYwMjUzMDAgMDAwMDAw
MDIgMDNlZjE0ODAgODA0NWVlMTAgMDNlZjE0ODAgODA0NWViMDggYmYwMWJlNDAgMDAwMDAwMDIN
CjllYTA6IDAzZWYxNDgwIDgwNDVlZTEwIDA3ZGUyOTAwIDgwNDVlYjA4IGJmMDFiNzgwIDAwMDAw
MDAyIDA3ZGUyOTAwIDgwNDVlZTEwDQo5ZWMwOiA4MGMyNzg5OCBiZjM5OWVlNCBiZjAyMGE4MCAw
MDAwMDAwMiAxZjc4YTQwMCA4MDQ1ZWUxMCA4MGY2MGU1YyA4MDQ2MDUxNA0KOWVlMDogODBmNjBl
NWMgYmYwMWI2MDAgYmYwMWI0ODAgODA0NjA0NjAgMGY4MmUyNDIgYmYzODNhODAgYmYzODNhMDAg
ODBmNjBlNWMNCjlmMDA6IDAwMDAwMDAwIGJmN2MxZGMwIDgwZjYwZTcwIDgwNDYwNTY0IDgwZjYw
ZGYwIDgwZjYwZDI0IDgwZjYwZGYwIDgwMTFlNzJjDQo5ZjIwOiAwMDAwMDAwMCA4MGY2MGRmMCA4
MGY2MGU2YyBiZjdjNGYwMCAwMDAwMDAwMCA4MDExZTdhYyBiZjI3NDAwMCA4MDEzYmQ4NA0KOWY0
MDogYmY3YzFkZDggODBmMDNkMDAgYmYyNzQwMDAgYmY3YzFkYzAgYmYyNzQwMTQgYmY3YzFkZDgg
ODBmMDNkMDAgYmYzOTgwMDANCjlmNjA6IDAwMDAwMDA4IDgwMTNiZmI0IDAwMDAwMDAwIGJmMjVk
MTAwIGJmMjVkMGMwIDAwMDAwMDAwIGJmMjc0MDAwIDgwMTNiZjg4DQo5ZjgwOiBiZjI1ZDExYyBi
ZjBjZmViYyAwMDAwMDAwMCA4MDE0MTQwYyBiZjI1ZDBjMCA4MDE0MTJlYyAwMDAwMDAwMCAwMDAw
MDAwMA0KOWZhMDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgODAxMDEwZTggMDAwMDAwMDAg
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCjlmYzA6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAw
MDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwDQo5ZmUwOiAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAxMyAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAwMA0KWzw4MDZhODkzYz5dIChpMmNfaW14X3NldF9jbGspIGZyb20gWzw4MDZh
OGEwND5dIChpMmNfaW14X2Nsa19ub3RpZmllcl9jYWxsKzB4MjAvMHgyOCkNCls8ODA2YThhMDQ+
XSAoaTJjX2lteF9jbGtfbm90aWZpZXJfY2FsbCkgZnJvbSBbPDgwMTQyOTAwPl0gKG5vdGlmaWVy
X2NhbGxfY2hhaW4rMHg0NC8weDg0KQ0KWzw4MDE0MjkwMD5dIChub3RpZmllcl9jYWxsX2NoYWlu
KSBmcm9tIFs8ODAxNDJkODQ+XSAoX19zcmN1X25vdGlmaWVyX2NhbGxfY2hhaW4rMHg0NC8weDk4
KQ0KWzw4MDE0MmQ4ND5dIChfX3NyY3Vfbm90aWZpZXJfY2FsbF9jaGFpbikgZnJvbSBbPDgwMTQy
ZGYwPl0gKHNyY3Vfbm90aWZpZXJfY2FsbF9jaGFpbisweDE4LzB4MjApDQpbPDgwMTQyZGYwPl0g
KHNyY3Vfbm90aWZpZXJfY2FsbF9jaGFpbikgZnJvbSBbPDgwNDVkZTU4Pl0gKF9fY2xrX25vdGlm
eSsweDc4LzB4YTQpDQpbPDgwNDVkZTU4Pl0gKF9fY2xrX25vdGlmeSkgZnJvbSBbPDgwNDVlZGYw
Pl0gKF9fY2xrX3JlY2FsY19yYXRlcysweDYwLzB4YjQpDQpbPDgwNDVlZGYwPl0gKF9fY2xrX3Jl
Y2FsY19yYXRlcykgZnJvbSBbPDgwNDVlZTEwPl0gKF9fY2xrX3JlY2FsY19yYXRlcysweDgwLzB4
YjQpDQpDb2RlOiBlOTJkNDBmOCBlNTkwMzI5OCBlNTkwNzJhMCBlMTUzMDAwMSAoZTU5NzUwMDgp
DQotLS1bIGVuZCB0cmFjZSBmYzdmNTUxNGI5N2I2Y2JiIF0tLS0NCg0KRml4ZXM6IDkwYWQyY2Jl
ODhjMigiaTJjOiBpbXg6IHVzZSBjbGsgbm90aWZpZXIgZm9yIHJhdGUgY2hhbmdlcyIpDQpTaWdu
ZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVz
c2VzL2kyYy1pbXguYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMNCmluZGV4IGMwYzMw
NDMuLmZkNzBiMTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jDQor
KysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jDQpAQCAtNTE1LDkgKzUxNSw5IEBAIHN0
YXRpYyBpbnQgaTJjX2lteF9jbGtfbm90aWZpZXJfY2FsbChzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sg
Km5iLA0KIAkJCQkgICAgIHVuc2lnbmVkIGxvbmcgYWN0aW9uLCB2b2lkICpkYXRhKQ0KIHsNCiAJ
c3RydWN0IGNsa19ub3RpZmllcl9kYXRhICpuZGF0YSA9IGRhdGE7DQotCXN0cnVjdCBpbXhfaTJj
X3N0cnVjdCAqaTJjX2lteCA9IGNvbnRhaW5lcl9vZigmbmRhdGEtPmNsaywNCisJc3RydWN0IGlt
eF9pMmNfc3RydWN0ICppMmNfaW14ID0gY29udGFpbmVyX29mKG5iLA0KIAkJCQkJCSAgICAgIHN0
cnVjdCBpbXhfaTJjX3N0cnVjdCwNCi0JCQkJCQkgICAgICBjbGspOw0KKwkJCQkJCSAgICAgIGNs
a19jaGFuZ2VfbmIpOw0KIA0KIAlpZiAoYWN0aW9uICYgUE9TVF9SQVRFX0NIQU5HRSkNCiAJCWky
Y19pbXhfc2V0X2NsayhpMmNfaW14LCBuZGF0YS0+bmV3X3JhdGUpOw0KLS0gDQoyLjcuNA0KDQo=
