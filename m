Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F735C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09108214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZZzjrCAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfEBIHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:07:03 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:51954
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbfEBIHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkqYsLfhg5iGkbuTS3L9cMtnuJC4tgOIzA8Ct3NDAeo=;
 b=ZZzjrCAnHEp6a0PwNiKnTSRBjarMZ0+ZsRwJI1vAW3HQneG4vUIgGY4Mx7DUiQvTdGkkgAlKDU3m5hIGsotYJitcEQd6SDtZl20wtC1m4oryhGeLGzcfHeW1bDn+Hy6RJ/bCV9Tj4UtRnlUFp8kt08gwX0wBY6spfENbOEd307E=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4948.eurprd04.prod.outlook.com (20.177.40.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.16; Thu, 2 May 2019 08:06:49 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 08:06:49 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 11/18] clk: imx: clk-fixup-mux: Switch to clk_hw based API
Thread-Topic: [PATCH v2 11/18] clk: imx: clk-fixup-mux: Switch to clk_hw based
 API
Thread-Index: AQHVAL3+Kq7BFPAkjUuNGbD1AGXNuA==
Date:   Thu, 2 May 2019 08:06:49 +0000
Message-ID: <1556784376-7191-12-git-send-email-abel.vesa@nxp.com>
References: <1556784376-7191-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1556784376-7191-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0041.eurprd05.prod.outlook.com
 (2603:10a6:800:60::27) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2ac4af0-dcdb-44da-5ab7-08d6ced520f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4948;
x-ms-traffictypediagnostic: AM0PR04MB4948:
x-microsoft-antispam-prvs: <AM0PR04MB49480E148C05A7A842CDD339F6340@AM0PR04MB4948.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(346002)(136003)(189003)(199004)(86362001)(3846002)(8676002)(478600001)(25786009)(186003)(6436002)(81156014)(26005)(71190400001)(71200400001)(102836004)(14454004)(6116002)(4326008)(53936002)(305945005)(7736002)(66066001)(36756003)(81166006)(50226002)(8936002)(6512007)(66556008)(64756008)(44832011)(316002)(54906003)(110136005)(99286004)(476003)(2616005)(66946007)(73956011)(486006)(68736007)(66476007)(66446008)(256004)(2906002)(6486002)(11346002)(446003)(5660300002)(52116002)(76176011)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4948;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FLfS9dcpBdHYjCRxdTrC2SpOsCCJ6LA140XuXhLsEo2/aFkxrx+QsoHizknTXHvcnU9mJ+y3Y4ENL6R1mUwY9PDJDO7S/6RhbmzfO21wPRk6opB/YVGS6vBa8LFFMo3UxI2l1QwtNtY0bOSiqBuw/ep7aY4ONPQmmsMTwWVTc7/HW7Sfg9MNwzrgoHm2SaC9OnKB5ZFRqJ0QxK2fc++H6ZyyTbCqx2ggvgZ0ZWDHe71oDLLXf40b1oZvXmGbmdDObO9cpBreo0pjJDMM0enbcnfYJmEyMf2e8MvdfYxrqXtIuU1R1/QMAV17ED6rUSjrtVqwgpRCgcMujsNtH+Vb+8unRgowxI4rn5AGFDCpoXSauGPEdYB/vQ2kRp0iy5V9tVbPc7s5VmG7qZdVU0ePRxJU1iTW6Go/l8gFiPojst4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ac4af0-dcdb-44da-5ab7-08d6ced520f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:06:49.7317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3dpdGNoIHRoZSBpbXhfY2xrX2ZpeHVwX211eCBmdW5jdGlvbiB0byBjbGtfaHcgYmFzZWQgQVBJ
LCByZW5hbWUNCmFjY29yZGluZ2x5IGFuZCBhZGQgYSBtYWNybyBmb3IgY2xrIGJhc2VkIGxlZ2Fj
eS4gYSBtYWNybyBmb3IgY2xrDQpiYXNlZCBsZWdhY3kuIFRoaXMgYWxsb3dzIHVzIHRvIG1vdmUg
Y2xvc2VyIHRvIGEgY2xlYXIgc3BsaXQgYmV0d2Vlbg0KY29uc3VtZXIgYW5kIHByb3ZpZGVyIGNs
ayBBUElzLg0KDQpTaWduZWQtb2ZmLWJ5OiBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPg0K
LS0tDQogZHJpdmVycy9jbGsvaW14L2Nsay1maXh1cC1tdXguYyB8IDE1ICsrKysrKysrKystLS0t
LQ0KIGRyaXZlcnMvY2xrL2lteC9jbGsuaCAgICAgICAgICAgfCAgMyArKysNCiAyIGZpbGVzIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2Nsay9pbXgvY2xrLWZpeHVwLW11eC5jIGIvZHJpdmVycy9jbGsvaW14L2Nsay1maXh1
cC1tdXguYw0KaW5kZXggNDQ4MTdjMS4uZjNjNGVjMiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xr
L2lteC9jbGstZml4dXAtbXV4LmMNCisrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstZml4dXAtbXV4
LmMNCkBAIC02OSwxMyArNjksMTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfb3BzIGNsa19m
aXh1cF9tdXhfb3BzID0gew0KIAkuc2V0X3BhcmVudCA9IGNsa19maXh1cF9tdXhfc2V0X3BhcmVu
dCwNCiB9Ow0KIA0KLXN0cnVjdCBjbGsgKmlteF9jbGtfZml4dXBfbXV4KGNvbnN0IGNoYXIgKm5h
bWUsIHZvaWQgX19pb21lbSAqcmVnLA0KK3N0cnVjdCBjbGtfaHcgKmlteF9jbGtfaHdfZml4dXBf
bXV4KGNvbnN0IGNoYXIgKm5hbWUsIHZvaWQgX19pb21lbSAqcmVnLA0KIAkJCSAgICAgIHU4IHNo
aWZ0LCB1OCB3aWR0aCwgY29uc3QgY2hhciAqIGNvbnN0ICpwYXJlbnRzLA0KIAkJCSAgICAgIGlu
dCBudW1fcGFyZW50cywgdm9pZCAoKmZpeHVwKSh1MzIgKnZhbCkpDQogew0KIAlzdHJ1Y3QgY2xr
X2ZpeHVwX211eCAqZml4dXBfbXV4Ow0KLQlzdHJ1Y3QgY2xrICpjbGs7DQorCXN0cnVjdCBjbGtf
aHcgKmh3Ow0KIAlzdHJ1Y3QgY2xrX2luaXRfZGF0YSBpbml0Ow0KKwlpbnQgcmV0Ow0KIA0KIAlp
ZiAoIWZpeHVwKQ0KIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQpAQCAtOTgsOSArOTksMTMg
QEAgc3RydWN0IGNsayAqaW14X2Nsa19maXh1cF9tdXgoY29uc3QgY2hhciAqbmFtZSwgdm9pZCBf
X2lvbWVtICpyZWcsDQogCWZpeHVwX211eC0+b3BzID0gJmNsa19tdXhfb3BzOw0KIAlmaXh1cF9t
dXgtPmZpeHVwID0gZml4dXA7DQogDQotCWNsayA9IGNsa19yZWdpc3RlcihOVUxMLCAmZml4dXBf
bXV4LT5tdXguaHcpOw0KLQlpZiAoSVNfRVJSKGNsaykpDQorCWh3ID0gJmZpeHVwX211eC0+bXV4
Lmh3Ow0KKw0KKwlyZXQgPSBjbGtfaHdfcmVnaXN0ZXIoTlVMTCwgaHcpOw0KKwlpZiAocmV0KSB7
DQogCQlrZnJlZShmaXh1cF9tdXgpOw0KKwkJcmV0dXJuIEVSUl9QVFIocmV0KTsNCisJfQ0KIA0K
LQlyZXR1cm4gY2xrOw0KKwlyZXR1cm4gaHc7DQogfQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L2lteC9jbGsuaCBiL2RyaXZlcnMvY2xrL2lteC9jbGsuaA0KaW5kZXggZmMzMmJhYS4uZTFhNDcz
OTYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLmgNCisrKyBiL2RyaXZlcnMvY2xr
L2lteC9jbGsuaA0KQEAgLTc1LDYgKzc1LDkgQEAgc3RydWN0IGlteF9wbGwxNHh4X2NsayB7DQog
I2RlZmluZSBpbXhfY2xrX2ZpeHVwX2RpdmlkZXIobmFtZSwgcGFyZW50LCByZWcsIHNoaWZ0LCB3
aWR0aCwgZml4dXApIFwNCiAJaW14X2Nsa19od19maXh1cF9kaXZpZGVyKG5hbWUsIHBhcmVudCwg
cmVnLCBzaGlmdCwgd2lkdGgsIGZpeHVwKS0+Y2xrDQogDQorI2RlZmluZSBpbXhfY2xrX2ZpeHVw
X211eChuYW1lLCByZWcsIHNoaWZ0LCB3aWR0aCwgcGFyZW50cywgbnVtX3BhcmVudHMsIGZpeHVw
KSBcDQorCWlteF9jbGtfaHdfZml4dXBfbXV4KG5hbWUsIHJlZywgc2hpZnQsIHdpZHRoLCBwYXJl
bnRzLCBudW1fcGFyZW50cywgZml4dXApLT5jbGsNCisNCiBzdHJ1Y3QgY2xrICppbXhfY2xrX3Bs
bDE0eHgoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqcGFyZW50X25hbWUsDQogCQkgdm9p
ZCBfX2lvbWVtICpiYXNlLCBjb25zdCBzdHJ1Y3QgaW14X3BsbDE0eHhfY2xrICpwbGxfY2xrKTsN
CiANCi0tIA0KMi43LjQNCg0K
