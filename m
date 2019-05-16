Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7517BC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A05206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="bkMTDLtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfEPLXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:23:01 -0400
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:17873
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726923AbfEPLXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdev-co-uk;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3csnKADdSUAt8TSJkqhYZZl184/FTfPNTd73qCyDRI=;
 b=bkMTDLtYhMxqsHpiHNRY03ltmW5u6LL18YYzmdnaZRu47Ki2IhkruanLmuwfa9d29WNkFgVCt8AHtJ1PEIKMIKEVrND4BeOAU9mtkklQvakP/AoSTT4pBtLxg0jVQ1jKL1Ao2iApZkLqPBxlGGnVWgC7YHlYScbv+xHwN9ZyzoI=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB0413.eurprd08.prod.outlook.com (10.162.12.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 16 May 2019 11:22:56 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::8e9:9487:4f0a:fdaf]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::8e9:9487:4f0a:fdaf%3]) with mapi id 15.20.1878.024; Thu, 16 May 2019
 11:22:56 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: vt6656: returns error code on
 vnt_int_start_interrupt fail
Thread-Topic: [PATCH] staging: vt6656: returns error code on
 vnt_int_start_interrupt fail
Thread-Index: AQHVC9m12V1LZttiK0yGWFHzOe/4XQ==
Date:   Thu, 16 May 2019 11:22:56 +0000
Message-ID: <20190516112243.14353-1-quentin.deslandes@itdev.co.uk>
References: <20190516093046.1400-1-quentin.deslandes@itdev.co.uk>
In-Reply-To: <20190516093046.1400-1-quentin.deslandes@itdev.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0125.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::30) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66243a98-9af8-4616-a81d-08d6d9f0d80e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR08MB0413;
x-ms-traffictypediagnostic: VI1PR08MB0413:
x-microsoft-antispam-prvs: <VI1PR08MB0413B5FAF549F57948D1FD9CB30A0@VI1PR08MB0413.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(366004)(346002)(136003)(396003)(376002)(189003)(199004)(316002)(7736002)(25786009)(36756003)(68736007)(76176011)(6486002)(6436002)(54906003)(52116002)(71190400001)(71200400001)(305945005)(99286004)(53936002)(2351001)(14454004)(256004)(14444005)(2501003)(8676002)(5640700003)(4326008)(74482002)(6512007)(44832011)(8936002)(73956011)(66476007)(66556008)(64756008)(66946007)(66446008)(102836004)(6916009)(26005)(186003)(386003)(6506007)(50226002)(1076003)(66066001)(3846002)(6116002)(2616005)(476003)(486006)(508600001)(86362001)(446003)(2906002)(5660300002)(81166006)(11346002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB0413;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YeDv3Tab2e8vKhAvU1KZALvj777N+HfMYiqCv105+Tgum6ekfoBAztP07V+pzt8grZExBx5FJsNi/Iknn0YmiyU3YtjUgi1hecCH0GVmbacC1jK6KMfP7w0baCJ2bWK92awpUqdoPJz29QBHgNYYxlFVaHBRzBLqPcYWrKTCDwrIkyWWUHI9ParvstjeHeNYKiePzOOEImYVOC6anGWZAH4wd/V26gvGxCayyXEqbMzsyQW8rZq7SFs/fS28/m/ii1UolLZsenEluJLGAq5wdhpsPH1wqBiDMesHVeGk9SVDp2hSmJ3uEAMP977xIrAIZdWp4oZmOHYPW1cm68extgZzoeAuq+Uof0B/T3eyQ64OVGokn0XlC/u9zM8Z1aMquNQ6awOoGOn47b/wkld2DIvgh6w75TScqyNJVT8zjn4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 66243a98-9af8-4616-a81d-08d6d9f0d80e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 11:22:56.5145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV0dXJucyBlcnJvciBjb2RlIGZyb20gJ3ZudF9pbnRfc3RhcnRfaW50ZXJydXB0KCknIHNvIHRo
ZSBkZXZpY2UncyBwcml2YXRlDQpidWZmZXJzIHdpbGwgYmUgY29ycmVjdGx5IGZyZWVkIGFuZCAn
c3RydWN0IGllZWU4MDIxMV9odycgc3RhcnQgZnVuY3Rpb24NCndpbGwgcmV0dXJuIGFuIGVycm9y
IGNvZGUuDQoNClNpZ25lZC1vZmYtYnk6IFF1ZW50aW4gRGVzbGFuZGVzIDxxdWVudGluLmRlc2xh
bmRlc0BpdGRldi5jby51az4NCi0tLQ0KdjI6IGluc3RlYWQgb2YgcmVtb3Zpbmcgc3RhdHVzIHZh
cmlhYmxlLCByZXR1cm5zIGl0cyB2YWx1ZSB0byBjYWxsZXIgYW5kDQogICAgaGFuZGxlIGVycm9y
IGluIGNhbGxlci4NCg0KIGRyaXZlcnMvc3RhZ2luZy92dDY2NTYvaW50LmMgICAgICB8ICA0ICsr
Ky0NCiBkcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L2ludC5oICAgICAgfCAgMiArLQ0KIGRyaXZlcnMv
c3RhZ2luZy92dDY2NTYvbWFpbl91c2IuYyB8IDEyICsrKysrKysrKy0tLQ0KIDMgZmlsZXMgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvc3RhZ2luZy92dDY2NTYvaW50LmMgYi9kcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L2ludC5j
DQppbmRleCA1MDQ0MjRiMTlmY2YuLmYzZWUyMTk4ZTFiMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
c3RhZ2luZy92dDY2NTYvaW50LmMNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvaW50LmMN
CkBAIC0zOSw3ICszOSw3IEBAIHN0YXRpYyBjb25zdCB1OCBmYWxsYmFja19yYXRlMVs1XVs1XSA9
IHsNCiAJe1JBVEVfNTRNLCBSQVRFXzU0TSwgUkFURV8zNk0sIFJBVEVfMThNLCBSQVRFXzE4TX0N
CiB9Ow0KIA0KLXZvaWQgdm50X2ludF9zdGFydF9pbnRlcnJ1cHQoc3RydWN0IHZudF9wcml2YXRl
ICpwcml2KQ0KK2ludCB2bnRfaW50X3N0YXJ0X2ludGVycnVwdChzdHJ1Y3Qgdm50X3ByaXZhdGUg
KnByaXYpDQogew0KIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KIAlpbnQgc3RhdHVzOw0KQEAgLTUx
LDYgKzUxLDggQEAgdm9pZCB2bnRfaW50X3N0YXJ0X2ludGVycnVwdChzdHJ1Y3Qgdm50X3ByaXZh
dGUgKnByaXYpDQogCXN0YXR1cyA9IHZudF9zdGFydF9pbnRlcnJ1cHRfdXJiKHByaXYpOw0KIA0K
IAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwcml2LT5sb2NrLCBmbGFncyk7DQorDQorCXJldHVy
biBzdGF0dXM7DQogfQ0KIA0KIHN0YXRpYyBpbnQgdm50X2ludF9yZXBvcnRfcmF0ZShzdHJ1Y3Qg
dm50X3ByaXZhdGUgKnByaXYsIHU4IHBrdF9ubywgdTggdHNyKQ0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc3RhZ2luZy92dDY2NTYvaW50LmggYi9kcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L2ludC5oDQpp
bmRleCA5ODdjNDU0ZTk5ZTkuLjhhNmQ2MDU2OWNlYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3Rh
Z2luZy92dDY2NTYvaW50LmgNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvaW50LmgNCkBA
IC00MSw3ICs0MSw3IEBAIHN0cnVjdCB2bnRfaW50ZXJydXB0X2RhdGEgew0KIAl1OCBzd1syXTsN
CiB9IF9fcGFja2VkOw0KIA0KLXZvaWQgdm50X2ludF9zdGFydF9pbnRlcnJ1cHQoc3RydWN0IHZu
dF9wcml2YXRlICpwcml2KTsNCitpbnQgdm50X2ludF9zdGFydF9pbnRlcnJ1cHQoc3RydWN0IHZu
dF9wcml2YXRlICpwcml2KTsNCiB2b2lkIHZudF9pbnRfcHJvY2Vzc19kYXRhKHN0cnVjdCB2bnRf
cHJpdmF0ZSAqcHJpdik7DQogDQogI2VuZGlmIC8qIF9fSU5UX0hfXyAqLw0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvbWFpbl91c2IuYyBiL2RyaXZlcnMvc3RhZ2luZy92dDY2
NTYvbWFpbl91c2IuYw0KaW5kZXggY2NhZmNjMmM4N2FjLi43MWUxMGI5YWUyNTMgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L21haW5fdXNiLmMNCisrKyBiL2RyaXZlcnMvc3Rh
Z2luZy92dDY2NTYvbWFpbl91c2IuYw0KQEAgLTQ4Myw2ICs0ODMsNyBAQCBzdGF0aWMgdm9pZCB2
bnRfdHhfODAyMTEoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsDQogDQogc3RhdGljIGludCB2bnRf
c3RhcnQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQogew0KKwlpbnQgZXJyID0gMDsNCiAJc3Ry
dWN0IHZudF9wcml2YXRlICpwcml2ID0gaHctPnByaXY7DQogDQogCXByaXYtPnJ4X2J1Zl9zeiA9
IE1BWF9UT1RBTF9TSVpFX1dJVEhfQUxMX0hFQURFUlM7DQpAQCAtNDk2LDE1ICs0OTcsMjAgQEAg
c3RhdGljIGludCB2bnRfc3RhcnQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQogDQogCWlmICh2
bnRfaW5pdF9yZWdpc3RlcnMocHJpdikgPT0gZmFsc2UpIHsNCiAJCWRldl9kYmcoJnByaXYtPnVz
Yi0+ZGV2LCAiIGluaXQgcmVnaXN0ZXIgZmFpbFxuIik7DQorCQllcnIgPSAtRU5PTUVNOw0KIAkJ
Z290byBmcmVlX2FsbDsNCiAJfQ0KIA0KLQlpZiAodm50X2tleV9pbml0X3RhYmxlKHByaXYpKQ0K
KwlpZiAodm50X2tleV9pbml0X3RhYmxlKHByaXYpKSB7DQorCQllcnIgPSAtRU5PTUVNOw0KIAkJ
Z290byBmcmVlX2FsbDsNCisJfQ0KIA0KIAlwcml2LT5pbnRfaW50ZXJ2YWwgPSAxOyAgLyogYklu
dGVydmFsIGlzIHNldCB0byAxICovDQogDQotCXZudF9pbnRfc3RhcnRfaW50ZXJydXB0KHByaXYp
Ow0KKwllcnIgPSB2bnRfaW50X3N0YXJ0X2ludGVycnVwdChwcml2KTsNCisJaWYgKGVycikNCisJ
CWdvdG8gZnJlZV9hbGw7DQogDQogCWllZWU4MDIxMV93YWtlX3F1ZXVlcyhodyk7DQogDQpAQCAt
NTE4LDcgKzUyNCw3IEBAIHN0YXRpYyBpbnQgdm50X3N0YXJ0KHN0cnVjdCBpZWVlODAyMTFfaHcg
Kmh3KQ0KIAl1c2Jfa2lsbF91cmIocHJpdi0+aW50ZXJydXB0X3VyYik7DQogCXVzYl9mcmVlX3Vy
Yihwcml2LT5pbnRlcnJ1cHRfdXJiKTsNCiANCi0JcmV0dXJuIC1FTk9NRU07DQorCXJldHVybiBl
cnI7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIHZudF9zdG9wKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3
KQ0KLS0gDQoyLjE3LjENCg0K
