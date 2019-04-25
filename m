Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD6C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F37521BC0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="r9neu+My"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbfDYM2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:28:34 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:27311 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbfDYM2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:28:34 -0400
X-IronPort-AV: E=Sophos;i="5.60,393,1549954800"; 
   d="scan'208";a="29070409"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Apr 2019 05:28:32 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 25 Apr 2019 05:28:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05Ew9TTkmmmKOWqIqM4i+iqRogO3xdytu+YXeYUWAFU=;
 b=r9neu+MyJfXW4IN9kcekH9AuMWBhwjEVpADJsUtkYl77jBIlvH2wj4340wKg8GWzcceynIkIUdDLZNqEZVSvij2NyGzLc8don7awwSURGSd5JpqfnN0SNLMaZ9RZMtvqdNQRNl6dYdNQoTfmvznIgzmwQVVqjCWJnzlVRDBS/hA=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1470.namprd11.prod.outlook.com (10.172.53.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Thu, 25 Apr 2019 12:28:30 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 12:28:30 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <thierry.reding@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 2/6] drm: atmel-hlcdc: avoid initializing cfg with zero
Thread-Topic: [PATCH v3 2/6] drm: atmel-hlcdc: avoid initializing cfg with
 zero
Thread-Index: AQHU+2JjKrQbNA/+GU2BMxZKQlfeYw==
Date:   Thu, 25 Apr 2019 12:28:30 +0000
Message-ID: <1556195285-10687-3-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 5564b5ff-bf1a-4952-cda8-08d6c979861d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1470;
x-ms-traffictypediagnostic: MWHPR11MB1470:
x-microsoft-antispam-prvs: <MWHPR11MB14709984A662BFF9EFEC61EC873D0@MWHPR11MB1470.namprd11.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(66476007)(7736002)(81156014)(305945005)(66556008)(64756008)(66446008)(8936002)(68736007)(8676002)(73956011)(66946007)(81166006)(5660300002)(6486002)(3846002)(6116002)(6506007)(2501003)(386003)(76176011)(14444005)(2201001)(102836004)(50226002)(99286004)(86362001)(36756003)(52116002)(4326008)(110136005)(54906003)(107886003)(66066001)(186003)(256004)(26005)(71190400001)(71200400001)(53936002)(25786009)(486006)(478600001)(72206003)(476003)(446003)(11346002)(2616005)(2906002)(97736004)(316002)(6436002)(6512007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1470;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l1Pru+iHojpDGR9IlD07DrAYzehzVXKNgwa23bzE97ZCQzossdoJss9EzB1KyPdQLQHImoKWuCJlHu1SW01ppxTNc55AtGoHoeKEN1ZpnZ2/ChbcDGafthKjV1HICP1ZIthIlF56FcapnehxwYfZTB+J6toIotSt2m8hEnkNUn2vUf7EtnhsYJ9OTa5NPbJGrj2DdeAeb4pIyXUh9dZMVXuUnM2PsMsvrYehQcC1NJ5ftBKkF32lHOPu/4GxAUTCw5kRuT776zBYx1uTvckA8s99t6iSFBvx1rXGLQiPDn57NV+xRG0l1fNHHBobWb5sF/udQ72X/uejwACDV9MfO0nyDXJJG5XBGzgww5u8TUgkADHiiCI+quWHqzugvZozUj0jXgcRqW4H86OGHEDfO15/sJMerTpe6FwK4Toxzn4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5564b5ff-bf1a-4952-cda8-08d6c979861d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:28:30.1542
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
