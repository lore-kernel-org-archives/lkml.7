Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50E5C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 02:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594AA20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 02:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YGq/XAur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfEOCmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 22:42:11 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:39301
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbfEOCmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 22:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rby7MnOd1YCRi1c/3G/Ek4KrtCgUtv7iv7ffvbcXiW0=;
 b=YGq/XAurqMXXXWQYvcHyHqrN6X/igCELyiPQH6CVt+XsLMdk492daGYxINicQj3J0J6NezUB0SwivaM1Xf9Q52swlxVW2HNp5BvjFb6GI5jP2VapaXYRHUL8h+wl2OIXmjLpZu3QcAqVSFFoL4C3TmkI4CYAF6IcU6vTeMHatf4=
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com (20.176.215.158) by
 AM0PR04MB4114.eurprd04.prod.outlook.com (52.134.94.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Wed, 15 May 2019 02:42:08 +0000
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be]) by AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be%7]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 02:42:08 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
CC:     Leo Li <leoyang.li@nxp.com>, Wen He <wen.he_1@nxp.com>
Subject: [v1] drm/arm/mali-dp: Disable checking for required pixel clock rate
Thread-Topic: [v1] drm/arm/mali-dp: Disable checking for required pixel clock
 rate
Thread-Index: AQHVCsfKc9H8v6XkZkyzoxWRKfwkRQ==
Date:   Wed, 15 May 2019 02:42:08 +0000
Message-ID: <20190515024348.43642-1-wen.he_1@nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::17) To AM0PR04MB4865.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9cf012a-03bf-4b0e-d9a0-08d6d8deec30
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4114;
x-ms-traffictypediagnostic: AM0PR04MB4114:
x-microsoft-antispam-prvs: <AM0PR04MB41148BE853C40A77C6521316E2090@AM0PR04MB4114.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(366004)(376002)(189003)(199004)(81156014)(52116002)(6436002)(81166006)(25786009)(2906002)(8676002)(99286004)(50226002)(66946007)(476003)(2616005)(68736007)(8936002)(6486002)(486006)(256004)(53936002)(2501003)(73956011)(66066001)(66446008)(66556008)(66476007)(102836004)(64756008)(186003)(7736002)(305945005)(4744005)(386003)(6506007)(26005)(3846002)(1076003)(6512007)(14454004)(36756003)(5660300002)(86362001)(6116002)(71190400001)(71200400001)(2201001)(316002)(4326008)(54906003)(110136005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4114;H:AM0PR04MB4865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SoS3f2HTwRQKSdJn6pZLERaCt1SU9qX1rIP/IvAmU/sU5AxJZcRuwOL4fRZExdYc+5HRbYLXsUz8wl9GKPU1E6i4U1hZDRZeKoBDzZClmDaoKlbyXL7CITHm32K+9BudJTc6V0YnS1HIMP+RxfFmVmLAsXMramr0tIEZ1tAIsumt4EtjV1n1Q4uwuFBiWIdGLqUxafgdLmg81AtItvd/u0hudEWpwM+NL4mWz553JidkVlGPZVgcuqKN8Jqf3EqIMPPPgNseq22fksBsHqI5qyo31K6+HEc+/P1BFnhx7JpK+DdE6hrkU983G4Hb5i8x5p+sWE4E0+q+dgvcSGT6/ZlPi2RK6EfDTuTveDfNcVSEFtdAQsvzoaJJviThuLI5HX6RtIRSCR86ooU02DzESJlVNbhZvE3Qce5Q2kP8Nco=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cf012a-03bf-4b0e-d9a0-08d6d8deec30
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 02:42:08.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGlzYWJsZSBjaGVja2luZyBmb3IgcmVxdWlyZWQgcGl4ZWwgY2xvY2sgcmF0ZSBpZiBBUkNIX0xB
WUVSU0NQQUUNCmlzIGVuYWJsZS4NCg0KU2lnbmVkLW9mZi1ieTogQWxpc29uIFdhbmcgPGFsaXNv
bi53YW5nQG54cC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBXZW4gSGUgPHdlbi5oZV8xQG54cC5jb20+
DQotLS0NCmNoYW5nZSBpbiBkZXNjcmlwdGlvbjoNCgktIFRoaXMgY2hlY2sgdGhhdCBvbmx5IHN1
cHBvcnRlZCBvbmUgcGl4ZWwgY2xvY2sgcmVxdWlyZWQgY2xvY2sgcmF0ZQ0KCWNvbXBhcmUgd2l0
aCBkdHMgbm9kZSB2YWx1ZS4gYnV0IHdlIGhhdmUgc3VwcG9ydHMgNCBwaXhlbCBjbG9jaw0KCWZv
ciBsczEwMjhhIGJvYXJkLg0KIGRyaXZlcnMvZ3B1L2RybS9hcm0vbWFsaWRwX2NydGMuYyB8IDIg
KysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL21hbGlk
cF9jcnRjLmMNCmluZGV4IDU2YWFkMjg4NjY2ZS4uYmI3OTIyM2Q5OTgxIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FybS9tYWxpZHBfY3J0Yy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YXJtL21hbGlkcF9jcnRjLmMNCkBAIC0zNiwxMSArMzYsMTMgQEAgc3RhdGljIGVudW0gZHJtX21v
ZGVfc3RhdHVzIG1hbGlkcF9jcnRjX21vZGVfdmFsaWQoc3RydWN0IGRybV9jcnRjICpjcnRjLA0K
IA0KIAlpZiAocmVxX3JhdGUpIHsNCiAJCXJhdGUgPSBjbGtfcm91bmRfcmF0ZShod2Rldi0+cHhs
Y2xrLCByZXFfcmF0ZSk7DQorI2lmbmRlZiBDT05GSUdfQVJDSF9MQVlFUlNDQVBFDQogCQlpZiAo
cmF0ZSAhPSByZXFfcmF0ZSkgew0KIAkJCURSTV9ERUJVR19EUklWRVIoInB4bGNsayBkb2Vzbid0
IHN1cHBvcnQgJWxkIEh6XG4iLA0KIAkJCQkJIHJlcV9yYXRlKTsNCiAJCQlyZXR1cm4gTU9ERV9O
T0NMT0NLOw0KIAkJfQ0KKyNlbmRpZg0KIAl9DQogDQogCXJldHVybiBNT0RFX09LOw0KLS0gDQoy
LjE3LjENCg0K
