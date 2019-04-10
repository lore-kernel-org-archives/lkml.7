Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A63FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0B42133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PEu4VEiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfDJGB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:01:28 -0400
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:18069
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbfDJGB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfCIZxKg8bFkpKQ9sNoe01CrH4DzyeiobVutX3JYFVU=;
 b=PEu4VEiW1PmhA0xflliW0CBAHpBUSM2KR85lcIjGcqGGC5icwlM7lAwP5aqLwy85aADBVRcjUo/btvvFmtrj3T9i10VWUNG1FUEW/mYBkP0FB1y87r4OZZfKyDfbCty/BphUhm3p+Tdd3VjMxcMJMkRv8HblUPUZ6b+FVPqskdc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3705.eurprd04.prod.outlook.com (52.134.70.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Wed, 10 Apr 2019 06:01:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 06:01:22 +0000
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
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Gross <andy.gross@linaro.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V11 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V11 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHU72LSVW04XBliYEW8yphj5Jq4XA==
Date:   Wed, 10 Apr 2019 06:01:22 +0000
Message-ID: <1554875779-19727-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67bc99f6-fa7a-4269-defe-08d6bd79f52b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3705;
x-ms-traffictypediagnostic: DB3PR0402MB3705:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB370521B95F4A9BF421D95A44F52E0@DB3PR0402MB3705.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(396003)(376002)(199004)(189003)(6116002)(4326008)(3846002)(6512007)(256004)(99286004)(476003)(36756003)(53936002)(50226002)(2616005)(386003)(316002)(5660300002)(52116002)(6506007)(71200400001)(102836004)(478600001)(186003)(25786009)(2201001)(110136005)(305945005)(71190400001)(86362001)(2501003)(486006)(14454004)(7416002)(6436002)(7736002)(105586002)(6486002)(2906002)(81156014)(8676002)(66066001)(81166006)(106356001)(97736004)(68736007)(26005)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3705;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C441z2sElrhCK8foJFpgmj98gEBuqL1uRbJc1PPDp/IpmNbg8IQmxxVje2vYzPz+4hO3jzWJZi0jLHkJDxI+KBuiMBC6oALotj+HVkqZVG1eMHaB+nYFqH86vFES5VndTBMHtjiwiFdxYJljGSyZi6Uq4QEj0bTCujPgu4FIaRDiH3rVtkXTfuSKTSt6noIjZjgHRqzdAs10M7kmSfnbH0qxJdSw7shju6zgMUv54vdmgHxZOdOCXZpCECer55XkkUTtwQrJKeLL1Gw6mAk2YowwsZvTpHgw5N8MJHs0kW/f5Ok6fPA7ipB5YwoHfyRPHsF+fdA3j4GG3Yd/wRwdWGs5/CaggvqNnoULfC1/iPNTgaQeFvQjWKkP3ZIX3ulI4tdYwvRNqhAhBhPgvDLQJeV4WtFLJGDM307N/Zhk7ws=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bc99f6-fa7a-4269-defe-08d6bd79f52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 06:01:22.5512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TlhQIGkuTVg4UVhQIGlzIGFuIEFSTXY4IFNvQyB3aXRoIGEgQ29ydGV4LU00IGNvcmUgaW5zaWRl
IGFzDQpzeXN0ZW0gY29udHJvbGxlciwgdGhlIHN5c3RlbSBjb250cm9sbGVyIGlzIGluIGNoYXJn
ZSBvZiBzeXN0ZW0NCnBvd2VyLCBjbG9jayBhbmQgdGhlcm1hbCBzZW5zb3JzIGV0Yy4gbWFuYWdl
bWVudCwgTGludXgga2VybmVsDQpoYXMgdG8gY29tbXVuaWNhdGUgd2l0aCBzeXN0ZW0gY29udHJv
bGxlciB2aWEgTVUgKG1lc3NhZ2UgdW5pdCkNCklQQyB0byBnZXQgdGVtcGVyYXR1cmUgZnJvbSB0
aGVybWFsIHNlbnNvcnMsIHRoaXMgcGF0Y2ggYWRkcw0KYmluZGluZyBkb2MgZm9yIGkuTVggc3lz
dGVtIGNvbnRyb2xsZXIgdGhlcm1hbCBkcml2ZXIuDQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1
YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQpDaGFuZ2VzIHNpbmNlIFYxMDoNCgktIHJl
bW92ZSBwcm9wZXJ0eSAiaW14LHNlbnNvci1yZXNvdXJjZS1pZCIuDQotLQ0KIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQgICAgICAgIHwgMTYgKysrKysr
KysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2ws
c2N1LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxl
L2ZzbCxzY3UudHh0DQppbmRleCA1ZDdkYmFiLi5mNGZiNmQ1IDEwMDY0NA0KLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCisr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxz
Y3UudHh0DQpAQCAtMTMzLDYgKzEzMywxNyBAQCBSVEMgYmluZGluZ3MgYmFzZWQgb24gU0NVIE1l
c3NhZ2UgUHJvdG9jb2wNCiBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIC0gY29tcGF0aWJsZTogc2hv
dWxkIGJlICJmc2wsaW14OHF4cC1zYy1ydGMiOw0KIA0KK1RoZXJtYWwgYmluZGluZ3MgYmFzZWQg
b24gU0NVIE1lc3NhZ2UgUHJvdG9jb2wNCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCisNCitSZXF1aXJlZCBwcm9wZXJ0aWVzOg0K
Ky0gY29tcGF0aWJsZToJCQlTaG91bGQgYmUgOg0KKwkJCQkgICJmc2wsaW14OHF4cC1zYy10aGVy
bWFsIg0KKwkJCQlmb2xsb3dlZCBieSAiZnNsLGlteC1zYy10aGVybWFsIjsNCisNCistICN0aGVy
bWFsLXNlbnNvci1jZWxsczoJU2VlIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90
aGVybWFsL3RoZXJtYWwudHh0DQorCQkJCWZvciBhIGRlc2NyaXB0aW9uLg0KKw0KIEV4YW1wbGUg
KGlteDhxeHApOg0KIC0tLS0tLS0tLS0tLS0NCiBhbGlhc2VzIHsNCkBAIC0xODUsNiArMTk2LDEx
IEBAIGZpcm13YXJlIHsNCiAJCXJ0YzogcnRjIHsNCiAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4
cXhwLXNjLXJ0YyI7DQogCQl9Ow0KKw0KKwkJdHNlbnM6IHRoZXJtYWwtc2Vuc29yIHsNCisJCQlj
b21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjLXRoZXJtYWwiLCAiZnNsLGlteC1zYy10aGVybWFs
IjsNCisJCQkjdGhlcm1hbC1zZW5zb3ItY2VsbHMgPSA8MT47DQorCQl9Ow0KIAl9Ow0KIH07DQog
DQotLSANCjIuNy40DQoNCg==
