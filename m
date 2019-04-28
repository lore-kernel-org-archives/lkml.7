Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A33C4321A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF41206C1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G6mu/xsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfD1D1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 23:27:07 -0400
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:46407
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbfD1D1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 23:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhB3A2JNndJKgMCUoZRHe2FQQQ26UAAz7zxR3MobPtU=;
 b=G6mu/xsjT4unCXeOQ32ptVIE8iTjjVh+McyKca3KXkqkRMQy5SD6eOLtZT/4KzDB0dFm4+2k0IGI/KtSl8aJOzIi5s6uKnJIaorExzI0txTaUY+9TRSSN0JBWVOiNv72houxHlUbG2ECOklAI2Yvks4163yciRH25XO6U0biy6Y=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3897.eurprd04.prod.outlook.com (52.134.73.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Sun, 28 Apr 2019 03:27:00 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.015; Sun, 28 Apr 2019
 03:27:00 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Topic: [PATCH V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Index: AQHU/XI9f9LbYLWILEa/3i56q8YtDQ==
Date:   Sun, 28 Apr 2019 03:27:00 +0000
Message-ID: <1556421727-7401-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e03741d5-612e-4dc8-6d8f-08d6cb896048
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3897;
x-ms-traffictypediagnostic: DB3PR0402MB3897:
x-microsoft-antispam-prvs: <DB3PR0402MB38978FBB11BBA76EEDD60F3EF5380@DB3PR0402MB3897.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(256004)(71190400001)(71200400001)(97736004)(6116002)(186003)(66066001)(86362001)(2201001)(476003)(2616005)(8936002)(36756003)(486006)(81156014)(81166006)(25786009)(53936002)(50226002)(3846002)(2906002)(2501003)(386003)(6506007)(68736007)(4326008)(102836004)(64756008)(52116002)(66946007)(66476007)(66556008)(8676002)(66446008)(6486002)(6436002)(7416002)(14454004)(73956011)(7736002)(99286004)(478600001)(316002)(110136005)(305945005)(26005)(6512007)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3897;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UAMloTgBjtNW0EnPP2Xcg/ybXgFsspQdeZWoE8W67RA05O4nWLaC4feQo9fsAFfTGpxZxf0cJ3bbiynHMW7OR7wWrBvQiQFlyOw5SGtFeJ86EjyP/85Jm3pPtNJrM4476Xcc3n3cEaYEi3XUwiic9RrL2+KGmznialgwvMEGGXi2d/hK/DPiYcMGG6QnboeLbNsz5iiRSwSGPnIEDnx/tFkzN178scdNqiCQPafiszxWt60ytP1ZQuJJG7LEJgSqDHmpx04zEtqVJ+qMKK6kIzTvSniDLlkSQQ23b5z59f5HIezmzLzsBRe7HOiRPFe9f6Wo+eNr0C5CMXNBuxrILDMkkTRgnhYmruEgfSUlNpuXrsdHqm3VHpTkKrseUN3D65Js2BO1vJnvqZPiSXWjn2w8E9xeqOl7iqKFHrKtgXA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03741d5-612e-4dc8-6d8f-08d6cb896048
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 03:27:00.8513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWCBzeXN0ZW0gY29udHJvbGxlciB3YXRjaGRvZyBoYXMgcHJldGltZW91dCBmdW5jdGlvbiB3
aGljaA0KZGVwZW5kcyBvbiBpLk1YIFNDVSBkcml2ZXIsIHNvIHdhdGNoZG9nIERUIG5vZGUgbmVl
ZHMgdG8gYmUNCnN1Ym5vZGUgb2YgU0NVLCB0aGlzIHBhdGNoIGFkZHMgaS5NWCBzeXN0ZW0gY29u
dHJvbGxlciB3YXRjaGRvZw0KYmluZGluZyB0byBTQ1UgYmluZGluZyBkb2MuDQoNClNpZ25lZC1v
ZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQpOZXcgcGF0Y2gu
DQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0
ICAgICAgICAgfCAxNSArKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KaW5kZXggNWQ3ZGJhYi4uMWI1NjU1NyAx
MDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNj
YWxlL2ZzbCxzY3UudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KQEAgLTEzMyw2ICsxMzMsMTYgQEAgUlRDIGJpbmRp
bmdzIGJhc2VkIG9uIFNDVSBNZXNzYWdlIFByb3RvY29sDQogUmVxdWlyZWQgcHJvcGVydGllczoN
CiAtIGNvbXBhdGlibGU6IHNob3VsZCBiZSAiZnNsLGlteDhxeHAtc2MtcnRjIjsNCiANCitXYXRj
aGRvZyBiaW5kaW5ncyBiYXNlZCBvbiBTQ1UgTWVzc2FnZSBQcm90b2NvbA0KKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KKw0KK1Jl
cXVpcmVkIHByb3BlcnRpZXM6DQorLSBjb21wYXRpYmxlOiBzaG91bGQgYmU6DQorICAgICAgICAg
ICAgICAiZnNsLGlteDhxeHAtc2Mtd2R0Ig0KKyAgICAgICAgICAgICAgZm9sbG93ZWQgYnkgImZz
bCxpbXgtc2Mtd2R0IjsNCitPcHRpb25hbCBwcm9wZXJ0aWVzOg0KKy0gdGltZW91dC1zZWM6IGNv
bnRhaW5zIHRoZSB3YXRjaGRvZyB0aW1lb3V0IGluIHNlY29uZHMuDQorDQogRXhhbXBsZSAoaW14
OHF4cCk6DQogLS0tLS0tLS0tLS0tLQ0KIGFsaWFzZXMgew0KQEAgLTE4NSw2ICsxOTUsMTEgQEAg
ZmlybXdhcmUgew0KIAkJcnRjOiBydGMgew0KIAkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAt
c2MtcnRjIjsNCiAJCX07DQorDQorCQl3YXRjaGRvZyB7DQorCQkJY29tcGF0aWJsZSA9ICJmc2ws
aW14OHF4cC1zYy13ZHQiLCAiZnNsLGlteC1zYy13ZHQiOw0KKwkJCXRpbWVvdXQtc2VjID0gPDYw
PjsNCisJCX07DQogCX07DQogfTsNCiANCi0tIA0KMi43LjQNCg0K
