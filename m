Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C674C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321DA206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qoP3h4RJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfDDGva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:51:30 -0400
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:64321
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbfDDGva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtTZ1/Ij8DBZsr8eLbyKPUO01IvobWOTspGsDYfEAQk=;
 b=qoP3h4RJkcyAVB0lhiVsExMDWFhCbb3jx4uZ2sz5JtqTC51i3lz2wlz5EwGRcAIXuDuYQaRb4uPXT+FfBPjQlbkTvu7aQFhl6pa/QwR1v+AUpL10z2X44Y1h4aRoWinsf6PkSdBTqIPdAdLP4zZOEu9ok+SA54417NgGH2xPeNA=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4352.eurprd04.prod.outlook.com (52.134.123.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Thu, 4 Apr 2019 06:51:26 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::c02c:b02b:fec5:577b]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::c02c:b02b:fec5:577b%4]) with mapi id 15.20.1750.014; Thu, 4 Apr 2019
 06:51:26 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] pinctrl: pinctrl-imx8mq: Add support PM operations
Thread-Topic: [PATCH v2 2/2] pinctrl: pinctrl-imx8mq: Add support PM
 operations
Thread-Index: AQHU4xL4DDCU6C+u6UCcMv4wiY9L/qYrnilA
Date:   Thu, 4 Apr 2019 06:51:25 +0000
Message-ID: <VI1PR04MB422278BD9C029E7332BB3C0A80500@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1553522352-20214-1-git-send-email-abel.vesa@nxp.com>
 <1553522352-20214-2-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553522352-20214-2-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54bab0da-7018-429d-71b5-08d6b8c9f529
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4352;
x-ms-traffictypediagnostic: VI1PR04MB4352:
x-microsoft-antispam-prvs: <VI1PR04MB4352FE04F8A9828D7964AD3380500@VI1PR04MB4352.eurprd04.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(81156014)(106356001)(229853002)(74316002)(102836004)(4326008)(25786009)(6246003)(476003)(3846002)(68736007)(8676002)(14454004)(55016002)(8936002)(105586002)(97736004)(6116002)(7736002)(110136005)(2906002)(486006)(44832011)(256004)(26005)(54906003)(305945005)(53936002)(9686003)(316002)(81166006)(6436002)(478600001)(11346002)(66066001)(6506007)(86362001)(5660300002)(52536014)(33656002)(446003)(71190400001)(7696005)(71200400001)(14444005)(76176011)(99286004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4352;H:VI1PR04MB4222.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: omfHDSXK9vbFrYkWQaSU5hLEHAH3PWLEl+S3bZeWlD6Wwh2AnBCntbZpg7KdpmyGstwnt10msKWdEtcEn7lYKEOt6Y792j7eAxxwvVx6e9qUesqb2vg4lRih8e9Iggm0U28w235Yyp2USTqwooCkzvfMdJo6TwrIHpNWvnf6CtSX4s6UyNUuzdYNVi2CwQSwcdC8BVTdMIwoOEkTVCHB7YYWXr/9OByNU0LaId+fDy3MuiZvps7MzsBVZ7d8cT4WekwZyhos+gJuXDdO6ktlYbbiXtGn5uansU4jg49ND6x5AqNkOLI6+RdP7w2U5U5ZbVaCNw0T39+10R69Yj3lXp00f80b8hBCXn+xRaK0I5qw98/WlA1DX4bfb69lqHPZdJUVvUeXsi8Ja6r1PIs2cPeDVTqUKbnUf/HIb4Z+xwk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bab0da-7018-429d-71b5-08d6b8c9f529
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 06:51:25.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Abel Vesa
> Sent: Monday, March 25, 2019 10:00 PM
>=20
> Add suspend/resume pm ops to the pinctrl i.MX8MQ driver.
> Make the suspend late and the resume early since some of the pins might b=
e
> needed active very late.
> These call the pinctrl-imx generic handlers.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/pinctrl/freescale/pinctrl-imx8mq.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx8mq.c
> b/drivers/pinctrl/freescale/pinctrl-imx8mq.c
> index 8d39af5..2a212bc 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx8mq.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx8mq.c
> @@ -335,10 +335,26 @@ static int imx8mq_pinctrl_probe(struct
> platform_device *pdev)
>  	return imx_pinctrl_probe(pdev, &imx8mq_pinctrl_info);  }
>=20
> +static int imx8mq_pinctrl_suspend(struct device *dev) {
> +	return imx_pinctrl_suspend(dev);
> +}
> +
> +static int imx8mq_pinctrl_resume(struct device *dev) {
> +	return imx_pinctrl_resume(dev);
> +}
> +
> +static const struct dev_pm_ops imx8mq_pinctrl_pm_ops =3D {

It looks we did not nothing special on the dev_pm_ops for platform drivers.
So do you think if we can move this into common pinctrl-imx.c?
Then platform driver does not need to implement the duplicated things?

Regards
Dong Aisheng

> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(imx8mq_pinctrl_suspend,
> +					imx8mq_pinctrl_resume)
> +};
> +
>  static struct platform_driver imx8mq_pinctrl_driver =3D {
>  	.driver =3D {
>  		.name =3D "imx8mq-pinctrl",
>  		.of_match_table =3D of_match_ptr(imx8mq_pinctrl_of_match),
> +		.pm =3D &imx8mq_pinctrl_pm_ops,
>  		.suppress_bind_attrs =3D true,
>  	},
>  	.probe =3D imx8mq_pinctrl_probe,
> --
> 2.7.4

