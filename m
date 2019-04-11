Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EFFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944F720663
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jp8OhHVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDKCGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:06:08 -0400
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:48789
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfDKCGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZW/p3vVChYHL/3GC9dqHtLbYFjiVuOOUqSKfatIDnE=;
 b=jp8OhHVbTebDigro0/wzyU4yr1DADRTOxMKDI8ecBa7V8rNnzKB973rTsFAZZn8F2kgre94uALgrliVXOT9IszOJnmmbhiDgKlVopBDQvXUY9G9mMHA7VybJSMGcC9G9PIuyl9NBMvMKFsF+GiQ1GPVqE1TXa700o7KmR6n5Hx0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3866.eurprd04.prod.outlook.com (52.134.71.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Thu, 11 Apr 2019 02:06:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 02:06:04 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] rtc: mxc: use dev_pm_set_wake_irq() to simplify code
Thread-Topic: [PATCH] rtc: mxc: use dev_pm_set_wake_irq() to simplify code
Thread-Index: AQHU8AseXcUv7QdF4Eas7C+lQpgLug==
Date:   Thu, 11 Apr 2019 02:06:04 +0000
Message-ID: <1554948064-2343-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:203:2e::25) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a599c34-7c35-4455-02da-08d6be22405e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3866;
x-ms-traffictypediagnostic: DB3PR0402MB3866:
x-microsoft-antispam-prvs: <DB3PR0402MB3866F7C79A32F05167C20195F52F0@DB3PR0402MB3866.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(376002)(39860400002)(199004)(189003)(81166006)(256004)(102836004)(4326008)(2501003)(14444005)(25786009)(66066001)(106356001)(305945005)(508600001)(14454004)(7736002)(105586002)(6506007)(386003)(6116002)(2616005)(3846002)(476003)(5660300002)(53936002)(8676002)(97736004)(99286004)(8936002)(486006)(6512007)(2201001)(316002)(36756003)(2906002)(6436002)(26005)(68736007)(6486002)(52116002)(186003)(71200400001)(50226002)(71190400001)(86362001)(110136005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3866;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BuobKqErt2hZXASaCF3bmHRyRYKud2+3EuG/jvGofdy4OxvzE8HXnzMLad1z9/VfsLUklxya/+UZB1mYJLzEspn5D0lmmj+oGnkAv9s4aIzxvCWHNpzeGTjAetgvOBQfuS8+pZjR06xreLiweaHmNUD/TetOvvI3uv2GuN8+07G49E8j8TPvo5xwahPpL9p/cbmdhoVIsHDzgQ2huJL8gv7k6KMJASEWPAsvRyfGnf8uoI/qZzwacOTWBqW+YkVY+oAXSS1VBlK9WkUme3Gs2x9UO1RxnLlTUYQjr6+XU7+nqhRUT3Ye8MdGhUgSNUt2qf0u1UMOf3cvocTBskSTLFoQy4G663Z6IKCuuCiOV9hyrOlQe+8RZGTht423+d4tjw5MjzvLbb6DeSOL+AN2hydHiS4HiG7g9ZM7fjiant4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a599c34-7c35-4455-02da-08d6be22405e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 02:06:04.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2l0aCBjYWxsaW5nIGRldl9wbV9zZXRfd2FrZV9pcnEoKSB0byBzZXQgTVhDIFJUQyBhcyB3YWtl
dXAgc291cmNlDQpmb3Igc3VzcGVuZCwgZ2VuZXJpYyB3YWtlIGlycSBtZWNoYW5pc20gd2lsbCBh
dXRvbWF0aWNhbGx5IGVuYWJsZQ0KaXQgYXMgd2FrZXVwIHNvdXJjZSB3aGVuIHN1c3BlbmQsIHRo
ZW4gdGhlIHN1c3BlbmQvcmVzdW1lIGNhbGxiYWNrDQp3aGljaCBhcmUgT05MWSBmb3IgZW5hYmxp
bmcvZGlzYWJsaW5nIGlycSB3YWtlIGNhbiBiZSByZW1vdmVkLCBpdA0Kc2ltcGxpZmllcyB0aGUg
Y29kZS4NCg0KU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQotLS0NCiBkcml2ZXJzL3J0Yy9ydGMtbXhjLmMgfCAzMiArKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRjLW14Yy5jIGIvZHJpdmVycy9ydGMv
cnRjLW14Yy5jDQppbmRleCAyOGExNWJkLi43MDhiOWU5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9y
dGMvcnRjLW14Yy5jDQorKysgYi9kcml2ZXJzL3J0Yy9ydGMtbXhjLmMNCkBAIC04LDYgKzgsNyBA
QA0KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQogI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5o
Pg0KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCisjaW5jbHVkZSA8bGludXgv
cG1fd2FrZWlycS5oPg0KICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCiAjaW5jbHVkZSA8bGludXgv
b2YuaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQpAQCAtMzk0LDggKzM5NSwxMiBA
QCBzdGF0aWMgaW50IG14Y19ydGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
CiAJCXBkYXRhLT5pcnEgPSAtMTsNCiAJfQ0KIA0KLQlpZiAocGRhdGEtPmlycSA+PSAwKQ0KKwlp
ZiAocGRhdGEtPmlycSA+PSAwKSB7DQogCQlkZXZpY2VfaW5pdF93YWtldXAoJnBkZXYtPmRldiwg
MSk7DQorCQlyZXQgPSBkZXZfcG1fc2V0X3dha2VfaXJxKCZwZGV2LT5kZXYsIHBkYXRhLT5pcnEp
Ow0KKwkJaWYgKHJldCkNCisJCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZW5hYmxl
IGlycSB3YWtlXG4iKTsNCisJfQ0KIA0KIAlydGMgPSBkZXZtX3J0Y19kZXZpY2VfcmVnaXN0ZXIo
JnBkZXYtPmRldiwgcGRldi0+bmFtZSwgJm14Y19ydGNfb3BzLA0KIAkJCQkgIFRISVNfTU9EVUxF
KTsNCkBAIC00MjYsMzUgKzQzMSwxMCBAQCBzdGF0aWMgaW50IG14Y19ydGNfcmVtb3ZlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXJldHVybiAwOw0KIH0NCiANCi0jaWZkZWYgQ09O
RklHX1BNX1NMRUVQDQotc3RhdGljIGludCBteGNfcnRjX3N1c3BlbmQoc3RydWN0IGRldmljZSAq
ZGV2KQ0KLXsNCi0Jc3RydWN0IHJ0Y19wbGF0X2RhdGEgKnBkYXRhID0gZGV2X2dldF9kcnZkYXRh
KGRldik7DQotDQotCWlmIChkZXZpY2VfbWF5X3dha2V1cChkZXYpKQ0KLQkJZW5hYmxlX2lycV93
YWtlKHBkYXRhLT5pcnEpOw0KLQ0KLQlyZXR1cm4gMDsNCi19DQotDQotc3RhdGljIGludCBteGNf
cnRjX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQotew0KLQlzdHJ1Y3QgcnRjX3BsYXRfZGF0
YSAqcGRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCi0NCi0JaWYgKGRldmljZV9tYXlfd2Fr
ZXVwKGRldikpDQotCQlkaXNhYmxlX2lycV93YWtlKHBkYXRhLT5pcnEpOw0KLQ0KLQlyZXR1cm4g
MDsNCi19DQotI2VuZGlmDQotDQotc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BTKG14Y19ydGNfcG1f
b3BzLCBteGNfcnRjX3N1c3BlbmQsIG14Y19ydGNfcmVzdW1lKTsNCi0NCiBzdGF0aWMgc3RydWN0
IHBsYXRmb3JtX2RyaXZlciBteGNfcnRjX2RyaXZlciA9IHsNCiAJLmRyaXZlciA9IHsNCiAJCSAg
IC5uYW1lCT0gIm14Y19ydGMiLA0KIAkJICAgLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRy
KGlteF9ydGNfZHRfaWRzKSwNCi0JCSAgIC5wbQkJPSAmbXhjX3J0Y19wbV9vcHMsDQogCX0sDQog
CS5pZF90YWJsZSA9IGlteF9ydGNfZGV2dHlwZSwNCiAJLnByb2JlID0gbXhjX3J0Y19wcm9iZSwN
Ci0tIA0KMi43LjQNCg0K
