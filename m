Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D4EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C96620850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MfF1t+e9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfCYTPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:15:33 -0400
Received: from mail-eopbgr30067.outbound.protection.outlook.com ([40.107.3.67]:16768
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728912AbfCYTPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWtgkseKPZLQZcGwh4Y47morVYH8LNXvXhPXPaUBCjo=;
 b=MfF1t+e9EpOKOsuu4LNYHflmpnizdrCcGnGRMh2nUa7Je/u2BZXQ0Ph3oGVMjjoIwZAkTfSNwZCmbj5G0j7MSYlMh30GJYf7Dubnp59bhGt1sVZoEXn/4N7nfjdeSqKyqE6s/MhhB3AWtQSFm50DDKRZAMYlE7SvoeClbcx/niQ=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB4759.eurprd04.prod.outlook.com (20.177.32.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Mon, 25 Mar 2019 19:15:27 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::4801:29e5:12d6:cbeb]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::4801:29e5:12d6:cbeb%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 19:15:27 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Ying Zhang <ying.zhang22455@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "upstream-release@linux.nxdi.nxp.com" 
        <upstream-release@linux.nxdi.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [RESEND] i2c: imx: defer probing on dma channel request
Thread-Topic: [RESEND] i2c: imx: defer probing on dma channel request
Thread-Index: AQHU4x+pQFXrzMNg3ku/zKZMNcZI8qYct23A
Date:   Mon, 25 Mar 2019 19:15:27 +0000
Message-ID: <AM6PR04MB58633D7FDB038AFADD5547218F5E0@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
In-Reply-To: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e53613e-6c64-439a-1ddd-08d6b1563d80
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4759;
x-ms-traffictypediagnostic: AM6PR04MB4759:
x-microsoft-antispam-prvs: <AM6PR04MB4759B950A7AB127ED8BDEA218F5E0@AM6PR04MB4759.eurprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(13464003)(199004)(86362001)(14454004)(476003)(66066001)(8936002)(53936002)(9686003)(81156014)(8676002)(81166006)(99286004)(486006)(256004)(14444005)(97736004)(52536014)(3846002)(25786009)(6246003)(2906002)(71200400001)(4326008)(6116002)(2501003)(71190400001)(102836004)(33656002)(26005)(7696005)(106356001)(54906003)(5660300002)(478600001)(53546011)(316002)(11346002)(446003)(110136005)(6506007)(55016002)(6436002)(186003)(7736002)(305945005)(68736007)(105586002)(229853002)(76176011)(6636002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4759;H:AM6PR04MB5863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iyfRpd/RfXEjgprDsJIjuVlxwyQ9UfBtKCFKshpspjiPopmzWszCRgU1MjraO1ALJ0Z4bfSg7fenoBpy1XFFhGnuME1SD9MC89uv7y3bVvREego7lYVyue9WlEFjovyFwC8EPlWiYxcuHzp4TywGA3AIlfLdbOnBp3pZe1Ptax7QS1eLAj7TiOMA3Hvj8VbhjYtl9jl/A2pfIvpv+98EvFIZq74O5PQQAZpqcgrSvWvw0ZYjSkeEq7oyL1x0xNcx2kUYR2A6UCxp5zKu8q+eA/cMcnNSUtrUNQKe0c5JI5GjIuY1j56/nOfhQs8HxKDcf/VfqvT8aVgzYz2+K4KTLjTI6uATNyj+yPNZzw2m4C94J38xzGPOrziNhB6lNn0GoNCRmepFLlUr9WYddBLVcOdoru9lJqwTY2QVzivAU+A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e53613e-6c64-439a-1ddd-08d6b1563d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 19:15:27.5473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: laurentiu.tudor@nxp.com <laurentiu.tudor@nxp.com>
> Sent: Monday, March 25, 2019 10:30 AM
> To: linux-i2c@vger.kernel.org; Ying Zhang <ying.zhang22455@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; upstream-
> release@linux.nxdi.nxp.com; Leo Li <leoyang.li@nxp.com>; Laurentiu Tudor
> <laurentiu.tudor@nxp.com>
> Subject: [RESEND] i2c: imx: defer probing on dma channel request
>=20
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>=20
> If the dma controller is not yet probed, defer i2c probe.
> The error path in probe was slightly modified (no functional change) to a=
void
> triggering this WARN_ON():
> "cg-pll0-div1 already disabled
> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb=
0"

You are removing clk_disable_unprepare() from all error paths except the ir=
q error.  Not sure why this is needed.

>=20
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c =
index
> 42fed40198a0..4e34b1572756 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1111,7 +1111,8 @@ static int i2c_imx_probe(struct platform_device
> *pdev)
>  				pdev->name, i2c_imx);
>  	if (ret) {
>  		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
> -		goto clk_disable;
> +		clk_disable_unprepare(i2c_imx->clk);
> +		return ret;
>  	}
>=20
>  	/* Init queue */
> @@ -1161,19 +1162,25 @@ static int i2c_imx_probe(struct platform_device
> *pdev)
>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
>=20
> +	/* Init DMA config if supported */
> +	ret =3D i2c_imx_dma_request(i2c_imx, phy_addr);
> +	if (ret) {
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_info(&pdev->dev, "can't use DMA, using PIO
> instead.\n");
> +		else
> +			goto del_adapter;
> +	}
> +
>  	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
>  	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
>  	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
>  		i2c_imx->adapter.name);
>=20
> -	/* Init DMA config if supported */
> -	ret =3D i2c_imx_dma_request(i2c_imx, phy_addr);
> -	if (ret < 0)
> -		goto clk_notifier_unregister;
> -
>  	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>  	return 0;   /* Return OK */
>=20
> +del_adapter:
> +	i2c_del_adapter(&i2c_imx->adapter);
>  clk_notifier_unregister:
>  	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
>  rpm_disable:
> @@ -1182,8 +1189,6 @@ static int i2c_imx_probe(struct platform_device
> *pdev)
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>=20
> -clk_disable:
> -	clk_disable_unprepare(i2c_imx->clk);
>  	return ret;
>  }
>=20
> --
> 2.17.1

