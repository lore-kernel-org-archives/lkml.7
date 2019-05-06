Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C5DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E0620830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Z3pOcOdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfEFMrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:47:22 -0400
Received: from mail-eopbgr150122.outbound.protection.outlook.com ([40.107.15.122]:58966
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbfEFMrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXEgaN+rQThO3cdLAqlODJwfJJFJmiiuVyyRJplodiw=;
 b=Z3pOcOdQABOYZjVA1sZochlqcC/B10KGcSVXM5oaINTSj8sWr7MDst2KacPGLfKTQBVcWb1ve4/hIR1w9ZHbxOA3cO3NzxZd+N0fsVYWZ+r9wZDzMuGJgmEowxU/kvsUszWR/LCiJeMDGeRv9pEV9WdfHma1PdFEutbNIfSaYmQ=
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com (20.178.17.97) by
 AM0PR02MB4452.eurprd02.prod.outlook.com (20.178.17.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 12:47:13 +0000
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f]) by AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 12:47:13 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH RESEND 3/3] lib/test_string: add some testcases for strchr and
 strnchr
Thread-Topic: [PATCH RESEND 3/3] lib/test_string: add some testcases for
 strchr and strnchr
Thread-Index: AQHVBAnUp9R6eKVsVUyf1pYReLNgRA==
Date:   Mon, 6 May 2019 12:47:13 +0000
Message-ID: <20190506124634.6807-4-peda@axentia.se>
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
x-ms-office365-filtering-correlation-id: 6d62a0e5-6b69-4b44-c46c-08d6d220f650
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR02MB4452;
x-ms-traffictypediagnostic: AM0PR02MB4452:
x-microsoft-antispam-prvs: <AM0PR02MB44526DCD63B45C733CF648C6BC300@AM0PR02MB4452.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(39830400003)(376002)(189003)(199004)(52116002)(386003)(6506007)(316002)(256004)(102836004)(50226002)(1076003)(76176011)(71190400001)(68736007)(6916009)(71200400001)(3846002)(11346002)(446003)(6116002)(508600001)(54906003)(25786009)(2351001)(36756003)(5640700003)(99286004)(74482002)(26005)(2616005)(186003)(7736002)(2501003)(305945005)(486006)(476003)(66556008)(66066001)(4326008)(53936002)(14454004)(86362001)(6436002)(73956011)(66446008)(66476007)(6486002)(6512007)(2906002)(5660300002)(81166006)(81156014)(8936002)(66946007)(8676002)(64756008)(40753002)(17423001)(156123004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB4452;H:AM0PR02MB4563.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JDhmQMhl5fBOomJURcqRy9YVZoafbyqa53Hkh7uESqmljjVwGY5/RjCcMmkKc/PRv42KIVD1j/yggMrRf5qcHnvIk3Z9m7PSkfaR7CDDCGVVQZ2SgcSOPfGoD0Q32qbIhNV4uQDaP6A+q6sobtTxIclWS9F5tjOeKDgSxPKaybQ/ZWLhnjnrjGljZ3Dvo5imIOOOjRpjV/Y0bwA37k+EVCaZiatrbcK0iNKQqhkpZhlMzBoVQFWKJtOUOrFY/HVKH/LbJd8L0k5Csy1z918fVXoFAMGe8CDFK39R6igMmHep3V8MmPJz5k3vHYHroGBJF9D+/SOeL3nUjoHsnqMuGh1M27oafBrNuJVJgSCfK7e8XFHGTjqxsFn7Fn+PxerVDYBT9r+q1WbQgOqqzATJmjJu5K/UFUxSEUAAofaZWrI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d62a0e5-6b69-4b44-c46c-08d6d220f650
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 12:47:13.6126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFrZSBzdXJlIHRoYXQgdGhlIHRyYWlsaW5nIE5VTCBpcyBjb25zaWRlcmVkIHBhcnQgb2YgdGhl
IHN0cmluZyBhbmQgY2FuDQpiZSBmb3VuZC4NCg0KU2lnbmVkLW9mZi1ieTogUGV0ZXIgUm9zaW4g
PHBlZGFAYXhlbnRpYS5zZT4NCi0tLQ0KIGxpYi90ZXN0X3N0cmluZy5jIHwgNzcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBj
aGFuZ2VkLCA3NyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9saWIvdGVzdF9zdHJpbmcu
YyBiL2xpYi90ZXN0X3N0cmluZy5jDQppbmRleCA5OGE3ODdlN2ExZmQuLjYxM2ZkNWNjOTg3MiAx
MDA2NDQNCi0tLSBhL2xpYi90ZXN0X3N0cmluZy5jDQorKysgYi9saWIvdGVzdF9zdHJpbmcuYw0K
QEAgLTExMSw2ICsxMTEsNzMgQEAgc3RhdGljIF9faW5pdCBpbnQgbWVtc2V0NjRfc2VsZnRlc3Qo
dm9pZCkNCiAJcmV0dXJuIDA7DQogfQ0KIA0KK3N0YXRpYyBfX2luaXQgaW50IHN0cmNocl9zZWxm
dGVzdCh2b2lkKQ0KK3sNCisJY29uc3QgY2hhciAqdGVzdF9zdHJpbmcgPSAiYWJjZGVmZ2hpamts
IjsNCisJY29uc3QgY2hhciAqZW1wdHlfc3RyaW5nID0gIiI7DQorCWNoYXIgKnJlc3VsdDsNCisJ
aW50IGk7DQorDQorCWZvciAoaSA9IDA7IGkgPCBzdHJsZW4odGVzdF9zdHJpbmcpICsgMTsgaSsr
KSB7DQorCQlyZXN1bHQgPSBzdHJjaHIodGVzdF9zdHJpbmcsIHRlc3Rfc3RyaW5nW2ldKTsNCisJ
CWlmIChyZXN1bHQgLSB0ZXN0X3N0cmluZyAhPSBpKQ0KKwkJCXJldHVybiBpICsgJ2EnOw0KKwl9
DQorDQorCXJlc3VsdCA9IHN0cmNocihlbXB0eV9zdHJpbmcsICdcMCcpOw0KKwlpZiAocmVzdWx0
ICE9IGVtcHR5X3N0cmluZykNCisJCXJldHVybiAweDEwMTsNCisNCisJcmVzdWx0ID0gc3RyY2hy
KGVtcHR5X3N0cmluZywgJ2EnKTsNCisJaWYgKHJlc3VsdCkNCisJCXJldHVybiAweDEwMjsNCisN
CisJcmVzdWx0ID0gc3RyY2hyKHRlc3Rfc3RyaW5nLCAneicpOw0KKwlpZiAocmVzdWx0KQ0KKwkJ
cmV0dXJuIDB4MTAzOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGljIF9faW5pdCBpbnQg
c3RybmNocl9zZWxmdGVzdCh2b2lkKQ0KK3sNCisJY29uc3QgY2hhciAqdGVzdF9zdHJpbmcgPSAi
YWJjZGVmZ2hpamtsIjsNCisJY29uc3QgY2hhciAqZW1wdHlfc3RyaW5nID0gIiI7DQorCWNoYXIg
KnJlc3VsdDsNCisJaW50IGksIGo7DQorDQorCWZvciAoaSA9IDA7IGkgPCBzdHJsZW4odGVzdF9z
dHJpbmcpICsgMTsgaSsrKSB7DQorCQlmb3IgKGogPSAwOyBqIDwgc3RybGVuKHRlc3Rfc3RyaW5n
KSArIDI7IGorKykgew0KKwkJCXJlc3VsdCA9IHN0cm5jaHIodGVzdF9zdHJpbmcsIGosIHRlc3Rf
c3RyaW5nW2ldKTsNCisJCQlpZiAoaiA8PSBpKSB7DQorCQkJCWlmICghcmVzdWx0KQ0KKwkJCQkJ
Y29udGludWU7DQorCQkJCXJldHVybiAoKGkgKyAnYScpIDw8IDgpIHwgajsNCisJCQl9DQorCQkJ
aWYgKHJlc3VsdCAtIHRlc3Rfc3RyaW5nICE9IGkpDQorCQkJCXJldHVybiAoKGkgKyAnYScpIDw8
IDgpIHwgajsNCisJCX0NCisJfQ0KKw0KKwlyZXN1bHQgPSBzdHJuY2hyKGVtcHR5X3N0cmluZywg
MCwgJ1wwJyk7DQorCWlmIChyZXN1bHQpDQorCQlyZXR1cm4gMHgxMDAwMTsNCisNCisJcmVzdWx0
ID0gc3RybmNocihlbXB0eV9zdHJpbmcsIDEsICdcMCcpOw0KKwlpZiAocmVzdWx0ICE9IGVtcHR5
X3N0cmluZykNCisJCXJldHVybiAweDEwMDAyOw0KKw0KKwlyZXN1bHQgPSBzdHJuY2hyKGVtcHR5
X3N0cmluZywgMSwgJ2EnKTsNCisJaWYgKHJlc3VsdCkNCisJCXJldHVybiAweDEwMDAzOw0KKw0K
KwlyZXN1bHQgPSBzdHJuY2hyKE5VTEwsIDAsICdcMCcpOw0KKwlpZiAocmVzdWx0KQ0KKwkJcmV0
dXJuIDB4MTAwMDQ7DQorDQorCXJldHVybiAwOw0KK30NCisNCiBzdGF0aWMgX19pbml0IGludCBz
dHJpbmdfc2VsZnRlc3RfaW5pdCh2b2lkKQ0KIHsNCiAJaW50IHRlc3QsIHN1YnRlc3Q7DQpAQCAt
MTMwLDYgKzE5NywxNiBAQCBzdGF0aWMgX19pbml0IGludCBzdHJpbmdfc2VsZnRlc3RfaW5pdCh2
b2lkKQ0KIAlpZiAoc3VidGVzdCkNCiAJCWdvdG8gZmFpbDsNCiANCisJdGVzdCA9IDQ7DQorCXN1
YnRlc3QgPSBzdHJjaHJfc2VsZnRlc3QoKTsNCisJaWYgKHN1YnRlc3QpDQorCQlnb3RvIGZhaWw7
DQorDQorCXRlc3QgPSA1Ow0KKwlzdWJ0ZXN0ID0gc3RybmNocl9zZWxmdGVzdCgpOw0KKwlpZiAo
c3VidGVzdCkNCisJCWdvdG8gZmFpbDsNCisNCiAJcHJfaW5mbygiU3RyaW5nIHNlbGZ0ZXN0cyBz
dWNjZWVkZWRcbiIpOw0KIAlyZXR1cm4gMDsNCiBmYWlsOg0KLS0gDQoyLjExLjANCg0K
