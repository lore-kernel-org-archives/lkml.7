Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432B5C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046F720850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="jcDamTqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDKFyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:54:17 -0400
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:42151
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfDKFyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oudfJHGkFBm5nlY+aU8Jwkl6F/1BN+5kVHDvfrixJUY=;
 b=jcDamTqna7ygseTsL+KNJgXHsLKd5EsN70K8Xg1VOjG3rbkp+TmMoWRBt9gWnNYEoMDJG6NHUQlG3iqQzwkOKwFs1Gx/d+J5dsnuTih9dUdzDwgOASyeS44w+3QPbmnQQXal0jHB03aq47+UObLm1tobzuOvqiiYShD0pfF/FD0=
Received: from AM6PR06MB5557.eurprd06.prod.outlook.com (20.178.94.211) by
 AM6PR06MB5365.eurprd06.prod.outlook.com (20.178.90.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Thu, 11 Apr 2019 05:54:09 +0000
Received: from AM6PR06MB5557.eurprd06.prod.outlook.com
 ([fe80::c0b4:b693:fdc7:e476]) by AM6PR06MB5557.eurprd06.prod.outlook.com
 ([fe80::c0b4:b693:fdc7:e476%4]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 05:54:09 +0000
From:   Han Nandor <nandor.han@vaisala.com>
To:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Han Nandor <nandor.han@vaisala.com>
Subject: [PATCH v2 1/2] power: reset: nvmem-reboot-mode: use NVMEM as reboot
 mode write interface
Thread-Topic: [PATCH v2 1/2] power: reset: nvmem-reboot-mode: use NVMEM as
 reboot mode write interface
Thread-Index: AQHU8Cr6oIbVVSxty0C3UbBNgltg/g==
Date:   Thu, 11 Apr 2019 05:54:09 +0000
Message-ID: <20190411055341.9263-2-nandor.han@vaisala.com>
References: <20190411055341.9263-1-nandor.han@vaisala.com>
In-Reply-To: <20190411055341.9263-1-nandor.han@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0160.eurprd05.prod.outlook.com
 (2603:10a6:7:28::47) To AM6PR06MB5557.eurprd06.prod.outlook.com
 (2603:10a6:20b:9c::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nandor.han@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.2
x-originating-ip: [193.143.230.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50d81e53-9e47-45a4-2d3b-08d6be421aa6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR06MB5365;
x-ms-traffictypediagnostic: AM6PR06MB5365:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <AM6PR06MB53654CAC716BA66FD8DAC353852F0@AM6PR06MB5365.eurprd06.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39850400004)(346002)(376002)(199004)(189003)(2616005)(186003)(6436002)(105586002)(6512007)(6116002)(7736002)(25786009)(3846002)(81156014)(446003)(305945005)(486006)(11346002)(8936002)(53936002)(5660300002)(81166006)(2906002)(71190400001)(71200400001)(14444005)(50226002)(8676002)(76176011)(66066001)(256004)(99286004)(110136005)(6486002)(107886003)(36756003)(476003)(52116002)(4326008)(106356001)(386003)(97736004)(316002)(102836004)(2201001)(14454004)(6506007)(478600001)(26005)(2501003)(68736007)(1076003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR06MB5365;H:AM6PR06MB5557.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l+T8LfLQFuBjgae1Qc0U4hLLgfVmYYfL6MVhK01cLE/OY4r78I8gRbDWJVAnD/48gI84GiYt35eXnIeYASeSwZ1ipPLFWEKfUhuRRqRRndJvBLQRrBj3qg9lwhSFfP9/FNWrwSp7ZfPcQpXdKoRADHEmlQq12QulVN/ywe3HKASGYVAjRGkoUZa6Wev9DgX4iWIhpG8acECuIdlp36WVRDfBrxiXK7r462QUtaW6uSyjgkZqPSu4Do3100NXgZlHds9zqzbzRLqVyC/kiuODBEMn9KfrxtYormkanj49DE76SRg2vrJqQbAZgCj5ALntJ/xL8J9d5uJDMQ3sf7qEK+T8bF3IZrn7S1XgF/Z5eDXZIzNSWksog2H3f0F9PKdx5zvm7eemmeVExnvGxWkYT3Kki9z6wzrnLuso2hozwyI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d81e53-9e47-45a4-2d3b-08d6be421aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 05:54:09.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5365
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgbmV3IHJlYm9vdCBtb2RlIHdyaXRlIGludGVyZmFjZSB0aGF0IGlzIHVzaW5nIGFuIE5W
TUVNIGNlbGwNCnRvIHN0b3JlIHRoZSByZWJvb3QgbW9kZSBtYWdpYy4NCg0KU2lnbmVkLW9mZi1i
eTogTmFuZG9yIEhhbiA8bmFuZG9yLmhhbkB2YWlzYWxhLmNvbT4NCi0tLQ0KIGRyaXZlcnMvcG93
ZXIvcmVzZXQvS2NvbmZpZyAgICAgICAgICAgICB8ICA5ICsrKw0KIGRyaXZlcnMvcG93ZXIvcmVz
ZXQvTWFrZWZpbGUgICAgICAgICAgICB8ICAxICsNCiBkcml2ZXJzL3Bvd2VyL3Jlc2V0L252bWVt
LXJlYm9vdC1tb2RlLmMgfCA3NiArKysrKysrKysrKysrKysrKysrKysrKysrDQogMyBmaWxlcyBj
aGFuZ2VkLCA4NiBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcG93
ZXIvcmVzZXQvbnZtZW0tcmVib290LW1vZGUuYw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dl
ci9yZXNldC9LY29uZmlnIGIvZHJpdmVycy9wb3dlci9yZXNldC9LY29uZmlnDQppbmRleCA2NTMz
YWE1NjBhYTEuLmJiNGE0ZTg1NGY5NiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcG93ZXIvcmVzZXQv
S2NvbmZpZw0KKysrIGIvZHJpdmVycy9wb3dlci9yZXNldC9LY29uZmlnDQpAQCAtMjQ1LDUgKzI0
NSwxNCBAQCBjb25maWcgUE9XRVJfUkVTRVRfU0MyN1hYDQogCSAgUE1JQ3MgaW5jbHVkZXMgdGhl
IFNDMjcyMCwgU0MyNzIxLCBTQzI3MjMsIFNDMjczMA0KIAkgIGFuZCBTQzI3MzEgY2hpcHMuDQog
DQorY29uZmlnIE5WTUVNX1JFQk9PVF9NT0RFDQorCXRyaXN0YXRlICJHZW5lcmljIE5WTUVNIHJl
Ym9vdCBtb2RlIGRyaXZlciINCisJc2VsZWN0IFJFQk9PVF9NT0RFDQorCWhlbHANCisJICBTYXkg
eSBoZXJlIHdpbGwgZW5hYmxlIHJlYm9vdCBtb2RlIGRyaXZlci4gVGhpcyB3aWxsDQorCSAgZ2V0
IHJlYm9vdCBtb2RlIGFyZ3VtZW50cyBhbmQgc3RvcmUgaXQgaW4gYSBOVk1FTSBjZWxsLA0KKwkg
IHRoZW4gdGhlIGJvb3Rsb2FkZXIgY2FuIHJlYWQgaXQgYW5kIHRha2UgZGlmZmVyZW50DQorCSAg
YWN0aW9uIGFjY29yZGluZyB0byB0aGUgbW9kZS4NCisNCiBlbmRpZg0KIA0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcG93ZXIvcmVzZXQvTWFrZWZpbGUgYi9kcml2ZXJzL3Bvd2VyL3Jlc2V0L01ha2Vm
aWxlDQppbmRleCAwYWViZWU5NTRhYzEuLjg1ZGEzMTk4ZTRlMCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvcG93ZXIvcmVzZXQvTWFrZWZpbGUNCisrKyBiL2RyaXZlcnMvcG93ZXIvcmVzZXQvTWFrZWZp
bGUNCkBAIC0yOSwzICsyOSw0IEBAIG9iai0kKENPTkZJR19QT1dFUl9SRVNFVF9aWCkgKz0gengt
cmVib290Lm8NCiBvYmotJChDT05GSUdfUkVCT09UX01PREUpICs9IHJlYm9vdC1tb2RlLm8NCiBv
YmotJChDT05GSUdfU1lTQ09OX1JFQk9PVF9NT0RFKSArPSBzeXNjb24tcmVib290LW1vZGUubw0K
IG9iai0kKENPTkZJR19QT1dFUl9SRVNFVF9TQzI3WFgpICs9IHNjMjd4eC1wb3dlcm9mZi5vDQor
b2JqLSQoQ09ORklHX05WTUVNX1JFQk9PVF9NT0RFKSArPSBudm1lbS1yZWJvb3QtbW9kZS5vDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlci9yZXNldC9udm1lbS1yZWJvb3QtbW9kZS5jIGIvZHJp
dmVycy9wb3dlci9yZXNldC9udm1lbS1yZWJvb3QtbW9kZS5jDQpuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KaW5kZXggMDAwMDAwMDAwMDAwLi44MTZjZmRhYjE2YTcNCi0tLSAvZGV2L251bGwNCisrKyBi
L2RyaXZlcnMvcG93ZXIvcmVzZXQvbnZtZW0tcmVib290LW1vZGUuYw0KQEAgLTAsMCArMSw3NiBA
QA0KKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KKy8qDQorICogQ29weXJp
Z2h0IChjKSBWYWlzYWxhIE95ai4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCisgKi8NCisNCisjaW5j
bHVkZSA8bGludXgvaW5pdC5oPg0KKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCisjaW5jbHVk
ZSA8bGludXgva2VybmVsLmg+DQorI2luY2x1ZGUgPGxpbnV4L29mLmg+DQorI2luY2x1ZGUgPGxp
bnV4L252bWVtLWNvbnN1bWVyLmg+DQorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5o
Pg0KKyNpbmNsdWRlIDxsaW51eC9yZWJvb3QtbW9kZS5oPg0KKw0KK3N0cnVjdCBudm1lbV9yZWJv
b3RfbW9kZSB7DQorCXN0cnVjdCByZWJvb3RfbW9kZV9kcml2ZXIgcmVib290Ow0KKwlzdHJ1Y3Qg
bnZtZW1fY2VsbCAqY2VsbDsNCit9Ow0KKw0KK3N0YXRpYyBpbnQgbnZtZW1fcmVib290X21vZGVf
d3JpdGUoc3RydWN0IHJlYm9vdF9tb2RlX2RyaXZlciAqcmVib290LA0KKwkJCQkgICAgdW5zaWdu
ZWQgaW50IG1hZ2ljKQ0KK3sNCisJaW50IHJldDsNCisJc3RydWN0IG52bWVtX3JlYm9vdF9tb2Rl
ICpudm1lbV9yYm07DQorDQorCW52bWVtX3JibSA9IGNvbnRhaW5lcl9vZihyZWJvb3QsIHN0cnVj
dCBudm1lbV9yZWJvb3RfbW9kZSwgcmVib290KTsNCisNCisJcmV0ID0gbnZtZW1fY2VsbF93cml0
ZShudm1lbV9yYm0tPmNlbGwsICZtYWdpYywgc2l6ZW9mKG1hZ2ljKSk7DQorCWlmIChyZXQgPCAw
KQ0KKwkJZGV2X2VycihyZWJvb3QtPmRldiwgInVwZGF0ZSByZWJvb3QgbW9kZSBiaXRzIGZhaWxl
ZFxuIik7DQorDQorCXJldHVybiByZXQ7DQorfQ0KKw0KK3N0YXRpYyBpbnQgbnZtZW1fcmVib290
X21vZGVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCit7DQorCWludCByZXQ7
DQorCXN0cnVjdCBudm1lbV9yZWJvb3RfbW9kZSAqbnZtZW1fcmJtOw0KKw0KKwludm1lbV9yYm0g
PSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCpudm1lbV9yYm0pLCBHRlBfS0VSTkVM
KTsNCisJaWYgKCFudm1lbV9yYm0pDQorCQlyZXR1cm4gLUVOT01FTTsNCisNCisJbnZtZW1fcmJt
LT5yZWJvb3QuZGV2ID0gJnBkZXYtPmRldjsNCisJbnZtZW1fcmJtLT5yZWJvb3Qud3JpdGUgPSBu
dm1lbV9yZWJvb3RfbW9kZV93cml0ZTsNCisNCisJbnZtZW1fcmJtLT5jZWxsID0gZGV2bV9udm1l
bV9jZWxsX2dldCgmcGRldi0+ZGV2LCAicmVib290LW1vZGUiKTsNCisJaWYgKElTX0VSUihudm1l
bV9yYm0tPmNlbGwpKSB7DQorCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZ2V0IHRo
ZSBudm1lbSBjZWxsIHJlYm9vdC1tb2RlXG4iKTsNCisJCXJldHVybiBQVFJfRVJSKG52bWVtX3Ji
bS0+Y2VsbCk7DQorCX0NCisNCisJcmV0ID0gZGV2bV9yZWJvb3RfbW9kZV9yZWdpc3RlcigmcGRl
di0+ZGV2LCAmbnZtZW1fcmJtLT5yZWJvb3QpOw0KKwlpZiAocmV0KQ0KKwkJZGV2X2VycigmcGRl
di0+ZGV2LCAiY2FuJ3QgcmVnaXN0ZXIgcmVib290IG1vZGVcbiIpOw0KKw0KKwlyZXR1cm4gcmV0
Ow0KK30NCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBudm1lbV9yZWJvb3Rf
bW9kZV9vZl9tYXRjaFtdID0gew0KKwl7IC5jb21wYXRpYmxlID0gIm52bWVtLXJlYm9vdC1tb2Rl
IiB9LA0KKwl7fQ0KK307DQorTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbnZtZW1fcmVib290X21v
ZGVfb2ZfbWF0Y2gpOw0KKw0KK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG52bWVtX3Jl
Ym9vdF9tb2RlX2RyaXZlciA9IHsNCisJLnByb2JlID0gbnZtZW1fcmVib290X21vZGVfcHJvYmUs
DQorCS5kcml2ZXIgPSB7DQorCQkubmFtZSA9ICJudm1lbS1yZWJvb3QtbW9kZSIsDQorCQkub2Zf
bWF0Y2hfdGFibGUgPSBudm1lbV9yZWJvb3RfbW9kZV9vZl9tYXRjaCwNCisJfSwNCit9Ow0KK21v
ZHVsZV9wbGF0Zm9ybV9kcml2ZXIobnZtZW1fcmVib290X21vZGVfZHJpdmVyKTsNCisNCitNT0RV
TEVfQVVUSE9SKCJOYW5kb3IgSGFuIDxuYW5kb3IuaGFuQHZhaXNhbGEuY29tPiIpOw0KK01PRFVM
RV9ERVNDUklQVElPTigiTlZNRU0gcmVib290IG1vZGUgZHJpdmVyIik7DQorTU9EVUxFX0xJQ0VO
U0UoIkdQTCB2MiIpOw0KLS0gDQoyLjE3LjINCg0K
