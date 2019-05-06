Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D82C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A1020830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="welJ+U9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfEFMme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:42:34 -0400
Received: from mail-eopbgr60120.outbound.protection.outlook.com ([40.107.6.120]:59522
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfEFMme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI/VPtBfd/cmkKe650BHbEU7Qfmf462oNtZOSBPNx1s=;
 b=welJ+U9digknqDYx2WKs8m17KLFp484hKWkkNZrm3lL6ElneqfNCS78IsySrVegnlqanI7dxQZmwlLNRgIWFMyzMy0eOHSwjRAwliXauGSg6mttTg/gfzjEm8lqenCph6p5fZFgXR2FDEx5V6A5QMaSxFj0obu3paLnKtuV0ry8=
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com (20.178.17.97) by
 AM0PR02MB3954.eurprd02.prod.outlook.com (20.177.43.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.14; Mon, 6 May 2019 12:42:31 +0000
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f]) by AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 12:42:31 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] lib/test_string: avoid masking memset16/32/64 failures
Thread-Topic: [PATCH 2/3] lib/test_string: avoid masking memset16/32/64
 failures
Thread-Index: AQHVBAkrbOwa5QaEG0iAtrjFlVy9cQ==
Date:   Mon, 6 May 2019 12:42:31 +0000
Message-ID: <20190506124205.6565-3-peda@axentia.se>
References: <20190506124205.6565-1-peda@axentia.se>
In-Reply-To: <20190506124205.6565-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0402CA0008.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::18) To AM0PR02MB4563.eurprd02.prod.outlook.com
 (2603:10a6:208:ec::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c6b5828-1cf7-4273-9315-08d6d2204e06
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR02MB3954;
x-ms-traffictypediagnostic: AM0PR02MB3954:
x-microsoft-antispam-prvs: <AM0PR02MB39542A5C5F574F9675070116BC300@AM0PR02MB3954.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(376002)(39830400003)(346002)(366004)(136003)(199004)(189003)(68736007)(1076003)(52116002)(99286004)(76176011)(66946007)(71190400001)(66066001)(73956011)(74482002)(102836004)(7736002)(2351001)(256004)(66446008)(14444005)(66476007)(305945005)(486006)(64756008)(476003)(5660300002)(54906003)(446003)(11346002)(66556008)(2616005)(71200400001)(14454004)(50226002)(8676002)(26005)(186003)(8936002)(3846002)(6116002)(81156014)(81166006)(86362001)(6436002)(5640700003)(2501003)(6506007)(386003)(36756003)(6512007)(316002)(4326008)(6916009)(53936002)(2906002)(508600001)(25786009)(6486002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB3954;H:AM0PR02MB4563.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nw6OMrkMd9sBXTi0HzVl1qPtMsWQuEUCnY/ZgeW3ec62TmIpwgUpRAj73TCLcYV78A14b9EMe9OljJddNUJPe+pW+sKykREn2bNA8AVJxmNlXCMtY1vYQU4X9xkFW6AjBVDE04lArswbgvKKLiKcNn3mXAzp+spT9YaAzj4Pts4cBX6KaGf+37gB4gTSeSEuTKB3wckd94YxNA1HTOcWLDpLVGS9RpXD68Bd9pDM5AomWu5laNyOInjVqi/PeTo9OYYVHyBfziHr8gfEquxff73ZZWPVkyGgbFZlgqeQT9vO+e9Hnei324fSXtZDk/I4nUbJVQJ5+5MOtAjHLUNzHgVRONQFufBNNvZKa20vRenqg7vYp6aIxIdZ+w3MPQhQ0T4DnTjMndJy1Y1rdQzGEhWHSRaBc4RX4LOejqTblPU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6b5828-1cf7-4273-9315-08d6d2204e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 12:42:31.2212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3954
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
