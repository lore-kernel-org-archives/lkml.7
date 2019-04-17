Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E046C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10723204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+ZbGN3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbfDQPZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:25:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33589 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfDQPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:25:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id d55so20557607ede.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gnFTNL0HyeJ5SkvPWRP8h9D5WPZZsEJ+mWryvvEXxhU=;
        b=Z+ZbGN3hV+dwBoWFiVvAJmNPPqsgSmmmllSVTAdsQXc6hKjHEfWwuc9KwYAqkq6xmM
         6DX42pTZdMWIaJviY/f36f7ABimQoVUIco9Py1WOp5izN8D5Zg14NrE+tY3mdMHHEnYZ
         VIiy9XxaP15xQhjmSKGT/fyxWwmFhVyQVhMI3aV/Zo69TV/WeHfnCAIGodrKJ3eQl6w/
         NMy7bozutA972RyLT6zZCGdGHu8jC9NDsSFvLHxAxhw2YEOzGPEJr3yY4fcHP0vw3lWC
         MDAni6Yik2xB4Gr+NuFJwylHVevbfZ10IErb95bLv3SQ+KkECBs4GEaRhZqSl/AtZC+U
         6xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gnFTNL0HyeJ5SkvPWRP8h9D5WPZZsEJ+mWryvvEXxhU=;
        b=KRLDaGpoL9A48NEhvH2nkVcNdkSSW3K7M2Egz0MuS448GTYEsb/N+KW4ly+SvAt592
         62wZ8xXErz6S10jvzwLqg3jnYxeLDDJCIQi9eowUAHTXtTt7mxNnbBGExkanWv0GPk94
         E/KQfzrFCg0ocBE/pax7Zv+9gUVULzeU5nLZdswNZK4hTanMaPOSG68jkWIuyuOEVP7Y
         AnQLUmaOcIGm8LBdQhuKEKPyvPnpLo0iCbxhrMemfpP6VwwEdJId4eey/t5CrfyeDEcy
         eZcpSfVvhpMXpKH/w/EFRmrNxE5pjE56y43m+MV+j+1W6nZ4THF6Q1z/3Hi5ZZhLuz/i
         H+gA==
X-Gm-Message-State: APjAAAXhhc4ttRsUw7WynJMmYO2udM9BhViQLMoRSwwq7afhq3fjrHR4
        7Sj6jsNcbM16/2tHD0rcobnrCUpStOgvAE+7juo=
X-Google-Smtp-Source: APXvYqyaUk9/lJvT0nVCL4AvEuY9o+lX5hktcqzxYfNXH5x3PqB1vFxf6j6H6vByhv3gacmnpmAwMGZufgIZ0wiLVdY=
X-Received: by 2002:a17:906:4e88:: with SMTP id v8mr23225174eju.160.1555514723678;
 Wed, 17 Apr 2019 08:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190417150915.37968-1-yuehaibing@huawei.com>
In-Reply-To: <20190417150915.37968-1-yuehaibing@huawei.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 17 Apr 2019 18:25:11 +0300
Message-ID: <CAEnQRZAug2kQoFTN6W47URBKwHcU5Zmmy=04smOtMomuzz6_TA@mail.gmail.com>
Subject: Re: [PATCH -next] ASoC: fsl_micfil: Remove set but not used variable 'osr'
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Cosmin-Gabriel Samoila <gabrielcsmo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

Looks good to me. Just one question for Cosmin:

On Wed, Apr 17, 2019 at 6:10 PM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> sound/soc/fsl/fsl_micfil.c: In function 'get_clk_div':
> sound/soc/fsl/fsl_micfil.c:154:6: warning: variable 'osr' set but not used [-Wunused-but-set-variable]
>
> It is never used since introduction in
> commit 47a70e6fc9a8 ("ASoC: Add MICFIL SoC Digital Audio Interface driver.")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/fsl/fsl_micfil.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> index 40c07e7..f7f2d29 100644
> --- a/sound/soc/fsl/fsl_micfil.c
> +++ b/sound/soc/fsl/fsl_micfil.c
> @@ -151,12 +151,9 @@ static inline int get_clk_div(struct fsl_micfil *micfil,
>  {
>         u32 ctrl2_reg;
>         long mclk_rate;
> -       int osr;
>         int clk_div;
>
>         regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);

I noticed now that we also read ctrl2_reg without using it. Is this as intended?

> -       osr = 16 - ((ctrl2_reg & MICFIL_CTRL2_CICOSR_MASK)
> -                   >> MICFIL_CTRL2_CICOSR_SHIFT);
>
>         mclk_rate = clk_get_rate(micfil->mclk);
>
> --
> 2.7.4
>
>
