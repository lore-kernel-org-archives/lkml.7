Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493AAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D861214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="llYh8KTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392679AbfETQjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:39:32 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:28806
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392648AbfETQj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3GH7ZsDuH1SdzYTbOBWAxaLhgiD0VLmogZPDLQ9TSA=;
 b=llYh8KTOk0vS/sV7cdXZzWpZdchsErTkQU58J5Ya4OECmUvuflOHlz5YgTH2xbkyr0Uf3zErVG+CsU6J/F6BRrA0MfE/L79vB6j/oWs472AOdRveCfFRzNbWI6A8rCjLlcKWHtGN6IXl9LheXJbC1H4y6gIIcW7d4lzfWDaKsUo=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB3662.eurprd08.prod.outlook.com (20.177.61.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Mon, 20 May 2019 16:39:05 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::1d25:dae7:53a6:b461]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::1d25:dae7:53a6:b461%3]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 16:39:05 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
CC:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] staging: vt6656: manage error path during device
 initialization
Thread-Topic: [PATCH 7/7] staging: vt6656: manage error path during device
 initialization
Thread-Index: AQHVDyqJGDUMHl7IJU60tXBT/8KwAA==
Date:   Mon, 20 May 2019 16:39:05 +0000
Message-ID: <20190520163844.1225-8-quentin.deslandes@itdev.co.uk>
References: <20190520163844.1225-1-quentin.deslandes@itdev.co.uk>
In-Reply-To: <20190520163844.1225-1-quentin.deslandes@itdev.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR08CA0002.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::14) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fc780eb-0ee7-41e3-5f08-08d6dd41ac4e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR08MB3662;
x-ms-traffictypediagnostic: VI1PR08MB3662:
x-microsoft-antispam-prvs: <VI1PR08MB366286EF5D82624CC0042AA8B3060@VI1PR08MB3662.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:190;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39840400004)(376002)(396003)(136003)(199004)(189003)(1730700003)(2501003)(14454004)(73956011)(486006)(8936002)(44832011)(71190400001)(71200400001)(50226002)(81156014)(81166006)(4326008)(66446008)(64756008)(66556008)(66946007)(66476007)(8676002)(53936002)(446003)(316002)(11346002)(476003)(2616005)(305945005)(6436002)(66066001)(508600001)(6486002)(7736002)(5640700003)(68736007)(25786009)(186003)(6512007)(86362001)(256004)(6116002)(3846002)(1076003)(5660300002)(26005)(36756003)(76176011)(99286004)(6916009)(6506007)(386003)(52116002)(102836004)(2351001)(54906003)(74482002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3662;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IHBuYuQ5bPDOD8hVYnoDOZ1Lm7l/sWa/EGckt7UCWTuVCH9qXaeh5jKBPZ6zRCfiZ5KcX3JTM+992iF9AYC8V3SxjrPRTwXuxaSPzoEGBa32jtpBkil5dVUmeaIe8gzQAFwVvQLzd6RZNFP8gHd1C6OC5Cc3ZstwjjoJpSMc2rrJWRlI6xY1LbPtmz1soeEtt6UIeAM+hjtJKzuukxHmV3tbaSCJ62FW9Nth5sejghVG2avZKgt98R13pLf18tCDMEZata7K3mGDY4fXcO+EMRrlJPL2w9UhvTMyEibFcHE+nowbt3hE5nZzyeJfsn1/KKCATZeKtoNwsptdkacLHRnHEQWcwwc3LfMsN1J4nB0lK0FX7/hEt0/V+ZsXGmmKvfkO/+IOdzK7Sm0+rex+Ow3IwRSP3xEP/aVqfY0c1Yg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc780eb-0ee7-41e3-5f08-08d6dd41ac4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 16:39:05.5572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hlY2sgZm9yIGVycm9yIGR1cmluZyBkZXZpY2UgaW5pdGlhbGl6YXRpb24gY2FsbGJhY2sgYW5k
IHJldHVybiBhDQptZWFuaW5nZnVsIGVycm9yIGNvZGUgb3IgemVybyBvbiBzdWNjZXNzLg0KDQpT
aWduZWQtb2ZmLWJ5OiBRdWVudGluIERlc2xhbmRlcyA8cXVlbnRpbi5kZXNsYW5kZXNAaXRkZXYu
Y28udWs+DQotLS0NCiBkcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L21haW5fdXNiLmMgfCAyMCArKysr
KysrKysrKysrLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA3IGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3Z0NjY1Ni9tYWluX3Vz
Yi5jIGIvZHJpdmVycy9zdGFnaW5nL3Z0NjY1Ni9tYWluX3VzYi5jDQppbmRleCA4ZWQ5NmU4ZWVk
YmUuLjg1NmJhOTdhZWM0ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvbWFp
bl91c2IuYw0KKysrIGIvZHJpdmVycy9zdGFnaW5nL3Z0NjY1Ni9tYWluX3VzYi5jDQpAQCAtNTI5
LDI4ICs1MjksMzQgQEAgc3RhdGljIHZvaWQgdm50X3R4XzgwMjExKHN0cnVjdCBpZWVlODAyMTFf
aHcgKmh3LA0KIA0KIHN0YXRpYyBpbnQgdm50X3N0YXJ0KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3
KQ0KIHsNCisJaW50IHJldCA9IDA7DQogCXN0cnVjdCB2bnRfcHJpdmF0ZSAqcHJpdiA9IGh3LT5w
cml2Ow0KIA0KIAlwcml2LT5yeF9idWZfc3ogPSBNQVhfVE9UQUxfU0laRV9XSVRIX0FMTF9IRUFE
RVJTOw0KIA0KLQlpZiAoIXZudF9hbGxvY19idWZzKHByaXYpKSB7DQorCXJldCA9IHZudF9hbGxv
Y19idWZzKHByaXYpOw0KKwlpZiAocmV0KSB7DQogCQlkZXZfZGJnKCZwcml2LT51c2ItPmRldiwg
InZudF9hbGxvY19idWZzIGZhaWwuLi5cbiIpOw0KLQkJcmV0dXJuIC1FTk9NRU07DQorCQlnb3Rv
IGVycjsNCiAJfQ0KIA0KIAljbGVhcl9iaXQoREVWSUNFX0ZMQUdTX0RJU0NPTk5FQ1RFRCwgJnBy
aXYtPmZsYWdzKTsNCiANCi0JaWYgKHZudF9pbml0X3JlZ2lzdGVycyhwcml2KSA9PSBmYWxzZSkg
ew0KKwlyZXQgPSB2bnRfaW5pdF9yZWdpc3RlcnMocHJpdik7DQorCWlmIChyZXQpIHsNCiAJCWRl
dl9kYmcoJnByaXYtPnVzYi0+ZGV2LCAiIGluaXQgcmVnaXN0ZXIgZmFpbFxuIik7DQogCQlnb3Rv
IGZyZWVfYWxsOw0KIAl9DQogDQotCWlmICh2bnRfa2V5X2luaXRfdGFibGUocHJpdikpDQorCXJl
dCA9IHZudF9rZXlfaW5pdF90YWJsZShwcml2KTsNCisJaWYgKHJldCkNCiAJCWdvdG8gZnJlZV9h
bGw7DQogDQogCXByaXYtPmludF9pbnRlcnZhbCA9IDE7ICAvKiBiSW50ZXJ2YWwgaXMgc2V0IHRv
IDEgKi8NCiANCi0Jdm50X2ludF9zdGFydF9pbnRlcnJ1cHQocHJpdik7DQorCXJldCA9IHZudF9p
bnRfc3RhcnRfaW50ZXJydXB0KHByaXYpOw0KKwlpZiAocmV0KQ0KKwkJZ290byBmcmVlX2FsbDsN
CiANCiAJaWVlZTgwMjExX3dha2VfcXVldWVzKGh3KTsNCiANCkBAIC01NjMsOCArNTY5LDggQEAg
c3RhdGljIGludCB2bnRfc3RhcnQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQogDQogCXVzYl9r
aWxsX3VyYihwcml2LT5pbnRlcnJ1cHRfdXJiKTsNCiAJdXNiX2ZyZWVfdXJiKHByaXYtPmludGVy
cnVwdF91cmIpOw0KLQ0KLQlyZXR1cm4gLUVOT01FTTsNCitlcnI6DQorCXJldHVybiByZXQ7DQog
fQ0KIA0KIHN0YXRpYyB2b2lkIHZudF9zdG9wKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0KLS0g
DQoyLjE3LjENCg0K
