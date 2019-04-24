Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830C3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4EB20656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="dSdMKSL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfDXJSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:18:03 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:45140 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfDXJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:18:02 -0400
X-IronPort-AV: E=Sophos;i="5.60,389,1549954800"; 
   d="scan'208";a="30557777"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Apr 2019 02:18:01 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 24 Apr 2019 02:18:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHiZ4ykzoYg0qah29A8OpwZ/Q6UJtFtdWTuO3P9vkKM=;
 b=dSdMKSL7m9ODoY+YvL2kLA3QV/ojF3b1Y6Dfj+I8IYbd7aABpmal49n4Gpnv4rmkFd8KyuJjAlfVJabfUWd71vIe6lfip0AwKe2fXEV90GYRlQSqPWg2exDCiv47BF8MfMKTBvUaj5S6HNh2PROmsM5q2dMxOEWXQk2yHybrq0I=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1776.namprd11.prod.outlook.com (10.175.53.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 09:17:59 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 09:17:59 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH] spi: atmel-quadspi: fix crash while suspending
Thread-Topic: [PATCH] spi: atmel-quadspi: fix crash while suspending
Thread-Index: AQHU+n6cb7ejKkN0g0+RIq8NlPMpTQ==
Date:   Wed, 24 Apr 2019 09:17:59 +0000
Message-ID: <1556097463-29672-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:803:64::25) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a656f66-bf3b-45df-fa9d-08d6c895be56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1776;
x-ms-traffictypediagnostic: MWHPR11MB1776:
x-microsoft-antispam-prvs: <MWHPR11MB1776D6B1A9DE3C9D5B8A1EB4873C0@MWHPR11MB1776.namprd11.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(396003)(346002)(199004)(189003)(186003)(102836004)(66446008)(2906002)(68736007)(14454004)(8676002)(2501003)(73956011)(53936002)(66476007)(66946007)(64756008)(81166006)(81156014)(386003)(6506007)(6436002)(8936002)(316002)(7736002)(50226002)(25786009)(305945005)(86362001)(3846002)(6116002)(71190400001)(54906003)(36756003)(97736004)(476003)(2616005)(66066001)(107886003)(486006)(66556008)(5660300002)(110136005)(99286004)(4326008)(71200400001)(26005)(478600001)(72206003)(52116002)(6636002)(6486002)(6512007)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1776;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hYN4QanHfs0J/Yi9gCcerjcqoK41L/fhw8pA3sYx2trp772fjVRNZsptYB0C1AiWuP6FnqfmacSWAhcfM30Whw2/vG8lHIhvki2e5mKDLD99hKnbF0cl2FusunFsooHLs/Rgv+s6xMBvzusDSxMIqtJtmNDxys1eniGr1vjZbK9eloAUIa2TIfhV8ZHar3FeplrqpfIbbrx118ej9P5ahh/yPRJZBWHFyzFp7OYyA1d+KR37/8oEUh8m7otgm2BqSBERGbIW3wJyFiDxPSWEVaB/hbORUWBzCmr6luzGQ9Fa8qwUrtFC2jRLpwud8phulog/D10/jXoBH/VozOvx4Q0/RUQeDerBwUJoAe/Q+2nPjWoGkgpRYrHX2ZdjR2sqKvo+kTO7gaHFcRJqPy0Zh8K4b52fWkK8QMIFoKWkI9g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a656f66-bf3b-45df-fa9d-08d6c895be56
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 09:17:59.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1776
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCmF0
bWVsX3FzcGkgb2JqZWN0cyBhcmUga2VwdCBpbiBzcGlfY29udHJvbGxlciBvYmplY3RzLCBzbywg
Zmlyc3QgZ2V0DQpwb2ludGVyIHRvIHNwaV9jb250cm9sbGVyIG9iamVjdCBhbmQgdGhlbiBnZXQg
YXRtZWxfcXNwaSBvYmplY3QgZnJvbQ0Kc3BpX2NvbnRyb2xsZXIgb2JqZWN0Lg0KDQpGaXhlczog
MmQzMGFjNWVkNjMzICgibXRkOiBzcGktbm9yOiBhdG1lbC1xdWFkc3BpOiBVc2Ugc3BpLW1lbSBp
bnRlcmZhY2UgZm9yIGF0bWVsLXF1YWRzcGkgZHJpdmVyIikNClNpZ25lZC1vZmYtYnk6IENsYXVk
aXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KLS0tDQogZHJpdmVycy9z
cGkvYXRtZWwtcXVhZHNwaS5jIHwgNiArKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvYXRtZWwt
cXVhZHNwaS5jIGIvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQppbmRleCBlNTQxMDk3NTlk
MzQuLjlmMjRkNWYwYjQzMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGku
Yw0KKysrIGIvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQpAQCAtNTcwLDcgKzU3MCw4IEBA
IHN0YXRpYyBpbnQgYXRtZWxfcXNwaV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCiANCiBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGF0bWVsX3FzcGlfc3VzcGVuZChzdHJ1
Y3QgZGV2aWNlICpkZXYpDQogew0KLQlzdHJ1Y3QgYXRtZWxfcXNwaSAqYXEgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCisJc3RydWN0IHNwaV9jb250cm9sbGVyICpjdHJsID0gZGV2X2dldF9kcnZk
YXRhKGRldik7DQorCXN0cnVjdCBhdG1lbF9xc3BpICphcSA9IHNwaV9jb250cm9sbGVyX2dldF9k
ZXZkYXRhKGN0cmwpOw0KIA0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUoYXEtPnFzcGljayk7DQog
CWNsa19kaXNhYmxlX3VucHJlcGFyZShhcS0+cGNsayk7DQpAQCAtNTgwLDcgKzU4MSw4IEBAIHN0
YXRpYyBpbnQgX19tYXliZV91bnVzZWQgYXRtZWxfcXNwaV9zdXNwZW5kKHN0cnVjdCBkZXZpY2Ug
KmRldikNCiANCiBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGF0bWVsX3FzcGlfcmVzdW1lKHN0
cnVjdCBkZXZpY2UgKmRldikNCiB7DQotCXN0cnVjdCBhdG1lbF9xc3BpICphcSA9IGRldl9nZXRf
ZHJ2ZGF0YShkZXYpOw0KKwlzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0cmwgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCisJc3RydWN0IGF0bWVsX3FzcGkgKmFxID0gc3BpX2NvbnRyb2xsZXJfZ2V0
X2RldmRhdGEoY3RybCk7DQogDQogCWNsa19wcmVwYXJlX2VuYWJsZShhcS0+cGNsayk7DQogCWNs
a19wcmVwYXJlX2VuYWJsZShhcS0+cXNwaWNrKTsNCi0tIA0KMi43LjQNCg0K
