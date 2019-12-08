Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E12C2D0BF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 18:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEEF206D6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 18:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K319RU8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLHSF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 13:05:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38854 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfLHSF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 13:05:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id b8so4365669oiy.5;
        Sun, 08 Dec 2019 10:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTKk2xaW6izThy3AlF0F8z6eeCX0vy7qq8T/sGHhvO8=;
        b=K319RU8L98AdTYk+TFFH07liuRfMqrUGSHeB1yVizEaZI6tXBYIJ9U1sVAHlpPqkeV
         8tT9kA6NvUJ6/a38fuTRpRIzIrjkaJosKJZy9PLidQKCmNHsJCabru0flsca74oTBtSs
         IdKJzEC3hiUvqROeWgwGkV7LfATiSnJNBePgk8ilsolml224mUrQI9KxGk0LZjn+LhSs
         nQl2G+dPsJAnsQj4j67dwKHH+6DyM17L2T76Gf9zhNekSINUnp0fNEZAwe4r4PtxmZGC
         /CP1KywXsi2+YdqjsISyMOiL3rx8neF68UBtXhPwFwdg2qVq9WgHkxHgr8jmC26B4+4S
         3CRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTKk2xaW6izThy3AlF0F8z6eeCX0vy7qq8T/sGHhvO8=;
        b=XEMwn+6chDA7Ui2F68+if5B07OrMQsExONFOcuE1j1MLutDfjv+iQakpWK6v3wZBMt
         cwaqcZobWehTvDdgrONXntpd6Mpqfran3c2JZ74+TRT4V5zkh9I0LbfuPzU0Mf5q1HUs
         dgXQ5B8GmdvZG8b9vwhcdLX6J6jwqvRwm6DIcSkuDwDR55tEc2yr3gGIlXgJCYANoZ0q
         rCxq2aonE5O33KBiKkPTFyoH+9W4J80I08WzsWhXjRJF56Oes7KKI9WPoPwdojzaqVPE
         cpVjLrsFYPkbc8SdvlVU7lRK2bsrztkB6g02kNNbmAgMIJKkkzOb/GW8h6Ge5flSG5BN
         53mg==
X-Gm-Message-State: APjAAAWtxbTkR685KXHE0m6BPWz0f3dkndb9SbqFc4YbU8S7kCtPDJOo
        Bw0o+oIvGpmhzRb86auR0OsR0ceeQey02mB8xXQ9pmS9
X-Google-Smtp-Source: APXvYqwP8CfD4nzvIAMNoJSw6b/s3OlcStAt+9hJdYSDZk0uioly16Xg/QyBa2wBGQwlsNfEfJZOqcez8T1vcmuzP90=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr15872202oig.39.1575828327856;
 Sun, 08 Dec 2019 10:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20191206100218.480348-1-jbrunet@baylibre.com> <20191206100218.480348-5-jbrunet@baylibre.com>
In-Reply-To: <20191206100218.480348-5-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 8 Dec 2019 19:05:16 +0100
Message-ID: <CAFBinCDMxf6tJt+bkfN7W5CMJrqZ+F1zTC=q8xmYtxg7gpEJxg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: meson: add libretech-pc boards support
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

this is looking good overall - I have some questions / nit-picks below

On Fri, Dec 6, 2019 at 11:02 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
[...]
> +       adc_keys {
on most boards we use "adc-keys" instead of "adc_keys"

[...]
> +               button-onoff {
> +                       label = "On/Off";
> +                       linux,code = <KEY_VENDOR>;
based on the label I assumed that the code is KEY_POWER
why is KEY_VENDOR the better choice here?

[...]
> +       cvbs-connector {
> +               compatible = "composite-video-connector";
> +               status = "disabled";
is there CVBS on the board? if I remember correctly the VPU driver
works fine when omitting the CVBS connector
so if the board doesn't have it you may drop the whole node instead of
keeping it disabled

[...]
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               green {
> +                       label = "librecomputer:green:disk";
you can use the "function" and "color" properties instead of the (now
deprecated) "label"

[...]
> +&external_mdio {
> +       external_phy: ethernet-phy@0 {
> +               reg = <0>;
it would be great to have a comment above which PHY is used on this board

> +               max-speed = <1000>;
> +               reset-assert-us = <10000>;
> +               reset-deassert-us = <30000>;
> +               reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
> +               interrupt-parent = <&gpio_intc>;
a comment like /* MAC_INTR on GPIOZ_15 */ would be great here
> +               interrupts = <25 IRQ_TYPE_LEVEL_LOW>;

[...]
> +&pinctrl_periphs {
> +       /*
> +        * Make sure the reset pin of the usb HUB is driven high to take
> +        * it out of reset.
> +        */
> +       usb1_rst_pins: usb1_rst_irq {
> +               mux {
> +                       groups = "GPIODV_3";
> +                       function = "gpio_periphs";
> +                       bias-disable;
> +                       output-high;
> +               };
> +       };
on other boards (like Odroid-C2) we use a GPIO hog for this. I'm not
sure which one is better

[...]
> +&pinctrl_periphs {
> +       /*
> +        * Make sure the irq pin of the TYPE C controller is not driven
> +        * by the SoC.
is this because the SoC default configuration pulls the IRQ line LOW,
which then generates "phantom" IRQs?

[...]
> +       fusb302@22 {
typec-portc@22

[...]
> +               interrupt-parent = <&gpio_intc>;
> +               interrupts = <59 IRQ_TYPE_LEVEL_LOW>;
a comment above with the GPIO number would be great


Martin
