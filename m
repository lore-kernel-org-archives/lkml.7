Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52658C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DE72133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivsiGwVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfFZMp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:45:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44693 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZMp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:45:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16so2554549wrl.11;
        Wed, 26 Jun 2019 05:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gAbbihM74t8q2UMVhMTR5xnkBr8o8yTLh+oQn0ML/yk=;
        b=ivsiGwVl83y9FI7hcXLb1AHoNEdPPw9E9/GVHE8u3kTwO1C8LY033LVpyHOqujBrcv
         fw0NnYE0PP94udJQJkCS/lfXLnQKgGmlJDVOjIdNVGpJRX1RQ+UUirq49t3meA4aGvXV
         NVROUsvQBXXhyq4OFtWjLyR8PuheX4BMDJqM4QkRbO7/CZPGwluDHD/CSmzeXFIJQQJ7
         sHcPzkijbaPqD+SQ1HJnRi4lqt5fbzTM2dNYHsEnCmJtagYWSWDmX87cc7KABifuI+94
         lZfmnrS5OL+gbyO/XMLTroey6Dr6fGqd4yhpHSDvQGKb8GBP2Zs9qLWYGGrL6JOAJVgk
         ugDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAbbihM74t8q2UMVhMTR5xnkBr8o8yTLh+oQn0ML/yk=;
        b=ULzn4R65gcGQJNotykoMuoG216VKlF/K2FdRNbyhR71a1lsLGUUnwy7mxj5AWad0jd
         qRzLQtIys4r08U/R4Y2knhEJYkCjbAWwRTOBcd1s6KF7PTN9I6t+aBAXN6o7CN2OH8NB
         rRx+y3oUqQ2fihENX6dQikRHUFtge2sii0flO0MA2Nl7Y+KN+G2848DgNU2jGk82Ugod
         xv89QYTNBIXU7yhYBgnNJ073hjtuIVPpITZIuwLXIalSq3A838iTv+IjtDY7b7rhd1hQ
         OzmKWbA8jRJQK08P47L4QJHh9OPGjgQ6iGlY6pvKYLrugRRrPIN2sLKFCHz5bFjwBmwC
         bKcA==
X-Gm-Message-State: APjAAAXHcrbDwK5EKhKxXOMlcg+rvnYXWgTCP0IHrtGboCDggQ2I8tEN
        Cxc9V6QCPRhv09xpW14bDiByBGhyxvr+5zE0wXI=
X-Google-Smtp-Source: APXvYqyRGuZ6Jz+jv+uDwzSDH3cb2d+5MNQtE2vHFYvNst/k8o0GEq2/zWRO0cYMNYNhC0UOR6kqGelgGOVUFtY8+CA=
X-Received: by 2002:a05:6000:9:: with SMTP id h9mr3617731wrx.212.1561553126908;
 Wed, 26 Jun 2019 05:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <1561469191-26840-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1561469191-26840-1-git-send-email-abel.vesa@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 26 Jun 2019 15:45:15 +0300
Message-ID: <CAEnQRZCVQ0+pRh6akiZJXU-fRugEXmnthZp8Q2=aXFXCO3vcUg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Init rates and parents configs for clocks
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 4:42 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Add the initial configuration for clocks that need default parent and rate
> setting. This is based on the vendor tree clock provider parents and rates
> configuration except this is doing the setup in dts rather than using clock
> consumer API in a clock provider driver.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 36 +++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 232a741..ab92108 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -451,6 +451,42 @@
>                                          <&clk_ext3>, <&clk_ext4>;
>                                 clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
>                                               "clk_ext3", "clk_ext4";
> +                               assigned-clocks = <&clk IMX8MM_CLK_AUDIO_AHB>,
> +                                               <&clk IMX8MM_CLK_IPG_AUDIO_ROOT>,
> +                                               <&clk IMX8MM_SYS_PLL3>,
> +                                               <&clk IMX8MM_VIDEO_PLL1>,
> +                                               <&clk IMX8MM_CLK_NOC>,
> +                                               <&clk IMX8MM_CLK_PCIE1_CTRL>,
> +                                               <&clk IMX8MM_CLK_PCIE1_PHY>,
> +                                               <&clk IMX8MM_CLK_CSI1_CORE>,
> +                                               <&clk IMX8MM_CLK_CSI1_PHY_REF>,
> +                                               <&clk IMX8MM_CLK_CSI1_ESC>,
> +                                               <&clk IMX8MM_CLK_DISP_AXI>,
> +                                               <&clk IMX8MM_CLK_DISP_APB>;
> +                               assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_800M>,
> +                                               <0>,
Isn't there a macro for 0? (dummy clock?)


> +                                               <0>,
> +                                               <0>,
> +                                               <&clk IMX8MM_SYS_PLL3_OUT>,
> +                                               <&clk IMX8MM_SYS_PLL2_250M>,
> +                                               <&clk IMX8MM_SYS_PLL2_100M>,
> +                                               <&clk IMX8MM_SYS_PLL2_1000M>,
> +                                               <&clk IMX8MM_SYS_PLL2_1000M>,
> +                                               <&clk IMX8MM_SYS_PLL1_800M>,
> +                                               <&clk IMX8MM_SYS_PLL2_1000M>,
> +                                               <&clk IMX8MM_SYS_PLL1_800M>;
> +                               assigned-clock-rates = <400000000>,
> +                                                       <400000000>,
> +                                                       <750000000>,
> +                                                       <594000000>,
> +                                                       <0>,
> +                                                       <0>,
> +                                                       <0>,
> +                                                       <0>,
> +                                                       <0>,
> +                                                       <0>,
> +                                                       <500000000>,
> +                                                       <200000000>;
>                         };
>
>                         src: reset-controller@30390000 {
> --
> 2.7.4
>
