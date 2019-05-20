Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE762C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A19214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KRuSI92X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfETRtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:49:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40925 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfETRtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:49:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id r136so10668948oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMu5z9Pb1JYnZ/S7r9n3dN5Znr+GV/uPeHM78vQFblM=;
        b=KRuSI92XIgS95pGI3LCda2ZEvswitp1vv2OAChZPPfbBnF2ZbmyL37TbD8BcOpbaam
         YqD/hVyKk7Y14DQrWjWC02oHqiMs2HfnYeX6J2DX79jdEHn2dThmNcVCLIJHe5hahOUO
         DdDPZABLzVzQB9/r7QxW96TGDS44zWI/hCR9kUqs1FjNaq3EX9+dHD4TTOZZYvN3rb6p
         ABZSAq/hHZ7m1KvGqtuIM5uo3Jt4mgkuJBZ0rYwiMhWZc3Xf5fvnLO6e8cLKLwcpvvbo
         xpr47oLIs15cFdTY5NapQkialIZPY7BVmq7yylmpdu+pW6qX6yY2KFd6pDYvag6FHSL1
         wJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMu5z9Pb1JYnZ/S7r9n3dN5Znr+GV/uPeHM78vQFblM=;
        b=ZIoIGnoImx0wZrozBCTU14UvBjRTb5c3ib1YVXD5dWQupF6HrB/X1FE7KWPvBqDCxP
         7XYJL1GlMJcm7uxm+r9WfJ5vS9FbEtcpibJbH1/UMsYadHUnn0MaJKfiIThmAiQpg3//
         tEijVR1wuWA7zFNG6JRL9jlYHIyzcBe00fj2AfTMmW8Yrwvx+50YPKjkzRls+m1p0hC3
         KacD/Jseva4ctB0F3MIE/CMxWAHKJn27rvLzB7FtpmahRIApgQT4akSpifWfildn9xKI
         QgAf1+O1QtYSAGCo4vey3RphmUve/F0TDqKf7w1VWmfjl4YWqjnbBIHoMCCHM8Tz88EB
         gm9Q==
X-Gm-Message-State: APjAAAVQQmiKcxwZsX7MKz1oOLQ38Uz47wfvcu3WXDUm2oNJMn1SctnW
        X1iXgzvfTY9/LydSa9QHy2Z/MxuDbdUid3dMpB/iftYBtB0=
X-Google-Smtp-Source: APXvYqzSgtPQegeT7Oj7PJgF8RjjJD8LkIdVdZGUr+tv94JHftdUknSgFg6oCu6UiaXRH1rM0RgY5cG0AhLn0g5BtK4=
X-Received: by 2002:aca:5b06:: with SMTP id p6mr260281oib.129.1558374579199;
 Mon, 20 May 2019 10:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190520134336.24737-1-narmstrong@baylibre.com>
In-Reply-To: <20190520134336.24737-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:49:28 +0200
Message-ID: <CAFBinCCvERE1V9aBhwNadwPRAi3Fy3EPQ_MGTGX23CQaHi0_kA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson-g12a-x96-max: Add Gigabit Ethernet Support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, May 20, 2019 at 3:43 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Enable the network interface of the X96 Mac using an external
> Realtek RTL8211F gigabit PHY, needing the same broken-eee properties
> as the previous Amlogic SoC generations.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> index 5cdc263b03e6..5ca79109c250 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> @@ -15,6 +15,7 @@
>
>         aliases {
>                 serial0 = &uart_AO;
> +               ethernet0 = &ethmac;
>         };
>         chosen {
>                 stdout-path = "serial0:115200n8";
> @@ -150,6 +151,27 @@
>         pinctrl-names = "default";
>  };
>
> +&ext_mdio {
> +       external_phy: ethernet-phy@0 {
> +               /* Realtek RTL8211F (0x001cc916) */
> +               reg = <0>;
> +               max-speed = <1000>;
> +               eee-broken-1000t;
do we still need eee-broken-1000t? there are only 2 boards left which
set it and I'm not sure whether those still need it after Carlo's
fixes

> +       };
> +};
> +
> +&ethmac {
> +       pinctrl-0 = <&eth_rmii_pins>, <&eth_rgmii_pins>;
Jerome renamed "eth_rmii_pins" to "eth_pins" in v2 of his Ethernet
pinctrl patch: [0]
you missed his update only by a few minutes


Martin


[0] https://patchwork.kernel.org/patch/10951103/
