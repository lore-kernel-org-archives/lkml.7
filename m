Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9765C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B05F240C8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MT+B+ODl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfDYM2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:28:42 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:17366 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfDYM2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:28:40 -0400
X-IronPort-AV: E=Sophos;i="5.60,393,1549954800"; 
   d="scan'208";a="32236321"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Apr 2019 05:28:39 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 25 Apr 2019 05:28:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bm0v2SKOAqLFTnLsoPeCFq1wYIKHNr6xoLZJSPArh+U=;
 b=MT+B+ODlnXDk/lbQ6zAGRrB4x24Hn023rrGkZygtgU3B2Ybo02rPY0cN0IFdxLK0hWYm8hiKWq//Ke2uSlJvWUWMf2F+B7SDwSLDiSx7LDqZMcnRPFZqqh3WC2rKWWXt9uKVztOShbvJHgx2GuIf5FJ5u53EQmRJYjEYeGr5/tM=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1470.namprd11.prod.outlook.com (10.172.53.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Thu, 25 Apr 2019 12:28:38 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 12:28:38 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <thierry.reding@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <Sandeep.Sheriker@microchip.com>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 4/6] drm: atmel-hlcdc: enable sys_clk during initalization.
Thread-Topic: [PATCH v3 4/6] drm: atmel-hlcdc: enable sys_clk during
 initalization.
Thread-Index: AQHU+2JoQq3P3r+WtU+oP4T6IosGBw==
Date:   Thu, 25 Apr 2019 12:28:37 +0000
Message-ID: <1556195285-10687-5-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 8029d127-3f96-4e1c-d62d-08d6c9798abb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1470;
x-ms-traffictypediagnostic: MWHPR11MB1470:
x-microsoft-antispam-prvs: <MWHPR11MB14709C8B794A2779E3D8EBA9873D0@MWHPR11MB1470.namprd11.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(66476007)(7736002)(81156014)(305945005)(66556008)(64756008)(66446008)(8936002)(68736007)(8676002)(73956011)(66946007)(81166006)(5660300002)(6486002)(3846002)(6116002)(6506007)(2501003)(386003)(76176011)(14444005)(2201001)(102836004)(50226002)(99286004)(86362001)(36756003)(52116002)(4326008)(110136005)(54906003)(107886003)(66066001)(186003)(256004)(26005)(71190400001)(71200400001)(53936002)(25786009)(486006)(478600001)(72206003)(476003)(446003)(11346002)(2616005)(2906002)(97736004)(316002)(6436002)(6512007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1470;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YQV0TgLE/FXu0tDRb5CFCdo1Uj3IWS6k3d29BUITjHHK1IMas6pTsmjkWuBGjoxfIIMkkg88J+9bwo3lTvwO6Gm00T0IyFF8A4CKOeTEajKeuTz3adbS4Tn8CZW4jaMZVa3iRbRCtbGmuPmDe8bBzS/FJukhM+KmwanWqLm71qoFeb9beAwh7KlMLAOCzzLjB18PLz6FtH+8L2Ja5LxSmyoa7N0dMO1zUbZSs9yYBYhinOGO2P81XbBFuWdnxxFFHJzi8XsWItho2nwAFAfIOr+aAIkHHU4TmqN5jPMSj9IkXNPB3HnDgcgZG/rr+osx+FCNS8Hdunk5VXknn9vHhFTxaP34x1wJRnMnPjjWdlEAsWG2tiT/P5ElIamS3L1iv8q0WPk0heWS+LWijedNRsP2Sq4+gkDqhD5JNseg0dw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8029d127-3f96-4e1c-d62d-08d6c9798abb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:28:37.9409
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

RnJvbTogU2FuZGVlcCBTaGVyaWtlciBNYWxsaWthcmp1biA8c2FuZGVlcHNoZXJpa2VyLm1hbGxp
a2FyanVuQG1pY3JvY2hpcC5jb20+DQoNCkZvciBTQU05WDYwIFNvQywgc3lzX2NsayBpcyB0aHJv
dWdoIGxjZF9nY2xrIGNsb2NrIHNvdXJjZSBhbmQgdGhpcw0KbmVlZHMgdG8gYmUgZW5hYmxlZCBi
ZWZvcmUgZW5hYmxpbmcgbGNkX2Nsay4NCg0KU2lnbmVkLW9mZi1ieTogU2FuZGVlcCBTaGVyaWtl
ciBNYWxsaWthcmp1biA8c2FuZGVlcHNoZXJpa2VyLm1hbGxpa2FyanVuQG1pY3JvY2hpcC5jb20+
DQpbY2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbTogYWRkIGZpeGVkX2Nsa3NyYyBjaGVja3Nd
DQpTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlw
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19kYy5j
IHwgMTkgKysrKysrKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwt
aGxjZGMvYXRtZWxfaGxjZGNfZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1l
bF9obGNkY19kYy5jDQppbmRleCAwYmUxM2VjZWVkYmEuLjhiZjUxZjg1MzcyMSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19kYy5jDQorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuYw0KQEAgLTYyNSwxMCAr
NjI1LDE4IEBAIHN0YXRpYyBpbnQgYXRtZWxfaGxjZGNfZGNfbG9hZChzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGV2KQ0KIAlkYy0+aGxjZGMgPSBkZXZfZ2V0X2RydmRhdGEoZGV2LT5kZXYtPnBhcmVudCk7
DQogCWRldi0+ZGV2X3ByaXZhdGUgPSBkYzsNCiANCisJaWYgKGRjLT5kZXNjLT5maXhlZF9jbGtz
cmMpIHsNCisJCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShkYy0+aGxjZGMtPnN5c19jbGspOw0K
KwkJaWYgKHJldCkgew0KKwkJCWRldl9lcnIoZGV2LT5kZXYsICJmYWlsZWQgdG8gZW5hYmxlIHN5
c19jbGtcbiIpOw0KKwkJCWdvdG8gZXJyX2Rlc3Ryb3lfd3E7DQorCQl9DQorCX0NCisNCiAJcmV0
ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGRjLT5obGNkYy0+cGVyaXBoX2Nsayk7DQogCWlmIChyZXQp
IHsNCiAJCWRldl9lcnIoZGV2LT5kZXYsICJmYWlsZWQgdG8gZW5hYmxlIHBlcmlwaF9jbGtcbiIp
Ow0KLQkJZ290byBlcnJfZGVzdHJveV93cTsNCisJCWdvdG8gZXJyX3N5c19jbGtfZGlzYWJsZTsN
CiAJfQ0KIA0KIAlwbV9ydW50aW1lX2VuYWJsZShkZXYtPmRldik7DQpAQCAtNjY0LDYgKzY3Miw5
IEBAIHN0YXRpYyBpbnQgYXRtZWxfaGxjZGNfZGNfbG9hZChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2
KQ0KIGVycl9wZXJpcGhfY2xrX2Rpc2FibGU6DQogCXBtX3J1bnRpbWVfZGlzYWJsZShkZXYtPmRl
dik7DQogCWNsa19kaXNhYmxlX3VucHJlcGFyZShkYy0+aGxjZGMtPnBlcmlwaF9jbGspOw0KK2Vy
cl9zeXNfY2xrX2Rpc2FibGU6DQorCWlmIChkYy0+ZGVzYy0+Zml4ZWRfY2xrc3JjKQ0KKwkJY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKGRjLT5obGNkYy0+c3lzX2Nsayk7DQogDQogZXJyX2Rlc3Ryb3lf
d3E6DQogCWRlc3Ryb3lfd29ya3F1ZXVlKGRjLT53cSk7DQpAQCAtNjg4LDYgKzY5OSw4IEBAIHN0
YXRpYyB2b2lkIGF0bWVsX2hsY2RjX2RjX3VubG9hZChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQ0K
IA0KIAlwbV9ydW50aW1lX2Rpc2FibGUoZGV2LT5kZXYpOw0KIAljbGtfZGlzYWJsZV91bnByZXBh
cmUoZGMtPmhsY2RjLT5wZXJpcGhfY2xrKTsNCisJaWYgKGRjLT5kZXNjLT5maXhlZF9jbGtzcmMp
DQorCQljbGtfZGlzYWJsZV91bnByZXBhcmUoZGMtPmhsY2RjLT5zeXNfY2xrKTsNCiAJZGVzdHJv
eV93b3JrcXVldWUoZGMtPndxKTsNCiB9DQogDQpAQCAtODA1LDYgKzgxOCw4IEBAIHN0YXRpYyBp
bnQgYXRtZWxfaGxjZGNfZGNfZHJtX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KIAlyZWdt
YXBfcmVhZChyZWdtYXAsIEFUTUVMX0hMQ0RDX0lNUiwgJmRjLT5zdXNwZW5kLmltcik7DQogCXJl
Z21hcF93cml0ZShyZWdtYXAsIEFUTUVMX0hMQ0RDX0lEUiwgZGMtPnN1c3BlbmQuaW1yKTsNCiAJ
Y2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRjLT5obGNkYy0+cGVyaXBoX2Nsayk7DQorCWlmIChkYy0+
ZGVzYy0+Zml4ZWRfY2xrc3JjKQ0KKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRjLT5obGNkYy0+
c3lzX2Nsayk7DQogDQogCXJldHVybiAwOw0KIH0NCkBAIC04MTQsNiArODI5LDggQEAgc3RhdGlj
IGludCBhdG1lbF9obGNkY19kY19kcm1fcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJc3Ry
dWN0IGRybV9kZXZpY2UgKmRybV9kZXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCiAJc3RydWN0
IGF0bWVsX2hsY2RjX2RjICpkYyA9IGRybV9kZXYtPmRldl9wcml2YXRlOw0KIA0KKwlpZiAoZGMt
PmRlc2MtPmZpeGVkX2Nsa3NyYykNCisJCWNsa19wcmVwYXJlX2VuYWJsZShkYy0+aGxjZGMtPnN5
c19jbGspOw0KIAljbGtfcHJlcGFyZV9lbmFibGUoZGMtPmhsY2RjLT5wZXJpcGhfY2xrKTsNCiAJ
cmVnbWFwX3dyaXRlKGRjLT5obGNkYy0+cmVnbWFwLCBBVE1FTF9ITENEQ19JRVIsIGRjLT5zdXNw
ZW5kLmltcik7DQogDQotLSANCjIuNy40DQoNCg==
