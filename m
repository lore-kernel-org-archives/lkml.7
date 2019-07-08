Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17766C606C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5E421874
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cdBffCSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389823AbfGHRkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:40:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43502 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfGHRkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:40:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id q10so17021108otk.10;
        Mon, 08 Jul 2019 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSVacs8YIm4Q8FN/mo4VvWI9vvPJ+1SwGrfqSjXCwAs=;
        b=cdBffCSMGovpdqOuw2eSAroY4VE3XeTKZxsETQ39SYm80rCHztdOezzH+hyadWxoF6
         9dF8HVPWqM2q7E/vKF4k5/jrbKVOhfmoDju+uAtMNFbI/MTySJ5BUf1T96iKq5aLuUJg
         /edDw5SHMcsEJXpJlZyLKdfiM7PZ1ETj1uPHBJTw1H8278WnXEmz2dPlUImQct6O/LHi
         jLjPYYsoXgdmgPplMoare0LZmrcaFgAtR6HN3+WQvmvfpw653It07PGr6VZZLfWt5d0r
         PhbGvmsdyM1q0L6fhqjrhsUDeNpWbHLlUA3R/ocXz8R4FCpSnzbcj4DqOko+OJqaMsHC
         LJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSVacs8YIm4Q8FN/mo4VvWI9vvPJ+1SwGrfqSjXCwAs=;
        b=fa4zjA5TAXTTLj+SSoSr1nwZ6JAk/PRxA/CQwrGFLnxWjTlO0DZje8UeckR8JkUgrH
         Nv0kFKxq2j95EDKwC7TlpdJ+brIiRpo3kTQcvkL/GOtvl86Jr85KkrFJBYgxzNgtQz+3
         fZheclsnatohiCfNoggLLfYFvkQtLUsGk+XI0xV6k1TYqzft+0Orp2nNJmXi3nKTMBX1
         mQLDzeL10IRDT23WPykfzl9ZN7TqDTzoHRELKrMVxEB5+o9QB2dxC+XLQHMxj8/c2Kg5
         UpS4dS8Je5DbGJ61JLZ7zmCQJYrH4caCmOAtEHtYA4J4/v0bKP0GLG4TeCTGjWKfGK5c
         cA9A==
X-Gm-Message-State: APjAAAXWGsx//6kinMCE0Cu/C1XHhTG4k62oySvAmLTf1YxK6q/ZGqBo
        GS13dhlRwc0RVq/PD6W7eoO0np+nn2/Wma+VGgI=
X-Google-Smtp-Source: APXvYqynS/GXRYen51q6ZZMCoT3bwhm+IUspfjINhfxpNq0N4KVOCnl2xnKfOrIoZv2GGw5qYNdOUzo9QUm7BhURwy0=
X-Received: by 2002:a9d:39a6:: with SMTP id y35mr16024114otb.81.1562607630822;
 Mon, 08 Jul 2019 10:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190708173330.13217-1-martin.blumenstingl@googlemail.com> <20190708173330.13217-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190708173330.13217-3-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 8 Jul 2019 19:40:19 +0200
Message-ID: <CAFBinCD8UG5PtCLzFDmiK22T03TVgGrgLB1zW3vLOAvXWs3Tvg@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/2] mmc: host: meson-mx-sdhc: new driver for the
 Amlogic Meson SDHC host
To:     jianxin.pan@amlogic.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jianxin,

I thought I'd put my questions inline again so it's easier to follow me.
I hope you can help clarify some of the questions I have.

On Mon, Jul 8, 2019 at 7:33 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> WiP - only partially working - see performance numbers.
>
> Odroid-C1 eMMC (HS-200):
> Amlogic's vendor driver @ Linux 3.10:
>   7781351936 bytes (7.8 GB) copied, 134.714 s, 57.8 MB/s
> This driver:
>   7781351936 bytes (7.8 GB, 7.2 GiB) copied, 189.02 s, 41.2 MB/s
>
> EC-100 eMMC (HS MMC):
> Amlogic's vendor driver @ Linux 3.10:
>   15762194432 bytes (16 GB) copied, 422.967 s, 37.3 MB/s
> This driver:
>   15762194432 bytes (16 GB, 15 GiB) copied, 9232.65 s, 1.7 MB/s
my EC-100 board uses high-speed MMC (no HS-200) mode only and it's
really bad there
on Odroid-C1 the MMC the performance is at ~70% of the 3.10 kernel driver

my thinking is that phase tuning "fixes" the performance on Odroid-C1
(EC-100 doesn't use tuning because it's not using HS-200 mode).
I could be wrong here though. Please let me know if you have any suggestions


[...]
> +               if (mmc->actual_clock > 100000000) {
> +                       rx_clk_phase = 1;
> +               } else if (mmc->actual_clock > 45000000) {
> +                       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
> +                               rx_clk_phase = 15;
> +                       else
> +                               rx_clk_phase = 11;
> +               } else if (mmc->actual_clock >= 25000000) {
> +                       rx_clk_phase = 15;
> +               } else if (mmc->actual_clock > 5000000) {
> +                       rx_clk_phase = 23;
> +               } else if (mmc->actual_clock > 1000000) {
> +                       rx_clk_phase = 55;
> +               } else {
> +                       rx_clk_phase = 1061;
> +               }
this MMC clock frequency to RX clock phase mapping only seems to work
for FCLK_DIV3
how do I calculate this dynamically?

[...]
> +static int meson_mx_sdhc_register_clks(struct meson_mx_sdhc_host *host)
> +{
> +       struct clk *mux_parents[MESON_SDHC_PARENT_CLKS];
> +       struct clk *mux_clk, *div_clk;
> +       int i;
> +
> +       for (i = 0; i < MESON_SDHC_PARENT_CLKS; i++)
> +               mux_parents[i] = host->parent_clks[i].clk;
> +
> +       host->clkc_clk_src_sel.reg = host->base + MESON_SDHC_CLKC;
> +       host->clkc_clk_src_sel.shift = __ffs(MESON_SDHC_CLKC_CLK_SRC_SEL);
> +       host->clkc_clk_src_sel.mask = MESON_SDHC_CLKC_CLK_SRC_SEL >>
> +                                     host->clkc_clk_src_sel.shift;
> +       mux_clk = meson_mx_sdhc_register_clk(mmc_dev(host->mmc),
> +                                            &host->clkc_clk_src_sel.hw,
> +                                            "clk_src_sel",
> +                                            MESON_SDHC_PARENT_CLKS,
> +                                            mux_parents,
> +                                            CLK_SET_RATE_NO_REPARENT,
> +                                            &clk_mux_ops);
> +       if (IS_ERR(mux_clk))
> +               return PTR_ERR(mux_clk);
> +
> +       host->clkc_clk_div.reg = host->base + MESON_SDHC_CLKC;
> +       host->clkc_clk_div.shift = __ffs(MESON_SDHC_CLKC_CLK_DIV);
> +       host->clkc_clk_div.width = fls(MESON_SDHC_CLKC_CLK_DIV) -
> +                                  host->clkc_clk_div.shift;
are there any constraints for the divider?
the driver from the Amlogic kernel sources does this, but I'm not sure
what this is trying to achieve (and why):
       clk_div = input_rate / clk_ios - !(input_rate%clk_ios);
       if (!(clk_div & 0x01)) // if even number, turn it to an odd one
          clk_div++;

[...]
> +       mmc->max_busy_timeout = 0; // TODO: actual value?
do you know the actual busy timeout of this IP block?


Thank you for your time!
Regards
Martin
