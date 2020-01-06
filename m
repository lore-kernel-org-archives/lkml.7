Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB834C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8806F21775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="jASuboOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgAFGrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 01:47:53 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34910 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAFGrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 01:47:53 -0500
Received: by mail-qv1-f68.google.com with SMTP id u10so18579263qvi.2;
        Sun, 05 Jan 2020 22:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OdrXgm2hCs01du+T8UYcvLNB/t0F3MI2dMgKBoMDV58=;
        b=jASuboOcMoZrLoqU/58dsKJaW1ZpB5TQiGXmSHu6SuvnehwUeL1CJeFtoo9nQp0FEs
         CWESkJ0rOS4Qq0CalTbKpRblev+e3NOD+9gEi5VhN6HHSb3/ITuJAgpp+WZxZZr4IUJs
         Q0XLeHEEEKx5RnlTMXJZY9O/IjXblGdD9WS1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OdrXgm2hCs01du+T8UYcvLNB/t0F3MI2dMgKBoMDV58=;
        b=Rtr+MgrUtFdOHJ5ztaqHA+JaR3fZEfhF+ax64mz6lC3WIcLTYwKm5/JHIjAmyCYnV5
         6vZWIW3Vh8yNhHofBy13X62PoP+kpFkseXjQrQ+7t+b2WHB71FYlVa1dWMCUfB4RoVMf
         W09IljnO3+1qRdPA98Oi0NcKUyC1RFD9v0Ovy7mMdnDAwvgdnAbi3gDguCFx/5HPAPtN
         YX3uNWZTg3LXDjSgoCzHhg+tatu1aOmEgvFckYch30sMFQzLvJhwxZmHeu73wIlnGqnO
         0p0L/2j3j5pTbLVvP4k2gjzFPA5hsWiW47hTuC8EK31h8+t2qbZIeb1dW7w7JF4DMLOO
         i0Cw==
X-Gm-Message-State: APjAAAX/O5634GCqk9wXClqTL5H2KjoRuX1O0nQ61NXuFT3nx+ahu0OY
        JuKkNsA8XbMmF2Y/vAIbJE1UFYLzdgUJAoB7tv4=
X-Google-Smtp-Source: APXvYqz+B08u8f36zlcVvGyFt7QmFTKQN1wZESA+ZjqGZOY2xqn3mk2uipltS6QD1UxNAL1a0DgbAgBtEUZjITcQB1Q=
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr73914830qvp.210.1578293271759;
 Sun, 05 Jan 2020 22:47:51 -0800 (PST)
MIME-Version: 1.0
References: <1577350475-127530-1-git-send-email-pengms1@lenovo.com>
In-Reply-To: <1577350475-127530-1-git-send-email-pengms1@lenovo.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 6 Jan 2020 06:47:39 +0000
Message-ID: <CACPK8XeY5dPHtRfFD55dLVHT0SF1gJEVf1DixsbJKpciLP2s5Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ARM: dts: aspeed: update Hr855xg2 device tree
To:     Andrew Peng <pengms1@lenovo.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Derek Lin <dlin23@lenovo.com>, Yonghui Liu <liuyh21@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Dec 2019 at 08:54, Andrew Peng <pengms1@lenovo.com> wrote:
>

When you have a list of things like below, it's sometimes a good hint
that you should be sending one patch for each bullet point. This makes
it easier to review.

> Update i2c aliases.
> Change flash_memory mapping address and size.
> Add in a gpio-keys section.
> Enable vhub, vuart, spi1 and spi2.
> Add raa228006, ir38164 and sn1701022 hwmon sensors.
> Remove some unuse gpio from gpio section.

unused?

>
> Signed-off-by: Andrew Peng <pengms1@lenovo.com>
> Signed-off-by: Derek Lin <dlin23@lenovo.com>
> Signed-off-by: Yonghui Liu <liuyh21@lenovo.com>

I got two copies of this. I think they are the same.

> ---
> v1: initial version
>
>  arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts | 557 ++++++++++++++++-------
>  1 file changed, 382 insertions(+), 175 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> index 8193fad..e1386d4 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> @@ -15,14 +15,21 @@
>         compatible = "lenovo,hr855xg2-bmc", "aspeed,ast2500";
>

> -               flash_memory: region@98000000 {
> +               flash_memory: region@9EFF0000 {
>                         no-map;
> -                       reg = <0x98000000 0x00100000>; /* 1M */
> +                       reg = <0x9EFF0000 0x00010000>; /* 64K */

Do you really use 64K here, or was this a workaround for the lpc-ctlr
driver requiring a memory region?

If it's a workaround you can now drop the memory region phandle, as
the driver works without it.

> +&spi2 {
>         status = "okay";
>         pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_txd1_default
> -                       &pinctrl_rxd1_default>;
> +       pinctrl-0 = <&pinctrl_spi2ck_default
> +                               &pinctrl_spi2cs0_default
> +                               &pinctrl_spi2miso_default
> +                               &pinctrl_spi2mosi_default>;
> +
> +               spidev@0 {
> +                               status = "okay";
> +                               compatible = "aspeed,spidev";
> +                               reg = < 0 >;
> +                               spi-max-frequency = <50000000>;
> +               };

This is for an out of tree driver? We discourage that, and prefer you
submit the driver upstream for review before adding it to the device
tree.

Please drop the sbidev bit from your next version.

> +
> +               flash@0 {
> +                               compatible = "jedec,spi-nor";
> +                               m25p,fast-read;
> +                               label = "fpga";
> +                               reg = < 0 >;
> +                               spi-max-frequency = <50000000>;
> +                               status = "okay";
> +               };
>  };

> +&vuart {
>         status = "okay";
> +       auto-flow-control;
> +       espi-enabled = <&syscon 0x70 25>;

Is this the same as the upstreamed aspeed,sirq-polarity-sense?

Please review https://git.kernel.org/torvalds/c/8d310c9107a2a3f19dc7bb54dd50f70c65ef5409.
I think you will find you can drop the espi-enabled property as
aspeed-g5.dtsi now contains the same information.

> +               pcie_slot12: i2c@4{
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               reg = <4>;
> +               };
> +
> +               switch0_i2c5:i2c@5{

a space after the :

> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               reg = <5>;
> +                               eeprom@54 {
> +                                               compatible = "atmel,24c04";
> +                                               pagesize = <16>;
> +                                               reg = <0x54>;
> +                               };
>                 };
>         };
>  };
> @@ -216,13 +377,43 @@
>         };
>
>         VR@45 {
> -               compatible = "pmbus";
> +               compatible = "raa228006";

Please send this change once you've had your pmbus driver accepted by
Guneter. In the mean time I suggest dropping it from v2 so we can
merge the other changes.

>                 reg = <0x45>;
>         };
>  };
>

> +       CPU0_VCCIN@60 {

Convention is to use lower case for node names.

> +               compatible = "raa228006";
> +               reg = <0x60>;
> +       };
> +
