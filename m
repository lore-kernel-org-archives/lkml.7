Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BE0C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FD121473
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cDZAlHip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfD1G1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:27:23 -0400
Received: from mail-eopbgr10051.outbound.protection.outlook.com ([40.107.1.51]:21799
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfD1G1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSXfUGclX286F/FD9eW26ISMrEAeFDAVts1D/2i82GE=;
 b=cDZAlHipxzDyb4m6ppn1p+k+e7CZQH9Ye08aA7lC3zQt1d4dftHvZsVSArxNUuo2WY07kuK9xnfPxvDALz8E9rdTUmdBYhnhKYqjalTpHuS3dmMNxnZyIVQ15CFNYhu6x8knwf125i1BDSrWHun+PuWlHZbt0iplUFIHjE5agnE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3898.eurprd04.prod.outlook.com (52.134.65.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Sun, 28 Apr 2019 06:27:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.016; Sun, 28 Apr 2019
 06:27:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] mailbox: imx: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH] mailbox: imx: use devm_platform_ioremap_resource() to
 simplify code
Thread-Index: AQHU6Enp8Rg1WsmI0EedzzVUaGgENqZRRjxg
Date:   Sun, 28 Apr 2019 06:27:17 +0000
Message-ID: <DB3PR0402MB39164C6D8A02B53E1F224232F5380@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554095441-15220-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554095441-15220-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 436fc123-6230-40e1-8db6-08d6cba28f98
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3898;
x-ms-traffictypediagnostic: DB3PR0402MB3898:
x-microsoft-antispam-prvs: <DB3PR0402MB38987931F71558CF6C0935F5F5380@DB3PR0402MB3898.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(136003)(376002)(189003)(13464003)(199004)(71190400001)(102836004)(6246003)(256004)(110136005)(2201001)(97736004)(2906002)(15650500001)(64756008)(66476007)(66556008)(476003)(5660300002)(71200400001)(478600001)(11346002)(86362001)(446003)(73956011)(76116006)(66066001)(66446008)(66946007)(186003)(7696005)(6436002)(26005)(76176011)(33656002)(55016002)(486006)(7736002)(14454004)(52536014)(8936002)(68736007)(74316002)(99286004)(305945005)(44832011)(6116002)(81156014)(229853002)(3846002)(8676002)(53546011)(53936002)(4326008)(81166006)(2501003)(9686003)(316002)(25786009)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3898;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cVK7SjVPc+73c5jtCA6Dgcuu0bDiXEJzE3hipTJBKYUSTdRbtLBgL/oKzKQ1aTtlF44/GT+tgLepC/C8lU4Wqeq/Mcgjq5aUPh2JTo8+kHl6e1QnExsOuT3NSwjPmkvI3WwmULyTPg/uore5JKa1ffQtoa88sQbt6tUJhhcWxwoFSTuYAasBucTDeffZwuasT84UWBi+x7lZbOcKM1SX4mHp36me6CSL+zcOSaUidWr15ZtZbUYN7Fe1Symq+Z1IilppF62BhTyiVjw1Up0KM6BDoQ3Phnj+hDY+YHvwq6MkdE042AzBOJfSPJ1QQycJzHl2nD8zeBb7+Dfp7sJaauL2OZBRo5PrkpU5XMEZN74kR7zZ3vPfjpGgPpu34UfQBZxrFYq2NNY7CB69rHYUvuzVYhD3MP+GYTox05azalE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436fc123-6230-40e1-8db6-08d6cba28f98
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 06:27:17.2783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

> -----Original Message-----
> From: Anson Huang
> Sent: Monday, April 1, 2019 1:15 PM
> To: jassisinghbrar@gmail.com; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: [PATCH] mailbox: imx: use devm_platform_ioremap_resource() to
> simplify code
>=20
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to simplify
> the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/mailbox/imx-mailbox.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.=
c
> index 85fc5b5..25be8bb 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -264,7 +264,6 @@ static int imx_mu_probe(struct platform_device
> *pdev)  {
>  	struct device *dev =3D &pdev->dev;
>  	struct device_node *np =3D dev->of_node;
> -	struct resource *iomem;
>  	struct imx_mu_priv *priv;
>  	unsigned int i;
>  	int ret;
> @@ -275,8 +274,7 @@ static int imx_mu_probe(struct platform_device
> *pdev)
>=20
>  	priv->dev =3D dev;
>=20
> -	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->base =3D devm_ioremap_resource(&pdev->dev, iomem);
> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
>=20
> --
> 2.7.4

