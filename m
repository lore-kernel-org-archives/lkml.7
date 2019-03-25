Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F15C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5263920863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncANneJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfCYN1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:27:52 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:32998 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfCYN1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:27:49 -0400
Received: by mail-ua1-f65.google.com with SMTP id g8so2983931uaj.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KV71XD3WbH3DLjsqUUlVLdRrx665df+FB2VJqIaMPEI=;
        b=ncANneJuvdWMWDeQAmOf1zoEHWfJoz9Hg6cZ5dO1AverLxo4SqG94bT33AqOnx5CtH
         RLJQolf+l1EliaR80FFxQEk/8b66F2MoJevMLN3tCiD0zxTO51j+Arc9rz52HhyTRxRU
         gAxxs2QdOtNvArMzpWqmo9q4jRyhSSUwYWRRECON65CRnKyCGVq/hwJ5Crl6HO/6NFEB
         kRZA7VgiQLOTPcxvDuRtmiB9GdrMAHcD3tAMANS8zyCtOgEILF5GVb24DukkS72EmAmo
         pU6ZsojUHM8lqP0BQgaGL+NNInHwFlXR89uwmJKqSNm+LdakBlL+7PP3QZhlTqhBXIol
         cQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KV71XD3WbH3DLjsqUUlVLdRrx665df+FB2VJqIaMPEI=;
        b=Wenu4UzLI+gwiZ470fUpD2uRuAszzbFS5leGerXSswNHUJr3yB6wMgZDAf2924mqUW
         IMBXkjE1gvyVrgoXStVpY/7Ryo9PZuUnuiyxZKwZrMTS4d9+d3VP7QhT68l3iemBbCan
         Rem4ANpQUFj+EM/+3vPZtip6g0uKE6iFQDzcNSgyTGyHEg8GbYPtnOwyT1F1VIHVu9on
         EV8/KZszlfI/RdvF18Ka0gV9kLyMEJ5nYNMMR2k3f2QIh1Z1Xyk5hlk8Gx1+hPdhlmkl
         MI/GZHYO6tLZB30UtUb8/4VYGEs5YSqB+lAVZ0nZ2jkccb9nX1FejRnl2Tv1mJuHxZKa
         t2Ww==
X-Gm-Message-State: APjAAAUPzQb8CiNh0Lmw5aY0+oqjhqmV2ZrzsQPa33IUGklllb04+mlk
        emlfIB9e/c45bZJbMZz10ZVGBoznaJ8hlfak+Q7Yyw==
X-Google-Smtp-Source: APXvYqzDO9secvXB3Zb9/Lvj9kSk1MGWjkotop4KcA0F6Bv2LB1YoMdrqNZ9n248STx8a686ESZxWmgRRfLOpI/KQg4=
X-Received: by 2002:ab0:7358:: with SMTP id k24mr13929870uap.104.1553520468535;
 Mon, 25 Mar 2019 06:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com>
In-Reply-To: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Mar 2019 14:27:12 +0100
Message-ID: <CAPDyKFqd8LOi=MN9rCKUwgkTxEjikmq3+B1SWGF8z1ykeMfoyg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: Add disable-cqe-dcmd property.
To:     Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Lin Huang <hl@rock-chips.com>, Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 at 12:39, Christoph Muellner
<christoph.muellner@theobroma-systems.com> wrote:
>
> Add disable-cqe-dcmd as optional property for MMC hosts.
> This property allows to disable or not enable the direct command
> features of the command queue engine.
>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index cdbcfd3a4ff2..c269dbe384fe 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -64,6 +64,8 @@ Optional properties:
>    whether pwrseq-simple is used. Default to 10ms if no available.
>  - supports-cqe : The presence of this property indicates that the corresponding
>    MMC host controller supports HW command queue feature.
> +- disable-cqe-dcmd: This property indicates that the MMC controller's command
> +  queue engine (CQE) does not support direct commands (DCMDs).
>
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> --
> 2.11.0
>
