Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEEDC282E9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0458206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="0yT034Vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbfDYMgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:36:44 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:27617 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfDYMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:36:35 -0400
X-IronPort-AV: E=Sophos;i="5.60,393,1549954800"; 
   d="scan'208";a="29070903"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Apr 2019 05:36:35 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 25 Apr 2019 05:36:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bm0v2SKOAqLFTnLsoPeCFq1wYIKHNr6xoLZJSPArh+U=;
 b=0yT034VgPUCepOkAJr7E/aiOwXPcNTgJhcsze3wyRQTdLDQwQ1sfUhV8DupKxhiVW1GOWYoyBF/lOYlZ8GT/prSLqNJMUGrupKwtMR4GDbkxKGA/LI+iUIf5BqrjdmXrHbYNkV1kC91DsahfWH16NRi/jAoD/TAUcm7ZdQaF4dg=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1726.namprd11.prod.outlook.com (10.169.237.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 12:36:31 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 12:36:31 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <thierry.reding@gmail.com>,
        <lee.jones@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <Sandeep.Sheriker@microchip.com>, <Claudiu.Beznea@microchip.com>
Subject: [RESEND][PATCH v3 4/6] drm: atmel-hlcdc: enable sys_clk during
 initalization.
Thread-Topic: [RESEND][PATCH v3 4/6] drm: atmel-hlcdc: enable sys_clk during
 initalization.
Thread-Index: AQHU+2OCAotEdimhnESxLYiP7v88dg==
Date:   Thu, 25 Apr 2019 12:36:30 +0000
Message-ID: <1556195748-11106-5-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 8f8679e8-5b40-44b0-7eca-08d6c97aa4ab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1726;
x-ms-traffictypediagnostic: MWHPR11MB1726:
x-microsoft-antispam-prvs: <MWHPR11MB172613185C24D3E3B615B9DE873D0@MWHPR11MB1726.namprd11.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39850400004)(346002)(376002)(199004)(189003)(81156014)(7416002)(81166006)(97736004)(2201001)(53936002)(5660300002)(8676002)(2501003)(2906002)(86362001)(50226002)(305945005)(6436002)(68736007)(6486002)(72206003)(107886003)(71190400001)(14454004)(6512007)(8936002)(478600001)(186003)(66066001)(76176011)(26005)(14444005)(256004)(476003)(7736002)(71200400001)(486006)(110136005)(54906003)(6506007)(386003)(6116002)(102836004)(66476007)(66446008)(66946007)(66556008)(36756003)(73956011)(64756008)(11346002)(4326008)(446003)(52116002)(316002)(99286004)(3846002)(2616005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1726;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zw3MQrkSrUJnt8aCxgxcVUX11f0bE6E4hcP+Fso8a8WmUEOei6igrRmRLgvqFp2H3OzZBXmku90wERq3EWKoHtcKYdp3R/lbIkVpw+Fq0KxfRTV55X2d8EUyqfmfNuzZTmWhpWQsi5zpBEQjzfmdJpcMgefRRZ+Il8htgJrbIEayFjFohgHA18kj75gYPd8SXJKL5lYUsk5jDKRdVj+qCSXnAAA93eFe7sP2DpPMXXo76VTh2lj4A9S1F8rXT0zNk0Nj2eHG9Y/dEe+NOxMRYS8KEGs0LPXYUvyXSDq66qeqnjFIzOZZUhFV7cw+WT9eGlibEm5SL4GbLYHv3JQ+Ts6X4Li83wddUf/Sl/NkEQ5enkTAZfMx/lr3BSo0Ma1FRRCPd3+bDGP2kxZWueK8c7kzfpq2L/WcWNa/CGOa3wQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8679e8-5b40-44b0-7eca-08d6c97aa4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:36:31.0483
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
