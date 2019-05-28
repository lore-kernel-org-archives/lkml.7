Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240E4C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0292075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Rr7cRtyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfE1IBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:01:10 -0400
Received: from mail-eopbgr50095.outbound.protection.outlook.com ([40.107.5.95]:43671
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbfE1IBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJPgPdHHnlForisO3pAkOACZSKSAG4puJlmGkzfQmcU=;
 b=Rr7cRtyFWo8AexGHuZGSvchjaKcFG3uTEgD83Lo5MbF7Uk44FmYeKzly2dVQ9GvLQAM0I59/kydku1W9C1iQzeVFGkzREjiL8o0wNp93PAbKTeQJs4pzoOGGZk1GjI9wX+apxxVz8NjzIeN+xEeBVVJHFvNPOx1ogZ8FBOR9mus=
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com (10.175.243.15) by
 VI1PR07MB6144.eurprd07.prod.outlook.com (20.178.124.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.10; Tue, 28 May 2019 08:01:04 +0000
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::1403:5377:c11d:a41a]) by VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::1403:5377:c11d:a41a%7]) with mapi id 15.20.1943.016; Tue, 28 May 2019
 08:01:04 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Vas Dias <jason.vas.dias@gmail.com>
Subject: [PATCH] x86/vdso: implement clock_gettime(CLOCK_MONOTONIC_RAW, ...)
Thread-Topic: [PATCH] x86/vdso: implement clock_gettime(CLOCK_MONOTONIC_RAW,
 ...)
Thread-Index: AQHVFSt/mcyouz98qE++y6I2rpiWQg==
Date:   Tue, 28 May 2019 08:01:04 +0000
Message-ID: <20190528080034.31259-1-alexander.sverdlin@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.181]
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HE1P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::24)
 To VI1PR07MB3165.eurprd07.prod.outlook.com (2603:10a6:802:21::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c918ba8c-7058-4950-86fb-08d6e342a203
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR07MB6144;
x-ms-traffictypediagnostic: VI1PR07MB6144:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR07MB6144A3AA8AD442F0167E6A75881E0@VI1PR07MB6144.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(99286004)(8936002)(508600001)(14454004)(386003)(52116002)(81156014)(8676002)(81166006)(66066001)(26005)(71200400001)(71190400001)(53936002)(186003)(6506007)(6436002)(6486002)(102836004)(14444005)(256004)(6306002)(6512007)(66946007)(25786009)(2501003)(66446008)(66476007)(68736007)(2906002)(50226002)(54906003)(110136005)(486006)(476003)(2616005)(36756003)(966005)(86362001)(4326008)(6116002)(3846002)(1076003)(316002)(305945005)(7736002)(66556008)(64756008)(73956011)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB6144;H:VI1PR07MB3165.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sI+Qf3Od+tGroWMBV3uVwRBbj/HW2NZdV7ROk3yg0zfwWmggaGDx62xVwutNPLjikYVS+aZpgpMmDih3S5ppo8VH4ganeZD2+lYaYOVq72GC3y3xDStgs83mwaHjvfzkuVcU8P71dGNqSYT5aLwKyd4Sgp7Fuxcc4XiS6fjoRHrY8nWNbLLJx5lUChQ4OrOuOSigFPB75XJEyzk9QazI8vjlaqvU9vnWyh+IfmujOWU/GdiBaiDFg4rx7z9gmjUQjDFVDpxYP2swal7NCS6Gush3V3BO4s39lezlgnjLa3idb2vlZCsFPTA2O/6r/UXrEOU2rLD9eITGWImjm4ZG4Kp6LcGFSaiTS3lxn9R3zXueBGuOcMGh4pyeCmECrAD0eXf0m4a+q/6raQFdW5KxI6qNDUNSWKnJm0XTOYAIDAE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c918ba8c-7058-4950-86fb-08d6e342a203
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 08:01:04.8038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alexander.sverdlin@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Abm9raWEuY29tPg0K
DQpBZGQgQ0xPQ0tfTU9OT1RPTklDX1JBVyB0byB0aGUgZXhpc3RpbmcgY2xvY2tfZ2V0dGltZSgp
IHZEU08NCmltcGxlbWVudGF0aW9uLiBUaGlzIGlzIGJhc2VkIG9uIHRoZSBpZGVhcyBvZiBKYXNv
biBWYXMgRGlhcyBhbmQgY29tbWVudHMNCm9mIFRob21hcyBHbGVpeG5lci4NCg0KLS0tLSBUZXN0
IGNvZGUgLS0tLQ0KICNpbmNsdWRlIDxlcnJuby5oPg0KICNpbmNsdWRlIDxzdGRpby5oPg0KICNp
bmNsdWRlIDxzdGRsaWIuaD4NCiAjaW5jbHVkZSA8dGltZS5oPg0KICNpbmNsdWRlIDx1bmlzdGQu
aD4NCg0KICNkZWZpbmUgQ0xPQ0tfVFlQRSBDTE9DS19NT05PVE9OSUNfUkFXDQogI2RlZmluZSBE
VVJBVElPTl9TRUMgMTANCg0KaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0Kew0KCXN0
cnVjdCB0aW1lc3BlYyB0LCBlbmQ7DQoJdW5zaWduZWQgbG9uZyBsb25nIGNudCA9IDA7DQoNCglj
bG9ja19nZXR0aW1lKENMT0NLX1RZUEUsICZlbmQpOw0KCWVuZC50dl9zZWMgKz0gRFVSQVRJT05f
U0VDOw0KDQoJZG8gew0KCQljbG9ja19nZXR0aW1lKENMT0NLX1RZUEUsICZ0KTsNCgkJKytjbnQ7
DQoJfSB3aGlsZSAodC50dl9zZWMgPCBlbmQudHZfc2VjIHx8IHQudHZfbnNlYyA8IGVuZC50dl9u
c2VjKTsNCg0KCWRwcmludGYoU1RET1VUX0ZJTEVOTywgIiVsbHUiLCBjbnQpOw0KDQoJcmV0dXJu
IEVYSVRfU1VDQ0VTUzsNCn0NCi0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KVGhlIHJlc3VsdHMgZnJv
bSB0aGUgYWJvdmUgdGVzdCBwcm9ncmFtOg0KDQpDbG9jawkJCUJlZm9yZQkJQWZ0ZXIJCURpZmYN
Ci0tLS0tCQkJLS0tLS0tCQktLS0tLQkJLS0tLQ0KQ0xPQ0tfTU9OT1RPTklDCQkzNTU1MzE3MjAJ
MzM4MDM5MzczCS01JQ0KQ0xPQ0tfTU9OT1RPTklDX1JBVwk0NDgzMTczOAkzMzYwNjQ5MTIJKzY1
MCUNCkNMT0NLX1JFQUxUSU1FCQkzNDc2NjUxMzMJMzM4MTAyOTA3CS0zJQ0KDQpMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvOTMzNTgzLw0KTGluazogaHR0cHM6
Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0xOTg5NjENCkNjOiBUaG9tYXMg
R2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCkNjOiBKYXNvbiBWYXMgRGlhcyA8amFzb24u
dmFzLmRpYXNAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxh
bGV4YW5kZXIuc3ZlcmRsaW5Abm9raWEuY29tPg0KLS0tDQogYXJjaC94ODYvZW50cnkvdmRzby92
Y2xvY2tfZ2V0dGltZS5jICAgIHwgMTEgKysrKysrKysrLS0NCiBhcmNoL3g4Ni9lbnRyeS92c3lz
Y2FsbC92c3lzY2FsbF9ndG9kLmMgfCAgNiArKysrKysNCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS92
Z3RvZC5oICAgICAgICAgICAgfCAgNSArKysrLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3Zk
c28vdmNsb2NrX2dldHRpbWUuYyBiL2FyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUu
Yw0KaW5kZXggOThjN2QxMi4uN2M5ZGIyNiAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2VudHJ5L3Zk
c28vdmNsb2NrX2dldHRpbWUuYw0KKysrIGIvYXJjaC94ODYvZW50cnkvdmRzby92Y2xvY2tfZ2V0
dGltZS5jDQpAQCAtMTQ0LDYgKzE0NCwxMyBAQCBub3RyYWNlIHN0YXRpYyBpbnQgZG9faHJlcyhj
bG9ja2lkX3QgY2xrLCBzdHJ1Y3QgdGltZXNwZWMgKnRzKQ0KIAlzdHJ1Y3Qgdmd0b2RfdHMgKmJh
c2UgPSAmZ3RvZC0+YmFzZXRpbWVbY2xrXTsNCiAJdTY0IGN5Y2xlcywgbGFzdCwgc2VjLCBuczsN
CiAJdW5zaWduZWQgaW50IHNlcTsNCisJdTMyIG11bHQgPSBndG9kLT5tdWx0Ow0KKwl1MzIgc2hp
ZnQgPSBndG9kLT5zaGlmdDsNCisNCisJaWYgKGNsayA9PSBDTE9DS19NT05PVE9OSUNfUkFXKSB7
DQorCQltdWx0ID0gZ3RvZC0+cmF3X211bHQ7DQorCQlzaGlmdCA9IGd0b2QtPnJhd19zaGlmdDsN
CisJfQ0KIA0KIAlkbyB7DQogCQlzZXEgPSBndG9kX3JlYWRfYmVnaW4oZ3RvZCk7DQpAQCAtMTUz
LDggKzE2MCw4IEBAIG5vdHJhY2Ugc3RhdGljIGludCBkb19ocmVzKGNsb2NraWRfdCBjbGssIHN0
cnVjdCB0aW1lc3BlYyAqdHMpDQogCQlpZiAodW5saWtlbHkoKHM2NCljeWNsZXMgPCAwKSkNCiAJ
CQlyZXR1cm4gdmRzb19mYWxsYmFja19nZXR0aW1lKGNsaywgdHMpOw0KIAkJaWYgKGN5Y2xlcyA+
IGxhc3QpDQotCQkJbnMgKz0gKGN5Y2xlcyAtIGxhc3QpICogZ3RvZC0+bXVsdDsNCi0JCW5zID4+
PSBndG9kLT5zaGlmdDsNCisJCQlucyArPSAoY3ljbGVzIC0gbGFzdCkgKiBtdWx0Ow0KKwkJbnMg
Pj49IHNoaWZ0Ow0KIAkJc2VjID0gYmFzZS0+c2VjOw0KIAl9IHdoaWxlICh1bmxpa2VseShndG9k
X3JlYWRfcmV0cnkoZ3RvZCwgc2VxKSkpOw0KIA0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5
L3ZzeXNjYWxsL3ZzeXNjYWxsX2d0b2QuYyBiL2FyY2gveDg2L2VudHJ5L3ZzeXNjYWxsL3ZzeXNj
YWxsX2d0b2QuYw0KaW5kZXggY2ZjZGJhMC4uYTk2N2YwMiAxMDA2NDQNCi0tLSBhL2FyY2gveDg2
L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsX2d0b2QuYw0KKysrIGIvYXJjaC94ODYvZW50cnkvdnN5
c2NhbGwvdnN5c2NhbGxfZ3RvZC5jDQpAQCAtNDYsMTEgKzQ2LDE3IEBAIHZvaWQgdXBkYXRlX3Zz
eXNjYWxsKHN0cnVjdCB0aW1la2VlcGVyICp0aykNCiAJdmRhdGEtPm1hc2sJCT0gdGstPnRrcl9t
b25vLm1hc2s7DQogCXZkYXRhLT5tdWx0CQk9IHRrLT50a3JfbW9uby5tdWx0Ow0KIAl2ZGF0YS0+
c2hpZnQJCT0gdGstPnRrcl9tb25vLnNoaWZ0Ow0KKwl2ZGF0YS0+cmF3X211bHQJCT0gdGstPnRr
cl9yYXcubXVsdDsNCisJdmRhdGEtPnJhd19zaGlmdAk9IHRrLT50a3JfcmF3LnNoaWZ0Ow0KIA0K
IAliYXNlID0gJnZkYXRhLT5iYXNldGltZVtDTE9DS19SRUFMVElNRV07DQogCWJhc2UtPnNlYyA9
IHRrLT54dGltZV9zZWM7DQogCWJhc2UtPm5zZWMgPSB0ay0+dGtyX21vbm8ueHRpbWVfbnNlYzsN
CiANCisJYmFzZSA9ICZ2ZGF0YS0+YmFzZXRpbWVbQ0xPQ0tfTU9OT1RPTklDX1JBV107DQorCWJh
c2UtPnNlYyA9IHRrLT5yYXdfc2VjOw0KKwliYXNlLT5uc2VjID0gdGstPnRrcl9yYXcueHRpbWVf
bnNlYzsNCisNCiAJYmFzZSA9ICZ2ZGF0YS0+YmFzZXRpbWVbQ0xPQ0tfVEFJXTsNCiAJYmFzZS0+
c2VjID0gdGstPnh0aW1lX3NlYyArIChzNjQpdGstPnRhaV9vZmZzZXQ7DQogCWJhc2UtPm5zZWMg
PSB0ay0+dGtyX21vbm8ueHRpbWVfbnNlYzsNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS92Z3RvZC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdmd0b2QuaA0KaW5kZXggOTEzYTEz
My4uZjY1YzQyYiAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZndG9kLmgNCisr
KyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZndG9kLmgNCkBAIC0yOCw3ICsyOCw4IEBAIHN0cnVj
dCB2Z3RvZF90cyB7DQogfTsNCiANCiAjZGVmaW5lIFZHVE9EX0JBU0VTCShDTE9DS19UQUkgKyAx
KQ0KLSNkZWZpbmUgVkdUT0RfSFJFUwkoQklUKENMT0NLX1JFQUxUSU1FKSB8IEJJVChDTE9DS19N
T05PVE9OSUMpIHwgQklUKENMT0NLX1RBSSkpDQorI2RlZmluZSBWR1RPRF9IUkVTCShCSVQoQ0xP
Q0tfUkVBTFRJTUUpIHwgQklUKENMT0NLX01PTk9UT05JQykgfCBcDQorCQkJIEJJVChDTE9DS19N
T05PVE9OSUNfUkFXKSB8IEJJVChDTE9DS19UQUkpKQ0KICNkZWZpbmUgVkdUT0RfQ09BUlNFCShC
SVQoQ0xPQ0tfUkVBTFRJTUVfQ09BUlNFKSB8IEJJVChDTE9DS19NT05PVE9OSUNfQ09BUlNFKSkN
CiANCiAvKg0KQEAgLTQzLDYgKzQ0LDggQEAgc3RydWN0IHZzeXNjYWxsX2d0b2RfZGF0YSB7DQog
CXU2NAkJbWFzazsNCiAJdTMyCQltdWx0Ow0KIAl1MzIJCXNoaWZ0Ow0KKwl1MzIJCXJhd19tdWx0
Ow0KKwl1MzIJCXJhd19zaGlmdDsNCiANCiAJc3RydWN0IHZndG9kX3RzCWJhc2V0aW1lW1ZHVE9E
X0JBU0VTXTsNCiANCi0tIA0KMi40LjYNCg0K
