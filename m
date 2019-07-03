Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891DEC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD92218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW4JmIPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfGCNFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:05:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34922 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCNFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:05:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so2330604wml.0;
        Wed, 03 Jul 2019 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KH2eG+x8Tg1+duN/dfrI01o6FXkBJqUeFiUf1jFkgyQ=;
        b=BW4JmIPUbKk7pMK8MtLDqli/03LRWL5o69F3Wk9hHVgusTFgWEBelYIOFPgnEiAkxx
         a6W5stinsnu55yOj+pCd1uysnend14STiaeWzHm/hxhwTbKs1f1ZuT/8KR1kwtyRDcs9
         7CyuwDUtEYdkVK1nbw9oTz/Vgtn7X3vNJNvfw0yYFhXhqUzUTg7xI+FrMJQYFvxKrXgj
         Cxj7CtML5rZ+lzAZZnLmz3GcFG4kgcd0EpaFLigTJUhXPmlWAQoNwA768Cih2l9y0HSX
         T30VJPWGBPaiNV2MBOyN2nT8QfBxLhWYorSLR82bYDT6cvpwp/ditZ9MkQWK/QbdK+IV
         YzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KH2eG+x8Tg1+duN/dfrI01o6FXkBJqUeFiUf1jFkgyQ=;
        b=POa8XA4QDinzo6zUfhEDzM69H/kF5jRrHN0jiG1gMwySMgEspojJsHK3X5IBRiqBfB
         /XuzfslcidE+ZWiw4xXRK2+sxxVbJwXVCK15Ugk/jRMtl9HReMilMVNwjEfs2Z0lGlxn
         BM/BJOH5V6Kbn6GPR6nulRYfbKCkmM+NTYLLQyeUi5wQGfTJqphbi+HwgrNE7QuwfvdE
         vBldyCwli2iB0iOXR1XQ/xy0AHXRJpbwAHb2PDb4DJlU8pyOkHUkR7DHoTx/Yd5q5Hqq
         KQcfNEuZpQTqARQ9bX0EIkMzoF+DyOYOdRcSmTLCfZYtpv9GkYwEAkdV95LHF4CCjwsn
         u9ow==
X-Gm-Message-State: APjAAAXumRKBI1NehkAEwZ87L+/Lamwv4ETrTfEj6hgi2T/h903gpzAP
        JspeGyKToFFyCjBeWEgjGxFxsMrejf9WQm//UFjidjRAHIw=
X-Google-Smtp-Source: APXvYqxY84Zmx8oWuSwwzgbMqQpDMtrsx3Me5sgTMeJ67amW0WnvPJVfwdFa1XFxQ2eCxwvf6j5mMN+1RkBNosgAdG0=
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr7668361wmi.73.1562159114636;
 Wed, 03 Jul 2019 06:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <1562155702-29809-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1562155702-29809-1-git-send-email-abel.vesa@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 3 Jul 2019 16:05:02 +0300
Message-ID: <CAEnQRZAje+i1i0Nj2-SgAkdpdEq3-NyOLOt4mxfC_ayd2aD=Bg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mm: Init rates and parents configs for clocks
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 3:10 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Add the initial configuration for clocks that need default parent and rate
> setting. This is based on the vendor tree clock provider parents and rates
> configuration except this is doing the setup in dts rather than using clock
> consumer API in a clock provider driver.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Thanks Abel, this helps audio.  For audio clk:

Acked-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>
> Changes since v1:
>  - removed the PCIE, CSI and DISP clocks parent setting since
>    that should be done from their driver.
>
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 232a741..ba2034d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -451,6 +451,17 @@
>                                          <&clk_ext3>, <&clk_ext4>;
>                                 clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
>                                               "clk_ext3", "clk_ext4";
> +                               assigned-clocks = <&clk IMX8MM_CLK_NOC>,
> +                                               <&clk IMX8MM_CLK_AUDIO_AHB>,
> +                                               <&clk IMX8MM_CLK_IPG_AUDIO_ROOT>,
> +                                               <&clk IMX8MM_SYS_PLL3>,
> +                                               <&clk IMX8MM_VIDEO_PLL1>;
> +                               assigned-clock-parents = <&clk IMX8MM_SYS_PLL3_OUT>,
> +                                                        <&clk IMX8MM_SYS_PLL1_800M>;
> +                               assigned-clock-rates = <0>,
> +                                                       <400000000>,
> +                                                       <750000000>,
> +                                                       <594000000>;
>                         };
>
>                         src: reset-controller@30390000 {
> --
> 2.7.4
>
