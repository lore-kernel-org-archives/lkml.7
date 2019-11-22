Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9723DC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED8A2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ipr0UnoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKVVsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 16:48:30 -0500
Received: from mail-eopbgr30067.outbound.protection.outlook.com ([40.107.3.67]:64039
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbfKVVs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 16:48:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxHR/2/UBq1Q16tU+LQQQjmGGG5cKseq2dxhqxbX9vz+Y9CTgWSj5YgpuvSobm+ooZGU/xM0VqDSK3fcNmf/d5+8RqIFgFtzJSk0HR4yQe6iGQgmO0+bzMIoQdtcWtbUK8ThXruB/rswOoebYFyV25a1/rQE03QB/1Kj51o5Zq0n4/W+W7mQ++lezyk3t99jmTZisPqwhaTS1Pnys/gyQQ4kznmBKO/b6VXDLII8RwLeBca3Sk/a02GHGn+MJdnGIhKyMaQkhoG7b6tWiVr/R6PLhUcQJPHrtGFvEk3PUzHJC1qKzYGry1Z1DManuMgnrP6QcMNMier/MIenm7Bm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy5PXzy/0332xTEXm7r2jrYWu5zB5/tV/TBn5CIgU8I=;
 b=ZJsZcpVfaDSi2lFj/LoiL34YDOoqdNnKFbxLWK0lHkN9jHRYVuhzEz4z8O7iQfCC8Bs0FmImx+J8AFneRt2ZsTLt2uqeX9DdEhMDciFGBFimibQc57PSf0hpKjolop96pnel2ffmoXdxArCXVy8sc3xV+Yxj6ym8bcUmVVJotWgvo6L8pjNAVbtc3hdWz7oHzNhQj/9yWCByD2mFkrRDQdbZZix7p4P36R5Lo4uLKjVkLe142U+fde2gv5QHyS6uYsebGf7G7Oy9Trt23ClcB6Z8C64kCsHNhznzdNL/rOOsD5r2nxFnP1y7caCNXlyr4SRKg22n7m1q1jhNwFINNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy5PXzy/0332xTEXm7r2jrYWu5zB5/tV/TBn5CIgU8I=;
 b=Ipr0UnoZ/+213mBRub9H3MtQg4qBEJVgiqhJPDMhsDQTBNp7qv9pPW1rcVIm/9HBCSrF3Tl0tl0EJrtFRY9TjqnA3P5L0IkSRbZ1CPX/MV4BKq/dHLaCrYhMP/TmHYlLPmhnmzFxF09itsVa2iwSeEhjgawm0pSIHkrSE1Psu5E=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3149.eurprd04.prod.outlook.com (10.170.229.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Fri, 22 Nov 2019 21:48:25 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2474.021; Fri, 22 Nov 2019
 21:48:25 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/11] clk: imx: Add correct failure handling for clk
 based helpers
Thread-Topic: [PATCH v2 01/11] clk: imx: Add correct failure handling for clk
 based helpers
Thread-Index: AQHVoSJWiPUbLE4/j0WIQrxGUo4alw==
Date:   Fri, 22 Nov 2019 21:48:25 +0000
Message-ID: <VI1PR04MB70231491C8375159CB07702BEE490@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
 <1574419679-3813-2-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 110ee35e-7684-4c8f-a374-08d76f95b3af
x-ms-traffictypediagnostic: VI1PR04MB3149:|VI1PR04MB3149:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3149B0CB0C3E17652908C6C7EE490@VI1PR04MB3149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(189003)(199004)(3846002)(66066001)(55016002)(6246003)(102836004)(6436002)(4326008)(71200400001)(71190400001)(86362001)(256004)(2906002)(14444005)(6116002)(186003)(4001150100001)(229853002)(26005)(6506007)(7736002)(74316002)(478600001)(44832011)(110136005)(52536014)(33656002)(9686003)(66946007)(76116006)(91956017)(66446008)(64756008)(66476007)(5660300002)(66556008)(53546011)(305945005)(8936002)(81166006)(446003)(76176011)(25786009)(7696005)(316002)(14454004)(99286004)(81156014)(8676002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3149;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIYZmMj8tgCbtKe5ECjXcsy9homrdZzbjDEwYgG9Hd5OO1s1p4vkFDGFMlQ/yc1I7HLdueDB813TGS4oPa8g0OmJ6dV6j7IVaAZJ7uu22/9/F/LKMV+vAYvpYtpTAVJ7Ka4rdEj3/raxFU07DVl/EL7biU15xxNtqLxUELT3hKaUV5tGm6GbVV8ptRfF4AldJtAQBjM9bOhK20t9bgCBRKegUMMXtODTuQgO9Ox5N4sdof5koPzxh9UJI73jPybXRux9y1exflALfxbaSlrPCaWsyjNvd1+RuC2+XGs/pvBx3UQtvElu+7+3Oms0Aimw4cVSqFBxI/hmwpnISt9NQtb0vd3QECOQdE1uuX++9lMGozS4LA/X3KifyhvoblntKvzlPzc0Fwz+8gMnZl1Flny77RhAwUMINphwyvwMD2PevFoOpt3Qd5kFVrBwd3/p
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110ee35e-7684-4c8f-a374-08d76f95b3af
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 21:48:25.0392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWPC8Juv8g6mikIlOLjqLgH4Ne3ciG8m0IgYDA/23VRvNh4Zj9+WkmcbmqTouCjurA3N1+qP3zNUIE+9xtddiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-22 12:48 PM, Abel Vesa wrote:=0A=
> If the clk_hw based API returns an error, trying to return the clk from=
=0A=
> hw will end up in a NULL pointer dereference. So adding the to_clk=0A=
> checker and using it inside every clk based macro helper we handle that=
=0A=
> case correctly.=0A=
> =0A=
> This to_clk is also temporary and will go away along with the clk based=
=0A=
> macro helpers once there is no user that need them anymore.=0A=
> =0A=
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
> ---=0A=
>   drivers/clk/imx/clk.h | 37 ++++++++++++++++++++++---------------=0A=
>   1 file changed, 22 insertions(+), 15 deletions(-)=0A=
> =0A=
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h=0A=
> index bc5bb6a..30ddbc1 100644=0A=
> --- a/drivers/clk/imx/clk.h=0A=
> +++ b/drivers/clk/imx/clk.h=0A=
> @@ -54,48 +54,48 @@ extern struct imx_pll14xx_clk imx_1416x_pll;=0A=
>   extern struct imx_pll14xx_clk imx_1443x_pll;=0A=
>   =0A=
>   #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \=0A=
> -	imx_clk_hw_cpu(name, parent_name, div, mux, pll, step)->clk=0A=
> +	to_clk(imx_clk_hw_cpu(name, parent_name, div, mux, pll, step))=0A=
>   =0A=
>   #define clk_register_gate2(dev, name, parent_name, flags, reg, bit_idx,=
 \=0A=
>   				cgr_val, clk_gate_flags, lock, share_count) \=0A=
> -	clk_hw_register_gate2(dev, name, parent_name, flags, reg, bit_idx, \=0A=
> -				cgr_val, clk_gate_flags, lock, share_count)->clk=0A=
> +	to_clk(clk_hw_register_gate2(dev, name, parent_name, flags, reg, bit_id=
x, \=0A=
> +				cgr_val, clk_gate_flags, lock, share_count))=0A=
>   =0A=
>   #define imx_clk_pllv3(type, name, parent_name, base, div_mask) \=0A=
> -	imx_clk_hw_pllv3(type, name, parent_name, base, div_mask)->clk=0A=
> +	to_clk(imx_clk_hw_pllv3(type, name, parent_name, base, div_mask))=0A=
>   =0A=
>   #define imx_clk_pfd(name, parent_name, reg, idx) \=0A=
> -	imx_clk_hw_pfd(name, parent_name, reg, idx)->clk=0A=
> +	to_clk(imx_clk_hw_pfd(name, parent_name, reg, idx))=0A=
>   =0A=
>   #define imx_clk_gate_exclusive(name, parent, reg, shift, exclusive_mask=
) \=0A=
> -	imx_clk_hw_gate_exclusive(name, parent, reg, shift, exclusive_mask)->cl=
k=0A=
> +	to_clk(imx_clk_hw_gate_exclusive(name, parent, reg, shift, exclusive_ma=
sk))=0A=
>   =0A=
>   #define imx_clk_fixed_factor(name, parent, mult, div) \=0A=
> -	imx_clk_hw_fixed_factor(name, parent, mult, div)->clk=0A=
> +	to_clk(imx_clk_hw_fixed_factor(name, parent, mult, div))=0A=
>   =0A=
>   #define imx_clk_divider2(name, parent, reg, shift, width) \=0A=
> -	imx_clk_hw_divider2(name, parent, reg, shift, width)->clk=0A=
> +	to_clk(imx_clk_hw_divider2(name, parent, reg, shift, width))=0A=
>   =0A=
>   #define imx_clk_gate_dis(name, parent, reg, shift) \=0A=
> -	imx_clk_hw_gate_dis(name, parent, reg, shift)->clk=0A=
> +	to_clk(imx_clk_hw_gate_dis(name, parent, reg, shift))=0A=
>   =0A=
>   #define imx_clk_gate2(name, parent, reg, shift) \=0A=
> -	imx_clk_hw_gate2(name, parent, reg, shift)->clk=0A=
> +	to_clk(imx_clk_hw_gate2(name, parent, reg, shift))=0A=
>   =0A=
>   #define imx_clk_gate2_flags(name, parent, reg, shift, flags) \=0A=
> -	imx_clk_hw_gate2_flags(name, parent, reg, shift, flags)->clk=0A=
> +	to_clk(imx_clk_hw_gate2_flags(name, parent, reg, shift, flags))=0A=
>   =0A=
>   #define imx_clk_gate2_shared2(name, parent, reg, shift, share_count) \=
=0A=
> -	imx_clk_hw_gate2_shared2(name, parent, reg, shift, share_count)->clk=0A=
> +	to_clk(imx_clk_hw_gate2_shared2(name, parent, reg, shift, share_count))=
=0A=
>   =0A=
>   #define imx_clk_gate3(name, parent, reg, shift) \=0A=
> -	imx_clk_hw_gate3(name, parent, reg, shift)->clk=0A=
> +	to_clk(imx_clk_hw_gate3(name, parent, reg, shift))=0A=
>   =0A=
>   #define imx_clk_gate4(name, parent, reg, shift) \=0A=
> -	imx_clk_hw_gate4(name, parent, reg, shift)->clk=0A=
> +	to_clk(imx_clk_hw_gate4(name, parent, reg, shift))=0A=
>   =0A=
>   #define imx_clk_mux(name, reg, shift, width, parents, num_parents) \=0A=
> -	imx_clk_hw_mux(name, reg, shift, width, parents, num_parents)->clk=0A=
> +	to_clk(imx_clk_hw_mux(name, reg, shift, width, parents, num_parents))=
=0A=
>   =0A=
>   struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,=
=0A=
>   		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);=0A=
> @@ -198,6 +198,13 @@ struct clk_hw *imx_clk_hw_fixup_mux(const char *name=
, void __iomem *reg,=0A=
>   			      u8 shift, u8 width, const char * const *parents,=0A=
>   			      int num_parents, void (*fixup)(u32 *val));=0A=
>   =0A=
> +static inline struct clk *to_clk(struct clk_hw *hw)=0A=
> +{=0A=
> +	if (IS_ERR_OR_NULL(hw))=0A=
> +		return ERR_CAST(hw);=0A=
> +	return hw->clk;=0A=
> +}=0A=
> +=0A=
>   static inline struct clk *imx_clk_fixed(const char *name, int rate)=0A=
>   {=0A=
>   	return clk_register_fixed_rate(NULL, name, NULL, 0, rate);=0A=
> =0A=
=0A=
