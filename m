Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FC7C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162332175B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="t1E8NWpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfDYBO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:14:29 -0400
Received: from mail-eopbgr50055.outbound.protection.outlook.com ([40.107.5.55]:39075
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728694AbfDYBO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQmTqUEQ4Se4l3OkB66vvOLpPWden9Z0y2j/2fcbKp4=;
 b=t1E8NWpu4lVHvc6mifi6lcsGdIh6SrgNtfJPv1HdeaYWtINV3xOZzzokNPpYXmxAVubnt///RvM1AKsghXalf9r2Jv4b6DE88mjJ4pjdceYulT5yn4wZW0SF0BMeZQGlb2nNzn7zel20n1t7SoOgB3ZLZkbwTGisNkV+S+lof/k=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3788.eurprd04.prod.outlook.com (52.134.72.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.18; Thu, 25 Apr 2019 01:14:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 01:14:23 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] firmware: imx: SCU irq should ONLY be enabled after SCU
 IPC is ready
Thread-Topic: [PATCH 1/2] firmware: imx: SCU irq should ONLY be enabled after
 SCU IPC is ready
Thread-Index: AQHU+wQ3bxGkLXDjYkSt99sp4EdO4Q==
Date:   Thu, 25 Apr 2019 01:14:23 +0000
Message-ID: <1556154581-31890-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0058.apcprd03.prod.outlook.com
 (2603:1096:203:52::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5121134-f1c0-44c5-af66-08d6c91b59e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3788;
x-ms-traffictypediagnostic: DB3PR0402MB3788:
x-microsoft-antispam-prvs: <DB3PR0402MB3788E60D865E984C9485C089F53D0@DB3PR0402MB3788.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39850400004)(199004)(189003)(68736007)(36756003)(256004)(478600001)(8936002)(50226002)(2201001)(5024004)(14454004)(97736004)(86362001)(316002)(6486002)(110136005)(66476007)(66446008)(64756008)(66556008)(73956011)(476003)(53936002)(6506007)(8676002)(2616005)(186003)(66946007)(66066001)(305945005)(102836004)(26005)(7736002)(6116002)(486006)(25786009)(2501003)(4326008)(386003)(52116002)(99286004)(81166006)(6436002)(81156014)(6512007)(3846002)(71190400001)(5660300002)(2906002)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3788;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xCJMX4DWnl6hcTcn/2+GY235Mlki70ZUezzcT2h8MSYni9fqcifawRnb5/u15gNUAYyDeBg4ti8mnfcKb6TJ6O51Nvd7NHUDsiX5CR6yFhr4lyOS6i5i06SzCqrD6bC/j9SpUD1CQZDA8e4RPSzEgU5gxNc/rW+NZBRqnGDhO0ke6EZDqTBy0aIdM/ZEjszxI6lMkaSNAcIJg8Cc7PfBGFNu1PTbNZ6lOR03KAmrhijj2Wd43DllcL1c9tL4EHhsmX5BW0aU2ymlNvtp+e3TOexS/S3NaZ+HCMlPyO1pni1KnI6VjGOtZOekqjaBquV2BepWDuuSrvkwoJl3ZEL076HKeBm5u6ndsxnYW67h/s44rTOmk7YG3aKyV/8v5Br9ITKH1NPKTWlwGkL7LHO0luG3XlmTo//moG7Owx2+Dto=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5121134-f1c0-44c5-af66-08d6c91b59e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 01:14:23.7794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGlteF9zY3VfaXJxX2dyb3VwX2VuYWJsZSgpIGlzIG5vcm1hbGx5IGNhbGxlZCBkdXJpbmcg
bW9kdWxlIGRyaXZlcg0KcHJvYmUgcGhhc2UgdG8gZW5hYmxlIFNDVSBncm91cCBpcnEsIGUuZy4s
IGkuTVggc3lzdGVtIGNvbnRyb2xsZXINCndhdGNoZG9nIGRyaXZlciB3aWxsIGNhbGwgaXQgZHVy
aW5nIGl0cyBkcml2ZXIgcHJvYmUgcGhhc2UsIGFzIGkuTVgNCnN5c3RlbSBjb250cm9sbGVyIHdh
dGNoZG9nIGRyaXZlciBkb2VzIE5PVCBuZWVkIFNDVSBJUEMgaGFuZGxlIGZvcg0Kb3BlcmF0aW9u
cywgc28gaXQgY291bGQgYmUgcHJvYmVkIGJlZm9yZSBpLk1YIFNDVSBJUEMgaXMgcmVhZHksIGFu
ZA0KYmVsb3cgZHVtcCB3aWxsIHNob3cgb3V0Og0KDQpbICAgIDAuOTMzMDAxXSBIYXJkd2FyZSBu
YW1lOiBGcmVlc2NhbGUgaS5NWDhRWFAgTUVLIChEVCkNClsgICAgMC45MzgxMjldIHBzdGF0ZTog
NjAwMDAwMDUgKG5aQ3YgZGFpZiAtUEFOIC1VQU8pDQpbICAgIDAuOTQyOTA3XSBwYyA6IGlteF9z
Y3VfY2FsbF9ycGMrMHgxMTQvMHgxNTgNClsgICAgMC45NDcyNTFdIGxyIDogaW14X3NjdV9pcnFf
Z3JvdXBfZW5hYmxlKzB4NzQvMHhjNA0KWyAgICAwLjk1MjExM10gc3AgOiBmZmZmMDAwMDEwMDVi
YWUwDQpbICAgIDAuOTU1NDE1XSB4Mjk6IGZmZmYwMDAwMTAwNWJhZTAgeDI4OiBmZmZmMDAwMDEx
MWJiMGEwDQpbICAgIDAuOTYwNzEyXSB4Mjc6IGZmZmYwMDAwMTE0MGIwMDAgeDI2OiBmZmZmMDAw
MDExMTEwNjhjDQpbICAgIDAuOTY2MDExXSB4MjU6IGZmZmYwMDAwMTExYmIxMDAgeDI0OiAwMDAw
MDAwMDAwMDAwMDAwDQpbICAgIDAuOTcxMzExXSB4MjM6IGZmZmYwMDAwMTEzZDljZDggeDIyOiAw
MDAwMDAwMDAwMDAwMDAxDQpbICAgIDAuOTc2NjEwXSB4MjE6IDAwMDAwMDAwMDAwMDAwMDEgeDIw
OiBmZmZmODAwODNiNTFhNDEwDQpbICAgIDAuOTgxOTA5XSB4MTk6IGZmZmYwMDAwMTEyNTkwMDAg
eDE4OiAwMDAwMDAwMDAwMDAwNDgwDQpbICAgIDAuOTg3MjA5XSB4MTc6IDAwMDAwMDAwMDAyM2Zm
YjggeDE2OiAwMDAwMDAwMDAwMDAwMDEwDQpbICAgIDAuOTkyNTA4XSB4MTU6IDAwMDAwMDAwMDAw
MDAyM2YgeDE0OiBmZmZmZmZmZmZmZmZmZmZmDQpbICAgIDAuOTk3ODA3XSB4MTM6IDAwMDAwMDAw
MDAwMDAwMTggeDEyOiAwMDAwMDAwMDAwMDAwMDMwDQpbICAgIDEuMDAzMTA3XSB4MTE6IDAwMDAw
MDAwMDAwMDAwMDMgeDEwOiAwMTAxMDEwMTAxMDEwMTAxDQpbICAgIDEuMDA4NDA2XSB4OSA6IGZm
ZmZmZmZmZmZmZmZmZmYgeDggOiA3ZjdmN2Y3ZjdmN2Y3ZjdmDQpbICAgIDEuMDEzNzA2XSB4NyA6
IGZlZmVmZWZmNjQ2YzYwNmQgeDYgOiAwMDAwMDAwMDAwMDAwMDAwDQpbICAgIDEuMDE5MDA1XSB4
NSA6IGZmZmYwMDAwMTEyNTk2YzggeDQgOiAwMDAwMDAwMDAwMDAwMDA4DQpbICAgIDEuMDI0MzA0
XSB4MyA6IDAwMDAwMDAwMDAwMDAwMDMgeDIgOiAwMDAwMDAwMDAwMDAwMDAxDQpbICAgIDEuMDI5
NjA0XSB4MSA6IGZmZmYwMDAwMTAwNWJiNTggeDAgOiAwMDAwMDAwMDAwMDAwMDAwDQpbICAgIDEu
MDM0OTA1XSBDYWxsIHRyYWNlOg0KWyAgICAxLjAzNzM0MV0gIGlteF9zY3VfY2FsbF9ycGMrMHgx
MTQvMHgxNTgNClsgICAgMS4wNDEzMzRdICBpbXhfc2N1X2lycV9ncm91cF9lbmFibGUrMHg3NC8w
eGM0DQpbICAgIDEuMDQ1ODU2XSAgaW14X3NjX3dkdF9wcm9iZSsweDI0LzB4MTUwDQpbICAgIDEu
MDQ5NzY2XSAgcGxhdGZvcm1fZHJ2X3Byb2JlKzB4NGMvMHhiMA0KWyAgICAxLjA1Mzc2Ml0gIHJl
YWxseV9wcm9iZSsweDFmOC8weDJjOA0KWyAgICAxLjA1NzQwN10gIGRyaXZlcl9wcm9iZV9kZXZp
Y2UrMHg1OC8weGZjDQpbICAgIDEuMDYxNDkwXSAgZGV2aWNlX2RyaXZlcl9hdHRhY2grMHg2OC8w
eDcwDQpbICAgIDEuMDY1NjYwXSAgX19kcml2ZXJfYXR0YWNoKzB4OTQvMHhkYw0KWyAgICAxLjA2
OTM5N10gIGJ1c19mb3JfZWFjaF9kZXYrMHg2NC8weGMwDQpbICAgIDEuMDczMjIwXSAgZHJpdmVy
X2F0dGFjaCsweDIwLzB4MjgNClsgICAgMS4wNzY3ODJdICBidXNfYWRkX2RyaXZlcisweDE0OC8w
eDFmYw0KWyAgICAxLjA4MDYwMV0gIGRyaXZlcl9yZWdpc3RlcisweDY4LzB4MTIwDQpbICAgIDEu
MDg0NDI0XSAgX19wbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIrMHg0Yy8weDU0DQpbICAgIDEuMDg5
MTIwXSAgaW14X3NjX3dkdF9kcml2ZXJfaW5pdCsweDE4LzB4MjANClsgICAgMS4wOTM0NjNdICBk
b19vbmVfaW5pdGNhbGwrMHg1OC8weDFiOA0KWyAgICAxLjA5NzI4N10gIGtlcm5lbF9pbml0X2Zy
ZWVhYmxlKzB4MWNjLzB4Mjg4DQpbICAgIDEuMTAxNjMwXSAga2VybmVsX2luaXQrMHgxMC8weDEw
MA0KWyAgICAxLjEwNTEwMV0gIHJldF9mcm9tX2ZvcmsrMHgxMC8weDE4DQpbICAgIDEuMTA4NjY5
XSAtLS1bIGVuZCB0cmFjZSA5ZTAzMzAyMTE0NDU3ZGU5IF0tLS0NClsgICAgMS4xMTMyOTZdIGVu
YWJsZSBpcnEgZmFpbGVkLCBncm91cCAxLCBtYXNrIDEsIHJldCAtMjINCg0KVG8gYXZvaWQgc3Vj
aCBzY2VuYXJpbywgcmV0dXJuIC1FUFJPQkVfREVGRVIgaW4gaW14X3NjdV9pcnFfZ3JvdXBfZW5h
YmxlKCkNCkFQSSBpZiBTQ1UgSVBDIGlzIE5PVCByZWFkeSwgdGhlbiBtb2R1bGUgZHJpdmVyIHdo
aWNoIGNhbGxzIHRoaXMgQVBJDQppbiBwcm9iZSBwaGFzZSB3aWxsIGRlZmVyIHByb2JlIGFmdGVy
IFNDVSBJUEMgcmVhZHkuDQoNCkZpeGVzOiA4NTE4MjZjNzU2NmUgKCJmaXJtd2FyZTogaW14OiBl
bmFibGUgaW14IHNjdSBnZW5lcmFsIGlycSBmdW5jdGlvbiIpDQpTaWduZWQtb2ZmLWJ5OiBBbnNv
biBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZmlybXdhcmUvaW14
L2lteC1zY3UtaXJxLmMgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UtaXJxLmMgYi9kcml2
ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LWlycS5jDQppbmRleCAwNDM4MzNhLi42ODcxMjFmIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS1pcnEuYw0KKysrIGIvZHJp
dmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS1pcnEuYw0KQEAgLTEwMCw2ICsxMDAsOSBAQCBpbnQg
aW14X3NjdV9pcnFfZ3JvdXBfZW5hYmxlKHU4IGdyb3VwLCB1MzIgbWFzaywgdTggZW5hYmxlKQ0K
IAlzdHJ1Y3QgaW14X3NjX3JwY19tc2cgKmhkciA9ICZtc2cuaGRyOw0KIAlpbnQgcmV0Ow0KIA0K
KwlpZiAoIWlteF9zY19pcnFfaXBjX2hhbmRsZSkNCisJCXJldHVybiAtRVBST0JFX0RFRkVSOw0K
Kw0KIAloZHItPnZlciA9IElNWF9TQ19SUENfVkVSU0lPTjsNCiAJaGRyLT5zdmMgPSBJTVhfU0Nf
UlBDX1NWQ19JUlE7DQogCWhkci0+ZnVuYyA9IElNWF9TQ19JUlFfRlVOQ19FTkFCTEU7DQotLSAN
CjIuNy40DQoNCg==
