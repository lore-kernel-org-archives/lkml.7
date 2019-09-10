Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636B6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272BD222BD
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="WMIZ2/Jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404655AbfIJGVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:21:20 -0400
Received: from mail-eopbgr50108.outbound.protection.outlook.com ([40.107.5.108]:55813
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfIJGVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:21:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx3pi3zH9YD62KmQyR/3XYBCtn6nQwM7yJ9tMdVFneRj2KS87DrkPqZQX87lA6liG+tBxAMeRZXRFAsabLgPvjorZR/Lx+RxbFP5Rvujs3gg/n48Jw7FoEFa12sVPPY+YFokzLB36uy1ZQU8ACNbzhtGalHpUHIx1RbuC7aEtgx7aOjbSNykCXUWCyrcHqCmrnPLSH805engKL4Dyi3FEtHNnzEJbWf3EZHJ4lpWElvv/yHZ/3kBG44YQVy243W4FipKzeJgCXwedBrSeG7AgJ/aBIyikSaur4DDUPDyOLL0kzxWkii0dbvnGSF/9ssBw5TxgibPowTeMoI2bZoO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOC+Tl+9sA8VHFcI3fdk9syq6SeNSlDvyvJeCCnfbNM=;
 b=KF9U83MhxJJdBI0VltFb6Zo6zbQqDZA3Xed0bQuOMsrRLL8/d/ilwZLY4OZg592aPJ2b/2u5m+C4c2XVhnEeVPUUekUC16y/424X4r0IcNhecUkQEjOj2ix0RU8EilH5Lbf3loeWRejVcD0REUuJ0DzOy7szEN8wtOj6XtsJADGD1C3D/SeiRI4TqRWg/mVq1lUaeWRMXxdhXkoRgGUxYH6mct5PkOjQPI68INnWA+VqMUSWpu2IkQJAu2qvROGF1AbEITyxT7dwnfk5zb8ICb7T3jUYHvAofvuNBtUoLVk4BGsvVt4xjuEw8fp6PlddVsnWPnCDh93acet6arI3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOC+Tl+9sA8VHFcI3fdk9syq6SeNSlDvyvJeCCnfbNM=;
 b=WMIZ2/Jpiri19C2qgIUD5xYig8tGxokMFcEau4LQ3A4RRuwjFJGSjLzUc/vok0ctS724Y5FAPa8lokf0nes5ozbmt0uiGjKa15P5DCXJzPjmH57wNouDyB2HyztAppF8+qfg7f2x8/lgpjLvvquKf/EXeSBQoGs8I0n06+kGaKY=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3054.eurprd05.prod.outlook.com (10.175.21.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Tue, 10 Sep 2019 06:21:13 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 06:21:13 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luka Pivk <luka.pivk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2 0/3] Add new binding regulator-fixed-clock to
 regulator-fixed
Thread-Topic: [PATCH v2 0/3] Add new binding regulator-fixed-clock to
 regulator-fixed
Thread-Index: AQHVZ5/xkR9Jah05zE2oPXjXVjZAdQ==
Date:   Tue, 10 Sep 2019 06:21:13 +0000
Message-ID: <20190910062103.39641-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0052.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::16) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f1415d6-8898-4739-5746-08d735b7142c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3054;
x-ms-traffictypediagnostic: VI1PR0502MB3054:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3054E7A6AEF87A16FA9A4E21F4B60@VI1PR0502MB3054.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39850400004)(366004)(346002)(396003)(376002)(85664002)(189003)(199004)(966005)(316002)(25786009)(14454004)(4326008)(256004)(71200400001)(71190400001)(7736002)(305945005)(53936002)(478600001)(50226002)(36756003)(8936002)(66476007)(66556008)(81156014)(64756008)(81166006)(66446008)(66946007)(486006)(44832011)(110136005)(99286004)(1076003)(6506007)(386003)(8676002)(2616005)(476003)(2501003)(6512007)(6306002)(14444005)(26005)(54906003)(5660300002)(7416002)(86362001)(6116002)(3846002)(102836004)(186003)(2906002)(52116002)(6486002)(6436002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3054;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K/br8gfpFViuYdqMinKyN30Btffutp5tfNwnX6kk3RW9fyrIXTbgv3l5YWkgELNaZ2gEkZNEXDu6CALqm59jNcHZ6YY+HCgUHdvV6rByNOb8gqE9UmELbdIeh2+seOcT0TzbQ3lI4jHtbEG5bDiecdfRbgct03+CDPLaFfqPb+oJNlzlJvtiandnIeMUy2MGzMKhVtaEwxuRNQIqGjtbAqgwoOp+TirGN6nbEZ427TgSuLyqpRC0y4Jcsyk7AyQl/KKXUZMrzJ7pubuUSokuEGOSEV2NvH0bKSbJSBFfAoyXSuAajdZFKnLJ1IDC7LI3wgrUE93opcTgRK8nL/xuT1iXBUfTGrAR9LVYuXfofpe31wDx7zySc03AQ7/JYQGWJ9oWHnX33mrzMohfgLlxbmcFcVYdA2/kWd1a8gCm/1M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1415d6-8898-4739-5746-08d735b7142c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 06:21:13.3000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vf8v2mx4mlymcRQbqHfRFJbC/YSHTTYfiqvLcMUwP0Px/FsWkLsEYZM7Qy7dXeKPECk6ZqYMcRrUnBvhFIs9EF9taVltvViepqY8K6HV4dY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Our hardware has a FET that is switching power rail of the ethernet PHY
on and off. This switching enable signal is a clock from the SoC.

There is no possibility in regulator subsystem to have this hardware
reflected in software.

I already discussed with Mark Brown about possible solutions and he
suggested to create at least a new compatible. [1]
This discussion includes also a better explanation of our circuit as
well as schematics. So please refer to that link if you have questions
about that.

In this first attempt I created a new binding "regulator-fixed-clock"
that can take a clock from devicetree. This is a simple addition to
regulator-fixed. If the binding regulator-fixed-clock is given, the
clock is simply enabled on regulator enable and disabled on regulator
disable.
To be able to have multiple consumers a counter variable is also given
that tells how many consumers need power from this regulator.

Best regards,
Philippe

[1] https://lkml.org/lkml/2019/8/7/78


Changes in v2:
- return priv->clk_enable_counter > 0 directly.
- Change select: to if:
- Change items: to enum:
- Defined how many clocks should be given

Philippe Schenker (3):
  regulator: fixed: add possibility to enable by clock
  ARM: dts: imx6ull-colibri: add phy-supply and respective regulator
  dt-bindings: regulator: add regulator-fixed-clock binding

 .../bindings/regulator/fixed-regulator.yaml   | 19 ++++-
 arch/arm/boot/dts/imx6ull-colibri.dtsi        | 12 +++
 drivers/regulator/fixed.c                     | 83 ++++++++++++++++++-
 3 files changed, 110 insertions(+), 4 deletions(-)

--=20
2.23.0

