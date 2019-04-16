Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959BBC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685CE20870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mbLn4iJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfDPDWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:22:39 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:4769
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfDPDWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRE0GGHqIoSGOfDOEWY3Unc70+j3zWB8l9DVM6H+Y68=;
 b=mbLn4iJpdTE+mm1O6wZHMKJl4o2x81QWxVc1UHfl4ZV+5fiyFC2wtyohnq7fJJVvDHZr9ergX2sBLoebx67B3t7r0qgvnXEjLljBcepCFKGkLHqRES5rXM+v9qMYJJX4bWLTyBJbrGHfRIA5BUxHBsAhLFkjwz0r0KOigefJ42E=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3895.eurprd04.prod.outlook.com (52.133.29.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Tue, 16 Apr 2019 03:22:33 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c854:fc94:f9ed:2ca2]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c854:fc94:f9ed:2ca2%6]) with mapi id 15.20.1792.020; Tue, 16 Apr 2019
 03:22:33 +0000
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
Subject: [PATCH V12 4/5] defconfig: arm64: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V12 4/5] defconfig: arm64: add i.MX system controller
 thermal support
Thread-Index: AQHU9AOhN40rowWqqUG8uS4B1vp4eg==
Date:   Tue, 16 Apr 2019 03:22:33 +0000
Message-ID: <1555384609-7030-4-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5039116f-ec7d-416d-536f-08d6c21ac3eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3895;
x-ms-traffictypediagnostic: AM6PR0402MB3895:
x-microsoft-antispam-prvs: <AM6PR0402MB3895C59CE26B95348078DB1AF5240@AM6PR0402MB3895.eurprd04.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(6512007)(106356001)(105586002)(53936002)(2501003)(36756003)(6116002)(3846002)(66066001)(68736007)(486006)(110136005)(316002)(5660300002)(11346002)(446003)(476003)(2616005)(97736004)(71190400001)(71200400001)(4744005)(81166006)(99286004)(8936002)(81156014)(8676002)(50226002)(52116002)(102836004)(256004)(14454004)(478600001)(6506007)(386003)(26005)(7736002)(4326008)(76176011)(86362001)(2906002)(7416002)(186003)(2201001)(25786009)(6486002)(6436002)(305945005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3895;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J12aJnwbFb8v3OY0S6UMR9h9r8SPQazi5QLgKNuPlbTSBVpBSJ6NNioLD3Es1o+rFucPN9mOUndrVgOJERdZsOdITzXx5rmwvQxicu8RIu6kiuMYVcbHa7FvqTy6/v/fIdVsygHqNhL2kHJ1uFcDJYc492iT5yda0tcdpyyK0pQP4Sx26+SPflgN4YQ2FOK9Q1JMQKOlITCOxCnXcSFCss6iKWTxqwPjhvOmP5b3pkmyZoJLePdzxqqbODfDUl1eZUWfw2WpDZ/ncL9rs1pEhokRY5BFGl4WWaPuzTj5bnymSZNYvvWX5k1hW3w82rdFKBrZl2VkLkO3gkkldm/Cov9MSlGUzq9Sx2gV8jX8dXatDq1tf0r4DuLWvpjWNR+wcKB60VlpHpM5kKtcgRBVXLADhtkqBwhEcSKIQ5D+iU4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5039116f-ec7d-416d-536f-08d6c21ac3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 03:22:33.6244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBlbmFibGVzIENPTkZJR19JTVhfU0NfVEhFUk1BTCBhcyBtb2R1bGUuDQoNClNp
Z25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQpObyBj
aGFuZ2UuDQotLS0NCiBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIHwgMSArDQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2NvbmZp
Z3MvZGVmY29uZmlnIGIvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KaW5kZXggMTdkYWE5
Ny4uZmJlM2JlNyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCisr
KyBiL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCkBAIC00MjUsNiArNDI1LDcgQEAgQ09O
RklHX1NFTlNPUlNfSU5BMlhYPW0NCiBDT05GSUdfVEhFUk1BTF9HT1ZfUE9XRVJfQUxMT0NBVE9S
PXkNCiBDT05GSUdfQ1BVX1RIRVJNQUw9eQ0KIENPTkZJR19USEVSTUFMX0VNVUxBVElPTj15DQor
Q09ORklHX0lNWF9TQ19USEVSTUFMPW0NCiBDT05GSUdfUk9DS0NISVBfVEhFUk1BTD1tDQogQ09O
RklHX1JDQVJfVEhFUk1BTD15DQogQ09ORklHX1JDQVJfR0VOM19USEVSTUFMPXkNCi0tIA0KMi43
LjQNCg0K
