Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED503C282E5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6058D206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="tzywggNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbfDYMgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:36:21 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:37713 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387787AbfDYMgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:36:20 -0400
X-IronPort-AV: E=Sophos;i="5.60,393,1549954800"; 
   d="scan'208";a="30827556"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 25 Apr 2019 05:36:19 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 25 Apr 2019 05:36:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05Ew9TTkmmmKOWqIqM4i+iqRogO3xdytu+YXeYUWAFU=;
 b=tzywggNrxuyp9FN0Fli5HTCYI3oCkAD7qsoUvFLxf2KJjFWOABWtvk90UUkVhL2LrE53dxnm677p5iJ6bX4URrqxtNvqXaVY62FcKQBEGB2nBvnaJVlqMZeg1HZDAlCYCwOPAiIprhuerZeVQaIa0WHnBkPYDmffT+TaekfU9+8=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1726.namprd11.prod.outlook.com (10.169.237.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 12:36:16 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 12:36:16 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <thierry.reding@gmail.com>,
        <lee.jones@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [RESEND][PATCH v3 2/6] drm: atmel-hlcdc: avoid initializing cfg with
 zero
Thread-Topic: [RESEND][PATCH v3 2/6] drm: atmel-hlcdc: avoid initializing cfg
 with zero
Thread-Index: AQHU+2N5/HBwvZtNc0CjiiQBec/BZw==
Date:   Thu, 25 Apr 2019 12:36:16 +0000
Message-ID: <1556195748-11106-3-git-send-email-claudiu.beznea@microchip.com>
References: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0024.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::34) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95711c9c-5abf-4d96-7679-08d6c97a9c15
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1726;
x-ms-traffictypediagnostic: MWHPR11MB1726:
x-microsoft-antispam-prvs: <MWHPR11MB1726BA9B8FE349C7AAFF13A4873D0@MWHPR11MB1726.namprd11.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39850400004)(346002)(376002)(199004)(189003)(81156014)(7416002)(81166006)(97736004)(2201001)(53936002)(5660300002)(8676002)(2501003)(2906002)(86362001)(50226002)(305945005)(6436002)(68736007)(6486002)(72206003)(107886003)(71190400001)(14454004)(6512007)(8936002)(478600001)(186003)(66066001)(76176011)(26005)(14444005)(256004)(476003)(7736002)(71200400001)(486006)(110136005)(54906003)(6506007)(386003)(6116002)(102836004)(66476007)(66446008)(66946007)(66556008)(36756003)(73956011)(64756008)(11346002)(4326008)(446003)(52116002)(316002)(99286004)(3846002)(2616005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1726;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PFULj3lm9/OoOF9aG9jvURbmEj/u6UIYzjJwJBB2Ph2VEVDNFST5AJ6WC2Ox2TAzgQYV4tG0P4v81WZaKWyhr8z5JNo2ZuCXzDVeA6u5813VaIj1ssZXMZyGTrhxFVvl33s9K/QH5HrwKmd3kpt5J3m7+4r5ATw6EA+O/8jjnSAPL35p6Gruq2/0Qg9lCfQdCX6glTX3oq+bQHxQTkYCxvOTJMo75WVNeTm8lRh39Of9deDCYSOJAj9g0XfnBwSsSvVJ9h7Jclc1WpY9eJegRK/HHFeUpWH14GpOfyMY7dxCHq/GeEAYr+xd42kgvTboU+jwNeWvq9tsNWIB0HN94EqRoIHuI8UN7hAwN6ZmsBSyUBFwjLDJ3hua1DbWbJwwkzbsdyijE+1p5B/G/siALE/nyz3pn83sUB3LIYxjXTc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 95711c9c-5abf-4d96-7679-08d6c97a9c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:36:16.6223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1726
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNClJl
bW92ZSBjZmcgaW5pdGlhbGl6YXRpb24gd2l0aCB6ZXJvIGFuZCByZWFkIHN0YXRlIHdpdGgNCmRy
bV9jcnRjX3N0YXRlX3RvX2F0bWVsX2hsY2RjX2NydGNfc3RhdGUoKSBzbyB0aGF0IGNmZyB0byBi
ZSBpbml0aWFsaXplZA0Kd2l0aCBzdGF0ZSdzIG91dHB1dF9tb2RlLg0KDQpTaWduZWQtb2ZmLWJ5
OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NClJldmlld2Vk
LWJ5OiBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+DQotLS0NCiBkcml2ZXJzL2dwdS9k
cm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jIHwgNiArKy0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMNCmluZGV4IDk1N2U2ZDJmYjAwZi4u
ODFjNTA3NzJkZjA1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0
bWVsX2hsY2RjX2NydGMuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVs
X2hsY2RjX2NydGMuYw0KQEAgLTEzOCw3ICsxMzgsOCBAQCBzdGF0aWMgdm9pZCBhdG1lbF9obGNk
Y19jcnRjX21vZGVfc2V0X25vZmIoc3RydWN0IGRybV9jcnRjICpjKQ0KIA0KIAlyZWdtYXBfdXBk
YXRlX2JpdHMocmVnbWFwLCBBVE1FTF9ITENEQ19DRkcoMCksIG1hc2ssIGNmZyk7DQogDQotCWNm
ZyA9IDA7DQorCXN0YXRlID0gZHJtX2NydGNfc3RhdGVfdG9fYXRtZWxfaGxjZGNfY3J0Y19zdGF0
ZShjLT5zdGF0ZSk7DQorCWNmZyA9IHN0YXRlLT5vdXRwdXRfbW9kZSA8PCA4Ow0KIA0KIAlpZiAo
YWRqLT5mbGFncyAmIERSTV9NT0RFX0ZMQUdfTlZTWU5DKQ0KIAkJY2ZnIHw9IEFUTUVMX0hMQ0RD
X1ZTUE9MOw0KQEAgLTE0Niw5ICsxNDcsNiBAQCBzdGF0aWMgdm9pZCBhdG1lbF9obGNkY19jcnRj
X21vZGVfc2V0X25vZmIoc3RydWN0IGRybV9jcnRjICpjKQ0KIAlpZiAoYWRqLT5mbGFncyAmIERS
TV9NT0RFX0ZMQUdfTkhTWU5DKQ0KIAkJY2ZnIHw9IEFUTUVMX0hMQ0RDX0hTUE9MOw0KIA0KLQlz
dGF0ZSA9IGRybV9jcnRjX3N0YXRlX3RvX2F0bWVsX2hsY2RjX2NydGNfc3RhdGUoYy0+c3RhdGUp
Ow0KLQljZmcgfD0gc3RhdGUtPm91dHB1dF9tb2RlIDw8IDg7DQotDQogCXJlZ21hcF91cGRhdGVf
Yml0cyhyZWdtYXAsIEFUTUVMX0hMQ0RDX0NGRyg1KSwNCiAJCQkgICBBVE1FTF9ITENEQ19IU1BP
TCB8IEFUTUVMX0hMQ0RDX1ZTUE9MIHwNCiAJCQkgICBBVE1FTF9ITENEQ19WU1BETFlTIHwgQVRN
RUxfSExDRENfVlNQRExZRSB8DQotLSANCjIuNy40DQoNCg==
