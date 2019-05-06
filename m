Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F45C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508472087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="wdl9Knsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfEFMrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:47:11 -0400
Received: from mail-eopbgr150115.outbound.protection.outlook.com ([40.107.15.115]:38846
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbfEFMrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b04Zr/jr7UvyVRs+aFFUlhDUu2nvr2lVmw7CeTj+Zd4=;
 b=wdl9KnsbVSCzQk3N750siGHH/fCsbP2y0/3Xl6hzEt9Uj99wpvgjDWf35cxMABT6FbF0WSg7XMLar3cM5RekEAs+FsLFgwPlOZ0B/qo0qFpwBkZMcwRG+mqIsOiaZGsAdzVNfpkAngEpjGVLAiFwkVV9uZw2qwaufw4L0RdyQco=
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com (20.178.17.97) by
 AM0PR02MB4452.eurprd02.prod.outlook.com (20.178.17.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 12:47:00 +0000
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f]) by AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 12:47:00 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH RESEND 1/3] lib/string: allow searching for NUL with strnchr
Thread-Topic: [PATCH RESEND 1/3] lib/string: allow searching for NUL with
 strnchr
Thread-Index: AQHVBAnMAYAk+CPZxEWKYT64PCWxmg==
Date:   Mon, 6 May 2019 12:47:00 +0000
Message-ID: <20190506124634.6807-2-peda@axentia.se>
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
x-ms-office365-filtering-correlation-id: 07a0800c-c107-487f-50a9-08d6d220ee68
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR02MB4452;
x-ms-traffictypediagnostic: AM0PR02MB4452:
x-microsoft-antispam-prvs: <AM0PR02MB4452799A3C0EC2637659E229BC300@AM0PR02MB4452.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(39830400003)(376002)(189003)(199004)(52116002)(386003)(6506007)(316002)(256004)(14444005)(102836004)(50226002)(1076003)(76176011)(71190400001)(68736007)(6916009)(71200400001)(3846002)(11346002)(446003)(6116002)(508600001)(54906003)(25786009)(2351001)(36756003)(5640700003)(99286004)(74482002)(26005)(2616005)(186003)(7736002)(2501003)(305945005)(486006)(476003)(66556008)(66066001)(4326008)(53936002)(14454004)(86362001)(6436002)(73956011)(66446008)(66476007)(6486002)(6512007)(2906002)(5660300002)(81166006)(81156014)(8936002)(66946007)(8676002)(64756008)(51383001)(17423001)(156123004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB4452;H:AM0PR02MB4563.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m2uzKXBfV4Dr4s83UY9nXe6tBxmSpe+WJDP1/c6vA91NIwdvuVbs/Q/XidovAP7u2xR5dnwcp5YJdQRVp7b3WzCHQUulD78/vnqzc59sqi8TXg+EPvu6YSqwLAkK1Mtl/ZWtym1/TeGzoq7s6mqSLmfKg3Xkk52PWP29i488xmlEtBloI09LeBY2Q+R1AkSzAmKqGnKUOs9SJNgKpA/zC7m2MByhJXpZm/0BJKwXKp+TwoNuX9k94KmUEwI6ULQ9pKnUgJUYQYBEmvtsZ7IpCAKkfjQ0wty4Nlv7jzmbomWll5mcYDs3VjMqGUUJyA7UtiWGrMsi2qmbT7YnVdA2irRlEKy1Iz63WHErMI7sbHYzlC5Gq8V6yHTRHTLaUgZh9LOmR6+S+3AOik1dw5vmPzajiCgkEguwkpntXii9MBM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a0800c-c107-487f-50a9-08d6d220ee68
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 12:47:00.2892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c3RyY2hyIGNvbnNpZGVycyB0aGUgdGVybWluYXRpbmcgTlVMIHRvIGJlIHBhcnQgb2YgdGhlIHN0
cmluZywgYW5kIE5VTA0KY2FuIHRodXMgYmUgc2VhcmNoZWQgZm9yIHdpdGggdGhhdCBmdW5jdGlv
bi4gRm9yIGNvbnNpc3RlbmN5LCBkbyB0aGUNCnNhbWUgd2l0aCBzdHJuY2hyLg0KDQpTaWduZWQt
b2ZmLWJ5OiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KLS0tDQogbGliL3N0cmluZy5j
IHwgMTEgKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvbGliL3N0cmluZy5jIGIvbGliL3N0cmluZy5jDQpp
bmRleCAzYWI4NjFjMWE4NTcuLjlkNjRkN2FiNDAxYSAxMDA2NDQNCi0tLSBhL2xpYi9zdHJpbmcu
Yw0KKysrIGIvbGliL3N0cmluZy5jDQpAQCAtMzY3LDYgKzM2Nyw5IEBAIEVYUE9SVF9TWU1CT0wo
c3RybmNtcCk7DQogICogc3RyY2hyIC0gRmluZCB0aGUgZmlyc3Qgb2NjdXJyZW5jZSBvZiBhIGNo
YXJhY3RlciBpbiBhIHN0cmluZw0KICAqIEBzOiBUaGUgc3RyaW5nIHRvIGJlIHNlYXJjaGVkDQog
ICogQGM6IFRoZSBjaGFyYWN0ZXIgdG8gc2VhcmNoIGZvcg0KKyAqDQorICogTm90ZSB0aGF0IHRo
ZSAlTlVMLXRlcm1pbmF0b3IgaXMgY29uc2lkZXJlZCBwYXJ0IG9mIHRoZSBzdHJpbmcsIGFuZCBj
YW4NCisgKiBiZSBzZWFyY2hlZCBmb3IuDQogICovDQogY2hhciAqc3RyY2hyKGNvbnN0IGNoYXIg
KnMsIGludCBjKQ0KIHsNCkBAIC00MjAsMTIgKzQyMywxOCBAQCBFWFBPUlRfU1lNQk9MKHN0cnJj
aHIpOw0KICAqIEBzOiBUaGUgc3RyaW5nIHRvIGJlIHNlYXJjaGVkDQogICogQGNvdW50OiBUaGUg
bnVtYmVyIG9mIGNoYXJhY3RlcnMgdG8gYmUgc2VhcmNoZWQNCiAgKiBAYzogVGhlIGNoYXJhY3Rl
ciB0byBzZWFyY2ggZm9yDQorICoNCisgKiBOb3RlIHRoYXQgdGhlICVOVUwtdGVybWluYXRvciBp
cyBjb25zaWRlcmVkIHBhcnQgb2YgdGhlIHN0cmluZywgYW5kIGNhbg0KKyAqIGJlIHNlYXJjaGVk
IGZvci4NCiAgKi8NCiBjaGFyICpzdHJuY2hyKGNvbnN0IGNoYXIgKnMsIHNpemVfdCBjb3VudCwg
aW50IGMpDQogew0KLQlmb3IgKDsgY291bnQtLSAmJiAqcyAhPSAnXDAnOyArK3MpDQorCXdoaWxl
IChjb3VudC0tKSB7DQogCQlpZiAoKnMgPT0gKGNoYXIpYykNCiAJCQlyZXR1cm4gKGNoYXIgKilz
Ow0KKwkJaWYgKCpzKysgPT0gJ1wwJykNCisJCQlicmVhazsNCisJfQ0KIAlyZXR1cm4gTlVMTDsN
CiB9DQogRVhQT1JUX1NZTUJPTChzdHJuY2hyKTsNCi0tIA0KMi4xMS4wDQoNCg==
