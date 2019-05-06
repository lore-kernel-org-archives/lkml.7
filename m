Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C001C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF23220830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="c4w0kpu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfEFMqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:46:45 -0400
Received: from mail-eopbgr00101.outbound.protection.outlook.com ([40.107.0.101]:24445
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726094AbfEFMqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7VESdjmYVknS2+W0mLM0hgcakmO3WQxnvaLE6z/x18=;
 b=c4w0kpu3/stiPfDt5n+TArnELe4yaVajzt35EuuP8+a889GfyoLwE+Bp4R/6/fFzyL0vzXZ4+88D81W8iB/C8EzOMVwWJ9zDJfZR6bex+gSe46zmcjHC5UEBC7Ih9aLVXnrlLapfwgyKfo6EQ/nfZ9U3WwGpWBb6YHXt1fikrxw=
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com (20.178.17.97) by
 AM0PR02MB3667.eurprd02.prod.outlook.com (52.133.63.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Mon, 6 May 2019 12:46:42 +0000
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f]) by AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 12:46:42 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH RESEND 0/3] lib/string: search for NUL with strchr/strnchr
Thread-Topic: [PATCH RESEND 0/3] lib/string: search for NUL with
 strchr/strnchr
Thread-Index: AQHVBAnBV5sIuqHPzUWB1vgymfY6HA==
Date:   Mon, 6 May 2019 12:46:42 +0000
Message-ID: <20190506124634.6807-1-peda@axentia.se>
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
x-ms-office365-filtering-correlation-id: 10a2653c-bbdd-4ad5-3e51-08d6d220e3f2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR02MB3667;
x-ms-traffictypediagnostic: AM0PR02MB3667:
x-microsoft-antispam-prvs: <AM0PR02MB36678F9CCD5CFF0162888572BC300@AM0PR02MB3667.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(346002)(39830400003)(396003)(189003)(199004)(26005)(4326008)(305945005)(508600001)(6506007)(6916009)(186003)(6116002)(5640700003)(256004)(14444005)(3846002)(52116002)(1076003)(2616005)(7736002)(54906003)(68736007)(8676002)(50226002)(99286004)(71200400001)(81156014)(81166006)(5660300002)(66066001)(102836004)(4744005)(14454004)(386003)(66446008)(64756008)(73956011)(25786009)(66946007)(66476007)(66556008)(6512007)(486006)(476003)(6436002)(6486002)(36756003)(2906002)(53936002)(8936002)(2351001)(316002)(2501003)(86362001)(71190400001)(74482002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB3667;H:AM0PR02MB4563.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UnST1fVUpLRYrQjTbJmsS8Nhr4Sil2ysGZ5VmRZqsREZhQk4GTXnysV8zA3s0plkLMHudEAil0m1gKmQU9ESSuzeJdM4h6GgzRSzR1acZDtH9GN45/6chW0FCl1wuxtKfe1mGLSeNEfo8OEwu63DCzvxBfUNlVR6yJzMog5OBMywkf5EbACABWHFvcZV7MUTwCpk6kgGvaoqV3dql/0Xy0df1nriSoX+moOg2fNqd7dkPn0Q6QUJO+nvgZO/7027sIJuIPtA5VbP6Q+UML27rnBWHFEVlN1TRbHICL/PbG67YTFBEH4ufuHb6NqqhVMhNCLVnKXNGpdB7VoV3JKujDn0EfKOYJboAU9OX9nXkLD/whfvLFwKJimBKwYudhvR8pAqeOxGpl4q0lzeZRCUbIHaPvQSBoNGNt4GKWHrJN4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a2653c-bbdd-4ad5-3e51-08d6d220e3f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 12:46:42.7222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3667
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1dpdGggYmV0dGVyIGFkZHJlc3MgZm9yIE1hdHRoZXc/XQ0KDQpIaSENCg0KSSBub3RpY2VkIGFu
IGluY29uc2lzdGVuY3kgd2hlcmUgc3RyY2hyIGFuZCBzdHJuY2hyIGRvIG5vdCBiZWhhdmUgdGhl
DQpzYW1lIHdpdGggcmVzcGVjdCB0byB0aGUgdHJhaWxpbmcgTlVMLiBzdHJjaHIgaXMgc3RhbmRh
cmRpc2VkIGFuZCB0aGUNCmtlcm5lbCBmdW5jdGlvbiBjb25mb3JtcywgYW5kIHRoZSBrZXJuZWwg
cmVsaWVzIG9uIHRoZSBiZWhhdmlvci4NClNvLCBuYXR1cmFsbHkgc3RyY2hyIHN0YXlzIGFzLWlz
IGFuZCBzdHJuY2hyIGlzIHdoYXQgSSBjaGFuZ2UuDQoNCldoaWxlIHdyaXRpbmcgYSBmZXcgdGVz
dHMgdG8gdmVyaWZ5IHRoYXQgbXkgbmV3IHN0cm5jaHIgbG9vcCB3YXMgc2FuZSwgSQ0Kbm90aWNl
ZCB0aGF0IHRoZSB0ZXN0cyBmb3IgbWVtc2V0MTYvMzIvNjQgaGFkIGEgcHJvYmxlbS4gU2luY2Ug
aXQncyBhbGwNCmFib3V0IHRoZSBsaWIvc3RyaW5nLmMgZmlsZSBJIG1hZGUgYSBzaG9ydCBzZXJp
ZXMgb2YgaXQgYWxsLi4uDQoNCkJ1dCB3aGVyZSB0byBzZW5kIGl0PyBnZXRfbWFpbnRhaW5lciBz
dWdnZXN0cyBubyB2aWN0aW0sIHNvIEknbSBhaW1pbmcNCmF0IHRob3NlIHRoYXQgc2lnbmVkLW9m
ZiBvbiB0aGUgbWVtc2V0MTYvMzIvNjQgYnVnLi4uDQoNCkNoZWVycywNClBldGVyDQoNClBldGVy
IFJvc2luICgzKToNCiAgbGliL3N0cmluZzogYWxsb3cgc2VhcmNoaW5nIGZvciBOVUwgd2l0aCBz
dHJuY2hyDQogIGxpYi90ZXN0X3N0cmluZzogYXZvaWQgbWFza2luZyBtZW1zZXQxNi8zMi82NCBm
YWlsdXJlcw0KICBsaWIvdGVzdF9zdHJpbmc6IGFkZCBzb21lIHRlc3RjYXNlcyBmb3Igc3RyY2hy
IGFuZCBzdHJuY2hyDQoNCiBsaWIvc3RyaW5nLmMgICAgICB8IDExICsrKysrKystDQogbGliL3Rl
c3Rfc3RyaW5nLmMgfCA4MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tDQogMiBmaWxlcyBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KDQotLSANCjIuMTEuMA0KDQo=
