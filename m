Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E4C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B0020825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iCOuUwdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfEGOG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:06:58 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:48366
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbfEGOG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHwVkI/rL8cUi4WR5Q4QgjbWA04b5Cj9H2DLGKwWRGk=;
 b=iCOuUwdzIBBL/YlOvlhMdRFsoWhwX4EVLJkqDCQwrXeYzH/PRbWkTfX0Kv7RCvqBszFe3bjDcJ01zqQZSlup30K259GIuEKxZMlmwnpGQRuEZ+m+HIsKMSU8AUQQowE09U3MklX0it9iotdRNx4AZkTrsGkrO3djI3mZS65Vkr4=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.23.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Tue, 7 May 2019 14:06:52 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 14:06:52 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RESEND PATCH v3] ASoC: fsl_sai: Move clock operation to PM runtime
Thread-Topic: [RESEND PATCH v3] ASoC: fsl_sai: Move clock operation to PM
 runtime
Thread-Index: AQHVBN4eGvra8iOf9kOYNpic21nAcg==
Date:   Tue, 7 May 2019 14:06:52 +0000
Message-ID: <20190507140632.15996-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0003.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::13) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e20964f4-a6d1-4ba5-f638-08d6d2f54113
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2863;
x-ms-traffictypediagnostic: VI1PR0402MB2863:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0402MB286305F44D3A59D9F12C7B9FF9310@VI1PR0402MB2863.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:203;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(2351001)(86362001)(1730700003)(6512007)(6306002)(8676002)(81166006)(81156014)(36756003)(44832011)(25786009)(99286004)(71200400001)(71190400001)(4326008)(52116002)(66476007)(64756008)(66556008)(66446008)(486006)(7736002)(476003)(73956011)(2616005)(66946007)(305945005)(386003)(5640700003)(2501003)(966005)(256004)(186003)(5660300002)(2906002)(26005)(6506007)(6436002)(54906003)(316002)(50226002)(1076003)(478600001)(68736007)(3846002)(66066001)(53936002)(8936002)(6486002)(6916009)(14454004)(6116002)(14444005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2863;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2Xr8G6GS41cuYOW7fEnZ4Z0leyG1GhWEcGEE5L8pDuI9ffkFP37lywtoC8HfnJO4Vf10356a2BjwlBmnBetIU2sO0uA9+mLsBcZw8QNwWPU+HkdQOZg75tJmCwd9c98PWmuRUy7eGOEfLOB5hof7zYHH3I3sE9FI59OICIdHZkDVgUug6t1VuKYQ+5lTCotq/OjJ3wnbM+X5088iBhGLv1k7gKE2QKtrG8DA0ZmBRzRGL0WCpXi9EVozwJEsEpYYjh+B4Dx6nMRR4vWxeOV9iZHtGxTmbnxmup3MSqL1pcWG+MVnrwnhmhp7Q/8EYlc6V3jqWQGVKL9KN+u/PKG8CWtzOsNd7WeFL/CQKcT+Up12VRTigfmANV4A+xaGvol+p8G34HI9NQaj+1CtoTz8H8PiJkq6Z6f2HeFLUaHUVfo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20964f4-a6d1-4ba5-f638-08d6d2f54113
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 14:06:52.2973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2863
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KDQpUdXJuIG9mZi9v
biBjbG9ja3Mgd2hlbiBkZXZpY2UgZW50ZXJzIHN1c3BlbmQvcmVzdW1lLiBUaGlzDQpjYW4gaGVs
cCBzYXZpbmcgcG93ZXIuDQoNCkFzIGEgZnVydGhlciBvcHRpbWl6YXRpb24sIHdlIHR1cm4gb2Zm
L29uIG1jbGsgb25seSB3aGVuIFNBSQ0KaXMgaW4gbWFzdGVyIG1vZGUgYmVjYXVzZSBvdGhlcndp
c2UgbWNsayBpcyBleHRlcm5hbGx5IHByb3ZpZGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBTaGVuZ2pp
dSBXYW5nIDxzaGVuZ2ppdS53YW5nQG54cC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQmFs
dXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQpSZXZpZXdlZC1ieTogVmlvcmVsIFN1bWFuIDx2
aW9yZWwuc3VtYW5AbnhwLmNvbT4NCi0tLQ0KLSBpbml0aWFsbHkgcGFydCBvZiB0aGlzIDMgcGF0
Y2ggc2VyaWVzIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTA5MTE1MTkvDQot
IGZpcnN0IDIgcGF0Y2hlcyB3ZXJlIG1lcmdlZA0KDQogc291bmQvc29jL2ZzbC9mc2xfc2FpLmMg
fCA1NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5jIGIvc291bmQvc29jL2ZzbC9mc2xfc2FpLmMNCmluZGV4
IDg1OTMyNjkxNTZiZC4uZDU4Y2MzYWU5MGQ4IDEwMDY0NA0KLS0tIGEvc291bmQvc29jL2ZzbC9m
c2xfc2FpLmMNCisrKyBiL3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5jDQpAQCAtNTk2LDE1ICs1OTYs
OCBAQCBzdGF0aWMgaW50IGZzbF9zYWlfc3RhcnR1cChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0g
KnN1YnN0cmVhbSwNCiB7DQogCXN0cnVjdCBmc2xfc2FpICpzYWkgPSBzbmRfc29jX2RhaV9nZXRf
ZHJ2ZGF0YShjcHVfZGFpKTsNCiAJYm9vbCB0eCA9IHN1YnN0cmVhbS0+c3RyZWFtID09IFNORFJW
X1BDTV9TVFJFQU1fUExBWUJBQ0s7DQotCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZzYWktPnBkZXYt
PmRldjsNCiAJaW50IHJldDsNCiANCi0JcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHNhaS0+YnVz
X2Nsayk7DQotCWlmIChyZXQpIHsNCi0JCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSBi
dXMgY2xvY2s6ICVkXG4iLCByZXQpOw0KLQkJcmV0dXJuIHJldDsNCi0JfQ0KLQ0KIAlyZWdtYXBf
dXBkYXRlX2JpdHMoc2FpLT5yZWdtYXAsIEZTTF9TQUlfeENSMyh0eCksIEZTTF9TQUlfQ1IzX1RS
Q0UsDQogCQkJICAgRlNMX1NBSV9DUjNfVFJDRSk7DQogDQpAQCAtNjIxLDggKzYxNCw2IEBAIHN0
YXRpYyB2b2lkIGZzbF9zYWlfc2h1dGRvd24oc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJz
dHJlYW0sDQogCWJvb2wgdHggPSBzdWJzdHJlYW0tPnN0cmVhbSA9PSBTTkRSVl9QQ01fU1RSRUFN
X1BMQVlCQUNLOw0KIA0KIAlyZWdtYXBfdXBkYXRlX2JpdHMoc2FpLT5yZWdtYXAsIEZTTF9TQUlf
eENSMyh0eCksIEZTTF9TQUlfQ1IzX1RSQ0UsIDApOw0KLQ0KLQljbGtfZGlzYWJsZV91bnByZXBh
cmUoc2FpLT5idXNfY2xrKTsNCiB9DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfc29jX2Rh
aV9vcHMgZnNsX3NhaV9wY21fZGFpX29wcyA9IHsNCkBAIC05MzUsNiArOTI2LDE0IEBAIHN0YXRp
YyBpbnQgZnNsX3NhaV9ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KIHsNCiAJ
c3RydWN0IGZzbF9zYWkgKnNhaSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KIA0KKwlpZiAoc2Fp
LT5tY2xrX3N0cmVhbXMgJiBCSVQoU05EUlZfUENNX1NUUkVBTV9DQVBUVVJFKSkNCisJCWNsa19k
aXNhYmxlX3VucHJlcGFyZShzYWktPm1jbGtfY2xrW3NhaS0+bWNsa19pZFswXV0pOw0KKw0KKwlp
ZiAoc2FpLT5tY2xrX3N0cmVhbXMgJiBCSVQoU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDSykpDQor
CQljbGtfZGlzYWJsZV91bnByZXBhcmUoc2FpLT5tY2xrX2Nsa1tzYWktPm1jbGtfaWRbMV1dKTsN
CisNCisJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHNhaS0+YnVzX2Nsayk7DQorDQogCXJlZ2NhY2hl
X2NhY2hlX29ubHkoc2FpLT5yZWdtYXAsIHRydWUpOw0KIAlyZWdjYWNoZV9tYXJrX2RpcnR5KHNh
aS0+cmVnbWFwKTsNCiANCkBAIC05NDQsNiArOTQzLDI1IEBAIHN0YXRpYyBpbnQgZnNsX3NhaV9y
dW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KIHN0YXRpYyBpbnQgZnNsX3NhaV9y
dW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogew0KIAlzdHJ1Y3QgZnNsX3NhaSAq
c2FpID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQorCWludCByZXQ7DQorDQorCXJldCA9IGNsa19w
cmVwYXJlX2VuYWJsZShzYWktPmJ1c19jbGspOw0KKwlpZiAocmV0KSB7DQorCQlkZXZfZXJyKGRl
diwgImZhaWxlZCB0byBlbmFibGUgYnVzIGNsb2NrOiAlZFxuIiwgcmV0KTsNCisJCXJldHVybiBy
ZXQ7DQorCX0NCisNCisJaWYgKHNhaS0+bWNsa19zdHJlYW1zICYgQklUKFNORFJWX1BDTV9TVFJF
QU1fUExBWUJBQ0spKSB7DQorCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoc2FpLT5tY2xrX2Ns
a1tzYWktPm1jbGtfaWRbMV1dKTsNCisJCWlmIChyZXQpDQorCQkJZ290byBkaXNhYmxlX2J1c19j
bGs7DQorCX0NCisNCisJaWYgKHNhaS0+bWNsa19zdHJlYW1zICYgQklUKFNORFJWX1BDTV9TVFJF
QU1fQ0FQVFVSRSkpIHsNCisJCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShzYWktPm1jbGtfY2xr
W3NhaS0+bWNsa19pZFswXV0pOw0KKwkJaWYgKHJldCkNCisJCQlnb3RvIGRpc2FibGVfdHhfY2xr
Ow0KKwl9DQogDQogCXJlZ2NhY2hlX2NhY2hlX29ubHkoc2FpLT5yZWdtYXAsIGZhbHNlKTsNCiAJ
cmVnbWFwX3dyaXRlKHNhaS0+cmVnbWFwLCBGU0xfU0FJX1RDU1IsIEZTTF9TQUlfQ1NSX1NSKTsN
CkBAIC05NTEsNyArOTY5LDIzIEBAIHN0YXRpYyBpbnQgZnNsX3NhaV9ydW50aW1lX3Jlc3VtZShz
dHJ1Y3QgZGV2aWNlICpkZXYpDQogCXVzbGVlcF9yYW5nZSgxMDAwLCAyMDAwKTsNCiAJcmVnbWFw
X3dyaXRlKHNhaS0+cmVnbWFwLCBGU0xfU0FJX1RDU1IsIDApOw0KIAlyZWdtYXBfd3JpdGUoc2Fp
LT5yZWdtYXAsIEZTTF9TQUlfUkNTUiwgMCk7DQotCXJldHVybiByZWdjYWNoZV9zeW5jKHNhaS0+
cmVnbWFwKTsNCisNCisJcmV0ID0gcmVnY2FjaGVfc3luYyhzYWktPnJlZ21hcCk7DQorCWlmIChy
ZXQpDQorCQlnb3RvIGRpc2FibGVfcnhfY2xrOw0KKw0KKwlyZXR1cm4gMDsNCisNCitkaXNhYmxl
X3J4X2NsazoNCisJaWYgKHNhaS0+bWNsa19zdHJlYW1zICYgQklUKFNORFJWX1BDTV9TVFJFQU1f
Q0FQVFVSRSkpDQorCQljbGtfZGlzYWJsZV91bnByZXBhcmUoc2FpLT5tY2xrX2Nsa1tzYWktPm1j
bGtfaWRbMF1dKTsNCitkaXNhYmxlX3R4X2NsazoNCisJaWYgKHNhaS0+bWNsa19zdHJlYW1zICYg
QklUKFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spKQ0KKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJl
KHNhaS0+bWNsa19jbGtbc2FpLT5tY2xrX2lkWzFdXSk7DQorZGlzYWJsZV9idXNfY2xrOg0KKwlj
bGtfZGlzYWJsZV91bnByZXBhcmUoc2FpLT5idXNfY2xrKTsNCisNCisJcmV0dXJuIHJldDsNCiB9
DQogI2VuZGlmIC8qIENPTkZJR19QTSAqLw0KIA0KLS0gDQoyLjE3LjENCg0K
