Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8932CC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C980218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BSn34yED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDLKTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:19:46 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:42998 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLKTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:19:43 -0400
X-IronPort-AV: E=Sophos;i="5.60,340,1549954800"; 
   d="scan'208";a="31374108"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Apr 2019 03:19:42 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 12 Apr 2019 03:19:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4kdUBe1TGQF3UjzuU9b/rLPl3rEEF1fNkuqB7xP2a0=;
 b=BSn34yEDO1/6yRTPf9kLpgUOqDuZY2cYpNEQHkGvhfPzmm3kb/MuH6gBIDkpU+buxMb9Q0Ghx7GpnuKq3lq9dBNYoKOXfjrM74VS1+efYj6JZPrmgm2afabLPp0FF8DN7NBijXrrVJ86ZHdm3XUQVQ1LlB4o6HBhzsbMpTSslvw=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1947.namprd11.prod.outlook.com (10.175.88.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.16; Fri, 12 Apr 2019 10:19:40 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 10:19:40 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <mchehab@kernel.org>,
        <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 1/3] media: atmel: atmel-isc: limit incoming pixels per frame
Thread-Topic: [PATCH 1/3] media: atmel: atmel-isc: limit incoming pixels per
 frame
Thread-Index: AQHU8Rk9Y6GORtaCfE+2SknPF+34Og==
Date:   Fri, 12 Apr 2019 10:19:40 +0000
Message-ID: <1555064098-19310-2-git-send-email-eugen.hristev@microchip.com>
References: <1555064098-19310-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1555064098-19310-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0111.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::40) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9eabd60a-c950-40fc-f811-08d6bf305fb8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR11MB1947;
x-ms-traffictypediagnostic: DM5PR11MB1947:
x-microsoft-antispam-prvs: <DM5PR11MB1947B5CFE152F119B046CB80E8280@DM5PR11MB1947.namprd11.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(105586002)(54906003)(102836004)(36756003)(50226002)(26005)(14454004)(2906002)(97736004)(66066001)(6486002)(6436002)(6506007)(386003)(305945005)(7736002)(2501003)(81166006)(5660300002)(8676002)(446003)(8936002)(81156014)(107886003)(14444005)(256004)(486006)(4326008)(478600001)(76176011)(110136005)(106356001)(68736007)(316002)(86362001)(3846002)(71200400001)(52116002)(72206003)(2616005)(476003)(25786009)(6116002)(186003)(6512007)(71190400001)(99286004)(11346002)(2201001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1947;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z+3E3TIY+R1HU64aCCrGVjve05e3pHxkyUxyA/j+82JNx5abUU7qQlH71yagHm3V/jMajF1Mb4ORUCxJ9gHs4uhqm1C2Fvs03Uya51HN2kbhlKHsuQIj50kxTaFnoORwYrzrbVAvVpu83ns+l4SDCfL2yGBQcC+H6NA83FCzyFS7a/E4RJDvSaI9woRc8XHQO6JYOgwT8RNeh9/UGH3tsjwgmkMLhmDM1j+2NTI0P/zAAfbskcwGXMQ6GUF6Gjbap4EXmC2opzYqjlq+NK+rLZvSRSIAxWk9qjZrZHFzCQr/LfjW2zppsa/YQUeIFl1y9br7ElN4lJHr5P9Mds+Ig/TBhVXyvzsBkNVvp8YMElE4kPlQb3MQtL3v7vVpch6mvRpvtWfdAUrh4IRn1w3Ml8TUHw2Aa/7jPwFz7Fq03/s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eabd60a-c950-40fc-f811-08d6bf305fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 10:19:40.8490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1947
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KDQpUaGlz
IHdpbGwgbGltaXQgdGhlIGluY29taW5nIHBpeGVscyBwZXIgZnJhbWUgZnJvbSB0aGUgc2Vuc29y
Lg0KQ3VycmVudGx5LCB0aGUgSVNDIHdpbGwgc3RvcCBzYW1wbGluZyB0aGUgZnJhbWUgb25seSB3
aGVuIHRoZSB2c3luYy9oc3luYw0KYXJlIGRldGVjdGVkLg0KSWYgd2UgbWlzY29uZmlndXJlIHRo
ZSByZXNvbHV0aW9uIGluIHRoZSBzZW5zb3Igdy5yLnQuIHJlc29sdXRpb24gaW4gdGhlIElTQywN
CnRoZSBidWZmZXIgdXNlZCBmb3IgRE1BIGluIHRoZSBJU0Mgd2lsbCBiZSBzbWFsbGVyIHRoYW4g
dGhlIG51bWJlciBvZiBwaXhlbHMNCnRoYXQgdGhlIElTQyBETUEgZW5naW5lIHdpbGwgY29weS4N
CkluIHRoaXMgY2FzZSBpdCBoYXBwZW5zIHRoYXQgdGhlIERNQSB3aWxsIG92ZXJ3cml0ZSBwYXJ0
cyBvZiB0aGUgbWVtb3J5IHdoaWNoDQpzaG91bGQgbm90IGJlIHdyaXR0ZW4sIGxlYWRpbmcgdG8g
bWVtb3J5IGNvcnJ1cHRpb24uDQpUbyBhdm9pZCB0aGlzIHNpdHVhdGlvbiwgdXNlIHRoZSBQRkUg
Q0ZHMSBhbmQgUEZFIENGRzIgcmVnaXN0ZXJzLCB3aGljaCBjcm9wDQp0aGUgaW5jb21pbmcgZnJh
bWUgdG8gdGhlIHJlc29sdXRpb24gdGhhdCB3ZSBjb25maWd1cmUuDQpUaGlzIHdheSB0aGUgRE1B
IGVuZ2luZSB3aWxsIG5ldmVyIHdyaXRlIG1vcmUgZGF0YSB0aGFuIHdlIGV4cGVjdCBpdCB0by4N
Cg0KU2lnbmVkLW9mZi1ieTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAu
Y29tPg0KLS0tDQogZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MtcmVncy5o
IHwgMTkgKysrKysrKysrKysrKysrDQogZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1l
bC1pc2MuYyAgICAgIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMiBmaWxlcyBj
aGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1yZWdzLmggYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0
bWVsL2F0bWVsLWlzYy1yZWdzLmgNCmluZGV4IDJhYWRjMTkuLjc2OGE1YWQgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1yZWdzLmgNCisrKyBiL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLXJlZ3MuaA0KQEAgLTM1LDYgKzM1
LDI1IEBADQogI2RlZmluZSBJU0NfUEZHX0NGRzBfQlBTX1RXRUxWRSAoMHgwIDw8IDI4KQ0KICNk
ZWZpbmUgSVNDX1BGRV9DRkcwX0JQU19NQVNLICAgR0VOTUFTSygzMCwgMjgpDQogDQorI2RlZmlu
ZSBJU0NfUEZFX0NGRzBfQ09MRU4JQklUKDEyKQ0KKyNkZWZpbmUgSVNDX1BGRV9DRkcwX1JPV0VO
CUJJVCgxMykNCisNCisvKiBJU0MgUGFyYWxsZWwgRnJvbnQgRW5kIENvbmZpZ3VyYXRpb24gMSBS
ZWdpc3RlciAqLw0KKyNkZWZpbmUgSVNDX1BGRV9DRkcxICAgIDB4MDAwMDAwMTANCisNCisjZGVm
aW5lIElTQ19QRkVfQ0ZHMV9DT0xNSU4odikJCSgodikpDQorI2RlZmluZSBJU0NfUEZFX0NGRzFf
Q09MTUlOX01BU0sJR0VOTUFTSygxNSwgMCkNCisjZGVmaW5lIElTQ19QRkVfQ0ZHMV9DT0xNQVgo
dikJCSgodikgPDwgMTYpDQorI2RlZmluZSBJU0NfUEZFX0NGRzFfQ09MTUFYX01BU0sJR0VOTUFT
SygzMSwgMTYpDQorDQorLyogSVNDIFBhcmFsbGVsIEZyb250IEVuZCBDb25maWd1cmF0aW9uIDIg
UmVnaXN0ZXIgKi8NCisjZGVmaW5lIElTQ19QRkVfQ0ZHMiAgICAweDAwMDAwMDE0DQorDQorI2Rl
ZmluZSBJU0NfUEZFX0NGRzJfUk9XTUlOKHYpCQkoKHYpKQ0KKyNkZWZpbmUgSVNDX1BGRV9DRkcy
X1JPV01JTl9NQVNLCUdFTk1BU0soMTUsIDApDQorI2RlZmluZSBJU0NfUEZFX0NGRzJfUk9XTUFY
KHYpCQkoKHYpIDw8IDE2KQ0KKyNkZWZpbmUgSVNDX1BGRV9DRkcyX1JPV01BWF9NQVNLCUdFTk1B
U0soMzEsIDE2KQ0KKw0KIC8qIElTQyBDbG9jayBFbmFibGUgUmVnaXN0ZXIgKi8NCiAjZGVmaW5l
IElTQ19DTEtFTiAgICAgICAgICAgICAgIDB4MDAwMDAwMTgNCiANCmRpZmYgLS1naXQgYS9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jIGIvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9hdG1lbC9hdG1lbC1pc2MuYw0KaW5kZXggYTEwZGIxNi4uZWE3NTIwYSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLmMNCisrKyBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLmMNCkBAIC03MjEsNiArNzIxLDQwIEBA
IHN0YXRpYyB2b2lkIGlzY19zdGFydF9kbWEoc3RydWN0IGlzY19kZXZpY2UgKmlzYykNCiAJdTMy
IHNpemVpbWFnZSA9IGlzYy0+Zm10LmZtdC5waXguc2l6ZWltYWdlOw0KIAl1MzIgZGN0cmxfZHZp
ZXc7DQogCWRtYV9hZGRyX3QgYWRkcjA7DQorCXUzMiBoLCB3Ow0KKw0KKwloID0gaXNjLT5mbXQu
Zm10LnBpeC5oZWlnaHQ7DQorCXcgPSBpc2MtPmZtdC5mbXQucGl4LndpZHRoOw0KKw0KKwkvKg0K
KwkgKiBJbiBjYXNlIHRoZSBzZW5zb3IgaXMgbm90IFJBVywgaXQgd2lsbCBvdXRwdXQgYSBwaXhl
bCAoMTItMTYgYml0cykNCisJICogd2l0aCB0d28gc2FtcGxlcyBvbiB0aGUgSVNDIERhdGEgYnVz
ICh3aGljaCBpcyA4LTEyKQ0KKwkgKiBJU0Mgd2lsbCBjb3VudCBlYWNoIHNhbXBsZSwgc28sIHdl
IG5lZWQgdG8gbXVsdGlwbHkgdGhlc2UgdmFsdWVzDQorCSAqIGJ5IHR3bywgdG8gZ2V0IHRoZSBy
ZWFsIG51bWJlciBvZiBzYW1wbGVzIGZvciB0aGUgcmVxdWlyZWQgcGl4ZWxzLg0KKwkgKi8NCisJ
aWYgKCFJU0NfSVNfRk9STUFUX1JBVyhpc2MtPmNvbmZpZy5zZF9mb3JtYXQtPm1idXNfY29kZSkp
IHsNCisJCWggPDw9IDE7DQorCQl3IDw8PSAxOw0KKwl9DQorDQorCS8qDQorCSAqIFdlIGxpbWl0
IHRoZSBjb2x1bW4vcm93IGNvdW50IHRoYXQgdGhlIElTQyB3aWxsIG91dHB1dCBhY2NvcmRpbmcN
CisJICogdG8gdGhlIGNvbmZpZ3VyZWQgcmVzb2x1dGlvbiB0aGF0IHdlIHdhbnQuDQorCSAqIFRo
aXMgd2lsbCBhdm9pZCB0aGUgc2l0dWF0aW9uIHdoZXJlIHRoZSBzZW5zb3IgaXMgbWlzY29uZmln
dXJlZCwNCisJICogc2VuZGluZyBtb3JlIGRhdGEsIGFuZCB0aGUgSVNDIHdpbGwganVzdCB0YWtl
IGl0IGFuZCBETUEgdG8gbWVtb3J5LA0KKwkgKiBjYXVzaW5nIGNvcnJ1cHRpb24uDQorCSAqLw0K
KwlyZWdtYXBfd3JpdGUocmVnbWFwLCBJU0NfUEZFX0NGRzEsDQorCQkgICAgIChJU0NfUEZFX0NG
RzFfQ09MTUlOKDApICYgSVNDX1BGRV9DRkcxX0NPTE1JTl9NQVNLKSB8DQorCQkgICAgIChJU0Nf
UEZFX0NGRzFfQ09MTUFYKHcgLSAxKSAmIElTQ19QRkVfQ0ZHMV9DT0xNQVhfTUFTSykpOw0KKw0K
KwlyZWdtYXBfd3JpdGUocmVnbWFwLCBJU0NfUEZFX0NGRzIsDQorCQkgICAgIChJU0NfUEZFX0NG
RzJfUk9XTUlOKDApICYgSVNDX1BGRV9DRkcyX1JPV01JTl9NQVNLKSB8DQorCQkgICAgIChJU0Nf
UEZFX0NGRzJfUk9XTUFYKGggLSAxKSAmIElTQ19QRkVfQ0ZHMl9ST1dNQVhfTUFTSykpOw0KKw0K
KwlyZWdtYXBfdXBkYXRlX2JpdHMocmVnbWFwLCBJU0NfUEZFX0NGRzAsDQorCQkJICAgSVNDX1BG
RV9DRkcwX0NPTEVOIHwgSVNDX1BGRV9DRkcwX1JPV0VOLA0KKwkJCSAgIElTQ19QRkVfQ0ZHMF9D
T0xFTiB8IElTQ19QRkVfQ0ZHMF9ST1dFTik7DQogDQogCWFkZHIwID0gdmIyX2RtYV9jb250aWdf
cGxhbmVfZG1hX2FkZHIoJmlzYy0+Y3VyX2ZybS0+dmIudmIyX2J1ZiwgMCk7DQogCXJlZ21hcF93
cml0ZShyZWdtYXAsIElTQ19EQUQwLCBhZGRyMCk7DQotLSANCjIuNy40DQoNCg==
