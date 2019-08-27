Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10486C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 04:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3342186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 04:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfH0ENS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 00:13:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37749 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0ENS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 00:13:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id f22so29431150edt.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 21:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5cHZyGdjYh3gEAKmcObYNldhgaeKgV4aSEBGnXJjJM=;
        b=nKh6nwFwFprPh6zEE1pjQ4FYJ+2AB10iIYK471TyBk9nsQti6ljUQbuinTV67i/F5H
         eG3Wv+JI4JLtrFL5U2sA4VFgrVAGwQezLeX9ong/qRESqxYB85eHhYLwcsQjMzNxMd5I
         6lvPGAPR8OYW82xQr1bCgTJNiS07nI0sAR3d1Y+oLi40WUs12kNFRMTk5bM21/pkB7yX
         zDTUZDM2+GWE+5SwjJn42QouZbDhMpU67+tqPAk+N2miMR5y9St2Xo4FOkvDA+TICfFj
         tnTS5a69eP5H8vdmhWhhcX/lSnFV/JZeY1vHJuGwu0XqicC7eJz+Bz3hPkMy/UjTsf8p
         vlCg==
X-Gm-Message-State: APjAAAXXpL/Q5hcmkOZ2hCtNTPi0H1ewX2GRo5u8Gm6SU9uDNqhGmiz6
        GsiZHflO7otwc1stbabDJgXyYh3OqCE=
X-Google-Smtp-Source: APXvYqz7kbYGv1mGeUdVWZOidpciG3bPWQjBms0Rp5aCGbQ+zL0TmX2XDdIRJ17q53tlGSgbHyfHoA==
X-Received: by 2002:aa7:d94f:: with SMTP id l15mr21809318eds.299.1566879196266;
        Mon, 26 Aug 2019 21:13:16 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id va28sm3229085ejb.36.2019.08.26.21.13.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 21:13:16 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id o4so1504465wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 21:13:15 -0700 (PDT)
X-Received: by 2002:a7b:c21a:: with SMTP id x26mr23286711wmi.61.1566879195343;
 Mon, 26 Aug 2019 21:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190826180734.15801-1-codekipper@gmail.com> <20190826180734.15801-2-codekipper@gmail.com>
In-Reply-To: <20190826180734.15801-2-codekipper@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 27 Aug 2019 12:13:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v651jVp+J2eyWh7vw-yHmFTVy4eaMjHV0FvOF17C5_Hswg@mail.gmail.com>
Message-ID: <CAGb2v651jVp+J2eyWh7vw-yHmFTVy4eaMjHV0FvOF17C5_Hswg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v6 1/3] ASoC: sun4i-i2s: incorrect regmap
 for A83T
To:     Code Kipper <codekipper@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
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

On Tue, Aug 27, 2019 at 2:07 AM <codekipper@gmail.com> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> The regmap configuration is set up for the legacy block on the
> A83T whereas it uses the new block with a larger register map.

Looking at the code Allwinner previously released [1], that doesn't seem to be
the case. Keep in mind that the register map shown in the user manual is for
the TDM interface, which we don't actually support right now.

The file shows the base address as 0x01c22800, and the last defined register
is SUNXI_RXCHMAP at 0x3c.

The I2S driver [2] also shows that it is the old register map size, but with
TX_FIFO and INT_STA swapped around. This might mean that it would need a
separate regmap_config, as the read/write callbacks need to be changed to
fit the swapped registers.

Finally, the TDM driver [3], which matches the TDM section in the manual, shows
a larger register map.

A83T is SUN8IW6, while SUN8IW7 refers to the H3.

ChenYu

[1] https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sunxi/hdmiaudio/sunxi-hdmipcm.h
[2] https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sunxi/i2s0/sunxi-i2s0.h
[3] https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sunxi/daudio0/sunxi-daudio0.h

> Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 57bf2a33753e..34575a8aa9f6 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -1100,7 +1100,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
>  static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
>         .has_reset              = true,
>         .reg_offset_txdata      = SUN8I_I2S_FIFO_TX_REG,
> -       .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
> +       .sun4i_i2s_regmap       = &sun8i_i2s_regmap_config,
>         .field_clkdiv_mclk_en   = REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
>         .field_fmt_wss          = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
>         .field_fmt_sr           = REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190826180734.15801-2-codekipper%40gmail.com.
