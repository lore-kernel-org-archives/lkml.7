Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581C8C10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C81B20870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xtmrdRba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfDPDWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:22:47 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:6080
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfDPDWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zhZUK8a7EHp1l/t3UQPLIdj9NbNdeZFY/KwdVuyddk=;
 b=xtmrdRbacMmCuKUOdLh4rriyxqtQkvrxfP0n3BuU5lFKS92Xhqo/7C9ruK60LglfmqJqOlS8dBgiZDW2Jj+wWgQG2N5qNYLm6PjTif11xZo17yn8W8iUCtAn/CZsF+WJ9OfyotE7VAW9CzMYTQQV1UCIwSF470hPVXtmSP3h7nA=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3895.eurprd04.prod.outlook.com (52.133.29.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Tue, 16 Apr 2019 03:22:41 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c854:fc94:f9ed:2ca2]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c854:fc94:f9ed:2ca2%6]) with mapi id 15.20.1792.020; Tue, 16 Apr 2019
 03:22:41 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V12 5/5] arm64: dts: imx: add i.MX8QXP thermal support
Thread-Topic: [PATCH V12 5/5] arm64: dts: imx: add i.MX8QXP thermal support
Thread-Index: AQHU9AOm/CUJEiXv10OrLxJ5rIIsIg==
Date:   Tue, 16 Apr 2019 03:22:41 +0000
Message-ID: <1555384609-7030-5-git-send-email-Anson.Huang@nxp.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98125c35-a565-459b-544b-08d6c21ac8a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3895;
x-ms-traffictypediagnostic: AM6PR0402MB3895:
x-microsoft-antispam-prvs: <AM6PR0402MB389579DAB3B4D775E42605ABF5240@AM6PR0402MB3895.eurprd04.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(6512007)(106356001)(105586002)(53936002)(2501003)(36756003)(6116002)(3846002)(66066001)(68736007)(486006)(110136005)(316002)(5660300002)(11346002)(446003)(476003)(2616005)(97736004)(71190400001)(71200400001)(14444005)(81166006)(99286004)(8936002)(81156014)(8676002)(50226002)(52116002)(102836004)(256004)(14454004)(478600001)(6506007)(386003)(26005)(7736002)(4326008)(76176011)(86362001)(2906002)(7416002)(186003)(2201001)(25786009)(6486002)(6436002)(305945005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3895;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /yGmAIfk+pGHhmS34AO8FEl2d1JdetgPHF8d/uxeuoxPyOVapgInzI+Or+6ZP9bZWgDMbJi5KA8B+xyl2J8a6tcQMH9W88kLXkjo2dLF7Bk1n6t2uZFcJID5pQ5gBV92c/CStHxAGKWxKCiNUuL2dftNP1tZ0bVHeCS9GpeRkAk6R5DKTtk5DkK5xiCp0GSowOSRd3bm9n2LoYaX2U5zmr43YTaeS5qxiwIPqvCEW0lbre1ORzksINqQDiOczCftA+hanaWaMCS554PUcjrBxeCWCt66mwKA76EeN1D8i/S4cqEjFigj6A5VWZMfnIbK9eoAGR3nU1ZRt+MQV+mT547fgJ69dUBW3JYcC3QdLpmnycVjQh9NnsqpjDeFA/la9t0gc9sx5is5Jg20d222A03k52FwMBIiSo1eCklF44c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98125c35-a565-459b-544b-08d6c21ac8a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 03:22:41.3185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGkuTVg4UVhQIENQVSB0aGVybWFsIHpvbmUgc3VwcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTog
QW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQotLS0NCkNoYW5nZXMgc2luY2UgVjEx
Og0KCS0gYWRkIGNvb2xpbmcgZGV2aWNlIGZvciBhbGwgc2Vjb25kYXJ5IENQVXMuDQotLS0NCiBh
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kgfCAzNyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKQ0K
DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNp
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQppbmRleCAwNjgz
ZWUyLi41ZWVhZGRjIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OHF4cC5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhw
LmR0c2kNCkBAIC0xMCw2ICsxMCw3IEBADQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bp
by5oPg0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2lj
Lmg+DQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3BpbmN0cmwvcGFkcy1pbXg4cXhwLmg+DQorI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL3RoZXJtYWwvdGhlcm1hbC5oPg0KIA0KIC8gew0KIAlpbnRlcnJ1
cHQtcGFyZW50ID0gPCZnaWM+Ow0KQEAgLTE0OSw2ICsxNTAsMTEgQEANCiAJCXJ0YzogcnRjIHsN
CiAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjLXJ0YyI7DQogCQl9Ow0KKw0KKwkJdHNl
bnM6IHRoZXJtYWwtc2Vuc29yIHsNCisJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjLXRo
ZXJtYWwiLCAiZnNsLGlteC1zYy10aGVybWFsIjsNCisJCQkjdGhlcm1hbC1zZW5zb3ItY2VsbHMg
PSA8MT47DQorCQl9Ow0KIAl9Ow0KIA0KIAl0aW1lciB7DQpAQCAtNTIyLDQgKzUyOCwzNSBAQA0K
IAkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zYy13ZHQiLCAiZnNsLGlteC1zYy13ZHQiOw0K
IAkJdGltZW91dC1zZWMgPSA8NjA+Ow0KIAl9Ow0KKw0KKwl0aGVybWFsX3pvbmVzOiB0aGVybWFs
LXpvbmVzIHsNCisJCWNwdS10aGVybWFsMCB7DQorCQkJcG9sbGluZy1kZWxheS1wYXNzaXZlID0g
PDI1MD47DQorCQkJcG9sbGluZy1kZWxheSA9IDwyMDAwPjsNCisJCQl0aGVybWFsLXNlbnNvcnMg
PSA8JnRzZW5zIElNWF9TQ19SX1NZU1RFTT47DQorCQkJdHJpcHMgew0KKwkJCQljcHVfYWxlcnQw
OiB0cmlwMCB7DQorCQkJCQl0ZW1wZXJhdHVyZSA9IDwxMDcwMDA+Ow0KKwkJCQkJaHlzdGVyZXNp
cyA9IDwyMDAwPjsNCisJCQkJCXR5cGUgPSAicGFzc2l2ZSI7DQorCQkJCX07DQorCQkJCWNwdV9j
cml0MDogdHJpcDEgew0KKwkJCQkJdGVtcGVyYXR1cmUgPSA8MTI3MDAwPjsNCisJCQkJCWh5c3Rl
cmVzaXMgPSA8MjAwMD47DQorCQkJCQl0eXBlID0gImNyaXRpY2FsIjsNCisJCQkJfTsNCisJCQl9
Ow0KKwkJCWNvb2xpbmctbWFwcyB7DQorCQkJCW1hcDAgew0KKwkJCQkJdHJpcCA9IDwmY3B1X2Fs
ZXJ0MD47DQorCQkJCQljb29saW5nLWRldmljZSA9DQorCQkJCQkJPCZBMzVfMCBUSEVSTUFMX05P
X0xJTUlUIFRIRVJNQUxfTk9fTElNSVQ+LA0KKwkJCQkJCTwmQTM1XzEgVEhFUk1BTF9OT19MSU1J
VCBUSEVSTUFMX05PX0xJTUlUPiwNCisJCQkJCQk8JkEzNV8yIFRIRVJNQUxfTk9fTElNSVQgVEhF
Uk1BTF9OT19MSU1JVD4sDQorCQkJCQkJPCZBMzVfMyBUSEVSTUFMX05PX0xJTUlUIFRIRVJNQUxf
Tk9fTElNSVQ+Ow0KKw0KKwkJCQl9Ow0KKwkJCX07DQorCQl9Ow0KKwl9Ow0KIH07DQotLSANCjIu
Ny40DQoNCg==
