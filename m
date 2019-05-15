Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E666C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B75A20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mn4zWIIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfEOKEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:04:52 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:39651
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbfEOKEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm2X//WPXOIgD5UW/K/WAjv2L76gLqUFtG3NSJhdqLY=;
 b=Mn4zWIIoM4a2at+hWHmy9qriRlUKed+NYgG5SedLvMisPKBjxgCHILC/VPr3tLTLpj2zQnHozv8/uDfVru754RgLLRTR/FMtg7N4X0hSQTrSZiUGdIvdicbMYoeg4PwcSlWSH7vOoaZU0T7HKyS2iSYLMGTswTl7lYPF0WR2CNw=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB4801.eurprd04.prod.outlook.com (20.177.41.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Wed, 15 May 2019 10:04:46 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 10:04:46 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V2 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH V2 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVCvixb1MFrIDHlECOalYM+lyDeQ==
Date:   Wed, 15 May 2019 10:04:46 +0000
Message-ID: <AM0PR04MB6434C2BCE2116836CFC0FEBFEE090@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <1557908823-11349-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9c69b43-db63-4003-37d1-08d6d91cc2ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4801;
x-ms-traffictypediagnostic: AM0PR04MB4801:
x-microsoft-antispam-prvs: <AM0PR04MB480156536BF4DAA6805F45BAEE090@AM0PR04MB4801.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(44832011)(486006)(66476007)(66556008)(53936002)(66066001)(5660300002)(6862004)(229853002)(73956011)(66446008)(64756008)(91956017)(76116006)(52536014)(99286004)(476003)(66946007)(478600001)(7696005)(14454004)(316002)(86362001)(76176011)(4744005)(446003)(102836004)(6116002)(8676002)(2906002)(71190400001)(186003)(14444005)(6506007)(53546011)(26005)(256004)(55016002)(9686003)(54906003)(3846002)(6636002)(4326008)(33656002)(6246003)(6436002)(305945005)(71200400001)(7736002)(81156014)(74316002)(81166006)(25786009)(8936002)(68736007)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4801;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y/ThbNd0wWXL7H2R4+RjpW0YsbGv8HGlcSfPA1sydRKGglH2TBBVqXpoeTvbrNw85ApwzaQu3KgLSlvsZIgCjH8k3SJNciRvyKCuFijM8wN316RjllItPd1wgnuRuZ9HaUZRjS0hqWydR+xQVP3guhdMaSseLfuFSTXCwdUP7eOzYJu/JKJqEOT2oQasUWkz0NQ6qIvhLc/E5Yy49cGihE51W01XQt6pm36DiXu6XSQCgi6iiDFJvTn1S6cYWMsBaq234YaXDLz9ddbKa7s0f1agfrQVkldkhoCJPf/rH8f/S33njOqLiDbh6vwjw7d6fucwZtFuwfrmeeWSK+lbTMAtiLaEOCajkbK29ORMN0BHCV+U8xasMzUoMB7IEmC8FHGkuLO8q0zTxf/HO7gOZXRudTWpj7lcXdonIYTBaWE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c69b43-db63-4003-37d1-08d6d91cc2ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 10:04:46.7000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.05.2019 11:32, Anson Huang wrote:=0A=
> Add i.MX SCU SoC info driver to support i.MX8QXP SoC, introduce=0A=
> driver dependency into Kconfig as CONFIG_IMX_SCU must be=0A=
> selected to support i.MX SCU SoC driver, also need to use=0A=
> platform driver model to make sure IMX_SCU driver is probed=0A=
> before i.MX SCU SoC driver.=0A=
> =0A=
> With this patch, SoC info can be read from sysfs:=0A=
=0A=
> +	id =3D of_match_node(imx_scu_soc_match, root);=0A=
> +	if (!id) {=0A=
> +		of_node_put(root);=0A=
> +		return -ENODEV;=0A=
> +	}=0A=
=0A=
Perhaps this check should be moved from imx_scu_soc_probe to =0A=
imx_scu_soc_init? As far as I can tell this "probe" function will be =0A=
attempted on all SOCs (even non-imx). Better to check if we're on a =0A=
SCU-based soc early and avoid temporary allocations.=0A=
=0A=
> +module_init(imx_scu_soc_init);=0A=
> +module_exit(imx_scu_soc_exit);=0A=
=0A=
Please don't make this a module=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
