Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D89C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBEF2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oegsddYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfC1HbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:31:25 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:38126
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfC1HbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flUYwiX+AjqSGFZriUWsRLchqTlT741+fu1RknlrIzA=;
 b=oegsddYtYtXkm1XRxaJzNPzIk8k77iUCvUsg8DMyHD+sfcuz7AEbRsCQ8XM8pV8nZkKoGzlcNv2jPV1VMFdJQDBRRgwuGWNVw2ZFMKrjOJIEiheWHT7gbzGbpYSVM2RBDZStXwDR+EJXfEolOxcGclLS+vPBvYU/soQUN3l3vrE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5537.eurprd04.prod.outlook.com (20.178.115.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Thu, 28 Mar 2019 07:31:20 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b%4]) with mapi id 15.20.1750.014; Thu, 28 Mar 2019
 07:31:20 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
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
        <upstream-release@linux.nxdi.nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: [RESEND] i2c: imx: defer probing on dma channel request
Thread-Topic: [RESEND] i2c: imx: defer probing on dma channel request
Thread-Index: AQHU4x+pU7Pzng1m0kSKhkHj16iqyqYgqMpw
Date:   Thu, 28 Mar 2019 07:31:20 +0000
Message-ID: <AM0PR04MB4211B411E79CD286AB33E25580590@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
In-Reply-To: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2aac88a3-6916-491c-8fd7-08d6b34f5f8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5537;
x-ms-traffictypediagnostic: AM0PR04MB5537:
x-microsoft-antispam-prvs: <AM0PR04MB5537754AC479EB97CF3C14A880590@AM0PR04MB5537.eurprd04.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(86362001)(97736004)(99286004)(81166006)(6116002)(68736007)(6636002)(105586002)(5660300002)(8936002)(33656002)(4326008)(14444005)(71200400001)(81156014)(8676002)(229853002)(256004)(55016002)(71190400001)(6246003)(44832011)(6436002)(305945005)(2906002)(53936002)(9686003)(7736002)(110136005)(102836004)(316002)(3846002)(54906003)(186003)(76176011)(26005)(106356001)(446003)(66066001)(476003)(25786009)(11346002)(6506007)(14454004)(52536014)(2501003)(7696005)(486006)(74316002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5537;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ixx+8ik8+MDluaTxyv0bDZovixycw8tgSTHvvkys4fuRLGE88CQE4j6q6qdc/+kAlqe9zVIUkvCFpp6BMQ+0wnmxHa4wTj4PMjxgW41+o5W5Akwu7DAFeR/PI5o/2DgKNN4a2DHRtureV9Udl/sZPBWPD4y7tHj5VJF+bj2cLXdxh6vpoMXDbNhKwh6xPHpPtVa+X7wxW3+rCU6RLktNSkJsXkK2KCFns91vV+p19U8af4cyYUwcpeD1ngi8UeGLYV5GUvm/PR+n5sCFisSU+nrSXLURJezy/3SPWiGyL2u9sahIDAf8zrdm/IV/MBjs1GC1qNiLRjmHMeUjaFZ8cMUcdJvqst2+FJnY6iI3saXu/Mu54QHducgryCMjW9Tov8SbrqZwIffnKbTy/xTxs5IwPsZzCIJLPlFOEHSLE5E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aac88a3-6916-491c-8fd7-08d6b34f5f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 07:31:20.4502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5537
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: laurentiu.tudor@nxp.com [mailto:laurentiu.tudor@nxp.com]
> Sent: Monday, March 25, 2019 11:30 PM
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

We may need more information to understand how this issue happens and it's =
also
better to put them in commit message to help review.

Regards
Dong Aisheng

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
> +			dev_info(&pdev->dev, "can't use DMA, using PIO instead.\n");
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

