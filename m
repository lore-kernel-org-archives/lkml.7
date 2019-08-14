Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CC5C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3537D205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfHNLbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:31:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40723 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHNLbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:31:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id h8so21472448edv.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnH5gEWlUPqTFMc04DMHRK5rlUo9OFLR8LpIJiKaA88=;
        b=l8lsY6lc+W7S7lrfqASoMKiGTVAfU6dqc3WV0D294o427MiVGJeDUBVnqUD0BPU6JU
         N8SWvyc/fz/b5PWZZ1hZMWqQftnyS6cRzWnzXxPT8cG/lvQiQj4nzx/8484ru2vGLFAM
         oeQ+8cPIzglbQ/aUg8xucM5i/FVJ9dST4H2EeVWsBZX9IoKQIZ+G/bMKyeF4rGU4KfWr
         zuWzkxXgGH4975w+jZSD/qQygaWCXVyYFRtRq2uQ6PXEgJxW1W2ejCYsNy3XQEH2tdt4
         IfLXNcmulTebnx0Lyyvx1p/wLviswPQRnrwWeNJXR6ovcp2rNoK19a6Zdnvnw81XJUKX
         EWFw==
X-Gm-Message-State: APjAAAV4T6I40s8IwPgScbB0CKr0eQlwbtlgSgAORHhjmBfwYgDO05/M
        Z2vviD424DR8yZYFncAouucnbFEtmH4=
X-Google-Smtp-Source: APXvYqwPQ1CH5xsQuRJDoBoccX/f8h/Obzxh0K2uiWIXHWC3aSv5xJh9oJBMjx5TFi2X6ZUPr0LCQA==
X-Received: by 2002:a17:906:1d51:: with SMTP id o17mr19930689ejh.186.1565782300242;
        Wed, 14 Aug 2019 04:31:40 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id g22sm18483186ejr.87.2019.08.14.04.31.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 04:31:39 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id p74so4287267wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:31:39 -0700 (PDT)
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr7844443wmf.47.1565782298812;
 Wed, 14 Aug 2019 04:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-16-codekipper@gmail.com>
In-Reply-To: <20190814060854.26345-16-codekipper@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 14 Aug 2019 19:31:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v65OdwwDg0Ezc0eXShvp1crQfmt6ZKAkWpOH9Dz94HFrEw@mail.gmail.com>
Message-ID: <CAGb2v65OdwwDg0Ezc0eXShvp1crQfmt6ZKAkWpOH9Dz94HFrEw@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] ASoC: sun4i-i2s: Adjust regmap settings
To:     Code Kipper <codekipper@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 2:09 PM <codekipper@gmail.com> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
> to reflect this.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 31 ++++++++++---------------------
>  1 file changed, 10 insertions(+), 21 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index d3c8789f70bb..ecfc1ed79379 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -876,9 +876,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>  {
>         /* Flush RX FIFO */
> +       regcache_cache_bypass(i2s->regmap, true);
>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> +       regcache_cache_bypass(i2s->regmap, false);
>
>         /* Clear RX counter */
>         regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
> @@ -897,9 +899,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>  static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
>  {
>         /* Flush TX FIFO */
> +       regcache_cache_bypass(i2s->regmap, true);
>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
> +       regcache_cache_bypass(i2s->regmap, false);
>
>         /* Clear TX counter */
>         regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
> @@ -1053,13 +1057,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
>
>  static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
>  {
> -       switch (reg) {
> -       case SUN4I_I2S_FIFO_TX_REG:
> -               return false;
> -
> -       default:
> -               return true;
> -       }
> +       return true;

The commit log needs to explain why this is relevant. And I'm not sure why one
would read back the TX FIFO. Also, if it's always true, just drop the callback.

ChenYu

>  }
>
>  static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
> @@ -1078,6 +1076,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>  {
>         switch (reg) {
>         case SUN4I_I2S_FIFO_RX_REG:
> +       case SUN4I_I2S_FIFO_TX_REG:
> +       case SUN4I_I2S_FIFO_STA_REG:
>         case SUN4I_I2S_INT_STA_REG:
>         case SUN4I_I2S_RX_CNT_REG:
>         case SUN4I_I2S_TX_CNT_REG:
> @@ -1088,23 +1088,12 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>         }
>  }
>
> -static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
> -{
> -       switch (reg) {
> -       case SUN8I_I2S_FIFO_TX_REG:
> -               return false;
> -
> -       default:
> -               return true;
> -       }
> -}
> -
>  static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>  {
>         if (reg == SUN8I_I2S_INT_STA_REG)
>                 return true;
>         if (reg == SUN8I_I2S_FIFO_TX_REG)
> -               return false;
> +               return true;
>
>         return sun4i_i2s_volatile_reg(dev, reg);
>  }
> @@ -1175,7 +1164,7 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
>         .reg_defaults   = sun8i_i2s_reg_defaults,
>         .num_reg_defaults       = ARRAY_SIZE(sun8i_i2s_reg_defaults),
>         .writeable_reg  = sun4i_i2s_wr_reg,
> -       .readable_reg   = sun8i_i2s_rd_reg,
> +       .readable_reg   = sun4i_i2s_rd_reg,
>         .volatile_reg   = sun8i_i2s_volatile_reg,
>  };
>
> @@ -1188,7 +1177,7 @@ static const struct regmap_config sun50i_i2s_regmap_config = {
>         .reg_defaults   = sun50i_i2s_reg_defaults,
>         .num_reg_defaults       = ARRAY_SIZE(sun50i_i2s_reg_defaults),
>         .writeable_reg  = sun4i_i2s_wr_reg,
> -       .readable_reg   = sun8i_i2s_rd_reg,
> +       .readable_reg   = sun4i_i2s_rd_reg,
>         .volatile_reg   = sun8i_i2s_volatile_reg,
>  };
>
> --
> 2.22.0
>
