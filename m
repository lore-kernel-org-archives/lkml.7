Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47A3C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC21320675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TL6z7dsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfD2KqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:46:08 -0400
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:15148
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727841AbfD2KqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQbO31yfxFT6lL6rn+MZuC6A6ieOqWs394MSxg3bnuI=;
 b=TL6z7dsAkr6xPY7KCTSQKRHD41cuEjo8DEYnQSvdwYLr6U7sMkSl7MWEGt2TI61lqY4GL+n4jXfD6zZy6vF1A6SapIYjSPSEBwnItkIJtiXUJt8mchguGMjvQwkmdHt/YNe3DxKrQpgbgnCup3F5cci/csN1EJon3/Feqvm4Cp8=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6621.eurprd04.prod.outlook.com (20.179.235.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Mon, 29 Apr 2019 10:46:03 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1835.016; Mon, 29 Apr 2019
 10:46:03 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: cs42xx8: Add reset gpio handling
Thread-Topic: [PATCH] ASoC: cs42xx8: Add reset gpio handling
Thread-Index: AQHU/ni9Rn+K8AXUn0yC+rdeNT8NqA==
Date:   Mon, 29 Apr 2019 10:46:03 +0000
Message-ID: <1556534756-15630-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:36::25) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f65234e8-3136-46d3-df82-08d6cc8fe00a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6621;
x-ms-traffictypediagnostic: VE1PR04MB6621:
x-microsoft-antispam-prvs: <VE1PR04MB6621634807C3C613348D127BE3390@VE1PR04MB6621.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(478600001)(6486002)(2906002)(97736004)(68736007)(8676002)(66066001)(50226002)(6116002)(2501003)(14454004)(3846002)(5660300002)(6436002)(81166006)(81156014)(7736002)(486006)(71190400001)(305945005)(25786009)(71200400001)(2616005)(476003)(8936002)(110136005)(52116002)(66446008)(66476007)(66556008)(64756008)(66946007)(6512007)(186003)(256004)(4326008)(53936002)(2201001)(99286004)(36756003)(86362001)(316002)(26005)(6506007)(386003)(14444005)(102836004)(73956011);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6621;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FSmBACjEB58XPR7Uh7JawEkzoEE/LOyzusGcHH1N2GEgNEfE4ppokRgBhZgdIaEOSbgQhbusRXmViiztyrt5J1F3ccHAe1I40tWcx1YrCJGIKA1Ee44fCR6Gq28ypcTWs2u7uCxL9NcBUcuTfLN7RsGW9BoFP7oCsy9Pz1CGm/y+IyHloZsyGaX3GpXWAAakRlFTZtwJPV4A1Pxu3mqlv1hNbYfrFM6nWHUvStSotfydLUcJZGFG9fX0ShPg2CsgHzDRLA+XlG0F4duMA10yLZkTJ7zeSe43P8E5qB2IkT8Oe0zLqQ7AN2x2qHfWK8ZG0/b2kIJ6DsJIeOfv+sgijWCZCMODzS3QVjDw84vizX0gClcou5OvQBTmS5FWPdLVkft/9x5y+HEfoXWeZKIrTEqDFQvcqLfdk7MJLeAKOUo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65234e8-3136-46d3-df82-08d6cc8fe00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 10:46:03.5215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6621
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGFuZGxlIHRoZSByZXNldCBHUElPIGFuZCByZXNldCB0aGUgZGV2aWNlIGluDQpwbV9ydW50aW1l
X3Jlc3VtZQ0KDQpTaWduZWQtb2ZmLWJ5OiBTaGVuZ2ppdSBXYW5nIDxzaGVuZ2ppdS53YW5nQG54
cC5jb20+DQotLS0NCiBzb3VuZC9zb2MvY29kZWNzL2NzNDJ4eDguYyB8IDE5ICsrKysrKysrKysr
KysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvc291bmQvc29jL2NvZGVjcy9jczQyeHg4LmMgYi9zb3VuZC9zb2MvY29kZWNzL2NzNDJ4eDgu
Yw0KaW5kZXggZWJiOWUwY2Y4MzY0Li5mYzI4ZTZkMjZjNmQgMTAwNjQ0DQotLS0gYS9zb3VuZC9z
b2MvY29kZWNzL2NzNDJ4eDguYw0KKysrIGIvc291bmQvc29jL2NvZGVjcy9jczQyeHg4LmMNCkBA
IC0xNCw2ICsxNCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQogI2luY2x1ZGUgPGxp
bnV4L21vZHVsZS5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCisjaW5jbHVkZSA8
bGludXgvb2ZfZ3Bpby5oPg0KICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQogI2luY2x1
ZGUgPGxpbnV4L3JlZ3VsYXRvci9jb25zdW1lci5oPg0KICNpbmNsdWRlIDxzb3VuZC9wY21fcGFy
YW1zLmg+DQpAQCAtNDUsNiArNDYsNyBAQCBzdHJ1Y3QgY3M0Mnh4OF9wcml2IHsNCiAJYm9vbCBz
bGF2ZV9tb2RlOw0KIAl1bnNpZ25lZCBsb25nIHN5c2NsazsNCiAJdTMyIHR4X2NoYW5uZWxzOw0K
KwlpbnQgZ3Bpb19yZXNldDsNCiB9Ow0KIA0KIC8qIC0xMjcuNWRCIHRvIDBkQiB3aXRoIHN0ZXAg
b2YgMC41ZEIgKi8NCkBAIC00NjcsNiArNDY5LDE3IEBAIGludCBjczQyeHg4X3Byb2JlKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IHJlZ21hcCAqcmVnbWFwKQ0KIAkJcmV0dXJuIC1FSU5WQUw7
DQogCX0NCiANCisJY3M0Mnh4OC0+Z3Bpb19yZXNldCA9IG9mX2dldF9uYW1lZF9ncGlvKGRldi0+
b2Zfbm9kZSwgImdwaW8tcmVzZXQiLCAwKTsNCisJaWYgKGdwaW9faXNfdmFsaWQoY3M0Mnh4OC0+
Z3Bpb19yZXNldCkpIHsNCisJCXJldCA9IGRldm1fZ3Bpb19yZXF1ZXN0X29uZShkZXYsIGNzNDJ4
eDgtPmdwaW9fcmVzZXQsDQorCQkJCUdQSU9GX09VVF9JTklUX0xPVywgImNzNDJ4eDggcmVzZXQi
KTsNCisJCWlmIChyZXQpIHsNCisJCQlkZXZfZXJyKGRldiwgInVuYWJsZSB0byBnZXQgcmVzZXQg
Z3Bpb1xuIik7DQorCQkJcmV0dXJuIHJldDsNCisJCX0NCisJCWdwaW9fc2V0X3ZhbHVlX2NhbnNs
ZWVwKGNzNDJ4eDgtPmdwaW9fcmVzZXQsIDEpOw0KKwl9DQorDQogCWNzNDJ4eDgtPmNsayA9IGRl
dm1fY2xrX2dldChkZXYsICJtY2xrIik7DQogCWlmIChJU19FUlIoY3M0Mnh4OC0+Y2xrKSkgew0K
IAkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZ2V0IHRoZSBjbG9jazogJWxkXG4iLA0KQEAgLTU0
Nyw2ICs1NjAsMTEgQEAgc3RhdGljIGludCBjczQyeHg4X3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBk
ZXZpY2UgKmRldikNCiAJCXJldHVybiByZXQ7DQogCX0NCiANCisJaWYgKGdwaW9faXNfdmFsaWQo
Y3M0Mnh4OC0+Z3Bpb19yZXNldCkpIHsNCisJCWdwaW9fc2V0X3ZhbHVlX2NhbnNsZWVwKGNzNDJ4
eDgtPmdwaW9fcmVzZXQsIDApOw0KKwkJZ3Bpb19zZXRfdmFsdWVfY2Fuc2xlZXAoY3M0Mnh4OC0+
Z3Bpb19yZXNldCwgMSk7DQorCX0NCisNCiAJcmV0ID0gcmVndWxhdG9yX2J1bGtfZW5hYmxlKEFS
UkFZX1NJWkUoY3M0Mnh4OC0+c3VwcGxpZXMpLA0KIAkJCQkgICAgY3M0Mnh4OC0+c3VwcGxpZXMp
Ow0KIAlpZiAocmV0KSB7DQpAQCAtNTU5LDYgKzU3Nyw3IEBAIHN0YXRpYyBpbnQgY3M0Mnh4OF9y
dW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogDQogCXJlZ2NhY2hlX2NhY2hlX29u
bHkoY3M0Mnh4OC0+cmVnbWFwLCBmYWxzZSk7DQogDQorCXJlZ2NhY2hlX21hcmtfZGlydHkoY3M0
Mnh4OC0+cmVnbWFwKTsNCiAJcmV0ID0gcmVnY2FjaGVfc3luYyhjczQyeHg4LT5yZWdtYXApOw0K
IAlpZiAocmV0KSB7DQogCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBzeW5jIHJlZ21hcDogJWRc
biIsIHJldCk7DQotLSANCjEuOS4xDQoNCg==
