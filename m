Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB56C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A6E2173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="abpYqtWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbfKFHpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 02:45:08 -0500
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:18985
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729986AbfKFHpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:45:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jlakg06RjDkIE1KDSVYBM9NXNvTX0Fwk1Z88Xi3zq1CHUAjRilzyKBNy2bnMQJ3kSnkCGaIW/rMABA3Go/ylobXqnvF9LE6pgbaj+S6yzJwhYhzKeiHHifoqF54s2Qdi3TSo0ecTD2GwwEZ3tbj+hhckjkITg1Na5G+LMqY0e4LId+on47IC/v05NUzfmvMiTH7w0mpaWBQlWN+Z1tBA9q+8tCVseuZnp+314mueJfpJhwbtrffWxaayK86B479iuE6tgr1QcznDUqYLcm55O535RfhOGBOdDQdszHyLsDDJRe8xt1lof4hR7xA43xQfJaPrpgxzoEZh5q6yHKL23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEp+4k3DsabS3lPCUEm6IwDjGzuiraozcekKoU0utuw=;
 b=a6u6xnCj7MA/vxhM8vYYLo1qOVqJvsfxbPN/Fsn/EvTqbbBmyiy2UcwY6I/e6mgLv2MH6lfciWepne0rfeuWKRIu8mzLJEhK7cuJ2zCO/tJx10Z5Yi4iQKc9RmFgBLQUQhWTYOXspIHJoXZr1AAExIuXdUbLBy7lnjc6kR4X2u/Bgi8eZwCdjo+XEGlVc4dP9KSpjUNtNQvbpHU/84NXZUGltrHDsbbOWebmjUXta4yjr+e+E4Mkcm1E40JpY7lP7FR20ATe5CAuI6K0Ed9zzlx+UHRR2h1yaU1iRGBUwdRuZP+L0ehQotPFJK2U8mjiVklRjgyHnYsqjldBhb16ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEp+4k3DsabS3lPCUEm6IwDjGzuiraozcekKoU0utuw=;
 b=abpYqtWBQQZdnl6Tt/aXybxHaHaUSxz0YNcM5CNNXun7e2xRLoTI5r3uI/HCTT/JDfecU6kHF4Sq0DIAgzAtpKgVJHND/C8L8lQBmizu3igZJadwyyQD/l9nBqriK9BXkQcYpsqZYug1H8cPb+glISo7H/V16sgDon9RSSCcRT8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB3956.eurprd04.prod.outlook.com (52.134.93.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 07:45:02 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 07:45:01 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] clk: imx: pll14xx: fix clk_pll14xx_wait_lock
Thread-Topic: [PATCH] clk: imx: pll14xx: fix clk_pll14xx_wait_lock
Thread-Index: AQHVlGNoepC2TDBj7kaCYRyt+h3yD6d9w2gA
Date:   Wed, 6 Nov 2019 07:45:01 +0000
Message-ID: <20191106074500.vwihbt6s4dwqyun7@fsr-ub1664-175>
References: <1573018178-14939-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1573018178-14939-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0101CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::25) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44bb08a1-bf45-4b4a-f4ef-08d7628d3b01
x-ms-traffictypediagnostic: AM0PR04MB3956:|AM0PR04MB3956:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB395665F85B4C56349A243B5CF6790@AM0PR04MB3956.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(7916004)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(6512007)(316002)(64756008)(6636002)(5660300002)(66446008)(2906002)(26005)(305945005)(102836004)(7736002)(86362001)(6116002)(76176011)(14444005)(8936002)(8676002)(66476007)(44832011)(66556008)(6506007)(3846002)(66066001)(71200400001)(6436002)(71190400001)(6486002)(478600001)(81166006)(6246003)(99286004)(476003)(9686003)(229853002)(52116002)(386003)(256004)(54906003)(81156014)(446003)(486006)(1076003)(6862004)(4744005)(25786009)(14454004)(66946007)(4326008)(53546011)(33716001)(11346002)(186003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3956;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PoAT/lwDNarbS17vfheekcGmymmENkNYSI+U1qLmqUpBZ2BgO4xBagbMGTLRBW+FWidooLGz4kBjEuH+YgYG8ImGvv5k8czCvwZvggNCQ+8yzD4Yxt4LRG5mDk8RT6eVwwoeq/yJOyEAHnWG5xzZ8wo5GzycKGv+0TaUMuVTfcf1dv7qpjJOhm1/JdF6YsCtCk2Tk0grUY76em95RMnhXkPy/KcExX1XzyGJsvKTE+dWUtrf/7fLpeMxSG08pCED4dR00g5J9gKrK95umpdkajl0cx9cEThmSkaz8RPqiTaehpV9N8y0YGetRRkXTyGxwFG3uRbNhi1eTaLAzToMSVRwtyFPuH4avgsZ0ZyXf0AIZxT8c5aEAg/fo3tDkwAsE+J5eifzHUdSX5JpulyY8S/inmQfE4JUS/1DgK1NLvwHVv5vqhEuvirno9WSdPu7
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C2A340762855A46862663A22A7574CA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bb08a1-bf45-4b4a-f4ef-08d7628d3b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 07:45:01.8697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qHDHv/EU/5rIHVd3bzy4CWxTEnN0HJAlOu8krcC3jnaS+FNLxw5URS1aRaWjAZbTx3kW3dZR5rEA1p/kI2wQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-06 05:31:15, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The usage of readl_poll_timeout is wrong, the cond should be
> "val & LOCK_STATUS" not "val & LOCK_TIMEOUT_US".
>=20
> Fixes: 8646d4dcc7fb ("clk: imx: Add PLLs driver for imx8mm soc")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>=20
> V1:
>  Hi Shawn,
>    This patch is made based on 5.4-rc6, not your for-next branch,
>    not sure whether this patch could catch 5.4 release.
>=20
>  drivers/clk/imx/clk-pll14xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.=
c
> index 7a815ec76aa5..d43b4a3c0de8 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -153,7 +153,7 @@ static int clk_pll14xx_wait_lock(struct clk_pll14xx *=
pll)
>  {
>  	u32 val;
> =20
> -	return readl_poll_timeout(pll->base, val, val & LOCK_TIMEOUT_US, 0,
> +	return readl_poll_timeout(pll->base, val, val & LOCK_STATUS, 0,
>  			LOCK_TIMEOUT_US);
>  }
> =20
> --=20
> 2.16.4
>=20
