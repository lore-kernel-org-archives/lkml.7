Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D573DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D2C217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qj5Q3f0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfDJHna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:43:30 -0400
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:36928
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727527AbfDJHn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYRwsIWaN1/tv+xpUeNx5xeEOkNoL8TP4dDMydV8Cdc=;
 b=qj5Q3f0xofYqbhRnmNlEsLtOyGwqugpxgpICnwhe/wZwo+sj/ooabuNYHw6UR3AjsmZ/31dcaCOtKQUvRYtXGsTd5dmPWB/1hXTve/GZwG5CosM31KYZ3Tj50rcF8zWNwxoWmZ4GLbZ0U/HNY3oZfk1yM1QyK+/4+34grSd5L8k=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3770.eurprd04.prod.outlook.com (52.134.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.18; Wed, 10 Apr 2019 07:43:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 07:43:22 +0000
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
Subject: [PATCH RESEND V11 3/4] defconfig: arm64: add i.MX system controller
 thermal support
Thread-Topic: [PATCH RESEND V11 3/4] defconfig: arm64: add i.MX system
 controller thermal support
Thread-Index: AQHU73ES/tmeWpSGFE6cNCmyFOWiJg==
Date:   Wed, 10 Apr 2019 07:43:22 +0000
Message-ID: <1554881866-26333-3-git-send-email-Anson.Huang@nxp.com>
References: <1554881866-26333-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554881866-26333-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 548ca32b-a059-4d0a-400b-08d6bd8834ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3770;
x-ms-traffictypediagnostic: DB3PR0402MB3770:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3770ED880B783A32DFF55776F52E0@DB3PR0402MB3770.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(86362001)(478600001)(7416002)(52116002)(97736004)(110136005)(76176011)(386003)(6506007)(2501003)(316002)(102836004)(186003)(2201001)(81156014)(81166006)(14454004)(2906002)(66066001)(8676002)(26005)(256004)(305945005)(6116002)(3846002)(7736002)(71190400001)(446003)(71200400001)(11346002)(68736007)(5660300002)(476003)(2616005)(4744005)(6512007)(53936002)(36756003)(99286004)(106356001)(6436002)(105586002)(6486002)(8936002)(50226002)(25786009)(486006)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3770;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZsAbjUQ9x3uIIkCHppCoi5tvEQZcitfy9g2RQe5I6nNrBf66qtLZ7ecf+eRoK6lcVO8kbHXr4kYIpCX5JwzTKh2J1q/PkeTOu/BvzJfC2HhsEVBUBUp5yCJgVCIvgqHXp6z0QUzG5iij42Ks6X3e6Wr99aoKBDV/6Vf2LrhbK9pW7Rit5fc7D8lBWVFlUD7vumh2NQMafjp5lfmQg4ozEAuOaNBAgpd4apHNZW3b1beG2xUPaXXNMhb+OYa4DacOmF86LT0FMP9JxWmvOY3sAu3ZaUcV3kPB8tBJYJGCjocSrTkDC60e8Z4mfpMEm2ZC9xfEG4XkxETgrAEhY0ym+eF+zE2BtqYot/f7Cd/GcedKoUHa82B9tBDog4qIFpVJ2P2g9RVBT01K5ywfWoVUUiRoDFSbpPQ54iQH+roEd7o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548ca32b-a059-4d0a-400b-08d6bd8834ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 07:43:22.5046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBlbmFibGVzIENPTkZJR19JTVhfU0NfVEhFUk1BTCBhcyBtb2R1bGUuDQoNClNp
Z25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQpObyBj
aGFuZ2VzLg0KLS0tDQogYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyB8IDEgKw0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9jb25m
aWdzL2RlZmNvbmZpZyBiL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCmluZGV4IDllMzEz
ZjUuLmQ0YzQwNGEgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQor
KysgYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQpAQCAtNDE1LDYgKzQxNSw3IEBAIENP
TkZJR19TRU5TT1JTX0lOQTJYWD1tDQogQ09ORklHX1RIRVJNQUxfR09WX1BPV0VSX0FMTE9DQVRP
Uj15DQogQ09ORklHX0NQVV9USEVSTUFMPXkNCiBDT05GSUdfVEhFUk1BTF9FTVVMQVRJT049eQ0K
K0NPTkZJR19JTVhfU0NfVEhFUk1BTD1tDQogQ09ORklHX1JPQ0tDSElQX1RIRVJNQUw9bQ0KIENP
TkZJR19SQ0FSX1RIRVJNQUw9eQ0KIENPTkZJR19SQ0FSX0dFTjNfVEhFUk1BTD15DQotLSANCjIu
Ny40DQoNCg==
