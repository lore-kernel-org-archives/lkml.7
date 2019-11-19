Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB048C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2E222310
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xy1PLezG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfKSQ3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:29:07 -0500
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:17113
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728250AbfKSQ3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:29:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAWKJalX5+9v5fuB6VICg8cs2I46/TT2pgewl3G2zRqUfAVU1Bxd5OUQYj6BVOzo9COnwalhbw04J482o9HuY7J7m9LF0SexanJGVPb129Zz9kqng8sG4/nxXGZZBLDSqBnyJRIrllLFHTzwvrL7Wnejv4hz4WVJ1PQoFuTK8tXpvIkNSjP6F1czkKtqr6HaOQxqk+RfXfQ4ZCPyBV5QNL8STs/LAAlbzUV4bbDc/ysZad+EaLRMX7YodtqN2bfxLL3h3pDLtZuky1/Nl/RkAnn5mjyVrWNjJ4p4zcT4w9ul9L4eHtIF7/HA5iB7/qbZI9P8lifUD5ERJHdpp//5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQBs1LaZfCthJ3E7oAloF7Vw+1sjRp1XjUD7VP9SO0Y=;
 b=K0Pinm053mQe+h7T4hjIobg+nUyLaDl5N4bubwuq7s+qK9l/jcCOttaGDuzQLPoaV1NklkZ4XQ6amD9x3DSK/Q51ut/8ULHq6wiTeRdxVBd92Mp0Zn3zwHq9cPWtpVtRIbvxg89smardA7ApYfaaTsRz4G42XUfhj43EhoGe0SDDUtNZRFW9eMAF8RoG6LwWmHlOhLw3BHVSukmZ8gWSD+2bvVziiZ7y65VMluTBROAg3MC48VYtWgsjOMadUswymF65o6i3uYmf0m2NuAwYER3I9BW+YHAJF+TDR9Wt+zENhC5SstgfmQJ1pJQxvHtooYGMRpi7vSi/eVO5Uq/SDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQBs1LaZfCthJ3E7oAloF7Vw+1sjRp1XjUD7VP9SO0Y=;
 b=Xy1PLezGqpCH6rSThBOTJMKZI0DjCfY2/h2O7t1CaTDMgqH//Sa5A4FIGeAsI+Hy2J109IoqZ0Edz49EJbJs12VVko9J+nAWBtYnSMAa8WavHXo/hJhQIicvPGmvD0BU7Zb7YSiJLLp0QPK+QB7afngjC1XmFbWNXgJ/NEwoIZ0=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4816.eurprd04.prod.outlook.com (20.177.50.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Tue, 19 Nov 2019 16:28:59 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 16:28:59 +0000
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
Subject: Re: [PATCH 1/9] clk: imx: Replace all the clk based helpers with
 macros
Thread-Topic: [PATCH 1/9] clk: imx: Replace all the clk based helpers with
 macros
Thread-Index: AQHVnuLYvDo4sHCUk06779AiK5l8jQ==
Date:   Tue, 19 Nov 2019 16:28:59 +0000
Message-ID: <VI1PR04MB70231C5BC647FE63815C194AEE4C0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1574172496-12987-1-git-send-email-abel.vesa@nxp.com>
 <1574172496-12987-2-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db2fbf41-8ea1-409b-a2a8-08d76d0d9503
x-ms-traffictypediagnostic: VI1PR04MB4816:|VI1PR04MB4816:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB481639A80D7FE4A628CDB506EE4C0@VI1PR04MB4816.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(81156014)(256004)(76176011)(5660300002)(478600001)(6246003)(33656002)(4001150100001)(476003)(229853002)(44832011)(71190400001)(9686003)(2906002)(55016002)(71200400001)(486006)(76116006)(14454004)(6436002)(91956017)(26005)(446003)(4326008)(66476007)(64756008)(66556008)(305945005)(102836004)(7736002)(66946007)(25786009)(66446008)(6116002)(3846002)(6506007)(99286004)(186003)(66066001)(110136005)(8936002)(7696005)(8676002)(81166006)(14444005)(54906003)(52536014)(316002)(86362001)(53546011)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4816;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJrYYw1FJ+uV4usqPw83eKlxr5QvMegv9x8KyyGylFHdDjhtnziWCXQ+9fNnvAB9gY1x9HTrHwYXqCTmi24Gxvsb3heZxZeTr++VozJ69uE+6zbEplUCzKh/WTa6KJevav40an8MkoobLA+4E1zgHkVcCGHvZd0mfVF3RLxtMcEEpW+j2nefHFkDi2TZ7a3VUQratE5REaFAMFgMiaFYHGz2T3gTLot8dEyKz+yAxerpffJgvIhVfZjnz3zp8lmIY9B69VWWVSHLGGfn5dbo9AiwU8zqfVmsNsX9oqpYZ31E3JIX4cCXouu7uDncpYEwvESzaJwT5uXMdEz7DFIW+k7wCbDdQvathuJZEOJyoXT5BXbs99zLvBrGJxn3xv+JODnFMa0HGLgXkCkrEUvTZhZvVtfcdrRDfOLfBIDeyXYnh9j2NMCOmmU8VDwQ6+/Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2fbf41-8ea1-409b-a2a8-08d76d0d9503
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 16:28:59.7125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akDsXdZ8tnXv5Gt5XJ5Vk+AH6sAxfUH0crXOzpiqWMI+BFGwWXp5v6rYMdnfwhNGluIqcFQ7DO6WGnyZBCh4DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4816
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-19 4:08 PM, Abel Vesa wrote:=0A=
> Replacing with macros all the clk based API helpers we reduce the code=0A=
> duplication. The end goal is to get rid of all these macros when there=0A=
> will be no more users of the clk based API, that is, when all the i.MX=0A=
> clock provider drivers will be switched completely to the clk_hw based=0A=
> API.=0A=
=0A=
I personally prefer inline functions to macros whenever possible (so =0A=
everything other than for_each and similar).=0A=
=0A=
BTW: All of these macros will crash if the underlying clk_hw =0A=
registration returns null or error.=0A=
=0A=
> This is another step in moving away from the non clk_hw based API usage=
=0A=
> throughout the i.MX clock drivers. The reason for doing that is to=0A=
> have a clear split between the clock provider and the clock consumer API.=
=0A=
> =0A=
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>=0A=
> ---=0A=
>   drivers/clk/imx/clk.h | 39 ++++++++++++---------------------------=0A=
>   1 file changed, 12 insertions(+), 27 deletions(-)=0A=
> =0A=
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h=0A=
> index bc5bb6a..945ce4d 100644=0A=
> --- a/drivers/clk/imx/clk.h=0A=
> +++ b/drivers/clk/imx/clk.h=0A=
> @@ -73,9 +73,18 @@ extern struct imx_pll14xx_clk imx_1443x_pll;=0A=
>   #define imx_clk_fixed_factor(name, parent, mult, div) \=0A=
>   	imx_clk_hw_fixed_factor(name, parent, mult, div)->clk=0A=
>   =0A=
> +#define imx_clk_divider(name, parent, reg, shift, width) \=0A=
> +	imx_clk_hw_divider(name, parent, reg, shift, width)->clk=0A=
> +=0A=
>   #define imx_clk_divider2(name, parent, reg, shift, width) \=0A=
>   	imx_clk_hw_divider2(name, parent, reg, shift, width)->clk=0A=
>   =0A=
> +#define imx_clk_divider_flags(name, parent, reg, shift, width, flags) \=
=0A=
> +	imx_clk_hw_divider_flags(name, parent, reg, shift, width, flags)->clk=
=0A=
> +=0A=
> +#define imx_clk_gate(name, parent, reg, shift) \=0A=
> +	imx_clk_hw_gate(name, parent, reg, shift)->clk=0A=
> +=0A=
>   #define imx_clk_gate_dis(name, parent, reg, shift) \=0A=
>   	imx_clk_hw_gate_dis(name, parent, reg, shift)->clk=0A=
>   =0A=
> @@ -97,6 +106,9 @@ extern struct imx_pll14xx_clk imx_1443x_pll;=0A=
>   #define imx_clk_mux(name, reg, shift, width, parents, num_parents) \=0A=
>   	imx_clk_hw_mux(name, reg, shift, width, parents, num_parents)->clk=0A=
>   =0A=
> +#define imx_clk_fixed(name, rate) \=0A=
> +	imx_clk_hw_fixed(name, rate)->clk=0A=
> +=0A=
>   struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,=
=0A=
>   		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);=0A=
>   =0A=
> @@ -198,11 +210,6 @@ struct clk_hw *imx_clk_hw_fixup_mux(const char *name=
, void __iomem *reg,=0A=
>   			      u8 shift, u8 width, const char * const *parents,=0A=
>   			      int num_parents, void (*fixup)(u32 *val));=0A=
>   =0A=
> -static inline struct clk *imx_clk_fixed(const char *name, int rate)=0A=
> -{=0A=
> -	return clk_register_fixed_rate(NULL, name, NULL, 0, rate);=0A=
> -}=0A=
> -=0A=
>   static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int rat=
e)=0A=
>   {=0A=
>   	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);=0A=
> @@ -224,13 +231,6 @@ static inline struct clk_hw *imx_clk_hw_fixed_factor=
(const char *name,=0A=
>   			CLK_SET_RATE_PARENT, mult, div);=0A=
>   }=0A=
>   =0A=
> -static inline struct clk *imx_clk_divider(const char *name, const char *=
parent,=0A=
> -		void __iomem *reg, u8 shift, u8 width)=0A=
> -{=0A=
> -	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,=0A=
> -			reg, shift, width, 0, &imx_ccm_lock);=0A=
> -}=0A=
> -=0A=
>   static inline struct clk_hw *imx_clk_hw_divider(const char *name,=0A=
>   						const char *parent,=0A=
>   						void __iomem *reg, u8 shift,=0A=
> @@ -240,14 +240,6 @@ static inline struct clk_hw *imx_clk_hw_divider(cons=
t char *name,=0A=
>   				       reg, shift, width, 0, &imx_ccm_lock);=0A=
>   }=0A=
>   =0A=
> -static inline struct clk *imx_clk_divider_flags(const char *name,=0A=
> -		const char *parent, void __iomem *reg, u8 shift, u8 width,=0A=
> -		unsigned long flags)=0A=
> -{=0A=
> -	return clk_register_divider(NULL, name, parent, flags,=0A=
> -			reg, shift, width, 0, &imx_ccm_lock);=0A=
> -}=0A=
> -=0A=
>   static inline struct clk_hw *imx_clk_hw_divider_flags(const char *name,=
=0A=
>   						   const char *parent,=0A=
>   						   void __iomem *reg, u8 shift,=0A=
> @@ -274,13 +266,6 @@ static inline struct clk *imx_clk_divider2_flags(con=
st char *name,=0A=
>   			reg, shift, width, 0, &imx_ccm_lock);=0A=
>   }=0A=
>   =0A=
> -static inline struct clk *imx_clk_gate(const char *name, const char *par=
ent,=0A=
> -		void __iomem *reg, u8 shift)=0A=
> -{=0A=
> -	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,=
=0A=
> -			shift, 0, &imx_ccm_lock);=0A=
> -}=0A=
> -=0A=
>   static inline struct clk_hw *imx_clk_hw_gate_flags(const char *name, co=
nst char *parent,=0A=
>   		void __iomem *reg, u8 shift, unsigned long flags)=0A=
>   {=0A=
> =0A=
=0A=
