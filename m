Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD94C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F75233A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmFr7nxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfHUJTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:19:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39638 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfHUJTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:19:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id x4so1452853ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tEQ31WOSLuQ3JEBF9cV8gIJ36Fz5CZ1Zb7GBPfj32s=;
        b=NmFr7nxDxcBSv+uW4e7+vOU6sf2roLBf2V03NMTBhvA8HsbJuDjuF6SfhiqpB9nTHE
         fR+OaPMsCKLJ7NobySSrkj3ygxdF+UbQFTYp10jJwkYhe3u7d4VDj0SNJHOsgLX2bNKC
         UCj73zuWvfPcmvRIg1dGnFzky8Ud54Lzq3z0YH3+ZD4ZJgK6cC/hcUvBcrx3IpKzxFAW
         AKK+8ukGQkwMaiKxjiW91h3sMTIz5qNaUWdiQAU8rS+YGdVuRqv8VNXbaPlCyHFApjMG
         6rRc9FbKry+rKOrUZtXHAYBymjAL11ozmQrBmF9WdBY2Z3QOKqPBC40ikCNvC/qqv5Gf
         RU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tEQ31WOSLuQ3JEBF9cV8gIJ36Fz5CZ1Zb7GBPfj32s=;
        b=CKzN3cbd457CneMzWNkR8JBeshAtmZwoeqfofifa4yt8FuaE0bbx9/FL+5PACEzRhP
         W88C5stMYIez5eLaGB9qVsocDMZxSfJbncZHWXp5a6U2nu77Ctpq6mGVU/moPf7kl1uW
         ljKUSS8UrccchPcDxnIqAtAE5jrJIddyVLkU3dRthgjZouBMW5NGcYgviuPMiByrN2bm
         lPA6jr3rKcyo5WEm5dcioSsw5sHJpTN64zNqEp3IgL/Giq2x2ySfcFgpvAoIQxpw5wF7
         uk5Z73YlpihtaamxMwhCPTEfal8I8DisyUes5GPQyS/IKUKjciYoJ3ce6DWEHizNYxp/
         aRpA==
X-Gm-Message-State: APjAAAUEAfWxczibsTgn7aiuQEy6ePHzFz2ulDH06+UPTfYYV+Rc3CqO
        8RuBoGE3BYuF4jg2eXfa2fJNQz60qQ9KuG9mVYo=
X-Google-Smtp-Source: APXvYqyMvMP7WpKv2AQSCUyxhmpTSTKtEUxHamxuC1vWlEJy7y4MvakGKiV9JeryByhHBufUiM7n40VZzjuQKwrf178=
X-Received: by 2002:a2e:5bc6:: with SMTP id m67mr15204586lje.53.1566379158109;
 Wed, 21 Aug 2019 02:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-10-codekipper@gmail.com>
In-Reply-To: <20190814060854.26345-10-codekipper@gmail.com>
From:   Code Kipper <codekipper@gmail.com>
Date:   Wed, 21 Aug 2019 11:19:05 +0200
Message-ID: <CAEKpxB=9NNoZgZoY_GpcEuDYoMUGzb+ATgZOSM64qy9tirC_MQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] clk: sunxi-ng: h6: Allow I2S to change parent rate
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 at 08:09, <codekipper@gmail.com> wrote:
>
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>
> I2S doesn't work if parent rate couldn't be change. Difference between
> wanted and actual rate is too big.
>
> Fix this by adding CLK_SET_RATE_PARENT flag to I2S clocks.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Signed-off-by: Marcus Cooper <codekipper@gmail.com>

> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> index aebef4af9861..d89353a3cdec 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> @@ -505,7 +505,7 @@ static struct ccu_div i2s3_clk = {
>                 .hw.init        = CLK_HW_INIT_PARENTS("i2s3",
>                                                       audio_parents,
>                                                       &ccu_div_ops,
> -                                                     0),
> +                                                     CLK_SET_RATE_PARENT),
>         },
>  };
>
> @@ -518,7 +518,7 @@ static struct ccu_div i2s0_clk = {
>                 .hw.init        = CLK_HW_INIT_PARENTS("i2s0",
>                                                       audio_parents,
>                                                       &ccu_div_ops,
> -                                                     0),
> +                                                     CLK_SET_RATE_PARENT),
>         },
>  };
>
> @@ -531,7 +531,7 @@ static struct ccu_div i2s1_clk = {
>                 .hw.init        = CLK_HW_INIT_PARENTS("i2s1",
>                                                       audio_parents,
>                                                       &ccu_div_ops,
> -                                                     0),
> +                                                     CLK_SET_RATE_PARENT),
>         },
>  };
>
> @@ -544,7 +544,7 @@ static struct ccu_div i2s2_clk = {
>                 .hw.init        = CLK_HW_INIT_PARENTS("i2s2",
>                                                       audio_parents,
>                                                       &ccu_div_ops,
> -                                                     0),
> +                                                     CLK_SET_RATE_PARENT),
>         },
>  };
>
> --
> 2.22.0
>
