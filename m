Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F421FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BE12083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ECDkcaAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfDJHnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:43:11 -0400
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:55297
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726577AbfDJHnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGz2RHNOSYTa3YO1/HVmBLDqunDx5M3PWWfNwBLuyzI=;
 b=ECDkcaAvrMzBNGUPes3CtGY92ahEIRN8iCk+KTe6jtMA0rMy29BzHDJ44nzEoKYbnukT5eOdqxudNmA4iY1plrbz0HOC5Cunp4Vr0cyII/EyzAccuARemFIzxo6Yov+0Ittj7OJcB3te/plE/tJ847MSgF/yUqui0imtAY+XeH4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3770.eurprd04.prod.outlook.com (52.134.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.18; Wed, 10 Apr 2019 07:43:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 07:43:04 +0000
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
Subject: [PATCH RESEND V11 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH RESEND V11 1/4] dt-bindings: fsl: scu: add thermal
 binding
Thread-Index: AQHU73EHSbSj+ICal0a8V7ocQCksIw==
Date:   Wed, 10 Apr 2019 07:43:04 +0000
Message-ID: <1554881866-26333-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0155.apcprd02.prod.outlook.com (10.171.30.15) To
 DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b8d3518-8bf4-4b3c-1854-08d6bd882a3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3770;
x-ms-traffictypediagnostic: DB3PR0402MB3770:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3770F3DA0508261AAB565EDAF52E0@DB3PR0402MB3770.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(86362001)(478600001)(7416002)(52116002)(97736004)(110136005)(386003)(6506007)(2501003)(316002)(102836004)(186003)(2201001)(81156014)(81166006)(14454004)(2906002)(66066001)(8676002)(26005)(256004)(305945005)(6116002)(3846002)(7736002)(71190400001)(71200400001)(68736007)(5660300002)(476003)(2616005)(6512007)(53936002)(36756003)(99286004)(106356001)(6436002)(105586002)(6486002)(8936002)(50226002)(25786009)(486006)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3770;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ikf866ZlTPVUHqU4a0icddtNq54zcBk6/1dS4IGN4cDr6abGPUkX7kZ/vQVFFO3N6Vj2VBkJQuupk85LiUoo/o4W+Z/NDZYuGmyzfdbdvcS7qlKQ1dx2ueaGid9DyngU0mX2JLMiQsRj6lO2JPqss95Tb+XcgSBebW08d3dxyz029WZlpJqgDMYWhbxfM91ZSX8+iNZ7rvWsTTSJKgsJZvvHiS/BKnHszkHghngVfHIX7Fp7PeuCRms6xg/skoFNyyC1H8q7pEo1VMmCwzvgBBljXCZwkwyqCU0WW8vs3pj6xYmT0HMn0jvRye6DQgey5K970o39tQDvxLIV47gZwcVAZq6r986BjiAvdpjOy+i/fw+Z12sPL5wQ6/hZoI3WCjVE9J1/K83pvojob7jVgEHVj8y1CCIrfcNDjZNkbLM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8d3518-8bf4-4b3c-1854-08d6bd882a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 07:43:04.4488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3770
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
bW92ZSBwcm9wZXJ0eSAiaW14LHNlbnNvci1yZXNvdXJjZS1pZCIuDQotLS0NCiAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0ICAgICAgICB8IDE2ICsrKysr
KysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNs
LHNjdS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2Fs
ZS9mc2wsc2N1LnR4dA0KaW5kZXggNzJkNDgxYy4uMDIzZmI1YyAxMDA2NDQNCi0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQor
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2ws
c2N1LnR4dA0KQEAgLTEyMiw2ICsxMjIsMTcgQEAgUlRDIGJpbmRpbmdzIGJhc2VkIG9uIFNDVSBN
ZXNzYWdlIFByb3RvY29sDQogUmVxdWlyZWQgcHJvcGVydGllczoNCiAtIGNvbXBhdGlibGU6IHNo
b3VsZCBiZSAiZnNsLGlteDhxeHAtc2MtcnRjIjsNCiANCitUaGVybWFsIGJpbmRpbmdzIGJhc2Vk
IG9uIFNDVSBNZXNzYWdlIFByb3RvY29sDQorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQorDQorUmVxdWlyZWQgcHJvcGVydGllczoN
CistIGNvbXBhdGlibGU6CQkJU2hvdWxkIGJlIDoNCisJCQkJICAiZnNsLGlteDhxeHAtc2MtdGhl
cm1hbCINCisJCQkJZm9sbG93ZWQgYnkgImZzbCxpbXgtc2MtdGhlcm1hbCI7DQorDQorLSAjdGhl
cm1hbC1zZW5zb3ItY2VsbHM6CVNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dGhlcm1hbC90aGVybWFsLnR4dA0KKwkJCQlmb3IgYSBkZXNjcmlwdGlvbi4NCisNCiBFeGFtcGxl
IChpbXg4cXhwKToNCiAtLS0tLS0tLS0tLS0tDQogbHNpb19tdTE6IG1haWxib3hANWQxYzAwMDAg
ew0KQEAgLTE2OCw2ICsxNzksMTEgQEAgZmlybXdhcmUgew0KIAkJcnRjOiBydGMgew0KIAkJCWNv
bXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2MtcnRjIjsNCiAJCX07DQorDQorCQl0c2VuczogdGhl
cm1hbC1zZW5zb3Igew0KKwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2MtdGhlcm1hbCIs
ICJmc2wsaW14LXNjLXRoZXJtYWwiOw0KKwkJCSN0aGVybWFsLXNlbnNvci1jZWxscyA9IDwxPjsN
CisJCX07DQogCX07DQogfTsNCiANCi0tIA0KMi43LjQNCg0K
