Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489E1C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163FA218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYCglz3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGCNGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:06:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35054 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfGCNGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:06:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id c27so2761550wrb.2;
        Wed, 03 Jul 2019 06:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zEixiL4IxxmhE1EEgRXYpM6GetKrTFh5N1jJDqD0OKY=;
        b=FYCglz3/YDkXa9BPSo5eBu3PK4LvTIUNrRLUJ30Gj73v7a/bJ3hazz+Zoq/ax9ppLX
         8ojk4XxS3b2uVAF1DFg+LLJxg/M1Qxsa1yew4s2mn88WoY1W7IWilpcOmNrABvzjHTcX
         WYPQyF8TIUaWVHThZ8OF6T3sXfOerACUIML9OKsUtkhUb/3Ihm4QjjZLV7Ru5CztEDdn
         Faf/FtX/YqLo7kFx2AV/PBntiObLJ/1sZSnci8srwDU39H0f8wB6K9QQXJHswsfCFZkz
         HRYkxM9tKgSrbBN8bveZnnsF8ES2FEPZIbQBn7QWQGwWFvQDZPp7C72i45japewGdMLC
         kaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEixiL4IxxmhE1EEgRXYpM6GetKrTFh5N1jJDqD0OKY=;
        b=DicskbDpzaJh0Z1gkLSrgMQMqTZWkOjjJsa7CYk86mV1Dnqa9sUTU3IbbEXfsxbW6x
         dSekBKZnT6pigWAX0bn18QXLSwovzdA5iG53k0GtzrWlYjXfau+QysWuP8LjC2XVN1aw
         JrhaVBAFPKJ3Npf5c0KXWXQyfkh7bUoqITjYOSW0AdyEhazBQXB9NOjYdb7l9hGDmoPj
         iLlh2bKsB6e2EJ2ZFWucrMCya6qnX4QGhTFatHmRIdEFHC+tDiUrMS4HzVnmKX6J6u1Z
         5FGsD8jMjgiWid0d4UyZWgonA6GOt3oWWJmQDrUVA4SXSzaLLWSFMo+mMtS6EYGupcuW
         55mg==
X-Gm-Message-State: APjAAAUCOGBwQdrnOABGksSp0lO8Dw6Ct0wNzqzGFgxw8MybLoE1DAO4
        BXqt99IrZD5/+hhKJqj6Aqez2VB/p7M26Ruc3sk=
X-Google-Smtp-Source: APXvYqyzkJF+FxAdtC5PrIBb3sVvDSb/XQN7bxmoIvvhhsxHRWKKj8Y8j5QNIWFRUek6SCIg8jt8R81BRxXQ/Bhq30c=
X-Received: by 2002:adf:b69a:: with SMTP id j26mr21756159wre.93.1562159160916;
 Wed, 03 Jul 2019 06:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <1562155311-24696-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1562155311-24696-1-git-send-email-abel.vesa@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 3 Jul 2019 16:05:49 +0300
Message-ID: <CAEnQRZBK7EYVhbGpFeC79HxU=h0OcXU_SSeaMWbp+Qk=rf=14g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mq: Init rates and parents configs for clocks
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 3:03 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Add the initial configuration for clocks that need default parent and rate
> setting. This is based on the vendor tree clock provider parents and rates
> configuration except this is doing the setup in dts rather then using clock
> consumer API in a clock provider driver.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

For audio related clock:
Acked-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>
> Changes since v1:
>  - removed the PCIE and CSI clocks parent setting since
>    that should be done from their driver, as suggested
>    by Leonard.
>
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index d09b808..c286f20 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -489,6 +489,20 @@
>                                 clock-names = "ckil", "osc_25m", "osc_27m",
>                                               "clk_ext1", "clk_ext2",
>                                               "clk_ext3", "clk_ext4";
> +                               assigned-clocks = <&clk IMX8MQ_VIDEO_PLL1>,
> +                                       <&clk IMX8MQ_CLK_AHB>,
> +                                       <&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
> +                                       <&clk IMX8MQ_CLK_AUDIO_AHB>,
> +                                       <&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,
> +                                       <&clk IMX8MQ_CLK_NOC>;
> +                               assigned-clock-parents = <0>,
> +                                               <&clk IMX8MQ_SYS1_PLL_133M>,
> +                                               <&clk IMX8MQ_SYS1_PLL_266M>,
> +                                               <&clk IMX8MQ_SYS2_PLL_500M>,
> +                                               <&clk IMX8MQ_CLK_27M>,
> +                                               <&clk IMX8MQ_SYS1_PLL_800M>;
> +                               assigned-clock-rates = <593999999>;
> +
>                         };
>
>                         src: reset-controller@30390000 {
> --
> 2.7.4
>
