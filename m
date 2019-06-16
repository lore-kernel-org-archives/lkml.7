Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6672BC31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 05:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A80C21473
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 05:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfFPFbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 01:31:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32818 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfFPFbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 01:31:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so10393456edq.0;
        Sat, 15 Jun 2019 22:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVwk/ziTyLZE6Zw80YoRGbaeC4ieFbAxfmOC6bCL8pk=;
        b=RuBPsgZHQ5VTC16pjlUVTU0dwK+VoWf2GoQLMcdRjZ5oAAwHAUGP8VhcJyYGhjLWwt
         LXoLYd2w09KnSPC6WMuvflDZGA9Ae9luSd5xdRW0rTQ3rV9xEz7FHF1hV/x4z4P4Ox/t
         RB6UiP7pU6aQcFpKW84kxxWXX+RpnW+pPleGlricYOxB9xeNAwK8gCJjIx8LhYZmPIst
         e7Sgwbw2JnjkWWmBY6f7rD9j9pV52cIcdk3qzfprkr3Etl2jGlqvSDSIlXhwuwPMdE2n
         fOroLn6CJyXOGaguFtiorQQnC80C8qVR7iPfdyGfK2TFLiFiNnzRZXKhMa3UFGAsMibf
         2I7g==
X-Gm-Message-State: APjAAAVBwt3DKIKUbQipX/FDZiBN/zsjcUJhF7Qp5Dbu5knH/UJxoNar
        B3PlvE6056qA+e2NO0T7fFUN4CJY5KQ=
X-Google-Smtp-Source: APXvYqxOOF51A6akSq1bcjWY3DXBOSxKbxBc1FTjufmgG+SL0T0YuZ4qlB1rVu+iFoQB5SfCiHvw8Q==
X-Received: by 2002:a17:906:6a87:: with SMTP id p7mr70251290ejr.277.1560663093093;
        Sat, 15 Jun 2019 22:31:33 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id ay25sm1498094ejb.26.2019.06.15.22.31.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 22:31:32 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id k11so6447900wrl.1;
        Sat, 15 Jun 2019 22:31:32 -0700 (PDT)
X-Received: by 2002:adf:f946:: with SMTP id q6mr18780972wrr.109.1560663091964;
 Sat, 15 Jun 2019 22:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190614164324.9427-1-jagan@amarulasolutions.com> <20190614164324.9427-6-jagan@amarulasolutions.com>
In-Reply-To: <20190614164324.9427-6-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 16 Jun 2019 13:31:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v669MprYgy2wc_a7Kz8VpzzNGZxDxsj0z_Ujx5bV25+AWQ@mail.gmail.com>
Message-ID: <CAGb2v669MprYgy2wc_a7Kz8VpzzNGZxDxsj0z_Ujx5bV25+AWQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 5/9] drm/sun4i: tcon_top: Register clock
 gates in probe
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 12:44 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> TCON TOP have clock gates for TV0, TV1, dsi and right
> now these are register during bind call.
>
> Of which, dsi clock gate would required during DPHY probe
> but same can miss to get since tcon top is not bound at
> that time.
>
> To solve, this circular dependency move the clock gate
> registration from bind to probe so-that DPHY can get the
> dsi gate clock on time.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 94 ++++++++++++++------------
>  1 file changed, 49 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> index 465e9b0cdfee..a8978b3fe851 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -124,7 +124,53 @@ static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
>  static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
>                                void *data)
>  {
> -       struct platform_device *pdev = to_platform_device(dev);
> +       struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = reset_control_deassert(tcon_top->rst);
> +       if (ret) {
> +               dev_err(dev, "Could not deassert ctrl reset control\n");
> +               return ret;
> +       }
> +
> +       ret = clk_prepare_enable(tcon_top->bus);
> +       if (ret) {
> +               dev_err(dev, "Could not enable bus clock\n");
> +               goto err_assert_reset;
> +       }

You have to de-assert the reset control and enable the clock before the
clocks it provides are registered. Otherwise a consumer may come in and
ask for the provided clock to be enabled, but since the TCON TOP's own
reset and clock are still disabled, you can't actually access the registers
that controls the provided clock.

> +
> +       return 0;
> +
> +err_assert_reset:
> +       reset_control_assert(tcon_top->rst);
> +
> +       return ret;
> +}
> +
> +static void sun8i_tcon_top_unbind(struct device *dev, struct device *master,
> +                                 void *data)
> +{
> +       struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
> +       struct clk_hw_onecell_data *clk_data = tcon_top->clk_data;
> +       int i;
> +
> +       of_clk_del_provider(dev->of_node);
> +       for (i = 0; i < CLK_NUM; i++)
> +               if (clk_data->hws[i])
> +                       clk_hw_unregister_gate(clk_data->hws[i]);

And this should be in the remove function.

So instead, just move _everything_ to the probe and remove functions,
and provide empty bind/unbind functions so the component system still
works.

ChenYu

> +
> +       clk_disable_unprepare(tcon_top->bus);
> +       reset_control_assert(tcon_top->rst);
> +}
> +
> +static const struct component_ops sun8i_tcon_top_ops = {
> +       .bind   = sun8i_tcon_top_bind,
> +       .unbind = sun8i_tcon_top_unbind,
> +};
> +
> +static int sun8i_tcon_top_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
>         struct clk_hw_onecell_data *clk_data;
>         struct sun8i_tcon_top *tcon_top;
>         const struct sun8i_tcon_top_quirks *quirks;
> @@ -132,7 +178,7 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
>         void __iomem *regs;
>         int ret, i;
>
> -       quirks = of_device_get_match_data(&pdev->dev);
> +       quirks = of_device_get_match_data(dev);
>
>         tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
>         if (!tcon_top)
> @@ -164,18 +210,6 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
>         if (IS_ERR(regs))
>                 return PTR_ERR(regs);
>
> -       ret = reset_control_deassert(tcon_top->rst);
> -       if (ret) {
> -               dev_err(dev, "Could not deassert ctrl reset control\n");
> -               return ret;
> -       }
> -
> -       ret = clk_prepare_enable(tcon_top->bus);
> -       if (ret) {
> -               dev_err(dev, "Could not enable bus clock\n");
> -               goto err_assert_reset;
> -       }
> -
>         /*
>          * At least on H6, some registers have some bits set by default
>          * which may cause issues. Clear them here.
> @@ -226,45 +260,15 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
>
>         dev_set_drvdata(dev, tcon_top);
>
> -       return 0;
> +       return component_add(dev, &sun8i_tcon_top_ops);
>
>  err_unregister_gates:
>         for (i = 0; i < CLK_NUM; i++)
>                 if (!IS_ERR_OR_NULL(clk_data->hws[i]))
>                         clk_hw_unregister_gate(clk_data->hws[i]);
> -       clk_disable_unprepare(tcon_top->bus);
> -err_assert_reset:
> -       reset_control_assert(tcon_top->rst);
> -
>         return ret;
>  }
>
> -static void sun8i_tcon_top_unbind(struct device *dev, struct device *master,
> -                                 void *data)
> -{
> -       struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
> -       struct clk_hw_onecell_data *clk_data = tcon_top->clk_data;
> -       int i;
> -
> -       of_clk_del_provider(dev->of_node);
> -       for (i = 0; i < CLK_NUM; i++)
> -               if (clk_data->hws[i])
> -                       clk_hw_unregister_gate(clk_data->hws[i]);
> -
> -       clk_disable_unprepare(tcon_top->bus);
> -       reset_control_assert(tcon_top->rst);
> -}
> -
> -static const struct component_ops sun8i_tcon_top_ops = {
> -       .bind   = sun8i_tcon_top_bind,
> -       .unbind = sun8i_tcon_top_unbind,
> -};
> -
> -static int sun8i_tcon_top_probe(struct platform_device *pdev)
> -{
> -       return component_add(&pdev->dev, &sun8i_tcon_top_ops);
> -}
> -
>  static int sun8i_tcon_top_remove(struct platform_device *pdev)
>  {
>         component_del(&pdev->dev, &sun8i_tcon_top_ops);
> --
> 2.18.0.321.gffc6fa0e3
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190614164324.9427-6-jagan%40amarulasolutions.com.
> For more options, visit https://groups.google.com/d/optout.
