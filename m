Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99A1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66AE218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pfC5KEvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfCUQfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:35:16 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:57351
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727138AbfCUQfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/u+B3qK3TpZpPTtp+BQx98tjD++umDObuXYeMfVUlw=;
 b=pfC5KEvw/9jM2pP4Ey5B0aXMyuf1M361at4yGV6LEDO0zONOBZAaMtOendaYNcOViHVlToqw8p3cU5DgGtxVPA4vAVjKq4eG4U17XKTwf4vuVLVWh/UxeZLNVHetNtYFbqk8mGZIkZD0AMpjOhRTUNQnlGdV9+IZ5sajKJbudpY=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5714.eurprd04.prod.outlook.com (20.178.119.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Thu, 21 Mar 2019 16:35:11 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Thu, 21 Mar 2019
 16:35:11 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Rob Herring <robh@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx6q: Do not reparent unregistered
 IMX6QDL_CLK_PERIPH2
Thread-Topic: [PATCH] clk: imx6q: Do not reparent unregistered
 IMX6QDL_CLK_PERIPH2
Thread-Index: AQHU30AlQ7uX5WNrk0iZ5CsAK+rIh6YWSZqA
Date:   Thu, 21 Mar 2019 16:35:11 +0000
Message-ID: <20190321163511.qa267pvzgt3n57rn@fsr-ub1664-175>
References: <1553101958-13457-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553101958-13457-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfcba330-ac4e-43aa-7c9c-08d6ae1b3067
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5714;
x-ms-traffictypediagnostic: AM0PR04MB5714:
x-microsoft-antispam-prvs: <AM0PR04MB5714FBB364980BBBAE4EA95BF6420@AM0PR04MB5714.eurprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(346002)(366004)(136003)(376002)(39860400002)(199004)(189003)(44832011)(6486002)(81166006)(68736007)(305945005)(7736002)(8676002)(81156014)(229853002)(6636002)(6246003)(106356001)(105586002)(53936002)(186003)(6436002)(6116002)(8936002)(6512007)(9686003)(76176011)(66066001)(3846002)(110136005)(54906003)(102836004)(316002)(4326008)(14454004)(25786009)(97736004)(2906002)(478600001)(6506007)(26005)(53546011)(1076003)(11346002)(5660300002)(71200400001)(71190400001)(476003)(256004)(33716001)(86362001)(99286004)(486006)(446003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5714;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lfUPkyZEncQ+GFEY47bMPNLvFhRL7iF29ClYXXh+gn867rrqF5/tupzSb1EmOLWEUbn0qQdIS9kEJbbHh1YtYClU1vhCM9zngVjPpNCs8GQg32yo2uMXKWgqwdR+nEuavbnEPocXbdZ4hv545ROXpSTERZ+ZiIFgGDU5cmXdG/LumC/jLL18M0xIN0RKjax+EOWMJ/P7g4rxGKMgOUr4lsP74m1TB6cVPcrRSFwN8gH3u3GYCT4KiwMZzh816StVk6K7EmmH1xdfn4/6UpoDg2rUYIlqxVu1L5x3dWCw8oRgqN2UJ1hmRTEutmMw0Wuo/Qwy9T+5aExD/Mpb2nv2V42HoR6j0pKiO+zx0w9fTq5+CAy3pW453xKDe6K9kz5pLS2oPyaykcWPv0eqKbEDnlQKbATQwFU5wLDtPbqHLD8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2FA7AD599F89E4399E0C608A2269174@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcba330-ac4e-43aa-7c9c-08d6ae1b3067
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 16:35:11.7761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5714
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-03-20 17:12:49, Abel Vesa wrote:
> The clock is registered later then these two re-parentings
>=20

Ignore this patch. I'll send a patchset which has another fix for
another case like this one (plus the fix for the typo).

The patchset is actually switching all the imx6 and imx7 clocks
to clk_hw based API, but will include all the necessary fixes
for that to work.

> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6q.c | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
> index 708e7c5..c7b671e 100644
> --- a/drivers/clk/imx/clk-imx6q.c
> +++ b/drivers/clk/imx/clk-imx6q.c
> @@ -291,12 +291,6 @@ static void mmdc_ch1_disable(void __iomem *ccm_base)
>  	clk_set_parent(clk[IMX6QDL_CLK_PERIPH2_CLK2_SEL],
>  		       clk[IMX6QDL_CLK_PLL3_USB_OTG]);
> =20
> -	/*
> -	 * Handshake with mmdc_ch1 module must be masked when changing
> -	 * periph2_clk_sel.
> -	 */
> -	clk_set_parent(clk[IMX6QDL_CLK_PERIPH2], clk[IMX6QDL_CLK_PERIPH2_CLK2])=
;
> -
>  	/* Disable pll3_sw_clk by selecting the bypass clock source */
>  	reg =3D readl_relaxed(ccm_base + CCM_CCSR);
>  	reg |=3D CCSR_PLL3_SW_CLK_SEL;
> @@ -311,8 +305,6 @@ static void mmdc_ch1_reenable(void __iomem *ccm_base)
>  	reg =3D readl_relaxed(ccm_base + CCM_CCSR);
>  	reg &=3D ~CCSR_PLL3_SW_CLK_SEL;
>  	writel_relaxed(reg, ccm_base + CCM_CCSR);
> -
> -	clk_set_parent(clk[IMX6QDL_CLK_PERIPH2], clk[IMX6QDL_CLK_PERIPH2_PRE]);
>  }
> =20
>  /*
> --=20
> 2.7.4
> =
