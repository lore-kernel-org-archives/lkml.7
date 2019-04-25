Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD766C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7740B24272
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="OV1rCQdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfDYM2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:28:51 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:37397 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfDYM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:28:50 -0400
X-IronPort-AV: E=Sophos;i="5.60,393,1549954800"; 
   d="scan'208";a="30826556"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 25 Apr 2019 05:28:48 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 25 Apr 2019 05:28:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaMBIGL3M1PjcCoUCC2H90HkEKofKXUHFm5nny0vUK4=;
 b=OV1rCQdxPpuAEkjM+258JsOpDOz7D3Vqp/305xlGHA3U8Fi65ASAb1CCMlQfhRCTCXpAVOLC6kobp0ou4U054q7LY+p/IJmguUliAG9iBM+d/povz8YqtWgpckGz6S9sX8lqIA9yNb9rbeK6Zn1jr7PHLFWM9pgCPQHGRANQWJQ=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1470.namprd11.prod.outlook.com (10.172.53.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Thu, 25 Apr 2019 12:28:47 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 12:28:47 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <thierry.reding@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>, <maxime.ripard@bootlin.com>
Subject: [PATCH v3 6/6] drm/atmel-hclcdc: revert shift by 8
Thread-Topic: [PATCH v3 6/6] drm/atmel-hclcdc: revert shift by 8
Thread-Index: AQHU+2Jt0ynRmATar02eZ3Uv1M30NQ==
Date:   Thu, 25 Apr 2019 12:28:46 +0000
Message-ID: <1556195285-10687-7-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: a8777e8f-ad23-471c-bdde-08d6c9799011
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1470;
x-ms-traffictypediagnostic: MWHPR11MB1470:
x-microsoft-antispam-prvs: <MWHPR11MB147018763C95F879FEB62DFC873D0@MWHPR11MB1470.namprd11.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(66476007)(7736002)(81156014)(305945005)(66556008)(64756008)(66446008)(8936002)(68736007)(8676002)(73956011)(66946007)(81166006)(5660300002)(7416002)(6486002)(3846002)(6116002)(6506007)(2501003)(386003)(76176011)(14444005)(2201001)(102836004)(50226002)(99286004)(86362001)(36756003)(52116002)(4326008)(110136005)(54906003)(66066001)(186003)(256004)(26005)(71190400001)(71200400001)(53936002)(25786009)(486006)(478600001)(72206003)(476003)(446003)(11346002)(4744005)(2616005)(2906002)(97736004)(316002)(6436002)(6512007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1470;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XJvrahVUthl50VB1+HDq3U/bc2Uruam4VxhL1kqQyszP6kGXhO2es81YOmRX+cAYqdUkdB1KpkeGCAGktHHnZyw4RWYFs5Sxhp/zdvf0GprzWIPxOHuk5k6RJCb/L6ioiXnafAcmY4Vsyb7K0jEd7InAfyT70HA6c4qTTrUDnk+06NsPixntEIZgwxnaAMP6/QfvAAdoAGKOcV366GdTUJaqeUPlj7HA2YFdytktMA6hVsX//or/LM+TgD9OPo2jh+bjL81xogTJVJwJ+8vYKuhKh16pJ0lmqfCtHtVfOog7xt4En+QpNvdVL7kmdhjs5fHSYWU5+MhHOXlQNo/w8aPTEpkJ8ZajCZPHcOnB3yX0Ir0GlNdkxtfQZzTFNV7hubNcY2vjfHrQ6HQnR2/+E068iPgVJB8gX1xaz7r9fq8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a8777e8f-ad23-471c-bdde-08d6c9799011
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:28:47.0306
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

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNClJl
dmVydCBzaGlmdCBieSA4IG9mIHN0YXRlLT5iYXNlLmFscGhhLiBUaGlzIGludHJvZHVjZWQgcmVn
cmVzaW9uDQpvbiBwbGFuZXMuDQoNCkZpeGVzOiA3ZjczYzEwYjI1NmIgKCJkcm0vYXRtZWwtaGNs
Y2RjOiBDb252ZXJ0IHRvIHRoZSBuZXcgZ2VuZXJpYyBhbHBoYSBwcm9wZXJ0eSIpDQpDYzogTWF4
aW1lIFJpcGFyZCA8bWF4aW1lLnJpcGFyZEBib290bGluLmNvbT4NClNpZ25lZC1vZmYtYnk6IENs
YXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KLS0tDQogZHJpdmVy
cy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX3BsYW5lLmMgfCAyICstDQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfcGxhbmUuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19wbGFuZS5jDQppbmRleCBlODM2ZTJkZTM1
Y2UuLmNjODMwMTM1MjM4NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNk
Yy9hdG1lbF9obGNkY19wbGFuZS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMv
YXRtZWxfaGxjZGNfcGxhbmUuYw0KQEAgLTM4Miw3ICszODIsNyBAQCBhdG1lbF9obGNkY19wbGFu
ZV91cGRhdGVfZ2VuZXJhbF9zZXR0aW5ncyhzdHJ1Y3QgYXRtZWxfaGxjZGNfcGxhbmUgKnBsYW5l
LA0KIAkJCWNmZyB8PSBBVE1FTF9ITENEQ19MQVlFUl9MQUVOOw0KIAkJZWxzZQ0KIAkJCWNmZyB8
PSBBVE1FTF9ITENEQ19MQVlFUl9HQUVOIHwNCi0JCQkgICAgICAgQVRNRUxfSExDRENfTEFZRVJf
R0Eoc3RhdGUtPmJhc2UuYWxwaGEgPj4gOCk7DQorCQkJICAgICAgIEFUTUVMX0hMQ0RDX0xBWUVS
X0dBKHN0YXRlLT5iYXNlLmFscGhhKTsNCiAJfQ0KIA0KIAlpZiAoc3RhdGUtPmRpc2NfaCAmJiBz
dGF0ZS0+ZGlzY193KQ0KLS0gDQoyLjcuNA0KDQo=
