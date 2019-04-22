Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82408C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 07:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AED820652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 07:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GjlXi7RR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfDVHjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 03:39:42 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41988 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfDVHjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 03:39:41 -0400
Received: by mail-vs1-f68.google.com with SMTP id f15so5766573vsk.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POlrDuh+Uc0VeEY8jUeOoKYhZtLAgJmnd2OEWu9wIao=;
        b=GjlXi7RR0XHYIzonq5v+6MSQEkDHk43an08aNyvkNFGnX7+efmXe+Bxf5e7GRHZSzp
         GNrbLAtHJaC4EMmGemAA2rUPqCnd1S+KuqZjL47kMXwia32QwU3PNGcyLdRTMUircHlI
         ii6D8kcHxmqP5ynTUQ+KPiC7gm+aVQUQa3JHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POlrDuh+Uc0VeEY8jUeOoKYhZtLAgJmnd2OEWu9wIao=;
        b=kY6Dr6oA1GBojJqOvY9GorEUZK0Vv48+7PRaIr5s7+qsyNh39rO4WnKoICDkfWLA5A
         VzI8AouW779BB+9H+MJKgTRPsjTNsYIurec/LXe1AgLP/6SxBJnqeewPk0/0e0PZ0y10
         XLiSC3/XXe0RGgEAWw5m2CXT/0qvkI+tid4+5GUfbmLg4COu2mApxQPnL8GgC5SV2bcq
         IN9+YiEe7zOa8dtkHc1F1nfKKNR8nT0WO/PIQMKN1Rkuh3JrgDIMYGlilKZEauVCXgJM
         NhK5C9MoR9WN3nhu7FLESXsqUduLZgdOFb7Q33EImqkLoNFH6njt04qug9ZeHji5IaMq
         fLEg==
X-Gm-Message-State: APjAAAWhWwaC+tzGGbzwNZ0s7lrRIHsoq1JHCVxaEYP+e1nHxajaL2kZ
        v19ucX2BQmFqv93wUE7CnLnQ59OpZrJvVsr14PKHuw==
X-Google-Smtp-Source: APXvYqwJI+45d11pTG8+UmYnFOa5RsZeQnBEzs7JBRknSOsQ1NVGMsUFnAJbpdKKMbSiXjGAB4sd2yU2mkzrr7BOMlU=
X-Received: by 2002:a67:ffc4:: with SMTP id w4mr8939270vsq.138.1555918779810;
 Mon, 22 Apr 2019 00:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190422061334.4243-1-akshu.agrawal@amd.com>
In-Reply-To: <20190422061334.4243-1-akshu.agrawal@amd.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Mon, 22 Apr 2019 15:39:13 +0800
Message-ID: <CAFv8NwKZskTeyaUQWevydfxZf0=nf+Z4kBOkYynTfiOMOq-LDA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: DA7219: Fix failure in hw_params by
 not letting set_rate error out
To:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Support Opensource <support.opensource@diasemi.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Adam.Thomson.Opensource@diasemi.com" 
        <Adam.Thomson.Opensource@diasemi.com>, yuhsuan@chromium.org,
        tzungbi@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akshu,


On Mon, Apr 22, 2019 at 2:15 PM Agrawal, Akshu <Akshu.Agrawal@amd.com> wrote:
>
> We need to set minimum bclk 64x of wclk as this is hw constraint in one
> of the component used.
> Since, clk_set_rate and clk is enabled in machine driver the
> clk_set_rate in hw_params of da7219 fails and errors out and when it
> tries to override the value.
>
> In cases like these not only clk_set_rate of da7219 codec should fail
> and not override the value but also should not error out.
>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
>  sound/soc/codecs/da7219.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index 5f5fa3416af3..a041dbf442af 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -1621,13 +1621,7 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
>
>                 if (bclk) {
>                         bclk_rate = frame_size * sr;
> -                       ret = clk_set_rate(bclk, bclk_rate);
> -                       if (ret) {
> -                               dev_err(component->dev,
> -                                       "Failed to set BCLK rate %lu: %d\n",
> -                                       bclk_rate, ret);
> -                               return ret;
> -                       }
> +                       clk_set_rate(bclk, bclk_rate);

I think this might mask the real issue when setting rate fails.
A more fundamental problem might be what are the acceptable ratios
between bclk and wclk.

From existing code of da7219 I see there are only two choices of
frame_size: 32 or 64.

In da7219_hw_params:
...
if (da7219->master && !da7219->tdm_en) {
  if ((word_len * DA7219_DAI_CH_NUM_MAX) <= 32)
     frame_size = 32;
  else
     frame_size = 64;

And in https://lkml.org/lkml/2019/4/17/322
the choice from machine driver is 64 or higher.

In cz_da7219_params:
 ...
 if (bclk < (wclk * 64))
  bclk = wclk * 64;
 return da7219_clk_enable(substream, wclk, bclk);

I don't know what is the best solution to avoid this conflict.
Maybe just set a fixed ratio from device property that can best work
for the combination of codecs on the machine?





>                 } else {
>                         ret = da7219_set_bclks_per_wclk(component, frame_size);
>                         if (ret) {
> --
> 2.17.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
