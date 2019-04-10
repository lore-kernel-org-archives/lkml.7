Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566CFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E762083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jhyYWyNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfDJGBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:01:47 -0400
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:21830
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbfDJGBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYRwsIWaN1/tv+xpUeNx5xeEOkNoL8TP4dDMydV8Cdc=;
 b=jhyYWyNp0X89WeXOqwY1QU4WoKdSljW36NYtZ0ytJS7OaXMfRd2zfTfRFdzm9rlcbJDEtv06h4mJF/N36cnz4UJOwMFxXGtaXTMlS8336bRLZUe9u4YwoPMEGkAltQKDMPqvtbhlboAh9g4+PyuU9UZ29TcICNmOSiQQA7Dfras=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3660.eurprd04.prod.outlook.com (52.134.70.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Wed, 10 Apr 2019 06:01:40 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 06:01:40 +0000
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
Subject: [PATCH V11 3/4] defconfig: arm64: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V11 3/4] defconfig: arm64: add i.MX system controller
 thermal support
Thread-Index: AQHU72LdpS6L7ZUD1USkxPKUJhktkg==
Date:   Wed, 10 Apr 2019 06:01:40 +0000
Message-ID: <1554875779-19727-3-git-send-email-Anson.Huang@nxp.com>
References: <1554875779-19727-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554875779-19727-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: b952102d-5cb8-48e3-f262-08d6bd79ffab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3660;
x-ms-traffictypediagnostic: DB3PR0402MB3660:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3660F7295089400AF4BEBC37F52E0@DB3PR0402MB3660.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(376002)(396003)(189003)(199004)(486006)(66066001)(8676002)(476003)(446003)(36756003)(5660300002)(256004)(81156014)(50226002)(71200400001)(71190400001)(105586002)(2616005)(81166006)(8936002)(478600001)(7416002)(106356001)(6512007)(305945005)(7736002)(53936002)(110136005)(2201001)(186003)(86362001)(76176011)(6486002)(99286004)(97736004)(4326008)(14454004)(68736007)(316002)(11346002)(52116002)(26005)(6436002)(6116002)(6506007)(3846002)(25786009)(386003)(2501003)(2906002)(102836004)(4744005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3660;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bSGqu394wYS5q5URLLHtNyC91Bdc1q/AVBmGrf9q9tGf+azPalj4w5Tb0gIH1TTk1MqvSNkshc1QJmU0HO3XkDHQmb4biW6tjY6GV6n1vjM+NftSwMKuDTiWEnyjCEbuOpqEz3GB2VGQkzikM1Zov4mVJk9tOt62m/BcZaAF3/30YfsPskKuMsqnUfEXZrpud1Ry2NStaPtlBTh/JybOtkNSz7+G/ClogBr5r3iQYOHCOOXPs/S+nsDwDYr+cn/OZybU0pCzivy9vjMvLpO4UfgMu8OqRWtMUvGwZkkHk98Zn7yaT6jbJdEGVftkwdiIRPZhDImDzLXn3JHDljWzXFYYQAXQMXfmktnJMUAs3Cis79INE/eACBockn6zgD0cqiBSkduzWvh99pRkd0kCmBwYxe4xOTw9EwTNCsQ4iyw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b952102d-5cb8-48e3-f262-08d6bd79ffab
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 06:01:40.3209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3660
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
