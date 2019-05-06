Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C489DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943A820830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="kChAUGEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfEFMm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:42:27 -0400
Received: from mail-eopbgr60102.outbound.protection.outlook.com ([40.107.6.102]:63302
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfEFMm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b04Zr/jr7UvyVRs+aFFUlhDUu2nvr2lVmw7CeTj+Zd4=;
 b=kChAUGEe0fRgg76V1EauXOw/HB0sX0VPALb72B/aaIn83WEfsH9Eg2JsnjTfMPERO+xSf/ohsdilv/x69ic7kJFbIUPKPwfurP9NI4VUdsDb95cZYPL3kjb87uF3Tb8Bk/a4FbOtJI2Dj7fhfWsDU+MEE+xcSqSIvRcNLoIvQeM=
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com (20.178.17.97) by
 AM0PR02MB3954.eurprd02.prod.outlook.com (20.177.43.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.14; Mon, 6 May 2019 12:42:23 +0000
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f]) by AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 12:42:23 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] lib/string: allow searching for NUL with strnchr
Thread-Topic: [PATCH 1/3] lib/string: allow searching for NUL with strnchr
Thread-Index: AQHVBAkntyOfzfOSfEytyfp+jtdRyg==
Date:   Mon, 6 May 2019 12:42:23 +0000
Message-ID: <20190506124205.6565-2-peda@axentia.se>
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
x-ms-office365-filtering-correlation-id: 99c020f8-0625-4bc0-feb4-08d6d22049a5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR02MB3954;
x-ms-traffictypediagnostic: AM0PR02MB3954:
x-microsoft-antispam-prvs: <AM0PR02MB3954FB9AB4FD930109E6BB65BC300@AM0PR02MB3954.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39830400003)(346002)(366004)(136003)(199004)(189003)(68736007)(1076003)(52116002)(99286004)(76176011)(66946007)(71190400001)(66066001)(73956011)(74482002)(102836004)(7736002)(2351001)(256004)(66446008)(14444005)(66476007)(305945005)(486006)(64756008)(476003)(5660300002)(54906003)(446003)(11346002)(66556008)(2616005)(71200400001)(14454004)(50226002)(8676002)(26005)(186003)(8936002)(3846002)(6116002)(81156014)(81166006)(86362001)(6436002)(5640700003)(2501003)(6506007)(386003)(36756003)(6512007)(316002)(4326008)(6916009)(53936002)(2906002)(508600001)(25786009)(6486002)(51383001)(17423001)(156123004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB3954;H:AM0PR02MB4563.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IgbUB4i6uhLb8JxJOgaQfDIhBZgrQcmZqcApXL59BiWRS52pXvC/FUqcMW18VyT6k523lkaj6oanIcnRT6n1JT5FK8EtqBQ/JHZF7kfKTOT+4l3NH7LyL8e6hYieq53A3TFif7E8ii7+uVp1VobYAmFmxs5HFlg/ErZq6ZWM+bEN3MAG+pwT5IMWm8OCifYXtFblPzkb0RyifHZt/Z2H6DjB5N1odVeew1j8Oe1K91V5ZAygWcGxiT9BQy5+NFEdwrnCiqyrA+u3/gDTIIbWCDs2IuwiBZngZpH+HutbXG9m1BLpXoZi36oym4NQz1+mG2aoMO3cQz86VsRCZ7145y17C4nwX8YPFoXbx91Bv2S/DhYsUy2fKCYmpWHx5m9qwPSdh2ZOWC2/I53YJLhl8DA2isePHox3lNgmQjyvRog=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c020f8-0625-4bc0-feb4-08d6d22049a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 12:42:23.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3954
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
