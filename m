Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40C0C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9348D206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="APYJoQYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfD1DDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 23:03:17 -0400
Received: from mail-eopbgr140084.outbound.protection.outlook.com ([40.107.14.84]:4548
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbfD1DDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 23:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Dh0oyIDNLwuIif9QgsYfiYn6zvbWbnH+f156Rv6Gvk=;
 b=APYJoQYRCNZgKE5VzseUy+fsW4JmoMDQhGgc2Hc3DCHF0TnIk9ZburZQkIZGMSw+7JqhxS/+Et0P2jJgPqFdED97AK3+5PK9HPl+GtsPJmScFOcnTGNBZMAKnwWZ/nXzwHBJUwIPbLQKmQxUt2zwXGNAI1jeT87NcMN4hnFTpg0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3882.eurprd04.prod.outlook.com (52.134.72.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Sun, 28 Apr 2019 03:03:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.015; Sun, 28 Apr 2019
 03:03:12 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2] firmware: imx: SCU irq should ONLY be enabled after SCU
 IPC is ready
Thread-Topic: [PATCH V2] firmware: imx: SCU irq should ONLY be enabled after
 SCU IPC is ready
Thread-Index: AQHU/W7qy26RYcrGkE20NBp+jw1zUg==
Date:   Sun, 28 Apr 2019 03:03:12 +0000
Message-ID: <1556420305-14680-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6881be59-8708-425c-d502-08d6cb860ca7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3882;
x-ms-traffictypediagnostic: DB3PR0402MB3882:
x-microsoft-antispam-prvs: <DB3PR0402MB38823BF7D16AF7DF85D4B3B8F5380@DB3PR0402MB3882.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(136003)(346002)(376002)(199004)(189003)(2906002)(66446008)(64756008)(186003)(71190400001)(71200400001)(26005)(52116002)(50226002)(102836004)(6506007)(386003)(8936002)(486006)(81156014)(476003)(73956011)(66946007)(66556008)(2501003)(66476007)(2616005)(3846002)(6116002)(36756003)(7736002)(66066001)(6436002)(305945005)(99286004)(6486002)(5660300002)(2201001)(316002)(53936002)(478600001)(110136005)(68736007)(4326008)(14454004)(5024004)(97736004)(86362001)(81166006)(8676002)(6512007)(256004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3882;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: huKK1lU0rmkK6Ljzje8goZkZPo+iALUFj1wZIYCa1aA3Aq6LqOlS9jeLAweN3cyOFta0K18G1+wxchSgCFGLXPr6XuPpbr+JenZIY3lW6qpyLBDY6QTpfwvZht5mo811XH7Fvnb9DJJQCeJGzRBe5oYfwpE6UpCG7kHIXQhUkzcMUMwkro+h+4BY9j5klJCdUJxqvdEUlWimTG3ORRSkzhhkUyjxzbHs5G0csKubHJvwCMjAoSeASudVfPYRkxRAWETnpiP1QBM5BOLSUZqRxDM49cv9sQ26TfU/dBPt6gb5RTCkP3XSkVr5372t2viKAAO3RDvLaKeG43xHaV6XyN6MWMNx1l5JuxxowOVBsgnqgamKhT/P6Z5cE4R12oVDCrW2SXRw8Hw4VcS8HZ8wlTTq2fyV/1r7kpeIAvbf2f4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6881be59-8708-425c-d502-08d6cb860ca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 03:03:12.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGlteF9zY3VfaXJxX2dyb3VwX2VuYWJsZSgpIGlzIG5vcm1hbGx5IGNhbGxlZCBkdXJpbmcg
bW9kdWxlIGRyaXZlcg0KcHJvYmUgcGhhc2UgdG8gZW5hYmxlIFNDVSBncm91cCBpcnEsIGlmIFND
VSBJUEMgaXMgTk9UIHJlYWR5LCBiZWxvdw0KZHVtcCB3aWxsIHNob3cgb3V0Og0KDQpbICAgIDAu
OTMzMDAxXSBIYXJkd2FyZSBuYW1lOiBGcmVlc2NhbGUgaS5NWDhRWFAgTUVLIChEVCkNClsgICAg
MC45MzgxMjldIHBzdGF0ZTogNjAwMDAwMDUgKG5aQ3YgZGFpZiAtUEFOIC1VQU8pDQpbICAgIDAu
OTQyOTA3XSBwYyA6IGlteF9zY3VfY2FsbF9ycGMrMHgxMTQvMHgxNTgNClsgICAgMC45NDcyNTFd
IGxyIDogaW14X3NjdV9pcnFfZ3JvdXBfZW5hYmxlKzB4NzQvMHhjNA0KWyAgICAwLjk1MjExM10g
c3AgOiBmZmZmMDAwMDEwMDViYWUwDQpbICAgIDAuOTU1NDE1XSB4Mjk6IGZmZmYwMDAwMTAwNWJh
ZTAgeDI4OiBmZmZmMDAwMDExMWJiMGEwDQpbICAgIDAuOTYwNzEyXSB4Mjc6IGZmZmYwMDAwMTE0
MGIwMDAgeDI2OiBmZmZmMDAwMDExMTEwNjhjDQpbICAgIDAuOTY2MDExXSB4MjU6IGZmZmYwMDAw
MTExYmIxMDAgeDI0OiAwMDAwMDAwMDAwMDAwMDAwDQpbICAgIDAuOTcxMzExXSB4MjM6IGZmZmYw
MDAwMTEzZDljZDggeDIyOiAwMDAwMDAwMDAwMDAwMDAxDQpbICAgIDAuOTc2NjEwXSB4MjE6IDAw
MDAwMDAwMDAwMDAwMDEgeDIwOiBmZmZmODAwODNiNTFhNDEwDQpbICAgIDAuOTgxOTA5XSB4MTk6
IGZmZmYwMDAwMTEyNTkwMDAgeDE4OiAwMDAwMDAwMDAwMDAwNDgwDQpbICAgIDAuOTg3MjA5XSB4
MTc6IDAwMDAwMDAwMDAyM2ZmYjggeDE2OiAwMDAwMDAwMDAwMDAwMDEwDQpbICAgIDAuOTkyNTA4
XSB4MTU6IDAwMDAwMDAwMDAwMDAyM2YgeDE0OiBmZmZmZmZmZmZmZmZmZmZmDQpbICAgIDAuOTk3
ODA3XSB4MTM6IDAwMDAwMDAwMDAwMDAwMTggeDEyOiAwMDAwMDAwMDAwMDAwMDMwDQpbICAgIDEu
MDAzMTA3XSB4MTE6IDAwMDAwMDAwMDAwMDAwMDMgeDEwOiAwMTAxMDEwMTAxMDEwMTAxDQpbICAg
IDEuMDA4NDA2XSB4OSA6IGZmZmZmZmZmZmZmZmZmZmYgeDggOiA3ZjdmN2Y3ZjdmN2Y3ZjdmDQpb
ICAgIDEuMDEzNzA2XSB4NyA6IGZlZmVmZWZmNjQ2YzYwNmQgeDYgOiAwMDAwMDAwMDAwMDAwMDAw
DQpbICAgIDEuMDE5MDA1XSB4NSA6IGZmZmYwMDAwMTEyNTk2YzggeDQgOiAwMDAwMDAwMDAwMDAw
MDA4DQpbICAgIDEuMDI0MzA0XSB4MyA6IDAwMDAwMDAwMDAwMDAwMDMgeDIgOiAwMDAwMDAwMDAw
MDAwMDAxDQpbICAgIDEuMDI5NjA0XSB4MSA6IGZmZmYwMDAwMTAwNWJiNTggeDAgOiAwMDAwMDAw
MDAwMDAwMDAwDQpbICAgIDEuMDM0OTA1XSBDYWxsIHRyYWNlOg0KWyAgICAxLjAzNzM0MV0gIGlt
eF9zY3VfY2FsbF9ycGMrMHgxMTQvMHgxNTgNClsgICAgMS4wNDEzMzRdICBpbXhfc2N1X2lycV9n
cm91cF9lbmFibGUrMHg3NC8weGM0DQpbICAgIDEuMDQ1ODU2XSAgaW14X3NjX3dkdF9wcm9iZSsw
eDI0LzB4MTUwDQpbICAgIDEuMDQ5NzY2XSAgcGxhdGZvcm1fZHJ2X3Byb2JlKzB4NGMvMHhiMA0K
WyAgICAxLjA1Mzc2Ml0gIHJlYWxseV9wcm9iZSsweDFmOC8weDJjOA0KWyAgICAxLjA1NzQwN10g
IGRyaXZlcl9wcm9iZV9kZXZpY2UrMHg1OC8weGZjDQpbICAgIDEuMDYxNDkwXSAgZGV2aWNlX2Ry
aXZlcl9hdHRhY2grMHg2OC8weDcwDQpbICAgIDEuMDY1NjYwXSAgX19kcml2ZXJfYXR0YWNoKzB4
OTQvMHhkYw0KWyAgICAxLjA2OTM5N10gIGJ1c19mb3JfZWFjaF9kZXYrMHg2NC8weGMwDQpbICAg
IDEuMDczMjIwXSAgZHJpdmVyX2F0dGFjaCsweDIwLzB4MjgNClsgICAgMS4wNzY3ODJdICBidXNf
YWRkX2RyaXZlcisweDE0OC8weDFmYw0KWyAgICAxLjA4MDYwMV0gIGRyaXZlcl9yZWdpc3Rlcisw
eDY4LzB4MTIwDQpbICAgIDEuMDg0NDI0XSAgX19wbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIrMHg0
Yy8weDU0DQpbICAgIDEuMDg5MTIwXSAgaW14X3NjX3dkdF9kcml2ZXJfaW5pdCsweDE4LzB4MjAN
ClsgICAgMS4wOTM0NjNdICBkb19vbmVfaW5pdGNhbGwrMHg1OC8weDFiOA0KWyAgICAxLjA5NzI4
N10gIGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4MWNjLzB4Mjg4DQpbICAgIDEuMTAxNjMwXSAga2Vy
bmVsX2luaXQrMHgxMC8weDEwMA0KWyAgICAxLjEwNTEwMV0gIHJldF9mcm9tX2ZvcmsrMHgxMC8w
eDE4DQpbICAgIDEuMTA4NjY5XSAtLS1bIGVuZCB0cmFjZSA5ZTAzMzAyMTE0NDU3ZGU5IF0tLS0N
ClsgICAgMS4xMTMyOTZdIGVuYWJsZSBpcnEgZmFpbGVkLCBncm91cCAxLCBtYXNrIDEsIHJldCAt
MjINCg0KVG8gYXZvaWQgc3VjaCBzY2VuYXJpbywgcmV0dXJuIC1FUFJPQkVfREVGRVIgaW4gaW14
X3NjdV9pcnFfZ3JvdXBfZW5hYmxlKCkNCkFQSSBpZiBTQ1UgSVBDIGlzIE5PVCByZWFkeSwgdGhl
biBtb2R1bGUgZHJpdmVyIHdoaWNoIGNhbGxzIHRoaXMgQVBJDQppbiBwcm9iZSBwaGFzZSB3aWxs
IGRlZmVyIHByb2JlIGFmdGVyIFNDVSBJUEMgcmVhZHkuDQoNCkZpeGVzOiA4NTE4MjZjNzU2NmUg
KCJmaXJtd2FyZTogaW14OiBlbmFibGUgaW14IHNjdSBnZW5lcmFsIGlycSBmdW5jdGlvbiIpDQpT
aWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCi0tLQ0KTm8g
Y29kZSBjaGFuZ2UsIGp1c3QgcmVtb3ZlIHRoZSB3YXRjaGRvZyByZWxhdGVkIHdvcmRzIHRvIGlt
cHJvdmUgdGhlIGNvbW1pdCBtZXNzYWdlLg0KLS0tDQogZHJpdmVycy9maXJtd2FyZS9pbXgvaW14
LXNjdS1pcnEuYyB8IDMgKysrDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS1pcnEuYyBiL2RyaXZlcnMv
ZmlybXdhcmUvaW14L2lteC1zY3UtaXJxLmMNCmluZGV4IDA0MzgzM2EuLjY4NzEyMWYgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LWlycS5jDQorKysgYi9kcml2ZXJz
L2Zpcm13YXJlL2lteC9pbXgtc2N1LWlycS5jDQpAQCAtMTAwLDYgKzEwMCw5IEBAIGludCBpbXhf
c2N1X2lycV9ncm91cF9lbmFibGUodTggZ3JvdXAsIHUzMiBtYXNrLCB1OCBlbmFibGUpDQogCXN0
cnVjdCBpbXhfc2NfcnBjX21zZyAqaGRyID0gJm1zZy5oZHI7DQogCWludCByZXQ7DQogDQorCWlm
ICghaW14X3NjX2lycV9pcGNfaGFuZGxlKQ0KKwkJcmV0dXJuIC1FUFJPQkVfREVGRVI7DQorDQog
CWhkci0+dmVyID0gSU1YX1NDX1JQQ19WRVJTSU9OOw0KIAloZHItPnN2YyA9IElNWF9TQ19SUENf
U1ZDX0lSUTsNCiAJaGRyLT5mdW5jID0gSU1YX1NDX0lSUV9GVU5DX0VOQUJMRTsNCi0tIA0KMi43
LjQNCg0K
