Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C4BC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF97F2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdvbkHw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbfFTNeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:34:13 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34607 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfFTNeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:34:13 -0400
Received: by mail-vs1-f65.google.com with SMTP id q64so1537448vsd.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lc/q2X+pawBjOcnjA6oAKxvqiYph1jdqY4goob1kTPs=;
        b=tdvbkHw9yUtnvDH/DJ4qWmkXoSxhraltCRvY1X1IFBEL7iCTQy4CP1dWXT+/akyp6q
         JVcDjnV1Zb2+jCu7Z8+abWILa4iswW67/+nL0CtxhU62ToEpO6cshXSsn5K2lqTqKXLe
         yysxyF4XMeEWHl51FGMFhtRL5QaJzYFtKNX2N2aX4eXe79A5KNyH7+CttCOsIC2I5EoJ
         iBe301EIgQtd/7pUFr9efWvPmIqELB2tSqtUyaHsdojov0JtFBfBCUv5RFCWK8AtGL9K
         n2owLAiOq75ICmeuyg+YvAqD57IyxLsFZAQg7BeIGNYjiZn4pRme4hDDuobgtTT8ky0T
         OH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lc/q2X+pawBjOcnjA6oAKxvqiYph1jdqY4goob1kTPs=;
        b=Z/xSKc2ecRwpLAvR+ZR5FJcDUl009+e7rKNyCxw8baCFYOGOcKyEmIKy+4PyxkqvFd
         XeBajELKRZhMZy/PmJrODV/voxNfFUqqQIh/baobhqsnNAmy3tmn8JRR5F7GIKzJj+jz
         I9S+hB9cidhEv+fKtlR/VMV7ntwBnxV5GSrvdN+pIkdOF3HemK1CORfmEbdzBptmWYsI
         F8rmd8UbGoABY7kVe/BzWJ6Iyz9VQjVYbyt3ptcGNrOg2dSYcx4Ylt66GYhl7IAXAcSM
         9UrZyfnDr5hXnvEMLDT2sqCt6SKvTIMc3/LlBRGFk+h/O6UgJmFcciICUnaYGFFjGYka
         WGwQ==
X-Gm-Message-State: APjAAAXYorAao9k+XMv8KqnKLKVO6PYmzcKcfShewQHuIVFG4x9XhICb
        Xc59PgJc8fJ8IfFMSY2haWBF997KjvGwK23IKlatQw==
X-Google-Smtp-Source: APXvYqyVxyq7u8zNpM4Beo3pE18Ytv/hNPQHDG2Iz7I2nebi3e7qnCAQv4cYrfQ+b9EBhFO/oJjbJ1VfrfyqTZOoADI=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr21368556vsp.191.1561037651820;
 Thu, 20 Jun 2019 06:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com> <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
 <MN2PR02MB6029DB87CEE32655B0F1E794C1E50@MN2PR02MB6029.namprd02.prod.outlook.com>
 <CAPDyKFqb3uRU1XbrioSw6UZ5atZ8WwZNhQ_yq2+3JfxXZCxr7g@mail.gmail.com> <MN2PR02MB602935234A2A779B5A05CD63C1E40@MN2PR02MB6029.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB602935234A2A779B5A05CD63C1E40@MN2PR02MB6029.namprd02.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Jun 2019 15:33:34 +0200
Message-ID: <CAPDyKFqwe7ss6r99Dxg_OFjKUmCYK_k3pyfYAe62BM7H=a4A7w@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
To:     Manish Narani <MNARANI@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Olof Johansson <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019 at 10:14, Manish Narani <MNARANI@xilinx.com> wrote:
>
> Hi Uffe,
>
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Wednesday, June 19, 2019 7:09 PM
> > To: Manish Narani <MNARANI@xilinx.com>
> > Cc: Michal Simek <michals@xilinx.com>; Rob Herring <robh+dt@kernel.org>;
> > Mark Rutland <mark.rutland@arm.com>; Adrian Hunter
> > <adrian.hunter@intel.com>; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> > <JOLLYS@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Olof
> > Johansson <olof@lixom.net>; linux-mmc@vger.kernel.org; DTML
> > <devicetree@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Linux ARM <linux-arm-kernel@lists.infradead.org>
> > Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP
> > Platform Tap Delays Setup
> >
> > On Wed, 19 Jun 2019 at 10:40, Manish Narani <MNARANI@xilinx.com> wrote:
> > >
> > > Hi Uffe,
> > >
> > >
> > > > -----Original Message-----
> > > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Sent: Monday, June 17, 2019 5:51 PM
> > > [...]
> > > >
> > > > The "const struct zynqmp_eemi_ops *eemi_ops; should then be moved into
> > > > a clock provider specific struct, which is assigned when calling
> > > > sdhci_arasan_register_sdclk. I understand that all the clock data is
> > > > folded into struct sdhci_arasan_data today, but I think that should be
> > > > moved into a "sub-struct" for the clock specifics.
> > > >
> > > > Moreover, when registering the clock, we should convert from using
> > > > devm_clk_register() into devm_clk_hw_register() as the first one is
> > > > now deprecated.
> > >
> > > Just a query here:
> > > When we switch to using devm_clk_hw_register() here, it will register the
> > clk_hw and return int.
> > > Is there a way we can get the clk (related to the clk_hw registered) from the
> > > clock framework?
> > > I am asking this because we will need that clk pointer while calling
> > clk_set_phase() function.
> >
> > I assume devm_clk_get() should work fine?
>
> This clock does not come through ZynqMP Clock framework. We are initializing it in this 'sdhci-of-arasan' driver and getting only the clock name from "clock_output_names" property. So I think devm_clk_get() will not work here for our case.

Well, I guess you need to register an OF clock provider to allow the
clock lookup to work. Apologize, but I don't have the time, currently
to point you in the exact direction.

However, in principle, my point is, there should be no difference
whether the clock is registered via the "ZynqMP Clock framework" or
via the mmc driver. The *clk_get() thing need to work, otherwise I
consider the clock registration in the mmc driver to be a hack. If you
see what I mean.

> I have gone through the clock framework and I found one function which may be used to create clock from clock hw, that is ' clk_hw_create_clk()' which can be used from our driver, however this needs change in the clock framework as below :
>
> ---
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index aa51756..4dc69ff 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3420,6 +3420,7 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
>
>         return clk;
>  }
> +EXPORT_SYMBOL_GPL(clk_hw_create_clk);
>
>  static int clk_cpy_name(const char **dst_p, const char *src, bool must_exist)
>  {
> diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
> index d8400d6..2319899 100644
> --- a/drivers/clk/clk.h
> +++ b/drivers/clk/clk.h
> @@ -22,17 +22,9 @@ static inline struct clk_hw *of_clk_get_hw(struct device_node *np,
>  struct clk_hw *clk_find_hw(const char *dev_id, const char *con_id);
>
>  #ifdef CONFIG_COMMON_CLK
> -struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
> -                             const char *dev_id, const char *con_id);
>  void __clk_put(struct clk *clk);
>  #else
>  /* All these casts to avoid ifdefs in clkdev... */
> -static inline struct clk *
> -clk_hw_create_clk(struct device *dev, struct clk_hw *hw, const char *dev_id,
> -                 const char *con_id)
> -{
> -       return (struct clk *)hw;
> -}
>  static struct clk_hw *__clk_get_hw(struct clk *clk)
>  {
>         return (struct clk_hw *)clk;
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index f689fc5..d3f60fe 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -18,6 +18,7 @@
>
>  struct device;
>  struct clk;
> +struct clk_hw;
>  struct device_node;
>  struct of_phandle_args;
>
> @@ -934,4 +935,15 @@ static inline struct clk *of_clk_get_from_provider(struct of_phandle_args *clksp
>  }
>  #endif
>
> +#ifdef CONFIG_COMMON_CLK
> +struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
> +                             const char *dev_id, const char *con_id);
> +#else
> +static inline struct clk *
> +clk_hw_create_clk(struct device *dev, struct clk_hw *hw, const char *dev_id,
> +                 const char *con_id)
> +{
> +       return (struct clk *)hw;
> +}
> +#endif
>  #endif
> ---
>
> This change should help other drivers (outside 'drivers/clk/') as well for getting the clock created from clk_hw.
> Is this fine to do?

I think this is the wrong approach, see why further above.

Kind regards
Uffe
