Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7507DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FD2216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="PdTgLzjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfEFMmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:42:43 -0400
Received: from mail-eopbgr60097.outbound.protection.outlook.com ([40.107.6.97]:18595
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfEFMmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXEgaN+rQThO3cdLAqlODJwfJJFJmiiuVyyRJplodiw=;
 b=PdTgLzjC6ytOzGA5uokJmG5z/J2j6/afSiXMsqn49AwGx/Dl4MvTSMDdvq4IUvF/0gQDXEuaarwqeS4acyhZbroXBRE9DX0LzvORXzV3nxYMZjeS349EjcOQoEkhvy+OxZkZXatv19Ndtmy4KE1OHOEXsx0QG6tr2hJSQkoYPGY=
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com (20.178.17.97) by
 AM0PR02MB3954.eurprd02.prod.outlook.com (20.177.43.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.14; Mon, 6 May 2019 12:42:39 +0000
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f]) by AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::59ed:e49a:eab8:168f%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 12:42:39 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/3] lib/test_string: add some testcases for strchr and
 strnchr
Thread-Topic: [PATCH 3/3] lib/test_string: add some testcases for strchr and
 strnchr
Thread-Index: AQHVBAkwXiBcGfnQI06sY4yaNeyKHQ==
Date:   Mon, 6 May 2019 12:42:39 +0000
Message-ID: <20190506124205.6565-4-peda@axentia.se>
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
x-ms-office365-filtering-correlation-id: 378cfe97-8117-4d50-a68b-08d6d2205311
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR02MB3954;
x-ms-traffictypediagnostic: AM0PR02MB3954:
x-microsoft-antispam-prvs: <AM0PR02MB395465354F6D7BF58BA06D21BC300@AM0PR02MB3954.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39830400003)(346002)(366004)(136003)(199004)(189003)(68736007)(1076003)(52116002)(99286004)(76176011)(66946007)(71190400001)(66066001)(73956011)(74482002)(102836004)(7736002)(2351001)(256004)(66446008)(66476007)(305945005)(486006)(64756008)(476003)(5660300002)(54906003)(446003)(11346002)(66556008)(2616005)(71200400001)(14454004)(50226002)(8676002)(26005)(186003)(8936002)(3846002)(6116002)(81156014)(81166006)(86362001)(6436002)(5640700003)(2501003)(6506007)(386003)(36756003)(6512007)(316002)(4326008)(6916009)(53936002)(2906002)(508600001)(25786009)(6486002)(40753002)(17423001)(156123004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB3954;H:AM0PR02MB4563.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /Trga1TfDALSPCOBHlXx3d3OtdlWDASqjoG+igz3CKUPzSLuJhvt63svwdgJcf6a/GFrul0TZMKs2l/RW1G+hHc7OoBaQ6LgLXXMb2nlXzUPyd5lmnWptpUzaTkGgTkkKXhSKL39H9qUpUQHTaJ+/XwcPuY/ukGYVbkkw4C6jUf8xqUprccWqdOwyMQBdrhKgj5lhNi7liUKk7Ht55Z426S3q4rvx1iiiPPKov97CFYnwU7HoMovy3W92QDQefFb4ezpAPMlf0njk6lvklSdUiFdHA0LefdpQPXYS1SZxGVWWWF6wgHB8z2mdy5/t4yA/oPLaW2+gbLDl6drcTNe9gmttfDiEgcuDYMCeghgeye13ub5ify4XWt0ZiVHNW2BGcGIaazT/fDOxNCMkr9ZqdP4f2Ni6HUf5v33IQPoFg0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 378cfe97-8117-4d50-a68b-08d6d2205311
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 12:42:39.6204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3954
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
