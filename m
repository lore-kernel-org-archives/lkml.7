Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DAAC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B428121BC0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="xeyDBQ9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbfDYM2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:28:30 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:37369 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbfDYM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:28:29 -0400
X-IronPort-AV: E=Sophos;i="5.60,393,1549954800"; 
   d="scan'208";a="30826534"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 25 Apr 2019 05:28:28 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 25 Apr 2019 05:28:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBQ+hpUZ4QZBYGADbXck0DQ1fR4QKfN34rUXcaGzFmE=;
 b=xeyDBQ9OcoSbq+DeUl1X587Ve5pwC7PLx8Fykc0t/DpM9zx7PCK4nyDxddtSL7zmnNQ10kBLyLIBnh23yZfjMDxyxwgpduU4S2wtYXPFjOeWaNCfcl5PEEfNMicNNJACHLrZNPH64u1HPJKE4jiRzbdM7LbMYtAZi/HZvRXlRcA=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1470.namprd11.prod.outlook.com (10.172.53.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Thu, 25 Apr 2019 12:28:26 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 12:28:26 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <thierry.reding@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 1/6] drm: atmel-hlcdc: add config option for clock
 selection
Thread-Topic: [PATCH v3 1/6] drm: atmel-hlcdc: add config option for clock
 selection
Thread-Index: AQHU+2JhBuWnQ7wyq02aSqvKdcdQ3Q==
Date:   Thu, 25 Apr 2019 12:28:26 +0000
Message-ID: <1556195285-10687-2-git-send-email-claudiu.beznea@microchip.com>
References: <1556195285-10687-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1556195285-10687-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0254.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::21) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c5612fc-4df4-45b6-4277-08d6c97983cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1470;
x-ms-traffictypediagnostic: MWHPR11MB1470:
x-microsoft-antispam-prvs: <MWHPR11MB1470E31DE42C05385DD4E342873D0@MWHPR11MB1470.namprd11.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(66476007)(7736002)(81156014)(305945005)(66556008)(64756008)(66446008)(8936002)(68736007)(8676002)(73956011)(66946007)(81166006)(5660300002)(6486002)(3846002)(6116002)(6506007)(2501003)(386003)(76176011)(14444005)(2201001)(102836004)(50226002)(99286004)(86362001)(36756003)(52116002)(4326008)(110136005)(54906003)(107886003)(66066001)(186003)(256004)(26005)(71190400001)(71200400001)(53936002)(25786009)(486006)(478600001)(72206003)(476003)(446003)(11346002)(2616005)(2906002)(97736004)(316002)(6436002)(6512007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1470;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F3FjGzo7i4S3ISNsM+0Z5nRjxOYx47eulEvwtKyRtjY4pHuTFTQt1buGus/KdC3qEPWpVFtfBUlIxQitRSZP9EjLdbxNuxc1Z9lPg+UyvCZyMFN13/sV+KwCcPNOvkLD+0MsJKMpXovxg3+aTWdi0xG+p7uhWb6mGP65k2SxhYnJpVSifqUxqcETD3/MAKZaLfsPc3J0vcap07ikH12WDZhnTZ/qMDr841VB3nSThkzJ1sga0jOZHxl2txm80oyUSDNIy0ZHzjiTLqgRqAW9z2s8pN8cLf37xHzbdPaHLxjpZNcufI3Yld0d6CutqDHchh+KZcMLg0OtwSeC7PbOHXidFdq5fnhZuN2CHNIS4MKN4MOkNGM7V2q6kPdu8JqMF8eTZ9mjjdr8UtUtQTGGH35K9rhLuvzcG7uiuPh1uoY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5612fc-4df4-45b6-4277-08d6c97983cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:28:26.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1470
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNClNB
TTl4NjAgTENEIENvbnRyb2xsZXIgaGFzIG5vIG9wdGlvbiB0byBzZWxlY3QgY2xvY2sgc291cmNl
IGFzIHByZXZpb3VzDQpjb250cm9sbGVycyBoYXZlLiBUbyBiZSBhYmxlIHRvIHVzZSB0aGUgc2Ft
ZSBkcml2ZXIgZXZlbiBmb3IgdGhpcyBMQ0QNCmNvbnRyb2xsZXIgYWRkIGEgY29uZmlnIG9wdGlv
biB0byBrbm93IGlmIGNvbnRyb2xsZXIgc3VwcG9ydHMgdGhpcy4NCg0KU2lnbmVkLW9mZi1ieTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQpSZXZpZXdlZC1i
eTogU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJvcmcub3JnPg0KLS0tDQogZHJpdmVycy9ncHUvZHJt
L2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYyB8IDEyICsrKysrKystLS0tLQ0KIGRyaXZl
cnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19kYy5oICAgfCAgMiArKw0KIDIgZmls
ZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMNCmluZGV4IDgwNzBhNTU4
ZDdiMS4uOTU3ZTZkMmZiMDBmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhs
Y2RjL2F0bWVsX2hsY2RjX2NydGMuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2Rj
L2F0bWVsX2hsY2RjX2NydGMuYw0KQEAgLTc4LDcgKzc4LDggQEAgc3RhdGljIHZvaWQgYXRtZWxf
aGxjZGNfY3J0Y19tb2RlX3NldF9ub2ZiKHN0cnVjdCBkcm1fY3J0YyAqYykNCiAJdW5zaWduZWQg
bG9uZyBtb2RlX3JhdGU7DQogCXN0cnVjdCB2aWRlb21vZGUgdm07DQogCXVuc2lnbmVkIGxvbmcg
cHJhdGU7DQotCXVuc2lnbmVkIGludCBjZmc7DQorCXVuc2lnbmVkIGludCBtYXNrID0gQVRNRUxf
SExDRENfQ0xLRElWX01BU0sgfCBBVE1FTF9ITENEQ19DTEtQT0w7DQorCXVuc2lnbmVkIGludCBj
ZmcgPSAwOw0KIAlpbnQgZGl2Ow0KIA0KIAl2bS52ZnJvbnRfcG9yY2ggPSBhZGotPmNydGNfdnN5
bmNfc3RhcnQgLSBhZGotPmNydGNfdmRpc3BsYXk7DQpAQCAtMTAxLDcgKzEwMiwxMCBAQCBzdGF0
aWMgdm9pZCBhdG1lbF9obGNkY19jcnRjX21vZGVfc2V0X25vZmIoc3RydWN0IGRybV9jcnRjICpj
KQ0KIAkJICAgICAoYWRqLT5jcnRjX2hkaXNwbGF5IC0gMSkgfA0KIAkJICAgICAoKGFkai0+Y3J0
Y192ZGlzcGxheSAtIDEpIDw8IDE2KSk7DQogDQotCWNmZyA9IEFUTUVMX0hMQ0RDX0NMS1NFTDsN
CisJaWYgKCFjcnRjLT5kYy0+ZGVzYy0+Zml4ZWRfY2xrc3JjKSB7DQorCQljZmcgfD0gQVRNRUxf
SExDRENfQ0xLU0VMOw0KKwkJbWFzayB8PSBBVE1FTF9ITENEQ19DTEtTRUw7DQorCX0NCiANCiAJ
cHJhdGUgPSAyICogY2xrX2dldF9yYXRlKGNydGMtPmRjLT5obGNkYy0+c3lzX2Nsayk7DQogCW1v
ZGVfcmF0ZSA9IGFkai0+Y3J0Y19jbG9jayAqIDEwMDA7DQpAQCAtMTMyLDkgKzEzNiw3IEBAIHN0
YXRpYyB2b2lkIGF0bWVsX2hsY2RjX2NydGNfbW9kZV9zZXRfbm9mYihzdHJ1Y3QgZHJtX2NydGMg
KmMpDQogDQogCWNmZyB8PSBBVE1FTF9ITENEQ19DTEtESVYoZGl2KTsNCiANCi0JcmVnbWFwX3Vw
ZGF0ZV9iaXRzKHJlZ21hcCwgQVRNRUxfSExDRENfQ0ZHKDApLA0KLQkJCSAgIEFUTUVMX0hMQ0RD
X0NMS1NFTCB8IEFUTUVMX0hMQ0RDX0NMS0RJVl9NQVNLIHwNCi0JCQkgICBBVE1FTF9ITENEQ19D
TEtQT0wsIGNmZyk7DQorCXJlZ21hcF91cGRhdGVfYml0cyhyZWdtYXAsIEFUTUVMX0hMQ0RDX0NG
RygwKSwgbWFzaywgY2ZnKTsNCiANCiAJY2ZnID0gMDsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuaCBiL2RyaXZlcnMvZ3B1L2RybS9h
dG1lbC1obGNkYy9hdG1lbF9obGNkY19kYy5oDQppbmRleCA3MGJkNTQwZDY0NGUuLjAxNTVlZmI5
YzQ0MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNk
Y19kYy5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMu
aA0KQEAgLTMyOCw2ICszMjgsNyBAQCBhdG1lbF9obGNkY19sYXllcl90b19wbGFuZShzdHJ1Y3Qg
YXRtZWxfaGxjZGNfbGF5ZXIgKmxheWVyKQ0KICAqIEBtYXhfaHB3OiBtYXhpbXVtIGhvcml6b250
YWwgYmFjay9mcm9udCBwb3JjaCB3aWR0aA0KICAqIEBjb25mbGljdGluZ19vdXRwdXRfZm9ybWF0
czogdHJ1ZSBpZiBSR0JYWFggb3V0cHV0IGZvcm1hdHMgY29uZmxpY3Qgd2l0aA0KICAqCQkJCWVh
Y2ggb3RoZXIuDQorICogQGZpeGVkX2Nsa3NyYzogdHJ1ZSBpZiBjbG9jayBzb3VyY2UgaXMgZml4
ZWQNCiAgKiBAbGF5ZXJzOiBhIGxheWVyIGRlc2NyaXB0aW9uIHRhYmxlIGRlc2NyaWJpbmcgYXZh
aWxhYmxlIGxheWVycw0KICAqIEBubGF5ZXJzOiBsYXllciBkZXNjcmlwdGlvbiB0YWJsZSBzaXpl
DQogICovDQpAQCAtMzQwLDYgKzM0MSw3IEBAIHN0cnVjdCBhdG1lbF9obGNkY19kY19kZXNjIHsN
CiAJaW50IG1heF92cHc7DQogCWludCBtYXhfaHB3Ow0KIAlib29sIGNvbmZsaWN0aW5nX291dHB1
dF9mb3JtYXRzOw0KKwlib29sIGZpeGVkX2Nsa3NyYzsNCiAJY29uc3Qgc3RydWN0IGF0bWVsX2hs
Y2RjX2xheWVyX2Rlc2MgKmxheWVyczsNCiAJaW50IG5sYXllcnM7DQogfTsNCi0tIA0KMi43LjQN
Cg0K
