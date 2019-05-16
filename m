Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF9EC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D7420645
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="ZXzzJSMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfEPL5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:57:32 -0400
Received: from mail-eopbgr140055.outbound.protection.outlook.com ([40.107.14.55]:51104
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726623AbfEPL5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toXCzcG4+vmkdQm5YcEF9FeNTKa0IwyfzIpOLTNT+/4=;
 b=ZXzzJSMrMoGGT/eiFR60wTfMcZjjswbMpOkccrxaB26ak6XUNFXG5MJHZlmdDoG728hjrY4Ytmv1esUFfuleoO+pgjt1BJ9NLyng7ADZMfuLEGJtJx+Lifhh7Dvf8tFRvHdmqZUDT8pqfoUUDPJiW1gmqjjT5VceZq5pv0eom1o=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB3968.eurprd08.prod.outlook.com (20.178.125.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 11:57:15 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::8e9:9487:4f0a:fdaf]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::8e9:9487:4f0a:fdaf%3]) with mapi id 15.20.1878.024; Thu, 16 May 2019
 11:57:15 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] staging: vt6656: returns error code on
 vnt_int_start_interrupt fail
Thread-Topic: [PATCH v2] staging: vt6656: returns error code on
 vnt_int_start_interrupt fail
Thread-Index: AQHVC96A+EJOd0fenE60pjbLPtRDhg==
Date:   Thu, 16 May 2019 11:57:15 +0000
Message-ID: <20190516115653.15120-1-quentin.deslandes@itdev.co.uk>
References: <20190516093046.1400-1-quentin.deslandes@itdev.co.uk>
In-Reply-To: <20190516093046.1400-1-quentin.deslandes@itdev.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::18) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6eac3f93-2ac4-4ba1-06b9-08d6d9f5a329
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR08MB3968;
x-ms-traffictypediagnostic: VI1PR08MB3968:
x-microsoft-antispam-prvs: <VI1PR08MB3968AA011A63B1D72DA4B5F4B30A0@VI1PR08MB3968.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:166;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(256004)(6512007)(99286004)(446003)(81156014)(52116002)(2906002)(508600001)(1076003)(25786009)(5660300002)(102836004)(6436002)(76176011)(50226002)(5640700003)(6486002)(305945005)(7736002)(8676002)(14444005)(4326008)(8936002)(14454004)(386003)(6506007)(81166006)(11346002)(476003)(2616005)(66066001)(44832011)(36756003)(486006)(186003)(66556008)(64756008)(316002)(2501003)(6916009)(68736007)(2351001)(54906003)(86362001)(6116002)(3846002)(53936002)(66476007)(26005)(71190400001)(66946007)(73956011)(71200400001)(66446008)(74482002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3968;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ujb5iJqqmI+/BreFdf8eUfzho4IEEZDujFkGwfnd8U+PYwgY4pT4m8/kFN2mup8Hz6yyZq2w9CF1pduGxEuLGGekeLVR6OWOr+DwkMCgRrQPFmve1aU2soVVF7ZlPNL+n5TVxwPuRCcPLwRXf/c3VPocG5zPOPRMtRs1ltEo/oZbNEv1xVlABtPLBbCf/INaINx5tW80v5fB7Kyqqz8AU+MfXr39prnNbymkPMbdIgps5Iy2b3rCGB0f6Ewc7/pJQ02p079e9H/0P3l+S/+wOvWJE6/nBcH+7xofovqO5LiNQLNwoYP5abtXqEA+5S2r+cz18X+XPIBTtrm+kvDf5pUyrNG//NOM7uQCBoub7VUPMhKHJUrSENynT5ySg58VSE9PzuUkg/obGdzBC7UeDXcsaeNG2wcaIEmmwOgMZkU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eac3f93-2ac4-4ba1-06b9-08d6d9f5a329
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 11:57:15.0776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3968
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV0dXJucyBlcnJvciBjb2RlIGZyb20gJ3ZudF9pbnRfc3RhcnRfaW50ZXJydXB0KCknIHNvIHRo
ZSBkZXZpY2UncyBwcml2YXRlDQpidWZmZXJzIHdpbGwgYmUgY29ycmVjdGx5IGZyZWVkIGFuZCAn
c3RydWN0IGllZWU4MDIxMV9odycgc3RhcnQgZnVuY3Rpb24NCndpbGwgcmV0dXJuIGFuIGVycm9y
IGNvZGUuDQoNClNpZ25lZC1vZmYtYnk6IFF1ZW50aW4gRGVzbGFuZGVzIDxxdWVudGluLmRlc2xh
bmRlc0BpdGRldi5jby51az4NCi0tLQ0KIGRyaXZlcnMvc3RhZ2luZy92dDY2NTYvaW50LmMgICAg
ICB8ICA0ICsrKy0NCiBkcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L2ludC5oICAgICAgfCAgMiArLQ0K
IGRyaXZlcnMvc3RhZ2luZy92dDY2NTYvbWFpbl91c2IuYyB8IDEyICsrKysrKysrKy0tLQ0KIDMg
ZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvaW50LmMgYi9kcml2ZXJzL3N0YWdpbmcvdnQ2
NjU2L2ludC5jDQppbmRleCA1MDQ0MjRiMTlmY2YuLmYzZWUyMTk4ZTFiMyAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvaW50LmMNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy92dDY2
NTYvaW50LmMNCkBAIC0zOSw3ICszOSw3IEBAIHN0YXRpYyBjb25zdCB1OCBmYWxsYmFja19yYXRl
MVs1XVs1XSA9IHsNCiAJe1JBVEVfNTRNLCBSQVRFXzU0TSwgUkFURV8zNk0sIFJBVEVfMThNLCBS
QVRFXzE4TX0NCiB9Ow0KIA0KLXZvaWQgdm50X2ludF9zdGFydF9pbnRlcnJ1cHQoc3RydWN0IHZu
dF9wcml2YXRlICpwcml2KQ0KK2ludCB2bnRfaW50X3N0YXJ0X2ludGVycnVwdChzdHJ1Y3Qgdm50
X3ByaXZhdGUgKnByaXYpDQogew0KIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KIAlpbnQgc3RhdHVz
Ow0KQEAgLTUxLDYgKzUxLDggQEAgdm9pZCB2bnRfaW50X3N0YXJ0X2ludGVycnVwdChzdHJ1Y3Qg
dm50X3ByaXZhdGUgKnByaXYpDQogCXN0YXR1cyA9IHZudF9zdGFydF9pbnRlcnJ1cHRfdXJiKHBy
aXYpOw0KIA0KIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwcml2LT5sb2NrLCBmbGFncyk7DQor
DQorCXJldHVybiBzdGF0dXM7DQogfQ0KIA0KIHN0YXRpYyBpbnQgdm50X2ludF9yZXBvcnRfcmF0
ZShzdHJ1Y3Qgdm50X3ByaXZhdGUgKnByaXYsIHU4IHBrdF9ubywgdTggdHNyKQ0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvaW50LmggYi9kcml2ZXJzL3N0YWdpbmcvdnQ2NjU2
L2ludC5oDQppbmRleCA5ODdjNDU0ZTk5ZTkuLjhhNmQ2MDU2OWNlYiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvc3RhZ2luZy92dDY2NTYvaW50LmgNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYv
aW50LmgNCkBAIC00MSw3ICs0MSw3IEBAIHN0cnVjdCB2bnRfaW50ZXJydXB0X2RhdGEgew0KIAl1
OCBzd1syXTsNCiB9IF9fcGFja2VkOw0KIA0KLXZvaWQgdm50X2ludF9zdGFydF9pbnRlcnJ1cHQo
c3RydWN0IHZudF9wcml2YXRlICpwcml2KTsNCitpbnQgdm50X2ludF9zdGFydF9pbnRlcnJ1cHQo
c3RydWN0IHZudF9wcml2YXRlICpwcml2KTsNCiB2b2lkIHZudF9pbnRfcHJvY2Vzc19kYXRhKHN0
cnVjdCB2bnRfcHJpdmF0ZSAqcHJpdik7DQogDQogI2VuZGlmIC8qIF9fSU5UX0hfXyAqLw0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvbWFpbl91c2IuYyBiL2RyaXZlcnMvc3Rh
Z2luZy92dDY2NTYvbWFpbl91c2IuYw0KaW5kZXggY2NhZmNjMmM4N2FjLi43MWUxMGI5YWUyNTMg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L21haW5fdXNiLmMNCisrKyBiL2Ry
aXZlcnMvc3RhZ2luZy92dDY2NTYvbWFpbl91c2IuYw0KQEAgLTQ4Myw2ICs0ODMsNyBAQCBzdGF0
aWMgdm9pZCB2bnRfdHhfODAyMTEoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsDQogDQogc3RhdGlj
IGludCB2bnRfc3RhcnQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQogew0KKwlpbnQgZXJyID0g
MDsNCiAJc3RydWN0IHZudF9wcml2YXRlICpwcml2ID0gaHctPnByaXY7DQogDQogCXByaXYtPnJ4
X2J1Zl9zeiA9IE1BWF9UT1RBTF9TSVpFX1dJVEhfQUxMX0hFQURFUlM7DQpAQCAtNDk2LDE1ICs0
OTcsMjAgQEAgc3RhdGljIGludCB2bnRfc3RhcnQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQog
DQogCWlmICh2bnRfaW5pdF9yZWdpc3RlcnMocHJpdikgPT0gZmFsc2UpIHsNCiAJCWRldl9kYmco
JnByaXYtPnVzYi0+ZGV2LCAiIGluaXQgcmVnaXN0ZXIgZmFpbFxuIik7DQorCQllcnIgPSAtRU5P
TUVNOw0KIAkJZ290byBmcmVlX2FsbDsNCiAJfQ0KIA0KLQlpZiAodm50X2tleV9pbml0X3RhYmxl
KHByaXYpKQ0KKwlpZiAodm50X2tleV9pbml0X3RhYmxlKHByaXYpKSB7DQorCQllcnIgPSAtRU5P
TUVNOw0KIAkJZ290byBmcmVlX2FsbDsNCisJfQ0KIA0KIAlwcml2LT5pbnRfaW50ZXJ2YWwgPSAx
OyAgLyogYkludGVydmFsIGlzIHNldCB0byAxICovDQogDQotCXZudF9pbnRfc3RhcnRfaW50ZXJy
dXB0KHByaXYpOw0KKwllcnIgPSB2bnRfaW50X3N0YXJ0X2ludGVycnVwdChwcml2KTsNCisJaWYg
KGVycikNCisJCWdvdG8gZnJlZV9hbGw7DQogDQogCWllZWU4MDIxMV93YWtlX3F1ZXVlcyhodyk7
DQogDQpAQCAtNTE4LDcgKzUyNCw3IEBAIHN0YXRpYyBpbnQgdm50X3N0YXJ0KHN0cnVjdCBpZWVl
ODAyMTFfaHcgKmh3KQ0KIAl1c2Jfa2lsbF91cmIocHJpdi0+aW50ZXJydXB0X3VyYik7DQogCXVz
Yl9mcmVlX3VyYihwcml2LT5pbnRlcnJ1cHRfdXJiKTsNCiANCi0JcmV0dXJuIC1FTk9NRU07DQor
CXJldHVybiBlcnI7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIHZudF9zdG9wKHN0cnVjdCBpZWVlODAy
MTFfaHcgKmh3KQ0KLS0gDQoyLjE3LjENCg0K
