Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6F2C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E543F206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="z2OaoHfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfEQHxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:53:55 -0400
Received: from mail-eopbgr10081.outbound.protection.outlook.com ([40.107.1.81]:58438
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727800AbfEQHxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdev-co-uk;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zyF0SW8VHKrIIVAvogZAaYQSGveFvAadZIJkq0LA5Q=;
 b=z2OaoHfGVtv6mjBIzbuh9U+6rh+dd5dY+zqSPAjtaGoWIKuV4jPttKAE8MoZXvLWpFzck3ndFG+Q3m1PxkPx/aNZCyemtfnqT+cluu7NHhwSo/4JKZ8TRKrLa8R2ZSBAkUDI5eoPtZWSnGOV6e4bWFvpUP3nBWSRsjcZ7ef4+cw=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB4271.eurprd08.prod.outlook.com (20.179.25.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Fri, 17 May 2019 07:53:50 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::8e9:9487:4f0a:fdaf]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::8e9:9487:4f0a:fdaf%3]) with mapi id 15.20.1878.028; Fri, 17 May 2019
 07:53:50 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] staging: vt6656: returns error code on
 vnt_int_start_interrupt fail
Thread-Topic: [PATCH v3] staging: vt6656: returns error code on
 vnt_int_start_interrupt fail
Thread-Index: AQHVDIWpJheiltxkuEGGqxIJz+Vw2Q==
Date:   Fri, 17 May 2019 07:53:49 +0000
Message-ID: <20190517075331.3658-1-quentin.deslandes@itdev.co.uk>
References: <20190516093046.1400-1-quentin.deslandes@itdev.co.uk>
In-Reply-To: <20190516093046.1400-1-quentin.deslandes@itdev.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6P190CA0013.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:2f::26)
 To VI1PR08MB3168.eurprd08.prod.outlook.com (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2197891-17ae-4d38-a7fd-08d6da9ccc5b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR08MB4271;
x-ms-traffictypediagnostic: VI1PR08MB4271:
x-microsoft-antispam-prvs: <VI1PR08MB4271519E352CF301691DF913B30B0@VI1PR08MB4271.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(39830400003)(346002)(199004)(189003)(68736007)(316002)(386003)(305945005)(36756003)(7736002)(6506007)(6916009)(2501003)(102836004)(1076003)(26005)(86362001)(66066001)(14444005)(256004)(6486002)(5640700003)(8676002)(76176011)(11346002)(2616005)(81166006)(81156014)(14454004)(2906002)(446003)(66946007)(66556008)(66476007)(6436002)(25786009)(73956011)(66446008)(64756008)(8936002)(50226002)(74482002)(186003)(508600001)(44832011)(476003)(99286004)(54906003)(71200400001)(71190400001)(5660300002)(6116002)(3846002)(6512007)(486006)(2351001)(53936002)(52116002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4271;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gi0t2LkvcOccvwfMDhE5np2KncNl8us3E4HtQg9zWbVCLP6SiVSKQH2Y/jkhhEIbE+8Xmtvep2DGsvI/kJcGP+HZfaY+eslBP0tn/eL/2jltM3uX3B5t9CSriEgjCbHsgzUiEukg0/kou1ZnM8257ES632XMjtLt/7LDvWYa29e/FIcLevzAXiri98uh8XEThtp/1r7P7WGkc+0ACKhvz61vV6sOC2aVmLWPSzAvJhBlkJeVNpFnaymlyKPDyM7U7dYqo+mC/EU1uam+RPVEIKC+6iYgMkFOpQySO4o2e/z2B9V3wAf6vGIbqaFpIsvq28EyYVfqO28LjZBc/cfdTxsnDy2LbVgbRlBKJ5E8pt9bvgv8ryS0fiynlOjCAut1FbwE63zTIXFMzZmd+9PGmY7f4SGUAqOrFAMGtJfyzBs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: a2197891-17ae-4d38-a7fd-08d6da9ccc5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 07:53:50.0818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV0dXJucyBlcnJvciBjb2RlIGZyb20gJ3ZudF9pbnRfc3RhcnRfaW50ZXJydXB0KCknIHNvIHRo
ZSBkZXZpY2UncyBwcml2YXRlDQpidWZmZXJzIHdpbGwgYmUgY29ycmVjdGx5IGZyZWVkIGFuZCAn
c3RydWN0IGllZWU4MDIxMV9odycgc3RhcnQgZnVuY3Rpb24NCndpbGwgcmV0dXJuIGFuIGVycm9y
IGNvZGUuDQoNClNpZ25lZC1vZmYtYnk6IFF1ZW50aW4gRGVzbGFuZGVzIDxxdWVudGluLmRlc2xh
bmRlc0BpdGRldi5jby51az4NCi0tLQ0KdjI6IHJldHVybnMgJ3N0YXR1cycgdmFsdWUgdG8gY2Fs
bGVyIGluc3RlYWQgb2YgcmVtb3ZpbmcgaXQuDQp2MzogYWRkIHBhdGNoIHZlcnNpb24gZGV0YWls
cy4gVGhhbmtzIHRvIEdyZWcgSy1IIGZvciBoaXMgaGVscC4NCg0KIGRyaXZlcnMvc3RhZ2luZy92
dDY2NTYvaW50LmMgICAgICB8ICA0ICsrKy0NCiBkcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L2ludC5o
ICAgICAgfCAgMiArLQ0KIGRyaXZlcnMvc3RhZ2luZy92dDY2NTYvbWFpbl91c2IuYyB8IDEyICsr
KysrKysrKy0tLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvaW50LmMgYi9kcml2
ZXJzL3N0YWdpbmcvdnQ2NjU2L2ludC5jDQppbmRleCA1MDQ0MjRiMTlmY2YuLmYzZWUyMTk4ZTFi
MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvaW50LmMNCisrKyBiL2RyaXZl
cnMvc3RhZ2luZy92dDY2NTYvaW50LmMNCkBAIC0zOSw3ICszOSw3IEBAIHN0YXRpYyBjb25zdCB1
OCBmYWxsYmFja19yYXRlMVs1XVs1XSA9IHsNCiAJe1JBVEVfNTRNLCBSQVRFXzU0TSwgUkFURV8z
Nk0sIFJBVEVfMThNLCBSQVRFXzE4TX0NCiB9Ow0KIA0KLXZvaWQgdm50X2ludF9zdGFydF9pbnRl
cnJ1cHQoc3RydWN0IHZudF9wcml2YXRlICpwcml2KQ0KK2ludCB2bnRfaW50X3N0YXJ0X2ludGVy
cnVwdChzdHJ1Y3Qgdm50X3ByaXZhdGUgKnByaXYpDQogew0KIAl1bnNpZ25lZCBsb25nIGZsYWdz
Ow0KIAlpbnQgc3RhdHVzOw0KQEAgLTUxLDYgKzUxLDggQEAgdm9pZCB2bnRfaW50X3N0YXJ0X2lu
dGVycnVwdChzdHJ1Y3Qgdm50X3ByaXZhdGUgKnByaXYpDQogCXN0YXR1cyA9IHZudF9zdGFydF9p
bnRlcnJ1cHRfdXJiKHByaXYpOw0KIA0KIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwcml2LT5s
b2NrLCBmbGFncyk7DQorDQorCXJldHVybiBzdGF0dXM7DQogfQ0KIA0KIHN0YXRpYyBpbnQgdm50
X2ludF9yZXBvcnRfcmF0ZShzdHJ1Y3Qgdm50X3ByaXZhdGUgKnByaXYsIHU4IHBrdF9ubywgdTgg
dHNyKQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvaW50LmggYi9kcml2ZXJz
L3N0YWdpbmcvdnQ2NjU2L2ludC5oDQppbmRleCA5ODdjNDU0ZTk5ZTkuLjhhNmQ2MDU2OWNlYiAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvaW50LmgNCisrKyBiL2RyaXZlcnMv
c3RhZ2luZy92dDY2NTYvaW50LmgNCkBAIC00MSw3ICs0MSw3IEBAIHN0cnVjdCB2bnRfaW50ZXJy
dXB0X2RhdGEgew0KIAl1OCBzd1syXTsNCiB9IF9fcGFja2VkOw0KIA0KLXZvaWQgdm50X2ludF9z
dGFydF9pbnRlcnJ1cHQoc3RydWN0IHZudF9wcml2YXRlICpwcml2KTsNCitpbnQgdm50X2ludF9z
dGFydF9pbnRlcnJ1cHQoc3RydWN0IHZudF9wcml2YXRlICpwcml2KTsNCiB2b2lkIHZudF9pbnRf
cHJvY2Vzc19kYXRhKHN0cnVjdCB2bnRfcHJpdmF0ZSAqcHJpdik7DQogDQogI2VuZGlmIC8qIF9f
SU5UX0hfXyAqLw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvbWFpbl91c2Iu
YyBiL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvbWFpbl91c2IuYw0KaW5kZXggY2NhZmNjMmM4N2Fj
Li43MWUxMGI5YWUyNTMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L21haW5f
dXNiLmMNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvbWFpbl91c2IuYw0KQEAgLTQ4Myw2
ICs0ODMsNyBAQCBzdGF0aWMgdm9pZCB2bnRfdHhfODAyMTEoc3RydWN0IGllZWU4MDIxMV9odyAq
aHcsDQogDQogc3RhdGljIGludCB2bnRfc3RhcnQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQog
ew0KKwlpbnQgZXJyID0gMDsNCiAJc3RydWN0IHZudF9wcml2YXRlICpwcml2ID0gaHctPnByaXY7
DQogDQogCXByaXYtPnJ4X2J1Zl9zeiA9IE1BWF9UT1RBTF9TSVpFX1dJVEhfQUxMX0hFQURFUlM7
DQpAQCAtNDk2LDE1ICs0OTcsMjAgQEAgc3RhdGljIGludCB2bnRfc3RhcnQoc3RydWN0IGllZWU4
MDIxMV9odyAqaHcpDQogDQogCWlmICh2bnRfaW5pdF9yZWdpc3RlcnMocHJpdikgPT0gZmFsc2Up
IHsNCiAJCWRldl9kYmcoJnByaXYtPnVzYi0+ZGV2LCAiIGluaXQgcmVnaXN0ZXIgZmFpbFxuIik7
DQorCQllcnIgPSAtRU5PTUVNOw0KIAkJZ290byBmcmVlX2FsbDsNCiAJfQ0KIA0KLQlpZiAodm50
X2tleV9pbml0X3RhYmxlKHByaXYpKQ0KKwlpZiAodm50X2tleV9pbml0X3RhYmxlKHByaXYpKSB7
DQorCQllcnIgPSAtRU5PTUVNOw0KIAkJZ290byBmcmVlX2FsbDsNCisJfQ0KIA0KIAlwcml2LT5p
bnRfaW50ZXJ2YWwgPSAxOyAgLyogYkludGVydmFsIGlzIHNldCB0byAxICovDQogDQotCXZudF9p
bnRfc3RhcnRfaW50ZXJydXB0KHByaXYpOw0KKwllcnIgPSB2bnRfaW50X3N0YXJ0X2ludGVycnVw
dChwcml2KTsNCisJaWYgKGVycikNCisJCWdvdG8gZnJlZV9hbGw7DQogDQogCWllZWU4MDIxMV93
YWtlX3F1ZXVlcyhodyk7DQogDQpAQCAtNTE4LDcgKzUyNCw3IEBAIHN0YXRpYyBpbnQgdm50X3N0
YXJ0KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0KIAl1c2Jfa2lsbF91cmIocHJpdi0+aW50ZXJy
dXB0X3VyYik7DQogCXVzYl9mcmVlX3VyYihwcml2LT5pbnRlcnJ1cHRfdXJiKTsNCiANCi0JcmV0
dXJuIC1FTk9NRU07DQorCXJldHVybiBlcnI7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIHZudF9zdG9w
KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0KLS0gDQoyLjE3LjENCg0K
