Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B099C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1538A206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TU+oVrfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfDZGxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:53:18 -0400
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]:25250
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbfDZGxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n77c3DJU2ZoX/ufclnCOYwKRdoFJL/XoFWLeD5Udjo=;
 b=TU+oVrfTQavfYMjAmaIGFM53ZnjIn5qitq8j27S1C5J8+YSDZRjzjrIpRs9JWH0NJ9BEUVbbPoy29tIKebKm6NEJTkk+97dnFfCj+8yW+WfcMmZ89t68QO9bcbg4S4Rm99fmKGqWTME4Cin2KV/pILobnG9yYDD5MfDxmMT8XqA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3657.eurprd04.prod.outlook.com (52.134.69.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Fri, 26 Apr 2019 06:53:14 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 06:53:14 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] clk: imx: correct pfdv2 gate_bit/vld_bit operations
Thread-Topic: [PATCH] clk: imx: correct pfdv2 gate_bit/vld_bit operations
Thread-Index: AQHU+/y4TYtf1+nKQkWX+VpUdHACww==
Date:   Fri, 26 Apr 2019 06:53:14 +0000
Message-ID: <1556261303-6360-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0048.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::36) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3e5935e-f82b-4bcc-f08c-08d6ca13da86
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3657;
x-ms-traffictypediagnostic: DB3PR0402MB3657:
x-microsoft-antispam-prvs: <DB3PR0402MB36576CAFB9E52D972946EF14F53E0@DB3PR0402MB3657.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(486006)(476003)(2616005)(14454004)(50226002)(66066001)(6486002)(6512007)(8936002)(81166006)(81156014)(6436002)(14444005)(256004)(8676002)(25786009)(53936002)(478600001)(2906002)(99286004)(186003)(6506007)(4326008)(386003)(102836004)(3846002)(26005)(5660300002)(52116002)(71200400001)(6116002)(66556008)(66476007)(305945005)(316002)(110136005)(2501003)(68736007)(66946007)(64756008)(66446008)(71190400001)(73956011)(97736004)(2201001)(36756003)(86362001)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3657;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WPVUqXUXnhy9Rlnd3F0p/M6MjERjXsVZMQsJ94xcn+m4leJ0hQFW7ftB5XSmYSoJzVS9xRG6TerI2TMkIFZVB3qbOn0akvtUr6PtizZgBCNsXpc1aA1yoqFs/oi9Lk7FuZ10LDnpVhSFY0cWoqNgglwiCSvmFLpZW19hJGDdmAVZvsQTq2oC40UPSEQb1fZbGK2z7TPxAaTaaC5mCe4qorB6pf7ov2xzn4+FN+1RB+wsT9xMsjQrMbqLQ5A3OMWfwwrMCnnYEuJLpkfSE3COx6j3oi907UmTtQ0JveXfb3fxP9+zfrFZXqfxvs91mhDmJQby2tM2ft8fa0xSvTjqWn0u0imu7rq9AT92eVrrk4G84MiXlk4uzJRT1g2shxCgT5eiMO7VvQgg+Pjh4TTYn8j9YbAnaaG7fEpc4SX2b3c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e5935e-f82b-4bcc-f08c-08d6ca13da86
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 06:53:14.4193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3657
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG9wZXJhdGlvbnMgb2YgcGZkdjIgZ2F0ZV9iaXQvdmFsaWRfYml0IGFyZSBpbmNvcnJlY3Qs
DQp0aGV5IGFyZSBkZWZpbmVkIGFzIHU4IGZvciBiaXQgb2Zmc2V0LCBidXQgZ2F0ZV9iaXQgaXMN
CmFjdHVhbGx5IGFzc2lnbmVkIGFzIG1hc2sgd2hpY2ggY291bGQgYmUgMzIgYml0IGxvbmcgYW5k
DQppdCBjYXVzZXMgb3ZlcmZsb3csIGFuZCB2bGRfYml0IGlzIGFzc2lnbmVkIGFzIGJpdCBvZmZz
ZXQNCmJhc2VkIG9uIGluY29ycmVjdCBnYXRlX2JpdCB2YWx1ZSwgaXQgY2F1c2VzIGluY29ycmVj
dA0KcGZkIGNsb2NrIGdhdGUgc3RhdHVzIGluIGNsb2NrIHRyZWUsIHRoaXMgcGF0Y2ggZml4ZXMg
dGhlDQppc3N1ZSBieSBhc3NpZ25pbmcgdGhlbSBhcyBjb3JyZWN0IGJpdCBvZmZzZXQuDQoNCkZp
eGVzOiA5ZmNiNmJlM2I2YzkgKCJjbGs6IGlteDogYWRkIHBmZHYyIHN1cHBvcnQiKQ0KU2lnbmVk
LW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQotLS0NCiBkcml2ZXJz
L2Nsay9pbXgvY2xrLXBmZHYyLmMgfCAxMCArKysrKy0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L2lteC9jbGstcGZkdjIuYyBiL2RyaXZlcnMvY2xrL2lteC9jbGstcGZkdjIuYw0KaW5kZXggN2U5
MTM0Yi4uZmI1NjdkYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstcGZkdjIuYw0K
KysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1wZmR2Mi5jDQpAQCAtNDMsNyArNDMsNyBAQCBzdGF0
aWMgaW50IGNsa19wZmR2Ml93YWl0KHN0cnVjdCBjbGtfcGZkdjIgKnBmZCkNCiB7DQogCXUzMiB2
YWw7DQogDQotCXJldHVybiByZWFkbF9wb2xsX3RpbWVvdXQocGZkLT5yZWcsIHZhbCwgdmFsICYg
cGZkLT52bGRfYml0LA0KKwlyZXR1cm4gcmVhZGxfcG9sbF90aW1lb3V0KHBmZC0+cmVnLCB2YWws
IHZhbCAmICgxIDw8IHBmZC0+dmxkX2JpdCksDQogCQkJCSAgMCwgTE9DS19USU1FT1VUX1VTKTsN
CiB9DQogDQpAQCAtNTUsNyArNTUsNyBAQCBzdGF0aWMgaW50IGNsa19wZmR2Ml9lbmFibGUoc3Ry
dWN0IGNsa19odyAqaHcpDQogDQogCXNwaW5fbG9ja19pcnFzYXZlKCZwZmRfbG9jaywgZmxhZ3Mp
Ow0KIAl2YWwgPSByZWFkbF9yZWxheGVkKHBmZC0+cmVnKTsNCi0JdmFsICY9IH5wZmQtPmdhdGVf
Yml0Ow0KKwl2YWwgJj0gfigxIDw8IHBmZC0+Z2F0ZV9iaXQpOw0KIAl3cml0ZWxfcmVsYXhlZCh2
YWwsIHBmZC0+cmVnKTsNCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcGZkX2xvY2ssIGZsYWdz
KTsNCiANCkBAIC03MCw3ICs3MCw3IEBAIHN0YXRpYyB2b2lkIGNsa19wZmR2Ml9kaXNhYmxlKHN0
cnVjdCBjbGtfaHcgKmh3KQ0KIA0KIAlzcGluX2xvY2tfaXJxc2F2ZSgmcGZkX2xvY2ssIGZsYWdz
KTsNCiAJdmFsID0gcmVhZGxfcmVsYXhlZChwZmQtPnJlZyk7DQotCXZhbCB8PSBwZmQtPmdhdGVf
Yml0Ow0KKwl2YWwgfD0gKDEgPDwgcGZkLT5nYXRlX2JpdCk7DQogCXdyaXRlbF9yZWxheGVkKHZh
bCwgcGZkLT5yZWcpOw0KIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwZmRfbG9jaywgZmxhZ3Mp
Ow0KIH0NCkBAIC0xMjMsNyArMTIzLDcgQEAgc3RhdGljIGludCBjbGtfcGZkdjJfaXNfZW5hYmxl
ZChzdHJ1Y3QgY2xrX2h3ICpodykNCiB7DQogCXN0cnVjdCBjbGtfcGZkdjIgKnBmZCA9IHRvX2Ns
a19wZmR2Mihodyk7DQogDQotCWlmIChyZWFkbF9yZWxheGVkKHBmZC0+cmVnKSAmIHBmZC0+Z2F0
ZV9iaXQpDQorCWlmIChyZWFkbF9yZWxheGVkKHBmZC0+cmVnKSAmICgxIDw8IHBmZC0+Z2F0ZV9i
aXQpKQ0KIAkJcmV0dXJuIDA7DQogDQogCXJldHVybiAxOw0KQEAgLTE4MCw3ICsxODAsNyBAQCBz
dHJ1Y3QgY2xrX2h3ICppbXhfY2xrX3BmZHYyKGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIg
KnBhcmVudF9uYW1lLA0KIAkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQogDQogCXBmZC0+cmVn
ID0gcmVnOw0KLQlwZmQtPmdhdGVfYml0ID0gMSA8PCAoKGlkeCArIDEpICogOCAtIDEpOw0KKwlw
ZmQtPmdhdGVfYml0ID0gKGlkeCArIDEpICogOCAtIDE7DQogCXBmZC0+dmxkX2JpdCA9IHBmZC0+
Z2F0ZV9iaXQgLSAxOw0KIAlwZmQtPmZyYWNfb2ZmID0gaWR4ICogODsNCiANCi0tIA0KMi43LjQN
Cg0K
