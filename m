Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A822C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9752081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I7gyh4IX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfCGOAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:00:16 -0500
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:26694
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbfCGOAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLWcfIwxGX+olop3Z/zoiJu2mBjDjAhXIS1Q9TkW334=;
 b=I7gyh4IXkO6kMQSuTE/Y3Val1AK+6lhRfyL54vmxXSkipiiLFCdfb19JYT8xezW3JAJy2gWD8LcpFtH5Pr+9gwESg5jkdF197gYn/uFCfJlRwGFHOZemEJ+2drVA4MEBehaGzKaNvtmnsdBSREjXnyRG/571azNW8ts5Lchx6e4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4451.eurprd04.prod.outlook.com (52.135.149.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 7 Mar 2019 13:59:59 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 13:59:59 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V7 1/3] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Topic: [PATCH V7 1/3] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Index: AQHU07jNtorBWhAbJkylCtaCxH6iDKYAGsHAgAAXwOCAAAGQcA==
Date:   Thu, 7 Mar 2019 13:59:59 +0000
Message-ID: <AM0PR04MB42118452D9B975337E3BDDAD804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4211060E8DA8BA9CEAAA0F15804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB391677CB27E45A6EC16D6F69F54C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391677CB27E45A6EC16D6F69F54C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30229d7c-d4de-4aa3-da4f-08d6a3053006
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4451;
x-ms-traffictypediagnostic: AM0PR04MB4451:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB4451;23:ILLRBZ65I+CAtiDLZG0VaA2F/Zew6+qYPHTtc4n+S?=
 =?us-ascii?Q?Ko3c3cI2GN/4y6msVK53UP0V+PAfqx43rAdHx8L4eTN/yWTYGObhOh9ETLa3?=
 =?us-ascii?Q?qog2xdStemqGo7G+Rsj0eIynwzrGYAzqjBUoxFodcxkfojExW2ftxxfmaNXC?=
 =?us-ascii?Q?tXMvfQmhefr4jLdmuV8ZTWt7ObMOsjb8MgcQlnt7RenemCN6Q0h7Mc6Nn64A?=
 =?us-ascii?Q?/rAuql4KAEYl0xVe0zo4KWX/457enl8+FsgRPJuLaaDp2vRfbNww00SlTzYv?=
 =?us-ascii?Q?tcCrf9mYftuIagj7o94aEuRGfzh3cLgmrwvOreSJIPCGEQAGW0mcppWRzEvG?=
 =?us-ascii?Q?DZtWXFxBNqIHyl8uKlW7G0lXk2/FTZjSYY+xVvX+GD0FxsYvHeq6bwmcHbAv?=
 =?us-ascii?Q?gQpG6lBkJBdOMjvRo6OihWVnz9IlNVmJM1U9KwcEShlCkX2a+5DY5hlC0qeq?=
 =?us-ascii?Q?GDXtW1qnYbXEnFlj4E1w9Dhm5pR699XB2TwX6y3hgxew/aAxyGK9bEYWvrDZ?=
 =?us-ascii?Q?fAunhfhu5JOmxYrjp6qEFQc/mGn8D152YydEgYFsTdXvAGJM4SOeGQbPmjOs?=
 =?us-ascii?Q?40651Z8nNqwyTvjTlzMC5zktHnrHFBDPx4cJGUn3+nirMV/IUxz+sK5SIA1G?=
 =?us-ascii?Q?8tkU2/6fapwj5ZxrVebsM+DxTxybDYzPaMBgrQBlt98kJbngUEGhF/hyDqJ8?=
 =?us-ascii?Q?ndjeGmK5hsuGjTzILv3NEAWW6+OtlJvT30sKD9Br1aY9BWQRaU/odKekihTo?=
 =?us-ascii?Q?SKkrGecpuM4uwNNiVw+J5l7Q6w3xRlaEuUaJwbKU1XzdAnBw5ChIXMal0qOE?=
 =?us-ascii?Q?DmoMi+NkqcMhWIG52St4YWDGXieD0Ra9uvsqZTp9epi/s2Abwwqdve5v3aSB?=
 =?us-ascii?Q?DElN4xIHAdKOjZl0JZjnLQhjBhBvA6N4TpEJ3zLs5Q8ued72Rm7BsZCYT7B8?=
 =?us-ascii?Q?fHJ/1i22u44pD/6z6XKoqOKjXRlH4lXEZSY5DfBJQzGq+fVBG9lkLvIUYhMZ?=
 =?us-ascii?Q?JYTaZmEHOg3FICr2xRbSsjmnRSfO8IkreqSoyonyLElXkRnMJHuheWb3iND5?=
 =?us-ascii?Q?vCZqQSvhbfuW9vicSw0iVBerQrs3suZLJNxb377LC0zIDB4y/A0Eab8Fau0b?=
 =?us-ascii?Q?CQgoUmKluwW8K8M7v/IyJknFhC36+uctzN1pFSOMIXtb+eZZdDzCtIj7yY3q?=
 =?us-ascii?Q?jcogqUZU7NDXNeVwwsoZU6GUumnx1QyqyhuHrgNcbpDEcX0iP/loe5Q7tfgI?=
 =?us-ascii?Q?Z+sgD8pL0+pECpM6ssmLo2LjiiIi3pio3lCfgqKHv0RMyVdu+yAQ4Ajz5ud+?=
 =?us-ascii?Q?tPjcm3qeKz5BYacq9FjtQPPQRbEeUROpB2IejBtB9XI?=
x-microsoft-antispam-prvs: <AM0PR04MB4451640A1819C93198452767804C0@AM0PR04MB4451.eurprd04.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(6436002)(55016002)(229853002)(5660300002)(52536013)(53936002)(9686003)(105586002)(6506007)(106356001)(4326008)(2501003)(7696005)(76176011)(86362001)(25786009)(256004)(97736004)(99286004)(66066001)(4744005)(102836004)(26005)(2201001)(8676002)(81166006)(8936002)(6246003)(81156014)(74316002)(305945005)(7736002)(44832011)(478600001)(33656002)(14454004)(186003)(316002)(68736007)(3846002)(6116002)(2906002)(71190400001)(7416002)(71200400001)(110136005)(486006)(11346002)(476003)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4451;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BM0e/IEzOgNlPlGmvtbJNt/cV9Gla2L9SGw9XGKw5TW0e+DCpVAey0yIci0pqg1zEivQjT5BWVY+bs9M3eZxEChQD6N1LV4szWkCDBUEdqsWiU91fHcdG7I1JKFU7ufqPA/WFgYc+5FRlgZiQbDEvS8OAzWnA9i4/MUWa3TD/HWkoKAlSsOm4PvHQLSOcy7mP0g3iminW43FpWn4GgxtW1r4hKsc3QniHTJhRg5PooeDnnfmvj7hFQDzXjR/VphquxikcftaS5c0ok+6m5PzoZ7MPTUliKX/BC0pP55n3PA645+q75eS1i8she6NsDhO1D286JGNwhibziHbULWG1dRSoK5H7xFr4Fr13f5SI6+PuvDiW2ryXR3QXgiRX/KvF9M8f2Ow98hZifVFFsvXnSrDYDm1XIzKzj9Pv4+92XM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30229d7c-d4de-4aa3-da4f-08d6a3053006
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 13:59:59.4862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > As I replied in another mail, it actually does not depend on SCU.
> > Let's wait for Rob's comment on whether we could move watchdog Out of
> > SCU node.
>=20
> Per previous discussion, the dependency here is to prevent enabling this
> module for platform without IMX SCU, although it does NOT use SCU IPC cal=
l,
> but the SMC call trap into ARM-Trusted-Firmware will eventually call SCU =
API,
> so it still depends on IMX SCU hardware, I am NOT very sure if it is corr=
ect to
> remove it here.
>=20

Then it's ATF depends on SCU, not this virtual watchdog based on ARM SIP, r=
ight?

Regards
Dong Aisheng

> >
> > > +	depends on HAVE_ARM_SMCCC
> > > +	select WATCHDOG_CORE
> > > +	help
> > > +	  This is the driver for the system controller watchdog
> > > +	  on the NXP i.MX SoCs with system controller inside.
> > > +	  If you have one of these processors and wish to have
> > > +	  watchdog support enabled, say Y, otherwise say N.
> > > +
