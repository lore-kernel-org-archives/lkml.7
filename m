Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00592C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDF820821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="HQ1mTl3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfDPK6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:58:00 -0400
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:28451
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726796AbfDPK6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TytXiavi6LB40QvUKL36e5yWgNhb4y8kif3/oH3BKpM=;
 b=HQ1mTl3DaItEXC6u2Zu3DX2aIzc9ELUw++KpuDq5hJUsdarELfCFS6Yu74Qut2yBrlgXz6cEVZpSqQW1MV55udv9X2yKhnNgUGB1czM5Vg/VX/D9b1ETCotv1N9VI83BhngZdsDxgePX4WMkUdMZ7WV8ZymfyH4vLnsCb6PtgmU=
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com (20.178.104.212) by
 DB7PR06MB4330.eurprd06.prod.outlook.com (52.135.140.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Tue, 16 Apr 2019 10:57:54 +0000
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::edef:902c:11a7:478]) by DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::edef:902c:11a7:478%6]) with mapi id 15.20.1792.018; Tue, 16 Apr 2019
 10:57:54 +0000
From:   Han Nandor <nandor.han@vaisala.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Han Nandor <nandor.han@vaisala.com>
Subject: [PATCH v3 1/1] rtc: ds3232: get SRAM access using NVMEM Framework
Thread-Topic: [PATCH v3 1/1] rtc: ds3232: get SRAM access using NVMEM
 Framework
Thread-Index: AQHU9EM+z7x/ugQMdE2+a8kQ936ntQ==
Date:   Tue, 16 Apr 2019 10:57:54 +0000
Message-ID: <20190416105741.11895-1-nandor.han@vaisala.com>
References: <33e0d0d0764c8606dc611721c8c5abe37678675a>
In-Reply-To: <33e0d0d0764c8606dc611721c8c5abe37678675a>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0085.eurprd07.prod.outlook.com
 (2603:10a6:3:64::29) To DB7PR06MB5563.eurprd06.prod.outlook.com
 (2603:10a6:10:83::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nandor.han@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.2
x-originating-ip: [193.143.230.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ffa178d-68bd-4111-4cd4-08d6c25a6067
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(2017052603328)(7193020);SRVR:DB7PR06MB4330;
x-ms-traffictypediagnostic: DB7PR06MB4330:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <DB7PR06MB4330B5A2299D8C9339E966A885240@DB7PR06MB4330.eurprd06.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39850400004)(346002)(376002)(199004)(189003)(86362001)(7736002)(36756003)(11926002)(2906002)(25786009)(2201001)(68736007)(105586002)(106356001)(3846002)(97736004)(71190400001)(71200400001)(478600001)(99286004)(6116002)(53936002)(14454004)(66066001)(6512007)(5790100002)(256004)(14444005)(316002)(11346002)(4326008)(2616005)(8936002)(50226002)(446003)(486006)(1076003)(476003)(81156014)(8676002)(110136005)(81166006)(52116002)(2501003)(6506007)(386003)(76176011)(6486002)(26005)(305945005)(102836004)(6436002)(5660300002)(107886003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB4330;H:DB7PR06MB5563.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tzyNuis62TT79OMZTPWp633Cu81KqSaD4bcpJwz9ShjHFJdAjCpiQIJAZFdHcOV+uwmoRdCjadwHlh8jqW1WfVIrBhmg8RU94aD5afWWXNvscnpVFBd6DZjdxhy8+asipBTne3TDKA/7M8AKeOdj4liYzTdkk6+fpHgo38UPe2yF8BrqAC4oOMWyewK0gqc3Y7/y72qJbuB37paRl7H/StvK18mwDNU5Xf2dz31IpWKeDmgEpVV00uI0aKlg38dsMr2xe40WZtMDbpdn9qydxngnbvniUkSv1uGoshAWxS7T2YeY6fci3bl8qOFF/SYfrYDm0nGB35KzmYWKRawUE2W3O89s7Yo+0AoV6U9uSakJlJk0zJN1arWRHj8vHrSaKQ8K8hmIDQB3s3LJ7yRZ4aNLXelVyy+iwKXNgU9LGjo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffa178d-68bd-4111-4cd4-08d6c25a6067
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 10:57:54.2873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFMzMjMyIFJUQyBoYXMgMjM2IGJ5dGVzIG9mIHBlcnNpc3RlbnQgbWVtb3J5Lg0KDQpBZGQgUlRD
IFNSQU0gcmVhZCBhbmQgd3JpdGUgYWNjZXNzIHVzaW5nDQp0aGUgTlZNRU0gRnJhbWV3b3JrLg0K
DQpTaWduZWQtb2ZmLWJ5OiBOYW5kb3IgSGFuIDxuYW5kb3IuaGFuQHZhaXNhbGEuY29tPg0KLS0t
DQoNCkRlc2NyaXB0aW9uDQotLS0tLS0tLS0tLQ0KUHJvdmlkZXMgRFMzMjMyIFJUQyBTUkFNIGFj
Y2VzcyB1c2luZyBOVk1FTSBmcmFtZXdvcmsuDQoNClRlc3RpbmcNCi0tLS0tLS0NClRoZSB0ZXN0
IHdhcyBkb25lIG9uIGEgY3VzdG9tIGJvYXJkIHdoaWNoIGNvbnRhaW5zIGENCkRTMzIzMiBSVEMg
ZGV2aWNlLg0KS2VybmVsIFZlcnNpb246IDQuMTQuNjAgKEp1c3QgZm9yIGNsYXJpdHksIHRoZSBw
YXRjaCBpcyBhZ2FpbnN0IG1hc3RlcikNCg0KMS4gVmVyaWZ5IHRoYXQgU1JBTSBpcyBhY2Nlc3Np
YmxlIHVzaW5nIE5WTUVNIGludGVyZmFjZTogUEFTUw0KYA0KIyBoZXhkdW1wIC9zeXMvYnVzL252
bWVtL2RldmljZXMvZHMzMjMyX3NyYW0wL252bWVtDQowMDAwMDAwIDAwMDAgMDAwMCAwMDAwIDAw
MDAgMDAwMCAwMDAwIDAwMDAgMDAwMA0KKg0KMDAwMDBlMA0KYA0KMi4gTW9kaWZ5IHRoZSBjb250
ZW50Lg0KYA0KIyBlY2hvIHRlc3RpbmcgPiAvc3lzL2J1cy9udm1lbS9kZXZpY2VzL2RzMzIzMl9z
cmFtMC9udm1lbQ0KIw0KYA0KMy4gUG93ZXIgY3ljbGUgdGhlIGJvYXJkIGFuZCB2ZXJpZnkgdGhh
dCBjb250ZW50cyBhcmUgcHJlc2VydmVkOiBQQVNTDQpgDQojIGhleGR1bXAgLW4gMTAgLUMgL3N5
cy9idXMvbnZtZW0vZGV2aWNlcy9kczMyMzJfc3JhbTAvbnZtZW0NCjAwMDAwMDAwICA3NCA2NSA3
MyA3NCA2OSA2ZSA2NyAwYSAgMDAgMDAgICAgICAgICAgICAgICAgICAgIHx0ZXN0aW5nLi4ufA0K
MDAwMDAwMGENCmANCg0KVGVzdGluZyBvbiBLZXJuZWwgdjUuMS4wLXJjMw0KDQoxLiBVcGRhdGUg
YGFyY2gvYXJtL2NvbmZpZ3MvaW14X3Y2X3Y3X2RlZmNvbmZpZ2AgdG8gY29udGFpbg0KYENPTkZJ
R19SVENfRFJWX0RTMzIzMj15YA0KMi4gVmVyaWZ5IHRoYXQgYnVpbGRpbmcgdGhlIGtlcm5lbCBp
cyBzdWNjZXNzZnVsOiBQQVNTDQpgDQptYWtlIEFSQ0g9YXJtIENST1NTX0NPTVBJTEU9YXJtLWxp
bnV4LWdudS0gaW14X3Y2X3Y3X2RlZmNvbmZpZyB6SW1hZ2UNCi4uLg0KQ0MgICAgICBkcml2ZXJz
L3J0Yy9ydGMtZHMzMjMyLm8NCi4uLg0KS2VybmVsOiBhcmNoL2FybS9ib290L3pJbWFnZSBpcyBy
ZWFkeQ0KYA0KDQpDaGFuZ2VzIHNpbmNlIHYxDQotLS0tLS0tLS0tLS0tLS0tDQogLSByZW1vdmUg
dGhlIHVubmVjZXNzYXJ5IGhlYWRlciAicnRjLWNvcmUuaCINCiAtIHVzZSBudm1lbV9jb25maWcg
ZnJvbSB0aGUgc3RhY2sNCiAtIGNvbmZpZ3VyZSB0aGUgbnZtZW0gdHlwZQ0KIC0gcmVtb3ZlIHRo
ZSBgb2Zfbm9kZWAgY29uZmlndXJhdGlvbg0KDQpDaGFuZ2VzIHNpbmNlIHYyDQotLS0tLS0tLS0t
LS0tLS0tDQogLSBpbml0IHVudXNlZCBzdHJ1Y3QgbnZtZW1fY2ZnIG1lbWJlcnMgdG8gMA0KIC0g
dXNlIHJlZ21hcCBhcyBwcml2YXRlIGRhdGEgdG8gbnZtZW0gc3RydWN0DQoNCiBkcml2ZXJzL3J0
Yy9ydGMtZHMzMjMyLmMgfCA0MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tDQogMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3J0Yy9ydGMtZHMzMjMyLmMgYi9kcml2ZXJzL3J0Yy9ydGMt
ZHMzMjMyLmMNCmluZGV4IDcxODRlNTE0NWYxMi4uMWU5MzEyZjk2MDIxIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ydGMvcnRjLWRzMzIzMi5jDQorKysgYi9kcml2ZXJzL3J0Yy9ydGMtZHMzMjMyLmMN
CkBAIC00OCw2ICs0OCwxMCBAQA0KICMgICAgICAgZGVmaW5lIERTMzIzMl9SRUdfU1JfQTFGICAg
ICAweDAxDQogDQogI2RlZmluZSBEUzMyMzJfUkVHX1RFTVBFUkFUVVJFCTB4MTENCisjZGVmaW5l
IERTMzIzMl9SRUdfU1JBTV9TVEFSVCAgIDB4MTQNCisjZGVmaW5lIERTMzIzMl9SRUdfU1JBTV9F
TkQgICAgIDB4RkYNCisNCisjZGVmaW5lIERTMzIzMl9SRUdfU1JBTV9TSVpFICAgIDIzNg0KIA0K
IHN0cnVjdCBkczMyMzIgew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXY7DQpAQCAtNDYxLDExICs0NjUs
MzkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBydGNfY2xhc3Nfb3BzIGRzMzIzMl9ydGNfb3BzID0g
ew0KIAkuYWxhcm1faXJxX2VuYWJsZSA9IGRzMzIzMl9hbGFybV9pcnFfZW5hYmxlLA0KIH07DQog
DQorc3RhdGljIGludCBkczMyMzJfbnZtZW1fcmVhZCh2b2lkICpwcml2LCB1bnNpZ25lZCBpbnQg
b2Zmc2V0LCB2b2lkICp2YWwsDQorCQkJICAgICBzaXplX3QgYnl0ZXMpDQorew0KKwlzdHJ1Y3Qg
cmVnbWFwICpkczMyMzJfcmVnbWFwID0gKHN0cnVjdCByZWdtYXAgKilwcml2Ow0KKw0KKwlyZXR1
cm4gcmVnbWFwX2J1bGtfcmVhZChkczMyMzJfcmVnbWFwLCBEUzMyMzJfUkVHX1NSQU1fU1RBUlQg
KyBvZmZzZXQsDQorCQkJCXZhbCwgYnl0ZXMpOw0KK30NCisNCitzdGF0aWMgaW50IGRzMzIzMl9u
dm1lbV93cml0ZSh2b2lkICpwcml2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LCB2b2lkICp2YWwsDQor
CQkJICAgICAgc2l6ZV90IGJ5dGVzKQ0KK3sNCisJc3RydWN0IHJlZ21hcCAqZHMzMjMyX3JlZ21h
cCA9IChzdHJ1Y3QgcmVnbWFwICopcHJpdjsNCisNCisJcmV0dXJuIHJlZ21hcF9idWxrX3dyaXRl
KGRzMzIzMl9yZWdtYXAsIERTMzIzMl9SRUdfU1JBTV9TVEFSVCArIG9mZnNldCwNCisJCQkJIHZh
bCwgYnl0ZXMpOw0KK30NCisNCiBzdGF0aWMgaW50IGRzMzIzMl9wcm9iZShzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCByZWdtYXAgKnJlZ21hcCwgaW50IGlycSwNCiAJCQljb25zdCBjaGFyICpu
YW1lKQ0KIHsNCiAJc3RydWN0IGRzMzIzMiAqZHMzMjMyOw0KIAlpbnQgcmV0Ow0KKwlzdHJ1Y3Qg
bnZtZW1fY29uZmlnIG52bWVtX2NmZyA9IHsNCisJCS5uYW1lID0gImRzMzIzMl9zcmFtIiwNCisJ
CS5zdHJpZGUgPSAxLA0KKwkJLnNpemUgPSBEUzMyMzJfUkVHX1NSQU1fU0laRSwNCisJCS53b3Jk
X3NpemUgPSAxLA0KKwkJLnJlZ19yZWFkID0gZHMzMjMyX252bWVtX3JlYWQsDQorCQkucmVnX3dy
aXRlID0gZHMzMjMyX252bWVtX3dyaXRlLA0KKwkJLnByaXYgPSByZWdtYXAsDQorCQkudHlwZSA9
IE5WTUVNX1RZUEVfQkFUVEVSWV9CQUNLRUQNCisJfTsNCiANCiAJZHMzMjMyID0gZGV2bV9remFs
bG9jKGRldiwgc2l6ZW9mKCpkczMyMzIpLCBHRlBfS0VSTkVMKTsNCiAJaWYgKCFkczMyMzIpDQpA
QCAtNDkwLDYgKzUyMiwxMCBAQCBzdGF0aWMgaW50IGRzMzIzMl9wcm9iZShzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCByZWdtYXAgKnJlZ21hcCwgaW50IGlycSwNCiAJaWYgKElTX0VSUihkczMy
MzItPnJ0YykpDQogCQlyZXR1cm4gUFRSX0VSUihkczMyMzItPnJ0Yyk7DQogDQorCXJldCA9IHJ0
Y19udm1lbV9yZWdpc3RlcihkczMyMzItPnJ0YywgJm52bWVtX2NmZyk7DQorCWlmKHJldCkNCisJ
CXJldHVybiByZXQ7DQorDQogCWlmIChkczMyMzItPmlycSA+IDApIHsNCiAJCXJldCA9IGRldm1f
cmVxdWVzdF90aHJlYWRlZF9pcnEoZGV2LCBkczMyMzItPmlycSwgTlVMTCwNCiAJCQkJCQlkczMy
MzJfaXJxLA0KQEAgLTU0Miw3ICs1NzgsNyBAQCBzdGF0aWMgaW50IGRzMzIzMl9pMmNfcHJvYmUo
c3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCiAJc3RhdGljIGNvbnN0IHN0cnVjdCByZWdtYXBf
Y29uZmlnIGNvbmZpZyA9IHsNCiAJCS5yZWdfYml0cyA9IDgsDQogCQkudmFsX2JpdHMgPSA4LA0K
LQkJLm1heF9yZWdpc3RlciA9IDB4MTMsDQorCQkubWF4X3JlZ2lzdGVyID0gRFMzMjMyX1JFR19T
UkFNX0VORCwNCiAJfTsNCiANCiAJcmVnbWFwID0gZGV2bV9yZWdtYXBfaW5pdF9pMmMoY2xpZW50
LCAmY29uZmlnKTsNCkBAIC02MDksNyArNjQ1LDcgQEAgc3RhdGljIGludCBkczMyMzRfcHJvYmUo
c3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCiAJc3RhdGljIGNvbnN0IHN0cnVjdCByZWdtYXBfY29u
ZmlnIGNvbmZpZyA9IHsNCiAJCS5yZWdfYml0cyA9IDgsDQogCQkudmFsX2JpdHMgPSA4LA0KLQkJ
Lm1heF9yZWdpc3RlciA9IDB4MTMsDQorCQkubWF4X3JlZ2lzdGVyID0gRFMzMjMyX1JFR19TUkFN
X0VORCwNCiAJCS53cml0ZV9mbGFnX21hc2sgPSAweDgwLA0KIAl9Ow0KIAlzdHJ1Y3QgcmVnbWFw
ICpyZWdtYXA7DQotLSANCjIuMTcuMg0KDQo=
