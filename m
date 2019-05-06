Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC7DC46460
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF5B2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="dFmGmSnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEFMrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:47:14 -0400
Received: from mail-eopbgr150115.outbound.protection.outlook.com ([40.107.15.115]:38846
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbfEFMrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI/VPtBfd/cmkKe650BHbEU7Qfmf462oNtZOSBPNx1s=;
 b=dFmGmSnEuhOc91KCDkNnwi3l3f/2/Af3qmFhi+Eoh90eP7+7xoISSMbUwOG+nYGLgP6H5JeNJsGtpAVGGeWvUn/6Gqsilz2CZeS/uA+WTFIsyAe8rw9IGIggztq47l7iuwaQlWMJ8KErPHJzX/zEVL0dfVM8+RORCtxJ5eJHbu0=
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com (20.178.17.97) by
 AM0PR02MB4452.eurprd02.prod.outlook.com (20.178.17.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 12:47:07 +0000
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f]) by AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 12:47:07 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH RESEND 2/3] lib/test_string: avoid masking memset16/32/64
 failures
Thread-Topic: [PATCH RESEND 2/3] lib/test_string: avoid masking memset16/32/64
 failures
Thread-Index: AQHVBAnQQ43QpvCEqEK4U6dIiHiP4w==
Date:   Mon, 6 May 2019 12:47:07 +0000
Message-ID: <20190506124634.6807-3-peda@axentia.se>
References: <20190506124634.6807-1-peda@axentia.se>
In-Reply-To: <20190506124634.6807-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0901CA0059.eurprd09.prod.outlook.com
 (2603:10a6:3:45::27) To AM0PR02MB4563.eurprd02.prod.outlook.com
 (2603:10a6:208:ec::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 222021ad-1ab6-42b9-1689-08d6d220f2aa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR02MB4452;
x-ms-traffictypediagnostic: AM0PR02MB4452:
x-microsoft-antispam-prvs: <AM0PR02MB44520D7D527A2A06C1AA33DEBC300@AM0PR02MB4452.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(39830400003)(376002)(189003)(199004)(52116002)(386003)(6506007)(316002)(256004)(14444005)(102836004)(50226002)(1076003)(76176011)(71190400001)(68736007)(6916009)(71200400001)(3846002)(11346002)(446003)(6116002)(508600001)(54906003)(25786009)(2351001)(36756003)(5640700003)(99286004)(74482002)(26005)(2616005)(186003)(7736002)(2501003)(305945005)(486006)(476003)(66556008)(66066001)(4326008)(53936002)(14454004)(86362001)(6436002)(73956011)(66446008)(66476007)(6486002)(6512007)(2906002)(5660300002)(81166006)(81156014)(8936002)(66946007)(8676002)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB4452;H:AM0PR02MB4563.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +JQ6qkXIoNCA2N1X83ovrGCiSprYhbZY7G7v30NJ7ho2ch6D/dWHxCVcohhKaNk10jxVSbaZdQz63/YZqPA/hgWGUUqn0JNcq1JivKIBvBzFazSZOjmOvYl6afbpMmwJXmqpNinaYpkPYBGoSfTf1YO4yNIkEhT+RfGUE9sCgS520De62inI2AxtVUwRKY5iytQzMGrRgq9FjhQWdqLGC2d8YeIRHC5M93wsYIEgvp8wDQrPpjgFCYkENoGW/qKa2oRoY4KErnhfaTYmiGRoMHKu0T9XuQh/ULYf8G1/2CnOctCjqzdHFXieHfmdtEP8kl1FlwrgoOI3IKb4q6Cel214/aQGsydtmMMRy1fEIr7kBY3B5jBgnDC/1AXkpebje7dTQ7RdDHA+ccKxwoIeCt4N1pSbZRN5LyRS4KfNWSA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 222021ad-1ab6-42b9-1689-08d6d220f2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 12:47:07.4551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgYSBtZW1zZXRYWCBpbXBsZW1lbnRhdGlvbiBpcyBjb21wbGV0ZWx5IGJyb2tlbiBhbmQgZmFp
bHMgaW4gdGhlIGZpcnN0DQppdGVyYXRpb24sIHdoZW4gaSwgaiwgYW5kIGsgYXJlIGFsbCB6ZXJv
LCB0aGUgZmFpbHVyZSBpcyBtYXNrZWQgYXMgemVybw0KaXMgcmV0dXJuZWQuIEZhaWxpbmcgaW4g
dGhlIGZpcnN0IGl0ZXJhdGlvbiBpcyBwZXJoYXBzIHRoZSBtb3N0IGxpa2VseQ0KZmFpbHVyZSwg
c28gdGhpcyBtYWtlcyB0aGUgdGVzdHMgcHJldHR5IG11Y2ggdXNlbGVzcy4gQXZvaWQgdGhlIHNp
dHVhdGlvbg0KYnkgYWx3YXlzIHNldHRpbmcgYSByYW5kb20gdW51c2VkIGJpdCBpbiB0aGUgcmVz
dWx0IG9uIGZhaWx1cmUuDQoNCkZpeGVzOiAwMzI3MGMxM2M1ZmYgKCJsaWIvc3RyaW5nLmM6IGFk
ZCB0ZXN0Y2FzZXMgZm9yIG1lbXNldDE2LzMyLzY0IikNClNpZ25lZC1vZmYtYnk6IFBldGVyIFJv
c2luIDxwZWRhQGF4ZW50aWEuc2U+DQotLS0NCiBsaWIvdGVzdF9zdHJpbmcuYyB8IDYgKysrLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2xpYi90ZXN0X3N0cmluZy5jIGIvbGliL3Rlc3Rfc3RyaW5nLmMNCmluZGV4IDBm
Y2RiODJkY2E4Ni4uOThhNzg3ZTdhMWZkIDEwMDY0NA0KLS0tIGEvbGliL3Rlc3Rfc3RyaW5nLmMN
CisrKyBiL2xpYi90ZXN0X3N0cmluZy5jDQpAQCAtMzUsNyArMzUsNyBAQCBzdGF0aWMgX19pbml0
IGludCBtZW1zZXQxNl9zZWxmdGVzdCh2b2lkKQ0KIGZhaWw6DQogCWtmcmVlKHApOw0KIAlpZiAo
aSA8IDI1NikNCi0JCXJldHVybiAoaSA8PCAyNCkgfCAoaiA8PCAxNikgfCBrOw0KKwkJcmV0dXJu
IChpIDw8IDI0KSB8IChqIDw8IDE2KSB8IGsgfCAweDgwMDA7DQogCXJldHVybiAwOw0KIH0NCiAN
CkBAIC03MSw3ICs3MSw3IEBAIHN0YXRpYyBfX2luaXQgaW50IG1lbXNldDMyX3NlbGZ0ZXN0KHZv
aWQpDQogZmFpbDoNCiAJa2ZyZWUocCk7DQogCWlmIChpIDwgMjU2KQ0KLQkJcmV0dXJuIChpIDw8
IDI0KSB8IChqIDw8IDE2KSB8IGs7DQorCQlyZXR1cm4gKGkgPDwgMjQpIHwgKGogPDwgMTYpIHwg
ayB8IDB4ODAwMDsNCiAJcmV0dXJuIDA7DQogfQ0KIA0KQEAgLTEwNyw3ICsxMDcsNyBAQCBzdGF0
aWMgX19pbml0IGludCBtZW1zZXQ2NF9zZWxmdGVzdCh2b2lkKQ0KIGZhaWw6DQogCWtmcmVlKHAp
Ow0KIAlpZiAoaSA8IDI1NikNCi0JCXJldHVybiAoaSA8PCAyNCkgfCAoaiA8PCAxNikgfCBrOw0K
KwkJcmV0dXJuIChpIDw8IDI0KSB8IChqIDw8IDE2KSB8IGsgfCAweDgwMDA7DQogCXJldHVybiAw
Ow0KIH0NCiANCi0tIA0KMi4xMS4wDQoNCg==
