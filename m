Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE6DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E50325333
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="RgAYBolw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfE3IqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:46:10 -0400
Received: from mail-eopbgr70131.outbound.protection.outlook.com ([40.107.7.131]:14004
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726635AbfE3IqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector1-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOzh2dHEbv8f0ZlLF0anTZOQeWGh7GWmafozYLJMR74=;
 b=RgAYBolwr/NGJm8aQ4tfHZXEAAyZ8bWnXCjX4T5tQ3EvtVlCv5IghDDrvbZ/tTHWebySjQpOwTTz6fal6mLgtF/hUvNEEKdTueAVJsti7YlsLQDATIn5N5VtS2Hof/FIW8vGJDIWq1JbltsKXHzu8jjmptWPYOUFOLaJ2CMx/fw=
Received: from DB7PR02MB4411.eurprd02.prod.outlook.com (20.178.41.22) by
 DB7PR02MB4956.eurprd02.prod.outlook.com (20.178.44.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Thu, 30 May 2019 08:46:02 +0000
Received: from DB7PR02MB4411.eurprd02.prod.outlook.com
 ([fe80::ce5:7d93:d1e2:5bcf]) by DB7PR02MB4411.eurprd02.prod.outlook.com
 ([fe80::ce5:7d93:d1e2:5bcf%4]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 08:46:02 +0000
From:   Dalit Ben Zoor <dbenzoor@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] habanalabs: clear sobs and monitors in context switch
Thread-Topic: [PATCH 2/3] habanalabs: clear sobs and monitors in context
 switch
Thread-Index: AQHVFsQcLTtazBGFy0eQLpuKQwZtog==
Date:   Thu, 30 May 2019 08:46:02 +0000
Message-ID: <20190530084554.31968-2-dbenzoor@habana.ai>
References: <20190530084554.31968-1-dbenzoor@habana.ai>
In-Reply-To: <20190530084554.31968-1-dbenzoor@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::21) To DB7PR02MB4411.eurprd02.prod.outlook.com
 (2603:10a6:10:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dbenzoor@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e60fb847-76aa-4312-e6ab-08d6e4db3e90
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB7PR02MB4956;
x-ms-traffictypediagnostic: DB7PR02MB4956:
x-microsoft-antispam-prvs: <DB7PR02MB49560C0F141020C19DB6A117DC180@DB7PR02MB4956.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39850400004)(366004)(396003)(199004)(189003)(8936002)(50226002)(25786009)(4326008)(14454004)(66446008)(64756008)(66556008)(66476007)(81166006)(81156014)(8676002)(73956011)(66946007)(2501003)(36756003)(68736007)(86362001)(66066001)(6486002)(2351001)(53936002)(74482002)(102836004)(316002)(1361003)(6436002)(5640700003)(6916009)(5660300002)(4744005)(386003)(6506007)(7736002)(305945005)(476003)(2616005)(99286004)(6116002)(3846002)(11346002)(52116002)(478600001)(446003)(71190400001)(76176011)(26005)(186003)(71200400001)(486006)(6512007)(2906002)(14444005)(1076003)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB4956;H:DB7PR02MB4411.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W1qVXQJaXfv8ndrmBV055AAM3DM5xj7CffY9M2wNcnGzALanBXFI09Cj8lNSBlFkJewanym9M1TP7MmmTV/On0Kgo09H3tRsrlYbytUyxipq0ccx7buZZ2rd5JqE6ReI/ASbYpKZ/C0B+/IFua7FnuJq46gLPNCuOxMS1L1nyeUy5YMUghRPaO6bXhCNo4DSlerXz0cFubPmF1H4Y8LxSBaMKUFeefMtSp4AkbMJ6usztbvNbt4SaushF5Ad381GPxRkJ1Xg8ADpJz0Mlqxbhhdbuz1pKBuRovM5+eIKjy5p8tsn/thx9m+UxZS1w1i0Me1HjtEQEDW4zIBd8D2YFkIcUILpurTcmbFUu8sqe3Aia96nPVXgrGmPZGPquxJ1cntNsNaycpGnFhk9i5KqycQFsnP/vQu2m1lzqwAB+4A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: e60fb847-76aa-4312-e6ab-08d6e4db3e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 08:46:02.1806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbenzoor@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gY29udGV4dCBzd2l0Y2ggd2UgbmVlZCB0byBlbnN1cmUgdGhhdCBlYWNoIHVzZXIgaXMgbm90
IGJlIGFmZmVjdGVkIGJ5DQpvdGhlciB1c2VyLCBzbyB3ZSBuZWVkIHRvIGNsZWFyIHN5bmMgb2Jq
ZWN0cyBhbmQgbW9uaXRvcnMgaW4gY29udGV4dA0Kc3dpdGNoIGluc3RlYWQgb2YgaW4gcmVzdG9y
ZV9waGFzZV90b3BvbG9neSBmdW5jdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogRGFsaXQgQmVuIFpv
b3IgPGRiZW56b29yQGhhYmFuYS5haT4NCi0tLQ0KIGRyaXZlcnMvbWlzYy9oYWJhbmFsYWJzL2dv
eWEvZ295YS5jIHwgNyArKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL2hhYmFuYWxhYnMvZ295YS9nb3lhLmMgYi9kcml2
ZXJzL21pc2MvaGFiYW5hbGFicy9nb3lhL2dveWEuYw0KaW5kZXggZTBmYzUxMWFjYWVjLi44Nzg1
OWM1NWI0YjggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21pc2MvaGFiYW5hbGFicy9nb3lhL2dveWEu
Yw0KKysrIGIvZHJpdmVycy9taXNjL2hhYmFuYWxhYnMvZ295YS9nb3lhLmMNCkBAIC0zOTE5LDYg
KzM5MTksMTEgQEAgdm9pZCBnb3lhX3VwZGF0ZV9lcV9jaShzdHJ1Y3QgaGxfZGV2aWNlICpoZGV2
LCB1MzIgdmFsKQ0KIH0NCiANCiB2b2lkIGdveWFfcmVzdG9yZV9waGFzZV90b3BvbG9neShzdHJ1
Y3QgaGxfZGV2aWNlICpoZGV2KQ0KK3sNCisNCit9DQorDQorc3RhdGljIHZvaWQgZ295YV9jbGVh
cl9zbV9yZWdzKHN0cnVjdCBobF9kZXZpY2UgKmhkZXYpDQogew0KIAlpbnQgaSwgbnVtX29mX3Nv
Yl9pbl9sb25ncywgbnVtX29mX21vbl9pbl9sb25nczsNCiANCkBAIC00NTY5LDYgKzQ1NzQsOCBA
QCBpbnQgZ295YV9jb250ZXh0X3N3aXRjaChzdHJ1Y3QgaGxfZGV2aWNlICpoZGV2LCB1MzIgYXNp
ZCkNCiAJV1JFRzMyKG1tVFBDX1BMTF9DTEtfUkxYXzAsIDB4MjAwMDIwKTsNCiAJZ295YV9tbXVf
cHJlcGFyZShoZGV2LCBhc2lkKTsNCiANCisJZ295YV9jbGVhcl9zbV9yZWdzKGhkZXYpOw0KKw0K
IAlyZXR1cm4gMDsNCiB9DQogDQotLSANCjIuMTcuMQ0KDQo=
