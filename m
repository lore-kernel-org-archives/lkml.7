Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AC2C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCACA222EB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="JXaRhHaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfDSSQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:16:11 -0400
Received: from mail-eopbgr1310073.outbound.protection.outlook.com ([40.107.131.73]:52552
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfDSSQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdfUc6+kLnUGTJf7L9HG8c0ayt4uBIagq0PHTSw5FSk=;
 b=JXaRhHaNbTyMAG02rm9RyB/ESCCoW83TARTzwWjVG9n3DyAvk9K2y5WZ21cqRe9vJk40hjC8qJ5XzprDxECUita1vbDy5JmMchcChHfpFlpumLPNqsEgkqnhnUU7Rm1za3/zcHHjsDOFtlRZOGmtwAEfQgR6Pb+by1PP6eIEfIQ=
Received: from HK0PR02MB2468.apcprd02.prod.outlook.com (52.133.208.17) by
 HK0PR02MB3314.apcprd02.prod.outlook.com (20.177.68.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Fri, 19 Apr 2019 13:26:53 +0000
Received: from HK0PR02MB2468.apcprd02.prod.outlook.com
 ([fe80::81e3:202b:6cdf:5912]) by HK0PR02MB2468.apcprd02.prod.outlook.com
 ([fe80::81e3:202b:6cdf:5912%2]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 13:26:53 +0000
From:   Raag Jadav <raag.jadav@einfochips.com>
CC:     Raag Jadav <raag.jadav@einfochips.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] i2c: at91: fix TXRDY interrupt spam
Thread-Topic: [PATCH] i2c: at91: fix TXRDY interrupt spam
Thread-Index: AQHU9rONl182tFqeSUyYd/NZUUWF6A==
Date:   Fri, 19 Apr 2019 13:26:53 +0000
Message-ID: <1555680298-518-1-git-send-email-raag.jadav@einfochips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: KL1PR0601CA0021.apcprd06.prod.outlook.com
 (2603:1096:802:1::31) To HK0PR02MB2468.apcprd02.prod.outlook.com
 (2603:1096:203:21::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=raag.jadav@einfochips.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1898ae49-df85-477c-fd5f-08d6c4caafbb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:HK0PR02MB3314;
x-ms-traffictypediagnostic: HK0PR02MB3314:
x-microsoft-antispam-prvs: <HK0PR02MB33146BE197C978369E267F09FC270@HK0PR02MB3314.apcprd02.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(36756003)(8676002)(102836004)(81156014)(81166006)(186003)(53936002)(54906003)(6512007)(26005)(50226002)(14454004)(59246006)(55236004)(7736002)(386003)(5660300002)(305945005)(6506007)(68736007)(2906002)(66066001)(478600001)(316002)(25786009)(78486014)(109986005)(2616005)(4326008)(71200400001)(256004)(14444005)(5024004)(6116002)(71190400001)(97736004)(6486002)(44832011)(6436002)(486006)(476003)(86362001)(8936002)(66574012)(64756008)(66446008)(3846002)(66476007)(66946007)(66556008)(1671002)(99286004)(73956011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:HK0PR02MB3314;H:HK0PR02MB2468.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /HGNiiJLJX8FsWMXwtcsV/fHuml2Lvw6e+SoTzZNxqaCOb4FFxPyE+kOiECMK998Y4Z6Z2o1rQ0Xo0ZTDI25GK7tDLYt1HyEVGh/u4/rxlIWCVAvFKr9Nus2tYFfvfEiDePgFwmohaXmJEUjNCV/8Ywf/9WB8Duf5UyYPgCqhzvGJEMgzIHepN07HFeFjg5ixeI+6tB7n9tPi3ymNSip/y6cQj+VXOL0tuoylHPfwt96MJorngTcat8YsvzNrooKrBiOIZYkIPP2+0sFQZEwEO+2kOjsxWPh0wda5tGlzB9avyFkZ+D0bHDBud6Zl2CdDU5zYIXhVg8AG6s2V0cUokPaUwOqBQg1bla8TVB4FRcOoJgHoHZ1Y8r4Zi3lqgIMHIieeRm8rXNiz3FyUk6+vNp/LFoF+lEFQbnZbcwM8qQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1898ae49-df85-477c-fd5f-08d6c4caafbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 13:26:53.3627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB3314
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGVyZm9ybWluZyBpMmMgd3JpdGUgb3BlcmF0aW9uIHdoaWxlIFNEQSBvciBTQ0wgbGluZSBpcyBn
cm91bmRlZCwNClRYUkRZIGludGVycnVwdCBzcGFtIGhhbmdzIHRoZSBwcm9jZXNzb3IsIG5vdCBh
bGxvd2luZyB0byBib290Lg0KDQpTaWduZWQtb2ZmLWJ5OiByYWFnIDxyYWFnLmphZGF2QGVpbmZv
Y2hpcHMuY29tPg0KLS0tDQogZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1hdDkxLmMgfCA0ICsrKy0N
CiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWF0OTEuYyBiL2RyaXZlcnMvaTJjL2J1c3Nl
cy9pMmMtYXQ5MS5jDQppbmRleCBiZmQxZmRmLi40N2I1ZThhIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy1hdDkxLmMNCisrKyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtYXQ5
MS5jDQpAQCAtMjcwLDkgKzI3MCwxMSBAQCBzdGF0aWMgdm9pZCBhdDkxX3R3aV93cml0ZV9uZXh0
X2J5dGUoc3RydWN0IGF0OTFfdHdpX2RldiAqZGV2KQ0KIHdyaXRlYl9yZWxheGVkKCpkZXYtPmJ1
ZiwgZGV2LT5iYXNlICsgQVQ5MV9UV0lfVEhSKTsNCg0KIC8qIHNlbmQgc3RvcCB3aGVuIGxhc3Qg
Ynl0ZSBoYXMgYmVlbiB3cml0dGVuICovDQotaWYgKC0tZGV2LT5idWZfbGVuID09IDApDQoraWYg
KC0tZGV2LT5idWZfbGVuID09IDApIHsNCiBpZiAoIWRldi0+dXNlX2FsdF9jbWQpDQogYXQ5MV90
d2lfd3JpdGUoZGV2LCBBVDkxX1RXSV9DUiwgQVQ5MV9UV0lfU1RPUCk7DQorYXQ5MV90d2lfd3Jp
dGUoZGV2LCBBVDkxX1RXSV9JRFIsIEFUOTFfVFdJX1RYUkRZKTsNCit9DQoNCiBkZXZfZGJnKGRl
di0+ZGV2LCAid3JvdGUgMHgleCwgdG8gZ28gJXp1XG4iLCAqZGV2LT5idWYsIGRldi0+YnVmX2xl
bik7DQoNCi0tDQoyLjcuNA0KDQoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqIGVJbmZvY2hpcHMgQnVzaW5lc3MgRGlzY2xhaW1lcjogVGhpcyBlLW1haWwgbWVzc2Fn
ZSBhbmQgYWxsIGF0dGFjaG1lbnRzIHRyYW5zbWl0dGVkIHdpdGggaXQgYXJlIGludGVuZGVkIHNv
bGVseSBmb3IgdGhlIHVzZSBvZiB0aGUgYWRkcmVzc2VlIGFuZCBtYXkgY29udGFpbiBsZWdhbGx5
IHByaXZpbGVnZWQgYW5kIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbi4gSWYgdGhlIHJlYWRlciBv
ZiB0aGlzIG1lc3NhZ2UgaXMgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIG9yIGFuIGVtcGxv
eWVlIG9yIGFnZW50IHJlc3BvbnNpYmxlIGZvciBkZWxpdmVyaW5nIHRoaXMgbWVzc2FnZSB0byB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJlIGhlcmVieSBub3RpZmllZCB0aGF0IGFueSBk
aXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24sIGNvcHlpbmcsIG9yIG90aGVyIHVzZSBvZiB0aGlz
IG1lc3NhZ2Ugb3IgaXRzIGF0dGFjaG1lbnRzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlv
dSBoYXZlIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUg
c2VuZGVyIGltbWVkaWF0ZWx5IGJ5IHJlcGx5aW5nIHRvIHRoaXMgbWVzc2FnZSBhbmQgcGxlYXNl
IGRlbGV0ZSBpdCBmcm9tIHlvdXIgY29tcHV0ZXIuIEFueSB2aWV3cyBleHByZXNzZWQgaW4gdGhp
cyBtZXNzYWdlIGFyZSB0aG9zZSBvZiB0aGUgaW5kaXZpZHVhbCBzZW5kZXIgdW5sZXNzIG90aGVy
d2lzZSBzdGF0ZWQuIENvbXBhbnkgaGFzIHRha2VuIGVub3VnaCBwcmVjYXV0aW9ucyB0byBwcmV2
ZW50IHRoZSBzcHJlYWQgb2YgdmlydXNlcy4gSG93ZXZlciB0aGUgY29tcGFueSBhY2NlcHRzIG5v
IGxpYWJpbGl0eSBmb3IgYW55IGRhbWFnZSBjYXVzZWQgYnkgYW55IHZpcnVzIHRyYW5zbWl0dGVk
IGJ5IHRoaXMgZW1haWwuICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioNCg==
