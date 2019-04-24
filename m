Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DAEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF90206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iyi5IrWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfDXILs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:11:48 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:3909
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbfDXILr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgYN8Kd40vCh0TWLUwLgHWy0IunelgDMtFFCzyZDOsQ=;
 b=iyi5IrWT0TgWmA1088VjMbHAe6PSHttnlp+1bZWdow0rBewMteSosRfFF6UvYoUYvogKbV6hwGyfAN9He3UC/XWFuy7vu1RuBfgTTRrph8gNEYMRh69rp6EDgtKpuxKB6zF7rFiErV3sBbF2xPLWGssClrbxxYYq/DRZFbnb8Os=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5505.eurprd04.prod.outlook.com (20.178.112.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 24 Apr 2019 08:11:43 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::a1d7:51b5:9893:dcee]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::a1d7:51b5:9893:dcee%2]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 08:11:43 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Yue Haibing <yuehaibing@huawei.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: imx: Fix build error without CONFIG_SOC_BUS
Thread-Topic: [PATCH] soc: imx: Fix build error without CONFIG_SOC_BUS
Thread-Index: AQHU+nPLGm9MWjwEc0eIwVyKi03AFA==
Date:   Wed, 24 Apr 2019 08:11:42 +0000
Message-ID: <AM0PR04MB6434F319FA56FE9A1AC0572FEE3C0@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <20190424075946.23124-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 846023b5-7d12-42d0-99df-08d6c88c7c94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5505;
x-ms-traffictypediagnostic: AM0PR04MB5505:
x-microsoft-antispam-prvs: <AM0PR04MB550581BD629C0E559801948CEE3C0@AM0PR04MB5505.eurprd04.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(136003)(346002)(189003)(199004)(256004)(54906003)(86362001)(8936002)(97736004)(53936002)(5660300002)(99286004)(478600001)(66476007)(66446008)(6116002)(7696005)(66556008)(2501003)(55016002)(64756008)(446003)(25786009)(3846002)(68736007)(7736002)(6246003)(76176011)(2906002)(110136005)(4326008)(26005)(316002)(186003)(33656002)(6506007)(53546011)(52536014)(81166006)(81156014)(305945005)(9686003)(6436002)(66066001)(4744005)(229853002)(476003)(44832011)(8676002)(73956011)(91956017)(76116006)(71200400001)(71190400001)(6636002)(14454004)(66946007)(486006)(74316002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5505;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f5rANXNihA76hRrb/gNSQqbFPhIQtU8qDnYudCtppccW07lxH/nAuTr4VL2Y1xFi/WlZB5yq37TYHnjtzaJJV8YOrB92dht+BzRIk6MXCyPByFH5wdVyWX1PSvp/znDyoUZib9lzbEqCxbRmkCtqwaQ4yrYLlX9m16wsAkxIHsg3rCzs4TWe3sY3ujEt5eite2IKf5JC3CqhRhlI/wjm8BwsLCp1bzjhE8lh7Cj/NVue9YmqHZTrbHBxAE0aJF0wiuYrTIWJlnVbvBIbuIr1c/rN19gFG4cdFSsec+HBAm9/ERsdW2j8nkDyAApXWKeH3yiT4gd+AfSPUeEA9cK2OAYwRKrMs3uzl4mHim8DHasRlVXn6+t+CQQeGQqfXH3eiCGAymsagx5SAI3BNG9lF6YgmXIRbzpc1YPQ4G7ALjA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846023b5-7d12-42d0-99df-08d6c88c7c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 08:11:42.9233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/2019 11:00 AM, Yue Haibing wrote:=0A=
> From: YueHaibing <yuehaibing@huawei.com>=0A=
> =0A=
> During randconfig builds, I occasionally run into an invalid configuratio=
n=0A=
> =0A=
> drivers/soc/imx/soc-imx8.o: In function `imx8_soc_init':=0A=
> soc-imx8.c:(.init.text+0x144): undefined reference to `soc_device_registe=
r'=0A=
> =0A=
> while CONFIG_SOC_BUS is not set, the building failed like this. This patc=
h=0A=
> selects SOC_BUS to fix it.=0A=
> =0A=
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig=0A=
> @@ -5,6 +5,7 @@ config IMX_GPCV2_PM_DOMAINS=0A=
>   	depends on ARCH_MXC || (COMPILE_TEST && OF)=0A=
>   	depends on PM=0A=
>   	select PM_GENERIC_DOMAINS=0A=
> +	select SOC_BUS=0A=
>   	default y if SOC_IMX7D=0A=
=0A=
You should "select SOC_BUS" from "config ARCH_MXC" in arm64 =0A=
Kconfig.platforms, not from a power domain implementation.=0A=
=0A=
Your patch works because arm64 ARCH_MXC currently does "select =0A=
IMX_GPCV2_PM_DOMAINS" but it's silly to use this intermediary.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
